// Written in the D programming language.

module windows.win32.ui.shell.propertiessystem;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, CHAR, HANDLE, HRESULT, HWND, POINTL, POINTS, PROPERTYKEY, PSTR,
                                         PWSTR, RECTL;
public import windows.win32.system.com : IBindCtx, IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : IPropertyBag, IPropertySetStorage, IPropertyStorage,
                                                           PROPSPEC, PROPVARIANT;
public import windows.win32.system.search.common : CONDITION_OPERATION;
public import windows.win32.system.variant : VARENUM, VARIANT;
public import windows.win32.ui.shell.common : ITEMIDLIST;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-getpropertystoreflags))], [])

alias GETPROPERTYSTOREFLAGS = int;
enum : int
{
    GPS_DEFAULT                 = 0x00000000,
    GPS_HANDLERPROPERTIESONLY   = 0x00000001,
    GPS_READWRITE               = 0x00000002,
    GPS_TEMPORARY               = 0x00000004,
    GPS_FASTPROPERTIESONLY      = 0x00000008,
    GPS_OPENSLOWITEM            = 0x00000010,
    GPS_DELAYCREATION           = 0x00000020,
    GPS_BESTEFFORT              = 0x00000040,
    GPS_NO_OPLOCK               = 0x00000080,
    GPS_PREFERQUERYPROPERTIES   = 0x00000100,
    GPS_EXTRINSICPROPERTIES     = 0x00000200,
    GPS_EXTRINSICPROPERTIESONLY = 0x00000400,
    GPS_VOLATILEPROPERTIES      = 0x00000800,
    GPS_VOLATILEPROPERTIESONLY  = 0x00001000,
    GPS_MASK_VALID              = 0x00001fff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-pka_flags))], [])

alias PKA_FLAGS = int;
enum : int
{
    PKA_SET    = 0x00000000,
    PKA_APPEND = 0x00000001,
    PKA_DELETE = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-psc_state))], [])

alias PSC_STATE = int;
enum : int
{
    PSC_NORMAL      = 0x00000000,
    PSC_NOTINSOURCE = 0x00000001,
    PSC_DIRTY       = 0x00000002,
    PSC_READONLY    = 0x00000003,
}

alias PROPENUMTYPE = int;
enum : int
{
    PET_DISCRETEVALUE = 0x00000000,
    PET_RANGEDVALUE   = 0x00000001,
    PET_DEFAULTVALUE  = 0x00000002,
    PET_ENDRANGE      = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-propdesc_type_flags))], [])

alias PROPDESC_TYPE_FLAGS = uint;
enum : uint
{
    PDTF_DEFAULT                   = 0x00000000,
    PDTF_MULTIPLEVALUES            = 0x00000001,
    PDTF_ISINNATE                  = 0x00000002,
    PDTF_ISGROUP                   = 0x00000004,
    PDTF_CANGROUPBY                = 0x00000008,
    PDTF_CANSTACKBY                = 0x00000010,
    PDTF_ISTREEPROPERTY            = 0x00000020,
    PDTF_INCLUDEINFULLTEXTQUERY    = 0x00000040,
    PDTF_ISVIEWABLE                = 0x00000080,
    PDTF_ISQUERYABLE               = 0x00000100,
    PDTF_CANBEPURGED               = 0x00000200,
    PDTF_SEARCHRAWVALUE            = 0x00000400,
    PDTF_DONTCOERCEEMPTYSTRINGS    = 0x00000800,
    PDTF_ALWAYSINSUPPLEMENTALSTORE = 0x00001000,
    PDTF_ISSYSTEMPROPERTY          = 0x80000000,
    PDTF_MASK_ALL                  = 0x80001fff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-propdesc_view_flags))], [])

alias PROPDESC_VIEW_FLAGS = int;
enum : int
{
    PDVF_DEFAULT             = 0x00000000,
    PDVF_CENTERALIGN         = 0x00000001,
    PDVF_RIGHTALIGN          = 0x00000002,
    PDVF_BEGINNEWGROUP       = 0x00000004,
    PDVF_FILLAREA            = 0x00000008,
    PDVF_SORTDESCENDING      = 0x00000010,
    PDVF_SHOWONLYIFPRESENT   = 0x00000020,
    PDVF_SHOWBYDEFAULT       = 0x00000040,
    PDVF_SHOWINPRIMARYLIST   = 0x00000080,
    PDVF_SHOWINSECONDARYLIST = 0x00000100,
    PDVF_HIDELABEL           = 0x00000200,
    PDVF_HIDDEN              = 0x00000800,
    PDVF_CANWRAP             = 0x00001000,
    PDVF_MASK_ALL            = 0x00001bff,
}

alias PROPDESC_DISPLAYTYPE = int;
enum : int
{
    PDDT_STRING     = 0x00000000,
    PDDT_NUMBER     = 0x00000001,
    PDDT_BOOLEAN    = 0x00000002,
    PDDT_DATETIME   = 0x00000003,
    PDDT_ENUMERATED = 0x00000004,
}

alias PROPDESC_GROUPING_RANGE = int;
enum : int
{
    PDGR_DISCRETE     = 0x00000000,
    PDGR_ALPHANUMERIC = 0x00000001,
    PDGR_SIZE         = 0x00000002,
    PDGR_DYNAMIC      = 0x00000003,
    PDGR_DATE         = 0x00000004,
    PDGR_PERCENT      = 0x00000005,
    PDGR_ENUMERATED   = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-propdesc_format_flags))], [])

