/**
 * minimal_test.d
 * Minimal framework test to isolate the crash.
 * Uses the framework but with minimal rendering.
 */
import guia4.app;
import guia4.guicore;
import guia4.utils.logger;
import std.logger;

void main()
{
    initLogger(LogLevel.trace);
    logInfo("=== Minimal Framework Test ===");
    
    auto app = new Application();
    auto window = app.createWindow(100, 100, 800, 600, "Minimal Test");
    window.show();
    
    logInfo("Entering message loop...");
    app.run();
    logInfo("Message loop exited");
}
