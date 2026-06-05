// Written in the D programming language.

module windows.win32.system.power;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, DEVPROPKEY, HANDLE, HRESULT, LPARAM, NTSTATUS, PWSTR,
                                         WIN32_ERROR;
public import windows.win32.system.registry : HKEY, REG_SAM_FLAGS;
public import windows.win32.system.threading : REASON_CONTEXT;
public import windows.win32.ui.windowsandmessaging : REGISTER_NOTIFICATION_FLAGS;

extern(Windows) @nogc nothrow:


// Enums


alias POWER_COOLING_MODE = ushort;
enum : ushort
{
    PO_TZ_ACTIVE       = cast(ushort)0x0000,
    PO_TZ_PASSIVE      = cast(ushort)0x0001,
    PO_TZ_INVALID_MODE = cast(ushort)0x0002,
}

alias POWER_PLATFORM_ROLE_VERSION = uint;
enum : uint
{
    POWER_PLATFORM_ROLE_V1 = 0x00000001,
    POWER_PLATFORM_ROLE_V2 = 0x00000002,
}

alias EXECUTION_STATE = uint;
enum : uint
{
    ES_AWAYMODE_REQUIRED = 0x00000040,
    ES_CONTINUOUS        = 0x80000000,
    ES_DISPLAY_REQUIRED  = 0x00000002,
    ES_SYSTEM_REQUIRED   = 0x00000001,
    ES_USER_PRESENT      = 0x00000004,
}

alias POWER_ACTION_POLICY_EVENT_CODE = uint;
enum : uint
{
    POWER_FORCE_TRIGGER_RESET     = 0x80000000,
    POWER_LEVEL_USER_NOTIFY_EXEC  = 0x00000004,
    POWER_LEVEL_USER_NOTIFY_SOUND = 0x00000002,
    POWER_LEVEL_USER_NOTIFY_TEXT  = 0x00000001,
    POWER_USER_NOTIFY_BUTTON      = 0x00000008,
    POWER_USER_NOTIFY_SHUTDOWN    = 0x00000010,
}

alias DEVICE_POWER_CAPABILITIES = uint;
enum : uint
{
    PDCAP_D0_SUPPORTED           = 0x00000001,
    PDCAP_D1_SUPPORTED           = 0x00000002,
    PDCAP_D2_SUPPORTED           = 0x00000004,
    PDCAP_D3_SUPPORTED           = 0x00000008,
    PDCAP_WAKE_FROM_D0_SUPPORTED = 0x00000010,
    PDCAP_WAKE_FROM_D1_SUPPORTED = 0x00000020,
    PDCAP_WAKE_FROM_D2_SUPPORTED = 0x00000040,
    PDCAP_WAKE_FROM_D3_SUPPORTED = 0x00000080,
    PDCAP_WARM_EJECT_SUPPORTED   = 0x00000100,
    PDCAP_S0_SUPPORTED           = 0x00010000,
    PDCAP_S1_SUPPORTED           = 0x00020000,
    PDCAP_S2_SUPPORTED           = 0x00040000,
    PDCAP_S3_SUPPORTED           = 0x00080000,
    PDCAP_WAKE_FROM_S0_SUPPORTED = 0x00100000,
    PDCAP_WAKE_FROM_S1_SUPPORTED = 0x00200000,
    PDCAP_WAKE_FROM_S2_SUPPORTED = 0x00400000,
    PDCAP_WAKE_FROM_S3_SUPPORTED = 0x00800000,
    PDCAP_S4_SUPPORTED           = 0x01000000,
    PDCAP_S5_SUPPORTED           = 0x02000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/ne-powersetting-effective_power_mode))], [])

alias EFFECTIVE_POWER_MODE = int;
enum : int
{
    EffectivePowerModeBatterySaver           = 0x00000000,
    EffectivePowerModeEnergySaverHighSavings = 0x00000000,
    EffectivePowerModeBetterBattery          = 0x00000001,
    EffectivePowerModeEnergySaverStandard    = 0x00000001,
    EffectivePowerModeBalanced               = 0x00000002,
    EffectivePowerModeHighPerformance        = 0x00000003,
    EffectivePowerModeMaxPerformance         = 0x00000004,
    EffectivePowerModeGameMode               = 0x00000005,
    EffectivePowerModeMixedReality           = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ne-powrprof-power_data_accessor))], [])

alias POWER_DATA_ACCESSOR = int;
enum : int
{
    ACCESS_AC_POWER_SETTING_INDEX               = 0x00000000,
    ACCESS_DC_POWER_SETTING_INDEX               = 0x00000001,
    ACCESS_FRIENDLY_NAME                        = 0x00000002,
    ACCESS_DESCRIPTION                          = 0x00000003,
    ACCESS_POSSIBLE_POWER_SETTING               = 0x00000004,
    ACCESS_POSSIBLE_POWER_SETTING_FRIENDLY_NAME = 0x00000005,
    ACCESS_POSSIBLE_POWER_SETTING_DESCRIPTION   = 0x00000006,
    ACCESS_DEFAULT_AC_POWER_SETTING             = 0x00000007,
    ACCESS_DEFAULT_DC_POWER_SETTING             = 0x00000008,
    ACCESS_POSSIBLE_VALUE_MIN                   = 0x00000009,
    ACCESS_POSSIBLE_VALUE_MAX                   = 0x0000000a,
    ACCESS_POSSIBLE_VALUE_INCREMENT             = 0x0000000b,
    ACCESS_POSSIBLE_VALUE_UNITS                 = 0x0000000c,
    ACCESS_ICON_RESOURCE                        = 0x0000000d,
    ACCESS_DEFAULT_SECURITY_DESCRIPTOR          = 0x0000000e,
    ACCESS_ATTRIBUTES                           = 0x0000000f,
    ACCESS_SCHEME                               = 0x00000010,
    ACCESS_SUBGROUP                             = 0x00000011,
    ACCESS_INDIVIDUAL_SETTING                   = 0x00000012,
    ACCESS_ACTIVE_SCHEME                        = 0x00000013,
    ACCESS_CREATE_SCHEME                        = 0x00000014,
    ACCESS_AC_POWER_SETTING_MAX                 = 0x00000015,
    ACCESS_DC_POWER_SETTING_MAX                 = 0x00000016,
    ACCESS_AC_POWER_SETTING_MIN                 = 0x00000017,
    ACCESS_DC_POWER_SETTING_MIN                 = 0x00000018,
    ACCESS_PROFILE                              = 0x00000019,
    ACCESS_OVERLAY_SCHEME                       = 0x0000001a,
    ACCESS_POWER_MODE                           = 0x0000001a,
    ACCESS_ACTIVE_OVERLAY_SCHEME                = 0x0000001b,
}

alias BATTERY_QUERY_INFORMATION_LEVEL = int;
enum : int
{
    BatteryInformation            = 0x00000000,
    BatteryGranularityInformation = 0x00000001,
    BatteryTemperature            = 0x00000002,
    BatteryEstimatedTime          = 0x00000003,
    BatteryDeviceName             = 0x00000004,
    BatteryManufactureDate        = 0x00000005,
    BatteryManufactureName        = 0x00000006,
    BatteryUniqueID               = 0x00000007,
    BatterySerialNumber           = 0x00000008,
}

alias BATTERY_CHARGING_SOURCE_TYPE = int;
enum : int
{
    BatteryChargingSourceType_AC       = 0x00000001,
    BatteryChargingSourceType_USB      = 0x00000002,
    BatteryChargingSourceType_Wireless = 0x00000003,
    BatteryChargingSourceType_Max      = 0x00000004,
}

alias USB_CHARGER_PORT = int;
enum : int
{
    UsbChargerPort_Legacy = 0x00000000,
    UsbChargerPort_TypeC  = 0x00000001,
    UsbChargerPort_Max    = 0x00000002,
}

alias BATTERY_SET_INFORMATION_LEVEL = int;
enum : int
{
    BatteryCriticalBias   = 0x00000000,
    BatteryCharge         = 0x00000001,
    BatteryDischarge      = 0x00000002,
    BatteryChargingSource = 0x00000003,
    BatteryChargerId      = 0x00000004,
    BatteryChargerStatus  = 0x00000005,
}

alias ACPI_TIME_RESOLUTION = int;
enum : int
{
    AcpiTimeResolutionMilliseconds = 0x00000000,
    AcpiTimeResolutionSeconds      = 0x00000001,
    AcpiTimeResolutionMax          = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emi/ne-emi-emi_measurement_unit))], [])

alias EMI_MEASUREMENT_UNIT = int;
enum : int
{
    EmiMeasurementUnitPicowattHours = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-system_power_state))], [])

alias SYSTEM_POWER_STATE = int;
enum : int
{
    PowerSystemUnspecified = 0x00000000,
    PowerSystemWorking     = 0x00000001,
    PowerSystemSleeping1   = 0x00000002,
    PowerSystemSleeping2   = 0x00000003,
    PowerSystemSleeping3   = 0x00000004,
    PowerSystemHibernate   = 0x00000005,
    PowerSystemShutdown    = 0x00000006,
    PowerSystemMaximum     = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-power_action))], [])