alias PROPDESC_FORMAT_FLAGS = int;
enum : int
{
    PDFF_DEFAULT              = 0x00000000,
    PDFF_PREFIXNAME           = 0x00000001,
    PDFF_FILENAME             = 0x00000002,
    PDFF_ALWAYSKB             = 0x00000004,
    PDFF_RESERVED_RIGHTTOLEFT = 0x00000008,
    PDFF_SHORTTIME            = 0x00000010,
    PDFF_LONGTIME             = 0x00000020,
    PDFF_HIDETIME             = 0x00000040,
    PDFF_SHORTDATE            = 0x00000080,
    PDFF_LONGDATE             = 0x00000100,
    PDFF_HIDEDATE             = 0x00000200,
    PDFF_RELATIVEDATE         = 0x00000400,
    PDFF_USEEDITINVITATION    = 0x00000800,
    PDFF_READONLY             = 0x00001000,
    PDFF_NOAUTOREADINGORDER   = 0x00002000,
}

alias PROPDESC_SORTDESCRIPTION = int;
enum : int
{
    PDSD_GENERAL          = 0x00000000,
    PDSD_A_Z              = 0x00000001,
    PDSD_LOWEST_HIGHEST   = 0x00000002,
    PDSD_SMALLEST_BIGGEST = 0x00000003,
    PDSD_OLDEST_NEWEST    = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-propdesc_relativedescription_type))], [])

alias PROPDESC_RELATIVEDESCRIPTION_TYPE = int;
enum : int
{
    PDRDT_GENERAL  = 0x00000000,
    PDRDT_DATE     = 0x00000001,
    PDRDT_SIZE     = 0x00000002,
    PDRDT_COUNT    = 0x00000003,
    PDRDT_REVISION = 0x00000004,
    PDRDT_LENGTH   = 0x00000005,
    PDRDT_DURATION = 0x00000006,
    PDRDT_SPEED    = 0x00000007,
    PDRDT_RATE     = 0x00000008,
    PDRDT_RATING   = 0x00000009,
    PDRDT_PRIORITY = 0x0000000a,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-propdesc_aggregation_type))], [])

alias PROPDESC_AGGREGATION_TYPE = int;
enum : int
{
    PDAT_DEFAULT   = 0x00000000,
    PDAT_FIRST     = 0x00000001,
    PDAT_SUM       = 0x00000002,
    PDAT_AVERAGE   = 0x00000003,
    PDAT_DATERANGE = 0x00000004,
    PDAT_UNION     = 0x00000005,
    PDAT_MAX       = 0x00000006,
    PDAT_MIN       = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-propdesc_condition_type))], [])

alias PROPDESC_CONDITION_TYPE = int;
enum : int
{
    PDCOT_NONE     = 0x00000000,
    PDCOT_STRING   = 0x00000001,
    PDCOT_SIZE     = 0x00000002,
    PDCOT_DATETIME = 0x00000003,
    PDCOT_BOOLEAN  = 0x00000004,
    PDCOT_NUMBER   = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-propdesc_searchinfo_flags))], [])

alias PROPDESC_SEARCHINFO_FLAGS = int;
enum : int
{
    PDSIF_DEFAULT         = 0x00000000,
    PDSIF_ININVERTEDINDEX = 0x00000001,
    PDSIF_ISCOLUMN        = 0x00000002,
    PDSIF_ISCOLUMNSPARSE  = 0x00000004,
    PDSIF_ALWAYSINCLUDE   = 0x00000008,
    PDSIF_USEFORTYPEAHEAD = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-propdesc_columnindex_type))], [])

alias PROPDESC_COLUMNINDEX_TYPE = int;
enum : int
{
    PDCIT_NONE         = 0x00000000,
    PDCIT_ONDISK       = 0x00000001,
    PDCIT_INMEMORY     = 0x00000002,
    PDCIT_ONDEMAND     = 0x00000003,
    PDCIT_ONDISKALL    = 0x00000004,
    PDCIT_ONDISKVECTOR = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/ne-propsys-propdesc_enumfilter))], [])

alias PROPDESC_ENUMFILTER = int;
enum : int
{
    PDEF_ALL             = 0x00000000,
    PDEF_SYSTEM          = 0x00000001,
    PDEF_NONSYSTEM       = 0x00000002,
    PDEF_VIEWABLE        = 0x00000003,
    PDEF_QUERYABLE       = 0x00000004,
    PDEF_INFULLTEXTQUERY = 0x00000005,
    PDEF_COLUMN          = 0x00000006,
}

alias _PERSIST_SPROPSTORE_FLAGS = int;
enum : int
{
    FPSPS_DEFAULT                   = 0x00000000,
    FPSPS_READONLY                  = 0x00000001,
    FPSPS_TREAT_NEW_VALUES_AS_DIRTY = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-sync_transfer_status))], [])

alias SYNC_TRANSFER_STATUS = int;
enum : int
{
    STS_NONE                   = 0x00000000,
    STS_NEEDSUPLOAD            = 0x00000001,
    STS_NEEDSDOWNLOAD          = 0x00000002,
    STS_TRANSFERRING           = 0x00000004,
    STS_PAUSED                 = 0x00000008,
    STS_HASERROR               = 0x00000010,
    STS_FETCHING_METADATA      = 0x00000020,
    STS_USER_REQUESTED_REFRESH = 0x00000040,
    STS_HASWARNING             = 0x00000080,
    STS_EXCLUDED               = 0x00000100,
    STS_INCOMPLETE             = 0x00000200,
    STS_PLACEHOLDER_IFEMPTY    = 0x00000400,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-placeholder_states))], [])

alias PLACEHOLDER_STATES = int;
enum : int
{
    PS_NONE                            = 0x00000000,
    PS_MARKED_FOR_OFFLINE_AVAILABILITY = 0x00000001,
    PS_FULL_PRIMARY_STREAM_AVAILABLE   = 0x00000002,
    PS_CREATE_FILE_ACCESSIBLE          = 0x00000004,
    PS_CLOUDFILE_PLACEHOLDER           = 0x00000008,
    PS_DEFAULT                         = 0x00000007,
    PS_ALL                             = 0x0000000f,
}

