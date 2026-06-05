// Written in the D programming language.

module windows.win32.graphics.gdi;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, COLORREF, HANDLE, HGLOBAL, HINSTANCE, HMODULE, HWND, LPARAM, POINT,
                                         POINTL, POINTS, PSTR, PWSTR, RECT, RECTL, SIZE, WPARAM;
public import windows.win32.storage.jet : JET_ENUMCOLUMNVALUE;

extern(Windows) @nogc nothrow:


// Enums


alias R2_MODE = int;
enum : int
{
    R2_BLACK       = 0x00000001,
    R2_NOTMERGEPEN = 0x00000002,
    R2_MASKNOTPEN  = 0x00000003,
    R2_NOTCOPYPEN  = 0x00000004,
    R2_MASKPENNOT  = 0x00000005,
    R2_NOT         = 0x00000006,
    R2_XORPEN      = 0x00000007,
    R2_NOTMASKPEN  = 0x00000008,
    R2_MASKPEN     = 0x00000009,
    R2_NOTXORPEN   = 0x0000000a,
    R2_NOP         = 0x0000000b,
    R2_MERGENOTPEN = 0x0000000c,
    R2_COPYPEN     = 0x0000000d,
    R2_MERGEPENNOT = 0x0000000e,
    R2_MERGEPEN    = 0x0000000f,
    R2_WHITE       = 0x00000010,
    R2_LAST        = 0x00000010,
}

alias RGN_COMBINE_MODE = int;
enum : int
{
    RGN_AND  = 0x00000001,
    RGN_OR   = 0x00000002,
    RGN_XOR  = 0x00000003,
    RGN_DIFF = 0x00000004,
    RGN_COPY = 0x00000005,
    RGN_MIN  = 0x00000001,
    RGN_MAX  = 0x00000005,
}

alias ETO_OPTIONS = uint;
enum : uint
{
    ETO_OPAQUE            = 0x00000002,
    ETO_CLIPPED           = 0x00000004,
    ETO_GLYPH_INDEX       = 0x00000010,
    ETO_RTLREADING        = 0x00000080,
    ETO_NUMERICSLOCAL     = 0x00000400,
    ETO_NUMERICSLATIN     = 0x00000800,
    ETO_IGNORELANGUAGE    = 0x00001000,
    ETO_PDY               = 0x00002000,
    ETO_REVERSE_INDEX_MAP = 0x00010000,
}

alias OBJ_TYPE = int;
enum : int
{
    OBJ_PEN         = 0x00000001,
    OBJ_BRUSH       = 0x00000002,
    OBJ_DC          = 0x00000003,
    OBJ_METADC      = 0x00000004,
    OBJ_PAL         = 0x00000005,
    OBJ_FONT        = 0x00000006,
    OBJ_BITMAP      = 0x00000007,
    OBJ_REGION      = 0x00000008,
    OBJ_METAFILE    = 0x00000009,
    OBJ_MEMDC       = 0x0000000a,
    OBJ_EXTPEN      = 0x0000000b,
    OBJ_ENHMETADC   = 0x0000000c,
    OBJ_ENHMETAFILE = 0x0000000d,
    OBJ_COLORSPACE  = 0x0000000e,
}

alias DIB_USAGE = uint;
enum : uint
{
    DIB_RGB_COLORS = 0x00000000,
    DIB_PAL_COLORS = 0x00000001,
}

alias DRAWEDGE_FLAGS = uint;
enum : uint
{
    BDR_RAISEDOUTER = 0x00000001,
    BDR_SUNKENOUTER = 0x00000002,
    BDR_RAISEDINNER = 0x00000004,
    BDR_SUNKENINNER = 0x00000008,
    BDR_OUTER       = 0x00000003,
    BDR_INNER       = 0x0000000c,
    BDR_RAISED      = 0x00000005,
    BDR_SUNKEN      = 0x0000000a,
    EDGE_RAISED     = 0x00000005,
    EDGE_SUNKEN     = 0x0000000a,
    EDGE_ETCHED     = 0x00000006,
    EDGE_BUMP       = 0x00000009,
}

alias DFC_TYPE = uint;
enum : uint
{
    DFC_CAPTION   = 0x00000001,
    DFC_MENU      = 0x00000002,
    DFC_SCROLL    = 0x00000003,
    DFC_BUTTON    = 0x00000004,
    DFC_POPUPMENU = 0x00000005,
}

alias DFCS_STATE = uint;
enum : uint
{
    DFCS_CAPTIONCLOSE        = 0x00000000,
    DFCS_CAPTIONMIN          = 0x00000001,
    DFCS_CAPTIONMAX          = 0x00000002,
    DFCS_CAPTIONRESTORE      = 0x00000003,
    DFCS_CAPTIONHELP         = 0x00000004,
    DFCS_MENUARROW           = 0x00000000,
    DFCS_MENUCHECK           = 0x00000001,
    DFCS_MENUBULLET          = 0x00000002,
    DFCS_MENUARROWRIGHT      = 0x00000004,
    DFCS_SCROLLUP            = 0x00000000,
    DFCS_SCROLLDOWN          = 0x00000001,
    DFCS_SCROLLLEFT          = 0x00000002,
    DFCS_SCROLLRIGHT         = 0x00000003,
    DFCS_SCROLLCOMBOBOX      = 0x00000005,
    DFCS_SCROLLSIZEGRIP      = 0x00000008,
    DFCS_SCROLLSIZEGRIPRIGHT = 0x00000010,
    DFCS_BUTTONCHECK         = 0x00000000,
    DFCS_BUTTONRADIOIMAGE    = 0x00000001,
    DFCS_BUTTONRADIOMASK     = 0x00000002,
    DFCS_BUTTONRADIO         = 0x00000004,
    DFCS_BUTTON3STATE        = 0x00000008,
    DFCS_BUTTONPUSH          = 0x00000010,
    DFCS_INACTIVE            = 0x00000100,
    DFCS_PUSHED              = 0x00000200,
    DFCS_CHECKED             = 0x00000400,
    DFCS_TRANSPARENT         = 0x00000800,
    DFCS_HOT                 = 0x00001000,
    DFCS_ADJUSTRECT          = 0x00002000,
    DFCS_FLAT                = 0x00004000,
    DFCS_MONO                = 0x00008000,
}

alias CDS_TYPE = uint;
enum : uint
{
    CDS_FULLSCREEN           = 0x00000004,
    CDS_GLOBAL               = 0x00000008,
    CDS_NORESET              = 0x10000000,
    CDS_RESET                = 0x40000000,
    CDS_SET_PRIMARY          = 0x00000010,
    CDS_TEST                 = 0x00000002,
    CDS_UPDATEREGISTRY       = 0x00000001,
    CDS_VIDEOPARAMETERS      = 0x00000020,
    CDS_ENABLE_UNSAFE_MODES  = 0x00000100,
    CDS_DISABLE_UNSAFE_MODES = 0x00000200,
    CDS_RESET_EX             = 0x20000000,
}

alias DISP_CHANGE = int;
enum : int
{
    DISP_CHANGE_SUCCESSFUL  = 0x00000000,
    DISP_CHANGE_RESTART     = 0x00000001,
    DISP_CHANGE_FAILED      = 0xffffffff,
    DISP_CHANGE_BADMODE     = 0xfffffffe,
    DISP_CHANGE_NOTUPDATED  = 0xfffffffd,
    DISP_CHANGE_BADFLAGS    = 0xfffffffc,
    DISP_CHANGE_BADPARAM    = 0xfffffffb,
    DISP_CHANGE_BADDUALVIEW = 0xfffffffa,
}

alias DRAWSTATE_FLAGS = uint;
enum : uint
{
    DST_COMPLEX    = 0x00000000,
    DST_TEXT       = 0x00000001,
    DST_PREFIXTEXT = 0x00000002,
    DST_ICON       = 0x00000003,
    DST_BITMAP     = 0x00000004,
    DSS_NORMAL     = 0x00000000,
    DSS_UNION      = 0x00000010,
    DSS_DISABLED   = 0x00000020,
    DSS_MONO       = 0x00000080,
    DSS_HIDEPREFIX = 0x00000200,
    DSS_PREFIXONLY = 0x00000400,
    DSS_RIGHT      = 0x00008000,
}

alias REDRAW_WINDOW_FLAGS = uint;
enum : uint
{
    RDW_INVALIDATE      = 0x00000001,
    RDW_INTERNALPAINT   = 0x00000002,
    RDW_ERASE           = 0x00000004,
    RDW_VALIDATE        = 0x00000008,
    RDW_NOINTERNALPAINT = 0x00000010,
    RDW_NOERASE         = 0x00000020,
    RDW_NOCHILDREN      = 0x00000040,
    RDW_ALLCHILDREN     = 0x00000080,
    RDW_UPDATENOW       = 0x00000100,
    RDW_ERASENOW        = 0x00000200,
    RDW_FRAME           = 0x00000400,
    RDW_NOFRAME         = 0x00000800,
}

alias ENUM_DISPLAY_SETTINGS_MODE = uint;
enum : uint
{
    ENUM_CURRENT_SETTINGS  = 0xffffffff,
    ENUM_REGISTRY_SETTINGS = 0xfffffffe,
}

alias TEXT_ALIGN_OPTIONS = uint;
enum : uint
{
    TA_NOUPDATECP = 0x00000000,
    TA_UPDATECP   = 0x00000001,
    TA_LEFT       = 0x00000000,
    TA_RIGHT      = 0x00000002,
    TA_CENTER     = 0x00000006,
    TA_TOP        = 0x00000000,
    TA_BOTTOM     = 0x00000008,
    TA_BASELINE   = 0x00000018,
    TA_RTLREADING = 0x00000100,
    TA_MASK       = 0x0000011f,
    VTA_BASELINE  = 0x00000018,
    VTA_LEFT      = 0x00000008,
    VTA_RIGHT     = 0x00000000,
    VTA_CENTER    = 0x00000006,
    VTA_BOTTOM    = 0x00000002,
    VTA_TOP       = 0x00000000,
}

alias PEN_STYLE = int;
enum : int
{
    PS_GEOMETRIC     = 0x00010000,
    PS_COSMETIC      = 0x00000000,
    PS_SOLID         = 0x00000000,
    PS_DASH          = 0x00000001,
    PS_DOT           = 0x00000002,
    PS_DASHDOT       = 0x00000003,
    PS_DASHDOTDOT    = 0x00000004,
    PS_NULL          = 0x00000005,
    PS_INSIDEFRAME   = 0x00000006,
    PS_USERSTYLE     = 0x00000007,
    PS_ALTERNATE     = 0x00000008,
    PS_STYLE_MASK    = 0x0000000f,
    PS_ENDCAP_ROUND  = 0x00000000,
    PS_ENDCAP_SQUARE = 0x00000100,
    PS_ENDCAP_FLAT   = 0x00000200,
    PS_ENDCAP_MASK   = 0x00000f00,
    PS_JOIN_ROUND    = 0x00000000,
    PS_JOIN_BEVEL    = 0x00001000,
    PS_JOIN_MITER    = 0x00002000,
    PS_JOIN_MASK     = 0x0000f000,
    PS_TYPE_MASK     = 0x000f0000,
}

alias TTEMBED_FLAGS = uint;
enum : uint
{
    TTEMBED_EMBEDEUDC    = 0x00000020,
    TTEMBED_RAW          = 0x00000000,
    TTEMBED_SUBSET       = 0x00000001,
    TTEMBED_TTCOMPRESSED = 0x00000004,
}

alias DRAW_TEXT_FORMAT = uint;
enum : uint
{
    DT_BOTTOM               = 0x00000008,
    DT_CALCRECT             = 0x00000400,
    DT_CENTER               = 0x00000001,
    DT_EDITCONTROL          = 0x00002000,
    DT_END_ELLIPSIS         = 0x00008000,
    DT_EXPANDTABS           = 0x00000040,
    DT_EXTERNALLEADING      = 0x00000200,
    DT_HIDEPREFIX           = 0x00100000,
    DT_INTERNAL             = 0x00001000,
    DT_LEFT                 = 0x00000000,
    DT_MODIFYSTRING         = 0x00010000,
    DT_NOCLIP               = 0x00000100,
    DT_NOFULLWIDTHCHARBREAK = 0x00080000,
    DT_NOPREFIX             = 0x00000800,
    DT_PATH_ELLIPSIS        = 0x00004000,
    DT_PREFIXONLY           = 0x00200000,
    DT_RIGHT                = 0x00000002,
    DT_RTLREADING           = 0x00020000,
    DT_SINGLELINE           = 0x00000020,
    DT_TABSTOP              = 0x00000080,
    DT_TOP                  = 0x00000000,
    DT_VCENTER              = 0x00000004,
    DT_WORDBREAK            = 0x00000010,
    DT_WORD_ELLIPSIS        = 0x00040000,
}

alias EMBED_FONT_CHARSET = uint;
enum : uint
{
    CHARSET_UNICODE = 0x00000001,
    CHARSET_SYMBOL  = 0x00000002,
}

alias GET_DCX_FLAGS = uint;
enum : uint
{
    DCX_WINDOW           = 0x00000001,
    DCX_CACHE            = 0x00000002,
    DCX_PARENTCLIP       = 0x00000020,
    DCX_CLIPSIBLINGS     = 0x00000010,
    DCX_CLIPCHILDREN     = 0x00000008,
    DCX_NORESETATTRS     = 0x00000004,
    DCX_LOCKWINDOWUPDATE = 0x00000400,
    DCX_EXCLUDERGN       = 0x00000040,
    DCX_INTERSECTRGN     = 0x00000080,
    DCX_INTERSECTUPDATE  = 0x00000200,
    DCX_VALIDATE         = 0x00200000,
}

alias GET_GLYPH_OUTLINE_FORMAT = uint;
enum : uint
{
    GGO_BEZIER       = 0x00000003,
    GGO_BITMAP       = 0x00000001,
    GGO_GLYPH_INDEX  = 0x00000080,
    GGO_GRAY2_BITMAP = 0x00000004,
    GGO_GRAY4_BITMAP = 0x00000005,
    GGO_GRAY8_BITMAP = 0x00000006,
    GGO_METRICS      = 0x00000000,
    GGO_NATIVE       = 0x00000002,
    GGO_UNHINTED     = 0x00000100,
}

alias SET_BOUNDS_RECT_FLAGS = uint;
enum : uint
{
    DCB_ACCUMULATE = 0x00000002,
    DCB_DISABLE    = 0x00000008,
    DCB_ENABLE     = 0x00000004,
    DCB_RESET      = 0x00000001,
}

alias GET_STOCK_OBJECT_FLAGS = int;
enum : int
{
    BLACK_BRUSH         = 0x00000004,
    DKGRAY_BRUSH        = 0x00000003,
    DC_BRUSH            = 0x00000012,
    GRAY_BRUSH          = 0x00000002,
    HOLLOW_BRUSH        = 0x00000005,
    LTGRAY_BRUSH        = 0x00000001,
    NULL_BRUSH          = 0x00000005,
    WHITE_BRUSH         = 0x00000000,
    BLACK_PEN           = 0x00000007,
    DC_PEN              = 0x00000013,
    NULL_PEN            = 0x00000008,
    WHITE_PEN           = 0x00000006,
    ANSI_FIXED_FONT     = 0x0000000b,
    ANSI_VAR_FONT       = 0x0000000c,
    DEVICE_DEFAULT_FONT = 0x0000000e,
    DEFAULT_GUI_FONT    = 0x00000011,
    OEM_FIXED_FONT      = 0x0000000a,
    SYSTEM_FONT         = 0x0000000d,
    SYSTEM_FIXED_FONT   = 0x00000010,
    DEFAULT_PALETTE     = 0x0000000f,
}

alias MODIFY_WORLD_TRANSFORM_MODE = uint;
enum : uint
{
    MWT_IDENTITY      = 0x00000001,
    MWT_LEFTMULTIPLY  = 0x00000002,
    MWT_RIGHTMULTIPLY = 0x00000003,
}

alias FONT_CLIP_PRECISION = ubyte;
enum : ubyte
{
    CLIP_DEFAULT_PRECIS   = cast(ubyte)0x00,
    CLIP_CHARACTER_PRECIS = cast(ubyte)0x01,
    CLIP_STROKE_PRECIS    = cast(ubyte)0x02,
    CLIP_MASK             = cast(ubyte)0x0f,
    CLIP_LH_ANGLES        = cast(ubyte)0x10,
    CLIP_TT_ALWAYS        = cast(ubyte)0x20,
    CLIP_DFA_DISABLE      = cast(ubyte)0x40,
    CLIP_EMBEDDED         = cast(ubyte)0x80,
    CLIP_DFA_OVERRIDE     = cast(ubyte)0x40,
}

alias CREATE_POLYGON_RGN_MODE = int;
enum : int
{
    ALTERNATE = 0x00000001,
    WINDING   = 0x00000002,
}

alias EMBEDDED_FONT_PRIV_STATUS = uint;
enum : uint
{
    EMBED_PREVIEWPRINT = 0x00000001,
    EMBED_EDITABLE     = 0x00000002,
    EMBED_INSTALLABLE  = 0x00000003,
    EMBED_NOEMBEDDING  = 0x00000004,
}

alias MONITOR_FROM_FLAGS = uint;
enum : uint
{
    MONITOR_DEFAULTTONEAREST = 0x00000002,
    MONITOR_DEFAULTTONULL    = 0x00000000,
    MONITOR_DEFAULTTOPRIMARY = 0x00000001,
}

alias FONT_RESOURCE_CHARACTERISTICS = uint;
enum : uint
{
    FR_PRIVATE  = 0x00000010,
    FR_NOT_ENUM = 0x00000020,
}

alias DC_LAYOUT = uint;
enum : uint
{
    LAYOUT_BITMAPORIENTATIONPRESERVED = 0x00000008,
    LAYOUT_RTL                        = 0x00000001,
}

alias GET_DEVICE_CAPS_INDEX = uint;
enum : uint
{
    DRIVERVERSION   = 0x00000000,
    TECHNOLOGY      = 0x00000002,
    HORZSIZE        = 0x00000004,
    VERTSIZE        = 0x00000006,
    HORZRES         = 0x00000008,
    VERTRES         = 0x0000000a,
    BITSPIXEL       = 0x0000000c,
    PLANES          = 0x0000000e,
    NUMBRUSHES      = 0x00000010,
    NUMPENS         = 0x00000012,
    NUMMARKERS      = 0x00000014,
    NUMFONTS        = 0x00000016,
    NUMCOLORS       = 0x00000018,
    PDEVICESIZE     = 0x0000001a,
    CURVECAPS       = 0x0000001c,
    LINECAPS        = 0x0000001e,
    POLYGONALCAPS   = 0x00000020,
    TEXTCAPS        = 0x00000022,
    CLIPCAPS        = 0x00000024,
    RASTERCAPS      = 0x00000026,
    ASPECTX         = 0x00000028,
    ASPECTY         = 0x0000002a,
    ASPECTXY        = 0x0000002c,
    LOGPIXELSX      = 0x00000058,
    LOGPIXELSY      = 0x0000005a,
    SIZEPALETTE     = 0x00000068,
    NUMRESERVED     = 0x0000006a,
    COLORRES        = 0x0000006c,
    PHYSICALWIDTH   = 0x0000006e,
    PHYSICALHEIGHT  = 0x0000006f,
    PHYSICALOFFSETX = 0x00000070,
    PHYSICALOFFSETY = 0x00000071,
    SCALINGFACTORX  = 0x00000072,
    SCALINGFACTORY  = 0x00000073,
    VREFRESH        = 0x00000074,
    DESKTOPVERTRES  = 0x00000075,
    DESKTOPHORZRES  = 0x00000076,
    BLTALIGNMENT    = 0x00000077,
    SHADEBLENDCAPS  = 0x00000078,
    COLORMGMTCAPS   = 0x00000079,
}

alias FONT_OUTPUT_PRECISION = ubyte;
enum : ubyte
{
    OUT_DEFAULT_PRECIS        = cast(ubyte)0x00,
    OUT_STRING_PRECIS         = cast(ubyte)0x01,
    OUT_CHARACTER_PRECIS      = cast(ubyte)0x02,
    OUT_STROKE_PRECIS         = cast(ubyte)0x03,
    OUT_TT_PRECIS             = cast(ubyte)0x04,
    OUT_DEVICE_PRECIS         = cast(ubyte)0x05,
    OUT_RASTER_PRECIS         = cast(ubyte)0x06,
    OUT_TT_ONLY_PRECIS        = cast(ubyte)0x07,
    OUT_OUTLINE_PRECIS        = cast(ubyte)0x08,
    OUT_SCREEN_OUTLINE_PRECIS = cast(ubyte)0x09,
    OUT_PS_ONLY_PRECIS        = cast(ubyte)0x0a,
}

alias FONT_WEIGHT = uint;
enum : uint
{
    FW_DONTCARE   = 0x00000000,
    FW_THIN       = 0x00000064,
    FW_EXTRALIGHT = 0x000000c8,
    FW_LIGHT      = 0x0000012c,
    FW_NORMAL     = 0x00000190,
    FW_MEDIUM     = 0x000001f4,
    FW_SEMIBOLD   = 0x00000258,
    FW_BOLD       = 0x000002bc,
    FW_EXTRABOLD  = 0x00000320,
    FW_HEAVY      = 0x00000384,
    FW_ULTRALIGHT = 0x000000c8,
    FW_REGULAR    = 0x00000190,
    FW_DEMIBOLD   = 0x00000258,
    FW_ULTRABOLD  = 0x00000320,
    FW_BLACK      = 0x00000384,
}

alias FONT_CHARSET = ubyte;
enum : ubyte
{
    ANSI_CHARSET        = cast(ubyte)0x00,
    DEFAULT_CHARSET     = cast(ubyte)0x01,
    SYMBOL_CHARSET      = cast(ubyte)0x02,
    SHIFTJIS_CHARSET    = cast(ubyte)0x80,
    HANGEUL_CHARSET     = cast(ubyte)0x81,
    HANGUL_CHARSET      = cast(ubyte)0x81,
    GB2312_CHARSET      = cast(ubyte)0x86,
    CHINESEBIG5_CHARSET = cast(ubyte)0x88,
    OEM_CHARSET         = cast(ubyte)0xff,
    JOHAB_CHARSET       = cast(ubyte)0x82,
    HEBREW_CHARSET      = cast(ubyte)0xb1,
    ARABIC_CHARSET      = cast(ubyte)0xb2,
    GREEK_CHARSET       = cast(ubyte)0xa1,
    TURKISH_CHARSET     = cast(ubyte)0xa2,
    VIETNAMESE_CHARSET  = cast(ubyte)0xa3,
    THAI_CHARSET        = cast(ubyte)0xde,
    EASTEUROPE_CHARSET  = cast(ubyte)0xee,
    RUSSIAN_CHARSET     = cast(ubyte)0xcc,
    MAC_CHARSET         = cast(ubyte)0x4d,
    BALTIC_CHARSET      = cast(ubyte)0xba,
}

alias ARC_DIRECTION = int;
enum : int
{
    AD_COUNTERCLOCKWISE = 0x00000001,
    AD_CLOCKWISE        = 0x00000002,
}

alias TTLOAD_EMBEDDED_FONT_STATUS = uint;
enum : uint
{
    TTLOAD_FONT_SUBSETTED     = 0x00000001,
    TTLOAD_FONT_IN_SYSSTARTUP = 0x00000002,
}

alias STRETCH_BLT_MODE = int;
enum : int
{
    BLACKONWHITE        = 0x00000001,
    COLORONCOLOR        = 0x00000003,
    HALFTONE            = 0x00000004,
    STRETCH_ANDSCANS    = 0x00000001,
    STRETCH_DELETESCANS = 0x00000003,
    STRETCH_HALFTONE    = 0x00000004,
    STRETCH_ORSCANS     = 0x00000002,
    WHITEONBLACK        = 0x00000002,
}

alias FONT_QUALITY = ubyte;
enum : ubyte
{
    DEFAULT_QUALITY        = cast(ubyte)0x00,
    DRAFT_QUALITY          = cast(ubyte)0x01,
    PROOF_QUALITY          = cast(ubyte)0x02,
    NONANTIALIASED_QUALITY = cast(ubyte)0x03,
    ANTIALIASED_QUALITY    = cast(ubyte)0x04,
    CLEARTYPE_QUALITY      = cast(ubyte)0x05,
}

alias BACKGROUND_MODE = uint;
enum : uint
{
    OPAQUE      = 0x00000002,
    TRANSPARENT = 0x00000001,
}

alias GET_CHARACTER_PLACEMENT_FLAGS = uint;
enum : uint
{
    GCP_CLASSIN         = 0x00080000,
    GCP_DIACRITIC       = 0x00000100,
    GCP_DISPLAYZWG      = 0x00400000,
    GCP_GLYPHSHAPE      = 0x00000010,
    GCP_JUSTIFY         = 0x00010000,
    GCP_KASHIDA         = 0x00000400,
    GCP_LIGATE          = 0x00000020,
    GCP_MAXEXTENT       = 0x00100000,
    GCP_NEUTRALOVERRIDE = 0x02000000,
    GCP_NUMERICOVERRIDE = 0x01000000,
    GCP_NUMERICSLATIN   = 0x04000000,
    GCP_NUMERICSLOCAL   = 0x08000000,
    GCP_REORDER         = 0x00000002,
    GCP_SYMSWAPOFF      = 0x00800000,
    GCP_USEKERNING      = 0x00000008,
}

alias DRAW_EDGE_FLAGS = uint;
enum : uint
{
    BF_ADJUST                  = 0x00002000,
    BF_BOTTOM                  = 0x00000008,
    BF_BOTTOMLEFT              = 0x00000009,
    BF_BOTTOMRIGHT             = 0x0000000c,
    BF_DIAGONAL                = 0x00000010,
    BF_DIAGONAL_ENDBOTTOMLEFT  = 0x00000019,
    BF_DIAGONAL_ENDBOTTOMRIGHT = 0x0000001c,
    BF_DIAGONAL_ENDTOPLEFT     = 0x00000013,
    BF_DIAGONAL_ENDTOPRIGHT    = 0x00000016,
    BF_FLAT                    = 0x00004000,
    BF_LEFT                    = 0x00000001,
    BF_MIDDLE                  = 0x00000800,
    BF_MONO                    = 0x00008000,
    BF_RECT                    = 0x0000000f,
    BF_RIGHT                   = 0x00000004,
    BF_SOFT                    = 0x00001000,
    BF_TOP                     = 0x00000002,
    BF_TOPLEFT                 = 0x00000003,
    BF_TOPRIGHT                = 0x00000006,
}

