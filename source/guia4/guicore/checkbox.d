module guia4.guicore.checkbox;

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
 * CheckBox — 复选框控件
 *
 * 带标签的复选按钮，点击切换 checked 状态。
 * 渲染：方框 + 勾号 + 文字
 */
class CheckBox : Control
{
    private string _text;
    private bool _checked = false;
    private bool _hovered = false;

    this(Control parent, string text)
    {
        super(parent);
        _text = text;
        width = 120;
        height = 24;
        focusable = true;
        logTrace("CheckBox.ctor(parent=", parent !is null, ", text='", text, "')");
    }

    // ── 属性 ────────────────────────────────────────────────

    string text() const @property { return _text; }
    void text(string v) @property { _text = v; markDirty(DirtyBits.Visual); }

    bool checked() const @property { return _checked; }
    void checked(bool v) @property { _checked = v; markDirty(DirtyBits.Visual); }

    // ── 鼠标事件 ──────────────────────────────────────────

    override void fireClick(int x, int y)
    {
        _checked = !_checked;
        markDirty(DirtyBits.Visual);
        logTrace("CheckBox.fireClick - '", _text, "' checked=", _checked);
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
        // Space 切换选中状态
        if (keyCode == VK_SPACE)
        {
            _checked = !_checked;
            markDirty(DirtyBits.Visual);
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
        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 作为基准
        logTrace("CheckBox.renderWithGDI() - '", _text, "' size=(", width(), ",", height(), ")");

        int bx = 2;          // 方框左上角 X
        int by = 3;          // 方框左上角 Y
        int boxSize = 16;          // 方框尺寸
        int textX = bx + boxSize + 6; // 文字起始 X

        // 方框颜色
        COLORREF boxBorderColor = _hovered
            ? cast(COLORREF)0x003366FF   // 悬停蓝色
            : cast(COLORREF)0x00888888;  // 默认灰色
        COLORREF boxBgColor = _checked
            ? cast(COLORREF)0x003366FF   // 选中蓝色背景
            : cast(COLORREF)0x00FFFFFF;  // 未选中白色背景

        // 绘制方框背景
        RECT boxRect = {
            cast(LONG)bx, cast(LONG)by,
            cast(LONG)(bx + boxSize), cast(LONG)(by + boxSize)
        };
        HBRUSH boxBrush = CreateSolidBrush(boxBgColor);
        FillRect(hdc, &boxRect, boxBrush);
        DeleteObject(cast(HGDIOBJ)boxBrush);

        // 绘制方框边框
        HPEN boxPen = CreatePen(PS_SOLID, 1, boxBorderColor);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)boxPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, boxRect.left, boxRect.top, boxRect.right, boxRect.bottom);
        SelectObject(hdc, oldBrush);
        SelectObject(hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)boxPen);

        // 如果选中，绘制勾号
        if (_checked)
        {
            HPEN checkPen = CreatePen(PS_SOLID, 2, cast(COLORREF)0x00FFFFFF); // 白色勾号
            HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)checkPen);
            MoveToEx(hdc, bx + 3, by + boxSize / 2, null);
            LineTo(hdc, bx + boxSize / 2 - 1, by + boxSize - 4);
            LineTo(hdc, bx + boxSize - 3, by + 3);
            SelectObject(hdc, oldPen2);
            DeleteObject(cast(HGDIOBJ)checkPen);
        }

        // 绘制文字
        auto fontEntry = FontCache.get(hdc, "Segoe UI", 14);
        SetTextColor(hdc, cast(COLORREF)0x00000000); // 黑色文字
        SetBkMode(hdc, TRANSPARENT);

        wstring textW = toUTF16(_text);
        int textY = (height() - 14) / 2;
        TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);

        FontCache.release(hdc, fontEntry);

        // 焦点指示器
        if (hasFocus())
        {
            HPEN focusPen = CreatePen(PS_DOT, 1, cast(COLORREF)0x00000000);
            HGDIOBJ oldPen3 = SelectObject(hdc, cast(HGDIOBJ)focusPen);
            HGDIOBJ oldBrush3 = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
            Rectangle(hdc, 1, 1, width() - 1, height() - 1);
            SelectObject(hdc, oldBrush3);
            SelectObject(hdc, oldPen3);
            DeleteObject(cast(HGDIOBJ)focusPen);
        }
    }

    override void render()
    {
    }
}