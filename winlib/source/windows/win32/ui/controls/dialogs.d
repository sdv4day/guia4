// Written in the D programming language.

module windows.win32.ui.controls.dialogs;

public import windows.core;
public import windows.win32.foundation : BOOL, COLORREF, HGLOBAL, HINSTANCE, HRESULT, HWND, LPARAM, LRESULT, POINT,
                                         PSTR, PWSTR, RECT, WPARAM;
public import windows.win32.graphics.gdi : DEVMODEA, HDC, LOGFONTA, LOGFONTW;
public import windows.win32.system.com : IUnknown;
public import windows.win32.ui.controls : HPROPSHEETPAGE, NMHDR;

extern(Windows) @nogc nothrow:


// Enums


alias COMMON_DLG_ERRORS = uint;
enum : uint
{
    CDERR_DIALOGFAILURE    = 0x0000ffff,
    CDERR_GENERALCODES     = 0x00000000,
    CDERR_STRUCTSIZE       = 0x00000001,
    CDERR_INITIALIZATION   = 0x00000002,
    CDERR_NOTEMPLATE       = 0x00000003,
    CDERR_NOHINSTANCE      = 0x00000004,
    CDERR_LOADSTRFAILURE   = 0x00000005,
    CDERR_FINDRESFAILURE   = 0x00000006,
    CDERR_LOADRESFAILURE   = 0x00000007,
    CDERR_LOCKRESFAILURE   = 0x00000008,
    CDERR_MEMALLOCFAILURE  = 0x00000009,
    CDERR_MEMLOCKFAILURE   = 0x0000000a,
    CDERR_NOHOOK           = 0x0000000b,
    CDERR_REGISTERMSGFAIL  = 0x0000000c,
    PDERR_PRINTERCODES     = 0x00001000,
    PDERR_SETUPFAILURE     = 0x00001001,
    PDERR_PARSEFAILURE     = 0x00001002,
    PDERR_RETDEFFAILURE    = 0x00001003,
    PDERR_LOADDRVFAILURE   = 0x00001004,
    PDERR_GETDEVMODEFAIL   = 0x00001005,
    PDERR_INITFAILURE      = 0x00001006,
    PDERR_NODEVICES        = 0x00001007,
    PDERR_NODEFAULTPRN     = 0x00001008,
    PDERR_DNDMMISMATCH     = 0x00001009,
    PDERR_CREATEICFAILURE  = 0x0000100a,
    PDERR_PRINTERNOTFOUND  = 0x0000100b,
    PDERR_DEFAULTDIFFERENT = 0x0000100c,
    CFERR_CHOOSEFONTCODES  = 0x00002000,
    CFERR_NOFONTS          = 0x00002001,
    CFERR_MAXLESSTHANMIN   = 0x00002002,
    FNERR_FILENAMECODES    = 0x00003000,
    FNERR_SUBCLASSFAILURE  = 0x00003001,
    FNERR_INVALIDFILENAME  = 0x00003002,
    FNERR_BUFFERTOOSMALL   = 0x00003003,
    FRERR_FINDREPLACECODES = 0x00004000,
    FRERR_BUFFERLENGTHZERO = 0x00004001,
    CCERR_CHOOSECOLORCODES = 0x00005000,
}

alias CHOOSECOLOR_FLAGS = uint;
enum : uint
{
    CC_RGBINIT              = 0x00000001,
    CC_FULLOPEN             = 0x00000002,
    CC_PREVENTFULLOPEN      = 0x00000004,
    CC_SHOWHELP             = 0x00000008,
    CC_ENABLEHOOK           = 0x00000010,
    CC_ENABLETEMPLATE       = 0x00000020,
    CC_ENABLETEMPLATEHANDLE = 0x00000040,
    CC_SOLIDCOLOR           = 0x00000080,
    CC_ANYCOLOR             = 0x00000100,
}

alias OPEN_FILENAME_FLAGS = uint;
enum : uint
{
    OFN_READONLY             = 0x00000001,
    OFN_OVERWRITEPROMPT      = 0x00000002,
    OFN_HIDEREADONLY         = 0x00000004,
    OFN_NOCHANGEDIR          = 0x00000008,
    OFN_SHOWHELP             = 0x00000010,
    OFN_ENABLEHOOK           = 0x00000020,
    OFN_ENABLETEMPLATE       = 0x00000040,
    OFN_ENABLETEMPLATEHANDLE = 0x00000080,
    OFN_NOVALIDATE           = 0x00000100,
    OFN_ALLOWMULTISELECT     = 0x00000200,
    OFN_EXTENSIONDIFFERENT   = 0x00000400,
    OFN_PATHMUSTEXIST        = 0x00000800,
    OFN_FILEMUSTEXIST        = 0x00001000,
    OFN_CREATEPROMPT         = 0x00002000,
    OFN_SHAREAWARE           = 0x00004000,
    OFN_NOREADONLYRETURN     = 0x00008000,
    OFN_NOTESTFILECREATE     = 0x00010000,
    OFN_NONETWORKBUTTON      = 0x00020000,
    OFN_NOLONGNAMES          = 0x00040000,
    OFN_EXPLORER             = 0x00080000,
    OFN_NODEREFERENCELINKS   = 0x00100000,
    OFN_LONGNAMES            = 0x00200000,
    OFN_ENABLEINCLUDENOTIFY  = 0x00400000,
    OFN_ENABLESIZING         = 0x00800000,
    OFN_DONTADDTORECENT      = 0x02000000,
    OFN_FORCESHOWHIDDEN      = 0x10000000,
}

alias OPEN_FILENAME_FLAGS_EX = uint;
enum : uint
{
    OFN_EX_NONE        = 0x00000000,
    OFN_EX_NOPLACESBAR = 0x00000001,
}

