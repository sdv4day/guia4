module guia4.guicore.position;

/**
 * PositionMode - 定位模式枚举
 * 
 * 参考CSS position属性，定义控件的定位方式：
 * - Static: 默认，按正常文档流定位
 * - Relative: 相对定位，相对于自身正常位置偏移
 * - Absolute: 绝对定位，相对于最近的非static父元素
 * - Fixed: 固定定位，相对于视口
 * - Sticky: 粘性定位，相对和固定的混合
 */
enum PositionMode
{
    /// 静态定位（默认）
    /// - 按正常文档流定位
    /// - x/y表示布局系统计算的最终位置（只读）
    /// - 不受top/right/bottom/left偏移影响
    /// - 与DockStyle配合使用
    Static = 0,
    
    /// 相对定位
    /// - 保持在文档流中的原始空间
    /// - x/y表示相对于正常位置的偏移量
    /// - 不影响其他控件布局
    /// - 可用于微调位置（如阴影、装饰效果）
    Relative = 1,
    
    /// 绝对定位
    /// - 脱离文档流
    /// - x/y相对于最近的非static父容器
    /// - 不参与停靠布局
    /// - 可用于弹出层、工具提示等
    Absolute = 2,
    
    /// 固定定位
    /// - 脱离文档流
    /// - x/y相对于视口（窗口客户区）
    /// - 不随父容器滚动
    /// - 可用于固定工具栏、状态栏等
    Fixed = 3,
    
    /// 粘性定位
    /// - 在阈值范围内表现为relative
    /// - 超出阈值后表现为fixed
    /// - 需要配合stickyThreshold使用
    /// - 可用于粘性表头、侧边栏等
    Sticky = 4
}

/**
 * Position - 定位结构
 * 
 * 封装控件的二维坐标、层级和定位模式。
 * 提供类型安全的定位操作，替代裸int x, y字段。
 * 
 * ## 坐标语义
 * 
 * 不同定位模式下，x/y的含义不同：
 * - Static: 最终位置（布局系统计算）
 * - Relative: 偏移量（相对于正常位置）
 * - Absolute/Fixed: 绝对坐标
 * - Sticky: 根据状态变化
 * 
 * ## Z轴（层级）
 * 
 * - 0: 默认层级
 * - >0: 上层（覆盖下层控件）
 * - <0: 下层（被其他控件覆盖）
 * - 同层级控件按添加顺序渲染
 * 
 * ## 示例
 * 
 * ```d
 * // 静态定位（默认）
 * auto pos1 = Position(100, 50);  // 布局系统计算的最终位置
 * 
 * // 相对定位（偏移）
 * auto pos2 = Position(10, -5, 0, PositionMode.Relative);  // 相对正常位置偏移
 * 
 * // 绝对定位
 * auto pos3 = Position(200, 100, 0, PositionMode.Absolute);  // 相对父容器
 * 
 * // 固定定位
 * auto pos4 = Position(0, 0, 10, PositionMode.Fixed);  // 相对视口，层级10
 * ```
 */
struct Position
{
    // ── 字段 ──────────────────────────────────────────────────────
    
    private int _x;              /// X坐标（语义取决于定位模式）
    private int _y;              /// Y坐标（语义取决于定位模式）
    private int _z;              /// Z轴层级（用于叠加顺序）
    private PositionMode _mode;  /// 定位模式
    
    // ── 构造函数 ──────────────────────────────────────────────────
    

    /// 基本构造 - 指定坐标，默认静态定位
    this(int x, int y) nothrow @nogc
    {
        _x = x;
        _y = y;
        _z = 0;
        _mode = PositionMode.Static;
    }
    
    /// 完整构造 - 指定坐标和层级
    this(int x, int y, int z) nothrow @nogc
    {
        _x = x;
        _y = y;
        _z = z;
        _mode = PositionMode.Static;
    }
    
    /// 完整构造 - 指定所有参数
    this(int x, int y, int z, PositionMode mode) nothrow @nogc
    {
        _x = x;
        _y = y;
        _z = z;
        _mode = mode;
    }
    
    /// 便捷构造 - 指定坐标和模式（z=0）
    static Position opCall(int x, int y, PositionMode mode) nothrow @nogc
    {
        return Position(x, y, 0, mode);
    }
    
    // ── 属性访问器 ────────────────────────────────────────────────
    
    /// X坐标
    int x() const nothrow @nogc @property { return _x; }
    void x(int v) nothrow @nogc @property { _x = v; }
    
    /// Y坐标
    int y() const nothrow @nogc @property { return _y; }
    void y(int v) nothrow @nogc @property { _y = v; }
    