alias POWER_ACTION = int;
enum : int
{
    PowerActionNone          = 0x00000000,
    PowerActionReserved      = 0x00000001,
    PowerActionSleep         = 0x00000002,
    PowerActionHibernate     = 0x00000003,
    PowerActionShutdown      = 0x00000004,
    PowerActionShutdownReset = 0x00000005,
    PowerActionShutdownOff   = 0x00000006,
    PowerActionWarmEject     = 0x00000007,
    PowerActionDisplayOff    = 0x00000008,
}

alias DEVICE_POWER_STATE = int;
enum : int
{
    PowerDeviceUnspecified = 0x00000000,
    PowerDeviceD0          = 0x00000001,
    PowerDeviceD1          = 0x00000002,
    PowerDeviceD2          = 0x00000003,
    PowerDeviceD3          = 0x00000004,
    PowerDeviceMaximum     = 0x00000005,
}

alias USER_ACTIVITY_PRESENCE = int;
enum : int
{
    PowerUserPresent    = 0x00000000,
    PowerUserNotPresent = 0x00000001,
    PowerUserInactive   = 0x00000002,
    PowerUserMaximum    = 0x00000003,
    PowerUserInvalid    = 0x00000003,
}

alias LATENCY_TIME = int;
enum : int
{
    LT_DONT_CARE      = 0x00000000,
    LT_LOWEST_LATENCY = 0x00000001,
}

alias POWER_REQUEST_TYPE = int;
enum : int
{
    PowerRequestDisplayRequired   = 0x00000000,
    PowerRequestSystemRequired    = 0x00000001,
    PowerRequestAwayModeRequired  = 0x00000002,
    PowerRequestExecutionRequired = 0x00000003,
}

alias POWER_INFORMATION_LEVEL = int;
enum : int
{
    SystemPowerPolicyAc                = 0x00000000,
    SystemPowerPolicyDc                = 0x00000001,
    VerifySystemPolicyAc               = 0x00000002,
    VerifySystemPolicyDc               = 0x00000003,
    SystemPowerCapabilities            = 0x00000004,
    SystemBatteryState                 = 0x00000005,
    SystemPowerStateHandler            = 0x00000006,
    ProcessorStateHandler              = 0x00000007,
    SystemPowerPolicyCurrent           = 0x00000008,
    AdministratorPowerPolicy           = 0x00000009,
    SystemReserveHiberFile             = 0x0000000a,
    ProcessorInformation               = 0x0000000b,
    SystemPowerInformation             = 0x0000000c,
    ProcessorStateHandler2             = 0x0000000d,
    LastWakeTime                       = 0x0000000e,
    LastSleepTime                      = 0x0000000f,
    SystemExecutionState               = 0x00000010,
    SystemPowerStateNotifyHandler      = 0x00000011,
    ProcessorPowerPolicyAc             = 0x00000012,
    ProcessorPowerPolicyDc             = 0x00000013,
    VerifyProcessorPowerPolicyAc       = 0x00000014,
    VerifyProcessorPowerPolicyDc       = 0x00000015,
    ProcessorPowerPolicyCurrent        = 0x00000016,
    SystemPowerStateLogging            = 0x00000017,
    SystemPowerLoggingEntry            = 0x00000018,
    SetPowerSettingValue               = 0x00000019,
    NotifyUserPowerSetting             = 0x0000001a,
    PowerInformationLevelUnused0       = 0x0000001b,
    SystemMonitorHiberBootPowerOff     = 0x0000001c,
    SystemVideoState                   = 0x0000001d,
    TraceApplicationPowerMessage       = 0x0000001e,
    TraceApplicationPowerMessageEnd    = 0x0000001f,
    ProcessorPerfStates                = 0x00000020,
    ProcessorIdleStates                = 0x00000021,
    ProcessorCap                       = 0x00000022,
    SystemWakeSource                   = 0x00000023,
    SystemHiberFileInformation         = 0x00000024,
    TraceServicePowerMessage           = 0x00000025,
    ProcessorLoad                      = 0x00000026,
    PowerShutdownNotification          = 0x00000027,
    MonitorCapabilities                = 0x00000028,
    SessionPowerInit                   = 0x00000029,
    SessionDisplayState                = 0x0000002a,
    PowerRequestCreate                 = 0x0000002b,
    PowerRequestAction                 = 0x0000002c,
    GetPowerRequestList                = 0x0000002d,
    ProcessorInformationEx             = 0x0000002e,
    NotifyUserModeLegacyPowerEvent     = 0x0000002f,
    GroupPark                          = 0x00000030,
    ProcessorIdleDomains               = 0x00000031,
    WakeTimerList                      = 0x00000032,
    SystemHiberFileSize                = 0x00000033,
    ProcessorIdleStatesHv              = 0x00000034,
    ProcessorPerfStatesHv              = 0x00000035,
    ProcessorPerfCapHv                 = 0x00000036,
    ProcessorSetIdle                   = 0x00000037,
    LogicalProcessorIdling             = 0x00000038,
    UserPresence                       = 0x00000039,
    PowerSettingNotificationName       = 0x0000003a,
    GetPowerSettingValue               = 0x0000003b,
    IdleResiliency                     = 0x0000003c,
    SessionRITState                    = 0x0000003d,
    SessionConnectNotification         = 0x0000003e,
    SessionPowerCleanup                = 0x0000003f,
    SessionLockState                   = 0x00000040,
    SystemHiberbootState               = 0x00000041,
    PlatformInformation                = 0x00000042,
    PdcInvocation                      = 0x00000043,
    MonitorInvocation                  = 0x00000044,
    FirmwareTableInformationRegistered = 0x00000045,
    SetShutdownSelectedTime            = 0x00000046,
    SuspendResumeInvocation            = 0x00000047,
    PlmPowerRequestCreate              = 0x00000048,
    ScreenOff                          = 0x00000049,
    CsDeviceNotification               = 0x0000004a,
    PlatformRole                       = 0x0000004b,
    LastResumePerformance              = 0x0000004c,
    DisplayBurst                       = 0x0000004d,
    ExitLatencySamplingPercentage      = 0x0000004e,
    RegisterSpmPowerSettings           = 0x0000004f,
    PlatformIdleStates                 = 0x00000050,
    ProcessorIdleVeto                  = 0x00000051,
    PlatformIdleVeto                   = 0x00000052,
    SystemBatteryStatePrecise          = 0x00000053,
    ThermalEvent                       = 0x00000054,
    PowerRequestActionInternal         = 0x00000055,
    BatteryDeviceState                 = 0x00000056,
    PowerInformationInternal           = 0x00000057,
    ThermalStandby                     = 0x00000058,
    SystemHiberFileType                = 0x00000059,
    PhysicalPowerButtonPress           = 0x0000005a,
    QueryPotentialDripsConstraint      = 0x0000005b,
    EnergyTrackerCreate                = 0x0000005c,
    EnergyTrackerQuery                 = 0x0000005d,
    UpdateBlackBoxRecorder             = 0x0000005e,
    SessionAllowExternalDmaDevices     = 0x0000005f,
    SendSuspendResumeNotification      = 0x00000060,
    BlackBoxRecorderDirectAccessBuffer = 0x00000061,
    SystemPowerSourceState             = 0x00000062,
    PowerInformationLevelMaximum       = 0x00000063,
}

alias POWER_USER_PRESENCE_TYPE = int;
enum : int
{
    UserNotPresent = 0x00000000,
    UserPresent    = 0x00000001,
    UserUnknown    = 0x000000ff,
}

