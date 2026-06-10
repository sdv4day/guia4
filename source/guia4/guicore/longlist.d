module guia4.guicore.longlist;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import std.algorithm;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/// 列表选择模式
enum ListSelectionMode
{
    None,       /// 不可选择
    Single,     /// 单选
    Multi,      /// 多选（Ctrl+点击追加选择）
    Extended,   /// 扩展多选（Shift+点击范围选择）
}

/// Follow 模式 — 自动跟随最新记录
enum FollowMode
{
    None,       /// 不跟随，用户自由滚动
    Follow,     /// 跟随最新：滚动条在底部时自动跟随，用户上滚暂停，滚回底部恢复
    Always,     /// 始终跟随：无论用户操作都强制滚到底部（如日志终端）
}

/**
 * LongList — 虚拟滚动长列表
 *
 * 高效展示大量数据的列表控件。只渲染可见区域的项，
 * 性能不受总数据量影响（百万级数据也流畅）。
 *
 * 设计要点：
 *   - 数据与渲染分离：通过 itemCount 回调获取总数，通过 itemText/itemData 回调获取项数据
 *   - 虚拟滚动：只渲染视口内的项，滚动时动态计算可见范围
 *   - 可变行高：通过 itemHeight 回调获取每项高度（默认固定行高）
 *   - 自定义渲染：通过 onRenderItem 回调自定义项渲染
 *   - 选中管理：支持单选/多选/扩展多选
 */
class LongList : Control
{
    // ── 数据源回调 ──────────────────────────────────────────────

    private int delegate() _itemCountFunc;              /// 项总数回调
    private string delegate(int index) _itemTextFunc;   /// 项文本回调
    private int delegate(int index) _itemHeightFunc;    /// 项高度回调（可变行高）

    // ── 状态 ────────────────────────────────────────────────────

    private int _scrollY = 0;               /// 垂直滚动偏移（像素）
    private int _defaultItemHeight = 24;    /// 默认项高度
    private int _totalHeight = 0;           /// 所有项的总高度（像素）
    private int _hoveredIndex = -1;         /// 鼠标悬停项索引
    private int[] _selectedIndices;         /// 选中项索引列表
    private int _anchorIndex = -1;          /// 多选锚点（Shift起点）
    private ListSelectionMode _selectionMode = ListSelectionMode.Single;
    private uint _fontSize = 14;

    // ── Follow 模式 ──────────────────────────────────────────────

    private FollowMode _followMode = FollowMode.None;  /// 跟随模式
    private bool _isAtBottom = true;                    /// 当前是否在底部（用于 Follow 模式判断）
    private int _followThreshold = 30;                  /// 距底部多少像素内视为"在底部"

    // ── 滚动条 ──────────────────────────────────────────────────

    private int _scrollbarWidth = 14;       /// 滚动条宽度
    private bool _scrollbarThumbDragging = false;
    private int _scrollbarDragStart = 0;
    private int _scrollbarDragStartScrollY = 0;
    private bool _scrollbarThumbHovered = false;

    // ── 颜色 ────────────────────────────────────────────────────

    private COLORREF _bgColor = cast(COLORREF)0x00FFFFFF;
    private COLORREF _textColor = cast(COLORREF)0x00333333;
    private COLORREF _selectedBgColor = cast(COLORREF)0x00CCE8FF;
    private COLORREF _selectedTextColor = cast(COLORREF)0x001A1A1A;
    private COLORREF _hoverBgColor = cast(COLORREF)0x00F0F0F0;
    private COLORREF _scrollbarTrackColor = cast(COLORREF)0x00F0F0F0;
    private COLORREF _scrollbarThumbColor = cast(COLORREF)0x00C0C0C0;
    private COLORREF _scrollbarThumbHoverColor = cast(COLORREF)0x00A0A0A0;

    // ── 构造 ────────────────────────────────────────────────────

    this()
    {
        width = 200;
        height = 300;
        focusable = true;
        onMouseWheel(&handleWheel);
        logTrace("LongList.ctor()");
    }

