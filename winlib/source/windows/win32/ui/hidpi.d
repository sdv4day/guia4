// Written in the D programming language.

module windows.win32.ui.hidpi;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, HWND, POINT, PWSTR, RECT;
public import windows.win32.graphics.gdi : HMONITOR;
public import windows.win32.ui.controls : HTHEME;
public import windows.win32.ui.windowsandmessaging : SYSTEM_METRICS_INDEX, WINDOW_EX_STYLE, WINDOW_STYLE;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windef/ne-windef-dpi_awareness))], [])

alias DPI_AWARENESS = int;
enum : int
{
    DPI_AWARENESS_INVALID           = 0xffffffff,
    DPI_AWARENESS_UNAWARE           = 0x00000000,
    DPI_AWARENESS_SYSTEM_AWARE      = 0x00000001,
    DPI_AWARENESS_PER_MONITOR_AWARE = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windef/ne-windef-dpi_hosting_behavior))], [])

alias DPI_HOSTING_BEHAVIOR = int;
enum : int
{
    DPI_HOSTING_BEHAVIOR_INVALID = 0xffffffff,
    DPI_HOSTING_BEHAVIOR_DEFAULT = 0x00000000,
    DPI_HOSTING_BEHAVIOR_MIXED   = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ne-winuser-dialog_control_dpi_change_behaviors))], [])

alias DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS = int;
enum : int
{
    DCDC_DEFAULT             = 0x00000000,
    DCDC_DISABLE_FONT_UPDATE = 0x00000001,
    DCDC_DISABLE_RELAYOUT    = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ne-winuser-dialog_dpi_change_behaviors))], [])

alias DIALOG_DPI_CHANGE_BEHAVIORS = int;
enum : int
{
    DDC_DEFAULT                  = 0x00000000,
    DDC_DISABLE_ALL              = 0x00000001,
    DDC_DISABLE_RESIZE           = 0x00000002,
    DDC_DISABLE_CONTROL_RELAYOUT = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shellscalingapi/ne-shellscalingapi-process_dpi_awareness))], [])

alias PROCESS_DPI_AWARENESS = int;
enum : int
{
    PROCESS_DPI_UNAWARE           = 0x00000000,
    PROCESS_SYSTEM_DPI_AWARE      = 0x00000001,
    PROCESS_PER_MONITOR_DPI_AWARE = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shellscalingapi/ne-shellscalingapi-monitor_dpi_type))], [])

alias MONITOR_DPI_TYPE = int;
enum : int
{
    MDT_EFFECTIVE_DPI = 0x00000000,
    MDT_ANGULAR_DPI   = 0x00000001,
    MDT_RAW_DPI       = 0x00000002,
    MDT_DEFAULT       = 0x00000000,
}

// Constants


enum : DPI_AWARENESS_CONTEXT
{
    DPI_AWARENESS_CONTEXT_UNAWARE              = DPI_AWARENESS_CONTEXT(cast(void*)0xffffffff),
    DPI_AWARENESS_CONTEXT_SYSTEM_AWARE         = DPI_AWARENESS_CONTEXT(cast(void*)0xfffffffe),
    DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE    = DPI_AWARENESS_CONTEXT(cast(void*)0xfffffffd),
    DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2 = DPI_AWARENESS_CONTEXT(cast(void*)0xfffffffc),
    DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED    = DPI_AWARENESS_CONTEXT(cast(void*)0xfffffffb),
}

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct DPI_AWARENESS_CONTEXT
{
    void* Value;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/uxtheme/nf-uxtheme-openthemedatafordpi))], [])
@DllImport("UxTheme.dll")
HTHEME OpenThemeDataForDpi(HWND hwnd, const(PWSTR) pszClassList, uint dpi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setdialogcontroldpichangebehavior))], [])
@DllImport("USER32.dll")
BOOL SetDialogControlDpiChangeBehavior(HWND hWnd, DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS mask, 
                                       DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS values);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getdialogcontroldpichangebehavior))], [])