alias POWER_MONITOR_REQUEST_REASON = int;
enum : int
{
    MonitorRequestReasonUnknown                        = 0x00000000,
    MonitorRequestReasonPowerButton                    = 0x00000001,
    MonitorRequestReasonRemoteConnection               = 0x00000002,
    MonitorRequestReasonScMonitorpower                 = 0x00000003,
    MonitorRequestReasonUserInput                      = 0x00000004,
    MonitorRequestReasonAcDcDisplayBurst               = 0x00000005,
    MonitorRequestReasonUserDisplayBurst               = 0x00000006,
    MonitorRequestReasonPoSetSystemState               = 0x00000007,
    MonitorRequestReasonSetThreadExecutionState        = 0x00000008,
    MonitorRequestReasonFullWake                       = 0x00000009,
    MonitorRequestReasonSessionUnlock                  = 0x0000000a,
    MonitorRequestReasonScreenOffRequest               = 0x0000000b,
    MonitorRequestReasonIdleTimeout                    = 0x0000000c,
    MonitorRequestReasonPolicyChange                   = 0x0000000d,
    MonitorRequestReasonSleepButton                    = 0x0000000e,
    MonitorRequestReasonLid                            = 0x0000000f,
    MonitorRequestReasonBatteryCountChange             = 0x00000010,
    MonitorRequestReasonGracePeriod                    = 0x00000011,
    MonitorRequestReasonPnP                            = 0x00000012,
    MonitorRequestReasonDP                             = 0x00000013,
    MonitorRequestReasonSxTransition                   = 0x00000014,
    MonitorRequestReasonSystemIdle                     = 0x00000015,
    MonitorRequestReasonNearProximity                  = 0x00000016,
    MonitorRequestReasonThermalStandby                 = 0x00000017,
    MonitorRequestReasonResumePdc                      = 0x00000018,
    MonitorRequestReasonResumeS4                       = 0x00000019,
    MonitorRequestReasonTerminal                       = 0x0000001a,
    MonitorRequestReasonPdcSignal                      = 0x0000001b,
    MonitorRequestReasonAcDcDisplayBurstSuppressed     = 0x0000001c,
    MonitorRequestReasonSystemStateEntered             = 0x0000001d,
    MonitorRequestReasonWinrt                          = 0x0000001e,
    MonitorRequestReasonUserInputKeyboard              = 0x0000001f,
    MonitorRequestReasonUserInputMouse                 = 0x00000020,
    MonitorRequestReasonUserInputTouchpad              = 0x00000021,
    MonitorRequestReasonUserInputPen                   = 0x00000022,
    MonitorRequestReasonUserInputAccelerometer         = 0x00000023,
    MonitorRequestReasonUserInputHid                   = 0x00000024,
    MonitorRequestReasonUserInputPoUserPresent         = 0x00000025,
    MonitorRequestReasonUserInputSessionSwitch         = 0x00000026,
    MonitorRequestReasonUserInputInitialization        = 0x00000027,
    MonitorRequestReasonPdcSignalWindowsMobilePwrNotif = 0x00000028,
    MonitorRequestReasonPdcSignalWindowsMobileShell    = 0x00000029,
    MonitorRequestReasonPdcSignalHeyCortana            = 0x0000002a,
    MonitorRequestReasonPdcSignalHolographicShell      = 0x0000002b,
    MonitorRequestReasonPdcSignalFingerprint           = 0x0000002c,
    MonitorRequestReasonDirectedDrips                  = 0x0000002d,
    MonitorRequestReasonDim                            = 0x0000002e,
    MonitorRequestReasonBuiltinPanel                   = 0x0000002f,
    MonitorRequestReasonDisplayRequiredUnDim           = 0x00000030,
    MonitorRequestReasonBatteryCountChangeSuppressed   = 0x00000031,
    MonitorRequestReasonResumeModernStandby            = 0x00000032,
    MonitorRequestReasonTerminalInit                   = 0x00000033,
    MonitorRequestReasonPdcSignalSensorsHumanPresence  = 0x00000034,
    MonitorRequestReasonBatteryPreCritical             = 0x00000035,
    MonitorRequestReasonUserInputTouch                 = 0x00000036,
    MonitorRequestReasonAusterityBatteryDrain          = 0x00000037,
    MonitorRequestReasonDozeRestrictedStandby          = 0x00000038,
    MonitorRequestReasonSmartRestrictedStandby         = 0x00000039,
    MonitorRequestReasonMax                            = 0x0000003a,
}

alias POWER_MONITOR_REQUEST_TYPE = int;
enum : int
{
    MonitorRequestTypeOff          = 0x00000000,
    MonitorRequestTypeOnAndPresent = 0x00000001,
    MonitorRequestTypeToggleOn     = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-system_power_condition))], [])

alias SYSTEM_POWER_CONDITION = int;
enum : int
{
    PoAc               = 0x00000000,
    PoDc               = 0x00000001,
    PoHot              = 0x00000002,
    PoConditionMaximum = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-power_platform_role))], [])

alias POWER_PLATFORM_ROLE = int;
enum : int
{
    PlatformRoleUnspecified       = 0x00000000,
    PlatformRoleDesktop           = 0x00000001,
    PlatformRoleMobile            = 0x00000002,
    PlatformRoleWorkstation       = 0x00000003,
    PlatformRoleEnterpriseServer  = 0x00000004,
    PlatformRoleSOHOServer        = 0x00000005,
    PlatformRoleAppliancePC       = 0x00000006,
    PlatformRolePerformanceServer = 0x00000007,
    PlatformRoleSlate             = 0x00000008,
    PlatformRoleMaximum           = 0x00000009,
}

alias POWER_SETTING_ALTITUDE = int;
enum : int
{
    ALTITUDE_GROUP_POLICY      = 0x00000000,
    ALTITUDE_USER              = 0x00000001,
    ALTITUDE_RUNTIME_OVERRIDE  = 0x00000002,
    ALTITUDE_PROVISIONING      = 0x00000003,
    ALTITUDE_OEM_CUSTOMIZATION = 0x00000004,
    ALTITUDE_INTERNAL_OVERRIDE = 0x00000005,
    ALTITUDE_OS_DEFAULT        = 0x00000006,
}

// Constants


enum : uint
{
    PPM_FIRMWARE_ACPI1C2      = 0x00000001,
    PPM_FIRMWARE_ACPI1C3      = 0x00000002,
    PPM_FIRMWARE_ACPI1TSTATES = 0x00000004,
    PPM_FIRMWARE_CST          = 0x00000008,
    PPM_FIRMWARE_CSD          = 0x00000010,
    PPM_FIRMWARE_PCT          = 0x00000020,
    PPM_FIRMWARE_PSS          = 0x00000040,
    PPM_FIRMWARE_XPSS         = 0x00000080,
    PPM_FIRMWARE_PPC          = 0x00000100,
    PPM_FIRMWARE_PSD          = 0x00000200,
    PPM_FIRMWARE_PTC          = 0x00000400,
    PPM_FIRMWARE_TSS          = 0x00000800,
    PPM_FIRMWARE_TPC          = 0x00001000,
    PPM_FIRMWARE_TSD          = 0x00002000,
    PPM_FIRMWARE_PCCH         = 0x00004000,
    PPM_FIRMWARE_PCCP         = 0x00008000,
    PPM_FIRMWARE_OSC          = 0x00010000,
    PPM_FIRMWARE_PDC          = 0x00020000,
    PPM_FIRMWARE_CPC          = 0x00040000,
    PPM_FIRMWARE_LPI          = 0x00080000,
}

enum : uint
{
    PPM_PERFORMANCE_IMPLEMENTATION_PSTATES = 0x00000001,
    PPM_PERFORMANCE_IMPLEMENTATION_PCCV1   = 0x00000002,
    PPM_PERFORMANCE_IMPLEMENTATION_CPPC    = 0x00000003,
    PPM_PERFORMANCE_IMPLEMENTATION_PEP     = 0x00000004,
}

enum : uint
{
    PPM_IDLE_IMPLEMENTATION_CSTATES   = 0x00000001,
    PPM_IDLE_IMPLEMENTATION_PEP       = 0x00000002,
    PPM_IDLE_IMPLEMENTATION_MICROPEP  = 0x00000003,
    PPM_IDLE_IMPLEMENTATION_LPISTATES = 0x00000004,
}

enum uint UNKNOWN_CAPACITY = 0xffffffff;
enum uint BATTERY_CAPACITY_RELATIVE = 0x40000000;

enum : uint
{
    BATTERY_SEALED                  = 0x10000000,
    BATTERY_SET_CHARGE_SUPPORTED    = 0x00000001,
    BATTERY_SET_DISCHARGE_SUPPORTED = 0x00000002,
}

enum uint BATTERY_SET_CHARGER_ID_SUPPORTED = 0x00000008;
enum uint BATTERY_UNKNOWN_CURRENT = 0xffffffff;

enum : uint
{
    BATTERY_USB_CHARGER_STATUS_FN_DEFAULT_USB = 0x00000001,
    BATTERY_USB_CHARGER_STATUS_UCM_PD         = 0x00000002,
}

enum uint BATTERY_UNKNOWN_RATE = 0x80000000;
enum uint UNKNOWN_VOLTAGE = 0xffffffff;

enum : uint
{
    BATTERY_DISCHARGING = 0x00000002,
    BATTERY_CHARGING    = 0x00000004,
    BATTERY_CRITICAL    = 0x00000008,
}

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Power/ioctl-battery-query-tag))], [])*/uint
{
    IOCTL_BATTERY_QUERY_TAG              = 0x00294040,
    IOCTL_BATTERY_QUERY_INFORMATION      = 0x00294044,
    IOCTL_BATTERY_SET_INFORMATION        = 0x00298048,
    IOCTL_BATTERY_QUERY_STATUS           = 0x0029404c,
    IOCTL_BATTERY_CHARGING_SOURCE_CHANGE = 0x00294050,
}

enum : uint
{
    IOCTL_QUERY_CUSTOMIZED_IO_CAPABILITIES     = 0x00294280,
    IOCTL_QUERY_CUSTOMIZED_INPUT_FROM_PLATFORM = 0x00294284,
}

