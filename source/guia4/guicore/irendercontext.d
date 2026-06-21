module guia4.guicore.irendercontext;

import guia4.guicore.color;

/**
 * IRenderContext — 跨平台抽象渲染上下文接口
 *
 * 设计目标：
 * - 控件只通过此接口渲染，不直接调用任何平台 API
 * - 支持 GDI（Windows）、Cairo（Linux）、Vulkan 等后端
 * - 无 void* 或平台特定类型泄露到接口中
 *
 * 使用原则：
 * - 控件在 renderWithGDI(void* hdc) 中创建 IRenderContext 实例
 * - 所有绘制操作通过 IRenderContext 方法完成
 * - 状态管理（save/restore/clip）通过接口方法完成
 */
interface IRenderContext
{
    // ── 尺寸 ──────────────────────────────────────────────

    /// 渲染目标宽度（像素）
    int width() const;

    /// 渲染目标高度（像素）
    int height() const;

    // ── 绘图基元 ─────────────────────────────────────────

    /// 填充矩形
    void fillRect(int x, int y, int w, int h, Color color);

    /// 绘制矩形边框（1px 线宽）
    void drawRect(int x, int y, int w, int h, Color color, int lineWidth = 1);

    /// 绘制圆角矩形边框
    void drawRoundRect(int x, int y, int w, int h, int radius, Color color, int lineWidth = 1);

    /// 填充圆角矩形
    void fillRoundRect(int x, int y, int w, int h, int radius, Color color);

    /// 绘制椭圆边框
    void drawEllipse(int x, int y, int w, int h, Color color, int lineWidth = 1);

    /// 填充椭圆
    void fillEllipse(int x, int y, int w, int h, Color color);

    /// 绘制直线
    void drawLine(int x1, int y1, int x2, int y2, Color color, int lineWidth = 1);

    /// 绘制多段线
    void drawPolyline(int[] points, Color color, int lineWidth = 1);

    // ── 文本操作 ─────────────────────────────────────────

    /// 设置当前字体（返回之前设置的字体 ID）
    int setFont(string family, int size, int weight = 400);

    /// 恢复之前的字体
    void restoreFont(int fontId);

    /// 绘制文本（使用当前字体）
    void drawText(int x, int y, string text, Color color);

    /// 测量文本尺寸（使用当前字体）
    void measureText(string text, out int w, out int h);

    /// 测量单个字符宽度
    void measureChar(dchar ch, out int w, out int h);

    // ── 状态管理 ─────────────────────────────────────────

    /// 保存当前渲染状态（字体、裁剪、视口等）
    int saveState();

    /// 恢复之前保存的状态
    void restoreState(int stateId);

    /// 设置裁剪矩形（交集）
    void setClipRect(int x, int y, int w, int h);

    /// 清除裁剪区域
    void clearClipRect();

    /// 偏移视口原点
    void setViewportOrigin(int x, int y);

    /// 恢复视口原点
    void resetViewportOrigin();

    // ── 位图操作 ─────────────────────────────────────────

    /// 创建兼容的内存 DC（用于双缓冲）
    void* createCompatibleDC();

    /// 释放内存 DC
    void releaseCompatibleDC(void* dc);

    /// 创建兼容位图
    void* createCompatibleBitmap(void* dc, int w, int h);

    /// 释放位图
    void releaseBitmap(void* bmp);

    /// 选择位图到 DC
    void* selectBitmap(void* dc, void* bmp);

    /// BitBlt 位块传输
    void bitBlt(void* dstDC, int dstX, int dstY, int dstW, int dstH,
                void* srcDC, int srcX, int srcY);

    // ── 裁剪区域（高级）──────────────────────────────────

    /// 创建矩形裁剪区域
    void* createClipRegion(int x, int y, int w, int h);

    /// 应用裁剪区域
    void applyClipRegion(void* region);

    /// 释放裁剪区域
    void releaseClipRegion(void* region);
}

/**
 * IPlatformRenderer — 平台渲染器接口
 *
 * 用于创建和管理 IRenderContext 实例。
 * 每个平台后端（GDI、Cairo、Vulkan）实现此接口。
 */
interface IPlatformRenderer
{
    /// 从原生句柄创建渲染上下文
    /// nativeHandle: HDC (GDI), cairo_t* (Cairo), VkCommandBuffer (Vulkan)
    IRenderContext createContext(void* nativeHandle, int width, int height);

    /// 销毁渲染上下文
    void destroyContext(IRenderContext ctx);
}
