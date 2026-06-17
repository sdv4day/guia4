module guia4.platform_win32.win32window;

import guia4.platform.iwindow;
import guia4.platform.types;
import guia4.platform_win32.win32defs;
import guia4.utils.logger;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;
import windows.win32.graphics.gdi;
import std.utf;

// 注意：不导入 windows.win32.ui.input.keyboardandmouse，避免 VK_* 常量冲突
// 只导入需要的函数和类型
import windows.win32.ui.input.keyboardandmouse : TrackMouseEvent, GetKeyState, TRACKMOUSEEVENT, TME_LEAVE;

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
enum WM_CHAR = 0x0102;

enum WM_MOUSEWHEEL = 0x020A;
enum WM_MOUSEHWHEEL = 0x020E;  // 横向滚轮消息

enum GWLP_USERDATA = -21;

enum COLOR_WINDOW = 5;
enum IDC_ARROW = 32512;

// 注意：TRACKMOUSEEVENT 结构体、TrackMouseEvent、GetKeyState 已从 windows.win32.ui.input.keyboardandmessaging 导入
// GetWindowLongPtrW、SetWindowLongPtrW 在标准库中只在 X86 版本下定义，需要手动声明

// 事件数据结构已移至 guia4.platform.types，此处通过 import guia4.platform.types 引用

// GetModuleHandleW 在 winlib 中未声明，需要手动声明
extern(Windows) HINSTANCE GetModuleHandleW(const(PWSTR) lpModuleName);

// GetWindowLongPtrW、SetWindowLongPtrW 在标准库中只在 X86 版本下定义，需要手动声明
extern(Windows) LONG_PTR GetWindowLongPtrW(HWND hWnd, int nIndex);
extern(Windows) LONG_PTR SetWindowLongPtrW(HWND hWnd, int nIndex, LONG_PTR dwNewLong);

// HOVER_DEFAULT 在 winlib 中未定义，需要手动定义
enum HOVER_DEFAULT = 0xFFFFFFFF;

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

class Win32Window : IPlatformWindow
{
    HWND _hwnd;
    string _title;
    int _x, _y;
    uint _width, _height;
    bool _visible;
    bool _destroyed = false; // true after DestroyWindow called

    // 实例级回调 — 每个窗口独立，支持多窗口
    private void function(HDC hdc, int w, int h, void* data) _paintFunc;
    private Object _paintDataRef;
    private void function(uint id, void* data) _timerFunc;
    private Object _timerDataRef;
    
    // Index into __gshared _windowTable for GC-safe Win32→D lookup.
    // -1 = not registered in the table.
    private int _windowTableIndex = -1;
    
    void delegate() _closeCallback;
    void delegate() _resizeCallback;
    void delegate(ref MouseEventData) _mouseCallback;
    void delegate(ref KeyEventData) _keyCallback;
    void delegate(ref WheelEventData) _wheelCallback;
    void delegate(ref CharEventData) _charCallback;
    void delegate() _redrawCallback;
    
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
        // 创建可变的wchar数组以匹配PWSTR类型
        wchar[] classNameBuf = _className.dup;
        wchar[] titleBuf = titleW.dup;
        
