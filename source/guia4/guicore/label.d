module guia4.guicore.label;

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
 * Label control — static text display.
 * Not focusable, no interaction.
 */
class Label : Control
{
    private string _text;
    private COLORREF _textColor = cast(COLORREF)0x00000000; // black
    private uint _fontSize = 14;
    private bool _autoSize = true;

    this(Control parent, string text)
    {
        super(parent);
        _text = text;
        width = 80;
        height = 20;
    }

    string text() const @property { return _text; }
    void text(string v) @property { _text = v; markDirty(DirtyBits.Visual); }

    COLORREF textColor() const @property { return _textColor; }
    void textColor(uint v) @property { _textColor = COLORREF(v); markDirty(DirtyBits.Visual); }

    uint fontSize() const @property { return _fontSize; }
    void fontSize(uint v) @property { _fontSize = v; markDirty(DirtyBits.Visual); }

    bool autoSize() const @property { return _autoSize; }
    void autoSize(bool v) @property { _autoSize = v; markDirty(DirtyBits.Visual); }

    /// 计算文本自动尺寸（在布局阶段调用，不在渲染阶段修改控件状态）
    void measure(void* hdc_)
    {
        if (!_autoSize) return;
        auto hdc = cast(HDC)hdc_;
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);

        wstring textW = toUTF16(_text);
        SIZE textSize;
        GetTextExtentPointW(hdc, cast(const(PWSTR))textW.ptr, cast(int)textW.length, &textSize);

        FontCache.release(hdc, fontEntry);

        width = textSize.cx;
        height = textSize.cy;
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("Label.renderWithGDI() - '", _text, "' size=(", width(), ",", height(), ")");

        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);

        SetTextColor(hdc, _textColor);
        SetBkMode(hdc, TRANSPARENT);

        wstring textW = toUTF16(_text);

        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 而不是 position()
        TextOutW(hdc, 0, 0, cast(const(PWSTR))textW.ptr, cast(int)textW.length);

        // 注意：自动尺寸由 measure() 在布局阶段计算，renderWithGDI 不再修改 width/height

        FontCache.release(hdc, fontEntry);
    }

    override void render()
    {
    }
}
