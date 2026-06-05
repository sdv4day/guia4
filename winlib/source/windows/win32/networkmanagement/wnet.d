// Written in the D programming language.

module windows.win32.networkmanagement.wnet;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HWND, LUID, PSTR, PWSTR, WIN32_ERROR;

extern(Windows) @nogc nothrow:


// Enums


alias UNC_INFO_LEVEL = uint;
enum : uint
{
    UNIVERSAL_NAME_INFO_LEVEL = 0x00000001,
    REMOTE_NAME_INFO_LEVEL    = 0x00000002,
}

alias WNPERM_DLG = uint;
enum : uint
{
    WNPERM_DLG_PERM  = 0x00000000,
    WNPERM_DLG_AUDIT = 0x00000001,
    WNPERM_DLG_OWNER = 0x00000002,
}

alias WNET_OPEN_ENUM_USAGE = uint;
enum : uint
{
    RESOURCEUSAGE_NONE        = 0x00000000,
    RESOURCEUSAGE_CONNECTABLE = 0x00000001,
    RESOURCEUSAGE_CONTAINER   = 0x00000002,
    RESOURCEUSAGE_ATTACHED    = 0x00000010,
    RESOURCEUSAGE_ALL         = 0x00000013,
}

alias NET_CONNECT_FLAGS = uint;
enum : uint
{
    CONNECT_UPDATE_PROFILE          = 0x00000001,
    CONNECT_UPDATE_RECENT           = 0x00000002,
    CONNECT_TEMPORARY               = 0x00000004,
    CONNECT_INTERACTIVE             = 0x00000008,
    CONNECT_PROMPT                  = 0x00000010,
    CONNECT_NEED_DRIVE              = 0x00000020,
    CONNECT_REFCOUNT                = 0x00000040,
    CONNECT_REDIRECT                = 0x00000080,
    CONNECT_LOCALDRIVE              = 0x00000100,
    CONNECT_CURRENT_MEDIA           = 0x00000200,
    CONNECT_DEFERRED                = 0x00000400,
    CONNECT_RESERVED                = 0xff000000,
    CONNECT_COMMANDLINE             = 0x00000800,
    CONNECT_CMD_SAVECRED            = 0x00001000,
    CONNECT_CRED_RESET              = 0x00002000,
    CONNECT_REQUIRE_INTEGRITY       = 0x00004000,
    CONNECT_REQUIRE_PRIVACY         = 0x00008000,
    CONNECT_WRITE_THROUGH_SEMANTICS = 0x00010000,
    CONNECT_GLOBAL_MAPPING          = 0x00040000,
}

alias NP_PROPERTY_DIALOG_SELECTION = uint;
enum : uint
{
    WNPS_FILE = 0x00000000,
    WNPS_DIR  = 0x00000001,
    WNPS_MULT = 0x00000002,
}

alias NPDIRECTORY_NOTIFY_OPERATION = uint;
enum : uint
{
    WNDN_MKDIR = 0x00000001,
    WNDN_RMDIR = 0x00000002,
    WNDN_MVDIR = 0x00000003,
}

alias NET_RESOURCE_TYPE = uint;
enum : uint
{
    RESOURCETYPE_ANY   = 0x00000000,
    RESOURCETYPE_DISK  = 0x00000001,
    RESOURCETYPE_PRINT = 0x00000002,
}

alias NETWORK_NAME_FORMAT_FLAGS = uint;
enum : uint
{
    WNFMT_MULTILINE   = 0x00000001,
    WNFMT_ABBREVIATED = 0x00000002,
}

alias NET_RESOURCE_SCOPE = uint;
enum : uint
{
    RESOURCE_CONNECTED  = 0x00000001,
    RESOURCE_CONTEXT    = 0x00000005,
    RESOURCE_GLOBALNET  = 0x00000002,
    RESOURCE_REMEMBERED = 0x00000003,
}

alias NETINFOSTRUCT_CHARACTERISTICS = uint;
enum : uint
{
    NETINFO_DLL16      = 0x00000001,
    NETINFO_DISKRED    = 0x00000004,
    NETINFO_PRINTERRED = 0x00000008,
}

