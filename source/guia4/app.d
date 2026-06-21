module guia4.app;

import guia4.gfx;
import guia4.gfx_d3d12;
import guia4.platform_win32;
import guia4.guicore;
import guia4.guicore.menubar;
import guia4.guicore.combobox;
import guia4.guicore.popup;
import guia4.guicore.focusmanager;
import guia4.guicore.mousedispatcher;
import guia4.guicore.keyboarddispatcher;
import guia4.guicore.menumanager;
import guia4.guicore.comboboxmanager;
import guia4.guicore.screenshotmanager;
import guia4.utils.logger;
import std.datetime;
import std.utf;
import std.range;
import std.algorithm;
import std.stdio;
import std.string;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

import guia4.platform.types : MouseEventData, KeyEventData, WheelEventData, CharEventData;
import guia4.platform.iwindow : IPlatformWindow;
import guia4.platform_win32.win32defs : VK_TAB;

/**
 * MainWindowCallbacks — MainWindow 静态回调函数集合
 *
 * 封装 Win32 WNDPROC 所需的 C 风格静态回调，
 * 避免模块级自由函数污染命名空间。
 */
struct MainWindowCallbacks
{
    /// 静态绘制回调 — 从 WNDPROC 调用，将 HDC 转发到 MainWindow.render()
    static void paintCallback(HDC hdc, int w, int h, void* data)
    {
        logTrace("paintCallback: w=", w, " h=", h);
        auto mw = cast(MainWindow)data;
        if (mw !is null)
            mw.render(hdc, w, h);
    }

    /// 静态定时器回调 — 处理光标闪烁、异步轮询、截图等
    static void timerCallback(uint id, void* data)
    {
        auto mw = cast(MainWindow)data;
        if (mw is null) return;

        if (id == MainWindow.BLINK_TIMER_ID)
        {
            if (mw.focusedControl !is null)
            {
                auto ti = cast(TextInput)mw.focusedControl;
                if (ti !is null)
                {
                    ti.cursorTick();
                    mw.requestRedraw();
                }
                auto eb = cast(EditBox)mw.focusedControl;
                if (eb !is null)
                {
                    eb.cursorTick();
                    mw.requestRedraw();
                }
                auto gw = cast(GridWidgetBase)mw.focusedControl;
                if (gw !is null && gw.isEditing())
                {
                    mw.requestRedraw();
                }
            }
        }
        else if (id == MainWindow.ASYNC_POLL_TIMER_ID)
        {
            if (mw._asyncTask !is null)
            {
                mw._asyncTask.poll();
                if (mw._asyncTask.isComplete())
                {
                    auto onComplete = mw._asyncOnComplete;
                    mw.stopAsyncPoll();
                    if (onComplete !is null)
                        onComplete();
                }
                else if (mw._asyncOnProgress !is null)
                {
                    mw._asyncOnProgress();
                }
            }
        }
        else
        {
            mw._platformWindow.stopTimer(id);
            mw._screenshotManager.captureScreenshot(mw._screenshotManager.screenshotFile);
            if (mw._screenshotManager.closeAfterScreenshot)
            {
                mw._screenshotManager.closeAfterScreenshot = false;
                mw.close();
            }
        }
    }
}

// Static timer callback
private static void mainWindowTimerCallback(uint id, void* data)
{
    auto mw = cast(MainWindow)data;
    if (mw is null) return;

    if (id == MainWindow.BLINK_TIMER_ID)
    {
        // Recurring blink timer — toggle cursor on focused TextInput / EditBox / GridWidgetBase
        if (mw.focusedControl !is null)
        {
            auto ti = cast(TextInput)mw.focusedControl;
            if (ti !is null)
            {
                ti.cursorTick();
                mw.requestRedraw();
            }
            auto eb = cast(EditBox)mw.focusedControl;
            if (eb !is null)
            {
                eb.cursorTick();
                mw.requestRedraw();
            }
            auto gw = cast(GridWidgetBase)mw.focusedControl;
            if (gw !is null && gw.isEditing())
            {
                mw.requestRedraw();
            }
        }
    }
    else if (id == MainWindow.ASYNC_POLL_TIMER_ID)
    {
        if (mw._asyncTask !is null)
        {
            mw._asyncTask.poll();
            if (mw._asyncTask.isComplete())
            {
                auto onComplete = mw._asyncOnComplete;
                mw.stopAsyncPoll();
                if (onComplete !is null)
                    onComplete();
            }
            else if (mw._asyncOnProgress !is null)
            {
                mw._asyncOnProgress();
            }
        }
    }
    else
    {
        // One-shot timers (screenshot)
        mw._platformWindow.stopTimer(id);
        mw._screenshotManager.captureScreenshot(mw._screenshotManager.screenshotFile);
        if (mw._screenshotManager.closeAfterScreenshot)
        {
            mw._screenshotManager.closeAfterScreenshot = false;
            mw.close();
        }
    }
}

