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

template EventRouter(Control T, EventId eventId)
{
    static if (eventId == EventId.Click)
    {
        alias HandlerType = ClickHandler;
    }
    else static if (eventId == EventId.MouseDown || eventId == EventId.MouseUp || eventId == EventId.MouseMove)
    {
        alias HandlerType = MouseHandler;
    }
    else static if (eventId == EventId.KeyDown || eventId == EventId.KeyUp)
    {
        alias HandlerType = KeyHandler;
    }
    else static if (eventId == EventId.Resize)
    {
        alias HandlerType = ResizeHandler;
    }
    else static if (eventId == EventId.Close)
    {
        alias HandlerType = CloseHandler;
    }
}

struct EventDispatcher
{
    static void dispatch(T)(ref ClickEvent event)
    {
        if (T._clickHandlers[EventId.Click] !is null)
        {
            T._clickHandlers[EventId.Click](event);
        }
    }
    
    static void dispatch(T)(ref MouseEvent event)
    {
        if (T._mouseHandlers[event.id] !is null)
        {
            T._mouseHandlers[event.id](event);
        }
    }
    
    static void dispatch(T)(ref KeyEvent event)
    {
        if (T._keyHandlers[event.id] !is null)
        {
            T._keyHandlers[event.id](event);
        }
    }
    
    static void dispatch(T)(ref ResizeEvent event)
    {
        if (T._resizeHandlers[EventId.Resize] !is null)
        {
            T._resizeHandlers[EventId.Resize](event);
        }
    }
    
    static void dispatch(T)(ref CloseEvent event)
    {
        if (T._closeHandlers[EventId.Close] !is null)
        {
            T._closeHandlers[EventId.Close](event);
        }
    }
}

bool bubbleEvent(Control target, EventId id)
{
    Control current = target;
    while (current !is null)
    {
        if (current.isDirty())
        {
            return true;
        }
        current = current.parent();
    }
    return false;
}