alias PROPERTYUI_NAME_FLAGS = int;
enum : int
{
    PUIFNF_DEFAULT  = 0x00000000,
    PUIFNF_MNEMONIC = 0x00000001,
}

alias PROPERTYUI_FLAGS = int;
enum : int
{
    PUIF_DEFAULT          = 0x00000000,
    PUIF_RIGHTALIGN       = 0x00000001,
    PUIF_NOLABELININFOTIP = 0x00000002,
}

alias PROPERTYUI_FORMAT_FLAGS = int;
enum : int
{
    PUIFFDF_DEFAULT      = 0x00000000,
    PUIFFDF_RIGHTTOLEFT  = 0x00000001,
    PUIFFDF_SHORTFORMAT  = 0x00000002,
    PUIFFDF_NOTIME       = 0x00000004,
    PUIFFDF_FRIENDLYDATE = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/ne-shobjidl_core-pdopstatus))], [])

alias PDOPSTATUS = int;
enum : int
{
    PDOPS_RUNNING   = 0x00000001,
    PDOPS_PAUSED    = 0x00000002,
    PDOPS_CANCELLED = 0x00000003,
    PDOPS_STOPPED   = 0x00000004,
    PDOPS_ERRORS    = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl/ne-shobjidl-sync_engine_state_flags))], [])

alias SYNC_ENGINE_STATE_FLAGS = int;
enum : int
{
    SESF_NONE                          = 0x00000000,
    SESF_SERVICE_QUOTA_NEARING_LIMIT   = 0x00000001,
    SESF_SERVICE_QUOTA_EXCEEDED_LIMIT  = 0x00000002,
    SESF_AUTHENTICATION_ERROR          = 0x00000004,
    SESF_PAUSED_DUE_TO_METERED_NETWORK = 0x00000008,
    SESF_PAUSED_DUE_TO_DISK_SPACE_FULL = 0x00000010,
    SESF_PAUSED_DUE_TO_CLIENT_POLICY   = 0x00000020,
    SESF_PAUSED_DUE_TO_SERVICE_POLICY  = 0x00000040,
    SESF_SERVICE_UNAVAILABLE           = 0x00000080,
    SESF_PAUSED_DUE_TO_USER_REQUEST    = 0x00000100,
    SESF_ALL_FLAGS                     = 0x000001ff,
}

// Constants


enum uint PKEY_PIDSTR_MAX = 0x0000000a;

// Structs


struct SERIALIZEDPROPSTORAGE
{
    ptrdiff_t Value;
}

struct PCUSERIALIZEDPROPSTORAGE
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj_core/ns-shlobj_core-propprg))], [])
struct PROPPRG
{
align (1):
    ushort    flPrg;
    ushort    flPrgInit;
    CHAR[30]  achTitle;
    CHAR[128] achCmdLine;
    CHAR[64]  achWorkDir;
    ushort    wHotKey;
    CHAR[80]  achIconFile;
    ushort    wIconIndex;
    uint      dwEnhModeFlags;
    uint      dwRealModeFlags;
    CHAR[80]  achOtherFile;
    CHAR[260] achPIFFile;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psformatfordisplay))], [])
@DllImport("PROPSYS.dll")
HRESULT PSFormatForDisplay(const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar, 
                           PROPDESC_FORMAT_FLAGS pdfFlags, PWSTR pwszText, uint cchText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psformatfordisplayalloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PSFormatForDisplayAlloc(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, 
                                PWSTR* ppszDisplay);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psformatpropertyvalue))], [])
@DllImport("PROPSYS.dll")
HRESULT PSFormatPropertyValue(IPropertyStore pps, IPropertyDescription ppd, PROPDESC_FORMAT_FLAGS pdff, 
                              PWSTR* ppszDisplay);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetimagereferenceforvalue))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetImageReferenceForValue(const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar, PWSTR* ppszImageRes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psstringfrompropertykey))], [])
@DllImport("PROPSYS.dll")
HRESULT PSStringFromPropertyKey(const(PROPERTYKEY)* pkey, PWSTR psz, uint cch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertykeyfromstring))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyKeyFromString(const(PWSTR) pszString, PROPERTYKEY* pkey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pscreatememorypropertystore))], [])
@DllImport("PROPSYS.dll")
HRESULT PSCreateMemoryPropertyStore(const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pscreatedelayedmultiplexpropertystore))], [])
@DllImport("PROPSYS.dll")
HRESULT PSCreateDelayedMultiplexPropertyStore(GETPROPERTYSTOREFLAGS flags, IDelayedPropertyStoreFactory pdpsf, 
                                              const(uint)* rgStoreIds, uint cStores, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pscreatemultiplexpropertystore))], [])
@DllImport("PROPSYS.dll")
HRESULT PSCreateMultiplexPropertyStore(IUnknown* prgpunkStores, uint cStores, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pscreatepropertychangearray))], [])
@DllImport("PROPSYS.dll")
HRESULT PSCreatePropertyChangeArray(const(PROPERTYKEY)* rgpropkey, const(PKA_FLAGS)* rgflags, 
                                    const(PROPVARIANT)* rgpropvar, uint cChanges, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pscreatesimplepropertychange))], [])
@DllImport("PROPSYS.dll")
HRESULT PSCreateSimplePropertyChange(PKA_FLAGS flags, const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, 
                                     const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetpropertydescription))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyDescription(const(PROPERTYKEY)* propkey, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetpropertydescriptionbyname))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyDescriptionByName(const(PWSTR) pszCanonicalName, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pslookuppropertyhandlerclsid))], [])
@DllImport("PROPSYS.dll")
HRESULT PSLookupPropertyHandlerCLSID(const(PWSTR) pszFilePath, GUID* pclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetitempropertyhandler))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetItemPropertyHandler(IUnknown punkItem, BOOL fReadWrite, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetitempropertyhandlerwithcreateobject))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetItemPropertyHandlerWithCreateObject(IUnknown punkItem, BOOL fReadWrite, IUnknown punkCreateObject, 
                                                 const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetpropertyvalue))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyValue(IPropertyStore pps, IPropertyDescription ppd, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pssetpropertyvalue))], [])