alias PAGESETUPDLG_FLAGS = uint;
enum : uint
{
    PSD_DEFAULTMINMARGINS             = 0x00000000,
    PSD_DISABLEMARGINS                = 0x00000010,
    PSD_DISABLEORIENTATION            = 0x00000100,
    PSD_DISABLEPAGEPAINTING           = 0x00080000,
    PSD_DISABLEPAPER                  = 0x00000200,
    PSD_DISABLEPRINTER                = 0x00000020,
    PSD_ENABLEPAGEPAINTHOOK           = 0x00040000,
    PSD_ENABLEPAGESETUPHOOK           = 0x00002000,
    PSD_ENABLEPAGESETUPTEMPLATE       = 0x00008000,
    PSD_ENABLEPAGESETUPTEMPLATEHANDLE = 0x00020000,
    PSD_INHUNDREDTHSOFMILLIMETERS     = 0x00000008,
    PSD_INTHOUSANDTHSOFINCHES         = 0x00000004,
    PSD_INWININIINTLMEASURE           = 0x00000000,
    PSD_MARGINS                       = 0x00000002,
    PSD_MINMARGINS                    = 0x00000001,
    PSD_NONETWORKBUTTON               = 0x00200000,
    PSD_NOWARNING                     = 0x00000080,
    PSD_RETURNDEFAULT                 = 0x00000400,
    PSD_SHOWHELP                      = 0x00000800,
}

alias CHOOSEFONT_FLAGS = uint;
enum : uint
{
    CF_APPLY                = 0x00000200,
    CF_ANSIONLY             = 0x00000400,
    CF_BOTH                 = 0x00000003,
    CF_EFFECTS              = 0x00000100,
    CF_ENABLEHOOK           = 0x00000008,
    CF_ENABLETEMPLATE       = 0x00000010,
    CF_ENABLETEMPLATEHANDLE = 0x00000020,
    CF_FIXEDPITCHONLY       = 0x00004000,
    CF_FORCEFONTEXIST       = 0x00010000,
    CF_INACTIVEFONTS        = 0x02000000,
    CF_INITTOLOGFONTSTRUCT  = 0x00000040,
    CF_LIMITSIZE            = 0x00002000,
    CF_NOOEMFONTS           = 0x00000800,
    CF_NOFACESEL            = 0x00080000,
    CF_NOSCRIPTSEL          = 0x00800000,
    CF_NOSIMULATIONS        = 0x00001000,
    CF_NOSIZESEL            = 0x00200000,
    CF_NOSTYLESEL           = 0x00100000,
    CF_NOVECTORFONTS        = 0x00000800,
    CF_NOVERTFONTS          = 0x01000000,
    CF_PRINTERFONTS         = 0x00000002,
    CF_SCALABLEONLY         = 0x00020000,
    CF_SCREENFONTS          = 0x00000001,
    CF_SCRIPTSONLY          = 0x00000400,
    CF_SELECTSCRIPT         = 0x00400000,
    CF_SHOWHELP             = 0x00000004,
    CF_TTONLY               = 0x00040000,
    CF_USESTYLE             = 0x00000080,
    CF_WYSIWYG              = 0x00008000,
}

alias FINDREPLACE_FLAGS = uint;
enum : uint
{
    FR_DOWN                 = 0x00000001,
    FR_WHOLEWORD            = 0x00000002,
    FR_MATCHCASE            = 0x00000004,
    FR_FINDNEXT             = 0x00000008,
    FR_REPLACE              = 0x00000010,
    FR_REPLACEALL           = 0x00000020,
    FR_DIALOGTERM           = 0x00000040,
    FR_SHOWHELP             = 0x00000080,
    FR_ENABLEHOOK           = 0x00000100,
    FR_ENABLETEMPLATE       = 0x00000200,
    FR_NOUPDOWN             = 0x00000400,
    FR_NOMATCHCASE          = 0x00000800,
    FR_NOWHOLEWORD          = 0x00001000,
    FR_ENABLETEMPLATEHANDLE = 0x00002000,
    FR_HIDEUPDOWN           = 0x00004000,
    FR_HIDEMATCHCASE        = 0x00008000,
    FR_HIDEWHOLEWORD        = 0x00010000,
    FR_RAW                  = 0x00020000,
    FR_SHOWWRAPAROUND       = 0x00040000,
    FR_NOWRAPAROUND         = 0x00080000,
    FR_WRAPAROUND           = 0x00100000,
    FR_MATCHDIAC            = 0x20000000,
    FR_MATCHKASHIDA         = 0x40000000,
    FR_MATCHALEFHAMZA       = 0x80000000,
}

alias PRINTDLGEX_FLAGS = uint;
enum : uint
{
    PD_ALLPAGES                   = 0x00000000,
    PD_COLLATE                    = 0x00000010,
    PD_CURRENTPAGE                = 0x00400000,
    PD_DISABLEPRINTTOFILE         = 0x00080000,
    PD_ENABLEPRINTTEMPLATE        = 0x00004000,
    PD_ENABLEPRINTTEMPLATEHANDLE  = 0x00010000,
    PD_EXCLUSIONFLAGS             = 0x01000000,
    PD_HIDEPRINTTOFILE            = 0x00100000,
    PD_NOCURRENTPAGE              = 0x00800000,
    PD_NOPAGENUMS                 = 0x00000008,
    PD_NOSELECTION                = 0x00000004,
    PD_NOWARNING                  = 0x00000080,
    PD_PAGENUMS                   = 0x00000002,
    PD_PRINTTOFILE                = 0x00000020,
    PD_RETURNDC                   = 0x00000100,
    PD_RETURNDEFAULT              = 0x00000400,
    PD_RETURNIC                   = 0x00000200,
    PD_SELECTION                  = 0x00000001,
    PD_USEDEVMODECOPIES           = 0x00040000,
    PD_USEDEVMODECOPIESANDCOLLATE = 0x00040000,
    PD_USELARGETEMPLATE           = 0x10000000,
    PD_ENABLEPRINTHOOK            = 0x00001000,
    PD_ENABLESETUPHOOK            = 0x00002000,
    PD_ENABLESETUPTEMPLATE        = 0x00008000,
    PD_ENABLESETUPTEMPLATEHANDLE  = 0x00020000,
    PD_NONETWORKBUTTON            = 0x00200000,
    PD_PRINTSETUP                 = 0x00000040,
    PD_SHOWHELP                   = 0x00000800,
}

