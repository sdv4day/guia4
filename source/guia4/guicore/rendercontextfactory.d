module guia4.guicore.rendercontextfactory;

import guia4.guicore.irendercontext;
import guia4.guicore.gdirendercontext;
import windows.win32.graphics.gdi;

/**
 * RenderContextFactory — 渲染上下文工厂
 *
 * 从 void* (HDC) 创建 IRenderContext 实例。
 * 控件通过此工厂创建渲染上下文，不直接 import GDI。
 */
struct RenderContextFactory
{
    /// 从 void* HDC 创建渲染上下文
    static IRenderContext create(void* nativeHandle, int width, int height)
    {
        return new GdiRenderContext(HDC(nativeHandle), width, height);
    }
}