@DllImport("PROPSYS.dll")
HRESULT PSSetPropertyValue(IPropertyStore pps, IPropertyDescription ppd, const(PROPVARIANT)* propvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psregisterpropertyschema))], [])
@DllImport("PROPSYS.dll")
HRESULT PSRegisterPropertySchema(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psunregisterpropertyschema))], [])
@DllImport("PROPSYS.dll")
HRESULT PSUnregisterPropertySchema(const(PWSTR) pszPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psrefreshpropertyschema))], [])
@DllImport("PROPSYS.dll")
HRESULT PSRefreshPropertySchema();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psenumeratepropertydescriptions))], [])
@DllImport("PROPSYS.dll")
HRESULT PSEnumeratePropertyDescriptions(PROPDESC_ENUMFILTER filterOn, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetpropertykeyfromname))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyKeyFromName(const(PWSTR) pszName, PROPERTYKEY* ppropkey);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetnamefrompropertykey))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetNameFromPropertyKey(const(PROPERTYKEY)* propkey, PWSTR* ppszCanonicalName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pscoercetocanonicalvalue))], [])
@DllImport("PROPSYS.dll")
HRESULT PSCoerceToCanonicalValue(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetpropertydescriptionlistfromstring))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyDescriptionListFromString(const(PWSTR) pszPropList, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pscreatepropertystorefrompropertysetstorage))], [])
@DllImport("PROPSYS.dll")
HRESULT PSCreatePropertyStoreFromPropertySetStorage(IPropertySetStorage ppss, uint grfMode, const(GUID)* riid, 
                                                    void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pscreatepropertystorefromobject))], [])
@DllImport("PROPSYS.dll")
HRESULT PSCreatePropertyStoreFromObject(IUnknown punk, uint grfMode, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pscreateadapterfrompropertystore))], [])
@DllImport("PROPSYS.dll")
HRESULT PSCreateAdapterFromPropertyStore(IPropertyStore pps, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetpropertysystem))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetPropertySystem(const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetpropertyfrompropertystorage))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetPropertyFromPropertyStorage(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PCUSERIALIZEDPROPSTORAGE psps, 
                                         uint cb, const(PROPERTYKEY)* rpkey, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-psgetnamedpropertyfrompropertystorage))], [])
@DllImport("PROPSYS.dll")
HRESULT PSGetNamedPropertyFromPropertyStorage(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PCUSERIALIZEDPROPSTORAGE psps, 
                                              uint cb, const(PWSTR) pszName, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readtype))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadType(IPropertyBag propBag, const(PWSTR) propName, VARIANT* var, VARENUM type);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readstr))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadStr(IPropertyBag propBag, const(PWSTR) propName, PWSTR value, int characterCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readstralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadStrAlloc(IPropertyBag propBag, const(PWSTR) propName, PWSTR* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readbstr))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadBSTR(IPropertyBag propBag, const(PWSTR) propName, BSTR* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writestr))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteStr(IPropertyBag propBag, const(PWSTR) propName, const(PWSTR) value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writebstr))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteBSTR(IPropertyBag propBag, const(PWSTR) propName, BSTR value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readint))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadInt(IPropertyBag propBag, const(PWSTR) propName, int* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writeint))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteInt(IPropertyBag propBag, const(PWSTR) propName, int value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readshort))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadSHORT(IPropertyBag propBag, const(PWSTR) propName, short* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writeshort))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteSHORT(IPropertyBag propBag, const(PWSTR) propName, short value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readlong))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadLONG(IPropertyBag propBag, const(PWSTR) propName, int* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writelong))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteLONG(IPropertyBag propBag, const(PWSTR) propName, int value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readdword))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadDWORD(IPropertyBag propBag, const(PWSTR) propName, uint* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writedword))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteDWORD(IPropertyBag propBag, const(PWSTR) propName, uint value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readbool))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadBOOL(IPropertyBag propBag, const(PWSTR) propName, BOOL* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writebool))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteBOOL(IPropertyBag propBag, const(PWSTR) propName, BOOL value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readpointl))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadPOINTL(IPropertyBag propBag, const(PWSTR) propName, POINTL* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writepointl))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WritePOINTL(IPropertyBag propBag, const(PWSTR) propName, const(POINTL)* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readpoints))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadPOINTS(IPropertyBag propBag, const(PWSTR) propName, POINTS* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writepoints))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WritePOINTS(IPropertyBag propBag, const(PWSTR) propName, const(POINTS)* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readrectl))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadRECTL(IPropertyBag propBag, const(PWSTR) propName, RECTL* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writerectl))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteRECTL(IPropertyBag propBag, const(PWSTR) propName, const(RECTL)* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readstream))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadStream(IPropertyBag propBag, const(PWSTR) propName, IStream* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writestream))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteStream(IPropertyBag propBag, const(PWSTR) propName, IStream value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_delete))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_Delete(IPropertyBag propBag, const(PWSTR) propName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readulonglong))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadULONGLONG(IPropertyBag propBag, const(PWSTR) propName, ulong* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writeulonglong))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteULONGLONG(IPropertyBag propBag, const(PWSTR) propName, ulong value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readunknown))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadUnknown(IPropertyBag propBag, const(PWSTR) propName, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writeunknown))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteUnknown(IPropertyBag propBag, const(PWSTR) propName, IUnknown punk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readguid))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadGUID(IPropertyBag propBag, const(PWSTR) propName, GUID* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writeguid))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WriteGUID(IPropertyBag propBag, const(PWSTR) propName, const(GUID)* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_readpropertykey))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_ReadPropertyKey(IPropertyBag propBag, const(PWSTR) propName, PROPERTYKEY* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-pspropertybag_writepropertykey))], [])
