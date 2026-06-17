module guia4.guicore.irendercontext;

import guia4.guicore.color;

/**
 * IRenderContext — 抽象渲染上下文接口
 *
 * 目的：解耦控件对 GDI（HDC/HBITMAP 等）的直接依赖，
 * 为未来支持其他渲染后端（如 Cairo、Skia）预留扩展点。
 *
 * 设计原则：
 * - 只暴露控件渲染所需的最小接口集
 * - 不暴露平台特定类型（如 HDC、HBITMAP）
 * - 使用 void* 作为不透明句柄，由具体实现解释
 */
interface IRenderContext
{
    /// 获取原生渲染设备句柄（不透明，由具体实现解释）
    /// 对于 GDI 后端，返回 HDC；对于其他后端，返回相应的上下文
    void* nativeHandle();

    /// 获取渲染目标的宽度（像素）
    int width() const;

    /// 获取渲染目标的高度（像素）
    int height() const;

    // ── 基础绘图操作 ─────────────────────────────────────

    /// 填充矩形
    void fillRect(int x, int y, int w, int h, Color color);

    /// 绘制矩形边框
    void drawRect(int x, int y, int w, int h, Color color);

    /// 绘制直线
    void drawLine(int x1, int y1, int x2, int y2, Color color);

    /// 绘制文本
    void drawText(int x, int y, string text, Color color);

    /// 测量文本尺寸
    void measureText(string text, out int w, out int h);

    // ── Layer Buffer 管理 ───────────────────────────────

    /// 创建 layer buffer（用于双缓冲渲染）
    /// refHandle: 参考设备上下文（用于创建兼容 DC）
    void createLayerBuffer(void* refHandle, int w, int h);

    /// 销毁 layer buffer
    void destroyLayerBuffer();

    /// 获取 layer buffer 的原生句柄
    void* layerBufferHandle();

    /// 将 layer buffer 内容复制到目标
    void blitToTarget(int srcX, int srcY, int srcW, int srcH,
                      int dstX, int dstY);

    // ── 裁剪区域 ─────────────────────────────────────────

    /// 设置裁剪矩形
    void setClipRect(int x, int y, int w, int h);

    /// 清除裁剪区域
    void clearClipRect();
}

/**
 * LayerBuffer — Layer 缓冲区管理器
 *
 * 封装 GDI layer buffer 的创建、销毁和复用逻辑。
 * 用于需要双缓冲渲染的控件。
 */
struct LayerBuffer
{
    private void* _dc;          // HDC (GDI) 或其他后端的等价物
    private void* _bitmap;      // HBITMAP (GDI) 或其他后端的等价物
    private void* _oldBitmap;   // 原始位图（用于恢复）
    private int _width = 0;
    private int _height = 0;

    /// 是否已初始化
    bool isInitialized() const { return _dc !is null; }

    /// 获取宽度
    int width() const { return _width; }

    /// 获取高度
    int height() const { return _height; }

    /// 获取原生 DC 句柄
    void* nativeDC() { return _dc; }

    /// 创建 layer buffer（GDI 实现）
    /// 注意：此方法包含 GDI 特定代码，应移到平台层
    /// 这里保留为占位符，实际实现在 GdiLayerBuffer 中
    void create(void* refDC, int w, int h)
    {
        // 占位符 - 实际实现在 GdiLayerBuffer
    }

    /// 销毁 layer buffer
    void destroy()
    {
        // 占位符 - 实际实现在 GdiLayerBuffer
    }
}
