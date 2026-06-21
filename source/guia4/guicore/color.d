module guia4.guicore.color;

import std.format : format;
import std.conv : to;
import std.string : strip, toUpper;
import std.algorithm.comparison : min, max;

/// HSL to RGB helper — extracted from nested function for @nogc compatibility
private static pure nothrow @safe @nogc float hue2rgb(float p, float q, float t)
{
    if (t < 0.0f) t += 1.0f;
    if (t > 1.0f) t -= 1.0f;
    if (t < 1.0f / 6.0f) return p + (q - p) * 6.0f * t;
    if (t < 1.0f / 2.0f) return q;
    if (t < 2.0f / 3.0f) return p + (q - p) * (2.0f / 3.0f - t) * 6.0f;
    return p;
}

/**
 * 多功能颜色结构体（跨平台）
 * 
 * 支持多种颜色格式：
 * - RGB/RGBA：红绿蓝透明度（0-255）
 * - HSL：色相饱和度亮度（H:0-360, S:0-100, L:0-100）
 * - HSV/HSB：色相饱和度明度
 * - CMYK：青洋红黄黑（0-100）
 * - HEX：十六进制字符串
 * 
 * 内部存储为 RGBA（跨平台），提供 toBGR() 方法用于 Windows GDI。
 */
struct Color
{
    // RGBA 顺序存储（跨平台）
    private union
    {
        struct
        {
            ubyte _r, _g, _b, _a;  // RGBA顺序
        }
        uint _value;  // 32位整数值（直接访问）
    }

    // ==================== 构造函数 ====================

    /// 基础构造函数（RGBA）
    this(ubyte r, ubyte g, ubyte b, ubyte a = 255) @safe pure nothrow @nogc
    {
        _r = r;
        _g = g;
        _b = b;
        _a = a;
    }

    // ==================== 转换方法 ====================

    /// 转换为BGR格式（Windows GDI COLORREF 格式：0x00BBGGRR）
    uint toBGR() const @safe pure nothrow @nogc
    {
        return (_b << 16) | (_g << 8) | _r;
    }

    /// 从BGR格式创建Color
    static Color fromBGR(uint bgr) @safe pure nothrow @nogc
    {
        Color c;
        c._r = cast(ubyte)(bgr & 0xFF);
        c._g = cast(ubyte)((bgr >> 8) & 0xFF);
        c._b = cast(ubyte)((bgr >> 16) & 0xFF);
        c._a = 255;
        return c;
    }

    /// 从32位整数值创建Color
    static Color fromValue(uint v) @safe pure nothrow @nogc
    {
        Color c;
        c._value = v;
        return c;
    }

    /// 获取32位整数值
    uint value() const @property @safe pure nothrow @nogc { return _value; }

    // ==================== 预定义颜色 ====================

    /// 透明
    static Color transparent() @safe pure nothrow @nogc
    {
        return Color(0, 0, 0, 0);
    }

    /// 黑色
    static Color black() @safe pure nothrow @nogc { return Color(0, 0, 0); }
    /// 白色
    static Color white() @safe pure nothrow @nogc { return Color(255, 255, 255); }
    /// 红色
    static Color red() @safe pure nothrow @nogc { return Color(255, 0, 0); }
    /// 绿色
    static Color green() @safe pure nothrow @nogc { return Color(0, 128, 0); }
    /// 蓝色
    static Color blue() @safe pure nothrow @nogc { return Color(0, 0, 255); }
    /// 灰色
    static Color gray() @safe pure nothrow @nogc { return Color(128, 128, 128); }
    /// 黄色
    static Color yellow() @safe pure nothrow @nogc { return Color(255, 255, 0); }
    /// 青色
    static Color cyan() @safe pure nothrow @nogc { return Color(0, 255, 255); }
    /// 品红色
    static Color magenta() @safe pure nothrow @nogc { return Color(255, 0, 255); }
    /// 橙色
    static Color orange() @safe pure nothrow @nogc { return Color(255, 128, 0); }
    /// 紫色
    static Color purple() @safe pure nothrow @nogc { return Color(128, 0, 128); }
    /// 粉色
    static Color pink() @safe pure nothrow @nogc { return Color(255, 192, 203); }
    /// 棕色
    static Color brown() @safe pure nothrow @nogc { return Color(139, 69, 19); }