    this(Control parent)
    {
        this();
        if (parent)
            parent.addChild(this);
    }

    // ── 数据源设置 ──────────────────────────────────────────────

    /// 设置项总数回调
    void itemCountFunc(int delegate() func) { _itemCountFunc = func; recalcTotalHeight(); markDirty(DirtyBits.Visual); }

    /// 设置项文本回调
    void itemTextFunc(string delegate(int index) func) { _itemTextFunc = func; markDirty(DirtyBits.Visual); }

    /// 设置项高度回调（可变行高）
    void itemHeightFunc(int delegate(int index) func) { _itemHeightFunc = func; recalcTotalHeight(); markDirty(DirtyBits.Visual); }

    /// 便捷方法：设置固定项数（不需要回调）
    void setItemCount(int count)
    {
        int c = count;  // 捕获到闭包
        _itemCountFunc = () => c;
        recalcTotalHeight();
        markDirty(DirtyBits.Visual);
    }

    /// 便捷方法：设置字符串数组为数据源
    void setItems(string[] items)
    {
        string[] data = items.dup;  // 捕获到闭包
        _itemCountFunc = () => cast(int)data.length;
        _itemTextFunc = (int index) => (index >= 0 && index < cast(int)data.length) ? data[index] : "";
        recalcTotalHeight();
        markDirty(DirtyBits.Visual);
    }

    // ── 属性 ────────────────────────────────────────────────────

    /// 默认项高度
    int defaultItemHeight() const @property { return _defaultItemHeight; }
    void defaultItemHeight(int v) @property { _defaultItemHeight = v; recalcTotalHeight(); markDirty(DirtyBits.Visual); }

    /// 选择模式
    ListSelectionMode selectionMode() const @property { return _selectionMode; }
    void selectionMode(ListSelectionMode v) @property { _selectionMode = v; markDirty(DirtyBits.Visual); }

    /// Follow 模式 — 自动跟随最新记录
    FollowMode followMode() const @property { return _followMode; }
    void followMode(FollowMode v) @property
    {
        _followMode = v;
        if (v != FollowMode.None)
        {
            // 启用跟随时，立即滚到底部
            scrollToBottom();
        }
        markDirty(DirtyBits.Visual);
    }

    /// 距底部多少像素内视为"在底部"（Follow 模式阈值）
    int followThreshold() const @property { return _followThreshold; }
    void followThreshold(int v) @property { _followThreshold = v > 0 ? v : 1; }

    /// 当前是否在底部
    bool isAtBottom() const @property { return _isAtBottom; }

    /// 滚动偏移
    int scrollY() const @property { return _scrollY; }

    /// 选中项索引列表
    const(int[]) selectedIndices() const @property { return _selectedIndices; }

    /// 第一个选中项索引（-1=无选中）
    int selectedIndex() const @property
    {
        return _selectedIndices.length > 0 ? _selectedIndices[0] : -1;
    }

    /// 是否有选中项
    bool hasSelection() const @property { return _selectedIndices.length > 0; }

    /// 项总数
    int itemCount() const
    {
        if (_itemCountFunc is null) return 0;
        return _itemCountFunc();
    }

    /// 获取项文本
    string itemText(int index) const
    {
        if (_itemTextFunc is null) return "";
        return _itemTextFunc(index);
    }

    /// 获取项高度
    int itemHeight(int index) const
    {
        if (_itemHeightFunc !is null)
            return _itemHeightFunc(index);
        return _defaultItemHeight;
    }

    // ── 选中操作 ────────────────────────────────────────────────

    /// 选中指定项
    void select(int index)
    {
        if (index < 0 || index >= itemCount()) return;
        if (_selectionMode == ListSelectionMode.None) return;

        if (_selectionMode == ListSelectionMode.Single)
        {
            _selectedIndices = [index];
        }
        else
        {
            // 检查是否已选中
            foreach (si; _selectedIndices)
                if (si == index) return;
            _selectedIndices ~= index;
        }
        _anchorIndex = index;
        markDirty(DirtyBits.Visual);
    }

