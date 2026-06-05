import guia4.app;
import guia4.guicore;
import guia4.utils.logger;
import std.stdio;
import core.sys.windows.windows;

void main()
{
    initLogger(LogLevel.trace);
    logInfo("=== Minimal Timer Test ===");
    
    auto app = new Application();
    auto window = app.createWindow(100, 100, 800, 600, "Timer Test");
    
    // Use a class-level counter to track timer fires
    auto timerFired = new shared(int);
    
    // Set a simple timer callback that doesn't do anything heavy
    window.setTimerCallback(1002, 1000, delegate () {
        writeln("TIMER FIRED at ", Clock.currStdTime());
        stdout.flush();
    });
    
    window.show();
    
    logInfo("Timer set for 1 second; waiting 5 seconds...");
    logInfo("Starting message loop");
    
    app.run();
    
    logInfo("=== Timer Test Complete ===");
}
