module guia4.app;

import guia4.gfx;
import guia4.gfx_d3d12;
import guia4.platform_win32;
import guia4.guicore;
import guia4.guicore.menubar;
import guia4.guicore.combobox;
import guia4.guicore.popup;
import guia4.guicore.focusmanager;
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

// Re-import the mouse event data struct from platform types so MainWindow can use it
import guia4.platform.types : MouseEventData, KeyEventData, WheelEventData, CharEventData;
import guia4.platform.iwindow : IPlatformWindow;
import guia4.platform_win32.win32defs : VK_TAB;

// Static paint callback — called from WNDPROC via instance-level function pointer.
// Casts user data (MainWindow*) back to MainWindow and calls render().
// This is the only mechanism proven to work from WNDPROC context
// (field function pointers → crash, delegates → body not executed).
private static void mainWindowPaintCallback(HDC hdc, int w, int h, void* data)
{
    logTrace("mainWindowPaintCallback: w=", w, " h=", h);
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
    if (mw is null) return;

    if (id == MainWindow.BLINK_TIMER_ID)
    {
        // Recurring blink timer — toggle cursor on focused TextInput / EditBox
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
        }
    }
    else if (id == MainWindow.ASYNC_POLL_TIMER_ID)
    {
        // AsyncTask 进度轮询 — 非阻塞收取后台线程消息
        if (mw._asyncTask !is null)
        {
            mw._asyncTask.poll();
            if (mw._asyncTask.isComplete())
            {
                // 先保存回调，再停止轮询（stopAsyncPoll 会清空回调）
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
        // One-shot timers (e.g. screenshot)
        mw._platformWindow.stopTimer(id);
        mw.captureScreenshot(mw._screenshotFile);
        if (mw._closeAfterScreenshot)
        {
            mw._closeAfterScreenshot = false;
            mw.close();
        }
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
    private IPlatformWindow _platformWindow;
    private IRenderDevice _renderDevice;
    private Application _app;
    
    // Mouse dispatch state
    private Control _capturedControl;  // control that received mouse-down (for click detection)
    private Control _hoveredControl;   // control currently under cursor

    // Focus state
    private FocusManager _focusManager;  // 焦点管理器

    // ── Layer-based渲染系统 ────────────────────────────────────────
    import guia4.guicore.layercompositor;
    private LayerCompositor _compositor;   // Layer合并引擎
    private bool _layerSystemInitialized = false;
    
    
    this(Application app, int x = 100, int y = 100, uint width = 800, uint height = 600, string title = "DGUI Window")
    {
        super();
        logTrace("MainWindow.ctor(app=", app !is null, ", x=", x, ", y=", y, ", width=", width, ", height=", height, ", title='", title, "')");
        _app = app;
        _platformWindow = new Win32Window(x, y, width, height, title);
        (cast(Win32Window)_platformWindow).setPaintFunction(&mainWindowPaintCallback, cast(Object)this);
        _platformWindow.setCloseCallback({ this.close(); this.fireClose(); });
        _platformWindow.setResizeCallback({ this.onResize(); });
        _platformWindow.setMouseCallback(&mouseEventHandler);
        _platformWindow.setKeyCallback(&keyEventHandler);
        _platformWindow.setWheelCallback(&wheelEventHandler);
        _platformWindow.setCharCallback(&charEventHandler);
        _focusManager = new FocusManager();
        _renderDevice = null;
    }
    
    this(int x = 100, int y = 100, uint width = 800, uint height = 600, string title = "DGUI Window")
    {
        this(null, x, y, width, height, title);
    }
    
    /**
     * 析构函数 — RAII资源清理
     * 
     * 注意：不在析构函数中调用 Win32 API（如 DestroyWindow），
     * 因为 GC 可能在 D 运行时的模块析构阶段析构对象，此时调用
     * Win32 API 可能导致访问冲突。
     * 
     * 正确的做法是在程序退出前显式调用 close() 方法。
     */
    ~this()
    {
        logTrace("MainWindow.~this() - marking resources as destroyed");
        
        // 仅标记资源为 null，不调用 Win32 API
        // 实际的资源清理应该在 close() 中完成
        _compositor = null;
        _renderDevice = null;
        _platformWindow = null;
        _focusManager = null;
        _capturedControl = null;
        _hoveredControl = null;
        _app = null;
        
        logTrace("MainWindow.~this() - cleanup complete");
    }
    
    void show()
    {
        logTrace("MainWindow.show()");
        if (_renderDevice is null)
        {
            _renderDevice = Application.createRenderDeviceStatic(_platformWindow.nativeHandle());
        }
        _platformWindow.show();
        
        // 获取窗口客户区大小并设置到自身
        HWND hwnd = cast(HWND)nativeHandle();
        RECT rect;
        GetClientRect(hwnd, &rect);
        int w = rect.right - rect.left;
        int h = rect.bottom - rect.top;
        
        // 设置 MainWindow 自身的大小（布局系统依赖这个）
        // 注意：使用 super.width/height 来设置基类的私有字段
        super.width(w);
        super.height(h);
        
        // 初始化Layer-based渲染系统
        if (!_layerSystemInitialized)
        {
            HDC hdc = GetDC(hwnd);
            
            // 创建Layer合并引擎
            _compositor = new LayerCompositor();
            _compositor.init(w, h, hdc);
            
            ReleaseDC(hwnd, hdc);
            _layerSystemInitialized = true;
            
            logInfo("Layer-based rendering system initialized: ", w, "x", h);
        }
        
        logInfo("MainWindow.show() - size set to ", w, "x", h);
    }
    
    /**
     * 处理窗口大小变化
     * 
     * 当窗口大小改变时（WM_SIZE），更新 MainWindow 的大小，
     * 更新 LayerCompositor 的大小，并触发子控件的重新布局。
     */
    void onResize()
    {
        // 获取新的窗口客户区大小
        HWND hwnd = cast(HWND)nativeHandle();
        RECT rect;
        GetClientRect(hwnd, &rect);
        int w = rect.right - rect.left;
        int h = rect.bottom - rect.top;
        
        logTrace("MainWindow.onResize() - new size: ", w, "x", h);
        
        // 更新 MainWindow 自身的大小
        super.width(w);
        super.height(h);
        
        // 更新 LayerCompositor 的大小
        if (_compositor !is null && _layerSystemInitialized)
        {
            HDC hdc = GetDC(hwnd);
            _compositor.init(w, h, hdc);
            ReleaseDC(hwnd, hdc);
        }
        
        // 触发子控件的重新布局
        // 对于 DockStyle.Fill 的子控件，会自动调整大小
        foreach (child; children())
        {
            if (child.visible())
            {
                // 标记子控件为脏，触发重新布局
                child.markDirty(DirtyBits.Size);
                child.markDirty(DirtyBits.Layout);
            }
        }
        
        // 强制重绘
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
        
        // 清理 LayerCompositor（GDI资源）
        if (_compositor !is null)
        {
            _compositor.destroy();
        }
        
        // 清理 RenderDevice（D3D12资源）
        // 注意：D3D12RenderDevice 的析构函数会自动清理资源
        
        if (_app !is null)
        {
            _app.removeWindow(this);
        }
        hide();
        
        // Destroy the native HWND after app lifecycle logic (removeWindow, hide).
        // This triggers WM_DESTROY, but PostQuitMessage is no longer called there —
        // the Application layer (removeWindow → quit) handles process exit.
        _platformWindow.destroy();
        
        logTrace("MainWindow.close() - all resources cleaned up");
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
        _closeAfterScreenshot = false;
        (cast(Win32Window)_platformWindow).setTimerFunction(&mainWindowTimerCallback, cast(Object)this);
        _platformWindow.startTimer(SCREENSHOT_TIMER_ID, delayMs);
    }

    /// 延迟截图，截图完成后自动关闭窗口
    void scheduleScreenshotAndClose(int delayMs = 500, string filename = "screenshot.bmp")
    {
        logTrace("MainWindow.scheduleScreenshotAndClose(delayMs=", delayMs, ", '", filename, "')");
        _screenshotFile = filename;
        _closeAfterScreenshot = true;
        (cast(Win32Window)_platformWindow).setTimerFunction(&mainWindowTimerCallback, cast(Object)this);
        _platformWindow.startTimer(SCREENSHOT_TIMER_ID, delayMs);
    }
    
    private string _screenshotFile;
    private bool _closeAfterScreenshot = false;
    private static immutable uint SCREENSHOT_TIMER_ID = 1001;
    private static immutable uint BLINK_TIMER_ID = 1002;
    private static immutable uint ASYNC_POLL_TIMER_ID = 1003;

    // ── AsyncTask 轮询支持 ──
    import guia4.guicore.asynctask : AsyncTask;
    private AsyncTask _asyncTask;
    private void delegate() _asyncOnProgress;
    private void delegate() _asyncOnComplete;

    /// 启动异步任务轮询定时器
    void startAsyncTask(AsyncTask task, void delegate() onProgress, void delegate() onComplete)
    {
        _asyncTask = task;
        _asyncOnProgress = onProgress;
        _asyncOnComplete = onComplete;
        (cast(Win32Window)_platformWindow).setTimerFunction(&mainWindowTimerCallback, cast(Object)this);
        _platformWindow.startTimer(ASYNC_POLL_TIMER_ID, 50); // 50ms 轮询间隔
        logInfo("AsyncTask polling started");
    }

    /// 停止异步任务轮询
    void stopAsyncPoll()
    {
        _platformWindow.stopTimer(ASYNC_POLL_TIMER_ID);
        _asyncTask = null;
        _asyncOnProgress = null;
        _asyncOnComplete = null;
        logInfo("AsyncTask polling stopped");
    }

    // Immediate screenshot - call from show() before message loop
    void captureImmediate(string filename)
    {
        logInfo("MainWindow.captureImmediate('", filename, "')");
        _screenshotFile = filename;
        captureScreenshot(filename);
    }
    
    /// 计算控件在窗口客户区中的绝对坐标（委托到 Control.controlToClient）
    private void controlToClient(Control ctrl, out int absX, out int absY)
    {
        ctrl.controlToClient(absX, absY);
    }

    /// 将窗口客户区坐标转换为控件局部坐标（委托到 Control.clientToControl）
    private void clientToControl(Control ctrl, int clientX, int clientY, out int localX, out int localY)
    {
        ctrl.clientToControl(clientX, clientY, localX, localY);
    }

    /// 累加所有祖先的纵向滚动偏移（委托到 Control.ancestorScrollY）
    private static int ancestorScrollY(Control ctrl)
    {
        return Control.ancestorScrollY(ctrl);
    }

    /// Mouse event dispatch from Win32Window.
    /// Performs hit-test on children, tracks capture (for click detection) and hover.
    /// ScrollableContainer scroll offsets are transparently handled by
    /// [ancestorScrollY] → [clientToControl].
    private void mouseEventHandler(ref MouseEventData ev)
    {
        logTrace("MainWindow.mouseEventHandler(x=", ev.x, ", y=", ev.y, ", down=", ev.down, ", move=", ev.move, ", leave=", ev.leave, ")");
        
        if (ev.leave)
        {
            if (_hoveredControl !is null && _hoveredControl !is this)
                _hoveredControl.fireMouseMove(-1, -1);
            _hoveredControl = null;
            _capturedControl = null;
            requestRedraw();
            return;
        }
        
        // Find the deepest visible child at this point
        Control target = hitTestChild(this, ev.x, ev.y);
        if (target is null)
            target = this;
        
        if (ev.down)
        {
            // 检查是否点击了 TextInput 的右键菜单
            if (focusedControl !is null)
            {
                auto ti = cast(TextInput)focusedControl;
                if (ti !is null && ti.contextMenuOpen)
                {
                    auto menu = ti.contextMenu;
                    int localX, localY;
                    clientToControl(menu, ev.x, ev.y, localX, localY);
                    menu.fireMouseDown(localX, localY, 0);
                    requestRedraw();
                    return;
                }
            }

            // 检查是否点击了 EditBox 的右键菜单
            if (focusedControl !is null)
            {
                auto eb = cast(EditBox)focusedControl;
                if (eb !is null && eb.contextMenuOpen)
                {
                    auto menu = eb.contextMenu;
                    int localX, localY;
                    clientToControl(menu, ev.x, ev.y, localX, localY);
                    menu.fireMouseDown(localX, localY, 0);
                    requestRedraw();
                    return;
                }
            }

            // Mouse button pressed
            _capturedControl = target;
            if (target.focusable())
                setFocus(target);
            int localX, localY;
            clientToControl(target, ev.x, ev.y, localX, localY);
            target.fireMouseDown(localX, localY, ev.button);

            // 如果Popup开始拖拽，设置窗口绝对坐标起点
            auto popupTarget = cast(Popup)target;
            if (popupTarget !is null && popupTarget.isDragging())
            {
                popupTarget.setDragOrigin(ev.x, ev.y);
            }


            // 检查是否点击了子菜单项
            bool clickedSubItem = false;
            foreach (child; children())
            {
                auto mb = cast(MenuBar)child;
                if (mb !is null && mb.hasOpenMenu())
                {
                    auto subItem = mb.hitTestSubMenu(ev.x, ev.y);
                    if (subItem !is null)
                    {
                        subItem.fireClick(ev.x, ev.y);
                        clickedSubItem = true;
                        break;
                    }
                }
            }

            // 如果点击的不是菜单区域，关闭所有展开的菜单
            if (!clickedSubItem)
            {
                auto targetMenuBar = cast(MenuBar)target;
                auto targetMenuItem = cast(MenuItem)target;
                if (targetMenuBar is null && targetMenuItem is null)
                {
                    // 检查 target 的父级是否是 MenuBar
                    Control p = target.parent();
                    bool isMenuArea = false;
                    while (p !is null)
                    {
                        if (cast(MenuBar)p !is null)
                        {
                            isMenuArea = true;
                            break;
                        }
                        p = p.parent();
                    }
                    if (!isMenuArea)
                        closeAllMenus();
                }
            }

            // 检查是否有 ComboBox 的下拉列表打开
            auto comboHit = findOpenComboBox(ev.x, ev.y);
            if (comboHit !is null)
            {
                int comboAbsX, comboAbsY;
                controlToClient(comboHit, comboAbsX, comboAbsY);

                // 如果点击在ComboBox自身区域内（非下拉列表区域），说明已经通过fireMouseDown处理了展开/收起
                // 不应再调用handleDropDownClick（否则会立即关闭刚展开的下拉列表）
                if (ev.y >= comboAbsY && ev.y < comboAbsY + comboHit.height() &&
                    ev.x >= comboAbsX && ev.x < comboAbsX + comboHit.width())
                {
                    // 点击在ComboBox自身区域，已由fireMouseDown处理，跳过
                    requestRedraw();
                    return;
                }

                comboHit.handleDropDownClick(ev.x, ev.y, comboAbsX, comboAbsY);
                requestRedraw();
                return;
            }
        }
        else if (!ev.move)
        {
            // Mouse button released
            if (_capturedControl !is null)
            {
                int localX, localY;
                clientToControl(_capturedControl, ev.x, ev.y, localX, localY);
                _capturedControl.fireMouseUp(localX, localY, ev.button);
                if (_capturedControl is target)
                    _capturedControl.fireClick(localX, localY);
            }
            _capturedControl = null;
        }
        else
        {
            // Mouse move
            Control moveTarget = target;
            if (_capturedControl !is null)
                moveTarget = _capturedControl;

            bool needRedraw = false;
            
            if (moveTarget !is _hoveredControl)
            {
                if (_hoveredControl !is null && _hoveredControl !is this)
                    _hoveredControl.fireMouseMove(-1, -1);
                _hoveredControl = moveTarget;
                needRedraw = true;  // hover改变需要重绘
            }
            int localX, localY;

            // Popup拖拽时使用窗口绝对坐标，避免clientToControl导致的抖动
            auto popupMove = cast(Popup)moveTarget;
            if (popupMove !is null && popupMove.isDragging())
            {
                localX = ev.x;
                localY = ev.y;
                needRedraw = true;  // Popup拖拽需要重绘
            }
            else
            {
                clientToControl(moveTarget, ev.x, ev.y, localX, localY);
            }
            moveTarget.fireMouseMove(localX, localY);

            // 处理子菜单项的悬停效果
            foreach (child; children())
            {
                auto mb = cast(MenuBar)child;
                if (mb !is null && mb.hasOpenMenu())
                {
                    updateSubMenuHover(mb, ev.x, ev.y);
                    needRedraw = true;  // MenuBar菜单悬停需要重绘
                }
            }

            // 更新 ComboBox 下拉列表悬停（递归查找所有嵌套的 ComboBox）
            updateComboBoxDropDownHover(ev.x, ev.y);
            needRedraw = true;
            
            if (needRedraw)
                requestRedraw();
        }
    }
    
    /// 关闭所有展开的菜单
    private void closeAllMenus()
    {
        foreach (child; children())
        {
            auto mb = cast(MenuBar)child;
            if (mb !is null)
                mb.closeAll();
        }
    }

    /// 查找打开下拉列表的 ComboBox，检查点击是否在下拉区域内
    private ComboBox findOpenComboBox(int px, int py)
    {
        return findOpenComboBoxInControl(this, px, py);
    }

    private ComboBox findOpenComboBoxInControl(Control c, int px, int py, int offsetX = 0, int offsetY = 0)
    {
        foreach (child; c.children())
        {
            int childAbsX, childAbsY;
            controlToClient(child, childAbsX, childAbsY);

            auto cb = cast(ComboBox)child;
            if (cb !is null && cb.isDropDown())
            {
                // 检查点击是否在 ComboBox 或其下拉区域内
                int dropY = childAbsY + cb.height();
                int dropH = cast(int)cb.itemCount() * 24;
                if (dropH > 120) dropH = 120;

                if (px >= childAbsX && px < childAbsX + cb.width() &&
                    py >= childAbsY && py < dropY + dropH)
                {
                    return cb;
                }
            }
            // 递归查找子控件
            auto result = findOpenComboBoxInControl(child, px, py, childAbsX, childAbsY);
            if (result !is null)
                return result;
        }
        return null;
    }

    /// 更新 ComboBox 下拉列表悬停
    private void updateComboBoxDropDownHover(int mx, int my)
    {
        updateComboBoxDropDownHoverInControl(this, mx, my);
    }

    private void updateComboBoxDropDownHoverInControl(Control c, int mx, int my)
    {
        foreach (child; c.children())
        {
            auto cb = cast(ComboBox)child;
            if (cb !is null && cb.isDropDown())
            {
                int childAbsX, childAbsY;
                controlToClient(cb, childAbsX, childAbsY);
                cb.handleDropDownMouseMove(mx, my, childAbsX, childAbsY);
            }
            updateComboBoxDropDownHoverInControl(child, mx, my);
        }
    }

    /// 关闭所有 ComboBox 的下拉列表
    private void closeAllComboBoxDropDown()
    {
        closeAllComboBoxDropDownInControl(this);
    }

    private void closeAllComboBoxDropDownInControl(Control c)
    {
        foreach (child; c.children())
        {
            auto cb = cast(ComboBox)child;
            if (cb !is null && cb.isDropDown())
            {
                int childAbsX, childAbsY;
                controlToClient(cb, childAbsX, childAbsY);
                cb.handleDropDownClick(-1, -1, childAbsX, childAbsY);  // 传无效坐标，触发关闭
            }
            closeAllComboBoxDropDownInControl(child);
        }
    }

    /// 更新子菜单项的悬停状态
    private void updateSubMenuHover(MenuBar mb, int mx, int my)
    {
        // 遍历 MenuBar 的所有 MenuItem，更新展开子菜单的悬停状态
        foreach (child; mb.children())
        {
            auto mi = cast(MenuItem)child;
            if (mi !is null && mi.menuOpen())
            {
                updateSubItemHover(mi, mx, my);
            }
        }
    }

    /// 递归更新子菜单项的悬停状态
    private void updateSubItemHover(MenuItem parentItem, int mx, int my)
    {
        foreach (subItem; parentItem.subItems())
        {
            bool inItem = mx >= subItem.position().x() && mx < subItem.position().x() + subItem.width() &&
                          my >= subItem.position().y() && my < subItem.position().y() + subItem.height();
            if (inItem && !subItem.hovered())
            {
                subItem.hovered(true);
                requestRedraw();
            }
            else if (!inItem && subItem.hovered())
            {
                subItem.hovered(false);
                requestRedraw();
            }
            // 递归处理子项的子菜单
            if (subItem.menuOpen())
            {
                updateSubItemHover(subItem, mx, my);
            }
        }
    }
    
    /// Wheel event handler — dispatch to hovered control (bubbling propagates to ScrollableContainer).
    private void wheelEventHandler(ref WheelEventData ev)
    {
        logTrace("MainWindow.wheelEventHandler(x=", ev.x, ", y=", ev.y, ", delta=", ev.delta, ", hDelta=", ev.hDelta, ")");
        
        // Dispatch to hovered control — bubbling carries it to parent ScrollableContainer
        if (_hoveredControl !is null && _hoveredControl !is this)
            _hoveredControl.fireMouseWheel(ev.delta, ev.hDelta, ev.x, ev.y);

        requestRedraw();
    }
    
    /// Char event handler — dispatch char input to focused control.
    private void charEventHandler(ref CharEventData ev)
    {
        logTrace("MainWindow.charEventHandler(ch='", ev.ch, "')");
        
        // 过滤控制字符（Ctrl+X产生的WM_CHAR控制字符，如Ctrl+A=0x01, Ctrl+C=0x03等）
        // 允许正常的空白字符通过（Tab=0x09, LF=0x0A, CR=0x0D）
        if (ev.ch < 0x20 && ev.ch != 0x09 && ev.ch != 0x0A && ev.ch != 0x0D)
            return;
        
        if (focusedControl !is null)
        {
            focusedControl.fireTextInput(ev.ch);
        }

        requestRedraw();
    }
    
    /// Set keyboard focus to a specific control.
    void setFocus(Control ctrl)
    {
        Control prevFocused = _focusManager.focusedControl;
        if (prevFocused is ctrl) return;

        // 停止旧控件的光标闪烁定时器
        if (prevFocused !is null && prevFocused !is this)
        {
            auto prevTi = cast(TextInput)prevFocused;
            auto prevEb = cast(EditBox)prevFocused;
            if (prevTi !is null || prevEb !is null)
                _platformWindow.stopTimer(BLINK_TIMER_ID);
        }

        // 使用 FocusManager 更新焦点状态
        _focusManager.setFocus(ctrl);

        // 启动新控件的光标闪烁定时器
        Control newFocused = _focusManager.focusedControl;
        if (newFocused !is null && newFocused !is this)
        {
            auto newTi = cast(TextInput)newFocused;
            auto newEb = cast(EditBox)newFocused;
            if (newTi !is null || newEb !is null)
                _platformWindow.startTimer(BLINK_TIMER_ID, 530);
        }
        logTrace("MainWindow.setFocus() -> ", newFocused !is null ? newFocused.toString() : "null");
        requestRedraw();
    }

    /// 获取当前焦点控件
    Control focusedControl() @property { return _focusManager.focusedControl; }
    
    /// Move focus to next focusable control (Tab), or previous (Shift+Tab).
    private void cycleFocus(bool reverse = false)
    {
        Control prevFocused = _focusManager.focusedControl;
        _focusManager.cycleFocus(this, reverse);
        Control newFocused = _focusManager.focusedControl;

        // 如果焦点变化，处理定时器
        if (newFocused !is prevFocused)
        {
            // 停止旧控件的光标闪烁定时器
            if (prevFocused !is null && prevFocused !is this)
            {
                auto prevTi = cast(TextInput)prevFocused;
                auto prevEb = cast(EditBox)prevFocused;
                if (prevTi !is null || prevEb !is null)
                    _platformWindow.stopTimer(BLINK_TIMER_ID);
            }
            // 启动新控件的光标闪烁定时器
            if (newFocused !is null && newFocused !is this)
            {
                auto newTi = cast(TextInput)newFocused;
                auto newEb = cast(EditBox)newFocused;
                if (newTi !is null || newEb !is null)
                    _platformWindow.startTimer(BLINK_TIMER_ID, 530);
            }
            requestRedraw();
        }
    }
    
    /// Keyboard event handler — dispatch key events to focused control.
    private void keyEventHandler(ref KeyEventData ev)
    {
        logTrace("MainWindow.keyEventHandler(keyCode=", ev.keyCode, " down=", ev.down, ")");
        
        if (!ev.down) return; // we only care about key-down events
        
        // Tab / Shift+Tab → cycle focus
        // 但如果 focused control 正在编辑（如 GridWidgetBase），让控件自己处理 Tab
        if (ev.keyCode == VK_TAB)
        {
            auto grid = cast(GridWidgetBase)focusedControl;
            if (grid !is null && grid.isEditing())
            {
                // 传给控件处理（GridWidgetBase 会在编辑模式下确认并移到下一格）
                focusedControl.fireKeyDown(ev.keyCode, ev.shift, ev.control, ev.alt);
                requestRedraw();
                return;
            }
            cycleFocus(ev.shift);
            requestRedraw();
            return;
        }

        // Ctrl+A 全选由 TextInput 内部处理，需要传递修饰键
        // Forward to focused control (with shift/control modifiers)
        if (focusedControl !is null)
        {
            focusedControl.fireKeyDown(ev.keyCode, ev.shift, ev.control, ev.alt);
        }

        requestRedraw();
    }
    
    /// Hit-test children recursively.
    /// px,py are absolute window-client coordinates. Returns deepest matching Control or null.
    /// 按层级从高到低遍历，同层级内从后往前（后添加的优先），确保弹出控件优先命中。
    /// parentOffset: 父控件的绝对位置（相对于窗口客户区），用于坐标转换
    private Control hitTestChild(Control parent, int px, int py, int parentOffsetX = 0, int parentOffsetY = 0)
    {
        auto children = parent.children();
        if (children.length == 0)
            return null;

        // 计算相对于当前父控件的坐标
        int relX = px - parentOffsetX;
        int relY = py - parentOffsetY;
        
        logTrace("hitTestChild: parent=", typeid(parent).name, " mouse=(", px, ",", py, ") parentOffset=(", parentOffsetX, ",", parentOffsetY, ") rel=(", relX, ",", relY, ")");

        // 找出最大层级值
        int maxLayer = 0;
        foreach (child; children)
        {
            if (cast(int)child.layer() > maxLayer)
                maxLayer = cast(int)child.layer();
        }

        // 按层级从高到低遍历，同层级内从后往前（后添加的优先）
        for (int layer = maxLayer; layer >= 0; layer--)
        {
            for (int i = cast(int)children.length - 1; i >= 0; i--)
            {
                auto child = children[i];
                if (!child.visible())
                    continue;
                if (cast(int)child.layer() != layer)
                    continue;

                // 使用相对于父控件的坐标进行命中测试
                // child.position() 是相对于 parent 的坐标
                // relX, relY 是相对于 parent 的坐标
                logTrace("  checking child: ", typeid(child).name, " position=(", child.position().x(), ",", child.position().y(), ") size=(", child.width(), ",", child.height(), ")");
                if (child.hitTest(relX, relY))
                {
                    logTrace("    HIT! child: ", typeid(child).name);
                    // 计算子控件的绝对位置（用于递归时的坐标转换）
                    int childAbsX = parentOffsetX + child.position().x();
                    int childAbsY = parentOffsetY + child.position().y();

                    // ScrollableContainer/Panel 使用 GDI 视口偏移渲染子控件
                    // 渲染时，视口原点被偏移 -scrollY，使得子控件的 position() 被解释为相对于内容区域的坐标
                    // 命中测试时，需要相应调整 parentOffsetY，使命中测试使用相同的坐标系
                    int adjustedParentOffsetY = childAbsY;
                    auto sc = cast(ScrollableContainer)child;
                    if (sc !is null)
                    {
                        adjustedParentOffsetY -= sc.scrollY;
                    }
                    else
                    {
                        import guia4.guicore.panel;
                        auto pn = cast(Panel)child;
                        if (pn !is null)
                        {
                            adjustedParentOffsetY -= pn.scrollY();
                        }
                    }

                    // TabHost 特殊处理：递归进入 activeIndex 对应的 page
                    auto th = cast(guia4.guicore.tabhost.TabHost)child;
                    if (th !is null)
                    {
                        auto pages = th.children();
                        int activeIdx = th.activeIndex();
                        if (activeIdx >= 0 && activeIdx < cast(int)pages.length)
                        {
                            auto activePage = pages[activeIdx];
                            if (activePage.visible())
                            {
                                // TabHost 使用 DC 偏移渲染，page 的坐标相对于 TabHost
                                auto deeper = hitTestChild(activePage, px, py, childAbsX, adjustedParentOffsetY);
                                if (deeper !is null)
                                    return deeper;
                                // 如果没有找到更深的子控件，返回 activePage
                                return activePage;
                            }
                        }
                        // 没有活跃页面，返回 parent
                        return parent;
                    }

                    auto deeper = hitTestChild(child, px, py, childAbsX, adjustedParentOffsetY);
                    if (deeper !is null)
                        return deeper;
                    return child;
                }
            }
        }
        return null;
    }
    
    /// 请求重绘 — 标记窗口客户区为需要更新，触发 WM_PAINT
    void requestRedraw()
    {
        HWND hwnd = cast(HWND)nativeHandle();
        if (hwnd.Value !is null)
        {
            // 使用RedrawWindow立即重绘，避免WM_PAINT延迟
            // RDW_INVALIDATE: 标记整个窗口为无效
            // RDW_UPDATENOW: 立即发送WM_PAINT
            RedrawWindow(hwnd, null, cast(HRGN)null, RDW_INVALIDATE | RDW_UPDATENOW);
        }
    }

    // ── Rendering ──

    void render(HDC hdc, int width, int height)
    {
        logTrace("MainWindow.render: width=", width, " height=", height, " _layerSystemInitialized=", _layerSystemInitialized);

        // 更新 MainWindow 自身的大小（处理窗口大小变化）
        if (this.width() != width || this.height() != height)
        {
            super.width(width);
            super.height(height);
            logTrace("MainWindow.render: size updated to ", width, "x", height);
        }
        
        // 执行 MainWindow 自身的布局（停靠布局）
        // 这会调用 layoutChildren() 来布局 MenuBar 和 ScrollableContainer
        this.ensureLayout();
        
        // 如果Layer系统未初始化，使用传统渲染
        if (!_layerSystemInitialized || _compositor is null)
        {
            renderTraditional(hdc, width, height);
            return;
        }
        
        // 检查是否有脏标记
        bool hasDirty = isDirty();
        
        void checkDirtyRecursive(Control ctrl)
        {
            if (ctrl.dirtyFlag().isDirty(DirtyBits.Visual))
            {
                hasDirty = true;
            }
            foreach (child; ctrl.children())
            {
                checkDirtyRecursive(child);
            }
        }
        
        foreach (child; children())
        {
            checkDirtyRecursive(child);
        }
        
        if (!hasDirty)
        {
            // 没有脏标记，直接输出历史buffer
            BitBlt(hdc, 0, 0, width, height, _compositor.historyDC(), 0, 0, SRCCOPY);
            return;
        }
        
        // ── Layer-based渲染流程 ──
        
        // 1. 收集所有需要渲染的控件
        auto allControls = children();
        
        // 2. 使用compositor合成所有layer（传入脏标记状态）
        _compositor.render(hdc, allControls, hasDirty);

        // 3. 在所有控件渲染完毕后，渲染 ComboBox 下拉列表（确保在下拉列表不被其他控件遮挡）
        renderComboBoxDropDowns(hdc);

        // 4. 清除所有脏标记
        clearDirty();
        foreach (child; children())
        {
            clearDirtyRecursive(child);
        }
    }
    

    /// 传统渲染方式（无虚拟画布）
    private void renderTraditional(HDC hdc, int width, int height)
    {
        logTrace("renderTraditional: width=", width, " height=", height);
        
        // 注意：布局已在 render() 中通过 this.ensureLayout() 执行
        
        // 检查是否有任何脏标记，如果没有则跳过渲染
        bool hasDirty = isDirty();
        if (!hasDirty)
        {
            foreach (child; children())
            {
                if (child.isDirty())
                {
                    hasDirty = true;
                    break;
                }
            }
        }
        
        if (!hasDirty)
        {
            return;  // 没有脏标记，跳过渲染
        }
        
        // ── Double-buffering: draw everything to an off-screen bitmap, then BitBlt at once ──
        HDC memDC = CreateCompatibleDC(hdc);
        HBITMAP memBmp = CreateCompatibleBitmap(hdc, width, height);
        HGDIOBJ oldBmp = SelectObject(memDC, cast(HGDIOBJ)memBmp);

        // Fill background
        RECT rect = {0, 0, width, height};
        HBRUSH brush = CreateSolidBrush(Theme.crBackground());
        FillRect(memDC, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);

        // 按 Layer 层级排序渲染：低层级先渲染（背景），高层级后渲染（弹出菜单在最上）
        auto sorted = children();
        sorted.sort!((a, b) => a.layer() < b.layer());
        foreach (child; sorted)
        {
            renderControlRecursive(child, memDC);
        }

        // 在所有子控件渲染完毕后，渲染 TextInput 上下文菜单（确保在最上层）
        renderContextMenus(memDC);

        // 在所有子控件渲染完毕后，渲染 ComboBox 下拉列表（确保下拉列表不被其他控件遮挡）
        renderComboBoxDropDowns(memDC);

        // Blit the complete off-screen buffer to the screen in one shot
        BitBlt(hdc, 0, 0, width, height, memDC, 0, 0, SRCCOPY);

        // Cleanup
        SelectObject(memDC, oldBmp);
        DeleteObject(cast(HGDIOBJ)memBmp);
        DeleteDC(memDC);
        
        // 渲染完成后清除所有脏标记
        clearDirty();
        foreach (child; children())
        {
            clearDirtyRecursive(child);
        }
    }
    
    /// 递归渲染控件（检查rendersChildren标志）
    private void renderControlRecursive(Control ctrl, HDC hdc)
    {
        logTrace("renderControlRecursive: ctrl=", typeid(ctrl).name, " position=(", ctrl.position().x(), ",", ctrl.position().y(), ") size=(", ctrl.width(), ",", ctrl.height(), ")");
        
        if (!ctrl.visible())
            return;
        
        // 确保布局已执行
        ctrl.ensureLayout();
        
        // 注意：不检查脏标记，让所有可见控件都渲染
        // 脏标记优化在renderTraditional和LayerCompositor中实现
        
        // 关键修复：在渲染控件之前，先偏移视口到控件位置
        // 这样控件使用 (0, 0) 渲染，而不是 position()
        POINT oldOrigin;
        OffsetViewportOrgEx(hdc, ctrl.position().x(), ctrl.position().y(), &oldOrigin);
        
        // 渲染控件本身
        ctrl.renderWithGDI(hdc.Value);
        
        // 恢复视口
        SetViewportOrgEx(hdc, oldOrigin.x, oldOrigin.y, null);
        
        // 只当控件不自己渲染子控件时，才递归渲染子控件
        if (!ctrl.rendersChildren())
        {
            auto children = ctrl.children();
            
            // 按Z轴排序渲染（z值小的先渲染，大的后渲染覆盖）
            if (children.length > 1)
            {
                // 创建索引数组用于排序
                import std.algorithm : sort;
                
                // 按z值排序子控件
                auto sortedChildren = children.dup;
                sortedChildren.sort!((a, b) => a.z() < b.z());
                
                foreach (child; sortedChildren)
                {
                    renderControlRecursive(child, hdc);
                }
            }
            else
            {
                // 单个子控件或无子控件，直接渲染
                foreach (child; children)
                {
                    renderControlRecursive(child, hdc);
                }
            }
        }
    }
    
    /// 递归清除脏标记
    private void clearDirtyRecursive(Control ctrl)
    {
        ctrl.clearDirty();
        foreach (child; ctrl.children())
        {
            clearDirtyRecursive(child);
        }
    }
    
    /// 渲染所有打开的 TextInput / EditBox 上下文菜单（在所有其他内容之上）
    private void renderContextMenus(HDC hdc)
    {
        // 遍历所有子控件，查找打开上下文菜单的 TextInput 或 EditBox
        void scanControls(Control ctrl)
        {
            auto ti = cast(TextInput)ctrl;
            if (ti !is null && ti.contextMenuOpen)
            {
                auto menu = ti.contextMenu;
                int absX, absY;
                ti.controlToClient(absX, absY);
                // PopupMenu 的位置是相对于 TextInput 的本地坐标
                // 需要转换为窗口客户区坐标
                int menuAbsX = absX + menu.position().x();
                int menuAbsY = absY + menu.position().y();
                menu.setXY(menuAbsX, menuAbsY);
                menu.renderWithGDI(hdc.Value);
            }
            auto eb = cast(EditBox)ctrl;
            if (eb !is null && eb.contextMenuOpen)
            {
                auto menu = eb.contextMenu;
                int absX, absY;
                eb.controlToClient(absX, absY);
                int menuAbsX = absX + menu.position().x();
                int menuAbsY = absY + menu.position().y();
                menu.setXY(menuAbsX, menuAbsY);
                menu.renderWithGDI(hdc.Value);
            }
            foreach (child; ctrl.children())
            {
                scanControls(child);
            }
        }
        scanControls(this);
    }

    /// 渲染所有打开的 ComboBox 下拉列表（在所有其他内容之上，避免被其他控件遮挡）
    private void renderComboBoxDropDowns(HDC hdc)
    {
        void scanControls(Control ctrl)
        {
            foreach (child; ctrl.children())
            {
                auto cb = cast(ComboBox)child;
                if (cb !is null && cb.isDropDown())
                {
                    int childAbsX, childAbsY;
                    controlToClient(cb, childAbsX, childAbsY);
                    cb.renderDropDownOnly(hdc, childAbsX, childAbsY);
                }
                scanControls(child);
            }
        }
        scanControls(this);
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
