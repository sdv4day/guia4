module guia4.guicore.scrollcontainer;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.scrollbar;
import guia4.guicore.theme;
import guia4.utils.logger;
import guia4.utils.math : clamp;
import guia4.platform_win32.win32defs;
import std.utf;
import std.algorithm;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * ScrollableContainer — a control that clips and scrolls its children
 * using GDI viewport offset, with vertical and horizontal scrollbars.
 *
 * Rendering approach:
 *   1. SaveDC to preserve original clip region + viewport origin
 *   2. IntersectClipRect to clip drawing to this container's bounds
 *   3. OffsetViewportOrgEx to shift children by (-_scrollX, -_scrollY)
 *   4. Render each visible child via renderWithGDI
 *   5. RestoreDC to undo clip and offset
 *   6. Draw the scrollbars on top (unclipped)
 *
 * Mouse wheel scrolls content. Scrollbar thumb supports click-and-drag.
 * Hover effect on thumb is tracked.
 *
 * Children are positioned as usual (absolute coords = container.x + rel.x).
 * The viewport offset shifts everything so child at (cx+5, cy+5)
 * appears at (cx+5 - _scrollX, cy+5 - _scrollY) on screen.
 */
class ScrollableContainer : Control
{
    private int _scrollX = 0;
    private int _scrollY = 0;
    private int _contentWidth = 0;   // total virtual width of content
    private int _contentHeight = 0;   // total virtual height of content
    private int _scrollbarWidth = 14; // width of the vertical scrollbar
    private int _scrollbarHeight = 14; // height of the horizontal scrollbar

    // ── 内部 ScrollBar 实例（非子控件，避免被布局和滚动影响）──
    private ScrollBar _vScrollBar;
    private ScrollBar _hScrollBar;

    // ── Layer buffer state ──
    private bool _layerBufferInitialized = false;

    this(Control parent)
    {
        super(parent);
        rendersChildren(true);  // ScrollableContainer自己渲染children
        dock(DockStyle.Fill);   // 默认填充父容器剩余空间

        // 创建内部滚动条（null parent = 不加入控件树）
        _vScrollBar = new ScrollBar(null, ScrollBarOrientation.Vertical);
        _vScrollBar.width = _scrollbarWidth;
        
        _hScrollBar = new ScrollBar(null, ScrollBarOrientation.Horizontal);
        _hScrollBar.height = _scrollbarHeight;
        
        // 设置鼠标滚轮事件处理器
        onMouseWheel((ref MouseWheelEvent ev) {
            // 垂直滚轮：向下滚动（delta < 0）增加 scrollY，向上滚动（delta > 0）减少 scrollY
            if (ev.delta != 0)
            {
                int newScrollY = _scrollY - ev.delta;
                scrollY(newScrollY);
            }
            
            // 横向滚轮：向右滚动（hDelta < 0）增加 scrollX，向左滚动（hDelta > 0）减少 scrollX
            if (ev.hDelta != 0)
            {
                int newScrollX = _scrollX - ev.hDelta;
                scrollX(newScrollX);
            }
        });
    }

    /**
     * 析构函数 — 仅标记资源为已销毁
     * 
     * 注意：不在析构函数中调用 GDI API（如 DeleteDC, DeleteObject），
     * 因为 GC 可能在 D 运行时的模块析构阶段析构对象，此时调用
     * GDI API 可能导致访问冲突。
     * 
     * 正确的做法是在控件被移除时显式调用 destroyLayerBuffer() 方法。
     */
    ~this()
    {
        // 仅标记资源为已销毁，不调用 GDI API
        // 实际的 GDI 资源清理应该在 destroyLayerBuffer() 中完成
    }

    // ── Properties ────────────────────────────────────────────────

    int scrollX() const @property { return _scrollX; }
    void scrollX(int v) @property
    {
        _scrollX = v.clamp(0, maxScrollX());
        markDirty(DirtyBits.Visual);
    }

    int scrollY() const @property { return _scrollY; }
    void scrollY(int v) @property
    {
        _scrollY = v.clamp(0, maxScrollY());
        markDirty(DirtyBits.Visual);
    }

    /// override Control.scrollOffsetX
    override int scrollOffsetX() const @property { return _scrollX; }
    
    /// override Control.scrollOffsetY
    override int scrollOffsetY() const @property { return _scrollY; }

    int contentWidth() const @property { return _contentWidth; }
    void contentWidth(int v) @property
    {
        _contentWidth = v;
        updateScrollbars();
        markDirty(DirtyBits.Visual);
    }

