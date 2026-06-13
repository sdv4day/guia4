module guia4.guicore.scrollcontainer;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
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
 * using GDI viewport offset, with a vertical scrollbar.
 *
 * Rendering approach:
 *   1. SaveDC to preserve original clip region + viewport origin
 *   2. IntersectClipRect to clip drawing to this container's bounds
 *   3. OffsetViewportOrgEx to shift children upward by _scrollY
 *   4. Render each visible child via renderWithGDI
 *   5. RestoreDC to undo clip and offset
 *   6. Draw the scrollbar on top (unclipped)
 *
 * Mouse wheel scrolls content. Scrollbar thumb supports click-and-drag.
 * Hover effect on thumb is tracked.
 *
 * Children are positioned as usual (absolute coords = container.x + rel.x).
 * The viewport offset shifts everything so child at (cx+5, cy+5)
 * appears at (cx+5, cy+5 - _scrollY) on screen.
 */
class ScrollableContainer : Control
{
    private int _scrollY = 0;
    private int _contentHeight = 0;   // total virtual height of content
    private int _thumbHeight = 0;     // height of the scrollbar thumb in pixels
    private int _scrollbarWidth = 14; // width of the vertical scrollbar

    // Scrollbar colors
    private COLORREF _trackColor   = cast(COLORREF)0x00F0F0F0; // light grey
    private COLORREF _thumbColor   = cast(COLORREF)0x00C0C0C0; // grey
    private COLORREF _thumbHover   = cast(COLORREF)0x00A0A0A0; // darker grey
    private bool _thumbHovered = false;

    // ── Thumb drag state ──
    private bool _isDragging = false;
    private int _dragStartY = 0;       // mouse Y at drag start (container-local)
    private int _dragStartScrollY = 0; // scrollY at drag start
    
    // ── Layer buffer state ──
    private bool _layerBufferInitialized = false;

    this(Control parent)
    {
        super(parent);
        rendersChildren(true);  // ScrollableContainer自己渲染children
        dock(DockStyle.Fill);   // 默认填充父容器剩余空间
    }
    
    ~this()
    {
        // 释放layer buffer资源
        destroyLayerBuffer();
    }

    // ── Properties ────────────────────────────────────────────────

    int scrollY() const @property { return _scrollY; }
    void scrollY(int v) @property
    {
        _scrollY = v.clamp(0, maxScroll());
        markDirty(DirtyBits.Visual);
    }

    int contentHeight() const @property { return _contentHeight; }
    void contentHeight(int v) @property
    {
        _contentHeight = v;
        updateScrollbar();
        markDirty(DirtyBits.Visual);
    }

    int scrollbarWidth() const @property { return _scrollbarWidth; }
    void scrollbarWidth(int v) @property { _scrollbarWidth = v; markDirty(DirtyBits.Visual); }

    /// Maximum scroll value (can't scroll past the bottom)
    private int maxScroll() const
    {
        return std.algorithm.max(0, _contentHeight - height());
    }

    /// Whether the content exceeds the container height
    private bool needsScrollbar() const
    {
        return _contentHeight > height();
    }

