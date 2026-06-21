module guia4.guicore.treewidget;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.utils.math : clamp;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * TreeItem — 树形节点
 */
class TreeItem
{
    string text;
    TreeItem[] children;
    bool expanded = false;
    int level = 0;  // 缩进级别

    this(string t)
    {
        text = t;
    }

    /// 添加子节点
    TreeItem addChild(string t)
    {
        auto item = new TreeItem(t);
        item.level = level + 1;
        children ~= item;
        return item;
    }

    /// 是否有子节点
    bool hasChildren() const @property { return children.length > 0; }
}

/**
 * TreeWidget — 树形视图
 *
 * 可展开/折叠的树形结构。
 * 支持缩进、展开/折叠点击、选中。
 */
class TreeWidget : Control
{
    private TreeItem _root;
    private TreeItem _selectedItem;
    private int _scrollY = 0;
    private int _itemHeight = 22;
    private uint _fontSize = 14;
    private int _indentWidth = 16;     /// 每级缩进像素
    private int _expandBoxWidth = 16;  /// 展开/折叠符号宽度

    // ── 滚动条相关 ──
    private int _scrollbarWidth = 14;     // 滚动条宽度
    private bool _thumbHovered = false;   // 滑块悬停状态
    private bool _thumbDragging = false;  // 滑块拖拽状态
    private int _dragStartY = 0;          // 拖拽起始Y
    private int _dragStartScrollY = 0;    // 拖拽起始scrollY

    this(Control parent)
    {
        super(parent);
        width = 200;
        height = 200;
        onMouseWheel(&handleWheel);
    }

    /// 根节点
    TreeItem root() @property { return _root; }
    void root(TreeItem r) @property { _root = r; markDirty(); }

    /// 当前选中项
    TreeItem selectedItem() @property { return _selectedItem; }

    /// 滚动位置
    int scrollY() const @property { return _scrollY; }
    void scrollY(int v) @property
    {
        _scrollY = v.clamp(0, maxScroll());
        markDirty();
    }

    private void handleWheel(ref MouseWheelEvent ev)
    {
        int delta = ev.delta;
        _scrollY = (_scrollY + (delta > 0 ? -_itemHeight : _itemHeight)).clamp(0, maxScroll());
        markDirty();
    }

    private int maxScroll() const
    {
        int totalH = countVisibleItems(_root) * _itemHeight;
        return (totalH > height()) ? totalH - height() : 0;
    }

    /// 计算可见项数量
    private int countVisibleItems(const(TreeItem) item) const
    {
        if (item is null)
            return 0;
        int count = 1; // 自身
        if (item.expanded)
        {
            foreach (child; item.children)
                count += countVisibleItems(child);
        }
        return count;
    }

    /// 是否需要滚动条
    private bool needsScrollbar() const
    {
        return countVisibleItems(_root) * _itemHeight > height();
    }

    /// 计算滑块高度
    private int thumbHeight() const
    {
        int totalH = countVisibleItems(_root) * _itemHeight;
        if (totalH <= 0 || !needsScrollbar()) return 0;
        float ratio = cast(float)height() / cast(float)totalH;
        int th = cast(int)(height() * ratio);
        if (th < 10) th = 10;
        return th;
    }

    /// 计算滑块顶部位置
    private int computeThumbTop() const
    {
        int th = thumbHeight();
        int ms = maxScroll();
        if (th <= 0 || ms <= 0) return 0;
        float ratio = cast(float)_scrollY / cast(float)ms;
        int available = height() - th;
        return cast(int)(available * ratio);
    }

    /// 判断x是否在滚动条区域
    private bool isInScrollbar(int lx) const
    {
        return lx >= width() - _scrollbarWidth && lx < width();
    }