@DllImport("PROPSYS.dll")
HRESULT PSPropertyBag_WritePropertyKey(IPropertyBag propBag, const(PWSTR) propName, const(PROPERTYKEY)* value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-shgetpropertystorefromidlist))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetPropertyStoreFromIDList(ITEMIDLIST* pidl, GETPROPERTYSTOREFLAGS flags, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-shgetpropertystorefromparsingname))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetPropertyStoreFromParsingName(const(PWSTR) pszPath, IBindCtx pbc, GETPROPERTYSTOREFLAGS flags, 
                                          const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl/nf-shobjidl-shadddefaultpropertiesbyext))], [])
@DllImport("SHELL32.dll")
HRESULT SHAddDefaultPropertiesByExt(const(PWSTR) pszExt, IPropertyStore pPropStore);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-pifmgr_openproperties))], [])
@DllImport("SHELL32.dll")
HANDLE PifMgr_OpenProperties(const(PWSTR) pszApp, const(PWSTR) pszPIF, uint hInf, uint flOpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-pifmgr_getproperties))], [])
@DllImport("SHELL32.dll")
int PifMgr_GetProperties(HANDLE hProps, const(PSTR) pszGroup, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpProps, 
                         int cbProps, uint flOpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-pifmgr_setproperties))], [])
@DllImport("SHELL32.dll")
int PifMgr_SetProperties(HANDLE hProps, const(PSTR) pszGroup, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* lpProps, 
                         int cbProps, uint flOpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-pifmgr_closeproperties))], [])
@DllImport("SHELL32.dll")
HANDLE PifMgr_CloseProperties(HANDLE hProps, uint flOpt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-shpropstgcreate))], [])
@DllImport("SHELL32.dll")
HRESULT SHPropStgCreate(IPropertySetStorage psstg, const(GUID)* fmtid, const(GUID)* pclsid, uint grfFlags, 
                        uint grfMode, uint dwDisposition, IPropertyStorage* ppstg, uint* puCodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-shpropstgreadmultiple))], [])
@DllImport("SHELL32.dll")
HRESULT SHPropStgReadMultiple(IPropertyStorage pps, uint uCodePage, uint cpspec, const(PROPSPEC)* rgpspec, 
                              PROPVARIANT* rgvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shlobj_core/nf-shlobj_core-shpropstgwritemultiple))], [])
@DllImport("SHELL32.dll")
HRESULT SHPropStgWriteMultiple(IPropertyStorage pps, uint* puCodePage, uint cpspec, const(PROPSPEC)* rgpspec, 
                               PROPVARIANT* rgvar, uint propidNameFirst);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shellapi/nf-shellapi-shgetpropertystoreforwindow))], [])
@DllImport("SHELL32.dll")
HRESULT SHGetPropertyStoreForWindow(HWND hwnd, const(GUID)* riid, void** ppv);


// Interfaces

@GUID("9a02e012-6303-4e1e-b9a1-630f802592c5")
struct InMemoryPropertyStore;

@GUID("d4ca0e2d-6da7-4b75-a97c-5f306f0eaedc")
struct InMemoryPropertyStoreMarshalByValue;

@GUID("b8967f85-58ae-4f46-9fb2-5d7904798f4b")
struct PropertySystem;

@GUID("b7d14566-0509-4cce-a71f-0a554233bd9b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-iinitializewithfile))], [])
interface IInitializeWithFile : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-iinitializewithfile-initialize))], [])
    HRESULT Initialize(const(PWSTR) pszFilePath, uint grfMode);
}

@GUID("b824b49d-22ac-4161-ac8a-9916e8fa3f7f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-iinitializewithstream))], [])
interface IInitializeWithStream : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-iinitializewithstream-initialize))], [])
    HRESULT Initialize(IStream pstream, uint grfMode);
}

@GUID("886d8eeb-8cf2-4446-8d02-cdba1dbdcf99")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertystore))], [])
interface IPropertyStore : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystore-getcount))], [])
    HRESULT GetCount(uint* cProps);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystore-getat))], [])
    HRESULT GetAt(uint iProp, PROPERTYKEY* pkey);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystore-getvalue))], [])
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* pv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystore-setvalue))], [])
    HRESULT SetValue(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystore-commit))], [])
    HRESULT Commit();
}

@GUID("71604b0f-97b0-4764-8577-2f13e98a1422")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-inamedpropertystore))], [])
interface INamedPropertyStore : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-inamedpropertystore-getnamedvalue))], [])
    HRESULT GetNamedValue(const(PWSTR) pszName, PROPVARIANT* ppropvar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-inamedpropertystore-setnamedvalue))], [])
    HRESULT SetNamedValue(const(PWSTR) pszName, const(PROPVARIANT)* propvar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-inamedpropertystore-getnamecount))], [])
    HRESULT GetNameCount(uint* pdwCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-inamedpropertystore-getnameat))], [])
    HRESULT GetNameAt(uint iProp, BSTR* pbstrName);
}

@GUID("fc0ca0a7-c316-4fd2-9031-3e628e6d4f23")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-iobjectwithpropertykey))], [])
interface IObjectWithPropertyKey : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-iobjectwithpropertykey-setpropertykey))], [])
    HRESULT SetPropertyKey(const(PROPERTYKEY)* key);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-iobjectwithpropertykey-getpropertykey))], [])
    HRESULT GetPropertyKey(PROPERTYKEY* pkey);
}

@GUID("f917bc8a-1bba-4478-a245-1bde03eb9431")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertychange))], [])
interface IPropertyChange : IObjectWithPropertyKey
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertychange-applytopropvariant))], [])
    HRESULT ApplyToPropVariant(const(PROPVARIANT)* propvarIn, PROPVARIANT* ppropvarOut);
}