    int contentHeight() const @property { return _contentHeight; }
    void contentHeight(int v) @property
    {
        _contentHeight = v;
        updateScrollbars();
        markDirty(DirtyBits.Visual);
    }

    int scrollbarWidth() const @property { return _scrollbarWidth; }
    void scrollbarWidth(int v) @property
    {
        _scrollbarWidth = v;
        _vScrollBar.width = v;
        markDirty(DirtyBits.Visual);
    }

    int scrollbarHeight() const @property { return _scrollbarHeight; }
    void scrollbarHeight(int v) @property
    {
        _scrollbarHeight = v;
        _hScrollBar.height = v;
        markDirty(DirtyBits.Visual);
    }
    
    /// 重写 height() getter 方法
    override int height() const nothrow @nogc @property { return super.height(); }
    
    /// 重写 height() setter 方法，在大小改变时重新计算内容高度
    override void height(int v) nothrow @nogc @property
    {
        int oldHeight = super.height();
        super.height(v);
        if (oldHeight != v)
        {
            // 标记需要重新计算内容高度（在下次渲染时执行）
            markDirty(DirtyBits.Layout);
        }
    }
    
    /// 重写 width() getter 方法
    override int width() const nothrow @nogc @property { return super.width(); }
    
    /// 重写 width() setter 方法，在大小改变时重新计算内容高度
    override void width(int v) nothrow @nogc @property
    {
        int oldWidth = super.width();
        super.width(v);
        if (oldWidth != v)
        {
            // 标记需要重新计算内容高度（在下次渲染时执行）
            markDirty(DirtyBits.Layout);
        }
    }

    /// Maximum scroll value (can't scroll past the bottom)
    private int maxScrollY() const nothrow @nogc
    {
        return std.algorithm.max(0, _contentHeight - height());
    }
    
    /// Maximum horizontal scroll value
    private int maxScrollX() const nothrow @nogc
    {
        return std.algorithm.max(0, _contentWidth - width());
    }

    /// Whether the content exceeds the container height
    private bool needsVerticalScrollbar() const nothrow @nogc
    {
        return _contentHeight > height();
    }
    
    /// Whether the content exceeds the container width
    private bool needsHorizontalScrollbar() const nothrow @nogc
    {
        return _contentWidth > width();
    }
    
    /// 兼容旧方法名
    private bool needsScrollbar() const nothrow @nogc
    {
        return needsVerticalScrollbar();
    }
    
    /// 兼容旧方法名
    private int maxScroll() const nothrow @nogc
    {
        return maxScrollY();
    }

    /// 同步内部 ScrollBar 状态（渲染和事件转发前调用）
    private void syncScrollbars()
    {
        // 同步垂直滚动条
        _vScrollBar.width = _scrollbarWidth;
        _vScrollBar.height = height();
        _vScrollBar.min(0);
        _vScrollBar.max(_contentHeight);
        _vScrollBar.pageSize(height());
        _vScrollBar.value(_scrollY);
        
        // 同步水平滚动条
        _hScrollBar.height = _scrollbarHeight;
        _hScrollBar.width = width();
        _hScrollBar.min(0);
        _hScrollBar.max(_contentWidth);
        _hScrollBar.pageSize(width());
        _hScrollBar.value(_scrollX);
    }
    
    /// 兼容旧方法名
    private void syncScrollBar()
    {
        syncScrollbars();
    }

    /// 从内部 ScrollBar 同步滚动值回 _scrollY
    private void syncScrollFromBar()
    {
        int newVal = _vScrollBar.value();
        if (newVal != _scrollY)
        {
            _scrollY = newVal;
            markDirty(DirtyBits.Visual);
        }
    }

    /// Update scrollbar state and clamp scroll position
    private void updateScrollbars() nothrow @nogc
    {
        if (!needsVerticalScrollbar())
        {
            _scrollY = 0;
        }
        else
        {
            _scrollY = _scrollY.clamp(0, maxScrollY());
        }
        
        if (!needsHorizontalScrollbar())
        {
            _scrollX = 0;
        }
        else
        {
            _scrollX = _scrollX.clamp(0, maxScrollX());
        }
    }
    
    /// 兼容旧方法名
    private void updateScrollbar() nothrow @nogc
    {
        updateScrollbars();
    }

    /// How many pixels of scroll per mouse wheel notch
    private int scrollStep() const
    {
        return 20;
    }

