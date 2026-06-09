module guia4.platform_win32.win32defs;

// 公共类型别名
alias LONG = int;
alias LONG_PTR = long;

// 虚键码常量
enum : uint
{
    VK_BACK    = 0x08,
    VK_TAB     = 0x09,
    VK_RETURN  = 0x0D,
    VK_SHIFT   = 0x10,
    VK_CONTROL = 0x11,
    VK_SPACE   = 0x20,
    VK_HOME    = 0x24,
    VK_END     = 0x23,
    VK_LEFT    = 0x25,
    VK_UP      = 0x26,
    VK_RIGHT   = 0x27,
    VK_DOWN    = 0x28,
    VK_ESCAPE  = 0x1B,
    VK_DELETE  = 0x2E,
    VK_F2      = 0x71,
}