@DllImport("USER32.dll")
DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS GetDialogControlDpiChangeBehavior(HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setdialogdpichangebehavior))], [])
@DllImport("USER32.dll")
BOOL SetDialogDpiChangeBehavior(HWND hDlg, DIALOG_DPI_CHANGE_BEHAVIORS mask, DIALOG_DPI_CHANGE_BEHAVIORS values);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getdialogdpichangebehavior))], [])
@DllImport("USER32.dll")
DIALOG_DPI_CHANGE_BEHAVIORS GetDialogDpiChangeBehavior(HWND hDlg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getsystemmetricsfordpi))], [])
@DllImport("USER32.dll")
int GetSystemMetricsForDpi(SYSTEM_METRICS_INDEX nIndex, uint dpi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-adjustwindowrectexfordpi))], [])
@DllImport("USER32.dll")
BOOL AdjustWindowRectExForDpi(RECT* lpRect, WINDOW_STYLE dwStyle, BOOL bMenu, WINDOW_EX_STYLE dwExStyle, uint dpi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-logicaltophysicalpointforpermonitordpi))], [])
@DllImport("USER32.dll")
BOOL LogicalToPhysicalPointForPerMonitorDPI(HWND hWnd, POINT* lpPoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-physicaltologicalpointforpermonitordpi))], [])
@DllImport("USER32.dll")
BOOL PhysicalToLogicalPointForPerMonitorDPI(HWND hWnd, POINT* lpPoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-systemparametersinfofordpi))], [])
@DllImport("USER32.dll")
BOOL SystemParametersInfoForDpi(uint uiAction, uint uiParam, void* pvParam, uint fWinIni, uint dpi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setthreaddpiawarenesscontext))], [])
@DllImport("USER32.dll")
DPI_AWARENESS_CONTEXT SetThreadDpiAwarenessContext(DPI_AWARENESS_CONTEXT dpiContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getthreaddpiawarenesscontext))], [])
@DllImport("USER32.dll")
DPI_AWARENESS_CONTEXT GetThreadDpiAwarenessContext();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getwindowdpiawarenesscontext))], [])
@DllImport("USER32.dll")
DPI_AWARENESS_CONTEXT GetWindowDpiAwarenessContext(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getawarenessfromdpiawarenesscontext))], [])
@DllImport("USER32.dll")
DPI_AWARENESS GetAwarenessFromDpiAwarenessContext(DPI_AWARENESS_CONTEXT value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getdpifromdpiawarenesscontext))], [])
@DllImport("USER32.dll")
uint GetDpiFromDpiAwarenessContext(DPI_AWARENESS_CONTEXT value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-aredpiawarenesscontextsequal))], [])
@DllImport("USER32.dll")
BOOL AreDpiAwarenessContextsEqual(DPI_AWARENESS_CONTEXT dpiContextA, DPI_AWARENESS_CONTEXT dpiContextB);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-isvaliddpiawarenesscontext))], [])
@DllImport("USER32.dll")
BOOL IsValidDpiAwarenessContext(DPI_AWARENESS_CONTEXT value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getdpiforwindow))], [])
@DllImport("USER32.dll")
uint GetDpiForWindow(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getdpiforsystem))], [])
@DllImport("USER32.dll")
uint GetDpiForSystem();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getsystemdpiforprocess))], [])
@DllImport("USER32.dll")
uint GetSystemDpiForProcess(HANDLE hProcess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enablenonclientdpiscaling))], [])
@DllImport("USER32.dll")
BOOL EnableNonClientDpiScaling(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setprocessdpiawarenesscontext))], [])
@DllImport("USER32.dll")
BOOL SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT value);

@DllImport("USER32.dll")
DPI_AWARENESS_CONTEXT GetDpiAwarenessContextForProcess(HANDLE hProcess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setthreaddpihostingbehavior))], [])
@DllImport("USER32.dll")
DPI_HOSTING_BEHAVIOR SetThreadDpiHostingBehavior(DPI_HOSTING_BEHAVIOR value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getthreaddpihostingbehavior))], [])
@DllImport("USER32.dll")
DPI_HOSTING_BEHAVIOR GetThreadDpiHostingBehavior();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getwindowdpihostingbehavior))], [])
@DllImport("USER32.dll")
DPI_HOSTING_BEHAVIOR GetWindowDpiHostingBehavior(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shellscalingapi/nf-shellscalingapi-setprocessdpiawareness))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT SetProcessDpiAwareness(PROCESS_DPI_AWARENESS value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shellscalingapi/nf-shellscalingapi-getprocessdpiawareness))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT GetProcessDpiAwareness(HANDLE hprocess, PROCESS_DPI_AWARENESS* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shellscalingapi/nf-shellscalingapi-getdpiformonitor))], [])
@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT GetDpiForMonitor(HMONITOR hmonitor, MONITOR_DPI_TYPE dpiType, uint* dpiX, uint* dpiY);


