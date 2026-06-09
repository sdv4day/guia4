module guia4.guicore.events;

import guia4.guicore.control;

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

struct Event
{
    EventId id;
    Control target;
    bool handled = false;
}

struct ClickEvent
{
    EventId id = EventId.Click;
    Control target;
    bool handled = false;
    int x;
    int y;
}

struct MouseEvent
{
    EventId id;
    Control target;
    bool handled = false;
    int x;
    int y;
    int button;
    bool pressed;
}

struct KeyEvent
{
    EventId id;
    Control target;
    bool handled = false;
    uint keyCode;
    bool pressed;
    bool shift;     /// Shift 键是否按下
    bool control;   /// Ctrl 键是否按下
    bool alt;       /// Alt 键是否按下
}

struct ResizeEvent
{
    EventId id = EventId.Resize;
    Control target;
    bool handled = false;
    int width;
    int height;
}

struct CloseEvent
{
    EventId id = EventId.Close;
    Control target;
    bool handled = false;
    bool cancel = false;
}

alias ClickHandler = void delegate(ref ClickEvent);
alias MouseHandler = void delegate(ref MouseEvent);
alias KeyHandler = void delegate(ref KeyEvent);
alias ResizeHandler = void delegate(ref ResizeEvent);
alias CloseHandler = void delegate(ref CloseEvent);

struct MouseWheelEvent
{
    EventId id = EventId.MouseWheel;
    Control target;
    bool handled = false;
    int delta;      /// 正值 = 向上滚动, 负值 = 向下滚动
    int x;          /// 滚轮事件 x 坐标
    int y;          /// 滚轮事件 y 坐标
}

alias MouseWheelHandler = void delegate(ref MouseWheelEvent);
alias TextInputHandler = void delegate(dchar ch);
