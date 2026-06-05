// Written in the D programming language.

module windows.win32.system.dataexchange;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, HANDLE, HWND, LPARAM, PSTR, PWSTR, WPARAM;
public import windows.win32.graphics.gdi : HDC, HENHMETAFILE, HMETAFILE;
public import windows.win32.security : SECURITY_QUALITY_OF_SERVICE;

extern(Windows) @nogc nothrow:


// Enums


alias DDE_ENABLE_CALLBACK_CMD = uint;
enum : uint
{
    EC_ENABLEALL    = 0x00000000,
    EC_ENABLEONE    = 0x00000080,
    EC_DISABLE      = 0x00000008,
    EC_QUERYWAITING = 0x00000002,
}

alias DDE_INITIALIZE_COMMAND = uint;
enum : uint
{
    APPCLASS_MONITOR          = 0x00000001,
    APPCLASS_STANDARD         = 0x00000000,
    APPCMD_CLIENTONLY         = 0x00000010,
    APPCMD_FILTERINITS        = 0x00000020,
    CBF_FAIL_ALLSVRXACTIONS   = 0x0003f000,
    CBF_FAIL_ADVISES          = 0x00004000,
    CBF_FAIL_CONNECTIONS      = 0x00002000,
    CBF_FAIL_EXECUTES         = 0x00008000,
    CBF_FAIL_POKES            = 0x00010000,
    CBF_FAIL_REQUESTS         = 0x00020000,
    CBF_FAIL_SELFCONNECTIONS  = 0x00001000,
    CBF_SKIP_ALLNOTIFICATIONS = 0x003c0000,
    CBF_SKIP_CONNECT_CONFIRMS = 0x00040000,
    CBF_SKIP_DISCONNECTS      = 0x00200000,
    CBF_SKIP_REGISTRATIONS    = 0x00080000,
    CBF_SKIP_UNREGISTRATIONS  = 0x00100000,
    MF_CALLBACKS              = 0x08000000,
    MF_CONV                   = 0x40000000,
    MF_ERRORS                 = 0x10000000,
    MF_HSZ_INFO               = 0x01000000,
    MF_LINKS                  = 0x20000000,
    MF_POSTMSGS               = 0x04000000,
    MF_SENDMSGS               = 0x02000000,
}

alias DDE_NAME_SERVICE_CMD = uint;
enum : uint
{
    DNS_REGISTER   = 0x00000001,
    DNS_UNREGISTER = 0x00000002,
    DNS_FILTERON   = 0x00000004,
    DNS_FILTEROFF  = 0x00000008,
}

alias DDE_CLIENT_TRANSACTION_TYPE = uint;
enum : uint
{
    XTYP_ADVSTART        = 0x00001030,
    XTYP_ADVSTOP         = 0x00008040,
    XTYP_EXECUTE         = 0x00004050,
    XTYP_POKE            = 0x00004090,
    XTYP_REQUEST         = 0x000020b0,
    XTYP_ADVDATA         = 0x00004010,
    XTYP_ADVREQ          = 0x00002022,
    XTYP_CONNECT         = 0x00001062,
    XTYP_CONNECT_CONFIRM = 0x00008072,
    XTYP_DISCONNECT      = 0x000080c2,
    XTYP_MONITOR         = 0x000080f2,
    XTYP_REGISTER        = 0x000080a2,
    XTYP_UNREGISTER      = 0x000080d2,
    XTYP_WILDCONNECT     = 0x000020e2,
    XTYP_XACT_COMPLETE   = 0x00008080,
}

alias CONVINFO_CONVERSATION_STATE = uint;
enum : uint
{
    XST_ADVACKRCVD     = 0x0000000d,
    XST_ADVDATAACKRCVD = 0x00000010,
    XST_ADVDATASENT    = 0x0000000f,
    XST_ADVSENT        = 0x0000000b,
    XST_CONNECTED      = 0x00000002,
    XST_DATARCVD       = 0x00000006,
    XST_EXECACKRCVD    = 0x0000000a,
    XST_EXECSENT       = 0x00000009,
    XST_INCOMPLETE     = 0x00000001,
    XST_INIT1          = 0x00000003,
    XST_INIT2          = 0x00000004,
    XST_NULL           = 0x00000000,
    XST_POKEACKRCVD    = 0x00000008,
    XST_POKESENT       = 0x00000007,
    XST_REQSENT        = 0x00000005,
    XST_UNADVACKRCVD   = 0x0000000e,
    XST_UNADVSENT      = 0x0000000c,
}

