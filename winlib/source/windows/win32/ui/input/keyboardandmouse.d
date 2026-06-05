// Written in the D programming language.

module windows.win32.ui.input.keyboardandmouse;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, HWND, POINT, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


alias HOT_KEY_MODIFIERS = uint;
enum : uint
{
    MOD_ALT      = 0x00000001,
    MOD_CONTROL  = 0x00000002,
    MOD_NOREPEAT = 0x00004000,
    MOD_SHIFT    = 0x00000004,
    MOD_WIN      = 0x00000008,
}

alias ACTIVATE_KEYBOARD_LAYOUT_FLAGS = uint;
enum : uint
{
    KLF_REORDER       = 0x00000008,
    KLF_RESET         = 0x40000000,
    KLF_SETFORPROCESS = 0x00000100,
    KLF_SHIFTLOCK     = 0x00010000,
    KLF_ACTIVATE      = 0x00000001,
    KLF_NOTELLSHELL   = 0x00000080,
    KLF_REPLACELANG   = 0x00000010,
    KLF_SUBSTITUTE_OK = 0x00000002,
}

alias GET_MOUSE_MOVE_POINTS_EX_RESOLUTION = uint;
enum : uint
{
    GMMP_USE_DISPLAY_POINTS         = 0x00000001,
    GMMP_USE_HIGH_RESOLUTION_POINTS = 0x00000002,
}

alias KEYBD_EVENT_FLAGS = uint;
enum : uint
{
    KEYEVENTF_EXTENDEDKEY = 0x00000001,
    KEYEVENTF_KEYUP       = 0x00000002,
    KEYEVENTF_SCANCODE    = 0x00000008,
    KEYEVENTF_UNICODE     = 0x00000004,
}

alias MOUSE_EVENT_FLAGS = uint;
enum : uint
{
    MOUSEEVENTF_ABSOLUTE        = 0x00008000,
    MOUSEEVENTF_LEFTDOWN        = 0x00000002,
    MOUSEEVENTF_LEFTUP          = 0x00000004,
    MOUSEEVENTF_MIDDLEDOWN      = 0x00000020,
    MOUSEEVENTF_MIDDLEUP        = 0x00000040,
    MOUSEEVENTF_MOVE            = 0x00000001,
    MOUSEEVENTF_RIGHTDOWN       = 0x00000008,
    MOUSEEVENTF_RIGHTUP         = 0x00000010,
    MOUSEEVENTF_WHEEL           = 0x00000800,
    MOUSEEVENTF_XDOWN           = 0x00000080,
    MOUSEEVENTF_XUP             = 0x00000100,
    MOUSEEVENTF_HWHEEL          = 0x00001000,
    MOUSEEVENTF_MOVE_NOCOALESCE = 0x00002000,
    MOUSEEVENTF_VIRTUALDESK     = 0x00004000,
}

alias INPUT_TYPE = uint;
enum : uint
{
    INPUT_MOUSE    = 0x00000000,
    INPUT_KEYBOARD = 0x00000001,
    INPUT_HARDWARE = 0x00000002,
}

alias TRACKMOUSEEVENT_FLAGS = uint;
enum : uint
{
    TME_CANCEL    = 0x80000000,
    TME_HOVER     = 0x00000001,
    TME_LEAVE     = 0x00000002,
    TME_NONCLIENT = 0x00000010,
    TME_QUERY     = 0x40000000,
}

