module guia4.guicore.control;

import guia4.guicore.dirtyflag;
import guia4.guicore.layer;
import guia4.guicore.layout;
import guia4.guicore.events;
// 注意：guicore 基类不直接依赖平台 GDI，renderWithGDI 使用 void* 以解耦
// 各控件子类内部可自行 import GDI 并 cast(HDC)hdc

/// 停靠模式 — 控件在父容器中的停靠位置
enum DockStyle
{
    None,       /// 不停靠，使用绝对定位
    Top,        /// 停靠在父容器顶部，宽度填满
    Bottom,     /// 停靠在父容器底部，宽度填满
    Left,       /// 停靠在父容器左侧，高度填满
    Right,      /// 停靠在父容器右侧，高度填满
    Fill,       /// 填充父容器剩余空间（上下左右全填充）
}

/// 水平对齐方式
enum HAlign
{
    Left,       /// 左对齐
    Center,     /// 水平居中
    Right,      /// 右对齐
    Stretch,    /// 水平拉伸填满
}

/// 垂直对齐方式
enum VAlign
{
    Top,        /// 顶部对齐
    Center,     /// 垂直居中
    Bottom,     /// 底部对齐
    Stretch,    /// 垂直拉伸填满
}

/// 悬浮模式 — 控件是否脱离正常布局流
enum FloatMode
{
    None,       /// 不悬浮，参与正常布局
    Left,       /// 左浮动，后续控件环绕右侧
    Right,      /// 右浮动，后续控件环绕左侧
    Absolute,   /// 绝对定位，脱离布局流，使用 x/y 定位
}

/**
 * Control — 控件基类
 *
 * 所有 GUI 控件的基类，包含：
 *   - 位置/尺寸属性（带脏标记传播）
 *   - 可见性/层级/焦点
 *   - 父子控件树
 *   - 布局管理
 *   - 事件注册与分发
 */
class Control
{
    // ── 字段 ──────────────────────────────────────────────────────

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
    private MouseWheelHandler _mouseWheelHandler;
    private TextInputHandler _textInputHandler;

    // ── 布局属性 ──────────────────────────────────────────────────

    private DockStyle _dock = DockStyle.None;
    private HAlign _hAlign = HAlign.Left;
    private VAlign _vAlign = VAlign.Top;
    private FloatMode _floatMode = FloatMode.None;
    private int _marginTop = 0;
    private int _marginBottom = 0;
    private int _marginLeft = 0;
    private int _marginRight = 0;
    private int _paddingTop = 0;
    private int _paddingBottom = 0;
    private int _paddingLeft = 0;
    private int _paddingRight = 0;
    private int _minWidth = 0;
    private int _minHeight = 0;
    private int _maxWidth = 0;       /// 0 = 无限制
    private int _maxHeight = 0;      /// 0 = 无限制
    private float _weightX = 0.0f;   /// 水平权重（0=不参与分配，>0=按比例分配剩余空间）
    private float _weightY = 0.0f;   /// 垂直权重
    private int _spanX = 1;          /// 网格水平跨列数
    private int _spanY = 1;          /// 网格垂直跨行数

    // ── 位置 ──────────────────────────────────────────────────────

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

    // ── 尺寸 ──────────────────────────────────────────────────────

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

    // ── 可见性 ────────────────────────────────────────────────────

    bool visible() const nothrow @nogc @property { return _visible; }
    void visible(bool v) nothrow @nogc @property
    {
        if (_visible != v) { _visible = v; _dirty.mark(DirtyBits.Visibility); propagateDirty(); }
    }

    // ── 层级 ──────────────────────────────────────────────────────

    Layer layer() const nothrow @nogc @property { return _layer; }
    void layer(Layer v) nothrow @nogc @property
    {
        if (_layer != v) { _layer = v; _dirty.mark(DirtyBits.Visual); propagateDirty(); }
    }

    // ── 焦点 ──────────────────────────────────────────────────────

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

