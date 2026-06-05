// Written in the D programming language.

module windows.win32.system.com.structuredstorage;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, CHAR, DECIMAL, FILETIME, HGLOBAL, HINSTANCE, HRESULT,
                                         PSTR, PWSTR, VARIANT_BOOL;
public import windows.win32.security : PSECURITY_DESCRIPTOR;
public import windows.win32.system.com : BLOB, CLSCTX, COSERVERINFO, CY, DVTARGETDEVICE, IDispatch, IErrorLog, IPersist,
                                         IStream, IUnknown, MULTI_QI, SAFEARRAY, STATSTG, STGM, STGMEDIUM,
                                         StorageLayout;
public import windows.win32.system.variant : PSTIME_FLAGS, VARENUM, VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias PROPSPEC_KIND = uint;
enum : uint
{
    PRSPEC_LPWSTR = 0x00000000,
    PRSPEC_PROPID = 0x00000001,
}

alias STGFMT = uint;
enum : uint
{
    STGFMT_STORAGE  = 0x00000000,
    STGFMT_NATIVE   = 0x00000001,
    STGFMT_FILE     = 0x00000003,
    STGFMT_ANY      = 0x00000004,
    STGFMT_DOCFILE  = 0x00000005,
    STGFMT_DOCUMENT = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ne-wtypes-stgmove))], [])

alias STGMOVE = int;
enum : int
{
    STGMOVE_MOVE        = 0x00000000,
    STGMOVE_COPY        = 0x00000001,
    STGMOVE_SHALLOWCOPY = 0x00000002,
}

alias PIDMSI_STATUS_VALUE = int;
enum : int
{
    PIDMSI_STATUS_NORMAL     = 0x00000000,
    PIDMSI_STATUS_NEW        = 0x00000001,
    PIDMSI_STATUS_PRELIM     = 0x00000002,
    PIDMSI_STATUS_DRAFT      = 0x00000003,
    PIDMSI_STATUS_INPROGRESS = 0x00000004,
    PIDMSI_STATUS_EDIT       = 0x00000005,
    PIDMSI_STATUS_REVIEW     = 0x00000006,
    PIDMSI_STATUS_PROOF      = 0x00000007,
    PIDMSI_STATUS_FINAL      = 0x00000008,
    PIDMSI_STATUS_OTHER      = 0x00007fff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/ne-propvarutil-propvar_compare_unit))], [])

alias PROPVAR_COMPARE_UNIT = int;
enum : int
{
    PVCU_DEFAULT = 0x00000000,
    PVCU_SECOND  = 0x00000001,
    PVCU_MINUTE  = 0x00000002,
    PVCU_HOUR    = 0x00000003,
    PVCU_DAY     = 0x00000004,
    PVCU_MONTH   = 0x00000005,
    PVCU_YEAR    = 0x00000006,
}

alias PROPVAR_COMPARE_FLAGS = int;
enum : int
{
    PVCF_DEFAULT                       = 0x00000000,
    PVCF_TREATEMPTYASGREATERTHAN       = 0x00000001,
    PVCF_USESTRCMP                     = 0x00000002,
    PVCF_USESTRCMPC                    = 0x00000004,
    PVCF_USESTRCMPI                    = 0x00000008,
    PVCF_USESTRCMPIC                   = 0x00000010,
    PVCF_DIGITSASNUMBERS_CASESENSITIVE = 0x00000020,
}

alias PROPVAR_CHANGE_FLAGS = int;
enum : int
{
    PVCHF_DEFAULT        = 0x00000000,
    PVCHF_NOVALUEPROP    = 0x00000001,
    PVCHF_ALPHABOOL      = 0x00000002,
    PVCHF_NOUSEROVERRIDE = 0x00000004,
    PVCHF_LOCALBOOL      = 0x00000008,
    PVCHF_NOHEXSTRING    = 0x00000010,
}

// Constants


enum : uint
{
    PROPSETFLAG_DEFAULT        = 0x00000000,
    PROPSETFLAG_NONSIMPLE      = 0x00000001,
    PROPSETFLAG_ANSI           = 0x00000002,
    PROPSETFLAG_UNBUFFERED     = 0x00000004,
    PROPSETFLAG_CASE_SENSITIVE = 0x00000008,
}

enum uint PID_DICTIONARY = 0x00000000;

enum : uint
{
    PID_FIRST_USABLE       = 0x00000002,
    PID_FIRST_NAME_DEFAULT = 0x00000fff,
}

enum uint PID_MODIFY_TIME = 0x80000001;
enum uint PID_BEHAVIOR = 0x80000003;
enum uint PID_MIN_READONLY = 0x80000000;
enum uint PRSPEC_INVALID = 0xffffffff;
enum int PIDDI_THUMBNAIL = 0x00000002;

enum : int
{
    PIDSI_SUBJECT    = 0x00000003,
    PIDSI_AUTHOR     = 0x00000004,
    PIDSI_KEYWORDS   = 0x00000005,
    PIDSI_COMMENTS   = 0x00000006,
    PIDSI_TEMPLATE   = 0x00000007,
    PIDSI_LASTAUTHOR = 0x00000008,
}

enum : int
{
    PIDSI_EDITTIME    = 0x0000000a,
    PIDSI_LASTPRINTED = 0x0000000b,
}

enum int PIDSI_LASTSAVE_DTM = 0x0000000d;
enum int PIDSI_WORDCOUNT = 0x0000000f;
enum int PIDSI_THUMBNAIL = 0x00000011;
enum int PIDSI_DOC_SECURITY = 0x00000013;

