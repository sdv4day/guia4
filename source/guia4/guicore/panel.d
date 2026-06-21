module guia4.guicore.panel;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.scrollbar;
import guia4.guicore.theme;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.utils.math : clamp;
import guia4.platform_win32.win32defs;
import std.utf;
import std.algorithm;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;


/**
 * Panel — 通用容器控件
 * 
 * 功能：
 *   - 可配置背景色、边框颜色/宽度/圆角
 *   - 可选标题栏（显示在顶部）
 *   - 作为子控件的容器
 *   - 支持布局管理
 *   - 支持纵向/横向滚动条使能
 *   - 支持内容对齐预制属性（Fill/Center/Dock）
 */
class Panel : Control
{
    private string _title;
    private COLORREF _bgColor = Theme.crPanelBg();
    private COLORREF _borderColor = Theme.crBorder();
    private int _borderWidth = 1;
    private int _borderRadius = 6;                               // 圆角半径
    private COLORREF _titleBgColor = Theme.crTitleBarBg();
    private COLORREF _titleTextColor = Theme.crText();
    private uint _fontSize = 13;
    private int _titleHeight = 0;  // 0 = 无标题栏, >0 = 标题栏高度


    // ── 滚动条使能 ──
    private bool _vScroll = false;    /// 纵向滚动条使能
    private bool _hScroll = false;    /// 横向滚动条使能
    private int _scrollX = 0;         /// 横向滚动偏移
    private int _scrollY = 0;         /// 纵向滚动偏移
    private int _contentWidth = 0;    /// 内容总宽度
    private int _contentHeight = 0;   /// 内容总高度
    private int _scrollbarWidth = 14; /// 滚动条宽度

    // ── 内部 ScrollBar 实例（非子控件）──
    private ScrollBar _vScrollBar;
    private ScrollBar _hScrollBar;

    // ── 自动内容尺寸 ──
    private bool _autoSizeContent = false;  /// 自动计算内容尺寸

    this(Control parent)
    {
        super(parent);
        rendersChildren = true;
        width = 200;
        height = 150;
        padding(8);  // 默认内边距
        onMouseWheel(&handleMouseWheel);

        // 创建内部滚动条（null parent = 不加入控件树）
        _vScrollBar = new ScrollBar(null, ScrollBarOrientation.Vertical);
        _vScrollBar.width = _scrollbarWidth;
        _hScrollBar = new ScrollBar(null, ScrollBarOrientation.Horizontal);
        _hScrollBar.height = _scrollbarWidth;

        logTrace("Panel.ctor()");
    }

    this(Control parent, string title)
    {
        super(parent);
        rendersChildren = true;
        _title = title;
        _titleHeight = 24;
        width = 200;
        height = 150;
        padding(8);  // 默认内边距
        onMouseWheel(&handleMouseWheel);

        // 创建内部滚动条
        _vScrollBar = new ScrollBar(null, ScrollBarOrientation.Vertical);
        _vScrollBar.width = _scrollbarWidth;
        _hScrollBar = new ScrollBar(null, ScrollBarOrientation.Horizontal);
        _hScrollBar.height = _scrollbarWidth;

        logTrace("Panel.ctor(title='", title, "')");
    }

    // ── 属性 ─────────────────────────────────────────────────────

    string title() const @property { return _title; }
    void title(string v) @property { _title = v; _titleHeight = v.length > 0 ? 24 : 0; markDirty(); }

    COLORREF bgColor() const @property { return _bgColor; }
    void bgColor(COLORREF v) @property { _bgColor = v; markDirty(); }

    COLORREF borderColor() const @property { return _borderColor; }
    void borderColor(COLORREF v) @property { _borderColor = v; markDirty(); }

    int borderWidth() const @property { return _borderWidth; }
    void borderWidth(int v) @property { _borderWidth = v; markDirty(); }

    int borderRadius() const @property { return _borderRadius; }
    void borderRadius(int v) @property { _borderRadius = v; markDirty(); }


    // ── 滚动条使能属性 ──

    bool vScroll() const @property { return _vScroll; }
    void vScroll(bool v) @property { _vScroll = v; markDirty(); }

    bool hScroll() const @property { return _hScroll; }
    void hScroll(bool v) @property { _hScroll = v; markDirty(); }

    // ── 滚动偏移属性 ──

