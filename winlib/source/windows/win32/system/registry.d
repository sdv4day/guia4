// Written in the D programming language.

module windows.win32.system.registry;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, HANDLE, PSTR, PWSTR, WIN32_ERROR;
public import windows.win32.security : OBJECT_SECURITY_INFORMATION, PSECURITY_DESCRIPTOR, SECURITY_ATTRIBUTES;

extern(Windows) @nogc nothrow:


// Enums


alias REG_VALUE_TYPE = uint;
enum : uint
{
    REG_NONE                       = 0x00000000,
    REG_SZ                         = 0x00000001,
    REG_EXPAND_SZ                  = 0x00000002,
    REG_BINARY                     = 0x00000003,
    REG_DWORD                      = 0x00000004,
    REG_DWORD_LITTLE_ENDIAN        = 0x00000004,
    REG_DWORD_BIG_ENDIAN           = 0x00000005,
    REG_LINK                       = 0x00000006,
    REG_MULTI_SZ                   = 0x00000007,
    REG_RESOURCE_LIST              = 0x00000008,
    REG_FULL_RESOURCE_DESCRIPTOR   = 0x00000009,
    REG_RESOURCE_REQUIREMENTS_LIST = 0x0000000a,
    REG_QWORD                      = 0x0000000b,
    REG_QWORD_LITTLE_ENDIAN        = 0x0000000b,
}

alias REG_SAM_FLAGS = uint;
enum : uint
{
    KEY_QUERY_VALUE        = 0x00000001,
    KEY_SET_VALUE          = 0x00000002,
    KEY_CREATE_SUB_KEY     = 0x00000004,
    KEY_ENUMERATE_SUB_KEYS = 0x00000008,
    KEY_NOTIFY             = 0x00000010,
    KEY_CREATE_LINK        = 0x00000020,
    KEY_WOW64_32KEY        = 0x00000200,
    KEY_WOW64_64KEY        = 0x00000100,
    KEY_WOW64_RES          = 0x00000300,
    KEY_READ               = 0x00020019,
    KEY_WRITE              = 0x00020006,
    KEY_EXECUTE            = 0x00020019,
    KEY_ALL_ACCESS         = 0x000f003f,
}

alias REG_OPEN_CREATE_OPTIONS = uint;
enum : uint
{
    REG_OPTION_RESERVED        = 0x00000000,
    REG_OPTION_NON_VOLATILE    = 0x00000000,
    REG_OPTION_VOLATILE        = 0x00000001,
    REG_OPTION_CREATE_LINK     = 0x00000002,
    REG_OPTION_BACKUP_RESTORE  = 0x00000004,
    REG_OPTION_OPEN_LINK       = 0x00000008,
    REG_OPTION_DONT_VIRTUALIZE = 0x00000010,
}

alias REG_CREATE_KEY_DISPOSITION = uint;
enum : uint
{
    REG_CREATED_NEW_KEY     = 0x00000001,
    REG_OPENED_EXISTING_KEY = 0x00000002,
}

alias REG_SAVE_FORMAT = uint;
enum : uint
{
    REG_STANDARD_FORMAT = 0x00000001,
    REG_LATEST_FORMAT   = 0x00000002,
    REG_NO_COMPRESSION  = 0x00000004,
}

alias REG_RESTORE_KEY_FLAGS = int;
enum : int
{
    REG_FORCE_RESTORE       = 0x00000008,
    REG_WHOLE_HIVE_VOLATILE = 0x00000001,
}

alias REG_NOTIFY_FILTER = uint;
enum : uint
{
    REG_NOTIFY_CHANGE_NAME       = 0x00000001,
    REG_NOTIFY_CHANGE_ATTRIBUTES = 0x00000002,
    REG_NOTIFY_CHANGE_LAST_SET   = 0x00000004,
    REG_NOTIFY_CHANGE_SECURITY   = 0x00000008,
    REG_NOTIFY_THREAD_AGNOSTIC   = 0x10000000,
}

alias REG_ROUTINE_FLAGS = uint;
enum : uint
{
    RRF_RT_DWORD          = 0x00000018,
    RRF_RT_QWORD          = 0x00000048,
    RRF_RT_REG_NONE       = 0x00000001,
    RRF_RT_REG_SZ         = 0x00000002,
    RRF_RT_REG_EXPAND_SZ  = 0x00000004,
    RRF_RT_REG_BINARY     = 0x00000008,
    RRF_RT_REG_DWORD      = 0x00000010,
    RRF_RT_REG_MULTI_SZ   = 0x00000020,
    RRF_RT_REG_QWORD      = 0x00000040,
    RRF_RT_ANY            = 0x0000ffff,
    RRF_SUBKEY_WOW6464KEY = 0x00010000,
    RRF_SUBKEY_WOW6432KEY = 0x00020000,
    RRF_WOW64_MASK        = 0x00030000,
    RRF_NOEXPAND          = 0x10000000,
    RRF_ZEROONFAILURE     = 0x20000000,
}

// Constants


enum HKEY HKEY_CLASSES_ROOT = HKEY(cast(void*)0x80000000);
enum HKEY HKEY_LOCAL_MACHINE = HKEY(cast(void*)0x80000002);

enum : HKEY
{
    HKEY_PERFORMANCE_DATA    = HKEY(cast(void*)0x80000004),
    HKEY_PERFORMANCE_TEXT    = HKEY(cast(void*)0x80000050),
    HKEY_PERFORMANCE_NLSTEXT = HKEY(cast(void*)0x80000060),
}

enum HKEY HKEY_DYN_DATA = HKEY(cast(void*)0x80000006);
enum uint REG_PROCESS_APPKEY = 0x00000001;
enum uint PROVIDER_KEEPS_VALUE_LENGTH = 0x00000001;
enum uint REG_SECURE_CONNECTION = 0x00000001;
enum uint REG_ALLOW_UNSECURE_CONNECTION = 0x00000004;

enum : const(wchar)*
{
    REGSTR_KEY_CONFIG      = "Config",
    REGSTR_KEY_ENUM        = "Enum",
    REGSTR_KEY_ROOTENUM    = "Root",
    REGSTR_KEY_BIOSENUM    = "BIOS",
    REGSTR_KEY_ACPIENUM    = "ACPI",
    REGSTR_KEY_PCMCIAENUM  = "PCMCIA",
    REGSTR_KEY_PCIENUM     = "PCI",
    REGSTR_KEY_VPOWERDENUM = "VPOWERD",
    REGSTR_KEY_ISAENUM     = "ISAPnP",
    REGSTR_KEY_EISAENUM    = "EISA",
    REGSTR_KEY_LOGCONFIG   = "LogConfig",
    REGSTR_KEY_SYSTEMBOARD = "*PNP0C01",
    REGSTR_KEY_APM         = "*PNP0C05",
    REGSTR_KEY_INIUPDATE   = "IniUpdate",
}

enum : const(wchar)*
{
    REGSTR_KEY_DOSOPTCDROM        = "CD-ROM",
    REGSTR_KEY_DOSOPTMOUSE        = "MOUSE",
    REGSTR_KEY_KNOWNDOCKINGSTATES = "Hardware Profiles",
}

enum const(wchar)* REGSTR_KEY_DRIVERPARAMETERS = "Driver Parameters";

enum : const(wchar)*
{
    REGSTR_PATH_SETUP                = "Software\\Microsoft\\Windows\\CurrentVersion",
    REGSTR_PATH_DRIVERSIGN           = "Software\\Microsoft\\Driver Signing",
    REGSTR_PATH_NONDRIVERSIGN        = "Software\\Microsoft\\Non-Driver Signing",
    REGSTR_PATH_DRIVERSIGN_POLICY    = "Software\\Policies\\Microsoft\\Windows NT\\Driver Signing",
    REGSTR_PATH_NONDRIVERSIGN_POLICY = "Software\\Policies\\Microsoft\\Windows NT\\Non-Driver Signing",
}

enum : const(wchar)*
{
    REGSTR_PATH_MSDOSOPTS                           = "Software\\Microsoft\\Windows\\CurrentVersion\\MS-DOSOptions",
    REGSTR_PATH_NOSUGGMSDOS                         = "Software\\Microsoft\\Windows\\CurrentVersion\\NoMSDOSWarn",
    REGSTR_PATH_NEWDOSBOX                           = "Software\\Microsoft\\Windows\\CurrentVersion\\MS-DOSSpecialConfig",
    REGSTR_PATH_RUNONCE                             = "Software\\Microsoft\\Windows\\CurrentVersion\\RunOnce",
    REGSTR_PATH_RUNONCEEX                           = "Software\\Microsoft\\Windows\\CurrentVersion\\RunOnceEx",
    REGSTR_PATH_RUN                                 = "Software\\Microsoft\\Windows\\CurrentVersion\\Run",
    REGSTR_PATH_RUNSERVICESONCE                     = "Software\\Microsoft\\Windows\\CurrentVersion\\RunServicesOnce",
    REGSTR_PATH_RUNSERVICES                         = "Software\\Microsoft\\Windows\\CurrentVersion\\RunServices",
    REGSTR_PATH_EXPLORER                            = "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer",
    REGSTR_PATH_PROPERTYSYSTEM                      = "Software\\Microsoft\\Windows\\CurrentVersion\\PropertySystem",
    REGSTR_PATH_DETECT                              = "Software\\Microsoft\\Windows\\CurrentVersion\\Detect",
    REGSTR_PATH_APPPATHS                            = "Software\\Microsoft\\Windows\\CurrentVersion\\App Paths",
    REGSTR_PATH_UNINSTALL                           = "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall",
    REGSTR_PATH_REALMODENET                         = "Software\\Microsoft\\Windows\\CurrentVersion\\Network\\Real Mode Net",
    REGSTR_PATH_NETEQUIV                            = "Software\\Microsoft\\Windows\\CurrentVersion\\Network\\Equivalent",
    REGSTR_PATH_CVNETWORK                           = "Software\\Microsoft\\Windows\\CurrentVersion\\Network",
    REGSTR_PATH_WMI_SECURITY                        = "System\\CurrentControlSet\\Control\\Wmi\\Security",
    REGSTR_PATH_RELIABILITY                         = "Software\\Microsoft\\Windows\\CurrentVersion\\Reliability",
    REGSTR_PATH_RELIABILITY_POLICY                  = "Software\\Policies\\Microsoft\\Windows NT\\Reliability",
    REGSTR_PATH_RELIABILITY_POLICY_SHUTDOWNREASONUI = "ShutdownReasonUI",
    REGSTR_PATH_RELIABILITY_POLICY_SNAPSHOT         = "Snapshot",
    REGSTR_PATH_RELIABILITY_POLICY_REPORTSNAPSHOT   = "ReportSnapshot",
}

