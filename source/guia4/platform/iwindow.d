module guia4.platform.iwindow;

import guia4.platform.types;

// 窗口样式标志
enum WindowStyle : uint
{
    None      = 0,
    Titled    = 0x0001,
    Closable  = 0x0002,
    Minimizable = 0x0004,
    Maximizable = 0x0008,
    Resizable = 0x0010,
    Default   = Titled | Closable | Minimizable | Maximizable | Resizable,
}

// 事件回调 delegate 类型 — 使用 platform.types 的平台事件数据结构
alias MouseEventCallback = void delegate(ref MouseEventData);
alias KeyEventCallback = void delegate(ref KeyEventData);
alias WheelEventCallback = void delegate(ref WheelEventData);
alias CharEventCallback = void delegate(ref CharEventData);
alias CloseEventCallback = void delegate();
alias RedrawEventCallback = void delegate();

/// 平台窗口接口 — 抽象平台相关的窗口操作
/// 实现类：Win32Window (Windows), 未来可扩展 X11Window (Linux) 等
interface IPlatformWindow
{
    // 显示/隐藏
    void show();
    void hide();
    bool visible() const;

    // 位置和尺寸
    void setPosition(int x, int y);
    void setSize(uint width, uint height);
    int x() const nothrow;
    int y() const nothrow;
    uint width() const nothrow;
    uint height() const nothrow;

    // 标题
    void title(string title);
    string title() const;

    // 原生句柄（平台特定，如 Windows 的 HWND）
    void* nativeHandle() const nothrow;

    // 事件回调设置
    void setMouseCallback(MouseEventCallback callback);
    void setKeyCallback(KeyEventCallback callback);
    void setWheelCallback(WheelEventCallback callback);
    void setCharCallback(CharEventCallback callback);
    void setCloseCallback(CloseEventCallback callback);
    void setRedrawCallback(RedrawEventCallback callback);

    // 定时器
    void startTimer(uint id, uint delayMs);
    void stopTimer(uint id);

    // 销毁原生窗口
    void destroy();
}