    int scrollX() const @property { return _scrollX; }
    int scrollY() const @property { return _scrollY; }

    /// override Control.scrollOffsetY
    override int scrollOffsetY() const @property { return _scrollY; }

    /// override Control.scrollOffsetX
    override int scrollOffsetX() const @property { return _scrollX; }


    // ── 自动内容尺寸属性 ──

    bool autoSizeContent() const @property { return _autoSizeContent; }
    void autoSizeContent(bool v) @property { _autoSizeContent = v; markDirty(); }

    // ── ScrollBar 同步辅助 ──

    /// 同步内部 ScrollBar 状态（渲染和事件转发前调用）
    private void syncScrollBars()
    {
        int viewH = height() - _titleHeight - paddingTop() - paddingBottom() - (_hScroll ? _scrollbarWidth : 0);
        int viewW = width() - paddingLeft() - paddingRight() - (_vScroll ? _scrollbarWidth : 0);

        // 纵向
        _vScrollBar.width = _scrollbarWidth;
        _vScrollBar.height = viewH;
        _vScrollBar.min(0);
        _vScrollBar.max(_contentHeight);
        _vScrollBar.pageSize(viewH);
        _vScrollBar.value(_scrollY);

        // 横向
        _hScrollBar.height = _scrollbarWidth;
        _hScrollBar.width = viewW;
        _hScrollBar.min(0);
        _hScrollBar.max(_contentWidth);
        _hScrollBar.pageSize(viewW);
        _hScrollBar.value(_scrollX);
    }

    /// 从内部 ScrollBar 同步滚动值回 Panel
    private void syncScrollFromBars()
    {
        int newSY = _vScrollBar.value();
        int newSX = _hScrollBar.value();
        if (newSY != _scrollY || newSX != _scrollX)
        {
            _scrollY = newSY;
            _scrollX = newSX;
            markDirty();
        }
    }

    /// 判断容器局部坐标是否在纵向滚动条区域内
    private bool isInVScrollbar(int lx, int ly) const
    {
        if (!_vScroll || _contentHeight <= height() - _titleHeight - paddingTop() - paddingBottom() - (_hScroll ? _scrollbarWidth : 0))
            return false;
        int viewH = height() - _titleHeight - (_hScroll ? _scrollbarWidth : 0);
        return lx >= width() - _scrollbarWidth && lx < width()
            && ly >= _titleHeight && ly < _titleHeight + viewH;
    }

    /// 判断容器局部坐标是否在横向滚动条区域内
    private bool isInHScrollbar(int lx, int ly) const
    {
        if (!_hScroll || _contentWidth <= width() - paddingLeft() - paddingRight() - (_vScroll ? _scrollbarWidth : 0))
            return false;
        int viewW = width() - (_vScroll ? _scrollbarWidth : 0);
        return ly >= height() - _scrollbarWidth && ly < height()
            && lx >= 0 && lx < viewW;
    }

    // ── 内容区域计算辅助 ──

    /// 获取内容区域尺寸（减去 padding 和滚动条占位）
    private void getContentArea(out int cx, out int cy, out int cw, out int ch)
    {
        cx = position().x() + paddingLeft();
        cy = position().y() + _titleHeight + paddingTop();
        cw = width() - paddingLeft() - paddingRight() - (_vScroll ? _scrollbarWidth : 0);
        ch = height() - _titleHeight - paddingTop() - paddingBottom() - (_hScroll ? _scrollbarWidth : 0);
    }

    // ── 内容对齐应用 ──

    /// 根据子控件的 dock/hAlign/vAlign 属性重新排列子控件
    /// 使用基类 layoutChildren() 实现停靠布局
    void applyContentAlignment()
    {
        layoutChildren();
    }

    // ── 内容尺寸自动计算 ──

    /// 计算子控件的总内容尺寸
    private void calcContentSize()
    {
        int maxRight = 0;
        int maxBottom = 0;
        int contentOriginX = position().x() + paddingLeft();
        int contentOriginY = position().y() + _titleHeight + paddingTop();

        foreach (child; children())
        {
            if (!child.visible()) continue;
            int childRight = child.position().x() + child.width() - contentOriginX;
            int childBottom = child.position().y() + child.height() - contentOriginY;
            if (childRight > maxRight) maxRight = childRight;
            if (childBottom > maxBottom) maxBottom = childBottom;
        }

        _contentWidth = maxRight;
        _contentHeight = maxBottom;
    }

