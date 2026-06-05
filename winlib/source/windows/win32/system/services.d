// Written in the D programming language.

module windows.win32.system.services;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, HANDLE, PSTR, PWSTR;
public import windows.win32.security : OBJECT_SECURITY_INFORMATION, PSECURITY_DESCRIPTOR;
public import windows.win32.system.registry : HKEY;

extern(Windows) @nogc nothrow:


// Enums


alias ENUM_SERVICE_STATE = uint;
enum : uint
{
    SERVICE_ACTIVE    = 0x00000001,
    SERVICE_INACTIVE  = 0x00000002,
    SERVICE_STATE_ALL = 0x00000003,
}
//ENUM ATTR: AssociatedConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SERVICE_NO_CHANGE))], [])

alias SERVICE_ERROR = uint;
enum : uint
{
    SERVICE_ERROR_CRITICAL = 0x00000003,
    SERVICE_ERROR_IGNORE   = 0x00000000,
    SERVICE_ERROR_NORMAL   = 0x00000001,
    SERVICE_ERROR_SEVERE   = 0x00000002,
}

alias SERVICE_CONFIG = uint;
enum : uint
{
    SERVICE_CONFIG_DELAYED_AUTO_START_INFO  = 0x00000003,
    SERVICE_CONFIG_DESCRIPTION              = 0x00000001,
    SERVICE_CONFIG_FAILURE_ACTIONS          = 0x00000002,
    SERVICE_CONFIG_FAILURE_ACTIONS_FLAG     = 0x00000004,
    SERVICE_CONFIG_PREFERRED_NODE           = 0x00000009,
    SERVICE_CONFIG_PRESHUTDOWN_INFO         = 0x00000007,
    SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO = 0x00000006,
    SERVICE_CONFIG_SERVICE_SID_INFO         = 0x00000005,
    SERVICE_CONFIG_TRIGGER_INFO             = 0x00000008,
    SERVICE_CONFIG_LAUNCH_PROTECTED         = 0x0000000c,
}
//ENUM ATTR: AssociatedConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SERVICE_NO_CHANGE))], [])

alias ENUM_SERVICE_TYPE = uint;
enum : uint
{
    SERVICE_DRIVER              = 0x0000000b,
    SERVICE_KERNEL_DRIVER       = 0x00000001,
    SERVICE_WIN32               = 0x00000030,
    SERVICE_WIN32_SHARE_PROCESS = 0x00000020,
    SERVICE_ADAPTER             = 0x00000004,
    SERVICE_FILE_SYSTEM_DRIVER  = 0x00000002,
    SERVICE_RECOGNIZER_DRIVER   = 0x00000008,
    SERVICE_WIN32_OWN_PROCESS   = 0x00000010,
    SERVICE_USER_OWN_PROCESS    = 0x00000050,
    SERVICE_USER_SHARE_PROCESS  = 0x00000060,
}
//ENUM ATTR: AssociatedConstantAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SERVICE_NO_CHANGE))], [])

alias SERVICE_START_TYPE = uint;
enum : uint
{
    SERVICE_AUTO_START   = 0x00000002,
    SERVICE_BOOT_START   = 0x00000000,
    SERVICE_DEMAND_START = 0x00000003,
    SERVICE_DISABLED     = 0x00000004,
    SERVICE_SYSTEM_START = 0x00000001,
}

alias SERVICE_NOTIFY = uint;
enum : uint
{
    SERVICE_NOTIFY_CREATED          = 0x00000080,
    SERVICE_NOTIFY_CONTINUE_PENDING = 0x00000010,
    SERVICE_NOTIFY_DELETE_PENDING   = 0x00000200,
    SERVICE_NOTIFY_DELETED          = 0x00000100,
    SERVICE_NOTIFY_PAUSE_PENDING    = 0x00000020,
    SERVICE_NOTIFY_PAUSED           = 0x00000040,
    SERVICE_NOTIFY_RUNNING          = 0x00000008,
    SERVICE_NOTIFY_START_PENDING    = 0x00000002,
    SERVICE_NOTIFY_STOP_PENDING     = 0x00000004,
    SERVICE_NOTIFY_STOPPED          = 0x00000001,
}

alias SERVICE_RUNS_IN_PROCESS = uint;
enum : uint
{
    SERVICE_RUNS_IN_NON_SYSTEM_OR_NOT_RUNNING = 0x00000000,
    SERVICE_RUNS_IN_SYSTEM_PROCESS            = 0x00000001,
}

alias SERVICE_TRIGGER_ACTION = uint;
enum : uint
{
    SERVICE_TRIGGER_ACTION_SERVICE_START = 0x00000001,
    SERVICE_TRIGGER_ACTION_SERVICE_STOP  = 0x00000002,
}

