// Written in the D programming language.

module windows.win32.system.systeminformation;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, CHAR, FILETIME, HANDLE, HRESULT, PSTR, PWSTR, SYSTEMTIME;
public import windows.win32.networking.winsock : DL_EUI48, IN_ADDR;

extern(Windows) @nogc nothrow:


// Enums


alias VER_FLAGS = uint;
enum : uint
{
    VER_MINORVERSION     = 0x00000001,
    VER_MAJORVERSION     = 0x00000002,
    VER_BUILDNUMBER      = 0x00000004,
    VER_PLATFORMID       = 0x00000008,
    VER_SERVICEPACKMINOR = 0x00000010,
    VER_SERVICEPACKMAJOR = 0x00000020,
    VER_SUITENAME        = 0x00000040,
    VER_PRODUCT_TYPE     = 0x00000080,
}

alias IMAGE_FILE_MACHINE = ushort;
enum : ushort
{
    IMAGE_FILE_MACHINE_AXP64       = cast(ushort)0x0284,
    IMAGE_FILE_MACHINE_I386        = cast(ushort)0x014c,
    IMAGE_FILE_MACHINE_IA64        = cast(ushort)0x0200,
    IMAGE_FILE_MACHINE_AMD64       = cast(ushort)0x8664,
    IMAGE_FILE_MACHINE_UNKNOWN     = cast(ushort)0x0000,
    IMAGE_FILE_MACHINE_TARGET_HOST = cast(ushort)0x0001,
    IMAGE_FILE_MACHINE_R3000       = cast(ushort)0x0162,
    IMAGE_FILE_MACHINE_R4000       = cast(ushort)0x0166,
    IMAGE_FILE_MACHINE_R10000      = cast(ushort)0x0168,
    IMAGE_FILE_MACHINE_WCEMIPSV2   = cast(ushort)0x0169,
    IMAGE_FILE_MACHINE_ALPHA       = cast(ushort)0x0184,
    IMAGE_FILE_MACHINE_SH3         = cast(ushort)0x01a2,
    IMAGE_FILE_MACHINE_SH3DSP      = cast(ushort)0x01a3,
    IMAGE_FILE_MACHINE_SH3E        = cast(ushort)0x01a4,
    IMAGE_FILE_MACHINE_SH4         = cast(ushort)0x01a6,
    IMAGE_FILE_MACHINE_SH5         = cast(ushort)0x01a8,
    IMAGE_FILE_MACHINE_ARM         = cast(ushort)0x01c0,
    IMAGE_FILE_MACHINE_THUMB       = cast(ushort)0x01c2,
    IMAGE_FILE_MACHINE_ARMNT       = cast(ushort)0x01c4,
    IMAGE_FILE_MACHINE_AM33        = cast(ushort)0x01d3,
    IMAGE_FILE_MACHINE_POWERPC     = cast(ushort)0x01f0,
    IMAGE_FILE_MACHINE_POWERPCFP   = cast(ushort)0x01f1,
    IMAGE_FILE_MACHINE_MIPS16      = cast(ushort)0x0266,
    IMAGE_FILE_MACHINE_ALPHA64     = cast(ushort)0x0284,
    IMAGE_FILE_MACHINE_MIPSFPU     = cast(ushort)0x0366,
    IMAGE_FILE_MACHINE_MIPSFPU16   = cast(ushort)0x0466,
    IMAGE_FILE_MACHINE_TRICORE     = cast(ushort)0x0520,
    IMAGE_FILE_MACHINE_CEF         = cast(ushort)0x0cef,
    IMAGE_FILE_MACHINE_EBC         = cast(ushort)0x0ebc,
    IMAGE_FILE_MACHINE_M32R        = cast(ushort)0x9041,
    IMAGE_FILE_MACHINE_ARM64       = cast(ushort)0xaa64,
    IMAGE_FILE_MACHINE_CEE         = cast(ushort)0xc0ee,
}

alias PROCESSOR_ARCHITECTURE = ushort;
enum : ushort
{
    PROCESSOR_ARCHITECTURE_INTEL          = cast(ushort)0x0000,
    PROCESSOR_ARCHITECTURE_MIPS           = cast(ushort)0x0001,
    PROCESSOR_ARCHITECTURE_ALPHA          = cast(ushort)0x0002,
    PROCESSOR_ARCHITECTURE_PPC            = cast(ushort)0x0003,
    PROCESSOR_ARCHITECTURE_SHX            = cast(ushort)0x0004,
    PROCESSOR_ARCHITECTURE_ARM            = cast(ushort)0x0005,
    PROCESSOR_ARCHITECTURE_IA64           = cast(ushort)0x0006,
    PROCESSOR_ARCHITECTURE_ALPHA64        = cast(ushort)0x0007,
    PROCESSOR_ARCHITECTURE_MSIL           = cast(ushort)0x0008,
    PROCESSOR_ARCHITECTURE_AMD64          = cast(ushort)0x0009,
    PROCESSOR_ARCHITECTURE_IA32_ON_WIN64  = cast(ushort)0x000a,
    PROCESSOR_ARCHITECTURE_NEUTRAL        = cast(ushort)0x000b,
    PROCESSOR_ARCHITECTURE_ARM64          = cast(ushort)0x000c,
    PROCESSOR_ARCHITECTURE_ARM32_ON_WIN64 = cast(ushort)0x000d,
    PROCESSOR_ARCHITECTURE_IA32_ON_ARM64  = cast(ushort)0x000e,
    PROCESSOR_ARCHITECTURE_UNKNOWN        = cast(ushort)0xffff,
}

alias FIRMWARE_TABLE_PROVIDER = uint;
enum : uint
{
    ACPI    = 0x41435049,
    FIRM    = 0x4649524d,
    RSMB    = 0x52534d42,
}

alias USER_CET_ENVIRONMENT = uint;
enum : uint
{
    USER_CET_ENVIRONMENT_WIN32_PROCESS     = 0x00000000,
    USER_CET_ENVIRONMENT_SGX2_ENCLAVE      = 0x00000002,
    USER_CET_ENVIRONMENT_VBS_ENCLAVE       = 0x00000010,
    USER_CET_ENVIRONMENT_VBS_BASIC_ENCLAVE = 0x00000011,
}