alias CHOOSEFONT_FONT_TYPE = ushort;
enum : ushort
{
    BOLD_FONTTYPE      = cast(ushort)0x0100,
    ITALIC_FONTTYPE    = cast(ushort)0x0200,
    PRINTER_FONTTYPE   = cast(ushort)0x4000,
    REGULAR_FONTTYPE   = cast(ushort)0x0400,
    SCREEN_FONTTYPE    = cast(ushort)0x2000,
    SIMULATED_FONTTYPE = cast(ushort)0x8000,
}

// Constants


enum : uint
{
    OFN_SHAREFALLTHROUGH = 0x00000002,
    OFN_SHARENOWARN      = 0x00000001,
    OFN_SHAREWARN        = 0x00000000,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/cdn-selchange))], [])*/uint CDN_SELCHANGE = 0xfffffda6;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/cdn-shareviolation))], [])*/uint CDN_SHAREVIOLATION = 0xfffffda4;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/cdn-fileok))], [])*/uint CDN_FILEOK = 0xfffffda2;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/cdn-includeitem))], [])*/uint CDN_INCLUDEITEM = 0xfffffda0;

enum : uint
{
    CDM_LAST            = 0x000004c8,
    CDM_GETSPEC         = 0x00000464,
    CDM_GETFILEPATH     = 0x00000465,
    CDM_GETFOLDERPATH   = 0x00000466,
    CDM_GETFOLDERIDLIST = 0x00000467,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/cdm-hidecontrol))], [])*/uint CDM_HIDECONTROL = 0x00000469;

enum : uint
{
    FRM_FIRST                  = 0x00000464,
    FRM_LAST                   = 0x000004c8,
    FRM_SETOPERATIONRESULT     = 0x00000464,
    FRM_SETOPERATIONRESULTTEXT = 0x00000465,
}

enum uint TT_OPENTYPE_FONTTYPE = 0x00020000;
enum uint SYMBOL_FONTTYPE = 0x00080000;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/wm-choosefont-setlogfont))], [])*/uint
{
    WM_CHOOSEFONT_SETLOGFONT = 0x00000465,
    WM_CHOOSEFONT_SETFLAGS   = 0x00000466,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/sharevistring))], [])*/const(wchar)* SHAREVISTRINGA = "commdlg_ShareViolation";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/colorokstring))], [])*/const(wchar)* COLOROKSTRINGA = "commdlg_ColorOK";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/helpmsgstring))], [])*/const(wchar)* HELPMSGSTRINGA = "commdlg_help";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/lbselchstring))], [])*/const(wchar)* LBSELCHSTRINGW = "commdlg_LBSelChangedNotify";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/fileokstring))], [])*/const(wchar)* FILEOKSTRINGW = "commdlg_FileNameOK";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/setrgbstring))], [])*/const(wchar)* SETRGBSTRINGW = "commdlg_SetRGBColor";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/findmsgstring))], [])*/const(wchar)* FINDMSGSTRINGW = "commdlg_FindReplace";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/sharevistring))], [])*/const(wchar)* SHAREVISTRING = "commdlg_ShareViolation";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/colorokstring))], [])*/const(wchar)* COLOROKSTRING = "commdlg_ColorOK";
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/helpmsgstring))], [])*/const(wchar)* HELPMSGSTRING = "commdlg_help";
enum int CD_LBSELNOITEMS = 0xffffffff;

enum : uint
{
    CD_LBSELSUB = 0x00000001,
    CD_LBSELADD = 0x00000002,
}

enum : uint
{
    PD_RESULT_CANCEL = 0x00000000,
    PD_RESULT_PRINT  = 0x00000001,
    PD_RESULT_APPLY  = 0x00000002,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/wm-psd-fullpagerect))], [])*/uint WM_PSD_FULLPAGERECT = 0x00000401;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/wm-psd-marginrect))], [])*/uint
{
    WM_PSD_MARGINRECT    = 0x00000403,
    WM_PSD_GREEKTEXTRECT = 0x00000404,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/dlgbox/wm-psd-yafullpagerect))], [])*/uint WM_PSD_YAFULLPAGERECT = 0x00000406;
enum uint COLOR_HUESCROLL = 0x000002bc;
enum uint COLOR_LUMSCROLL = 0x000002be;

enum : uint
{
    COLOR_SAT        = 0x000002c0,
    COLOR_LUM        = 0x000002c1,
    COLOR_RED        = 0x000002c2,
    COLOR_GREEN      = 0x000002c3,
    COLOR_BLUE       = 0x000002c4,
    COLOR_CURRENT    = 0x000002c5,
    COLOR_RAINBOW    = 0x000002c6,
    COLOR_SAVE       = 0x000002c7,
    COLOR_ADD        = 0x000002c8,
    COLOR_SOLID      = 0x000002c9,
    COLOR_TUNE       = 0x000002ca,
    COLOR_SCHEMES    = 0x000002cb,
    COLOR_ELEMENT    = 0x000002cc,
    COLOR_SAMPLES    = 0x000002cd,
    COLOR_PALETTE    = 0x000002ce,
    COLOR_MIX        = 0x000002cf,
    COLOR_BOX1       = 0x000002d0,
    COLOR_CUSTOM1    = 0x000002d1,
    COLOR_HUEACCEL   = 0x000002d3,
    COLOR_SATACCEL   = 0x000002d4,
    COLOR_LUMACCEL   = 0x000002d5,
    COLOR_REDACCEL   = 0x000002d6,
    COLOR_GREENACCEL = 0x000002d7,
}