enum : uint
{
    PIDDSI_PRESFORMAT  = 0x00000003,
    PIDDSI_BYTECOUNT   = 0x00000004,
    PIDDSI_LINECOUNT   = 0x00000005,
    PIDDSI_PARCOUNT    = 0x00000006,
    PIDDSI_SLIDECOUNT  = 0x00000007,
    PIDDSI_NOTECOUNT   = 0x00000008,
    PIDDSI_HIDDENCOUNT = 0x00000009,
}

enum : uint
{
    PIDDSI_SCALE       = 0x0000000b,
    PIDDSI_HEADINGPAIR = 0x0000000c,
}

enum : uint
{
    PIDDSI_MANAGER    = 0x0000000e,
    PIDDSI_COMPANY    = 0x0000000f,
    PIDDSI_LINKSDIRTY = 0x00000010,
}

enum : int
{
    PIDMSI_SUPPLIER    = 0x00000003,
    PIDMSI_SOURCE      = 0x00000004,
    PIDMSI_SEQUENCE_NO = 0x00000005,
}

enum : int
{
    PIDMSI_STATUS     = 0x00000007,
    PIDMSI_OWNER      = 0x00000008,
    PIDMSI_RATING     = 0x00000009,
    PIDMSI_PRODUCTION = 0x0000000a,
    PIDMSI_COPYRIGHT  = 0x0000000b,
}

enum uint STGOPTIONS_VERSION = 0x00000001;

// Structs


struct BSTRBLOB
{
    uint   cbSize;
    ubyte* pData;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CLIPDATA
{
    uint   cbSize;
    int    ulClipFmt;
    ubyte* pClipData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-remsnb))], [])
struct RemSNB
{
    uint ulCntStr;
    uint ulCntChar;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] rgString;
}

struct VERSIONEDSTREAM
{
    GUID    guidVersion;
    IStream pStream;
}

struct CAC
{
    uint cElems;
    PSTR pElems;
}

struct CAUB
{
    uint   cElems;
    ubyte* pElems;
}

struct CAI
{
    uint   cElems;
    short* pElems;
}

struct CAUI
{
    uint    cElems;
    ushort* pElems;
}

struct CAL
{
    uint cElems;
    int* pElems;
}

struct CAUL
{
    uint  cElems;
    uint* pElems;
}

struct CAFLT
{
    uint   cElems;
    float* pElems;
}

struct CADBL
{
    uint    cElems;
    double* pElems;
}

struct CACY
{
    uint cElems;
    CY*  pElems;
}

struct CADATE
{
    uint    cElems;
    double* pElems;
}

struct CABSTR
{
    uint  cElems;
    BSTR* pElems;
}

struct CABSTRBLOB
{
    uint      cElems;
    BSTRBLOB* pElems;
}

struct CABOOL
{
    uint          cElems;
    VARIANT_BOOL* pElems;
}

struct CASCODE
{
    uint cElems;
    int* pElems;
}

struct CAPROPVARIANT
{
    uint         cElems;
    PROPVARIANT* pElems;
}

struct CAH
{
    uint  cElems;
    long* pElems;
}

struct CAUH
{
    uint   cElems;
    ulong* pElems;
}

struct CALPSTR
{
    uint  cElems;
    PSTR* pElems;
}

struct CALPWSTR
{
    uint   cElems;
    PWSTR* pElems;
}

struct CAFILETIME
{
    uint      cElems;
    FILETIME* pElems;
}

struct CACLIPDATA
{
    uint      cElems;
    CLIPDATA* pElems;
}

struct CACLSID
{
    uint  cElems;
    GUID* pElems;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/ns-propidlbase-propvariant))], [])
struct PROPVARIANT
{
union Anonymous
    {
struct Anonymous
        {
            VARENUM vt;
            ushort  wReserved1;
            ushort  wReserved2;
            ushort  wReserved3;
union Anonymous
            {
                CHAR             cVal;
                ubyte            bVal;
                short            iVal;
                ushort           uiVal;
                int              lVal;
                uint             ulVal;
                int              intVal;
                uint             uintVal;
                long             hVal;
                ulong            uhVal;
                float            fltVal;
                double           dblVal;
                VARIANT_BOOL     boolVal;
                VARIANT_BOOL     __OBSOLETE__VARIANT_BOOL;
                int              scode;
                CY               cyVal;
                double           date;
                FILETIME         filetime;
                GUID*            puuid;
                CLIPDATA*        pclipdata;
                BSTR             bstrVal;
                BSTRBLOB         bstrblobVal;
                BLOB             blob;
                PSTR             pszVal;
                PWSTR            pwszVal;
                IUnknown         punkVal;
                IDispatch        pdispVal;
                IStream          pStream;
                IStorage         pStorage;
                VERSIONEDSTREAM* pVersionedStream;
                SAFEARRAY*       parray;
                CAC              cac;
                CAUB             caub;
                CAI              cai;
                CAUI             caui;
                CAL              cal;
                CAUL             caul;
                CAH              cah;
                CAUH             cauh;
                CAFLT            caflt;
                CADBL            cadbl;
                CABOOL           cabool;
                CASCODE          cascode;
                CACY             cacy;
                CADATE           cadate;
                CAFILETIME       cafiletime;
                CACLSID          cauuid;
                CACLIPDATA       caclipdata;
                CABSTR           cabstr;
                CABSTRBLOB       cabstrblob;
                CALPSTR          calpstr;
                CALPWSTR         calpwstr;
                CAPROPVARIANT    capropvar;
                PSTR             pcVal;
                ubyte*           pbVal;
                short*           piVal;
                ushort*          puiVal;
                int*             plVal;
                uint*            pulVal;
                int*             pintVal;
                uint*            puintVal;
                float*           pfltVal;
                double*          pdblVal;
                VARIANT_BOOL*    pboolVal;
                DECIMAL*         pdecVal;
                int*             pscode;
                CY*              pcyVal;
                double*          pdate;
                BSTR*            pbstrVal;
                IUnknown*        ppunkVal;
                IDispatch*       ppdispVal;
                SAFEARRAY**      pparray;
                PROPVARIANT*     pvarVal;
            }
        }
        DECIMAL decVal;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/ns-propidlbase-propspec))], [])