alias OS_PRODUCT_TYPE = uint;
enum : uint
{
    PRODUCT_UNDEFINED                               = 0x00000000,
    PRODUCT_ULTIMATE                                = 0x00000001,
    PRODUCT_HOME_BASIC                              = 0x00000002,
    PRODUCT_HOME_PREMIUM                            = 0x00000003,
    PRODUCT_ENTERPRISE                              = 0x00000004,
    PRODUCT_HOME_BASIC_N                            = 0x00000005,
    PRODUCT_BUSINESS                                = 0x00000006,
    PRODUCT_STANDARD_SERVER                         = 0x00000007,
    PRODUCT_DATACENTER_SERVER                       = 0x00000008,
    PRODUCT_SMALLBUSINESS_SERVER                    = 0x00000009,
    PRODUCT_ENTERPRISE_SERVER                       = 0x0000000a,
    PRODUCT_STARTER                                 = 0x0000000b,
    PRODUCT_DATACENTER_SERVER_CORE                  = 0x0000000c,
    PRODUCT_STANDARD_SERVER_CORE                    = 0x0000000d,
    PRODUCT_ENTERPRISE_SERVER_CORE                  = 0x0000000e,
    PRODUCT_ENTERPRISE_SERVER_IA64                  = 0x0000000f,
    PRODUCT_BUSINESS_N                              = 0x00000010,
    PRODUCT_WEB_SERVER                              = 0x00000011,
    PRODUCT_CLUSTER_SERVER                          = 0x00000012,
    PRODUCT_HOME_SERVER                             = 0x00000013,
    PRODUCT_STORAGE_EXPRESS_SERVER                  = 0x00000014,
    PRODUCT_STORAGE_STANDARD_SERVER                 = 0x00000015,
    PRODUCT_STORAGE_WORKGROUP_SERVER                = 0x00000016,
    PRODUCT_STORAGE_ENTERPRISE_SERVER               = 0x00000017,
    PRODUCT_SERVER_FOR_SMALLBUSINESS                = 0x00000018,
    PRODUCT_SMALLBUSINESS_SERVER_PREMIUM            = 0x00000019,
    PRODUCT_HOME_PREMIUM_N                          = 0x0000001a,
    PRODUCT_ENTERPRISE_N                            = 0x0000001b,
    PRODUCT_ULTIMATE_N                              = 0x0000001c,
    PRODUCT_WEB_SERVER_CORE                         = 0x0000001d,
    PRODUCT_MEDIUMBUSINESS_SERVER_MANAGEMENT        = 0x0000001e,
    PRODUCT_MEDIUMBUSINESS_SERVER_SECURITY          = 0x0000001f,
    PRODUCT_MEDIUMBUSINESS_SERVER_MESSAGING         = 0x00000020,
    PRODUCT_SERVER_FOUNDATION                       = 0x00000021,
    PRODUCT_HOME_PREMIUM_SERVER                     = 0x00000022,
    PRODUCT_SERVER_FOR_SMALLBUSINESS_V              = 0x00000023,
    PRODUCT_STANDARD_SERVER_V                       = 0x00000024,
    PRODUCT_DATACENTER_SERVER_V                     = 0x00000025,
    PRODUCT_ENTERPRISE_SERVER_V                     = 0x00000026,
    PRODUCT_DATACENTER_SERVER_CORE_V                = 0x00000027,
    PRODUCT_STANDARD_SERVER_CORE_V                  = 0x00000028,
    PRODUCT_ENTERPRISE_SERVER_CORE_V                = 0x00000029,
    PRODUCT_HYPERV                                  = 0x0000002a,
    PRODUCT_STORAGE_EXPRESS_SERVER_CORE             = 0x0000002b,
    PRODUCT_STORAGE_STANDARD_SERVER_CORE            = 0x0000002c,
    PRODUCT_STORAGE_WORKGROUP_SERVER_CORE           = 0x0000002d,
    PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE          = 0x0000002e,
    PRODUCT_STARTER_N                               = 0x0000002f,
    PRODUCT_PROFESSIONAL                            = 0x00000030,
    PRODUCT_PROFESSIONAL_N                          = 0x00000031,
    PRODUCT_SB_SOLUTION_SERVER                      = 0x00000032,
    PRODUCT_SERVER_FOR_SB_SOLUTIONS                 = 0x00000033,
    PRODUCT_STANDARD_SERVER_SOLUTIONS               = 0x00000034,
    PRODUCT_STANDARD_SERVER_SOLUTIONS_CORE          = 0x00000035,
    PRODUCT_SB_SOLUTION_SERVER_EM                   = 0x00000036,
    PRODUCT_SERVER_FOR_SB_SOLUTIONS_EM              = 0x00000037,
    PRODUCT_SOLUTION_EMBEDDEDSERVER                 = 0x00000038,
    PRODUCT_SOLUTION_EMBEDDEDSERVER_CORE            = 0x00000039,
    PRODUCT_PROFESSIONAL_EMBEDDED                   = 0x0000003a,
    PRODUCT_ESSENTIALBUSINESS_SERVER_MGMT           = 0x0000003b,
    PRODUCT_ESSENTIALBUSINESS_SERVER_ADDL           = 0x0000003c,
    PRODUCT_ESSENTIALBUSINESS_SERVER_MGMTSVC        = 0x0000003d,
    PRODUCT_ESSENTIALBUSINESS_SERVER_ADDLSVC        = 0x0000003e,
    PRODUCT_SMALLBUSINESS_SERVER_PREMIUM_CORE       = 0x0000003f,
    PRODUCT_CLUSTER_SERVER_V                        = 0x00000040,
    PRODUCT_EMBEDDED                                = 0x00000041,
    PRODUCT_STARTER_E                               = 0x00000042,
    PRODUCT_HOME_BASIC_E                            = 0x00000043,
    PRODUCT_HOME_PREMIUM_E                          = 0x00000044,
    PRODUCT_PROFESSIONAL_E                          = 0x00000045,
    PRODUCT_ENTERPRISE_E                            = 0x00000046,
    PRODUCT_ULTIMATE_E                              = 0x00000047,
    PRODUCT_ENTERPRISE_EVALUATION                   = 0x00000048,
    PRODUCT_MULTIPOINT_STANDARD_SERVER              = 0x0000004c,
    PRODUCT_MULTIPOINT_PREMIUM_SERVER               = 0x0000004d,
    PRODUCT_STANDARD_EVALUATION_SERVER              = 0x0000004f,
    PRODUCT_DATACENTER_EVALUATION_SERVER            = 0x00000050,
    PRODUCT_ENTERPRISE_N_EVALUATION                 = 0x00000054,
    PRODUCT_EMBEDDED_AUTOMOTIVE                     = 0x00000055,
    PRODUCT_EMBEDDED_INDUSTRY_A                     = 0x00000056,
    PRODUCT_THINPC                                  = 0x00000057,
    PRODUCT_EMBEDDED_A                              = 0x00000058,
    PRODUCT_EMBEDDED_INDUSTRY                       = 0x00000059,
    PRODUCT_EMBEDDED_E                              = 0x0000005a,
    PRODUCT_EMBEDDED_INDUSTRY_E                     = 0x0000005b,
    PRODUCT_EMBEDDED_INDUSTRY_A_E                   = 0x0000005c,
    PRODUCT_STORAGE_WORKGROUP_EVALUATION_SERVER     = 0x0000005f,
    PRODUCT_STORAGE_STANDARD_EVALUATION_SERVER      = 0x00000060,
    PRODUCT_CORE_ARM                                = 0x00000061,
    PRODUCT_CORE_N                                  = 0x00000062,
    PRODUCT_CORE_COUNTRYSPECIFIC                    = 0x00000063,
    PRODUCT_CORE_SINGLELANGUAGE                     = 0x00000064,
    PRODUCT_CORE                                    = 0x00000065,
    PRODUCT_PROFESSIONAL_WMC                        = 0x00000067,
    PRODUCT_EMBEDDED_INDUSTRY_EVAL                  = 0x00000069,
    PRODUCT_EMBEDDED_INDUSTRY_E_EVAL                = 0x0000006a,
    PRODUCT_EMBEDDED_EVAL                           = 0x0000006b,
    PRODUCT_EMBEDDED_E_EVAL                         = 0x0000006c,
    PRODUCT_NANO_SERVER                             = 0x0000006d,
    PRODUCT_CLOUD_STORAGE_SERVER                    = 0x0000006e,
    PRODUCT_CORE_CONNECTED                          = 0x0000006f,
    PRODUCT_PROFESSIONAL_STUDENT                    = 0x00000070,
    PRODUCT_CORE_CONNECTED_N                        = 0x00000071,
    PRODUCT_PROFESSIONAL_STUDENT_N                  = 0x00000072,
    PRODUCT_CORE_CONNECTED_SINGLELANGUAGE           = 0x00000073,
    PRODUCT_CORE_CONNECTED_COUNTRYSPECIFIC          = 0x00000074,
    PRODUCT_CONNECTED_CAR                           = 0x00000075,
    PRODUCT_INDUSTRY_HANDHELD                       = 0x00000076,
    PRODUCT_PPI_PRO                                 = 0x00000077,
    PRODUCT_ARM64_SERVER                            = 0x00000078,
    PRODUCT_EDUCATION                               = 0x00000079,
    PRODUCT_EDUCATION_N                             = 0x0000007a,
    PRODUCT_IOTUAP                                  = 0x0000007b,
    PRODUCT_CLOUD_HOST_INFRASTRUCTURE_SERVER        = 0x0000007c,
    PRODUCT_ENTERPRISE_S                            = 0x0000007d,
    PRODUCT_ENTERPRISE_S_N                          = 0x0000007e,
    PRODUCT_PROFESSIONAL_S                          = 0x0000007f,
    PRODUCT_PROFESSIONAL_S_N                        = 0x00000080,
    PRODUCT_ENTERPRISE_S_EVALUATION                 = 0x00000081,
    PRODUCT_ENTERPRISE_S_N_EVALUATION               = 0x00000082,
    PRODUCT_HOLOGRAPHIC                             = 0x00000087,
    PRODUCT_HOLOGRAPHIC_BUSINESS                    = 0x00000088,
    PRODUCT_PRO_SINGLE_LANGUAGE                     = 0x0000008a,
    PRODUCT_PRO_CHINA                               = 0x0000008b,
    PRODUCT_ENTERPRISE_SUBSCRIPTION                 = 0x0000008c,
    PRODUCT_ENTERPRISE_SUBSCRIPTION_N               = 0x0000008d,
    PRODUCT_DATACENTER_NANO_SERVER                  = 0x0000008f,
    PRODUCT_STANDARD_NANO_SERVER                    = 0x00000090,
    PRODUCT_DATACENTER_A_SERVER_CORE                = 0x00000091,
    PRODUCT_STANDARD_A_SERVER_CORE                  = 0x00000092,
    PRODUCT_DATACENTER_WS_SERVER_CORE               = 0x00000093,
    PRODUCT_STANDARD_WS_SERVER_CORE                 = 0x00000094,
    PRODUCT_UTILITY_VM                              = 0x00000095,
    PRODUCT_DATACENTER_EVALUATION_SERVER_CORE       = 0x0000009f,
    PRODUCT_STANDARD_EVALUATION_SERVER_CORE         = 0x000000a0,
    PRODUCT_PRO_WORKSTATION                         = 0x000000a1,
    PRODUCT_PRO_WORKSTATION_N                       = 0x000000a2,
    PRODUCT_PRO_FOR_EDUCATION                       = 0x000000a4,
    PRODUCT_PRO_FOR_EDUCATION_N                     = 0x000000a5,
    PRODUCT_AZURE_SERVER_CORE                       = 0x000000a8,
    PRODUCT_AZURE_NANO_SERVER                       = 0x000000a9,
    PRODUCT_ENTERPRISEG                             = 0x000000ab,
    PRODUCT_ENTERPRISEGN                            = 0x000000ac,
    PRODUCT_SERVERRDSH                              = 0x000000af,
    PRODUCT_CLOUD                                   = 0x000000b2,
    PRODUCT_CLOUDN                                  = 0x000000b3,
    PRODUCT_HUBOS                                   = 0x000000b4,
    PRODUCT_ONECOREUPDATEOS                         = 0x000000b6,
    PRODUCT_CLOUDE                                  = 0x000000b7,
    PRODUCT_IOTOS                                   = 0x000000b9,
    PRODUCT_CLOUDEN                                 = 0x000000ba,
    PRODUCT_IOTEDGEOS                               = 0x000000bb,
    PRODUCT_IOTENTERPRISE                           = 0x000000bc,
    PRODUCT_LITE                                    = 0x000000bd,
    PRODUCT_IOTENTERPRISES                          = 0x000000bf,
    PRODUCT_XBOX_SYSTEMOS                           = 0x000000c0,
    PRODUCT_XBOX_GAMEOS                             = 0x000000c2,
    PRODUCT_XBOX_ERAOS                              = 0x000000c3,
    PRODUCT_XBOX_DURANGOHOSTOS                      = 0x000000c4,
    PRODUCT_XBOX_SCARLETTHOSTOS                     = 0x000000c5,
    PRODUCT_XBOX_KEYSTONE                           = 0x000000c6,
    PRODUCT_AZURE_SERVER_CLOUDHOST                  = 0x000000c7,
    PRODUCT_AZURE_SERVER_CLOUDMOS                   = 0x000000c8,
    PRODUCT_CLOUDEDITIONN                           = 0x000000ca,
    PRODUCT_CLOUDEDITION                            = 0x000000cb,
    PRODUCT_VALIDATION                              = 0x000000cc,
    PRODUCT_IOTENTERPRISESK                         = 0x000000cd,
    PRODUCT_IOTENTERPRISEK                          = 0x000000ce,
    PRODUCT_IOTENTERPRISESEVAL                      = 0x000000cf,
    PRODUCT_AZURE_SERVER_AGENTBRIDGE                = 0x000000d0,
    PRODUCT_AZURE_SERVER_NANOHOST                   = 0x000000d1,
    PRODUCT_WNC                                     = 0x000000d2,
    PRODUCT_AZURESTACKHCI_SERVER_CORE               = 0x00000196,
    PRODUCT_DATACENTER_SERVER_AZURE_EDITION         = 0x00000197,
    PRODUCT_DATACENTER_SERVER_CORE_AZURE_EDITION    = 0x00000198,
    PRODUCT_DATACENTER_WS_SERVER_CORE_AZURE_EDITION = 0x00000199,
    PRODUCT_UNLICENSED                              = 0xabcdabcd,
}

