module guia4.guicore.panel;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
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
    private COLORREF _bgColor = cast(COLORREF)0x00F0F0F0;       // 浅灰背景
    private COLORREF _borderColor = cast(COLORREF)0x00CCCCCC;   // 灰色边框
    private int _borderWidth = 1;
    private int _borderRadius = 6;                               // 圆角半径
    private COLORREF _titleBgColor = cast(COLORREF)0x00E0E0E0;  // 标题栏背景
    private COLORREF _titleTextColor = cast(COLORREF)0x00333333; // 标题文字颜色
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

    // ── 滚动条拖拽状态 ──
    private bool _vThumbDragging = false;
    private bool _hThumbDragging = false;
    private int _vDragStartY = 0;
    private int _hDragStartX = 0;
    private int _vDragStartScroll = 0;
    private int _hDragStartScroll = 0;
    private bool _vThumbHovered = false;
    private bool _hThumbHovered = false;

    // ── 滚动条颜色 ──
    private COLORREF _trackColor = cast(COLORREF)0x00F0F0F0;
    private COLORREF _thumbColor = cast(COLORREF)0x00C0C0C0;
    private COLORREF _thumbHoverColor = cast(COLORREF)0x00A0A0A0;

    // ── 自动内容尺寸 ──
    private bool _autoSizeContent = false;  /// 自动计算内容尺寸

    this(Control parent)
    {
        super(parent);
        width = 200;
        height = 150;
        padding(8);  // 默认内边距
        onMouseWheel(&handleMouseWheel);
        logTrace("Panel.ctor()");
    }

    this(Control parent, string title)
    {
        super(parent);
        _title = title;
        _titleHeight = 24;
        width = 200;
        height = 150;
        padding(8);  // 默认内边距
        onMouseWheel(&handleMouseWheel);
        logTrace("Panel.ctor(title='", title, "')");
    }

    // ── 属性 ─────────────────────────────────────────────────────

    string title() const @property { return _title; }
    void title(string v) @property { _title = v; _titleHeight = v.length > 0 ? 24 : 0; markDirty(DirtyBits.Visual); }

    COLORREF bgColor() const @property { return _bgColor; }
    void bgColor(COLORREF v) @property { _bgColor = v; markDirty(DirtyBits.Visual); }

    COLORREF borderColor() const @property { return _borderColor; }
    void borderColor(COLORREF v) @property { _borderColor = v; markDirty(DirtyBits.Visual); }

    int borderWidth() const @property { return _borderWidth; }
    void borderWidth(int v) @property { _borderWidth = v; markDirty(DirtyBits.Visual); }

    int borderRadius() const @property { return _borderRadius; }
    void borderRadius(int v) @property { _borderRadius = v; markDirty(DirtyBits.Visual); }


    // ── 滚动条使能属性 ──

    bool vScroll() const @property { return _vScroll; }
    void vScroll(bool v) @property { _vScroll = v; markDirty(DirtyBits.Visual); }

    bool hScroll() const @property { return _hScroll; }
    void hScroll(bool v) @property { _hScroll = v; markDirty(DirtyBits.Visual); }

    // ── 滚动偏移属性 ──

    int scrollX() const @property { return _scrollX; }
    int scrollY() const @property { return _scrollY; }


    // ── 自动内容尺寸属性 ──

    bool autoSizeContent() const @property { return _autoSizeContent; }
    void autoSizeContent(bool v) @property { _autoSizeContent = v; markDirty(DirtyBits.Visual); }

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
            markDirty(DirtyBits.Visual);
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

        int rx = position().x();
        int ry = position().y();
        int rw = width();
        int rh = height();

        // ── 背景 ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(_bgColor);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── 标题栏 ──
        if (_titleHeight > 0 && _title.length > 0)
        {
            RECT titleRect = {
                cast(LONG)rx, cast(LONG)ry,
                cast(LONG)(rx + rw), cast(LONG)(ry + _titleHeight)
            };
            HBRUSH titleBrush = CreateSolidBrush(_titleBgColor);
            FillRect(hdc, &titleRect, titleBrush);
            DeleteObject(cast(HGDIOBJ)titleBrush);

            // 标题文字
            auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize, FW_BOLD);
            SetTextColor(hdc, _titleTextColor);
            SetBkMode(hdc, TRANSPARENT);
            wstring textW = toUTF16(_title);
            TextOutW(hdc, rx + 8, ry + (_titleHeight - cast(int)_fontSize) / 2,
                     cast(const(PWSTR))textW.ptr, cast(int)textW.length);
            FontCache.release(hdc, fontEntry);

            // 标题栏底部分隔线
            HPEN sepPen = CreatePen(PS_SOLID, 1, _borderColor);
            HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)sepPen);
            MoveToEx(hdc, rx, ry + _titleHeight, null);
            LineTo(hdc, rx + rw, ry + _titleHeight);
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
                RoundRect(hdc, rx, ry, rx + rw, ry + rh,
                          _borderRadius * 2, _borderRadius * 2);
            }
            else
            {
                Rectangle(hdc, rx, ry, rx + rw, ry + rh);
            }

            SelectObject(hdc, oldPen);
            SelectObject(hdc, oldBrush);
            DeleteObject(cast(HGDIOBJ)borderPen);
        }

        // ── 如果启用自动内容尺寸，先计算 ──
        if (_autoSizeContent)
            calcContentSize();

        // ── 计算内容区域 ──
        int contentX = rx + paddingLeft();
        int contentY = ry + _titleHeight + paddingTop();
        int contentW = rw - paddingLeft() - paddingRight() - (_vScroll ? _scrollbarWidth : 0);
        int contentH = rh - _titleHeight - paddingTop() - paddingBottom() - (_hScroll ? _scrollbarWidth : 0);

        // ── 渲染子控件（带滚动裁剪）──
        if (_vScroll || _hScroll)
        {
            int savedDC = SaveDC(hdc);
            IntersectClipRect(hdc, contentX, contentY, contentX + contentW, contentY + contentH);
            POINT oldOrigin;
            // 偏移原点：先到 Panel 位置，再减去滚动偏移
            OffsetViewportOrgEx(hdc, rx - _scrollX, ry - _scrollY, &oldOrigin);

            foreach (child; children())
            {
                if (child.visible())
                    child.renderWithGDI(hdc.Value);
            }

            RestoreDC(hdc, savedDC);

            // ── 绘制滚动条 ──
            if (_vScroll && _contentHeight > contentH)
                drawVScrollbar(hdc, rx, ry + _titleHeight, rw, rh - _titleHeight);
            if (_hScroll && _contentWidth > contentW)
                drawHScrollbar(hdc, rx, ry + _titleHeight, rw, rh - _titleHeight);
        }
        else
        {
            // ── 无滚动，使用 DC 偏移渲染子控件 ──
            int savedDC = SaveDC(hdc);
            POINT oldOrigin;
            OffsetViewportOrgEx(hdc, rx, ry, &oldOrigin);
            
            foreach (child; children())
            {
                if (child.visible())
                    child.renderWithGDI(hdc.Value);
            }
            
            RestoreDC(hdc, savedDC);
        }
    }

    // ── 滚动条绘制 ──

    /// 绘制纵向滚动条
    private void drawVScrollbar(HDC hdc, int rx, int ry, int rw, int rh)
    {
        int trackH = rh - (_hScroll ? _scrollbarWidth : 0);
        int thumbH = cast(int)(cast(float)trackH * rh / _contentHeight);
        if (thumbH < 10) thumbH = 10;

        int maxScroll = _contentHeight - (rh - (_hScroll ? _scrollbarWidth : 0));
        if (maxScroll <= 0) return;

        int sbLeft = rx + rw - _scrollbarWidth;
        int sbTop = ry;

        // ── 轨道 ──
        RECT trackRect = { cast(LONG)sbLeft, cast(LONG)sbTop, cast(LONG)(sbLeft + _scrollbarWidth), cast(LONG)(sbTop + trackH) };
        HBRUSH trackBrush = CreateSolidBrush(_trackColor);
        FillRect(hdc, &trackRect, trackBrush);
        DeleteObject(cast(HGDIOBJ)trackBrush);

        // ── 滑块 ──
        float ratio = cast(float)_scrollY / maxScroll;
        int availableTrack = trackH - thumbH;
        int thumbTop = sbTop + cast(int)(availableTrack * ratio);

        COLORREF thumbCol = _vThumbHovered ? _thumbHoverColor : _thumbColor;
        HBRUSH thumbBrush = CreateSolidBrush(thumbCol);
        RECT thumbRect = { cast(LONG)(sbLeft + 2), cast(LONG)thumbTop, cast(LONG)(sbLeft + _scrollbarWidth - 2), cast(LONG)(thumbTop + thumbH) };
        FillRect(hdc, &thumbRect, thumbBrush);
        DeleteObject(cast(HGDIOBJ)thumbBrush);
    }

    /// 绘制横向滚动条
    private void drawHScrollbar(HDC hdc, int rx, int ry, int rw, int rh)
    {
        int trackW = rw - (_vScroll ? _scrollbarWidth : 0);
        int thumbW = cast(int)(cast(float)trackW * rw / _contentWidth);
        if (thumbW < 10) thumbW = 10;

        int maxScroll = _contentWidth - (rw - (_vScroll ? _scrollbarWidth : 0));
        if (maxScroll <= 0) return;

        int sbLeft = rx;
        int sbTop = ry + rh - _scrollbarWidth;

        // ── 轨道 ──
        RECT trackRect = { cast(LONG)sbLeft, cast(LONG)sbTop, cast(LONG)(sbLeft + trackW), cast(LONG)(sbTop + _scrollbarWidth) };
        HBRUSH trackBrush = CreateSolidBrush(_trackColor);
        FillRect(hdc, &trackRect, trackBrush);
        DeleteObject(cast(HGDIOBJ)trackBrush);

        // ── 滑块 ──
        float ratio = cast(float)_scrollX / maxScroll;
        int availableTrack = trackW - thumbW;
        int thumbLeft = sbLeft + cast(int)(availableTrack * ratio);

        COLORREF thumbCol = _hThumbHovered ? _thumbHoverColor : _thumbColor;
        HBRUSH thumbBrush = CreateSolidBrush(thumbCol);
        RECT thumbRect = { cast(LONG)thumbLeft, cast(LONG)(sbTop + 2), cast(LONG)(thumbLeft + thumbW), cast(LONG)(sbTop + _scrollbarWidth - 2) };
        FillRect(hdc, &thumbRect, thumbBrush);
        DeleteObject(cast(HGDIOBJ)thumbBrush);
    }

    override void render()
    {
    }
}

