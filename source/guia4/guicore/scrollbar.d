module guia4.guicore.scrollbar;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.theme;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * ScrollBarOrientation — 滚动条方向
 */
enum ScrollBarOrientation
{
    Vertical,   /// 垂直滚动条
    Horizontal  /// 水平滚动条
}

/**
 * ScrollBar — 独立滚动条控件
 *
 * 可独立使用（不依赖 ScrollableContainer）。
 * 支持拖拽滑块、点击轨道跳转、鼠标滚轮。
 * 渲染：轨道 + 滑块
 */
class ScrollBar : Control
{
    private ScrollBarOrientation _orientation = ScrollBarOrientation.Vertical;
    private int _min = 0;
    private int _max = 100;
    private int _value = 0;
    private int _pageSize = 10;
    private bool _thumbHovered = false;
    private bool _thumbDragging = false;
    private int _dragStart = 0;
    private int _dragStartValue = 0;

    // 颜色（使用 Theme 常量作为默认值）
    private COLORREF _trackColor   = Theme.crScrollTrack();
    private COLORREF _thumbColor   = Theme.crScrollThumb();
    private COLORREF _thumbHoverColor = Theme.crScrollHover();
    private COLORREF _thumbDragColor  = Theme.crScrollDrag();

    this(Control parent, ScrollBarOrientation orient = ScrollBarOrientation.Vertical)
    {
        super(parent);
        width = 14;
        height = 100;
        _orientation = orient;
        if (orient == ScrollBarOrientation.Horizontal)
        {
            width = 100;
            height = 14;
        }
        onMouseWheel(&handleWheel);
        logTrace("ScrollBar.ctor(parent=", parent !is null, ", orient=", orient, ")");
    }

    // ── 属性 ────────────────────────────────────────────────

    ScrollBarOrientation orientation() const @property { return _orientation; }
    void orientation(ScrollBarOrientation v) @property { _orientation = v; markDirty(); }

    int value() const @property { return _value; }

    void value(int v) @property
    {
        _value = clampValue(v);
        markDirty();
    }

    int min() const @property { return _min; }
    void min(int v) @property { _min = v; _value = clampValue(_value); markDirty(); }

    int max() const @property { return _max; }
    void max(int v) @property { _max = v; _value = clampValue(_value); markDirty(); }

    int pageSize() const @property { return _pageSize; }
    void pageSize(int v) @property { _pageSize = v; _value = clampValue(_value); markDirty(); }

    /// 滑块是否正在被拖拽（供容器查询以转发事件）
    bool isDragging() const @property { return _thumbDragging; }

    // ── 辅助方法 ──────────────────────────────────────────

    private int clampValue(int v)
    {
        int maxVal = _max - _pageSize;
        if (maxVal < _min) maxVal = _min;
        if (v < _min) return _min;
        if (v > maxVal) return maxVal;
        return v;
    }

    /// 计算滑块位置和尺寸（返回滑块起始和长度，单位为像素）
    private void getThumbRect(out int thumbStart, out int thumbLength)
    {
        int totalRange = _max - _min;
        if (totalRange <= 0)
        {
            thumbStart = 0;
            thumbLength = (_orientation == ScrollBarOrientation.Vertical) ? height() : width();
            return;
        }

        int trackLength = (_orientation == ScrollBarOrientation.Vertical) ? height() : width();

        // 滑块大小 = pageSize / totalRange * trackLength
        thumbLength = cast(int)((cast(long)_pageSize * trackLength) / totalRange);
        if (thumbLength < 16) thumbLength = 16; // 最小滑块尺寸
        if (thumbLength > trackLength) thumbLength = trackLength;

        int movableRange = trackLength - thumbLength;
        if (movableRange <= 0)
        {
            thumbStart = 0;
            return;
        }

        // 在最大值时，滑块应在轨道最底部/右侧
        int maxVal = _max - _pageSize;
        if (maxVal < _min) maxVal = _min;

        if (_value >= maxVal)
        {
            thumbStart = movableRange;
        }
        else if (_value <= _min)
        {
            thumbStart = 0;
        }
        else
        {
            // 使用浮点计算确保精度
            float ratio = cast(float)(_value - _min) / cast(float)(maxVal - _min);
            thumbStart = cast(int)(movableRange * ratio);
            if (thumbStart < 0) thumbStart = 0;
            if (thumbStart > movableRange) thumbStart = movableRange;
        }
    }

    /// 根据像素位置计算滚动值
    private int valueFromPixel(int pixel)
    {
        int totalRange = _max - _min;
        if (totalRange <= 0) return _min;

        int trackLength = (_orientation == ScrollBarOrientation.Vertical) ? height() : width();
        int thumbStart, thumbLength;
        getThumbRect(thumbStart, thumbLength);

        int movableRange = trackLength - thumbLength;
        if (movableRange <= 0) return _min;

        // 像素位置到达轨道末端时，返回最大值
        if (pixel >= movableRange)
            return _max - _pageSize;

        // 使用浮点计算确保精度
        float ratio = cast(float)pixel / cast(float)movableRange;
        int maxVal = _max - _pageSize;
        if (maxVal < _min) maxVal = _min;
        int result = _min + cast(int)((maxVal - _min) * ratio);
        return clampValue(result);
    }

