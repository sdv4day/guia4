module guia4.app;

import guia4.gfx;
import guia4.gfx_d3d12;
import guia4.platform_win32;
import guia4.guicore;
import guia4.utils.logger;
import std.datetime;
import std.utf;
import std.range;
import std.stdio;
import std.string;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

// Re-import the mouse event data struct from win32window so MainWindow can use it
import guia4.platform_win32.win32window : MouseEventData, KeyEventData, VK_TAB;

alias LONG = int;

// Static paint callback — called from WNDPROC via module-level __gshared function pointer.
// Casts user data (MainWindow*) back to MainWindow and calls render().
// This is the only mechanism proven to work from WNDPROC context
// (field function pointers → crash, delegates → body not executed).
private static void mainWindowPaintCallback(HDC hdc, int w, int h, void* data)
{
    auto mw = cast(MainWindow)data;
    if (mw !is null)
    {
        mw.render(hdc, w, h);
    }
}

// Static timer callback — called from WNDPROC via module-level __gshared function pointer.
private static void mainWindowTimerCallback(uint id, void* data)
{
    auto mw = cast(MainWindow)data;
    if (mw !is null)
    {
        mw._platformWindow.stopTimer(id);
        mw.captureScreenshot(mw._screenshotFile);
    }
}

/**
 * Application - 应用程序管理类
 * 
 * 职责：
 * - 管理平台层消息循环
 * - 管理所有 MainWindow 窗口
 * - 窗口生命周期管理（最后一个窗口关闭时退出应用）
 */
class Application
{
    private Win32Application _platformApp;
    private D3D12RenderDevice _renderDevice;
    private MainWindow[] _windows;
    
    this()
    {
        logTrace("Application.ctor()");
        _platformApp = new Win32Application();
        logInfo("Application initialized");
    }
    
    int run()
    {
        logTrace("Application.run()");
        if (_windows.empty)
        {
            logWarning("No windows created. Application will exit immediately.");
            return 0;
        }
        logInfo("Starting application message loop");
        int result = _platformApp.run();
        logInfo("Application exited with code: ", result);
        return result;
    }
    
    void quit(int exitCode = 0)
    {
        logTrace("Application.quit(", exitCode, ")");
        _platformApp.quit(exitCode);
    }
    
    MainWindow createWindow(int x = 100, int y = 100, uint width = 800, uint height = 600, string title = "DGUI Window")
    {
        logTrace("Application.createWindow(x=", x, ", y=", y, ", width=", width, ", height=", height, ", title='", title, "')");
        auto window = new MainWindow(this, x, y, width, height, title);
        _windows ~= window;
        logInfo("Window created, total windows: ", _windows.length);
        return window;
    }
    
    void removeWindow(MainWindow window)
    {
        logTrace("Application.removeWindow()");
        foreach (i; 0 .. _windows.length)
        {
            if (_windows[i] is window)
            {
                _windows = _windows[0 .. i] ~ _windows[i+1 .. $];
                logInfo("Window removed, remaining windows: ", _windows.length);
                break;
            }
        }
        
        if (_windows.empty)
        {
            logInfo("No more windows, quitting application");
            quit();
        }
    }
    
    IRenderDevice createRenderDevice(void* hwnd)
    {
        _renderDevice = new D3D12RenderDevice(hwnd);
        return _renderDevice;
    }
    
    static IRenderDevice createRenderDeviceStatic(void* hwnd)
    {
        return new D3D12RenderDevice(hwnd);
    }
}

/**
 * MainWindow - 主窗口类
 * 
 * 职责：
 * - 关联平台层窗口（Win32Window）
 * - 关联渲染设备（IRenderDevice）
 * - 作为控件树的根节点
 * - 处理平台事件并分发给控件
 */
class MainWindow : Control
{
    private Win32Window _platformWindow;
    private IRenderDevice _renderDevice;
    private Application _app;
    
    // Mouse dispatch state
    private Control _capturedControl;  // control that received mouse-down (for click detection)
    private Control _hoveredControl;   // control currently under cursor
    
    // Focus state
    private Control _focusedControl;   // control currently holding keyboard focus
    