alias SYS_COLOR_INDEX = int;
enum : int
{
    COLOR_SCROLLBAR               = 0x00000000,
    COLOR_BACKGROUND              = 0x00000001,
    COLOR_ACTIVECAPTION           = 0x00000002,
    COLOR_INACTIVECAPTION         = 0x00000003,
    COLOR_MENU                    = 0x00000004,
    COLOR_WINDOW                  = 0x00000005,
    COLOR_WINDOWFRAME             = 0x00000006,
    COLOR_MENUTEXT                = 0x00000007,
    COLOR_WINDOWTEXT              = 0x00000008,
    COLOR_CAPTIONTEXT             = 0x00000009,
    COLOR_ACTIVEBORDER            = 0x0000000a,
    COLOR_INACTIVEBORDER          = 0x0000000b,
    COLOR_APPWORKSPACE            = 0x0000000c,
    COLOR_HIGHLIGHT               = 0x0000000d,
    COLOR_HIGHLIGHTTEXT           = 0x0000000e,
    COLOR_BTNFACE                 = 0x0000000f,
    COLOR_BTNSHADOW               = 0x00000010,
    COLOR_GRAYTEXT                = 0x00000011,
    COLOR_BTNTEXT                 = 0x00000012,
    COLOR_INACTIVECAPTIONTEXT     = 0x00000013,
    COLOR_BTNHIGHLIGHT            = 0x00000014,
    COLOR_3DDKSHADOW              = 0x00000015,
    COLOR_3DLIGHT                 = 0x00000016,
    COLOR_INFOTEXT                = 0x00000017,
    COLOR_INFOBK                  = 0x00000018,
    COLOR_HOTLIGHT                = 0x0000001a,
    COLOR_GRADIENTACTIVECAPTION   = 0x0000001b,
    COLOR_GRADIENTINACTIVECAPTION = 0x0000001c,
    COLOR_MENUHILIGHT             = 0x0000001d,
    COLOR_MENUBAR                 = 0x0000001e,
    COLOR_DESKTOP                 = 0x00000001,
    COLOR_3DFACE                  = 0x0000000f,
    COLOR_3DSHADOW                = 0x00000010,
    COLOR_3DHIGHLIGHT             = 0x00000014,
    COLOR_3DHILIGHT               = 0x00000014,
    COLOR_BTNHILIGHT              = 0x00000014,
}

alias FONT_LICENSE_PRIVS = uint;
enum : uint
{
    LICENSE_PREVIEWPRINT = 0x00000004,
    LICENSE_EDITABLE     = 0x00000008,
    LICENSE_INSTALLABLE  = 0x00000000,
    LICENSE_NOEMBEDDING  = 0x00000002,
    LICENSE_DEFAULT      = 0x00000000,
}

alias GRADIENT_FILL = uint;
enum : uint
{
    GRADIENT_FILL_RECT_H   = 0x00000000,
    GRADIENT_FILL_RECT_V   = 0x00000001,
    GRADIENT_FILL_TRIANGLE = 0x00000002,
}

alias CREATE_FONT_PACKAGE_SUBSET_ENCODING = short;
enum : short
{
    TTFCFP_STD_MAC_CHAR_SET = cast(short)0x0000,
    TTFCFP_SYMBOL_CHAR_SET  = cast(short)0x0000,
    TTFCFP_UNICODE_CHAR_SET = cast(short)0x0001,
}

alias EXT_FLOOD_FILL_TYPE = uint;
enum : uint
{
    FLOODFILLBORDER  = 0x00000000,
    FLOODFILLSURFACE = 0x00000001,
}

alias HATCH_BRUSH_STYLE = int;
enum : int
{
    HS_BDIAGONAL  = 0x00000003,
    HS_CROSS      = 0x00000004,
    HS_DIAGCROSS  = 0x00000005,
    HS_FDIAGONAL  = 0x00000002,
    HS_HORIZONTAL = 0x00000000,
    HS_VERTICAL   = 0x00000001,
}

alias DRAW_CAPTION_FLAGS = uint;
enum : uint
{
    DC_ACTIVE   = 0x00000001,
    DC_BUTTONS  = 0x00001000,
    DC_GRADIENT = 0x00000020,
    DC_ICON     = 0x00000004,
    DC_INBUTTON = 0x00000010,
    DC_SMALLCAP = 0x00000002,
    DC_TEXT     = 0x00000008,
}

alias SYSTEM_PALETTE_USE = uint;
enum : uint
{
    SYSPAL_NOSTATIC    = 0x00000002,
    SYSPAL_NOSTATIC256 = 0x00000003,
    SYSPAL_STATIC      = 0x00000001,
}

alias GRAPHICS_MODE = int;
enum : int
{
    GM_COMPATIBLE = 0x00000001,
    GM_ADVANCED   = 0x00000002,
}

alias FONT_PITCH = ubyte;
enum : ubyte
{
    DEFAULT_PITCH  = cast(ubyte)0x00,
    FIXED_PITCH    = cast(ubyte)0x01,
    VARIABLE_PITCH = cast(ubyte)0x02,
}

alias FONT_FAMILY = ubyte;
enum : ubyte
{
    FF_DECORATIVE = cast(ubyte)0x50,
    FF_DONTCARE   = cast(ubyte)0x00,
    FF_MODERN     = cast(ubyte)0x30,
    FF_ROMAN      = cast(ubyte)0x10,
    FF_SCRIPT     = cast(ubyte)0x40,
    FF_SWISS      = cast(ubyte)0x20,
}

alias ROP_CODE = uint;
enum : uint
{
    BLACKNESS      = 0x00000042,
    NOTSRCERASE    = 0x001100a6,
    NOTSRCCOPY     = 0x00330008,
    SRCERASE       = 0x00440328,
    DSTINVERT      = 0x00550009,
    PATINVERT      = 0x005a0049,
    SRCINVERT      = 0x00660046,
    SRCAND         = 0x008800c6,
    MERGEPAINT     = 0x00bb0226,
    MERGECOPY      = 0x00c000ca,
    SRCCOPY        = 0x00cc0020,
    SRCPAINT       = 0x00ee0086,
    PATCOPY        = 0x00f00021,
    PATPAINT       = 0x00fb0a09,
    WHITENESS      = 0x00ff0062,
    CAPTUREBLT     = 0x40000000,
    NOMIRRORBITMAP = 0x80000000,
}

alias CREATE_FONT_PACKAGE_SUBSET_PLATFORM = short;
enum : short
{
    TTFCFP_UNICODE_PLATFORMID = cast(short)0x0000,
    TTFCFP_ISO_PLATFORMID     = cast(short)0x0002,
}

alias HDC_MAP_MODE = int;
enum : int
{
    MM_ANISOTROPIC = 0x00000008,
    MM_HIENGLISH   = 0x00000005,
    MM_HIMETRIC    = 0x00000003,
    MM_ISOTROPIC   = 0x00000007,
    MM_LOENGLISH   = 0x00000004,
    MM_LOMETRIC    = 0x00000002,
    MM_TEXT        = 0x00000001,
    MM_TWIPS       = 0x00000006,
}

alias GDI_REGION_TYPE = int;
enum : int
{
    RGN_ERROR     = 0x00000000,
    NULLREGION    = 0x00000001,
    SIMPLEREGION  = 0x00000002,
    COMPLEXREGION = 0x00000003,
}

alias BRUSH_STYLE = uint;
enum : uint
{
    BS_SOLID         = 0x00000000,
    BS_NULL          = 0x00000001,
    BS_HOLLOW        = 0x00000001,
    BS_HATCHED       = 0x00000002,
    BS_PATTERN       = 0x00000003,
    BS_INDEXED       = 0x00000004,
    BS_DIBPATTERN    = 0x00000005,
    BS_DIBPATTERNPT  = 0x00000006,
    BS_PATTERN8X8    = 0x00000007,
    BS_DIBPATTERN8X8 = 0x00000008,
    BS_MONOPATTERN   = 0x00000009,
}

alias TMPF_FLAGS = ubyte;
enum : ubyte
{
    TMPF_FIXED_PITCH = cast(ubyte)0x01,
    TMPF_VECTOR      = cast(ubyte)0x02,
    TMPF_DEVICE      = cast(ubyte)0x08,
    TMPF_TRUETYPE    = cast(ubyte)0x04,
}

alias BI_COMPRESSION = uint;
enum : uint
{
    BI_RGB       = 0x00000000,
    BI_RLE8      = 0x00000001,
    BI_RLE4      = 0x00000002,
    BI_BITFIELDS = 0x00000003,
    BI_JPEG      = 0x00000004,
    BI_PNG       = 0x00000005,
}

alias ENHANCED_METAFILE_RECORD_TYPE = uint;
enum : uint
{
    EMR_HEADER                  = 0x00000001,
    EMR_POLYBEZIER              = 0x00000002,
    EMR_POLYGON                 = 0x00000003,
    EMR_POLYLINE                = 0x00000004,
    EMR_POLYBEZIERTO            = 0x00000005,
    EMR_POLYLINETO              = 0x00000006,
    EMR_POLYPOLYLINE            = 0x00000007,
    EMR_POLYPOLYGON             = 0x00000008,
    EMR_SETWINDOWEXTEX          = 0x00000009,
    EMR_SETWINDOWORGEX          = 0x0000000a,
    EMR_SETVIEWPORTEXTEX        = 0x0000000b,
    EMR_SETVIEWPORTORGEX        = 0x0000000c,
    EMR_SETBRUSHORGEX           = 0x0000000d,
    EMR_EOF                     = 0x0000000e,
    EMR_SETPIXELV               = 0x0000000f,
    EMR_SETMAPPERFLAGS          = 0x00000010,
    EMR_SETMAPMODE              = 0x00000011,
    EMR_SETBKMODE               = 0x00000012,
    EMR_SETPOLYFILLMODE         = 0x00000013,
    EMR_SETROP2                 = 0x00000014,
    EMR_SETSTRETCHBLTMODE       = 0x00000015,
    EMR_SETTEXTALIGN            = 0x00000016,
    EMR_SETCOLORADJUSTMENT      = 0x00000017,
    EMR_SETTEXTCOLOR            = 0x00000018,
    EMR_SETBKCOLOR              = 0x00000019,
    EMR_OFFSETCLIPRGN           = 0x0000001a,
    EMR_MOVETOEX                = 0x0000001b,
    EMR_SETMETARGN              = 0x0000001c,
    EMR_EXCLUDECLIPRECT         = 0x0000001d,
    EMR_INTERSECTCLIPRECT       = 0x0000001e,
    EMR_SCALEVIEWPORTEXTEX      = 0x0000001f,
    EMR_SCALEWINDOWEXTEX        = 0x00000020,
    EMR_SAVEDC                  = 0x00000021,
    EMR_RESTOREDC               = 0x00000022,
    EMR_SETWORLDTRANSFORM       = 0x00000023,
    EMR_MODIFYWORLDTRANSFORM    = 0x00000024,
    EMR_SELECTOBJECT            = 0x00000025,
    EMR_CREATEPEN               = 0x00000026,
    EMR_CREATEBRUSHINDIRECT     = 0x00000027,
    EMR_DELETEOBJECT            = 0x00000028,
    EMR_ANGLEARC                = 0x00000029,
    EMR_ELLIPSE                 = 0x0000002a,
    EMR_RECTANGLE               = 0x0000002b,
    EMR_ROUNDRECT               = 0x0000002c,
    EMR_ARC                     = 0x0000002d,
    EMR_CHORD                   = 0x0000002e,
    EMR_PIE                     = 0x0000002f,
    EMR_SELECTPALETTE           = 0x00000030,
    EMR_CREATEPALETTE           = 0x00000031,
    EMR_SETPALETTEENTRIES       = 0x00000032,
    EMR_RESIZEPALETTE           = 0x00000033,
    EMR_REALIZEPALETTE          = 0x00000034,
    EMR_EXTFLOODFILL            = 0x00000035,
    EMR_LINETO                  = 0x00000036,
    EMR_ARCTO                   = 0x00000037,
    EMR_POLYDRAW                = 0x00000038,
    EMR_SETARCDIRECTION         = 0x00000039,
    EMR_SETMITERLIMIT           = 0x0000003a,
    EMR_BEGINPATH               = 0x0000003b,
    EMR_ENDPATH                 = 0x0000003c,
    EMR_CLOSEFIGURE             = 0x0000003d,
    EMR_FILLPATH                = 0x0000003e,
    EMR_STROKEANDFILLPATH       = 0x0000003f,
    EMR_STROKEPATH              = 0x00000040,
    EMR_FLATTENPATH             = 0x00000041,
    EMR_WIDENPATH               = 0x00000042,
    EMR_SELECTCLIPPATH          = 0x00000043,
    EMR_ABORTPATH               = 0x00000044,
    EMR_GDICOMMENT              = 0x00000046,
    EMR_FILLRGN                 = 0x00000047,
    EMR_FRAMERGN                = 0x00000048,
    EMR_INVERTRGN               = 0x00000049,
    EMR_PAINTRGN                = 0x0000004a,
    EMR_EXTSELECTCLIPRGN        = 0x0000004b,
    EMR_BITBLT                  = 0x0000004c,
    EMR_STRETCHBLT              = 0x0000004d,
    EMR_MASKBLT                 = 0x0000004e,
    EMR_PLGBLT                  = 0x0000004f,
    EMR_SETDIBITSTODEVICE       = 0x00000050,
    EMR_STRETCHDIBITS           = 0x00000051,
    EMR_EXTCREATEFONTINDIRECTW  = 0x00000052,
    EMR_EXTTEXTOUTA             = 0x00000053,
    EMR_EXTTEXTOUTW             = 0x00000054,
    EMR_POLYBEZIER16            = 0x00000055,
    EMR_POLYGON16               = 0x00000056,
    EMR_POLYLINE16              = 0x00000057,
    EMR_POLYBEZIERTO16          = 0x00000058,
    EMR_POLYLINETO16            = 0x00000059,
    EMR_POLYPOLYLINE16          = 0x0000005a,
    EMR_POLYPOLYGON16           = 0x0000005b,
    EMR_POLYDRAW16              = 0x0000005c,
    EMR_CREATEMONOBRUSH         = 0x0000005d,
    EMR_CREATEDIBPATTERNBRUSHPT = 0x0000005e,
    EMR_EXTCREATEPEN            = 0x0000005f,
    EMR_POLYTEXTOUTA            = 0x00000060,
    EMR_POLYTEXTOUTW            = 0x00000061,
    EMR_SETICMMODE              = 0x00000062,
    EMR_CREATECOLORSPACE        = 0x00000063,
    EMR_SETCOLORSPACE           = 0x00000064,
    EMR_DELETECOLORSPACE        = 0x00000065,
    EMR_GLSRECORD               = 0x00000066,
    EMR_GLSBOUNDEDRECORD        = 0x00000067,
    EMR_PIXELFORMAT             = 0x00000068,
    EMR_RESERVED_105            = 0x00000069,
    EMR_RESERVED_106            = 0x0000006a,
    EMR_RESERVED_107            = 0x0000006b,
    EMR_RESERVED_108            = 0x0000006c,
    EMR_RESERVED_109            = 0x0000006d,
    EMR_RESERVED_110            = 0x0000006e,
    EMR_COLORCORRECTPALETTE     = 0x0000006f,
    EMR_SETICMPROFILEA          = 0x00000070,
    EMR_SETICMPROFILEW          = 0x00000071,
    EMR_ALPHABLEND              = 0x00000072,
    EMR_SETLAYOUT               = 0x00000073,
    EMR_TRANSPARENTBLT          = 0x00000074,
    EMR_RESERVED_117            = 0x00000075,
    EMR_GRADIENTFILL            = 0x00000076,
    EMR_RESERVED_119            = 0x00000077,
    EMR_RESERVED_120            = 0x00000078,
    EMR_COLORMATCHTOTARGETW     = 0x00000079,
    EMR_CREATECOLORSPACEW       = 0x0000007a,
    EMR_MIN                     = 0x00000001,
    EMR_MAX                     = 0x0000007a,
}

alias DEVMODE_FIELD_FLAGS = uint;
enum : uint
{
    DM_SPECVERSION        = 0x00000401,
    DM_ORIENTATION        = 0x00000001,
    DM_PAPERSIZE          = 0x00000002,
    DM_PAPERLENGTH        = 0x00000004,
    DM_PAPERWIDTH         = 0x00000008,
    DM_SCALE              = 0x00000010,
    DM_POSITION           = 0x00000020,
    DM_NUP                = 0x00000040,
    DM_DISPLAYORIENTATION = 0x00000080,
    DM_COPIES             = 0x00000100,
    DM_DEFAULTSOURCE      = 0x00000200,
    DM_PRINTQUALITY       = 0x00000400,
    DM_COLOR              = 0x00000800,
    DM_DUPLEX             = 0x00001000,
    DM_YRESOLUTION        = 0x00002000,
    DM_TTOPTION           = 0x00004000,
    DM_COLLATE            = 0x00008000,
    DM_FORMNAME           = 0x00010000,
    DM_LOGPIXELS          = 0x00020000,
    DM_BITSPERPEL         = 0x00040000,
    DM_PELSWIDTH          = 0x00080000,
    DM_PELSHEIGHT         = 0x00100000,
    DM_DISPLAYFLAGS       = 0x00200000,
    DM_DISPLAYFREQUENCY   = 0x00400000,
    DM_ICMMETHOD          = 0x00800000,
    DM_ICMINTENT          = 0x01000000,
    DM_MEDIATYPE          = 0x02000000,
    DM_DITHERTYPE         = 0x04000000,
    DM_PANNINGWIDTH       = 0x08000000,
    DM_PANNINGHEIGHT      = 0x10000000,
    DM_DISPLAYFIXEDOUTPUT = 0x20000000,
    DM_INTERLACED         = 0x00000002,
    DM_UPDATE             = 0x00000001,
    DM_COPY               = 0x00000002,
    DM_PROMPT             = 0x00000004,
    DM_MODIFY             = 0x00000008,
    DM_IN_BUFFER          = 0x00000008,
    DM_IN_PROMPT          = 0x00000004,
    DM_OUT_BUFFER         = 0x00000002,
    DM_OUT_DEFAULT        = 0x00000001,
}

alias DEVMODE_COLOR = short;
enum : short
{
    DMCOLOR_MONOCHROME = cast(short)0x0001,
    DMCOLOR_COLOR      = cast(short)0x0002,
}

alias DEVMODE_DUPLEX = short;
enum : short
{
    DMDUP_SIMPLEX    = cast(short)0x0001,
    DMDUP_VERTICAL   = cast(short)0x0002,
    DMDUP_HORIZONTAL = cast(short)0x0003,
}

alias DEVMODE_COLLATE = short;
enum : short
{
    DMCOLLATE_FALSE = cast(short)0x0000,
    DMCOLLATE_TRUE  = cast(short)0x0001,
}

alias DEVMODE_DISPLAY_ORIENTATION = uint;
enum : uint
{
    DMDO_DEFAULT = 0x00000000,
    DMDO_90      = 0x00000001,
    DMDO_180     = 0x00000002,
    DMDO_270     = 0x00000003,
}

alias DEVMODE_DISPLAY_FIXED_OUTPUT = uint;
enum : uint
{
    DMDFO_DEFAULT = 0x00000000,
    DMDFO_STRETCH = 0x00000001,
    DMDFO_CENTER  = 0x00000002,
}

alias DEVMODE_TRUETYPE_OPTION = short;
enum : short
{
    DMTT_BITMAP           = cast(short)0x0001,
    DMTT_DOWNLOAD         = cast(short)0x0002,
    DMTT_SUBDEV           = cast(short)0x0003,
    DMTT_DOWNLOAD_OUTLINE = cast(short)0x0004,
}

alias PAN_FAMILY_TYPE = ubyte;
enum : ubyte
{
    PAN_FAMILY_ANY          = cast(ubyte)0x00,
    PAN_FAMILY_NO_FIT       = cast(ubyte)0x01,
    PAN_FAMILY_TEXT_DISPLAY = cast(ubyte)0x02,
    PAN_FAMILY_SCRIPT       = cast(ubyte)0x03,
    PAN_FAMILY_DECORATIVE   = cast(ubyte)0x04,
    PAN_FAMILY_PICTORIAL    = cast(ubyte)0x05,
}

alias PAN_SERIF_STYLE = ubyte;
enum : ubyte
{
    PAN_SERIF_ANY                = cast(ubyte)0x00,
    PAN_SERIF_NO_FIT             = cast(ubyte)0x01,
    PAN_SERIF_COVE               = cast(ubyte)0x02,
    PAN_SERIF_OBTUSE_COVE        = cast(ubyte)0x03,
    PAN_SERIF_SQUARE_COVE        = cast(ubyte)0x04,
    PAN_SERIF_OBTUSE_SQUARE_COVE = cast(ubyte)0x05,
    PAN_SERIF_SQUARE             = cast(ubyte)0x06,
    PAN_SERIF_THIN               = cast(ubyte)0x07,
    PAN_SERIF_BONE               = cast(ubyte)0x08,
    PAN_SERIF_EXAGGERATED        = cast(ubyte)0x09,
    PAN_SERIF_TRIANGLE           = cast(ubyte)0x0a,
    PAN_SERIF_NORMAL_SANS        = cast(ubyte)0x0b,
    PAN_SERIF_OBTUSE_SANS        = cast(ubyte)0x0c,
    PAN_SERIF_PERP_SANS          = cast(ubyte)0x0d,
    PAN_SERIF_FLARED             = cast(ubyte)0x0e,
    PAN_SERIF_ROUNDED            = cast(ubyte)0x0f,
}

alias PAN_WEIGHT = ubyte;
enum : ubyte
{
    PAN_WEIGHT_ANY        = cast(ubyte)0x00,
    PAN_WEIGHT_NO_FIT     = cast(ubyte)0x01,
    PAN_WEIGHT_INDEX      = cast(ubyte)0x02,
    PAN_WEIGHT_VERY_LIGHT = cast(ubyte)0x02,
    PAN_WEIGHT_LIGHT      = cast(ubyte)0x03,
    PAN_WEIGHT_THIN       = cast(ubyte)0x04,
    PAN_WEIGHT_BOOK       = cast(ubyte)0x05,
    PAN_WEIGHT_MEDIUM     = cast(ubyte)0x06,
    PAN_WEIGHT_DEMI       = cast(ubyte)0x07,
    PAN_WEIGHT_BOLD       = cast(ubyte)0x08,
    PAN_WEIGHT_HEAVY      = cast(ubyte)0x09,
    PAN_WEIGHT_BLACK      = cast(ubyte)0x0a,
    PAN_WEIGHT_NORD       = cast(ubyte)0x0b,
}

alias PAN_STROKE_VARIATION = ubyte;
enum : ubyte
{
    PAN_STROKE_ANY          = cast(ubyte)0x00,
    PAN_STROKE_NO_FIT       = cast(ubyte)0x01,
    PAN_STROKE_GRADUAL_DIAG = cast(ubyte)0x02,
    PAN_STROKE_GRADUAL_TRAN = cast(ubyte)0x03,
    PAN_STROKE_GRADUAL_VERT = cast(ubyte)0x04,
    PAN_STROKE_GRADUAL_HORZ = cast(ubyte)0x05,
    PAN_STROKE_RAPID_VERT   = cast(ubyte)0x06,
    PAN_STROKE_RAPID_HORZ   = cast(ubyte)0x07,
    PAN_STROKE_INSTANT_VERT = cast(ubyte)0x08,
}

alias PAN_PROPORTION = ubyte;
enum : ubyte
{
    PAN_PROP_ANY            = cast(ubyte)0x00,
    PAN_PROP_NO_FIT         = cast(ubyte)0x01,
    PAN_PROP_OLD_STYLE      = cast(ubyte)0x02,
    PAN_PROP_MODERN         = cast(ubyte)0x03,
    PAN_PROP_EVEN_WIDTH     = cast(ubyte)0x04,
    PAN_PROP_EXPANDED       = cast(ubyte)0x05,
    PAN_PROP_CONDENSED      = cast(ubyte)0x06,
    PAN_PROP_VERY_EXPANDED  = cast(ubyte)0x07,
    PAN_PROP_VERY_CONDENSED = cast(ubyte)0x08,
    PAN_PROP_MONOSPACED     = cast(ubyte)0x09,
}

alias PAN_CONTRAST = ubyte;
enum : ubyte
{
    PAN_CONTRAST_ANY         = cast(ubyte)0x00,
    PAN_CONTRAST_NO_FIT      = cast(ubyte)0x01,
    PAN_CONTRAST_INDEX       = cast(ubyte)0x04,
    PAN_CONTRAST_NONE        = cast(ubyte)0x02,
    PAN_CONTRAST_VERY_LOW    = cast(ubyte)0x03,
    PAN_CONTRAST_LOW         = cast(ubyte)0x04,
    PAN_CONTRAST_MEDIUM_LOW  = cast(ubyte)0x05,
    PAN_CONTRAST_MEDIUM      = cast(ubyte)0x06,
    PAN_CONTRAST_MEDIUM_HIGH = cast(ubyte)0x07,
    PAN_CONTRAST_HIGH        = cast(ubyte)0x08,
    PAN_CONTRAST_VERY_HIGH   = cast(ubyte)0x09,
}