struct PROPSPEC
{
    PROPSPEC_KIND ulKind;
union Anonymous
    {
        uint  propid;
        PWSTR lpwstr;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/ns-propidlbase-statpropstg))], [])
struct STATPROPSTG
{
    PWSTR   lpwstrName;
    uint    propid;
    VARENUM vt;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/ns-propidlbase-statpropsetstg))], [])
struct STATPROPSETSTG
{
    GUID     fmtid;
    GUID     clsid;
    uint     grfFlags;
    FILETIME mtime;
    FILETIME ctime;
    FILETIME atime;
    uint     dwOSVersion;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/ns-coml2api-stgoptions))], [])
struct STGOPTIONS
{
    ushort       usVersion;
    ushort       reserved;
    uint         ulSectorSize;
    const(PWSTR) pwcsTemplateFile;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidl/ns-propidl-serializedpropertyvalue))], [])
struct SERIALIZEDPROPERTYVALUE
{
    uint dwType;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] rgb;
}

struct OLESTREAMVTBL
{
    ptrdiff_t Get;
    ptrdiff_t Put;
}

struct OLESTREAM
{
    OLESTREAMVTBL* lpstbl;
}

struct PROPBAG2
{
    uint    dwType;
    VARENUM vt;
    ushort  cfType;
    uint    dwHint;
    PWSTR   pstrName;
    GUID    clsid;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-cogetinstancefromfile))], [])
@DllImport("OLE32.dll")
HRESULT CoGetInstanceFromFile(COSERVERINFO* pServerInfo, GUID* pClsid, IUnknown punkOuter, CLSCTX dwClsCtx, 
                              uint grfMode, PWSTR pwszName, uint dwCount, MULTI_QI* pResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-cogetinstancefromistorage))], [])
@DllImport("OLE32.dll")
HRESULT CoGetInstanceFromIStorage(COSERVERINFO* pServerInfo, GUID* pClsid, IUnknown punkOuter, CLSCTX dwClsCtx, 
                                  IStorage pstg, uint dwCount, MULTI_QI* pResults);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-stgopenasyncdocfileonifilllockbytes))], [])
@DllImport("ole32.dll")
HRESULT StgOpenAsyncDocfileOnIFillLockBytes(IFillLockBytes pflb, uint grfMode, uint asyncFlags, 
                                            IStorage* ppstgOpen);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-stggetifilllockbytesonilockbytes))], [])
@DllImport("ole32.dll")
HRESULT StgGetIFillLockBytesOnILockBytes(ILockBytes pilb, IFillLockBytes* ppflb);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-stggetifilllockbytesonfile))], [])
@DllImport("ole32.dll")
HRESULT StgGetIFillLockBytesOnFile(const(PWSTR) pwcsName, IFillLockBytes* ppflb);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-stgopenlayoutdocfile))], [])
@DllImport("dflayout.dll")
HRESULT StgOpenLayoutDocfile(const(PWSTR) pwcsDfName, uint grfMode, uint reserved, IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-createstreamonhglobal))], [])
@DllImport("OLE32.dll")
HRESULT CreateStreamOnHGlobal(HGLOBAL hGlobal, BOOL fDeleteOnRelease, IStream* ppstm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-gethglobalfromstream))], [])
@DllImport("OLE32.dll")
HRESULT GetHGlobalFromStream(IStream pstm, HGLOBAL* phglobal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetinterfaceandreleasestream))], [])
@DllImport("OLE32.dll")
HRESULT CoGetInterfaceAndReleaseStream(IStream pStm, const(GUID)* iid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-propvariantcopy))], [])
@DllImport("OLE32.dll")
HRESULT PropVariantCopy(PROPVARIANT* pvarDest, const(PROPVARIANT)* pvarSrc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-propvariantclear))], [])
@DllImport("OLE32.dll")
HRESULT PropVariantClear(PROPVARIANT* pvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-freepropvariantarray))], [])
@DllImport("OLE32.dll")
HRESULT FreePropVariantArray(uint cVariants, PROPVARIANT* rgvars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgcreatedocfile))], [])
@DllImport("OLE32.dll")
HRESULT StgCreateDocfile(const(PWSTR) pwcsName, STGM grfMode, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved, 
                         IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgcreatedocfileonilockbytes))], [])
@DllImport("OLE32.dll")
HRESULT StgCreateDocfileOnILockBytes(ILockBytes plkbyt, STGM grfMode, uint reserved, IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgopenstorage))], [])
@DllImport("OLE32.dll")
HRESULT StgOpenStorage(const(PWSTR) pwcsName, IStorage pstgPriority, STGM grfMode, ushort** snbExclude, 
                       uint reserved, IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgopenstorageonilockbytes))], [])
