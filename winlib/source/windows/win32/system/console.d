// Written in the D programming language.

module windows.win32.system.console;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, COLORREF, HANDLE, HRESULT, HWND, NTSTATUS, PSTR, PWSTR, RECT;
public import windows.win32.graphics.gdi : BITMAPINFO, HPALETTE;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.ui.windowsandmessaging : HCURSOR, HICON, HMENU;

extern(Windows) @nogc nothrow:


// Enums


alias CONSOLE_MODE = uint;
enum : uint
{
    ENABLE_PROCESSED_INPUT             = 0x00000001,
    ENABLE_LINE_INPUT                  = 0x00000002,
    ENABLE_ECHO_INPUT                  = 0x00000004,
    ENABLE_WINDOW_INPUT                = 0x00000008,
    ENABLE_MOUSE_INPUT                 = 0x00000010,
    ENABLE_INSERT_MODE                 = 0x00000020,
    ENABLE_QUICK_EDIT_MODE             = 0x00000040,
    ENABLE_EXTENDED_FLAGS              = 0x00000080,
    ENABLE_AUTO_POSITION               = 0x00000100,
    ENABLE_VIRTUAL_TERMINAL_INPUT      = 0x00000200,
    ENABLE_PROCESSED_OUTPUT            = 0x00000001,
    ENABLE_WRAP_AT_EOL_OUTPUT          = 0x00000002,
    ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x00000004,
    DISABLE_NEWLINE_AUTO_RETURN        = 0x00000008,
    ENABLE_LVB_GRID_WORLDWIDE          = 0x00000010,
}

alias STD_HANDLE = uint;
enum : uint
{
    STD_INPUT_HANDLE  = 0xfffffff6,
    STD_OUTPUT_HANDLE = 0xfffffff5,
    STD_ERROR_HANDLE  = 0xfffffff4,
}

alias CONSOLE_CHARACTER_ATTRIBUTES = ushort;
enum : ushort
{
    FOREGROUND_BLUE            = cast(ushort)0x0001,
    FOREGROUND_GREEN           = cast(ushort)0x0002,
    FOREGROUND_RED             = cast(ushort)0x0004,
    FOREGROUND_INTENSITY       = cast(ushort)0x0008,
    BACKGROUND_BLUE            = cast(ushort)0x0010,
    BACKGROUND_GREEN           = cast(ushort)0x0020,
    BACKGROUND_RED             = cast(ushort)0x0040,
    BACKGROUND_INTENSITY       = cast(ushort)0x0080,
    COMMON_LVB_LEADING_BYTE    = cast(ushort)0x0100,
    COMMON_LVB_TRAILING_BYTE   = cast(ushort)0x0200,
    COMMON_LVB_GRID_HORIZONTAL = cast(ushort)0x0400,
    COMMON_LVB_GRID_LVERTICAL  = cast(ushort)0x0800,
    COMMON_LVB_GRID_RVERTICAL  = cast(ushort)0x1000,
    COMMON_LVB_REVERSE_VIDEO   = cast(ushort)0x4000,
    COMMON_LVB_UNDERSCORE      = cast(ushort)0x8000,
    COMMON_LVB_SBCSDBCS        = cast(ushort)0x0300,
}

alias ALLOC_CONSOLE_MODE = int;
enum : int
{
    ALLOC_CONSOLE_MODE_DEFAULT    = 0x00000000,
    ALLOC_CONSOLE_MODE_NEW_WINDOW = 0x00000001,
    ALLOC_CONSOLE_MODE_NO_WINDOW  = 0x00000002,
}

alias ALLOC_CONSOLE_RESULT = int;
enum : int
{
    ALLOC_CONSOLE_RESULT_NO_CONSOLE       = 0x00000000,
    ALLOC_CONSOLE_RESULT_NEW_CONSOLE      = 0x00000001,
    ALLOC_CONSOLE_RESULT_EXISTING_CONSOLE = 0x00000002,
}

alias CONSOLECONTROL = int;
enum : int
{
    Reserved1                       = 0x00000000,
    ConsoleNotifyConsoleApplication = 0x00000001,
    Reserved2                       = 0x00000002,
    ConsoleSetCaretInfo             = 0x00000003,
    Reserved3                       = 0x00000004,
    ConsoleSetForeground            = 0x00000005,
    ConsoleSetWindowOwner           = 0x00000006,
    ConsoleEndTask                  = 0x00000007,
}

// Constants