    // ==================== 静态工厂方法 ====================

    /// 从RGB创建（不透明）
    static Color rgb(ubyte r, ubyte g, ubyte b) @safe pure nothrow @nogc
    {
        return Color(r, g, b, 255);
    }

    /// 从RGBA创建
    static Color rgba(ubyte r, ubyte g, ubyte b, ubyte a) @safe pure nothrow @nogc
    {
        return Color(r, g, b, a);
    }

    /// 从HSL创建（H:0-360, S:0-100, L:0-100）
    static Color hsl(float h, float s, float l) @safe pure nothrow
    {
        return hslToRgb(h, s, l);
    }

    /// 从HSV/HSB创建（H:0-360, S:0-100, V:0-100）
    static Color hsv(float h, float s, float v) @safe pure nothrow
    {
        return hsvToRgb(h, s, v);
    }

    /// 从十六进制字符串创建
    static Color hex(string hexColor) @safe pure
    {
        return parseHex(hexColor);
    }

    // ==================== 预定义颜色（枚举组） ====================
    
    /**
     * 预定义颜色枚举组
     * 
     * 使用方式：Color.Colors.black, Color.Colors.white 等
     */
    enum Colors
    {
        /// 黑色
        black = Color(0, 0, 0),
        
        /// 白色
        white = Color(255, 255, 255),
        
        /// 红色
        red = Color(255, 0, 0),
        
        /// 绿色
        green = Color(0, 255, 0),
        
        /// 蓝色
        blue = Color(0, 0, 255),
        
        /// 黄色
        yellow = Color(255, 255, 0),
        
        /// 青色
        cyan = Color(0, 255, 255),
        
        /// 洋红
        magenta = Color(255, 0, 255),
        
        /// 橙色
        orange = Color(255, 165, 0),
        
        /// 紫色
        purple = Color(128, 0, 128),
        
        /// 粉色
        pink = Color(255, 192, 203),
        
        /// 灰色
        gray = Color(128, 128, 128),
        
        /// 浅灰色
        lightGray = Color(192, 192, 192),
        
        /// 深灰色
        darkGray = Color(64, 64, 64),
        
        /// 棕色
        brown = Color(165, 42, 42),
        
        /// 橄榄绿
        olive = Color(128, 128, 0),
        
        /// 海军蓝
        navy = Color(0, 0, 128),
        
        /// 青绿色
        teal = Color(0, 128, 128),
        
        /// 深红色
        darkRed = Color(139, 0, 0),
        
        /// 深绿色
        darkGreen = Color(0, 100, 0),
        
        /// 深蓝色
        darkBlue = Color(0, 0, 139),
        
        /// 浅红色
        lightRed = Color(255, 128, 128),
        
        /// 浅绿色
        lightGreen = Color(144, 238, 144),
        
        /// 浅蓝色
        lightBlue = Color(173, 216, 230)
    }

    // ==================== 运算符重载 ====================

    /// 相等比较
    bool opEquals(Color rhs) const @safe pure nothrow @nogc
    {
        return _r == rhs._r && _g == rhs._g && _b == rhs._b && _a == rhs._a;
    }

    // ==================== 内部转换函数 ====================

private:
    /// 色相取模（pure版本）
    static float hueMod(float h, float mod) @safe pure nothrow @nogc
    {
        float result = h;
        while (result >= mod) result -= mod;
        while (result < 0.0f) result += mod;
        return result;
    }

    /// 限制值在范围内
    static float clamp(float value, float minVal, float maxVal) @safe pure nothrow @nogc
    {
        if (value < minVal) return minVal;
        if (value > maxVal) return maxVal;
        return value;
    }