enum : const(wchar)*
{
    REGSTR_PATH_NT_CURRENTVERSION = "Software\\Microsoft\\Windows NT\\CurrentVersion",
    REGSTR_PATH_VOLUMECACHE       = "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VolumeCaches",
}

enum : const(wchar)*
{
    REGSTR_PATH_IDCONFIGDB             = "System\\CurrentControlSet\\Control\\IDConfigDB",
    REGSTR_PATH_CRITICALDEVICEDATABASE = "System\\CurrentControlSet\\Control\\CriticalDeviceDatabase",
}

enum : const(wchar)*
{
    REGSTR_PATH_DISPLAYSETTINGS    = "Display\\Settings",
    REGSTR_PATH_FONTS              = "Display\\Fonts",
    REGSTR_PATH_ENUM               = "Enum",
    REGSTR_PATH_ROOT               = "Enum\\Root",
    REGSTR_PATH_CURRENTCONTROLSET  = "System\\CurrentControlSet",
    REGSTR_PATH_SYSTEMENUM         = "System\\CurrentControlSet\\Enum",
    REGSTR_PATH_HWPROFILES         = "System\\CurrentControlSet\\Hardware Profiles",
    REGSTR_PATH_HWPROFILESCURRENT  = "System\\CurrentControlSet\\Hardware Profiles\\Current",
    REGSTR_PATH_CLASS_NT           = "System\\CurrentControlSet\\Control\\Class",
    REGSTR_PATH_PER_HW_ID_STORAGE  = "Software\\Microsoft\\Windows NT\\CurrentVersion\\PerHwIdStorage",
    REGSTR_PATH_DEVICE_CLASSES     = "System\\CurrentControlSet\\Control\\DeviceClasses",
    REGSTR_PATH_CODEVICEINSTALLERS = "System\\CurrentControlSet\\Control\\CoDeviceInstallers",
}

enum : const(wchar)*
{
    REGSTR_PATH_SERVICES              = "System\\CurrentControlSet\\Services",
    REGSTR_PATH_VXD                   = "System\\CurrentControlSet\\Services\\VxD",
    REGSTR_PATH_IOS                   = "System\\CurrentControlSet\\Services\\VxD\\IOS",
    REGSTR_PATH_VMM                   = "System\\CurrentControlSet\\Services\\VxD\\VMM",
    REGSTR_PATH_VPOWERD               = "System\\CurrentControlSet\\Services\\VxD\\VPOWERD",
    REGSTR_PATH_VNETSUP               = "System\\CurrentControlSet\\Services\\VxD\\VNETSUP",
    REGSTR_PATH_NWREDIR               = "System\\CurrentControlSet\\Services\\VxD\\NWREDIR",
    REGSTR_PATH_NCPSERVER             = "System\\CurrentControlSet\\Services\\NcpServer\\Parameters",
    REGSTR_PATH_VCOMM                 = "System\\CurrentControlSet\\Services\\VxD\\VCOMM",
    REGSTR_PATH_IOARB                 = "System\\CurrentControlSet\\Services\\Arbitrators\\IOArb",
    REGSTR_PATH_ADDRARB               = "System\\CurrentControlSet\\Services\\Arbitrators\\AddrArb",
    REGSTR_PATH_DMAARB                = "System\\CurrentControlSet\\Services\\Arbitrators\\DMAArb",
    REGSTR_PATH_IRQARB                = "System\\CurrentControlSet\\Services\\Arbitrators\\IRQArb",
    REGSTR_PATH_CODEPAGE              = "System\\CurrentControlSet\\Control\\Nls\\Codepage",
    REGSTR_PATH_FILESYSTEM            = "System\\CurrentControlSet\\Control\\FileSystem",
    REGSTR_PATH_FILESYSTEM_NOVOLTRACK = "System\\CurrentControlSet\\Control\\FileSystem\\NoVolTrack",
}

enum : const(wchar)*
{
    REGSTR_PATH_WINBOOT        = "System\\CurrentControlSet\\Control\\WinBoot",
    REGSTR_PATH_INSTALLEDFILES = "System\\CurrentControlSet\\Control\\InstalledFiles",
    REGSTR_PATH_VMM32FILES     = "System\\CurrentControlSet\\Control\\VMM32Files",
}

enum const(wchar)* REGSTR_KEY_DEVICE_PROPERTIES = "Properties";

enum : const(wchar)*
{
    REGSTR_VAL_CLASSGUID            = "ClassGUID",
    REGSTR_VAL_DISABLECOUNT         = "DisableCount",
    REGSTR_VAL_DOCKSTATE            = "DockState",
    REGSTR_VAL_DEVICE_INSTANCE      = "DeviceInstance",
    REGSTR_VAL_SYMBOLIC_LINK        = "SymbolicLink",
    REGSTR_VAL_DEFAULT              = "Default",
    REGSTR_VAL_LOWERFILTERS         = "LowerFilters",
    REGSTR_VAL_UPPERFILTERS         = "UpperFilters",
    REGSTR_VAL_LOCATION_INFORMATION = "LocationInformation",
}

enum const(wchar)* REGSTR_VAL_UI_NUMBER_DESC_FORMAT = "UINumberDescFormat";

enum : const(wchar)*
{
    REGSTR_VAL_ADDRESS                    = "Address",
    REGSTR_VAL_DEVICE_TYPE                = "DeviceType",
    REGSTR_VAL_DEVICE_CHARACTERISTICS     = "DeviceCharacteristics",
    REGSTR_VAL_DEVICE_SECURITY_DESCRIPTOR = "Security",
    REGSTR_VAL_DEVICE_EXCLUSIVE           = "Exclusive",
    REGSTR_VAL_RESOURCE_PICKER_TAGS       = "ResourcePickerTags",
    REGSTR_VAL_RESOURCE_PICKER_EXCEPTIONS = "ResourcePickerExceptions",
}

enum const(wchar)* REGSTR_VAL_CUSTOM_PROPERTY_HW_ID_KEY = "CustomPropertyHwIdKey";

enum : const(wchar)*
{
    REGSTR_VAL_CONTAINERID    = "ContainerID",
    REGSTR_VAL_EJECT_PRIORITY = "EjectPriority",
}

enum : const(wchar)*
{
    REGSTR_VAL_ACTIVESERVICE        = "ActiveService",
    REGSTR_VAL_LINKED               = "Linked",
    REGSTR_VAL_PHYSICALDEVICEOBJECT = "PhysicalDeviceObject",
}

enum const(wchar)* REGSTR_KEY_FILTERS = "Filters";
enum const(wchar)* REGSTR_VAL_UPPER_FILTER_DEFAULT_LEVEL = "UpperFilterDefaultLevel";
enum const(wchar)* REGSTR_KEY_UPPER_FILTER_LEVEL_DEFAULT = "*Upper";
enum const(wchar)* REGSTR_VAL_UPPER_FILTER_LEVELS = "UpperFilterLevels";

enum : const(wchar)*
{
    REGSTR_VAL_CURRENT_BUILD      = "CurrentBuildNumber",
    REGSTR_VAL_CURRENT_CSDVERSION = "CSDVersion",
    REGSTR_VAL_CURRENT_TYPE       = "CurrentType",
    REGSTR_VAL_BITSPERPIXEL       = "BitsPerPixel",
    REGSTR_VAL_RESOLUTION         = "Resolution",
    REGSTR_VAL_DPILOGICALX        = "DPILogicalX",
    REGSTR_VAL_DPILOGICALY        = "DPILogicalY",
    REGSTR_VAL_DPIPHYSICALX       = "DPIPhysicalX",
    REGSTR_VAL_DPIPHYSICALY       = "DPIPhysicalY",
    REGSTR_VAL_REFRESHRATE        = "RefreshRate",
    REGSTR_VAL_DISPLAYFLAGS       = "DisplayFlags",
}

enum const(wchar)* REGSTR_PATH_CONTROLSFOLDER = "Software\\Microsoft\\Windows\\CurrentVersion\\Controls Folder";

enum : const(wchar)*
{
    REGSTR_VAL_WINCP                = "ACP",
    REGSTR_VAL_DONTUSEMEM           = "DontAllocLastMem",
    REGSTR_VAL_SYSTEMROOT           = "SystemRoot",
    REGSTR_VAL_BOOTCOUNT            = "BootCount",
    REGSTR_VAL_REALNETSTART         = "RealNetStart",
    REGSTR_VAL_MEDIA                = "MediaPath",
    REGSTR_VAL_CONFIG               = "ConfigPath",
    REGSTR_VAL_DEVICEPATH           = "DevicePath",
    REGSTR_VAL_SRCPATH              = "SourcePath",
    REGSTR_VAL_DRIVERCACHEPATH      = "DriverCachePath",
    REGSTR_VAL_OLDWINDIR            = "OldWinDir",
    REGSTR_VAL_SETUPFLAGS           = "SetupFlags",
    REGSTR_VAL_REGOWNER             = "RegisteredOwner",
    REGSTR_VAL_REGORGANIZATION      = "RegisteredOrganization",
    REGSTR_VAL_LICENSINGINFO        = "LicensingInfo",
    REGSTR_VAL_OLDMSDOSVER          = "OldMSDOSVer",
    REGSTR_VAL_FIRSTINSTALLDATETIME = "FirstInstallDateTime",
}

enum uint IT_COMPACT = 0x00000000;
enum uint IT_PORTABLE = 0x00000002;
enum const(wchar)* REGSTR_VAL_WRAPPER = "Wrapper";
enum const(wchar)* REGSTR_VAL_LASTALIVEINTERVAL = "TimeStampInterval";
enum const(wchar)* REGSTR_VAL_DIRTYSHUTDOWNTIME = "DirtyShutdownTime";

enum : const(wchar)*
{
    REGSTR_VAL_LASTCOMPUTERNAME             = "LastComputerName",
    REGSTR_VAL_LASTALIVEBT                  = "LastAliveBT",
    REGSTR_VAL_LASTALIVESTAMP               = "LastAliveStamp",
    REGSTR_VAL_LASTALIVESTAMPFORCED         = "LastAliveStampForced",
    REGSTR_VAL_LASTALIVESTAMPINTERVAL       = "LastAliveStampInterval",
    REGSTR_VAL_LASTALIVESTAMPPOLICYINTERVAL = "LastAliveStampPolicyInterval",
    REGSTR_VAL_LASTALIVEUPTIME              = "LastAliveUptime",
    REGSTR_VAL_LASTALIVEPMPOLICY            = "LastAlivePMPolicy",
}

enum : const(wchar)*
{
    REGSTR_VAL_COMMENT                 = "Comment",
    REGSTR_VAL_SHUTDOWNREASON          = "ShutdownReason",
    REGSTR_VAL_SHUTDOWNREASON_CODE     = "ShutdownReasonCode",
    REGSTR_VAL_SHUTDOWNREASON_COMMENT  = "ShutdownReasonComment",
    REGSTR_VAL_SHUTDOWNREASON_PROCESS  = "ShutdownReasonProcess",
    REGSTR_VAL_SHUTDOWNREASON_USERNAME = "ShutdownReasonUserName",
}