enum uint CONSOLE_TEXTMODE_BUFFER = 0x00000001;
enum uint VDM_HIDE_WINDOW = 0x00000001;

enum : uint
{
    VDM_CLIENT_RECT      = 0x00000003,
    VDM_CLIENT_TO_SCREEN = 0x00000004,
}

enum uint VDM_IS_HIDDEN = 0x00000006;
enum uint VDM_SET_VIDEO_MODE = 0x00000008;

enum : uint
{
    CONSOLE_REGISTER_VDM = 0x00000001,
    CONSOLE_REGISTER_WOW = 0x00000002,
}

enum : uint
{
    CONSOLE_ALTTAB           = 0x00000001,
    CONSOLE_ALTESC           = 0x00000002,
    CONSOLE_ALTSPACE         = 0x00000004,
    CONSOLE_ALTENTER         = 0x00000008,
    CONSOLE_ALTPRTSC         = 0x00000010,
    CONSOLE_PRTSC            = 0x00000020,
    CONSOLE_CTRLESC          = 0x00000040,
    CONSOLE_MODIFIER_SHIFT   = 0x00000003,
    CONSOLE_MODIFIER_CONTROL = 0x00000004,
    CONSOLE_MODIFIER_ALT     = 0x00000008,
}

enum : uint
{
    CHAR_TYPE_LEADING  = 0x00000002,
    CHAR_TYPE_TRAILING = 0x00000003,
}

enum uint CONSOLE_HANDLE_NEVERSET = 0x10000000;
enum const(wchar)* CONSOLE_OUTPUT_STRING = "CONOUT$";

enum : uint
{
    PID_CONSOLE_FORCEV2              = 0x00000001,
    PID_CONSOLE_WRAPTEXT             = 0x00000002,
    PID_CONSOLE_FILTERONPASTE        = 0x00000003,
    PID_CONSOLE_CTRLKEYSDISABLED     = 0x00000004,
    PID_CONSOLE_LINESELECTION        = 0x00000005,
    PID_CONSOLE_WINDOWTRANSPARENCY   = 0x00000006,
    PID_CONSOLE_WINDOWMAXIMIZED      = 0x00000007,
    PID_CONSOLE_CURSOR_TYPE          = 0x00000008,
    PID_CONSOLE_CURSOR_COLOR         = 0x00000009,
    PID_CONSOLE_INTERCEPT_COPY_PASTE = 0x0000000a,
}

enum : uint
{
    PID_CONSOLE_DEFAULTBACKGROUND = 0x0000000c,
    PID_CONSOLE_TERMINALSCROLLING = 0x0000000d,
}

enum : uint
{
    CTRL_C_EVENT     = 0x00000000,
    CTRL_BREAK_EVENT = 0x00000001,
}

enum uint CTRL_LOGOFF_EVENT = 0x00000005;
enum uint PSEUDOCONSOLE_INHERIT_CURSOR = 0x00000001;

enum : uint
{
    CONSOLE_SELECTION_IN_PROGRESS = 0x00000001,
    CONSOLE_SELECTION_NOT_EMPTY   = 0x00000002,
}

enum uint CONSOLE_MOUSE_DOWN = 0x00000008;

enum : uint
{
    CONSOLE_FULLSCREEN          = 0x00000001,
    CONSOLE_FULLSCREEN_HARDWARE = 0x00000002,
    CONSOLE_FULLSCREEN_MODE     = 0x00000001,
}

enum uint RIGHT_ALT_PRESSED = 0x00000001;
enum uint RIGHT_CTRL_PRESSED = 0x00000004;
enum uint SHIFT_PRESSED = 0x00000010;
enum uint SCROLLLOCK_ON = 0x00000040;
enum uint ENHANCED_KEY = 0x00000100;
enum uint NLS_ALPHANUMERIC = 0x00000000;
enum uint NLS_HIRAGANA = 0x00040000;
enum uint NLS_IME_CONVERSION = 0x00800000;
enum uint NLS_IME_DISABLE = 0x20000000;
enum uint RIGHTMOST_BUTTON_PRESSED = 0x00000002;
enum uint FROM_LEFT_3RD_BUTTON_PRESSED = 0x00000008;
enum uint MOUSE_MOVED = 0x00000001;

enum : uint
{
    MOUSE_WHEELED  = 0x00000004,
    MOUSE_HWHEELED = 0x00000008,
}

enum uint MOUSE_EVENT = 0x00000002;
enum uint MENU_EVENT = 0x00000008;

// Callbacks

alias PHANDLER_ROUTINE = BOOL function(uint CtrlType);