alias CONNECTDLGSTRUCT_FLAGS = uint;
enum : uint
{
    CONNDLG_RO_PATH     = 0x00000001,
    CONNDLG_CONN_POINT  = 0x00000002,
    CONNDLG_USE_MRU     = 0x00000004,
    CONNDLG_HIDE_BOX    = 0x00000008,
    CONNDLG_PERSIST     = 0x00000010,
    CONNDLG_NOT_PERSIST = 0x00000020,
}

alias DISCDLGSTRUCT_FLAGS = uint;
enum : uint
{
    DISC_UPDATE_PROFILE = 0x00000001,
    DISC_NO_FORCE       = 0x00000040,
}

// Constants


enum : uint
{
    WNGETCON_CONNECTED    = 0x00000000,
    WNGETCON_DISCONNECTED = 0x00000001,
}

enum uint WNNC_SPEC_VERSION51 = 0x00050001;
enum uint WNNC_NET_NONE = 0x00000000;

enum : uint
{
    WNNC_USER        = 0x00000004,
    WNNC_USR_GETUSER = 0x00000001,
}

enum : uint
{
    WNNC_CON_ADDCONNECTION    = 0x00000001,
    WNNC_CON_CANCELCONNECTION = 0x00000002,
}

enum : uint
{
    WNNC_CON_ADDCONNECTION3 = 0x00000008,
    WNNC_CON_ADDCONNECTION4 = 0x00000010,
}

enum uint WNNC_CON_GETPERFORMANCE = 0x00000040;

enum : uint
{
    WNNC_DIALOG             = 0x00000008,
    WNNC_DLG_DEVICEMODE     = 0x00000001,
    WNNC_DLG_PROPERTYDIALOG = 0x00000020,
}

enum uint WNNC_DLG_FORMATNETWORKNAME = 0x00000080;

enum : uint
{
    WNNC_DLG_GETRESOURCEPARENT      = 0x00000200,
    WNNC_DLG_GETRESOURCEINFORMATION = 0x00000800,
}

enum uint WNNC_ADM_GETDIRECTORYTYPE = 0x00000001;

enum : uint
{
    WNNC_ENUMERATION    = 0x0000000b,
    WNNC_ENUM_GLOBAL    = 0x00000001,
    WNNC_ENUM_LOCAL     = 0x00000002,
    WNNC_ENUM_CONTEXT   = 0x00000004,
    WNNC_ENUM_SHAREABLE = 0x00000008,
}

enum uint WNNC_WAIT_FOR_START = 0x00000001;

enum : uint
{
    WNTYPE_DRIVE   = 0x00000001,
    WNTYPE_FILE    = 0x00000002,
    WNTYPE_PRINTER = 0x00000003,
    WNTYPE_COMM    = 0x00000004,
}

enum : uint
{
    WNDT_NORMAL  = 0x00000000,
    WNDT_NETWORK = 0x00000001,
}

enum uint WN_CREDENTIAL_CLASS = 0x00000002;
enum uint WN_SERVICE_CLASS = 0x00000008;
enum uint WN_NT_PASSWORD_CHANGED = 0x00000002;
enum uint NOTIFY_POST = 0x00000002;

enum : uint
{
    WNPERMC_AUDIT = 0x00000002,
    WNPERMC_OWNER = 0x00000004,
}

enum : uint
{
    RESOURCETYPE_RESERVED = 0x00000008,
    RESOURCETYPE_UNKNOWN  = 0xffffffff,
}

enum : uint
{
    RESOURCEUSAGE_SIBLING  = 0x00000008,
    RESOURCEUSAGE_RESERVED = 0x80000000,
}

enum : uint
{
    RESOURCEDISPLAYTYPE_ROOT         = 0x00000007,
    RESOURCEDISPLAYTYPE_SHAREADMIN   = 0x00000008,
    RESOURCEDISPLAYTYPE_DIRECTORY    = 0x00000009,
    RESOURCEDISPLAYTYPE_NDSCONTAINER = 0x0000000b,
}

