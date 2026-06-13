module guia4.guicore.button;

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
 * Button control with dlangui-style state machine.
 *
 * Mouse state transitions (orchestrated by MainWindow mouse dispatch):
 *   fireMouseDown(x,y)  → Pressed=true,  visual = pressed
 *   fireMouseUp(x,y)    → Pressed=false, visual = normal/hovered
 *   fireMouseMove(x,y)  → Hovered=true  (if inside bounds)
 *   fireMouseMove(-1,-1) → Hovered=false (cursor left)
 *
 * Click detection is handled at the MainWindow dispatch layer.
 */
class Button : Control
{
    private string _text;
    private bool _pressed = false;
    private bool _hovered = false;

    this(Control parent, string text)
    {
        super(parent);
        logTrace("Button.ctor(parent=", parent !is null, ", text='", text, "')");
        _text = text;
        width = 100;
        height = 30;
        focusable = true;
    }

    string text() const @property { return _text; }
    void text(string v) @property { logTrace("Button.text = '", v, "'"); _text = v; markDirty(DirtyBits.Visual); }

    // ── Mouse event overrides ──────────────────────────────────────────

    override void fireMouseDown(int x, int y, int button)
    {
        logTrace("Button.fireMouseDown(x=", x, ", y=", y, ") - '", _text, "'");
        _pressed = true;
        markDirty(DirtyBits.Visual);
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        logTrace("Button.fireMouseUp(x=", x, ", y=", y, ") - '", _text, "'");
        _pressed = false;
        markDirty(DirtyBits.Visual);
        super.fireMouseUp(x, y, button);
    }

    override void fireClick(int x, int y)
    {
        logTrace("Button.fireClick(x=", x, ", y=", y, ") - '", _text, "' clicked");
        super.fireClick(x, y);
    }

    override void fireKeyDown(uint keyCode, bool shift = false, bool control = false, bool alt = false)
    {
        logTrace("Button.fireKeyDown(keyCode=", keyCode, ") - '", _text, "'");
        // Enter or Space triggers click (same as dlangui behaviour)
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
        // Sentinels: (-1, -1) signals mouse leave, (>=0, >=0) normal move
        if (x < 0 || y < 0)
        {
            // Mouse left this button
            if (_hovered)
            {
                logTrace("Button.fireMouseMove(LEAVE) - '", _text, "'");
                _hovered = false;
                markDirty(DirtyBits.Visual);
            }
        }
        else
        {
            // Normal mouse move (within window) — cursor could be entering or already inside
            if (!_hovered)
            {
                logTrace("Button.fireMouseMove(ENTER) - '", _text, "' at (", x, ",", y, ")");
                _hovered = true;
                markDirty(DirtyBits.Visual);
            }
        }
        super.fireMouseMove(x, y);
    }

    // ── Rendering ──────────────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        // 关键修复：视口已经被 renderChildRecursive 偏移到控件位置，所以使用 (0, 0) 渲染
        logTrace("Button.renderWithGDI() - '", _text, "' size=(", width(), ",", height(), ")");

        // Select colors based on state
        COLORREF bgColor;
        COLORREF borderColor;
        COLORREF textColor = cast(COLORREF)0x00FFFFFF; // white

        if (_pressed)
        {
            bgColor     = cast(COLORREF)0x00444444; // dark grey
            borderColor = cast(COLORREF)0x00222222; // darker grey
        }
        else if (_hovered)
        {
            bgColor     = cast(COLORREF)0x008888FF; // lighter blue
            borderColor = cast(COLORREF)0x005555CC; // medium blue
        }
        else
        {
            bgColor     = cast(COLORREF)0x006666FF; // default blue
            borderColor = cast(COLORREF)0x003333AA; // dark blue
        }

        // 使用 (0, 0) 而不是 position()，因为视口已经偏移
        RECT rect = {
            0, 0,
            cast(LONG)width(), cast(LONG)height()
        };

        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)bgColor);
        HPEN borderPen = CreatePen(PS_SOLID, 2, cast(COLORREF)borderColor);

        HBRUSH oldBrush = cast(HBRUSH)SelectObject(hdc, cast(HGDIOBJ)bgBrush);
        HPEN oldPen = cast(HPEN)SelectObject(hdc, cast(HGDIOBJ)borderPen);

        RoundRect(hdc, rect.left, rect.top, rect.right, rect.bottom, 8, 8);

        SelectObject(hdc, cast(HGDIOBJ)oldBrush);
        SelectObject(hdc, cast(HGDIOBJ)oldPen);
        DeleteObject(cast(HGDIOBJ)bgBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // Draw text
        auto fontEntry = FontCache.get(hdc, "Segoe UI", 14);

        SetTextColor(hdc, cast(COLORREF)textColor);
        SetBkMode(hdc, TRANSPARENT);

        wstring textW = toUTF16(_text);

        SIZE textSize;
        GetTextExtentPointW(hdc, cast(const(PWSTR))textW.ptr, cast(int)textW.length, &textSize);

        int textX = (width() - textSize.cx) / 2;
        int textY = (height() - textSize.cy) / 2;

        TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);

        FontCache.release(hdc, fontEntry);

        // Focus indicator: dotted rectangle around the button when focused
        if (hasFocus())
        {
            HPEN focusPen = CreatePen(PS_DOT, 1, cast(COLORREF)0x00000000); // black dotted
            HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)focusPen);
            HBRUSH oldBrush2 = cast(HBRUSH)SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));

            RECT focusRect = {
                2, 2,
                cast(LONG)(width() - 2), cast(LONG)(height() - 2)
            };
            Rectangle(hdc, focusRect.left, focusRect.top, focusRect.right, focusRect.bottom);

            SelectObject(hdc, cast(HGDIOBJ)oldBrush2);
            SelectObject(hdc, cast(HGDIOBJ)oldPen2);
            DeleteObject(cast(HGDIOBJ)focusPen);
        }
    }

    override void render()
    {
    }
}