enum : const(wchar)*
{
    REGSTR_VAL_SHUTDOWN_IGNORE_PREDEFINED = "ShutdownIgnorePredefinedReasons",
    REGSTR_VAL_SHUTDOWN_STATE_SNAPSHOT    = "ShutdownStateSnapshot",
}

enum : const(wchar)*
{
    REGSTR_VAL_BOOTDIR     = "BootDir",
    REGSTR_VAL_WINBOOTDIR  = "WinbootDir",
    REGSTR_VAL_WINDIR      = "WinDir",
    REGSTR_VAL_APPINSTPATH = "AppInstallPath",
}

enum : const(wchar)*
{
    REGSTR_KEY_EBDFILESKEYBOARD       = "EBDFilesKeyboard",
    REGSTR_KEY_EBDAUTOEXECBATLOCAL    = "EBDAutoexecBatLocale",
    REGSTR_KEY_EBDAUTOEXECBATKEYBOARD = "EBDAutoexecBatKeyboard",
    REGSTR_KEY_EBDCONFIGSYSLOCAL      = "EBDConfigSysLocale",
    REGSTR_KEY_EBDCONFIGSYSKEYBOARD   = "EBDConfigSysKeyboard",
}

enum const(wchar)* REGSTR_VAL_BEHAVIOR_ON_FAILED_VERIFY = "BehaviorOnFailedVerify";

enum : uint
{
    DRIVERSIGN_WARNING  = 0x00000001,
    DRIVERSIGN_BLOCKING = 0x00000002,
}

enum : const(wchar)*
{
    REGSTR_VAL_MSDOSMODEDISCARD  = "Discard",
    REGSTR_VAL_DOSOPTGLOBALFLAGS = "GlobalFlags",
}

enum : const(wchar)*
{
    REGSTR_VAL_DOSOPTFLAGS  = "Flags",
    REGSTR_VAL_OPTORDER     = "Order",
    REGSTR_VAL_CONFIGSYS    = "Config.Sys",
    REGSTR_VAL_AUTOEXEC     = "Autoexec.Bat",
    REGSTR_VAL_STDDOSOPTION = "StdOption",
    REGSTR_VAL_DOSOPTTIP    = "TipText",
}

enum : int
{
    DOSOPTF_SUPPORTED   = 0x00000002,
    DOSOPTF_ALWAYSUSE   = 0x00000004,
    DOSOPTF_USESPMODE   = 0x00000008,
    DOSOPTF_PROVIDESUMB = 0x00000010,
    DOSOPTF_NEEDSETUP   = 0x00000020,
    DOSOPTF_INDOSSTART  = 0x00000040,
    DOSOPTF_MULTIPLE    = 0x00000080,
}

enum int SUF_EXPRESS = 0x00000002;

enum : int
{
    SUF_CLEAN   = 0x00000008,
    SUF_INSETUP = 0x00000010,
}

enum : int
{
    SUF_NETHDBOOT  = 0x00000040,
    SUF_NETRPLBOOT = 0x00000080,
}

enum : const(wchar)*
{
    REGSTR_VAL_DOSPAGER     = "DOSPager",
    REGSTR_VAL_VXDGROUPS    = "VXDGroups",
    REGSTR_VAL_VPOWERDFLAGS = "Flags",
}

enum uint VPDF_FORCEAPM10MODE = 0x00000002;

enum : uint
{
    VPDF_DISABLEPWRSTATUSPOLL = 0x00000008,
    VPDF_DISABLERINGRESUME    = 0x00000010,
}

enum uint BIF_SHOWSIMILARDRIVERS = 0x00000001;

enum : const(wchar)*
{
    REGSTR_VAL_WORKGROUP         = "Workgroup",
    REGSTR_VAL_DIRECTHOST        = "DirectHost",
    REGSTR_VAL_FILESHARING       = "FileSharing",
    REGSTR_VAL_PRINTSHARING      = "PrintSharing",
    REGSTR_VAL_FIRSTNETDRIVE     = "FirstNetworkDrive",
    REGSTR_VAL_MAXCONNECTIONS    = "MaxConnections",
    REGSTR_VAL_APISUPPORT        = "APISupport",
    REGSTR_VAL_MAXRETRY          = "MaxRetry",
    REGSTR_VAL_MINRETRY          = "MinRetry",
    REGSTR_VAL_SUPPORTLFN        = "SupportLFN",
    REGSTR_VAL_SUPPORTBURST      = "SupportBurst",
    REGSTR_VAL_SUPPORTTUNNELLING = "SupportTunnelling",
}

enum : const(wchar)*
{
    REGSTR_VAL_READCACHING         = "ReadCaching",
    REGSTR_VAL_SHOWDOTS            = "ShowDots",
    REGSTR_VAL_GAPTIME             = "GapTime",
    REGSTR_VAL_SEARCHMODE          = "SearchMode",
    REGSTR_VAL_SHELLVERSION        = "ShellVersion",
    REGSTR_VAL_MAXLIP              = "MaxLIP",
    REGSTR_VAL_PRESERVECASE        = "PreserveCase",
    REGSTR_VAL_OPTIMIZESFN         = "OptimizeSFN",
    REGSTR_VAL_NCP_BROWSEMASTER    = "BrowseMaster",
    REGSTR_VAL_NCP_USEPEERBROWSING = "Use_PeerBrowsing",
    REGSTR_VAL_NCP_USESAP          = "Use_Sap",
    REGSTR_VAL_PCCARD_POWER        = "EnablePowerManagement",
    REGSTR_VAL_WIN31FILESYSTEM     = "Win31FileSystem",
    REGSTR_VAL_PRESERVELONGNAMES   = "PreserveLongNames",
}

enum : const(wchar)*
{
    REGSTR_VAL_ASYNCFILECOMMIT    = "AsyncFileCommit",
    REGSTR_VAL_PATHCACHECOUNT     = "PathCache",
    REGSTR_VAL_NAMECACHECOUNT     = "NameCache",
    REGSTR_VAL_CONTIGFILEALLOC    = "ContigFileAllocSize",
    REGSTR_VAL_FREESPACERATIO     = "FreeSpaceRatio",
    REGSTR_VAL_VOLIDLETIMEOUT     = "VolumeIdleTimeout",
    REGSTR_VAL_BUFFIDLETIMEOUT    = "BufferIdleTimeout",
    REGSTR_VAL_BUFFAGETIMEOUT     = "BufferAgeTimeout",
    REGSTR_VAL_NAMENUMERICTAIL    = "NameNumericTail",
    REGSTR_VAL_READAHEADTHRESHOLD = "ReadAheadThreshold",
}

enum : const(wchar)*
{
    REGSTR_VAL_SOFTCOMPATMODE     = "SoftCompatMode",
    REGSTR_VAL_DRIVESPINDOWN      = "DriveSpinDown",
    REGSTR_VAL_FORCEPMIO          = "ForcePMIO",
    REGSTR_VAL_FORCERMIO          = "ForceRMIO",
    REGSTR_VAL_LASTBOOTPMDRVS     = "LastBootPMDrvs",
    REGSTR_VAL_ACSPINDOWNPREVIOUS = "ACSpinDownPrevious",
}

enum : const(wchar)*
{
    REGSTR_VAL_VIRTUALHDIRQ        = "VirtualHDIRQ",
    REGSTR_VAL_SRVNAMECACHECOUNT   = "ServerNameCacheMax",
    REGSTR_VAL_SRVNAMECACHE        = "ServerNameCache",
    REGSTR_VAL_SRVNAMECACHENETPROV = "ServerNameCacheNumNets",
}

enum : const(wchar)*
{
    REGSTR_VAL_COMPRESSIONMETHOD    = "CompressionAlgorithm",
    REGSTR_VAL_COMPRESSIONTHRESHOLD = "CompressionThreshold",
}

enum : const(wchar)*
{
    REGSTR_VAL_BATDRIVESPINDOWN = "BatDriveSpinDown",
    REGSTR_VAL_CDCACHESIZE      = "CacheSize",
    REGSTR_VAL_CDPREFETCH       = "Prefetch",
    REGSTR_VAL_CDPREFETCHTAIL   = "PrefetchTail",
    REGSTR_VAL_CDRAWCACHE       = "RawCache",
    REGSTR_VAL_CDEXTERRORS      = "ExtendedErrors",
    REGSTR_VAL_CDSVDSENSE       = "SVDSense",
    REGSTR_VAL_CDSHOWVERSIONS   = "ShowVersions",
    REGSTR_VAL_CDCOMPATNAMES    = "MSCDEXCompatNames",
    REGSTR_VAL_CDNOREADAHEAD    = "NoReadAhead",
    REGSTR_VAL_SCSI             = "SCSI\\",
    REGSTR_VAL_ESDI             = "ESDI\\",
    REGSTR_VAL_FLOP             = "FLOP\\",
    REGSTR_VAL_DISK             = "GenDisk",
    REGSTR_VAL_CDROM            = "GenCD",
    REGSTR_VAL_TAPE             = "TAPE",
    REGSTR_VAL_SCANNER          = "SCANNER",
    REGSTR_VAL_FLOPPY           = "FLOPPY",
    REGSTR_VAL_SCSITID          = "SCSITargetID",
    REGSTR_VAL_SCSILUN          = "SCSILUN",
    REGSTR_VAL_REVLEVEL         = "RevisionLevel",
    REGSTR_VAL_PRODUCTID        = "ProductId",
    REGSTR_VAL_PRODUCTTYPE      = "ProductType",
    REGSTR_VAL_DEVTYPE          = "DeviceType",
    REGSTR_VAL_REMOVABLE        = "Removable",
    REGSTR_VAL_CURDRVLET        = "CurrentDriveLetterAssignment",
    REGSTR_VAL_USRDRVLET        = "UserDriveLetterAssignment",
    REGSTR_VAL_SYNCDATAXFER     = "SyncDataXfer",
    REGSTR_VAL_AUTOINSNOTE      = "AutoInsertNotification",
    REGSTR_VAL_DISCONNECT       = "Disconnect",
    REGSTR_VAL_INT13            = "Int13",
    REGSTR_VAL_PMODE_INT13      = "PModeInt13",
    REGSTR_VAL_USERSETTINGS     = "AdapterSettings",
    REGSTR_VAL_NOIDE            = "NoIDE",
    REGSTR_VAL_DISKCLASSNAME    = "DiskDrive",
    REGSTR_VAL_CDROMCLASSNAME   = "CDROM",
    REGSTR_VAL_FORCELOAD        = "ForceLoadPD",
    REGSTR_VAL_FORCEFIFO        = "ForceFIFO",
    REGSTR_VAL_FORCECL          = "ForceChangeLine",
    REGSTR_VAL_NOUSECLASS       = "NoUseClass",
    REGSTR_VAL_NOINSTALLCLASS   = "NoInstallClass",
    REGSTR_VAL_NODISPLAYCLASS   = "NoDisplayClass",
    REGSTR_VAL_SILENTINSTALL    = "SilentInstall",
    REGSTR_VAL_FSFILTERCLASS    = "FSFilterClass",
}