alias VIRTUAL_KEY = ushort;
enum : ushort
{
    VK_0                               = cast(ushort)0x0030,
    VK_1                               = cast(ushort)0x0031,
    VK_2                               = cast(ushort)0x0032,
    VK_3                               = cast(ushort)0x0033,
    VK_4                               = cast(ushort)0x0034,
    VK_5                               = cast(ushort)0x0035,
    VK_6                               = cast(ushort)0x0036,
    VK_7                               = cast(ushort)0x0037,
    VK_8                               = cast(ushort)0x0038,
    VK_9                               = cast(ushort)0x0039,
    VK_A                               = cast(ushort)0x0041,
    VK_B                               = cast(ushort)0x0042,
    VK_C                               = cast(ushort)0x0043,
    VK_D                               = cast(ushort)0x0044,
    VK_E                               = cast(ushort)0x0045,
    VK_F                               = cast(ushort)0x0046,
    VK_G                               = cast(ushort)0x0047,
    VK_H                               = cast(ushort)0x0048,
    VK_I                               = cast(ushort)0x0049,
    VK_J                               = cast(ushort)0x004a,
    VK_K                               = cast(ushort)0x004b,
    VK_L                               = cast(ushort)0x004c,
    VK_M                               = cast(ushort)0x004d,
    VK_N                               = cast(ushort)0x004e,
    VK_O                               = cast(ushort)0x004f,
    VK_P                               = cast(ushort)0x0050,
    VK_Q                               = cast(ushort)0x0051,
    VK_R                               = cast(ushort)0x0052,
    VK_S                               = cast(ushort)0x0053,
    VK_T                               = cast(ushort)0x0054,
    VK_U                               = cast(ushort)0x0055,
    VK_V                               = cast(ushort)0x0056,
    VK_W                               = cast(ushort)0x0057,
    VK_X                               = cast(ushort)0x0058,
    VK_Y                               = cast(ushort)0x0059,
    VK_Z                               = cast(ushort)0x005a,
    VK_ABNT_C1                         = cast(ushort)0x00c1,
    VK_ABNT_C2                         = cast(ushort)0x00c2,
    VK_DBE_ALPHANUMERIC                = cast(ushort)0x00f0,
    VK_DBE_CODEINPUT                   = cast(ushort)0x00fa,
    VK_DBE_DBCSCHAR                    = cast(ushort)0x00f4,
    VK_DBE_DETERMINESTRING             = cast(ushort)0x00fc,
    VK_DBE_ENTERDLGCONVERSIONMODE      = cast(ushort)0x00fd,
    VK_DBE_ENTERIMECONFIGMODE          = cast(ushort)0x00f8,
    VK_DBE_ENTERWORDREGISTERMODE       = cast(ushort)0x00f7,
    VK_DBE_FLUSHSTRING                 = cast(ushort)0x00f9,
    VK_DBE_HIRAGANA                    = cast(ushort)0x00f2,
    VK_DBE_KATAKANA                    = cast(ushort)0x00f1,
    VK_DBE_NOCODEINPUT                 = cast(ushort)0x00fb,
    VK_DBE_NOROMAN                     = cast(ushort)0x00f6,
    VK_DBE_ROMAN                       = cast(ushort)0x00f5,
    VK_DBE_SBCSCHAR                    = cast(ushort)0x00f3,
    VK__none_                          = cast(ushort)0x00ff,
    VK_LBUTTON                         = cast(ushort)0x0001,
    VK_RBUTTON                         = cast(ushort)0x0002,
    VK_CANCEL                          = cast(ushort)0x0003,
    VK_MBUTTON                         = cast(ushort)0x0004,
    VK_XBUTTON1                        = cast(ushort)0x0005,
    VK_XBUTTON2                        = cast(ushort)0x0006,
    VK_BACK                            = cast(ushort)0x0008,
    VK_TAB                             = cast(ushort)0x0009,
    VK_CLEAR                           = cast(ushort)0x000c,
    VK_RETURN                          = cast(ushort)0x000d,
    VK_SHIFT                           = cast(ushort)0x0010,
    VK_CONTROL                         = cast(ushort)0x0011,
    VK_MENU                            = cast(ushort)0x0012,
    VK_PAUSE                           = cast(ushort)0x0013,
    VK_CAPITAL                         = cast(ushort)0x0014,
    VK_KANA                            = cast(ushort)0x0015,
    VK_HANGEUL                         = cast(ushort)0x0015,
    VK_HANGUL                          = cast(ushort)0x0015,
    VK_IME_ON                          = cast(ushort)0x0016,
    VK_JUNJA                           = cast(ushort)0x0017,
    VK_FINAL                           = cast(ushort)0x0018,
    VK_HANJA                           = cast(ushort)0x0019,
    VK_KANJI                           = cast(ushort)0x0019,
    VK_IME_OFF                         = cast(ushort)0x001a,
    VK_ESCAPE                          = cast(ushort)0x001b,
    VK_CONVERT                         = cast(ushort)0x001c,
    VK_NONCONVERT                      = cast(ushort)0x001d,
    VK_ACCEPT                          = cast(ushort)0x001e,
    VK_MODECHANGE                      = cast(ushort)0x001f,
    VK_SPACE                           = cast(ushort)0x0020,
    VK_PRIOR                           = cast(ushort)0x0021,
    VK_NEXT                            = cast(ushort)0x0022,
    VK_END                             = cast(ushort)0x0023,
    VK_HOME                            = cast(ushort)0x0024,
    VK_LEFT                            = cast(ushort)0x0025,
    VK_UP                              = cast(ushort)0x0026,
    VK_RIGHT                           = cast(ushort)0x0027,
    VK_DOWN                            = cast(ushort)0x0028,
    VK_SELECT                          = cast(ushort)0x0029,
    VK_PRINT                           = cast(ushort)0x002a,
    VK_EXECUTE                         = cast(ushort)0x002b,
    VK_SNAPSHOT                        = cast(ushort)0x002c,
    VK_INSERT                          = cast(ushort)0x002d,
    VK_DELETE                          = cast(ushort)0x002e,
    VK_HELP                            = cast(ushort)0x002f,
    VK_LWIN                            = cast(ushort)0x005b,
    VK_RWIN                            = cast(ushort)0x005c,
    VK_APPS                            = cast(ushort)0x005d,
    VK_SLEEP                           = cast(ushort)0x005f,
    VK_NUMPAD0                         = cast(ushort)0x0060,
    VK_NUMPAD1                         = cast(ushort)0x0061,
    VK_NUMPAD2                         = cast(ushort)0x0062,
    VK_NUMPAD3                         = cast(ushort)0x0063,
    VK_NUMPAD4                         = cast(ushort)0x0064,
    VK_NUMPAD5                         = cast(ushort)0x0065,
    VK_NUMPAD6                         = cast(ushort)0x0066,
    VK_NUMPAD7                         = cast(ushort)0x0067,
    VK_NUMPAD8                         = cast(ushort)0x0068,
    VK_NUMPAD9                         = cast(ushort)0x0069,
    VK_MULTIPLY                        = cast(ushort)0x006a,
    VK_ADD                             = cast(ushort)0x006b,
    VK_SEPARATOR                       = cast(ushort)0x006c,
    VK_SUBTRACT                        = cast(ushort)0x006d,
    VK_DECIMAL                         = cast(ushort)0x006e,
    VK_DIVIDE                          = cast(ushort)0x006f,
    VK_F1                              = cast(ushort)0x0070,
    VK_F2                              = cast(ushort)0x0071,
    VK_F3                              = cast(ushort)0x0072,
    VK_F4                              = cast(ushort)0x0073,
    VK_F5                              = cast(ushort)0x0074,
    VK_F6                              = cast(ushort)0x0075,
    VK_F7                              = cast(ushort)0x0076,
    VK_F8                              = cast(ushort)0x0077,
    VK_F9                              = cast(ushort)0x0078,
    VK_F10                             = cast(ushort)0x0079,
    VK_F11                             = cast(ushort)0x007a,
    VK_F12                             = cast(ushort)0x007b,
    VK_F13                             = cast(ushort)0x007c,
    VK_F14                             = cast(ushort)0x007d,
    VK_F15                             = cast(ushort)0x007e,
    VK_F16                             = cast(ushort)0x007f,
    VK_F17                             = cast(ushort)0x0080,
    VK_F18                             = cast(ushort)0x0081,
    VK_F19                             = cast(ushort)0x0082,
    VK_F20                             = cast(ushort)0x0083,
    VK_F21                             = cast(ushort)0x0084,
    VK_F22                             = cast(ushort)0x0085,
    VK_F23                             = cast(ushort)0x0086,
    VK_F24                             = cast(ushort)0x0087,
    VK_NAVIGATION_VIEW                 = cast(ushort)0x0088,
    VK_NAVIGATION_MENU                 = cast(ushort)0x0089,
    VK_NAVIGATION_UP                   = cast(ushort)0x008a,
    VK_NAVIGATION_DOWN                 = cast(ushort)0x008b,
    VK_NAVIGATION_LEFT                 = cast(ushort)0x008c,
    VK_NAVIGATION_RIGHT                = cast(ushort)0x008d,
    VK_NAVIGATION_ACCEPT               = cast(ushort)0x008e,
    VK_NAVIGATION_CANCEL               = cast(ushort)0x008f,
    VK_NUMLOCK                         = cast(ushort)0x0090,
    VK_SCROLL                          = cast(ushort)0x0091,
    VK_OEM_NEC_EQUAL                   = cast(ushort)0x0092,
    VK_OEM_FJ_JISHO                    = cast(ushort)0x0092,
    VK_OEM_FJ_MASSHOU                  = cast(ushort)0x0093,
    VK_OEM_FJ_TOUROKU                  = cast(ushort)0x0094,
    VK_OEM_FJ_LOYA                     = cast(ushort)0x0095,
    VK_OEM_FJ_ROYA                     = cast(ushort)0x0096,
    VK_LSHIFT                          = cast(ushort)0x00a0,
    VK_RSHIFT                          = cast(ushort)0x00a1,
    VK_LCONTROL                        = cast(ushort)0x00a2,
    VK_RCONTROL                        = cast(ushort)0x00a3,
    VK_LMENU                           = cast(ushort)0x00a4,
    VK_RMENU                           = cast(ushort)0x00a5,
    VK_BROWSER_BACK                    = cast(ushort)0x00a6,
    VK_BROWSER_FORWARD                 = cast(ushort)0x00a7,
    VK_BROWSER_REFRESH                 = cast(ushort)0x00a8,
    VK_BROWSER_STOP                    = cast(ushort)0x00a9,
    VK_BROWSER_SEARCH                  = cast(ushort)0x00aa,
    VK_BROWSER_FAVORITES               = cast(ushort)0x00ab,
    VK_BROWSER_HOME                    = cast(ushort)0x00ac,
    VK_VOLUME_MUTE                     = cast(ushort)0x00ad,
    VK_VOLUME_DOWN                     = cast(ushort)0x00ae,
    VK_VOLUME_UP                       = cast(ushort)0x00af,
    VK_MEDIA_NEXT_TRACK                = cast(ushort)0x00b0,
    VK_MEDIA_PREV_TRACK                = cast(ushort)0x00b1,
    VK_MEDIA_STOP                      = cast(ushort)0x00b2,
    VK_MEDIA_PLAY_PAUSE                = cast(ushort)0x00b3,
    VK_LAUNCH_MAIL                     = cast(ushort)0x00b4,
    VK_LAUNCH_MEDIA_SELECT             = cast(ushort)0x00b5,
    VK_LAUNCH_APP1                     = cast(ushort)0x00b6,
    VK_LAUNCH_APP2                     = cast(ushort)0x00b7,
    VK_OEM_1                           = cast(ushort)0x00ba,
    VK_OEM_PLUS                        = cast(ushort)0x00bb,
    VK_OEM_COMMA                       = cast(ushort)0x00bc,
    VK_OEM_MINUS                       = cast(ushort)0x00bd,
    VK_OEM_PERIOD                      = cast(ushort)0x00be,
    VK_OEM_2                           = cast(ushort)0x00bf,
    VK_OEM_3                           = cast(ushort)0x00c0,
    VK_GAMEPAD_A                       = cast(ushort)0x00c3,
    VK_GAMEPAD_B                       = cast(ushort)0x00c4,
    VK_GAMEPAD_X                       = cast(ushort)0x00c5,
    VK_GAMEPAD_Y                       = cast(ushort)0x00c6,
    VK_GAMEPAD_RIGHT_SHOULDER          = cast(ushort)0x00c7,
    VK_GAMEPAD_LEFT_SHOULDER           = cast(ushort)0x00c8,
    VK_GAMEPAD_LEFT_TRIGGER            = cast(ushort)0x00c9,
    VK_GAMEPAD_RIGHT_TRIGGER           = cast(ushort)0x00ca,
    VK_GAMEPAD_DPAD_UP                 = cast(ushort)0x00cb,
    VK_GAMEPAD_DPAD_DOWN               = cast(ushort)0x00cc,
    VK_GAMEPAD_DPAD_LEFT               = cast(ushort)0x00cd,
    VK_GAMEPAD_DPAD_RIGHT              = cast(ushort)0x00ce,
    VK_GAMEPAD_MENU                    = cast(ushort)0x00cf,
    VK_GAMEPAD_VIEW                    = cast(ushort)0x00d0,
    VK_GAMEPAD_LEFT_THUMBSTICK_BUTTON  = cast(ushort)0x00d1,
    VK_GAMEPAD_RIGHT_THUMBSTICK_BUTTON = cast(ushort)0x00d2,
    VK_GAMEPAD_LEFT_THUMBSTICK_UP      = cast(ushort)0x00d3,
    VK_GAMEPAD_LEFT_THUMBSTICK_DOWN    = cast(ushort)0x00d4,
    VK_GAMEPAD_LEFT_THUMBSTICK_RIGHT   = cast(ushort)0x00d5,
    VK_GAMEPAD_LEFT_THUMBSTICK_LEFT    = cast(ushort)0x00d6,
    VK_GAMEPAD_RIGHT_THUMBSTICK_UP     = cast(ushort)0x00d7,
    VK_GAMEPAD_RIGHT_THUMBSTICK_DOWN   = cast(ushort)0x00d8,
    VK_GAMEPAD_RIGHT_THUMBSTICK_RIGHT  = cast(ushort)0x00d9,
    VK_GAMEPAD_RIGHT_THUMBSTICK_LEFT   = cast(ushort)0x00da,
    VK_OEM_4                           = cast(ushort)0x00db,
    VK_OEM_5                           = cast(ushort)0x00dc,
    VK_OEM_6                           = cast(ushort)0x00dd,
    VK_OEM_7                           = cast(ushort)0x00de,
    VK_OEM_8                           = cast(ushort)0x00df,
    VK_OEM_AX                          = cast(ushort)0x00e1,
    VK_OEM_102                         = cast(ushort)0x00e2,
    VK_ICO_HELP                        = cast(ushort)0x00e3,
    VK_ICO_00                          = cast(ushort)0x00e4,
    VK_PROCESSKEY                      = cast(ushort)0x00e5,
    VK_ICO_CLEAR                       = cast(ushort)0x00e6,
    VK_PACKET                          = cast(ushort)0x00e7,
    VK_OEM_RESET                       = cast(ushort)0x00e9,
    VK_OEM_JUMP                        = cast(ushort)0x00ea,
    VK_OEM_PA1                         = cast(ushort)0x00eb,
    VK_OEM_PA2                         = cast(ushort)0x00ec,
    VK_OEM_PA3                         = cast(ushort)0x00ed,
    VK_OEM_WSCTRL                      = cast(ushort)0x00ee,
    VK_OEM_CUSEL                       = cast(ushort)0x00ef,
    VK_OEM_ATTN                        = cast(ushort)0x00f0,
    VK_OEM_FINISH                      = cast(ushort)0x00f1,
    VK_OEM_COPY                        = cast(ushort)0x00f2,
    VK_OEM_AUTO                        = cast(ushort)0x00f3,
    VK_OEM_ENLW                        = cast(ushort)0x00f4,
    VK_OEM_BACKTAB                     = cast(ushort)0x00f5,
    VK_ATTN                            = cast(ushort)0x00f6,
    VK_CRSEL                           = cast(ushort)0x00f7,
    VK_EXSEL                           = cast(ushort)0x00f8,
    VK_EREOF                           = cast(ushort)0x00f9,
    VK_PLAY                            = cast(ushort)0x00fa,
    VK_ZOOM                            = cast(ushort)0x00fb,
    VK_NONAME                          = cast(ushort)0x00fc,
    VK_PA1                             = cast(ushort)0x00fd,
    VK_OEM_CLEAR                       = cast(ushort)0x00fe,
}