alias DEVICEFAMILYINFOENUM = uint;
enum : uint
{
    DEVICEFAMILYINFOENUM_UAP                   = 0x00000000,
    DEVICEFAMILYINFOENUM_WINDOWS_8X            = 0x00000001,
    DEVICEFAMILYINFOENUM_WINDOWS_PHONE_8X      = 0x00000002,
    DEVICEFAMILYINFOENUM_DESKTOP               = 0x00000003,
    DEVICEFAMILYINFOENUM_MOBILE                = 0x00000004,
    DEVICEFAMILYINFOENUM_XBOX                  = 0x00000005,
    DEVICEFAMILYINFOENUM_TEAM                  = 0x00000006,
    DEVICEFAMILYINFOENUM_IOT                   = 0x00000007,
    DEVICEFAMILYINFOENUM_IOT_HEADLESS          = 0x00000008,
    DEVICEFAMILYINFOENUM_SERVER                = 0x00000009,
    DEVICEFAMILYINFOENUM_HOLOGRAPHIC           = 0x0000000a,
    DEVICEFAMILYINFOENUM_XBOXSRA               = 0x0000000b,
    DEVICEFAMILYINFOENUM_XBOXERA               = 0x0000000c,
    DEVICEFAMILYINFOENUM_SERVER_NANO           = 0x0000000d,
    DEVICEFAMILYINFOENUM_8828080               = 0x0000000e,
    DEVICEFAMILYINFOENUM_7067329               = 0x0000000f,
    DEVICEFAMILYINFOENUM_WINDOWS_CORE          = 0x00000010,
    DEVICEFAMILYINFOENUM_WINDOWS_CORE_HEADLESS = 0x00000011,
    DEVICEFAMILYINFOENUM_MAX                   = 0x00000011,
}