    /// 取消选中指定项
    void deselect(int index)
    {
        for (size_t i = 0; i < _selectedIndices.length; i++)
        {
            if (_selectedIndices[i] == index)
            {
                _selectedIndices = _selectedIndices[0 .. i] ~ _selectedIndices[i + 1 .. $];
                markDirty(DirtyBits.Visual);
                return;
            }
        }
    }

    /// 切换选中状态
    void toggleSelect(int index)
    {
        foreach (si; _selectedIndices)
            if (si == index) { deselect(index); return; }
        select(index);
    }

    /// 全选
    void selectAll()
    {
        if (_selectionMode == ListSelectionMode.None) return;
        _selectedIndices.length = 0;
        int count = itemCount();
        _selectedIndices.reserve(count);
        for (int i = 0; i < count; i++)
            _selectedIndices ~= i;
        markDirty(DirtyBits.Visual);
    }

    /// 清除选中
    void clearSelection()
    {
        _selectedIndices.length = 0;
        _anchorIndex = -1;
        markDirty(DirtyBits.Visual);
    }

    /// 判断项是否选中
    bool isSelected(int index) const
    {
        foreach (si; _selectedIndices)
            if (si == index) return true;
        return false;
    }

    /// 滚动到指定项（使其可见）
    void scrollToItem(int index)
    {
        if (index < 0 || index >= itemCount()) return;

        // 计算该项的 Y 位置
        int itemY = itemYPos(index);
        int itemH = itemHeight(index);
        int viewH = height();

        // 如果项在视口上方，滚动到项顶部
        if (itemY < _scrollY)
        {
            _scrollY = itemY;
        }
        // 如果项在视口下方，滚动到项底部可见
        else if (itemY + itemH > _scrollY + viewH)
        {
            _scrollY = itemY + itemH - viewH;
        }

        _scrollY = _scrollY.clamp(0, maxScroll());
        updateAtBottomState();
        markDirty(DirtyBits.Visual);
    }

    /// 滚动到底部（显示最新记录）
    void scrollToBottom()
    {
        recalcTotalHeight();
        _scrollY = maxScroll();
        _isAtBottom = true;
        markDirty(DirtyBits.Visual);
    }

    /// 通知数据已追加 — 在 Follow 模式下自动滚到底部
    /// 调用时机：外部数据源追加了新记录后
    void onItemsAppended()
    {
        recalcTotalHeight();

        if (_followMode == FollowMode.Always)
        {
            // 始终跟随：强制滚到底部
            _scrollY = maxScroll();
            _isAtBottom = true;
            markDirty(DirtyBits.Visual);
        }
        else if (_followMode == FollowMode.Follow && _isAtBottom)
        {
            // 跟随模式且当前在底部：自动跟随
            _scrollY = maxScroll();
            markDirty(DirtyBits.Visual);
        }
        // FollowMode.None 或用户已上滚：不做任何操作
    }

    /// 通知数据已重置 — 重新计算并滚到顶部（或底部如果 Follow）
    void onItemsReset()
    {
        recalcTotalHeight();
        clearSelection();

        if (_followMode != FollowMode.None)
        {
            _scrollY = maxScroll();
            _isAtBottom = true;
        }
        else
        {
            _scrollY = 0;
            _isAtBottom = false;
        }
        markDirty(DirtyBits.Visual);
    }

    /// 更新 _isAtBottom 状态
    private void updateAtBottomState()
    {
        int ms = maxScroll();
        _isAtBottom = (ms <= 0) || (_scrollY >= ms - _followThreshold);
    }

    // ── 内部计算 ────────────────────────────────────────────────

    /// 重新计算总高度
    private void recalcTotalHeight()
    {
        _totalHeight = 0;
        int count = itemCount();
        if (_itemHeightFunc !is null)
        {
            for (int i = 0; i < count; i++)
                _totalHeight += _itemHeightFunc(i);
        }
        else
        {
            _totalHeight = count * _defaultItemHeight;
        }
    }