    // ── Wheel handler ────────────────────────────────────────────

    /// Called when ScrollableContainer receives a mouse wheel event
    private void handleMouseWheel(ref MouseWheelEvent ev)
    {
        int delta = ev.delta;
        logTrace("ScrollableContainer.handleMouseWheel(delta=", delta, ")");

        if (maxScroll() <= 0)
            return; // no scrolling needed

        if (delta > 0)
        {
            // Scroll up (negative delta moves content down to reveal more above)
            _scrollY = (_scrollY - scrollStep()).clamp(0, maxScroll());
        }
        else
        {
            // Scroll down
            _scrollY = (_scrollY + scrollStep()).clamp(0, maxScroll());
        }

        markDirty(DirtyBits.Visual);
        logTrace("ScrollableContainer: scrollY now ", _scrollY);
    }

    // ── Scrollbar area detection ─────────────────────────────────

    /// Returns true if container-local x is inside the scrollbar track.
    private bool isInScrollbar(int lx) const
    {
        return needsScrollbar() && lx >= width() - _scrollbarWidth && lx < width();
    }

    // ── Child management ─────────────────────────────────────────

    /// Compute content height from children (auto-calculated).
    /// Each child's bottom edge = child.y + child.height - this.y (relative to container).
    private int computeContentHeight()
    {
        int maxBottom = 0;
        foreach (child; children())
        {
            // child.position().y() 已相对于本容器，无需再减去 position().y()
            int childBottom = child.position().y() + child.height();
            if (childBottom > maxBottom)
                maxBottom = childBottom;
        }
        return maxBottom;
    }
    
    private int computeContentWidth()
    {
        int maxRight = 0;
        foreach (child; children())
        {
            // child.position().x() 已相对于本容器，无需再减去 position().x()
            int childRight = child.position().x() + child.width();
            if (childRight > maxRight)
                maxRight = childRight;
        }
        return maxRight;
    }

    /// Recalculate content height and width from current children and update scrollbars.
    /// Call this after repositioning children, adding/removing via raw _children, or
    /// after container resize. The `addChild` override calls this automatically.
    void recalcContent()
    {
        // 确保布局已执行，这样才能正确计算内容高度和宽度
        ensureLayout();
        
        _contentHeight = computeContentHeight();
        _contentWidth = computeContentWidth();
        updateScrollbars();
        markDirty(DirtyBits.Visual);
    }

    override void addChild(Control child)
    {
        super.addChild(child);
        recalcContent();
    }

    /// Auto-adaptive content: recalc content height on every render pass so
    /// any child repositioning (via applyLayout, manual y() set, etc.) is
    /// automatically reflected in the scrollbar.
    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        
        // 确保布局已执行
        ensureLayout();
        
        // Recompute content height before drawing — this makes the scrollbar
        // self-adapt to any out-of-band child repositioning.
        int prevContentH = _contentHeight;
        _contentHeight = computeContentHeight();
        updateScrollbar();
        if (_contentHeight != prevContentH)
            logTrace("ScrollableContainer.renderWithGDI: contentH ", prevContentH, " → ", _contentHeight);

        // ── 确保layer buffer已初始化 ──
        logTrace("ScrollableContainer.renderWithGDI: checking buffer, _layerBufferInitialized=", _layerBufferInitialized, " _layerBufferValid=", _layerBufferValid);
        if (!_layerBufferInitialized || !_layerBufferValid)
        {
            logTrace("  initializing layer buffer...");
            initLayerBuffer(hdc);
            _layerBufferInitialized = true;
            logTrace("  after initLayerBuffer: _layerBufferValid=", _layerBufferValid);
            
            // 初始化后立即渲染一次内容
            if (_layerBufferValid)
            {
                logTrace("  calling renderContentToBuffer...");
                renderContentToBuffer(_layerDC);
            }
            else
            {
                logTrace("  ERROR: initLayerBuffer failed, _layerBufferValid is still false!");
            }
        }
        
        // ── 检查是否需要重建buffer（尺寸变化）──
        if (_layerBufferValid)
        {
            // 获取当前buffer尺寸
            BITMAP bm;
            GetObjectW(cast(HGDIOBJ)_layerBmp, bm.sizeof, &bm);
            if (bm.bmWidth != width() || bm.bmHeight != height())
            {
                // 尺寸变化，重建buffer
                initLayerBuffer(hdc);
                
                // 重建后立即渲染一次内容
                if (_layerBufferValid)
                {
                    renderContentToBuffer(_layerDC);
                }
            }
        }
        
