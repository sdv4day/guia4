module guia4.guicore.control;

import guia4.guicore.dirtyflag;
import guia4.guicore.layer;
import guia4.guicore.layout;
import guia4.guicore.events;
import windows.win32.graphics.gdi;

// Mixin template for control properties with dirty flag propagation
mixin template ControlProperties()
{
    private int _x, _y;
    private int _width, _height;
    private bool _visible = true;
    private Layer _layer = Layer.Content;
    private Control _parent;
    private Control[] _children;
    private DirtyFlag _dirty;
    private ILayout _layout;
    
    private bool _focusable = false;
    private bool _hasFocus = false;
    
    private ClickHandler _clickHandler;
    private MouseHandler _mouseDownHandler;
    private MouseHandler _mouseUpHandler;
    private MouseHandler _mouseMoveHandler;
    private KeyHandler _keyDownHandler;
    private KeyHandler _keyUpHandler;
    private ResizeHandler _resizeHandler;
    private CloseHandler _closeHandler;

    // Position
    int x() const nothrow @nogc @property { return _x; }
    int y() const nothrow @nogc @property { return _y; }

    void x(int v) nothrow @nogc @property
    {
        if (_x != v) { _x = v; _dirty.mark(DirtyBits.Position); propagateDirty(); }
    }

    void y(int v) nothrow @nogc @property
    {
        if (_y != v) { _y = v; _dirty.mark(DirtyBits.Position); propagateDirty(); }
    }

    // Size
    int width() const nothrow @nogc @property { return _width; }
    int height() const nothrow @nogc @property { return _height; }

    void width(int v) nothrow @nogc @property
    {
        if (_width != v) { _width = v; _dirty.mark(DirtyBits.Size); propagateDirty(); }
    }

    void height(int v) nothrow @nogc @property
    {
        if (_height != v) { _height = v; _dirty.mark(DirtyBits.Size); propagateDirty(); }
    }

    // Visibility
    bool visible() const nothrow @nogc @property { return _visible; }
    void visible(bool v) nothrow @nogc @property
    {
        if (_visible != v) { _visible = v; _dirty.mark(DirtyBits.Visibility); propagateDirty(); }
    }

    // Layer
    Layer layer() const nothrow @nogc @property { return _layer; }
    void layer(Layer v) nothrow @nogc @property
    {
        if (_layer != v) { _layer = v; _dirty.mark(DirtyBits.Visual); propagateDirty(); }
    }

    // Focus
    bool focusable() const @property { return _focusable; }
    void focusable(bool v) @property { _focusable = v; }
    bool hasFocus() const @property { return _hasFocus; }
    void hasFocus(bool v) @property
    {
        if (_hasFocus != v)
        {
            _hasFocus = v;
            _dirty.mark(DirtyBits.Visual);
            propagateDirty();
        }
    }

    // Parent
    Control parent() nothrow @nogc @property { return _parent; }
    void parent(Control p) nothrow @nogc @property { _parent = p; }

    // Children
    Control[] children() nothrow @nogc @property { return _children; }

    void addChild(Control child)
    {
        import std.stdio;
        writeln("Control.addChild() - adding child, this=", cast(void*)this, ", child=", cast(void*)child);
        child.parent(this);
        _children ~= child;
        writeln("Control.addChild() - children count: ", _children.length);
        _dirty.mark(DirtyBits.Children);
        propagateDirty();
    }

    void removeChild(Control child) nothrow
    {
        foreach (i, c; _children)
        {
            if (c is child)
            {
                child.parent(null);
                _children = _children[0 .. i] ~ _children[i + 1 .. $];
                _dirty.mark(DirtyBits.Children);
                propagateDirty();
                return;
            }
        }
    }

    // Layout
    ILayout layout() nothrow @property { return _layout; }
    void layout(ILayout l) nothrow @property { _layout = l; }

    // Dirty flag
    DirtyFlag dirtyFlag() const nothrow @nogc @property { return _dirty; }
    bool isDirty() const nothrow @nogc { return _dirty.isDirty(); }

    void markDirty(DirtyBits bits) nothrow @nogc
    {
        _dirty.mark(bits);
        propagateDirty();
    }

    void clearDirty() nothrow @nogc
    {
        _dirty.clear();
    }

    // Propagate dirty to parent
    private void propagateDirty() nothrow @nogc
    {
        if (_parent !is null && _dirty.isDirty())
        {
            _parent.markDirty(DirtyBits.Children);
        }
    }

    // Event registration methods
    void onClick(ClickHandler handler) { _clickHandler = handler; }
    void onMouseDown(MouseHandler handler) { _mouseDownHandler = handler; }
    void onMouseUp(MouseHandler handler) { _mouseUpHandler = handler; }
    void onMouseMove(MouseHandler handler) { _mouseMoveHandler = handler; }
    void onKeyDown(KeyHandler handler) { _keyDownHandler = handler; }
    void onKeyUp(KeyHandler handler) { _keyUpHandler = handler; }
    void onResize(ResizeHandler handler) { _resizeHandler = handler; }
    void onClose(CloseHandler handler) { _closeHandler = handler; }
    
    // Handler accessors (for dispatch from MainWindow)
    ClickHandler getClickHandler() const { return _clickHandler; }
    MouseHandler getMouseDownHandler() const { return _mouseDownHandler; }
    MouseHandler getMouseUpHandler() const { return _mouseUpHandler; }
    MouseHandler getMouseMoveHandler() const { return _mouseMoveHandler; }
    KeyHandler getKeyDownHandler() const { return _keyDownHandler; }
    KeyHandler getKeyUpHandler() const { return _keyUpHandler; }
    ResizeHandler getResizeHandler() const { return _resizeHandler; }
    CloseHandler getCloseHandler() const { return _closeHandler; }

    // Event firing methods
    void fireClick(int x, int y)
    {
        if (_clickHandler !is null)
        {
            ClickEvent event;
            event.target = this;
            event.x = x;
            event.y = y;
            _clickHandler(event);
        }
    }

    void fireMouseDown(int x, int y, int button)
    {
        if (_mouseDownHandler !is null)
        {
            MouseEvent event;
            event.id = EventId.MouseDown;
            event.target = this;
            event.x = x;
            event.y = y;
            event.button = button;
            event.pressed = true;
            _mouseDownHandler(event);
        }
    }

    void fireMouseUp(int x, int y, int button)
    {
        if (_mouseUpHandler !is null)
        {
            MouseEvent event;
            event.id = EventId.MouseUp;
            event.target = this;
            event.x = x;
            event.y = y;
            event.button = button;
            event.pressed = false;
            _mouseUpHandler(event);
        }
    }

    void fireMouseMove(int x, int y)
    {
        if (_mouseMoveHandler !is null)
        {
            MouseEvent event;
            event.id = EventId.MouseMove;
            event.target = this;
            event.x = x;
            event.y = y;
            _mouseMoveHandler(event);
        }
    }

    void fireKeyDown(uint keyCode)
    {
        if (_keyDownHandler !is null)
        {
            KeyEvent event;
            event.id = EventId.KeyDown;
            event.target = this;
            event.keyCode = keyCode;
            event.pressed = true;
            _keyDownHandler(event);
        }
    }

    void fireKeyUp(uint keyCode)
    {
        if (_keyUpHandler !is null)
        {
            KeyEvent event;
            event.id = EventId.KeyUp;
            event.target = this;
            event.keyCode = keyCode;
            event.pressed = false;
            _keyUpHandler(event);
        }
    }

    void fireResize(int width, int height)
    {
        if (_resizeHandler !is null)
        {
            ResizeEvent event;
            event.target = this;
            event.width = width;
            event.height = height;
            _resizeHandler(event);
        }
    }

    void fireClose()
    {
        if (_closeHandler !is null)
        {
            CloseEvent event;
            event.target = this;
            _closeHandler(event);
        }
    }
}

// Base Control class
class Control
{
    mixin ControlProperties;

    this()
    {
        _children = [];
        _dirty.mark(DirtyBits.All);
    }

    void render() {}
    
    void renderWithGDI(HDC hdc) {}

    void layout()
    {
        if (_layout !is null)
        {
            _layout.layout(this);
        }
    }

    bool hitTest(int px, int py) const nothrow @nogc
    {
        if (!_visible) return false;
        return px >= _x && px < _x + _width && py >= _y && py < _y + _height;
    }
}