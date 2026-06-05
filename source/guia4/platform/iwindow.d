module guia4.platform.iwindow;

import guia4.platform.events;

// Window style flags
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

// Delegate types for window events
alias MouseEventDelegate = void delegate(MouseEvent);
alias KeyEventDelegate = void delegate(KeyEvent);
alias ResizeEventDelegate = void delegate(ResizeEvent);
alias CloseEventDelegate = void delegate(ref CloseEvent);
alias PaintEventDelegate = void delegate();
alias MouseMoveEventDelegate = void delegate(MouseMoveEvent);

interface IPlatformWindow
{
    // Show/hide
    void show();
    void hide();
    bool isVisible() const nothrow;

    // Position and size
    void setPosition(int x, int y);
    void setSize(uint width, uint height);
    int x() const nothrow;
    int y() const nothrow;
    uint width() const nothrow;
    uint height() const nothrow;

    // Title
    void title(string title);
    string title() const;

    // Native handle (platform-specific, e.g. HWND on Windows)
    void* nativeHandle() const nothrow;

    // Event handlers
    void onMouseInput(MouseEventDelegate dlg);
    void onKeyInput(KeyEventDelegate dlg);
    void onResize(ResizeEventDelegate dlg);
    void onClose(CloseEventDelegate dlg);
    void onPaint(PaintEventDelegate dlg);
    void onMouseMove(MouseMoveEventDelegate dlg);
}