// Structs


@RAIIFree!ClosePseudoConsole
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HPCON
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/coord-str))], [])
struct COORD
{
    short X;
    short Y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/small-rect-str))], [])
struct SMALL_RECT
{
    short Left;
    short Top;
    short Right;
    short Bottom;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/key-event-record-str))], [])
struct KEY_EVENT_RECORD
{
    BOOL   bKeyDown;
    ushort wRepeatCount;
    ushort wVirtualKeyCode;
    ushort wVirtualScanCode;
union uChar
    {
        wchar UnicodeChar;
        CHAR  AsciiChar;
    }
    uint   dwControlKeyState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/mouse-event-record-str))], [])
struct MOUSE_EVENT_RECORD
{
    COORD dwMousePosition;
    uint  dwButtonState;
    uint  dwControlKeyState;
    uint  dwEventFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/window-buffer-size-record-str))], [])
struct WINDOW_BUFFER_SIZE_RECORD
{
    COORD dwSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/menu-event-record-str))], [])
struct MENU_EVENT_RECORD
{
    uint dwCommandId;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/focus-event-record-str))], [])
struct FOCUS_EVENT_RECORD
{
    BOOL bSetFocus;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/input-record-str))], [])
struct INPUT_RECORD
{
    ushort EventType;
union Event
    {
        KEY_EVENT_RECORD   KeyEvent;
        MOUSE_EVENT_RECORD MouseEvent;
        WINDOW_BUFFER_SIZE_RECORD WindowBufferSizeEvent;
        MENU_EVENT_RECORD  MenuEvent;
        FOCUS_EVENT_RECORD FocusEvent;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/char-info-str))], [])
struct CHAR_INFO
{
union Char
    {
        wchar UnicodeChar;
        CHAR  AsciiChar;
    }
    ushort Attributes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/console-font-info-str))], [])
struct CONSOLE_FONT_INFO
{
    uint  nFont;
    COORD dwFontSize;
}

struct ALLOC_CONSOLE_OPTIONS
{
    ALLOC_CONSOLE_MODE mode;
    BOOL               useShowWindow;
    ushort             showWindow;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/console-readconsole-control))], [])
struct CONSOLE_READCONSOLE_CONTROL
{
    uint nLength;
    uint nInitialChars;
    uint dwCtrlWakeupMask;
    uint dwControlKeyState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/console-cursor-info-str))], [])
struct CONSOLE_CURSOR_INFO
{
    uint dwSize;
    BOOL bVisible;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/console-screen-buffer-info-str))], [])
struct CONSOLE_SCREEN_BUFFER_INFO
{
    COORD      dwSize;
    COORD      dwCursorPosition;
    CONSOLE_CHARACTER_ATTRIBUTES wAttributes;
    SMALL_RECT srWindow;
    COORD      dwMaximumWindowSize;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/console-screen-buffer-infoex))], [])
struct CONSOLE_SCREEN_BUFFER_INFOEX
{
    uint         cbSize;
    COORD        dwSize;
    COORD        dwCursorPosition;
    CONSOLE_CHARACTER_ATTRIBUTES wAttributes;
    SMALL_RECT   srWindow;
    COORD        dwMaximumWindowSize;
    ushort       wPopupAttributes;
    BOOL         bFullscreenSupported;
    COLORREF[16] ColorTable;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/console-font-infoex))], [])
struct CONSOLE_FONT_INFOEX
{
    uint      cbSize;
    uint      nFont;
    COORD     dwFontSize;
    uint      FontFamily;
    uint      FontWeight;
    wchar[32] FaceName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/console-selection-info-str))], [])
struct CONSOLE_SELECTION_INFO
{
    uint       dwFlags;
    COORD      dwSelectionAnchor;
    SMALL_RECT srSelection;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/console-history-info))], [])
struct CONSOLE_HISTORY_INFO
{
    uint cbSize;
    uint HistoryBufferSize;
    uint NumberOfHistoryBuffers;
    uint dwFlags;
}

struct CONSOLE_GRAPHICS_BUFFER_INFO
{
    uint        dwBitMapInfoLength;
    BITMAPINFO* lpBitMapInfo;
    uint        dwUsage;
    HANDLE      hMutex;
    void*       lpBitMap;
}

struct APPKEY
{
    ushort Modifier;
    ushort ScanCode;
}

struct ExtKeySubst
{
    ushort wMod;
    ushort wVirKey;
    wchar  wUnicodeChar;
}