    override void fireMouseDown(int mx, int my, int button)
    {
        if (button != 0 || _root is null)
            return;

        // 检查是否点击了滚动条
        if (needsScrollbar() && isInScrollbar(mx))
        {
            int tTop = computeThumbTop();
            int tHeight = thumbHeight();
            if (my >= tTop && my < tTop + tHeight)
            {
                _thumbDragging = true;
                _dragStartY = my;
                _dragStartScrollY = _scrollY;
            }
            else
            {
                // 点击轨道：跳转到对应位置
                int totalH = countVisibleItems(_root) * _itemHeight;
                float ratio = cast(float)my / cast(float)height();
                _scrollY = cast(int)(maxScroll() * ratio);
                _scrollY = (_scrollY > maxScroll()) ? maxScroll() : (_scrollY < 0) ? 0 : _scrollY;
            }
            markDirty();
            return;
        }

        // mx, my 已经是控件本地坐标（由 MainWindow clientToControl 转换）
        int localY = my + _scrollY;
        int clickedIdx = localY / _itemHeight;

        // 找到点击的项
        TreeItem clickedItem = findVisibleItem(_root, clickedIdx);
        if (clickedItem is null)
            return;

        int localX = mx;  // 已经是本地坐标
        int indentX = clickedItem.level * _indentWidth;

        // 判断是否点击了展开/折叠区域
        if (clickedItem.hasChildren() &&
            localX >= indentX && localX < indentX + _expandBoxWidth)
        {
            clickedItem.expanded = !clickedItem.expanded;
            markDirty();
            return;
        }

        // 选中该项
        _selectedItem = clickedItem;
        markDirty();
    }

    override void fireMouseUp(int x, int y, int button)
    {
        if (_thumbDragging)
        {
            _thumbDragging = false;
            _thumbHovered = false;
            markDirty();
        }
        super.fireMouseUp(x, y, button);
    }

    override void fireMouseMove(int mx, int my)
    {
        if (_thumbDragging)
        {
            int deltaY = my - _dragStartY;
            int tHeight = thumbHeight();
            int ms = maxScroll();
            int available = height() - tHeight;
            if (available > 0 && ms > 0)
            {
                float scrollPerPixel = cast(float)ms / cast(float)available;
                _scrollY = cast(int)(_dragStartScrollY + deltaY * scrollPerPixel);
                _scrollY = (_scrollY > maxScroll()) ? maxScroll() : (_scrollY < 0) ? 0 : _scrollY;
            }
            markDirty();
        }
        else if (needsScrollbar() && isInScrollbar(mx))
        {
            int tTop = computeThumbTop();
            int tHeight = thumbHeight();
            bool wasHovered = _thumbHovered;
            _thumbHovered = (my >= tTop && my < tTop + tHeight);
            if (_thumbHovered != wasHovered)
                markDirty();
        }
        else
        {
            if (_thumbHovered)
            {
                _thumbHovered = false;
                markDirty();
            }
        }
    }

    /// 根据可见索引查找项
    private TreeItem findVisibleItem(TreeItem item, ref int targetIdx)
    {
        if (item is null)
            return null;

        if (targetIdx == 0)
            return item;

        targetIdx--;

        if (item.expanded)
        {
            foreach (child; item.children)
            {
                auto found = findVisibleItem(child, targetIdx);
                if (found !is null)
                    return found;
            }
        }
        return null;
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("TreeWidget.renderWithGDI() size=(", width(), ",", height(), ")");

        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 作为基准
        int rx = 0;
        int ry = 0;
        int rw = width();
        int rh = height();

        // ── 白色背景 ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        if (_root is null)
            return;

        // ── 递归渲染树项 ──
        int clipTop = ry;
        int clipBottom = ry + rh;
        int currentY = ry - _scrollY;

        // 设置 GDI 裁剪区域，防止内容越过边框
        int savedDC = SaveDC(hdc);
        RECT clipRect = { cast(LONG)rx, cast(LONG)ry, cast(LONG)(rx + rw), cast(LONG)(ry + rh) };
        IntersectClipRect(hdc, clipRect.left, clipRect.top, clipRect.right, clipRect.bottom);

        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetBkMode(hdc, TRANSPARENT);

        renderTreeItem(hdc, _root, currentY, clipTop, clipBottom);

        FontCache.release(hdc, fontEntry);

        // 恢复裁剪区域
        RestoreDC(hdc, savedDC);

        // ── 滚动条 ──
        if (needsScrollbar())
        {
            drawScrollbar(hdc, rx, ry, rw, rh);
        }

        // ── 边框 ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, rx, ry, rx + rw, ry + rh);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);
    }