    /// Update scrollbar thumb size and clamp scroll position
    private void updateScrollbar()
    {
        if (!needsScrollbar())
        {
            _thumbHeight = 0;
            _scrollY = 0;
            return;
        }

        // Thumb height proportional to visible area vs content area
        float visibleRatio = cast(float)height() / _contentHeight;
        _thumbHeight = cast(int)(height() * visibleRatio);
        _thumbHeight = std.algorithm.max(_thumbHeight, 10); // minimum 10px thumb

        // Clamp scroll position
        _scrollY = _scrollY.clamp(0, maxScroll());
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

    // ── Thumb drag handlers ──────────────────────────────────────

    /// Returns true if container-local x is inside the scrollbar track.
    private bool isInScrollbar(int lx) const
    {
        return lx >= width() - _scrollbarWidth && lx < width();
    }

    /// Returns the thumb top edge in container-local coordinates.
    private int computeThumbTop() const
    {
        if (_thumbHeight <= 0 || maxScroll() <= 0)
            return 0;
        float ratio = cast(float)_scrollY / maxScroll();
        int available = height() - _thumbHeight;
        return cast(int)(available * ratio);
    }

    /// Handle mouse-down: start drag if on the scrollbar thumb.
    private void handleMouseDown(ref MouseEvent event)
    {
        if (!needsScrollbar() || _thumbHeight <= 0)
            return;

        if (!isInScrollbar(event.x))
            return;

        int tTop = computeThumbTop();
        if (event.y >= tTop && event.y < tTop + _thumbHeight)
        {
            _isDragging = true;
            _dragStartY = event.y;
            _dragStartScrollY = _scrollY;
            logTrace("ScrollableContainer: thumb drag started at y=", event.y);
        }
    }

    /// Handle mouse-up: stop drag.
    private void handleMouseUp(ref MouseEvent event)
    {
        if (_isDragging)
        {
            _isDragging = false;
            _thumbHovered = false;
            logTrace("ScrollableContainer: thumb drag ended");
        }
    }

    /// Handle mouse-move: during drag → update scroll; otherwise → hover tracking.
    private void handleMouseMove(ref MouseEvent event)
    {
        if (_isDragging)
        {
            int deltaY = event.y - _dragStartY;
            float scrollPerPixel = cast(float)maxScroll() / (height() - _thumbHeight);
            _scrollY = cast(int)(_dragStartScrollY + deltaY * scrollPerPixel);
            _scrollY = _scrollY.clamp(0, maxScroll());
            markDirty(DirtyBits.Visual);
            logTrace("ScrollableContainer: drag scrollY=", _scrollY);
        }
        else
        {
            // Hover tracking for thumb color
            if (isInScrollbar(event.x))
            {
                int tTop = computeThumbTop();
                _thumbHovered = (event.y >= tTop && event.y < tTop + _thumbHeight);
            }
            else
            {
                _thumbHovered = false;
            }
        }
    }

    // ── Child management ─────────────────────────────────────────

    /// Compute content height from children (auto-calculated).
    /// Each child's bottom edge = child.y + child.height - this.y (relative to container).
    private int computeContentHeight()
    {
        int maxBottom = 0;
        foreach (child; children())
        {
            int childBottom = child.position().y() + child.height() - position().y();
            if (childBottom > maxBottom)
                maxBottom = childBottom;
        }
        return std.algorithm.max(maxBottom, height());
    }

    /// Recalculate content height from current children and update scrollbar.
    /// Call this after repositioning children, adding/removing via raw _children, or
    /// after container resize. The `addChild` override calls this automatically.
    void recalcContent()
    {
        _contentHeight = computeContentHeight();
        updateScrollbar();
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
        logTrace("ScrollableContainer.renderContentToBuffer() size=", width(), "x", height(), " scrollY=", _scrollY, " position=(", position().x(), ",", position().y(), ")");

        int rw = width();
        int rh = height();

        // ── Draw container background ──
        RECT bgRect = {0, 0, rw, rh};
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00F8F8F8);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── Save DC state before clipping/scrolling children ──
        int savedDC = SaveDC(hdc);

        // ── Clip to container bounds ──
        IntersectClipRect(hdc, 0, 0, rw, rh);

        // ── Apply scroll offset for children ──
        POINT oldOrigin;
        // 偏移原点：减去滚动偏移（相对于buffer的(0,0)）
        OffsetViewportOrgEx(hdc, 0, -_scrollY, &oldOrigin);

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
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));

        Rectangle(hdc, 0, 0, rw, rh);

        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── Draw scrollbar (on top, unclipped) ──
        if (needsScrollbar())
        {
            drawScrollbarOnBuffer(hdc, rw, rh);
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
        
        logTrace("  renderChildRecursive: ", typeid(ctrl).name, " absPos=(", ctrlAbsX, ",", ctrlAbsY, ") relPos=(", ctrl.position().x(), ",", ctrl.position().y(), ")");
        
        // 关键修复：在渲染控件之前，先偏移视口到控件位置
        POINT oldOrigin;
        OffsetViewportOrgEx(hdc, ctrl.position().x(), ctrl.position().y(), &oldOrigin);
        
        // 渲染控件本身
        // 由于视口已经偏移，控件应该使用 (0, 0) 而不是 position() 来渲染
        // 但为了兼容现有代码，我们让控件继续使用 position() 渲染
        // 这需要在控件的 renderWithGDI 中调整
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
    }

    
    /// 在buffer上绘制滚动条（坐标原点为(0,0)）
    private void drawScrollbarOnBuffer(HDC hdc, int rw, int rh)
    {

        int sbLeft = rw - _scrollbarWidth;
        int sbTop = 0;
        int sbWidth = _scrollbarWidth;
        int sbHeight = rh;

        // ── Track background ──
        RECT trackRect = {
            cast(LONG)sbLeft, cast(LONG)sbTop,
            cast(LONG)(sbLeft + sbWidth), cast(LONG)(sbTop + sbHeight)
        };
        HBRUSH trackBrush = CreateSolidBrush(_trackColor);
        FillRect(hdc, &trackRect, trackBrush);
        DeleteObject(cast(HGDIOBJ)trackBrush);

        // ── Thumb ──
        if (_thumbHeight > 0 && maxScroll() > 0)
        {
            // Thumb position proportional to scroll progress
            float scrollRatio = cast(float)_scrollY / maxScroll();
            int availableTrack = sbHeight - _thumbHeight;
            int thumbTop = sbTop + cast(int)(availableTrack * scrollRatio);

            COLORREF thumb = _thumbHovered ? _thumbHover : _thumbColor;
            HBRUSH thumbBrush = CreateSolidBrush(thumb);
            RECT thumbRect = {
                cast(LONG)(sbLeft + 2), cast(LONG)thumbTop,
                cast(LONG)(sbLeft + sbWidth - 2), cast(LONG)(thumbTop + _thumbHeight)
            };
            FillRect(hdc, &thumbRect, thumbBrush);
            DeleteObject(cast(HGDIOBJ)thumbBrush);

            // ── Thumb border ──
            HPEN thumbPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00B0B0B0);
            HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)thumbPen);
            HGDIOBJ oldBrush2 = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));

            Rectangle(hdc, thumbRect.left, thumbRect.top, thumbRect.right, thumbRect.bottom);

            SelectObject(hdc, oldPen);
            SelectObject(hdc, oldBrush2);
            DeleteObject(cast(HGDIOBJ)thumbPen);
        }
    }


    override void render()
    {
    }
}