struct ExtKeyDef
{
    ExtKeySubst[3] keys;
}

struct ExtKeyDefBuf
{
align (2):
    uint          dwVersion;
    uint          dwCheckSum;
    ExtKeyDef[26] table;
}

struct CONSOLEENDTASK
{
    HANDLE ProcessId;
    HWND   hwnd;
    uint   ConsoleEventCode;
    uint   ConsoleFlags;
}

struct CONSOLEWINDOWOWNER
{
    HWND hwnd;
    uint ProcessId;
    uint ThreadId;
}

struct CONSOLESETFOREGROUND
{
    HANDLE hProcess;
    BOOL   bForeground;
}

struct CONSOLE_PROCESS_INFO
{
    uint dwProcessID;
    uint dwFlags;
}

struct CONSOLE_CARET_INFO
{
    HWND hwnd;
    RECT rc;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/allocconsole))], [])
@DllImport("KERNEL32.dll")
BOOL AllocConsole();

@DllImport("KERNEL32.dll")
HRESULT AllocConsoleWithOptions(ALLOC_CONSOLE_OPTIONS* options, ALLOC_CONSOLE_RESULT* result);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/freeconsole))], [])
@DllImport("KERNEL32.dll")
BOOL FreeConsole();

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/attachconsole))], [])
@DllImport("KERNEL32.dll")
BOOL AttachConsole(uint dwProcessId);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolecp))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleCP();

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsoleoutputcp))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleOutputCP();

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolemode))], [])
@DllImport("KERNEL32.dll")
BOOL GetConsoleMode(HANDLE hConsoleHandle, CONSOLE_MODE* lpMode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsolemode))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleMode(HANDLE hConsoleHandle, CONSOLE_MODE dwMode);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getnumberofconsoleinputevents))], [])
@DllImport("KERNEL32.dll")
BOOL GetNumberOfConsoleInputEvents(HANDLE hConsoleInput, uint* lpNumberOfEvents);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsoleinput))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleInputA(HANDLE hConsoleInput, INPUT_RECORD* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsoleinput))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleInputW(HANDLE hConsoleInput, INPUT_RECORD* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/peekconsoleinput))], [])
@DllImport("KERNEL32.dll")
BOOL PeekConsoleInputA(HANDLE hConsoleInput, INPUT_RECORD* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/peekconsoleinput))], [])
@DllImport("KERNEL32.dll")
BOOL PeekConsoleInputW(HANDLE hConsoleInput, INPUT_RECORD* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsole))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleA(HANDLE hConsoleInput, void* lpBuffer, uint nNumberOfCharsToRead, uint* lpNumberOfCharsRead, 
                  CONSOLE_READCONSOLE_CONTROL* pInputControl);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsole))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleW(HANDLE hConsoleInput, void* lpBuffer, uint nNumberOfCharsToRead, uint* lpNumberOfCharsRead, 
                  CONSOLE_READCONSOLE_CONTROL* pInputControl);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/writeconsole))], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleA(HANDLE hConsoleOutput, const(PSTR) lpBuffer, uint nNumberOfCharsToWrite, 
                   uint* lpNumberOfCharsWritten, 
                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/writeconsole))], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleW(HANDLE hConsoleOutput, const(PWSTR) lpBuffer, uint nNumberOfCharsToWrite, 
                   uint* lpNumberOfCharsWritten, 
                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpReserved);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsolectrlhandler))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleCtrlHandler(PHANDLER_ROUTINE HandlerRoutine, BOOL Add);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/createpseudoconsole))], [])
@DllImport("KERNEL32.dll")
HRESULT CreatePseudoConsole(COORD size, HANDLE hInput, HANDLE hOutput, uint dwFlags, HPCON* phPC);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/resizepseudoconsole))], [])
@DllImport("KERNEL32.dll")
HRESULT ResizePseudoConsole(HPCON hPC, COORD size);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/closepseudoconsole))], [])
@DllImport("KERNEL32.dll")
void ClosePseudoConsole(HPCON hPC);

@DllImport("KERNEL32.dll")
HRESULT ReleasePseudoConsole(HPCON hPC);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/fillconsoleoutputcharacter))], [])
@DllImport("KERNEL32.dll")
BOOL FillConsoleOutputCharacterA(HANDLE hConsoleOutput, CHAR cCharacter, uint nLength, COORD dwWriteCoord, 
                                 uint* lpNumberOfCharsWritten);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/fillconsoleoutputcharacter))], [])