alias DEVICEFAMILYDEVICEFORM = uint;
enum : uint
{
    DEVICEFAMILYDEVICEFORM_UNKNOWN               = 0x00000000,
    DEVICEFAMILYDEVICEFORM_PHONE                 = 0x00000001,
    DEVICEFAMILYDEVICEFORM_TABLET                = 0x00000002,
    DEVICEFAMILYDEVICEFORM_DESKTOP               = 0x00000003,
    DEVICEFAMILYDEVICEFORM_NOTEBOOK              = 0x00000004,
    DEVICEFAMILYDEVICEFORM_CONVERTIBLE           = 0x00000005,
    DEVICEFAMILYDEVICEFORM_DETACHABLE            = 0x00000006,
    DEVICEFAMILYDEVICEFORM_ALLINONE              = 0x00000007,
    DEVICEFAMILYDEVICEFORM_STICKPC               = 0x00000008,
    DEVICEFAMILYDEVICEFORM_PUCK                  = 0x00000009,
    DEVICEFAMILYDEVICEFORM_LARGESCREEN           = 0x0000000a,
    DEVICEFAMILYDEVICEFORM_HMD                   = 0x0000000b,
    DEVICEFAMILYDEVICEFORM_INDUSTRY_HANDHELD     = 0x0000000c,
    DEVICEFAMILYDEVICEFORM_INDUSTRY_TABLET       = 0x0000000d,
    DEVICEFAMILYDEVICEFORM_BANKING               = 0x0000000e,
    DEVICEFAMILYDEVICEFORM_BUILDING_AUTOMATION   = 0x0000000f,
    DEVICEFAMILYDEVICEFORM_DIGITAL_SIGNAGE       = 0x00000010,
    DEVICEFAMILYDEVICEFORM_GAMING                = 0x00000011,
    DEVICEFAMILYDEVICEFORM_HOME_AUTOMATION       = 0x00000012,
    DEVICEFAMILYDEVICEFORM_INDUSTRIAL_AUTOMATION = 0x00000013,
    DEVICEFAMILYDEVICEFORM_KIOSK                 = 0x00000014,
    DEVICEFAMILYDEVICEFORM_MAKER_BOARD           = 0x00000015,
    DEVICEFAMILYDEVICEFORM_MEDICAL               = 0x00000016,
    DEVICEFAMILYDEVICEFORM_NETWORKING            = 0x00000017,
    DEVICEFAMILYDEVICEFORM_POINT_OF_SERVICE      = 0x00000018,
    DEVICEFAMILYDEVICEFORM_PRINTING              = 0x00000019,
    DEVICEFAMILYDEVICEFORM_THIN_CLIENT           = 0x0000001a,
    DEVICEFAMILYDEVICEFORM_TOY                   = 0x0000001b,
    DEVICEFAMILYDEVICEFORM_VENDING               = 0x0000001c,
    DEVICEFAMILYDEVICEFORM_INDUSTRY_OTHER        = 0x0000001d,
    DEVICEFAMILYDEVICEFORM_XBOX_ONE              = 0x0000001e,
    DEVICEFAMILYDEVICEFORM_XBOX_ONE_S            = 0x0000001f,
    DEVICEFAMILYDEVICEFORM_XBOX_ONE_X            = 0x00000020,
    DEVICEFAMILYDEVICEFORM_XBOX_ONE_X_DEVKIT     = 0x00000021,
    DEVICEFAMILYDEVICEFORM_XBOX_SERIES_X         = 0x00000022,
    DEVICEFAMILYDEVICEFORM_XBOX_SERIES_X_DEVKIT  = 0x00000023,
    DEVICEFAMILYDEVICEFORM_XBOX_SERIES_S         = 0x00000024,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_01      = 0x00000025,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_02      = 0x00000026,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_03      = 0x00000027,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_04      = 0x00000028,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_05      = 0x00000029,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_06      = 0x0000002a,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_07      = 0x0000002b,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_08      = 0x0000002c,
    DEVICEFAMILYDEVICEFORM_XBOX_RESERVED_09      = 0x0000002d,
    DEVICEFAMILYDEVICEFORM_GAMING_HANDHELD       = 0x0000002e,
    DEVICEFAMILYDEVICEFORM_GAMING_CONSOLE        = 0x0000002f,
    DEVICEFAMILYDEVICEFORM_MAX                   = 0x0000002f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/ne-sysinfoapi-computer_name_format))], [])

alias COMPUTER_NAME_FORMAT = int;
enum : int
{
    ComputerNameNetBIOS                   = 0x00000000,
    ComputerNameDnsHostname               = 0x00000001,
    ComputerNameDnsDomain                 = 0x00000002,
    ComputerNameDnsFullyQualified         = 0x00000003,
    ComputerNamePhysicalNetBIOS           = 0x00000004,
    ComputerNamePhysicalDnsHostname       = 0x00000005,
    ComputerNamePhysicalDnsDomain         = 0x00000006,
    ComputerNamePhysicalDnsFullyQualified = 0x00000007,
    ComputerNameMax                       = 0x00000008,
}

alias DEVELOPER_DRIVE_ENABLEMENT_STATE = int;
enum : int
{
    DeveloperDriveEnablementStateError   = 0x00000000,
    DeveloperDriveEnabled                = 0x00000001,
    DeveloperDriveDisabledBySystemPolicy = 0x00000002,
    DeveloperDriveDisabledByGroupPolicy  = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-firmware_type))], [])

alias FIRMWARE_TYPE = int;
enum : int
{
    FirmwareTypeUnknown = 0x00000000,
    FirmwareTypeBios    = 0x00000001,
    FirmwareTypeUefi    = 0x00000002,
    FirmwareTypeMax     = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-logical_processor_relationship))], [])

alias LOGICAL_PROCESSOR_RELATIONSHIP = int;
enum : int
{
    RelationProcessorCore    = 0x00000000,
    RelationNumaNode         = 0x00000001,
    RelationCache            = 0x00000002,
    RelationProcessorPackage = 0x00000003,
    RelationGroup            = 0x00000004,
    RelationProcessorDie     = 0x00000005,
    RelationNumaNodeEx       = 0x00000006,
    RelationProcessorModule  = 0x00000007,
    RelationAll              = 0x0000ffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-processor_cache_type))], [])