alias MAP_VIRTUAL_KEY_TYPE = uint;
enum : uint
{
    MAPVK_VK_TO_VSC    = 0x00000000,
    MAPVK_VSC_TO_VK    = 0x00000001,
    MAPVK_VK_TO_CHAR   = 0x00000002,
    MAPVK_VSC_TO_VK_EX = 0x00000003,
    MAPVK_VK_TO_VSC_EX = 0x00000004,
}

// Constants


enum uint EXTENDED_BIT = 0x01000000;
enum uint FAKE_KEYSTROKE = 0x02000000;
enum uint KBDSHIFT = 0x00000001;

enum : uint
{
    KBDALT       = 0x00000004,
    KBDKANA      = 0x00000008,
    KBDROYA      = 0x00000010,
    KBDLOYA      = 0x00000020,
    KBDGRPSELTAP = 0x00000080,
}

enum uint ACUTE = 0x00000301;
enum uint TILDE = 0x00000303;
enum uint OVERSCORE = 0x00000305;
enum uint DOT_ABOVE = 0x00000307;
enum uint DIARESIS = 0x00000308;
enum uint RING = 0x0000030a;
enum uint HACEK = 0x0000030c;
enum uint OGONEK = 0x00000328;
enum uint DIARESIS_TONOS = 0x00000385;
enum const(wchar)* wszACUTE = "́";
enum const(wchar)* wszTILDE = "̃";
enum const(wchar)* wszOVERSCORE = "̅";
enum const(wchar)* wszDOT_ABOVE = "̇";
enum const(wchar)* wszHOOK_ABOVE = "̉";
enum const(wchar)* wszDOUBLE_ACUTE = "̋";
enum const(wchar)* wszCEDILLA = "̧";
enum const(wchar)* wszTONOS = "΄";
enum uint SHFT_INVALID = 0x0000000f;