    /// 最大滚动值
    private int maxScroll()
    {
        int viewH = height();
        int maxVal = _totalHeight - viewH;
        return (maxVal > 0) ? maxVal : 0;
    }

    /// 根据像素 Y 位置找到对应的项索引
    private int indexFromY(int pixelY)
    {
        int count = itemCount();
        if (count == 0) return -1;

        int accumulatedY = 0;
        for (int i = 0; i < count; i++)
        {
            int h = itemHeight(i);
            if (pixelY >= accumulatedY && pixelY < accumulatedY + h)
                return i;
            accumulatedY += h;
        }
        return count - 1;  // 超出范围，返回最后一项
    }

    /// 计算指定项的 Y 坐标（相对于列表顶部）
    private int itemYPos(int index)
    {
        int y = 0;
        for (int i = 0; i < index && i < itemCount(); i++)
            y += itemHeight(i);
        return y;
    }

    /// 计算滚动条滑块位置和尺寸
    private void getScrollbarThumbRect(out int thumbStart, out int thumbLength)
    {
        int trackH = height();
        int totalH = _totalHeight;
        if (totalH <= 0 || totalH <= trackH)
        {
            thumbStart = 0;
            thumbLength = trackH;
            return;
        }

        // 滑块大小 = viewH / totalH * trackH
        thumbLength = cast(int)((cast(long)trackH * trackH) / totalH);
        if (thumbLength < 16) thumbLength = 16;
        if (thumbLength > trackH) thumbLength = trackH;

        int movableRange = trackH - thumbLength;
        int maxS = maxScroll();
        if (maxS <= 0)
        {
            thumbStart = 0;
            return;
        }

        // 使用浮点确保精度
        float ratio = cast(float)_scrollY / cast(float)maxS;
        thumbStart = cast(int)(movableRange * ratio);
        if (thumbStart < 0) thumbStart = 0;
        if (thumbStart > movableRange) thumbStart = movableRange;
    }

    // ── 事件处理 ────────────────────────────────────────────────

    private void handleWheel(ref MouseWheelEvent ev)
    {
        int delta = ev.delta;
        int step = _defaultItemHeight * 3;  // 每次滚3行
        if (delta > 0)
            _scrollY = (_scrollY - step).clamp(0, maxScroll());
        else
            _scrollY = (_scrollY + step).clamp(0, maxScroll());

        // 对齐到行高整数倍，避免半行显示
        _scrollY = (_scrollY / _defaultItemHeight) * _defaultItemHeight;

        updateAtBottomState();
        markDirty(DirtyBits.Visual);
    }

    override void fireMouseDown(int mx, int my, int button)
    {
        if (button != 0) return;

        // 检查是否点击滚动条
        int listW = width() - _scrollbarWidth;
        if (mx >= listW)
        {
            // 滚动条区域
            int thumbStart, thumbLength;
            getScrollbarThumbRect(thumbStart, thumbLength);

            if (my >= thumbStart && my < thumbStart + thumbLength)
            {
                // 点击滑块：开始拖拽
                _scrollbarThumbDragging = true;
                _scrollbarDragStart = my;
                _scrollbarDragStartScrollY = _scrollY;
            }
            else
            {
                // 点击轨道：跳转
                int trackH = height();
                int maxS = maxScroll();
                if (maxS > 0 && trackH > 0)
                {
                    float ratio = cast(float)my / cast(float)trackH;
                    _scrollY = cast(int)(maxS * ratio).clamp(0, maxS);

                    // 对齐到行高整数倍，避免半行显示
                    _scrollY = (_scrollY / _defaultItemHeight) * _defaultItemHeight;

                    updateAtBottomState();
                }
            }
            markDirty(DirtyBits.Visual);
            return;
        }

        // 点击列表项
        int itemPixelY = my + _scrollY;
        int clickedIndex = indexFromY(itemPixelY);

        if (clickedIndex >= 0 && clickedIndex < itemCount())
        {
            // 处理选择
            if (_selectionMode != ListSelectionMode.None)
            {
                // TODO: 检测 Shift/Ctrl 修饰键
                // 当前简化为单选逻辑
                if (_selectionMode == ListSelectionMode.Single)
                {
                    _selectedIndices = [clickedIndex];
                }
                else
                {
                    toggleSelect(clickedIndex);
                }
                _anchorIndex = clickedIndex;
            }
            _hoveredIndex = clickedIndex;
            markDirty(DirtyBits.Visual);
        }

        super.fireMouseDown(mx, my, button);
    }

