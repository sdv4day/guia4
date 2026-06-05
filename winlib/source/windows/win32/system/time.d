// Written in the D programming language.

module windows.win32.system.time;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, FILETIME, SYSTEMTIME;

extern(Windows) @nogc nothrow:


// Constants


enum : const(wchar)*
{
    wszW32TimeRegKeyTimeProviders       = "System\\CurrentControlSet\\Services\\W32Time\\TimeProviders",
    wszW32TimeRegKeyPolicyTimeProviders = "Software\\Policies\\Microsoft\\W32Time\\TimeProviders",
}

enum : const(wchar)*
{
    wszW32TimeRegValueDllName          = "DllName",
    wszW32TimeRegValueInputProvider    = "InputProvider",
    wszW32TimeRegValueMetaDataProvider = "MetaDataProvider",
}

enum uint TSF_Authenticated = 0x00000002;
enum uint TSF_SignatureAuthenticated = 0x00000008;

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/ns-timezoneapi-time_zone_information))], [])
struct TIME_ZONE_INFORMATION
{
    int        Bias;
    wchar[32]  StandardName;
    SYSTEMTIME StandardDate;
    int        StandardBias;
    wchar[32]  DaylightName;
    SYSTEMTIME DaylightDate;
    int        DaylightBias;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/ns-timezoneapi-dynamic_time_zone_information))], [])
struct DYNAMIC_TIME_ZONE_INFORMATION
{
    int        Bias;
    wchar[32]  StandardName;
    SYSTEMTIME StandardDate;
    int        StandardBias;
    wchar[32]  DaylightName;
    SYSTEMTIME DaylightDate;
    int        DaylightBias;
    wchar[128] TimeZoneKeyName;
    BOOLEAN    DynamicDaylightTimeDisabled;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-systemtimetotzspecificlocaltime))], [])
@DllImport("KERNEL32.dll")
BOOL SystemTimeToTzSpecificLocalTime(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                     const(SYSTEMTIME)* lpUniversalTime, SYSTEMTIME* lpLocalTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-tzspecificlocaltimetosystemtime))], [])
@DllImport("KERNEL32.dll")
BOOL TzSpecificLocalTimeToSystemTime(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                     const(SYSTEMTIME)* lpLocalTime, SYSTEMTIME* lpUniversalTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-filetimetosystemtime))], [])
@DllImport("KERNEL32.dll")
BOOL FileTimeToSystemTime(const(FILETIME)* lpFileTime, SYSTEMTIME* lpSystemTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-systemtimetofiletime))], [])
@DllImport("KERNEL32.dll")
BOOL SystemTimeToFileTime(const(SYSTEMTIME)* lpSystemTime, FILETIME* lpFileTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-gettimezoneinformation))], [])
@DllImport("KERNEL32.dll")
uint GetTimeZoneInformation(TIME_ZONE_INFORMATION* lpTimeZoneInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-settimezoneinformation))], [])
@DllImport("KERNEL32.dll")
BOOL SetTimeZoneInformation(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-setdynamictimezoneinformation))], [])
@DllImport("KERNEL32.dll")
BOOL SetDynamicTimeZoneInformation(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-getdynamictimezoneinformation))], [])
@DllImport("KERNEL32.dll")
uint GetDynamicTimeZoneInformation(DYNAMIC_TIME_ZONE_INFORMATION* pTimeZoneInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-gettimezoneinformationforyear))], [])
@DllImport("KERNEL32.dll")
BOOL GetTimeZoneInformationForYear(ushort wYear, DYNAMIC_TIME_ZONE_INFORMATION* pdtzi, TIME_ZONE_INFORMATION* ptzi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-enumdynamictimezoneinformation))], [])
@DllImport("ADVAPI32.dll")
uint EnumDynamicTimeZoneInformation(const(uint) dwIndex, DYNAMIC_TIME_ZONE_INFORMATION* lpTimeZoneInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-getdynamictimezoneinformationeffectiveyears))], [])
@DllImport("ADVAPI32.dll")
uint GetDynamicTimeZoneInformationEffectiveYears(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                                 uint* FirstYear, uint* LastYear);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-systemtimetotzspecificlocaltimeex))], [])
@DllImport("KERNEL32.dll")
BOOL SystemTimeToTzSpecificLocalTimeEx(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                       const(SYSTEMTIME)* lpUniversalTime, SYSTEMTIME* lpLocalTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/timezoneapi/nf-timezoneapi-tzspecificlocaltimetosystemtimeex))], [])
@DllImport("KERNEL32.dll")
BOOL TzSpecificLocalTimeToSystemTimeEx(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                       const(SYSTEMTIME)* lpLocalTime, SYSTEMTIME* lpUniversalTime);

@DllImport("KERNEL32.dll")
BOOL LocalFileTimeToLocalSystemTime(const(TIME_ZONE_INFORMATION)* timeZoneInformation, 
                                    const(FILETIME)* localFileTime, SYSTEMTIME* localSystemTime);

@DllImport("KERNEL32.dll")
BOOL LocalSystemTimeToLocalFileTime(const(TIME_ZONE_INFORMATION)* timeZoneInformation, 
                                    const(SYSTEMTIME)* localSystemTime, FILETIME* localFileTime);


