module guia4.guicore.gdirendercontext;

import guia4.guicore.irendercontext;
import guia4.guicore.color;
import guia4.guicore.theme;

version (Windows)
{
    import core.sys.windows.windows;
    import core.sys.windows.wingdi;
}

/**
 * GdiRenderContext — GDI 渲染上下文实现
 *
 * 封装 Win32 GDI 操作，实现 IRenderContext 接口。
 * 所有 GDI 特定代码都集中在此模块中。
 */
class GdiRenderContext : IRenderContext
{
    private HDC _hdc;
    private int _width;
    private int _height;

    // Layer buffer
    private HDC _layerDC;
    private HBITMAP _layerBmp;
    private HGDIOBJ _layerOldBmp;
    private int _layerWidth;
    private int _layerHeight;

    this(HDC hdc, int width, int height)
    {
        _hdc = hdc;
        _width = width;
        _height = height;
    }

    // ── IRenderContext 实现 ─────────────────────────────────────

    void* nativeHandle() { return cast(void*)_hdc; }

    int width() const { return _width; }
    int height() const { return _height; }

    void fillRect(int x, int y, int w, int h, Color color)
    {
        RECT r;
        r.left = x;
        r.top = y;
        r.right = x + w;
        r.bottom = y + h;
        HBRUSH brush = CreateSolidBrush(color.toCOLORREF().Value);
        FillRect(_hdc, &r, brush);
        DeleteObject(cast(HGDIOBJ)brush);
    }

    void drawRect(int x, int y, int w, int h, Color color)
    {
        HPEN pen = CreatePen(PS_SOLID, 1, color.toCOLORREF().Value);
        HGDIOBJ oldPen = SelectObject(_hdc, cast(HGDIOBJ)pen);
        HGDIOBJ oldBrush = SelectObject(_hdc, cast(HGDIOBJ)GetStockObject(NULL_BRUSH));
        Rectangle(_hdc, x, y, x + w, y + h);
        SelectObject(_hdc, oldBrush);
        SelectObject(_hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    void drawLine(int x1, int y1, int x2, int y2, Color color)
    {
        HPEN pen = CreatePen(PS_SOLID, 1, color.toCOLORREF().Value);
        HGDIOBJ oldPen = SelectObject(_hdc, cast(HGDIOBJ)pen);
        MoveToEx(_hdc, x1, y1, null);
        LineTo(_hdc, x2, y2);
        SelectObject(_hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    void drawText(int x, int y, string text, Color color)
    {
        SetTextColor(_hdc, color.toCOLORREF().Value);
        SetBkMode(_hdc, TRANSPARENT);
        TextOutA(_hdc, x, y, text.ptr, cast(int)text.length);
    }

    void measureText(string text, out int w, out int h)
    {
        SIZE size;
        GetTextExtentPoint32A(_hdc, text.ptr, cast(int)text.length, &size);
        w = size.cx;
        h = size.cy;
    }

    // ── Layer Buffer 管理 ───────────────────────────────────────

    void createLayerBuffer(void* refHandle, int w, int h)
    {
        HDC refDC = cast(HDC)refHandle;

        // 销毁旧的 layer buffer
        destroyLayerBuffer();

        _layerDC = CreateCompatibleDC(refDC);
        _layerBmp = CreateCompatibleBitmap(refDC, w, h);
        _layerOldBmp = SelectObject(_layerDC, cast(HGDIOBJ)_layerBmp);
        _layerWidth = w;
        _layerHeight = h;

        // 清空为白色背景
        RECT r = {0, 0, w, h};
        HBRUSH brush = CreateSolidBrush(Theme.crBackground().Value);
        FillRect(_layerDC, &r, brush);
        DeleteObject(cast(HGDIOBJ)brush);
    }

    void destroyLayerBuffer()
    {
        if (_layerOldBmp !is null)
        {
            SelectObject(_layerDC, _layerOldBmp);
            _layerOldBmp = null;
        }
        if (_layerBmp !is null)
        {
            DeleteObject(cast(HGDIOBJ)_layerBmp);
            _layerBmp = null;
        }
        if (_layerDC !is null)
        {
            DeleteDC(_layerDC);
            _layerDC = null;
        }
        _layerWidth = 0;
        _layerHeight = 0;
    }

    void* layerBufferHandle()
    {
        return cast(void*)_layerDC;
    }

    void blitToTarget(int srcX, int srcY, int srcW, int srcH, int dstX, int dstY)
    {
        if (_layerDC is null) return;
        BitBlt(_hdc, dstX, dstY, srcW, srcH, _layerDC, srcX, srcY, SRCCOPY);
    }

    // ── 裁剪区域 ─────────────────────────────────────────────────

    void setClipRect(int x, int y, int w, int h)
    {
        HRGN clipRgn = CreateRectRgn(x, y, x + w, y + h);
        SelectClipRgn(_hdc, clipRgn);
        DeleteObject(cast(HGDIOBJ)clipRgn);
    }

    void clearClipRect()
    {
        SelectClipRgn(_hdc, null);
    }

    // ── GDI 特定方法 ─────────────────────────────────────────────

    /// 获取 HDC（用于需要直接访问 GDI 的场景）
    HDC hdc() { return _hdc; }

    /// 获取 layer buffer 的 HDC
    HDC layerHDC() { return _layerDC; }

    /// 设置字体
    void setFont(HFONT font)
    {
        SelectObject(_hdc, cast(HGDIOBJ)font);
    }

    /// 设置 layer buffer 字体
    void setLayerFont(HFONT font)
    {
        if (_layerDC !is null)
            SelectObject(_layerDC, cast(HGDIOBJ)font);
    }
}
