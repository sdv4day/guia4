/**
 * 简化的编码诊断程序
 */
module test_encoding_simple;

import std.utf;
import std.stdio;
import std.conv;

shared static this()
{
    import core.sys.windows.windows;
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
}

void main()
{
    writeln("=== 编码诊断程序 ===");
    writeln();
    
    // 测试1: 检查字符串字面量
    string testStr = "DGUI - All Controls Demo";
    writeln("测试1: 英文字符串字面量");
    writeln("  原字符串: ", testStr);
    writeln("  长度: ", testStr.length, " 字符");
    writeln("  字节表示: ", testStr.representation);
    writeln();
    
    // 测试2: toUTF16转换
    writeln("测试2: toUTF16转换（英文）");
    try {
        wstring testW = toUTF16(testStr);
        writeln("  转换成功!");
        writeln("  UTF-16长度: ", testW.length, " wchar");
        write("  UTF-16编码: ");
        foreach (wchar c; testW)
        {
            writef("%04X ", cast(ushort)c);
        }
        writeln();
        writeln("  重建字符串: ", toUTF8(testW));
    } catch (Exception e) {
        writeln("  错误: ", e.msg);
    }
    writeln();
    
    // 测试3: 中文测试
    string testCN = "中文测试";
    writeln("测试3: 中文字符串");
    writeln("  原字符串: ", testCN);
    writeln("  长度: ", testCN.length, " 字节");
    writeln("  字节表示: ", testCN.representation);
    
    try {
        wstring testW_CN = toUTF16(testCN);
        writeln("  UTF-16长度: ", testW_CN.length, " wchar");
        write("  UTF-16编码: ");
        foreach (wchar c; testW_CN)
        {
            writef("%04X ", cast(ushort)c);
        }
        writeln();
        writeln("  重建字符串: ", toUTF8(testW_CN));
    } catch (Exception e) {
        writeln("  错误: ", e.msg);
    }
    writeln();
    
    // 测试4: 混合字符串
    string testMix = "DGUI - 所有控件演示";
    writeln("测试4: 混合字符串");
    writeln("  原字符串: ", testMix);
    writeln("  长度: ", testMix.length, " 字节");
    
    try {
        wstring testW_Mix = toUTF16(testMix);
        writeln("  UTF-16长度: ", testW_Mix.length, " wchar");
        write("  UTF-16编码: ");
        foreach (wchar c; testW_Mix)
        {
            writef("%04X ", cast(ushort)c);
        }
        writeln();
        writeln("  重建字符串: ", toUTF8(testW_Mix));
    } catch (Exception e) {
        writeln("  错误: ", e.msg);
    }
    writeln();
    
    // 测试5: 检查源文件编码
    writeln("测试5: 源文件编码检查");
    writeln("  D语言默认源文件编码: UTF-8");
    writeln("  字符串字面量编码: UTF-8");
    
    // 验证字符串是否为有效UTF-8
    import std.utf : validate;
    try {
        validate(testStr);
        writeln("  英文字符串: 有效UTF-8");
    } catch (UTFException e) {
        writeln("  英文字符串: 无效UTF-8 - ", e.msg);
    }
    
    try {
        validate(testCN);
        writeln("  中文字符串: 有效UTF-8");
    } catch (UTFException e) {
        writeln("  中文字符串: 无效UTF-8 - ", e.msg);
    }
    
    try {
        validate(testMix);
        writeln("  混合字符串: 有效UTF-8");
    } catch (UTFException e) {
        writeln("  混合字符串: 无效UTF-8 - ", e.msg);
    }
    
    writeln();
    writeln("=== 诊断完成 ===");
    writeln();
    writeln("结论:");
    writeln("1. 如果所有测试都通过，说明toUTF16转换正常");
    writeln("2. 问题可能在于:");
    writeln("   - CreateWindowExW的参数传递");
    writeln("   - Windows API调用方式");
    writeln("   - 窗口类的注册");
}