    // ── 父子关系 ──────────────────────────────────────────────────

    Control parent() nothrow @nogc @property { return _parent; }
    void parent(Control p) nothrow @nogc @property { _parent = p; }

    Control[] children() nothrow @nogc @property { return _children; }

    void addChild(Control child)
    {
        child.parent(this);
        _children ~= child;

        // 未指定大小的控件默认填充父容器
        // 条件：width==0 && height==0 且 dock 未设置
        // 这样 layoutChildren() 会将其填充到父容器剩余空间
        if (child._width == 0 && child._height == 0 && child._dock == DockStyle.None)
        {
            child._dock = DockStyle.Fill;
        }

        _dirty.mark(DirtyBits.Children);
        propagateDirty();

        // 对有停靠属性的子控件应用布局
        layoutChildren();
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

    // ── 布局 ──────────────────────────────────────────────────────

    ILayout layout() nothrow @property { return _layout; }
    void layout(ILayout l) nothrow @property { _layout = l; }

    // ── 脏标记 ────────────────────────────────────────────────────

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

    /// 向父控件传播脏标记
    private void propagateDirty() nothrow @nogc
    {
        if (_parent !is null && _dirty.isDirty())
        {
            _parent.markDirty(DirtyBits.Children);
        }
    }

    // ── 事件注册 ──────────────────────────────────────────────────

    void onClick(ClickHandler handler) { _clickHandler = handler; }
    void onMouseDown(MouseHandler handler) { _mouseDownHandler = handler; }
    void onMouseUp(MouseHandler handler) { _mouseUpHandler = handler; }
    void onMouseMove(MouseHandler handler) { _mouseMoveHandler = handler; }
    void onKeyDown(KeyHandler handler) { _keyDownHandler = handler; }
    void onKeyUp(KeyHandler handler) { _keyUpHandler = handler; }
    void onResize(ResizeHandler handler) { _resizeHandler = handler; }
    void onClose(CloseHandler handler) { _closeHandler = handler; }
    void onMouseWheel(MouseWheelHandler handler) { _mouseWheelHandler = handler; }
    void onTextInput(TextInputHandler handler) { _textInputHandler = handler; }

    // ── 处理器访问（供 MainWindow 事件分发使用）──────────────────

    ClickHandler getClickHandler() const { return _clickHandler; }
    MouseHandler getMouseDownHandler() const { return _mouseDownHandler; }
    MouseHandler getMouseUpHandler() const { return _mouseUpHandler; }
    MouseHandler getMouseMoveHandler() const { return _mouseMoveHandler; }
    KeyHandler getKeyDownHandler() const { return _keyDownHandler; }
    KeyHandler getKeyUpHandler() const { return _keyUpHandler; }
    ResizeHandler getResizeHandler() const { return _resizeHandler; }
    CloseHandler getCloseHandler() const { return _closeHandler; }
    MouseWheelHandler getMouseWheelHandler() const { return _mouseWheelHandler; }
    TextInputHandler getTextInputHandler() const { return _textInputHandler; }

    // ── 事件触发 ──────────────────────────────────────────────────

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

    void fireKeyDown(uint keyCode, bool shift = false, bool control = false, bool alt = false)
    {
        if (_keyDownHandler !is null)
        {
            KeyEvent event;
            event.id = EventId.KeyDown;
            event.target = this;
            event.keyCode = keyCode;
            event.pressed = true;
            event.shift = shift;
            event.control = control;
            event.alt = alt;
            _keyDownHandler(event);
        }
    }

    void fireKeyUp(uint keyCode, bool shift = false, bool control = false, bool alt = false)
    {
        if (_keyUpHandler !is null)
        {
            KeyEvent event;
            event.id = EventId.KeyUp;
            event.target = this;
            event.keyCode = keyCode;
            event.pressed = false;
            event.shift = shift;
            event.control = control;
            event.alt = alt;
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

    void fireMouseWheel(int delta, int x = 0, int y = 0)
    {
        if (_mouseWheelHandler !is null)
        {
            MouseWheelEvent event;
            event.target = this;
            event.delta = delta;
            event.x = x;
            event.y = y;
            _mouseWheelHandler(event);
        }
        else if (_parent !is null)
        {
            // 冒泡到父控件 — 允许 ScrollableContainer 在光标位于子控件上时接收滚轮事件
            _parent.fireMouseWheel(delta, x, y);
        }
    }

    void fireTextInput(dchar ch)
    {
        if (_textInputHandler !is null)
        {
            _textInputHandler(ch);
        }
    }

    // ── 布局属性访问器 ────────────────────────────────────────────

    /// 停靠模式
    DockStyle dock() const @property { return _dock; }
    void dock(DockStyle v) @property { _dock = v; markDirty(DirtyBits.Visual); }

    /// 水平对齐
    HAlign hAlign() const @property { return _hAlign; }
    void hAlign(HAlign v) @property { _hAlign = v; markDirty(DirtyBits.Visual); }

    /// 垂直对齐
    VAlign vAlign() const @property { return _vAlign; }
    void vAlign(VAlign v) @property { _vAlign = v; markDirty(DirtyBits.Visual); }

    /// 悬浮模式
    FloatMode floatMode() const @property { return _floatMode; }
    void floatMode(FloatMode v) @property { _floatMode = v; markDirty(DirtyBits.Visual); }

    /// 外边距（控件与父容器的间距）
    int marginTop() const @property { return _marginTop; }
    void marginTop(int v) @property { _marginTop = v; markDirty(DirtyBits.Visual); }
    int marginBottom() const @property { return _marginBottom; }
    void marginBottom(int v) @property { _marginBottom = v; markDirty(DirtyBits.Visual); }
    int marginLeft() const @property { return _marginLeft; }
    void marginLeft(int v) @property { _marginLeft = v; markDirty(DirtyBits.Visual); }
    int marginRight() const @property { return _marginRight; }
    void marginRight(int v) @property { _marginRight = v; markDirty(DirtyBits.Visual); }

    /// 设置四边外边距（便捷方法）
    void margin(int all) @property { _marginTop = _marginBottom = _marginLeft = _marginRight = all; markDirty(DirtyBits.Visual); }
    void setMargin(int top, int right, int bottom, int left) { _marginTop = top; _marginRight = right; _marginBottom = bottom; _marginLeft = left; markDirty(DirtyBits.Visual); }

    /// 内边距（控件内容区与边界的间距）
    int paddingTop() const @property { return _paddingTop; }
    void paddingTop(int v) @property { _paddingTop = v; markDirty(DirtyBits.Visual); }
    int paddingBottom() const @property { return _paddingBottom; }
    void paddingBottom(int v) @property { _paddingBottom = v; markDirty(DirtyBits.Visual); }
    int paddingLeft() const @property { return _paddingLeft; }
    void paddingLeft(int v) @property { _paddingLeft = v; markDirty(DirtyBits.Visual); }
    int paddingRight() const @property { return _paddingRight; }
    void paddingRight(int v) @property { _paddingRight = v; markDirty(DirtyBits.Visual); }

    /// 设置四边内边距（便捷方法）
    void padding(int all) @property { _paddingTop = _paddingBottom = _paddingLeft = _paddingRight = all; markDirty(DirtyBits.Visual); }
    void setPadding(int top, int right, int bottom, int left) { _paddingTop = top; _paddingRight = right; _paddingBottom = bottom; _paddingLeft = left; markDirty(DirtyBits.Visual); }

    /// 最小尺寸
    int minWidth() const @property { return _minWidth; }
    void minWidth(int v) @property { _minWidth = v; markDirty(DirtyBits.Visual); }
    int minHeight() const @property { return _minHeight; }
    void minHeight(int v) @property { _minHeight = v; markDirty(DirtyBits.Visual); }

    /// 最大尺寸（0 = 无限制）
    int maxWidth() const @property { return _maxWidth; }
    void maxWidth(int v) @property { _maxWidth = v; markDirty(DirtyBits.Visual); }
    int maxHeight() const @property { return _maxHeight; }
    void maxHeight(int v) @property { _maxHeight = v; markDirty(DirtyBits.Visual); }

    /// 水平权重（用于弹性布局，按比例分配剩余空间）
    float weightX() const @property { return _weightX; }
    void weightX(float v) @property { _weightX = v; markDirty(DirtyBits.Visual); }

    /// 垂直权重
    float weightY() const @property { return _weightY; }
    void weightY(float v) @property { _weightY = v; markDirty(DirtyBits.Visual); }

    /// 网格跨列数
    int spanX() const @property { return _spanX; }
    void spanX(int v) @property { _spanX = v < 1 ? 1 : v; markDirty(DirtyBits.Visual); }

    /// 网格跨行数
    int spanY() const @property { return _spanY; }
    void spanY(int v) @property { _spanY = v < 1 ? 1 : v; markDirty(DirtyBits.Visual); }

    // ── 构造/渲染/命中测试 ────────────────────────────────────────

    this()
    {
        _children = [];
        _dirty.mark(DirtyBits.All);
    }

    void render() {}
    
    void renderWithGDI(void* hdc) {}

    void applyLayout()
    {
        if (_layout !is null)
        {
            _layout.layout(this);
        }
    }

    /// 根据停靠模式和对齐属性，在父容器内自动定位和调整尺寸
    /// 由父控件在布局时调用
    void applyDockLayout(int parentX, int parentY, int parentW, int parentH)
    {
        if (_dock == DockStyle.None && _floatMode == FloatMode.Absolute)
            return;  // 绝对定位，不自动布局

        // 计算可用区域（减去外边距）
        int availX = parentX + _marginLeft;
        int availY = parentY + _marginTop;
        int availW = parentW - _marginLeft - _marginRight;
        int availH = parentH - _marginTop - _marginBottom;

        if (availW < 0) availW = 0;
        if (availH < 0) availH = 0;

        final switch (_dock)
        {
            case DockStyle.None:
                // 不停靠，仅应用对齐
                applyAlignment(availX, availY, availW, availH);
                break;
            case DockStyle.Top:
                x(availX);
                y(availY);
                width(availW);
                // height 保持控件自身值
                break;
            case DockStyle.Bottom:
                x(availX);
                y(availY + availH - height());
                width(availW);
                break;
            case DockStyle.Left:
                x(availX);
                y(availY);
                // width 保持控件自身值
                height(availH);
                break;
            case DockStyle.Right:
                x(availX + availW - width());
                y(availY);
                height(availH);
                break;
            case DockStyle.Fill:
                x(availX);
                y(availY);
                width(availW);
                height(availH);
                break;
        }
    }

    /// 根据对齐属性在可用区域内定位
    private void applyAlignment(int availX, int availY, int availW, int availH)
    {
        // 水平对齐
        final switch (_hAlign)
        {
            case HAlign.Left:
                x(availX);
                break;
            case HAlign.Center:
                x(availX + (availW - width()) / 2);
                break;
            case HAlign.Right:
                x(availX + availW - width());
                break;
            case HAlign.Stretch:
                x(availX);
                width(availW);
                break;
        }

        // 垂直对齐
        final switch (_vAlign)
        {
            case VAlign.Top:
                y(availY);
                break;
            case VAlign.Center:
                y(availY + (availH - height()) / 2);
                break;
            case VAlign.Bottom:
                y(availY + availH - height());
                break;
            case VAlign.Stretch:
                y(availY);
                height(availH);
                break;
        }
    }

    /// 对所有子控件应用停靠布局（由容器控件在布局时调用）
    void layoutChildren()
    {
        // 停靠布局：按 DockStyle 顺序（Top→Bottom→Left→Right→Fill）依次分配空间
        // 剩余空间逐步被停靠控件占据
        int remainingX = _x + _paddingLeft;
        int remainingY = _y + _paddingTop;
        int remainingW = _width - _paddingLeft - _paddingRight;
        int remainingH = _height - _paddingTop - _paddingBottom;

        if (remainingW < 0) remainingW = 0;
        if (remainingH < 0) remainingH = 0;

        // 第一轮：Top/Bottom 停靠
        foreach (child; _children)
        {
            if (!child.visible() || child.dock() == DockStyle.None) continue;
            if (child.floatMode() != FloatMode.None) continue;

            if (child.dock() == DockStyle.Top)
            {
                child.x(remainingX + child.marginLeft());
                child.y(remainingY + child.marginTop());
                child.width(remainingW - child.marginLeft() - child.marginRight());
                remainingY += child.height() + child.marginTop() + child.marginBottom();
                remainingH -= child.height() + child.marginTop() + child.marginBottom();
            }
            else if (child.dock() == DockStyle.Bottom)
            {
                child.x(remainingX + child.marginLeft());
                child.y(remainingY + remainingH - child.height() - child.marginBottom());
                child.width(remainingW - child.marginLeft() - child.marginRight());
                remainingH -= child.height() + child.marginTop() + child.marginBottom();
            }
        }

        // 第二轮：Left/Right 停靠
        foreach (child; _children)
        {
            if (!child.visible() || child.dock() == DockStyle.None) continue;
            if (child.floatMode() != FloatMode.None) continue;

            if (child.dock() == DockStyle.Left)
            {
                child.x(remainingX + child.marginLeft());
                child.y(remainingY + child.marginTop());
                child.height(remainingH - child.marginTop() - child.marginBottom());
                remainingX += child.width() + child.marginLeft() + child.marginRight();
                remainingW -= child.width() + child.marginLeft() + child.marginRight();
            }
            else if (child.dock() == DockStyle.Right)
            {
                child.x(remainingX + remainingW - child.width() - child.marginRight());
                child.y(remainingY + child.marginTop());
                child.height(remainingH - child.marginTop() - child.marginBottom());
                remainingW -= child.width() + child.marginLeft() + child.marginRight();
            }
        }

        // 第三轮：Fill 停靠
        foreach (child; _children)
        {
            if (!child.visible() || child.dock() == DockStyle.None) continue;
            if (child.floatMode() != FloatMode.None) continue;

            if (child.dock() == DockStyle.Fill)
            {
                child.x(remainingX + child.marginLeft());
                child.y(remainingY + child.marginTop());
                child.width(remainingW - child.marginLeft() - child.marginRight());
                child.height(remainingH - child.marginTop() - child.marginBottom());
            }
        }

        // 第四轮：DockStyle.None 但有对齐属性的子控件
        foreach (child; _children)
        {
            if (!child.visible()) continue;
            if (child.dock() != DockStyle.None) continue;
            if (child.floatMode() != FloatMode.None) continue;

            // 只对设置了非默认对齐的控件应用
            if (child.hAlign() != HAlign.Left || child.vAlign() != VAlign.Top)
            {
                child.applyDockLayout(remainingX, remainingY, remainingW, remainingH);
            }
        }

        if (remainingH < 0) remainingH = 0;
    }

    bool hitTest(int px, int py) const nothrow @nogc
    {
        if (!_visible) return false;
        return px >= _x && px < _x + _width && py >= _y && py < _y + _height;
    }

    // 返回控件类型和位置信息，便于调试日志输出
    override string toString() const
    {
        import std.conv : to;
        return typeid(this).name ~ " at (" ~ _x.to!string ~ "," ~ _y.to!string ~ ") " ~ _width.to!string ~ "x" ~ _height.to!string;
    }
}
