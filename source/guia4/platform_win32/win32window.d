module guia4.platform_win32.win32window;

import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;
import windows.win32.graphics.gdi;
import std.utf;

enum WM_PAINT = 0x000F;
enum WM_CLOSE = 0x0010;
enum WM_DESTROY = 0x0002;
enum WM_TIMER = 0x0113;
enum WM_MOUSEMOVE = 0x0200;
enum WM_LBUTTONDOWN = 0x0201;
enum WM_LBUTTONUP = 0x0202;
enum WM_RBUTTONDOWN = 0x0204;
enum WM_RBUTTONUP = 0x0205;
enum WM_MOUSELEAVE = 0x02A3;
enum WM_KEYDOWN = 0x0100;
enum WM_SYSKEYDOWN = 0x0104;
enum WM_KEYUP = 0x0101;

// Virtual key codes we care about
enum VK_TAB     = 0x09;
enum VK_RETURN  = 0x0D;
enum VK_SPACE   = 0x20;
enum VK_LEFT    = 0x25;
enum VK_UP      = 0x26;
enum VK_RIGHT   = 0x27;
enum VK_DOWN    = 0x28;
enum VK_SHIFT   = 0x10;
enum VK_CONTROL = 0x11;

enum GWLP_USERDATA = -21;

enum COLOR_WINDOW = 5;
enum IDC_ARROW = 32512;

struct TRACKMOUSEEVENT
{
    uint cbSize;
    uint dwFlags;
    HWND hwndTrack;
    uint dwHoverTime;
}

enum TME_HOVER   = 0x00000001;
enum TME_LEAVE   = 0x00000002;
enum TME_NONCLIENT = 0x00000010;
enum TME_QUERY   = 0x40000000;
enum TME_CANCEL  = 0x80000000;
enum HOVER_DEFAULT = 0xFFFFFFFF;

alias LONG = int;
alias LONG_PTR = long;

// Mouse event data forwarded from Win32 messages to the MainWindow layer
struct MouseEventData
{
    int x;
    int y;
    int button;  // 0=left, 1=right, 2=middle
    bool down;   // true = button press, false = button release (for button messages only)
    bool move;   // true for WM_MOUSEMOVE
    bool leave;  // true for WM_MOUSELEAVE
}

// Key event data forwarded from Win32 messages
struct KeyEventData
{
    uint keyCode;   // virtual key code (VK_*)
    bool down;      // true = key pressed, false = key released
    bool alt;       // alt key held
    bool shift;     // shift held
    bool control;   // control held
}