enum : uint
{
    WCH_DEAD = 0x0000f001,
    WCH_LGTR = 0x0000f002,
}

enum uint SGCAPS = 0x00000002;
enum uint KANALOK = 0x00000008;
enum uint DKF_DEAD = 0x00000001;

enum : uint
{
    KLLF_ALTGR     = 0x00000001,
    KLLF_SHIFTLOCK = 0x00000002,
}

enum uint KLLF_GLOBAL_ATTRS = 0x00000002;

enum : uint
{
    KEYBOARD_TYPE_GENERIC_101 = 0x00000004,
    KEYBOARD_TYPE_JAPAN       = 0x00000007,
    KEYBOARD_TYPE_KOREA       = 0x00000008,
    KEYBOARD_TYPE_UNKNOWN     = 0x00000051,
}

enum : uint
{
    NLSKBD_OEM_AX         = 0x00000001,
    NLSKBD_OEM_EPSON      = 0x00000004,
    NLSKBD_OEM_FUJITSU    = 0x00000005,
    NLSKBD_OEM_IBM        = 0x00000007,
    NLSKBD_OEM_MATSUSHITA = 0x0000000a,
    NLSKBD_OEM_NEC        = 0x0000000d,
    NLSKBD_OEM_TOSHIBA    = 0x00000012,
    NLSKBD_OEM_DEC        = 0x00000018,
}