enum : uint
{
    WNFMT_INENUM     = 0x00000010,
    WNFMT_CONNECTION = 0x00000020,
}

enum uint WNCON_NOTROUTED = 0x00000002;
enum uint WNCON_DYNAMIC = 0x00000008;

// Callbacks

alias PF_NPAddConnection = uint function(NETRESOURCEW* lpNetResource, PWSTR lpPassword, PWSTR lpUserName);
alias PF_NPAddConnection3 = uint function(HWND hwndOwner, NETRESOURCEW* lpNetResource, PWSTR lpPassword, 
                                          PWSTR lpUserName, uint dwFlags);
alias PF_NPAddConnection4 = uint function(HWND hwndOwner, NETRESOURCEW* lpNetResource, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpAuthBuffer, 
                                          uint cbAuthBuffer, uint dwFlags, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                          uint cbUseOptions);
alias PF_NPCancelConnection = uint function(PWSTR lpName, BOOL fForce);
alias PF_NPCancelConnection2 = uint function(PWSTR lpName, BOOL fForce, uint dwFlags);
alias PF_NPGetConnection = uint function(PWSTR lpLocalName, PWSTR lpRemoteName, uint* lpnBufferLen);
alias PF_NPGetConnection3 = uint function(const(PWSTR) lpLocalName, uint dwLevel, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                          uint* lpBufferSize);
alias PF_NPGetUniversalName = uint function(const(PWSTR) lpLocalPath, uint dwInfoLevel, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                            uint* lpnBufferSize);
alias PF_NPGetConnectionPerformance = uint function(const(PWSTR) lpRemoteName, 
                                                    NETCONNECTINFOSTRUCT* lpNetConnectInfo);
alias PF_NPOpenEnum = uint function(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, 
                                    HANDLE* lphEnum);
alias PF_NPEnumResource = uint function(HANDLE hEnum, uint* lpcCount, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                        uint* lpBufferSize);
alias PF_NPCloseEnum = uint function(HANDLE hEnum);
alias PF_NPGetCaps = uint function(uint ndex);
alias PF_NPGetUser = uint function(PWSTR lpName, PWSTR lpUserName, uint* lpnBufferLen);
alias PF_NPGetPersistentUseOptionsForConnection = uint function(PWSTR lpRemotePath, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* lpReadUseOptions, 
                                                                uint cbReadUseOptions, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpWriteUseOptions, 
                                                                uint* lpSizeWriteUseOptions);
alias PF_NPDeviceMode = uint function(HWND hParent);
alias PF_NPSearchDialog = uint function(HWND hwndParent, NETRESOURCEW* lpNetResource, void* lpBuffer, 
                                        uint cbBuffer, uint* lpnFlags);
alias PF_NPGetResourceParent = uint function(NETRESOURCEW* lpNetResource, 
                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                             uint* lpBufferSize);
alias PF_NPGetResourceInformation = uint function(NETRESOURCEW* lpNetResource, 
                                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                                  uint* lpBufferSize, PWSTR* lplpSystem);
alias PF_NPFormatNetworkName = uint function(PWSTR lpRemoteName, PWSTR lpFormattedName, uint* lpnLength, 
                                             uint dwFlags, uint dwAveCharPerLine);
alias PF_NPGetPropertyText = uint function(uint iButton, uint nPropSel, PWSTR lpName, PWSTR lpButtonName, 
                                           uint nButtonNameLen, uint nType);
alias PF_NPPropertyDialog = uint function(HWND hwndParent, uint iButtonDlg, uint nPropSel, PWSTR lpFileName, 
                                          uint nType);