enum : uint
{
    COLOR_SOLID_LEFT  = 0x000002da,
    COLOR_SOLID_RIGHT = 0x000002db,
}

enum uint NUM_CUSTOM_COLORS = 0x00000010;

// Callbacks

alias LPOFNHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPCCHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPFRHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPCFHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPRINTHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPSETUPHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPAGEPAINTHOOK = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPAGESETUPHOOK = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);

// Structs


version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4a))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct OPENFILENAME_NT4A
{
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(PSTR)   lpstrFilter;
    PSTR          lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    PSTR          lpstrFile;
    uint          nMaxFile;
    PSTR          lpstrFileTitle;
    uint          nMaxFileTitle;
    const(PSTR)   lpstrInitialDir;
    const(PSTR)   lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(PSTR)   lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(PSTR)   lpTemplateName;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4w))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct OPENFILENAME_NT4W
{
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(PWSTR)  lpstrFilter;
    PWSTR         lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    PWSTR         lpstrFile;
    uint          nMaxFile;
    PWSTR         lpstrFileTitle;
    uint          nMaxFileTitle;
    const(PWSTR)  lpstrInitialDir;
    const(PWSTR)  lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(PWSTR)  lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(PWSTR)  lpTemplateName;
}
}

version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamea))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct OPENFILENAMEA
{
    uint                lStructSize;
    HWND                hwndOwner;
    HINSTANCE           hInstance;
    const(PSTR)         lpstrFilter;
    PSTR                lpstrCustomFilter;
    uint                nMaxCustFilter;
    uint                nFilterIndex;
    PSTR                lpstrFile;
    uint                nMaxFile;
    PSTR                lpstrFileTitle;
    uint                nMaxFileTitle;
    const(PSTR)         lpstrInitialDir;
    const(PSTR)         lpstrTitle;
    OPEN_FILENAME_FLAGS Flags;
    ushort              nFileOffset;
    ushort              nFileExtension;
    const(PSTR)         lpstrDefExt;
    LPARAM              lCustData;
    LPOFNHOOKPROC       lpfnHook;
    const(PSTR)         lpTemplateName;
    void*               pvReserved;
    uint                dwReserved;
    OPEN_FILENAME_FLAGS_EX FlagsEx;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamew))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct OPENFILENAMEW
{
    uint                lStructSize;
    HWND                hwndOwner;
    HINSTANCE           hInstance;
    const(PWSTR)        lpstrFilter;
    PWSTR               lpstrCustomFilter;
    uint                nMaxCustFilter;
    uint                nFilterIndex;
    PWSTR               lpstrFile;
    uint                nMaxFile;
    PWSTR               lpstrFileTitle;
    uint                nMaxFileTitle;
    const(PWSTR)        lpstrInitialDir;
    const(PWSTR)        lpstrTitle;
    OPEN_FILENAME_FLAGS Flags;
    ushort              nFileOffset;
    ushort              nFileExtension;
    const(PWSTR)        lpstrDefExt;
    LPARAM              lCustData;
    LPOFNHOOKPROC       lpfnHook;
    const(PWSTR)        lpTemplateName;
    void*               pvReserved;
    uint                dwReserved;
    OPEN_FILENAME_FLAGS_EX FlagsEx;
}
}

version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifya))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct OFNOTIFYA
{
    NMHDR          hdr;
    OPENFILENAMEA* lpOFN;
    PSTR           pszFile;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct OFNOTIFYW
{
    NMHDR          hdr;
    OPENFILENAMEW* lpOFN;
    PWSTR          pszFile;
}
}

version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexa))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct OFNOTIFYEXA
{
    NMHDR          hdr;
    OPENFILENAMEA* lpOFN;
    void*          psf;
    void*          pidl;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct OFNOTIFYEXW
{
    NMHDR          hdr;
    OPENFILENAMEW* lpOFN;
    void*          psf;
    void*          pidl;
}
}

version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolora))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct CHOOSECOLORA
{
    uint              lStructSize;
    HWND              hwndOwner;
    HWND              hInstance;
    COLORREF          rgbResult;
    COLORREF*         lpCustColors;
    CHOOSECOLOR_FLAGS Flags;
    LPARAM            lCustData;
    LPCCHOOKPROC      lpfnHook;
    const(PSTR)       lpTemplateName;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolorw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct CHOOSECOLORW
{
    uint              lStructSize;
    HWND              hwndOwner;
    HWND              hInstance;
    COLORREF          rgbResult;
    COLORREF*         lpCustColors;
    CHOOSECOLOR_FLAGS Flags;
    LPARAM            lCustData;
    LPCCHOOKPROC      lpfnHook;
    const(PWSTR)      lpTemplateName;
}
}

version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacea))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct FINDREPLACEA
{
    uint              lStructSize;
    HWND              hwndOwner;
    HINSTANCE         hInstance;
    FINDREPLACE_FLAGS Flags;
    PSTR              lpstrFindWhat;
    PSTR              lpstrReplaceWith;
    ushort            wFindWhatLen;
    ushort            wReplaceWithLen;
    LPARAM            lCustData;
    LPFRHOOKPROC      lpfnHook;
    const(PSTR)       lpTemplateName;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacew))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct FINDREPLACEW
{
    uint              lStructSize;
    HWND              hwndOwner;
    HINSTANCE         hInstance;
    FINDREPLACE_FLAGS Flags;
    PWSTR             lpstrFindWhat;
    PWSTR             lpstrReplaceWith;
    ushort            wFindWhatLen;
    ushort            wReplaceWithLen;
    LPARAM            lCustData;
    LPFRHOOKPROC      lpfnHook;
    const(PWSTR)      lpTemplateName;
}
}