@DllImport("OLE32.dll")
HRESULT StgOpenStorageOnILockBytes(ILockBytes plkbyt, IStorage pstgPriority, STGM grfMode, ushort** snbExclude, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved, 
                                   IStorage* ppstgOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgisstoragefile))], [])
@DllImport("OLE32.dll")
HRESULT StgIsStorageFile(const(PWSTR) pwcsName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgisstorageilockbytes))], [])
@DllImport("OLE32.dll")
HRESULT StgIsStorageILockBytes(ILockBytes plkbyt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgsettimes))], [])
@DllImport("OLE32.dll")
HRESULT StgSetTimes(const(PWSTR) lpszName, const(FILETIME)* pctime, const(FILETIME)* patime, 
                    const(FILETIME)* pmtime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgcreatestorageex))], [])
@DllImport("OLE32.dll")
HRESULT StgCreateStorageEx(const(PWSTR) pwcsName, STGM grfMode, STGFMT stgfmt, uint grfAttrs, 
                           STGOPTIONS* pStgOptions, PSECURITY_DESCRIPTOR pSecurityDescriptor, const(GUID)* riid, 
                           void** ppObjectOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgopenstorageex))], [])
@DllImport("OLE32.dll")
HRESULT StgOpenStorageEx(const(PWSTR) pwcsName, STGM grfMode, STGFMT stgfmt, uint grfAttrs, 
                         STGOPTIONS* pStgOptions, PSECURITY_DESCRIPTOR pSecurityDescriptor, const(GUID)* riid, 
                         void** ppObjectOpen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgcreatepropstg))], [])
@DllImport("OLE32.dll")
HRESULT StgCreatePropStg(IUnknown pUnk, const(GUID)* fmtid, const(GUID)* pclsid, uint grfFlags, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                         IPropertyStorage* ppPropStg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgopenpropstg))], [])
@DllImport("OLE32.dll")
HRESULT StgOpenPropStg(IUnknown pUnk, const(GUID)* fmtid, uint grfFlags, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                       IPropertyStorage* ppPropStg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-stgcreatepropsetstg))], [])
@DllImport("OLE32.dll")
HRESULT StgCreatePropSetStg(IStorage pStorage, 
                            /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                            IPropertySetStorage* ppPropSetStg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-fmtidtopropstgname))], [])
@DllImport("OLE32.dll")
HRESULT FmtIdToPropStgName(const(GUID)* pfmtid, PWSTR oszName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-propstgnametofmtid))], [])
@DllImport("OLE32.dll")
HRESULT PropStgNameToFmtId(const(PWSTR) oszName, GUID* pfmtid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-readclassstg))], [])
@DllImport("OLE32.dll")
HRESULT ReadClassStg(IStorage pStg, GUID* pclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-writeclassstg))], [])
@DllImport("OLE32.dll")
HRESULT WriteClassStg(IStorage pStg, const(GUID)* rclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-readclassstm))], [])
@DllImport("OLE32.dll")
HRESULT ReadClassStm(IStream pStm, GUID* pclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-writeclassstm))], [])
@DllImport("OLE32.dll")
HRESULT WriteClassStm(IStream pStm, const(GUID)* rclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-gethglobalfromilockbytes))], [])
@DllImport("OLE32.dll")
HRESULT GetHGlobalFromILockBytes(ILockBytes plkbyt, HGLOBAL* phglobal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-createilockbytesonhglobal))], [])
@DllImport("OLE32.dll")
HRESULT CreateILockBytesOnHGlobal(HGLOBAL hGlobal, BOOL fDeleteOnRelease, ILockBytes* pplkbyt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/coml2api/nf-coml2api-getconvertstg))], [])
@DllImport("OLE32.dll")
HRESULT GetConvertStg(IStorage pStg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-stgconvertvarianttoproperty))], [])
@DllImport("ole32.dll")
SERIALIZEDPROPERTYVALUE* StgConvertVariantToProperty(const(PROPVARIANT)* pvar, ushort CodePage, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/SERIALIZEDPROPERTYVALUE* pprop, 
                                                     uint* pcb, uint pid, 
                                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/BOOLEAN fReserved, 
                                                     uint* pcIndirect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-stgconvertpropertytovariant))], [])
@DllImport("ole32.dll")
BOOLEAN StgConvertPropertyToVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, ushort CodePage, PROPVARIANT* pvar, 
                                    IMemoryAllocator pma);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propapi/nf-propapi-stgpropertylengthasvariant))], [])
@DllImport("ole32.dll")
uint StgPropertyLengthAsVariant(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(SERIALIZEDPROPERTYVALUE)* pProp, 
                                uint cbProp, ushort CodePage, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/ubyte bReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ole2/nf-ole2-writefmtusertypestg))], [])
