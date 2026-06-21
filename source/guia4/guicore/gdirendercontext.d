module guia4.guicore.gdirendercontext;

import guia4.guicore.irendercontext;
import guia4.guicore.color;
import guia4.guicore.theme;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import std.utf;

/**
 * GdiRenderContext — GDI 渲染上下文实现
 *
 * 封装所有 Win32 GDI 操作，实现 IRenderContext 接口。
 * 控件通过此接口渲染，不直接调用 GDI API。
 */
class GdiRenderContext : IRenderContext
{
    private HDC _hdc;
    private int _width;
    private int _height;
    private int _fontCounter = 0;

    // 状态栈
    private struct State
    {
        HFONT font;
        int clipActive;
    }
    private State[] _stateStack;

    this(HDC hdc, int width, int height)
    {
        _hdc = hdc;
        _width = width;
        _height = height;
    }

    // ── 尺寸 ──────────────────────────────────────────────

    int width() const { return _width; }
    int height() const { return _height; }

    /// 获取原生 HDC（内部使用）
    HDC hdc() { return _hdc; }

    // ── 绘图基元 ─────────────────────────────────────────

    void fillRect(int x, int y, int w, int h, Color color)
    {
        RECT r = {x, y, x + w, y + h};
        HBRUSH brush = CreateSolidBrush(COLORREF(color.toBGR()));
        FillRect(_hdc, &r, brush);
        DeleteObject(cast(HGDIOBJ)brush);
    }

