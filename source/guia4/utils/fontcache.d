module guia4.utils.fontcache;

import windows.win32.graphics.gdi;
import windows.win32.ui.windowsandmessaging;
import std.utf;

/**
 * 字体缓存 — 避免每帧重复 CreateFontW/DeleteObject
 * 
 * 使用方式：
 *   auto entry = FontCache.get(hdc, "Segoe UI", 14);
 *   // 使用 entry.font 进行文本渲染
 *   FontCache.release(hdc, entry);  // 恢复旧字体，但不删除缓存字体
 *   FontCache.cleanup();  // 应用退出时调用，释放所有缓存字体
 */
struct FontEntry
{
    HFONT font;      /// 缓存的字体句柄
    HFONT oldFont;   /// 之前选入 DC 的字体（用于恢复）
}

struct FontCacheKey
{
    wstring fontName;
    int fontSize;
    int weight;

    size_t toHash() const nothrow
    {
        size_t h = 0;
        foreach (c; fontName)
            h = h * 31 + cast(size_t)c;
        h = h * 31 + cast(size_t)fontSize;
        h = h * 31 + cast(size_t)weight;
        return h;
    }

    bool opEquals(ref const FontCacheKey other) const
    {
        return fontName == other.fontName && fontSize == other.fontSize && weight == other.weight;
    }
}

/**
 * 全局字体缓存
 * 
 * 字体按 (fontName, fontSize, weight) 三元组缓存。
 * get() 选入 DC 并返回 FontEntry；release() 恢复旧字体但不删除缓存字体。
 * cleanup() 在应用退出时释放所有缓存字体。
 */
struct FontCache
{
private:
    static FontEntry[FontCacheKey] _cache;

public:
    /**
     * 获取缓存字体并选入 DC
     * 
     * Params:
     *   hdc = 设备上下文
     *   fontName = 字体名称（如 "Segoe UI"）
     *   fontSize = 字体大小（逻辑单位）
     *   weight = 字体粗细（FW_NORMAL=400, FW_BOLD=700）
     * 
     * Returns:
     *   FontEntry 包含缓存字体和旧字体
     */
    static FontEntry get(HDC hdc, string fontName, int fontSize, int weight = FW_NORMAL)
    {
        FontCacheKey key;
        key.fontName = toUTF16(fontName);
        key.fontSize = fontSize;
        key.weight = weight;

        auto ptr = key in _cache;
        HFONT font;
        if (ptr !is null)
        {
            font = ptr.font;
        }
        else
        {
            font = CreateFontW(fontSize, 0, 0, 0, weight, 0u, 0u, 0u,
                              DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                              DEFAULT_QUALITY, DEFAULT_PITCH | FF_DONTCARE,
                              cast(const(PWSTR))key.fontName.ptr);
            FontEntry newEntry;
            newEntry.font = font;
            newEntry.oldFont = HFONT.init;
            _cache[key] = newEntry;
        }

        FontEntry result;
        result.font = font;
        result.oldFont = cast(HFONT)SelectObject(hdc, cast(HGDIOBJ)font);
        return result;
    }

    /**
     * 释放字体 — 恢复 DC 中的旧字体，但不删除缓存字体
     */
    static void release(HDC hdc, ref FontEntry entry)
    {
        SelectObject(hdc, cast(HGDIOBJ)entry.oldFont);
    }

    /**
     * 清理所有缓存字体 — 应用退出时调用
     */
    static void cleanup()
    {
        foreach (ref key, ref entry; _cache)
        {
            if (entry.font.Value !is null)
                DeleteObject(cast(HGDIOBJ)entry.font);
        }
        _cache = null;
    }
}