@GUID("380f5cad-1b5e-42f2-805d-637fd392d31e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertychangearray))], [])
interface IPropertyChangeArray : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertychangearray-getcount))], [])
    HRESULT GetCount(uint* pcOperations);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertychangearray-getat))], [])
    HRESULT GetAt(uint iIndex, const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertychangearray-insertat))], [])
    HRESULT InsertAt(uint iIndex, IPropertyChange ppropChange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertychangearray-append))], [])
    HRESULT Append(IPropertyChange ppropChange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertychangearray-appendorreplace))], [])
    HRESULT AppendOrReplace(IPropertyChange ppropChange);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertychangearray-removeat))], [])
    HRESULT RemoveAt(uint iIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertychangearray-iskeyinarray))], [])
    HRESULT IsKeyInArray(const(PROPERTYKEY)* key);
}

@GUID("c8e2d566-186e-4d49-bf41-6909ead56acc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertystorecapabilities))], [])
interface IPropertyStoreCapabilities : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystorecapabilities-ispropertywritable))], [])
    HRESULT IsPropertyWritable(const(PROPERTYKEY)* key);
}

@GUID("3017056d-9a91-4e90-937d-746c72abbf4f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertystorecache))], [])
interface IPropertyStoreCache : IPropertyStore
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystorecache-getstate))], [])
    HRESULT GetState(const(PROPERTYKEY)* key, PSC_STATE* pstate);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystorecache-getvalueandstate))], [])
    HRESULT GetValueAndState(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar, PSC_STATE* pstate);
    HRESULT SetState(const(PROPERTYKEY)* key, PSC_STATE state);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystorecache-setvalueandstate))], [])
    HRESULT SetValueAndState(const(PROPERTYKEY)* key, const(PROPVARIANT)* ppropvar, PSC_STATE state);
}

@GUID("11e1fbf9-2d56-4a6b-8db3-7cd193a471f2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertyenumtype))], [])
interface IPropertyEnumType : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtype-getenumtype))], [])
    HRESULT GetEnumType(PROPENUMTYPE* penumtype);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtype-getvalue))], [])
    HRESULT GetValue(PROPVARIANT* ppropvar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtype-getrangeminvalue))], [])
    HRESULT GetRangeMinValue(PROPVARIANT* ppropvarMin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtype-getrangesetvalue))], [])
    HRESULT GetRangeSetValue(PROPVARIANT* ppropvarSet);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtype-getdisplaytext))], [])
    HRESULT GetDisplayText(PWSTR* ppszDisplay);
}

@GUID("9b6e051c-5ddd-4321-9070-fe2acb55e794")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertyenumtype2))], [])
interface IPropertyEnumType2 : IPropertyEnumType
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtype2-getimagereference))], [])
    HRESULT GetImageReference(PWSTR* ppszImageRes);
}

@GUID("a99400f4-3d84-4557-94ba-1242fb2cc9a6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertyenumtypelist))], [])
interface IPropertyEnumTypeList : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtypelist-getcount))], [])
    HRESULT GetCount(uint* pctypes);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtypelist-getat))], [])
    HRESULT GetAt(uint itype, const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtypelist-getconditionat))], [])
    HRESULT GetConditionAt(uint nIndex, const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertyenumtypelist-findmatchingindex))], [])
    HRESULT FindMatchingIndex(const(PROPVARIANT)* propvarCmp, uint* pnIndex);
}

@GUID("6f79d558-3e96-4549-a1d1-7d75d2288814")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertydescription))], [])
interface IPropertyDescription : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getpropertykey))], [])
    HRESULT GetPropertyKey(PROPERTYKEY* pkey);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getcanonicalname))], [])
    HRESULT GetCanonicalName(PWSTR* ppszName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getpropertytype))], [])
    HRESULT GetPropertyType(ushort* pvartype);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getdisplayname))], [])
    HRESULT GetDisplayName(PWSTR* ppszName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-geteditinvitation))], [])
    HRESULT GetEditInvitation(PWSTR* ppszInvite);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-gettypeflags))], [])
    HRESULT GetTypeFlags(PROPDESC_TYPE_FLAGS mask, PROPDESC_TYPE_FLAGS* ppdtFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getviewflags))], [])
    HRESULT GetViewFlags(PROPDESC_VIEW_FLAGS* ppdvFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getdefaultcolumnwidth))], [])
    HRESULT GetDefaultColumnWidth(uint* pcxChars);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getdisplaytype))], [])
    HRESULT GetDisplayType(PROPDESC_DISPLAYTYPE* pdisplaytype);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getcolumnstate))], [])
    HRESULT GetColumnState(uint* pcsFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getgroupingrange))], [])
    HRESULT GetGroupingRange(PROPDESC_GROUPING_RANGE* pgr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getrelativedescriptiontype))], [])
    HRESULT GetRelativeDescriptionType(PROPDESC_RELATIVEDESCRIPTION_TYPE* prdt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getrelativedescription))], [])
    HRESULT GetRelativeDescription(const(PROPVARIANT)* propvar1, const(PROPVARIANT)* propvar2, PWSTR* ppszDesc1, 
                                   PWSTR* ppszDesc2);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getsortdescription))], [])
    HRESULT GetSortDescription(PROPDESC_SORTDESCRIPTION* psd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getsortdescriptionlabel))], [])
    HRESULT GetSortDescriptionLabel(BOOL fDescending, PWSTR* ppszDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getaggregationtype))], [])
    HRESULT GetAggregationType(PROPDESC_AGGREGATION_TYPE* paggtype);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getconditiontype))], [])
    HRESULT GetConditionType(PROPDESC_CONDITION_TYPE* pcontype, CONDITION_OPERATION* popDefault);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-getenumtypelist))], [])
    HRESULT GetEnumTypeList(const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-coercetocanonicalvalue))], [])
    HRESULT CoerceToCanonicalValue(PROPVARIANT* ppropvar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-formatfordisplay))], [])
    HRESULT FormatForDisplay(const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdfFlags, PWSTR* ppszDisplay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription-isvaluecanonical))], [])
    HRESULT IsValueCanonical(const(PROPVARIANT)* propvar);
}