alias SERVICE_TRIGGER_TYPE = uint;
enum : uint
{
    SERVICE_TRIGGER_TYPE_CUSTOM                   = 0x00000014,
    SERVICE_TRIGGER_TYPE_DEVICE_INTERFACE_ARRIVAL = 0x00000001,
    SERVICE_TRIGGER_TYPE_DOMAIN_JOIN              = 0x00000003,
    SERVICE_TRIGGER_TYPE_FIREWALL_PORT_EVENT      = 0x00000004,
    SERVICE_TRIGGER_TYPE_GROUP_POLICY             = 0x00000005,
    SERVICE_TRIGGER_TYPE_IP_ADDRESS_AVAILABILITY  = 0x00000002,
    SERVICE_TRIGGER_TYPE_NETWORK_ENDPOINT         = 0x00000006,
}

alias SERVICE_TRIGGER_SPECIFIC_DATA_ITEM_DATA_TYPE = uint;
enum : uint
{
    SERVICE_TRIGGER_DATA_TYPE_BINARY      = 0x00000001,
    SERVICE_TRIGGER_DATA_TYPE_STRING      = 0x00000002,
    SERVICE_TRIGGER_DATA_TYPE_LEVEL       = 0x00000003,
    SERVICE_TRIGGER_DATA_TYPE_KEYWORD_ANY = 0x00000004,
    SERVICE_TRIGGER_DATA_TYPE_KEYWORD_ALL = 0x00000005,
}

alias SERVICE_STATUS_CURRENT_STATE = uint;
enum : uint
{
    SERVICE_CONTINUE_PENDING = 0x00000005,
    SERVICE_PAUSE_PENDING    = 0x00000006,
    SERVICE_PAUSED           = 0x00000007,
    SERVICE_RUNNING          = 0x00000004,
    SERVICE_START_PENDING    = 0x00000002,
    SERVICE_STOP_PENDING     = 0x00000003,
    SERVICE_STOPPED          = 0x00000001,
}

alias SC_ACTION_TYPE = int;
enum : int
{
    SC_ACTION_NONE        = 0x00000000,
    SC_ACTION_RESTART     = 0x00000001,
    SC_ACTION_REBOOT      = 0x00000002,
    SC_ACTION_RUN_COMMAND = 0x00000003,
    SC_ACTION_OWN_RESTART = 0x00000004,
}

alias SC_STATUS_TYPE = int;
enum : int
{
    SC_STATUS_PROCESS_INFO = 0x00000000,
}

alias SC_ENUM_TYPE = int;
enum : int
{
    SC_ENUM_PROCESS_INFO = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Services/sc-event-type))], [])

alias SC_EVENT_TYPE = int;
enum : int
{
    SC_EVENT_DATABASE_CHANGE = 0x00000000,
    SC_EVENT_PROPERTY_CHANGE = 0x00000001,
    SC_EVENT_STATUS_CHANGE   = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ne-winsvc-service_registry_state_type))], [])

alias SERVICE_REGISTRY_STATE_TYPE = int;
enum : int
{
    ServiceRegistryStateParameters = 0x00000000,
    ServiceRegistryStatePersistent = 0x00000001,
    MaxServiceRegistryStateType    = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ne-winsvc-service_directory_type))], [])

alias SERVICE_DIRECTORY_TYPE = int;
enum : int
{
    ServiceDirectoryPersistentState = 0x00000000,
    ServiceDirectoryTypeMax         = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ne-winsvc-service_shared_registry_state_type))], [])

alias SERVICE_SHARED_REGISTRY_STATE_TYPE = int;
enum : int
{
    ServiceSharedRegistryPersistentState = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ne-winsvc-service_shared_directory_type))], [])

alias SERVICE_SHARED_DIRECTORY_TYPE = int;
enum : int
{
    ServiceSharedDirectoryPersistentState = 0x00000000,
}

// Constants


enum uint SERVICE_ALL_ACCESS = 0x000f01ff;
enum const(wchar)* SERVICES_ACTIVE_DATABASEW = "ServicesActive";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SERVICES_ACTIVE_DATABASEA = "ServicesActive";
enum const(wchar)* SERVICES_ACTIVE_DATABASE = "ServicesActive";

enum : uint
{
    SERVICE_NO_CHANGE                     = 0xffffffff,
    SERVICE_CONTROL_STOP                  = 0x00000001,
    SERVICE_CONTROL_PAUSE                 = 0x00000002,
    SERVICE_CONTROL_CONTINUE              = 0x00000003,
    SERVICE_CONTROL_INTERROGATE           = 0x00000004,
    SERVICE_CONTROL_SHUTDOWN              = 0x00000005,
    SERVICE_CONTROL_PARAMCHANGE           = 0x00000006,
    SERVICE_CONTROL_NETBINDADD            = 0x00000007,
    SERVICE_CONTROL_NETBINDREMOVE         = 0x00000008,
    SERVICE_CONTROL_NETBINDENABLE         = 0x00000009,
    SERVICE_CONTROL_NETBINDDISABLE        = 0x0000000a,
    SERVICE_CONTROL_DEVICEEVENT           = 0x0000000b,
    SERVICE_CONTROL_HARDWAREPROFILECHANGE = 0x0000000c,
    SERVICE_CONTROL_POWEREVENT            = 0x0000000d,
    SERVICE_CONTROL_SESSIONCHANGE         = 0x0000000e,
    SERVICE_CONTROL_PRESHUTDOWN           = 0x0000000f,
    SERVICE_CONTROL_TIMECHANGE            = 0x00000010,
    SERVICE_CONTROL_TRIGGEREVENT          = 0x00000020,
    SERVICE_CONTROL_LOWRESOURCES          = 0x00000060,
    SERVICE_CONTROL_SYSTEMLOWRESOURCES    = 0x00000061,
}