alias CONVINFO_STATUS = uint;
enum : uint
{
    ST_ADVISE     = 0x00000002,
    ST_BLOCKED    = 0x00000008,
    ST_BLOCKNEXT  = 0x00000080,
    ST_CLIENT     = 0x00000010,
    ST_CONNECTED  = 0x00000001,
    ST_INLIST     = 0x00000040,
    ST_ISLOCAL    = 0x00000004,
    ST_ISSELF     = 0x00000100,
    ST_TERMINATED = 0x00000020,
}

// Constants


enum : uint
{
    WM_DDE_FIRST     = 0x000003e0,
    WM_DDE_INITIATE  = 0x000003e0,
    WM_DDE_TERMINATE = 0x000003e1,
    WM_DDE_ADVISE    = 0x000003e2,
    WM_DDE_UNADVISE  = 0x000003e3,
    WM_DDE_ACK       = 0x000003e4,
    WM_DDE_DATA      = 0x000003e5,
    WM_DDE_REQUEST   = 0x000003e6,
    WM_DDE_POKE      = 0x000003e7,
    WM_DDE_EXECUTE   = 0x000003e8,
    WM_DDE_LAST      = 0x000003e8,
}

enum : uint
{
    DDE_FACK      = 0x00008000,
    DDE_FBUSY     = 0x00004000,
    DDE_FDEFERUPD = 0x00004000,
}

enum : uint
{
    DDE_FRELEASE   = 0x00002000,
    DDE_FREQUESTED = 0x00001000,
}

enum uint DDE_FNOTPROCESSED = 0x00000000;

enum : int
{
    CP_WINANSI    = 0x000003ec,
    CP_WINUNICODE = 0x000004b0,
    CP_WINNEUTRAL = 0x000004b0,
}

enum : uint
{
    XTYPF_NODATA = 0x00000004,
    XTYPF_ACKREQ = 0x00000008,
}

enum : uint
{
    XCLASS_BOOL         = 0x00001000,
    XCLASS_DATA         = 0x00002000,
    XCLASS_FLAGS        = 0x00004000,
    XCLASS_NOTIFICATION = 0x00008000,
}

enum uint XTYP_SHIFT = 0x00000004;
enum uint QID_SYNC = 0xffffffff;

enum : const(wchar)*
{
    SZDDESYS_ITEM_TOPICS   = "Topics",
    SZDDESYS_ITEM_SYSITEMS = "SysItems",
    SZDDESYS_ITEM_RTNMSG   = "ReturnMessage",
    SZDDESYS_ITEM_STATUS   = "Status",
    SZDDESYS_ITEM_FORMATS  = "Formats",
    SZDDESYS_ITEM_HELP     = "Help",
}

enum int APPCMD_MASK = 0x00000ff0;
enum uint HDATA_APPOWNED = 0x00000001;

enum : uint
{
    DMLERR_FIRST         = 0x00004000,
    DMLERR_ADVACKTIMEOUT = 0x00004000,
}

enum uint DMLERR_DATAACKTIMEOUT = 0x00004002;

enum : uint
{
    DMLERR_DLL_USAGE      = 0x00004004,
    DMLERR_EXECACKTIMEOUT = 0x00004005,
}

enum : uint
{
    DMLERR_LOW_MEMORY   = 0x00004007,
    DMLERR_MEMORY_ERROR = 0x00004008,
}

enum uint DMLERR_NO_CONV_ESTABLISHED = 0x0000400a;
enum uint DMLERR_POSTMSG_FAILED = 0x0000400c;

enum : uint
{
    DMLERR_SERVER_DIED      = 0x0000400e,
    DMLERR_SYS_ERROR        = 0x0000400f,
    DMLERR_UNADVACKTIMEOUT  = 0x00004010,
    DMLERR_UNFOUND_QUEUE_ID = 0x00004011,
}

enum uint MH_CREATE = 0x00000001;
enum uint MH_DELETE = 0x00000003;
enum uint MAX_MONITORS = 0x00000004;

// Callbacks