alias PAN_ARM_STYLE = ubyte;
enum : ubyte
{
    PAN_ARM_ANY                    = cast(ubyte)0x00,
    PAN_ARM_NO_FIT                 = cast(ubyte)0x01,
    PAN_STRAIGHT_ARMS_HORZ         = cast(ubyte)0x02,
    PAN_STRAIGHT_ARMS_WEDGE        = cast(ubyte)0x03,
    PAN_STRAIGHT_ARMS_VERT         = cast(ubyte)0x04,
    PAN_STRAIGHT_ARMS_SINGLE_SERIF = cast(ubyte)0x05,
    PAN_STRAIGHT_ARMS_DOUBLE_SERIF = cast(ubyte)0x06,
    PAN_BENT_ARMS_HORZ             = cast(ubyte)0x07,
    PAN_BENT_ARMS_WEDGE            = cast(ubyte)0x08,
    PAN_BENT_ARMS_VERT             = cast(ubyte)0x09,
    PAN_BENT_ARMS_SINGLE_SERIF     = cast(ubyte)0x0a,
    PAN_BENT_ARMS_DOUBLE_SERIF     = cast(ubyte)0x0b,
}

alias PAN_LETT_FORM = ubyte;
enum : ubyte
{
    PAN_LETT_FORM_ANY           = cast(ubyte)0x00,
    PAN_LETT_FORM_NO_FIT        = cast(ubyte)0x01,
    PAN_LETT_NORMAL_CONTACT     = cast(ubyte)0x02,
    PAN_LETT_NORMAL_WEIGHTED    = cast(ubyte)0x03,
    PAN_LETT_NORMAL_BOXED       = cast(ubyte)0x04,
    PAN_LETT_NORMAL_FLATTENED   = cast(ubyte)0x05,
    PAN_LETT_NORMAL_ROUNDED     = cast(ubyte)0x06,
    PAN_LETT_NORMAL_OFF_CENTER  = cast(ubyte)0x07,
    PAN_LETT_NORMAL_SQUARE      = cast(ubyte)0x08,
    PAN_LETT_OBLIQUE_CONTACT    = cast(ubyte)0x09,
    PAN_LETT_OBLIQUE_WEIGHTED   = cast(ubyte)0x0a,
    PAN_LETT_OBLIQUE_BOXED      = cast(ubyte)0x0b,
    PAN_LETT_OBLIQUE_FLATTENED  = cast(ubyte)0x0c,
    PAN_LETT_OBLIQUE_ROUNDED    = cast(ubyte)0x0d,
    PAN_LETT_OBLIQUE_OFF_CENTER = cast(ubyte)0x0e,
    PAN_LETT_OBLIQUE_SQUARE     = cast(ubyte)0x0f,
}

alias PAN_MIDLINE = ubyte;
enum : ubyte
{
    PAN_MIDLINE_ANY              = cast(ubyte)0x00,
    PAN_MIDLINE_NO_FIT           = cast(ubyte)0x01,
    PAN_MIDLINE_INDEX            = cast(ubyte)0x08,
    PAN_MIDLINE_STANDARD_TRIMMED = cast(ubyte)0x02,
    PAN_MIDLINE_STANDARD_POINTED = cast(ubyte)0x03,
    PAN_MIDLINE_STANDARD_SERIFED = cast(ubyte)0x04,
    PAN_MIDLINE_HIGH_TRIMMED     = cast(ubyte)0x05,
    PAN_MIDLINE_HIGH_POINTED     = cast(ubyte)0x06,
    PAN_MIDLINE_HIGH_SERIFED     = cast(ubyte)0x07,
    PAN_MIDLINE_CONSTANT_TRIMMED = cast(ubyte)0x08,
    PAN_MIDLINE_CONSTANT_POINTED = cast(ubyte)0x09,
    PAN_MIDLINE_CONSTANT_SERIFED = cast(ubyte)0x0a,
    PAN_MIDLINE_LOW_TRIMMED      = cast(ubyte)0x0b,
    PAN_MIDLINE_LOW_POINTED      = cast(ubyte)0x0c,
    PAN_MIDLINE_LOW_SERIFED      = cast(ubyte)0x0d,
}

alias PAN_XHEIGHT = ubyte;
enum : ubyte
{
    PAN_XHEIGHT_ANY            = cast(ubyte)0x00,
    PAN_XHEIGHT_NO_FIT         = cast(ubyte)0x01,
    PAN_XHEIGHT_INDEX          = cast(ubyte)0x09,
    PAN_XHEIGHT_CONSTANT_SMALL = cast(ubyte)0x02,
    PAN_XHEIGHT_CONSTANT_STD   = cast(ubyte)0x03,
    PAN_XHEIGHT_CONSTANT_LARGE = cast(ubyte)0x04,
    PAN_XHEIGHT_DUCKING_SMALL  = cast(ubyte)0x05,
    PAN_XHEIGHT_DUCKING_STD    = cast(ubyte)0x06,
    PAN_XHEIGHT_DUCKING_LARGE  = cast(ubyte)0x07,
}

alias ENUM_DISPLAY_SETTINGS_FLAGS = uint;
enum : uint
{
    EDS_RAWMODE     = 0x00000002,
    EDS_ROTATEDMODE = 0x00000004,
}

alias DISPLAY_DEVICE_STATE_FLAGS = uint;
enum : uint
{
    DISPLAY_DEVICE_ATTACHED_TO_DESKTOP = 0x00000001,
    DISPLAY_DEVICE_MULTI_DRIVER        = 0x00000002,
    DISPLAY_DEVICE_PRIMARY_DEVICE      = 0x00000004,
    DISPLAY_DEVICE_MIRRORING_DRIVER    = 0x00000008,
    DISPLAY_DEVICE_VGA_COMPATIBLE      = 0x00000010,
    DISPLAY_DEVICE_REMOVABLE           = 0x00000020,
    DISPLAY_DEVICE_ACC_DRIVER          = 0x00000040,
    DISPLAY_DEVICE_MODESPRUNED         = 0x08000000,
    DISPLAY_DEVICE_RDPUDD              = 0x01000000,
    DISPLAY_DEVICE_REMOTE              = 0x04000000,
    DISPLAY_DEVICE_DISCONNECT          = 0x02000000,
    DISPLAY_DEVICE_TS_COMPATIBLE       = 0x00200000,
    DISPLAY_DEVICE_UNSAFE_MODES_ON     = 0x00080000,
    DISPLAY_DEVICE_ACTIVE              = 0x00000001,
    DISPLAY_DEVICE_ATTACHED            = 0x00000002,
}

alias DISPLAYCONFIG_COLOR_ENCODING = int;
enum : int
{
    DISPLAYCONFIG_COLOR_ENCODING_RGB       = 0x00000000,
    DISPLAYCONFIG_COLOR_ENCODING_YCBCR444  = 0x00000001,
    DISPLAYCONFIG_COLOR_ENCODING_YCBCR422  = 0x00000002,
    DISPLAYCONFIG_COLOR_ENCODING_YCBCR420  = 0x00000003,
    DISPLAYCONFIG_COLOR_ENCODING_INTENSITY = 0x00000004,
}

alias DISPLAYCONFIG_ADVANCED_COLOR_MODE = int;
enum : int
{
    DISPLAYCONFIG_ADVANCED_COLOR_MODE_SDR = 0x00000000,
    DISPLAYCONFIG_ADVANCED_COLOR_MODE_WCG = 0x00000001,
    DISPLAYCONFIG_ADVANCED_COLOR_MODE_HDR = 0x00000002,
}

// Constants


enum int GDI_ERROR = 0xffffffff;
enum uint MAXSTRETCHBLTMODE = 0x00000004;

enum : uint
{
    LAYOUT_BTT = 0x00000002,
    LAYOUT_VBH = 0x00000004,
}

enum : uint
{
    META_SETBKCOLOR      = 0x00000201,
    META_SETBKMODE       = 0x00000102,
    META_SETMAPMODE      = 0x00000103,
    META_SETROP2         = 0x00000104,
    META_SETRELABS       = 0x00000105,
    META_SETPOLYFILLMODE = 0x00000106,
}

enum : uint
{
    META_SETTEXTCHAREXTRA     = 0x00000108,
    META_SETTEXTCOLOR         = 0x00000209,
    META_SETTEXTJUSTIFICATION = 0x0000020a,
}

enum : uint
{
    META_SETWINDOWEXT   = 0x0000020c,
    META_SETVIEWPORTORG = 0x0000020d,
    META_SETVIEWPORTEXT = 0x0000020e,
}

enum uint META_SCALEWINDOWEXT = 0x00000410;
enum uint META_SCALEVIEWPORTEXT = 0x00000412;

enum : uint
{
    META_MOVETO          = 0x00000214,
    META_EXCLUDECLIPRECT = 0x00000415,
}

enum : uint
{
    META_ARC       = 0x00000817,
    META_ELLIPSE   = 0x00000418,
    META_FLOODFILL = 0x00000419,
}

enum : uint
{
    META_RECTANGLE = 0x0000041b,
    META_ROUNDRECT = 0x0000061c,
}

enum : uint
{
    META_SAVEDC   = 0x0000001e,
    META_SETPIXEL = 0x0000041f,
}

enum : uint
{
    META_TEXTOUT    = 0x00000521,
    META_BITBLT     = 0x00000922,
    META_STRETCHBLT = 0x00000b23,
}

enum uint META_POLYLINE = 0x00000325;
enum uint META_RESTOREDC = 0x00000127;
enum uint META_FRAMEREGION = 0x00000429;
enum uint META_PAINTREGION = 0x0000012b;

enum : uint
{
    META_SELECTOBJECT = 0x0000012d,
    META_SETTEXTALIGN = 0x0000012e,
}

enum uint META_SETMAPPERFLAGS = 0x00000231;

enum : uint
{
    META_SETDIBTODEV   = 0x00000d33,
    META_SELECTPALETTE = 0x00000234,
}

enum uint META_ANIMATEPALETTE = 0x00000436;
enum uint META_POLYPOLYGON = 0x00000538;

enum : uint
{
    META_DIBBITBLT             = 0x00000940,
    META_DIBSTRETCHBLT         = 0x00000b41,
    META_DIBCREATEPATTERNBRUSH = 0x00000142,
}

enum uint META_EXTFLOODFILL = 0x00000548;
enum uint META_DELETEOBJECT = 0x000001f0;

enum : uint
{
    META_CREATEPATTERNBRUSH  = 0x000001f9,
    META_CREATEPENINDIRECT   = 0x000002fa,
    META_CREATEFONTINDIRECT  = 0x000002fb,
    META_CREATEBRUSHINDIRECT = 0x000002fc,
    META_CREATEREGION        = 0x000006ff,
}

enum uint ABORTDOC = 0x00000002;
enum uint SETCOLORTABLE = 0x00000004;
enum uint FLUSHOUTPUT = 0x00000006;
enum uint QUERYESCSUPPORT = 0x00000008;
enum uint STARTDOC = 0x0000000a;
enum uint GETPHYSPAGESIZE = 0x0000000c;
enum uint GETSCALINGFACTOR = 0x0000000e;
enum uint GETPENWIDTH = 0x00000010;
enum uint SELECTPAPERSOURCE = 0x00000012;
enum uint PASSTHROUGH = 0x00000013;
enum uint GETTECHNOLOGY = 0x00000014;
enum uint SETLINEJOIN = 0x00000016;
enum uint BANDINFO = 0x00000018;

enum : uint
{
    GETVECTORPENSIZE   = 0x0000001a,
    GETVECTORBRUSHSIZE = 0x0000001b,
}

enum : uint
{
    GETSETPAPERBINS   = 0x0000001d,
    GETSETPRINTORIENT = 0x0000001e,
}

enum uint SETDIBSCALING = 0x00000020;
enum uint ENUMPAPERMETRICS = 0x00000022;

enum : uint
{
    POSTSCRIPT_DATA   = 0x00000025,
    POSTSCRIPT_IGNORE = 0x00000026,
}

enum uint GETDEVICEUNITS = 0x0000002a;
enum uint GETEXTENTTABLE = 0x00000101;
enum uint GETTRACKKERNTABLE = 0x00000103;
enum uint GETFACENAME = 0x00000201;
enum uint ENABLERELATIVEWIDTHS = 0x00000300;
enum uint SETKERNTRACK = 0x00000302;
enum uint SETCHARSET = 0x00000304;
enum uint METAFILE_DRIVER = 0x00000801;
enum uint QUERYDIBSUPPORT = 0x00000c01;
enum uint CLIP_TO_PATH = 0x00001001;
enum uint EXT_DEVICE_CAPS = 0x00001003;
enum uint SAVE_CTM = 0x00001005;
enum uint SET_BACKGROUND_COLOR = 0x00001007;
enum uint SET_SCREEN_ANGLE = 0x00001009;
enum uint TRANSFORM_CTM = 0x0000100b;
enum uint SET_BOUNDS = 0x0000100d;
enum uint OPENCHANNEL = 0x0000100e;
enum uint CLOSECHANNEL = 0x00001010;
enum uint ENCAPSULATED_POSTSCRIPT = 0x00001014;
enum uint POSTSCRIPT_INJECTION = 0x00001016;
enum uint CHECKPNGFORMAT = 0x00001018;

enum : uint
{
    GDIPLUS_TS_QUERYVER = 0x0000101a,
    GDIPLUS_TS_RECORD   = 0x0000101b,
}

enum uint MILCORE_TS_QUERYVER_RESULT_TRUE = 0x7fffffff;

enum : uint
{
    PSIDENT_GDICENTRIC = 0x00000000,
    PSIDENT_PSCENTRIC  = 0x00000001,
}

enum : uint
{
    FEATURESETTING_NUP           = 0x00000000,
    FEATURESETTING_OUTPUT        = 0x00000001,
    FEATURESETTING_PSLEVEL       = 0x00000002,
    FEATURESETTING_CUSTPAPER     = 0x00000003,
    FEATURESETTING_MIRROR        = 0x00000004,
    FEATURESETTING_NEGATIVE      = 0x00000005,
    FEATURESETTING_PROTOCOL      = 0x00000006,
    FEATURESETTING_PRIVATE_BEGIN = 0x00001000,
    FEATURESETTING_PRIVATE_END   = 0x00001fff,
}

enum : uint
{
    PSPROTOCOL_BCP    = 0x00000001,
    PSPROTOCOL_TBCP   = 0x00000002,
    PSPROTOCOL_BINARY = 0x00000003,
}

enum uint QDI_GETDIBITS = 0x00000002;
enum uint QDI_STRETCHDIB = 0x00000008;
enum int SP_ERROR = 0xffffffff;
enum int SP_USERABORT = 0xfffffffd;
enum int SP_OUTOFMEMORY = 0xfffffffb;

enum : int
{
    LCS_GM_BUSINESS         = 0x00000001,
    LCS_GM_GRAPHICS         = 0x00000002,
    LCS_GM_IMAGES           = 0x00000004,
    LCS_GM_ABS_COLORIMETRIC = 0x00000008,
}

enum uint CM_IN_GAMUT = 0x00000000;

enum : int
{
    NTM_BOLD   = 0x00000020,
    NTM_ITALIC = 0x00000001,
}

enum uint NTM_PS_OPENTYPE = 0x00020000;
enum uint NTM_MULTIPLEMASTER = 0x00080000;
enum uint NTM_DSIG = 0x00200000;
enum uint LF_FULLFACESIZE = 0x00000040;
enum uint MONO_FONT = 0x00000008;
enum int FS_LATIN2 = 0x00000002;
enum int FS_GREEK = 0x00000008;
enum int FS_HEBREW = 0x00000020;
enum int FS_BALTIC = 0x00000080;

enum : int
{
    FS_THAI     = 0x00010000,
    FS_JISJAPAN = 0x00020000,
}

enum int FS_WANSUNG = 0x00080000;
enum int FS_JOHAB = 0x00200000;
enum uint PANOSE_COUNT = 0x0000000a;
enum uint PAN_SERIFSTYLE_INDEX = 0x00000001;
enum uint PAN_STROKEVARIATION_INDEX = 0x00000005;
enum uint PAN_LETTERFORM_INDEX = 0x00000007;

enum : uint
{
    PAN_ANY    = 0x00000000,
    PAN_NO_FIT = 0x00000001,
}

enum uint ELF_VERSION = 0x00000000;
enum uint RASTER_FONTTYPE = 0x00000001;
enum uint TRUETYPE_FONTTYPE = 0x00000004;
enum uint PC_EXPLICIT = 0x00000002;
enum uint BKMODE_LAST = 0x00000002;
enum uint PT_CLOSEFIGURE = 0x00000001;
enum uint PT_BEZIERTO = 0x00000004;
enum uint ABSOLUTE = 0x00000001;
enum uint STOCK_LAST = 0x00000013;
enum uint HS_API_MAX = 0x0000000c;

enum : uint
{
    DT_RASDISPLAY = 0x00000001,
    DT_RASPRINTER = 0x00000002,
    DT_RASCAMERA  = 0x00000003,
}

enum uint DT_METAFILE = 0x00000005;

enum : uint
{
    CC_NONE    = 0x00000000,
    CC_CIRCLES = 0x00000001,
}

enum uint CC_CHORD = 0x00000004;

enum : uint
{
    CC_WIDE   = 0x00000010,
    CC_STYLED = 0x00000020,
}

enum uint CC_INTERIORS = 0x00000080;

enum : uint
{
    LC_NONE     = 0x00000000,
    LC_POLYLINE = 0x00000002,
}

enum uint LC_POLYMARKER = 0x00000008;
enum uint LC_STYLED = 0x00000020;
enum uint LC_INTERIORS = 0x00000080;
enum uint PC_POLYGON = 0x00000001;
enum uint PC_WINDPOLYGON = 0x00000004;
enum uint PC_SCANLINE = 0x00000008;
enum uint PC_STYLED = 0x00000020;
enum uint PC_INTERIORS = 0x00000080;
enum uint PC_PATHS = 0x00000200;

enum : uint
{
    CP_RECTANGLE = 0x00000001,
    CP_REGION    = 0x00000002,
}

enum uint TC_OP_STROKE = 0x00000002;

enum : uint
{
    TC_CR_90  = 0x00000008,
    TC_CR_ANY = 0x00000010,
}

enum : uint
{
    TC_SA_DOUBLE  = 0x00000040,
    TC_SA_INTEGER = 0x00000080,
    TC_SA_CONTIN  = 0x00000100,
}

enum uint TC_IA_ABLE = 0x00000400;
enum uint TC_SO_ABLE = 0x00001000;
enum uint TC_VA_ABLE = 0x00004000;
enum uint TC_SCROLLBLT = 0x00010000;
enum uint RC_BANDING = 0x00000002;
enum uint RC_BITMAP64 = 0x00000008;
enum uint RC_GDI20_STATE = 0x00000020;
enum uint RC_DI_BITMAP = 0x00000080;
enum uint RC_DIBTODEV = 0x00000200;
enum uint RC_STRETCHBLT = 0x00000800;
enum uint RC_STRETCHDIB = 0x00002000;
enum uint RC_DEVBITS = 0x00008000;
enum uint SB_CONST_ALPHA = 0x00000001;
enum uint SB_PREMULT_ALPHA = 0x00000004;
enum uint SB_GRAD_TRI = 0x00000020;
enum uint CM_DEVICE_ICM = 0x00000001;
enum uint CM_CMYK_COLOR = 0x00000004;
enum int CBM_INIT = 0x00000004;

enum : uint
{
    DMORIENT_PORTRAIT  = 0x00000001,
    DMORIENT_LANDSCAPE = 0x00000002,
}

enum : uint
{
    DMPAPER_LETTERSMALL  = 0x00000002,
    DMPAPER_TABLOID      = 0x00000003,
    DMPAPER_LEDGER       = 0x00000004,
    DMPAPER_LEGAL        = 0x00000005,
    DMPAPER_STATEMENT    = 0x00000006,
    DMPAPER_EXECUTIVE    = 0x00000007,
    DMPAPER_A3           = 0x00000008,
    DMPAPER_A4           = 0x00000009,
    DMPAPER_A4SMALL      = 0x0000000a,
    DMPAPER_A5           = 0x0000000b,
    DMPAPER_B4           = 0x0000000c,
    DMPAPER_B5           = 0x0000000d,
    DMPAPER_FOLIO        = 0x0000000e,
    DMPAPER_QUARTO       = 0x0000000f,
    DMPAPER_10X14        = 0x00000010,
    DMPAPER_11X17        = 0x00000011,
    DMPAPER_NOTE         = 0x00000012,
    DMPAPER_ENV_9        = 0x00000013,
    DMPAPER_ENV_10       = 0x00000014,
    DMPAPER_ENV_11       = 0x00000015,
    DMPAPER_ENV_12       = 0x00000016,
    DMPAPER_ENV_14       = 0x00000017,
    DMPAPER_CSHEET       = 0x00000018,
    DMPAPER_DSHEET       = 0x00000019,
    DMPAPER_ESHEET       = 0x0000001a,
    DMPAPER_ENV_DL       = 0x0000001b,
    DMPAPER_ENV_C5       = 0x0000001c,
    DMPAPER_ENV_C3       = 0x0000001d,
    DMPAPER_ENV_C4       = 0x0000001e,
    DMPAPER_ENV_C6       = 0x0000001f,
    DMPAPER_ENV_C65      = 0x00000020,
    DMPAPER_ENV_B4       = 0x00000021,
    DMPAPER_ENV_B5       = 0x00000022,
    DMPAPER_ENV_B6       = 0x00000023,
    DMPAPER_ENV_ITALY    = 0x00000024,
    DMPAPER_ENV_MONARCH  = 0x00000025,
    DMPAPER_ENV_PERSONAL = 0x00000026,
}

enum : uint
{
    DMPAPER_FANFOLD_STD_GERMAN = 0x00000028,
    DMPAPER_FANFOLD_LGL_GERMAN = 0x00000029,
}

enum uint DMPAPER_JAPANESE_POSTCARD = 0x0000002b;

enum : uint
{
    DMPAPER_10X11         = 0x0000002d,
    DMPAPER_15X11         = 0x0000002e,
    DMPAPER_ENV_INVITE    = 0x0000002f,
    DMPAPER_RESERVED_48   = 0x00000030,
    DMPAPER_RESERVED_49   = 0x00000031,
    DMPAPER_LETTER_EXTRA  = 0x00000032,
    DMPAPER_LEGAL_EXTRA   = 0x00000033,
    DMPAPER_TABLOID_EXTRA = 0x00000034,
}

enum uint DMPAPER_LETTER_TRANSVERSE = 0x00000036;
enum uint DMPAPER_LETTER_EXTRA_TRANSVERSE = 0x00000038;

enum : uint
{
    DMPAPER_B_PLUS        = 0x0000003a,
    DMPAPER_LETTER_PLUS   = 0x0000003b,
    DMPAPER_A4_PLUS       = 0x0000003c,
    DMPAPER_A5_TRANSVERSE = 0x0000003d,
}

enum : uint
{
    DMPAPER_A3_EXTRA            = 0x0000003f,
    DMPAPER_A5_EXTRA            = 0x00000040,
    DMPAPER_B5_EXTRA            = 0x00000041,
    DMPAPER_A2                  = 0x00000042,
    DMPAPER_A3_TRANSVERSE       = 0x00000043,
    DMPAPER_A3_EXTRA_TRANSVERSE = 0x00000044,
}

enum : uint
{
    DMPAPER_A6             = 0x00000046,
    DMPAPER_JENV_KAKU2     = 0x00000047,
    DMPAPER_JENV_KAKU3     = 0x00000048,
    DMPAPER_JENV_CHOU3     = 0x00000049,
    DMPAPER_JENV_CHOU4     = 0x0000004a,
    DMPAPER_LETTER_ROTATED = 0x0000004b,
}

enum : uint
{
    DMPAPER_A4_ROTATED     = 0x0000004d,
    DMPAPER_A5_ROTATED     = 0x0000004e,
    DMPAPER_B4_JIS_ROTATED = 0x0000004f,
    DMPAPER_B5_JIS_ROTATED = 0x00000050,
}

enum uint DMPAPER_DBL_JAPANESE_POSTCARD_ROTATED = 0x00000052;

enum : uint
{
    DMPAPER_JENV_KAKU2_ROTATED = 0x00000054,
    DMPAPER_JENV_KAKU3_ROTATED = 0x00000055,
    DMPAPER_JENV_CHOU3_ROTATED = 0x00000056,
    DMPAPER_JENV_CHOU4_ROTATED = 0x00000057,
}

enum uint DMPAPER_B6_JIS_ROTATED = 0x00000059;

enum : uint
{
    DMPAPER_JENV_YOU4         = 0x0000005b,
    DMPAPER_JENV_YOU4_ROTATED = 0x0000005c,
}

enum : uint
{
    DMPAPER_P32K            = 0x0000005e,
    DMPAPER_P32KBIG         = 0x0000005f,
    DMPAPER_PENV_1          = 0x00000060,
    DMPAPER_PENV_2          = 0x00000061,
    DMPAPER_PENV_3          = 0x00000062,
    DMPAPER_PENV_4          = 0x00000063,
    DMPAPER_PENV_5          = 0x00000064,
    DMPAPER_PENV_6          = 0x00000065,
    DMPAPER_PENV_7          = 0x00000066,
    DMPAPER_PENV_8          = 0x00000067,
    DMPAPER_PENV_9          = 0x00000068,
    DMPAPER_PENV_10         = 0x00000069,
    DMPAPER_P16K_ROTATED    = 0x0000006a,
    DMPAPER_P32K_ROTATED    = 0x0000006b,
    DMPAPER_P32KBIG_ROTATED = 0x0000006c,
}

enum : uint
{
    DMPAPER_PENV_2_ROTATED  = 0x0000006e,
    DMPAPER_PENV_3_ROTATED  = 0x0000006f,
    DMPAPER_PENV_4_ROTATED  = 0x00000070,
    DMPAPER_PENV_5_ROTATED  = 0x00000071,
    DMPAPER_PENV_6_ROTATED  = 0x00000072,
    DMPAPER_PENV_7_ROTATED  = 0x00000073,
    DMPAPER_PENV_8_ROTATED  = 0x00000074,
    DMPAPER_PENV_9_ROTATED  = 0x00000075,
    DMPAPER_PENV_10_ROTATED = 0x00000076,
}