    /// Z轴层级
    int z() const nothrow @nogc @property { return _z; }
    void z(int v) nothrow @nogc @property { _z = v; }
    
    /// 定位模式
    PositionMode mode() const nothrow @nogc @property { return _mode; }
    void mode(PositionMode v) nothrow @nogc @property { _mode = v; }
    
    // ── 定位模式判断 ──────────────────────────────────────────────
    
    /// 是否静态定位
    bool isStatic() const nothrow @nogc @property 
    { 
        return _mode == PositionMode.Static; 
    }
    
    /// 是否相对定位
    bool isRelative() const nothrow @nogc @property 
    { 
        return _mode == PositionMode.Relative; 
    }
    
    /// 是否绝对定位
    bool isAbsolute() const nothrow @nogc @property 
    { 
        return _mode == PositionMode.Absolute; 
    }
    
    /// 是否固定定位
    bool isFixed() const nothrow @nogc @property 
    { 
        return _mode == PositionMode.Fixed; 
    }
    
    /// 是否粘性定位
    bool isSticky() const nothrow @nogc @property 
    { 
        return _mode == PositionMode.Sticky; 
    }
    
    /// 是否脱离文档流
    /// Absolute和Fixed会脱离文档流
    bool isOutOfFlow() const nothrow @nogc @property
    {
        return _mode == PositionMode.Absolute || _mode == PositionMode.Fixed;
    }
    
    /// 是否参与布局
    /// Static和Relative参与布局，Absolute/Fixed不参与
    bool participatesInLayout() const nothrow @nogc @property
    {
        return _mode == PositionMode.Static || _mode == PositionMode.Relative;
    }
    
    // ── 坐标操作 ──────────────────────────────────────────────────
    
    /// 设置坐标
    void setXY(int x, int y) nothrow @nogc
    {
        _x = x;
        _y = y;
    }
    
    /// 设置所有值
    void set(int x, int y, int z, PositionMode mode) nothrow @nogc
    {
        _x = x;
        _y = y;
        _z = z;
        _mode = mode;
    }
    
    /// 偏移坐标
    void offset(int dx, int dy) nothrow @nogc
    {
        _x += dx;
        _y += dy;
    }
    
    /// 偏移坐标（含层级）
    void offset(int dx, int dy, int dz) nothrow @nogc
    {
        _x += dx;
        _y += dy;
        _z += dz;
    }
    
    /// 返回偏移后的新位置
    Position shifted(int dx, int dy) const nothrow @nogc
    {
        return Position(_x + dx, _y + dy, _z, _mode);
    }
    
    /// 返回偏移后的新位置（含层级）
    Position shifted(int dx, int dy, int dz) const nothrow @nogc
    {
        return Position(_x + dx, _y + dy, _z + dz, _mode);
    }
    
    // ── 模式转换 ──────────────────────────────────────────────────
    
    /// 转换为静态定位（保持坐标）
    Position toStatic() const nothrow @nogc
    {
        return Position(_x, _y, _z, PositionMode.Static);
    }
    
    /// 转换为相对定位（保持坐标）
    Position toRelative() const nothrow @nogc
    {
        return Position(_x, _y, _z, PositionMode.Relative);
    }
    
    /// 转换为绝对定位（保持坐标）
    Position toAbsolute() const nothrow @nogc
    {
        return Position(_x, _y, _z, PositionMode.Absolute);
    }
    
    /// 转换为固定定位（保持坐标）
    Position toFixed() const nothrow @nogc
    {
        return Position(_x, _y, _z, PositionMode.Fixed);
    }
    
    /// 转换为粘性定位（保持坐标）
    Position toSticky() const nothrow @nogc
    {
        return Position(_x, _y, _z, PositionMode.Sticky);
    }
    
    // ── 比较运算 ──────────────────────────────────────────────────
    
    bool opEquals(const Position rhs) const nothrow @nogc
    {
        return _x == rhs._x && _y == rhs._y && _z == rhs._z && _mode == rhs._mode;
    }
    
    // ── 字符串表示 ────────────────────────────────────────────────
    
    /// 返回字符串表示（用于调试）
    string toString() const
    {
        import std.conv : to;
        
        string modeStr;
        final switch (_mode)
        {
            case PositionMode.Static:   modeStr = "Static";   break;
            case PositionMode.Relative: modeStr = "Relative"; break;
            case PositionMode.Absolute: modeStr = "Absolute"; break;
            case PositionMode.Fixed:    modeStr = "Fixed";    break;
            case PositionMode.Sticky:   modeStr = "Sticky";   break;
        }
        
        return "Position(" ~ _x.to!string ~ ", " ~ _y.to!string ~ 
               ", z=" ~ _z.to!string ~ ", " ~ modeStr ~ ")";
    }
    