    // ── 滚动范围辅助 ──

    /// 纵向最大滚动偏移
    private int maxScrollY() const
    {
        int viewH = height() - _titleHeight - paddingTop() - paddingBottom() - (_hScroll ? _scrollbarWidth : 0);
        return std.algorithm.max(0, _contentHeight - viewH);
    }

    /// 横向最大滚动偏移
    private int maxScrollX() const
    {
        int viewW = width() - paddingLeft() - paddingRight() - (_vScroll ? _scrollbarWidth : 0);
        return std.algorithm.max(0, _contentWidth - viewW);
    }

    // ── 鼠标滚轮处理 ──

    private void handleMouseWheel(ref MouseWheelEvent ev)
    {
        int delta = ev.delta;
        if (_vScroll)
        {
            int maxY = maxScrollY();
            if (delta > 0)
                _scrollY = (_scrollY - 20).clamp(0, maxY);
            else
                _scrollY = (_scrollY + 20).clamp(0, maxY);
            markDirty();
        }
    }

    // ── 子控件管理 ──

    override void addChild(Control child)
    {
        super.addChild(child);
        if (_autoSizeContent)
            calcContentSize();
        // 检查子控件是否有停靠或对齐属性，自动应用布局
        bool hasLayoutProps = false;
        foreach (c; children())
        {
            if (c.dock() != DockStyle.None || c.hAlign() != HAlign.Left || c.vAlign() != VAlign.Top)
            {
                hasLayoutProps = true;
                break;
            }
        }
        if (hasLayoutProps)
            applyContentAlignment();
    }

    // ── 渲染 ─────────────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("Panel.renderWithGDI() at (", position().x(), ",", position().y(), ") ", width(), "x", height());

        // 确保布局已执行
        ensureLayout();

        // Panel 通过 LayerCompositor 渲染时，视口已被偏移到该 Panel 的位置，
        // 所以这里所有绘制都使用本地坐标 (0,0) 而非 position()
        int rw = width();
        int rh = height();

        // ── 背景 ──
        RECT bgRect = {
            cast(LONG)0, cast(LONG)0,
            cast(LONG)rw, cast(LONG)rh
        };
        HBRUSH bgBrush = CreateSolidBrush(_bgColor);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── 标题栏 ──
        if (_titleHeight > 0 && _title.length > 0)
        {
            RECT titleRect = {
                cast(LONG)0, cast(LONG)0,
                cast(LONG)rw, cast(LONG)_titleHeight
            };
            HBRUSH titleBrush = CreateSolidBrush(_titleBgColor);
            FillRect(hdc, &titleRect, titleBrush);
            DeleteObject(cast(HGDIOBJ)titleBrush);

            // 标题文字
            auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize, FW_BOLD);
            SetTextColor(hdc, _titleTextColor);
            SetBkMode(hdc, TRANSPARENT);
            wstring textW = toUTF16(_title);
            TextOutW(hdc, 8, (_titleHeight - cast(int)_fontSize) / 2,
                     cast(const(PWSTR))textW.ptr, cast(int)textW.length);
            FontCache.release(hdc, fontEntry);