version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefonta))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct CHOOSEFONTA
{
    uint                 lStructSize;
    HWND                 hwndOwner;
    HDC                  hDC;
    LOGFONTA*            lpLogFont;
    int                  iPointSize;
    CHOOSEFONT_FLAGS     Flags;
    COLORREF             rgbColors;
    LPARAM               lCustData;
    LPCFHOOKPROC         lpfnHook;
    const(PSTR)          lpTemplateName;
    HINSTANCE            hInstance;
    PSTR                 lpszStyle;
    CHOOSEFONT_FONT_TYPE nFontType;
    ushort               ___MISSING_ALIGNMENT__;
    int                  nSizeMin;
    int                  nSizeMax;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefontw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct CHOOSEFONTW
{
    uint                 lStructSize;
    HWND                 hwndOwner;
    HDC                  hDC;
    LOGFONTW*            lpLogFont;
    int                  iPointSize;
    CHOOSEFONT_FLAGS     Flags;
    COLORREF             rgbColors;
    LPARAM               lCustData;
    LPCFHOOKPROC         lpfnHook;
    const(PWSTR)         lpTemplateName;
    HINSTANCE            hInstance;
    PWSTR                lpszStyle;
    CHOOSEFONT_FONT_TYPE nFontType;
    ushort               ___MISSING_ALIGNMENT__;
    int                  nSizeMin;
    int                  nSizeMax;
}
}

version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlga))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct PRINTDLGA
{
    uint             lStructSize;
    HWND             hwndOwner;
    HGLOBAL          hDevMode;
    HGLOBAL          hDevNames;
    HDC              hDC;
    PRINTDLGEX_FLAGS Flags;
    ushort           nFromPage;
    ushort           nToPage;
    ushort           nMinPage;
    ushort           nMaxPage;
    ushort           nCopies;
    HINSTANCE        hInstance;
    LPARAM           lCustData;
    LPPRINTHOOKPROC  lpfnPrintHook;
    LPSETUPHOOKPROC  lpfnSetupHook;
    const(PSTR)      lpPrintTemplateName;
    const(PSTR)      lpSetupTemplateName;
    HGLOBAL          hPrintTemplate;
    HGLOBAL          hSetupTemplate;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct PRINTDLGW
{
    uint             lStructSize;
    HWND             hwndOwner;
    HGLOBAL          hDevMode;
    HGLOBAL          hDevNames;
    HDC              hDC;
    PRINTDLGEX_FLAGS Flags;
    ushort           nFromPage;
    ushort           nToPage;
    ushort           nMinPage;
    ushort           nMaxPage;
    ushort           nCopies;
    HINSTANCE        hInstance;
    LPARAM           lCustData;
    LPPRINTHOOKPROC  lpfnPrintHook;
    LPSETUPHOOKPROC  lpfnSetupHook;
    const(PWSTR)     lpPrintTemplateName;
    const(PWSTR)     lpSetupTemplateName;
    HGLOBAL          hPrintTemplate;
    HGLOBAL          hSetupTemplate;
}
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printpagerange))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct PRINTPAGERANGE
{
    uint nFromPage;
    uint nToPage;
}
}

version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexa))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct PRINTDLGEXA
{
    uint             lStructSize;
    HWND             hwndOwner;
    HGLOBAL          hDevMode;
    HGLOBAL          hDevNames;
    HDC              hDC;
    PRINTDLGEX_FLAGS Flags;
    uint             Flags2;
    uint             ExclusionFlags;
    uint             nPageRanges;
    uint             nMaxPageRanges;
    PRINTPAGERANGE*  lpPageRanges;
    uint             nMinPage;
    uint             nMaxPage;
    uint             nCopies;
    HINSTANCE        hInstance;
    const(PSTR)      lpPrintTemplateName;
    IUnknown         lpCallback;
    uint             nPropertyPages;
    HPROPSHEETPAGE*  lphPropertyPages;
    uint             nStartPage;
    uint             dwResultAction;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct PRINTDLGEXW
{
    uint             lStructSize;
    HWND             hwndOwner;
    HGLOBAL          hDevMode;
    HGLOBAL          hDevNames;
    HDC              hDC;
    PRINTDLGEX_FLAGS Flags;
    uint             Flags2;
    uint             ExclusionFlags;
    uint             nPageRanges;
    uint             nMaxPageRanges;
    PRINTPAGERANGE*  lpPageRanges;
    uint             nMinPage;
    uint             nMaxPage;
    uint             nCopies;
    HINSTANCE        hInstance;
    const(PWSTR)     lpPrintTemplateName;
    IUnknown         lpCallback;
    uint             nPropertyPages;
    HPROPSHEETPAGE*  lphPropertyPages;
    uint             nStartPage;
    uint             dwResultAction;
}
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-devnames))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct DEVNAMES
{
    ushort wDriverOffset;
    ushort wDeviceOffset;
    ushort wOutputOffset;
    ushort wDefault;
}
}

version (X86) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlga))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct PAGESETUPDLGA
{
    uint               lStructSize;
    HWND               hwndOwner;
    HGLOBAL            hDevMode;
    HGLOBAL            hDevNames;
    PAGESETUPDLG_FLAGS Flags;
    POINT              ptPaperSize;
    RECT               rtMinMargin;
    RECT               rtMargin;
    HINSTANCE          hInstance;
    LPARAM             lCustData;
    LPPAGESETUPHOOK    lpfnPageSetupHook;
    LPPAGEPAINTHOOK    lpfnPagePaintHook;
    const(PSTR)        lpPageSetupTemplateName;
    HGLOBAL            hPageSetupTemplate;
}
}