enum : uint
{
    SERVICE_ACCEPT_PAUSE_CONTINUE        = 0x00000002,
    SERVICE_ACCEPT_SHUTDOWN              = 0x00000004,
    SERVICE_ACCEPT_PARAMCHANGE           = 0x00000008,
    SERVICE_ACCEPT_NETBINDCHANGE         = 0x00000010,
    SERVICE_ACCEPT_HARDWAREPROFILECHANGE = 0x00000020,
    SERVICE_ACCEPT_POWEREVENT            = 0x00000040,
    SERVICE_ACCEPT_SESSIONCHANGE         = 0x00000080,
    SERVICE_ACCEPT_PRESHUTDOWN           = 0x00000100,
    SERVICE_ACCEPT_TIMECHANGE            = 0x00000200,
    SERVICE_ACCEPT_TRIGGEREVENT          = 0x00000400,
    SERVICE_ACCEPT_USER_LOGOFF           = 0x00000800,
    SERVICE_ACCEPT_LOWRESOURCES          = 0x00002000,
    SERVICE_ACCEPT_SYSTEMLOWRESOURCES    = 0x00004000,
}

enum : uint
{
    SC_MANAGER_CREATE_SERVICE    = 0x00000002,
    SC_MANAGER_ENUMERATE_SERVICE = 0x00000004,
}

enum uint SC_MANAGER_QUERY_LOCK_STATUS = 0x00000010;
enum uint SERVICE_QUERY_CONFIG = 0x00000001;
enum uint SERVICE_QUERY_STATUS = 0x00000004;

enum : uint
{
    SERVICE_START          = 0x00000010,
    SERVICE_STOP           = 0x00000020,
    SERVICE_PAUSE_CONTINUE = 0x00000040,
}

enum uint SERVICE_USER_DEFINED_CONTROL = 0x00000100;

enum : uint
{
    SERVICE_NOTIFY_STATUS_CHANGE_2 = 0x00000002,
    SERVICE_NOTIFY_STATUS_CHANGE   = 0x00000002,
}

enum : uint
{
    SERVICE_STOP_REASON_FLAG_UNPLANNED                  = 0x10000000,
    SERVICE_STOP_REASON_FLAG_CUSTOM                     = 0x20000000,
    SERVICE_STOP_REASON_FLAG_PLANNED                    = 0x40000000,
    SERVICE_STOP_REASON_FLAG_MAX                        = 0x80000000,
    SERVICE_STOP_REASON_MAJOR_MIN                       = 0x00000000,
    SERVICE_STOP_REASON_MAJOR_OTHER                     = 0x00010000,
    SERVICE_STOP_REASON_MAJOR_HARDWARE                  = 0x00020000,
    SERVICE_STOP_REASON_MAJOR_OPERATINGSYSTEM           = 0x00030000,
    SERVICE_STOP_REASON_MAJOR_SOFTWARE                  = 0x00040000,
    SERVICE_STOP_REASON_MAJOR_APPLICATION               = 0x00050000,
    SERVICE_STOP_REASON_MAJOR_NONE                      = 0x00060000,
    SERVICE_STOP_REASON_MAJOR_MAX                       = 0x00070000,
    SERVICE_STOP_REASON_MAJOR_MIN_CUSTOM                = 0x00400000,
    SERVICE_STOP_REASON_MAJOR_MAX_CUSTOM                = 0x00ff0000,
    SERVICE_STOP_REASON_MINOR_MIN                       = 0x00000000,
    SERVICE_STOP_REASON_MINOR_OTHER                     = 0x00000001,
    SERVICE_STOP_REASON_MINOR_MAINTENANCE               = 0x00000002,
    SERVICE_STOP_REASON_MINOR_INSTALLATION              = 0x00000003,
    SERVICE_STOP_REASON_MINOR_UPGRADE                   = 0x00000004,
    SERVICE_STOP_REASON_MINOR_RECONFIG                  = 0x00000005,
    SERVICE_STOP_REASON_MINOR_HUNG                      = 0x00000006,
    SERVICE_STOP_REASON_MINOR_UNSTABLE                  = 0x00000007,
    SERVICE_STOP_REASON_MINOR_DISK                      = 0x00000008,
    SERVICE_STOP_REASON_MINOR_NETWORKCARD               = 0x00000009,
    SERVICE_STOP_REASON_MINOR_ENVIRONMENT               = 0x0000000a,
    SERVICE_STOP_REASON_MINOR_HARDWARE_DRIVER           = 0x0000000b,
    SERVICE_STOP_REASON_MINOR_OTHERDRIVER               = 0x0000000c,
    SERVICE_STOP_REASON_MINOR_SERVICEPACK               = 0x0000000d,
    SERVICE_STOP_REASON_MINOR_SOFTWARE_UPDATE           = 0x0000000e,
    SERVICE_STOP_REASON_MINOR_SECURITYFIX               = 0x0000000f,
    SERVICE_STOP_REASON_MINOR_SECURITY                  = 0x00000010,
    SERVICE_STOP_REASON_MINOR_NETWORK_CONNECTIVITY      = 0x00000011,
    SERVICE_STOP_REASON_MINOR_WMI                       = 0x00000012,
    SERVICE_STOP_REASON_MINOR_SERVICEPACK_UNINSTALL     = 0x00000013,
    SERVICE_STOP_REASON_MINOR_SOFTWARE_UPDATE_UNINSTALL = 0x00000014,
    SERVICE_STOP_REASON_MINOR_SECURITYFIX_UNINSTALL     = 0x00000015,
    SERVICE_STOP_REASON_MINOR_MMC                       = 0x00000016,
    SERVICE_STOP_REASON_MINOR_NONE                      = 0x00000017,
    SERVICE_STOP_REASON_MINOR_MEMOTYLIMIT               = 0x00000018,
    SERVICE_STOP_REASON_MINOR_MAX                       = 0x00000019,
    SERVICE_STOP_REASON_MINOR_MIN_CUSTOM                = 0x00000100,
    SERVICE_STOP_REASON_MINOR_MAX_CUSTOM                = 0x0000ffff,
}

