module guia4.guicore.font;

import guia4.guicore.color;

/**
 * IFont — 跨平台字体接口
 *
 * 抽象字体创建、测量、渲染操作。
 * GDI 后端使用 CreateFontIndirectW，Linux 后端使用 FreeType。
 */
interface IFont
{
    /// 字体族名
    string family() const;

    /// 字体大小（像素）
    int size() const;

    /// 字重（400=正常，700=粗体）
    int weight() const;

    /// 测量文本宽度和高度
    void measureText(string text, out int w, out int h);

    /// 测量单个字符
    void measureChar(dchar ch, out int w, out int h);
}

/**
 * IFontCache — 跨平台字体缓存接口
 *
 * 管理字体实例的创建和复用。
 */
interface IFontCache
{
    /// 获取或创建字体
    IFont getFont(string family, int size, int weight = 400);

    /// 释放字体（引用计数归零时销毁）
    void releaseFont(IFont font);

    /// 清除所有缓存
    void clear();
}
