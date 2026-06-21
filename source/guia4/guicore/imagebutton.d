module guia4.guicore.imagebutton;

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
 * ImageButton — 纯图片按钮
 *
 * 继承 Button 的鼠标状态机（pressed/hovered），用图片替代文字渲染。
 * 属性：normalBitmap, hoverBitmap, pressedBitmap
 */
class ImageButton : Control
{
    private HBITMAP _normalBitmap;
    private HBITMAP _hoverBitmap;
    private HBITMAP _pressedBitmap;
    private bool _pressed = false;
    private bool _hovered = false;

    this(Control parent)
    {
        super(parent);
        width = 32;
        height = 32;
        focusable = true;
        logTrace("ImageButton.ctor(parent=", parent !is null, ")");
    }

    // ── 属性 ────────────────────────────────────────────────

    HBITMAP normalBitmap() @property { return _normalBitmap; }
    void normalBitmap(HBITMAP v) @property { _normalBitmap = v; markDirty(); }

    HBITMAP hoverBitmap() @property { return _hoverBitmap; }
    void hoverBitmap(HBITMAP v) @property { _hoverBitmap = v; markDirty(); }

    HBITMAP pressedBitmap() @property { return _pressedBitmap; }
    void pressedBitmap(HBITMAP v) @property { _pressedBitmap = v; markDirty(); }

    // ── 从文件加载位图 ──────────────────────────────────────

    /// 从 BMP 文件加载位图到指定属性
    static HBITMAP loadBitmapFromFile(string path)
    {
        if (path.length == 0)
            return HBITMAP.init;

        wstring wpath = toUTF16(path);
        HANDLE hImg = LoadImageW(
            HINSTANCE.init,
            cast(const(PWSTR))wpath.ptr,
            IMAGE_BITMAP,
            0, 0,
            LR_LOADFROMFILE | LR_DEFAULTSIZE
        );

        if (hImg.Value !is null)
        {
            logTrace("ImageButton.loadBitmapFromFile: loaded '", path, "'");
            return HBITMAP(hImg.Value);
        }
        else
        {
            logWarning("ImageButton.loadBitmapFromFile: failed to load '", path, "'");
            return HBITMAP.init;
        }
    }

    // ── 鼠标事件 ──────────────────────────────────────────

    override void fireMouseDown(int x, int y, int button)
    {
        logTrace("ImageButton.fireMouseDown(x=", x, ", y=", y, ")");
        _pressed = true;
        markDirty();
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        logTrace("ImageButton.fireMouseUp(x=", x, ", y=", y, ")");
        _pressed = false;
        markDirty();
        super.fireMouseUp(x, y, button);
    }

    override void fireClick(int x, int y)
    {
        logTrace("ImageButton.fireClick(x=", x, ", y=", y, ")");
        super.fireClick(x, y);
    }

    override void fireKeyDown(uint keyCode, bool shift = false, bool control = false, bool alt = false)
    {
        // Enter 或 Space 触发点击
        if (keyCode == VK_RETURN || keyCode == VK_SPACE)
        {
            _pressed = true;
            markDirty();
            fireClick(width / 2, height / 2);
            _pressed = false;
            markDirty();
        }
        super.fireKeyDown(keyCode, shift, control, alt);
    }

    override void fireMouseMove(int x, int y)
    {
        if (x < 0 || y < 0)
        {
            // 鼠标离开
            if (_hovered)
            {
                _hovered = false;
                markDirty();
            }
        }
        else
        {
            if (!_hovered)
            {
                _hovered = true;
                markDirty();
            }
        }
        super.fireMouseMove(x, y);
    }

    // ── 渲染 ──────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("ImageButton.renderWithGDI() size=(", width(), ",", height(), ")");

        // 根据状态选择位图
        HBITMAP currentBmp;
        if (_pressed && _pressedBitmap.Value !is null)
            currentBmp = _pressedBitmap;
        else if (_hovered && _hoverBitmap.Value !is null)
            currentBmp = _hoverBitmap;
        else
            currentBmp = _normalBitmap;

        if (currentBmp.Value is null)
            return;

        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 作为基准
        // BitBlt 绘制
        HDC memDC = CreateCompatibleDC(hdc);
        HGDIOBJ oldBmp = SelectObject(memDC, cast(HGDIOBJ)currentBmp);
        BitBlt(hdc, 0, 0, width(), height(), memDC, 0, 0, SRCCOPY);
        SelectObject(memDC, oldBmp);
        DeleteDC(memDC);

        // 焦点指示器
        if (hasFocus())
        {
            HPEN focusPen = CreatePen(PS_DOT, 1, cast(COLORREF)0x00000000);
            HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)focusPen);
            HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
            Rectangle(hdc, 2, 2, width() - 2, height() - 2);
            SelectObject(hdc, oldBrush);
            SelectObject(hdc, oldPen);
            DeleteObject(cast(HGDIOBJ)focusPen);
        }
    }

    override void render()
    {
    }
}