enum : uint
{
    SERVICE_SID_TYPE_NONE         = 0x00000000,
    SERVICE_SID_TYPE_UNRESTRICTED = 0x00000001,
}

enum uint SERVICE_TRIGGER_TYPE_AGGREGATE = 0x0000001e;

enum : uint
{
    SERVICE_START_REASON_AUTO               = 0x00000002,
    SERVICE_START_REASON_TRIGGER            = 0x00000004,
    SERVICE_START_REASON_RESTART_ON_FAILURE = 0x00000008,
    SERVICE_START_REASON_DELAYEDAUTO        = 0x00000010,
}

enum : uint
{
    SERVICE_LAUNCH_PROTECTED_NONE              = 0x00000000,
    SERVICE_LAUNCH_PROTECTED_WINDOWS           = 0x00000001,
    SERVICE_LAUNCH_PROTECTED_WINDOWS_LIGHT     = 0x00000002,
    SERVICE_LAUNCH_PROTECTED_ANTIMALWARE_LIGHT = 0x00000003,
}

enum const(wchar)* SC_AGGREGATE_STORAGE_KEY = "System\\CurrentControlSet\\Control\\ServiceAggregatedEvents";

// Callbacks

//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias SERVICE_MAIN_FUNCTIONW = void function(uint dwNumServicesArgs, PWSTR* lpServiceArgVectors);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias SERVICE_MAIN_FUNCTIONA = void function(uint dwNumServicesArgs, byte** lpServiceArgVectors);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias LPSERVICE_MAIN_FUNCTIONW = void function(uint dwNumServicesArgs, PWSTR* lpServiceArgVectors);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias LPSERVICE_MAIN_FUNCTIONA = void function(uint dwNumServicesArgs, PSTR* lpServiceArgVectors);
alias HANDLER_FUNCTION = void function(uint dwControl);
alias HANDLER_FUNCTION_EX = uint function(uint dwControl, uint dwEventType, void* lpEventData, void* lpContext);
alias LPHANDLER_FUNCTION = void function(uint dwControl);
alias LPHANDLER_FUNCTION_EX = uint function(uint dwControl, uint dwEventType, void* lpEventData, void* lpContext);
alias PFN_SC_NOTIFY_CALLBACK = void function(void* pParameter);
alias PSC_NOTIFICATION_CALLBACK = void function(uint dwNotify, void* pCallbackContext);

// Structs


@RAIIFree!CloseServiceHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SC_HANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SERVICE_STATUS_HANDLE
{
    void* Value;
}

struct PSC_NOTIFICATION_REGISTRATION
{
    ptrdiff_t Value;
}

struct SERVICE_TRIGGER_CUSTOM_STATE_ID
{
    uint[2] Data;
}

struct SERVICE_CUSTOM_SYSTEM_STATE_CHANGE_DATA_ITEM
{
union u
    {
        SERVICE_TRIGGER_CUSTOM_STATE_ID CustomStateId;
struct s
        {
            uint DataOffset;
            /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
        }
    }
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_descriptiona))], [])
struct SERVICE_DESCRIPTIONA
{
    PSTR lpDescription;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_descriptionw))], [])
struct SERVICE_DESCRIPTIONW
{
    PWSTR lpDescription;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-sc_action))], [])
struct SC_ACTION
{
    SC_ACTION_TYPE Type;
    uint           Delay;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_failure_actionsa))], [])
struct SERVICE_FAILURE_ACTIONSA
{
    uint       dwResetPeriod;
    PSTR       lpRebootMsg;
    PSTR       lpCommand;
    uint       cActions;
    SC_ACTION* lpsaActions;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_failure_actionsw))], [])
struct SERVICE_FAILURE_ACTIONSW
{
    uint       dwResetPeriod;
    PWSTR      lpRebootMsg;
    PWSTR      lpCommand;
    uint       cActions;
    SC_ACTION* lpsaActions;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_delayed_auto_start_info))], [])