alias PROCESSOR_CACHE_TYPE = int;
enum : int
{
    CacheUnified     = 0x00000000,
    CacheInstruction = 0x00000001,
    CacheData        = 0x00000002,
    CacheTrace       = 0x00000003,
    CacheUnknown     = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/ProcThread/cpu-set-information-type))], [])

alias CPU_SET_INFORMATION_TYPE = int;
enum : int
{
    CpuSetInformation = 0x00000000,
}

alias OS_DEPLOYEMENT_STATE_VALUES = int;
enum : int
{
    OS_DEPLOYMENT_STANDARD = 0x00000001,
    OS_DEPLOYMENT_COMPACT  = 0x00000002,
}

alias RTL_SYSTEM_GLOBAL_DATA_ID = int;
enum : int
{
    GlobalDataIdUnknown                     = 0x00000000,
    GlobalDataIdRngSeedVersion              = 0x00000001,
    GlobalDataIdInterruptTime               = 0x00000002,
    GlobalDataIdTimeZoneBias                = 0x00000003,
    GlobalDataIdImageNumberLow              = 0x00000004,
    GlobalDataIdImageNumberHigh             = 0x00000005,
    GlobalDataIdTimeZoneId                  = 0x00000006,
    GlobalDataIdNtMajorVersion              = 0x00000007,
    GlobalDataIdNtMinorVersion              = 0x00000008,
    GlobalDataIdSystemExpirationDate        = 0x00000009,
    GlobalDataIdKdDebuggerEnabled           = 0x0000000a,
    GlobalDataIdCyclesPerYield              = 0x0000000b,
    GlobalDataIdSafeBootMode                = 0x0000000c,
    GlobalDataIdLastSystemRITEventTickCount = 0x0000000d,
    GlobalDataIdConsoleSharedDataFlags      = 0x0000000e,
    GlobalDataIdNtSystemRootDrive           = 0x0000000f,
    GlobalDataIdQpcBypassEnabled            = 0x00000010,
    GlobalDataIdQpcData                     = 0x00000011,
    GlobalDataIdQpcBias                     = 0x00000012,
}

alias DEP_SYSTEM_POLICY_TYPE = int;
enum : int
{
    DEPPolicyAlwaysOff  = 0x00000000,
    DEPPolicyAlwaysOn   = 0x00000001,
    DEPPolicyOptIn      = 0x00000002,
    DEPPolicyOptOut     = 0x00000003,
    DEPTotalPolicyCount = 0x00000004,
}

// Constants


enum : uint
{
    NTDDI_WIN2K        = 0x05000000,
    NTDDI_WINXP        = 0x05010000,
    NTDDI_WINXPSP2     = 0x05010200,
    NTDDI_WS03SP1      = 0x05020100,
    NTDDI_VISTA        = 0x06000000,
    NTDDI_VISTASP1     = 0x06000100,
    NTDDI_WIN7         = 0x06010000,
    NTDDI_WIN8         = 0x06020000,
    NTDDI_WINBLUE      = 0x06030000,
    NTDDI_WINTHRESHOLD = 0x0a000000,
}

enum : uint
{
    SYSTEM_CPU_SET_INFORMATION_ALLOCATED                   = 0x00000002,
    SYSTEM_CPU_SET_INFORMATION_ALLOCATED_TO_TARGET_PROCESS = 0x00000004,
    SYSTEM_CPU_SET_INFORMATION_REALTIME                    = 0x00000008,
}

enum : uint
{
    _WIN32_WINNT_WIN2K        = 0x00000500,
    _WIN32_WINNT_WINXP        = 0x00000501,
    _WIN32_WINNT_WS03         = 0x00000502,
    _WIN32_WINNT_WIN6         = 0x00000600,
    _WIN32_WINNT_VISTA        = 0x00000600,
    _WIN32_WINNT_WS08         = 0x00000600,
    _WIN32_WINNT_LONGHORN     = 0x00000600,
    _WIN32_WINNT_WIN7         = 0x00000601,
    _WIN32_WINNT_WIN8         = 0x00000602,
    _WIN32_WINNT_WINBLUE      = 0x00000603,
    _WIN32_WINNT_WINTHRESHOLD = 0x00000a00,
    _WIN32_WINNT_WIN10        = 0x00000a00,
}

enum : uint
{
    _WIN32_IE_IE30         = 0x00000300,
    _WIN32_IE_IE302        = 0x00000302,
    _WIN32_IE_IE40         = 0x00000400,
    _WIN32_IE_IE401        = 0x00000401,
    _WIN32_IE_IE50         = 0x00000500,
    _WIN32_IE_IE501        = 0x00000501,
    _WIN32_IE_IE55         = 0x00000550,
    _WIN32_IE_IE60         = 0x00000600,
    _WIN32_IE_IE60SP1      = 0x00000601,
    _WIN32_IE_IE60SP2      = 0x00000603,
    _WIN32_IE_IE70         = 0x00000700,
    _WIN32_IE_IE80         = 0x00000800,
    _WIN32_IE_IE90         = 0x00000900,
    _WIN32_IE_IE100        = 0x00000a00,
    _WIN32_IE_IE110        = 0x00000a00,
    _WIN32_IE_NT4          = 0x00000200,
    _WIN32_IE_NT4SP1       = 0x00000200,
    _WIN32_IE_NT4SP2       = 0x00000200,
    _WIN32_IE_NT4SP3       = 0x00000302,
    _WIN32_IE_NT4SP4       = 0x00000401,
    _WIN32_IE_NT4SP5       = 0x00000401,
    _WIN32_IE_NT4SP6       = 0x00000500,
    _WIN32_IE_WIN98        = 0x00000401,
    _WIN32_IE_WIN98SE      = 0x00000500,
    _WIN32_IE_WINME        = 0x00000550,
    _WIN32_IE_WIN2K        = 0x00000501,
    _WIN32_IE_WIN2KSP1     = 0x00000501,
    _WIN32_IE_WIN2KSP2     = 0x00000501,
    _WIN32_IE_WIN2KSP3     = 0x00000501,
    _WIN32_IE_WIN2KSP4     = 0x00000501,
    _WIN32_IE_XP           = 0x00000600,
    _WIN32_IE_XPSP1        = 0x00000601,
    _WIN32_IE_XPSP2        = 0x00000603,
    _WIN32_IE_WS03         = 0x00000602,
    _WIN32_IE_WS03SP1      = 0x00000603,
    _WIN32_IE_WIN6         = 0x00000700,
    _WIN32_IE_LONGHORN     = 0x00000700,
    _WIN32_IE_WIN7         = 0x00000800,
    _WIN32_IE_WIN8         = 0x00000a00,
    _WIN32_IE_WINBLUE      = 0x00000a00,
    _WIN32_IE_WINTHRESHOLD = 0x00000a00,
    _WIN32_IE_WIN10        = 0x00000a00,
}