enum uint MAX_ACTIVE_COOLING_LEVELS = 0x0000000a;
enum uint PASSIVE_COOLING = 0x00000001;
enum uint THERMAL_WAIT_READ_TIMEOUT_NONE = 0xffffffff;
enum uint TZ_ACTIVATION_REASON_CURRENT = 0x00000002;
enum uint THERMAL_POLICY_VERSION_2 = 0x00000002;
enum uint IOCTL_THERMAL_SET_COOLING_POLICY = 0x00298084;

enum : uint
{
    IOCTL_THERMAL_SET_PASSIVE_LIMIT = 0x0029808c,
    IOCTL_THERMAL_READ_TEMPERATURE  = 0x00294090,
    IOCTL_THERMAL_READ_POLICY       = 0x00294094,
}

enum uint IOCTL_NOTIFY_SWITCH_EVENT = 0x00294100;
enum uint IOCTL_GET_SYS_BUTTON_EVENT = 0x00294144;

enum : uint
{
    SYS_BUTTON_SLEEP          = 0x00000002,
    SYS_BUTTON_LID            = 0x00000004,
    SYS_BUTTON_WAKE           = 0x80000000,
    SYS_BUTTON_LID_STATE_MASK = 0x00030000,
    SYS_BUTTON_LID_OPEN       = 0x00010000,
    SYS_BUTTON_LID_CLOSED     = 0x00020000,
    SYS_BUTTON_LID_INITIAL    = 0x00040000,
    SYS_BUTTON_LID_CHANGED    = 0x00080000,
}

enum uint THERMAL_COOLING_INTERFACE_VERSION = 0x00000001;
enum uint POWER_LIMIT_INTERFACE_VERSION = 0x00000001;

enum : uint
{
    IOCTL_SET_WAKE_ALARM_VALUE  = 0x00298200,
    IOCTL_SET_WAKE_ALARM_POLICY = 0x00298204,
}

enum uint IOCTL_GET_WAKE_ALARM_POLICY = 0x0029c20c;

enum : uint
{
    ACPI_TIME_IN_DAYLIGHT  = 0x00000002,
    ACPI_TIME_ZONE_UNKNOWN = 0x000007ff,
}

enum uint IOCTL_ACPI_SET_REAL_TIME = 0x00298214;
enum uint IOCTL_GET_ACPI_TIME_AND_ALARM_CAPABILITIES = 0x0029421c;
enum uint BATTERY_NOTIFY_VERSION_2 = 0x00000002;

enum : uint
{
    BATTERY_MINIPORT_UPDATE_DATA_VER_1 = 0x00000001,
    BATTERY_MINIPORT_UPDATE_DATA_VER_2 = 0x00000002,
}

enum : uint
{
    BATTERY_CLASS_MINOR_VERSION   = 0x00000000,
    BATTERY_CLASS_MINOR_VERSION_1 = 0x00000001,
    BATTERY_CLASS_MINOR_VERSION_2 = 0x00000002,
}

enum uint ADAPTER_CLASS_MINOR_VERSION = 0x00000000;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emi/ni-emi-ioctl_emi_get_metadata_size))], [])*/uint
{
    IOCTL_EMI_GET_METADATA_SIZE = 0x00224004,
    IOCTL_EMI_GET_METADATA      = 0x00224008,
    IOCTL_EMI_GET_MEASUREMENT   = 0x0022400c,
}

enum : uint
{
    EMI_VERSION_V1 = 0x00000001,
    EMI_VERSION_V2 = 0x00000002,
}

enum uint EFFECTIVE_POWER_MODE_V2 = 0x00000002;
enum uint EnableMultiBatteryDisplay = 0x00000002;
enum uint EnableWakeOnRing = 0x00000008;

enum : uint
{
    POWER_ATTRIBUTE_HIDE      = 0x00000001,
    POWER_ATTRIBUTE_SHOW_AOAC = 0x00000002,
}

enum : uint
{
    DEVICEPOWER_AND_OPERATION           = 0x40000000,
    DEVICEPOWER_FILTER_DEVICES_PRESENT  = 0x20000000,
    DEVICEPOWER_FILTER_HARDWARE         = 0x10000000,
    DEVICEPOWER_FILTER_WAKEENABLED      = 0x08000000,
    DEVICEPOWER_FILTER_WAKEPROGRAMMABLE = 0x04000000,
    DEVICEPOWER_FILTER_ON_NAME          = 0x02000000,
    DEVICEPOWER_SET_WAKEENABLED         = 0x00000001,
    DEVICEPOWER_CLEAR_WAKEENABLED       = 0x00000002,
}

// Callbacks

//DELEGATE ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
alias EFFECTIVE_POWER_MODE_CALLBACK = void function(EFFECTIVE_POWER_MODE Mode, void* Context);
alias PWRSCHEMESENUMPROC_V1 = BOOLEAN function(uint Index, uint NameSize, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/byte* Name, 
                                               uint DescriptionSize, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/byte* Description, 
                                               POWER_POLICY* Policy, LPARAM Context);
alias PWRSCHEMESENUMPROC = BOOLEAN function(uint Index, uint NameSize, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PWSTR Name, 
                                            uint DescriptionSize, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR Description, 
                                            POWER_POLICY* Policy, LPARAM Context);
alias PDEVICE_NOTIFY_CALLBACK_ROUTINE = uint function(void* Context, uint Type, void* Setting);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Power/processor-power-information-str))], [])
struct PROCESSOR_POWER_INFORMATION
{
    uint Number;
    uint MaxMhz;
    uint CurrentMhz;
    uint MhzLimit;
    uint MaxIdleState;
    uint CurrentIdleState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Power/system-power-information-str))], [])
struct SYSTEM_POWER_INFORMATION
{
    uint               MaxIdlenessAllowed;
    uint               Idleness;
    uint               TimeRemaining;
    POWER_COOLING_MODE CoolingMode;
}

@RAIIFree!UnregisterPowerSettingNotification
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HPOWERNOTIFY
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-global_machine_power_policy))], [])
struct GLOBAL_MACHINE_POWER_POLICY
{
    uint               Revision;
    SYSTEM_POWER_STATE LidOpenWakeAc;
    SYSTEM_POWER_STATE LidOpenWakeDc;
    uint               BroadcastCapacityResolution;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-global_user_power_policy))], [])
struct GLOBAL_USER_POWER_POLICY
{
    uint                Revision;
    POWER_ACTION_POLICY PowerButtonAc;
    POWER_ACTION_POLICY PowerButtonDc;
    POWER_ACTION_POLICY SleepButtonAc;
    POWER_ACTION_POLICY SleepButtonDc;
    POWER_ACTION_POLICY LidCloseAc;
    POWER_ACTION_POLICY LidCloseDc;
    SYSTEM_POWER_LEVEL[4] DischargePolicy;
    uint                GlobalFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-global_power_policy))], [])
struct GLOBAL_POWER_POLICY
{
    GLOBAL_USER_POWER_POLICY user;
    GLOBAL_MACHINE_POWER_POLICY mach;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-machine_power_policy))], [])
struct MACHINE_POWER_POLICY
{
    uint                Revision;
    SYSTEM_POWER_STATE  MinSleepAc;
    SYSTEM_POWER_STATE  MinSleepDc;
    SYSTEM_POWER_STATE  ReducedLatencySleepAc;
    SYSTEM_POWER_STATE  ReducedLatencySleepDc;
    uint                DozeTimeoutAc;
    uint                DozeTimeoutDc;
    uint                DozeS4TimeoutAc;
    uint                DozeS4TimeoutDc;
    ubyte               MinThrottleAc;
    ubyte               MinThrottleDc;
    ubyte[2]            pad1;
    POWER_ACTION_POLICY OverThrottledAc;
    POWER_ACTION_POLICY OverThrottledDc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-machine_processor_power_policy))], [])
struct MACHINE_PROCESSOR_POWER_POLICY
{
    uint Revision;
    PROCESSOR_POWER_POLICY ProcessorPolicyAc;
    PROCESSOR_POWER_POLICY ProcessorPolicyDc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-user_power_policy))], [])
struct USER_POWER_POLICY
{
    uint                Revision;
    POWER_ACTION_POLICY IdleAc;
    POWER_ACTION_POLICY IdleDc;
    uint                IdleTimeoutAc;
    uint                IdleTimeoutDc;
    ubyte               IdleSensitivityAc;
    ubyte               IdleSensitivityDc;
    ubyte               ThrottlePolicyAc;
    ubyte               ThrottlePolicyDc;
    SYSTEM_POWER_STATE  MaxSleepAc;
    SYSTEM_POWER_STATE  MaxSleepDc;
    uint[2]             Reserved;
    uint                VideoTimeoutAc;
    uint                VideoTimeoutDc;
    uint                SpindownTimeoutAc;
    uint                SpindownTimeoutDc;
    BOOLEAN             OptimizeForPowerAc;
    BOOLEAN             OptimizeForPowerDc;
    ubyte               FanThrottleToleranceAc;
    ubyte               FanThrottleToleranceDc;
    ubyte               ForcedThrottleAc;
    ubyte               ForcedThrottleDc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-power_policy))], [])
