module guia4.guicore.label;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

alias LONG = int;

/**
 * Label control — static text display.
 * Not focusable, no interaction.
 */
class Label : Control
{
    private string _text;
    private COLORREF _textColor = cast(COLORREF)0x00000000; // black
    private uint _fontSize = 14;

    this(string text = "Label")
    {
        super();
        _text = text;
        width = 80;
        height = 20;
    }

    this(Control parent, string text)
    {
        super();
        _text = text;
        width = 80;
        height = 20;
        if (parent)
            parent.addChild(this);
    }

    string text() const @property { return _text; }
    void text(string v) { _text = v; markDirty(DirtyBits.Visual); }

    COLORREF textColor() const @property { return _textColor; }
    void textColor(COLORREF v) { _textColor = v; markDirty(DirtyBits.Visual); }

    uint fontSize() const @property { return _fontSize; }
    void fontSize(uint v) { _fontSize = v; markDirty(DirtyBits.Visual); }

    override void renderWithGDI(HDC hdc)
    {
        logTrace("Label.renderWithGDI() - '", _text, "' at (", x(), ",", y(), ")");

        wstring fontName = toUTF16("Segoe UI");
        HFONT font = CreateFontW(cast(int)_fontSize, 0, 0, 0, FW_NORMAL, 0u, 0u, 0u, DEFAULT_CHARSET,
                                OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
                                DEFAULT_PITCH | FF_DONTCARE, cast(const(PWSTR))fontName.ptr);
        HFONT oldFont = cast(HFONT)SelectObject(hdc, cast(HGDIOBJ)font);

        SetTextColor(hdc, _textColor);
        SetBkMode(hdc, TRANSPARENT);

        wstring textW = toUTF16(_text);

        SIZE textSize;
        GetTextExtentPointW(hdc, cast(const(PWSTR))textW.ptr, cast(int)textW.length, &textSize);

        // Render at (x, y) — text flows from top-left
        TextOutW(hdc, cast(int)x(), cast(int)y(), cast(const(PWSTR))textW.ptr, cast(int)textW.length);

        // Auto-size width if not explicitly set
        if (width() == 80 && textSize.cx > 0) // default placeholder width
            width = textSize.cx;
        if (height() == 20)
            height = textSize.cy;

        SelectObject(hdc, cast(HGDIOBJ)oldFont);
        DeleteObject(cast(HGDIOBJ)font);
    }

    override void render()
    {
    }
}