enum : const(wchar)*
{
    REGSTR_KEY_SCSI_CLASS     = "SCSIAdapter",
    REGSTR_KEY_PORTS_CLASS    = "ports",
    REGSTR_KEY_MEDIA_CLASS    = "MEDIA",
    REGSTR_KEY_DISPLAY_CLASS  = "Display",
    REGSTR_KEY_KEYBOARD_CLASS = "Keyboard",
    REGSTR_KEY_MOUSE_CLASS    = "Mouse",
    REGSTR_KEY_MONITOR_CLASS  = "Monitor",
    REGSTR_KEY_MODEM_CLASS    = "Modem",
}

enum : int
{
    PCMCIA_OPT_HAVE_SOCKET  = 0x00000001,
    PCMCIA_OPT_AUTOMEM      = 0x00000004,
    PCMCIA_OPT_NO_SOUND     = 0x00000008,
    PCMCIA_OPT_NO_AUDIO     = 0x00000010,
    PCMCIA_OPT_NO_APMREMOVE = 0x00000020,
}

enum : uint
{
    PCMCIA_DEF_MEMBEGIN = 0x000c0000,
    PCMCIA_DEF_MEMEND   = 0x00ffffff,
    PCMCIA_DEF_MEMLEN   = 0x00001000,
}

enum : const(wchar)*
{
    REGSTR_VAL_PCMCIA_ATAD = "ATADelay",
    REGSTR_VAL_PCMCIA_SIZ  = "MinRegionSize",
}

enum : const(wchar)*
{
    REGSTR_VAL_P1284MDL            = "Model",
    REGSTR_VAL_P1284MFG            = "Manufacturer",
    REGSTR_VAL_ISAPNP              = "ISAPNP",
    REGSTR_VAL_ISAPNP_RDP_OVERRIDE = "RDPOverRide",
}

enum : const(wchar)*
{
    REGSTR_PCI_OPTIONS  = "Options",
    REGSTR_PCI_DUAL_IDE = "PCIDualIDE",
}

enum int PCI_OPTIONS_USE_IRQ_STEERING = 0x00000002;

enum : int
{
    AGP_FLAG_NO_2X_RATE             = 0x00000002,
    AGP_FLAG_NO_4X_RATE             = 0x00000004,
    AGP_FLAG_NO_8X_RATE             = 0x00000008,
    AGP_FLAG_REVERSE_INITIALIZATION = 0x00000080,
}

enum : int
{
    AGP_FLAG_NO_FW_ENABLE    = 0x00000200,
    AGP_FLAG_SPECIAL_TARGET  = 0x000fffff,
    AGP_FLAG_SPECIAL_RESERVE = 0x000f8000,
}

enum : const(wchar)*
{
    REGSTR_KEY_DANGERS    = "Dangers",
    REGSTR_KEY_DETMODVARS = "DetModVars",
    REGSTR_KEY_NDISINFO   = "NDISInfo",
}

enum : const(wchar)*
{
    REGSTR_VAL_RESOURCES     = "Resources",
    REGSTR_VAL_CRASHFUNCS    = "CrashFuncs",
    REGSTR_VAL_CLASS         = "Class",
    REGSTR_VAL_CLASSDESC     = "ClassDesc",
    REGSTR_VAL_DEVDESC       = "DeviceDesc",
    REGSTR_VAL_BOOTCONFIG    = "BootConfig",
    REGSTR_VAL_DETFUNC       = "DetFunc",
    REGSTR_VAL_DETFLAGS      = "DetFlags",
    REGSTR_VAL_COMPATIBLEIDS = "CompatibleIDs",
    REGSTR_VAL_DETCONFIG     = "DetConfig",
    REGSTR_VAL_VERIFYKEY     = "VerifyKey",
    REGSTR_VAL_COMINFO       = "ComInfo",
    REGSTR_VAL_INFNAME       = "InfName",
    REGSTR_VAL_CARDSPECIFIC  = "CardSpecific",
    REGSTR_VAL_NETOSTYPE     = "NetOSType",
}

enum : const(wchar)*
{
    REGSTR_DATA_NETOS_ODI = "ODI",
    REGSTR_DATA_NETOS_IPX = "IPX",
}

enum : const(wchar)*
{
    REGSTR_VAL_SCAN_ONLY_FIRST   = "ScanOnlyFirstDrive",
    REGSTR_VAL_SHARE_IRQ         = "ForceIRQSharing",
    REGSTR_VAL_NONSTANDARD_ATAPI = "NonStandardATAPI",
}

enum uint REGSTR_VAL_MAX_HCID_LEN = 0x00000400;
enum const(wchar)* REGSTR_VAL_ENABLEINTS = "EnableInts";

enum : uint
{
    REGDF_NOTDETMEM      = 0x00000002,
    REGDF_NOTDETIRQ      = 0x00000004,
    REGDF_NOTDETDMA      = 0x00000008,
    REGDF_NEEDFULLCONFIG = 0x00000010,
}

enum uint REGDF_NODETCONFIG = 0x00008000;

enum : uint
{
    REGDF_CONFLICTMEM = 0x00020000,
    REGDF_CONFLICTIRQ = 0x00040000,
    REGDF_CONFLICTDMA = 0x00080000,
}

enum uint REGDF_NOTVERIFIED = 0x80000000;

enum : const(wchar)*
{
    REGSTR_VAL_APMFLAGS         = "APMFlags",
    REGSTR_VAL_SLSUPPORT        = "SLSupport",
    REGSTR_VAL_MACHINETYPE      = "MachineType",
    REGSTR_VAL_SETUPMACHINETYPE = "SetupMachineType",
}

enum : const(wchar)*
{
    REGSTR_MACHTYPE_IBMPC         = "IBM PC",
    REGSTR_MACHTYPE_IBMPCJR       = "IBM PCjr",
    REGSTR_MACHTYPE_IBMPCCONV     = "IBM PC Convertible",
    REGSTR_MACHTYPE_IBMPCXT       = "IBM PC/XT",
    REGSTR_MACHTYPE_IBMPCXT_286   = "IBM PC/XT 286",
    REGSTR_MACHTYPE_IBMPCAT       = "IBM PC/AT",
    REGSTR_MACHTYPE_IBMPS2_25     = "IBM PS/2-25",
    REGSTR_MACHTYPE_IBMPS2_30_286 = "IBM PS/2-30 286",
    REGSTR_MACHTYPE_IBMPS2_30     = "IBM PS/2-30",
    REGSTR_MACHTYPE_IBMPS2_50     = "IBM PS/2-50",
    REGSTR_MACHTYPE_IBMPS2_50Z    = "IBM PS/2-50Z",
    REGSTR_MACHTYPE_IBMPS2_55SX   = "IBM PS/2-55SX",
    REGSTR_MACHTYPE_IBMPS2_60     = "IBM PS/2-60",
    REGSTR_MACHTYPE_IBMPS2_65SX   = "IBM PS/2-65SX",
    REGSTR_MACHTYPE_IBMPS2_70     = "IBM PS/2-70",
    REGSTR_MACHTYPE_IBMPS2_P70    = "IBM PS/2-P70",
    REGSTR_MACHTYPE_IBMPS2_70_80  = "IBM PS/2-70/80",
    REGSTR_MACHTYPE_IBMPS2_80     = "IBM PS/2-80",
    REGSTR_MACHTYPE_IBMPS2_90     = "IBM PS/2-90",
    REGSTR_MACHTYPE_IBMPS1        = "IBM PS/1",
    REGSTR_MACHTYPE_PHOENIX_PCAT  = "Phoenix PC/AT Compatible",
    REGSTR_MACHTYPE_HP_VECTRA     = "HP Vectra",
    REGSTR_MACHTYPE_ATT_PC        = "AT&T PC",
    REGSTR_MACHTYPE_ZENITH_PC     = "Zenith PC",
}

enum : uint
{
    APMMENUSUSPEND_DISABLED = 0x00000000,
    APMMENUSUSPEND_ENABLED  = 0x00000001,
    APMMENUSUSPEND_UNDOCKED = 0x00000002,
    APMMENUSUSPEND_NOCHANGE = 0x00000080,
}

enum const(wchar)* REGSTR_VAL_APMBATTIMEOUT = "APMBatTimeout";

enum : const(wchar)*
{
    REGSTR_VAL_APMSHUTDOWNPOWER = "APMShutDownPower",
    REGSTR_VAL_BUSTYPE          = "BusType",
    REGSTR_VAL_CPU              = "CPU",
    REGSTR_VAL_NDP              = "NDP",
    REGSTR_VAL_PNPBIOSVER       = "PnPBIOSVer",
    REGSTR_VAL_PNPSTRUCOFFSET   = "PnPStrucOffset",
    REGSTR_VAL_PCIBIOSVER       = "PCIBIOSVer",
    REGSTR_VAL_HWMECHANISM      = "HWMechanism",
    REGSTR_VAL_LASTPCIBUSNUM    = "LastPCIBusNum",
    REGSTR_VAL_CONVMEM          = "ConvMem",
    REGSTR_VAL_EXTMEM           = "ExtMem",
    REGSTR_VAL_COMPUTERNAME     = "ComputerName",
    REGSTR_VAL_BIOSNAME         = "BIOSName",
    REGSTR_VAL_BIOSVERSION      = "BIOSVersion",
    REGSTR_VAL_BIOSDATE         = "BIOSDate",
    REGSTR_VAL_MODEL            = "Model",
    REGSTR_VAL_SUBMODEL         = "Submodel",
    REGSTR_VAL_REVISION         = "Revision",
    REGSTR_VAL_FIFODEPTH        = "FIFODepth",
    REGSTR_VAL_RDINTTHRESHOLD   = "RDIntThreshold",
    REGSTR_VAL_WRINTTHRESHOLD   = "WRIntThreshold",
    REGSTR_VAL_PRIORITY         = "Priority",
    REGSTR_VAL_DRIVER           = "Driver",
    REGSTR_VAL_FUNCDESC         = "FunctionDesc",
    REGSTR_VAL_FORCEDCONFIG     = "ForcedConfig",
    REGSTR_VAL_CONFIGFLAGS      = "ConfigFlags",
    REGSTR_VAL_CSCONFIGFLAGS    = "CSConfigFlags",
}