enum : uint
{
    MICROSOFT_KBD_AX_TYPE  = 0x00000001,
    MICROSOFT_KBD_106_TYPE = 0x00000002,
    MICROSOFT_KBD_002_TYPE = 0x00000003,
    MICROSOFT_KBD_001_TYPE = 0x00000004,
    MICROSOFT_KBD_FUNC     = 0x0000000c,
}

enum : uint
{
    FMR_KBD_JIS_TYPE   = 0x00000000,
    FMR_KBD_OASYS_TYPE = 0x00000001,
}

enum : uint
{
    NEC_KBD_NORMAL_TYPE = 0x00000001,
    NEC_KBD_N_MODE_TYPE = 0x00000002,
    NEC_KBD_H_MODE_TYPE = 0x00000003,
    NEC_KBD_LAPTOP_TYPE = 0x00000004,
    NEC_KBD_106_TYPE    = 0x00000005,
}

enum uint TOSHIBA_KBD_LAPTOP_TYPE = 0x0000000f;
enum uint DEC_KBD_JIS_LAYOUT_TYPE = 0x00000002;

enum : uint
{
    MICROSOFT_KBD_101B_TYPE = 0x00000004,
    MICROSOFT_KBD_101C_TYPE = 0x00000005,
    MICROSOFT_KBD_103_TYPE  = 0x00000006,
}

enum uint NLSKBD_INFO_ACCESSIBILITY_KEYMAP = 0x00000002;
enum uint NLSKBD_INFO_EMURATE_106_KEYBOARD = 0x00000020;

enum : uint
{
    KBDNLS_TYPE_NORMAL = 0x00000001,
    KBDNLS_TYPE_TOGGLE = 0x00000002,
}

