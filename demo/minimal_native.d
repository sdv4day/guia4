/**
 * minimal_native.d
 * Same as capture_test but using winlib types instead of core.sys.windows
 * to isolate whether the crash is from winlib's type definitions.
 */
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;
import windows.win32.graphics.gdi;

// MAKEINTRESOURCE for cursor ID
enum IDC_ARROWA = PSTR(cast(ubyte*) cast(size_t) 32512);

// extern(Windows) with nothrow
extern (Windows)
LRESULT WndProc(HWND hwnd, uint msg, WPARAM wParam, LPARAM lParam) nothrow
{
    switch (msg)
    {
        case WM_DESTROY:
            PostQuitMessage(0);
            return LRESULT(0);

        case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hwnd, &ps);
            RECT rect;
            GetClientRect(hwnd, &rect);

            // Fill white
            HBRUSH brush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
            FillRect(hdc, &rect, brush);
            DeleteObject(brush);

            // Draw text using ANSI API
            SetBkMode(hdc, TRANSPARENT);
            SetTextColor(hdc, RGB(255, 255, 255));
            RECT textRect = {50, 50, 400, 100};
            DrawTextA(hdc, "Minimal Native Test", -1, &textRect, DT_LEFT);

            EndPaint(hwnd, &ps);
            return LRESULT(0);
        }

        default:
            return DefWindowProcA(hwnd, msg, wParam, lParam);
    }
}

extern (Windows)
int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow)
{
    // Register class using winlib types
    WNDCLASSA wc;
    wc.style = WNDCLASS_STYLES(CS_HREDRAW | CS_VREDRAW);
    wc.lpfnWndProc = &WndProc;
    wc.hInstance = hInstance;
    wc.hCursor = LoadCursorA(null, IDC_ARROWA);
    wc.hbrBackground = cast(HBRUSH) cast(void*)(COLOR_WINDOW + 1);
    wc.lpszClassName = "MinimalClass";

    if (RegisterClassA(&wc) == 0)
    {
        return 1;
    }

    HWND hwnd = CreateWindowExA(
        WINDOW_EX_STYLE.init,
        "MinimalClass",
        "Minimal Native",
        WINDOW_STYLE(WS_OVERLAPPEDWINDOW),
        CW_USEDEFAULT, CW_USEDEFAULT, 800, 600,
        HWND.init, HMENU.init, hInstance, null
    );
    if (hwnd.Value is null)
    {
        return 1;
    }

    ShowWindow(hwnd, SW_SHOW);
    UpdateWindow(hwnd);

    MSG msg;
    while (GetMessageW(&msg, HWND.init, 0, 0).Value != 0)
    {
        TranslateMessage(&msg);
        DispatchMessageW(&msg);
    }

    return 0;
}