alias PF_NPGetDirectoryType = uint function(PWSTR lpName, int* lpType, BOOL bFlushCache);
alias PF_NPDirectoryNotify = uint function(HWND hwnd, PWSTR lpDir, uint dwOper);
alias PF_NPLogonNotify = uint function(LUID* lpLogonId, const(PWSTR) lpAuthentInfoType, void* lpAuthentInfo, 
                                       const(PWSTR) lpPreviousAuthentInfoType, void* lpPreviousAuthentInfo, 
                                       PWSTR lpStationName, void* StationHandle, PWSTR* lpLogonScript);
alias PF_NPPasswordChangeNotify = uint function(const(PWSTR) lpAuthentInfoType, void* lpAuthentInfo, 
                                                const(PWSTR) lpPreviousAuthentInfoType, void* lpPreviousAuthentInfo, 
                                                PWSTR lpStationName, void* StationHandle, uint dwChangeInfo);
alias PF_AddConnectNotify = uint function(NOTIFYINFO* lpNotifyInfo, NOTIFYADD* lpAddInfo);
alias PF_CancelConnectNotify = uint function(NOTIFYINFO* lpNotifyInfo, NOTIFYCANCEL* lpCancelInfo);
alias PF_NPFMXGetPermCaps = uint function(PWSTR lpDriveName);
alias PF_NPFMXEditPerm = uint function(PWSTR lpDriveName, HWND hwndFMX, uint nDialogType);
alias PF_NPFMXGetPermHelp = uint function(PWSTR lpDriveName, uint nDialogType, BOOL fDirectory, 
                                          void* lpFileNameBuffer, uint* lpBufferSize, uint* lpnHelpContext);

// Structs


//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-netresourcea))], [])
struct NETRESOURCEA
{
    NET_RESOURCE_SCOPE dwScope;
    NET_RESOURCE_TYPE  dwType;
    uint               dwDisplayType;
    uint               dwUsage;
    PSTR               lpLocalName;
    PSTR               lpRemoteName;
    PSTR               lpComment;
    PSTR               lpProvider;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-netresourcew))], [])
struct NETRESOURCEW
{
    NET_RESOURCE_SCOPE dwScope;
    NET_RESOURCE_TYPE  dwType;
    uint               dwDisplayType;
    uint               dwUsage;
    PWSTR              lpLocalName;
    PWSTR              lpRemoteName;
    PWSTR              lpComment;
    PWSTR              lpProvider;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-connectdlgstructa))], [])
struct CONNECTDLGSTRUCTA
{
    uint          cbStructure;
    HWND          hwndOwner;
    NETRESOURCEA* lpConnRes;
    CONNECTDLGSTRUCT_FLAGS dwFlags;
    uint          dwDevNum;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-connectdlgstructw))], [])
struct CONNECTDLGSTRUCTW
{
    uint          cbStructure;
    HWND          hwndOwner;
    NETRESOURCEW* lpConnRes;
    CONNECTDLGSTRUCT_FLAGS dwFlags;
    uint          dwDevNum;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-discdlgstructa))], [])
struct DISCDLGSTRUCTA
{
    uint                cbStructure;
    HWND                hwndOwner;
    PSTR                lpLocalName;
    PSTR                lpRemoteName;
    DISCDLGSTRUCT_FLAGS dwFlags;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-discdlgstructw))], [])
struct DISCDLGSTRUCTW
{
    uint                cbStructure;
    HWND                hwndOwner;
    PWSTR               lpLocalName;
    PWSTR               lpRemoteName;
    DISCDLGSTRUCT_FLAGS dwFlags;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-universal_name_infoa))], [])
struct UNIVERSAL_NAME_INFOA
{
    PSTR lpUniversalName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-universal_name_infow))], [])
struct UNIVERSAL_NAME_INFOW
{
    PWSTR lpUniversalName;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-remote_name_infoa))], [])
struct REMOTE_NAME_INFOA
{
    PSTR lpUniversalName;
    PSTR lpConnectionName;
    PSTR lpRemainingPath;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-remote_name_infow))], [])
struct REMOTE_NAME_INFOW
{
    PWSTR lpUniversalName;
    PWSTR lpConnectionName;
    PWSTR lpRemainingPath;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-netinfostruct))], [])