version (X86) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlgw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct PAGESETUPDLGW
{
    uint               lStructSize;
    HWND               hwndOwner;
    HGLOBAL            hDevMode;
    HGLOBAL            hDevNames;
    PAGESETUPDLG_FLAGS Flags;
    POINT              ptPaperSize;
    RECT               rtMinMargin;
    RECT               rtMargin;
    HINSTANCE          hInstance;
    LPARAM             lCustData;
    LPPAGESETUPHOOK    lpfnPageSetupHook;
    LPPAGEPAINTHOOK    lpfnPagePaintHook;
    const(PWSTR)       lpPageSetupTemplateName;
    HGLOBAL            hPageSetupTemplate;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4a))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct OPENFILENAME_NT4A
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(PSTR)   lpstrFilter;
    PSTR          lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    PSTR          lpstrFile;
    uint          nMaxFile;
    PSTR          lpstrFileTitle;
    uint          nMaxFileTitle;
    const(PSTR)   lpstrInitialDir;
    const(PSTR)   lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(PSTR)   lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(PSTR)   lpTemplateName;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilename_nt4w))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct OPENFILENAME_NT4W
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(PWSTR)  lpstrFilter;
    PWSTR         lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    PWSTR         lpstrFile;
    uint          nMaxFile;
    PWSTR         lpstrFileTitle;
    uint          nMaxFileTitle;
    const(PWSTR)  lpstrInitialDir;
    const(PWSTR)  lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(PWSTR)  lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(PWSTR)  lpTemplateName;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamea))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct OPENFILENAMEA
{
align (1):
    uint                lStructSize;
    HWND                hwndOwner;
    HINSTANCE           hInstance;
    const(PSTR)         lpstrFilter;
    PSTR                lpstrCustomFilter;
    uint                nMaxCustFilter;
    uint                nFilterIndex;
    PSTR                lpstrFile;
    uint                nMaxFile;
    PSTR                lpstrFileTitle;
    uint                nMaxFileTitle;
    const(PSTR)         lpstrInitialDir;
    const(PSTR)         lpstrTitle;
    OPEN_FILENAME_FLAGS Flags;
    ushort              nFileOffset;
    ushort              nFileExtension;
    const(PSTR)         lpstrDefExt;
    LPARAM              lCustData;
    LPOFNHOOKPROC       lpfnHook;
    const(PSTR)         lpTemplateName;
    void*               pvReserved;
    uint                dwReserved;
    OPEN_FILENAME_FLAGS_EX FlagsEx;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-openfilenamew))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct OPENFILENAMEW
{
align (1):
    uint                lStructSize;
    HWND                hwndOwner;
    HINSTANCE           hInstance;
    const(PWSTR)        lpstrFilter;
    PWSTR               lpstrCustomFilter;
    uint                nMaxCustFilter;
    uint                nFilterIndex;
    PWSTR               lpstrFile;
    uint                nMaxFile;
    PWSTR               lpstrFileTitle;
    uint                nMaxFileTitle;
    const(PWSTR)        lpstrInitialDir;
    const(PWSTR)        lpstrTitle;
    OPEN_FILENAME_FLAGS Flags;
    ushort              nFileOffset;
    ushort              nFileExtension;
    const(PWSTR)        lpstrDefExt;
    LPARAM              lCustData;
    LPOFNHOOKPROC       lpfnHook;
    const(PWSTR)        lpTemplateName;
    void*               pvReserved;
    uint                dwReserved;
    OPEN_FILENAME_FLAGS_EX FlagsEx;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifya))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct OFNOTIFYA
{
align (1):
    NMHDR          hdr;
    OPENFILENAMEA* lpOFN;
    PSTR           pszFile;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct OFNOTIFYW
{
align (1):
    NMHDR          hdr;
    OPENFILENAMEW* lpOFN;
    PWSTR          pszFile;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexa))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct OFNOTIFYEXA
{
align (1):
    NMHDR          hdr;
    OPENFILENAMEA* lpOFN;
    void*          psf;
    void*          pidl;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-ofnotifyexw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct OFNOTIFYEXW
{
align (1):
    NMHDR          hdr;
    OPENFILENAMEW* lpOFN;
    void*          psf;
    void*          pidl;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolora))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct CHOOSECOLORA
{
align (1):
    uint              lStructSize;
    HWND              hwndOwner;
    HWND              hInstance;
    COLORREF          rgbResult;
    COLORREF*         lpCustColors;
    CHOOSECOLOR_FLAGS Flags;
    LPARAM            lCustData;
    LPCCHOOKPROC      lpfnHook;
    const(PSTR)       lpTemplateName;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosecolorw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct CHOOSECOLORW
{
align (1):
    uint              lStructSize;
    HWND              hwndOwner;
    HWND              hInstance;
    COLORREF          rgbResult;
    COLORREF*         lpCustColors;
    CHOOSECOLOR_FLAGS Flags;
    LPARAM            lCustData;
    LPCCHOOKPROC      lpfnHook;
    const(PWSTR)      lpTemplateName;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacea))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct FINDREPLACEA
{
align (1):
    uint              lStructSize;
    HWND              hwndOwner;
    HINSTANCE         hInstance;
    FINDREPLACE_FLAGS Flags;
    PSTR              lpstrFindWhat;
    PSTR              lpstrReplaceWith;
    ushort            wFindWhatLen;
    ushort            wReplaceWithLen;
    LPARAM            lCustData;
    LPFRHOOKPROC      lpfnHook;
    const(PSTR)       lpTemplateName;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-findreplacew))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct FINDREPLACEW
{
align (1):
    uint              lStructSize;
    HWND              hwndOwner;
    HINSTANCE         hInstance;
    FINDREPLACE_FLAGS Flags;
    PWSTR             lpstrFindWhat;
    PWSTR             lpstrReplaceWith;
    ushort            wFindWhatLen;
    ushort            wReplaceWithLen;
    LPARAM            lCustData;
    LPFRHOOKPROC      lpfnHook;
    const(PWSTR)      lpTemplateName;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefonta))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct CHOOSEFONTA
{
align (1):
    uint                 lStructSize;
    HWND                 hwndOwner;
    HDC                  hDC;
    LOGFONTA*            lpLogFont;
    int                  iPointSize;
    CHOOSEFONT_FLAGS     Flags;
    COLORREF             rgbColors;
    LPARAM               lCustData;
    LPCFHOOKPROC         lpfnHook;
    const(PSTR)          lpTemplateName;
    HINSTANCE            hInstance;
    PSTR                 lpszStyle;
    CHOOSEFONT_FONT_TYPE nFontType;
    ushort               ___MISSING_ALIGNMENT__;
    int                  nSizeMin;
    int                  nSizeMax;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-choosefontw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct CHOOSEFONTW
{
align (1):
    uint                 lStructSize;
    HWND                 hwndOwner;
    HDC                  hDC;
    LOGFONTW*            lpLogFont;
    int                  iPointSize;
    CHOOSEFONT_FLAGS     Flags;
    COLORREF             rgbColors;
    LPARAM               lCustData;
    LPCFHOOKPROC         lpfnHook;
    const(PWSTR)         lpTemplateName;
    HINSTANCE            hInstance;
    PWSTR                lpszStyle;
    CHOOSEFONT_FONT_TYPE nFontType;
    ushort               ___MISSING_ALIGNMENT__;
    int                  nSizeMin;
    int                  nSizeMax;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlga))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct PRINTDLGA
{
align (1):
    uint             lStructSize;
    HWND             hwndOwner;
    HGLOBAL          hDevMode;
    HGLOBAL          hDevNames;
    HDC              hDC;
    PRINTDLGEX_FLAGS Flags;
    ushort           nFromPage;
    ushort           nToPage;
    ushort           nMinPage;
    ushort           nMaxPage;
    ushort           nCopies;
    HINSTANCE        hInstance;
    LPARAM           lCustData;
    LPPRINTHOOKPROC  lpfnPrintHook;
    LPSETUPHOOKPROC  lpfnSetupHook;
    const(PSTR)      lpPrintTemplateName;
    const(PSTR)      lpSetupTemplateName;
    HGLOBAL          hPrintTemplate;
    HGLOBAL          hSetupTemplate;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct PRINTDLGW
{
align (1):
    uint             lStructSize;
    HWND             hwndOwner;
    HGLOBAL          hDevMode;
    HGLOBAL          hDevNames;
    HDC              hDC;
    PRINTDLGEX_FLAGS Flags;
    ushort           nFromPage;
    ushort           nToPage;
    ushort           nMinPage;
    ushort           nMaxPage;
    ushort           nCopies;
    HINSTANCE        hInstance;
    LPARAM           lCustData;
    LPPRINTHOOKPROC  lpfnPrintHook;
    LPSETUPHOOKPROC  lpfnSetupHook;
    const(PWSTR)     lpPrintTemplateName;
    const(PWSTR)     lpSetupTemplateName;
    HGLOBAL          hPrintTemplate;
    HGLOBAL          hSetupTemplate;
}
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printpagerange))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct PRINTPAGERANGE
{
align (1):
    uint nFromPage;
    uint nToPage;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexa))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct PRINTDLGEXA
{
align (1):
    uint             lStructSize;
    HWND             hwndOwner;
    HGLOBAL          hDevMode;
    HGLOBAL          hDevNames;
    HDC              hDC;
    PRINTDLGEX_FLAGS Flags;
    uint             Flags2;
    uint             ExclusionFlags;
    uint             nPageRanges;
    uint             nMaxPageRanges;
    PRINTPAGERANGE*  lpPageRanges;
    uint             nMinPage;
    uint             nMaxPage;
    uint             nCopies;
    HINSTANCE        hInstance;
    const(PSTR)      lpPrintTemplateName;
    IUnknown         lpCallback;
    uint             nPropertyPages;
    HPROPSHEETPAGE*  lphPropertyPages;
    uint             nStartPage;
    uint             dwResultAction;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-printdlgexw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct PRINTDLGEXW
{
align (1):
    uint             lStructSize;
    HWND             hwndOwner;
    HGLOBAL          hDevMode;
    HGLOBAL          hDevNames;
    HDC              hDC;
    PRINTDLGEX_FLAGS Flags;
    uint             Flags2;
    uint             ExclusionFlags;
    uint             nPageRanges;
    uint             nMaxPageRanges;
    PRINTPAGERANGE*  lpPageRanges;
    uint             nMinPage;
    uint             nMaxPage;
    uint             nCopies;
    HINSTANCE        hInstance;
    const(PWSTR)     lpPrintTemplateName;
    IUnknown         lpCallback;
    uint             nPropertyPages;
    HPROPSHEETPAGE*  lphPropertyPages;
    uint             nStartPage;
    uint             dwResultAction;
}
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-devnames))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct DEVNAMES
{
align (1):
    ushort wDriverOffset;
    ushort wDeviceOffset;
    ushort wOutputOffset;
    ushort wDefault;
}
}