    this(Application app, int x = 100, int y = 100, uint width = 800, uint height = 600, string title = "DGUI Window")
    {
        super();
        logTrace("MainWindow.ctor(app=", app !is null, ", x=", x, ", y=", y, ", width=", width, ", height=", height, ", title='", title, "')");
        _app = app;
        _platformWindow = new Win32Window(x, y, width, height, title);
        _platformWindow.setPaintFunction(&mainWindowPaintCallback, cast(Object)this);
        _platformWindow.setCloseCallback({ this.close(); this.fireClose(); });
        _platformWindow.setMouseCallback(&mouseEventHandler);
        _platformWindow.setKeyCallback(&keyEventHandler);
        _renderDevice = null;
    }
    
    this(int x = 100, int y = 100, uint width = 800, uint height = 600, string title = "DGUI Window")
    {
        this(null, x, y, width, height, title);
    }
    
    void show()
    {
        logTrace("MainWindow.show()");
        if (_renderDevice is null)
        {
            _renderDevice = Application.createRenderDeviceStatic(_platformWindow.nativeHandle());
        }
        _platformWindow.show();
        logInfo("Window shown");
    }
    
    void hide()
    {
        logTrace("MainWindow.hide()");
        _platformWindow.hide();
    }
    
    void close()
    {
        logTrace("MainWindow.close()");
        if (_app !is null)
        {
            _app.removeWindow(this);
        }
        hide();
        // Destroy the native HWND after app lifecycle logic (removeWindow, hide).
        // This triggers WM_DESTROY, but PostQuitMessage is no longer called there —
        // the Application layer (removeWindow → quit) handles process exit.
        _platformWindow.destroy();
    }
    
    void title(string title)
    {
        _platformWindow.title(title);
    }
    
    string title() const
    {
        return _platformWindow.title();
    }
    
    void setSize(uint w, uint h)
    {
        _platformWindow.setSize(w, h);
        if (_renderDevice)
        {
            _renderDevice.resize(w, h);
        }
    }
    
    void* nativeHandle() const
    {
        return _platformWindow.nativeHandle();
    }
    
    IRenderDevice renderDevice()
    {
        return _renderDevice;
    }
    
    void captureScreenshot(string filename = "screenshot.bmp")
    {
        logInfo("MainWindow.captureScreenshot('", filename, "') - ENTERED");
        HWND hwnd = cast(HWND)nativeHandle();
        
        HDC hdcScreen = GetDC(hwnd);
        HDC hdcMemDC = CreateCompatibleDC(hdcScreen);
        
        RECT rect;
        GetClientRect(hwnd, &rect);
        int width = rect.right - rect.left;
        int height = rect.bottom - rect.top;
        
        HBITMAP hBitmap = CreateCompatibleBitmap(hdcScreen, width, height);
        HGDIOBJ hOldBitmap = SelectObject(hdcMemDC, cast(HGDIOBJ)hBitmap);
        
        BitBlt(hdcMemDC, 0, 0, width, height, hdcScreen, 0, 0, 0x00CC0020);
        
        BITMAPINFOHEADER bi;
        bi.biSize = BITMAPINFOHEADER.sizeof;
        bi.biWidth = width;
        bi.biHeight = -height;
        bi.biPlanes = 1;
        bi.biBitCount = 32;
        bi.biCompression = 0;
        bi.biSizeImage = 0;
        bi.biXPelsPerMeter = 0;
        bi.biYPelsPerMeter = 0;
        bi.biClrUsed = 0;
        bi.biClrImportant = 0;
        
        int bufferSize = width * height * 4;
        ubyte[] buffer = new ubyte[bufferSize];
        GetDIBits(hdcScreen, hBitmap, 0, cast(uint)height, buffer.ptr, cast(BITMAPINFO*)&bi, 0);
        
        FILE* file = fopen(filename.toStringz(), "wb");
        if (file !is null)
        {
            BITMAPFILEHEADER bf;
            bf.bfType = 0x4D42;
            bf.bfSize = cast(uint)(BITMAPFILEHEADER.sizeof + BITMAPINFOHEADER.sizeof + bufferSize);
            bf.bfReserved1 = 0;
            bf.bfReserved2 = 0;
            bf.bfOffBits = BITMAPFILEHEADER.sizeof + BITMAPINFOHEADER.sizeof;
            
            fwrite(&bf, BITMAPFILEHEADER.sizeof, 1, file);
            fwrite(&bi, BITMAPINFOHEADER.sizeof, 1, file);
            fwrite(buffer.ptr, bufferSize, 1, file);
            fclose(file);
            
            logInfo("Screenshot saved to: ", filename);
        }
        else
        {
            logError("Failed to open file for screenshot: ", filename);
        }
        
        SelectObject(hdcMemDC, hOldBitmap);
        DeleteObject(cast(HGDIOBJ)hBitmap);
        DeleteDC(hdcMemDC);
        ReleaseDC(hwnd, hdcScreen);
        logInfo("MainWindow.captureScreenshot() - COMPLETED");
    }
    
