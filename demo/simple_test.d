/**
 * dub.json
 * {
 *     "name": "simple_test",
 *     "dependencies": {
 *         "winlib": "*"
 *     }
 * }
 */
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;
import windows.win32.graphics.gdi;
import std.utf;
import std.stdio;

enum WM_PAINT = 0x000F;
enum WM_CLOSE = 0x0010;
enum WM_DESTROY = 0x0002;
enum GWLP_USERDATA = -21;
enum COLOR_WINDOW = 5;
enum IDC_ARROW = 32512;

alias LONG_PTR = long;

extern(Windows) HINSTANCE GetModuleHandleW(const(PWSTR) lpModuleName);
extern(Windows) LONG_PTR GetWindowLongPtrW(HWND hWnd, int nIndex);
extern(Windows) LONG_PTR SetWindowLongPtrW(HWND hWnd, int nIndex, LONG_PTR dwNewLong);

private bool _classRegistered = false;
private wchar[] _className = "Test_Window_Class"w.dup;

extern(Windows) LRESULT wndProc(HWND hwnd, uint msg, WPARAM wparam, LPARAM lparam)
{
    switch (msg)
    {
        case WM_CREATE:
            SetWindowLongPtrW(hwnd, GWLP_USERDATA, cast(LONG_PTR)cast(void*)true);
            return LRESULT(0);
            
        case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hwnd, &ps);
            
            RECT rect;
            GetClientRect(hwnd, &rect);
            
            HBRUSH brush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
            FillRect(hdc, &rect, brush);
            DeleteObject(cast(HGDIOBJ)brush);
            
            RECT btnRect = {50, 50, 150, 80};
            HBRUSH btnBrush = CreateSolidBrush(cast(COLORREF)0x006666FF);
            HPEN btnPen = CreatePen(PS_SOLID, 2, cast(COLORREF)0x003333AA);
            
            HBRUSH oldBrush = cast(HBRUSH)SelectObject(hdc, cast(HGDIOBJ)btnBrush);
            HPEN oldPen = cast(HPEN)SelectObject(hdc, cast(HGDIOBJ)btnPen);
            
            RoundRect(hdc, btnRect.left, btnRect.top, btnRect.right, btnRect.bottom, 8, 8);
            
            SelectObject(hdc, cast(HGDIOBJ)oldBrush);
            SelectObject(hdc, cast(HGDIOBJ)oldPen);
            DeleteObject(cast(HGDIOBJ)btnBrush);
            DeleteObject(cast(HGDIOBJ)btnPen);
            
            HFONT font = CreateFontW(14, 0, 0, 0, FW_NORMAL, 0u, 0u, 0u, DEFAULT_CHARSET, 
                                    OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, 
                                    DEFAULT_PITCH | FF_DONTCARE, cast(PWSTR)"Segoe UI");
            HFONT oldFont = cast(HFONT)SelectObject(hdc, cast(HGDIOBJ)font);
            
            SetTextColor(hdc, cast(COLORREF)0x00FFFFFF);
            SetBkMode(hdc, TRANSPARENT);
            
            wstring textW = "Click Me"w;
            SIZE textSize;
            GetTextExtentPointW(hdc, cast(const(PWSTR))textW.ptr, cast(int)textW.length, &textSize);
            
            int textX = btnRect.left + (btnRect.right - btnRect.left - textSize.cx) / 2;
            int textY = btnRect.top + (btnRect.bottom - btnRect.top - textSize.cy) / 2;
            
            TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);
            
            SelectObject(hdc, cast(HGDIOBJ)oldFont);
            DeleteObject(cast(HGDIOBJ)font);
            
            EndPaint(hwnd, &ps);
            return LRESULT(0);
        }
        
        case WM_CLOSE:
            DestroyWindow(hwnd);
            return LRESULT(0);
            
        case WM_DESTROY:
            PostQuitMessage(0);
            return LRESULT(0);
            
        default:
            break;
    }
    
    return DefWindowProcW(hwnd, msg, wparam, lparam);
}

void registerWindowClass()
{
    if (_classRegistered) return;
    
    wchar[] menuName = null;
    
    WNDCLASSEXW wc = WNDCLASSEXW(
        WNDCLASSEXW.sizeof,
        CS_HREDRAW | CS_VREDRAW,
        &wndProc,
        0,
        0,
        GetModuleHandleW(PWSTR.init),
        HICON.init,
        LoadCursorW(HINSTANCE.init, cast(PWSTR)cast(wchar*)IDC_ARROW),
        cast(HBRUSH)cast(void*)(COLOR_WINDOW + 1),
        cast(const(PWSTR))menuName.ptr,
        cast(const(PWSTR))_className.ptr,
        HICON.init
    );
    
    RegisterClassExW(&wc);
    _classRegistered = true;
}

void main()
{
    writeln("=== Simple Button Test ===");
    
    registerWindowClass();
    
    wstring titleW = "Button Test"w;
    HWND hwnd = CreateWindowExW(
        0,
        cast(const(PWSTR))_className.ptr,
        cast(const(PWSTR))titleW.ptr,
        WS_OVERLAPPEDWINDOW,
        100, 100, 300, 200,
        HWND.init,
        HMENU.init,
        GetModuleHandleW(PWSTR.init),
        cast(void*)null
    );
    
    if (hwnd.Value is null)
    {
        writeln("Failed to create window");
        return;
    }
    
    ShowWindow(hwnd, SW_SHOW);
    
    MSG msg;
    while (GetMessageW(&msg, HWND.init, 0, 0).Value != 0)
    {
        TranslateMessage(&msg);
        DispatchMessageW(&msg);
    }
    
    writeln("Test completed");
}