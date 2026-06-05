module guia4.platform.events;

// Mouse buttons
enum MouseButton
{
    Left,
    Right,
    Middle,
    XButton1,
    XButton2,
}

// Key modifiers
enum KeyModifier : uint
{
    None     = 0,
    Shift    = 0x0001,
    Control  = 0x0002,
    Alt      = 0x0004,
    Super    = 0x0008,
}

// Mouse event
struct MouseEvent
{
    int x;
    int y;
    int deltaX;
    int deltaY;
    MouseButton button;
    bool pressed;
    uint modifiers;
    int wheelDelta;
}

// Keyboard event
struct KeyEvent
{
    uint keyCode;
    uint scanCode;
    bool pressed;
    bool repeated;
    uint modifiers;
}

// Resize event
struct ResizeEvent
{
    uint width;
    uint height;
}

// Close event
struct CloseEvent
{
    bool cancel = false; // Set to true to prevent closing
}

// Paint event (request to repaint)
struct PaintEvent
{
}

// Mouse move event
struct MouseMoveEvent
{
    int x;
    int y;
    int deltaX;
    int deltaY;
    uint modifiers;
}