    void scheduleScreenshot(int delayMs = 2000, string filename = "screenshot.bmp")
    {
        logTrace("MainWindow.scheduleScreenshot(delayMs=", delayMs, ", '", filename, "')");
        _screenshotFile = filename;
        Win32Window.setTimerFunction(&mainWindowTimerCallback, cast(Object)this);
        _platformWindow.startTimer(SCREENSHOT_TIMER_ID, delayMs);
    }
    
    private string _screenshotFile;
    private static immutable uint SCREENSHOT_TIMER_ID = 1001;
    
    // Immediate screenshot - call from show() before message loop
    void captureImmediate(string filename)
    {
        logInfo("MainWindow.captureImmediate('", filename, "')");
        _screenshotFile = filename;
        captureScreenshot(filename);
    }
    
    /// Compute absolute coordinates (window client space) for a control
    private void controlAbsolutePos(Control ctrl, out int absX, out int absY)
    {
        absX = 0;
        absY = 0;
        Control cur = ctrl;
        while (cur !is null)
        {
            absX += cur.x();
            absY += cur.y();
            cur = cur.parent();
        }
    }
    
    /// Translate client-space coordinates to control-local coordinates
    private void clientToControl(Control ctrl, int clientX, int clientY, out int localX, out int localY)
    {
        int absX, absY;
        controlAbsolutePos(ctrl, absX, absY);
        localX = clientX - absX;
        localY = clientY - absY;
    }
    
    /// Mouse event dispatch from Win32Window.
    /// Performs hit-test on children, tracks capture (for click detection) and hover.
    private void mouseEventHandler(ref MouseEventData ev)
    {
        logTrace("MainWindow.mouseEventHandler(x=", ev.x, ", y=", ev.y, ", down=", ev.down, ", move=", ev.move, ", leave=", ev.leave, ")");
        
        if (ev.leave)
        {
            // Cursor left the window entirely — send hover-end to tracked control
            if (_hoveredControl !is null && _hoveredControl !is this)
            {
                _hoveredControl.fireMouseMove(-1, -1);
            }
            _hoveredControl = null;
            _capturedControl = null;
            return;
        }
        
        // Find the deepest visible child at this point (using absolute client coordinates)
        Control target = hitTestChild(this, ev.x, ev.y);
        if (target is null)
            target = this;
        
        if (ev.down)
        {
            // Mouse button pressed
            _capturedControl = target;
            // Click-to-focus: set keyboard focus to the clicked control if focusable
            if (target.focusable())
                setFocus(target);
            int localX, localY;
            clientToControl(target, ev.x, ev.y, localX, localY);
            target.fireMouseDown(localX, localY, ev.button);
        }
        else if (!ev.move)
        {
            // Mouse button released
            if (_capturedControl !is null)
            {
                int localX, localY;
                clientToControl(_capturedControl, ev.x, ev.y, localX, localY);
                _capturedControl.fireMouseUp(localX, localY, ev.button);
                // Click detection: mouse-up on the same control that received mouse-down
                if (_capturedControl is target)
                {
                    _capturedControl.fireClick(localX, localY);
                }
            }
            _capturedControl = null;
        }
        else
        {
            // Mouse move
            if (target !is _hoveredControl)
            {
                // Leave previous hovered control — send fireMouseMove with (-1,-1) sentinel
                if (_hoveredControl !is null && _hoveredControl !is this)
                {
                    _hoveredControl.fireMouseMove(-1, -1);
                }
                // Enter new hovered control
                _hoveredControl = target;
            }
            int localX, localY;
            clientToControl(target, ev.x, ev.y, localX, localY);
            target.fireMouseMove(localX, localY);
        }
    }
    