    override void fireMouseUp(int mx, int my, int button)
    {
        if (_scrollbarThumbDragging)
        {
            _scrollbarThumbDragging = false;
            markDirty(DirtyBits.Visual);
        }
        super.fireMouseUp(mx, my, button);
    }

    override void fireMouseMove(int mx, int my)
    {
        // 滚动条拖拽
        if (_scrollbarThumbDragging)
        {
            int thumbStart, thumbLength;
            getScrollbarThumbRect(thumbStart, thumbLength);
            int trackH = height();
            int movableRange = trackH - thumbLength;
            int maxS = maxScroll();

            if (movableRange > 0 && maxS > 0)
            {
                int delta = my - _scrollbarDragStart;
                float valueDelta = cast(float)delta * cast(float)maxS / cast(float)movableRange;
                _scrollY = cast(int)(_scrollbarDragStartScrollY + valueDelta).clamp(0, maxS);

                // 对齐到行高整数倍，避免半行显示
                _scrollY = (_scrollY / _defaultItemHeight) * _defaultItemHeight;

                updateAtBottomState();
            }
            markDirty(DirtyBits.Visual);
            return;
        }

        // 滚动条悬停
        int listW = width() - _scrollbarWidth;
        if (mx >= listW)
        {
            int thumbStart, thumbLength;
            getScrollbarThumbRect(thumbStart, thumbLength);
            bool wasHovered = _scrollbarThumbHovered;
            _scrollbarThumbHovered = (my >= thumbStart && my < thumbStart + thumbLength);
            if (_scrollbarThumbHovered != wasHovered)
                markDirty(DirtyBits.Visual);
            return;
        }

        // 列表项悬停
        int itemPixelY = my + _scrollY;
        int hoveredIdx = indexFromY(itemPixelY);
        if (hoveredIdx != _hoveredIndex)
        {
            _hoveredIndex = hoveredIdx;
            markDirty(DirtyBits.Visual);
        }
    }

    override void fireKeyDown(uint keyCode, bool shift = false, bool control = false, bool alt = false)
    {
        int count = itemCount();
        if (count == 0) return;

        switch (keyCode)
        {
            case VK_UP:
            {
                int cur = selectedIndex();
                if (cur > 0)
                {
                    select(cur - 1);
                    scrollToItem(cur - 1);
                }
                break;
            }
            case VK_DOWN:
            {
                int cur = selectedIndex();
                if (cur < count - 1)
                {
                    select(cur + 1);
                    scrollToItem(cur + 1);
                }
                break;
            }
            case VK_HOME:
                select(0);
                scrollToItem(0);
                break;
            case VK_END:
                select(count - 1);
                scrollToItem(count - 1);
                break;
            case VK_SPACE:
                if (_hoveredIndex >= 0)
                    toggleSelect(_hoveredIndex);
                break;
            default:
                break;
        }

        super.fireKeyDown(keyCode, shift, control, alt);
    }

    // ── 渲染 ────────────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        int rx = x();
        int ry = y();
        int rw = width();
        int rh = height();
        int listW = rw - _scrollbarWidth;