@GUID("57d2eded-5062-400e-b107-5dae79fe57a6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertydescription2))], [])
interface IPropertyDescription2 : IPropertyDescription
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescription2-getimagereferenceforvalue))], [])
    HRESULT GetImageReferenceForValue(const(PROPVARIANT)* propvar, PWSTR* ppszImageRes);
}

@GUID("f67104fc-2af9-46fd-b32d-243c1404f3d1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertydescriptionaliasinfo))], [])
interface IPropertyDescriptionAliasInfo : IPropertyDescription
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescriptionaliasinfo-getsortbyalias))], [])
    HRESULT GetSortByAlias(const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescriptionaliasinfo-getadditionalsortbyaliases))], [])
    HRESULT GetAdditionalSortByAliases(const(GUID)* riid, void** ppv);
}

@GUID("078f91bd-29a2-440f-924e-46a291524520")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertydescriptionsearchinfo))], [])
interface IPropertyDescriptionSearchInfo : IPropertyDescription
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescriptionsearchinfo-getsearchinfoflags))], [])
    HRESULT GetSearchInfoFlags(PROPDESC_SEARCHINFO_FLAGS* ppdsiFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescriptionsearchinfo-getcolumnindextype))], [])
    HRESULT GetColumnIndexType(PROPDESC_COLUMNINDEX_TYPE* ppdciType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescriptionsearchinfo-getprojectionstring))], [])
    HRESULT GetProjectionString(PWSTR* ppszProjection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescriptionsearchinfo-getmaxsize))], [])
    HRESULT GetMaxSize(uint* pcbMaxSize);
}

@GUID("507393f4-2a3d-4a60-b59e-d9c75716c2dd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertydescriptionrelatedpropertyinfo))], [])
interface IPropertyDescriptionRelatedPropertyInfo : IPropertyDescription
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescriptionrelatedpropertyinfo-getrelatedproperty))], [])
    HRESULT GetRelatedProperty(const(PWSTR) pszRelationshipName, const(GUID)* riid, void** ppv);
}

@GUID("ca724e8a-c3e6-442b-88a4-6fb0db8035a3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertysystem))], [])
interface IPropertySystem : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertysystem-getpropertydescription))], [])
    HRESULT GetPropertyDescription(const(PROPERTYKEY)* propkey, const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertysystem-getpropertydescriptionbyname))], [])
    HRESULT GetPropertyDescriptionByName(const(PWSTR) pszCanonicalName, const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertysystem-getpropertydescriptionlistfromstring))], [])
    HRESULT GetPropertyDescriptionListFromString(const(PWSTR) pszPropList, const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertysystem-enumeratepropertydescriptions))], [])
    HRESULT EnumeratePropertyDescriptions(PROPDESC_ENUMFILTER filterOn, const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertysystem-formatfordisplay))], [])
    HRESULT FormatForDisplay(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, 
                             PWSTR pszText, uint cchText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertysystem-formatfordisplayalloc))], [])
    HRESULT FormatForDisplayAlloc(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar, PROPDESC_FORMAT_FLAGS pdff, 
                                  PWSTR* ppszDisplay);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertysystem-registerpropertyschema))], [])
    HRESULT RegisterPropertySchema(const(PWSTR) pszPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertysystem-unregisterpropertyschema))], [])
    HRESULT UnregisterPropertySchema(const(PWSTR) pszPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertysystem-refreshpropertyschema))], [])
    HRESULT RefreshPropertySchema();
}

@GUID("1f9fc1d0-c39b-4b26-817f-011967d3440e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertydescriptionlist))], [])
interface IPropertyDescriptionList : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescriptionlist-getcount))], [])
    HRESULT GetCount(uint* pcElem);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertydescriptionlist-getat))], [])
    HRESULT GetAt(uint iElem, const(GUID)* riid, void** ppv);
}

@GUID("bc110b6d-57e8-4148-a9c6-91015ab2f3a5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipropertystorefactory))], [])
interface IPropertyStoreFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystorefactory-getpropertystore))], [])
    HRESULT GetPropertyStore(GETPROPERTYSTOREFLAGS flags, IUnknown pUnkFactory, const(GUID)* riid, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipropertystorefactory-getpropertystoreforkeys))], [])
    HRESULT GetPropertyStoreForKeys(const(PROPERTYKEY)* rgKeys, uint cKeys, GETPROPERTYSTOREFLAGS flags, 
                                    const(GUID)* riid, void** ppv);
}

@GUID("40d4577f-e237-4bdb-bd69-58f089431b6a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-idelayedpropertystorefactory))], [])
interface IDelayedPropertyStoreFactory : IPropertyStoreFactory
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-idelayedpropertystorefactory-getdelayedpropertystore))], [])
    HRESULT GetDelayedPropertyStore(GETPROPERTYSTOREFLAGS flags, uint dwStoreId, const(GUID)* riid, void** ppv);
}

@GUID("e318ad57-0aa0-450f-aca5-6fab7103d917")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipersistserializedpropstorage))], [])
interface IPersistSerializedPropStorage : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipersistserializedpropstorage-setflags))], [])
    HRESULT SetFlags(int flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipersistserializedpropstorage-setpropertystorage))], [])
    HRESULT SetPropertyStorage(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PCUSERIALIZEDPROPSTORAGE psps, 
                               uint cb);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipersistserializedpropstorage-getpropertystorage))], [])
    HRESULT GetPropertyStorage(SERIALIZEDPROPSTORAGE** ppsps, uint* pcb);
}