    /// 绘制垂直滚动条
    private void drawScrollbar(HDC hdc, int rx, int ry, int rw, int rh)
    {
        int sbLeft = rx + rw - _scrollbarWidth;
        int sbWidth = _scrollbarWidth;
        int sbHeight = rh;

        // 轨道背景
        RECT trackRect = {
            cast(LONG)sbLeft, cast(LONG)ry,
            cast(LONG)(sbLeft + sbWidth), cast(LONG)(ry + sbHeight)
        };
        HBRUSH trackBrush = CreateSolidBrush(cast(COLORREF)0x00F0F0F0);
        FillRect(hdc, &trackRect, trackBrush);
        DeleteObject(cast(HGDIOBJ)trackBrush);

        // 滑块
        int tHeight = thumbHeight();
        int tTop = computeThumbTop();
        if (tHeight > 0 && maxScroll() > 0)
        {
            COLORREF thumbCol = _thumbHovered ? cast(COLORREF)0x00A0A0A0 : cast(COLORREF)0x00C0C0C0;
            HBRUSH thumbBrush = CreateSolidBrush(thumbCol);
            RECT thumbRect = {
                cast(LONG)(sbLeft + 2), cast(LONG)(ry + tTop),
                cast(LONG)(sbLeft + sbWidth - 2), cast(LONG)(ry + tTop + tHeight)
            };
            FillRect(hdc, &thumbRect, thumbBrush);
            DeleteObject(cast(HGDIOBJ)thumbBrush);

            // 滑块边框
            HPEN thumbPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00B0B0B0);
            HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)thumbPen);
            HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
            Rectangle(hdc, thumbRect.left, thumbRect.top, thumbRect.right, thumbRect.bottom);
            SelectObject(hdc, oldPen);
            SelectObject(hdc, oldBrush);
            DeleteObject(cast(HGDIOBJ)thumbPen);
        }
    }

    /// 递归渲染树项
    private void renderTreeItem(HDC hdc, TreeItem item, ref int currentY,
                                int clipTop, int clipBottom)
    {
        if (item is null)
            return;

        // 如果 currentY 超出底部，跳过
        if (currentY > clipBottom)
            return;

        int rx = 0;
        int itemY = currentY;

        // 只渲染可见范围内的项
        if (itemY + _itemHeight > clipTop && itemY < clipBottom)
        {
            int indentX = rx + item.level * _indentWidth;

            // 选中项高亮
            if (item is _selectedItem)
            {
                RECT selRect = {
                    cast(LONG)rx, cast(LONG)itemY,
                    cast(LONG)(rx + width()), cast(LONG)(itemY + _itemHeight)
                };
                HBRUSH selBrush = CreateSolidBrush(cast(COLORREF)0x00CCCCFF);
                FillRect(hdc, &selRect, selBrush);
                DeleteObject(cast(HGDIOBJ)selBrush);
            }

            // 展开/折叠符号
            if (item.hasChildren())
            {
                wstring symbol = item.expanded ? "−"w : "+"w;
                SetTextColor(hdc, cast(COLORREF)0x00666666);
                TextOutW(hdc, indentX, itemY + (_itemHeight - cast(int)_fontSize) / 2,
                         cast(const(PWSTR))symbol.ptr, cast(int)symbol.length);
            }
            else
            {
                // 叶子符号
                wstring leaf = "·"w;
                SetTextColor(hdc, cast(COLORREF)0x00999999);
                TextOutW(hdc, indentX, itemY + (_itemHeight - cast(int)_fontSize) / 2,
                         cast(const(PWSTR))leaf.ptr, cast(int)leaf.length);
            }

            // 文字
            int textX = indentX + _expandBoxWidth;
            SetTextColor(hdc, cast(COLORREF)0x00333333);
            wstring textW = toUTF16(item.text);
            TextOutW(hdc, textX, itemY + (_itemHeight - cast(int)_fontSize) / 2,
                     cast(const(PWSTR))textW.ptr, cast(int)textW.length);
        }

        currentY += _itemHeight;

        // 如果展开，递归渲染子项
        if (item.expanded)
        {
            foreach (child; item.children)
            {
                renderTreeItem(hdc, child, currentY, clipTop, clipBottom);
                if (currentY > clipBottom)
                    return;
            }
        }
    }

    override void render() {}
}