enum : uint
{
    CSCONFIGFLAG_DISABLED      = 0x00000001,
    CSCONFIGFLAG_DO_NOT_CREATE = 0x00000002,
    CSCONFIGFLAG_DO_NOT_START  = 0x00000004,
}

enum : const(wchar)*
{
    REGSTR_VAL_ROOT_DEVNODE     = "HTREE\\ROOT\\0",
    REGSTR_VAL_RESERVED_DEVNODE = "HTREE\\RESERVED\\0",
}

enum const(wchar)* REGSTR_VAL_RESOURCE_MAP = "ResourceMap";
enum uint NUM_RESOURCE_MAP = 0x00000100;
enum uint MF_FLAGS_EVEN_IF_NO_RESOURCE = 0x00000001;
enum uint MF_FLAGS_FILL_IN_UNKNOWN_RESOURCE = 0x00000004;

enum : const(wchar)*
{
    REGSTR_VAL_EISA_RANGES         = "EISARanges",
    REGSTR_VAL_EISA_FUNCTIONS      = "EISAFunctions",
    REGSTR_VAL_EISA_FUNCTIONS_MASK = "EISAFunctionsMask",
    REGSTR_VAL_EISA_FLAGS          = "EISAFlags",
    REGSTR_VAL_EISA_SIMULATE_INT15 = "EISASimulateInt15",
}

enum uint EISAFLAG_SLOT_IO_FIRST = 0x00000002;
enum uint NUM_EISA_RANGES = 0x00000004;

enum : const(wchar)*
{
    REGSTR_VAL_DEVLOADER          = "DevLoader",
    REGSTR_VAL_STATICVXD          = "StaticVxD",
    REGSTR_VAL_PROPERTIES         = "Properties",
    REGSTR_VAL_MANUFACTURER       = "Manufacturer",
    REGSTR_VAL_EXISTS             = "Exists",
    REGSTR_VAL_CMENUMFLAGS        = "CMEnumFlags",
    REGSTR_VAL_CMDRIVFLAGS        = "CMDrivFlags",
    REGSTR_VAL_ENUMERATOR         = "Enumerator",
    REGSTR_VAL_DEVICEDRIVER       = "DeviceDriver",
    REGSTR_VAL_PORTNAME           = "PortName",
    REGSTR_VAL_INFPATH            = "InfPath",
    REGSTR_VAL_INFSECTION         = "InfSection",
    REGSTR_VAL_INFSECTIONEXT      = "InfSectionExt",
    REGSTR_VAL_POLLING            = "Polling",
    REGSTR_VAL_DONTLOADIFCONFLICT = "DontLoadIfConflict",
}

enum : const(wchar)*
{
    REGSTR_VAL_NETCLEAN                      = "NetClean",
    REGSTR_VAL_IDE_NO_SERIALIZE              = "IDENoSerialize",
    REGSTR_VAL_NOCMOSORFDPT                  = "NoCMOSorFDPT",
    REGSTR_VAL_COMVERIFYBASE                 = "COMVerifyBase",
    REGSTR_VAL_MATCHINGDEVID                 = "MatchingDeviceId",
    REGSTR_VAL_DRIVERDATE                    = "DriverDate",
    REGSTR_VAL_DRIVERDATEDATA                = "DriverDateData",
    REGSTR_VAL_DRIVERVERSION                 = "DriverVersion",
    REGSTR_VAL_LOCATION_INFORMATION_OVERRIDE = "LocationInformationOverride",
}

enum : const(wchar)*
{
    REGSTR_VAL_CONFIGMG          = "CONFIGMG",
    REGSTR_VAL_SYSDM             = "SysDM",
    REGSTR_VAL_SYSDMFUNC         = "SysDMFunc",
    REGSTR_VAL_PRIVATE           = "Private",
    REGSTR_VAL_PRIVATEFUNC       = "PrivateFunc",
    REGSTR_VAL_DETECT            = "Detect",
    REGSTR_VAL_DETECTFUNC        = "DetectFunc",
    REGSTR_VAL_ASKFORCONFIG      = "AskForConfig",
    REGSTR_VAL_ASKFORCONFIGFUNC  = "AskForConfigFunc",
    REGSTR_VAL_WAITFORUNDOCK     = "WaitForUndock",
    REGSTR_VAL_WAITFORUNDOCKFUNC = "WaitForUndockFunc",
}

enum const(wchar)* REGSTR_VAL_REMOVEROMOKAYFUNC = "RemoveRomOkayFunc";

enum : const(wchar)*
{
    REGSTR_VAL_FRIENDLYNAME   = "FriendlyName",
    REGSTR_VAL_CURRENTCONFIG  = "CurrentConfig",
    REGSTR_VAL_MAP            = "Map",
    REGSTR_VAL_ID             = "CurrentID",
    REGSTR_VAL_DOCKED         = "CurrentDockedState",
    REGSTR_VAL_CHECKSUM       = "CurrentChecksum",
    REGSTR_VAL_HWDETECT       = "HardwareDetect",
    REGSTR_VAL_INHIBITRESULTS = "InhibitResults",
    REGSTR_VAL_PROFILEFLAGS   = "ProfileFlags",
}

enum const(wchar)* REGSTR_KEY_PCUNKNOWN = "UNKNOWN_MANUFACTURER";

enum : const(wchar)*
{
    REGSTR_KEY_PCMTD              = "MTD-",
    REGSTR_VAL_PCMTDRIVER         = "MTD",
    REGSTR_VAL_HARDWAREID         = "HardwareID",
    REGSTR_VAL_INSTALLER          = "Installer",
    REGSTR_VAL_INSTALLER_32       = "Installer32",
    REGSTR_VAL_INSICON            = "Icon",
    REGSTR_VAL_ENUMPROPPAGES      = "EnumPropPages",
    REGSTR_VAL_ENUMPROPPAGES_32   = "EnumPropPages32",
    REGSTR_VAL_BASICPROPERTIES    = "BasicProperties",
    REGSTR_VAL_BASICPROPERTIES_32 = "BasicProperties32",
}

enum const(wchar)* REGSTR_VAL_PRIVATEPROBLEM = "PrivateProblem";

enum : const(wchar)*
{
    REGSTR_KEY_DEFAULT     = "Default",
    REGSTR_KEY_MODES       = "Modes",
    REGSTR_VAL_MODE        = "Mode",
    REGSTR_VAL_BPP         = "BPP",
    REGSTR_VAL_HRES        = "HRes",
    REGSTR_VAL_VRES        = "VRes",
    REGSTR_VAL_FONTSIZE    = "FontSize",
    REGSTR_VAL_DRV         = "drv",
    REGSTR_VAL_GRB         = "grb",
    REGSTR_VAL_VDD         = "vdd",
    REGSTR_VAL_VER         = "Ver",
    REGSTR_VAL_MAXRES      = "MaxResolution",
    REGSTR_VAL_DPMS        = "DPMS",
    REGSTR_VAL_RESUMERESET = "ResumeReset",
}

enum : const(wchar)*
{
    REGSTR_KEY_USER        = "User",
    REGSTR_VAL_DPI         = "dpi",
    REGSTR_VAL_PCICOPTIONS = "PCICOptions",
}

enum uint PCIC_DEFAULT_NUMSOCKETS = 0x00000000;

enum : const(wchar)*
{
    REGSTR_PATH_APPEARANCE  = "Control Panel\\Appearance",
    REGSTR_PATH_LOOKSCHEMES = "Control Panel\\Appearance\\Schemes",
}

enum const(wchar)* REGSTR_PATH_SCREENSAVE = "Control Panel\\Desktop";

enum : const(wchar)*
{
    REGSTR_VALUE_SCRPASSWORD     = "ScreenSave_Data",
    REGSTR_VALUE_LOWPOWERTIMEOUT = "ScreenSaveLowPowerTimeout",
    REGSTR_VALUE_POWEROFFTIMEOUT = "ScreenSavePowerOffTimeout",
    REGSTR_VALUE_LOWPOWERACTIVE  = "ScreenSaveLowPowerActive",
    REGSTR_VALUE_POWEROFFACTIVE  = "ScreenSavePowerOffActive",
}

enum const(wchar)* REGSTR_PATH_SYSTRAY = "Software\\Microsoft\\Windows\\CurrentVersion\\Applets\\SysTray";

enum : const(wchar)*
{
    REGSTR_VAL_SYSTRAYBATFLAGS    = "PowerFlags",
    REGSTR_VAL_SYSTRAYPCCARDFLAGS = "PCMCIAFlags",
}

enum : const(wchar)*
{
    REGSTR_KEY_NETWORK_PERSISTENT = "\\Persistent",
    REGSTR_KEY_NETWORK_RECENT     = "\\Recent",
}

enum : const(wchar)*
{
    REGSTR_VAL_USER_NAME       = "UserName",
    REGSTR_VAL_PROVIDER_NAME   = "ProviderName",
    REGSTR_VAL_CONNECTION_TYPE = "ConnectionType",
    REGSTR_VAL_UPGRADE         = "Upgrade",
}

enum : const(wchar)*
{
    REGSTR_VAL_MUSTBEVALIDATED = "MustBeValidated",
    REGSTR_VAL_RUNLOGINSCRIPT  = "ProcessLoginScript",
}

enum : const(wchar)*
{
    REGSTR_VAL_AUTHENT_AGENT       = "AuthenticatingAgent",
    REGSTR_VAL_PREFREDIR           = "PreferredRedir",
    REGSTR_VAL_AUTOSTART           = "AutoStart",
    REGSTR_VAL_AUTOLOGON           = "AutoLogon",
    REGSTR_VAL_NETCARD             = "Netcard",
    REGSTR_VAL_TRANSPORT           = "Transport",
    REGSTR_VAL_DYNAMIC             = "Dynamic",
    REGSTR_VAL_TRANSITION          = "Transition",
    REGSTR_VAL_STATICDRIVE         = "StaticDrive",
    REGSTR_VAL_LOADHI              = "LoadHi",
    REGSTR_VAL_LOADRMDRIVERS       = "LoadRMDrivers",
    REGSTR_VAL_SETUPN              = "SetupN",
    REGSTR_VAL_SETUPNPATH          = "SetupNPath",
    REGSTR_VAL_WRKGRP_FORCEMAPPING = "WrkgrpForceMapping",
    REGSTR_VAL_WRKGRP_REQUIRED     = "WrkgrpRequired",
}

enum const(wchar)* REGSTR_VAL_CURRENT_USER = "Current User";

enum : const(wchar)*
{
    REGSTR_VAL_PWDPROVIDER_PATH          = "ProviderPath",
    REGSTR_VAL_PWDPROVIDER_DESC          = "Description",
    REGSTR_VAL_PWDPROVIDER_CHANGEPWD     = "ChangePassword",
    REGSTR_VAL_PWDPROVIDER_CHANGEPWDHWND = "ChangePasswordHwnd",
    REGSTR_VAL_PWDPROVIDER_GETPWDSTATUS  = "GetPasswordStatus",
    REGSTR_VAL_PWDPROVIDER_ISNP          = "NetworkProvider",
    REGSTR_VAL_PWDPROVIDER_CHANGEORDER   = "ChangeOrder",
}