struct SERVICE_DELAYED_AUTO_START_INFO
{
    BOOL fDelayedAutostart;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_failure_actions_flag))], [])
struct SERVICE_FAILURE_ACTIONS_FLAG
{
    BOOL fFailureActionsOnNonCrashFailures;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_sid_info))], [])
struct SERVICE_SID_INFO
{
    uint dwServiceSidType;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_required_privileges_infoa))], [])
struct SERVICE_REQUIRED_PRIVILEGES_INFOA
{
    PSTR pmszRequiredPrivileges;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_required_privileges_infow))], [])
struct SERVICE_REQUIRED_PRIVILEGES_INFOW
{
    PWSTR pmszRequiredPrivileges;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_preshutdown_info))], [])
struct SERVICE_PRESHUTDOWN_INFO
{
    uint dwPreshutdownTimeout;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_trigger_specific_data_item))], [])
struct SERVICE_TRIGGER_SPECIFIC_DATA_ITEM
{
    SERVICE_TRIGGER_SPECIFIC_DATA_ITEM_DATA_TYPE dwDataType;
    uint   cbData;
    ubyte* pData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_trigger))], [])
struct SERVICE_TRIGGER
{
    SERVICE_TRIGGER_TYPE dwTriggerType;
    SERVICE_TRIGGER_ACTION dwAction;
    GUID*                pTriggerSubtype;
    uint                 cDataItems;
    SERVICE_TRIGGER_SPECIFIC_DATA_ITEM* pDataItems;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_trigger_info))], [])
struct SERVICE_TRIGGER_INFO
{
    uint             cTriggers;
    SERVICE_TRIGGER* pTriggers;
    ubyte*           pReserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_preferred_node_info))], [])
struct SERVICE_PREFERRED_NODE_INFO
{
    ushort  usPreferredNode;
    BOOLEAN fDelete;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_timechange_info))], [])
struct SERVICE_TIMECHANGE_INFO
{
    long liNewTime;
    long liOldTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_launch_protected_info))], [])
struct SERVICE_LAUNCH_PROTECTED_INFO
{
    uint dwLaunchProtected;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_status))], [])
struct SERVICE_STATUS
{
    ENUM_SERVICE_TYPE dwServiceType;
    SERVICE_STATUS_CURRENT_STATE dwCurrentState;
    uint              dwControlsAccepted;
    uint              dwWin32ExitCode;
    uint              dwServiceSpecificExitCode;
    uint              dwCheckPoint;
    uint              dwWaitHint;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_status_process))], [])
struct SERVICE_STATUS_PROCESS
{
    ENUM_SERVICE_TYPE dwServiceType;
    SERVICE_STATUS_CURRENT_STATE dwCurrentState;
    uint              dwControlsAccepted;
    uint              dwWin32ExitCode;
    uint              dwServiceSpecificExitCode;
    uint              dwCheckPoint;
    uint              dwWaitHint;
    uint              dwProcessId;
    SERVICE_RUNS_IN_PROCESS dwServiceFlags;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-enum_service_statusa))], [])
struct ENUM_SERVICE_STATUSA
{
    PSTR           lpServiceName;
    PSTR           lpDisplayName;
    SERVICE_STATUS ServiceStatus;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-enum_service_statusw))], [])
struct ENUM_SERVICE_STATUSW
{
    PWSTR          lpServiceName;
    PWSTR          lpDisplayName;
    SERVICE_STATUS ServiceStatus;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-enum_service_status_processa))], [])
struct ENUM_SERVICE_STATUS_PROCESSA
{
    PSTR lpServiceName;
    PSTR lpDisplayName;
    SERVICE_STATUS_PROCESS ServiceStatusProcess;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-enum_service_status_processw))], [])
struct ENUM_SERVICE_STATUS_PROCESSW
{
    PWSTR lpServiceName;
    PWSTR lpDisplayName;
    SERVICE_STATUS_PROCESS ServiceStatusProcess;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-query_service_lock_statusa))], [])
struct QUERY_SERVICE_LOCK_STATUSA
{
    uint fIsLocked;
    PSTR lpLockOwner;
    uint dwLockDuration;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-query_service_lock_statusw))], [])
struct QUERY_SERVICE_LOCK_STATUSW
{
    uint  fIsLocked;
    PWSTR lpLockOwner;
    uint  dwLockDuration;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-query_service_configa))], [])
struct QUERY_SERVICE_CONFIGA
{
    ENUM_SERVICE_TYPE  dwServiceType;
    SERVICE_START_TYPE dwStartType;
    SERVICE_ERROR      dwErrorControl;
    PSTR               lpBinaryPathName;
    PSTR               lpLoadOrderGroup;
    uint               dwTagId;
    PSTR               lpDependencies;
    PSTR               lpServiceStartName;
    PSTR               lpDisplayName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-query_service_configw))], [])