struct POWER_POLICY
{
    USER_POWER_POLICY    user;
    MACHINE_POWER_POLICY mach;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-device_notify_subscribe_parameters))], [])
struct DEVICE_NOTIFY_SUBSCRIBE_PARAMETERS
{
    PDEVICE_NOTIFY_CALLBACK_ROUTINE Callback;
    void* Context;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-thermal_event))], [])
struct THERMAL_EVENT
{
    uint  Version;
    uint  Size;
    uint  Type;
    uint  Temperature;
    uint  TripPointTemperature;
    PWSTR Initiator;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Power/battery-query-information-str))], [])
struct BATTERY_QUERY_INFORMATION
{
    uint BatteryTag;
    BATTERY_QUERY_INFORMATION_LEVEL InformationLevel;
    uint AtRate;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Power/battery-information-str))], [])
struct BATTERY_INFORMATION
{
    uint     Capabilities;
    ubyte    Technology;
    ubyte[3] Reserved;
    ubyte[4] Chemistry;
    uint     DesignedCapacity;
    uint     FullChargedCapacity;
    uint     DefaultAlert1;
    uint     DefaultAlert2;
    uint     CriticalBias;
    uint     CycleCount;
}

struct BATTERY_CHARGING_SOURCE
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    uint MaxCurrent;
}

struct BATTERY_CHARGING_SOURCE_INFORMATION
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    BOOLEAN SourceOnline;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Power/battery-set-information-str))], [])
struct BATTERY_SET_INFORMATION
{
    uint BatteryTag;
    BATTERY_SET_INFORMATION_LEVEL InformationLevel;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Buffer;
}

struct BATTERY_CHARGER_STATUS
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] VaData;
}

struct BATTERY_USB_CHARGER_STATUS
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    uint             Reserved;
    uint             Flags;
    uint             MaxCurrent;
    uint             Voltage;
    USB_CHARGER_PORT PortType;
    ulong            PortId;
    void*            PowerSourceInformation;
    GUID             OemCharger;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Power/battery-wait-status-str))], [])
struct BATTERY_WAIT_STATUS
{
    uint BatteryTag;
    uint Timeout;
    uint PowerState;
    uint LowCapacity;
    uint HighCapacity;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Power/battery-status-str))], [])
struct BATTERY_STATUS
{
    uint PowerState;
    uint Capacity;
    uint Voltage;
    int  Rate;
}

union POWER_ADAPTER_POWER_STATES
{
struct States
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(3)), FixedArgSig(ElementSig(29))], [])*/uint _bitfield7;
    }
    uint AsUlong;
}

struct POWER_ADAPTER_STATUS
{
    ubyte    Version;
    ubyte[3] Reserved;
    POWER_ADAPTER_POWER_STATES PowerState;
    uint     PeakPower;
    uint     MaxOutputPower;
    uint     MaxInputPower;
    ulong    RecStartTime;
    ulong    RecEndTime;
}

struct POWER_ADAPTER_SET_STATUS_BUFFER
{
    ubyte    Version;
    BOOLEAN  RecOverride;
    ubyte[2] Reserved;
}

struct POWER_ADAPTER_CHARGE_REQUIREMENT
{
    uint AcAdapterType;
    uint MinimumPower;
    uint NominalPower;
    uint MaximumPower;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Power/battery-manufacture-date-str))], [])
struct BATTERY_MANUFACTURE_DATE
{
    ubyte  Day;
    ubyte  Month;
    ushort Year;
}

struct CUSTOMIZED_IO_CAPABILITIES
{
    uint SupportedInputs;
    uint SupportedOutputs;
}

struct CUSTOMIZED_IO_QUERY_INPUT_RETURN
{
    uint FunctionId;
    uint ErrorCode;
    uint Value;
}

struct CUSTOMIZED_IO_SEND_OUTPUT_BUFFER
{
    uint FunctionId;
    uint Value;
}

struct THERMAL_INFORMATION
{
    uint     ThermalStamp;
    uint     ThermalConstant1;
    uint     ThermalConstant2;
    size_t   Processors;
    uint     SamplingPeriod;
    uint     CurrentTemperature;
    uint     PassiveTripPoint;
    uint     CriticalTripPoint;
    ubyte    ActiveTripPointCount;
    uint[10] ActiveTripPoint;
}

struct THERMAL_WAIT_READ
{
    uint Timeout;
    uint LowTemperature;
    uint HighTemperature;
}

struct THERMAL_POLICY
{
    uint    Version;
    BOOLEAN WaitForUpdate;
    BOOLEAN Hibernate;
    BOOLEAN Critical;
    BOOLEAN ThermalStandby;
    uint    ActivationReasons;
    uint    PassiveLimit;
    uint    ActiveLevel;
    BOOLEAN OverThrottled;
}

struct PROCESSOR_OBJECT_INFO
{
    uint  PhysicalID;
    uint  PBlkAddress;
    ubyte PBlkLength;
}

struct PROCESSOR_OBJECT_INFO_EX
{
    uint  PhysicalID;
    uint  PBlkAddress;
    ubyte PBlkLength;
    uint  InitialApicId;
}

struct WAKE_ALARM_INFORMATION
{
    uint TimerIdentifier;
    uint Timeout;
}

struct ACPI_REAL_TIME
{
    ushort   Year;
    ubyte    Month;
    ubyte    Day;
    ubyte    Hour;
    ubyte    Minute;
    ubyte    Second;
    ubyte    Valid;
    ushort   Milliseconds;
    short    TimeZone;
    ubyte    DayLight;
    ubyte[3] Reserved1;
}

struct ACPI_TIME_AND_ALARM_CAPABILITIES
{
    BOOLEAN              AcWakeSupported;
    BOOLEAN              DcWakeSupported;
    BOOLEAN              S4AcWakeSupported;
    BOOLEAN              S4DcWakeSupported;
    BOOLEAN              S5AcWakeSupported;
    BOOLEAN              S5DcWakeSupported;
    BOOLEAN              S4S5WakeStatusSupported;
    uint                 DeepestWakeSystemState;
    BOOLEAN              RealTimeFeaturesSupported;
    ACPI_TIME_RESOLUTION RealTimeResolution;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_version))], [])
struct EMI_VERSION
{
    ushort EmiVersion;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_metadata_size))], [])
struct EMI_METADATA_SIZE
{
    uint MetadataSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_channel_measurement_data))], [])
struct EMI_CHANNEL_MEASUREMENT_DATA
{
    ulong AbsoluteEnergy;
    ulong AbsoluteTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_metadata_v1))], [])
struct EMI_METADATA_V1
{
    EMI_MEASUREMENT_UNIT MeasurementUnit;
    wchar[16]            HardwareOEM;
    wchar[16]            HardwareModel;
    ushort               HardwareRevision;
    ushort               MeteredHardwareNameSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] MeteredHardwareName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_channel_v2))], [])
struct EMI_CHANNEL_V2
{
    EMI_MEASUREMENT_UNIT MeasurementUnit;
    ushort               ChannelNameSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] ChannelName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_metadata_v2))], [])
struct EMI_METADATA_V2
{
    wchar[16] HardwareOEM;
    wchar[16] HardwareModel;
    ushort    HardwareRevision;
    ushort    ChannelCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/EMI_CHANNEL_V2[1] Channels;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_measurement_data_v2))], [])
struct EMI_MEASUREMENT_DATA_V2
{
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/EMI_CHANNEL_MEASUREMENT_DATA[1] ChannelData;
}

struct CM_POWER_DATA
{
    uint               PD_Size;
    DEVICE_POWER_STATE PD_MostRecentPowerState;
    uint               PD_Capabilities;
    uint               PD_D1Latency;
    uint               PD_D2Latency;
    uint               PD_D3Latency;
    DEVICE_POWER_STATE[7] PD_PowerStateMapping;
    SYSTEM_POWER_STATE PD_DeepestSystemWake;
}

struct POWER_USER_PRESENCE
{
    POWER_USER_PRESENCE_TYPE UserPresence;
}

struct POWER_SESSION_CONNECT
{
    BOOLEAN Connected;
    BOOLEAN Console;
}

struct POWER_SESSION_TIMEOUTS
{
    uint InputTimeout;
    uint DisplayTimeout;
}

struct POWER_SESSION_RIT_STATE
{
    BOOLEAN Active;
    ulong   LastInputTime;
}

struct POWER_SESSION_WINLOGON
{
    uint    SessionId;
    BOOLEAN Console;
    BOOLEAN Locked;
}

struct POWER_SESSION_ALLOW_EXTERNAL_DMA_DEVICES
{
    BOOLEAN IsAllowed;
}