        // ── 背景 ──
        RECT bgRect = { cast(LONG)rx, cast(LONG)ry, cast(LONG)(rx + listW), cast(LONG)(ry + rh) };
        HBRUSH bgBrush = CreateSolidBrush(_bgColor);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── 虚拟渲染可见项 ──
        int count = itemCount();
        if (count > 0 && _itemTextFunc !is null)
        {
            auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
            SetBkMode(hdc, TRANSPARENT);

            // 找到第一个可见项
            int currentY = 0;  // 项的 Y 坐标（相对于列表顶部）
            int viewTop = _scrollY;
            int viewBottom = _scrollY + rh;

            for (int i = 0; i < count; i++)
            {
                int itemH = itemHeight(i);
                int itemTop = currentY;
                int itemBottom = currentY + itemH;

                // 只渲染可见项
                if (itemBottom > viewTop && itemTop < viewBottom)
                {
                    int drawY = ry + itemTop - _scrollY;

                    // 选中背景
                    if (isSelected(i))
                    {
                        RECT selRect = { cast(LONG)rx, cast(LONG)drawY, cast(LONG)(rx + listW), cast(LONG)(drawY + itemH) };
                        HBRUSH selBrush = CreateSolidBrush(_selectedBgColor);
                        FillRect(hdc, &selRect, selBrush);
                        DeleteObject(cast(HGDIOBJ)selBrush);
                    }
                    // 悬停背景
                    else if (i == _hoveredIndex)
                    {
                        RECT hovRect = { cast(LONG)rx, cast(LONG)drawY, cast(LONG)(rx + listW), cast(LONG)(drawY + itemH) };
                        HBRUSH hovBrush = CreateSolidBrush(_hoverBgColor);
                        FillRect(hdc, &hovRect, hovBrush);
                        DeleteObject(cast(HGDIOBJ)hovBrush);
                    }

                    // 项文本
                    string text = _itemTextFunc(i);
                    if (text.length > 0)
                    {
                        SetTextColor(hdc, isSelected(i) ? _selectedTextColor : _textColor);
                        wstring textW = toUTF16(text);
                        int textX = rx + 6;
                        int textY = drawY + (itemH - cast(int)_fontSize) / 2;
                        TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);
                    }
                }

                currentY += itemH;

                // 如果已超出视口底部，停止
                if (currentY > viewBottom)
                    break;
            }

            FontCache.release(hdc, fontEntry);
        }

        // ── 滚动条 ──
        renderScrollbar(hdc);

        // ── 边框 ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, rx, ry, rx + rw, ry + rh);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);
    }

    /// 渲染滚动条
    private void renderScrollbar(HDC hdc)
    {
        int rx = x() + width() - _scrollbarWidth;
        int ry = y();
        int rh = height();

        // 轨道
        RECT trackRect = { cast(LONG)rx, cast(LONG)ry, cast(LONG)(rx + _scrollbarWidth), cast(LONG)(ry + rh) };
        HBRUSH trackBrush = CreateSolidBrush(_scrollbarTrackColor);
        FillRect(hdc, &trackRect, trackBrush);
        DeleteObject(cast(HGDIOBJ)trackBrush);

        // 滑块
        if (_totalHeight > height())
        {
            int thumbStart, thumbLength;
            getScrollbarThumbRect(thumbStart, thumbLength);

            COLORREF thumbCol = _scrollbarThumbHovered ? _scrollbarThumbHoverColor : _scrollbarThumbColor;
            RECT thumbRect = {
                cast(LONG)(rx + 1), cast(LONG)(ry + thumbStart),
                cast(LONG)(rx + _scrollbarWidth - 1), cast(LONG)(ry + thumbStart + thumbLength)
            };
            HBRUSH thumbBrush = CreateSolidBrush(thumbCol);
            FillRect(hdc, &thumbRect, thumbBrush);
            DeleteObject(cast(HGDIOBJ)thumbBrush);

            // 滑块边框
            HPEN thumbPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00888888);
            HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)thumbPen);
            HGDIOBJ oldBrush2 = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
            Rectangle(hdc, thumbRect.left, thumbRect.top, thumbRect.right, thumbRect.bottom);
            SelectObject(hdc, oldPen);
            SelectObject(hdc, oldBrush2);
            DeleteObject(cast(HGDIOBJ)thumbPen);
        }
    }

    override void render() {}
}