enum : uint
{
    NTDDI_WIN2KSP1   = 0x05000100,
    NTDDI_WIN2KSP2   = 0x05000200,
    NTDDI_WIN2KSP3   = 0x05000300,
    NTDDI_WIN2KSP4   = 0x05000400,
    NTDDI_WINXPSP1   = 0x05010100,
    NTDDI_WINXPSP3   = 0x05010300,
    NTDDI_WINXPSP4   = 0x05010400,
    NTDDI_WS03       = 0x05020000,
    NTDDI_WS03SP2    = 0x05020200,
    NTDDI_WS03SP3    = 0x05020300,
    NTDDI_WS03SP4    = 0x05020400,
    NTDDI_WIN6       = 0x06000000,
    NTDDI_WIN6SP1    = 0x06000100,
    NTDDI_WIN6SP2    = 0x06000200,
    NTDDI_WIN6SP3    = 0x06000300,
    NTDDI_WIN6SP4    = 0x06000400,
    NTDDI_VISTASP2   = 0x06000200,
    NTDDI_VISTASP3   = 0x06000300,
    NTDDI_VISTASP4   = 0x06000400,
    NTDDI_LONGHORN   = 0x06000000,
    NTDDI_WS08       = 0x06000100,
    NTDDI_WS08SP2    = 0x06000200,
    NTDDI_WS08SP3    = 0x06000300,
    NTDDI_WS08SP4    = 0x06000400,
    NTDDI_WIN10      = 0x0a000000,
    NTDDI_WIN10_TH2  = 0x0a000001,
    NTDDI_WIN10_RS1  = 0x0a000002,
    NTDDI_WIN10_RS2  = 0x0a000003,
    NTDDI_WIN10_RS3  = 0x0a000004,
    NTDDI_WIN10_RS4  = 0x0a000005,
    NTDDI_WIN10_RS5  = 0x0a000006,
    NTDDI_WIN10_19H1 = 0x0a000007,
    NTDDI_WIN10_VB   = 0x0a000008,
    NTDDI_WIN10_MN   = 0x0a000009,
    NTDDI_WIN10_FE   = 0x0a00000a,
    NTDDI_WIN10_CO   = 0x0a00000b,
    NTDDI_WIN10_NI   = 0x0a00000c,
    NTDDI_WIN10_CU   = 0x0a00000d,
    NTDDI_WIN11_ZN   = 0x0a00000e,
    NTDDI_WIN11_GA   = 0x0a00000f,
    NTDDI_WIN11_GE   = 0x0a000010,
}

enum uint OSVERSION_MASK = 0xffff0000;
enum uint SUBVERSION_MASK = 0x000000ff;
enum uint SCEX2_ALT_NETBIOS_NAME = 0x00000001;

// Callbacks

//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias PGET_SYSTEM_WOW64_DIRECTORY_A = uint function(PSTR lpBuffer, uint uSize);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias PGET_SYSTEM_WOW64_DIRECTORY_W = uint function(PWSTR lpBuffer, uint uSize);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-group_affinity))], [])
struct GROUP_AFFINITY
{
    size_t    Mask;
    ushort    Group;
    ushort[3] Reserved;
}

struct GROUP_AFFINITY32
{
    uint      Mask;
    ushort    Group;
    ushort[3] Reserved;
}

struct GROUP_AFFINITY64
{
    ulong     Mask;
    ushort    Group;
    ushort[3] Reserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/ns-sysinfoapi-system_info))], [])
struct SYSTEM_INFO
{
union Anonymous
    {
        uint dwOemId;
struct Anonymous
        {
            PROCESSOR_ARCHITECTURE wProcessorArchitecture;
            ushort wReserved;
        }
    }
    uint   dwPageSize;
    void*  lpMinimumApplicationAddress;
    void*  lpMaximumApplicationAddress;
    size_t dwActiveProcessorMask;
    uint   dwNumberOfProcessors;
    uint   dwProcessorType;
    uint   dwAllocationGranularity;
    ushort wProcessorLevel;
    ushort wProcessorRevision;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/ns-sysinfoapi-memorystatusex))], [])
struct MEMORYSTATUSEX
{
    uint  dwLength;
    uint  dwMemoryLoad;
    ulong ullTotalPhys;
    ulong ullAvailPhys;
    ulong ullTotalPageFile;
    ulong ullAvailPageFile;
    ulong ullTotalVirtual;
    ulong ullAvailVirtual;
    ulong ullAvailExtendedVirtual;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-cache_descriptor))], [])
struct CACHE_DESCRIPTOR
{
    ubyte                Level;
    ubyte                Associativity;
    ushort               LineSize;
    uint                 Size;
    PROCESSOR_CACHE_TYPE Type;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_logical_processor_information))], [])
struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION
{
    size_t ProcessorMask;
    LOGICAL_PROCESSOR_RELATIONSHIP Relationship;
union Anonymous
    {
struct ProcessorCore
        {
            ubyte Flags;
        }
struct NumaNode
        {
            uint NodeNumber;
        }
        CACHE_DESCRIPTOR Cache;
        ulong[2]         Reserved;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_relationship))], [])
struct PROCESSOR_RELATIONSHIP
{
    ubyte     Flags;
    ubyte     EfficiencyClass;
    ubyte[20] Reserved;
    ushort    GroupCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/GROUP_AFFINITY[1] GroupMask;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-numa_node_relationship))], [])
struct NUMA_NODE_RELATIONSHIP
{
    uint      NodeNumber;
    ubyte[18] Reserved;
    ushort    GroupCount;
union Anonymous
    {
        GROUP_AFFINITY GroupMask;
        /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/GROUP_AFFINITY[1] GroupMasks;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-cache_relationship))], [])
struct CACHE_RELATIONSHIP
{
    ubyte                Level;
    ubyte                Associativity;
    ushort               LineSize;
    uint                 CacheSize;
    PROCESSOR_CACHE_TYPE Type;
    ubyte[18]            Reserved;
    ushort               GroupCount;
union Anonymous
    {
        GROUP_AFFINITY GroupMask;
        /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/GROUP_AFFINITY[1] GroupMasks;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_group_info))], [])
struct PROCESSOR_GROUP_INFO
{
    ubyte     MaximumProcessorCount;
    ubyte     ActiveProcessorCount;
    ubyte[38] Reserved;
    size_t    ActiveProcessorMask;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-group_relationship))], [])
struct GROUP_RELATIONSHIP
{
    ushort    MaximumGroupCount;
    ushort    ActiveGroupCount;
    ubyte[20] Reserved;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PROCESSOR_GROUP_INFO[1] GroupInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_logical_processor_information_ex))], [])
struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX
{
    LOGICAL_PROCESSOR_RELATIONSHIP Relationship;
    uint Size;
union Anonymous
    {
        PROCESSOR_RELATIONSHIP Processor;
        NUMA_NODE_RELATIONSHIP NumaNode;
        CACHE_RELATIONSHIP Cache;
        GROUP_RELATIONSHIP Group;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_cpu_set_information))], [])
struct SYSTEM_CPU_SET_INFORMATION
{
    uint Size;
    CPU_SET_INFORMATION_TYPE Type;
union Anonymous
    {
struct CpuSet
        {
            uint   Id;
            ushort Group;
            ubyte  LogicalProcessorIndex;
            ubyte  CoreIndex;
            ubyte  LastLevelCacheIndex;
            ubyte  NumaNodeIndex;
            ubyte  EfficiencyClass;
union Anonymous1
            {
                ubyte                AllFlags;
struct Anonymous
                {
                align (1):
                    ushort   Flags;
                    ushort   MappedPort;
                    IN_ADDR  MappedAddress;
                    IN_ADDR  LocalAddress;
                    uint     InterfaceIndex;
                    ushort   LocalPort;
                    DL_EUI48 DlDestination;
                }
            }
union Anonymous2
            {
                uint  Reserved;
                ubyte SchedulingClass;
            }
            ulong  AllocationTag;
        }
    }
}