enum uint DMPAPER_USER = 0x00000100;

enum : uint
{
    DMBIN_ONLYONE   = 0x00000001,
    DMBIN_LOWER     = 0x00000002,
    DMBIN_MIDDLE    = 0x00000003,
    DMBIN_MANUAL    = 0x00000004,
    DMBIN_ENVELOPE  = 0x00000005,
    DMBIN_ENVMANUAL = 0x00000006,
}

enum : uint
{
    DMBIN_TRACTOR       = 0x00000008,
    DMBIN_SMALLFMT      = 0x00000009,
    DMBIN_LARGEFMT      = 0x0000000a,
    DMBIN_LARGECAPACITY = 0x0000000b,
}

enum uint DMBIN_FORMSOURCE = 0x0000000f;
enum uint DMBIN_USER = 0x00000100;

enum : int
{
    DMRES_LOW    = 0xfffffffe,
    DMRES_MEDIUM = 0xfffffffd,
    DMRES_HIGH   = 0xfffffffc,
}

enum : uint
{
    DMNUP_SYSTEM = 0x00000001,
    DMNUP_ONEUP  = 0x00000002,
}

enum : uint
{
    DMICMMETHOD_SYSTEM = 0x00000002,
    DMICMMETHOD_DRIVER = 0x00000003,
    DMICMMETHOD_DEVICE = 0x00000004,
    DMICMMETHOD_USER   = 0x00000100,
}

enum : uint
{
    DMICM_CONTRAST     = 0x00000002,
    DMICM_COLORIMETRIC = 0x00000003,
}

enum uint DMICM_USER = 0x00000100;
enum uint DMMEDIA_TRANSPARENCY = 0x00000002;
enum uint DMMEDIA_USER = 0x00000100;

enum : uint
{
    DMDITHER_COARSE         = 0x00000002,
    DMDITHER_FINE           = 0x00000003,
    DMDITHER_LINEART        = 0x00000004,
    DMDITHER_ERRORDIFFUSION = 0x00000005,
}

enum : uint
{
    DMDITHER_RESERVED7 = 0x00000007,
    DMDITHER_RESERVED8 = 0x00000008,
    DMDITHER_RESERVED9 = 0x00000009,
    DMDITHER_GRAYSCALE = 0x0000000a,
    DMDITHER_USER      = 0x00000100,
}

enum : uint
{
    DISPLAYCONFIG_PATH_MODE_IDX_INVALID          = 0xffffffff,
    DISPLAYCONFIG_PATH_TARGET_MODE_IDX_INVALID   = 0x0000ffff,
    DISPLAYCONFIG_PATH_DESKTOP_IMAGE_IDX_INVALID = 0x0000ffff,
    DISPLAYCONFIG_PATH_SOURCE_MODE_IDX_INVALID   = 0x0000ffff,
    DISPLAYCONFIG_PATH_CLONE_GROUP_INVALID       = 0x0000ffff,
}

enum : uint
{
    DISPLAYCONFIG_TARGET_IN_USE                     = 0x00000001,
    DISPLAYCONFIG_TARGET_FORCIBLE                   = 0x00000002,
    DISPLAYCONFIG_TARGET_FORCED_AVAILABILITY_BOOT   = 0x00000004,
    DISPLAYCONFIG_TARGET_FORCED_AVAILABILITY_PATH   = 0x00000008,
    DISPLAYCONFIG_TARGET_FORCED_AVAILABILITY_SYSTEM = 0x00000010,
    DISPLAYCONFIG_TARGET_IS_HMD                     = 0x00000020,
    DISPLAYCONFIG_PATH_ACTIVE                       = 0x00000001,
    DISPLAYCONFIG_PATH_PREFERRED_UNSCALED           = 0x00000004,
    DISPLAYCONFIG_PATH_SUPPORT_VIRTUAL_MODE         = 0x00000008,
    DISPLAYCONFIG_PATH_BOOST_REFRESH_RATE           = 0x00000010,
    DISPLAYCONFIG_PATH_VALID_FLAGS                  = 0x0000001d,
}

enum uint SYSRGN = 0x00000004;

enum : uint
{
    TT_PRIM_LINE    = 0x00000001,
    TT_PRIM_QSPLINE = 0x00000002,
    TT_PRIM_CSPLINE = 0x00000003,
}

enum uint GCP_ERROR = 0x00008000;
enum int FLI_GLYPHS = 0x00040000;

enum : uint
{
    GCPCLASS_LATIN                  = 0x00000001,
    GCPCLASS_HEBREW                 = 0x00000002,
    GCPCLASS_ARABIC                 = 0x00000002,
    GCPCLASS_NEUTRAL                = 0x00000003,
    GCPCLASS_LOCALNUMBER            = 0x00000004,
    GCPCLASS_LATINNUMBER            = 0x00000005,
    GCPCLASS_LATINNUMERICTERMINATOR = 0x00000006,
    GCPCLASS_LATINNUMERICSEPARATOR  = 0x00000007,
}

enum : uint
{
    GCPCLASS_PREBOUNDLTR  = 0x00000080,
    GCPCLASS_PREBOUNDRTL  = 0x00000040,
    GCPCLASS_POSTBOUNDLTR = 0x00000020,
    GCPCLASS_POSTBOUNDRTL = 0x00000010,
}

enum uint GCPGLYPH_LINKAFTER = 0x00004000;
enum uint TT_ENABLED = 0x00000002;
enum uint DC_EMF_COMPLIANT = 0x00000014;
enum uint DC_MANUFACTURER = 0x00000017;

enum : uint
{
    PRINTRATEUNIT_PPM = 0x00000001,
    PRINTRATEUNIT_CPS = 0x00000002,
    PRINTRATEUNIT_LPM = 0x00000003,
    PRINTRATEUNIT_IPM = 0x00000004,
}

enum int DCTT_DOWNLOAD = 0x00000002;
enum int DCTT_DOWNLOAD_OUTLINE = 0x00000008;

enum : uint
{
    DCBA_FACEUPCENTER   = 0x00000001,
    DCBA_FACEUPLEFT     = 0x00000002,
    DCBA_FACEUPRIGHT    = 0x00000003,
    DCBA_FACEDOWNNONE   = 0x00000100,
    DCBA_FACEDOWNCENTER = 0x00000101,
    DCBA_FACEDOWNLEFT   = 0x00000102,
    DCBA_FACEDOWNRIGHT  = 0x00000103,
}

enum uint GGI_MARK_NONEXISTING_GLYPHS = 0x00000001;
enum uint MM_MAX_AXES_NAMELEN = 0x00000010;

enum : uint
{
    AC_SRC_OVER  = 0x00000000,
    AC_SRC_ALPHA = 0x00000001,
}

enum uint CA_NEGATIVE = 0x00000001;

enum : uint
{
    ILLUMINANT_DEVICE_DEFAULT = 0x00000000,
    ILLUMINANT_A              = 0x00000001,
    ILLUMINANT_B              = 0x00000002,
    ILLUMINANT_C              = 0x00000003,
    ILLUMINANT_D50            = 0x00000004,
    ILLUMINANT_D55            = 0x00000005,
    ILLUMINANT_D65            = 0x00000006,
    ILLUMINANT_D75            = 0x00000007,
    ILLUMINANT_F2             = 0x00000008,
    ILLUMINANT_MAX_INDEX      = 0x00000008,
    ILLUMINANT_TUNGSTEN       = 0x00000001,
    ILLUMINANT_DAYLIGHT       = 0x00000003,
    ILLUMINANT_FLUORESCENT    = 0x00000008,
    ILLUMINANT_NTSC           = 0x00000003,
}

enum uint DI_ROPS_READ_DESTINATION = 0x00000002;

enum : uint
{
    ENHMETA_SIGNATURE    = 0x464d4520,
    ENHMETA_STOCK_OBJECT = 0x80000000,
}

enum uint CREATECOLORSPACE_EMBEDED = 0x00000001;

enum : uint
{
    GDICOMMENT_IDENTIFIER       = 0x43494447,
    GDICOMMENT_WINDOWS_METAFILE = 0x80000001,
    GDICOMMENT_BEGINGROUP       = 0x00000002,
    GDICOMMENT_ENDGROUP         = 0x00000003,
    GDICOMMENT_MULTIFORMATS     = 0x40000004,
}

enum : uint
{
    GDICOMMENT_UNICODE_STRING = 0x00000040,
    GDICOMMENT_UNICODE_END    = 0x00000080,
}

enum uint WGL_FONT_POLYGONS = 0x00000001;

enum : uint
{
    LPD_STEREO         = 0x00000002,
    LPD_SUPPORT_GDI    = 0x00000010,
    LPD_SUPPORT_OPENGL = 0x00000020,
}

enum : uint
{
    LPD_SHARE_STENCIL = 0x00000080,
    LPD_SHARE_ACCUM   = 0x00000100,
}

enum uint LPD_SWAP_COPY = 0x00000400;

enum : uint
{
    LPD_TYPE_RGBA       = 0x00000000,
    LPD_TYPE_COLORINDEX = 0x00000001,
}

enum : uint
{
    WGL_SWAP_OVERLAY1    = 0x00000002,
    WGL_SWAP_OVERLAY2    = 0x00000004,
    WGL_SWAP_OVERLAY3    = 0x00000008,
    WGL_SWAP_OVERLAY4    = 0x00000010,
    WGL_SWAP_OVERLAY5    = 0x00000020,
    WGL_SWAP_OVERLAY6    = 0x00000040,
    WGL_SWAP_OVERLAY7    = 0x00000080,
    WGL_SWAP_OVERLAY8    = 0x00000100,
    WGL_SWAP_OVERLAY9    = 0x00000200,
    WGL_SWAP_OVERLAY10   = 0x00000400,
    WGL_SWAP_OVERLAY11   = 0x00000800,
    WGL_SWAP_OVERLAY12   = 0x00001000,
    WGL_SWAP_OVERLAY13   = 0x00002000,
    WGL_SWAP_OVERLAY14   = 0x00004000,
    WGL_SWAP_OVERLAY15   = 0x00008000,
    WGL_SWAP_UNDERLAY1   = 0x00010000,
    WGL_SWAP_UNDERLAY2   = 0x00020000,
    WGL_SWAP_UNDERLAY3   = 0x00040000,
    WGL_SWAP_UNDERLAY4   = 0x00080000,
    WGL_SWAP_UNDERLAY5   = 0x00100000,
    WGL_SWAP_UNDERLAY6   = 0x00200000,
    WGL_SWAP_UNDERLAY7   = 0x00400000,
    WGL_SWAP_UNDERLAY8   = 0x00800000,
    WGL_SWAP_UNDERLAY9   = 0x01000000,
    WGL_SWAP_UNDERLAY10  = 0x02000000,
    WGL_SWAP_UNDERLAY11  = 0x04000000,
    WGL_SWAP_UNDERLAY12  = 0x08000000,
    WGL_SWAP_UNDERLAY13  = 0x10000000,
    WGL_SWAP_UNDERLAY14  = 0x20000000,
    WGL_SWAP_UNDERLAY15  = 0x40000000,
    WGL_SWAPMULTIPLE_MAX = 0x00000010,
}

enum uint QUERYROPSUPPORT = 0x00000028;
enum uint SC_SCREENSAVE = 0x0000f140;

enum : uint
{
    TTFCFP_SUBSET1          = 0x00000001,
    TTFCFP_DELTA            = 0x00000002,
    TTFCFP_APPLE_PLATFORMID = 0x00000001,
}

enum : uint
{
    TTFCFP_DONT_CARE     = 0x0000ffff,
    TTFCFP_LANG_KEEP_ALL = 0x00000000,
}

enum : uint
{
    TTFCFP_FLAGS_COMPRESS  = 0x00000002,
    TTFCFP_FLAGS_TTC       = 0x00000004,
    TTFCFP_FLAGS_GLYPHLIST = 0x00000008,
}

enum : uint
{
    TTFMFP_SUBSET1 = 0x00000001,
    TTFMFP_DELTA   = 0x00000002,
}

enum uint ERR_READOUTOFBOUNDS = 0x000003e9;
enum uint ERR_READCONTROL = 0x000003eb;

enum : uint
{
    ERR_MEM    = 0x000003ed,
    ERR_FORMAT = 0x000003ee,
}

enum uint ERR_VERSION = 0x000003f0;

enum : uint
{
    ERR_INVALID_MERGE_FORMATS   = 0x000003f2,
    ERR_INVALID_MERGE_CHECKSUMS = 0x000003f3,
    ERR_INVALID_MERGE_NUMGLYPHS = 0x000003f4,
    ERR_INVALID_DELTA_FORMAT    = 0x000003f5,
}

enum uint ERR_INVALID_TTC_INDEX = 0x000003f7;

enum : uint
{
    ERR_MISSING_GLYF         = 0x00000407,
    ERR_MISSING_HEAD         = 0x00000408,
    ERR_MISSING_HHEA         = 0x00000409,
    ERR_MISSING_HMTX         = 0x0000040a,
    ERR_MISSING_LOCA         = 0x0000040b,
    ERR_MISSING_MAXP         = 0x0000040c,
    ERR_MISSING_NAME         = 0x0000040d,
    ERR_MISSING_POST         = 0x0000040e,
    ERR_MISSING_OS2          = 0x0000040f,
    ERR_MISSING_VHEA         = 0x00000410,
    ERR_MISSING_VMTX         = 0x00000411,
    ERR_MISSING_HHEA_OR_VHEA = 0x00000412,
    ERR_MISSING_HMTX_OR_VMTX = 0x00000413,
    ERR_MISSING_EBDT         = 0x00000414,
}

enum : uint
{
    ERR_INVALID_GLYF         = 0x00000425,
    ERR_INVALID_HEAD         = 0x00000426,
    ERR_INVALID_HHEA         = 0x00000427,
    ERR_INVALID_HMTX         = 0x00000428,
    ERR_INVALID_LOCA         = 0x00000429,
    ERR_INVALID_MAXP         = 0x0000042a,
    ERR_INVALID_NAME         = 0x0000042b,
    ERR_INVALID_POST         = 0x0000042c,
    ERR_INVALID_OS2          = 0x0000042d,
    ERR_INVALID_VHEA         = 0x0000042e,
    ERR_INVALID_VMTX         = 0x0000042f,
    ERR_INVALID_HHEA_OR_VHEA = 0x00000430,
    ERR_INVALID_HMTX_OR_VMTX = 0x00000431,
    ERR_INVALID_TTO          = 0x00000438,
    ERR_INVALID_GSUB         = 0x00000439,
    ERR_INVALID_GPOS         = 0x0000043a,
    ERR_INVALID_GDEF         = 0x0000043b,
    ERR_INVALID_JSTF         = 0x0000043c,
    ERR_INVALID_BASE         = 0x0000043d,
    ERR_INVALID_EBLC         = 0x0000043e,
    ERR_INVALID_LTSH         = 0x0000043f,
    ERR_INVALID_VDMX         = 0x00000440,
    ERR_INVALID_HDMX         = 0x00000441,
}

enum : uint
{
    ERR_PARAMETER1  = 0x0000044d,
    ERR_PARAMETER2  = 0x0000044e,
    ERR_PARAMETER3  = 0x0000044f,
    ERR_PARAMETER4  = 0x00000450,
    ERR_PARAMETER5  = 0x00000451,
    ERR_PARAMETER6  = 0x00000452,
    ERR_PARAMETER7  = 0x00000453,
    ERR_PARAMETER8  = 0x00000454,
    ERR_PARAMETER9  = 0x00000455,
    ERR_PARAMETER10 = 0x00000456,
    ERR_PARAMETER11 = 0x00000457,
    ERR_PARAMETER12 = 0x00000458,
    ERR_PARAMETER13 = 0x00000459,
    ERR_PARAMETER14 = 0x0000045a,
    ERR_PARAMETER15 = 0x0000045b,
    ERR_PARAMETER16 = 0x0000045c,
}

enum uint CHARSET_GLYPHIDX = 0x00000003;

enum : uint
{
    TTEMBED_WEBOBJECT      = 0x00000080,
    TTEMBED_XORENCRYPTDATA = 0x10000000,
}

enum uint TTEMBED_EUDCEMBEDDED = 0x00000002;

enum : uint
{
    TTLOAD_PRIVATE        = 0x00000001,
    TTLOAD_EUDC_OVERWRITE = 0x00000002,
    TTLOAD_EUDC_SET       = 0x00000004,
}

enum int E_NONE = 0x00000000;

enum : int
{
    E_CHARCODECOUNTINVALID = 0x00000002,
    E_CHARCODESETINVALID   = 0x00000003,
}

enum int E_HDCINVALID = 0x00000006;
enum int E_FONTREFERENCEINVALID = 0x00000008;

enum : int
{
    E_ERRORACCESSINGFONTDATA = 0x0000000c,
    E_ERRORACCESSINGFACENAME = 0x0000000d,
}

enum int E_ERRORCONVERTINGCHARS = 0x00000012;
enum int E_RESERVEDPARAMNOTNULL = 0x00000014;
enum int E_FILE_NOT_FOUND = 0x00000017;
enum int E_INPUTPARAMINVALID = 0x00000019;
enum int E_FONTDATAINVALID = 0x00000102;
enum int E_FONTNOTEMBEDDABLE = 0x00000104;
enum int E_SUBSETTINGFAILED = 0x00000106;
enum int E_SAVETOSTREAMFAILED = 0x00000108;
enum int E_T2NOFREEMEMORY = 0x0000010a;
enum int E_FLAGSINVALID = 0x0000010c;
enum int E_FONTALREADYEXISTS = 0x0000010e;
enum int E_FONTINSTALLFAILED = 0x00000110;
enum int E_ERRORACCESSINGEXCLUDELIST = 0x00000112;
enum int E_STREAMINVALID = 0x00000114;
enum int E_PRIVSTATUSINVALID = 0x00000116;
enum int E_PBENABLEDINVALID = 0x00000118;
enum int E_SUBSTRING_TEST_FAIL = 0x0000011a;
enum int E_FONTFAMILYNAMENOTINFULL = 0x0000011d;
enum int E_COULDNTCREATETEMPFILE = 0x00000201;
enum int E_WINDOWSAPI = 0x00000204;
enum int E_RESOURCEFILECREATEFAILED = 0x00000206;
enum int E_ERRORGETTINGDC = 0x00000208;
enum int E_EXCEPTIONINCOMPRESSION = 0x0000020a;

// Callbacks

//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias FONTENUMPROCA = int function(const(LOGFONTA)* param0, const(TEXTMETRICA)* param1, uint param2, LPARAM param3);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias FONTENUMPROCW = int function(const(LOGFONTW)* param0, const(TEXTMETRICW)* param1, uint param2, LPARAM param3);
alias GOBJENUMPROC = int function(void* param0, LPARAM param1);
alias LINEDDAPROC = void function(int param0, int param1, LPARAM param2);
alias LPFNDEVMODE = uint function(HWND param0, HMODULE param1, DEVMODEA* param2, PSTR param3, PSTR param4, 
                                  DEVMODEA* param5, PSTR param6, uint param7);
alias LPFNDEVCAPS = uint function(PSTR param0, PSTR param1, uint param2, PSTR param3, DEVMODEA* param4);
alias MFENUMPROC = int function(HDC hdc, HANDLETABLE* lpht, METARECORD* lpMR, int nObj, LPARAM param4);
alias ENHMFENUMPROC = int function(HDC hdc, HANDLETABLE* lpht, const(ENHMETARECORD)* lpmr, int nHandles, 
                                   LPARAM data);
alias CFP_ALLOCPROC = void* function(size_t param0);
alias CFP_REALLOCPROC = void* function(void* param0, size_t param1);
alias CFP_FREEPROC = void function(void* param0);
alias READEMBEDPROC = uint function(void* param0, void* param1, const(uint) param2);
alias WRITEEMBEDPROC = uint function(void* param0, const(void)* param1, const(uint) param2);
alias GRAYSTRINGPROC = BOOL function(HDC param0, LPARAM param1, int param2);
alias DRAWSTATEPROC = BOOL function(HDC hdc, LPARAM lData, WPARAM wData, int cx, int cy);
alias MONITORENUMPROC = BOOL function(HMONITOR param0, HDC param1, RECT* param2, LPARAM param3);

// Structs


//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-monitorinfoexa))], [])
struct MONITORINFOEXA
{
    MONITORINFO monitorInfo;
    CHAR[32]    szDevice;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-monitorinfoexw))], [])
struct MONITORINFOEXW
{
    MONITORINFO monitorInfo;
    wchar[32]   szDevice;
}

@RAIIFree!DeleteObject
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HGDIOBJ))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HBITMAP
{
    void* Value;
}

@RAIIFree!DeleteObject
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HGDIOBJ))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HRGN
{
    void* Value;
}

@RAIIFree!DeleteObject
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HGDIOBJ))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HPEN
{
    void* Value;
}

@RAIIFree!DeleteObject
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HGDIOBJ))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HBRUSH
{
    void* Value;
}

@RAIIFree!DeleteObject
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HGDIOBJ))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HFONT
{
    void* Value;
}

@RAIIFree!DeleteMetaFile
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMETAFILE
{
    void* Value;
}

@RAIIFree!DeleteEnhMetaFile
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HENHMETAFILE
{
    void* Value;
}

@RAIIFree!DeleteObject
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HGDIOBJ))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HPALETTE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDC
{
    void* Value;
}

@RAIIFree!DeleteObject
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HGDIOBJ
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMONITOR
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-xform))], [])
struct XFORM
{
    float eM11;
    float eM12;
    float eM21;
    float eM22;
    float eDx;
    float eDy;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-bitmap))], [])
struct BITMAP
{
    int    bmType;
    int    bmWidth;
    int    bmHeight;
    int    bmWidthBytes;
    ushort bmPlanes;
    ushort bmBitsPixel;
    void*  bmBits;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-rgbtriple))], [])
struct RGBTRIPLE
{
    ubyte rgbtBlue;
    ubyte rgbtGreen;
    ubyte rgbtRed;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-rgbquad))], [])
struct RGBQUAD
{
    ubyte rgbBlue;
    ubyte rgbGreen;
    ubyte rgbRed;
    ubyte rgbReserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-ciexyz))], [])
struct CIEXYZ
{
    int ciexyzX;
    int ciexyzY;
    int ciexyzZ;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-ciexyztriple))], [])
struct CIEXYZTRIPLE
{
    CIEXYZ ciexyzRed;
    CIEXYZ ciexyzGreen;
    CIEXYZ ciexyzBlue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-bitmapcoreheader))], [])
struct BITMAPCOREHEADER
{
    uint   bcSize;
    ushort bcWidth;
    ushort bcHeight;
    ushort bcPlanes;
    ushort bcBitCount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader))], [])
struct BITMAPINFOHEADER
{
    uint   biSize;
    int    biWidth;
    int    biHeight;
    ushort biPlanes;
    ushort biBitCount;
    uint   biCompression;
    uint   biSizeImage;
    int    biXPelsPerMeter;
    int    biYPelsPerMeter;
    uint   biClrUsed;
    uint   biClrImportant;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-bitmapv4header))], [])
struct BITMAPV4HEADER
{
    uint           bV4Size;
    int            bV4Width;
    int            bV4Height;
    ushort         bV4Planes;
    ushort         bV4BitCount;
    BI_COMPRESSION bV4V4Compression;
    uint           bV4SizeImage;
    int            bV4XPelsPerMeter;
    int            bV4YPelsPerMeter;
    uint           bV4ClrUsed;
    uint           bV4ClrImportant;
    uint           bV4RedMask;
    uint           bV4GreenMask;
    uint           bV4BlueMask;
    uint           bV4AlphaMask;
    uint           bV4CSType;
    CIEXYZTRIPLE   bV4Endpoints;
    uint           bV4GammaRed;
    uint           bV4GammaGreen;
    uint           bV4GammaBlue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-bitmapv5header))], [])
struct BITMAPV5HEADER
{
    uint           bV5Size;
    int            bV5Width;
    int            bV5Height;
    ushort         bV5Planes;
    ushort         bV5BitCount;
    BI_COMPRESSION bV5Compression;
    uint           bV5SizeImage;
    int            bV5XPelsPerMeter;
    int            bV5YPelsPerMeter;
    uint           bV5ClrUsed;
    uint           bV5ClrImportant;
    uint           bV5RedMask;
    uint           bV5GreenMask;
    uint           bV5BlueMask;
    uint           bV5AlphaMask;
    uint           bV5CSType;
    CIEXYZTRIPLE   bV5Endpoints;
    uint           bV5GammaRed;
    uint           bV5GammaGreen;
    uint           bV5GammaBlue;
    uint           bV5Intent;
    uint           bV5ProfileData;
    uint           bV5ProfileSize;
    uint           bV5Reserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-bitmapinfo))], [])
struct BITMAPINFO
{
    BITMAPINFOHEADER bmiHeader;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/RGBQUAD[1] bmiColors;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-bitmapcoreinfo))], [])
struct BITMAPCOREINFO
{
    BITMAPCOREHEADER bmciHeader;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/RGBTRIPLE[1] bmciColors;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-bitmapfileheader))], [])
struct BITMAPFILEHEADER
{
align (2):
    ushort bfType;
    uint   bfSize;
    ushort bfReserved1;
    ushort bfReserved2;
    uint   bfOffBits;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-handletable))], [])
struct HANDLETABLE
{
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/HGDIOBJ[1] objectHandle;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-metarecord))], [])
struct METARECORD
{
    uint   rdSize;
    ushort rdFunction;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ushort[1] rdParm;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-metaheader))], [])
struct METAHEADER
{
align (2):
    ushort mtType;
    ushort mtHeaderSize;
    ushort mtVersion;
    uint   mtSize;
    ushort mtNoObjects;
    uint   mtMaxRecord;
    ushort mtNoParameters;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enhmetarecord))], [])
struct ENHMETARECORD
{
    ENHANCED_METAFILE_RECORD_TYPE iType;
    uint nSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] dParm;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enhmetaheader))], [])