alias PFNCALLBACK = HDDEDATA function(uint wType, uint wFmt, HCONV hConv, HSZ hsz1, HSZ hsz2, HDDEDATA hData, 
                                      size_t dwData1, size_t dwData2);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HSZ
{
    void* Value;
}

@RAIIFree!DdeDisconnect
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCONV
{
    void* Value;
}

@RAIIFree!DdeDisconnectList
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCONVLIST
{
    void* Value;
}

@RAIIFree!DdeFreeDataHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDDEDATA
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/ns-dde-ddeack))], [])
struct DDEACK
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fAck)), FixedArgSig(ElementSig(15)), FixedArgSig(ElementSig(1))], [])*/ushort _bitfield44;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/ns-dde-ddeadvise))], [])
struct DDEADVISE
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fAckReq)), FixedArgSig(ElementSig(15)), FixedArgSig(ElementSig(1))], [])*/ushort _bitfield45;
    short cfFormat;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/ns-dde-ddedata))], [])
struct DDEDATA
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fAckReq)), FixedArgSig(ElementSig(15)), FixedArgSig(ElementSig(1))], [])*/ushort _bitfield46;
    short cfFormat;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/ns-dde-ddepoke))], [])
struct DDEPOKE
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fReserved)), FixedArgSig(ElementSig(14)), FixedArgSig(ElementSig(2))], [])*/ushort _bitfield47;
    short cfFormat;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Value;
}

struct DDELN
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fAckReq)), FixedArgSig(ElementSig(15)), FixedArgSig(ElementSig(1))], [])*/ushort _bitfield48;
    short cfFormat;
}

struct DDEUP
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fAckReq)), FixedArgSig(ElementSig(15)), FixedArgSig(ElementSig(1))], [])*/ushort _bitfield49;
    short cfFormat;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] rgb;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-hszpair))], [])
struct HSZPAIR
{
    HSZ hszSvc;
    HSZ hszTopic;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-convcontext))], [])
struct CONVCONTEXT
{
    uint cb;
    uint wFlags;
    uint wCountryID;
    int  iCodePage;
    uint dwLangID;
    uint dwSecurity;
    SECURITY_QUALITY_OF_SERVICE qos;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-convinfo))], [])
struct CONVINFO
{
    uint            cb;
    size_t          hUser;
    HCONV           hConvPartner;
    HSZ             hszSvcPartner;
    HSZ             hszServiceReq;
    HSZ             hszTopic;
    HSZ             hszItem;
    uint            wFmt;
    DDE_CLIENT_TRANSACTION_TYPE wType;
    CONVINFO_STATUS wStatus;
    CONVINFO_CONVERSATION_STATE wConvst;
    uint            wLastError;
    HCONVLIST       hConvList;
    CONVCONTEXT     ConvCtxt;
    HWND            hwnd;
    HWND            hwndPartner;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-ddeml_msg_hook_data))], [])
struct DDEML_MSG_HOOK_DATA
{
    size_t  uiLo;
    size_t  uiHi;
    uint    cbData;
    uint[8] Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monmsgstruct))], [])
struct MONMSGSTRUCT
{
    uint                cb;
    HWND                hwndTo;
    uint                dwTime;
    HANDLE              hTask;
    uint                wMsg;
    WPARAM              wParam;
    LPARAM              lParam;
    DDEML_MSG_HOOK_DATA dmhd;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-moncbstruct))], [])
struct MONCBSTRUCT
{
    uint        cb;
    uint        dwTime;
    HANDLE      hTask;
    uint        dwRet;
    uint        wType;
    uint        wFmt;
    HCONV       hConv;
    HSZ         hsz1;
    HSZ         hsz2;
    HDDEDATA    hData;
    size_t      dwData1;
    size_t      dwData2;
    CONVCONTEXT cc;
    uint        cbData;
    uint[8]     Data;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monhszstructa))], [])
struct MONHSZSTRUCTA
{
    uint   cb;
    BOOL   fsAction;
    uint   dwTime;
    HSZ    hsz;
    HANDLE hTask;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/CHAR[1] str;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monhszstructw))], [])
struct MONHSZSTRUCTW
{
    uint   cb;
    BOOL   fsAction;
    uint   dwTime;
    HSZ    hsz;
    HANDLE hTask;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] str;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monerrstruct))], [])
struct MONERRSTRUCT
{
    uint   cb;
    uint   wLastError;
    uint   dwTime;
    HANDLE hTask;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monlinkstruct))], [])