    // ── 静态工厂方法 ──────────────────────────────────────────────
    
    /// 创建静态定位
    static Position static_(int x, int y, int z = 0) nothrow @nogc
    {
        return Position(x, y, z, PositionMode.Static);
    }
    
    /// 创建相对定位
    static Position relative(int offsetX, int offsetY, int z = 0) nothrow @nogc
    {
        return Position(offsetX, offsetY, z, PositionMode.Relative);
    }
    
    /// 创建绝对定位
    static Position absolute(int x, int y, int z = 0) nothrow @nogc
    {
        return Position(x, y, z, PositionMode.Absolute);
    }
    
    /// 创建固定定位
    static Position fixed(int x, int y, int z = 0) nothrow @nogc
    {
        return Position(x, y, z, PositionMode.Fixed);
    }
    
    /// 创建粘性定位
    static Position sticky(int x, int y, int z = 0) nothrow @nogc
    {
        return Position(x, y, z, PositionMode.Sticky);
    }
}

/**
 * StickyThreshold - 粘性定位阈值
 * 
 * 定义粘性定位的触发条件。
 * 当控件滚动到阈值边界时，从relative切换为fixed。
 */
struct StickyThreshold
{
    int top = int.min;    /// 顶部阈值（相对于视口），int.min表示未设置
    int right = int.min;  /// 右侧阈值
    int bottom = int.min; /// 底部阈值
    int left = int.min;   /// 左侧阈值
    
    /// 设置顶部阈值
    static StickyThreshold fromTop(int value) nothrow @nogc
    {
        StickyThreshold t;
        t.top = value;
        return t;
    }
    
    /// 设置底部阈值
    static StickyThreshold fromBottom(int value) nothrow @nogc
    {
        StickyThreshold t;
        t.bottom = value;
        return t;
    }
    
    /// 设置左侧阈值
    static StickyThreshold fromLeft(int value) nothrow @nogc
    {
        StickyThreshold t;
        t.left = value;
        return t;
    }
    
    /// 设置右侧阈值
    static StickyThreshold fromRight(int value) nothrow @nogc
    {
        StickyThreshold t;
        t.right = value;
        return t;
    }
    
    /// 是否设置了顶部阈值
    bool hasTop() const nothrow @nogc @property { return top != int.min; }
    
    /// 是否设置了右侧阈值
    bool hasRight() const nothrow @nogc @property { return right != int.min; }
    
    /// 是否设置了底部阈值
    bool hasBottom() const nothrow @nogc @property { return bottom != int.min; }
    
    /// 是否设置了左侧阈值
    bool hasLeft() const nothrow @nogc @property { return left != int.min; }
}

// ── 单元测试 ──────────────────────────────────────────────────────

unittest
{
    import std.stdio;
    
    // 测试基本构造
    auto p1 = Position(0, 0);
    assert(p1.x == 0);
    assert(p1.y == 0);
    assert(p1.z == 0);
    assert(p1.isStatic());
    
    // 测试基本构造
    auto p2 = Position(100, 50);
    assert(p2.x == 100);
    assert(p2.y == 50);
    assert(p2.isStatic());
    
    // 测试完整构造
    auto p3 = Position(200, 100, 5, PositionMode.Absolute);
    assert(p3.x == 200);
    assert(p3.y == 100);
    assert(p3.z == 5);
    assert(p3.isAbsolute());
    assert(p3.isOutOfFlow());
    assert(!p3.participatesInLayout());
    
    // 测试静态工厂方法
    auto p4 = Position.relative(10, -5);
    assert(p4.isRelative());
    assert(p4.participatesInLayout());
    
    auto p5 = Position.fixed(0, 0, 10);
    assert(p5.isFixed());
    assert(p5.isOutOfFlow());
    
    auto p6 = Position.sticky(0, 0);
    assert(p6.isSticky());
    
    // 测试偏移
    auto p7 = p3.shifted(10, 20);
    assert(p7.x == 210);
    assert(p7.y == 120);
    assert(p7.mode == PositionMode.Absolute);
    
    // 测试模式转换
    auto p8 = p3.toRelative();
    assert(p8.isRelative());
    assert(p8.x == 200);  // 坐标保持不变
    
    // 测试比较
    auto p9 = Position(100, 50);
    assert(p2 == p9);
    assert(p2 != p3);
    
    // 测试StickyThreshold
    auto st = StickyThreshold.fromTop(50);
    assert(st.hasTop());
    assert(!st.hasBottom());
    assert(st.top == 50);
    
    writeln("Position 单元测试通过");
}