version (X86_64) {
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlga))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct PAGESETUPDLGA
{
align (1):
    uint               lStructSize;
    HWND               hwndOwner;
    HGLOBAL            hDevMode;
    HGLOBAL            hDevNames;
    PAGESETUPDLG_FLAGS Flags;
    POINT              ptPaperSize;
    RECT               rtMinMargin;
    RECT               rtMargin;
    HINSTANCE          hInstance;
    LPARAM             lCustData;
    LPPAGESETUPHOOK    lpfnPageSetupHook;
    LPPAGEPAINTHOOK    lpfnPagePaintHook;
    const(PSTR)        lpPageSetupTemplateName;
    HGLOBAL            hPageSetupTemplate;
}
}

version (X86_64) {
//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/ns-commdlg-pagesetupdlgw))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct PAGESETUPDLGW
{
align (1):
    uint               lStructSize;
    HWND               hwndOwner;
    HGLOBAL            hDevMode;
    HGLOBAL            hDevNames;
    PAGESETUPDLG_FLAGS Flags;
    POINT              ptPaperSize;
    RECT               rtMinMargin;
    RECT               rtMargin;
    HINSTANCE          hInstance;
    LPARAM             lCustData;
    LPPAGESETUPHOOK    lpfnPageSetupHook;
    LPPAGEPAINTHOOK    lpfnPagePaintHook;
    const(PWSTR)       lpPageSetupTemplateName;
    HGLOBAL            hPageSetupTemplate;
}
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-getopenfilenamea))], [])
@DllImport("COMDLG32.dll")
BOOL GetOpenFileNameA(OPENFILENAMEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-getopenfilenamew))], [])
@DllImport("COMDLG32.dll")
BOOL GetOpenFileNameW(OPENFILENAMEW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-getsavefilenamea))], [])
@DllImport("COMDLG32.dll")
BOOL GetSaveFileNameA(OPENFILENAMEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-getsavefilenamew))], [])
@DllImport("COMDLG32.dll")
BOOL GetSaveFileNameW(OPENFILENAMEW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-getfiletitlea))], [])
@DllImport("COMDLG32.dll")
short GetFileTitleA(const(PSTR) param0, PSTR Buf, ushort cchSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-getfiletitlew))], [])
@DllImport("COMDLG32.dll")
short GetFileTitleW(const(PWSTR) param0, PWSTR Buf, ushort cchSize);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("COMDLG32.dll")
BOOL ChooseColorA(CHOOSECOLORA* param0);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nc-commdlg-choosecolorw))], [])
@DllImport("COMDLG32.dll")
BOOL ChooseColorW(CHOOSECOLORW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-findtexta))], [])
@DllImport("COMDLG32.dll")
HWND FindTextA(FINDREPLACEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-findtextw))], [])
@DllImport("COMDLG32.dll")
HWND FindTextW(FINDREPLACEW* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-replacetexta))], [])
@DllImport("COMDLG32.dll")
HWND ReplaceTextA(FINDREPLACEA* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-replacetextw))], [])
@DllImport("COMDLG32.dll")
HWND ReplaceTextW(FINDREPLACEW* param0);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nc-commdlg-choosefonta))], [])
@DllImport("COMDLG32.dll")
BOOL ChooseFontA(CHOOSEFONTA* param0);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nc-commdlg-choosefontw))], [])
@DllImport("COMDLG32.dll")
BOOL ChooseFontW(CHOOSEFONTW* param0);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nc-commdlg-printdlga))], [])
@DllImport("COMDLG32.dll")
BOOL PrintDlgA(PRINTDLGA* pPD);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nc-commdlg-printdlgw))], [])
@DllImport("COMDLG32.dll")
BOOL PrintDlgW(PRINTDLGW* pPD);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nc-commdlg-printdlgexa))], [])
@DllImport("COMDLG32.dll")
HRESULT PrintDlgExA(PRINTDLGEXA* pPD);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nc-commdlg-printdlgexw))], [])
@DllImport("COMDLG32.dll")
HRESULT PrintDlgExW(PRINTDLGEXW* pPD);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-commdlgextendederror))], [])
@DllImport("COMDLG32.dll")
COMMON_DLG_ERRORS CommDlgExtendedError();

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nc-commdlg-pagesetupdlga))], [])
@DllImport("COMDLG32.dll")
BOOL PageSetupDlgA(PAGESETUPDLGA* param0);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nc-commdlg-pagesetupdlgw))], [])
@DllImport("COMDLG32.dll")
BOOL PageSetupDlgW(PAGESETUPDLGW* param0);


// Interfaces

@GUID("5852a2c3-6530-11d1-b6a3-0000f8757bf9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nn-commdlg-iprintdialogcallback))], [])
interface IPrintDialogCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogcallback-initdone))], [])
    HRESULT InitDone();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogcallback-selectionchange))], [])
    HRESULT SelectionChange();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogcallback-handlemessage))], [])
    HRESULT HandleMessage(HWND hDlg, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* pResult);
}

@GUID("509aaeda-5639-11d1-b6a1-0000f8757bf9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nn-commdlg-iprintdialogservices))], [])
interface IPrintDialogServices : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogservices-getcurrentdevmode))], [])
    HRESULT GetCurrentDevMode(DEVMODEA* pDevMode, uint* pcbSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogservices-getcurrentprintername))], [])
    HRESULT GetCurrentPrinterName(PWSTR pPrinterName, uint* pcchSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/commdlg/nf-commdlg-iprintdialogservices-getcurrentportname))], [])
    HRESULT GetCurrentPortName(PWSTR pPortName, uint* pcchSize);
}


// GUIDs


const GUID IID_IPrintDialogCallback = GUIDOF!IPrintDialogCallback;
const GUID IID_IPrintDialogServices = GUIDOF!IPrintDialogServices;