struct MONLINKSTRUCT
{
    uint   cb;
    uint   dwTime;
    HANDLE hTask;
    BOOL   fEstablished;
    BOOL   fNoData;
    HSZ    hszSvc;
    HSZ    hszTopic;
    HSZ    hszItem;
    uint   wFmt;
    BOOL   fServer;
    HCONV  hConvServer;
    HCONV  hConvClient;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monconvstruct))], [])
struct MONCONVSTRUCT
{
    uint   cb;
    BOOL   fConnect;
    uint   dwTime;
    HANDLE hTask;
    HSZ    hszSvc;
    HSZ    hszTopic;
    HCONV  hConvClient;
    HCONV  hConvServer;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-metafilepict))], [])
struct METAFILEPICT
{
    int       mm;
    int       xExt;
    int       yExt;
    HMETAFILE hMF;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-copydatastruct))], [])
struct COPYDATASTRUCT
{
    size_t dwData;
    uint   cbData;
    void*  lpData;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/nf-dde-ddesetqualityofservice))], [])
@DllImport("USER32.dll")
BOOL DdeSetQualityOfService(HWND hwndClient, const(SECURITY_QUALITY_OF_SERVICE)* pqosNew, 
                            SECURITY_QUALITY_OF_SERVICE* pqosPrev);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/nf-dde-impersonateddeclientwindow))], [])
@DllImport("USER32.dll")
BOOL ImpersonateDdeClientWindow(HWND hWndClient, HWND hWndServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/nf-dde-packddelparam))], [])
@DllImport("USER32.dll")
LPARAM PackDDElParam(uint msg, size_t uiLo, size_t uiHi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/nf-dde-unpackddelparam))], [])
@DllImport("USER32.dll")
BOOL UnpackDDElParam(uint msg, LPARAM lParam, size_t* puiLo, size_t* puiHi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/nf-dde-freeddelparam))], [])
@DllImport("USER32.dll")
BOOL FreeDDElParam(uint msg, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dde/nf-dde-reuseddelparam))], [])
@DllImport("USER32.dll")
LPARAM ReuseDDElParam(LPARAM lParam, uint msgIn, uint msgOut, size_t uiLo, size_t uiHi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeinitializea))], [])
@DllImport("USER32.dll")
uint DdeInitializeA(uint* pidInst, PFNCALLBACK pfnCallback, DDE_INITIALIZE_COMMAND afCmd, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint ulRes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeinitializew))], [])
@DllImport("USER32.dll")
uint DdeInitializeW(uint* pidInst, PFNCALLBACK pfnCallback, DDE_INITIALIZE_COMMAND afCmd, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint ulRes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeuninitialize))], [])
@DllImport("USER32.dll")
BOOL DdeUninitialize(uint idInst);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeconnectlist))], [])
@DllImport("USER32.dll")
HCONVLIST DdeConnectList(uint idInst, HSZ hszService, HSZ hszTopic, HCONVLIST hConvList, CONVCONTEXT* pCC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddequerynextserver))], [])
@DllImport("USER32.dll")
HCONV DdeQueryNextServer(HCONVLIST hConvList, HCONV hConvPrev);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddedisconnectlist))], [])
@DllImport("USER32.dll")
BOOL DdeDisconnectList(HCONVLIST hConvList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeconnect))], [])
@DllImport("USER32.dll")
HCONV DdeConnect(uint idInst, HSZ hszService, HSZ hszTopic, CONVCONTEXT* pCC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddedisconnect))], [])
@DllImport("USER32.dll")
BOOL DdeDisconnect(HCONV hConv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddereconnect))], [])
@DllImport("USER32.dll")
HCONV DdeReconnect(HCONV hConv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddequeryconvinfo))], [])
@DllImport("USER32.dll")
uint DdeQueryConvInfo(HCONV hConv, uint idTransaction, CONVINFO* pConvInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddesetuserhandle))], [])
@DllImport("USER32.dll")
BOOL DdeSetUserHandle(HCONV hConv, uint id, size_t hUser);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeabandontransaction))], [])
@DllImport("USER32.dll")
BOOL DdeAbandonTransaction(uint idInst, HCONV hConv, uint idTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddepostadvise))], [])
@DllImport("USER32.dll")
BOOL DdePostAdvise(uint idInst, HSZ hszTopic, HSZ hszItem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeenablecallback))], [])
@DllImport("USER32.dll")
BOOL DdeEnableCallback(uint idInst, HCONV hConv, DDE_ENABLE_CALLBACK_CMD wCmd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeimpersonateclient))], [])
@DllImport("USER32.dll")
BOOL DdeImpersonateClient(HCONV hConv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddenameservice))], [])
@DllImport("USER32.dll")
HDDEDATA DdeNameService(uint idInst, HSZ hsz1, HSZ hsz2, DDE_NAME_SERVICE_CMD afCmd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeclienttransaction))], [])
@DllImport("USER32.dll")
HDDEDATA DdeClientTransaction(ubyte* pData, uint cbData, HCONV hConv, HSZ hszItem, uint wFmt, 
                              DDE_CLIENT_TRANSACTION_TYPE wType, uint dwTimeout, uint* pdwResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddecreatedatahandle))], [])