struct QUERY_SERVICE_CONFIGW
{
    ENUM_SERVICE_TYPE  dwServiceType;
    SERVICE_START_TYPE dwStartType;
    SERVICE_ERROR      dwErrorControl;
    PWSTR              lpBinaryPathName;
    PWSTR              lpLoadOrderGroup;
    uint               dwTagId;
    PWSTR              lpDependencies;
    PWSTR              lpServiceStartName;
    PWSTR              lpDisplayName;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_table_entrya))], [])
struct SERVICE_TABLE_ENTRYA
{
    PSTR lpServiceName;
    LPSERVICE_MAIN_FUNCTIONA lpServiceProc;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_table_entryw))], [])
struct SERVICE_TABLE_ENTRYW
{
    PWSTR lpServiceName;
    LPSERVICE_MAIN_FUNCTIONW lpServiceProc;
}

struct SERVICE_NOTIFY_1
{
    uint  dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint  dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_notify_2a))], [])
struct SERVICE_NOTIFY_2A
{
    uint  dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint  dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    uint  dwNotificationTriggered;
    PSTR  pszServiceNames;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_notify_2w))], [])
struct SERVICE_NOTIFY_2W
{
    uint  dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint  dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    uint  dwNotificationTriggered;
    PWSTR pszServiceNames;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_control_status_reason_paramsa))], [])
struct SERVICE_CONTROL_STATUS_REASON_PARAMSA
{
    uint dwReason;
    PSTR pszComment;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/ns-winsvc-service_control_status_reason_paramsw))], [])
struct SERVICE_CONTROL_STATUS_REASON_PARAMSW
{
    uint  dwReason;
    PWSTR pszComment;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

struct SERVICE_START_REASON
{
    uint dwReason;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/lmserver/nf-lmserver-setservicebits))], [])
@DllImport("ADVAPI32.dll")
BOOL SetServiceBits(SERVICE_STATUS_HANDLE hServiceStatus, uint dwServiceBits, BOOL bSetBitsOn, 
                    BOOL bUpdateImmediately);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-changeserviceconfiga))], [])
@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfigA(SC_HANDLE hService, ENUM_SERVICE_TYPE dwServiceType, SERVICE_START_TYPE dwStartType, 
                          SERVICE_ERROR dwErrorControl, const(PSTR) lpBinaryPathName, const(PSTR) lpLoadOrderGroup, 
                          uint* lpdwTagId, const(PSTR) lpDependencies, const(PSTR) lpServiceStartName, 
                          const(PSTR) lpPassword, const(PSTR) lpDisplayName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-changeserviceconfigw))], [])
@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfigW(SC_HANDLE hService, ENUM_SERVICE_TYPE dwServiceType, SERVICE_START_TYPE dwStartType, 
                          SERVICE_ERROR dwErrorControl, const(PWSTR) lpBinaryPathName, const(PWSTR) lpLoadOrderGroup, 
                          uint* lpdwTagId, const(PWSTR) lpDependencies, const(PWSTR) lpServiceStartName, 
                          const(PWSTR) lpPassword, const(PWSTR) lpDisplayName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-changeserviceconfig2a))], [])
@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfig2A(SC_HANDLE hService, SERVICE_CONFIG dwInfoLevel, void* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-changeserviceconfig2w))], [])
@DllImport("ADVAPI32.dll")
BOOL ChangeServiceConfig2W(SC_HANDLE hService, SERVICE_CONFIG dwInfoLevel, void* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-closeservicehandle))], [])
@DllImport("ADVAPI32.dll")
BOOL CloseServiceHandle(SC_HANDLE hSCObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-controlservice))], [])
@DllImport("ADVAPI32.dll")
BOOL ControlService(SC_HANDLE hService, uint dwControl, SERVICE_STATUS* lpServiceStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-createservicea))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE CreateServiceA(SC_HANDLE hSCManager, const(PSTR) lpServiceName, const(PSTR) lpDisplayName, 
                         uint dwDesiredAccess, ENUM_SERVICE_TYPE dwServiceType, SERVICE_START_TYPE dwStartType, 
                         SERVICE_ERROR dwErrorControl, const(PSTR) lpBinaryPathName, const(PSTR) lpLoadOrderGroup, 
                         uint* lpdwTagId, const(PSTR) lpDependencies, const(PSTR) lpServiceStartName, 
                         const(PSTR) lpPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-createservicew))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE CreateServiceW(SC_HANDLE hSCManager, const(PWSTR) lpServiceName, const(PWSTR) lpDisplayName, 
                         uint dwDesiredAccess, ENUM_SERVICE_TYPE dwServiceType, SERVICE_START_TYPE dwStartType, 
                         SERVICE_ERROR dwErrorControl, const(PWSTR) lpBinaryPathName, const(PWSTR) lpLoadOrderGroup, 
                         uint* lpdwTagId, const(PWSTR) lpDependencies, const(PWSTR) lpServiceStartName, 
                         const(PWSTR) lpPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-deleteservice))], [])