@DllImport("OLE32.dll")
HRESULT WriteFmtUserTypeStg(IStorage pstg, ushort cf, PWSTR lpszUserType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ole2/nf-ole2-readfmtusertypestg))], [])
@DllImport("OLE32.dll")
HRESULT ReadFmtUserTypeStg(IStorage pstg, ushort* pcf, PWSTR* lplpszUserType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ole2/nf-ole2-oleconvertolestreamtoistorage))], [])
@DllImport("ole32.dll")
HRESULT OleConvertOLESTREAMToIStorage(OLESTREAM* lpolestream, IStorage pstg, const(DVTARGETDEVICE)* ptd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ole2/nf-ole2-oleconvertistoragetoolestream))], [])
@DllImport("ole32.dll")
HRESULT OleConvertIStorageToOLESTREAM(IStorage pstg, OLESTREAM* lpolestream);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ole2/nf-ole2-setconvertstg))], [])
@DllImport("OLE32.dll")
HRESULT SetConvertStg(IStorage pStg, BOOL fConvert);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ole2/nf-ole2-oleconvertistoragetoolestreamex))], [])
@DllImport("ole32.dll")
HRESULT OleConvertIStorageToOLESTREAMEx(IStorage pstg, ushort cfFormat, int lWidth, int lHeight, uint dwSize, 
                                        STGMEDIUM* pmedium, OLESTREAM* polestm);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ole2/nf-ole2-oleconvertolestreamtoistorageex))], [])
@DllImport("ole32.dll")
HRESULT OleConvertOLESTREAMToIStorageEx(OLESTREAM* polestm, IStorage pstg, ushort* pcfFormat, int* plwWidth, 
                                        int* plHeight, uint* pdwSize, STGMEDIUM* pmedium);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-propvarianttowinrtpropertyvalue))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToWinRTPropertyValue(const(PROPVARIANT)* propvar, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propsys/nf-propsys-winrtpropertyvaluetopropvariant))], [])