/**
 * Application - 应用程序管理类
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
 * - 协调各 Dispatcher 工作
 */
class MainWindow : Control
{
    package IPlatformWindow _platformWindow;
    private IRenderDevice _renderDevice;
    private Application _app;

    // Dispatchers
    private MouseDispatcher _mouseDispatcher;
    private KeyboardDispatcher _keyboardDispatcher;
    private MenuManager _menuManager;
    private ComboBoxManager _comboBoxManager;
    package ScreenshotManager _screenshotManager;

    // Focus state
    private FocusManager _focusManager;

    // Layer-based渲染系统
    import guia4.guicore.layercompositor;
    private LayerCompositor _compositor;
    private bool _layerSystemInitialized = false;

    // AsyncTask 轮询支持
    import guia4.guicore.asynctask : AsyncTask;
    package AsyncTask _asyncTask;
    private void delegate() _asyncOnProgress;
    private void delegate() _asyncOnComplete;

    package static immutable uint SCREENSHOT_TIMER_ID = 1001;
    package static immutable uint BLINK_TIMER_ID = 1002;
    package static immutable uint ASYNC_POLL_TIMER_ID = 1003;

    this(Application app, int x = 100, int y = 100, uint width = 800, uint height = 600, string title = "DGUI Window")
    {
        super();
        logTrace("MainWindow.ctor(app=", app !is null, ")");
        _app = app;
        _platformWindow = new Win32Window(x, y, width, height, title);
        (cast(Win32Window)_platformWindow).setPaintFunction(&MainWindowCallbacks.paintCallback, cast(Object)this);

        // 初始化 FocusManager
        _focusManager = new FocusManager();

        // 初始化 MouseDispatcher
        _mouseDispatcher = new MouseDispatcher(this);
        _mouseDispatcher.setCoordinateDelegates(&controlToClient, &clientToControl);
        _mouseDispatcher.setFocusDelegates(&setFocus, &focusedControl);
        _mouseDispatcher.setRequestRedrawDelegate(&requestRedraw);
        _platformWindow.setMouseCallback(&mouseEventHandler);

        // 初始化 KeyboardDispatcher
        _keyboardDispatcher = new KeyboardDispatcher(this, _focusManager);
        _keyboardDispatcher.setTimerDelegates(
            (uint id, uint interval) { _platformWindow.startTimer(id, interval); },
            (uint id) { _platformWindow.stopTimer(id); }
        );
        _keyboardDispatcher.setRequestRedrawDelegate(&requestRedraw);
        _platformWindow.setKeyCallback(&keyEventHandler);
        _platformWindow.setCharCallback(&charEventHandler);

        // 初始化 MenuManager
        _menuManager = new MenuManager(this);
        _menuManager.setRequestRedrawDelegate(&requestRedraw);

        // 初始化 ComboBoxManager
        _comboBoxManager = new ComboBoxManager(this);
        _comboBoxManager.setCoordinateDelegate(&controlToClient);

        // 初始化 ScreenshotManager
        _screenshotManager = new ScreenshotManager(_platformWindow.nativeHandle());

        // 其他回调
        _platformWindow.setCloseCallback({ this.close(); this.fireClose(); });
        _platformWindow.setResizeCallback({ this.onResize(); });
        _platformWindow.setWheelCallback(&wheelEventHandler);
    }

    this(int x = 100, int y = 100, uint width = 800, uint height = 600, string title = "DGUI Window")
    {
        this(null, x, y, width, height, title);
    }

    ~this()
    {
        _compositor = null;
        _renderDevice = null;
        _platformWindow = null;
        _focusManager = null;
        _mouseDispatcher = null;
        _keyboardDispatcher = null;
        _menuManager = null;
        _comboBoxManager = null;
        _screenshotManager = null;
        _app = null;
    }

    // ── 窗口生命周期 ──────────────────────────────────────