enum const(wchar)* REGSTR_PATH_UPDATE = "System\\CurrentControlSet\\Control\\Update";

enum : const(wchar)*
{
    REGSTR_VALUE_VERBOSE    = "Verbose",
    REGSTR_VALUE_NETPATH    = "NetworkPath",
    REGSTR_VALUE_DEFAULTLOC = "UseDefaultNetLocation",
}

enum : const(wchar)*
{
    REGSTR_KEY_PRINTERS  = "Printers",
    REGSTR_KEY_WINOLDAPP = "WinOldApp",
    REGSTR_KEY_EXPLORER  = "Explorer",
}

enum : const(wchar)*
{
    REGSTR_VAL_NOPRINTSHARING     = "NoPrintSharing",
    REGSTR_VAL_NOFILESHARINGCTRL  = "NoFileSharingControl",
    REGSTR_VAL_NOPRINTSHARINGCTRL = "NoPrintSharingControl",
}

enum const(wchar)* REGSTR_VAL_DISABLEPWDCACHING = "DisablePwdCaching";

enum : const(wchar)*
{
    REGSTR_VAL_NETSETUP_DISABLE        = "NoNetSetup",
    REGSTR_VAL_NETSETUP_NOCONFIGPAGE   = "NoNetSetupConfigPage",
    REGSTR_VAL_NETSETUP_NOIDPAGE       = "NoNetSetupIDPage",
    REGSTR_VAL_NETSETUP_NOSECURITYPAGE = "NoNetSetupSecurityPage",
}

enum : const(wchar)*
{
    REGSTR_VAL_SYSTEMCPL_NODEVMGRPAGE  = "NoDevMgrPage",
    REGSTR_VAL_SYSTEMCPL_NOCONFIGPAGE  = "NoConfigPage",
    REGSTR_VAL_SYSTEMCPL_NOFILESYSPAGE = "NoFileSysPage",
}

enum : const(wchar)*
{
    REGSTR_VAL_DISPCPL_NOBACKGROUNDPAGE = "NoDispBackgroundPage",
    REGSTR_VAL_DISPCPL_NOSCRSAVPAGE     = "NoDispScrSavPage",
    REGSTR_VAL_DISPCPL_NOAPPEARANCEPAGE = "NoDispAppearancePage",
    REGSTR_VAL_DISPCPL_NOSETTINGSPAGE   = "NoDispSettingsPage",
}

enum : const(wchar)*
{
    REGSTR_VAL_SECCPL_NOPWDPAGE     = "NoPwdPage",
    REGSTR_VAL_SECCPL_NOADMINPAGE   = "NoAdminPage",
    REGSTR_VAL_SECCPL_NOPROFILEPAGE = "NoProfilePage",
}

enum : const(wchar)*
{
    REGSTR_VAL_PRINTERS_NODELETE    = "NoDeletePrinter",
    REGSTR_VAL_PRINTERS_NOADD       = "NoAddPrinter",
    REGSTR_VAL_WINOLDAPP_DISABLED   = "Disabled",
    REGSTR_VAL_WINOLDAPP_NOREALMODE = "NoRealMode",
}

enum const(wchar)* REGSTR_VAL_NOWORKGROUPCONTENTS = "NoWorkgroupContents";

enum : const(wchar)*
{
    REGSTR_VAL_MINPWDLEN       = "MinPwdLen",
    REGSTR_VAL_PWDEXPIRATION   = "PwdExpiration",
    REGSTR_VAL_WIN31PROVIDER   = "Win31Provider",
    REGSTR_VAL_DISABLEREGTOOLS = "DisableRegistryTools",
}

enum : const(wchar)*
{
    REGSTR_VAL_LEGALNOTICECAPTION = "LegalNoticeCaption",
    REGSTR_VAL_LEGALNOTICETEXT    = "LegalNoticeText",
    REGSTR_VAL_DRIVE_SPINDOWN     = "NoDispSpinDown",
    REGSTR_VAL_SHUTDOWN_FLAGS     = "ShutdownFlags",
    REGSTR_VAL_RESTRICTRUN        = "RestrictRun",
}

enum : const(wchar)*
{
    REGSTR_KEY_POL_COMPUTERS     = "Computers",
    REGSTR_KEY_POL_USERGROUPS    = "UserGroups",
    REGSTR_KEY_POL_DEFAULT       = ".default",
    REGSTR_KEY_POL_USERGROUPDATA = "GroupData\\UserGroups\\Priority",
}

enum : const(wchar)*
{
    REGSTR_VAL_TZBIAS          = "Bias",
    REGSTR_VAL_TZDLTBIAS       = "DaylightBias",
    REGSTR_VAL_TZSTDBIAS       = "StandardBias",
    REGSTR_VAL_TZACTBIAS       = "ActiveTimeBias",
    REGSTR_VAL_TZDLTFLAG       = "DaylightFlag",
    REGSTR_VAL_TZSTDSTART      = "StandardStart",
    REGSTR_VAL_TZDLTSTART      = "DaylightStart",
    REGSTR_VAL_TZDLTNAME       = "DaylightName",
    REGSTR_VAL_TZSTDNAME       = "StandardName",
    REGSTR_VAL_TZNOCHANGESTART = "NoChangeStart",
    REGSTR_VAL_TZNOCHANGEEND   = "NoChangeEnd",
    REGSTR_VAL_TZNOAUTOTIME    = "DisableAutoDaylightTimeSet",
}

enum const(wchar)* REGSTR_PATH_FLOATINGPOINTPROCESSOR0 = "HARDWARE\\DESCRIPTION\\System\\FloatingPointProcessor\\0";
enum const(wchar)* REGSTR_VAL_COMPUTRNAME = "ComputerName";

enum : const(wchar)*
{
    REGSTR_VAL_FORCEREBOOT     = "ForceReboot",
    REGSTR_VAL_SETUPPROGRAMRAN = "SetupProgramRan",
    REGSTR_VAL_DOES_POLLING    = "PollingSupportNeeded",
}

enum : const(wchar)*
{
    REGSTR_PATH_KNOWN16DLLS     = "System\\CurrentControlSet\\Control\\SessionManager\\Known16DLLs",
    REGSTR_PATH_CHECKVERDLLS    = "System\\CurrentControlSet\\Control\\SessionManager\\CheckVerDLLs",
    REGSTR_PATH_WARNVERDLLS     = "System\\CurrentControlSet\\Control\\SessionManager\\WarnVerDLLs",
    REGSTR_PATH_HACKINIFILE     = "System\\CurrentControlSet\\Control\\SessionManager\\HackIniFiles",
    REGSTR_PATH_CHECKBADAPPS    = "System\\CurrentControlSet\\Control\\SessionManager\\CheckBadApps",
    REGSTR_PATH_APPPATCH        = "System\\CurrentControlSet\\Control\\SessionManager\\AppPatches",
    REGSTR_PATH_CHECKBADAPPS400 = "System\\CurrentControlSet\\Control\\SessionManager\\CheckBadApps400",
    REGSTR_PATH_KNOWNVXDS       = "System\\CurrentControlSet\\Control\\SessionManager\\KnownVxDs",
}

enum const(wchar)* REGSTR_VAL_UNINSTALLER_COMMANDLINE = "UninstallString";

enum : const(wchar)*
{
    REGSTR_VAL_REINSTALL_STRING            = "ReinstallString",
    REGSTR_VAL_REINSTALL_DEVICEINSTANCEIDS = "DeviceInstanceIds",
}

enum : const(wchar)*
{
    REGSTR_PATH_MOUSE          = "Control Panel\\Mouse",
    REGSTR_PATH_KEYBOARD       = "Control Panel\\Keyboard",
    REGSTR_PATH_COLORS         = "Control Panel\\Colors",
    REGSTR_PATH_SOUND          = "Control Panel\\Sound",
    REGSTR_PATH_METRICS        = "Control Panel\\Desktop\\WindowMetrics",
    REGSTR_PATH_ICONS          = "Control Panel\\Icons",
    REGSTR_PATH_CURSORS        = "Control Panel\\Cursors",
    REGSTR_PATH_CHECKDISK      = "Software\\Microsoft\\Windows\\CurrentVersion\\Applets\\Check Drive",
    REGSTR_PATH_CHECKDISKSET   = "Settings",
    REGSTR_PATH_CHECKDISKUDRVS = "NoUnknownDDErrDrvs",
    REGSTR_PATH_FAULT          = "Software\\Microsoft\\Windows\\CurrentVersion\\Fault",
    REGSTR_VAL_FAULT_LOGFILE   = "LogFile",
}

enum : const(wchar)*
{
    REGSTR_VAL_AEDEBUG_DEBUGGER = "Debugger",
    REGSTR_VAL_AEDEBUG_AUTO     = "Auto",
}

enum const(wchar)* REGSTR_VAL_REGITEMDELETEMESSAGE = "Removal Message";

enum : const(wchar)*
{
    REGSTR_PATH_LASTOPTIMIZE  = "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\LastOptimize",
    REGSTR_PATH_LASTBACKUP    = "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\LastBackup",
    REGSTR_PATH_CHKLASTCHECK  = "Software\\Microsoft\\Windows\\CurrentVersion\\Applets\\Check Drive\\LastCheck",
    REGSTR_PATH_CHKLASTSURFAN = "Software\\Microsoft\\Windows\\CurrentVersion\\Applets\\Check Drive\\LastSurfaceAnalysis",
}

enum : uint
{
    DTRESULTFIX  = 0x00000001,
    DTRESULTPROB = 0x00000002,
    DTRESULTPART = 0x00000003,
}

enum : const(wchar)*
{
    REGSTR_VAL_SHARES_FLAGS   = "Flags",
    REGSTR_VAL_SHARES_TYPE    = "Type",
    REGSTR_VAL_SHARES_PATH    = "Path",
    REGSTR_VAL_SHARES_REMARK  = "Remark",
    REGSTR_VAL_SHARES_RW_PASS = "Parm1",
    REGSTR_VAL_SHARES_RO_PASS = "Parm2",
}

enum : const(wchar)*
{
    REGSTR_PATH_PRINTERS     = "System\\CurrentControlSet\\Control\\Print\\Printers",
    REGSTR_PATH_PROVIDERS    = "System\\CurrentControlSet\\Control\\Print\\Providers",
    REGSTR_PATH_MONITORS     = "System\\CurrentControlSet\\Control\\Print\\Monitors",
    REGSTR_PATH_ENVIRONMENTS = "System\\CurrentControlSet\\Control\\Print\\Environments",
}