enum : uint
{
    KBDNLS_INDEX_ALT     = 0x00000002,
    KBDNLS_NULL          = 0x00000000,
    KBDNLS_NOEVENT       = 0x00000001,
    KBDNLS_SEND_BASE_VK  = 0x00000002,
    KBDNLS_SEND_PARAM_VK = 0x00000003,
}

enum : uint
{
    KBDNLS_ALPHANUM      = 0x00000005,
    KBDNLS_HIRAGANA      = 0x00000006,
    KBDNLS_KATAKANA      = 0x00000007,
    KBDNLS_SBCSDBCS      = 0x00000008,
    KBDNLS_ROMAN         = 0x00000009,
    KBDNLS_CODEINPUT     = 0x0000000a,
    KBDNLS_HELP_OR_END   = 0x0000000b,
    KBDNLS_HOME_OR_CLEAR = 0x0000000c,
}

enum : uint
{
    KBDNLS_KANAEVENT       = 0x0000000e,
    KBDNLS_CONV_OR_NONCONV = 0x0000000f,
}

enum : uint
{
    SCANCODE_LSHIFT             = 0x0000002a,
    SCANCODE_RSHIFT             = 0x00000036,
    SCANCODE_CTRL               = 0x0000001d,
    SCANCODE_ALT                = 0x00000038,
    SCANCODE_NUMPAD_FIRST       = 0x00000047,
    SCANCODE_NUMPAD_LAST        = 0x00000052,
    SCANCODE_LWIN               = 0x0000005b,
    SCANCODE_RWIN               = 0x0000005c,
    SCANCODE_THAI_LAYOUT_TOGGLE = 0x00000029,
}

// Structs


@RAIIFree!UnloadKeyboardLayout
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HKL
{
    void* Value;
}

struct VK_TO_BIT
{
    ubyte Vk;
    ubyte ModBits;
}

struct MODIFIERS
{
    VK_TO_BIT* pVkToBit;
    ushort     wMaxModBits;
    ubyte[1]   ModNumber;
}

struct VSC_VK
{
    ubyte  Vsc;
    ushort Vk;
}

struct VK_VSC
{
    ubyte Vk;
    ubyte Vsc;
}

struct VK_TO_WCHARS1
{
    ubyte VirtualKey;
    ubyte Attributes;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] wch;
}

struct VK_TO_WCHARS2
{
    ubyte    VirtualKey;
    ubyte    Attributes;
    wchar[2] wch;
}

struct VK_TO_WCHARS3
{
    ubyte    VirtualKey;
    ubyte    Attributes;
    wchar[3] wch;
}

struct VK_TO_WCHARS4
{
    ubyte    VirtualKey;
    ubyte    Attributes;
    wchar[4] wch;
}

struct VK_TO_WCHARS5
{
    ubyte    VirtualKey;
    ubyte    Attributes;
    wchar[5] wch;
}

struct VK_TO_WCHARS6
{
    ubyte    VirtualKey;
    ubyte    Attributes;
    wchar[6] wch;
}

struct VK_TO_WCHARS7
{
    ubyte    VirtualKey;
    ubyte    Attributes;
    wchar[7] wch;
}

struct VK_TO_WCHARS8
{
    ubyte    VirtualKey;
    ubyte    Attributes;
    wchar[8] wch;
}

struct VK_TO_WCHARS9
{
    ubyte    VirtualKey;
    ubyte    Attributes;
    wchar[9] wch;
}

struct VK_TO_WCHARS10
{
    ubyte     VirtualKey;
    ubyte     Attributes;
    wchar[10] wch;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct VK_TO_WCHAR_TABLE
{
    VK_TO_WCHARS1* pVkToWchars;
    ubyte          nModifications;
    ubyte          cbSize;
}

struct DEADKEY
{
    uint   dwBoth;
    wchar  wchComposed;
    ushort uFlags;
}

struct LIGATURE1
{
    ubyte  VirtualKey;
    ushort ModificationNumber;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] wch;
}

struct LIGATURE2
{
    ubyte    VirtualKey;
    ushort   ModificationNumber;
    wchar[2] wch;
}

struct LIGATURE3
{
    ubyte    VirtualKey;
    ushort   ModificationNumber;
    wchar[3] wch;
}

struct LIGATURE4
{
    ubyte    VirtualKey;
    ushort   ModificationNumber;
    wchar[4] wch;
}

struct LIGATURE5
{
    ubyte    VirtualKey;
    ushort   ModificationNumber;
    wchar[5] wch;
}

struct VSC_LPWSTR
{
    ubyte vsc;
    PWSTR pwsz;
}

struct KBDTABLES
{
    MODIFIERS*         pCharModifiers;
    VK_TO_WCHAR_TABLE* pVkToWcharTable;
    DEADKEY*           pDeadKey;
    VSC_LPWSTR*        pKeyNames;
    VSC_LPWSTR*        pKeyNamesExt;
    ushort**           pKeyNamesDead;
    ushort*            pusVSCtoVK;
    ubyte              bMaxVSCtoVK;
    VSC_VK*            pVSCtoVK_E0;
    VSC_VK*            pVSCtoVK_E1;
    uint               fLocaleFlags;
    ubyte              nLgMax;
    ubyte              cbLgEntry;
    LIGATURE1*         pLigature;
    uint               dwType;
    uint               dwSubType;
}

