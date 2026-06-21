module guia4.guicore.gdifont;

import guia4.guicore.font;
import guia4.guicore.color;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import std.utf;
import std.conv : to;

/**
 * GdiFont — GDI 字体实现
 */
class GdiFont : IFont
{
    private string _family;
    private int _size;
    private int _weight;
    private HFONT _handle;

    this(string family, int size, int weight)
    {
        _family = family;
        _size = size;
        _weight = weight;
        _handle = createFont(family, size, weight);
    }

    ~this()
    {
        if (_handle.Value !is null)
            DeleteObject(cast(HGDIOBJ)_handle);
    }

    string family() const { return _family; }
    int size() const { return _size; }
    int weight() const { return _weight; }

    HFONT handle() { return _handle; }

    void measureText(string text, out int w, out int h)
    {
        // 需要一个 DC 来测量文本
        HDC hdc = CreateCompatibleDC(HDC.init);
        HGDIOBJ oldFont = SelectObject(hdc, cast(HGDIOBJ)_handle);

        SIZE size;
        auto wtext = toUTF16(text);
        GetTextExtentPoint32W(hdc, cast(const(PWSTR))wtext.ptr, cast(int)wtext.length, &size);

        SelectObject(hdc, oldFont);
        DeleteDC(hdc);

        w = size.cx;
        h = size.cy;
    }

    void measureChar(dchar ch, out int w, out int h)
    {
        char[4] buf;
        size_t len = encode(buf, ch);
        wstring ws = (cast(wchar*)buf)[0 .. len / 2].idup;

        HDC hdc = CreateCompatibleDC(HDC.init);
        HGDIOBJ oldFont = SelectObject(hdc, cast(HGDIOBJ)_handle);

        SIZE size;
        GetTextExtentPoint32W(hdc, cast(const(PWSTR))ws.ptr, cast(int)ws.length, &size);

        SelectObject(hdc, oldFont);
        DeleteDC(hdc);

        w = size.cx;
        h = size.cy;
    }

    private static HFONT createFont(string family, int size, int weight)
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

        return CreateFontIndirectW(&lf);
    }
}

/**
 * GdiFontCache — GDI 字体缓存实现
 */
class GdiFontCache : IFontCache
{
    private GdiFont[string] _cache;  // key: "family_size_weight"

    IFont getFont(string family, int size, int weight = 400)
    {
        string key = family ~ "_" ~ to!string(size) ~ "_" ~ to!string(weight);
        if (auto cached = key in _cache)
            return *cached;

        auto font = new GdiFont(family, size, weight);
        _cache[key] = font;
        return font;
    }

    void releaseFont(IFont font)
    {
        // GDI 字体由 GdiFont 析构函数释放
        // 这里只从缓存中移除
        string key = font.family() ~ "_" ~ to!string(font.size()) ~ "_" ~ to!string(font.weight());
        _cache.remove(key);
    }

    void clear()
    {
        _cache = null;
    }
}