@DllImport("ADVAPI32.dll")
BOOL DeleteService(SC_HANDLE hService);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-enumdependentservicesa))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumDependentServicesA(SC_HANDLE hService, ENUM_SERVICE_STATE dwServiceState, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ENUM_SERVICE_STATUSA* lpServices, 
                            uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-enumdependentservicesw))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumDependentServicesW(SC_HANDLE hService, ENUM_SERVICE_STATE dwServiceState, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ENUM_SERVICE_STATUSW* lpServices, 
                            uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-enumservicesstatusa))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusA(SC_HANDLE hSCManager, ENUM_SERVICE_TYPE dwServiceType, ENUM_SERVICE_STATE dwServiceState, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ENUM_SERVICE_STATUSA* lpServices, 
                         uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-enumservicesstatusw))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusW(SC_HANDLE hSCManager, ENUM_SERVICE_TYPE dwServiceType, ENUM_SERVICE_STATE dwServiceState, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ENUM_SERVICE_STATUSW* lpServices, 
                         uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-enumservicesstatusexa))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusExA(SC_HANDLE hSCManager, SC_ENUM_TYPE InfoLevel, ENUM_SERVICE_TYPE dwServiceType, 
                           ENUM_SERVICE_STATE dwServiceState, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* lpServices, 
                           uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle, 
                           const(PSTR) pszGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-enumservicesstatusexw))], [])
@DllImport("ADVAPI32.dll")
BOOL EnumServicesStatusExW(SC_HANDLE hSCManager, SC_ENUM_TYPE InfoLevel, ENUM_SERVICE_TYPE dwServiceType, 
                           ENUM_SERVICE_STATE dwServiceState, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* lpServices, 
                           uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle, 
                           const(PWSTR) pszGroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getservicekeynamea))], [])
@DllImport("ADVAPI32.dll")
BOOL GetServiceKeyNameA(SC_HANDLE hSCManager, const(PSTR) lpDisplayName, PSTR lpServiceName, uint* lpcchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getservicekeynamew))], [])
@DllImport("ADVAPI32.dll")
BOOL GetServiceKeyNameW(SC_HANDLE hSCManager, const(PWSTR) lpDisplayName, PWSTR lpServiceName, uint* lpcchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getservicedisplaynamea))], [])
@DllImport("ADVAPI32.dll")
BOOL GetServiceDisplayNameA(SC_HANDLE hSCManager, const(PSTR) lpServiceName, PSTR lpDisplayName, uint* lpcchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getservicedisplaynamew))], [])
@DllImport("ADVAPI32.dll")
BOOL GetServiceDisplayNameW(SC_HANDLE hSCManager, const(PWSTR) lpServiceName, PWSTR lpDisplayName, 
                            uint* lpcchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-lockservicedatabase))], [])
@DllImport("ADVAPI32.dll")
void* LockServiceDatabase(SC_HANDLE hSCManager);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-notifybootconfigstatus))], [])
@DllImport("ADVAPI32.dll")
BOOL NotifyBootConfigStatus(BOOL BootAcceptable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-openscmanagera))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE OpenSCManagerA(const(PSTR) lpMachineName, const(PSTR) lpDatabaseName, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-openscmanagerw))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE OpenSCManagerW(const(PWSTR) lpMachineName, const(PWSTR) lpDatabaseName, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-openservicea))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE OpenServiceA(SC_HANDLE hSCManager, const(PSTR) lpServiceName, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-openservicew))], [])
@DllImport("ADVAPI32.dll")
SC_HANDLE OpenServiceW(SC_HANDLE hSCManager, const(PWSTR) lpServiceName, uint dwDesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryserviceconfiga))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfigA(SC_HANDLE hService, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/QUERY_SERVICE_CONFIGA* lpServiceConfig, 
                         uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryserviceconfigw))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfigW(SC_HANDLE hService, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/QUERY_SERVICE_CONFIGW* lpServiceConfig, 
                         uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryserviceconfig2a))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfig2A(SC_HANDLE hService, SERVICE_CONFIG dwInfoLevel, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpBuffer, 
                          uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryserviceconfig2w))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceConfig2W(SC_HANDLE hService, SERVICE_CONFIG dwInfoLevel, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpBuffer, 
                          uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryservicelockstatusa))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceLockStatusA(SC_HANDLE hSCManager, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/QUERY_SERVICE_LOCK_STATUSA* lpLockStatus, 
                             uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryservicelockstatusw))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceLockStatusW(SC_HANDLE hSCManager, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/QUERY_SERVICE_LOCK_STATUSW* lpLockStatus, 
                             uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryserviceobjectsecurity))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceObjectSecurity(SC_HANDLE hService, uint dwSecurityInformation, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR lpSecurityDescriptor, 
                                uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryservicestatus))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceStatus(SC_HANDLE hService, SERVICE_STATUS* lpServiceStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryservicestatusex))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceStatusEx(SC_HANDLE hService, SC_STATUS_TYPE InfoLevel, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* lpBuffer, 
                          uint cbBufSize, uint* pcbBytesNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-registerservicectrlhandlera))], [])
@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerA(const(PSTR) lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-registerservicectrlhandlerw))], [])
@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerW(const(PWSTR) lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-registerservicectrlhandlerexa))], [])
@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerExA(const(PSTR) lpServiceName, LPHANDLER_FUNCTION_EX lpHandlerProc, 
                                                    void* lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-registerservicectrlhandlerexw))], [])
