/**
 * 编码诊断程序 - 测试字符串转换和窗口标题设置
 */
module test_encoding;

/+
dub.sdl:
    name "test_encoding"
    dependency "winlib" path="winlib"
+/

import core.sys.windows.windows;
import std.utf;
import std.stdio;
import std.string;

extern(Windows) {
    HWND CreateWindowExW(uint dwExStyle, const(wchar)* lpClassName, const(wchar)* lpWindowName, 
                         uint dwStyle, int x, int y, int nWidth, int nHeight,
                         HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, void* lpParam);
    BOOL DestroyWindow(HWND hWnd);
    BOOL SetWindowTextW(HWND hWnd, const(wchar)* lpString);
    HINSTANCE GetModuleHandleW(const(wchar)* lpModuleName);
    ATOM RegisterClassExW(const(void*) lpwcx);
    LRESULT DefWindowProcW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);
    LONG_PTR SetWindowLongPtrW(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
}

enum WS_OVERLAPPEDWINDOW = 0x00CF0000;
enum WS_VISIBLE = 0x10000000;
enum GWLP_WNDPROC = -4;
enum COLOR_WINDOW = 5;
enum IDC_ARROW = 32512;
enum CS_HREDRAW = 0x0002;
enum CS_VREDRAW = 0x0001;

struct WNDCLASSEXW {
    uint cbSize;
    uint style;
    extern(Windows) LRESULT function(HWND, uint, WPARAM, LPARAM) lpfnWndProc;
    int cbClsExtra;
    int cbWndExtra;
    HINSTANCE hInstance;
    HICON hIcon;
    HCURSOR hCursor;
    HBRUSH hbrBackground;
    const(wchar)* lpszMenuName;
    const(wchar)* lpszClassName;
    HICON hIconSm;
}

extern(Windows) HICON LoadCursorW(HINSTANCE hInstance, const(wchar)* lpCursorName);

shared static this()
{
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
}

void main()
{
    writeln("=== 编码诊断程序 ===");
    writeln();
    
    // 测试1: 检查字符串字面量
    string testStr = "DGUI - All Controls Demo";
    writeln("测试1: 字符串字面量");
    writeln("  原字符串: ", testStr);
    writeln("  长度: ", testStr.length);
    writeln("  字节: ", testStr.representation);
    writeln();
    
    // 测试2: toUTF16转换
    writeln("测试2: toUTF16转换");
    wstring testW = toUTF16(testStr);
    writeln("  转换后长度: ", testW.length);
    write("  UTF-16编码: ");
    foreach (wchar c; testW)
    {
        writef("%04X ", cast(ushort)c);
    }
    writeln();
    writeln();
    
    // 测试3: 中文测试
    string testCN = "中文测试";
    writeln("测试3: 中文字符串");
    writeln("  原字符串: ", testCN);
    writeln("  长度: ", testCN.length);
    writeln("  字节: ", testCN.representation);
    
    wstring testW_CN = toUTF16(testCN);
    writeln("  UTF-16长度: ", testW_CN.length);
    write("  UTF-16编码: ");
    foreach (wchar c; testW_CN)
    {
        writef("%04X ", cast(ushort)c);
    }
    writeln();
    writeln();
    
    // 测试4: 创建窗口测试
    writeln("测试4: 创建窗口并设置标题");
    
    // 注册窗口类
    extern(Windows) static LRESULT dummyProc(HWND hwnd, uint msg, WPARAM wparam, LPARAM lparam)
    {
        return DefWindowProcW(hwnd, msg, wparam, lparam);
    }
    
    WNDCLASSEXW wc;
    wc.cbSize = WNDCLASSEXW.sizeof;
    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc = &dummyProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = GetModuleHandleW(null);
    wc.hIcon = HICON.init;
    wc.hCursor = LoadCursorW(HINSTANCE.init, cast(const(wchar*))IDC_ARROW);
    wc.hbrBackground = cast(HBRUSH)(COLOR_WINDOW + 1);
    wc.lpszMenuName = null;
    wc.lpszClassName = "TestWindowClass"w.ptr;
    wc.hIconSm = HICON.init;
    
    RegisterClassExW(&wc);
    
    // 创建窗口 - 使用UTF-16字符串
    wstring className = "TestWindowClass"w;
    wstring windowTitle = "测试窗口 - Test Window"w;
    
    HWND hwnd = CreateWindowExW(
        0,
        className.ptr,
        windowTitle.ptr,
        WS_OVERLAPPEDWINDOW | WS_VISIBLE,
        100, 100, 600, 400,
        HWND.init,
        HMENU.init,
        GetModuleHandleW(null),
        null
    );
    
    if (hwnd.Value is null)
    {
        writeln("  错误: 窗口创建失败!");
    }
    else
    {
        writeln("  窗口创建成功!");
        writeln("  窗口句柄: ", hwnd.Value);
        
        // 测试SetWindowTextW
        string newTitle = "新标题 - New Title";
        wstring newTitleW = toUTF16(newTitle);
        writeln("  设置新标题: ", newTitle);
        SetWindowTextW(hwnd, newTitleW.ptr);
        
        // 等待一下让用户看到窗口
        import core.thread;
        Thread.sleep(2.seconds);
        
        DestroyWindow(hwnd);
        writeln("  窗口已销毁");
    }
    
    writeln();
    writeln("=== 诊断完成 ===");
}