        // ── 将layer buffer合成到父DC ──
        // 注意：不在这里调用updateLayerBuffer()
        // LayerCompositor会根据脏标记调用updateLayerBuffer()
        logTrace("ScrollableContainer.renderWithGDI: _layerBufferValid=", _layerBufferValid, " position=(", position().x(), ",", position().y(), ") size=", width(), "x", height());
        if (_layerBufferValid)
        {
            BitBlt(hdc, position().x(), position().y(), width(), height(), _layerDC, 0, 0, SRCCOPY);
            logTrace("  BitBlt executed: dst=(", position().x(), ",", position().y(), ") size=", width(), "x", height());
        }
        else
        {
            logTrace("  ERROR: _layerBufferValid is false, BitBlt skipped!");
        }
    }
    
    /// 重写updateLayerBuffer：将内容渲染到layer buffer
    override void updateLayerBuffer()
    {
        // ── 确保layer buffer已初始化 ──
        // 注意：这里需要refDC，但我们无法直接获取，使用_layerDC作为参考
        // 如果buffer未初始化，先创建一个临时的兼容DC
        if (!_layerBufferInitialized || !_layerBufferValid)
        {
            // 无法在这里初始化，因为没有refDC
            // 这种情况下应该由renderWithGDI来初始化
            return;
        }
        
        // ── 检查是否需要重建buffer（尺寸变化）──
        if (_layerBufferValid)
        {
            // 获取当前buffer尺寸
            BITMAP bm;
            GetObjectW(cast(HGDIOBJ)_layerBmp, bm.sizeof, &bm);
            if (bm.bmWidth != width() || bm.bmHeight != height())
            {
                // 尺寸变化，但无法重建（没有refDC）
                // 标记为无效，等待renderWithGDI重建
                _layerBufferValid = false;
                return;
            }
        }
        
        // 渲染内容到layer buffer（坐标原点为(0,0)）
        renderContentToBuffer(_layerDC);
    }
    
    /// 渲染内容到layer buffer（坐标原点为(0,0)）
    private void renderContentToBuffer(HDC hdc)
    {
        logTrace("ScrollableContainer.renderContentToBuffer() size=", width(), "x", height(), " scrollX=", _scrollX, " scrollY=", _scrollY, " position=(", position().x(), ",", position().y(), ")");

        int rw = width();
        int rh = height();

        // ── Draw container background ──
        RECT bgRect = {0, 0, rw, rh};
        HBRUSH bgBrush = CreateSolidBrush(Theme.crContainerBg());
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── Save DC state before clipping/scrolling children ──
        int savedDC = SaveDC(hdc);

        // ── Clip to container bounds ──
        IntersectClipRect(hdc, 0, 0, rw, rh);

        // ── Apply scroll offset for children ──
        POINT oldOrigin;
        // 偏移原点：减去滚动偏移（相对于buffer的(0,0)）
        OffsetViewportOrgEx(hdc, -_scrollX, -_scrollY, &oldOrigin);

        // ── Render each visible child (递归渲染) ──
        // 传递 ScrollableContainer 的绝对位置作为初始偏移
        int containerAbsX = position().x();
        int containerAbsY = position().y();
        foreach (child; children())
        {
            if (child.visible())
            {
                renderChildRecursive(child, hdc, containerAbsX, containerAbsY);
            }
        }


        // ── Restore DC (removes clip rect and viewport offset) ──
        RestoreDC(hdc, savedDC);

        // ── Draw border ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, Theme.crBorder());
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));

        Rectangle(hdc, 0, 0, rw, rh);

        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── Draw scrollbars via internal ScrollBar ──
        // 注意：滚动条渲染在容器右侧和底部，不受裁剪影响
        
        // 渲染垂直滚动条
        if (needsVerticalScrollbar())
        {
            syncScrollbars();
            POINT sbOrigin;
            // 如果同时有水平滚动条，垂直滚动条的高度要减去水平滚动条的高度
            int vScrollbarHeight = needsHorizontalScrollbar() ? rh - _scrollbarHeight : rh;
            _vScrollBar.height = vScrollbarHeight;
            OffsetViewportOrgEx(hdc, rw - _scrollbarWidth, 0, &sbOrigin);
            _vScrollBar.renderWithGDI(hdc.Value);
            SetViewportOrgEx(hdc, sbOrigin.x, sbOrigin.y, null);
        }
        
        // 渲染水平滚动条
        if (needsHorizontalScrollbar())
        {
            syncScrollbars();
            POINT sbOrigin;
            // 如果同时有垂直滚动条，水平滚动条的宽度要减去垂直滚动条的宽度
            int hScrollbarWidth = needsVerticalScrollbar() ? rw - _scrollbarWidth : rw;
            _hScrollBar.width = hScrollbarWidth;
            OffsetViewportOrgEx(hdc, 0, rh - _scrollbarHeight, &sbOrigin);
            _hScrollBar.renderWithGDI(hdc.Value);
            SetViewportOrgEx(hdc, sbOrigin.x, sbOrigin.y, null);
        }
    }
    
    /// 递归渲染子控件（处理容器控件的子控件）
    /// 关键修复：在渲染控件之前先偏移视口到控件位置
    /// 这样控件使用 position() 渲染时，实际设备坐标是正确的
    /// absX, absY: 父控件的绝对位置
    private void renderChildRecursive(Control ctrl, HDC hdc, int absX = 0, int absY = 0)
    {
        // 确保控件布局已执行
        ctrl.ensureLayout();
        
        // 计算控件的绝对位置
        int ctrlAbsX = absX + ctrl.position().x();
        int ctrlAbsY = absY + ctrl.position().y();
        
        // 保存DC状态（包括裁剪区域）
        int savedDC = SaveDC(hdc);
        
        // 设置裁剪区域为控件边界，防止内容绘制到控件外部
        IntersectClipRect(hdc, ctrl.position().x(), ctrl.position().y(),
                          ctrl.position().x() + ctrl.width(), ctrl.position().y() + ctrl.height());
        
        // 关键修复：在渲染控件之前，先偏移视口到控件位置
        POINT oldOrigin;
        OffsetViewportOrgEx(hdc, ctrl.position().x(), ctrl.position().y(), &oldOrigin);
        
        // 渲染控件本身
        ctrl.renderWithGDI(hdc.Value);
        
        // 如果控件不自己渲染子控件，递归渲染其子控件
        // 注意：视口已经偏移，子控件的渲染会在此基础上继续偏移
        if (!ctrl.rendersChildren())
        {
            foreach (child; ctrl.children())
            {
                if (child.visible())
                {
                    renderChildRecursive(child, hdc, ctrlAbsX, ctrlAbsY);
                }
            }
        }
        
        // 恢复GDI视口
        SetViewportOrgEx(hdc, oldOrigin.x, oldOrigin.y, null);
        
        // 恢复DC状态（包括裁剪区域）
        RestoreDC(hdc, savedDC);
    }


    // ── Event overrides — 委托滚动条交互给内部 ScrollBar ──

    override void fireMouseDown(int x, int y, int button)
    {
        if (isInScrollbar(x))
        {
            syncScrollBar();
            int sbLocalX = x - (width() - _scrollbarWidth);
            _vScrollBar.fireMouseDown(sbLocalX, y, button);
            syncScrollFromBar();
            return;
        }
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        // 拖拽中时始终转发 mouseUp 给 ScrollBar
        if (_vScrollBar.isDragging)
        {
            syncScrollBar();
            int sbLocalX = x - (width() - _scrollbarWidth);
            _vScrollBar.fireMouseUp(sbLocalX, y, button);
            syncScrollFromBar();
            return;
        }
        super.fireMouseUp(x, y, button);
    }

    override void fireMouseMove(int x, int y)
    {
        // 拖拽中或在滚动条区域内时转发给 ScrollBar
        if (_vScrollBar.isDragging || isInScrollbar(x))
        {
            syncScrollBar();
            int sbLocalX = x - (width() - _scrollbarWidth);
            _vScrollBar.fireMouseMove(sbLocalX, y);
            syncScrollFromBar();
            return;
        }
        super.fireMouseMove(x, y);
    }

    override void fireMouseWheel(int delta, int hDelta = 0, int x = 0, int y = 0)
    {
        MouseWheelEvent event;
        event.id = EventId.MouseWheel;
        event.target = this;
        event.delta = delta;
        event.hDelta = hDelta;
        event.x = x;
        event.y = y;
        handleMouseWheel(event);
        // Continue bubbling so nested containers / parents can scroll too
        super.fireMouseWheel(delta, hDelta, x, y);
    }

    override void render()
    {
    }
}

