module guia4.guicore.iplatformrenderer;

import guia4.guicore.color;

/**
 * IPlatformRenderer — 平台渲染抽象接口
 *
 * 目的：解耦核心GUI层对平台特定渲染API(如Win32 GDI)的直接依赖
 * 
 * 设计原则：
 * - 只暴露控件渲染所需的最小接口集
 * - 不暴露平台特定类型(如HDC、HBITMAP)
 * - 使用void*作为不透明句柄,由具体实现解释
 * - 支持未来扩展到其他渲染后端(Cairo、Skia、Metal等)
 */
interface IPlatformRenderer
{
    // ── 资源管理 ─────────────────────────────────────
    
    /**
     * 创建渲染缓冲区
     * 
     * Params:
     *   width = 缓冲区宽度
     *   height = 缓冲区高度
     *   refHandle = 参考设备句柄(用于创建兼容资源)
     * 
     * Returns: 缓冲区句柄(不透明,由具体实现解释)
     */
    void* createBuffer(int width, int height, void* refHandle);
    
    /**
     * 销毁渲染缓冲区
     * 
     * Params:
     *   buffer = 要销毁的缓冲区句柄
     */
    void destroyBuffer(void* buffer);
    
    /**
     * 获取缓冲区的设备上下文
     * 
     * Params:
     *   buffer = 缓冲区句柄
     * 
     * Returns: 设备上下文句柄(不透明)
     */
    void* getBufferDC(void* buffer);
    
    // ── 基础绘图操作 ─────────────────────────────────────
    
    /**
     * 填充矩形
     * 
     * Params:
     *   dc = 设备上下文句柄
     *   x, y, w, h = 矩形位置和尺寸
     *   color = 填充颜色
     */
    void fillRect(void* dc, int x, int y, int w, int h, Color color);
    
    /**
     * 绘制矩形边框
     * 
     * Params:
     *   dc = 设备上下文句柄
     *   x, y, w, h = 矩形位置和尺寸
     *   color = 边框颜色
     */
    void drawRect(void* dc, int x, int y, int w, int h, Color color);
    
    /**
     * 绘制直线
     * 
     * Params:
     *   dc = 设备上下文句柄
     *   x1, y1, x2, y2 = 直线端点
     *   color = 线条颜色
     */
    void drawLine(void* dc, int x1, int y1, int x2, int y2, Color color);
    
    /**
     * 绘制文本
     * 
     * Params:
     *   dc = 设备上下文句柄
     *   x, y = 文本位置
     *   text = 文本内容
     *   color = 文本颜色
     */
    void drawText(void* dc, int x, int y, string text, Color color);
    
    /**
     * 测量文本尺寸
     * 
     * Params:
     *   dc = 设备上下文句柄
     *   text = 文本内容
     *   w, h = 输出参数,文本宽度和高度
     */
    void measureText(void* dc, string text, out int w, out int h);
    
    // ── 缓冲区操作 ─────────────────────────────────────
    
    /**
     * 将源缓冲区内容复制到目标缓冲区
     * 
     * Params:
     *   dstDC = 目标设备上下文
     *   dstX, dstY = 目标位置
     *   srcDC = 源设备上下文
     *   srcX, srcY = 源位置
     *   w, h = 复制区域尺寸
     */
    void bitBlt(void* dstDC, int dstX, int dstY, 
                void* srcDC, int srcX, int srcY, 
                int w, int h);
    
    /**
     * 设置裁剪区域
     * 
     * Params:
     *   dc = 设备上下文句柄
     *   x, y, w, h = 裁剪矩形
     */
    void setClipRect(void* dc, int x, int y, int w, int h);
    
    /**
     * 清除裁剪区域
     * 
     * Params:
     *   dc = 设备上下文句柄
     */
    void clearClipRect(void* dc);
    
    // ── 字体管理 ─────────────────────────────────────
    
    /**
     * 设置字体
     * 
     * Params:
     *   dc = 设备上下文句柄
     *   fontSize = 字体大小
     *   fontWeight = 字体粗细(400=正常, 700=粗体)
     */
    void setFont(void* dc, uint fontSize, uint fontWeight = 400);
}

/**
 * PlatformRendererFactory — 平台渲染器工厂
 *
 * 用于创建平台特定的渲染器实例
 */
interface IPlatformRendererFactory
{
    /**
     * 创建平台渲染器实例
     * 
     * Returns: 平台渲染器接口
     */
    IPlatformRenderer createRenderer();
}
