/**
 * win32window_test.d
 * Test Win32Window directly - minimal paint callback with crash handling.
 */
import guia4.platform_win32.win32window;
import guia4.utils.logger;
import std.logger;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;
import windows.win32.graphics.gdi;

void main()
{
    initLogger(LogLevel.trace);
    logInfo("=== Win32Window Direct Test ===");
    
    auto win = new Win32Window(100, 100, 800, 600, "Win32Window Test");
    logInfo("Window created, native handle = ", win.nativeHandle());
    
    win.show();
    logInfo("Window shown");
    
    logInfo("Entering manual message loop...");
    
    // Wrap in try-catch
    try
    {
        MSG msg;
        while (GetMessageW(&msg, HWND.init, 0, 0).Value != 0)
        {
            TranslateMessage(&msg);
            DispatchMessageW(&msg);
        }
        logInfo("Message loop exited normally (WM_QUIT)");
    }
    catch (Throwable t)
    {
        logError("CRASH: ", t.toString());
    }
    
    logInfo("Exiting test");
}
