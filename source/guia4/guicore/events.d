module guia4.guicore.events;

import guia4.guicore.control;

/// 事件传播阶段
enum EventPhase
{
    None = 0,
    Capturing,  /// 捕获阶段：从根到目标
    AtTarget,   /// 目标阶段：在目标控件上
    Bubbling,   /// 冒泡阶段：从目标到根
}

enum EventId
{
    None = 0,
    Click,
    MouseDown,
    MouseUp,
    MouseMove,
    KeyDown,
    KeyUp,
    Resize,
    Paint,
    Close,
    MouseWheel,
    Count,
}

/// 事件基类接口
interface IEvent
{
    EventId id() const;
    Control target() const;
    bool handled() const;
    void handled(bool v);
    EventPhase phase() const;
    void phase(EventPhase p);
    bool propagationStopped() const;
    void stopPropagation();
    void stopImmediatePropagation();
}

/**
 * EventCore — 事件公共字段和方法结构体
 *
 * 所有事件结构体共享的核心数据和行为。
 * 不使用 mixin template，改用结构体组合 + alias this，
 * 便于调试和 IDE 跳转。
 */
struct EventCore
{
    EventId id;
    Control target;
    bool handled = false;
    EventPhase phase = EventPhase.None;
    private bool _propagationStopped = false;
    private bool _immediatePropagationStopped = false;

    /// 停止事件传播（不再传递给其他控件）
    void stopPropagation() nothrow @nogc
    {
        _propagationStopped = true;
    }

    /// 立即停止事件传播（不再调用当前控件的其他监听器）
    void stopImmediatePropagation() nothrow @nogc
    {
        _propagationStopped = true;
        _immediatePropagationStopped = true;
    }

    bool propagationStopped() const nothrow @nogc @property
    {
        return _propagationStopped;
    }

    bool immediatePropagationStopped() const nothrow @nogc @property
    {
        return _immediatePropagationStopped;
    }
}

// ── 各事件结构体 ─────────────────────────────────────

/// 基础事件结构体
struct Event
{
    EventCore core;
    alias core this;
}

/// 点击事件
struct ClickEvent
{
    EventCore core;
    alias core this;
    int x;
    int y;
}

/// 鼠标事件
struct MouseEvent
{
    EventCore core;
    alias core this;
    int x;
    int y;
    int button;
    bool pressed;
}

/// 键盘事件
struct KeyEvent
{
    EventCore core;
    alias core this;
    uint keyCode;
    bool pressed;
    bool shift;     /// Shift 键是否按下
    bool control;   /// Ctrl 键是否按下
    bool alt;       /// Alt 键是否按下
}

/// 窗口大小改变事件
struct ResizeEvent
{
    EventCore core;
    alias core this;
    int width;
    int height;
}

/// 窗口关闭事件
struct CloseEvent
{
    EventCore core;
    alias core this;
    bool cancel = false;
}

/// 鼠标滚轮事件
struct MouseWheelEvent
{
    EventCore core;
    alias core this;
    int delta;      /// 正值 = 向上滚动, 负值 = 向下滚动
    int hDelta;     /// 正值 = 向右滚动, 负值 = 向左滚动（横向滚轮）
    int x;          /// 滚轮事件 x 坐标
    int y;          /// 滚轮事件 y 坐标
}

// ── 事件处理器别名 ─────────────────────────────────────

alias ClickHandler = void delegate(ref ClickEvent);
alias MouseHandler = void delegate(ref MouseEvent);
alias KeyHandler = void delegate(ref KeyEvent);
alias ResizeHandler = void delegate(ref ResizeEvent);
alias CloseHandler = void delegate(ref CloseEvent);
alias MouseWheelHandler = void delegate(ref MouseWheelEvent);
alias TextInputHandler = void delegate(dchar ch);

// ── 编译时验证 ─────────────────────────────────────

static assert(is(typeof(ClickEvent.init.stopPropagation)));
static assert(is(typeof(MouseEvent.init.stopPropagation)));
static assert(is(typeof(KeyEvent.init.stopPropagation)));
static assert(is(typeof(ResizeEvent.init.stopPropagation)));
static assert(is(typeof(CloseEvent.init.stopPropagation)));
static assert(is(typeof(MouseWheelEvent.init.stopPropagation)));

static assert(is(typeof(ClickEvent.init.stopImmediatePropagation)));
static assert(is(typeof(MouseEvent.init.stopImmediatePropagation)));
static assert(is(typeof(KeyEvent.init.stopImmediatePropagation)));
static assert(is(typeof(ResizeEvent.init.stopImmediatePropagation)));
static assert(is(typeof(CloseEvent.init.stopImmediatePropagation)));
static assert(is(typeof(MouseWheelEvent.init.stopImmediatePropagation)));

static assert(is(typeof(ClickEvent.init.propagationStopped)));
static assert(is(typeof(MouseEvent.init.propagationStopped)));
static assert(is(typeof(KeyEvent.init.propagationStopped)));
static assert(is(typeof(ResizeEvent.init.propagationStopped)));
static assert(is(typeof(CloseEvent.init.propagationStopped)));
static assert(is(typeof(MouseWheelEvent.init.propagationStopped)));