enum : const(wchar)*
{
    REGSTR_VAL_PRINTERS_MASK  = "PrintersMask",
    REGSTR_VAL_DOS_SPOOL_MASK = "DOSSpoolMask",
}

enum : const(wchar)*
{
    REGSTR_KEY_DRIVERS    = "\\Drivers",
    REGSTR_KEY_PRINT_PROC = "\\Print Processors",
}

enum : const(wchar)*
{
    REGSTR_PATH_SCHEMES          = "AppEvents\\Schemes",
    REGSTR_PATH_MULTIMEDIA_AUDIO = "Software\\Microsoft\\Multimedia\\Audio",
}

enum const(wchar)* REGSTR_KEY_JOYSETTINGS = "JoystickSettings";

enum : const(wchar)*
{
    REGSTR_VAL_JOYCALLOUT           = "JoystickCallout",
    REGSTR_VAL_JOYNCONFIG           = "Joystick%dConfiguration",
    REGSTR_VAL_JOYNOEMNAME          = "Joystick%dOEMName",
    REGSTR_VAL_JOYNOEMCALLOUT       = "Joystick%dOEMCallout",
    REGSTR_VAL_JOYOEMCALLOUT        = "OEMCallout",
    REGSTR_VAL_JOYOEMNAME           = "OEMName",
    REGSTR_VAL_JOYOEMDATA           = "OEMData",
    REGSTR_VAL_JOYOEMXYLABEL        = "OEMXYLabel",
    REGSTR_VAL_JOYOEMZLABEL         = "OEMZLabel",
    REGSTR_VAL_JOYOEMRLABEL         = "OEMRLabel",
    REGSTR_VAL_JOYOEMPOVLABEL       = "OEMPOVLabel",
    REGSTR_VAL_JOYOEMULABEL         = "OEMULabel",
    REGSTR_VAL_JOYOEMVLABEL         = "OEMVLabel",
    REGSTR_VAL_JOYOEMTESTMOVEDESC   = "OEMTestMoveDesc",
    REGSTR_VAL_JOYOEMTESTBUTTONDESC = "OEMTestButtonDesc",
    REGSTR_VAL_JOYOEMTESTMOVECAP    = "OEMTestMoveCap",
    REGSTR_VAL_JOYOEMTESTBUTTONCAP  = "OEMTestButtonCap",
    REGSTR_VAL_JOYOEMTESTWINCAP     = "OEMTestWinCap",
    REGSTR_VAL_JOYOEMCALCAP         = "OEMCalCap",
    REGSTR_VAL_JOYOEMCALWINCAP      = "OEMCalWinCap",
    REGSTR_VAL_JOYOEMCAL1           = "OEMCal1",
    REGSTR_VAL_JOYOEMCAL2           = "OEMCal2",
    REGSTR_VAL_JOYOEMCAL3           = "OEMCal3",
    REGSTR_VAL_JOYOEMCAL4           = "OEMCal4",
    REGSTR_VAL_JOYOEMCAL5           = "OEMCal5",
    REGSTR_VAL_JOYOEMCAL6           = "OEMCal6",
    REGSTR_VAL_JOYOEMCAL7           = "OEMCal7",
    REGSTR_VAL_JOYOEMCAL8           = "OEMCal8",
    REGSTR_VAL_JOYOEMCAL9           = "OEMCal9",
    REGSTR_VAL_JOYOEMCAL10          = "OEMCal10",
    REGSTR_VAL_JOYOEMCAL11          = "OEMCal11",
    REGSTR_VAL_JOYOEMCAL12          = "OEMCal12",
    REGSTR_VAL_AUDIO_BITMAP         = "bitmap",
    REGSTR_VAL_AUDIO_ICON           = "icon",
}

enum : const(wchar)*
{
    REGSTR_PATH_DIFX         = "Software\\Microsoft\\Windows\\CurrentVersion\\DIFX",
    REGSTR_VAL_SEARCHOPTIONS = "SearchOptions",
}

enum : const(wchar)*
{
    REGSTR_PATH_PCIIR        = "System\\CurrentControlSet\\Control\\Pnp\\PciIrqRouting",
    REGSTR_VAL_OPTIONS       = "Options",
    REGSTR_VAL_STAT          = "Status",
    REGSTR_VAL_TABLE_STAT    = "TableStatus",
    REGSTR_VAL_MINIPORT_STAT = "MiniportStatus",
}

enum : uint
{
    PIR_OPTION_REGISTRY = 0x00000002,
    PIR_OPTION_MSSPEC   = 0x00000004,
    PIR_OPTION_REALMODE = 0x00000008,
    PIR_OPTION_DEFAULT  = 0x0000000f,
}

enum : uint
{
    PIR_STATUS_ENABLED             = 0x00000001,
    PIR_STATUS_DISABLED            = 0x00000002,
    PIR_STATUS_MAX                 = 0x00000003,
    PIR_STATUS_TABLE_REGISTRY      = 0x00000000,
    PIR_STATUS_TABLE_MSSPEC        = 0x00000001,
    PIR_STATUS_TABLE_REALMODE      = 0x00000002,
    PIR_STATUS_TABLE_NONE          = 0x00000003,
    PIR_STATUS_TABLE_ERROR         = 0x00000004,
    PIR_STATUS_TABLE_BAD           = 0x00000005,
    PIR_STATUS_TABLE_SUCCESS       = 0x00000006,
    PIR_STATUS_TABLE_MAX           = 0x00000007,
    PIR_STATUS_MINIPORT_NORMAL     = 0x00000000,
    PIR_STATUS_MINIPORT_COMPATIBLE = 0x00000001,
    PIR_STATUS_MINIPORT_OVERRIDE   = 0x00000002,
    PIR_STATUS_MINIPORT_NONE       = 0x00000003,
    PIR_STATUS_MINIPORT_ERROR      = 0x00000004,
    PIR_STATUS_MINIPORT_NOKEY      = 0x00000005,
    PIR_STATUS_MINIPORT_SUCCESS    = 0x00000006,
    PIR_STATUS_MINIPORT_INVALID    = 0x00000007,
    PIR_STATUS_MINIPORT_MAX        = 0x00000008,
}

enum const(wchar)* REGSTR_PATH_LASTGOODTMP = "System\\LastKnownGoodRecovery\\LastGood.Tmp";

enum : uint
{
    LASTGOOD_OPERATION_NOPOSTPROC = 0x00000000,
    LASTGOOD_OPERATION_DELETE     = 0x00000001,
}

// Callbacks

alias PQUERYHANDLER = uint function(void* keycontext, val_context* val_list, uint num_vals, void* outputbuffer, 
                                    uint* total_outlen, uint input_blen);

// Structs


@RAIIFree!RegCloseKey
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HKEY
{
    void* Value;
}

struct val_context
{
    int   valuelen;
    void* value_context;
    void* val_buff_ptr;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct PVALUEA
{
    PSTR  pv_valuename;
    int   pv_valuelen;
    void* pv_value_context;
    uint  pv_type;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct PVALUEW
{
    PWSTR pv_valuename;
    int   pv_valuelen;
    void* pv_value_context;
    uint  pv_type;
}

struct REG_PROVIDER
{
    PQUERYHANDLER pi_R0_1val;
    PQUERYHANDLER pi_R0_allvals;
    PQUERYHANDLER pi_R3_1val;
    PQUERYHANDLER pi_R3_allvals;
    uint          pi_flags;
    void*         pi_key_context;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/ns-winreg-valenta))], [])
struct VALENTA
{
    PSTR           ve_valuename;
    uint           ve_valuelen;
    size_t         ve_valueptr;
    REG_VALUE_TYPE ve_type;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/ns-winreg-valentw))], [])
struct VALENTW
{
    PWSTR          ve_valuename;
    uint           ve_valuelen;
    size_t         ve_valueptr;
    REG_VALUE_TYPE ve_type;
}

struct DSKTLSYSTEMTIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDayOfWeek;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
    ushort wResult;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regclosekey))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegCloseKey(HKEY hKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regoverridepredefkey))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegOverridePredefKey(HKEY hKey, HKEY hNewHKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regopenuserclassesroot))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegOpenUserClassesRoot(HANDLE hToken, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwOptions, 
                                   uint samDesired, HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regopencurrentuser))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegOpenCurrentUser(uint samDesired, HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdisablepredefinedcache))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDisablePredefinedCache();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdisablepredefinedcacheex))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDisablePredefinedCacheEx();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regconnectregistrya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegConnectRegistryA(const(PSTR) lpMachineName, HKEY hKey, HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regconnectregistryw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegConnectRegistryW(const(PWSTR) lpMachineName, HKEY hKey, HKEY* phkResult);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ADVAPI32.dll")
int RegConnectRegistryExA(const(PSTR) lpMachineName, HKEY hKey, uint Flags, HKEY* phkResult);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("ADVAPI32.dll")
int RegConnectRegistryExW(const(PWSTR) lpMachineName, HKEY hKey, uint Flags, HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regcreatekeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegCreateKeyA(HKEY hKey, const(PSTR) lpSubKey, HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regcreatekeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegCreateKeyW(HKEY hKey, const(PWSTR) lpSubKey, HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regcreatekeyexa))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegCreateKeyExA(HKEY hKey, const(PSTR) lpSubKey, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                            PSTR lpClass, REG_OPEN_CREATE_OPTIONS dwOptions, REG_SAM_FLAGS samDesired, 
                            const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, 
                            REG_CREATE_KEY_DISPOSITION* lpdwDisposition);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regcreatekeyexw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegCreateKeyExW(HKEY hKey, const(PWSTR) lpSubKey, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                            PWSTR lpClass, REG_OPEN_CREATE_OPTIONS dwOptions, REG_SAM_FLAGS samDesired, 
                            const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, 
                            REG_CREATE_KEY_DISPOSITION* lpdwDisposition);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regcreatekeytransacteda))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegCreateKeyTransactedA(HKEY hKey, const(PSTR) lpSubKey, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                                    PSTR lpClass, REG_OPEN_CREATE_OPTIONS dwOptions, REG_SAM_FLAGS samDesired, 
                                    const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, 
                                    REG_CREATE_KEY_DISPOSITION* lpdwDisposition, HANDLE hTransaction, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pExtendedParemeter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regcreatekeytransactedw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegCreateKeyTransactedW(HKEY hKey, const(PWSTR) lpSubKey, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                                    PWSTR lpClass, REG_OPEN_CREATE_OPTIONS dwOptions, REG_SAM_FLAGS samDesired, 
                                    const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, 
                                    REG_CREATE_KEY_DISPOSITION* lpdwDisposition, HANDLE hTransaction, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pExtendedParemeter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletekeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteKeyA(HKEY hKey, const(PSTR) lpSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletekeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteKeyW(HKEY hKey, const(PWSTR) lpSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletekeyexa))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteKeyExA(HKEY hKey, const(PSTR) lpSubKey, uint samDesired, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletekeyexw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteKeyExW(HKEY hKey, const(PWSTR) lpSubKey, uint samDesired, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletekeytransacteda))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteKeyTransactedA(HKEY hKey, const(PSTR) lpSubKey, uint samDesired, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                                    HANDLE hTransaction, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pExtendedParameter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletekeytransactedw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteKeyTransactedW(HKEY hKey, const(PWSTR) lpSubKey, uint samDesired, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                                    HANDLE hTransaction, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pExtendedParameter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdisablereflectionkey))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDisableReflectionKey(HKEY hBase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regenablereflectionkey))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegEnableReflectionKey(HKEY hBase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regqueryreflectionkey))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegQueryReflectionKey(HKEY hBase, BOOL* bIsReflectionDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletevaluea))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteValueA(HKEY hKey, const(PSTR) lpValueName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletevaluew))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteValueW(HKEY hKey, const(PWSTR) lpValueName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regenumkeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegEnumKeyA(HKEY hKey, uint dwIndex, PSTR lpName, uint cchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regenumkeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegEnumKeyW(HKEY hKey, uint dwIndex, PWSTR lpName, uint cchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regenumkeyexa))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegEnumKeyExA(HKEY hKey, uint dwIndex, PSTR lpName, uint* lpcchName, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                          PSTR lpClass, uint* lpcchClass, FILETIME* lpftLastWriteTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regenumkeyexw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegEnumKeyExW(HKEY hKey, uint dwIndex, PWSTR lpName, uint* lpcchName, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                          PWSTR lpClass, uint* lpcchClass, FILETIME* lpftLastWriteTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regenumvaluea))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegEnumValueA(HKEY hKey, uint dwIndex, PSTR lpValueName, uint* lpcchValueName, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                          uint* lpType, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/ubyte* lpData, 
                          uint* lpcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regenumvaluew))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegEnumValueW(HKEY hKey, uint dwIndex, PWSTR lpValueName, uint* lpcchValueName, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                          uint* lpType, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/ubyte* lpData, 
                          uint* lpcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regflushkey))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegFlushKey(HKEY hKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-reggetkeysecurity))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegGetKeySecurity(HKEY hKey, OBJECT_SECURITY_INFORMATION SecurityInformation, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                              uint* lpcbSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regloadkeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegLoadKeyA(HKEY hKey, const(PSTR) lpSubKey, const(PSTR) lpFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regloadkeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegLoadKeyW(HKEY hKey, const(PWSTR) lpSubKey, const(PWSTR) lpFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regnotifychangekeyvalue))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegNotifyChangeKeyValue(HKEY hKey, BOOL bWatchSubtree, REG_NOTIFY_FILTER dwNotifyFilter, HANDLE hEvent, 
                                    BOOL fAsynchronous);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regopenkeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegOpenKeyA(HKEY hKey, const(PSTR) lpSubKey, HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regopenkeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegOpenKeyW(HKEY hKey, const(PWSTR) lpSubKey, HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regopenkeyexa))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegOpenKeyExA(HKEY hKey, const(PSTR) lpSubKey, uint ulOptions, REG_SAM_FLAGS samDesired, 
                          HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regopenkeyexw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegOpenKeyExW(HKEY hKey, const(PWSTR) lpSubKey, uint ulOptions, REG_SAM_FLAGS samDesired, 
                          HKEY* phkResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regopenkeytransacteda))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegOpenKeyTransactedA(HKEY hKey, const(PSTR) lpSubKey, uint ulOptions, REG_SAM_FLAGS samDesired, 
                                  HKEY* phkResult, HANDLE hTransaction, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pExtendedParemeter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regopenkeytransactedw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegOpenKeyTransactedW(HKEY hKey, const(PWSTR) lpSubKey, uint ulOptions, REG_SAM_FLAGS samDesired, 
                                  HKEY* phkResult, HANDLE hTransaction, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pExtendedParemeter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regqueryinfokeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegQueryInfoKeyA(HKEY hKey, PSTR lpClass, uint* lpcchClass, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                             uint* lpcSubKeys, uint* lpcbMaxSubKeyLen, uint* lpcbMaxClassLen, uint* lpcValues, 
                             uint* lpcbMaxValueNameLen, uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, 
                             FILETIME* lpftLastWriteTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regqueryinfokeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegQueryInfoKeyW(HKEY hKey, PWSTR lpClass, uint* lpcchClass, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                             uint* lpcSubKeys, uint* lpcbMaxSubKeyLen, uint* lpcbMaxClassLen, uint* lpcValues, 
                             uint* lpcbMaxValueNameLen, uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, 
                             FILETIME* lpftLastWriteTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regqueryvaluea))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegQueryValueA(HKEY hKey, const(PSTR) lpSubKey, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR lpData, 
                           int* lpcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regqueryvaluew))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegQueryValueW(HKEY hKey, const(PWSTR) lpSubKey, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR lpData, 
                           int* lpcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regquerymultiplevaluesa))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegQueryMultipleValuesA(HKEY hKey, VALENTA* val_list, uint num_vals, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR lpValueBuf, 
                                    uint* ldwTotsize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regquerymultiplevaluesw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegQueryMultipleValuesW(HKEY hKey, VALENTW* val_list, uint num_vals, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PWSTR lpValueBuf, 
                                    uint* ldwTotsize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regqueryvalueexa))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegQueryValueExA(HKEY hKey, const(PSTR) lpValueName, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                             REG_VALUE_TYPE* lpType, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* lpData, 
                             uint* lpcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regqueryvalueexw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegQueryValueExW(HKEY hKey, const(PWSTR) lpValueName, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* lpReserved, 
                             REG_VALUE_TYPE* lpType, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* lpData, 
                             uint* lpcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regreplacekeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegReplaceKeyA(HKEY hKey, const(PSTR) lpSubKey, const(PSTR) lpNewFile, const(PSTR) lpOldFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regreplacekeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegReplaceKeyW(HKEY hKey, const(PWSTR) lpSubKey, const(PWSTR) lpNewFile, const(PWSTR) lpOldFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regrestorekeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegRestoreKeyA(HKEY hKey, const(PSTR) lpFile, 
                           /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(REG_RESTORE_KEY_FLAGS))], [])*/uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regrestorekeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegRestoreKeyW(HKEY hKey, const(PWSTR) lpFile, 
                           /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(REG_RESTORE_KEY_FLAGS))], [])*/uint dwFlags);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regrenamekey))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegRenameKey(HKEY hKey, const(PWSTR) lpSubKeyName, const(PWSTR) lpNewKeyName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsavekeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSaveKeyA(HKEY hKey, const(PSTR) lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsavekeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSaveKeyW(HKEY hKey, const(PWSTR) lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsetkeysecurity))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSetKeySecurity(HKEY hKey, OBJECT_SECURITY_INFORMATION SecurityInformation, 
                              PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsetvaluea))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSetValueA(HKEY hKey, const(PSTR) lpSubKey, REG_VALUE_TYPE dwType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PSTR) lpData, 
                         uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsetvaluew))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSetValueW(HKEY hKey, const(PWSTR) lpSubKey, REG_VALUE_TYPE dwType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PWSTR) lpData, 
                         uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsetvalueexa))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSetValueExA(HKEY hKey, const(PSTR) lpValueName, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                           REG_VALUE_TYPE dwType, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(ubyte)* lpData, 
                           uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsetvalueexw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSetValueExW(HKEY hKey, const(PWSTR) lpValueName, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                           REG_VALUE_TYPE dwType, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(ubyte)* lpData, 
                           uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regunloadkeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegUnLoadKeyA(HKEY hKey, const(PSTR) lpSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regunloadkeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegUnLoadKeyW(HKEY hKey, const(PWSTR) lpSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletekeyvaluea))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteKeyValueA(HKEY hKey, const(PSTR) lpSubKey, const(PSTR) lpValueName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletekeyvaluew))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteKeyValueW(HKEY hKey, const(PWSTR) lpSubKey, const(PWSTR) lpValueName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsetkeyvaluea))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSetKeyValueA(HKEY hKey, const(PSTR) lpSubKey, const(PSTR) lpValueName, uint dwType, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* lpData, 
                            uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsetkeyvaluew))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSetKeyValueW(HKEY hKey, const(PWSTR) lpSubKey, const(PWSTR) lpValueName, uint dwType, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* lpData, 
                            uint cbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletetreea))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteTreeA(HKEY hKey, const(PSTR) lpSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regdeletetreew))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegDeleteTreeW(HKEY hKey, const(PWSTR) lpSubKey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regcopytreea))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegCopyTreeA(HKEY hKeySrc, const(PSTR) lpSubKey, HKEY hKeyDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-reggetvaluea))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegGetValueA(HKEY hkey, const(PSTR) lpSubKey, const(PSTR) lpValue, REG_ROUTINE_FLAGS dwFlags, 
                         REG_VALUE_TYPE* pdwType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvData, 
                         uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-reggetvaluew))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegGetValueW(HKEY hkey, const(PWSTR) lpSubKey, const(PWSTR) lpValue, REG_ROUTINE_FLAGS dwFlags, 
                         REG_VALUE_TYPE* pdwType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvData, 
                         uint* pcbData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regcopytreew))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegCopyTreeW(HKEY hKeySrc, const(PWSTR) lpSubKey, HKEY hKeyDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regloadmuistringa))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegLoadMUIStringA(HKEY hKey, const(PSTR) pszValue, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR pszOutBuf, 
                              uint cbOutBuf, uint* pcbData, uint Flags, const(PSTR) pszDirectory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regloadmuistringw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegLoadMUIStringW(HKEY hKey, const(PWSTR) pszValue, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR pszOutBuf, 
                              uint cbOutBuf, uint* pcbData, uint Flags, const(PWSTR) pszDirectory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regloadappkeya))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegLoadAppKeyA(const(PSTR) lpFile, HKEY* phkResult, uint samDesired, uint dwOptions, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regloadappkeyw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegLoadAppKeyW(const(PWSTR) lpFile, HKEY* phkResult, uint samDesired, uint dwOptions, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsavekeyexa))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSaveKeyExA(HKEY hKey, const(PSTR) lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, 
                          REG_SAVE_FORMAT Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winreg/nf-winreg-regsavekeyexw))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR RegSaveKeyExW(HKEY hKey, const(PWSTR) lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, 
                          REG_SAVE_FORMAT Flags);

@DllImport("api-ms-win-core-state-helpers-l1-1-0.dll")
WIN32_ERROR GetRegistryValueWithFallbackW(HKEY hkeyPrimary, const(PWSTR) pwszPrimarySubKey, HKEY hkeyFallback, 
                                          const(PWSTR) pwszFallbackSubKey, const(PWSTR) pwszValue, uint dwFlags, 
                                          uint* pdwType, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/void* pvData, 
                                          uint cbDataIn, uint* pcbDataOut);