    /// RGB转HSL
    static float[3] rgbToHsl(ubyte r, ubyte g, ubyte b) @safe pure nothrow @nogc
    {
        float rf = cast(float)r / 255.0f;
        float gf = cast(float)g / 255.0f;
        float bf = cast(float)b / 255.0f;

        float maxVal = max(max(rf, gf), bf);
        float minVal = min(min(rf, gf), bf);
        float h, s, l = (maxVal + minVal) / 2.0f;

        if (maxVal == minVal)
        {
            h = 0.0f;
            s = 0.0f;
        }
        else
        {
            float d = maxVal - minVal;
            s = l > 0.5f ? d / (2.0f - maxVal - minVal) : d / (maxVal + minVal);

            if (maxVal == rf)
                h = (gf - bf) / d + (gf < bf ? 6.0f : 0.0f);
            else if (maxVal == gf)
                h = (bf - rf) / d + 2.0f;
            else
                h = (rf - gf) / d + 4.0f;

            h *= 60.0f;
        }

        return [h, s * 100.0f, l * 100.0f];
    }

    /// HSL转RGB
    static Color hslToRgb(float h, float s, float l) @safe pure nothrow @nogc
    {
        h = hueMod(h, 360.0f);
        if (h < 0.0f) h += 360.0f;
        s = clamp(s, 0.0f, 100.0f) / 100.0f;
        l = clamp(l, 0.0f, 100.0f) / 100.0f;

        float r, g, b;

        if (s == 0.0f)
        {
            r = g = b = l;
        }
        else
        {
            float q = l < 0.5f ? l * (1.0f + s) : l + s - l * s;
            float p = 2.0f * l - q;
            r = hue2rgb(p, q, h / 360.0f + 1.0f / 3.0f);
            g = hue2rgb(p, q, h / 360.0f);
            b = hue2rgb(p, q, h / 360.0f - 1.0f / 3.0f);
        }

        return Color(
            cast(ubyte)(r * 255.0f + 0.5f),
            cast(ubyte)(g * 255.0f + 0.5f),
            cast(ubyte)(b * 255.0f + 0.5f)
        );
    }

    /// RGB转HSV
    static float[3] rgbToHsv(ubyte r, ubyte g, ubyte b) @safe pure nothrow @nogc
    {
        float rf = cast(float)r / 255.0f;
        float gf = cast(float)g / 255.0f;
        float bf = cast(float)b / 255.0f;

        float maxVal = max(max(rf, gf), bf);
        float minVal = min(min(rf, gf), bf);
        float h, s, v = maxVal;

        float d = maxVal - minVal;
        s = maxVal == 0.0f ? 0.0f : d / maxVal;

        if (maxVal == minVal)
        {
            h = 0.0f;
        }
        else
        {
            if (maxVal == rf)
                h = (gf - bf) / d + (gf < bf ? 6.0f : 0.0f);
            else if (maxVal == gf)
                h = (bf - rf) / d + 2.0f;
            else
                h = (rf - gf) / d + 4.0f;

            h *= 60.0f;
        }

        return [h, s * 100.0f, v * 100.0f];
    }

    /// HSV转RGB
    static Color hsvToRgb(float h, float s, float v) @safe pure nothrow @nogc
    {
        h = hueMod(h, 360.0f);
        if (h < 0.0f) h += 360.0f;
        s = clamp(s, 0.0f, 100.0f) / 100.0f;
        v = clamp(v, 0.0f, 100.0f) / 100.0f;

        float r, g, b;

        int i = cast(int)(h / 60.0f);
        float f = h / 60.0f - cast(float)i;
        float p = v * (1.0f - s);
        float q = v * (1.0f - f * s);
        float t = v * (1.0f - (1.0f - f) * s);

        switch (i % 6)
        {
            case 0: r = v; g = t; b = p; break;
            case 1: r = q; g = v; b = p; break;
            case 2: r = p; g = v; b = t; break;
            case 3: r = p; g = q; b = v; break;
            case 4: r = t; g = p; b = v; break;
            case 5: r = v; g = p; b = q; break;
            default: r = g = b = 0.0f; break;
        }

        return Color(
            cast(ubyte)(r * 255.0f + 0.5f),
            cast(ubyte)(g * 255.0f + 0.5f),
            cast(ubyte)(b * 255.0f + 0.5f)
        );
    }