struct VK_FPARAM
{
    ubyte NLSFEProcIndex;
    uint  NLSFEProcParam;
}

struct VK_F_t
{
    ubyte        Vk;
    ubyte        NLSFEProcType;
    ubyte        NLSFEProcCurrent;
    ubyte        NLSFEProcSwitch;
    VK_FPARAM[8] NLSFEProc;
    VK_FPARAM[8] NLSFEProcAlt;
}

struct KBDNLSTABLES
{
    ushort  OEMIdentifier;
    ushort  LayoutInformation;
    uint    NumOfVkToF;
    VK_F_t* pVkToF;
    int     NumOfMouseVKey;
    ushort* pusMouseVKey;
}

struct KBDTABLE_DESC
{
    wchar[32] wszDllName;
    uint      dwType;
    uint      dwSubType;
}

struct KBDTABLE_MULTI
{
    uint             nTables;
    KBDTABLE_DESC[8] aKbdTables;
}

struct KBD_TYPE_INFO
{
    uint dwVersion;
    uint dwType;
    uint dwSubType;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-mousemovepoint))], [])
struct MOUSEMOVEPOINT
{
    int    x;
    int    y;
    uint   time;
    size_t dwExtraInfo;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-trackmouseevent))], [])
struct TRACKMOUSEEVENT
{
    uint cbSize;
    TRACKMOUSEEVENT_FLAGS dwFlags;
    HWND hwndTrack;
    uint dwHoverTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-mouseinput))], [])
struct MOUSEINPUT
{
    int               dx;
    int               dy;
    uint              mouseData;
    MOUSE_EVENT_FLAGS dwFlags;
    uint              time;
    size_t            dwExtraInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-keybdinput))], [])
struct KEYBDINPUT
{
    VIRTUAL_KEY       wVk;
    ushort            wScan;
    KEYBD_EVENT_FLAGS dwFlags;
    uint              time;
    size_t            dwExtraInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-hardwareinput))], [])
struct HARDWAREINPUT
{
    uint   uMsg;
    ushort wParamL;
    ushort wParamH;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-input))], [])
struct INPUT
{
    INPUT_TYPE type;
union Anonymous
    {
        MOUSEINPUT    mi;
        KEYBDINPUT    ki;
        HARDWAREINPUT hi;
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-lastinputinfo))], [])
struct LASTINPUTINFO
{
    uint cbSize;
    uint dwTime;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commctrl/nf-commctrl-_trackmouseevent))], [])
@DllImport("COMCTL32.dll")
BOOL _TrackMouseEvent(TRACKMOUSEEVENT* lpEventTrack);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-loadkeyboardlayouta))], [])
@DllImport("USER32.dll")
HKL LoadKeyboardLayoutA(const(PSTR) pwszKLID, ACTIVATE_KEYBOARD_LAYOUT_FLAGS Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-loadkeyboardlayoutw))], [])
@DllImport("USER32.dll")
HKL LoadKeyboardLayoutW(const(PWSTR) pwszKLID, ACTIVATE_KEYBOARD_LAYOUT_FLAGS Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-activatekeyboardlayout))], [])
@DllImport("USER32.dll")
HKL ActivateKeyboardLayout(HKL hkl, ACTIVATE_KEYBOARD_LAYOUT_FLAGS Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-tounicodeex))], [])
@DllImport("USER32.dll")
int ToUnicodeEx(uint wVirtKey, uint wScanCode, const(ubyte)* lpKeyState, PWSTR pwszBuff, int cchBuff, uint wFlags, 
                HKL dwhkl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-unloadkeyboardlayout))], [])
@DllImport("USER32.dll")
BOOL UnloadKeyboardLayout(HKL hkl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkeyboardlayoutnamea))], [])
@DllImport("USER32.dll")
BOOL GetKeyboardLayoutNameA(PSTR pwszKLID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkeyboardlayoutnamew))], [])
@DllImport("USER32.dll")
BOOL GetKeyboardLayoutNameW(PWSTR pwszKLID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkeyboardlayoutlist))], [])
@DllImport("USER32.dll")
int GetKeyboardLayoutList(int nBuff, HKL* lpList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkeyboardlayout))], [])
@DllImport("USER32.dll")
HKL GetKeyboardLayout(uint idThread);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getmousemovepointsex))], [])
@DllImport("USER32.dll")
int GetMouseMovePointsEx(uint cbSize, MOUSEMOVEPOINT* lppt, MOUSEMOVEPOINT* lpptBuf, int nBufPoints, 
                         GET_MOUSE_MOVE_POINTS_EX_RESOLUTION resolution);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-trackmouseevent))], [])