    /// Set keyboard focus to a specific control.
    void setFocus(Control ctrl)
    {
        if (_focusedControl is ctrl) return;
        // Remove focus from previous
        if (_focusedControl !is null && _focusedControl !is this)
            _focusedControl.hasFocus(false);
        // Grant focus to new
        _focusedControl = ctrl;
        if (_focusedControl !is null && _focusedControl !is this)
            _focusedControl.hasFocus(true);
        logTrace("MainWindow.setFocus() -> ", _focusedControl !is null ? _focusedControl.toString() : "null");
    }
    
    /// Collect all focusable controls in tab order via depth-first traversal.
    private void collectFocusable(Control parent, ref Control[] list)
    {
        foreach (child; parent.children())
        {
            if (!child.visible()) continue;
            if (child.focusable())
                list ~= child;
            collectFocusable(child, list);
        }
    }
    
    /// Move focus to next focusable control (Tab), or previous (Shift+Tab).
    private void cycleFocus(bool reverse = false)
    {
        Control[] focusable;
        collectFocusable(this, focusable);
        if (focusable.length == 0) return;
        
        int idx = -1;
        foreach (i, c; focusable)
        {
            if (c is _focusedControl) { idx = cast(int)i; break; }
        }
        
        if (reverse)
            idx = (idx <= 0) ? cast(int)(focusable.length - 1) : idx - 1;
        else
            idx = (idx < 0 || idx >= cast(int)(focusable.length - 1)) ? 0 : idx + 1;
        
        setFocus(focusable[idx]);
    }
    
    /// Keyboard event handler — dispatch key events to focused control.
    private void keyEventHandler(ref KeyEventData ev)
    {
        logTrace("MainWindow.keyEventHandler(keyCode=", ev.keyCode, " down=", ev.down, ")");
        
        if (!ev.down) return; // we only care about key-down events
        
        // Tab / Shift+Tab → cycle focus
        if (ev.keyCode == VK_TAB)
        {
            cycleFocus(ev.shift);
            return;
        }
        
        // Forward to focused control
        if (_focusedControl !is null)
        {
            _focusedControl.fireKeyDown(ev.keyCode);
        }
    }
    
    /// Hit-test children recursively.
    /// px,py are relative to `parent`. Returns deepest matching Control or null.
    private Control hitTestChild(Control parent, int px, int py)
    {
        // Iterate in reverse (last child drawn on top = first to receive events)
        auto children = parent.children();
        for (int i = cast(int)children.length - 1; i >= 0; i--)
        {
            auto child = children[i];
            if (!child.visible())
                continue;
            // child.hitTest uses child's own coordinate space (relative to its parent)
            if (child.hitTest(px, py))
            {
                // Recurse with coordinates relative to this child
                auto deeper = hitTestChild(child, px - child.x(), py - child.y());
                if (deeper !is null)
                    return deeper;
                return child;
            }
        }
        return null;
    }
    
    void render(HDC hdc, int width, int height)
    {
        RECT rect = {0, 0, width, height};
        
        HBRUSH brush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);
        
        foreach (child; children())
        {
            if (child.visible())
            {
                child.renderWithGDI(hdc);
            }
        }
    }
    
    void captureWindow()
    {
        HWND hwnd = cast(HWND)_platformWindow.nativeHandle();
        HDC hdc = GetDC(hwnd);
        
        RECT rect;
        GetClientRect(hwnd, &rect);
        
        render(hdc, rect.right - rect.left, rect.bottom - rect.top);
        
        ReleaseDC(hwnd, hdc);
    }
}
