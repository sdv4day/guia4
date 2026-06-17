module guia4.guicore.color;

import std.format : format;
import std.conv : to;
import std.string : strip, toUpper;
import std.algorithm.comparison : min, max;
import windows.win32.foundation : COLORREF;

/**
 * 多功能颜色结构体
 * 
 * 支持多种颜色格式：
 * - RGB/RGBA：红绿蓝透明度（0-255）
 * - HSL：色相饱和度亮度（H:0-360, S:0-100, L:0-100）
 * - HSV/HSB：色相饱和度明度
 * - CMYK：青洋红黄黑（0-100）
 * - HEX：十六进制字符串
 * - COLORREF：Windows GDI颜色格式（0x00BBGGRR）
 * 
 * 使用union实现COLORREF和RGB共享内存，内部BGR顺序存储（COLORREF兼容）
 */
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

    /// 从HSL创建（带透明度）
    static Color hsla(float h, float s, float l, ubyte a) @safe pure nothrow
    {
        auto c = hslToRgb(h, s, l);
        c._a = a;
        return c;
    }

    /// 从HSV/HSB创建（H:0-360, S:0-100, V:0-100）
    static Color hsv(float h, float s, float v) @safe pure nothrow
    {
        return hsvToRgb(h, s, v);
    }

    /// 从HSV创建（带透明度）
    static Color hsva(float h, float s, float v, ubyte a) @safe pure nothrow
    {
        auto c = hsvToRgb(h, s, v);
        c._a = a;
        return c;
    }

    /// 从CMYK创建（C,M,Y,K: 0-100）
    static Color cmyk(float c, float m, float y, float k) @safe pure nothrow
    {
        return cmykToRgb(c, m, y, k);
    }

    /// 从CMYK创建（带透明度）
    static Color cmyka(float c, float m, float y, float k, ubyte a) @safe pure nothrow
    {
        auto col = cmykToRgb(c, m, y, k);
        col._a = a;
        return col;
    }

    /// 从十六进制字符串创建（支持 "#RGB", "#RGBA", "#RRGGBB", "#RRGGBBAA"）
    static Color hex(string hexColor) @safe pure
    {
        return parseHex(hexColor);
    }

    // ==================== 预定义颜色常量 ====================

    /// 红色
    static Color red() @safe pure nothrow @nogc { return rgb(255, 0, 0); }
    /// 绿色
    static Color green() @safe pure nothrow @nogc { return rgb(0, 255, 0); }
    /// 蓝色
    static Color blue() @safe pure nothrow @nogc { return rgb(0, 0, 255); }
    /// 黑色
    static Color black() @safe pure nothrow @nogc { return rgb(0, 0, 0); }
    /// 白色
    static Color white() @safe pure nothrow @nogc { return rgb(255, 255, 255); }
    /// 灰色
    static Color gray() @safe pure nothrow @nogc { return rgb(128, 128, 128); }
    /// 黄色
    static Color yellow() @safe pure nothrow @nogc { return rgb(255, 255, 0); }
    /// 青色
    static Color cyan() @safe pure nothrow @nogc { return rgb(0, 255, 255); }
    /// 品红色
    static Color magenta() @safe pure nothrow @nogc { return rgb(255, 0, 255); }
    /// 橙色
    static Color orange() @safe pure nothrow @nogc { return rgb(255, 128, 0); }
    /// 紫色
    static Color purple() @safe pure nothrow @nogc { return rgb(128, 0, 128); }
    /// 粉色
    static Color pink() @safe pure nothrow @nogc { return rgb(255, 192, 203); }
    /// 棕色
    static Color brown() @safe pure nothrow @nogc { return rgb(139, 69, 19); }

    // ==================== 属性访问 ====================

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

    /// 红色分量（0.0-1.0）
    float rf() const @property @safe pure nothrow @nogc
    {
        return cast(float)_r / 255.0f;
    }

    /// 绿色分量（0.0-1.0）
    float gf() const @property @safe pure nothrow @nogc
    {
        return cast(float)_g / 255.0f;
    }

    /// 蓝色分量（0.0-1.0）
    float bf() const @property @safe pure nothrow @nogc
    {
        return cast(float)_b / 255.0f;
    }

    /// 透明度分量（0.0-1.0）
    float af() const @property @safe pure nothrow @nogc
    {
        return cast(float)_a / 255.0f;
    }

    // ==================== 格式转换 ====================

    /// 转换为HSL（返回数组：[H, S, L]）
    float[3] toHSL() const @safe pure nothrow @nogc
    {
        return rgbToHsl(_r, _g, _b);
    }

    /// 转换为HSV（返回数组：[H, S, V]）
    float[3] toHSV() const @safe pure nothrow @nogc
    {
        return rgbToHsv(_r, _g, _b);
    }

    /// 转换为CMYK（返回数组：[C, M, Y, K]）
    float[4] toCMYK() const @safe pure nothrow @nogc
    {
        return rgbToCmyk(_r, _g, _b);
    }

    /// 转换为十六进制字符串（格式：#RRGGBB）
    string toHex() const @safe pure
    {
        return format("#%02X%02X%02X", _r, _g, _b);
    }

    /// 转换为十六进制字符串（带透明度，格式：#RRGGBBAA）
    string toHexAlpha() const @safe pure
    {
        return format("#%02X%02X%02X%02X", _r, _g, _b, _a);
    }

    // ==================== GDI兼容 ====================

    /// 转换为COLORREF（清除alpha通道，Windows GDI要求高位字节为0）
    COLORREF toCOLORREF() const @safe pure nothrow @nogc
    {
        return COLORREF((_r << 16) | (_g << 8) | _b);
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

    // ==================== 颜色操作 ====================

    /// 设置透明度
    Color withAlpha(ubyte a) const @safe pure nothrow @nogc
    {
        return Color(_r, _g, _b, a);
    }

    /// 设置透明度（浮点版本，0.0-1.0）
    Color withAlphaF(float a) const @safe pure nothrow @nogc
    {
        return Color(_r, _g, _b, cast(ubyte)(a * 255.0f));
    }

    /// 颜色混合（线性插值）
    Color blend(Color other, float t) const @safe pure nothrow @nogc
    {
        t = clamp(t, 0.0f, 1.0f);
        float invT = 1.0f - t;
        
        ubyte r = cast(ubyte)(_r * invT + other._r * t);
        ubyte g = cast(ubyte)(_g * invT + other._g * t);
        ubyte b = cast(ubyte)(_b * invT + other._b * t);
        ubyte a = cast(ubyte)(_a * invT + other._a * t);
        
        return Color(r, g, b, a);
    }

    /// 变亮（增加亮度）
    Color lighter(float amount = 0.2f) const @safe pure nothrow @nogc
    {
        auto hsl = rgbToHsl(_r, _g, _b);
        hsl[2] = clamp(hsl[2] + amount * 100.0f, 0.0f, 100.0f);
        auto result = hslToRgb(hsl[0], hsl[1], hsl[2]);
        result._a = _a;
        return result;
    }

    /// 变暗（减少亮度）
    Color darker(float amount = 0.2f) const @safe pure nothrow @nogc
    {
        return lighter(-amount);
    }

    /// 增加饱和度
    Color saturate(float amount = 0.2f) const @safe pure nothrow @nogc
    {
        auto hsl = rgbToHsl(_r, _g, _b);
        hsl[1] = clamp(hsl[1] + amount * 100.0f, 0.0f, 100.0f);
        auto result = hslToRgb(hsl[0], hsl[1], hsl[2]);
        result._a = _a;
        return result;
    }

    /// 减少饱和度（趋向灰色）
    Color desaturate(float amount = 0.2f) const @safe pure nothrow @nogc
    {
        return saturate(-amount);
    }

    /// 旋转色相
    Color rotateHue(float degrees) const @safe pure nothrow @nogc
    {
        auto hsl = rgbToHsl(_r, _g, _b);
        hsl[0] = hueMod(hsl[0] + degrees, 360.0f);
        if (hsl[0] < 0.0f) hsl[0] += 360.0f;
        auto result = hslToRgb(hsl[0], hsl[1], hsl[2]);
        result._a = _a;
        return result;
    }

    /// 取反色
    Color inverted() const @safe pure nothrow @nogc
    {
        return Color(cast(ubyte)(255 - _r), cast(ubyte)(255 - _g), cast(ubyte)(255 - _b), _a);
    }

    /// 灰度化
    Color toGrayscale() const @safe pure nothrow @nogc
    {
        // 使用人眼感知权重
        ubyte gray = cast(ubyte)(0.299f * _r + 0.587f * _g + 0.114f * _b);
        return Color(gray, gray, gray, _a);
    }

    // ==================== 预定义颜色 ====================

    /// 透明
    static Color transparent() @safe pure nothrow @nogc
    {
        return Color(0, 0, 0, 0);
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
            float hue2rgb(float p, float q, float t)
            {
                if (t < 0.0f) t += 1.0f;
                if (t > 1.0f) t -= 1.0f;
                if (t < 1.0f / 6.0f) return p + (q - p) * 6.0f * t;
                if (t < 1.0f / 2.0f) return q;
                if (t < 2.0f / 3.0f) return p + (q - p) * (2.0f / 3.0f - t) * 6.0f;
                return p;
            }

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

    // 测试COLORREF转换
    auto c7 = Color.rgb(255, 128, 64);
    COLORREF cr = c7.toCOLORREF();
    auto c8 = Color.fromCOLORREF(cr);
    assert(c7.r == c8.r);
    assert(c7.g == c8.g);
    assert(c7.b == c8.b);

    // 测试union共享内存
    auto c9 = Color.rgb(0x12, 0x34, 0x56);
    assert(c9.r == 0x12);
    assert(c9.g == 0x34);
    assert(c9.b == 0x56);
    // 验证COLORREF格式：0x00BBGGRR = 0x00563412
    assert(c9.value() == 0xFF563412);  // 包含alpha=255

    // 测试value属性
    auto c10 = Color.fromValue(0xFF804020);
    assert(c10.r == 0x20);  // R在最高字节
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