struct ENHMETAHEADER
{
    uint   iType;
    uint   nSize;
    RECTL  rclBounds;
    RECTL  rclFrame;
    uint   dSignature;
    uint   nVersion;
    uint   nBytes;
    uint   nRecords;
    ushort nHandles;
    ushort sReserved;
    uint   nDescription;
    uint   offDescription;
    uint   nPalEntries;
    SIZE   szlDevice;
    SIZE   szlMillimeters;
    uint   cbPixelFormat;
    uint   offPixelFormat;
    uint   bOpenGL;
    SIZE   szlMicrometers;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-textmetrica))], [])
struct TEXTMETRICA
{
    int        tmHeight;
    int        tmAscent;
    int        tmDescent;
    int        tmInternalLeading;
    int        tmExternalLeading;
    int        tmAveCharWidth;
    int        tmMaxCharWidth;
    int        tmWeight;
    int        tmOverhang;
    int        tmDigitizedAspectX;
    int        tmDigitizedAspectY;
    ubyte      tmFirstChar;
    ubyte      tmLastChar;
    ubyte      tmDefaultChar;
    ubyte      tmBreakChar;
    ubyte      tmItalic;
    ubyte      tmUnderlined;
    ubyte      tmStruckOut;
    TMPF_FLAGS tmPitchAndFamily;
    ubyte      tmCharSet;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-textmetricw))], [])
struct TEXTMETRICW
{
    int        tmHeight;
    int        tmAscent;
    int        tmDescent;
    int        tmInternalLeading;
    int        tmExternalLeading;
    int        tmAveCharWidth;
    int        tmMaxCharWidth;
    int        tmWeight;
    int        tmOverhang;
    int        tmDigitizedAspectX;
    int        tmDigitizedAspectY;
    wchar      tmFirstChar;
    wchar      tmLastChar;
    wchar      tmDefaultChar;
    wchar      tmBreakChar;
    ubyte      tmItalic;
    ubyte      tmUnderlined;
    ubyte      tmStruckOut;
    TMPF_FLAGS tmPitchAndFamily;
    ubyte      tmCharSet;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-newtextmetrica))], [])
struct NEWTEXTMETRICA
{
    int        tmHeight;
    int        tmAscent;
    int        tmDescent;
    int        tmInternalLeading;
    int        tmExternalLeading;
    int        tmAveCharWidth;
    int        tmMaxCharWidth;
    int        tmWeight;
    int        tmOverhang;
    int        tmDigitizedAspectX;
    int        tmDigitizedAspectY;
    ubyte      tmFirstChar;
    ubyte      tmLastChar;
    ubyte      tmDefaultChar;
    ubyte      tmBreakChar;
    ubyte      tmItalic;
    ubyte      tmUnderlined;
    ubyte      tmStruckOut;
    TMPF_FLAGS tmPitchAndFamily;
    ubyte      tmCharSet;
    uint       ntmFlags;
    uint       ntmSizeEM;
    uint       ntmCellHeight;
    uint       ntmAvgWidth;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-newtextmetricw))], [])
struct NEWTEXTMETRICW
{
    int        tmHeight;
    int        tmAscent;
    int        tmDescent;
    int        tmInternalLeading;
    int        tmExternalLeading;
    int        tmAveCharWidth;
    int        tmMaxCharWidth;
    int        tmWeight;
    int        tmOverhang;
    int        tmDigitizedAspectX;
    int        tmDigitizedAspectY;
    wchar      tmFirstChar;
    wchar      tmLastChar;
    wchar      tmDefaultChar;
    wchar      tmBreakChar;
    ubyte      tmItalic;
    ubyte      tmUnderlined;
    ubyte      tmStruckOut;
    TMPF_FLAGS tmPitchAndFamily;
    ubyte      tmCharSet;
    uint       ntmFlags;
    uint       ntmSizeEM;
    uint       ntmCellHeight;
    uint       ntmAvgWidth;
}

struct PELARRAY
{
    int   paXCount;
    int   paYCount;
    int   paXExt;
    int   paYExt;
    ubyte paRGBs;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-logbrush))], [])
struct LOGBRUSH
{
    BRUSH_STYLE lbStyle;
    COLORREF    lbColor;
    size_t      lbHatch;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-logbrush32))], [])
struct LOGBRUSH32
{
    BRUSH_STYLE lbStyle;
    COLORREF    lbColor;
    uint        lbHatch;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-logpen))], [])
struct LOGPEN
{
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PEN_STYLE))], [])*/uint lopnStyle;
    POINT    lopnWidth;
    COLORREF lopnColor;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-extlogpen))], [])
struct EXTLOGPEN
{
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PEN_STYLE))], [])*/uint elpPenStyle;
    uint     elpWidth;
    uint     elpBrushStyle;
    COLORREF elpColor;
    size_t   elpHatch;
    uint     elpNumEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] elpStyleEntry;
}

struct EXTLOGPEN32
{
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PEN_STYLE))], [])*/uint elpPenStyle;
    uint     elpWidth;
    uint     elpBrushStyle;
    COLORREF elpColor;
    uint     elpHatch;
    uint     elpNumEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] elpStyleEntry;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-paletteentry))], [])
struct PALETTEENTRY
{
    ubyte peRed;
    ubyte peGreen;
    ubyte peBlue;
    ubyte peFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-logpalette))], [])
struct LOGPALETTE
{
    ushort palVersion;
    ushort palNumEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PALETTEENTRY[1] palPalEntry;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shtypes/ns-shtypes-logfonta))], [])
struct LOGFONTA
{
    int                 lfHeight;
    int                 lfWidth;
    int                 lfEscapement;
    int                 lfOrientation;
    int                 lfWeight;
    ubyte               lfItalic;
    ubyte               lfUnderline;
    ubyte               lfStrikeOut;
    FONT_CHARSET        lfCharSet;
    FONT_OUTPUT_PRECISION lfOutPrecision;
    FONT_CLIP_PRECISION lfClipPrecision;
    FONT_QUALITY        lfQuality;
    ubyte               lfPitchAndFamily;
    CHAR[32]            lfFaceName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shtypes/ns-shtypes-logfontw))], [])
struct LOGFONTW
{
    int                 lfHeight;
    int                 lfWidth;
    int                 lfEscapement;
    int                 lfOrientation;
    int                 lfWeight;
    ubyte               lfItalic;
    ubyte               lfUnderline;
    ubyte               lfStrikeOut;
    FONT_CHARSET        lfCharSet;
    FONT_OUTPUT_PRECISION lfOutPrecision;
    FONT_CLIP_PRECISION lfClipPrecision;
    FONT_QUALITY        lfQuality;
    ubyte               lfPitchAndFamily;
    wchar[32]           lfFaceName;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enumlogfonta))], [])
struct ENUMLOGFONTA
{
    LOGFONTA  elfLogFont;
    ubyte[64] elfFullName;
    ubyte[32] elfStyle;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enumlogfontw))], [])
struct ENUMLOGFONTW
{
    LOGFONTW  elfLogFont;
    wchar[64] elfFullName;
    wchar[32] elfStyle;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enumlogfontexa))], [])
struct ENUMLOGFONTEXA
{
    LOGFONTA  elfLogFont;
    ubyte[64] elfFullName;
    ubyte[32] elfStyle;
    ubyte[32] elfScript;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enumlogfontexw))], [])
struct ENUMLOGFONTEXW
{
    LOGFONTW  elfLogFont;
    wchar[64] elfFullName;
    wchar[32] elfStyle;
    wchar[32] elfScript;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-panose))], [])
struct PANOSE
{
    PAN_FAMILY_TYPE      bFamilyType;
    PAN_SERIF_STYLE      bSerifStyle;
    PAN_WEIGHT           bWeight;
    PAN_PROPORTION       bProportion;
    PAN_CONTRAST         bContrast;
    PAN_STROKE_VARIATION bStrokeVariation;
    PAN_ARM_STYLE        bArmStyle;
    PAN_LETT_FORM        bLetterform;
    PAN_MIDLINE          bMidline;
    PAN_XHEIGHT          bXHeight;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-extlogfonta))], [])
struct EXTLOGFONTA
{
    LOGFONTA  elfLogFont;
    ubyte[64] elfFullName;
    ubyte[32] elfStyle;
    uint      elfVersion;
    uint      elfStyleSize;
    uint      elfMatch;
    uint      elfReserved;
    ubyte[4]  elfVendorId;
    uint      elfCulture;
    PANOSE    elfPanose;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-extlogfontw))], [])
struct EXTLOGFONTW
{
    LOGFONTW  elfLogFont;
    wchar[64] elfFullName;
    wchar[32] elfStyle;
    uint      elfVersion;
    uint      elfStyleSize;
    uint      elfMatch;
    uint      elfReserved;
    ubyte[4]  elfVendorId;
    uint      elfCulture;
    PANOSE    elfPanose;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-devmodea))], [])
struct DEVMODEA
{
    ubyte[32]           dmDeviceName;
    ushort              dmSpecVersion;
    ushort              dmDriverVersion;
    ushort              dmSize;
    ushort              dmDriverExtra;
    DEVMODE_FIELD_FLAGS dmFields;
union Anonymous1
    {
struct Anonymous1
        {
            uint                 cEnumColumnValue;
            JET_ENUMCOLUMNVALUE* rgEnumColumnValue;
        }
struct Anonymous2
        {
            uint  cbData;
            void* pvData;
        }
    }
    DEVMODE_COLOR       dmColor;
    DEVMODE_DUPLEX      dmDuplex;
    short               dmYResolution;
    DEVMODE_TRUETYPE_OPTION dmTTOption;
    DEVMODE_COLLATE     dmCollate;
    ubyte[32]           dmFormName;
    ushort              dmLogPixels;
    uint                dmBitsPerPel;
    uint                dmPelsWidth;
    uint                dmPelsHeight;
union Anonymous2
    {
        uint dmDisplayFlags;
        uint dmNup;
    }
    uint                dmDisplayFrequency;
    uint                dmICMMethod;
    uint                dmICMIntent;
    uint                dmMediaType;
    uint                dmDitherType;
    uint                dmReserved1;
    uint                dmReserved2;
    uint                dmPanningWidth;
    uint                dmPanningHeight;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-devmodew))], [])
struct DEVMODEW
{
    wchar[32]           dmDeviceName;
    ushort              dmSpecVersion;
    ushort              dmDriverVersion;
    ushort              dmSize;
    ushort              dmDriverExtra;
    DEVMODE_FIELD_FLAGS dmFields;
union Anonymous1
    {
struct Anonymous1
        {
            short dmOrientation;
            short dmPaperSize;
            short dmPaperLength;
            short dmPaperWidth;
            short dmScale;
            short dmCopies;
            short dmDefaultSource;
            short dmPrintQuality;
        }
struct Anonymous2
        {
            POINTL dmPosition;
            DEVMODE_DISPLAY_ORIENTATION dmDisplayOrientation;
            DEVMODE_DISPLAY_FIXED_OUTPUT dmDisplayFixedOutput;
        }
    }
    DEVMODE_COLOR       dmColor;
    DEVMODE_DUPLEX      dmDuplex;
    short               dmYResolution;
    DEVMODE_TRUETYPE_OPTION dmTTOption;
    DEVMODE_COLLATE     dmCollate;
    wchar[32]           dmFormName;
    ushort              dmLogPixels;
    uint                dmBitsPerPel;
    uint                dmPelsWidth;
    uint                dmPelsHeight;
union Anonymous2
    {
        uint dmDisplayFlags;
        uint dmNup;
    }
    uint                dmDisplayFrequency;
    uint                dmICMMethod;
    uint                dmICMIntent;
    uint                dmMediaType;
    uint                dmDitherType;
    uint                dmReserved1;
    uint                dmReserved2;
    uint                dmPanningWidth;
    uint                dmPanningHeight;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-display_devicea))], [])
struct DISPLAY_DEVICEA
{
    uint      cb;
    CHAR[32]  DeviceName;
    CHAR[128] DeviceString;
    DISPLAY_DEVICE_STATE_FLAGS StateFlags;
    CHAR[128] DeviceID;
    CHAR[128] DeviceKey;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-display_devicew))], [])
struct DISPLAY_DEVICEW
{
    uint       cb;
    wchar[32]  DeviceName;
    wchar[128] DeviceString;
    DISPLAY_DEVICE_STATE_FLAGS StateFlags;
    wchar[128] DeviceID;
    wchar[128] DeviceKey;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-rgndataheader))], [])
struct RGNDATAHEADER
{
    uint dwSize;
    uint iType;
    uint nCount;
    uint nRgnSize;
    RECT rcBound;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-rgndata))], [])
struct RGNDATA
{
    RGNDATAHEADER rdh;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/CHAR[1] Buffer;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-abc))], [])
struct ABC
{
    int  abcA;
    uint abcB;
    int  abcC;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-abcfloat))], [])
struct ABCFLOAT
{
    float abcfA;
    float abcfB;
    float abcfC;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-outlinetextmetrica))], [])
struct OUTLINETEXTMETRICA
{
    uint        otmSize;
    TEXTMETRICA otmTextMetrics;
    ubyte       otmFiller;
    PANOSE      otmPanoseNumber;
    uint        otmfsSelection;
    uint        otmfsType;
    int         otmsCharSlopeRise;
    int         otmsCharSlopeRun;
    int         otmItalicAngle;
    uint        otmEMSquare;
    int         otmAscent;
    int         otmDescent;
    uint        otmLineGap;
    uint        otmsCapEmHeight;
    uint        otmsXHeight;
    RECT        otmrcFontBox;
    int         otmMacAscent;
    int         otmMacDescent;
    uint        otmMacLineGap;
    uint        otmusMinimumPPEM;
    POINT       otmptSubscriptSize;
    POINT       otmptSubscriptOffset;
    POINT       otmptSuperscriptSize;
    POINT       otmptSuperscriptOffset;
    uint        otmsStrikeoutSize;
    int         otmsStrikeoutPosition;
    int         otmsUnderscoreSize;
    int         otmsUnderscorePosition;
    PSTR        otmpFamilyName;
    PSTR        otmpFaceName;
    PSTR        otmpStyleName;
    PSTR        otmpFullName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-outlinetextmetricw))], [])
struct OUTLINETEXTMETRICW
{
    uint        otmSize;
    TEXTMETRICW otmTextMetrics;
    ubyte       otmFiller;
    PANOSE      otmPanoseNumber;
    uint        otmfsSelection;
    uint        otmfsType;
    int         otmsCharSlopeRise;
    int         otmsCharSlopeRun;
    int         otmItalicAngle;
    uint        otmEMSquare;
    int         otmAscent;
    int         otmDescent;
    uint        otmLineGap;
    uint        otmsCapEmHeight;
    uint        otmsXHeight;
    RECT        otmrcFontBox;
    int         otmMacAscent;
    int         otmMacDescent;
    uint        otmMacLineGap;
    uint        otmusMinimumPPEM;
    POINT       otmptSubscriptSize;
    POINT       otmptSubscriptOffset;
    POINT       otmptSuperscriptSize;
    POINT       otmptSuperscriptOffset;
    uint        otmsStrikeoutSize;
    int         otmsStrikeoutPosition;
    int         otmsUnderscoreSize;
    int         otmsUnderscorePosition;
    PSTR        otmpFamilyName;
    PSTR        otmpFaceName;
    PSTR        otmpStyleName;
    PSTR        otmpFullName;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-polytexta))], [])
struct POLYTEXTA
{
    int         x;
    int         y;
    uint        n;
    const(PSTR) lpstr;
    uint        uiFlags;
    RECT        rcl;
    int*        pdx;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-polytextw))], [])
struct POLYTEXTW
{
    int          x;
    int          y;
    uint         n;
    const(PWSTR) lpstr;
    uint         uiFlags;
    RECT         rcl;
    int*         pdx;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-fixed))], [])
struct FIXED
{
    ushort fract;
    short  value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-mat2))], [])
struct MAT2
{
    FIXED eM11;
    FIXED eM12;
    FIXED eM21;
    FIXED eM22;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-glyphmetrics))], [])
struct GLYPHMETRICS
{
    uint  gmBlackBoxX;
    uint  gmBlackBoxY;
    POINT gmptGlyphOrigin;
    short gmCellIncX;
    short gmCellIncY;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-pointfx))], [])
struct POINTFX
{
    FIXED x;
    FIXED y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-ttpolycurve))], [])
struct TTPOLYCURVE
{
    ushort wType;
    ushort cpfx;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/POINTFX[1] apfx;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-ttpolygonheader))], [])
struct TTPOLYGONHEADER
{
    uint    cb;
    uint    dwType;
    POINTFX pfxStart;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-gcp_resultsa))], [])
struct GCP_RESULTSA
{
    uint  lStructSize;
    PSTR  lpOutString;
    uint* lpOrder;
    int*  lpDx;
    int*  lpCaretPos;
    PSTR  lpClass;
    PWSTR lpGlyphs;
    uint  nGlyphs;
    int   nMaxFit;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-gcp_resultsw))], [])
struct GCP_RESULTSW
{
    uint  lStructSize;
    PWSTR lpOutString;
    uint* lpOrder;
    int*  lpDx;
    int*  lpCaretPos;
    PSTR  lpClass;
    PWSTR lpGlyphs;
    uint  nGlyphs;
    int   nMaxFit;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-rasterizer_status))], [])
struct RASTERIZER_STATUS
{
    short nSize;
    short wFlags;
    short nLanguageID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-wcrange))], [])
struct WCRANGE
{
    wchar  wcLow;
    ushort cGlyphs;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-glyphset))], [])
struct GLYPHSET
{
    uint cbThis;
    uint flAccel;
    uint cGlyphsSupported;
    uint cRanges;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WCRANGE[1] ranges;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-designvector))], [])
struct DESIGNVECTOR
{
    uint    dvReserved;
    uint    dvNumAxes;
    int[16] dvValues;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-axisinfoa))], [])
struct AXISINFOA
{
    int       axMinValue;
    int       axMaxValue;
    ubyte[16] axAxisName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-axisinfow))], [])
struct AXISINFOW
{
    int       axMinValue;
    int       axMaxValue;
    wchar[16] axAxisName;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-axeslista))], [])
struct AXESLISTA
{
    uint          axlReserved;
    uint          axlNumAxes;
    AXISINFOA[16] axlAxisInfo;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-axeslistw))], [])
struct AXESLISTW
{
    uint          axlReserved;
    uint          axlNumAxes;
    AXISINFOW[16] axlAxisInfo;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enumlogfontexdva))], [])
struct ENUMLOGFONTEXDVA
{
    ENUMLOGFONTEXA elfEnumLogfontEx;
    DESIGNVECTOR   elfDesignVector;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-enumlogfontexdvw))], [])
struct ENUMLOGFONTEXDVW
{
    ENUMLOGFONTEXW elfEnumLogfontEx;
    DESIGNVECTOR   elfDesignVector;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-trivertex))], [])
struct TRIVERTEX
{
    int    x;
    int    y;
    ushort Red;
    ushort Green;
    ushort Blue;
    ushort Alpha;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-gradient_triangle))], [])
struct GRADIENT_TRIANGLE
{
    uint Vertex1;
    uint Vertex2;
    uint Vertex3;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-gradient_rect))], [])
struct GRADIENT_RECT
{
    uint UpperLeft;
    uint LowerRight;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-blendfunction))], [])
struct BLENDFUNCTION
{
    ubyte BlendOp;
    ubyte BlendFlags;
    ubyte SourceConstantAlpha;
    ubyte AlphaFormat;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-dibsection))], [])
struct DIBSECTION
{
    BITMAP           dsBm;
    BITMAPINFOHEADER dsBmih;
    uint[3]          dsBitfields;
    HANDLE           dshSection;
    uint             dsOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-coloradjustment))], [])
struct COLORADJUSTMENT
{
    ushort caSize;
    ushort caFlags;
    ushort caIlluminantIndex;
    ushort caRedGamma;
    ushort caGreenGamma;
    ushort caBlueGamma;
    ushort caReferenceBlack;
    ushort caReferenceWhite;
    short  caContrast;
    short  caBrightness;
    short  caColorfulness;
    short  caRedGreenTint;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-kerningpair))], [])
struct KERNINGPAIR
{
    ushort wFirst;
    ushort wSecond;
    int    iKernAmount;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emr))], [])
struct EMR
{
    ENHANCED_METAFILE_RECORD_TYPE iType;
    uint nSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrtext))], [])
struct EMRTEXT
{
    POINTL ptlReference;
    uint   nChars;
    uint   offString;
    uint   fOptions;
    RECTL  rcl;
    uint   offDx;
}

struct ABORTPATH
{
    EMR emr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrselectclippath))], [])
struct EMRSELECTCLIPPATH
{
    EMR  emr;
    uint iMode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetmiterlimit))], [])
struct EMRSETMITERLIMIT
{
    EMR   emr;
    float eMiterLimit;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrrestoredc))], [])
struct EMRRESTOREDC
{
    EMR emr;
    int iRelative;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetarcdirection))], [])
struct EMRSETARCDIRECTION
{
    EMR  emr;
    uint iArcDirection;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetmapperflags))], [])
struct EMRSETMAPPERFLAGS
{
    EMR  emr;
    uint dwFlags;
}

struct EMRSETTEXTCOLOR
{
    EMR      emr;
    COLORREF crColor;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrselectobject))], [])
struct EMRSELECTOBJECT
{
    EMR  emr;
    uint ihObject;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrselectpalette))], [])
struct EMRSELECTPALETTE
{
    EMR  emr;
    uint ihPal;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrresizepalette))], [])
struct EMRRESIZEPALETTE
{
    EMR  emr;
    uint ihPal;
    uint cEntries;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetpaletteentries))], [])
struct EMRSETPALETTEENTRIES
{
    EMR  emr;
    uint ihPal;
    uint iStart;
    uint cEntries;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PALETTEENTRY[1] aPalEntries;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetcoloradjustment))], [])
struct EMRSETCOLORADJUSTMENT
{
    EMR             emr;
    COLORADJUSTMENT ColorAdjustment;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrgdicomment))], [])
struct EMRGDICOMMENT
{
    EMR  emr;
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emreof))], [])
struct EMREOF
{
    EMR  emr;
    uint nPalEntries;
    uint offPalEntries;
    uint nSizeLast;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrlineto))], [])
struct EMRLINETO
{
    EMR    emr;
    POINTL ptl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emroffsetcliprgn))], [])
struct EMROFFSETCLIPRGN
{
    EMR    emr;
    POINTL ptlOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrfillpath))], [])
struct EMRFILLPATH
{
    EMR   emr;
    RECTL rclBounds;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrexcludecliprect))], [])
struct EMREXCLUDECLIPRECT
{
    EMR   emr;
    RECTL rclClip;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetviewportorgex))], [])
struct EMRSETVIEWPORTORGEX
{
    EMR    emr;
    POINTL ptlOrigin;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetviewportextex))], [])
struct EMRSETVIEWPORTEXTEX
{
    EMR  emr;
    SIZE szlExtent;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrscaleviewportextex))], [])
struct EMRSCALEVIEWPORTEXTEX
{
    EMR emr;
    int xNum;
    int xDenom;
    int yNum;
    int yDenom;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetworldtransform))], [])
struct EMRSETWORLDTRANSFORM
{
    EMR   emr;
    XFORM xform;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrmodifyworldtransform))], [])
struct EMRMODIFYWORLDTRANSFORM
{
    EMR   emr;
    XFORM xform;
    MODIFY_WORLD_TRANSFORM_MODE iMode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetpixelv))], [])
struct EMRSETPIXELV
{
    EMR      emr;
    POINTL   ptlPixel;
    COLORREF crColor;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrextfloodfill))], [])
struct EMREXTFLOODFILL
{
    EMR      emr;
    POINTL   ptlStart;
    COLORREF crColor;
    uint     iMode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrellipse))], [])
struct EMRELLIPSE
{
    EMR   emr;
    RECTL rclBox;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrroundrect))], [])
struct EMRROUNDRECT
{
    EMR   emr;
    RECTL rclBox;
    SIZE  szlCorner;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrarc))], [])
struct EMRARC
{
    EMR    emr;
    RECTL  rclBox;
    POINTL ptlStart;
    POINTL ptlEnd;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emranglearc))], [])
struct EMRANGLEARC
{
    EMR    emr;
    POINTL ptlCenter;
    uint   nRadius;
    float  eStartAngle;
    float  eSweepAngle;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrpolyline))], [])
struct EMRPOLYLINE
{
    EMR   emr;
    RECTL rclBounds;
    uint  cptl;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/POINTL[1] aptl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrpolyline16))], [])
struct EMRPOLYLINE16
{
    EMR   emr;
    RECTL rclBounds;
    uint  cpts;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/POINTS[1] apts;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrpolydraw))], [])
struct EMRPOLYDRAW
{
    EMR       emr;
    RECTL     rclBounds;
    uint      cptl;
    POINTL[1] aptl;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] abTypes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrpolydraw16))], [])
struct EMRPOLYDRAW16
{
    EMR       emr;
    RECTL     rclBounds;
    uint      cpts;
    POINTS[1] apts;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] abTypes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrpolypolyline))], [])
struct EMRPOLYPOLYLINE
{
    EMR     emr;
    RECTL   rclBounds;
    uint    nPolys;
    uint    cptl;
    uint[1] aPolyCounts;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/POINTL[1] aptl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrpolypolyline16))], [])
struct EMRPOLYPOLYLINE16
{
    EMR     emr;
    RECTL   rclBounds;
    uint    nPolys;
    uint    cpts;
    uint[1] aPolyCounts;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/POINTS[1] apts;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrinvertrgn))], [])
struct EMRINVERTRGN
{
    EMR   emr;
    RECTL rclBounds;
    uint  cbRgnData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] RgnData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrfillrgn))], [])
struct EMRFILLRGN
{
    EMR   emr;
    RECTL rclBounds;
    uint  cbRgnData;
    uint  ihBrush;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] RgnData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrframergn))], [])
struct EMRFRAMERGN
{
    EMR   emr;
    RECTL rclBounds;
    uint  cbRgnData;
    uint  ihBrush;
    SIZE  szlStroke;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] RgnData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrextselectcliprgn))], [])