@DllImport("PROPSYS.dll")
HRESULT WinRTPropertyValueToPropVariant(IUnknown punkPropertyValue, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromresource))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromResource(HINSTANCE hinst, uint id, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfrombuffer))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromBuffer(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pv, 
                                  uint cb, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromclsid))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromCLSID(const(GUID)* clsid, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromguidasstring))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromGUIDAsString(const(GUID)* guid, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromfiletime))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromFileTime(const(FILETIME)* pftIn, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfrompropvariantvectorelem))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromPropVariantVectorElem(const(PROPVARIANT)* propvarIn, uint iElem, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantvectorfrompropvariant))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantVectorFromPropVariant(const(PROPVARIANT)* propvarSingle, PROPVARIANT* ppropvarVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfrombooleanvector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromBooleanVector(const(BOOL)* prgf, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromint16vector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromInt16Vector(const(short)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromuint16vector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromUInt16Vector(const(ushort)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromint32vector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromInt32Vector(const(int)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromuint32vector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromUInt32Vector(const(uint)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromint64vector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromInt64Vector(const(long)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromuint64vector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromUInt64Vector(const(ulong)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromdoublevector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromDoubleVector(const(double)* prgn, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromfiletimevector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromFileTimeVector(const(FILETIME)* prgft, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromstringvector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromStringVector(const(PWSTR)* prgsz, uint cElems, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-initpropvariantfromstringasvector))], [])
@DllImport("PROPSYS.dll")
HRESULT InitPropVariantFromStringAsVector(const(PWSTR) psz, PROPVARIANT* ppropvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttobooleanwithdefault))], [])
@DllImport("PROPSYS.dll")
BOOL PropVariantToBooleanWithDefault(const(PROPVARIANT)* propvarIn, BOOL fDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint16withdefault))], [])
@DllImport("PROPSYS.dll")
short PropVariantToInt16WithDefault(const(PROPVARIANT)* propvarIn, short iDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint16withdefault))], [])
@DllImport("PROPSYS.dll")
ushort PropVariantToUInt16WithDefault(const(PROPVARIANT)* propvarIn, ushort uiDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint32withdefault))], [])
@DllImport("PROPSYS.dll")
int PropVariantToInt32WithDefault(const(PROPVARIANT)* propvarIn, int lDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint32withdefault))], [])
@DllImport("PROPSYS.dll")
uint PropVariantToUInt32WithDefault(const(PROPVARIANT)* propvarIn, uint ulDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint64withdefault))], [])
@DllImport("PROPSYS.dll")
long PropVariantToInt64WithDefault(const(PROPVARIANT)* propvarIn, long llDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint64withdefault))], [])
@DllImport("PROPSYS.dll")
ulong PropVariantToUInt64WithDefault(const(PROPVARIANT)* propvarIn, ulong ullDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttodoublewithdefault))], [])
@DllImport("PROPSYS.dll")
double PropVariantToDoubleWithDefault(const(PROPVARIANT)* propvarIn, double dblDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttostringwithdefault))], [])
@DllImport("PROPSYS.dll")
PWSTR PropVariantToStringWithDefault(const(PROPVARIANT)* propvarIn, const(PWSTR) pszDefault);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoboolean))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBoolean(const(PROPVARIANT)* propvarIn, BOOL* pfRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint16))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt16(const(PROPVARIANT)* propvarIn, short* piRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint16))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt16(const(PROPVARIANT)* propvarIn, ushort* puiRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint32))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt32(const(PROPVARIANT)* propvarIn, int* plRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint32))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt32(const(PROPVARIANT)* propvarIn, uint* pulRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint64))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt64(const(PROPVARIANT)* propvarIn, long* pllRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint64))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt64(const(PROPVARIANT)* propvarIn, ulong* pullRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttodouble))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToDouble(const(PROPVARIANT)* propvarIn, double* pdblRet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttobuffer))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBuffer(const(PROPVARIANT)* propvar, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                            uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttostring))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToString(const(PROPVARIANT)* propvar, PWSTR psz, uint cch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoguid))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToGUID(const(PROPVARIANT)* propvar, GUID* pguid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttostringalloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToStringAlloc(const(PROPVARIANT)* propvar, PWSTR* ppszOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttobstr))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBSTR(const(PROPVARIANT)* propvar, BSTR* pbstrOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttofiletime))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToFileTime(const(PROPVARIANT)* propvar, PSTIME_FLAGS pstfOut, FILETIME* pftOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetelementcount))], [])
@DllImport("PROPSYS.dll")
uint PropVariantGetElementCount(const(PROPVARIANT)* propvar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttobooleanvector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBooleanVector(const(PROPVARIANT)* propvar, BOOL* prgf, uint crgf, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint16vector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt16Vector(const(PROPVARIANT)* propvar, short* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint16vector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt16Vector(const(PROPVARIANT)* propvar, ushort* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint32vector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt32Vector(const(PROPVARIANT)* propvar, int* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint32vector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt32Vector(const(PROPVARIANT)* propvar, uint* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint64vector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt64Vector(const(PROPVARIANT)* propvar, long* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint64vector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt64Vector(const(PROPVARIANT)* propvar, ulong* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttodoublevector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToDoubleVector(const(PROPVARIANT)* propvar, double* prgn, uint crgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttofiletimevector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToFileTimeVector(const(PROPVARIANT)* propvar, FILETIME* prgft, uint crgft, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttostringvector))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToStringVector(const(PROPVARIANT)* propvar, PWSTR* prgsz, uint crgsz, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttobooleanvectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToBooleanVectorAlloc(const(PROPVARIANT)* propvar, BOOL** pprgf, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint16vectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt16VectorAlloc(const(PROPVARIANT)* propvar, short** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint16vectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt16VectorAlloc(const(PROPVARIANT)* propvar, ushort** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint32vectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt32VectorAlloc(const(PROPVARIANT)* propvar, int** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint32vectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt32VectorAlloc(const(PROPVARIANT)* propvar, uint** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttoint64vectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToInt64VectorAlloc(const(PROPVARIANT)* propvar, long** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttouint64vectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToUInt64VectorAlloc(const(PROPVARIANT)* propvar, ulong** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttodoublevectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToDoubleVectorAlloc(const(PROPVARIANT)* propvar, double** pprgn, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttofiletimevectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToFileTimeVectorAlloc(const(PROPVARIANT)* propvar, FILETIME** pprgft, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttostringvectoralloc))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToStringVectorAlloc(const(PROPVARIANT)* propvar, PWSTR** pprgsz, uint* pcElem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetbooleanelem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetBooleanElem(const(PROPVARIANT)* propvar, uint iElem, BOOL* pfVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetint16elem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetInt16Elem(const(PROPVARIANT)* propvar, uint iElem, short* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetuint16elem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetUInt16Elem(const(PROPVARIANT)* propvar, uint iElem, ushort* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetint32elem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetInt32Elem(const(PROPVARIANT)* propvar, uint iElem, int* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetuint32elem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetUInt32Elem(const(PROPVARIANT)* propvar, uint iElem, uint* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetint64elem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetInt64Elem(const(PROPVARIANT)* propvar, uint iElem, long* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetuint64elem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetUInt64Elem(const(PROPVARIANT)* propvar, uint iElem, ulong* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetdoubleelem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetDoubleElem(const(PROPVARIANT)* propvar, uint iElem, double* pnVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetfiletimeelem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetFileTimeElem(const(PROPVARIANT)* propvar, uint iElem, FILETIME* pftVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantgetstringelem))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantGetStringElem(const(PROPVARIANT)* propvar, uint iElem, PWSTR* ppszVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-clearpropvariantarray))], [])
@DllImport("PROPSYS.dll")
void ClearPropVariantArray(PROPVARIANT* rgPropVar, uint cVars);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantcompareex))], [])
@DllImport("PROPSYS.dll")
int PropVariantCompareEx(const(PROPVARIANT)* propvar1, const(PROPVARIANT)* propvar2, PROPVAR_COMPARE_UNIT unit, 
                         PROPVAR_COMPARE_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvariantchangetype))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantChangeType(PROPVARIANT* ppropvarDest, const(PROPVARIANT)* propvarSrc, 
                              PROPVAR_CHANGE_FLAGS flags, VARENUM vt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-propvarianttovariant))], [])
@DllImport("PROPSYS.dll")
HRESULT PropVariantToVariant(const(PROPVARIANT)* pPropVar, VARIANT* pVar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-varianttopropvariant))], [])
@DllImport("PROPSYS.dll")
HRESULT VariantToPropVariant(const(VARIANT)* pVar, PROPVARIANT* pPropVar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-stgserializepropvariant))], [])
@DllImport("PROPSYS.dll")
HRESULT StgSerializePropVariant(const(PROPVARIANT)* ppropvar, SERIALIZEDPROPERTYVALUE** ppProp, uint* pcb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propvarutil/nf-propvarutil-stgdeserializepropvariant))], [])
@DllImport("PROPSYS.dll")
HRESULT StgDeserializePropVariant(const(SERIALIZEDPROPERTYVALUE)* pprop, uint cbMax, PROPVARIANT* ppropvar);


// Interfaces

@GUID("0000000d-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ienumstatstg))], [])
interface IEnumSTATSTG : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatstg-next))], [])
    HRESULT Next(uint celt, STATSTG* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatstg-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatstg-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatstg-clone))], [])
    HRESULT Clone(IEnumSTATSTG* ppenum);
}