@DllImport("USER32.dll")
HDDEDATA DdeCreateDataHandle(uint idInst, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pSrc, 
                             uint cb, uint cbOff, HSZ hszItem, uint wFmt, uint afCmd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeadddata))], [])
@DllImport("USER32.dll")
HDDEDATA DdeAddData(HDDEDATA hData, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pSrc, 
                    uint cb, uint cbOff);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddegetdata))], [])
@DllImport("USER32.dll")
uint DdeGetData(HDDEDATA hData, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pDst, 
                uint cbMax, uint cbOff);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeaccessdata))], [])
@DllImport("USER32.dll")
ubyte* DdeAccessData(HDDEDATA hData, uint* pcbDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddeunaccessdata))], [])
@DllImport("USER32.dll")
BOOL DdeUnaccessData(HDDEDATA hData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddefreedatahandle))], [])
@DllImport("USER32.dll")
BOOL DdeFreeDataHandle(HDDEDATA hData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddegetlasterror))], [])
@DllImport("USER32.dll")
uint DdeGetLastError(uint idInst);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddecreatestringhandlea))], [])
@DllImport("USER32.dll")
HSZ DdeCreateStringHandleA(uint idInst, const(PSTR) psz, int iCodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddecreatestringhandlew))], [])
@DllImport("USER32.dll")
HSZ DdeCreateStringHandleW(uint idInst, const(PWSTR) psz, int iCodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddequerystringa))], [])
@DllImport("USER32.dll")
uint DdeQueryStringA(uint idInst, HSZ hsz, PSTR psz, uint cchMax, int iCodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddequerystringw))], [])
@DllImport("USER32.dll")
uint DdeQueryStringW(uint idInst, HSZ hsz, PWSTR psz, uint cchMax, int iCodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddefreestringhandle))], [])
@DllImport("USER32.dll")
BOOL DdeFreeStringHandle(uint idInst, HSZ hsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddekeepstringhandle))], [])
@DllImport("USER32.dll")
BOOL DdeKeepStringHandle(uint idInst, HSZ hsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ddeml/nf-ddeml-ddecmpstringhandles))], [])
@DllImport("USER32.dll")
int DdeCmpStringHandles(HSZ hsz1, HSZ hsz2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wingdi/nf-wingdi-setwinmetafilebits))], [])
@DllImport("GDI32.dll")
HENHMETAFILE SetWinMetaFileBits(uint nSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/const(ubyte)* lpMeta16Data, 
                                HDC hdcRef, const(METAFILEPICT)* lpMFP);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-openclipboard))], [])