struct POWER_IDLE_RESILIENCY
{
    uint CoalescingTimeout;
    uint IdleResiliencyPeriod;
}

struct POWER_MONITOR_INVOCATION
{
    BOOLEAN Console;
    POWER_MONITOR_REQUEST_REASON RequestReason;
}

struct RESUME_PERFORMANCE
{
    uint  PostTimeMs;
    ulong TotalResumeTimeMs;
    ulong ResumeCompleteTimestamp;
}

struct SET_POWER_SETTING_VALUE
{
    uint Version;
    GUID Guid;
    SYSTEM_POWER_CONDITION PowerCondition;
    uint DataLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

struct POWER_PLATFORM_INFORMATION
{
    BOOLEAN AoAc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-battery_reporting_scale))], [])
struct BATTERY_REPORTING_SCALE
{
    uint Granularity;
    uint Capacity;
}

struct PPM_WMI_LEGACY_PERFSTATE
{
    uint Frequency;
    uint Flags;
    uint PercentFrequency;
}

struct PPM_WMI_IDLE_STATE
{
    uint  Latency;
    uint  Power;
    uint  TimeCheck;
    ubyte PromotePercent;
    ubyte DemotePercent;
    ubyte StateType;
    ubyte Reserved;
    uint  StateFlags;
    uint  Context;
    uint  IdleHandler;
    uint  Reserved1;
}

struct PPM_WMI_IDLE_STATES
{
    uint  Type;
    uint  Count;
    uint  TargetState;
    uint  OldState;
    ulong TargetProcessors;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PPM_WMI_IDLE_STATE[1] State;
}

struct PPM_WMI_IDLE_STATES_EX
{
    uint  Type;
    uint  Count;
    uint  TargetState;
    uint  OldState;
    void* TargetProcessors;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PPM_WMI_IDLE_STATE[1] State;
}

struct PPM_WMI_PERF_STATE
{
    uint  Frequency;
    uint  Power;
    ubyte PercentFrequency;
    ubyte IncreaseLevel;
    ubyte DecreaseLevel;
    ubyte Type;
    uint  IncreaseTime;
    uint  DecreaseTime;
    ulong Control;
    ulong Status;
    uint  HitCount;
    uint  Reserved1;
    ulong Reserved2;
    ulong Reserved3;
}

struct PPM_WMI_PERF_STATES
{
    uint  Count;
    uint  MaxFrequency;
    uint  CurrentState;
    uint  MaxPerfState;
    uint  MinPerfState;
    uint  LowestPerfState;
    uint  ThermalConstraint;
    ubyte BusyAdjThreshold;
    ubyte PolicyType;
    ubyte Type;
    ubyte Reserved;
    uint  TimerInterval;
    ulong TargetProcessors;
    uint  PStateHandler;
    uint  PStateContext;
    uint  TStateHandler;
    uint  TStateContext;
    uint  FeedbackHandler;
    uint  Reserved1;
    ulong Reserved2;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PPM_WMI_PERF_STATE[1] State;
}

struct PPM_WMI_PERF_STATES_EX
{
    uint  Count;
    uint  MaxFrequency;
    uint  CurrentState;
    uint  MaxPerfState;
    uint  MinPerfState;
    uint  LowestPerfState;
    uint  ThermalConstraint;
    ubyte BusyAdjThreshold;
    ubyte PolicyType;
    ubyte Type;
    ubyte Reserved;
    uint  TimerInterval;
    void* TargetProcessors;
    uint  PStateHandler;
    uint  PStateContext;
    uint  TStateHandler;
    uint  TStateContext;
    uint  FeedbackHandler;
    uint  Reserved1;
    ulong Reserved2;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PPM_WMI_PERF_STATE[1] State;
}

struct PPM_IDLE_STATE_ACCOUNTING
{
    uint    IdleTransitions;
    uint    FailedTransitions;
    uint    InvalidBucketIndex;
    ulong   TotalTime;
    uint[6] IdleTimeBuckets;
}

struct PPM_IDLE_ACCOUNTING
{
    uint  StateCount;
    uint  TotalTransitions;
    uint  ResetCount;
    ulong StartTime;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PPM_IDLE_STATE_ACCOUNTING[1] State;
}

struct PPM_IDLE_STATE_BUCKET_EX
{
    ulong TotalTimeUs;
    uint  MinTimeUs;
    uint  MaxTimeUs;
    uint  Count;
}

struct PPM_IDLE_STATE_ACCOUNTING_EX
{
    ulong TotalTime;
    uint  IdleTransitions;
    uint  FailedTransitions;
    uint  InvalidBucketIndex;
    uint  MinTimeUs;
    uint  MaxTimeUs;
    uint  CancelledTransitions;
    PPM_IDLE_STATE_BUCKET_EX[16] IdleTimeBuckets;
}

struct PPM_IDLE_ACCOUNTING_EX
{
    uint  StateCount;
    uint  TotalTransitions;
    uint  ResetCount;
    uint  AbortCount;
    ulong StartTime;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PPM_IDLE_STATE_ACCOUNTING_EX[1] State;
}

struct PPM_PERFSTATE_EVENT
{
    uint State;
    uint Status;
    uint Latency;
    uint Speed;
    uint Processor;
}

struct PPM_PERFSTATE_DOMAIN_EVENT
{
    uint  State;
    uint  Latency;
    uint  Speed;
    ulong Processors;
}

struct PPM_IDLESTATE_EVENT
{
    uint  NewState;
    uint  OldState;
    ulong Processors;
}

struct PPM_THERMALCHANGE_EVENT
{
    uint  ThermalConstraint;
    ulong Processors;
}

struct PPM_THERMAL_POLICY_EVENT
{
    ubyte Mode;
    ulong Processors;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-power_action_policy))], [])
struct POWER_ACTION_POLICY
{
    POWER_ACTION Action;
    uint         Flags;
    POWER_ACTION_POLICY_EVENT_CODE EventCode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_power_level))], [])
struct SYSTEM_POWER_LEVEL
{
    BOOLEAN             Enable;
    ubyte[3]            Spare;
    uint                BatteryLevel;
    POWER_ACTION_POLICY PowerPolicy;
    SYSTEM_POWER_STATE  MinSystemState;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_power_policy))], [])
struct SYSTEM_POWER_POLICY
{
    uint                Revision;
    POWER_ACTION_POLICY PowerButton;
    POWER_ACTION_POLICY SleepButton;
    POWER_ACTION_POLICY LidClose;
    SYSTEM_POWER_STATE  LidOpenWake;
    uint                Reserved;
    POWER_ACTION_POLICY Idle;
    uint                IdleTimeout;
    ubyte               IdleSensitivity;
    ubyte               DynamicThrottle;
    ubyte[2]            Spare2;
    SYSTEM_POWER_STATE  MinSleep;
    SYSTEM_POWER_STATE  MaxSleep;
    SYSTEM_POWER_STATE  ReducedLatencySleep;
    uint                WinLogonFlags;
    uint                Spare3;
    uint                DozeS4Timeout;
    uint                BroadcastCapacityResolution;
    SYSTEM_POWER_LEVEL[4] DischargePolicy;
    uint                VideoTimeout;
    BOOLEAN             VideoDimDisplay;
    uint[3]             VideoReserved;
    uint                SpindownTimeout;
    BOOLEAN             OptimizeForPower;
    ubyte               FanThrottleTolerance;
    ubyte               ForcedThrottle;
    ubyte               MinThrottle;
    POWER_ACTION_POLICY OverThrottled;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_power_policy_info))], [])
struct PROCESSOR_POWER_POLICY_INFO
{
    uint     TimeCheck;
    uint     DemoteLimit;
    uint     PromoteLimit;
    ubyte    DemotePercent;
    ubyte    PromotePercent;
    ubyte[2] Spare;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(2)), FixedArgSig(ElementSig(30))], [])*/uint _bitfield8;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_power_policy))], [])
struct PROCESSOR_POWER_POLICY
{
    uint     Revision;
    ubyte    DynamicThrottle;
    ubyte[3] Spare;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(31))], [])*/uint _bitfield9;
    uint     PolicyCount;
    PROCESSOR_POWER_POLICY_INFO[3] Policy;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-administrator_power_policy))], [])
struct ADMINISTRATOR_POWER_POLICY
{
    SYSTEM_POWER_STATE MinSleep;
    SYSTEM_POWER_STATE MaxSleep;
    uint               MinVideoTimeout;
    uint               MaxVideoTimeout;
    uint               MinSpindownTimeout;
    uint               MaxSpindownTimeout;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_power_capabilities))], [])