@DllImport("KERNEL32.dll")
BOOL FillConsoleOutputCharacterW(HANDLE hConsoleOutput, wchar cCharacter, uint nLength, COORD dwWriteCoord, 
                                 uint* lpNumberOfCharsWritten);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/fillconsoleoutputattribute))], [])
@DllImport("KERNEL32.dll")
BOOL FillConsoleOutputAttribute(HANDLE hConsoleOutput, ushort wAttribute, uint nLength, COORD dwWriteCoord, 
                                uint* lpNumberOfAttrsWritten);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/generateconsolectrlevent))], [])
@DllImport("KERNEL32.dll")
BOOL GenerateConsoleCtrlEvent(uint dwCtrlEvent, uint dwProcessGroupId);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/createconsolescreenbuffer))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateConsoleScreenBuffer(uint dwDesiredAccess, uint dwShareMode, 
                                 const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, uint dwFlags, 
                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpScreenBufferData);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsoleactivescreenbuffer))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleActiveScreenBuffer(HANDLE hConsoleOutput);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/flushconsoleinputbuffer))], [])
@DllImport("KERNEL32.dll")
BOOL FlushConsoleInputBuffer(HANDLE hConsoleInput);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsolecp))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleCP(uint wCodePageID);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsoleoutputcp))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleOutputCP(uint wCodePageID);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolecursorinfo))], [])
@DllImport("KERNEL32.dll")
BOOL GetConsoleCursorInfo(HANDLE hConsoleOutput, CONSOLE_CURSOR_INFO* lpConsoleCursorInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsolecursorinfo))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleCursorInfo(HANDLE hConsoleOutput, const(CONSOLE_CURSOR_INFO)* lpConsoleCursorInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolescreenbufferinfo))], [])
@DllImport("KERNEL32.dll")
BOOL GetConsoleScreenBufferInfo(HANDLE hConsoleOutput, CONSOLE_SCREEN_BUFFER_INFO* lpConsoleScreenBufferInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolescreenbufferinfoex))], [])
@DllImport("KERNEL32.dll")
BOOL GetConsoleScreenBufferInfoEx(HANDLE hConsoleOutput, CONSOLE_SCREEN_BUFFER_INFOEX* lpConsoleScreenBufferInfoEx);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsolescreenbufferinfoex))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleScreenBufferInfoEx(HANDLE hConsoleOutput, CONSOLE_SCREEN_BUFFER_INFOEX* lpConsoleScreenBufferInfoEx);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsolescreenbuffersize))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleScreenBufferSize(HANDLE hConsoleOutput, COORD dwSize);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsolecursorposition))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleCursorPosition(HANDLE hConsoleOutput, COORD dwCursorPosition);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getlargestconsolewindowsize))], [])
@DllImport("KERNEL32.dll")
COORD GetLargestConsoleWindowSize(HANDLE hConsoleOutput);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsoletextattribute))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleTextAttribute(HANDLE hConsoleOutput, CONSOLE_CHARACTER_ATTRIBUTES wAttributes);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsolewindowinfo))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleWindowInfo(HANDLE hConsoleOutput, BOOL bAbsolute, const(SMALL_RECT)* lpConsoleWindow);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/writeconsoleoutputcharacter))], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputCharacterA(HANDLE hConsoleOutput, const(PSTR) lpCharacter, uint nLength, COORD dwWriteCoord, 
                                  uint* lpNumberOfCharsWritten);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/writeconsoleoutputcharacter))], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputCharacterW(HANDLE hConsoleOutput, const(PWSTR) lpCharacter, uint nLength, 
                                  COORD dwWriteCoord, uint* lpNumberOfCharsWritten);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/writeconsoleoutputattribute))], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputAttribute(HANDLE hConsoleOutput, const(ushort)* lpAttribute, uint nLength, 
                                 COORD dwWriteCoord, uint* lpNumberOfAttrsWritten);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsoleoutputcharacter))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputCharacterA(HANDLE hConsoleOutput, PSTR lpCharacter, uint nLength, COORD dwReadCoord, 
                                 uint* lpNumberOfCharsRead);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsoleoutputcharacter))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputCharacterW(HANDLE hConsoleOutput, PWSTR lpCharacter, uint nLength, COORD dwReadCoord, 
                                 uint* lpNumberOfCharsRead);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsoleoutputattribute))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputAttribute(HANDLE hConsoleOutput, ushort* lpAttribute, uint nLength, COORD dwReadCoord, 
                                uint* lpNumberOfAttrsRead);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/writeconsoleinput))], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleInputA(HANDLE hConsoleInput, const(INPUT_RECORD)* lpBuffer, uint nLength, 
                        uint* lpNumberOfEventsWritten);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/writeconsoleinput))], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleInputW(HANDLE hConsoleInput, const(INPUT_RECORD)* lpBuffer, uint nLength, 
                        uint* lpNumberOfEventsWritten);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/scrollconsolescreenbuffer))], [])