struct NETINFOSTRUCT
{
    uint        cbStructure;
    uint        dwProviderVersion;
    WIN32_ERROR dwStatus;
    NETINFOSTRUCT_CHARACTERISTICS dwCharacteristics;
    size_t      dwHandle;
    ushort      wNetType;
    uint        dwPrinters;
    uint        dwDrives;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/ns-winnetwk-netconnectinfostruct))], [])
struct NETCONNECTINFOSTRUCT
{
    uint cbStructure;
    uint dwFlags;
    uint dwSpeed;
    uint dwDelay;
    uint dwOptDataSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/ns-npapi-notifyinfo))], [])
struct NOTIFYINFO
{
    uint  dwNotifyStatus;
    uint  dwOperationStatus;
    void* lpContext;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/ns-npapi-notifyadd))], [])
struct NOTIFYADD
{
    HWND              hwndOwner;
    NETRESOURCEA      NetResource;
    NET_CONNECT_FLAGS dwAddFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/ns-npapi-notifycancel))], [])
struct NOTIFYCANCEL
{
    PWSTR lpName;
    PWSTR lpProvider;
    uint  dwFlags;
    BOOL  fForce;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetaddconnectiona))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnectionA(const(PSTR) lpRemoteName, const(PSTR) lpPassword, const(PSTR) lpLocalName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetaddconnectionw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnectionW(const(PWSTR) lpRemoteName, const(PWSTR) lpPassword, const(PWSTR) lpLocalName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetaddconnection2a))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection2A(NETRESOURCEA* lpNetResource, const(PSTR) lpPassword, const(PSTR) lpUserName, 
                                NET_CONNECT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetaddconnection2w))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection2W(NETRESOURCEW* lpNetResource, const(PWSTR) lpPassword, const(PWSTR) lpUserName, 
                                NET_CONNECT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetaddconnection3a))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection3A(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(PSTR) lpPassword, 
                                const(PSTR) lpUserName, NET_CONNECT_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetaddconnection3w))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection3W(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(PWSTR) lpPassword, 
                                const(PWSTR) lpUserName, NET_CONNECT_FLAGS dwFlags);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pAuthBuffer, 
                                uint cbAuthBuffer, NET_CONNECT_FLAGS dwFlags, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                uint cbUseOptions);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetAddConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pAuthBuffer, 
                                uint cbAuthBuffer, NET_CONNECT_FLAGS dwFlags, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                uint cbUseOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetcancelconnectiona))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCancelConnectionA(const(PSTR) lpName, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetcancelconnectionw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCancelConnectionW(const(PWSTR) lpName, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetcancelconnection2a))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCancelConnection2A(const(PSTR) lpName, NET_CONNECT_FLAGS dwFlags, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetcancelconnection2w))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCancelConnection2W(const(PWSTR) lpName, NET_CONNECT_FLAGS dwFlags, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetconnectiona))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetConnectionA(const(PSTR) lpLocalName, PSTR lpRemoteName, uint* lpnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetconnectionw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetConnectionW(const(PWSTR) lpLocalName, PWSTR lpRemoteName, uint* lpnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetuseconnectiona))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetUseConnectionA(HWND hwndOwner, NETRESOURCEA* lpNetResource, const(PSTR) lpPassword, 
                               const(PSTR) lpUserId, NET_CONNECT_FLAGS dwFlags, PSTR lpAccessName, 
                               uint* lpBufferSize, uint* lpResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetuseconnectionw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetUseConnectionW(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(PWSTR) lpPassword, 
                               const(PWSTR) lpUserId, NET_CONNECT_FLAGS dwFlags, PWSTR lpAccessName, 
                               uint* lpBufferSize, uint* lpResult);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetUseConnection4A(HWND hwndOwner, NETRESOURCEA* lpNetResource, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pAuthBuffer, 
                                uint cbAuthBuffer, uint dwFlags, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                uint cbUseOptions, PSTR lpAccessName, uint* lpBufferSize, uint* lpResult);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetUseConnection4W(HWND hwndOwner, NETRESOURCEW* lpNetResource, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pAuthBuffer, 
                                uint cbAuthBuffer, uint dwFlags, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                                uint cbUseOptions, PWSTR lpAccessName, uint* lpBufferSize, uint* lpResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetconnectiondialog))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetConnectionDialog(HWND hwnd, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetdisconnectdialog))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetDisconnectDialog(HWND hwnd, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetconnectiondialog1a))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetConnectionDialog1A(CONNECTDLGSTRUCTA* lpConnDlgStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetconnectiondialog1w))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetConnectionDialog1W(CONNECTDLGSTRUCTW* lpConnDlgStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetdisconnectdialog1a))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetDisconnectDialog1A(DISCDLGSTRUCTA* lpConnDlgStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetdisconnectdialog1w))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetDisconnectDialog1W(DISCDLGSTRUCTW* lpConnDlgStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetopenenuma))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetOpenEnumA(NET_RESOURCE_SCOPE dwScope, NET_RESOURCE_TYPE dwType, WNET_OPEN_ENUM_USAGE dwUsage, 
                          NETRESOURCEA* lpNetResource, 
                          /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WNetCloseEnum))], [])*/HANDLE* lphEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetopenenumw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetOpenEnumW(NET_RESOURCE_SCOPE dwScope, NET_RESOURCE_TYPE dwType, WNET_OPEN_ENUM_USAGE dwUsage, 
                          NETRESOURCEW* lpNetResource, 
                          /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WNetCloseEnum))], [])*/HANDLE* lphEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetenumresourcea))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetEnumResourceA(HANDLE hEnum, uint* lpcCount, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                              uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetenumresourcew))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetEnumResourceW(HANDLE hEnum, uint* lpcCount, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                              uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetcloseenum))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetCloseEnum(HANDLE hEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetresourceparenta))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetResourceParentA(NETRESOURCEA* lpNetResource, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                   uint* lpcbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetresourceparentw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetResourceParentW(NETRESOURCEW* lpNetResource, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                   uint* lpcbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetresourceinformationa))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetResourceInformationA(NETRESOURCEA* lpNetResource, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                        uint* lpcbBuffer, PSTR* lplpSystem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetresourceinformationw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetResourceInformationW(NETRESOURCEW* lpNetResource, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                                        uint* lpcbBuffer, PWSTR* lplpSystem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetuniversalnamea))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetUniversalNameA(const(PSTR) lpLocalPath, UNC_INFO_LEVEL dwInfoLevel, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                  uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetuniversalnamew))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetUniversalNameW(const(PWSTR) lpLocalPath, UNC_INFO_LEVEL dwInfoLevel, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                  uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetusera))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetUserA(const(PSTR) lpName, PSTR lpUserName, uint* lpnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetuserw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetUserW(const(PWSTR) lpName, PWSTR lpUserName, uint* lpnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetprovidernamea))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetProviderNameA(uint dwNetType, PSTR lpProviderName, uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetprovidernamew))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetProviderNameW(uint dwNetType, PWSTR lpProviderName, uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetnetworkinformationa))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetNetworkInformationA(const(PSTR) lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetnetworkinformationw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetNetworkInformationW(const(PWSTR) lpProvider, NETINFOSTRUCT* lpNetInfoStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetlasterrora))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetLastErrorA(uint* lpError, PSTR lpErrorBuf, uint nErrorBufSize, PSTR lpNameBuf, 
                              uint nNameBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-wnetgetlasterrorw))], [])