struct SYSTEM_POOL_ZEROING_INFORMATION
{
    BOOLEAN PoolZeroingSupportPresent;
}

struct SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION
{
    ulong CycleTime;
}

struct SYSTEM_SUPPORTED_PROCESSOR_ARCHITECTURES_INFORMATION
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedZero0)), FixedArgSig(ElementSig(21)), FixedArgSig(ElementSig(11))], [])*/uint _bitfield43;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-osversioninfoa))], [])
struct OSVERSIONINFOA
{
    uint      dwOSVersionInfoSize;
    uint      dwMajorVersion;
    uint      dwMinorVersion;
    uint      dwBuildNumber;
    uint      dwPlatformId;
    CHAR[128] szCSDVersion;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-osversioninfow))], [])
struct OSVERSIONINFOW
{
    uint       dwOSVersionInfoSize;
    uint       dwMajorVersion;
    uint       dwMinorVersion;
    uint       dwBuildNumber;
    uint       dwPlatformId;
    wchar[128] szCSDVersion;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-osversioninfoexa))], [])
struct OSVERSIONINFOEXA
{
    uint      dwOSVersionInfoSize;
    uint      dwMajorVersion;
    uint      dwMinorVersion;
    uint      dwBuildNumber;
    uint      dwPlatformId;
    CHAR[128] szCSDVersion;
    ushort    wServicePackMajor;
    ushort    wServicePackMinor;
    ushort    wSuiteMask;
    ubyte     wProductType;
    ubyte     wReserved;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-osversioninfoexw))], [])
struct OSVERSIONINFOEXW
{
    uint       dwOSVersionInfoSize;
    uint       dwMajorVersion;
    uint       dwMinorVersion;
    uint       dwBuildNumber;
    uint       dwPlatformId;
    wchar[128] szCSDVersion;
    ushort     wServicePackMajor;
    ushort     wServicePackMinor;
    ushort     wSuiteMask;
    ubyte      wProductType;
    ubyte      wReserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-memorystatus))], [])
struct MEMORYSTATUS
{
    uint   dwLength;
    uint   dwMemoryLoad;
    size_t dwTotalPhys;
    size_t dwAvailPhys;
    size_t dwTotalPageFile;
    size_t dwAvailPageFile;
    size_t dwTotalVirtual;
    size_t dwAvailVirtual;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-globalmemorystatusex))], [])
@DllImport("KERNEL32.dll")
BOOL GlobalMemoryStatusEx(MEMORYSTATUSEX* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsysteminfo))], [])
@DllImport("KERNEL32.dll")
void GetSystemInfo(SYSTEM_INFO* lpSystemInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemtime))], [])
@DllImport("KERNEL32.dll")
void GetSystemTime(SYSTEMTIME* lpSystemTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemtimeasfiletime))], [])
@DllImport("KERNEL32.dll")
void GetSystemTimeAsFileTime(FILETIME* lpSystemTimeAsFileTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getlocaltime))], [])
@DllImport("KERNEL32.dll")
void GetLocalTime(SYSTEMTIME* lpSystemTime);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-isusercetavailableinenvironment))], [])
@DllImport("KERNEL32.dll")
BOOL IsUserCetAvailableInEnvironment(USER_CET_ENVIRONMENT UserCetEnvironment);

@DllImport("KERNEL32.dll")
BOOL GetSystemLeapSecondInformation(BOOL* Enabled, uint* Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getversion))], [])
@DllImport("KERNEL32.dll")
uint GetVersion();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-setlocaltime))], [])
@DllImport("KERNEL32.dll")
BOOL SetLocalTime(const(SYSTEMTIME)* lpSystemTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount))], [])
@DllImport("KERNEL32.dll")
uint GetTickCount();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount64))], [])
@DllImport("KERNEL32.dll")
ulong GetTickCount64();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemtimeadjustment))], [])
@DllImport("KERNEL32.dll")
BOOL GetSystemTimeAdjustment(uint* lpTimeAdjustment, uint* lpTimeIncrement, BOOL* lpTimeAdjustmentDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemtimeadjustmentprecise))], [])
@DllImport("api-ms-win-core-sysinfo-l1-2-4.dll")
BOOL GetSystemTimeAdjustmentPrecise(ulong* lpTimeAdjustment, ulong* lpTimeIncrement, 
                                    BOOL* lpTimeAdjustmentDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemdirectorya))], [])
@DllImport("KERNEL32.dll")
uint GetSystemDirectoryA(PSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemdirectoryw))], [])
@DllImport("KERNEL32.dll")
uint GetSystemDirectoryW(PWSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getwindowsdirectorya))], [])
@DllImport("KERNEL32.dll")
uint GetWindowsDirectoryA(PSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getwindowsdirectoryw))], [])
@DllImport("KERNEL32.dll")
uint GetWindowsDirectoryW(PWSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemwindowsdirectorya))], [])
@DllImport("KERNEL32.dll")
uint GetSystemWindowsDirectoryA(PSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemwindowsdirectoryw))], [])
@DllImport("KERNEL32.dll")
uint GetSystemWindowsDirectoryW(PWSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getcomputernameexa))], [])
@DllImport("KERNEL32.dll")
BOOL GetComputerNameExA(COMPUTER_NAME_FORMAT NameType, PSTR lpBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getcomputernameexw))], [])
@DllImport("KERNEL32.dll")
BOOL GetComputerNameExW(COMPUTER_NAME_FORMAT NameType, PWSTR lpBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-setcomputernameexw))], [])
@DllImport("KERNEL32.dll")
BOOL SetComputerNameExW(COMPUTER_NAME_FORMAT NameType, const(PWSTR) lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-setsystemtime))], [])
@DllImport("KERNEL32.dll")
BOOL SetSystemTime(const(SYSTEMTIME)* lpSystemTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getversionexa))], [])
@DllImport("KERNEL32.dll")
BOOL GetVersionExA(OSVERSIONINFOA* lpVersionInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getversionexw))], [])
@DllImport("KERNEL32.dll")
BOOL GetVersionExW(OSVERSIONINFOW* lpVersionInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getlogicalprocessorinformation))], [])
@DllImport("KERNEL32.dll")
BOOL GetLogicalProcessorInformation(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SYSTEM_LOGICAL_PROCESSOR_INFORMATION* Buffer, 
                                    uint* ReturnedLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getlogicalprocessorinformationex))], [])
@DllImport("KERNEL32.dll")
BOOL GetLogicalProcessorInformationEx(LOGICAL_PROCESSOR_RELATIONSHIP RelationshipType, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX* Buffer, 
                                      uint* ReturnedLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getnativesysteminfo))], [])
@DllImport("KERNEL32.dll")
void GetNativeSystemInfo(SYSTEM_INFO* lpSystemInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemtimepreciseasfiletime))], [])
@DllImport("KERNEL32.dll")
void GetSystemTimePreciseAsFileTime(FILETIME* lpSystemTimeAsFileTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getproductinfo))], [])
@DllImport("KERNEL32.dll")
BOOL GetProductInfo(uint dwOSMajorVersion, uint dwOSMinorVersion, uint dwSpMajorVersion, uint dwSpMinorVersion, 
                    OS_PRODUCT_TYPE* pdwReturnedProductType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-versetconditionmask))], [])
