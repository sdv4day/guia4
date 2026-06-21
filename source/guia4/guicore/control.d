module guia4.guicore.control;

import guia4.guicore.dirtyflag;
import guia4.guicore.layer;
import guia4.guicore.layout;
import guia4.guicore.events;
import guia4.guicore.position;
import guia4.platform_win32.win32defs;
import guia4.guicore.theme;
import guia4.utils.logger;
import windows.win32.graphics.gdi;
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

    private Position _position;
    private int _width, _height;
    private bool _autoWidth = false;   /// 宽度由布局管理器自动设置
    private bool _autoHeight = false;  /// 高度由布局管理器自动设置
    private bool _visible = true;
    private Layer _layer = Layer.Content;
    private Control _parent;
    private Control[] _children;
    private DirtyFlag _dirty = DirtyFlag(false);
    private ILayout _layout;
    private bool _layoutRequested = false;  /// 布局请求标志

    private bool _focusable = false;
    private bool _hasFocus = false;
    private bool _rendersChildren = false;  /// 控件自己渲染子控件（防止LayerCompositor递归）

    // ── Layer Buffer（独立缓冲区）────────────────────────────────
    protected HDC _layerDC;              // 控件独立的layer buffer DC
    protected HBITMAP _layerBmp;         // 控件独立的layer buffer位图
    protected HGDIOBJ _layerOldBmp;      // 原始位图
    protected bool _layerBufferValid = false;  // buffer是否有效
    
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

    /// Z轴层级
    int z() const nothrow @nogc @property { return _position.z(); }
    void z(int v) nothrow @nogc @property
    {
        if (_position.z() != v) { _position.z(v); markDirty(); }
    }
    
    /// Position对象访问
    Position position() const nothrow @nogc @property { return _position; }
    void position(Position pos) nothrow @nogc @property
    {
        if (_position != pos) { _position = pos; markDirty(); }
    }

    /// 便捷方法：设置XY坐标
    void setXY(int x, int y) nothrow @nogc
    {
        _position.setXY(x, y);
        markDirty();
    }

    /// 便捷方法：设置XYZ坐标
    void setXYZ(int x, int y, int z) nothrow @nogc
    {
        _position.set(x, y, z, _position.mode());
        markDirty();
    }

    /// 定位模式
    PositionMode positionMode() const nothrow @nogc @property { return _position.mode(); }
    void positionMode(PositionMode mode) nothrow @nogc @property
    {
        if (_position.mode() != mode) { _position.mode(mode); markDirty(); }
    }
    
    /// 是否静态定位
    bool isStaticPosition() const nothrow @nogc @property { return _position.isStatic(); }
    /// 是否相对定位
    bool isRelativePosition() const nothrow @nogc @property { return _position.isRelative(); }
    /// 是否绝对定位
    bool isAbsolutePosition() const nothrow @nogc @property { return _position.isAbsolute(); }
    /// 是否固定定位
    bool isFixedPosition() const nothrow @nogc @property { return _position.isFixed(); }
    /// 是否粘性定位
    bool isStickyPosition() const nothrow @nogc @property { return _position.isSticky(); }
    /// 是否脱离文档流
    bool isOutOfFlowPosition() const nothrow @nogc @property { return _position.isOutOfFlow(); }
    /// 是否参与布局
    bool participatesInLayout() const nothrow @nogc @property { return _position.participatesInLayout(); }

    // ── 尺寸 ──────────────────────────────────────────────────────

    int width() const nothrow @nogc @property { return _width; }
    int height() const nothrow @nogc @property { return _height; }

    void width(int v) nothrow @nogc @property
    {
        if (_width != v) { _width = v; _autoWidth = (v == 0); markDirty(); }
    }

    void height(int v) nothrow @nogc @property
    {
        if (_height != v) { _height = v; _autoHeight = (v == 0); markDirty(); }
    }

    // ── 可见性 ────────────────────────────────────────────────────

    bool visible() const nothrow @nogc @property { return _visible; }
    void visible(bool v) nothrow @nogc @property
    {
        if (_visible != v) { _visible = v; markDirty(); }
    }

    // ── 子控件渲染控制 ─────────────────────────────────────────────

    /// 控件是否自己渲染子控件（如MenuBar、ScrollableContainer）
    /// 如果为true，LayerCompositor不递归渲染其children
    bool rendersChildren() const nothrow @nogc @property { return _rendersChildren; }
    void rendersChildren(bool v) nothrow @nogc @property { _rendersChildren = v; }

    // ── 层级 ──────────────────────────────────────────────────────

    Layer layer() const nothrow @nogc @property { return _layer; }
    void layer(Layer v) nothrow @nogc @property
    {
        if (_layer != v) { _layer = v; markDirty(); }
    }

    // ── 焦点 ──────────────────────────────────────────────────────

    bool focusable() const nothrow @nogc @property { return _focusable; }
    void focusable(bool v) nothrow @nogc @property { _focusable = v; }
    bool hasFocus() const nothrow @nogc @property { return _hasFocus; }
    void hasFocus(bool v) nothrow @nogc @property
    {
        if (_hasFocus != v)
        {
            _hasFocus = v;
            markDirty();
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
        // 条件：width==0 && height==0 且 dock 未设置 且 父容器没有布局管理器
        // 有布局管理器时，由布局管理器负责子控件的大小
        if (child._width == 0 && child._height == 0 && child._dock == DockStyle.None && _layout is null)
        {
            child._dock = DockStyle.Fill;
        }

        markDirty();
        
        // 请求重新布局
        requestLayout();
    }

    void removeChild(Control child) nothrow
    {
        foreach (i, c; _children)
        {
            if (c is child)
            {
                child.parent(null);
                _children = _children[0 .. i] ~ _children[i + 1 .. $];
                markDirty();
                return;
            }
        }
    }

    // ── 布局 ──────────────────────────────────────────────────────

    ILayout layout() nothrow @property { return _layout; }
    void layout(ILayout l) nothrow @property 
    { 
        _layout = l; 
        requestLayout();
    }
    
    /// 请求重新布局（延迟执行）
    void requestLayout() nothrow @nogc
    {
        _layoutRequested = true;
        // 向父控件传播布局请求
        if (_parent !is null)
        {
            _parent.requestLayout();
        }
    }
    
    /// 确保布局已执行（在渲染前调用）
    void ensureLayout()
    {
        if (_layout !is null)
        {
            // 自定义布局管理器（如 VerticalLayout）：先子后父
            // 子控件需先确定自身尺寸，父布局才能正确计算排列
            foreach (child; _children)
            {
                child.ensureLayout();
            }
            _layout.layout(this);
        }
        else
        {
            // 停靠布局（无布局管理器）：先父后子
            // 父容器先分配空间（如 DockStyle.Fill 的宽高），子控件再基于分配到的空间布局
            layoutChildren();
            foreach (child; _children)
            {
                child.ensureLayout();
            }
        }
        
        _layoutRequested = false;
    }
    
    // ── 布局管理器专用接口（package级别，同包可访问）────────────────
    
    package bool autoWidth() const nothrow @nogc { return _autoWidth; }
    package bool autoHeight() const nothrow @nogc { return _autoHeight; }
    package void setLayoutWidth(int v) nothrow @nogc
    {
        if (_width != v) { _width = v; markDirty(); }
    }
    package void setLayoutHeight(int v) nothrow @nogc
    {
        if (_height != v) { _height = v; markDirty(); }
    }

    // ── 脏标记 ────────────────────────────────────────────────────

    /// 全局脏控件计数器 — 避免每帧 O(N) 递归检查
    package static int _globalDirtyCount = 0;

    DirtyFlag dirtyFlag() const nothrow @nogc @property { return _dirty; }
    bool isDirty() const nothrow @nogc { return _dirty.isDirty(); }

    /// 全局是否有脏控件
    static bool hasAnyDirty() nothrow @nogc { return _globalDirtyCount > 0; }

    void markDirty() nothrow @nogc
    {
        if (!_dirty.isDirty())
            _globalDirtyCount++;
        _dirty.mark();
        // 向父控件传播脏标记
        // 使得 rendersChildren=true 的容器在 dirtyOnly 模式下
        // 能被正确判断为需要渲染（否则容器自身没脏标记时会被跳过）
        if (_parent !is null)
            _parent.markDirty();
    }

    void clearDirty() nothrow @nogc
    {
        if (_dirty.isDirty())
            _globalDirtyCount--;
        _dirty.clear();
    }
    
    // ── Layer Buffer管理 ───────────────────────────────────────────
    
    /**
     * 初始化Layer Buffer
     * 每个控件可以有独立的buffer用于layer-based渲染
     */
    void initLayerBuffer(HDC refDC)
    {
        // 释放旧的buffer
        destroyLayerBuffer();
        
        if (_width <= 0 || _height <= 0)
            return;
        
        // 创建控件独立的buffer
        _layerDC = CreateCompatibleDC(refDC);
        _layerBmp = CreateCompatibleBitmap(refDC, _width, _height);
        _layerOldBmp = SelectObject(_layerDC, cast(HGDIOBJ)_layerBmp);
        
        // 填充透明背景（白色，后续可改为真正的alpha通道）
        RECT rect = {0, 0, _width, _height};
        HBRUSH brush = CreateSolidBrush(Theme.crBackground());
        FillRect(_layerDC, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);
        
        _layerBufferValid = true;
    }
    
    /// 销毁Layer Buffer
    void destroyLayerBuffer()
    {
        if (_layerDC.Value !is null)
        {
            if (_layerOldBmp.Value !is null)
            {
                SelectObject(_layerDC, _layerOldBmp);
                _layerOldBmp = HGDIOBJ.init;
            }
            if (_layerBmp.Value !is null)
            {
                DeleteObject(cast(HGDIOBJ)_layerBmp);
                _layerBmp = HBITMAP.init;
            }
            DeleteDC(_layerDC);
            _layerDC = HDC.init;
        }
        _layerBufferValid = false;
    }
    
    /// 检查Layer Buffer是否有效
    bool hasLayerBuffer() const @property { return _layerBufferValid; }
    
    /// 获取Layer Buffer DC（用于渲染）
    HDC layerBufferDC() @property { return _layerDC; }
    
    /// 更新Layer Buffer（将控件内容渲染到自己的buffer）
    void updateLayerBuffer()
    {
        if (!_layerBufferValid)
            return;
        
        // 子类应该重写这个方法来渲染自己的内容
        // 默认实现：填充背景
        RECT rect = {0, 0, _width, _height};
        HBRUSH brush = CreateSolidBrush(Theme.crBackground());
        FillRect(_layerDC, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);
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

    void fireMouseWheel(int delta, int hDelta = 0, int x = 0, int y = 0)
    {
        if (_mouseWheelHandler !is null)
        {
            MouseWheelEvent event;
            event.id = EventId.MouseWheel;
            event.target = this;
            event.delta = delta;
            event.hDelta = hDelta;
            event.x = x;
            event.y = y;
            _mouseWheelHandler(event);
        }
        else if (_parent !is null)
        {
            // 冒泡到父控件 — 允许 ScrollableContainer 在光标位于子控件上时接收滚轮事件
            _parent.fireMouseWheel(delta, hDelta, x, y);
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
    void dock(DockStyle v) @property { _dock = v; markDirty(); }

    /// 水平对齐
    HAlign hAlign() const @property { return _hAlign; }
    void hAlign(HAlign v) @property { _hAlign = v; markDirty(); }

    /// 垂直对齐
    VAlign vAlign() const @property { return _vAlign; }
    void vAlign(VAlign v) @property { _vAlign = v; markDirty(); }

    /// 悬浮模式
    FloatMode floatMode() const @property { return _floatMode; }
    void floatMode(FloatMode v) @property { _floatMode = v; markDirty(); }

    /// 外边距（控件与父容器的间距）
    int marginTop() const @property { return _marginTop; }
    void marginTop(int v) @property { _marginTop = v; markDirty(); }
    int marginBottom() const @property { return _marginBottom; }
    void marginBottom(int v) @property { _marginBottom = v; markDirty(); }
    int marginLeft() const @property { return _marginLeft; }
    void marginLeft(int v) @property { _marginLeft = v; markDirty(); }
    int marginRight() const @property { return _marginRight; }
    void marginRight(int v) @property { _marginRight = v; markDirty(); }

    /// 设置四边外边距（便捷方法）
    void margin(int all) @property { _marginTop = _marginBottom = _marginLeft = _marginRight = all; markDirty(); }
    void setMargin(int top, int right, int bottom, int left) { _marginTop = top; _marginRight = right; _marginBottom = bottom; _marginLeft = left; markDirty(); }

    /// 内边距（控件内容区与边界的间距）
    int paddingTop() const @property { return _paddingTop; }
    void paddingTop(int v) @property { _paddingTop = v; markDirty(); }
    int paddingBottom() const @property { return _paddingBottom; }
    void paddingBottom(int v) @property { _paddingBottom = v; markDirty(); }
    int paddingLeft() const @property { return _paddingLeft; }
    void paddingLeft(int v) @property { _paddingLeft = v; markDirty(); }
    int paddingRight() const @property { return _paddingRight; }
    void paddingRight(int v) @property { _paddingRight = v; markDirty(); }

    /// 设置四边内边距（便捷方法）
    void padding(int all) @property { _paddingTop = _paddingBottom = _paddingLeft = _paddingRight = all; markDirty(); }
    void setPadding(int top, int right, int bottom, int left) { _paddingTop = top; _paddingRight = right; _paddingBottom = bottom; _paddingLeft = left; markDirty(); }

    /// 最小尺寸
    int minWidth() const @property { return _minWidth; }
    void minWidth(int v) @property { _minWidth = v; markDirty(); }
    int minHeight() const @property { return _minHeight; }
    void minHeight(int v) @property { _minHeight = v; markDirty(); }

    /// 最大尺寸（0 = 无限制）
    int maxWidth() const @property { return _maxWidth; }
    void maxWidth(int v) @property { _maxWidth = v; markDirty(); }
    int maxHeight() const @property { return _maxHeight; }
    void maxHeight(int v) @property { _maxHeight = v; markDirty(); }

    /// 水平权重（用于弹性布局，按比例分配剩余空间）
    float weightX() const @property { return _weightX; }
    void weightX(float v) @property { _weightX = v; markDirty(); }

    /// 垂直权重
    float weightY() const @property { return _weightY; }
    void weightY(float v) @property { _weightY = v; markDirty(); }

    /// 网格跨列数
    int spanX() const @property { return _spanX; }
    void spanX(int v) @property { _spanX = v < 1 ? 1 : v; markDirty(); }

    /// 网格跨行数
    int spanY() const @property { return _spanY; }
    void spanY(int v) @property { _spanY = v < 1 ? 1 : v; markDirty(); }

    // ── 构造/渲染/命中测试 ────────────────────────────────────────

    /// 无参构造函数（仅限 MainWindow 和派生类使用）
    protected this()
    {
        _children = [];
        markDirty();
    }

    /// 带父级参数的构造函数（推荐使用）
    /// 创建控件并自动添加到父级
    this(Control parent)
    {
        _children = [];
        markDirty();
        if (parent !is null)
        {
            parent.addChild(this);
        }
    }
    
    /**
     * 析构函数 — 信赖 GC，将引用置 null 交给 GC 处理
     * 
     * 充分信赖 GC，不需要自行释放内存，将 GC 托管的引用置 null 即可。
     * 但注意：动态数组（如 _children）置 null 会触发 GC 内存操作，
     * 在 GC finalization 阶段是非法的，所以不能在此处置 null。
     * GC 会在 finalization 阶段自动处理这些资源。
     */
    ~this()
    {
        _parent = null;
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
                setXY(availX, availY);
                width(availW);
                // height 保持控件自身值
                break;
            case DockStyle.Bottom:
                setXY(availX, availY + availH - height());
                width(availW);
                break;
            case DockStyle.Left:
                setXY(availX, availY);
                // width 保持控件自身值
                height(availH);
                break;
            case DockStyle.Right:
                setXY(availX + availW - width(), availY);
                height(availH);
                break;
            case DockStyle.Fill:
                setXY(availX, availY);
                width(availW);
                height(availH);
                break;
        }
    }

    /// 根据对齐属性在可用区域内定位
    private void applyAlignment(int availX, int availY, int availW, int availH)
    {
        // 水平对齐
        int newX = position().x();
        int newY = position().y();
        final switch (_hAlign)
        {
            case HAlign.Left:
                newX = availX;
                break;
            case HAlign.Center:
                newX = availX + (availW - width()) / 2;
                break;
            case HAlign.Right:
                newX = availX + availW - width();
                break;
            case HAlign.Stretch:
                newX = availX;
                width(availW);
                break;
        }

        // 垂直对齐
        final switch (_vAlign)
        {
            case VAlign.Top:
                newY = availY;
                break;
            case VAlign.Center:
                newY = availY + (availH - height()) / 2;
                break;
            case VAlign.Bottom:
                newY = availY + availH - height();
                break;
            case VAlign.Stretch:
                newY = availY;
                height(availH);
                break;
        }
        setXY(newX, newY);
    }

    /// 对所有子控件应用停靠布局（由容器控件在布局时调用）
    void layoutChildren()
    {
        logTrace("layoutChildren: parent=", typeid(this).name, " size=(", _width, ",", _height, ") children=", _children.length);
        
        // 停靠布局：按 DockStyle 顺序（Top→Bottom→Left→Right→Fill）依次分配空间
        // 剩余空间逐步被停靠控件占据
        // 注意：子控件坐标是相对于父控件的，不包含父控件的绝对位置
        int remainingX = _paddingLeft;
        int remainingY = _paddingTop;
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
                child.setXY(remainingX + child.marginLeft(), remainingY + child.marginTop());
                child.width(remainingW - child.marginLeft() - child.marginRight());
                remainingY += child.height() + child.marginTop() + child.marginBottom();
                remainingH -= child.height() + child.marginTop() + child.marginBottom();
            }
            else if (child.dock() == DockStyle.Bottom)
            {
                child.setXY(remainingX + child.marginLeft(), remainingY + remainingH - child.height() - child.marginBottom());
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
                child.setXY(remainingX + child.marginLeft(), remainingY + child.marginTop());
                child.height(remainingH - child.marginTop() - child.marginBottom());
                remainingX += child.width() + child.marginLeft() + child.marginRight();
                remainingW -= child.width() + child.marginLeft() + child.marginRight();
            }
            else if (child.dock() == DockStyle.Right)
            {
                child.setXY(remainingX + remainingW - child.width() - child.marginRight(), remainingY + child.marginTop());
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
                child.setXY(remainingX + child.marginLeft(), remainingY + child.marginTop());
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

    // ── 滚动偏移虚属性 ──────────────────────────────────────────

    /// 本控件的纵向滚动偏移（像素）。子类（ScrollableContainer/Panel/GridWidgetBase）override。
    /// 默认返回 0（无滚动）。
    int scrollOffsetY() const @property { return 0; }

    /// 本控件的横向滚动偏移（像素）。子类 override。
    int scrollOffsetX() const @property { return 0; }

    // ── 坐标转换 ──────────────────────────────────────────────

    /// 计算本控件在窗口客户区中的绝对坐标
    /// 累加所有祖先的 position 偏移，并补偿滚动容器的 scrollOffset
    void controlToClient(out int absX, out int absY)
    {
        absX = _position.x();
        absY = _position.y();
        int scrollY = 0;

        Control cur = _parent;
        while (cur !is null)
        {
            absX += cur._position.x();
            absY += cur._position.y();
            scrollY += cur.scrollOffsetY();
            cur = cur._parent;
        }

        absY -= scrollY;
    }

    /// 将窗口客户区坐标转换为本控件的局部坐标
    void clientToControl(int clientX, int clientY, out int localX, out int localY)
    {
        int absX, absY;
        controlToClient(absX, absY);
        localX = clientX - absX;
        localY = clientY - absY;
    }

    /// 累加所有祖先的纵向滚动偏移
    static int ancestorScrollY(Control ctrl)
    {
        int total = 0;
        Control cur = ctrl._parent;
        while (cur !is null)
        {
            total += cur.scrollOffsetY();
            cur = cur._parent;
        }
        return total;
    }

    bool hitTest(int px, int py) const nothrow @nogc
    {
        if (!_visible) return false;
        return px >= _position.x() && px < _position.x() + _width && py >= _position.y() && py < _position.y() + _height;
    }

    // 返回控件类型和位置信息，便于调试日志输出
    override string toString() const
    {
        import std.conv : to;
        return typeid(this).name ~ " at (" ~ _position.x().to!string ~ "," ~ _position.y().to!string ~ ") " ~ _width.to!string ~ "x" ~ _height.to!string;
    }
}