@DllImport("ADVAPI32.dll")
SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerExW(const(PWSTR) lpServiceName, 
                                                    LPHANDLER_FUNCTION_EX lpHandlerProc, void* lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-setserviceobjectsecurity))], [])
@DllImport("ADVAPI32.dll")
BOOL SetServiceObjectSecurity(SC_HANDLE hService, OBJECT_SECURITY_INFORMATION dwSecurityInformation, 
                              PSECURITY_DESCRIPTOR lpSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-setservicestatus))], [])
@DllImport("ADVAPI32.dll")
BOOL SetServiceStatus(SERVICE_STATUS_HANDLE hServiceStatus, SERVICE_STATUS* lpServiceStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-startservicectrldispatchera))], [])
@DllImport("ADVAPI32.dll")
BOOL StartServiceCtrlDispatcherA(const(SERVICE_TABLE_ENTRYA)* lpServiceStartTable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-startservicectrldispatcherw))], [])
@DllImport("ADVAPI32.dll")
BOOL StartServiceCtrlDispatcherW(const(SERVICE_TABLE_ENTRYW)* lpServiceStartTable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-startservicea))], [])
@DllImport("ADVAPI32.dll")
BOOL StartServiceA(SC_HANDLE hService, uint dwNumServiceArgs, const(PSTR)* lpServiceArgVectors);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-startservicew))], [])
@DllImport("ADVAPI32.dll")
BOOL StartServiceW(SC_HANDLE hService, uint dwNumServiceArgs, const(PWSTR)* lpServiceArgVectors);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-unlockservicedatabase))], [])
@DllImport("ADVAPI32.dll")
BOOL UnlockServiceDatabase(void* ScLock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-notifyservicestatuschangea))], [])
@DllImport("ADVAPI32.dll")
uint NotifyServiceStatusChangeA(SC_HANDLE hService, SERVICE_NOTIFY dwNotifyMask, 
                                /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/SERVICE_NOTIFY_2A* pNotifyBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-notifyservicestatuschangew))], [])
@DllImport("ADVAPI32.dll")
uint NotifyServiceStatusChangeW(SC_HANDLE hService, SERVICE_NOTIFY dwNotifyMask, 
                                /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/SERVICE_NOTIFY_2W* pNotifyBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-controlserviceexa))], [])
@DllImport("ADVAPI32.dll")
BOOL ControlServiceExA(SC_HANDLE hService, uint dwControl, uint dwInfoLevel, void* pControlParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-controlserviceexw))], [])
@DllImport("ADVAPI32.dll")
BOOL ControlServiceExW(SC_HANDLE hService, uint dwControl, uint dwInfoLevel, void* pControlParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-queryservicedynamicinformation))], [])
@DllImport("ADVAPI32.dll")
BOOL QueryServiceDynamicInformation(SERVICE_STATUS_HANDLE hServiceStatus, uint dwInfoLevel, void** ppDynamicInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Services/subscribeservicechangenotifications))], [])
@DllImport("SecHost.dll")
uint SubscribeServiceChangeNotifications(SC_HANDLE hService, SC_EVENT_TYPE eEventType, 
                                         PSC_NOTIFICATION_CALLBACK pCallback, void* pCallbackContext, 
                                         PSC_NOTIFICATION_REGISTRATION* pSubscription);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Services/unsubscribeservicechangenotifications))], [])
@DllImport("SecHost.dll")
void UnsubscribeServiceChangeNotifications(PSC_NOTIFICATION_REGISTRATION pSubscription);

@DllImport("ADVAPI32.dll")
uint WaitServiceState(SC_HANDLE hService, uint dwNotify, uint dwTimeout, HANDLE hCancelEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getserviceregistrystatekey))], [])
@DllImport("api-ms-win-service-core-l1-1-3.dll")
uint GetServiceRegistryStateKey(SERVICE_STATUS_HANDLE ServiceStatusHandle, SERVICE_REGISTRY_STATE_TYPE StateType, 
                                uint AccessMask, HKEY* ServiceStateKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getservicedirectory))], [])
@DllImport("api-ms-win-service-core-l1-1-4.dll")
uint GetServiceDirectory(SERVICE_STATUS_HANDLE hServiceStatus, SERVICE_DIRECTORY_TYPE eDirectoryType, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR lpPathBuffer, 
                         uint cchPathBufferLength, uint* lpcchRequiredBufferLength);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getsharedserviceregistrystatekey))], [])
@DllImport("api-ms-win-service-core-l1-1-5.dll")
uint GetSharedServiceRegistryStateKey(SC_HANDLE ServiceHandle, SERVICE_SHARED_REGISTRY_STATE_TYPE StateType, 
                                      uint AccessMask, HKEY* ServiceStateKey);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsvc/nf-winsvc-getsharedservicedirectory))], [])
@DllImport("api-ms-win-service-core-l1-1-5.dll")
uint GetSharedServiceDirectory(SC_HANDLE ServiceHandle, SERVICE_SHARED_DIRECTORY_TYPE DirectoryType, 
                               /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR PathBuffer, 
                               uint PathBufferLength, uint* RequiredBufferLength);


