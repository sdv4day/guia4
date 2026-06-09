module guia4.guicore.textimagebutton;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * TextImageButton — 图标+文字按钮
 *
 * 继承 Button 的鼠标状态机，同时渲染图标和文字。
 * 属性：text, icon (HBITMAP), iconWidth, iconHeight
 */
class TextImageButton : Control
{
    private string _text;
    private HBITMAP _icon;
    private int _iconWidth = 16;
    private int _iconHeight = 16;
    private bool _pressed = false;
    private bool _hovered = false;

    this(string text = "Button")
    {
        super();
        _text = text;
        width = 120;
        height = 30;
        focusable = true;
        logTrace("TextImageButton.ctor(text='", text, "')");
    }

    this(Control parent, string text)
    {
        super();
        _text = text;
        width = 120;
        height = 30;
        focusable = true;
        if (parent)
            parent.addChild(this);
        logTrace("TextImageButton.ctor(parent=", parent !is null, ", text='", text, "')");
    }

    // ── 属性 ────────────────────────────────────────────────

    string text() const @property { return _text; }
    void text(string v) @property { _text = v; markDirty(DirtyBits.Visual); }

    HBITMAP icon() @property { return _icon; }
    void icon(HBITMAP v) @property { _icon = v; markDirty(DirtyBits.Visual); }

    int iconWidth() const @property { return _iconWidth; }
    void iconWidth(int v) @property { _iconWidth = v; markDirty(DirtyBits.Visual); }

    int iconHeight() const @property { return _iconHeight; }
    void iconHeight(int v) @property { _iconHeight = v; markDirty(DirtyBits.Visual); }

    // ── 鼠标事件 ──────────────────────────────────────────

    override void fireMouseDown(int x, int y, int button)
    {
        logTrace("TextImageButton.fireMouseDown - '", _text, "'");
        _pressed = true;
        markDirty(DirtyBits.Visual);
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        logTrace("TextImageButton.fireMouseUp - '", _text, "'");
        _pressed = false;
        markDirty(DirtyBits.Visual);
        super.fireMouseUp(x, y, button);
    }

    override void fireClick(int x, int y)
    {
        logTrace("TextImageButton.fireClick - '", _text, "'");
        super.fireClick(x, y);
    }

    override void fireKeyDown(uint keyCode, bool shift = false, bool control = false, bool alt = false)
    {
        if (keyCode == VK_RETURN || keyCode == VK_SPACE)
        {
            _pressed = true;
            markDirty(DirtyBits.Visual);
            fireClick(width / 2, height / 2);
            _pressed = false;
            markDirty(DirtyBits.Visual);
        }
        super.fireKeyDown(keyCode, shift, control, alt);
    }

    override void fireMouseMove(int x, int y)
    {
        if (x < 0 || y < 0)
        {
            if (_hovered)
            {
                _hovered = false;
                markDirty(DirtyBits.Visual);
            }
        }
        else
        {
            if (!_hovered)
            {
                _hovered = true;
                markDirty(DirtyBits.Visual);
            }
        }
        super.fireMouseMove(x, y);
    }

    // ── 渲染 ──────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("TextImageButton.renderWithGDI() - '", _text, "' at (", x(), ",", y(), ")");

        // 选择颜色
        COLORREF bgColor;
        COLORREF borderColor;
        COLORREF textColor = cast(COLORREF)0x00FFFFFF; // 白色

        if (_pressed)
        {
            bgColor     = cast(COLORREF)0x00444444;
            borderColor = cast(COLORREF)0x00222222;
        }
        else if (_hovered)
        {
            bgColor     = cast(COLORREF)0x008888FF;
            borderColor = cast(COLORREF)0x005555CC;
        }
        else
        {
            bgColor     = cast(COLORREF)0x006666FF;
            borderColor = cast(COLORREF)0x003333AA;
        }

        // 绘制按钮背景（RoundRect）
        RECT rect = {
            cast(LONG)x(), cast(LONG)y(),
            cast(LONG)(x() + width()), cast(LONG)(y() + height())
        };

        HBRUSH bgBrush = CreateSolidBrush(bgColor);
        HPEN borderPen = CreatePen(PS_SOLID, 2, borderColor);
        HBRUSH oldBrush = cast(HBRUSH)SelectObject(hdc, cast(HGDIOBJ)bgBrush);
        HPEN oldPen = cast(HPEN)SelectObject(hdc, cast(HGDIOBJ)borderPen);
        RoundRect(hdc, rect.left, rect.top, rect.right, rect.bottom, 8, 8);
        SelectObject(hdc, cast(HGDIOBJ)oldBrush);
        SelectObject(hdc, cast(HGDIOBJ)oldPen);
        DeleteObject(cast(HGDIOBJ)bgBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        int contentX = x() + 8; // 左侧内边距

        // 绘制图标
        if (_icon.Value !is null)
        {
            HDC memDC = CreateCompatibleDC(hdc);
            HGDIOBJ oldBmp = SelectObject(memDC, cast(HGDIOBJ)_icon);
            int iconY = y() + (height() - _iconHeight) / 2;
            BitBlt(hdc, contentX, iconY, _iconWidth, _iconHeight, memDC, 0, 0, SRCCOPY);
            SelectObject(memDC, oldBmp);
            DeleteDC(memDC);
            contentX += _iconWidth + 4; // 图标后间距
        }

        // 绘制文字
        auto fontEntry = FontCache.get(hdc, "Segoe UI", 14);
        SetTextColor(hdc, textColor);
        SetBkMode(hdc, TRANSPARENT);

        wstring textW = toUTF16(_text);
        SIZE textSize;
        GetTextExtentPointW(hdc, cast(const(PWSTR))textW.ptr, cast(int)textW.length, &textSize);

        int textX = contentX;
        int textY = y() + (height() - textSize.cy) / 2;
        TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);

        FontCache.release(hdc, fontEntry);

        // 焦点指示器
        if (hasFocus())
        {
            HPEN focusPen = CreatePen(PS_DOT, 1, cast(COLORREF)0x00000000);
            HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)focusPen);
            HGDIOBJ oldBrush2 = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
            Rectangle(hdc, x() + 2, y() + 2, x() + width() - 2, y() + height() - 2);
            SelectObject(hdc, oldBrush2);
            SelectObject(hdc, oldPen2);
            DeleteObject(cast(HGDIOBJ)focusPen);
        }
    }

    override void render()
    {
    }
}