struct EMREXTSELECTCLIPRGN
{
    EMR  emr;
    uint cbRgnData;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(RGN_COMBINE_MODE))], [])*/uint iMode;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] RgnData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrexttextouta))], [])
struct EMREXTTEXTOUTA
{
    EMR     emr;
    RECTL   rclBounds;
    uint    iGraphicsMode;
    float   exScale;
    float   eyScale;
    EMRTEXT emrtext;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrpolytextouta))], [])
struct EMRPOLYTEXTOUTA
{
    EMR   emr;
    RECTL rclBounds;
    uint  iGraphicsMode;
    float exScale;
    float eyScale;
    int   cStrings;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/EMRTEXT[1] aemrtext;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrbitblt))], [])
struct EMRBITBLT
{
    EMR      emr;
    RECTL    rclBounds;
    int      xDest;
    int      yDest;
    int      cxDest;
    int      cyDest;
    uint     dwRop;
    int      xSrc;
    int      ySrc;
    XFORM    xformSrc;
    COLORREF crBkColorSrc;
    uint     iUsageSrc;
    uint     offBmiSrc;
    uint     cbBmiSrc;
    uint     offBitsSrc;
    uint     cbBitsSrc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrstretchblt))], [])
struct EMRSTRETCHBLT
{
    EMR      emr;
    RECTL    rclBounds;
    int      xDest;
    int      yDest;
    int      cxDest;
    int      cyDest;
    uint     dwRop;
    int      xSrc;
    int      ySrc;
    XFORM    xformSrc;
    COLORREF crBkColorSrc;
    uint     iUsageSrc;
    uint     offBmiSrc;
    uint     cbBmiSrc;
    uint     offBitsSrc;
    uint     cbBitsSrc;
    int      cxSrc;
    int      cySrc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrmaskblt))], [])
struct EMRMASKBLT
{
    EMR      emr;
    RECTL    rclBounds;
    int      xDest;
    int      yDest;
    int      cxDest;
    int      cyDest;
    uint     dwRop;
    int      xSrc;
    int      ySrc;
    XFORM    xformSrc;
    COLORREF crBkColorSrc;
    uint     iUsageSrc;
    uint     offBmiSrc;
    uint     cbBmiSrc;
    uint     offBitsSrc;
    uint     cbBitsSrc;
    int      xMask;
    int      yMask;
    uint     iUsageMask;
    uint     offBmiMask;
    uint     cbBmiMask;
    uint     offBitsMask;
    uint     cbBitsMask;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrplgblt))], [])
struct EMRPLGBLT
{
    EMR       emr;
    RECTL     rclBounds;
    POINTL[3] aptlDest;
    int       xSrc;
    int       ySrc;
    int       cxSrc;
    int       cySrc;
    XFORM     xformSrc;
    COLORREF  crBkColorSrc;
    uint      iUsageSrc;
    uint      offBmiSrc;
    uint      cbBmiSrc;
    uint      offBitsSrc;
    uint      cbBitsSrc;
    int       xMask;
    int       yMask;
    uint      iUsageMask;
    uint      offBmiMask;
    uint      cbBmiMask;
    uint      offBitsMask;
    uint      cbBitsMask;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetdibitstodevice))], [])
struct EMRSETDIBITSTODEVICE
{
    EMR   emr;
    RECTL rclBounds;
    int   xDest;
    int   yDest;
    int   xSrc;
    int   ySrc;
    int   cxSrc;
    int   cySrc;
    uint  offBmiSrc;
    uint  cbBmiSrc;
    uint  offBitsSrc;
    uint  cbBitsSrc;
    uint  iUsageSrc;
    uint  iStartScan;
    uint  cScans;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrstretchdibits))], [])
struct EMRSTRETCHDIBITS
{
    EMR   emr;
    RECTL rclBounds;
    int   xDest;
    int   yDest;
    int   xSrc;
    int   ySrc;
    int   cxSrc;
    int   cySrc;
    uint  offBmiSrc;
    uint  cbBmiSrc;
    uint  offBitsSrc;
    uint  cbBitsSrc;
    uint  iUsageSrc;
    uint  dwRop;
    int   cxDest;
    int   cyDest;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrextcreatefontindirectw))], [])
struct EMREXTCREATEFONTINDIRECTW
{
    EMR         emr;
    uint        ihFont;
    EXTLOGFONTW elfw;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrcreatepalette))], [])
struct EMRCREATEPALETTE
{
    EMR        emr;
    uint       ihPal;
    LOGPALETTE lgpl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrcreatepen))], [])
struct EMRCREATEPEN
{
    EMR    emr;
    uint   ihPen;
    LOGPEN lopn;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrextcreatepen))], [])
struct EMREXTCREATEPEN
{
    EMR         emr;
    uint        ihPen;
    uint        offBmi;
    uint        cbBmi;
    uint        offBits;
    uint        cbBits;
    EXTLOGPEN32 elp;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrcreatebrushindirect))], [])
struct EMRCREATEBRUSHINDIRECT
{
    EMR        emr;
    uint       ihBrush;
    LOGBRUSH32 lb;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrcreatemonobrush))], [])
struct EMRCREATEMONOBRUSH
{
    EMR  emr;
    uint ihBrush;
    uint iUsage;
    uint offBmi;
    uint cbBmi;
    uint offBits;
    uint cbBits;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrcreatedibpatternbrushpt))], [])
struct EMRCREATEDIBPATTERNBRUSHPT
{
    EMR  emr;
    uint ihBrush;
    uint iUsage;
    uint offBmi;
    uint cbBmi;
    uint offBits;
    uint cbBits;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrformat))], [])
struct EMRFORMAT
{
    uint dSignature;
    uint nVersion;
    uint cbData;
    uint offData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrglsrecord))], [])
struct EMRGLSRECORD
{
    EMR  emr;
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrglsboundedrecord))], [])
struct EMRGLSBOUNDEDRECORD
{
    EMR   emr;
    RECTL rclBounds;
    uint  cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrsetcolorspace))], [])
struct EMRSETCOLORSPACE
{
    EMR  emr;
    uint ihCS;
}

struct EMREXTESCAPE
{
    EMR emr;
    int iEscape;
    int cbEscData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] EscData;
}

struct EMRNAMEDESCAPE
{
    EMR emr;
    int iEscape;
    int cbDriver;
    int cbEscData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] EscData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrseticmprofile))], [])
struct EMRSETICMPROFILE
{
    EMR  emr;
    uint dwFlags;
    uint cbName;
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrcolormatchtotarget))], [])
struct EMRCOLORMATCHTOTARGET
{
    EMR  emr;
    uint dwAction;
    uint dwFlags;
    uint cbName;
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrcolorcorrectpalette))], [])
struct EMRCOLORCORRECTPALETTE
{
    EMR  emr;
    uint ihPalette;
    uint nFirstEntry;
    uint nPalEntries;
    uint nReserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emralphablend))], [])
struct EMRALPHABLEND
{
    EMR      emr;
    RECTL    rclBounds;
    int      xDest;
    int      yDest;
    int      cxDest;
    int      cyDest;
    uint     dwRop;
    int      xSrc;
    int      ySrc;
    XFORM    xformSrc;
    COLORREF crBkColorSrc;
    uint     iUsageSrc;
    uint     offBmiSrc;
    uint     cbBmiSrc;
    uint     offBitsSrc;
    uint     cbBitsSrc;
    int      cxSrc;
    int      cySrc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrgradientfill))], [])
struct EMRGRADIENTFILL
{
    EMR           emr;
    RECTL         rclBounds;
    uint          nVer;
    uint          nTri;
    GRADIENT_FILL ulMode;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/TRIVERTEX[1] Ver;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-emrtransparentblt))], [])
struct EMRTRANSPARENTBLT
{
    EMR      emr;
    RECTL    rclBounds;
    int      xDest;
    int      yDest;
    int      cxDest;
    int      cyDest;
    uint     dwRop;
    int      xSrc;
    int      ySrc;
    XFORM    xformSrc;
    COLORREF crBkColorSrc;
    uint     iUsageSrc;
    uint     offBmiSrc;
    uint     cbBmiSrc;
    uint     offBitsSrc;
    uint     cbBitsSrc;
    int      cxSrc;
    int      cySrc;
}

struct WGLSWAP
{
    HDC  hdc;
    uint uiFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/ns-t2embapi-ttloadinfo))], [])
struct TTLOADINFO
{
    ushort  usStructSize;
    ushort  usRefStrSize;
    ushort* pusRefStr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/ns-t2embapi-ttembedinfo))], [])
struct TTEMBEDINFO
{
    ushort  usStructSize;
    ushort  usRootStrSize;
    ushort* pusRootStr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/ns-t2embapi-ttvalidationtestsparams))], [])
struct TTVALIDATIONTESTSPARAMS
{
    uint    ulStructSize;
    int     lTestFromSize;
    int     lTestToSize;
    uint    ulCharSet;
    ushort  usReserved1;
    ushort  usCharCodeCount;
    ushort* pusCharCodeSet;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/ns-t2embapi-ttvalidationtestsparamsex))], [])
struct TTVALIDATIONTESTSPARAMSEX
{
    uint   ulStructSize;
    int    lTestFromSize;
    int    lTestToSize;
    uint   ulCharSet;
    ushort usReserved1;
    ushort usCharCodeCount;
    uint*  pulCharCodeSet;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-paintstruct))], [])
struct PAINTSTRUCT
{
    HDC       hdc;
    BOOL      fErase;
    RECT      rcPaint;
    BOOL      fRestore;
    BOOL      fIncUpdate;
    ubyte[32] rgbReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-drawtextparams))], [])
struct DRAWTEXTPARAMS
{
    uint cbSize;
    int  iTabLength;
    int  iLeftMargin;
    int  iRightMargin;
    uint uiLengthDrawn;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-monitorinfo))], [])
struct MONITORINFO
{
    uint cbSize;
    RECT rcMonitor;
    RECT rcWork;
    uint dwFlags;
}

// Functions

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getobjecta))], [])
@DllImport("GDI32.dll")
int GetObjectA(HGDIOBJ h, int c, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-addfontresourcea))], [])
@DllImport("GDI32.dll")
int AddFontResourceA(const(PSTR) param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-addfontresourcew))], [])
@DllImport("GDI32.dll")
int AddFontResourceW(const(PWSTR) param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-animatepalette))], [])
@DllImport("GDI32.dll")
BOOL AnimatePalette(HPALETTE hPal, uint iStartIndex, uint cEntries, const(PALETTEENTRY)* ppe);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-arc))], [])
@DllImport("GDI32.dll")
BOOL Arc(HDC hdc, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-bitblt))], [])
@DllImport("GDI32.dll")
BOOL BitBlt(HDC hdc, int x, int y, int cx, int cy, HDC hdcSrc, int x1, int y1, ROP_CODE rop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-canceldc))], [])
@DllImport("GDI32.dll")
BOOL CancelDC(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-chord))], [])
@DllImport("GDI32.dll")
BOOL Chord(HDC hdc, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-closemetafile))], [])
@DllImport("GDI32.dll")
HMETAFILE CloseMetaFile(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-combinergn))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE CombineRgn(HRGN hrgnDst, HRGN hrgnSrc1, HRGN hrgnSrc2, RGN_COMBINE_MODE iMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-copymetafilea))], [])
@DllImport("GDI32.dll")
HMETAFILE CopyMetaFileA(HMETAFILE param0, const(PSTR) param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-copymetafilew))], [])
@DllImport("GDI32.dll")
HMETAFILE CopyMetaFileW(HMETAFILE param0, const(PWSTR) param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createbitmap))], [])
@DllImport("GDI32.dll")
HBITMAP CreateBitmap(int nWidth, int nHeight, uint nPlanes, uint nBitCount, const(void)* lpBits);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createbitmapindirect))], [])
@DllImport("GDI32.dll")
HBITMAP CreateBitmapIndirect(const(BITMAP)* pbm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createbrushindirect))], [])
@DllImport("GDI32.dll")
HBRUSH CreateBrushIndirect(const(LOGBRUSH)* plbrush);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createcompatiblebitmap))], [])
@DllImport("GDI32.dll")
HBITMAP CreateCompatibleBitmap(HDC hdc, int cx, int cy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-creatediscardablebitmap))], [])
@DllImport("GDI32.dll")
HBITMAP CreateDiscardableBitmap(HDC hdc, int cx, int cy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createcompatibledc))], [])
@DllImport("GDI32.dll")
HDC CreateCompatibleDC(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createdca))], [])
@DllImport("GDI32.dll")
HDC CreateDCA(const(PSTR) pwszDriver, const(PSTR) pwszDevice, const(PSTR) pszPort, const(DEVMODEA)* pdm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createdcw))], [])
@DllImport("GDI32.dll")
HDC CreateDCW(const(PWSTR) pwszDriver, const(PWSTR) pwszDevice, const(PWSTR) pszPort, const(DEVMODEW)* pdm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createdibitmap))], [])
@DllImport("GDI32.dll")
HBITMAP CreateDIBitmap(HDC hdc, const(BITMAPINFOHEADER)* pbmih, uint flInit, const(void)* pjBits, 
                       const(BITMAPINFO)* pbmi, DIB_USAGE iUsage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createdibpatternbrush))], [])
@DllImport("GDI32.dll")
HBRUSH CreateDIBPatternBrush(HGLOBAL h, DIB_USAGE iUsage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createdibpatternbrushpt))], [])
@DllImport("GDI32.dll")
HBRUSH CreateDIBPatternBrushPt(const(void)* lpPackedDIB, DIB_USAGE iUsage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createellipticrgn))], [])
@DllImport("GDI32.dll")
HRGN CreateEllipticRgn(int x1, int y1, int x2, int y2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createellipticrgnindirect))], [])
@DllImport("GDI32.dll")
HRGN CreateEllipticRgnIndirect(const(RECT)* lprect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createfontindirecta))], [])
@DllImport("GDI32.dll")
HFONT CreateFontIndirectA(const(LOGFONTA)* lplf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createfontindirectw))], [])
@DllImport("GDI32.dll")
HFONT CreateFontIndirectW(const(LOGFONTW)* lplf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createfonta))], [])
@DllImport("GDI32.dll")
HFONT CreateFontA(int cHeight, int cWidth, int cEscapement, int cOrientation, int cWeight, uint bItalic, 
                  uint bUnderline, uint bStrikeOut, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FONT_CHARSET))], [])*/uint iCharSet, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FONT_OUTPUT_PRECISION))], [])*/uint iOutPrecision, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FONT_CLIP_PRECISION))], [])*/uint iClipPrecision, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FONT_QUALITY))], [])*/uint iQuality, 
                  uint iPitchAndFamily, const(PSTR) pszFaceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createfontw))], [])
@DllImport("GDI32.dll")
HFONT CreateFontW(int cHeight, int cWidth, int cEscapement, int cOrientation, int cWeight, uint bItalic, 
                  uint bUnderline, uint bStrikeOut, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FONT_CHARSET))], [])*/uint iCharSet, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FONT_OUTPUT_PRECISION))], [])*/uint iOutPrecision, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FONT_CLIP_PRECISION))], [])*/uint iClipPrecision, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FONT_QUALITY))], [])*/uint iQuality, 
                  uint iPitchAndFamily, const(PWSTR) pszFaceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createhatchbrush))], [])
@DllImport("GDI32.dll")
HBRUSH CreateHatchBrush(HATCH_BRUSH_STYLE iHatch, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createica))], [])
@DllImport("GDI32.dll")
HDC CreateICA(const(PSTR) pszDriver, const(PSTR) pszDevice, const(PSTR) pszPort, const(DEVMODEA)* pdm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createicw))], [])
@DllImport("GDI32.dll")
HDC CreateICW(const(PWSTR) pszDriver, const(PWSTR) pszDevice, const(PWSTR) pszPort, const(DEVMODEW)* pdm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createmetafilea))], [])
@DllImport("GDI32.dll")
HDC CreateMetaFileA(const(PSTR) pszFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createmetafilew))], [])
@DllImport("GDI32.dll")
HDC CreateMetaFileW(const(PWSTR) pszFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createpalette))], [])
@DllImport("GDI32.dll")
HPALETTE CreatePalette(const(LOGPALETTE)* plpal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createpen))], [])
@DllImport("GDI32.dll")
HPEN CreatePen(PEN_STYLE iStyle, int cWidth, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createpenindirect))], [])
@DllImport("GDI32.dll")
HPEN CreatePenIndirect(const(LOGPEN)* plpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createpolypolygonrgn))], [])
@DllImport("GDI32.dll")
HRGN CreatePolyPolygonRgn(const(POINT)* pptl, const(int)* pc, int cPoly, CREATE_POLYGON_RGN_MODE iMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createpatternbrush))], [])
@DllImport("GDI32.dll")
HBRUSH CreatePatternBrush(HBITMAP hbm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createrectrgn))], [])
@DllImport("GDI32.dll")
HRGN CreateRectRgn(int x1, int y1, int x2, int y2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createrectrgnindirect))], [])
@DllImport("GDI32.dll")
HRGN CreateRectRgnIndirect(const(RECT)* lprect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createroundrectrgn))], [])
@DllImport("GDI32.dll")
HRGN CreateRoundRectRgn(int x1, int y1, int x2, int y2, int w, int h);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createscalablefontresourcea))], [])
@DllImport("GDI32.dll")
BOOL CreateScalableFontResourceA(uint fdwHidden, const(PSTR) lpszFont, const(PSTR) lpszFile, const(PSTR) lpszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createscalablefontresourcew))], [])
@DllImport("GDI32.dll")
BOOL CreateScalableFontResourceW(uint fdwHidden, const(PWSTR) lpszFont, const(PWSTR) lpszFile, 
                                 const(PWSTR) lpszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createsolidbrush))], [])
@DllImport("GDI32.dll")
HBRUSH CreateSolidBrush(COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-deletedc))], [])
@DllImport("GDI32.dll")
BOOL DeleteDC(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-deletemetafile))], [])
@DllImport("GDI32.dll")
BOOL DeleteMetaFile(HMETAFILE hmf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-deleteobject))], [])
@DllImport("GDI32.dll")
BOOL DeleteObject(HGDIOBJ ho);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-drawescape))], [])
@DllImport("GDI32.dll")
int DrawEscape(HDC hdc, int iEscape, int cjIn, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) lpIn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1helper/nf-d2d1helper-ellipse))], [])
@DllImport("GDI32.dll")
BOOL Ellipse(HDC hdc, int left, int top, int right, int bottom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-enumfontfamiliesexa))], [])
@DllImport("GDI32.dll")
int EnumFontFamiliesExA(HDC hdc, LOGFONTA* lpLogfont, FONTENUMPROCA lpProc, LPARAM lParam, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-enumfontfamiliesexw))], [])
@DllImport("GDI32.dll")
int EnumFontFamiliesExW(HDC hdc, LOGFONTW* lpLogfont, FONTENUMPROCW lpProc, LPARAM lParam, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-enumfontfamiliesa))], [])
@DllImport("GDI32.dll")
int EnumFontFamiliesA(HDC hdc, const(PSTR) lpLogfont, FONTENUMPROCA lpProc, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-enumfontfamiliesw))], [])
@DllImport("GDI32.dll")
int EnumFontFamiliesW(HDC hdc, const(PWSTR) lpLogfont, FONTENUMPROCW lpProc, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-enumfontsa))], [])
@DllImport("GDI32.dll")
int EnumFontsA(HDC hdc, const(PSTR) lpLogfont, FONTENUMPROCA lpProc, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-enumfontsw))], [])
@DllImport("GDI32.dll")
int EnumFontsW(HDC hdc, const(PWSTR) lpLogfont, FONTENUMPROCW lpProc, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-enumobjects))], [])
@DllImport("GDI32.dll")
int EnumObjects(HDC hdc, OBJ_TYPE nType, GOBJENUMPROC lpFunc, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-equalrgn))], [])
@DllImport("GDI32.dll")
BOOL EqualRgn(HRGN hrgn1, HRGN hrgn2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-excludecliprect))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE ExcludeClipRect(HDC hdc, int left, int top, int right, int bottom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-extcreateregion))], [])
@DllImport("GDI32.dll")
HRGN ExtCreateRegion(const(XFORM)* lpx, uint nCount, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(RGNDATA)* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-extfloodfill))], [])
@DllImport("GDI32.dll")
BOOL ExtFloodFill(HDC hdc, int x, int y, COLORREF color, EXT_FLOOD_FILL_TYPE type);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-fillrgn))], [])
@DllImport("GDI32.dll")
BOOL FillRgn(HDC hdc, HRGN hrgn, HBRUSH hbr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-floodfill))], [])
@DllImport("GDI32.dll")
BOOL FloodFill(HDC hdc, int x, int y, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-framergn))], [])
@DllImport("GDI32.dll")
BOOL FrameRgn(HDC hdc, HRGN hrgn, HBRUSH hbr, int w, int h);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getrop2))], [])
@DllImport("GDI32.dll")
R2_MODE GetROP2(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getaspectratiofilterex))], [])
@DllImport("GDI32.dll")
BOOL GetAspectRatioFilterEx(HDC hdc, SIZE* lpsize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getbkcolor))], [])
@DllImport("GDI32.dll")
COLORREF GetBkColor(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getdcbrushcolor))], [])
@DllImport("GDI32.dll")
COLORREF GetDCBrushColor(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getdcpencolor))], [])
@DllImport("GDI32.dll")
COLORREF GetDCPenColor(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getbkmode))], [])
@DllImport("GDI32.dll")
int GetBkMode(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getbitmapbits))], [])
@DllImport("GDI32.dll")
int GetBitmapBits(HBITMAP hbit, int cb, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpvBits);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getbitmapdimensionex))], [])
@DllImport("GDI32.dll")
BOOL GetBitmapDimensionEx(HBITMAP hbit, SIZE* lpsize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getboundsrect))], [])
@DllImport("GDI32.dll")
uint GetBoundsRect(HDC hdc, RECT* lprect, uint flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getbrushorgex))], [])
@DllImport("GDI32.dll")
BOOL GetBrushOrgEx(HDC hdc, POINT* lppt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharwidtha))], [])
@DllImport("GDI32.dll")
BOOL GetCharWidthA(HDC hdc, uint iFirst, uint iLast, int* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharwidthw))], [])
@DllImport("GDI32.dll")
BOOL GetCharWidthW(HDC hdc, uint iFirst, uint iLast, int* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharwidth32a))], [])
@DllImport("GDI32.dll")
BOOL GetCharWidth32A(HDC hdc, uint iFirst, uint iLast, int* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharwidth32w))], [])
@DllImport("GDI32.dll")
BOOL GetCharWidth32W(HDC hdc, uint iFirst, uint iLast, int* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharwidthfloata))], [])
@DllImport("GDI32.dll")
BOOL GetCharWidthFloatA(HDC hdc, uint iFirst, uint iLast, float* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharwidthfloatw))], [])
@DllImport("GDI32.dll")
BOOL GetCharWidthFloatW(HDC hdc, uint iFirst, uint iLast, float* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharabcwidthsa))], [])
@DllImport("GDI32.dll")
BOOL GetCharABCWidthsA(HDC hdc, uint wFirst, uint wLast, ABC* lpABC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharabcwidthsw))], [])
@DllImport("GDI32.dll")
BOOL GetCharABCWidthsW(HDC hdc, uint wFirst, uint wLast, ABC* lpABC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharabcwidthsfloata))], [])
@DllImport("GDI32.dll")
BOOL GetCharABCWidthsFloatA(HDC hdc, uint iFirst, uint iLast, ABCFLOAT* lpABC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharabcwidthsfloatw))], [])
@DllImport("GDI32.dll")
BOOL GetCharABCWidthsFloatW(HDC hdc, uint iFirst, uint iLast, ABCFLOAT* lpABC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getclipbox))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE GetClipBox(HDC hdc, RECT* lprect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcliprgn))], [])
@DllImport("GDI32.dll")
int GetClipRgn(HDC hdc, HRGN hrgn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getmetargn))], [])
@DllImport("GDI32.dll")
int GetMetaRgn(HDC hdc, HRGN hrgn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcurrentobject))], [])
@DllImport("GDI32.dll")
HGDIOBJ GetCurrentObject(HDC hdc, 
                         /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(OBJ_TYPE))], [])*/uint type);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcurrentpositionex))], [])
@DllImport("GDI32.dll")
BOOL GetCurrentPositionEx(HDC hdc, POINT* lppt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getdevicecaps))], [])
@DllImport("GDI32.dll")
int GetDeviceCaps(HDC hdc, 
                  /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(GET_DEVICE_CAPS_INDEX))], [])*/int index);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getdibits))], [])
@DllImport("GDI32.dll")
int GetDIBits(HDC hdc, HBITMAP hbm, uint start, uint cLines, void* lpvBits, BITMAPINFO* lpbmi, DIB_USAGE usage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getfontdata))], [])
@DllImport("GDI32.dll")
uint GetFontData(HDC hdc, uint dwTable, uint dwOffset, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvBuffer, 
                 uint cjBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getglyphoutlinea))], [])
@DllImport("GDI32.dll")
uint GetGlyphOutlineA(HDC hdc, uint uChar, GET_GLYPH_OUTLINE_FORMAT fuFormat, GLYPHMETRICS* lpgm, uint cjBuffer, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvBuffer, 
                      const(MAT2)* lpmat2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getglyphoutlinew))], [])
@DllImport("GDI32.dll")
uint GetGlyphOutlineW(HDC hdc, uint uChar, GET_GLYPH_OUTLINE_FORMAT fuFormat, GLYPHMETRICS* lpgm, uint cjBuffer, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvBuffer, 
                      const(MAT2)* lpmat2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getgraphicsmode))], [])