    /// RGB转CMYK
    static float[4] rgbToCmyk(ubyte r, ubyte g, ubyte b) @safe pure nothrow @nogc
    {
        float rf = cast(float)r / 255.0f;
        float gf = cast(float)g / 255.0f;
        float bf = cast(float)b / 255.0f;

        float k = 1.0f - max(max(rf, gf), bf);
        float c, m, y;

        if (k == 1.0f)
        {
            c = m = y = 0.0f;
        }
        else
        {
            c = (1.0f - rf - k) / (1.0f - k);
            m = (1.0f - gf - k) / (1.0f - k);
            y = (1.0f - bf - k) / (1.0f - k);
        }

        return [c * 100.0f, m * 100.0f, y * 100.0f, k * 100.0f];
    }

    /// CMYK转RGB
    static Color cmykToRgb(float c, float m, float y, float k) @safe pure nothrow @nogc
    {
        c = clamp(c, 0.0f, 100.0f) / 100.0f;
        m = clamp(m, 0.0f, 100.0f) / 100.0f;
        y = clamp(y, 0.0f, 100.0f) / 100.0f;
        k = clamp(k, 0.0f, 100.0f) / 100.0f;

        float r = (1.0f - c) * (1.0f - k);
        float g = (1.0f - m) * (1.0f - k);
        float b = (1.0f - y) * (1.0f - k);

        return Color(
            cast(ubyte)(r * 255.0f + 0.5f),
            cast(ubyte)(g * 255.0f + 0.5f),
            cast(ubyte)(b * 255.0f + 0.5f)
        );
    }

    /// 解析十六进制字符
    static ubyte parseHexChar(char c) @safe pure nothrow @nogc
    {
        if (c >= '0' && c <= '9') return cast(ubyte)(c - '0');
        if (c >= 'A' && c <= 'F') return cast(ubyte)(c - 'A' + 10);
        if (c >= 'a' && c <= 'f') return cast(ubyte)(c - 'a' + 10);
        return 0;
    }

    /// 解析十六进制字符串
    static Color parseHex(string hexColor) @safe pure
    {
        string hex = hexColor.strip();
        
        // 移除前导#
        if (hex.length > 0 && hex[0] == '#')
            hex = hex[1..$];
        
        hex = hex.toUpper();

        if (hex.length == 3)
        {
            // #RGB -> RRGGBB
            ubyte r = cast(ubyte)((parseHexChar(hex[0]) << 4) | parseHexChar(hex[0]));
            ubyte g = cast(ubyte)((parseHexChar(hex[1]) << 4) | parseHexChar(hex[1]));
            ubyte b = cast(ubyte)((parseHexChar(hex[2]) << 4) | parseHexChar(hex[2]));
            return Color(r, g, b, 255);
        }
        else if (hex.length == 4)
        {
            // #RGBA -> RRGGBBAA
            ubyte r = cast(ubyte)((parseHexChar(hex[0]) << 4) | parseHexChar(hex[0]));
            ubyte g = cast(ubyte)((parseHexChar(hex[1]) << 4) | parseHexChar(hex[1]));
            ubyte b = cast(ubyte)((parseHexChar(hex[2]) << 4) | parseHexChar(hex[2]));
            ubyte a = cast(ubyte)((parseHexChar(hex[3]) << 4) | parseHexChar(hex[3]));
            return Color(r, g, b, a);
        }
        else if (hex.length == 6)
        {
            // #RRGGBB
            ubyte r = cast(ubyte)((parseHexChar(hex[0]) << 4) | parseHexChar(hex[1]));
            ubyte g = cast(ubyte)((parseHexChar(hex[2]) << 4) | parseHexChar(hex[3]));
            ubyte b = cast(ubyte)((parseHexChar(hex[4]) << 4) | parseHexChar(hex[5]));
            return Color(r, g, b, 255);
        }
        else if (hex.length == 8)
        {
            // #RRGGBBAA
            ubyte r = cast(ubyte)((parseHexChar(hex[0]) << 4) | parseHexChar(hex[1]));
            ubyte g = cast(ubyte)((parseHexChar(hex[2]) << 4) | parseHexChar(hex[3]));
            ubyte b = cast(ubyte)((parseHexChar(hex[4]) << 4) | parseHexChar(hex[5]));
            ubyte a = cast(ubyte)((parseHexChar(hex[6]) << 4) | parseHexChar(hex[7]));
            return Color(r, g, b, a);
        }

        // 默认返回黑色
        return Color(0, 0, 0, 255);
    }
}