@GUID("0000000b-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-istorage))], [])
interface IStorage : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-createstream))], [])
    HRESULT CreateStream(const(PWSTR) pwcsName, STGM grfMode, uint reserved1, uint reserved2, IStream* ppstm);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-openstream))], [])
    HRESULT OpenStream(const(PWSTR) pwcsName, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* reserved1, STGM grfMode, 
                       uint reserved2, IStream* ppstm);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-createstorage))], [])
    HRESULT CreateStorage(const(PWSTR) pwcsName, STGM grfMode, uint reserved1, uint reserved2, IStorage* ppstg);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-openstorage))], [])
    HRESULT OpenStorage(const(PWSTR) pwcsName, IStorage pstgPriority, STGM grfMode, ushort** snbExclude, 
                        uint reserved, IStorage* ppstg);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-copyto))], [])
    HRESULT CopyTo(uint ciidExclude, const(GUID)* rgiidExclude, ushort** snbExclude, IStorage pstgDest);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-moveelementto))], [])
    HRESULT MoveElementTo(const(PWSTR) pwcsName, IStorage pstgDest, const(PWSTR) pwcsNewName, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(STGMOVE))], [])*/uint grfFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-commit))], [])
    HRESULT Commit(uint grfCommitFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-revert))], [])
    HRESULT Revert();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-enumelements))], [])
    HRESULT EnumElements(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved1, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* reserved2, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint reserved3, 
                         IEnumSTATSTG* ppenum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-destroyelement))], [])
    HRESULT DestroyElement(const(PWSTR) pwcsName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-renameelement))], [])
    HRESULT RenameElement(const(PWSTR) pwcsOldName, const(PWSTR) pwcsNewName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-setelementtimes))], [])
    HRESULT SetElementTimes(const(PWSTR) pwcsName, const(FILETIME)* pctime, const(FILETIME)* patime, 
                            const(FILETIME)* pmtime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-setclass))], [])
    HRESULT SetClass(const(GUID)* clsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-setstatebits))], [])
    HRESULT SetStateBits(uint grfStateBits, uint grfMask);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istorage-stat))], [])
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

@GUID("0000010a-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ipersiststorage))], [])
interface IPersistStorage : IPersist
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-isdirty))], [])
    HRESULT IsDirty();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-initnew))], [])
    HRESULT InitNew(IStorage pStg);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-load))], [])
    HRESULT Load(IStorage pStg);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-save))], [])
    HRESULT Save(IStorage pStgSave, BOOL fSameAsLoad);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-savecompleted))], [])
    HRESULT SaveCompleted(IStorage pStgNew);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststorage-handsoffstorage))], [])
    HRESULT HandsOffStorage();
}

@GUID("0000000a-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ilockbytes))], [])
interface ILockBytes : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-readat))], [])
    HRESULT ReadAt(ulong ulOffset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                   uint cb, uint* pcbRead);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-writeat))], [])
    HRESULT WriteAt(ulong ulOffset, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pv, 
                    uint cb, uint* pcbWritten);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-flush))], [])
    HRESULT Flush();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-setsize))], [])
    HRESULT SetSize(ulong cb);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-lockregion))], [])
    HRESULT LockRegion(ulong libOffset, ulong cb, uint dwLockType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-unlockregion))], [])
    HRESULT UnlockRegion(ulong libOffset, ulong cb, uint dwLockType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilockbytes-stat))], [])
    HRESULT Stat(STATSTG* pstatstg, uint grfStatFlag);
}

@GUID("00000012-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-irootstorage))], [])
interface IRootStorage : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irootstorage-switchtofile))], [])
    HRESULT SwitchToFile(PWSTR pszFile);
}

@GUID("99caf010-415e-11cf-8814-00aa00b569f5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ifilllockbytes))], [])
interface IFillLockBytes : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ifilllockbytes-fillappend))], [])
    HRESULT FillAppend(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pv, 
                       uint cb, uint* pcbWritten);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ifilllockbytes-fillat))], [])
    HRESULT FillAt(ulong ulOffset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pv, 
                   uint cb, uint* pcbWritten);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ifilllockbytes-setfillsize))], [])
    HRESULT SetFillSize(ulong ulSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ifilllockbytes-terminate))], [])
    HRESULT Terminate(BOOL bCanceled);
}

@GUID("0e6d4d90-6738-11cf-9608-00aa00680db4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ilayoutstorage))], [])
interface ILayoutStorage : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-layoutscript))], [])
    HRESULT LayoutScript(StorageLayout* pStorageLayout, uint nEntries, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint glfInterleavedFlag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-beginmonitor))], [])
    HRESULT BeginMonitor();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-endmonitor))], [])
    HRESULT EndMonitor();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-relayoutdocfile))], [])
    HRESULT ReLayoutDocfile(PWSTR pwcsNewDfName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ilayoutstorage-relayoutdocfileonilockbytes))], [])
    HRESULT ReLayoutDocfileOnILockBytes(ILockBytes pILockBytes);
}

@GUID("0e6d4d92-6738-11cf-9608-00aa00680db4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-idirectwriterlock))], [])
interface IDirectWriterLock : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idirectwriterlock-waitforwriteaccess))], [])
    HRESULT WaitForWriteAccess(uint dwTimeout);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idirectwriterlock-releasewriteaccess))], [])
    HRESULT ReleaseWriteAccess();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idirectwriterlock-havewriteaccess))], [])
    HRESULT HaveWriteAccess();
}