@DllImport("KERNEL32.dll")
BOOL ScrollConsoleScreenBufferA(HANDLE hConsoleOutput, const(SMALL_RECT)* lpScrollRectangle, 
                                const(SMALL_RECT)* lpClipRectangle, COORD dwDestinationOrigin, 
                                const(CHAR_INFO)* lpFill);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/scrollconsolescreenbuffer))], [])
@DllImport("KERNEL32.dll")
BOOL ScrollConsoleScreenBufferW(HANDLE hConsoleOutput, const(SMALL_RECT)* lpScrollRectangle, 
                                const(SMALL_RECT)* lpClipRectangle, COORD dwDestinationOrigin, 
                                const(CHAR_INFO)* lpFill);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/writeconsoleoutput))], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputA(HANDLE hConsoleOutput, const(CHAR_INFO)* lpBuffer, COORD dwBufferSize, 
                         COORD dwBufferCoord, SMALL_RECT* lpWriteRegion);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/writeconsoleoutput))], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleOutputW(HANDLE hConsoleOutput, const(CHAR_INFO)* lpBuffer, COORD dwBufferSize, 
                         COORD dwBufferCoord, SMALL_RECT* lpWriteRegion);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsoleoutput))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputA(HANDLE hConsoleOutput, CHAR_INFO* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, 
                        SMALL_RECT* lpReadRegion);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsoleoutput))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleOutputW(HANDLE hConsoleOutput, CHAR_INFO* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, 
                        SMALL_RECT* lpReadRegion);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsoletitle))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleTitleA(PSTR lpConsoleTitle, uint nSize);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsoletitle))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleTitleW(PWSTR lpConsoleTitle, uint nSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsoleoriginaltitle))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleOriginalTitleA(PSTR lpConsoleTitle, uint nSize);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsoleoriginaltitle))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleOriginalTitleW(PWSTR lpConsoleTitle, uint nSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsoletitle))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleTitleA(const(PSTR) lpConsoleTitle);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsoletitle))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleTitleW(const(PWSTR) lpConsoleTitle);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getnumberofconsolemousebuttons))], [])
@DllImport("KERNEL32.dll")
BOOL GetNumberOfConsoleMouseButtons(uint* lpNumberOfMouseButtons);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolefontsize))], [])
@DllImport("KERNEL32.dll")
COORD GetConsoleFontSize(HANDLE hConsoleOutput, uint nFont);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getcurrentconsolefont))], [])
@DllImport("KERNEL32.dll")
BOOL GetCurrentConsoleFont(HANDLE hConsoleOutput, BOOL bMaximumWindow, CONSOLE_FONT_INFO* lpConsoleCurrentFont);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getcurrentconsolefontex))], [])
@DllImport("KERNEL32.dll")
BOOL GetCurrentConsoleFontEx(HANDLE hConsoleOutput, BOOL bMaximumWindow, 
                             CONSOLE_FONT_INFOEX* lpConsoleCurrentFontEx);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setcurrentconsolefontex))], [])
@DllImport("KERNEL32.dll")
BOOL SetCurrentConsoleFontEx(HANDLE hConsoleOutput, BOOL bMaximumWindow, 
                             CONSOLE_FONT_INFOEX* lpConsoleCurrentFontEx);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsoleselectioninfo))], [])