extern(Windows) HINSTANCE GetModuleHandleW(const(PWSTR) lpModuleName);
extern(Windows) LONG_PTR GetWindowLongPtrW(HWND hWnd, int nIndex);
extern(Windows) LONG_PTR SetWindowLongPtrW(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
extern(Windows) BOOL TrackMouseEvent(ref TRACKMOUSEEVENT lpEventTrack);
extern(Windows) short GetKeyState(int nVirtKey);

enum MK_LBUTTON   = 0x0001;
enum MK_RBUTTON   = 0x0002;
enum MK_SHIFT     = 0x0004;
enum MK_CONTROL   = 0x0008;
enum MK_MBUTTON   = 0x0010;
enum MK_XBUTTON1  = 0x0020;
enum MK_XBUTTON2  = 0x0040;

// Extracts signed 16-bit x from lParam
private int lParamX(LPARAM lp)
{
    return cast(short)(lp.Value & 0xFFFF);
}

// Extracts signed 16-bit y from lParam
private int lParamY(LPARAM lp)
{
    return cast(short)((lp.Value >> 16) & 0xFFFF);
}

// ── GC-safe window lookup table ─────────────────────────────────────────
//
// GWLP_USERDATA stores an INDEX (not a raw pointer) into this table.
// Each slot holds a GC-tracked Object reference. When the GC compactor moves
// the Win32Window, the reference in the table is updated automatically.
// Dereferencing a stale void* from GWLP_USERDATA would crash.
private __gshared
{
    // Fixed-size table of GC-tracked window refs. Value-type array = no GC issues.
    Object[MAX_WINDOWS] _windowTable;
    int _windowTableCount = 0;

    // Paint callback: static function + GC-scoped data ref (same pattern as before)
    void function(HDC hdc, int w, int h, void* data) _paintFunc;
    Object _paintDataRef;

    // Timer callback
    void function(uint id, void* data) _timerFunc;
    Object _timerDataRef;
}

private enum MAX_WINDOWS = 64;

/// Store a Win32Window ref in the GC-safe table, return index for GWLP_USERDATA
private int storeWindow(Win32Window w)
{
    assert(_windowTableCount < MAX_WINDOWS, "Too many windows (max " ~ MAX_WINDOWS.stringof ~ ")");
    int idx = _windowTableCount++;
    _windowTable[idx] = cast(Object)w;
    return idx;
}

/// Look up Win32Window by table index (retrieved from GWLP_USERDATA)
private Win32Window lookupWindow(LONG_PTR userData)
{
    int idx = cast(int)userData;
    if (idx >= 0 && idx < _windowTableCount)
        return cast(Win32Window)_windowTable[idx];
    return null;
}

/// Remove a window ref from the table
private void forgetWindow(int idx)
{
    if (idx >= 0 && idx < _windowTableCount)
        _windowTable[idx] = null;
}

class Win32Window
{
    HWND _hwnd;
    string _title;
    int _x, _y;
    uint _width, _height;
    bool _visible;
    bool _destroyed = false; // true after DestroyWindow called
    
    // Index into __gshared _windowTable for GC-safe Win32→D lookup.
    // -1 = not registered in the table.
    private int _windowTableIndex = -1;
    
    void delegate() _closeCallback;
    void delegate(ref MouseEventData) _mouseCallback;
    void delegate(ref KeyEventData) _keyCallback;
    
    private static bool _classRegistered = false;
    private static wchar[] _className;
    
    this(int x, int y, uint width, uint height, string title)
    {
        _x = x;
        _y = y;
        _width = width;
        _height = height;
        _title = title;
        _visible = false;
        _hwnd = HWND.init;
        
        if (_className is null)
        {
            _className = "DGUI_Window_Class"w.dup;
        }
        
        registerWindowClass();
        createWindow();
    }
    
    private static void registerWindowClass()
    {
        if (_classRegistered) return;
        
        wchar[] menuName = null;
        
        // Use SetWindowLongPtrW after creation instead of passing through WNDCLASSEXW.
        // This avoids the nothrow @nogc constraint on WNDPROC in the struct.
        // We use a minimal dummy WNDPROC that just calls DefWindowProcW.
        extern(Windows) static LRESULT dummyProc(HWND hwnd, uint msg, WPARAM wparam, LPARAM lparam)
        {
            return DefWindowProcW(hwnd, msg, wparam, lparam);
        }
        
        WNDCLASSEXW wc = WNDCLASSEXW(
            WNDCLASSEXW.sizeof,
            CS_HREDRAW | CS_VREDRAW,
            &dummyProc,
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
    
    private void createWindow()
    {
        wstring titleW = toUTF16(_title);
        _hwnd = CreateWindowExW(
            0,
            cast(const(PWSTR))_className.ptr,
            cast(const(PWSTR))titleW.ptr,
            WS_OVERLAPPEDWINDOW,
            _x, _y, cast(int)_width, cast(int)_height,
            HWND.init,
            HMENU.init,
            GetModuleHandleW(PWSTR.init),
            cast(void*)this
        );
        // Store GC-tracked reference in the lookup table; store INDEX in GWLP_USERDATA.
        // This avoids the GC compaction bug: cast(void*)this in GWLP_USERDATA becomes stale
        // when the GC compactor moves the Win32Window object. The table holds an Object ref
        // that the GC updates automatically.
        _windowTableIndex = storeWindow(this);
        SetWindowLongPtrW(_hwnd, GWLP_USERDATA, cast(LONG_PTR)_windowTableIndex);
        // Override the dummy WNDPROC with our real one
        SetWindowLongPtrW(_hwnd, GWLP_WNDPROC, cast(LONG_PTR)cast(void*)&wndProcWrapper);
    }
    
    private static extern(Windows) LRESULT wndProcWrapper(HWND hwnd, uint msg, WPARAM wparam, LPARAM lparam)
    {
        // Look up the Win32Window via GC-safe index table instead of raw pointer.
        // The index is a small int stored in GWLP_USERDATA; the table holds a GC-tracked
        // Object reference that survives compaction.
        Win32Window window = lookupWindow(GetWindowLongPtrW(hwnd, GWLP_USERDATA));
        
        switch (msg)
        {
            case WM_PAINT:
            {
                if (window !is null)
                {
                    window.internalPaint(hwnd);
                }
                return LRESULT(0);
            }
            
            case WM_CLOSE:
            {
                // Do NOT call DestroyWindow here — the close callback (MainWindow.close())
                // owns teardown: it calls app.removeWindow, hide, then destroy().
                // This ordering preserves multi-window support (no premature PostQuitMessage).
                if (window !is null)
                {
                    window.internalClose();
                }
                return LRESULT(0);
            }
            
            case WM_DESTROY:
            {
                // PostQuitMessage is NOT called here — the Application layer handles that
                // via MainWindow.close() → _app.removeWindow() → _app.quit().
                // This prevents WM_DESTROY from unconditionally killing multi-window apps.
                return LRESULT(0);
            }
            
            case WM_TIMER:
            {
                if (window !is null)
                {
                    window.internalTimer(cast(uint)wparam.Value);
                }
                return LRESULT(0);
            }
            
            case WM_LBUTTONDOWN:
            {
                if (window !is null)
                {
                    window.internalMouseDown(lParamX(lparam), lParamY(lparam), 0);
                }
                return LRESULT(0);
            }
            
            case WM_LBUTTONUP:
            {
                if (window !is null)
                {
                    window.internalMouseUp(lParamX(lparam), lParamY(lparam), 0);
                }
                return LRESULT(0);
            }
            
            case WM_RBUTTONDOWN:
            {
                if (window !is null)
                {
                    window.internalMouseDown(lParamX(lparam), lParamY(lparam), 1);
                }
                return LRESULT(0);
            }
            
            case WM_RBUTTONUP:
            {
                if (window !is null)
                {
                    window.internalMouseUp(lParamX(lparam), lParamY(lparam), 1);
                }
                return LRESULT(0);
            }
            
            case WM_MOUSEMOVE:
            {
                if (window !is null)
                {
                    // Request WM_MOUSELEAVE notification on first mouse move
                    window.trackMouseLeave();
                    window.internalMouseMove(lParamX(lparam), lParamY(lparam));
                }
                return LRESULT(0);
            }
            
            case WM_MOUSELEAVE:
            {
                if (window !is null)
                {
                    window.internalMouseLeave();
                }
                return LRESULT(0);
            }
            
            case WM_KEYDOWN:
            case WM_SYSKEYDOWN:
            {
                if (window !is null)
                {
                    uint vk = cast(uint)wparam.Value;
                    bool alt  = (msg == WM_SYSKEYDOWN);
                    bool shift = (GetKeyState(VK_SHIFT) & 0x8000) != 0;
                    bool ctrl  = (GetKeyState(VK_CONTROL) & 0x8000) != 0;
                    window.internalKey(vk, true, alt, shift, ctrl);
                }
                // Let DefWindowProc handle system keys (Alt+F4 etc.)
                if (msg == WM_SYSKEYDOWN)
                    break;
                return LRESULT(0);
            }
            
            case WM_KEYUP:
            {
                if (window !is null)
                {
                    uint vk = cast(uint)wparam.Value;
                    bool alt  = false;
                    bool shift = (GetKeyState(VK_SHIFT) & 0x8000) != 0;
                    bool ctrl  = (GetKeyState(VK_CONTROL) & 0x8000) != 0;
                    window.internalKey(vk, false, alt, shift, ctrl);
                }
                return LRESULT(0);
            }
            
            default:
                break;
        }
        
        return DefWindowProcW(hwnd, msg, wparam, lparam);
    }
    
    private void internalPaint(HWND hwnd)
    {
        PAINTSTRUCT ps;
        HDC hdc = BeginPaint(hwnd, &ps);
        
        RECT rect = {0, 0, cast(LONG)_width, cast(LONG)_height};
        HBRUSH brush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);
        
        if (_paintFunc !is null)
        {
            // Derive void* from GC-scanned Object ref — ensures the address is always valid
            // even after GC compaction moves the object in memory.
            _paintFunc(hdc, cast(int)_width, cast(int)_height, cast(void*)_paintDataRef);
        }
        
        EndPaint(hwnd, &ps);
    }
    
    private void internalClose()
    {
        if (_closeCallback !is null)
        {
            _closeCallback();
        }
    }
    
    /// Set paint callback using static function pointer + user data.
    /// This is the ONLY mechanism verified to work reliably from WNDPROC context.
    static void setPaintFunction(void function(HDC hdc, int w, int h, void* data) func, Object data)
    {
        _paintFunc = func;
        _paintDataRef = data;
    }
    
    void setCloseCallback(void delegate() callback)
    {
        _closeCallback = callback;
    }
    
    /// Request WM_MOUSELEAVE notifications — call on first mouse move over the window.
    /// Must be re-armed after each WM_MOUSELEAVE fires (standard Win32 behaviour).
    private void trackMouseLeave()
    {
        TRACKMOUSEEVENT tme;
        tme.cbSize = TRACKMOUSEEVENT.sizeof;
        tme.dwFlags = TME_LEAVE;
        tme.hwndTrack = _hwnd;
        tme.dwHoverTime = HOVER_DEFAULT;
        TrackMouseEvent(tme);
    }
    
    void setMouseCallback(void delegate(ref MouseEventData) callback)
    {
        _mouseCallback = callback;
    }
    
    void setKeyCallback(void delegate(ref KeyEventData) callback)
    {
        _keyCallback = callback;
    }
    
    // Mouse event forwarders — called from wndProcWrapper, dispatch via delegate
    private void internalMouseDown(int x, int y, int button)
    {
        if (_mouseCallback !is null)
        {
            MouseEventData ev;
            ev.x = x;
            ev.y = y;
            ev.button = button;
            ev.down = true;
            ev.move = false;
            ev.leave = false;
            _mouseCallback(ev);
        }
    }
    
    private void internalMouseUp(int x, int y, int button)
    {
        if (_mouseCallback !is null)
        {
            MouseEventData ev;
            ev.x = x;
            ev.y = y;
            ev.button = button;
            ev.down = false;
            ev.move = false;
            ev.leave = false;
            _mouseCallback(ev);
        }
    }
    
    private void internalMouseMove(int x, int y)
    {
        if (_mouseCallback !is null)
        {
            MouseEventData ev;
            ev.x = x;
            ev.y = y;
            ev.button = -1;
            ev.down = false;
            ev.move = true;
            ev.leave = false;
            _mouseCallback(ev);
        }
    }
    
    private void internalMouseLeave()
    {
        if (_mouseCallback !is null)
        {
            MouseEventData ev;
            ev.x = -1;
            ev.y = -1;
            ev.button = -1;
            ev.down = false;
            ev.move = false;
            ev.leave = true;
            _mouseCallback(ev);
        }
    }
    
    // Key event forwarder — called from wndProcWrapper, dispatch via delegate
    private void internalKey(uint keyCode, bool down, bool alt, bool shift, bool control)
    {
        if (_keyCallback !is null)
        {
            KeyEventData ev;
            ev.keyCode = keyCode;
            ev.down = down;
            ev.alt = alt;
            ev.shift = shift;
            ev.control = control;
            _keyCallback(ev);
        }
    }
    
    /// Set timer callback using static function pointer + user data.
    static void setTimerFunction(void function(uint id, void* data) func, Object data)
    {
        _timerFunc = func;
        _timerDataRef = data;
    }
    
    void startTimer(uint id, uint delayMs)
    {
        SetTimer(_hwnd, id, delayMs, null);
    }
    
    void stopTimer(uint id)
    {
        KillTimer(_hwnd, id);
    }
    
    private void internalTimer(uint id)
    {
        if (_timerFunc !is null)
        {
            _timerFunc(id, cast(void*)_timerDataRef);
        }
    }
    
    /// Destroy the native HWND. Called from MainWindow.close() after app logic completes.
    /// This triggers WM_DESTROY internally, but we no longer PostQuitMessage from there —
    /// the Application layer controls process exit.
    void destroy()
    {
        if (_destroyed) return;
        _destroyed = true;
        // Remove from GC-safe lookup table so stale indices don't resolve
        if (_windowTableIndex >= 0)
        {
            forgetWindow(_windowTableIndex);
            _windowTableIndex = -1;
        }
        if (_hwnd.Value !is null)
        {
            DestroyWindow(_hwnd);
            _hwnd = HWND.init;
        }
    }
    
    void show()
    {
        ShowWindow(_hwnd, SW_SHOW);
        _visible = true;
    }
    
    void hide()
    {
        ShowWindow(_hwnd, SW_HIDE);
        _visible = false;
    }
    
    bool visible() const
    {
        return _visible;
    }
    
    void* nativeHandle() const
    {
        return cast(void*)_hwnd.Value;
    }
    
    void title(string title)
    {
        _title = title;
        wstring titleW = toUTF16(title);
        SetWindowTextW(_hwnd, cast(const(PWSTR))titleW.ptr);
    }
    
    string title() const
    {
        return _title;
    }
    
    void setSize(uint width, uint height)
    {
        _width = width;
        _height = height;
        SetWindowPos(_hwnd, HWND.init, 0, 0, cast(int)width, cast(int)height, SWP_NOMOVE | SWP_NOZORDER);
    }
    
    ~this()
    {
        destroy(); // safe — checks _destroyed flag
    }
}
