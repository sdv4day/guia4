module guia4.guicore.popup;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.layer;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * Popup — 弹出窗口
 *
 * 浮动面板，可指定位置和大小。
 * 渲染在所有其他控件之上。
 */
class Popup : Control
{
    private bool _isOpen = false;
    private Control _content;
    private COLORREF _bgColor = cast(COLORREF)0x00FFFFFF;
    private COLORREF _borderColor = cast(COLORREF)0x00888888;
    private int _shadowOffset = 3;

    this()
    {
        width = 200;
        height = 150;
        visible = false;
        layer = Layer.Popup;
    }

    /// 弹出窗口是否打开
    bool isOpen() const @property { return _isOpen; }

    /// 在指定位置打开弹出窗口
    void open(int px, int py)
    {
        x(px);
        y(py);
        _isOpen = true;
        visible = true;
        markDirty(DirtyBits.Visual);
    }

    /// 关闭弹出窗口
    void close()
    {
        _isOpen = false;
        visible = false;
        markDirty(DirtyBits.Visual);
    }

    /// 设置内容控件
    void content(Control c) @property
    {
        _content = c;
        if (c)
            addChild(c);
    }

    /// 获取内容控件
    Control content() @property { return _content; }

    override void fireMouseDown(int mx, int my, int button)
    {
        if (!_isOpen)
            return;

        // mx, my 已经是控件本地坐标（由 MainWindow clientToControl 转换）
        // 点击弹出窗口外部 → 关闭
        if (mx < 0 || mx >= width() || my < 0 || my >= height())
        {
            close();
            return;
        }

        // 转发给内容控件
        if (_content)
        {
            _content.fireMouseDown(mx, my, button);
        }
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        if (!_isOpen)
            return;

        logTrace("Popup.renderWithGDI() at (", x(), ",", y(), ")");

        int rx = x();
        int ry = y();
        int rw = width();
        int rh = height();

        // ── 阴影效果（偏移灰色矩形） ──
        RECT shadowRect = {
            cast(LONG)(rx + _shadowOffset), cast(LONG)(ry + _shadowOffset),
            cast(LONG)(rx + rw + _shadowOffset), cast(LONG)(ry + rh + _shadowOffset)
        };
        HBRUSH shadowBrush = CreateSolidBrush(cast(COLORREF)0x00808080);
        FillRect(hdc, &shadowRect, shadowBrush);
        DeleteObject(cast(HGDIOBJ)shadowBrush);

        // ── 白色背景 ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(_bgColor);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── 边框 ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, _borderColor);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, rx, ry, rx + rw, ry + rh);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── 渲染内容控件 ──
        if (_content && _content.visible())
        {
            _content.x(rx);
            _content.y(ry);
            _content.width(rw);
            _content.height(rh);
            _content.renderWithGDI(hdc.Value);
        }
    }

    override void render() {}
}