    void drawRect(int x, int y, int w, int h, Color color, int lineWidth = 1)
    {
        HPEN pen = CreatePen(PS_SOLID, lineWidth, COLORREF(color.toBGR()));
        HGDIOBJ oldPen = SelectObject(_hdc, cast(HGDIOBJ)pen);
        HGDIOBJ oldBrush = SelectObject(_hdc, cast(HGDIOBJ)GetStockObject(NULL_BRUSH));
        Rectangle(_hdc, x, y, x + w, y + h);
        SelectObject(_hdc, oldBrush);
        SelectObject(_hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    void drawRoundRect(int x, int y, int w, int h, int radius, Color color, int lineWidth = 1)
    {
        HPEN pen = CreatePen(PS_SOLID, lineWidth, COLORREF(color.toBGR()));
        HGDIOBJ oldPen = SelectObject(_hdc, cast(HGDIOBJ)pen);
        HGDIOBJ oldBrush = SelectObject(_hdc, cast(HGDIOBJ)GetStockObject(NULL_BRUSH));
        RoundRect(_hdc, x, y, x + w, y + h, radius * 2, radius * 2);
        SelectObject(_hdc, oldBrush);
        SelectObject(_hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    void fillRoundRect(int x, int y, int w, int h, int radius, Color color)
    {
        HBRUSH brush = CreateSolidBrush(COLORREF(color.toBGR()));
        HGDIOBJ oldBrush = SelectObject(_hdc, cast(HGDIOBJ)brush);
        HPEN pen = CreatePen(PS_SOLID, 1, COLORREF(color.toBGR()));
        HGDIOBJ oldPen = SelectObject(_hdc, cast(HGDIOBJ)pen);
        RoundRect(_hdc, x, y, x + w, y + h, radius * 2, radius * 2);
        SelectObject(_hdc, oldPen);
        SelectObject(_hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)pen);
        DeleteObject(cast(HGDIOBJ)brush);
    }

    void drawEllipse(int x, int y, int w, int h, Color color, int lineWidth = 1)
    {
        HPEN pen = CreatePen(PS_SOLID, lineWidth, COLORREF(color.toBGR()));
        HGDIOBJ oldPen = SelectObject(_hdc, cast(HGDIOBJ)pen);
        HGDIOBJ oldBrush = SelectObject(_hdc, cast(HGDIOBJ)GetStockObject(NULL_BRUSH));
        Ellipse(_hdc, x, y, x + w, y + h);
        SelectObject(_hdc, oldBrush);
        SelectObject(_hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    void fillEllipse(int x, int y, int w, int h, Color color)
    {
        HBRUSH brush = CreateSolidBrush(COLORREF(color.toBGR()));
        HGDIOBJ oldBrush = SelectObject(_hdc, cast(HGDIOBJ)brush);
        HPEN pen = CreatePen(PS_SOLID, 1, COLORREF(color.toBGR()));
        HGDIOBJ oldPen = SelectObject(_hdc, cast(HGDIOBJ)pen);
        Ellipse(_hdc, x, y, x + w, y + h);
        SelectObject(_hdc, oldPen);
        SelectObject(_hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)pen);
        DeleteObject(cast(HGDIOBJ)brush);
    }

    void drawLine(int x1, int y1, int x2, int y2, Color color, int lineWidth = 1)
    {
        HPEN pen = CreatePen(PS_SOLID, lineWidth, COLORREF(color.toBGR()));
        HGDIOBJ oldPen = SelectObject(_hdc, cast(HGDIOBJ)pen);
        MoveToEx(_hdc, x1, y1, null);
        LineTo(_hdc, x2, y2);
        SelectObject(_hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    void drawPolyline(int[] points, Color color, int lineWidth = 1)
    {
        if (points.length < 4) return; // 至少2个点 (x1,y1,x2,y2)
        HPEN pen = CreatePen(PS_SOLID, lineWidth, COLORREF(color.toBGR()));
        HGDIOBJ oldPen = SelectObject(_hdc, cast(HGDIOBJ)pen);
        MoveToEx(_hdc, points[0], points[1], null);
        for (size_t i = 2; i + 1 < points.length; i += 2)
            LineTo(_hdc, points[i], points[i + 1]);
        SelectObject(_hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    // ── 文本操作 ─────────────────────────────────────────

    int setFont(string family, int size, int weight = 400)
    {
        LOGFONTW lf;
        lf.lfHeight = -size;
        lf.lfWeight = weight;
        lf.lfCharSet = DEFAULT_CHARSET;
        lf.lfOutPrecision = OUT_DEFAULT_PRECIS;
        lf.lfClipPrecision = CLIP_DEFAULT_PRECIS;
        lf.lfQuality = DEFAULT_QUALITY;
        lf.lfPitchAndFamily = DEFAULT_PITCH | FF_DONTCARE;

        auto wfamily = toUTF16(family);
        if (wfamily.length > 31) wfamily = wfamily[0 .. 31];
        lf.lfFaceName[0 .. wfamily.length] = wfamily[];

        HFONT font = CreateFontIndirectW(&lf);
        SelectObject(_hdc, cast(HGDIOBJ)font);

        _fontCounter++;
        return _fontCounter;
    }

    void restoreFont(int fontId)
    {
        // 简化实现：恢复默认字体
        SelectObject(_hdc, GetStockObject(DEFAULT_GUI_FONT));
    }

    void drawText(int x, int y, string text, Color color)
    {
        SetTextColor(_hdc, COLORREF(color.toBGR()));
        SetBkMode(_hdc, TRANSPARENT);
        auto wtext = toUTF16(text);
        TextOutW(_hdc, x, y, cast(const(PWSTR))wtext.ptr, cast(int)wtext.length);
    }

    void measureText(string text, out int w, out int h)
    {
        SIZE size;
        auto wtext = toUTF16(text);
        GetTextExtentPoint32W(_hdc, cast(const(PWSTR))wtext.ptr, cast(int)wtext.length, &size);
        w = size.cx;
        h = size.cy;
    }

    void measureChar(dchar ch, out int w, out int h)
    {
        char[4] buf;
        size_t len = encode(buf, ch);
        wstring ws = (cast(wchar*)buf)[0 .. len / 2].idup;
        SIZE size;
        GetTextExtentPoint32W(_hdc, cast(const(PWSTR))ws.ptr, cast(int)ws.length, &size);
        w = size.cx;
        h = size.cy;
    }

    // ── 状态管理 ─────────────────────────────────────────

    int saveState()
    {
        int id = SaveDC(_hdc);
        return id;
    }

    void restoreState(int stateId)
    {
        RestoreDC(_hdc, stateId);
    }

    void setClipRect(int x, int y, int w, int h)
    {
        HRGN rgn = CreateRectRgn(x, y, x + w, y + h);
        SelectClipRgn(_hdc, rgn);
        DeleteObject(cast(HGDIOBJ)rgn);
    }

    void clearClipRect()
    {
        SelectClipRgn(_hdc, HRGN.init);
    }

    void setViewportOrigin(int x, int y)
    {
        POINT old;
        OffsetViewportOrgEx(_hdc, x, y, &old);
    }

    void resetViewportOrigin()
    {
        SetViewportOrgEx(_hdc, 0, 0, null);
    }

    // ── 位图操作 ─────────────────────────────────────────

    void* createCompatibleDC()
    {
        HDC dc = CreateCompatibleDC(_hdc);
        return dc.Value;
    }

    void releaseCompatibleDC(void* dc)
    {
        DeleteDC(HDC(dc));
    }

    void* createCompatibleBitmap(void* dc, int w, int h)
    {
        HBITMAP bmp = CreateCompatibleBitmap(HDC(dc), w, h);
        return bmp.Value;
    }

    void releaseBitmap(void* bmp)
    {
        DeleteObject(cast(HGDIOBJ)HBITMAP(bmp));
    }

    void* selectBitmap(void* dc, void* bmp)
    {
        HGDIOBJ old = SelectObject(HDC(dc), cast(HGDIOBJ)HBITMAP(bmp));
        return old.Value;
    }

    void bitBlt(void* dstDC, int dstX, int dstY, int dstW, int dstH,
                void* srcDC, int srcX, int srcY)
    {
        BitBlt(HDC(dstDC), dstX, dstY, dstW, dstH,
               HDC(srcDC), srcX, srcY, SRCCOPY);
    }

    // ── 裁剪区域（高级）──────────────────────────────────

    void* createClipRegion(int x, int y, int w, int h)
    {
        HRGN rgn = CreateRectRgn(x, y, x + w, y + h);
        return rgn.Value;
    }

    void applyClipRegion(void* region)
    {
        SelectClipRgn(_hdc, HRGN(region));
    }

    void releaseClipRegion(void* region)
    {
        DeleteObject(cast(HGDIOBJ)region);
    }
}