@DllImport("GDI32.dll")
int GetGraphicsMode(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getmapmode))], [])
@DllImport("GDI32.dll")
HDC_MAP_MODE GetMapMode(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getmetafilebitsex))], [])
@DllImport("GDI32.dll")
uint GetMetaFileBitsEx(HMETAFILE hMF, uint cbBuffer, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpData);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getmetafilea))], [])
@DllImport("GDI32.dll")
HMETAFILE GetMetaFileA(const(PSTR) lpName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getmetafilew))], [])
@DllImport("GDI32.dll")
HMETAFILE GetMetaFileW(const(PWSTR) lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getnearestcolor))], [])
@DllImport("GDI32.dll")
COLORREF GetNearestColor(HDC hdc, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getnearestpaletteindex))], [])
@DllImport("GDI32.dll")
uint GetNearestPaletteIndex(HPALETTE h, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getobjecttype))], [])
@DllImport("GDI32.dll")
uint GetObjectType(HGDIOBJ h);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getoutlinetextmetricsa))], [])
@DllImport("GDI32.dll")
uint GetOutlineTextMetricsA(HDC hdc, uint cjCopy, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/OUTLINETEXTMETRICA* potm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getoutlinetextmetricsw))], [])
@DllImport("GDI32.dll")
uint GetOutlineTextMetricsW(HDC hdc, uint cjCopy, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/OUTLINETEXTMETRICW* potm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getpaletteentries))], [])
@DllImport("GDI32.dll")
uint GetPaletteEntries(HPALETTE hpal, uint iStart, uint cEntries, PALETTEENTRY* pPalEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getpixel))], [])
@DllImport("GDI32.dll")
COLORREF GetPixel(HDC hdc, int x, int y);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getpolyfillmode))], [])
@DllImport("GDI32.dll")
int GetPolyFillMode(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getrasterizercaps))], [])
@DllImport("GDI32.dll")
BOOL GetRasterizerCaps(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/RASTERIZER_STATUS* lpraststat, 
                       uint cjBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getrandomrgn))], [])
@DllImport("GDI32.dll")
int GetRandomRgn(HDC hdc, HRGN hrgn, int i);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getregiondata))], [])
@DllImport("GDI32.dll")
uint GetRegionData(HRGN hrgn, uint nCount, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/RGNDATA* lpRgnData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getrgnbox))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE GetRgnBox(HRGN hrgn, RECT* lprc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getstockobject))], [])
@DllImport("GDI32.dll")
HGDIOBJ GetStockObject(GET_STOCK_OBJECT_FLAGS i);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getstretchbltmode))], [])
@DllImport("GDI32.dll")
int GetStretchBltMode(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getsystempaletteentries))], [])
@DllImport("GDI32.dll")
uint GetSystemPaletteEntries(HDC hdc, uint iStart, uint cEntries, PALETTEENTRY* pPalEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getsystempaletteuse))], [])
@DllImport("GDI32.dll")
uint GetSystemPaletteUse(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextcharacterextra))], [])
@DllImport("GDI32.dll")
int GetTextCharacterExtra(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextalign))], [])
@DllImport("GDI32.dll")
TEXT_ALIGN_OPTIONS GetTextAlign(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextcolor))], [])
@DllImport("GDI32.dll")
COLORREF GetTextColor(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextextentpointa))], [])
@DllImport("GDI32.dll")
BOOL GetTextExtentPointA(HDC hdc, const(PSTR) lpString, int c, SIZE* lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextextentpointw))], [])
@DllImport("GDI32.dll")
BOOL GetTextExtentPointW(HDC hdc, const(PWSTR) lpString, int c, SIZE* lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextextentpoint32a))], [])
@DllImport("GDI32.dll")
BOOL GetTextExtentPoint32A(HDC hdc, const(PSTR) lpString, int c, SIZE* psizl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextextentpoint32w))], [])
@DllImport("GDI32.dll")
BOOL GetTextExtentPoint32W(HDC hdc, const(PWSTR) lpString, int c, SIZE* psizl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextextentexpointa))], [])
@DllImport("GDI32.dll")
BOOL GetTextExtentExPointA(HDC hdc, const(PSTR) lpszString, int cchString, int nMaxExtent, int* lpnFit, int* lpnDx, 
                           SIZE* lpSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextextentexpointw))], [])
@DllImport("GDI32.dll")
BOOL GetTextExtentExPointW(HDC hdc, const(PWSTR) lpszString, int cchString, int nMaxExtent, int* lpnFit, 
                           int* lpnDx, SIZE* lpSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getfontlanguageinfo))], [])
@DllImport("GDI32.dll")
uint GetFontLanguageInfo(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharacterplacementa))], [])
@DllImport("GDI32.dll")
uint GetCharacterPlacementA(HDC hdc, const(PSTR) lpString, int nCount, int nMexExtent, GCP_RESULTSA* lpResults, 
                            GET_CHARACTER_PLACEMENT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharacterplacementw))], [])
@DllImport("GDI32.dll")
uint GetCharacterPlacementW(HDC hdc, const(PWSTR) lpString, int nCount, int nMexExtent, GCP_RESULTSW* lpResults, 
                            GET_CHARACTER_PLACEMENT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getfontunicoderanges))], [])
@DllImport("GDI32.dll")
uint GetFontUnicodeRanges(HDC hdc, GLYPHSET* lpgs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getglyphindicesa))], [])
@DllImport("GDI32.dll")
uint GetGlyphIndicesA(HDC hdc, const(PSTR) lpstr, int c, ushort* pgi, uint fl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getglyphindicesw))], [])
@DllImport("GDI32.dll")
uint GetGlyphIndicesW(HDC hdc, const(PWSTR) lpstr, int c, ushort* pgi, uint fl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextextentpointi))], [])
@DllImport("GDI32.dll")
BOOL GetTextExtentPointI(HDC hdc, ushort* pgiIn, int cgi, SIZE* psize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextextentexpointi))], [])
@DllImport("GDI32.dll")
BOOL GetTextExtentExPointI(HDC hdc, ushort* lpwszString, int cwchString, int nMaxExtent, int* lpnFit, int* lpnDx, 
                           SIZE* lpSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharwidthi))], [])
@DllImport("GDI32.dll")
BOOL GetCharWidthI(HDC hdc, uint giFirst, uint cgi, ushort* pgi, int* piWidths);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcharabcwidthsi))], [])
@DllImport("GDI32.dll")
BOOL GetCharABCWidthsI(HDC hdc, uint giFirst, uint cgi, ushort* pgi, ABC* pabc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-addfontresourceexa))], [])
@DllImport("GDI32.dll")
int AddFontResourceExA(const(PSTR) name, FONT_RESOURCE_CHARACTERISTICS fl, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-addfontresourceexw))], [])
@DllImport("GDI32.dll")
int AddFontResourceExW(const(PWSTR) name, FONT_RESOURCE_CHARACTERISTICS fl, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-removefontresourceexa))], [])
@DllImport("GDI32.dll")
BOOL RemoveFontResourceExA(const(PSTR) name, uint fl, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pdv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-removefontresourceexw))], [])
@DllImport("GDI32.dll")
BOOL RemoveFontResourceExW(const(PWSTR) name, uint fl, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pdv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-addfontmemresourceex))], [])
@DllImport("GDI32.dll")
HANDLE AddFontMemResourceEx(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pFileView, 
                            uint cjSize, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvResrved, 
                            uint* pNumFonts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-removefontmemresourceex))], [])
@DllImport("GDI32.dll")
BOOL RemoveFontMemResourceEx(HANDLE h);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createfontindirectexa))], [])
@DllImport("GDI32.dll")
HFONT CreateFontIndirectExA(const(ENUMLOGFONTEXDVA)* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createfontindirectexw))], [])
@DllImport("GDI32.dll")
HFONT CreateFontIndirectExW(const(ENUMLOGFONTEXDVW)* param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getviewportextex))], [])
@DllImport("GDI32.dll")
BOOL GetViewportExtEx(HDC hdc, SIZE* lpsize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getviewportorgex))], [])
@DllImport("GDI32.dll")
BOOL GetViewportOrgEx(HDC hdc, POINT* lppoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getwindowextex))], [])
@DllImport("GDI32.dll")
BOOL GetWindowExtEx(HDC hdc, SIZE* lpsize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getwindoworgex))], [])
@DllImport("GDI32.dll")
BOOL GetWindowOrgEx(HDC hdc, POINT* lppoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-intersectcliprect))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE IntersectClipRect(HDC hdc, int left, int top, int right, int bottom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-invertrgn))], [])
@DllImport("GDI32.dll")
BOOL InvertRgn(HDC hdc, HRGN hrgn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-linedda))], [])
@DllImport("GDI32.dll")
BOOL LineDDA(int xStart, int yStart, int xEnd, int yEnd, LINEDDAPROC lpProc, LPARAM data);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-lineto))], [])
@DllImport("GDI32.dll")
BOOL LineTo(HDC hdc, int x, int y);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-maskblt))], [])
@DllImport("GDI32.dll")
BOOL MaskBlt(HDC hdcDest, int xDest, int yDest, int width, int height, HDC hdcSrc, int xSrc, int ySrc, 
             HBITMAP hbmMask, int xMask, int yMask, uint rop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-plgblt))], [])
@DllImport("GDI32.dll")
BOOL PlgBlt(HDC hdcDest, const(POINT)* lpPoint, HDC hdcSrc, int xSrc, int ySrc, int width, int height, 
            HBITMAP hbmMask, int xMask, int yMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-offsetcliprgn))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE OffsetClipRgn(HDC hdc, int x, int y);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-offsetrgn))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE OffsetRgn(HRGN hrgn, int x, int y);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-patblt))], [])
@DllImport("GDI32.dll")
BOOL PatBlt(HDC hdc, int x, int y, int w, int h, ROP_CODE rop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-pie))], [])
@DllImport("GDI32.dll")
BOOL Pie(HDC hdc, int left, int top, int right, int bottom, int xr1, int yr1, int xr2, int yr2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-playmetafile))], [])
@DllImport("GDI32.dll")
BOOL PlayMetaFile(HDC hdc, HMETAFILE hmf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-paintrgn))], [])
@DllImport("GDI32.dll")
BOOL PaintRgn(HDC hdc, HRGN hrgn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polypolygon))], [])
@DllImport("GDI32.dll")
BOOL PolyPolygon(HDC hdc, const(POINT)* apt, const(int)* asz, int csz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-ptinregion))], [])
@DllImport("GDI32.dll")
BOOL PtInRegion(HRGN hrgn, int x, int y);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-ptvisible))], [])
@DllImport("GDI32.dll")
BOOL PtVisible(HDC hdc, int x, int y);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-rectinregion))], [])
@DllImport("GDI32.dll")
BOOL RectInRegion(HRGN hrgn, const(RECT)* lprect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-rectvisible))], [])
@DllImport("GDI32.dll")
BOOL RectVisible(HDC hdc, const(RECT)* lprect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-rectangle))], [])
@DllImport("GDI32.dll")
BOOL Rectangle(HDC hdc, int left, int top, int right, int bottom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-restoredc))], [])
@DllImport("GDI32.dll")
BOOL RestoreDC(HDC hdc, int nSavedDC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-resetdca))], [])
@DllImport("GDI32.dll")
HDC ResetDCA(HDC hdc, const(DEVMODEA)* lpdm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-resetdcw))], [])
@DllImport("GDI32.dll")
HDC ResetDCW(HDC hdc, const(DEVMODEW)* lpdm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-realizepalette))], [])
@DllImport("GDI32.dll")
uint RealizePalette(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-removefontresourcea))], [])
@DllImport("GDI32.dll")
BOOL RemoveFontResourceA(const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-removefontresourcew))], [])
@DllImport("GDI32.dll")
BOOL RemoveFontResourceW(const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-roundrect))], [])
@DllImport("GDI32.dll")
BOOL RoundRect(HDC hdc, int left, int top, int right, int bottom, int width, int height);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-resizepalette))], [])
@DllImport("GDI32.dll")
BOOL ResizePalette(HPALETTE hpal, uint n);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-savedc))], [])
@DllImport("GDI32.dll")
int SaveDC(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-selectcliprgn))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE SelectClipRgn(HDC hdc, HRGN hrgn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-extselectcliprgn))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE ExtSelectClipRgn(HDC hdc, HRGN hrgn, RGN_COMBINE_MODE mode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setmetargn))], [])
@DllImport("GDI32.dll")
GDI_REGION_TYPE SetMetaRgn(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-selectobject))], [])
@DllImport("GDI32.dll")
HGDIOBJ SelectObject(HDC hdc, HGDIOBJ h);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-selectpalette))], [])
@DllImport("GDI32.dll")
HPALETTE SelectPalette(HDC hdc, HPALETTE hPal, BOOL bForceBkgd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setbkcolor))], [])
@DllImport("GDI32.dll")
COLORREF SetBkColor(HDC hdc, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setdcbrushcolor))], [])
@DllImport("GDI32.dll")
COLORREF SetDCBrushColor(HDC hdc, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setdcpencolor))], [])
@DllImport("GDI32.dll")
COLORREF SetDCPenColor(HDC hdc, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setbkmode))], [])
@DllImport("GDI32.dll")
int SetBkMode(HDC hdc, 
              /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(BACKGROUND_MODE))], [])*/int mode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setbitmapbits))], [])
@DllImport("GDI32.dll")
int SetBitmapBits(HBITMAP hbm, uint cb, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pvBits);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setboundsrect))], [])
@DllImport("GDI32.dll")
uint SetBoundsRect(HDC hdc, const(RECT)* lprect, SET_BOUNDS_RECT_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setdibits))], [])
@DllImport("GDI32.dll")
int SetDIBits(HDC hdc, HBITMAP hbm, uint start, uint cLines, const(void)* lpBits, const(BITMAPINFO)* lpbmi, 
              DIB_USAGE ColorUse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setdibitstodevice))], [])
@DllImport("GDI32.dll")
int SetDIBitsToDevice(HDC hdc, int xDest, int yDest, uint w, uint h, int xSrc, int ySrc, uint StartScan, 
                      uint cLines, const(void)* lpvBits, const(BITMAPINFO)* lpbmi, DIB_USAGE ColorUse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setmapperflags))], [])
@DllImport("GDI32.dll")
uint SetMapperFlags(HDC hdc, uint flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setgraphicsmode))], [])
@DllImport("GDI32.dll")
int SetGraphicsMode(HDC hdc, GRAPHICS_MODE iMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setmapmode))], [])
@DllImport("GDI32.dll")
int SetMapMode(HDC hdc, HDC_MAP_MODE iMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setlayout))], [])
@DllImport("GDI32.dll")
uint SetLayout(HDC hdc, DC_LAYOUT l);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getlayout))], [])
@DllImport("GDI32.dll")
uint GetLayout(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setmetafilebitsex))], [])
@DllImport("GDI32.dll")
HMETAFILE SetMetaFileBitsEx(uint cbBuffer, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/const(ubyte)* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setpaletteentries))], [])
@DllImport("GDI32.dll")
uint SetPaletteEntries(HPALETTE hpal, uint iStart, uint cEntries, const(PALETTEENTRY)* pPalEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setpixel))], [])
@DllImport("GDI32.dll")
COLORREF SetPixel(HDC hdc, int x, int y, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setpixelv))], [])
@DllImport("GDI32.dll")
BOOL SetPixelV(HDC hdc, int x, int y, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setpolyfillmode))], [])
@DllImport("GDI32.dll")
int SetPolyFillMode(HDC hdc, CREATE_POLYGON_RGN_MODE mode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-stretchblt))], [])
@DllImport("GDI32.dll")
BOOL StretchBlt(HDC hdcDest, int xDest, int yDest, int wDest, int hDest, HDC hdcSrc, int xSrc, int ySrc, int wSrc, 
                int hSrc, ROP_CODE rop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setrectrgn))], [])
@DllImport("GDI32.dll")
BOOL SetRectRgn(HRGN hrgn, int left, int top, int right, int bottom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-stretchdibits))], [])
@DllImport("GDI32.dll")
int StretchDIBits(HDC hdc, int xDest, int yDest, int DestWidth, int DestHeight, int xSrc, int ySrc, int SrcWidth, 
                  int SrcHeight, const(void)* lpBits, const(BITMAPINFO)* lpbmi, DIB_USAGE iUsage, ROP_CODE rop);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setrop2))], [])
@DllImport("GDI32.dll")
int SetROP2(HDC hdc, R2_MODE rop2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setstretchbltmode))], [])
@DllImport("GDI32.dll")
int SetStretchBltMode(HDC hdc, STRETCH_BLT_MODE mode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setsystempaletteuse))], [])
@DllImport("GDI32.dll")
uint SetSystemPaletteUse(HDC hdc, SYSTEM_PALETTE_USE use);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-settextcharacterextra))], [])
@DllImport("GDI32.dll")
int SetTextCharacterExtra(HDC hdc, int extra);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-settextcolor))], [])
@DllImport("GDI32.dll")
COLORREF SetTextColor(HDC hdc, COLORREF color);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-settextalign))], [])
@DllImport("GDI32.dll")
uint SetTextAlign(HDC hdc, TEXT_ALIGN_OPTIONS align_);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-settextjustification))], [])
@DllImport("GDI32.dll")
BOOL SetTextJustification(HDC hdc, int extra, int count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-updatecolors))], [])
@DllImport("GDI32.dll")
BOOL UpdateColors(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-alphablend))], [])
@DllImport("MSIMG32.dll")
BOOL AlphaBlend(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, int xoriginSrc, 
                int yoriginSrc, int wSrc, int hSrc, BLENDFUNCTION ftn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-transparentblt))], [])
@DllImport("MSIMG32.dll")
BOOL TransparentBlt(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, 
                    int xoriginSrc, int yoriginSrc, int wSrc, int hSrc, uint crTransparent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gradientfill))], [])
@DllImport("MSIMG32.dll")
BOOL GradientFill(HDC hdc, TRIVERTEX* pVertex, uint nVertex, void* pMesh, uint nMesh, GRADIENT_FILL ulMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gdialphablend))], [])
@DllImport("GDI32.dll")
BOOL GdiAlphaBlend(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, int xoriginSrc, 
                   int yoriginSrc, int wSrc, int hSrc, BLENDFUNCTION ftn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gditransparentblt))], [])
@DllImport("GDI32.dll")
BOOL GdiTransparentBlt(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, 
                       int xoriginSrc, int yoriginSrc, int wSrc, int hSrc, uint crTransparent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gdigradientfill))], [])
@DllImport("GDI32.dll")
BOOL GdiGradientFill(HDC hdc, TRIVERTEX* pVertex, uint nVertex, void* pMesh, uint nCount, GRADIENT_FILL ulMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-playmetafilerecord))], [])
@DllImport("GDI32.dll")
BOOL PlayMetaFileRecord(HDC hdc, HANDLETABLE* lpHandleTable, METARECORD* lpMR, uint noObjs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-enummetafile))], [])
@DllImport("GDI32.dll")
BOOL EnumMetaFile(HDC hdc, HMETAFILE hmf, MFENUMPROC proc, LPARAM param3);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-closeenhmetafile))], [])
@DllImport("GDI32.dll")
HENHMETAFILE CloseEnhMetaFile(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-copyenhmetafilea))], [])
@DllImport("GDI32.dll")
HENHMETAFILE CopyEnhMetaFileA(HENHMETAFILE hEnh, const(PSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-copyenhmetafilew))], [])
@DllImport("GDI32.dll")
HENHMETAFILE CopyEnhMetaFileW(HENHMETAFILE hEnh, const(PWSTR) lpFileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createenhmetafilea))], [])
@DllImport("GDI32.dll")
HDC CreateEnhMetaFileA(HDC hdc, const(PSTR) lpFilename, const(RECT)* lprc, const(PSTR) lpDesc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createenhmetafilew))], [])
@DllImport("GDI32.dll")
HDC CreateEnhMetaFileW(HDC hdc, const(PWSTR) lpFilename, const(RECT)* lprc, const(PWSTR) lpDesc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-deleteenhmetafile))], [])
@DllImport("GDI32.dll")
BOOL DeleteEnhMetaFile(HENHMETAFILE hmf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-enumenhmetafile))], [])
@DllImport("GDI32.dll")
BOOL EnumEnhMetaFile(HDC hdc, HENHMETAFILE hmf, ENHMFENUMPROC proc, void* param3, const(RECT)* lpRect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getenhmetafilea))], [])
@DllImport("GDI32.dll")
HENHMETAFILE GetEnhMetaFileA(const(PSTR) lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getenhmetafilew))], [])
@DllImport("GDI32.dll")
HENHMETAFILE GetEnhMetaFileW(const(PWSTR) lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getenhmetafilebits))], [])
@DllImport("GDI32.dll")
uint GetEnhMetaFileBits(HENHMETAFILE hEMF, uint nSize, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getenhmetafiledescriptiona))], [])
@DllImport("GDI32.dll")
uint GetEnhMetaFileDescriptionA(HENHMETAFILE hemf, uint cchBuffer, PSTR lpDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getenhmetafiledescriptionw))], [])
@DllImport("GDI32.dll")
uint GetEnhMetaFileDescriptionW(HENHMETAFILE hemf, uint cchBuffer, PWSTR lpDescription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getenhmetafileheader))], [])
@DllImport("GDI32.dll")
uint GetEnhMetaFileHeader(HENHMETAFILE hemf, uint nSize, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ENHMETAHEADER* lpEnhMetaHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getenhmetafilepaletteentries))], [])
@DllImport("GDI32.dll")
uint GetEnhMetaFilePaletteEntries(HENHMETAFILE hemf, uint nNumEntries, PALETTEENTRY* lpPaletteEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getwinmetafilebits))], [])
@DllImport("GDI32.dll")
uint GetWinMetaFileBits(HENHMETAFILE hemf, uint cbData16, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pData16, 
                        int iMapMode, HDC hdcRef);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-playenhmetafile))], [])
@DllImport("GDI32.dll")
BOOL PlayEnhMetaFile(HDC hdc, HENHMETAFILE hmf, const(RECT)* lprect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-playenhmetafilerecord))], [])
@DllImport("GDI32.dll")
BOOL PlayEnhMetaFileRecord(HDC hdc, HANDLETABLE* pht, const(ENHMETARECORD)* pmr, uint cht);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setenhmetafilebits))], [])
@DllImport("GDI32.dll")
HENHMETAFILE SetEnhMetaFileBits(uint nSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/const(ubyte)* pb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gdicomment))], [])
@DllImport("GDI32.dll")
BOOL GdiComment(HDC hdc, uint nSize, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(ubyte)* lpData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextmetricsa))], [])
@DllImport("GDI32.dll")
BOOL GetTextMetricsA(HDC hdc, TEXTMETRICA* lptm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextmetricsw))], [])
@DllImport("GDI32.dll")
BOOL GetTextMetricsW(HDC hdc, TEXTMETRICW* lptm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-anglearc))], [])
@DllImport("GDI32.dll")
BOOL AngleArc(HDC hdc, int x, int y, uint r, float StartAngle, float SweepAngle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polypolyline))], [])
@DllImport("GDI32.dll")
BOOL PolyPolyline(HDC hdc, const(POINT)* apt, const(uint)* asz, uint csz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getworldtransform))], [])
@DllImport("GDI32.dll")
BOOL GetWorldTransform(HDC hdc, XFORM* lpxf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setworldtransform))], [])
@DllImport("GDI32.dll")
BOOL SetWorldTransform(HDC hdc, const(XFORM)* lpxf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-modifyworldtransform))], [])
@DllImport("GDI32.dll")
BOOL ModifyWorldTransform(HDC hdc, const(XFORM)* lpxf, MODIFY_WORLD_TRANSFORM_MODE mode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-combinetransform))], [])
@DllImport("GDI32.dll")
BOOL CombineTransform(XFORM* lpxfOut, const(XFORM)* lpxf1, const(XFORM)* lpxf2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createdibsection))], [])
@DllImport("GDI32.dll")
HBITMAP CreateDIBSection(HDC hdc, const(BITMAPINFO)* pbmi, DIB_USAGE usage, void** ppvBits, HANDLE hSection, 
                         uint offset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getdibcolortable))], [])
@DllImport("GDI32.dll")
uint GetDIBColorTable(HDC hdc, uint iStart, uint cEntries, RGBQUAD* prgbq);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setdibcolortable))], [])
@DllImport("GDI32.dll")
uint SetDIBColorTable(HDC hdc, uint iStart, uint cEntries, const(RGBQUAD)* prgbq);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setcoloradjustment))], [])
@DllImport("GDI32.dll")
BOOL SetColorAdjustment(HDC hdc, const(COLORADJUSTMENT)* lpca);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getcoloradjustment))], [])
@DllImport("GDI32.dll")
BOOL GetColorAdjustment(HDC hdc, COLORADJUSTMENT* lpca);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createhalftonepalette))], [])
@DllImport("GDI32.dll")
HPALETTE CreateHalftonePalette(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-abortpath))], [])
@DllImport("GDI32.dll")
BOOL AbortPath(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-arcto))], [])
@DllImport("GDI32.dll")
BOOL ArcTo(HDC hdc, int left, int top, int right, int bottom, int xr1, int yr1, int xr2, int yr2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-beginpath))], [])
@DllImport("GDI32.dll")
BOOL BeginPath(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-closefigure))], [])
@DllImport("GDI32.dll")
BOOL CloseFigure(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-endpath))], [])
@DllImport("GDI32.dll")
BOOL EndPath(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-fillpath))], [])
@DllImport("GDI32.dll")
BOOL FillPath(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-flattenpath))], [])
@DllImport("GDI32.dll")
BOOL FlattenPath(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getpath))], [])
@DllImport("GDI32.dll")
int GetPath(HDC hdc, POINT* apt, ubyte* aj, int cpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-pathtoregion))], [])
@DllImport("GDI32.dll")
HRGN PathToRegion(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polydraw))], [])
@DllImport("GDI32.dll")
BOOL PolyDraw(HDC hdc, const(POINT)* apt, const(ubyte)* aj, int cpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-selectclippath))], [])
@DllImport("GDI32.dll")
BOOL SelectClipPath(HDC hdc, RGN_COMBINE_MODE mode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setarcdirection))], [])
@DllImport("GDI32.dll")
int SetArcDirection(HDC hdc, ARC_DIRECTION dir);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setmiterlimit))], [])
@DllImport("GDI32.dll")
BOOL SetMiterLimit(HDC hdc, float limit, float* old);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-strokeandfillpath))], [])
@DllImport("GDI32.dll")
BOOL StrokeAndFillPath(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-strokepath))], [])
@DllImport("GDI32.dll")
BOOL StrokePath(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-widenpath))], [])
@DllImport("GDI32.dll")
BOOL WidenPath(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-extcreatepen))], [])
@DllImport("GDI32.dll")
HPEN ExtCreatePen(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PEN_STYLE))], [])*/uint iPenStyle, 
                  uint cWidth, const(LOGBRUSH)* plbrush, uint cStyle, const(uint)* pstyle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getmiterlimit))], [])