// ==================== 单元测试 ====================

unittest
{
    import std.stdio : writeln;

    // 测试RGB创建
    auto c1 = Color.rgb(255, 128, 64);
    assert(c1.r == 255);
    assert(c1.g == 128);
    assert(c1.b == 64);
    assert(c1.a == 255);

    // 测试RGBA创建
    auto c2 = Color.rgba(100, 150, 200, 128);
    assert(c2.r == 100);
    assert(c2.a == 128);

    // 测试HSL转换
    auto c3 = Color.hsl(120.0f, 50.0f, 50.0f); // 绿色
    auto hsl = c3.toHSL();
    assert(hsl[0] >= 119.0f && hsl[0] <= 121.0f);

    // 测试HSV转换
    auto c4 = Color.hsv(240.0f, 100.0f, 100.0f); // 蓝色
    assert(c4.b > 250);
    auto hsv = c4.toHSV();
    assert(hsv[0] >= 239.0f && hsv[0] <= 241.0f);

    // 测试十六进制
    auto c5 = Color.hex("#FF8000");
    assert(c5.r == 255);
    assert(c5.g == 128);
    assert(c5.b == 0);

    auto c6 = Color.hex("#F00");
    assert(c6.r == 255);
    assert(c6.g == 0);
    assert(c6.b == 0);

    // 测试BGR转换
    auto c7 = Color.rgb(255, 128, 64);
    uint bgr = c7.toBGR();
    auto c8 = Color.fromBGR(bgr);
    assert(c7.r == c8.r);
    assert(c7.g == c8.g);
    assert(c7.b == c8.b);

    // 测试union共享内存
    auto c9 = Color.rgb(0x12, 0x34, 0x56);
    assert(c9.r == 0x12);
    assert(c9.g == 0x34);
    assert(c9.b == 0x56);
    // 验证BGR格式：0x00BBGGRR = 0x00563412
    assert(c9.toBGR() == 0x00563412);

    // 测试value属性
    auto c10 = Color.fromValue(0xFF804020);
    assert(c10.r == 0x20);  // R在最低字节
    assert(c10.g == 0x40);
    assert(c10.b == 0x80);
    assert(c10.a == 0xFF);

    // 测试颜色混合
    auto red = Color.red();
    auto blue = Color.blue();
    auto mixed = red.blend(blue, 0.5f);
    assert(mixed.r == 127 || mixed.r == 128);
    assert(mixed.b == 127 || mixed.b == 128);

    // 测试亮度调整
    auto gray = Color.gray();
    auto lighter = gray.lighter(0.5f);
    auto darker = gray.darker(0.5f);
    assert(lighter.r > gray.r);
    assert(darker.r < gray.r);

    // 测试透明度
    auto c11 = Color.red().withAlpha(128);
    assert(c11.r == 255);
    assert(c11.a == 128);

    // 测试预定义颜色
    assert(Color.black().r == 0);
    assert(Color.white().r == 255);
    assert(Color.transparent().a == 0);

    // 测试反色
    auto c12 = Color.rgb(100, 150, 200);
    auto inv = c12.inverted();
    assert(inv.r == 155);
    assert(inv.g == 105);
    assert(inv.b == 55);

    // 测试灰度化
    auto c13 = Color.rgb(100, 100, 100);
    auto gray13 = c13.toGrayscale();
    assert(gray13.r == gray13.g && gray13.g == gray13.b);

    // 测试相等比较
    auto c14 = Color.rgb(100, 150, 200);
    auto c15 = Color.rgb(100, 150, 200);
    assert(c14 == c15);

    writeln("Color结构体单元测试通过！");
}