struct SYSTEM_POWER_CAPABILITIES
{
    BOOLEAN            PowerButtonPresent;
    BOOLEAN            SleepButtonPresent;
    BOOLEAN            LidPresent;
    BOOLEAN            SystemS1;
    BOOLEAN            SystemS2;
    BOOLEAN            SystemS3;
    BOOLEAN            SystemS4;
    BOOLEAN            SystemS5;
    BOOLEAN            HiberFilePresent;
    BOOLEAN            FullWake;
    BOOLEAN            VideoDimPresent;
    BOOLEAN            ApmPresent;
    BOOLEAN            UpsPresent;
    BOOLEAN            ThermalControl;
    BOOLEAN            ProcessorThrottle;
    ubyte              ProcessorMinThrottle;
    ubyte              ProcessorMaxThrottle;
    BOOLEAN            FastSystemS4;
    BOOLEAN            Hiberboot;
    BOOLEAN            WakeAlarmPresent;
    BOOLEAN            AoAc;
    BOOLEAN            DiskSpinDown;
    ubyte              HiberFileType;
    BOOLEAN            AoAcConnectivitySupported;
    ubyte[6]           spare3;
    BOOLEAN            SystemBatteriesPresent;
    BOOLEAN            BatteriesAreShortTerm;
    BATTERY_REPORTING_SCALE[3] BatteryScale;
    SYSTEM_POWER_STATE AcOnLineWake;
    SYSTEM_POWER_STATE SoftLidWake;
    SYSTEM_POWER_STATE RtcWake;
    SYSTEM_POWER_STATE MinDeviceWakeState;
    SYSTEM_POWER_STATE DefaultLowLatencyWake;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_battery_state))], [])
struct SYSTEM_BATTERY_STATE
{
    BOOLEAN    AcOnLine;
    BOOLEAN    BatteryPresent;
    BOOLEAN    Charging;
    BOOLEAN    Discharging;
    BOOLEAN[3] Spare1;
    ubyte      Tag;
    uint       MaxCapacity;
    uint       RemainingCapacity;
    uint       Rate;
    uint       EstimatedTime;
    uint       DefaultAlert1;
    uint       DefaultAlert2;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-powerbroadcast_setting))], [])
struct POWERBROADCAST_SETTING
{
    GUID PowerSetting;
    uint DataLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-system_power_status))], [])
struct SYSTEM_POWER_STATUS
{
    ubyte ACLineStatus;
    ubyte BatteryFlag;
    ubyte BatteryLifePercent;
    ubyte SystemStatusFlag;
    uint  BatteryLifeTime;
    uint  BatteryFullLifeTime;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powerbase/nf-powerbase-callntpowerinformation))], [])
@DllImport("POWRPROF.dll")
NTSTATUS CallNtPowerInformation(POWER_INFORMATION_LEVEL InformationLevel, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* InputBuffer, 
                                uint InputBufferLength, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* OutputBuffer, 
                                uint OutputBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powerbase/nf-powerbase-getpwrcapabilities))], [])
@DllImport("POWRPROF.dll")
BOOLEAN GetPwrCapabilities(SYSTEM_POWER_CAPABILITIES* lpspc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powerbase/nf-powerbase-powerdetermineplatformroleex))], [])
@DllImport("POWRPROF.dll")
POWER_PLATFORM_ROLE PowerDeterminePlatformRoleEx(POWER_PLATFORM_ROLE_VERSION Version);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powerbase/nf-powerbase-powerregistersuspendresumenotification))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerRegisterSuspendResumeNotification(REGISTER_NOTIFICATION_FLAGS Flags, HANDLE Recipient, 
                                                   void** RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powerbase/nf-powerbase-powerunregistersuspendresumenotification))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerUnregisterSuspendResumeNotification(HPOWERNOTIFY RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powerreadacvalue))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadACValue(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                             const(GUID)* PowerSettingGuid, uint* Type, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                             uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powerreaddcvalue))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadDCValue(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                             const(GUID)* PowerSettingGuid, uint* Type, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                             uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powerwriteacvalueindex))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteACValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                   const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                   uint AcValueIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powerwritedcvalueindex))], [])
@DllImport("POWRPROF.dll")
uint PowerWriteDCValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                            const(GUID)* PowerSettingGuid, uint DcValueIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powergetactivescheme))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerGetActiveScheme(HKEY UserRootPowerKey, GUID** ActivePolicyGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powersetactivescheme))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSetActiveScheme(HKEY UserRootPowerKey, const(GUID)* SchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powersettingregisternotification))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSettingRegisterNotification(const(GUID)* SettingGuid, REGISTER_NOTIFICATION_FLAGS Flags, 
                                             HANDLE Recipient, void** RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powersettingunregisternotification))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSettingUnregisterNotification(HPOWERNOTIFY RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powerregisterforeffectivepowermodenotifications))], [])
@DllImport("POWRPROF.dll")
HRESULT PowerRegisterForEffectivePowerModeNotifications(uint Version, EFFECTIVE_POWER_MODE_CALLBACK Callback, 
                                                        void* Context, void** RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powersetting/nf-powersetting-powerunregisterfromeffectivepowermodenotifications))], [])
@DllImport("POWRPROF.dll")
HRESULT PowerUnregisterFromEffectivePowerModeNotifications(void* RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-getpwrdiskspindownrange))], [])
@DllImport("POWRPROF.dll")
BOOLEAN GetPwrDiskSpindownRange(uint* puiMax, uint* puiMin);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-enumpwrschemes))], [])
@DllImport("POWRPROF.dll")
BOOLEAN EnumPwrSchemes(PWRSCHEMESENUMPROC lpfn, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-readglobalpwrpolicy))], [])
@DllImport("POWRPROF.dll")
BOOLEAN ReadGlobalPwrPolicy(GLOBAL_POWER_POLICY* pGlobalPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-readpwrscheme))], [])
@DllImport("POWRPROF.dll")
BOOLEAN ReadPwrScheme(uint uiID, POWER_POLICY* pPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-writepwrscheme))], [])
@DllImport("POWRPROF.dll")
BOOLEAN WritePwrScheme(uint* puiID, const(PWSTR) lpszSchemeName, const(PWSTR) lpszDescription, 
                       POWER_POLICY* lpScheme);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-writeglobalpwrpolicy))], [])
@DllImport("POWRPROF.dll")
BOOLEAN WriteGlobalPwrPolicy(GLOBAL_POWER_POLICY* pGlobalPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-deletepwrscheme))], [])
@DllImport("POWRPROF.dll")
BOOLEAN DeletePwrScheme(uint uiID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-getactivepwrscheme))], [])
@DllImport("POWRPROF.dll")
BOOLEAN GetActivePwrScheme(uint* puiID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-setactivepwrscheme))], [])
@DllImport("POWRPROF.dll")
BOOLEAN SetActivePwrScheme(uint uiID, GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-ispwrsuspendallowed))], [])
@DllImport("POWRPROF.dll")
BOOLEAN IsPwrSuspendAllowed();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-ispwrhibernateallowed))], [])
@DllImport("POWRPROF.dll")
BOOLEAN IsPwrHibernateAllowed();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-ispwrshutdownallowed))], [])
@DllImport("POWRPROF.dll")
BOOLEAN IsPwrShutdownAllowed();

@DllImport("POWRPROF.dll")
BOOLEAN IsAdminOverrideActive(ADMINISTRATOR_POWER_POLICY* papp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-setsuspendstate))], [])
@DllImport("POWRPROF.dll")
BOOLEAN SetSuspendState(BOOLEAN bHibernate, BOOLEAN bForce, BOOLEAN bWakeupEventsDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-getcurrentpowerpolicies))], [])
@DllImport("POWRPROF.dll")
BOOLEAN GetCurrentPowerPolicies(GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-canuserwritepwrscheme))], [])
@DllImport("POWRPROF.dll")
BOOLEAN CanUserWritePwrScheme();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-readprocessorpwrscheme))], [])
@DllImport("POWRPROF.dll")
BOOLEAN ReadProcessorPwrScheme(uint uiID, MACHINE_PROCESSOR_POWER_POLICY* pMachineProcessorPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-writeprocessorpwrscheme))], [])
@DllImport("POWRPROF.dll")
BOOLEAN WriteProcessorPwrScheme(uint uiID, MACHINE_PROCESSOR_POWER_POLICY* pMachineProcessorPowerPolicy);

@DllImport("POWRPROF.dll")
BOOLEAN ValidatePowerPolicies(GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerissettingrangedefined))], [])
@DllImport("POWRPROF.dll")
BOOLEAN PowerIsSettingRangeDefined(const(GUID)* SubKeyGuid, const(GUID)* SettingGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powersettingaccesscheckex))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSettingAccessCheckEx(POWER_DATA_ACCESSOR AccessFlags, const(GUID)* PowerGuid, 
                                      REG_SAM_FLAGS AccessType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powersettingaccesscheck))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSettingAccessCheck(POWER_DATA_ACCESSOR AccessFlags, const(GUID)* PowerGuid);

@DllImport("POWRPROF.dll")
uint PowerGetUserConfiguredACPowerMode(GUID* PowerModeGuid);