    // ── 鼠标滚轮 ──────────────────────────────────────────

    private void handleWheel(ref MouseWheelEvent ev)
    {
        int delta = ev.delta;
        int step = (delta > 0) ? -3 : 3;
        _value = clampValue(_value + step);
        markDirty();
    }

    // ── 鼠标事件 ──────────────────────────────────────────

    override void fireMouseDown(int x, int y, int button)
    {
        logTrace("ScrollBar.fireMouseDown(x=", x, ", y=", y, ")");

        int thumbStart, thumbLength;
        getThumbRect(thumbStart, thumbLength);

        int clickPos = (_orientation == ScrollBarOrientation.Vertical) ? y : x;

        if (clickPos >= thumbStart && clickPos < thumbStart + thumbLength)
        {
            // 点击滑块：开始拖拽
            _thumbDragging = true;
            _dragStart = clickPos;
            _dragStartValue = _value;
            markDirty();
        }
        else
        {
            // 点击轨道：跳转到对应位置
            int newThumbPos = clickPos - thumbLength / 2;
            if (newThumbPos < 0) newThumbPos = 0;
            _value = valueFromPixel(newThumbPos);
            markDirty();
        }

        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        logTrace("ScrollBar.fireMouseUp(x=", x, ", y=", y, ")");

        if (_thumbDragging)
        {
            _thumbDragging = false;
            markDirty();
        }

        super.fireMouseUp(x, y, button);
    }

    override void fireMouseMove(int x, int y)
    {
        int thumbStart, thumbLength;
        getThumbRect(thumbStart, thumbLength);

        int pos = (_orientation == ScrollBarOrientation.Vertical) ? y : x;

        if (_thumbDragging)
        {
            // 拖拽更新
            int delta = pos - _dragStart;
            int trackLength = (_orientation == ScrollBarOrientation.Vertical) ? height() : width();
            int totalRange = _max - _min;
            int movableRange = trackLength - thumbLength;

            if (movableRange > 0 && totalRange > 0)
            {
                int valueDelta = (delta * totalRange) / movableRange;
                _value = clampValue(_dragStartValue + valueDelta);
            }
            markDirty();
        }
        else
        {
            // 悬停检测
            bool wasHovered = _thumbHovered;
            _thumbHovered = (pos >= thumbStart && pos < thumbStart + thumbLength);
            if (_thumbHovered != wasHovered)
                markDirty();
        }

        super.fireMouseMove(x, y);
    }

    // ── 渲染 ──────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("ScrollBar.renderWithGDI() size=(", width(), ",", height(), ")");

        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 作为基准
        int rx = 0;
        int ry = 0;
        int rw = width();
        int rh = height();

        // ── 轨道背景 ──
        RECT trackRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH trackBrush = CreateSolidBrush(_trackColor);
        FillRect(hdc, &trackRect, trackBrush);
        DeleteObject(cast(HGDIOBJ)trackBrush);

        // ── 滑块 ──
        int thumbStart, thumbLength;
        getThumbRect(thumbStart, thumbLength);

        COLORREF thumbCol;
        if (_thumbDragging)
            thumbCol = _thumbDragColor;
        else if (_thumbHovered)
            thumbCol = _thumbHoverColor;
        else
            thumbCol = _thumbColor;

        RECT thumbRect;
        if (_orientation == ScrollBarOrientation.Vertical)
        {
            thumbRect.left   = cast(LONG)(rx + 1);
            thumbRect.top    = cast(LONG)(ry + thumbStart);
            thumbRect.right  = cast(LONG)(rx + rw - 1);
            thumbRect.bottom = cast(LONG)(ry + thumbStart + thumbLength);
        }
        else
        {
            thumbRect.left   = cast(LONG)(rx + thumbStart);
            thumbRect.top    = cast(LONG)(ry + 1);
            thumbRect.right  = cast(LONG)(rx + thumbStart + thumbLength);
            thumbRect.bottom = cast(LONG)(ry + rh - 1);
        }

        HBRUSH thumbBrush = CreateSolidBrush(thumbCol);
        FillRect(hdc, &thumbRect, thumbBrush);
        DeleteObject(cast(HGDIOBJ)thumbBrush);

        // 滑块边框
        HPEN thumbPen = CreatePen(PS_SOLID, 1, Theme.crScrollBorder());
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)thumbPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, thumbRect.left, thumbRect.top, thumbRect.right, thumbRect.bottom);
        SelectObject(hdc, oldBrush);
        SelectObject(hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)thumbPen);
    }

    override void render()
    {
    }
}