@DllImport("KERNEL32.dll")
BOOL GetConsoleSelectionInfo(CONSOLE_SELECTION_INFO* lpConsoleSelectionInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolehistoryinfo))], [])
@DllImport("KERNEL32.dll")
BOOL GetConsoleHistoryInfo(CONSOLE_HISTORY_INFO* lpConsoleHistoryInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsolehistoryinfo))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleHistoryInfo(CONSOLE_HISTORY_INFO* lpConsoleHistoryInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsoledisplaymode))], [])
@DllImport("KERNEL32.dll")
BOOL GetConsoleDisplayMode(uint* lpModeFlags);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setconsoledisplaymode))], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleDisplayMode(HANDLE hConsoleOutput, uint dwFlags, COORD* lpNewScreenBufferDimensions);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolewindow))], [])
@DllImport("KERNEL32.dll")
HWND GetConsoleWindow();

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/addconsolealias))], [])
@DllImport("KERNEL32.dll")
BOOL AddConsoleAliasA(PSTR Source, PSTR Target, PSTR ExeName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/addconsolealias))], [])
@DllImport("KERNEL32.dll")
BOOL AddConsoleAliasW(PWSTR Source, PWSTR Target, PWSTR ExeName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealias))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasA(PSTR Source, PSTR TargetBuffer, uint TargetBufferLength, PSTR ExeName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealias))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasW(PWSTR Source, PWSTR TargetBuffer, uint TargetBufferLength, PWSTR ExeName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealiaseslength))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasesLengthA(PSTR ExeName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealiaseslength))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasesLengthW(PWSTR ExeName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealiasexeslength))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasExesLengthA();

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealiasexeslength))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasExesLengthW();

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealiases))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasesA(PSTR AliasBuffer, uint AliasBufferLength, PSTR ExeName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealiases))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasesW(PWSTR AliasBuffer, uint AliasBufferLength, PWSTR ExeName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealiasexes))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasExesA(PSTR ExeNameBuffer, uint ExeNameBufferLength);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsolealiasexes))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleAliasExesW(PWSTR ExeNameBuffer, uint ExeNameBufferLength);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
void ExpungeConsoleCommandHistoryA(PSTR ExeName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
void ExpungeConsoleCommandHistoryW(PWSTR ExeName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleNumberOfCommandsA(uint Number, PSTR ExeName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleNumberOfCommandsW(uint Number, PWSTR ExeName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
uint GetConsoleCommandHistoryLengthA(PSTR ExeName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
uint GetConsoleCommandHistoryLengthW(PWSTR ExeName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
uint GetConsoleCommandHistoryA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR Commands, 
                               uint CommandBufferLength, PSTR ExeName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
uint GetConsoleCommandHistoryW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PWSTR Commands, 
                               uint CommandBufferLength, PWSTR ExeName);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getconsoleprocesslist))], [])
@DllImport("KERNEL32.dll")
uint GetConsoleProcessList(uint* lpdwProcessList, uint dwProcessCount);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("user32.dll")
BOOL GetConsoleKeyboardLayoutNameA(PSTR pszLayout);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("user32.dll")
BOOL GetConsoleKeyboardLayoutNameW(PWSTR pszLayout);

@DllImport("KERNEL32.dll")
BOOL InvalidateConsoleDIBits(HANDLE hConsoleOutput, SMALL_RECT* lpRect);

@DllImport("KERNEL32.dll")
void SetLastConsoleEventActive();

@DllImport("KERNEL32.dll")
BOOL VDMConsoleOperation(uint iFunction, void* lpData);

@DllImport("KERNEL32.dll")
BOOL SetConsoleIcon(HICON hIcon);

@DllImport("KERNEL32.dll")
BOOL SetConsoleFont(HANDLE hConsoleOutput, uint nFont);

@DllImport("KERNEL32.dll")
uint GetConsoleFontInfo(HANDLE hConsoleOutput, BOOL bMaximumWindow, uint nLength, 
                        CONSOLE_FONT_INFO* lpConsoleFontInfo);

@DllImport("KERNEL32.dll")
uint GetNumberOfConsoleFonts();

@DllImport("KERNEL32.dll")
BOOL SetConsoleCursor(HANDLE hConsoleOutput, HCURSOR hCursor);

@DllImport("KERNEL32.dll")
int ShowConsoleCursor(HANDLE hConsoleOutput, BOOL bShow);

@DllImport("KERNEL32.dll")
HMENU ConsoleMenuControl(HANDLE hConsoleOutput, uint dwCommandIdLow, uint dwCommandIdHigh);

@DllImport("KERNEL32.dll")
BOOL SetConsolePalette(HANDLE hConsoleOutput, HPALETTE hPalette, uint dwUsage);

@DllImport("KERNEL32.dll")
BOOL RegisterConsoleVDM(uint dwRegisterFlags, HANDLE hStartHardwareEvent, HANDLE hEndHardwareEvent, 
                        HANDLE hErrorhardwareEvent, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                        uint* lpStateLength, void** lpState, COORD VDMBufferSize, void** lpVDMBuffer);

@DllImport("KERNEL32.dll")
BOOL GetConsoleHardwareState(HANDLE hConsoleOutput, COORD* lpResolution, COORD* lpFontSize);

@DllImport("KERNEL32.dll")
BOOL SetConsoleHardwareState(HANDLE hConsoleOutput, COORD dwResolution, COORD dwFontSize);

@DllImport("KERNEL32.dll")
BOOL SetConsoleKeyShortcuts(BOOL bSet, ubyte bReserveKeys, APPKEY* lpAppKeys, uint dwNumAppKeys);

@DllImport("KERNEL32.dll")
BOOL SetConsoleMenuClose(BOOL bEnable);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
uint GetConsoleInputExeNameA(uint nBufferLength, PSTR lpBuffer);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
uint GetConsoleInputExeNameW(uint nBufferLength, PWSTR lpBuffer);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleInputExeNameA(PSTR lpExeName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL SetConsoleInputExeNameW(PWSTR lpExeName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsoleinputex))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleInputExA(HANDLE hConsoleInput, INPUT_RECORD* lpBuffer, uint nLength, uint* lpNumberOfEventsRead, 
                         ushort wFlags);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/readconsoleinputex))], [])