@DllImport("POWRPROF.dll")
uint PowerGetUserConfiguredDCPowerMode(GUID* PowerModeGuid);

@DllImport("POWRPROF.dll")
uint PowerSetUserConfiguredACPowerMode(const(GUID)* PowerModeGuid);

@DllImport("POWRPROF.dll")
uint PowerSetUserConfiguredDCPowerMode(const(GUID)* PowerModeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadacvalueindex))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadACValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                  const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                  uint* AcValueIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreaddcvalueindex))], [])
@DllImport("POWRPROF.dll")
uint PowerReadDCValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                           const(GUID)* PowerSettingGuid, uint* DcValueIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadfriendlyname))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadFriendlyName(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                  const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                  uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreaddescription))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadDescription(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                 const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                 uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadpossiblevalue))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadPossibleValue(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                   const(GUID)* PowerSettingGuid, uint* Type, uint PossibleSettingIndex, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                                   uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadpossiblefriendlyname))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadPossibleFriendlyName(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                          const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                          uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadpossibledescription))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadPossibleDescription(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                         const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                         uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadvaluemin))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadValueMin(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                              const(GUID)* PowerSettingGuid, uint* ValueMinimum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadvaluemax))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadValueMax(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                              const(GUID)* PowerSettingGuid, uint* ValueMaximum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadvalueincrement))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadValueIncrement(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                    const(GUID)* PowerSettingGuid, uint* ValueIncrement);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadvalueunitsspecifier))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadValueUnitsSpecifier(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                         const(GUID)* PowerSettingGuid, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Buffer, 
                                         uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadacdefaultindex))], [])
@DllImport("POWRPROF.dll")
uint PowerReadACDefaultIndex(HKEY RootPowerKey, const(GUID)* SchemePersonalityGuid, 
                             const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                             uint* AcDefaultIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreaddcdefaultindex))], [])
@DllImport("POWRPROF.dll")
uint PowerReadDCDefaultIndex(HKEY RootPowerKey, const(GUID)* SchemePersonalityGuid, 
                             const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                             uint* DcDefaultIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadiconresourcespecifier))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadIconResourceSpecifier(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                           const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                           uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreadsettingattributes))], [])
@DllImport("POWRPROF.dll")
uint PowerReadSettingAttributes(const(GUID)* SubGroupGuid, const(GUID)* PowerSettingGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritefriendlyname))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteFriendlyName(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                   const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                   uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritedescription))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteDescription(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                  const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                  uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritepossiblevalue))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWritePossibleValue(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                    const(GUID)* PowerSettingGuid, uint Type, uint PossibleSettingIndex, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                                    uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritepossiblefriendlyname))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWritePossibleFriendlyName(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                           const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, 
                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                           uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritepossibledescription))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWritePossibleDescription(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                          const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                          uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritevaluemin))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteValueMin(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                               const(GUID)* PowerSettingGuid, uint ValueMinimum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritevaluemax))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteValueMax(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                               const(GUID)* PowerSettingGuid, uint ValueMaximum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritevalueincrement))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteValueIncrement(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                     const(GUID)* PowerSettingGuid, uint ValueIncrement);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritevalueunitsspecifier))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteValueUnitsSpecifier(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                          const(GUID)* PowerSettingGuid, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Buffer, 
                                          uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwriteacdefaultindex))], [])
@DllImport("POWRPROF.dll")
uint PowerWriteACDefaultIndex(HKEY RootSystemPowerKey, const(GUID)* SchemePersonalityGuid, 
                              const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                              uint DefaultAcIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritedcdefaultindex))], [])
@DllImport("POWRPROF.dll")
uint PowerWriteDCDefaultIndex(HKEY RootSystemPowerKey, const(GUID)* SchemePersonalityGuid, 
                              const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                              uint DefaultDcIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwriteiconresourcespecifier))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteIconResourceSpecifier(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                            const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                            uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerwritesettingattributes))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteSettingAttributes(const(GUID)* SubGroupGuid, const(GUID)* PowerSettingGuid, uint Attributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerduplicatescheme))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerDuplicateScheme(HKEY RootPowerKey, const(GUID)* SourceSchemeGuid, GUID** DestinationSchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerimportpowerscheme))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerImportPowerScheme(HKEY RootPowerKey, const(PWSTR) ImportFileNamePath, 
                                   GUID** DestinationSchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerdeletescheme))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerDeleteScheme(HKEY RootPowerKey, const(GUID)* SchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerremovepowersetting))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerRemovePowerSetting(const(GUID)* PowerSettingSubKeyGuid, const(GUID)* PowerSettingGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powercreatesetting))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerCreateSetting(HKEY RootSystemPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                               const(GUID)* PowerSettingGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powercreatepossiblesetting))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerCreatePossibleSetting(HKEY RootSystemPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                       const(GUID)* PowerSettingGuid, uint PossibleSettingIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerenumerate))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerEnumerate(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                           POWER_DATA_ACCESSOR AccessFlags, uint Index, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                           uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerOpenUserPowerKey(HKEY* phUserPowerKey, uint Access, BOOL OpenExisting);

@DllImport("POWRPROF.dll")
uint PowerOpenSystemPowerKey(HKEY* phSystemPowerKey, uint Access, BOOL OpenExisting);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powercanrestoreindividualdefaultpowerscheme))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerCanRestoreIndividualDefaultPowerScheme(const(GUID)* SchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerrestoreindividualdefaultpowerscheme))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerRestoreIndividualDefaultPowerScheme(const(GUID)* SchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerrestoredefaultpowerschemes))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerRestoreDefaultPowerSchemes();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreplacedefaultpowerschemes))], [])
@DllImport("POWRPROF.dll")
uint PowerReplaceDefaultPowerSchemes();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerdetermineplatformrole))], [])
@DllImport("POWRPROF.dll")
POWER_PLATFORM_ROLE PowerDeterminePlatformRole();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-devicepowerenumdevices))], [])
@DllImport("POWRPROF.dll")
BOOLEAN DevicePowerEnumDevices(uint QueryIndex, uint QueryInterpretationFlags, uint QueryFlags, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pReturnBuffer, 
                               uint* pBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-devicepowersetdevicestate))], [])
@DllImport("POWRPROF.dll")
uint DevicePowerSetDeviceState(const(PWSTR) DeviceDescription, uint SetFlags, void* SetData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-devicepoweropen))], [])
@DllImport("POWRPROF.dll")
BOOLEAN DevicePowerOpen(uint DebugMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-devicepowerclose))], [])
@DllImport("POWRPROF.dll")
BOOLEAN DevicePowerClose();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/powrprof/nf-powrprof-powerreportthermalevent))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReportThermalEvent(THERMAL_EVENT* Event);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-registerpowersettingnotification))], [])
@DllImport("USER32.dll")
HPOWERNOTIFY RegisterPowerSettingNotification(HANDLE hRecipient, const(GUID)* PowerSettingGuid, 
                                              REGISTER_NOTIFICATION_FLAGS Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-unregisterpowersettingnotification))], [])
@DllImport("USER32.dll")
BOOL UnregisterPowerSettingNotification(HPOWERNOTIFY Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-registersuspendresumenotification))], [])
@DllImport("USER32.dll")
HPOWERNOTIFY RegisterSuspendResumeNotification(HANDLE hRecipient, REGISTER_NOTIFICATION_FLAGS Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-unregistersuspendresumenotification))], [])
@DllImport("USER32.dll")
BOOL UnregisterSuspendResumeNotification(HPOWERNOTIFY Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-requestwakeuplatency))], [])
@DllImport("KERNEL32.dll")
BOOL RequestWakeupLatency(LATENCY_TIME latency);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-issystemresumeautomatic))], [])
@DllImport("KERNEL32.dll")
BOOL IsSystemResumeAutomatic();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-setthreadexecutionstate))], [])
@DllImport("KERNEL32.dll")
EXECUTION_STATE SetThreadExecutionState(EXECUTION_STATE esFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-powercreaterequest))], [])
@DllImport("KERNEL32.dll")
HANDLE PowerCreateRequest(REASON_CONTEXT* Context);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-powersetrequest))], [])
@DllImport("KERNEL32.dll")
BOOL PowerSetRequest(HANDLE PowerRequest, POWER_REQUEST_TYPE RequestType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-powerclearrequest))], [])
@DllImport("KERNEL32.dll")
BOOL PowerClearRequest(HANDLE PowerRequest, POWER_REQUEST_TYPE RequestType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-getdevicepowerstate))], [])
@DllImport("KERNEL32.dll")
BOOL GetDevicePowerState(HANDLE hDevice, BOOL* pfOn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-setsystempowerstate))], [])
@DllImport("KERNEL32.dll")
BOOL SetSystemPowerState(BOOL fSuspend, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-getsystempowerstatus))], [])
@DllImport("KERNEL32.dll")
BOOL GetSystemPowerStatus(SYSTEM_POWER_STATUS* lpSystemPowerStatus);


