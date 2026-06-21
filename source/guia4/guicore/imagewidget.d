module guia4.guicore.imagewidget;

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
 * ImageWidget — 静态图片控件
 *
 * 从 BMP 文件加载图片（HBITMAP），用 BitBlt 绘制。
 * 属性：filePath, bitmap, autoSize
 */
class ImageWidget : Control
{
    private string _filePath;
    private HBITMAP _bitmap;
    private bool _autoSize = true;

    this(Control parent, string filePath)
    {
        super(parent);
        width = 64;
        height = 64;
        if (filePath.length > 0)
            loadBitmap(filePath);
        logTrace("ImageWidget.ctor(parent=", parent !is null, ", filePath='", filePath, "')");
    }

    // ── 属性 ────────────────────────────────────────────────

    string filePath() const @property { return _filePath; }

    void filePath(string v) @property
    {
        if (_filePath != v)
        {
            _filePath = v;
            loadBitmap(v);
        }
    }

    HBITMAP bitmap() @property { return _bitmap; }

    void bitmap(HBITMAP v) @property
    {
        if (_bitmap.Value !is null && _bitmap.Value != v.Value)
            DeleteObject(cast(HGDIOBJ)_bitmap);
        _bitmap = v;
        markDirty();
    }

    bool autoSize() const @property { return _autoSize; }
    void autoSize(bool v) @property { _autoSize = v; markDirty(); }

    // ── 加载 BMP ──────────────────────────────────────────

    ~this()
    {
        if (_bitmap.Value !is null)
            DeleteObject(cast(HGDIOBJ)_bitmap);
    }

    private void loadBitmap(string path)
    {
        if (path.length == 0)
        {
            if (_bitmap.Value !is null)
                DeleteObject(cast(HGDIOBJ)_bitmap);
            _bitmap = HBITMAP.init;
            markDirty();
            return;
        }

        wstring wpath = toUTF16(path);

        // 使用 LoadImageW 加载 BMP 文件
        HANDLE hImg = LoadImageW(
            HINSTANCE.init,
            cast(const(PWSTR))wpath.ptr,
            IMAGE_BITMAP,
            0, 0,
            LR_LOADFROMFILE | LR_DEFAULTSIZE
        );

        if (hImg.Value !is null)
        {
            if (_bitmap.Value !is null)
                DeleteObject(cast(HGDIOBJ)_bitmap);
            _bitmap = HBITMAP(hImg.Value);
            logTrace("ImageWidget.loadBitmap: loaded '", path, "'");

            // 如果 autoSize，获取位图尺寸
            if (_autoSize)
            {
                // BITMAP 结构获取尺寸
                BITMAP bm;
                GetObjectW(cast(HGDIOBJ)_bitmap, BITMAP.sizeof, &bm);
                width = bm.bmWidth;
                height = bm.bmHeight;
            }
        }
        else
        {
            _bitmap = HBITMAP.init;
            logWarning("ImageWidget.loadBitmap: failed to load '", path, "'");
        }

        markDirty();
    }

    // ── 渲染 ──────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("ImageWidget.renderWithGDI() size=(", width(), ",", height(), ")");

        if (_bitmap.Value is null)
            return;

        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 作为基准
        // 创建兼容内存 DC，选入位图，BitBlt 绘制
        HDC memDC = CreateCompatibleDC(hdc);
        HGDIOBJ oldBmp = SelectObject(memDC, cast(HGDIOBJ)_bitmap);
        BitBlt(hdc, 0, 0, width(), height(), memDC, 0, 0, SRCCOPY);
        SelectObject(memDC, oldBmp);
        DeleteDC(memDC);
    }

    override void render()
    {
    }
}
