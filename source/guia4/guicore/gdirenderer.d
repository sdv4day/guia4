module guia4.guicore.gdirenderer;

import guia4.guicore.iplatformrenderer;
import guia4.guicore.color;
import guia4.guicore.theme;
import guia4.utils.logger;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import std.utf;

/**
 * GdiPlatformRenderer — GDI平台渲染器实现
 *
 * 实现IPlatformRenderer接口,封装Win32 GDI操作
 */
class GdiPlatformRenderer : IPlatformRenderer
{
    // ── 资源管理 ─────────────────────────────────────

    void* createBuffer(int width, int height, void* refHandle)
    {
        if (width <= 0 || height <= 0)
            return null;

        HDC refDC = HDC(refHandle);

        auto info = new BufferInfo();
        info.width = width;
        info.height = height;

        // 创建兼容DC和位图
        info.dc = CreateCompatibleDC(refDC);
        info.bitmap = CreateCompatibleBitmap(refDC, width, height);
        info.oldBitmap = SelectObject(info.dc, cast(HGDIOBJ)info.bitmap);

        // 填充背景
        RECT rect = {0, 0, width, height};
        HBRUSH brush = CreateSolidBrush(Theme.crBackground());
        FillRect(info.dc, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);

        return cast(void*)info;
    }

    void destroyBuffer(void* buffer)
    {
        if (buffer is null)
            return;

        auto info = cast(BufferInfo*)buffer;

        if (info.dc.Value !is null)
        {
            if (info.oldBitmap.Value !is null)
                SelectObject(info.dc, info.oldBitmap);
            if (info.bitmap.Value !is null)
                DeleteObject(cast(HGDIOBJ)info.bitmap);
            DeleteDC(info.dc);
        }

        // 释放结构体内存(GC管理)
    }

    void* getBufferDC(void* buffer)
    {
        if (buffer is null)
            return null;

        auto info = cast(BufferInfo*)buffer;
        return info.dc.Value;
    }

    // ── 基础绘图操作 ─────────────────────────────────────

    void fillRect(void* dc, int x, int y, int w, int h, Color color)
    {
        HDC hdc = HDC(dc);
        RECT rect = {x, y, x + w, y + h};
        HBRUSH brush = CreateSolidBrush(color.toCOLORREF());
        FillRect(hdc, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);
    }

    void drawRect(void* dc, int x, int y, int w, int h, Color color)
    {
        HDC hdc = HDC(dc);
        HPEN pen = CreatePen(PS_SOLID, 1, color.toCOLORREF());
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)pen);

        // 绘制矩形边框
        MoveToEx(hdc, x, y, null);
        LineTo(hdc, x + w, y);
        LineTo(hdc, x + w, y + h);
        LineTo(hdc, x, y + h);
        LineTo(hdc, x, y);

        SelectObject(hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    void drawLine(void* dc, int x1, int y1, int x2, int y2, Color color)
    {
        HDC hdc = HDC(dc);
        HPEN pen = CreatePen(PS_SOLID, 1, color.toCOLORREF());
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)pen);

        MoveToEx(hdc, x1, y1, null);
        LineTo(hdc, x2, y2);

        SelectObject(hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    void drawText(void* dc, int x, int y, string text, Color color)
    {
        HDC hdc = HDC(dc);
        SetTextColor(hdc, color.toCOLORREF());
        SetBkMode(hdc, TRANSPARENT);

        auto wtext = toUTF16(text);
        TextOutW(hdc, x, y, cast(const(PWSTR))wtext.ptr, cast(int)wtext.length);
    }

    void measureText(void* dc, string text, out int w, out int h)
    {
        HDC hdc = HDC(dc);
        SIZE size;

        auto wtext = toUTF16(text);
        GetTextExtentPoint32W(hdc, cast(const(PWSTR))wtext.ptr, cast(int)wtext.length, &size);

        w = size.cx;
        h = size.cy;
    }

    // ── 缓冲区操作 ─────────────────────────────────────

    void bitBlt(void* dstDC, int dstX, int dstY,
                void* srcDC, int srcX, int srcY,
                int w, int h)
    {
        HDC hdcDst = HDC(dstDC);
        HDC hdcSrc = HDC(srcDC);

        BitBlt(hdcDst, dstX, dstY, w, h, hdcSrc, srcX, srcY, SRCCOPY);
    }

    void setClipRect(void* dc, int x, int y, int w, int h)
    {
        HDC hdc = HDC(dc);
        IntersectClipRect(hdc, x, y, x + w, y + h);
    }

    void clearClipRect(void* dc)
    {
        HDC hdc = HDC(dc);
        // GDI没有直接清除裁剪区域的API,需要保存/恢复DC状态
        // 这里简化实现,实际使用时应该配合SaveDC/RestoreDC
    }

    // ── 字体管理 ─────────────────────────────────────

    void setFont(void* dc, uint fontSize, uint fontWeight = 400)
    {
        HDC hdc = HDC(dc);

        LOGFONTW lf;
        lf.lfHeight = -cast(int)fontSize;
        lf.lfWeight = cast(int)fontWeight;
        lf.lfCharSet = DEFAULT_CHARSET;
        lf.lfOutPrecision = OUT_DEFAULT_PRECIS;
        lf.lfClipPrecision = CLIP_DEFAULT_PRECIS;
        lf.lfQuality = DEFAULT_QUALITY;
        lf.lfPitchAndFamily = DEFAULT_PITCH | FF_DONTCARE;

        // 使用默认字体名称
        auto fontName = "Microsoft YaHei"w;
        lf.lfFaceName[0 .. fontName.length] = fontName[];

        HFONT font = CreateFontIndirectW(&lf);
        HGDIOBJ oldFont = SelectObject(hdc, cast(HGDIOBJ)font);

        // 注意:这里没有删除旧字体,调用者负责管理字体生命周期
        // 在实际使用中,应该使用字体缓存来管理字体对象
    }
}

private struct BufferInfo
{
    HDC dc;
    HBITMAP bitmap;
    HGDIOBJ oldBitmap;
    int width;
    int height;
}