@DllImport("USER32.dll")
BOOL TrackMouseEvent(TRACKMOUSEEVENT* lpEventTrack);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-registerhotkey))], [])
@DllImport("USER32.dll")
BOOL RegisterHotKey(HWND hWnd, int id, HOT_KEY_MODIFIERS fsModifiers, uint vk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-unregisterhotkey))], [])
@DllImport("USER32.dll")
BOOL UnregisterHotKey(HWND hWnd, int id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-swapmousebutton))], [])
@DllImport("USER32.dll")
BOOL SwapMouseButton(BOOL fSwap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getdoubleclicktime))], [])
@DllImport("USER32.dll")
uint GetDoubleClickTime();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setdoubleclicktime))], [])
@DllImport("USER32.dll")
BOOL SetDoubleClickTime(uint param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setfocus))], [])
@DllImport("USER32.dll")
HWND SetFocus(HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getactivewindow))], [])
@DllImport("USER32.dll")
HWND GetActiveWindow();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getfocus))], [])
@DllImport("USER32.dll")
HWND GetFocus();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkbcodepage))], [])
@DllImport("USER32.dll")
uint GetKBCodePage();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkeystate))], [])
@DllImport("USER32.dll")
short GetKeyState(int nVirtKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getasynckeystate))], [])
@DllImport("USER32.dll")
short GetAsyncKeyState(int vKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkeyboardstate))], [])
@DllImport("USER32.dll")
BOOL GetKeyboardState(ubyte* lpKeyState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setkeyboardstate))], [])
@DllImport("USER32.dll")
BOOL SetKeyboardState(ubyte* lpKeyState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkeynametexta))], [])
@DllImport("USER32.dll")
int GetKeyNameTextA(int lParam, PSTR lpString, int cchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkeynametextw))], [])
@DllImport("USER32.dll")
int GetKeyNameTextW(int lParam, PWSTR lpString, int cchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getkeyboardtype))], [])
@DllImport("USER32.dll")
int GetKeyboardType(int nTypeFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-toascii))], [])
@DllImport("USER32.dll")
int ToAscii(uint uVirtKey, uint uScanCode, const(ubyte)* lpKeyState, ushort* lpChar, uint uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-toasciiex))], [])
@DllImport("USER32.dll")
int ToAsciiEx(uint uVirtKey, uint uScanCode, const(ubyte)* lpKeyState, ushort* lpChar, uint uFlags, HKL dwhkl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-tounicode))], [])
@DllImport("USER32.dll")
int ToUnicode(uint wVirtKey, uint wScanCode, const(ubyte)* lpKeyState, PWSTR pwszBuff, int cchBuff, uint wFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-oemkeyscan))], [])
@DllImport("USER32.dll")
uint OemKeyScan(ushort wOemChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-vkkeyscana))], [])
@DllImport("USER32.dll")
short VkKeyScanA(CHAR ch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-vkkeyscanw))], [])
@DllImport("USER32.dll")
short VkKeyScanW(wchar ch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-vkkeyscanexa))], [])
@DllImport("USER32.dll")
short VkKeyScanExA(CHAR ch, HKL dwhkl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-vkkeyscanexw))], [])
@DllImport("USER32.dll")
short VkKeyScanExW(wchar ch, HKL dwhkl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-keybd_event))], [])
@DllImport("USER32.dll")
void keybd_event(ubyte bVk, ubyte bScan, KEYBD_EVENT_FLAGS dwFlags, size_t dwExtraInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-mouse_event))], [])
@DllImport("USER32.dll")
void mouse_event(MOUSE_EVENT_FLAGS dwFlags, int dx, int dy, int dwData, size_t dwExtraInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-sendinput))], [])
@DllImport("USER32.dll")
uint SendInput(uint cInputs, INPUT* pInputs, int cbSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getlastinputinfo))], [])
@DllImport("USER32.dll")
BOOL GetLastInputInfo(LASTINPUTINFO* plii);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-mapvirtualkeya))], [])
@DllImport("USER32.dll")
uint MapVirtualKeyA(uint uCode, MAP_VIRTUAL_KEY_TYPE uMapType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-mapvirtualkeyw))], [])
@DllImport("USER32.dll")
uint MapVirtualKeyW(uint uCode, MAP_VIRTUAL_KEY_TYPE uMapType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-mapvirtualkeyexa))], [])
@DllImport("USER32.dll")
uint MapVirtualKeyExA(uint uCode, MAP_VIRTUAL_KEY_TYPE uMapType, HKL dwhkl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-mapvirtualkeyexw))], [])
@DllImport("USER32.dll")
uint MapVirtualKeyExW(uint uCode, MAP_VIRTUAL_KEY_TYPE uMapType, HKL dwhkl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getcapture))], [])
@DllImport("USER32.dll")
HWND GetCapture();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setcapture))], [])
@DllImport("USER32.dll")
HWND SetCapture(HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-releasecapture))], [])
@DllImport("USER32.dll")
BOOL ReleaseCapture();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enablewindow))], [])
@DllImport("USER32.dll")
BOOL EnableWindow(HWND hWnd, BOOL bEnable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-iswindowenabled))], [])
@DllImport("USER32.dll")
BOOL IsWindowEnabled(HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-dragdetect))], [])
@DllImport("USER32.dll")
BOOL DragDetect(HWND hwnd, POINT pt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setactivewindow))], [])
@DllImport("USER32.dll")
HWND SetActiveWindow(HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-blockinput))], [])
@DllImport("USER32.dll")
BOOL BlockInput(BOOL fBlockIt);


