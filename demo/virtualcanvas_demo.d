module demo.virtualcanvas_demo;

import guia4.app;
import guia4.guicore;
import guia4.guicore.virtualcanvas;
import guia4.guicore.button;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.platform_win32.win32defs;
import windows.win32.graphics.gdi;
import std.stdio;
import std.conv;

/**
 * VirtualCanvas演示
 * 
 * 展示tile-based脏标记和虚拟画布的高效渲染：
 * - 2048x1024的虚拟画布
 * - 1024x768的显示窗口
 * - 滚动时无需重绘，只需移动可视窗口
 * - 控件更新时，只重绘受影响的tile
 */
void main()
{
    initLogger(LogLevel.info);
    logInfo("=== VirtualCanvas Demo ===");
    
    auto app = new Application();
    auto win = app.createWindow(100, 100, 1024, 768, "VirtualCanvas Demo");
    
    // 创建虚拟画布（2048x1024）
    auto canvas = new VirtualCanvas(win);
    canvas.setXY(0, 0);
    canvas.width = 1024;
    canvas.height = 768;
    
    // 添加一些控件到虚拟画布
    for (int i = 0; i < 20; i++)
    {
        auto btn = new Button(canvas, "Button " ~ text(i));
        btn.setXY(50 + (i % 5) * 200, 50 + (i / 5) * 100);
        btn.width = 150;
        btn.height = 40;
        
        // 点击按钮时，只更新该按钮区域
        int idx = i;
        btn.onClick((ref ClickEvent e) {
            auto b = cast(Button)e.target;
            b.text = "Clicked!";
            // 标记按钮区域为脏
            canvas.markDirtyRect(b.position().x(), b.position().y(), b.width(), b.height());
        });
    }
    
    // 添加说明标签（放在主窗口上，不在虚拟画布上）
    auto label = new Label(win, "Use mouse wheel to scroll. Virtual canvas: 2048x1024");
    label.setXY(10, 10);
    label.width = 500;
    label.height = 25;
    
    // 窗口显示后初始化虚拟画布
    win.show();
    
    // 获取窗口DC并初始化虚拟画布
    HWND hwnd = cast(HWND)win.nativeHandle();
    HDC hdc = GetDC(hwnd);
    canvas.initCanvas(2048, 1024, hdc);
    ReleaseDC(hwnd, hdc);
    
    logInfo("Demo initialized. Use mouse wheel to scroll.");
    app.run();
    
    logInfo("=== Demo Exited ===");
}