@DllImport("MPR.dll")
WIN32_ERROR WNetGetLastErrorW(uint* lpError, PWSTR lpErrorBuf, uint nErrorBufSize, PWSTR lpNameBuf, 
                              uint nNameBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-multinetgetconnectionperformancea))], [])
@DllImport("MPR.dll")
uint MultinetGetConnectionPerformanceA(NETRESOURCEA* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnetwk/nf-winnetwk-multinetgetconnectionperformancew))], [])
@DllImport("MPR.dll")
uint MultinetGetConnectionPerformanceW(NETRESOURCEW* lpNetResource, NETCONNECTINFOSTRUCT* lpNetConnectInfoStruct);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npaddconnection))], [])
@DllImport("davclnt.dll")
uint NPAddConnection(NETRESOURCEW* lpNetResource, PWSTR lpPassword, PWSTR lpUserName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npaddconnection3))], [])
@DllImport("davclnt.dll")
uint NPAddConnection3(HWND hwndOwner, NETRESOURCEW* lpNetResource, PWSTR lpPassword, PWSTR lpUserName, 
                      NET_CONNECT_FLAGS dwFlags);

@DllImport("NTLANMAN.dll")
uint NPAddConnection4(HWND hwndOwner, NETRESOURCEW* lpNetResource, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpAuthBuffer, 
                      uint cbAuthBuffer, uint dwFlags, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* lpUseOptions, 
                      uint cbUseOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npcancelconnection))], [])
