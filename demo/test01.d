import guia4.app;
import guia4.guicore;
import guia4.utils.logger;
import std.logger;

shared static this()
{
    import core.sys.windows.windows;
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
}

void main()
{
    // Initialize logger with TRACE level to see all logs
    initLogger(LogLevel.trace);
    logInfo("=== DGUI Demo Starting ===");
    
    logInfo("方式1: 使用 Application.createWindow() 创建窗口（推荐）");
    logInfo("Application 会自动管理窗口生命周期");
    
    auto app = new Application();
    
    // 通过 Application 创建窗口，自动建立关联
    auto window = app.createWindow(100, 100, 800, 600, "DGUI Demo");
    
    auto button = new Button(window, "Click Me");
    button.x = 100;
    button.y = 100;
    
    window.scheduleScreenshot(3000, "demo_screenshot.bmp");
    window.show();
    
    logInfo("Taking immediate screenshot before message loop...");
    window.captureImmediate("demo_screenshot_immediate.bmp");
    logInfo("Immediate screenshot done");
    
    logInfo("DGUI Demo started!");
    logInfo("关闭窗口会自动退出应用");
    
    app.run();
    
    logInfo("=== DGUI Demo Exiting ===");
    logInfo("应用已退出");
}