    void show()
    {
        logTrace("MainWindow.show()");
        if (_renderDevice is null)
        {
            _renderDevice = Application.createRenderDeviceStatic(_platformWindow.nativeHandle());
        }
        _platformWindow.show();

        HWND hwnd = cast(HWND)nativeHandle();
        RECT rect;
        GetClientRect(hwnd, &rect);
        int w = rect.right - rect.left;
        int h = rect.bottom - rect.top;

        super.width(w);
        super.height(h);

        if (!_layerSystemInitialized)
        {
            HDC hdc = GetDC(hwnd);
            _compositor = new LayerCompositor();
            _compositor.init(w, h, hdc);
            ReleaseDC(hwnd, hdc);
            _layerSystemInitialized = true;
            logInfo("Layer-based rendering system initialized: ", w, "x", h);
        }
        logInfo("MainWindow.show() - size set to ", w, "x", h);
    }

    void onResize()
    {
        HWND hwnd = cast(HWND)nativeHandle();
        RECT rect;
        GetClientRect(hwnd, &rect);
        int w = rect.right - rect.left;
        int h = rect.bottom - rect.top;

        logTrace("MainWindow.onResize() - new size: ", w, "x", h);

        super.width(w);
        super.height(h);

        if (_compositor !is null && _layerSystemInitialized)
        {
            HDC hdc = GetDC(hwnd);
            _compositor.init(w, h, hdc);
            ReleaseDC(hwnd, hdc);
        }

        foreach (child; children())
        {
            if (child.visible())
                child.markDirty();
        }

        InvalidateRect(hwnd, null, cast(BOOL)0);
    }

    void hide()
    {
        logTrace("MainWindow.hide()");
        _platformWindow.hide();
    }

    void close()
    {
        logTrace("MainWindow.close()");

        if (_compositor !is null)
            _compositor.destroy();

        if (_app !is null)
            _app.removeWindow(this);
        hide();
        _platformWindow.destroy();

        logTrace("MainWindow.close() - all resources cleaned up");
    }

    // ── 属性 ──────────────────────────────────────────────

    void title(string title) { _platformWindow.title(title); }
    string title() const { return _platformWindow.title(); }

    void setSize(uint w, uint h)
    {
        _platformWindow.setSize(w, h);
        if (_renderDevice)
            _renderDevice.resize(w, h);
    }

    void* nativeHandle() const { return _platformWindow.nativeHandle(); }
    IRenderDevice renderDevice() { return _renderDevice; }

    Control focusedControl() @property { return _focusManager.focusedControl; }
    void setFocus(Control ctrl) { _keyboardDispatcher.setFocus(ctrl); }

    // ── 截图 ──────────────────────────────────────────────

    void captureScreenshot(string filename = "screenshot.bmp")
    {
        _screenshotManager.captureScreenshot(filename);
    }

    void scheduleScreenshot(int delayMs = 2000, string filename = "screenshot.bmp")
    {
        logTrace("MainWindow.scheduleScreenshot(delayMs=", delayMs, ")");
        _screenshotManager.setScreenshotFile(filename);
        _screenshotManager.closeAfterScreenshot = false;
        (cast(Win32Window)_platformWindow).setTimerFunction(&MainWindowCallbacks.timerCallback, cast(Object)this);
        _platformWindow.startTimer(SCREENSHOT_TIMER_ID, delayMs);
    }

    void scheduleScreenshotAndClose(int delayMs = 500, string filename = "screenshot.bmp")
    {
        logTrace("MainWindow.scheduleScreenshotAndClose(delayMs=", delayMs, ")");
        _screenshotManager.setScreenshotFile(filename);
        _screenshotManager.closeAfterScreenshot = true;
        (cast(Win32Window)_platformWindow).setTimerFunction(&MainWindowCallbacks.timerCallback, cast(Object)this);
        _platformWindow.startTimer(SCREENSHOT_TIMER_ID, delayMs);
    }

    void captureImmediate(string filename)
    {
        logInfo("MainWindow.captureImmediate('", filename, "')");
        _screenshotManager.setScreenshotFile(filename);
        _screenshotManager.captureScreenshot(filename);
    }

    // ── AsyncTask ─────────────────────────────────────────

    void startAsyncTask(AsyncTask task, void delegate() onProgress, void delegate() onComplete)
    {
        _asyncTask = task;
        _asyncOnProgress = onProgress;
        _asyncOnComplete = onComplete;
        (cast(Win32Window)_platformWindow).setTimerFunction(&MainWindowCallbacks.timerCallback, cast(Object)this);
        _platformWindow.startTimer(ASYNC_POLL_TIMER_ID, 50);
        logInfo("AsyncTask polling started");
    }