@DllImport("davclnt.dll")
uint NPCancelConnection(PWSTR lpName, BOOL fForce);

@DllImport("NTLANMAN.dll")
uint NPCancelConnection2(PWSTR lpName, BOOL fForce, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npgetconnection))], [])
@DllImport("davclnt.dll")
uint NPGetConnection(PWSTR lpLocalName, PWSTR lpRemoteName, uint* lpnBufferLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npgetconnection3))], [])
@DllImport("NTLANMAN.dll")
uint NPGetConnection3(const(PWSTR) lpLocalName, uint dwLevel, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                      uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npgetuniversalname))], [])
@DllImport("davclnt.dll")
uint NPGetUniversalName(const(PWSTR) lpLocalPath, UNC_INFO_LEVEL dwInfoLevel, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                        uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npgetconnectionperformance))], [])
@DllImport("NTLANMAN.dll")
uint NPGetConnectionPerformance(const(PWSTR) lpRemoteName, NETCONNECTINFOSTRUCT* lpNetConnectInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npopenenum))], [])
@DllImport("davclnt.dll")
uint NPOpenEnum(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, HANDLE* lphEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npenumresource))], [])
@DllImport("davclnt.dll")
uint NPEnumResource(HANDLE hEnum, uint* lpcCount, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                    uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npcloseenum))], [])
@DllImport("davclnt.dll")
uint NPCloseEnum(HANDLE hEnum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npgetcaps))], [])
@DllImport("davclnt.dll")
uint NPGetCaps(uint ndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npgetuser))], [])
@DllImport("davclnt.dll")
uint NPGetUser(PWSTR lpName, PWSTR lpUserName, uint* lpnBufferLen);

@DllImport("NTLANMAN.dll")
uint NPGetPersistentUseOptionsForConnection(PWSTR lpRemotePath, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* lpReadUseOptions, 
                                            uint cbReadUseOptions, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* lpWriteUseOptions, 
                                            uint* lpSizeWriteUseOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npgetresourceparent))], [])
@DllImport("davclnt.dll")
uint NPGetResourceParent(NETRESOURCEW* lpNetResource, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                         uint* lpBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npgetresourceinformation))], [])
@DllImport("davclnt.dll")
uint NPGetResourceInformation(NETRESOURCEW* lpNetResource, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpBuffer, 
                              uint* lpBufferSize, PWSTR* lplpSystem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-npformatnetworkname))], [])
@DllImport("davclnt.dll")
uint NPFormatNetworkName(PWSTR lpRemoteName, PWSTR lpFormattedName, uint* lpnLength, 
                         NETWORK_NAME_FORMAT_FLAGS dwFlags, uint dwAveCharPerLine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-wnetsetlasterrora))], [])
@DllImport("MPR.dll")
void WNetSetLastErrorA(uint err, PSTR lpError, PSTR lpProviders);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/npapi/nf-npapi-wnetsetlasterrorw))], [])
@DllImport("MPR.dll")
void WNetSetLastErrorW(uint err, PWSTR lpError, PWSTR lpProviders);


