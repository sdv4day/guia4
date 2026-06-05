module guia4.platform_win32.win32application;

import guia4.platform;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

class Win32Application : IPlatformApplication
{
    bool _running = false;
    
    int run()
    {
        _running = true;
        MSG msg;
        while (GetMessageW(&msg, HWND.init, 0, 0).Value != 0)
        {
            TranslateMessage(&msg);
            DispatchMessageW(&msg);
        }
        _running = false;
        return cast(int)(msg.wParam.Value);
    }
    
    void quit(int exitCode = 0)
    {
        _running = false;
        PostQuitMessage(exitCode);
    }
    
    bool processMessage()
    {
        MSG msg;
        if (PeekMessageW(&msg, HWND.init, 0, 0, PM_REMOVE).Value != 0)
        {
            TranslateMessage(&msg);
            DispatchMessageW(&msg);
            return true;
        }
        return _running;
    }
}