@GUID("00000138-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nn-propidlbase-ipropertystorage))], [])
interface IPropertyStorage : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-readmultiple))], [])
    HRESULT ReadMultiple(uint cpspec, const(PROPSPEC)* rgpspec, PROPVARIANT* rgpropvar);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-writemultiple))], [])
    HRESULT WriteMultiple(uint cpspec, const(PROPSPEC)* rgpspec, const(PROPVARIANT)* rgpropvar, 
                          uint propidNameFirst);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-deletemultiple))], [])
    HRESULT DeleteMultiple(uint cpspec, const(PROPSPEC)* rgpspec);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-readpropertynames))], [])
    HRESULT ReadPropertyNames(uint cpropid, const(uint)* rgpropid, PWSTR* rglpwstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-writepropertynames))], [])
    HRESULT WritePropertyNames(uint cpropid, const(uint)* rgpropid, const(PWSTR)* rglpwstrName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-deletepropertynames))], [])
    HRESULT DeletePropertyNames(uint cpropid, const(uint)* rgpropid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-commit))], [])
    HRESULT Commit(uint grfCommitFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-revert))], [])
    HRESULT Revert();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-enum))], [])
    HRESULT Enum(IEnumSTATPROPSTG* ppenum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-settimes))], [])
    HRESULT SetTimes(const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-setclass))], [])
    HRESULT SetClass(const(GUID)* clsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ipropertystorage-stat))], [])
    HRESULT Stat(STATPROPSETSTG* pstatpsstg);
}

@GUID("0000013a-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidl/nn-propidl-ipropertysetstorage))], [])
interface IPropertySetStorage : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-ipropertysetstorage-create))], [])
    HRESULT Create(const(GUID)* rfmtid, const(GUID)* pclsid, uint grfFlags, uint grfMode, 
                   IPropertyStorage* ppprstg);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-ipropertysetstorage-open))], [])
    HRESULT Open(const(GUID)* rfmtid, uint grfMode, IPropertyStorage* ppprstg);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-ipropertysetstorage-delete))], [])
    HRESULT Delete(const(GUID)* rfmtid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidl/nf-propidl-ipropertysetstorage-enum))], [])
    HRESULT Enum(IEnumSTATPROPSETSTG* ppenum);
}

@GUID("00000139-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nn-propidlbase-ienumstatpropstg))], [])
interface IEnumSTATPROPSTG : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropstg-next))], [])
    HRESULT Next(uint celt, STATPROPSTG* rgelt, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropstg-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropstg-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropstg-clone))], [])
    HRESULT Clone(IEnumSTATPROPSTG* ppenum);
}

@GUID("0000013b-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nn-propidlbase-ienumstatpropsetstg))], [])
interface IEnumSTATPROPSETSTG : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropsetstg-next))], [])
    HRESULT Next(uint celt, STATPROPSETSTG* rgelt, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropsetstg-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropsetstg-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/propidlbase/nf-propidlbase-ienumstatpropsetstg-clone))], [])
    HRESULT Clone(IEnumSTATPROPSETSTG* ppenum);
}

//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Stg/imemoryallocator))], [])
interface IMemoryAllocator
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Stg/imemoryallocator-allocate))], [])
    void* Allocate(uint cbSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Stg/imemoryallocator-free))], [])
    void  Free(void* pv);
}

@GUID("55272a00-42cb-11ce-8135-00aa004bb851")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-ipropertybag))], [])
interface IPropertyBag : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ipropertybag-read))], [])
    HRESULT Read(const(PWSTR) pszPropName, VARIANT* pVar, IErrorLog pErrorLog);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ipropertybag-write))], [])
    HRESULT Write(const(PWSTR) pszPropName, VARIANT* pVar);
}

@GUID("22f55882-280b-11d0-a8a9-00a0c90c2004")
interface IPropertyBag2 : IUnknown
{
    HRESULT Read(uint cProperties, PROPBAG2* pPropBag, IErrorLog pErrLog, VARIANT* pvarValue, HRESULT* phrError);
    HRESULT Write(uint cProperties, PROPBAG2* pPropBag, VARIANT* pvarValue);
    HRESULT CountProperties(uint* pcProperties);
    HRESULT GetPropertyInfo(uint iProperty, uint cProperties, PROPBAG2* pPropBag, uint* pcProperties);
    HRESULT LoadObject(const(PWSTR) pstrName, uint dwHint, IUnknown pUnkObject, IErrorLog pErrLog);
}


// GUIDs


const GUID IID_IDirectWriterLock   = GUIDOF!IDirectWriterLock;
const GUID IID_IEnumSTATPROPSETSTG = GUIDOF!IEnumSTATPROPSETSTG;
const GUID IID_IEnumSTATPROPSTG    = GUIDOF!IEnumSTATPROPSTG;
const GUID IID_IEnumSTATSTG        = GUIDOF!IEnumSTATSTG;
const GUID IID_IFillLockBytes      = GUIDOF!IFillLockBytes;
const GUID IID_ILayoutStorage      = GUIDOF!ILayoutStorage;
const GUID IID_ILockBytes          = GUIDOF!ILockBytes;
const GUID IID_IPersistStorage     = GUIDOF!IPersistStorage;
const GUID IID_IPropertyBag        = GUIDOF!IPropertyBag;
const GUID IID_IPropertyBag2       = GUIDOF!IPropertyBag2;
const GUID IID_IPropertySetStorage = GUIDOF!IPropertySetStorage;
const GUID IID_IPropertyStorage    = GUIDOF!IPropertyStorage;
const GUID IID_IRootStorage        = GUIDOF!IRootStorage;
const GUID IID_IStorage            = GUIDOF!IStorage;