@DllImport("USER32.dll")
BOOL OpenClipboard(HWND hWndNewOwner);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-closeclipboard))], [])
@DllImport("USER32.dll")
BOOL CloseClipboard();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getclipboardsequencenumber))], [])
@DllImport("USER32.dll")
uint GetClipboardSequenceNumber();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getclipboardowner))], [])
@DllImport("USER32.dll")
HWND GetClipboardOwner();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setclipboardviewer))], [])
@DllImport("USER32.dll")
HWND SetClipboardViewer(HWND hWndNewViewer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getclipboardviewer))], [])
@DllImport("USER32.dll")
HWND GetClipboardViewer();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-changeclipboardchain))], [])
@DllImport("USER32.dll")
BOOL ChangeClipboardChain(HWND hWndRemove, HWND hWndNewNext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setclipboarddata))], [])
@DllImport("USER32.dll")
HANDLE SetClipboardData(uint uFormat, HANDLE hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getclipboarddata))], [])
@DllImport("USER32.dll")
HANDLE GetClipboardData(uint uFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-registerclipboardformata))], [])
@DllImport("USER32.dll")
uint RegisterClipboardFormatA(const(PSTR) lpszFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-registerclipboardformatw))], [])
@DllImport("USER32.dll")
uint RegisterClipboardFormatW(const(PWSTR) lpszFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-countclipboardformats))], [])
@DllImport("USER32.dll")
int CountClipboardFormats();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-enumclipboardformats))], [])
@DllImport("USER32.dll")
uint EnumClipboardFormats(uint format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getclipboardformatnamea))], [])
@DllImport("USER32.dll")
int GetClipboardFormatNameA(uint format, PSTR lpszFormatName, int cchMaxCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getclipboardformatnamew))], [])
@DllImport("USER32.dll")
int GetClipboardFormatNameW(uint format, PWSTR lpszFormatName, int cchMaxCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-emptyclipboard))], [])
@DllImport("USER32.dll")
BOOL EmptyClipboard();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-isclipboardformatavailable))], [])
@DllImport("USER32.dll")
BOOL IsClipboardFormatAvailable(uint format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getpriorityclipboardformat))], [])
@DllImport("USER32.dll")
int GetPriorityClipboardFormat(uint* paFormatPriorityList, int cFormats);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getopenclipboardwindow))], [])
@DllImport("USER32.dll")
HWND GetOpenClipboardWindow();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-addclipboardformatlistener))], [])
@DllImport("USER32.dll")
BOOL AddClipboardFormatListener(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-removeclipboardformatlistener))], [])
@DllImport("USER32.dll")
BOOL RemoveClipboardFormatListener(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-getupdatedclipboardformats))], [])
@DllImport("USER32.dll")
BOOL GetUpdatedClipboardFormats(uint* lpuiFormats, uint cFormats, uint* pcFormatsOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globaldeleteatom))], [])
@DllImport("KERNEL32.dll")
ushort GlobalDeleteAtom(ushort nAtom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-initatomtable))], [])
@DllImport("KERNEL32.dll")
BOOL InitAtomTable(uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-deleteatom))], [])
@DllImport("KERNEL32.dll")
ushort DeleteAtom(ushort nAtom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globaladdatoma))], [])
@DllImport("KERNEL32.dll")
ushort GlobalAddAtomA(const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globaladdatomw))], [])
@DllImport("KERNEL32.dll")
ushort GlobalAddAtomW(const(PWSTR) lpString);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globaladdatomexa))], [])
@DllImport("KERNEL32.dll")
ushort GlobalAddAtomExA(const(PSTR) lpString, uint Flags);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globaladdatomexw))], [])
@DllImport("KERNEL32.dll")
ushort GlobalAddAtomExW(const(PWSTR) lpString, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globalfindatoma))], [])
@DllImport("KERNEL32.dll")
ushort GlobalFindAtomA(const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globalfindatomw))], [])
@DllImport("KERNEL32.dll")
ushort GlobalFindAtomW(const(PWSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globalgetatomnamea))], [])
@DllImport("KERNEL32.dll")
uint GlobalGetAtomNameA(ushort nAtom, PSTR lpBuffer, int nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globalgetatomnamew))], [])
@DllImport("KERNEL32.dll")
uint GlobalGetAtomNameW(ushort nAtom, PWSTR lpBuffer, int nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-addatoma))], [])
@DllImport("KERNEL32.dll")
ushort AddAtomA(const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-addatomw))], [])
@DllImport("KERNEL32.dll")
ushort AddAtomW(const(PWSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-findatoma))], [])
@DllImport("KERNEL32.dll")
ushort FindAtomA(const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-findatomw))], [])
@DllImport("KERNEL32.dll")
ushort FindAtomW(const(PWSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-getatomnamea))], [])
@DllImport("KERNEL32.dll")
uint GetAtomNameA(ushort nAtom, PSTR lpBuffer, int nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-getatomnamew))], [])
@DllImport("KERNEL32.dll")
uint GetAtomNameW(ushort nAtom, PWSTR lpBuffer, int nSize);