        _hwnd = CreateWindowExW(
            0,
            cast(const(PWSTR))classNameBuf.ptr,
            cast(const(PWSTR))titleBuf.ptr,
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

            case WM_SIZE:
            {
                // 窗口大小改变时触发回调，更新布局
                if (window !is null)
                {
                    // 更新 Win32Window 内部的大小记录
                    window._width = cast(uint)lParamX(lparam);
                    window._height = cast(uint)lParamY(lparam);
                    
                    // 调用 resize 回调（MainWindow.onResize）
                    if (window._resizeCallback !is null)
                    {
                        window._resizeCallback();
                    }
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
            
            case WM_CHAR:
            {
                if (window !is null)
                {
                    wchar code = cast(wchar)(wparam.Value & 0xFFFF);
                    window.internalChar(cast(dchar)code);
                }
                return LRESULT(0);
            }
            
            case WM_MOUSEWHEEL:
            {
                if (window !is null)
                {
                    int delta = cast(short)((wparam.Value >> 16) & 0xFFFF);
                    // WM_MOUSEWHEEL gives screen coordinates; convert to client
                    POINT pt;
                    pt.x = lParamX(lparam);
                    pt.y = lParamY(lparam);
                    ScreenToClient(hwnd, &pt);
                    window.internalWheel(cast(int)pt.x, cast(int)pt.y, delta, 0);
                }
                return LRESULT(0);
            }
            
            case WM_MOUSEHWHEEL:
            {
                if (window !is null)
                {
                    int hDelta = cast(short)((wparam.Value >> 16) & 0xFFFF);
                    // WM_MOUSEHWHEEL gives screen coordinates; convert to client
                    POINT pt;
                    pt.x = lParamX(lparam);
                    pt.y = lParamY(lparam);
                    ScreenToClient(hwnd, &pt);
                    window.internalWheel(cast(int)pt.x, cast(int)pt.y, 0, hDelta);
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
        logTrace("Win32Window.internalPaint called");
        PAINTSTRUCT ps;
        HDC hdc = BeginPaint(hwnd, &ps);
        
        // Use GetClientRect for correct client-area dimensions (not the window dimensions
        // which include title bar and borders).
        RECT cr;
        GetClientRect(hwnd, &cr);
        int cw = cr.right - cr.left;
        int ch = cr.bottom - cr.top;
        
        if (_paintFunc !is null)
        {
            // Derive void* from GC-scanned Object ref — ensures the address is always valid
            // even after GC compaction moves the object in memory.
            _paintFunc(hdc, cw, ch, cast(void*)_paintDataRef);
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
    /// Instance method — each window has its own paint callback, supporting multi-window.
    void setPaintFunction(void function(HDC hdc, int w, int h, void* data) func, Object data)
    {
        _paintFunc = func;
        _paintDataRef = data;
    }
    
    void setCloseCallback(void delegate() callback)
    {
        _closeCallback = callback;
    }
    
    void setResizeCallback(void delegate() callback)
    {
        _resizeCallback = callback;
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
        TrackMouseEvent(&tme);
    }
    
    void setMouseCallback(void delegate(ref MouseEventData) callback)
    {
        _mouseCallback = callback;
    }
    
    void setKeyCallback(void delegate(ref KeyEventData) callback)
    {
        _keyCallback = callback;
    }
    
    void setWheelCallback(void delegate(ref WheelEventData) callback)
    {
        _wheelCallback = callback;
    }
    
    void setCharCallback(void delegate(ref CharEventData) callback)
    {
        _charCallback = callback;
    }
    
    void setRedrawCallback(void delegate() callback)
    {
        _redrawCallback = callback;
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
    
    // Wheel event forwarder — called from wndProcWrapper
    private void internalWheel(int x, int y, int delta, int hDelta)
    {
        if (_wheelCallback !is null)
        {
            WheelEventData ev;
            ev.x = x;
            ev.y = y;
            ev.delta = delta;
            ev.hDelta = hDelta;
            _wheelCallback(ev);
        }
    }
    
    // Char event forwarder — called from wndProcWrapper
    private void internalChar(dchar ch)
    {
        if (_charCallback !is null)
        {
            CharEventData ev;
            ev.ch = ch;
            _charCallback(ev);
        }
    }
    
    /// Set timer callback using static function pointer + user data.
    /// Instance method — each window has its own timer callback, supporting multi-window.
    void setTimerFunction(void function(uint id, void* data) func, Object data)
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
    
    bool visible() const nothrow
    {
        return _visible;
    }
    
    void* nativeHandle() const nothrow
    {
        return cast(void*)_hwnd.Value;
    }
    
    void title(string title)
    {
        _title = title;
        wstring titleW = toUTF16(title);
        wchar[] titleBuf = titleW.dup;
        SetWindowTextW(_hwnd, cast(const(PWSTR))titleBuf.ptr);
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
    
    void setPosition(int x, int y)
    {
        _x = x;
        _y = y;
        SetWindowPos(_hwnd, HWND.init, x, y, 0, 0, SWP_NOSIZE | SWP_NOZORDER);
    }
    
    int x() const nothrow
    {
        return _x;
    }
    
    int y() const nothrow
    {
        return _y;
    }
    
    uint width() const nothrow
    {
        return _width;
    }
    
    uint height() const nothrow
    {
        return _height;
    }
    
    /**
     * 析构函数 — 仅标记对象为已销毁
     * 
     * 注意：不在析构函数中调用 Win32 API（如 DestroyWindow），
     * 因为 GC 可能在 D 运行时的模块析构阶段析构对象，此时调用
     * Win32 API 可能导致访问冲突。
     * 
     * 正确的做法是在程序退出前显式调用 destroy() 方法。
     */
    ~this()
    {
        // 仅标记为已销毁，不调用 Win32 API
        _destroyed = true;
        // 从查找表中移除，避免悬空引用
        if (_windowTableIndex >= 0)
        {
            forgetWindow(_windowTableIndex);
            _windowTableIndex = -1;
        }
    }
}