@DllImport("GDI32.dll")
BOOL GetMiterLimit(HDC hdc, float* plimit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getarcdirection))], [])
@DllImport("GDI32.dll")
int GetArcDirection(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getobjectw))], [])
@DllImport("GDI32.dll")
int GetObjectW(HGDIOBJ h, int c, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-movetoex))], [])
@DllImport("GDI32.dll")
BOOL MoveToEx(HDC hdc, int x, int y, POINT* lppt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-textouta))], [])
@DllImport("GDI32.dll")
BOOL TextOutA(HDC hdc, int x, int y, const(PSTR) lpString, int c);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-textoutw))], [])
@DllImport("GDI32.dll")
BOOL TextOutW(HDC hdc, int x, int y, const(PWSTR) lpString, int c);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-exttextouta))], [])
@DllImport("GDI32.dll")
BOOL ExtTextOutA(HDC hdc, int x, int y, ETO_OPTIONS options, const(RECT)* lprect, const(PSTR) lpString, uint c, 
                 const(int)* lpDx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-exttextoutw))], [])
@DllImport("GDI32.dll")
BOOL ExtTextOutW(HDC hdc, int x, int y, ETO_OPTIONS options, const(RECT)* lprect, const(PWSTR) lpString, uint c, 
                 const(int)* lpDx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polytextouta))], [])
@DllImport("GDI32.dll")
BOOL PolyTextOutA(HDC hdc, const(POLYTEXTA)* ppt, int nstrings);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polytextoutw))], [])
@DllImport("GDI32.dll")
BOOL PolyTextOutW(HDC hdc, const(POLYTEXTW)* ppt, int nstrings);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-createpolygonrgn))], [])
@DllImport("GDI32.dll")
HRGN CreatePolygonRgn(const(POINT)* pptl, int cPoint, CREATE_POLYGON_RGN_MODE iMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-dptolp))], [])
@DllImport("GDI32.dll")
BOOL DPtoLP(HDC hdc, POINT* lppt, int c);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-lptodp))], [])
@DllImport("GDI32.dll")
BOOL LPtoDP(HDC hdc, POINT* lppt, int c);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polygon))], [])
@DllImport("GDI32.dll")
BOOL Polygon(HDC hdc, const(POINT)* apt, int cpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polyline))], [])
@DllImport("GDI32.dll")
BOOL Polyline(HDC hdc, const(POINT)* apt, int cpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polybezier))], [])
@DllImport("GDI32.dll")
BOOL PolyBezier(HDC hdc, const(POINT)* apt, uint cpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polybezierto))], [])
@DllImport("GDI32.dll")
BOOL PolyBezierTo(HDC hdc, const(POINT)* apt, uint cpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-polylineto))], [])
@DllImport("GDI32.dll")
BOOL PolylineTo(HDC hdc, const(POINT)* apt, uint cpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setviewportextex))], [])
@DllImport("GDI32.dll")
BOOL SetViewportExtEx(HDC hdc, int x, int y, SIZE* lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setviewportorgex))], [])
@DllImport("GDI32.dll")
BOOL SetViewportOrgEx(HDC hdc, int x, int y, POINT* lppt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setwindowextex))], [])
@DllImport("GDI32.dll")
BOOL SetWindowExtEx(HDC hdc, int x, int y, SIZE* lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setwindoworgex))], [])
@DllImport("GDI32.dll")
BOOL SetWindowOrgEx(HDC hdc, int x, int y, POINT* lppt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-offsetviewportorgex))], [])
@DllImport("GDI32.dll")
BOOL OffsetViewportOrgEx(HDC hdc, int x, int y, POINT* lppt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-offsetwindoworgex))], [])
@DllImport("GDI32.dll")
BOOL OffsetWindowOrgEx(HDC hdc, int x, int y, POINT* lppt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-scaleviewportextex))], [])
@DllImport("GDI32.dll")
BOOL ScaleViewportExtEx(HDC hdc, int xn, int dx, int yn, int yd, SIZE* lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-scalewindowextex))], [])
@DllImport("GDI32.dll")
BOOL ScaleWindowExtEx(HDC hdc, int xn, int xd, int yn, int yd, SIZE* lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setbitmapdimensionex))], [])
@DllImport("GDI32.dll")
BOOL SetBitmapDimensionEx(HBITMAP hbm, int w, int h, SIZE* lpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setbrushorgex))], [])
@DllImport("GDI32.dll")
BOOL SetBrushOrgEx(HDC hdc, int x, int y, POINT* lppt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextfacea))], [])
@DllImport("GDI32.dll")
int GetTextFaceA(HDC hdc, int c, PSTR lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gettextfacew))], [])
@DllImport("GDI32.dll")
int GetTextFaceW(HDC hdc, int c, PWSTR lpName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getkerningpairsa))], [])
@DllImport("GDI32.dll")
uint GetKerningPairsA(HDC hdc, uint nPairs, KERNINGPAIR* lpKernPair);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getkerningpairsw))], [])
@DllImport("GDI32.dll")
uint GetKerningPairsW(HDC hdc, uint nPairs, KERNINGPAIR* lpKernPair);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-getdcorgex))], [])
@DllImport("GDI32.dll")
BOOL GetDCOrgEx(HDC hdc, POINT* lppt);

@DllImport("GDI32.dll")
BOOL FixBrushOrgEx(HDC hdc, int x, int y, POINT* ptl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-unrealizeobject))], [])
@DllImport("GDI32.dll")
BOOL UnrealizeObject(HGDIOBJ h);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gdiflush))], [])
@DllImport("GDI32.dll")
BOOL GdiFlush();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gdisetbatchlimit))], [])
@DllImport("GDI32.dll")
uint GdiSetBatchLimit(uint dw);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-gdigetbatchlimit))], [])
@DllImport("GDI32.dll")
uint GdiGetBatchLimit();

@DllImport("OPENGL32.dll")
uint wglSwapMultipleBuffers(uint param0, const(WGLSWAP)* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fontsub/nf-fontsub-createfontpackage))], [])
@DllImport("FONTSUB.dll")
uint CreateFontPackage(const(ubyte)* puchSrcBuffer, const(uint) ulSrcBufferSize, ubyte** ppuchFontPackageBuffer, 
                       uint* pulFontPackageBufferSize, uint* pulBytesWritten, const(ushort) usFlag, 
                       const(ushort) usTTCIndex, const(ushort) usSubsetFormat, const(ushort) usSubsetLanguage, 
                       const(CREATE_FONT_PACKAGE_SUBSET_PLATFORM) usSubsetPlatform, 
                       const(CREATE_FONT_PACKAGE_SUBSET_ENCODING) usSubsetEncoding, const(ushort)* pusSubsetKeepList, 
                       const(ushort) usSubsetListCount, CFP_ALLOCPROC lpfnAllocate, CFP_REALLOCPROC lpfnReAllocate, 
                       CFP_FREEPROC lpfnFree, void* lpvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/fontsub/nf-fontsub-mergefontpackage))], [])
@DllImport("FONTSUB.dll")
uint MergeFontPackage(const(ubyte)* puchMergeFontBuffer, const(uint) ulMergeFontBufferSize, 
                      const(ubyte)* puchFontPackageBuffer, const(uint) ulFontPackageBufferSize, 
                      ubyte** ppuchDestBuffer, uint* pulDestBufferSize, uint* pulBytesWritten, const(ushort) usMode, 
                      CFP_ALLOCPROC lpfnAllocate, CFP_REALLOCPROC lpfnReAllocate, CFP_FREEPROC lpfnFree, 
                      void* lpvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttembedfont))], [])
@DllImport("t2embed.dll")
int TTEmbedFont(HDC hDC, TTEMBED_FLAGS ulFlags, EMBED_FONT_CHARSET ulCharSet, 
                EMBEDDED_FONT_PRIV_STATUS* pulPrivStatus, uint* pulStatus, WRITEEMBEDPROC lpfnWriteToStream, 
                void* lpvWriteStream, ushort* pusCharCodeSet, ushort usCharCodeCount, ushort usLanguage, 
                TTEMBEDINFO* pTTEmbedInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttembedfontfromfilea))], [])
@DllImport("t2embed.dll")
int TTEmbedFontFromFileA(HDC hDC, const(PSTR) szFontFileName, ushort usTTCIndex, TTEMBED_FLAGS ulFlags, 
                         EMBED_FONT_CHARSET ulCharSet, EMBEDDED_FONT_PRIV_STATUS* pulPrivStatus, uint* pulStatus, 
                         WRITEEMBEDPROC lpfnWriteToStream, void* lpvWriteStream, ushort* pusCharCodeSet, 
                         ushort usCharCodeCount, ushort usLanguage, TTEMBEDINFO* pTTEmbedInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttloadembeddedfont))], [])
@DllImport("t2embed.dll")
int TTLoadEmbeddedFont(HANDLE* phFontReference, uint ulFlags, EMBEDDED_FONT_PRIV_STATUS* pulPrivStatus, 
                       FONT_LICENSE_PRIVS ulPrivs, TTLOAD_EMBEDDED_FONT_STATUS* pulStatus, 
                       READEMBEDPROC lpfnReadFromStream, void* lpvReadStream, PWSTR szWinFamilyName, 
                       PSTR szMacFamilyName, TTLOADINFO* pTTLoadInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttgetembeddedfontinfo))], [])
@DllImport("t2embed.dll")
int TTGetEmbeddedFontInfo(TTEMBED_FLAGS ulFlags, uint* pulPrivStatus, FONT_LICENSE_PRIVS ulPrivs, uint* pulStatus, 
                          READEMBEDPROC lpfnReadFromStream, void* lpvReadStream, TTLOADINFO* pTTLoadInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttdeleteembeddedfont))], [])
@DllImport("t2embed.dll")
int TTDeleteEmbeddedFont(HANDLE hFontReference, uint ulFlags, uint* pulStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttgetembeddingtype))], [])
@DllImport("t2embed.dll")
int TTGetEmbeddingType(HDC hDC, EMBEDDED_FONT_PRIV_STATUS* pulEmbedType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttchartounicode))], [])
@DllImport("t2embed.dll")
int TTCharToUnicode(HDC hDC, ubyte* pucCharCodes, uint ulCharCodeSize, ushort* pusShortCodes, uint ulShortCodeSize, 
                    uint ulFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttrunvalidationtests))], [])
@DllImport("t2embed.dll")
int TTRunValidationTests(HDC hDC, TTVALIDATIONTESTSPARAMS* pTestParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttisembeddingenabled))], [])
@DllImport("t2embed.dll")
int TTIsEmbeddingEnabled(HDC hDC, BOOL* pbEnabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttisembeddingenabledforfacename))], [])
@DllImport("t2embed.dll")
int TTIsEmbeddingEnabledForFacename(const(PSTR) lpszFacename, BOOL* pbEnabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttenableembeddingforfacename))], [])
@DllImport("t2embed.dll")
int TTEnableEmbeddingForFacename(const(PSTR) lpszFacename, BOOL bEnable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttembedfontex))], [])
@DllImport("t2embed.dll")
int TTEmbedFontEx(HDC hDC, TTEMBED_FLAGS ulFlags, EMBED_FONT_CHARSET ulCharSet, 
                  EMBEDDED_FONT_PRIV_STATUS* pulPrivStatus, uint* pulStatus, WRITEEMBEDPROC lpfnWriteToStream, 
                  void* lpvWriteStream, uint* pulCharCodeSet, ushort usCharCodeCount, ushort usLanguage, 
                  TTEMBEDINFO* pTTEmbedInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttrunvalidationtestsex))], [])
@DllImport("t2embed.dll")
int TTRunValidationTestsEx(HDC hDC, TTVALIDATIONTESTSPARAMSEX* pTestParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/t2embapi/nf-t2embapi-ttgetnewfontname))], [])
@DllImport("t2embed.dll")
int TTGetNewFontName(HANDLE* phFontReference, PWSTR wzWinFamilyName, int cchMaxWinName, PSTR szMacFamilyName, 
                     int cchMaxMacName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawedge))], [])
@DllImport("USER32.dll")
BOOL DrawEdge(HDC hdc, RECT* qrc, DRAWEDGE_FLAGS edge, DRAW_EDGE_FLAGS grfFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawframecontrol))], [])
@DllImport("USER32.dll")
BOOL DrawFrameControl(HDC hdc, RECT* lprc, uint uType, uint uState);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawcaption))], [])
@DllImport("USER32.dll")
BOOL DrawCaption(HWND hwnd, HDC hdc, const(RECT)* lprect, DRAW_CAPTION_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawanimatedrects))], [])
@DllImport("USER32.dll")
BOOL DrawAnimatedRects(HWND hwnd, int idAni, const(RECT)* lprcFrom, const(RECT)* lprcTo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawtexta))], [])
@DllImport("USER32.dll")
int DrawTextA(HDC hdc, const(PSTR) lpchText, int cchText, RECT* lprc, DRAW_TEXT_FORMAT format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawtextw))], [])
@DllImport("USER32.dll")
int DrawTextW(HDC hdc, const(PWSTR) lpchText, int cchText, RECT* lprc, DRAW_TEXT_FORMAT format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawtextexa))], [])
@DllImport("USER32.dll")
int DrawTextExA(HDC hdc, PSTR lpchText, int cchText, RECT* lprc, DRAW_TEXT_FORMAT format, DRAWTEXTPARAMS* lpdtp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawtextexw))], [])
@DllImport("USER32.dll")
int DrawTextExW(HDC hdc, PWSTR lpchText, int cchText, RECT* lprc, DRAW_TEXT_FORMAT format, DRAWTEXTPARAMS* lpdtp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-graystringa))], [])
@DllImport("USER32.dll")
BOOL GrayStringA(HDC hDC, HBRUSH hBrush, GRAYSTRINGPROC lpOutputFunc, LPARAM lpData, int nCount, int X, int Y, 
                 int nWidth, int nHeight);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-graystringw))], [])
@DllImport("USER32.dll")
BOOL GrayStringW(HDC hDC, HBRUSH hBrush, GRAYSTRINGPROC lpOutputFunc, LPARAM lpData, int nCount, int X, int Y, 
                 int nWidth, int nHeight);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawstatea))], [])
@DllImport("USER32.dll")
BOOL DrawStateA(HDC hdc, HBRUSH hbrFore, DRAWSTATEPROC qfnCallBack, LPARAM lData, WPARAM wData, int x, int y, 
                int cx, int cy, DRAWSTATE_FLAGS uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawstatew))], [])
@DllImport("USER32.dll")
BOOL DrawStateW(HDC hdc, HBRUSH hbrFore, DRAWSTATEPROC qfnCallBack, LPARAM lData, WPARAM wData, int x, int y, 
                int cx, int cy, DRAWSTATE_FLAGS uFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-tabbedtextouta))], [])
@DllImport("USER32.dll")
int TabbedTextOutA(HDC hdc, int x, int y, const(PSTR) lpString, int chCount, int nTabPositions, 
                   const(int)* lpnTabStopPositions, int nTabOrigin);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-tabbedtextoutw))], [])
@DllImport("USER32.dll")
int TabbedTextOutW(HDC hdc, int x, int y, const(PWSTR) lpString, int chCount, int nTabPositions, 
                   const(int)* lpnTabStopPositions, int nTabOrigin);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-gettabbedtextextenta))], [])
@DllImport("USER32.dll")
uint GetTabbedTextExtentA(HDC hdc, const(PSTR) lpString, int chCount, int nTabPositions, 
                          const(int)* lpnTabStopPositions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-gettabbedtextextentw))], [])
@DllImport("USER32.dll")
uint GetTabbedTextExtentW(HDC hdc, const(PWSTR) lpString, int chCount, int nTabPositions, 
                          const(int)* lpnTabStopPositions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-updatewindow))], [])
@DllImport("USER32.dll")
BOOL UpdateWindow(HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-paintdesktop))], [])
@DllImport("USER32.dll")
BOOL PaintDesktop(HDC hdc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-windowfromdc))], [])
@DllImport("USER32.dll")
HWND WindowFromDC(HDC hDC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getdc))], [])
@DllImport("USER32.dll")
HDC GetDC(HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getdcex))], [])
@DllImport("USER32.dll")
HDC GetDCEx(HWND hWnd, HRGN hrgnClip, GET_DCX_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getwindowdc))], [])
@DllImport("USER32.dll")
HDC GetWindowDC(HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-releasedc))], [])
@DllImport("USER32.dll")
int ReleaseDC(HWND hWnd, HDC hDC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-beginpaint))], [])
@DllImport("USER32.dll")
HDC BeginPaint(HWND hWnd, PAINTSTRUCT* lpPaint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-endpaint))], [])
@DllImport("USER32.dll")
BOOL EndPaint(HWND hWnd, const(PAINTSTRUCT)* lpPaint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getupdaterect))], [])
@DllImport("USER32.dll")
BOOL GetUpdateRect(HWND hWnd, RECT* lpRect, BOOL bErase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getupdatergn))], [])
@DllImport("USER32.dll")
GDI_REGION_TYPE GetUpdateRgn(HWND hWnd, HRGN hRgn, BOOL bErase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setwindowrgn))], [])
@DllImport("USER32.dll")
int SetWindowRgn(HWND hWnd, HRGN hRgn, BOOL bRedraw);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getwindowrgn))], [])
@DllImport("USER32.dll")
GDI_REGION_TYPE GetWindowRgn(HWND hWnd, HRGN hRgn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getwindowrgnbox))], [])
@DllImport("USER32.dll")
GDI_REGION_TYPE GetWindowRgnBox(HWND hWnd, RECT* lprc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-excludeupdatergn))], [])
@DllImport("USER32.dll")
int ExcludeUpdateRgn(HDC hDC, HWND hWnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-invalidaterect))], [])
@DllImport("USER32.dll")
BOOL InvalidateRect(HWND hWnd, const(RECT)* lpRect, BOOL bErase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-validaterect))], [])
@DllImport("USER32.dll")
BOOL ValidateRect(HWND hWnd, const(RECT)* lpRect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-invalidatergn))], [])
@DllImport("USER32.dll")
BOOL InvalidateRgn(HWND hWnd, HRGN hRgn, BOOL bErase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-validatergn))], [])
@DllImport("USER32.dll")
BOOL ValidateRgn(HWND hWnd, HRGN hRgn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-redrawwindow))], [])
@DllImport("USER32.dll")
BOOL RedrawWindow(HWND hWnd, const(RECT)* lprcUpdate, HRGN hrgnUpdate, REDRAW_WINDOW_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-lockwindowupdate))], [])
@DllImport("USER32.dll")
BOOL LockWindowUpdate(HWND hWndLock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-clienttoscreen))], [])
@DllImport("USER32.dll")
BOOL ClientToScreen(HWND hWnd, POINT* lpPoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-screentoclient))], [])
@DllImport("USER32.dll")
BOOL ScreenToClient(HWND hWnd, POINT* lpPoint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-mapwindowpoints))], [])
@DllImport("USER32.dll")
int MapWindowPoints(HWND hWndFrom, HWND hWndTo, POINT* lpPoints, uint cPoints);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getsyscolor))], [])
@DllImport("USER32.dll")
uint GetSysColor(SYS_COLOR_INDEX nIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getsyscolorbrush))], [])
@DllImport("USER32.dll")
HBRUSH GetSysColorBrush(SYS_COLOR_INDEX nIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setsyscolors))], [])
@DllImport("USER32.dll")
BOOL SetSysColors(int cElements, const(int)* lpaElements, const(COLORREF)* lpaRgbValues);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-drawfocusrect))], [])
@DllImport("USER32.dll")
BOOL DrawFocusRect(HDC hDC, const(RECT)* lprc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-fillrect))], [])
@DllImport("USER32.dll")
int FillRect(HDC hDC, const(RECT)* lprc, HBRUSH hbr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-framerect))], [])
@DllImport("USER32.dll")
int FrameRect(HDC hDC, const(RECT)* lprc, HBRUSH hbr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-invertrect))], [])
@DllImport("USER32.dll")
BOOL InvertRect(HDC hDC, const(RECT)* lprc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setrect))], [])
@DllImport("USER32.dll")
BOOL SetRect(RECT* lprc, int xLeft, int yTop, int xRight, int yBottom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setrectempty))], [])
@DllImport("USER32.dll")
BOOL SetRectEmpty(RECT* lprc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-copyrect))], [])
@DllImport("USER32.dll")
BOOL CopyRect(RECT* lprcDst, const(RECT)* lprcSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-inflaterect))], [])
@DllImport("USER32.dll")
BOOL InflateRect(RECT* lprc, int dx, int dy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-intersectrect))], [])
@DllImport("USER32.dll")
BOOL IntersectRect(RECT* lprcDst, const(RECT)* lprcSrc1, const(RECT)* lprcSrc2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-unionrect))], [])
@DllImport("USER32.dll")
BOOL UnionRect(RECT* lprcDst, const(RECT)* lprcSrc1, const(RECT)* lprcSrc2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-subtractrect))], [])
@DllImport("USER32.dll")
BOOL SubtractRect(RECT* lprcDst, const(RECT)* lprcSrc1, const(RECT)* lprcSrc2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-offsetrect))], [])
@DllImport("USER32.dll")
BOOL OffsetRect(RECT* lprc, int dx, int dy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-isrectempty))], [])
@DllImport("USER32.dll")
BOOL IsRectEmpty(const(RECT)* lprc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-equalrect))], [])
@DllImport("USER32.dll")
BOOL EqualRect(const(RECT)* lprc1, const(RECT)* lprc2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-ptinrect))], [])
@DllImport("USER32.dll")
BOOL PtInRect(const(RECT)* lprc, POINT pt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-loadbitmapa))], [])
@DllImport("USER32.dll")
HBITMAP LoadBitmapA(HINSTANCE hInstance, const(PSTR) lpBitmapName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-loadbitmapw))], [])
@DllImport("USER32.dll")
HBITMAP LoadBitmapW(HINSTANCE hInstance, const(PWSTR) lpBitmapName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-changedisplaysettingsa))], [])
@DllImport("USER32.dll")
DISP_CHANGE ChangeDisplaySettingsA(DEVMODEA* lpDevMode, CDS_TYPE dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-changedisplaysettingsw))], [])
@DllImport("USER32.dll")
DISP_CHANGE ChangeDisplaySettingsW(DEVMODEW* lpDevMode, CDS_TYPE dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-changedisplaysettingsexa))], [])
@DllImport("USER32.dll")
DISP_CHANGE ChangeDisplaySettingsExA(const(PSTR) lpszDeviceName, DEVMODEA* lpDevMode, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, 
                                     CDS_TYPE dwflags, void* lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-changedisplaysettingsexw))], [])
@DllImport("USER32.dll")
DISP_CHANGE ChangeDisplaySettingsExW(const(PWSTR) lpszDeviceName, DEVMODEW* lpDevMode, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HWND hwnd, 
                                     CDS_TYPE dwflags, void* lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enumdisplaysettingsa))], [])
@DllImport("USER32.dll")
BOOL EnumDisplaySettingsA(const(PSTR) lpszDeviceName, ENUM_DISPLAY_SETTINGS_MODE iModeNum, DEVMODEA* lpDevMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enumdisplaysettingsw))], [])
@DllImport("USER32.dll")
BOOL EnumDisplaySettingsW(const(PWSTR) lpszDeviceName, ENUM_DISPLAY_SETTINGS_MODE iModeNum, DEVMODEW* lpDevMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enumdisplaysettingsexa))], [])
@DllImport("USER32.dll")
BOOL EnumDisplaySettingsExA(const(PSTR) lpszDeviceName, ENUM_DISPLAY_SETTINGS_MODE iModeNum, DEVMODEA* lpDevMode, 
                            ENUM_DISPLAY_SETTINGS_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enumdisplaysettingsexw))], [])
@DllImport("USER32.dll")
BOOL EnumDisplaySettingsExW(const(PWSTR) lpszDeviceName, ENUM_DISPLAY_SETTINGS_MODE iModeNum, DEVMODEW* lpDevMode, 
                            ENUM_DISPLAY_SETTINGS_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enumdisplaydevicesa))], [])
@DllImport("USER32.dll")
BOOL EnumDisplayDevicesA(const(PSTR) lpDevice, uint iDevNum, DISPLAY_DEVICEA* lpDisplayDevice, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enumdisplaydevicesw))], [])
@DllImport("USER32.dll")
BOOL EnumDisplayDevicesW(const(PWSTR) lpDevice, uint iDevNum, DISPLAY_DEVICEW* lpDisplayDevice, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-monitorfrompoint))], [])
@DllImport("USER32.dll")
HMONITOR MonitorFromPoint(POINT pt, MONITOR_FROM_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-monitorfromrect))], [])
@DllImport("USER32.dll")
HMONITOR MonitorFromRect(RECT* lprc, MONITOR_FROM_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-monitorfromwindow))], [])
@DllImport("USER32.dll")
HMONITOR MonitorFromWindow(HWND hwnd, MONITOR_FROM_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getmonitorinfoa))], [])
@DllImport("USER32.dll")
BOOL GetMonitorInfoA(HMONITOR hMonitor, MONITORINFO* lpmi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getmonitorinfow))], [])
@DllImport("USER32.dll")
BOOL GetMonitorInfoW(HMONITOR hMonitor, MONITORINFO* lpmi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enumdisplaymonitors))], [])
@DllImport("USER32.dll")
BOOL EnumDisplayMonitors(HDC hdc, RECT* lprcClip, MONITORENUMPROC lpfnEnum, LPARAM dwData);


