module test_color_union;

import std.stdio : writeln;

// 模拟COLORREF定义
struct COLORREF
{
    uint Value;
}

// 重构后的Color结构体
struct Color
{
    // 使用union共享内存，COLORREF格式：0x00BBGGRR
    private union
    {
        struct
        {
            ubyte _b, _g, _r, _a;  // BGR顺序（COLORREF兼容）
        }
        uint _value;  // 32位整数值（直接访问）
        COLORREF _colorref;  // COLORREF类型（直接访问）
    }

    /// 基础构造函数（RGBA）
    this(ubyte r, ubyte g, ubyte b, ubyte a = 255) @safe pure nothrow @nogc
    {
        _r = r;
        _g = g;
        _b = b;
        _a = a;
    }

    /// 红色分量（0-255）
    ubyte r() const @property @safe pure nothrow @nogc
    {
        return _r;
    }

    /// 绿色分量（0-255）
    ubyte g() const @property @safe pure nothrow @nogc
    {
        return _g;
    }

    /// 蓝色分量（0-255）
    ubyte b() const @property @safe pure nothrow @nogc
    {
        return _b;
    }

    /// 透明度分量（0-255，255为不透明）
    ubyte a() const @property @safe pure nothrow @nogc
    {
        return _a;
    }

    /// 转换为COLORREF（直接返回union成员）
    COLORREF toCOLORREF() const @safe pure nothrow @nogc
    {
        return _colorref;
    }

    /// 从COLORREF创建Color（直接赋值union成员）
    static Color fromCOLORREF(COLORREF cr) @safe pure nothrow @nogc
    {
        Color c;
        c._colorref = cr;
        c._a = 255;  // COLORREF没有透明度，默认不透明
        return c;
    }

    /// 直接访问32位颜色值（COLORREF格式：0xAABBGGRR）
    uint value() const @property @safe pure nothrow @nogc
    {
        return _value;
    }

    /// 从32位颜色值创建Color
    static Color fromValue(uint v) @safe pure nothrow @nogc
    {
        Color c;
        c._value = v;
        return c;
    }
}

void main()
{
    writeln("=== Color Union测试 ===");
    
    // 测试1：创建颜色并验证union共享内存
    auto c1 = Color(0x12, 0x34, 0x56, 0xFF);
    writeln("c1: R=", c1.r, " G=", c1.g, " B=", c1.b, " A=", c1.a);
    writeln("c1.value: 0x", c1.value);
    writeln("期望: 0xFF563412 (AABBGGRR格式)");
    assert(c1.r == 0x12);
    assert(c1.g == 0x34);
    assert(c1.b == 0x56);
    assert(c1.a == 0xFF);
    assert(c1.value() == 0xFF563412);
    writeln("✓ 测试1通过：union共享内存正确\n");
    
    // 测试2：COLORREF转换
    auto c2 = Color(255, 128, 64, 255);
    COLORREF cr = c2.toCOLORREF();
    writeln("c2: R=", c2.r, " G=", c2.g, " B=", c2.b);
    writeln("COLORREF.Value: 0x", cr.Value);
    writeln("期望: 0xFF4080FF (COLORREF格式)");
    
    auto c3 = Color.fromCOLORREF(cr);
    writeln("c3: R=", c3.r, " G=", c3.g, " B=", c3.b);
    assert(c2.r == c3.r);
    assert(c2.g == c3.g);
    assert(c2.b == c3.b);
    writeln("✓ 测试2通过：COLORREF转换正确\n");
    
    // 测试3：fromValue
    auto c4 = Color.fromValue(0xFF804020);
    writeln("c4: R=", c4.r, " G=", c4.g, " B=", c4.b, " A=", c4.a);
    writeln("期望: R=0x20, G=0x40, B=0x80, A=0xFF");
    assert(c4.r == 0x20);
    assert(c4.g == 0x40);
    assert(c4.b == 0x80);
    assert(c4.a == 0xFF);
    writeln("✓ 测试3通过：fromValue正确\n");
    
    // 测试4：内存布局验证
    auto c5 = Color(0xAA, 0xBB, 0xCC, 0xDD);
    writeln("c5: R=0x", c5.r, " G=0x", c5.g, " B=0x", c5.b, " A=0x", c5.a);
    writeln("c5.value: 0x", c5.value);
    writeln("内存布局: [_b=0xCC, _g=0xBB, _r=0xAA, _a=0xDD]");
    writeln("对应uint: 0xDDCCBBAA");
    assert(c5.value() == 0xDDCCBBAA);
    writeln("✓ 测试4通过：内存布局正确\n");
    
    writeln("=== 所有测试通过！ ===");
}