@GUID("77effa68-4f98-4366-ba72-573b3d880571")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-ipersistserializedpropstorage2))], [])
interface IPersistSerializedPropStorage2 : IPersistSerializedPropStorage
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipersistserializedpropstorage2-getpropertystoragesize))], [])
    HRESULT GetPropertyStorageSize(uint* pcb);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-ipersistserializedpropstorage2-getpropertystoragebuffer))], [])
    HRESULT GetPropertyStorageBuffer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SERIALIZEDPROPSTORAGE* psps, 
                                     uint cb, uint* pcbWritten);
}

@GUID("fa955fd9-38be-4879-a6ce-824cf52d609f")
interface IPropertySystemChangeNotify : IUnknown
{
    HRESULT SchemaRefreshed();
}

@GUID("75121952-e0d0-43e5-9380-1d80483acf72")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nn-propsys-icreateobject))], [])
interface ICreateObject : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-icreateobject-createobject))], [])
    HRESULT CreateObject(const(GUID)* clsid, IUnknown pUnkOuter, const(GUID)* riid, void** ppv);
}

@GUID("757a7d9f-919a-4118-99d7-dbb208c8cc66")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nn-shobjidl_core-ipropertyui))], [])
interface IPropertyUI : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipropertyui-parsepropertyname))], [])
    HRESULT ParsePropertyName(const(PWSTR) pszName, GUID* pfmtid, uint* ppid, uint* pchEaten);
    HRESULT GetCannonicalName(const(GUID)* fmtid, uint pid, PWSTR pwszText, uint cchText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipropertyui-getdisplayname))], [])
    HRESULT GetDisplayName(const(GUID)* fmtid, uint pid, PROPERTYUI_NAME_FLAGS flags, PWSTR pwszText, uint cchText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipropertyui-getpropertydescription))], [])
    HRESULT GetPropertyDescription(const(GUID)* fmtid, uint pid, PWSTR pwszText, uint cchText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipropertyui-getdefaultwidth))], [])
    HRESULT GetDefaultWidth(const(GUID)* fmtid, uint pid, uint* pcxChars);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipropertyui-getflags))], [])
    HRESULT GetFlags(const(GUID)* fmtid, uint pid, PROPERTYUI_FLAGS* pflags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipropertyui-formatfordisplay))], [])
    HRESULT FormatForDisplay(const(GUID)* fmtid, uint pid, const(PROPVARIANT)* ppropvar, 
                             PROPERTYUI_FORMAT_FLAGS puiff, PWSTR pwszText, uint cchText);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/shobjidl_core/nf-shobjidl_core-ipropertyui-gethelpinfo))], [])
    HRESULT GetHelpInfo(const(GUID)* fmtid, uint pid, PWSTR pwszHelpFile, uint cch, uint* puHelpID);
}


// GUIDs

const GUID CLSID_InMemoryPropertyStore               = GUIDOF!InMemoryPropertyStore;
const GUID CLSID_InMemoryPropertyStoreMarshalByValue = GUIDOF!InMemoryPropertyStoreMarshalByValue;
const GUID CLSID_PropertySystem                      = GUIDOF!PropertySystem;

const GUID IID_ICreateObject                           = GUIDOF!ICreateObject;
const GUID IID_IDelayedPropertyStoreFactory            = GUIDOF!IDelayedPropertyStoreFactory;
const GUID IID_IInitializeWithFile                     = GUIDOF!IInitializeWithFile;
const GUID IID_IInitializeWithStream                   = GUIDOF!IInitializeWithStream;
const GUID IID_INamedPropertyStore                     = GUIDOF!INamedPropertyStore;
const GUID IID_IObjectWithPropertyKey                  = GUIDOF!IObjectWithPropertyKey;
const GUID IID_IPersistSerializedPropStorage           = GUIDOF!IPersistSerializedPropStorage;
const GUID IID_IPersistSerializedPropStorage2          = GUIDOF!IPersistSerializedPropStorage2;
const GUID IID_IPropertyChange                         = GUIDOF!IPropertyChange;
const GUID IID_IPropertyChangeArray                    = GUIDOF!IPropertyChangeArray;
const GUID IID_IPropertyDescription                    = GUIDOF!IPropertyDescription;
const GUID IID_IPropertyDescription2                   = GUIDOF!IPropertyDescription2;
const GUID IID_IPropertyDescriptionAliasInfo           = GUIDOF!IPropertyDescriptionAliasInfo;
const GUID IID_IPropertyDescriptionList                = GUIDOF!IPropertyDescriptionList;
const GUID IID_IPropertyDescriptionRelatedPropertyInfo = GUIDOF!IPropertyDescriptionRelatedPropertyInfo;
const GUID IID_IPropertyDescriptionSearchInfo          = GUIDOF!IPropertyDescriptionSearchInfo;
const GUID IID_IPropertyEnumType                       = GUIDOF!IPropertyEnumType;
const GUID IID_IPropertyEnumType2                      = GUIDOF!IPropertyEnumType2;
const GUID IID_IPropertyEnumTypeList                   = GUIDOF!IPropertyEnumTypeList;
const GUID IID_IPropertyStore                          = GUIDOF!IPropertyStore;
const GUID IID_IPropertyStoreCache                     = GUIDOF!IPropertyStoreCache;
const GUID IID_IPropertyStoreCapabilities              = GUIDOF!IPropertyStoreCapabilities;
const GUID IID_IPropertyStoreFactory                   = GUIDOF!IPropertyStoreFactory;
const GUID IID_IPropertySystem                         = GUIDOF!IPropertySystem;
const GUID IID_IPropertySystemChangeNotify             = GUIDOF!IPropertySystemChangeNotify;
const GUID IID_IPropertyUI                             = GUIDOF!IPropertyUI;