    void stopAsyncPoll()
    {
        _platformWindow.stopTimer(ASYNC_POLL_TIMER_ID);
        _asyncTask = null;
        _asyncOnProgress = null;
        _asyncOnComplete = null;
        logInfo("AsyncTask polling stopped");
    }

    // ── 坐标转换 ──────────────────────────────────────────

    private void controlToClient(Control ctrl, out int absX, out int absY)
    {
        ctrl.controlToClient(absX, absY);
    }

    private void clientToControl(Control ctrl, int clientX, int clientY, out int localX, out int localY)
    {
        ctrl.clientToControl(clientX, clientY, localX, localY);
    }

    // ── 事件处理（委托给 Dispatcher）─────────────────────

    private void mouseEventHandler(ref MouseEventData ev)
    {
        _mouseDispatcher.handleMouseEvent(ev);

        // 菜单处理
        if (ev.down)
        {
            Control target = _mouseDispatcher.hitTestChild(this, ev.x, ev.y);
            if (target is null) target = this;

            bool clickedSubItem = _menuManager.handleClickOnSubItem(ev.x, ev.y);
            if (!clickedSubItem && !_menuManager.isMenuArea(ev.x, ev.y, target))
                _menuManager.closeAllMenus();

            // ComboBox 下拉列表处理
            auto comboHit = _comboBoxManager.findOpenComboBox(ev.x, ev.y);
            if (comboHit !is null)
            {
                int comboAbsX, comboAbsY;
                controlToClient(comboHit, comboAbsX, comboAbsY);
                if (ev.y >= comboAbsY && ev.y < comboAbsY + comboHit.height() &&
                    ev.x >= comboAbsX && ev.x < comboAbsX + comboHit.width())
                {
                    requestRedraw();
                    return;
                }
                comboHit.handleDropDownClick(ev.x, ev.y, comboAbsX, comboAbsY);
                requestRedraw();
                return;
            }
        }
        else if (ev.move)
        {
            // 更新菜单悬停
            foreach (child; children())
            {
                auto mb = cast(MenuBar)child;
                if (mb !is null && mb.hasOpenMenu())
                    _menuManager.updateSubMenuHover(mb, ev.x, ev.y);
            }
            _comboBoxManager.updateDropDownHover(ev.x, ev.y);
        }

        // 鼠标事件处理完毕，触发重绘（处理点击导致的状态变化）
        requestRedraw();
    }

    private void keyEventHandler(ref KeyEventData ev)
    {
        _keyboardDispatcher.handleKeyEvent(ev);
    }

    private void charEventHandler(ref CharEventData ev)
    {
        _keyboardDispatcher.handleCharEvent(ev);
    }

    private void wheelEventHandler(ref WheelEventData ev)
    {
        logTrace("MainWindow.wheelEventHandler(x=", ev.x, ", y=", ev.y, ")");
        auto hovered = _mouseDispatcher.hoveredControl;
        if (hovered !is null && hovered !is this)
            hovered.fireMouseWheel(ev.delta, ev.hDelta, ev.x, ev.y);
        requestRedraw();
    }

    // ── 渲染 ──────────────────────────────────────────────

    void requestRedraw()
    {
        HWND hwnd = cast(HWND)nativeHandle();
        if (hwnd.Value !is null)
        {
            RedrawWindow(hwnd, null, cast(HRGN)null, RDW_INVALIDATE | RDW_UPDATENOW);
        }
    }

    void render(HDC hdc, int width, int height)
    {
        logTrace("MainWindow.render: width=", width, " height=", height);

        if (this.width() != width || this.height() != height)
        {
            super.width(width);
            super.height(height);
        }

        this.ensureLayout();

        // 使用全局脏计数器避免 O(N) 递归检查
        bool hasDirty = Control.hasAnyDirty();

        if (!hasDirty)
        {
            BitBlt(hdc, 0, 0, width, height, _compositor.historyDC(), 0, 0, SRCCOPY);
            return;
        }

        // Layer-based渲染
        auto allControls = children();
        _compositor.render(hdc, allControls, hasDirty);

        // 渲染 ComboBox 下拉列表
        _comboBoxManager.renderDropDowns(hdc);

        // 清除脏标记
        clearDirty();
        void clearDirtyRecursive(Control ctrl)
        {
            ctrl.clearDirty();
            foreach (child; ctrl.children())
                clearDirtyRecursive(child);
        }
        foreach (child; children())
            clearDirtyRecursive(child);
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