            // 标题栏底部分隔线
            HPEN sepPen = CreatePen(PS_SOLID, 1, _borderColor);
            HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)sepPen);
            MoveToEx(hdc, 0, _titleHeight, null);
            LineTo(hdc, rw, _titleHeight);
            SelectObject(hdc, oldPen);
            DeleteObject(cast(HGDIOBJ)sepPen);
        }

        // ── 边框 ──
        if (_borderWidth > 0)
        {
            HPEN borderPen = CreatePen(PS_SOLID, _borderWidth, _borderColor);
            HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
            HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));

            if (_borderRadius > 0)
            {
                RoundRect(hdc, 0, 0, rw, rh,
                          _borderRadius * 2, _borderRadius * 2);
            }
            else
            {
                Rectangle(hdc, 0, 0, rw, rh);
            }

            SelectObject(hdc, oldPen);
            SelectObject(hdc, oldBrush);
            DeleteObject(cast(HGDIOBJ)borderPen);
        }

        // ── 如果启用自动内容尺寸，先计算 ──
        if (_autoSizeContent)
            calcContentSize();

        // ── 计算内容区域 ──
        int contentX = paddingLeft();
        int contentY = _titleHeight + paddingTop();
        int contentW = rw - paddingLeft() - paddingRight() - (_vScroll ? _scrollbarWidth : 0);
        int contentH = rh - _titleHeight - paddingTop() - paddingBottom() - (_hScroll ? _scrollbarWidth : 0);

        // ── 渲染子控件（带滚动裁剪）──
        if (_vScroll || _hScroll)
        {
            int savedDC = SaveDC(hdc);
            IntersectClipRect(hdc, contentX, contentY, contentX + contentW, contentY + contentH);
            POINT oldOrigin;
            // 偏移原点：相对 Panel 本地原点，再减去滚动偏移
            OffsetViewportOrgEx(hdc, -_scrollX, -_scrollY, &oldOrigin);

            foreach (child; children())
            {
                if (child.visible())
                    child.renderWithGDI(hdc.Value);
            }

            RestoreDC(hdc, savedDC);

            // ── 绘制滚动条（通过内部 ScrollBar）──
            syncScrollBars();
            if (_vScroll && _contentHeight > contentH)
            {
                POINT sbOrigin;
                OffsetViewportOrgEx(hdc, rw - _scrollbarWidth, _titleHeight, &sbOrigin);
                _vScrollBar.renderWithGDI(hdc.Value);
                SetViewportOrgEx(hdc, sbOrigin.x, sbOrigin.y, null);
            }
            if (_hScroll && _contentWidth > contentW)
            {
                POINT sbOrigin;
                OffsetViewportOrgEx(hdc, 0, rh - _scrollbarWidth, &sbOrigin);
                _hScrollBar.renderWithGDI(hdc.Value);
                SetViewportOrgEx(hdc, sbOrigin.x, sbOrigin.y, null);
            }
        }
        else
        {
            // ── 无滚动，直接渲染子控件 ──
            foreach (child; children())
            {
                if (child.visible())
                    child.renderWithGDI(hdc.Value);
            }
        }
    }

    // ── 鼠标事件转发给内部 ScrollBar ──

    override void fireMouseDown(int x, int y, int button)
    {
        if (isInVScrollbar(x, y))
        {
            syncScrollBars();
            int sbLocalX = x - (width() - _scrollbarWidth);
            int sbLocalY = y - _titleHeight;
            _vScrollBar.fireMouseDown(sbLocalX, sbLocalY, button);
            syncScrollFromBars();
            return;
        }
        if (isInHScrollbar(x, y))
        {
            syncScrollBars();
            int sbLocalX = x;
            int sbLocalY = y - (height() - _scrollbarWidth);
            _hScrollBar.fireMouseDown(sbLocalX, sbLocalY, button);
            syncScrollFromBars();
            return;
        }
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        bool vDrag = _vScrollBar.isDragging;
        bool hDrag = _hScrollBar.isDragging;
        if (vDrag || hDrag)
        {
            syncScrollBars();
            if (vDrag)
            {
                int sbLocalX = x - (width() - _scrollbarWidth);
                int sbLocalY = y - _titleHeight;
                _vScrollBar.fireMouseUp(sbLocalX, sbLocalY, button);
            }
            if (hDrag)
            {
                int sbLocalX = x;
                int sbLocalY = y - (height() - _scrollbarWidth);
                _hScrollBar.fireMouseUp(sbLocalX, sbLocalY, button);
            }
            syncScrollFromBars();
            return;
        }
        super.fireMouseUp(x, y, button);
    }

    override void fireMouseMove(int x, int y)
    {
        bool vDrag = _vScrollBar.isDragging;
        bool hDrag = _hScrollBar.isDragging;
        if (vDrag || hDrag || isInVScrollbar(x, y) || isInHScrollbar(x, y))
        {
            syncScrollBars();
            if (vDrag || isInVScrollbar(x, y))
            {
                int sbLocalX = x - (width() - _scrollbarWidth);
                int sbLocalY = y - _titleHeight;
                _vScrollBar.fireMouseMove(sbLocalX, sbLocalY);
            }
            if (hDrag || isInHScrollbar(x, y))
            {
                int sbLocalX = x;
                int sbLocalY = y - (height() - _scrollbarWidth);
                _hScrollBar.fireMouseMove(sbLocalX, sbLocalY);
            }
            syncScrollFromBars();
            return;
        }
        super.fireMouseMove(x, y);
    }

    override void render()
    {
    }
}

