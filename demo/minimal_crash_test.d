/**
 * Crash test - wrap message loop in try-catch to catch any exception.
 * Uses the framework's Win32Window but with crash catching.
 */
import guia4.platform_win32.win32window;
import guia4.utils.logger;
import std.logger;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;
import windows.win32.graphics.gdi;

void nullPaint(HDC hdc, int width, int height, void* userData)
{
}

void main()
{
    initLogger(LogLevel.trace);
    logInfo("=== Crash Test ===");
    
    auto win = new Win32Window(100, 100, 800, 600, "Crash Test");
    win.setPaintCallback(&nullPaint, null);
    logInfo("Window created, hwnd=", win.nativeHandle());
    
    win.show();
    logInfo("Window shown");
    
    logInfo("Entering manual message loop...");
    
    try
    {
        MSG msg;
        while (GetMessageW(&msg, HWND.init, 0, 0).Value != 0)
        {
            TranslateMessage(&msg);
            try
            {
                DispatchMessageW(&msg);
            }
            catch (Exception e)
            {
                logError("DispatchMessageW exception: ", e.msg);
            }
            catch (Throwable t)
            {
                logError("DispatchMessageW throwable");
            }
        }
    }
    catch (Exception e)
    {
        logError("Message loop exception: ", e.msg);
    }
    catch (Throwable t)
    {
        logError("Message loop throwable");
    }
    
    logInfo("Message loop exited");
}