@DllImport("KERNEL32.dll")
ulong VerSetConditionMask(ulong ConditionMask, VER_FLAGS TypeMask, ubyte Condition);

@DllImport("api-ms-win-core-sysinfo-l1-2-0.dll")
BOOL GetOsSafeBootMode(uint* Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-enumsystemfirmwaretables))], [])
@DllImport("KERNEL32.dll")
uint EnumSystemFirmwareTables(FIRMWARE_TABLE_PROVIDER FirmwareTableProviderSignature, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pFirmwareTableEnumBuffer, 
                              uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemfirmwaretable))], [])
@DllImport("KERNEL32.dll")
uint GetSystemFirmwareTable(FIRMWARE_TABLE_PROVIDER FirmwareTableProviderSignature, uint FirmwareTableID, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pFirmwareTableBuffer, 
                            uint BufferSize);

@DllImport("KERNEL32.dll")
BOOL DnsHostnameToComputerNameExW(const(PWSTR) Hostname, PWSTR ComputerName, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getphysicallyinstalledsystemmemory))], [])
@DllImport("KERNEL32.dll")
BOOL GetPhysicallyInstalledSystemMemory(ulong* TotalMemoryInKilobytes);

@DllImport("KERNEL32.dll")
BOOL SetComputerNameEx2W(COMPUTER_NAME_FORMAT NameType, uint Flags, const(PWSTR) lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-setsystemtimeadjustment))], [])
@DllImport("KERNEL32.dll")
BOOL SetSystemTimeAdjustment(uint dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-setsystemtimeadjustmentprecise))], [])
@DllImport("api-ms-win-core-sysinfo-l1-2-4.dll")
BOOL SetSystemTimeAdjustmentPrecise(ulong dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getprocessorsystemcycletime))], [])
@DllImport("KERNEL32.dll")
BOOL GetProcessorSystemCycleTime(ushort Group, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION* Buffer, 
                                 uint* ReturnedLength);

@DllImport("api-ms-win-core-sysinfo-l1-2-3.dll")
BOOL GetOsManufacturingMode(BOOL* pbEnabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-getintegrateddisplaysize))], [])
@DllImport("api-ms-win-core-sysinfo-l1-2-3.dll")
HRESULT GetIntegratedDisplaySize(double* sizeInInches);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-setcomputernamea))], [])
@DllImport("KERNEL32.dll")
BOOL SetComputerNameA(const(PSTR) lpComputerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-setcomputernamew))], [])
@DllImport("KERNEL32.dll")
BOOL SetComputerNameW(const(PWSTR) lpComputerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sysinfoapi/nf-sysinfoapi-setcomputernameexa))], [])
@DllImport("KERNEL32.dll")
BOOL SetComputerNameExA(COMPUTER_NAME_FORMAT NameType, const(PSTR) lpBuffer);

@DllImport("api-ms-win-core-sysinfo-l1-2-6.dll")
DEVELOPER_DRIVE_ENABLEMENT_STATE GetDeveloperDriveEnablementState();

@DllImport("KERNEL32.dll")
BOOL GetRuntimeAttestationReport(ubyte* Nonce, ushort PackageVersion, ulong ReportTypesBitmap, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ReportBuffer, 
                                 uint* ReportBufferSize);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/ProcThread/getsystemcpusetinformation))], [])
@DllImport("KERNEL32.dll")
BOOL GetSystemCpuSetInformation(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SYSTEM_CPU_SET_INFORMATION* Information, 
                                uint BufferLength, uint* ReturnedLength, HANDLE Process, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wow64apiset/nf-wow64apiset-getsystemwow64directorya))], [])
@DllImport("KERNEL32.dll")
uint GetSystemWow64DirectoryA(PSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wow64apiset/nf-wow64apiset-getsystemwow64directoryw))], [])
@DllImport("KERNEL32.dll")
uint GetSystemWow64DirectoryW(PWSTR lpBuffer, uint uSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10586))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wow64apiset/nf-wow64apiset-getsystemwow64directory2a))], [])
@DllImport("api-ms-win-core-wow64-l1-1-1.dll")
uint GetSystemWow64Directory2A(PSTR lpBuffer, uint uSize, IMAGE_FILE_MACHINE ImageFileMachineType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10586))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wow64apiset/nf-wow64apiset-getsystemwow64directory2w))], [])
@DllImport("api-ms-win-core-wow64-l1-1-1.dll")
uint GetSystemWow64Directory2W(PWSTR lpBuffer, uint uSize, IMAGE_FILE_MACHINE ImageFileMachineType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wow64apiset/nf-wow64apiset-iswow64guestmachinesupported))], [])
@DllImport("KERNEL32.dll")
HRESULT IsWow64GuestMachineSupported(IMAGE_FILE_MACHINE WowGuestMachine, BOOL* MachineIsSupported);

@DllImport("ntdll.dll")
BOOLEAN RtlGetProductInfo(uint OSMajorVersion, uint OSMinorVersion, uint SpMajorVersion, uint SpMinorVersion, 
                          uint* ReturnedProductType);

@DllImport("ntdll.dll")
OS_DEPLOYEMENT_STATE_VALUES RtlOsDeploymentState(uint Flags);

@DllImport("ntdllk.dll")
uint RtlGetSystemGlobalData(RTL_SYSTEM_GLOBAL_DATA_ID DataId, void* Buffer, uint Size);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/DevNotes/rtlgetdevicefamilyinfoenum))], [])
@DllImport("ntdll.dll")
void RtlGetDeviceFamilyInfoEnum(ulong* pullUAPInfo, DEVICEFAMILYINFOENUM* pulDeviceFamily, 
                                DEVICEFAMILYDEVICEFORM* pulDeviceForm);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlconvertdevicefamilyinfotostring))], [])
@DllImport("ntdll.dll")
uint RtlConvertDeviceFamilyInfoToString(uint* pulDeviceFamilyBufferSize, uint* pulDeviceFormBufferSize, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/PWSTR DeviceFamily, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PWSTR DeviceForm);

@DllImport("ntdll.dll")
uint RtlSwitchedVVI(OSVERSIONINFOEXW* VersionInfo, uint TypeMask, ulong ConditionMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globalmemorystatus))], [])
@DllImport("KERNEL32.dll")
void GlobalMemoryStatus(MEMORYSTATUS* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-getsystemdeppolicy))], [])
@DllImport("KERNEL32.dll")
DEP_SYSTEM_POLICY_TYPE GetSystemDEPPolicy();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-getfirmwaretype))], [])
@DllImport("KERNEL32.dll")
BOOL GetFirmwareType(FIRMWARE_TYPE* FirmwareType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-verifyversioninfoa))], [])
@DllImport("KERNEL32.dll")
BOOL VerifyVersionInfoA(OSVERSIONINFOEXA* lpVersionInformation, VER_FLAGS dwTypeMask, ulong dwlConditionMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-verifyversioninfow))], [])
@DllImport("KERNEL32.dll")
BOOL VerifyVersionInfoW(OSVERSIONINFOEXW* lpVersionInformation, VER_FLAGS dwTypeMask, ulong dwlConditionMask);