@DllImport("KERNEL32.dll")
BOOL ReadConsoleInputExW(HANDLE hConsoleInput, INPUT_RECORD* lpBuffer, uint nLength, uint* lpNumberOfEventsRead, 
                         ushort wFlags);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleInputVDMA(HANDLE hConsoleInput, INPUT_RECORD* lpBuffer, uint nLength, 
                           uint* lpNumberOfEventsWritten);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("KERNEL32.dll")
BOOL WriteConsoleInputVDMW(HANDLE hConsoleInput, INPUT_RECORD* lpBuffer, uint nLength, 
                           uint* lpNumberOfEventsWritten);

@DllImport("KERNEL32.dll")
BOOL GetConsoleNlsMode(HANDLE hConsole, uint* lpdwNlsMode);

@DllImport("KERNEL32.dll")
BOOL SetConsoleNlsMode(HANDLE hConsole, uint fdwNlsMode);

@DllImport("KERNEL32.dll")
BOOL GetConsoleCharType(HANDLE hConsole, COORD coordCheck, uint* pdwType);

@DllImport("KERNEL32.dll")
BOOL SetConsoleLocalEUDC(HANDLE hConsoleHandle, ushort wCodePoint, COORD cFontSize, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR lpSB);

@DllImport("KERNEL32.dll")
BOOL SetConsoleCursorMode(HANDLE hConsoleHandle, BOOL Blink, BOOL DBEnable);

@DllImport("KERNEL32.dll")
BOOL GetConsoleCursorMode(HANDLE hConsoleHandle, BOOL* pbBlink, BOOL* pbDBEnable);

@DllImport("KERNEL32.dll")
BOOL RegisterConsoleOS2(BOOL fOs2Register);

@DllImport("KERNEL32.dll")
BOOL SetConsoleOS2OemFormat(BOOL fOs2OemFormat);

@DllImport("KERNEL32.dll")
BOOL RegisterConsoleIME(HWND hWndConsoleIME, uint* lpdwConsoleThreadId);

@DllImport("KERNEL32.dll")
BOOL UnregisterConsoleIME();

@DllImport("KERNEL32.dll")
HANDLE OpenConsoleW(PWSTR lpConsoleDevice, uint dwDesiredAccess, BOOL bInheritHandle, uint dwShareMode);

@DllImport("KERNEL32.dll")
HANDLE DuplicateConsoleHandle(HANDLE hSourceHandle, uint dwDesiredAccess, BOOL bInheritHandle, uint dwOptions);

@DllImport("KERNEL32.dll")
BOOL CloseConsoleHandle(HANDLE hConsole);

@DllImport("KERNEL32.dll")
BOOL VerifyConsoleIoHandle(HANDLE hIoHandle);

@DllImport("KERNEL32.dll")
HANDLE GetConsoleInputWaitHandle();

@DllImport("USER32.dll")
NTSTATUS ConsoleControl(CONSOLECONTROL Command, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* ConsoleInformation, 
                        uint ConsoleInformationLength);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/getstdhandle))], [])
@DllImport("KERNEL32.dll")
HANDLE GetStdHandle(STD_HANDLE nStdHandle);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/console/setstdhandle))], [])
@DllImport("KERNEL32.dll")
BOOL SetStdHandle(STD_HANDLE nStdHandle, HANDLE hHandle);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/processenv/nf-processenv-setstdhandleex))], [])
@DllImport("KERNEL32.dll")
BOOL SetStdHandleEx(STD_HANDLE nStdHandle, HANDLE hHandle, HANDLE* phPrevValue);


