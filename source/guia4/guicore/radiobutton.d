module guia4.guicore.radiobutton;

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
 * RadioButton — 单选按钮控件
 *
 * 带标签的单选按钮，同一 groupId 内只能选中一个。
 * 渲染：圆圈 + 实心点 + 文字
 */
class RadioButton : Control
{
    private string _text;
    private bool _checked = false;
    private int _groupId = 0;
    private bool _hovered = false;

    this(string text = "Radio")
    {
        super();
        _text = text;
        width = 120;
        height = 24;
        focusable = true;
        logTrace("RadioButton.ctor(text='", text, "')");
    }

    this(Control parent, string text)
    {
        super();
        _text = text;
        width = 120;
        height = 24;
        focusable = true;
        if (parent)
            parent.addChild(this);
        logTrace("RadioButton.ctor(parent=", parent !is null, ", text='", text, "')");
    }

    // ── 属性 ────────────────────────────────────────────────

    string text() const @property { return _text; }
    void text(string v) @property { _text = v; markDirty(DirtyBits.Visual); }

    bool checked() const @property { return _checked; }

    void checked(bool v) @property
    {
        _checked = v;
        if (v)
            uncheckSiblings();
        markDirty(DirtyBits.Visual);
    }

    int groupId() const @property { return _groupId; }
    void groupId(int v) @property { _groupId = v; markDirty(DirtyBits.Visual); }

    // ── 取消同组其他选中 ──────────────────────────────────

    private void uncheckSiblings()
    {
        if (parent() is null)
            return;

        foreach (child; parent().children())
        {
            RadioButton rb = cast(RadioButton)child;
            if (rb !is null && rb !is this && rb.groupId() == _groupId && rb.checked())
            {
                rb._checked = false;
                rb.markDirty(DirtyBits.Visual);
            }
        }
    }

    // ── 鼠标事件 ──────────────────────────────────────────

    override void fireClick(int x, int y)
    {
        if (!_checked)
        {
            checked = true; // 触发 uncheckSiblings
        }
        logTrace("RadioButton.fireClick - '", _text, "' checked=", _checked);
        super.fireClick(x, y);
    }

    override void fireMouseDown(int x, int y, int button)
    {
        markDirty(DirtyBits.Visual);
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        markDirty(DirtyBits.Visual);
        super.fireMouseUp(x, y, button);
    }

    override void fireKeyDown(uint keyCode, bool shift = false, bool control = false, bool alt = false)
    {
        // Space 选中
        if (keyCode == VK_SPACE)
        {
            if (!_checked)
            {
                checked = true;
            }
            fireClick(width / 2, height / 2);
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
        logTrace("RadioButton.renderWithGDI() - '", _text, "' at (", x(), ",", y(), ")");

        int cx = x() + 10;         // 圆圈中心 X
        int cy = y() + height() / 2; // 圆圈中心 Y
        int radius = 7;            // 圆圈半径
        int textX = cx + radius + 6; // 文字起始 X

        // 圆圈颜色
        COLORREF circleBorderColor = _hovered
            ? cast(COLORREF)0x003366FF   // 悬停蓝色
            : cast(COLORREF)0x00888888;  // 默认灰色

        // 绘制圆圈边框
        HPEN circlePen = CreatePen(PS_SOLID, 1, circleBorderColor);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)circlePen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Ellipse(hdc, cx - radius, cy - radius, cx + radius, cy + radius);
        SelectObject(hdc, oldBrush);
        SelectObject(hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)circlePen);

        // 如果选中，绘制实心点
        if (_checked)
        {
            int dotRadius = 4;
            HBRUSH dotBrush = CreateSolidBrush(cast(COLORREF)0x003366FF);
            HPEN dotPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x003366FF);
            HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)dotPen);
            HGDIOBJ oldBrush2 = SelectObject(hdc, cast(HGDIOBJ)dotBrush);
            Ellipse(hdc, cx - dotRadius, cy - dotRadius, cx + dotRadius, cy + dotRadius);
            SelectObject(hdc, oldBrush2);
            SelectObject(hdc, oldPen2);
            DeleteObject(cast(HGDIOBJ)dotBrush);
            DeleteObject(cast(HGDIOBJ)dotPen);
        }

        // 绘制文字
        auto fontEntry = FontCache.get(hdc, "Segoe UI", 14);
        SetTextColor(hdc, cast(COLORREF)0x00000000); // 黑色文字
        SetBkMode(hdc, TRANSPARENT);

        wstring textW = toUTF16(_text);
        int textY = y() + (height() - 14) / 2;
        TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);

        FontCache.release(hdc, fontEntry);

        // 焦点指示器
        if (hasFocus())
        {
            HPEN focusPen = CreatePen(PS_DOT, 1, cast(COLORREF)0x00000000);
            HGDIOBJ oldPen3 = SelectObject(hdc, cast(HGDIOBJ)focusPen);
            HGDIOBJ oldBrush3 = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
            Rectangle(hdc, x() + 1, y() + 1, x() + width() - 1, y() + height() - 1);
            SelectObject(hdc, oldBrush3);
            SelectObject(hdc, oldPen3);
            DeleteObject(cast(HGDIOBJ)focusPen);
        }
    }

    override void render()
    {
    }
}