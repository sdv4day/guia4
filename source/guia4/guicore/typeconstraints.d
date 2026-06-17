module guia4.guicore.typeconstraints;

import guia4.guicore.events;

/**
 * 编译时类型约束
 * 
 * 使用D语言的模板约束(template constraints)和__traits
 * 在编译时验证类型安全性,避免运行时错误
 */

/**
 * 验证类型是否为有效的事件结构体
 */
template isValidEvent(T)
{
    enum bool isValidEvent = 
        is(T == struct) &&
        __traits(compiles, T.init.stopPropagation()) &&
        __traits(compiles, T.init.stopImmediatePropagation()) &&
        __traits(compiles, T.init.propagationStopped) &&
        __traits(compiles, T.init.id);
}

/**
 * 验证类型是否为有效的控件
 */
template isValidControl(T)
{
    enum bool isValidControl = 
        is(T == class) &&
        __traits(compiles, T.init.width()) &&
        __traits(compiles, T.init.height()) &&
        __traits(compiles, T.init.visible()) &&
        __traits(compiles, T.init.parent());
}

/**
 * 验证类型是否为有效的布局管理器
 */
template isValidLayout(T)
{
    enum bool isValidLayout = 
        is(T == class) &&
        __traits(compiles, T.init.layout(null));
}

/**
 * 类型安全的事件处理器包装器
 */
struct SafeEventHandler(T)
if (isValidEvent!T)
{
    private void delegate(ref T) _handler;
    
    /**
     * 设置事件处理器
     * 
     * Params:
     *   handler = 事件处理委托
     */
    void setHandler(H)(H handler)
    if (is(typeof({ T event; handler(event); })))
    {
        _handler = handler;
    }
    
    /**
     * 触发事件
     * 
     * Params:
     *   event = 事件对象
     */
    void fire(ref T event)
    {
        if (_handler !is null)
            _handler(event);
    }
    
    /**
     * 检查是否已设置处理器
     */
    bool hasHandler() const nothrow @nogc @property
    {
        return _handler !is null;
    }
}

/**
 * 类型安全的控件容器
 */
struct SafeControlContainer(T)
if (isValidControl!T)
{
    private T[] _controls;
    
    /**
     * 添加控件
     */
    void add(T control)
    {
        _controls ~= control;
    }
    
    /**
     * 移除控件
     */
    void remove(T control)
    {
        foreach (i, c; _controls)
        {
            if (c is control)
            {
                _controls = _controls[0 .. i] ~ _controls[i + 1 .. $];
                return;
            }
        }
    }
    
    /**
     * 获取所有控件
     */
    T[] controls() nothrow @nogc @property
    {
        return _controls;
    }
    
    /**
     * 获取控件数量
     */
    size_t length() const nothrow @nogc @property
    {
        return _controls.length;
    }
}

// ── 编译时验证示例 ─────────────────────────────────────

/**
 * 编译时验证所有事件类型都满足约束
 */
static assert(isValidEvent!ClickEvent);
static assert(isValidEvent!MouseEvent);
static assert(isValidEvent!KeyEvent);
static assert(isValidEvent!ResizeEvent);
static assert(isValidEvent!CloseEvent);
static assert(isValidEvent!MouseWheelEvent);

/**
 * 编译时验证SafeEventHandler可以正常工作
 */
static assert(isValidEvent!ClickEvent);
static assert(__traits(compiles, SafeEventHandler!ClickEvent.init));

/**
 * 示例:类型安全的事件处理器使用
 */
unittest
{
    // 创建类型安全的点击事件处理器
    auto handler = SafeEventHandler!ClickEvent();
    
    // 设置处理器
    handler.setHandler((ref ClickEvent e) 
    { 
        // 编译时类型安全的事件处理
        assert(e.x >= 0);
        assert(e.y >= 0);
    });
    
    // 触发事件
    ClickEvent event;
    event.x = 100;
    event.y = 200;
    handler.fire(event);
    
    assert(handler.hasHandler);
}
