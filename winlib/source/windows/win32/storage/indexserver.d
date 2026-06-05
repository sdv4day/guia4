// Written in the D programming language.

module windows.win32.storage.indexserver;

public import windows.core;
public import windows.win32.foundation : HRESULT, PWSTR, RECT;
public import windows.win32.system.com : IStream, IUnknown;
public import windows.win32.system.com.structuredstorage : IStorage, PROPSPEC, PROPVARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias IFILTER_INIT = int;
enum : int
{
    IFILTER_INIT_CANON_PARAGRAPHS        = 0x00000001,
    IFILTER_INIT_HARD_LINE_BREAKS        = 0x00000002,
    IFILTER_INIT_CANON_HYPHENS           = 0x00000004,
    IFILTER_INIT_CANON_SPACES            = 0x00000008,
    IFILTER_INIT_APPLY_INDEX_ATTRIBUTES  = 0x00000010,
    IFILTER_INIT_APPLY_OTHER_ATTRIBUTES  = 0x00000020,
    IFILTER_INIT_APPLY_CRAWL_ATTRIBUTES  = 0x00000100,
    IFILTER_INIT_INDEXING_ONLY           = 0x00000040,
    IFILTER_INIT_SEARCH_LINKS            = 0x00000080,
    IFILTER_INIT_FILTER_OWNED_VALUE_OK   = 0x00000200,
    IFILTER_INIT_FILTER_AGGRESSIVE_BREAK = 0x00000400,
    IFILTER_INIT_DISABLE_EMBEDDED        = 0x00000800,
    IFILTER_INIT_EMIT_FORMATTING         = 0x00001000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/ne-filter-ifilter_flags))], [])

alias IFILTER_FLAGS = int;
enum : int
{
    IFILTER_FLAGS_OLE_PROPERTIES = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/ne-filter-chunkstate))], [])

alias CHUNKSTATE = int;
enum : int
{
    CHUNK_TEXT               = 0x00000001,
    CHUNK_VALUE              = 0x00000002,
    CHUNK_FILTER_OWNED_VALUE = 0x00000004,
    CHUNK_IMAGE              = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/ne-filter-chunk_breaktype))], [])

alias CHUNK_BREAKTYPE = int;
enum : int
{
    CHUNK_NO_BREAK = 0x00000000,
    CHUNK_EOW      = 0x00000001,
    CHUNK_EOS      = 0x00000002,
    CHUNK_EOP      = 0x00000003,
    CHUNK_EOC      = 0x00000004,
}

alias IMAGE_PIXELFORMAT = int;
enum : int
{
    FILTER_PIXELFORMAT_BGRA8  = 0x00000000,
    FILTER_PIXELFORMAT_PBGRA8 = 0x00000001,
    FILTER_PIXELFORMAT_BGR8   = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/indexsrv/ne-indexsrv-wordrep_break_type))], [])

alias WORDREP_BREAK_TYPE = int;
enum : int
{
    WORDREP_BREAK_EOW = 0x00000000,
    WORDREP_BREAK_EOS = 0x00000001,
    WORDREP_BREAK_EOP = 0x00000002,
    WORDREP_BREAK_EOC = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oledbguid/ne-oledbguid-dbkindenum))], [])

alias DBKINDENUM = int;
enum : int
{
    DBKIND_GUID_NAME    = 0x00000000,
    DBKIND_GUID_PROPID  = 0x00000001,
    DBKIND_NAME         = 0x00000002,
    DBKIND_PGUID_NAME   = 0x00000003,
    DBKIND_PGUID_PROPID = 0x00000004,
    DBKIND_PROPID       = 0x00000005,
    DBKIND_GUID         = 0x00000006,
}

// Constants


enum : uint
{
    CI_VERSION_WDS30 = 0x00000102,
    CI_VERSION_WDS40 = 0x00000109,
    CI_VERSION_WIN70 = 0x00000700,
}

enum const(wchar)* CIADMIN = "::_nodocstore_::";
enum uint LIFF_IMPLEMENT_TEXT_FILTER_FALLBACK_POLICY = 0x00000002;
enum uint PID_FILENAME = 0x00000064;

enum : uint
{
    DBPROP_CI_INCLUDE_SCOPES = 0x00000003,
    DBPROP_CI_DEPTHS         = 0x00000004,
    DBPROP_CI_SCOPE_FLAGS    = 0x00000004,
    DBPROP_CI_EXCLUDE_SCOPES = 0x00000005,
    DBPROP_CI_SECURITY_ID    = 0x00000006,
    DBPROP_CI_QUERY_TYPE     = 0x00000007,
    DBPROP_CI_PROVIDER       = 0x00000008,
}

enum : uint
{
    CI_PROVIDER_INDEXING_SERVICE = 0x00000002,
    CI_PROVIDER_ALL              = 0xffffffff,
}

enum uint DBPROP_USECONTENTINDEX = 0x00000002;
enum uint DBPROP_USEEXTENDEDDBTYPES = 0x00000004;
enum uint DBPROP_GENERICOPTIONS_STRING = 0x00000006;
enum uint DBPROP_DEFERCATALOGVERIFICATION = 0x00000008;
enum uint DBPROP_GENERATEPARSETREE = 0x0000000a;

enum : uint
{
    DBPROP_FREETEXTANYTERM     = 0x0000000c,
    DBPROP_FREETEXTUSESTEMMING = 0x0000000d,
}

enum uint DBPROP_DONOTCOMPUTEEXPENSIVEPROPS = 0x0000000f;

enum : uint
{
    DBPROP_SESSION_ID   = 0x00000011,
    DBPROP_QUERY_ID     = 0x00000012,
    DBPROP_MACHINE      = 0x00000002,
    DBPROP_CLIENT_CLSID = 0x00000003,
}

enum uint MSIDXSPROP_COMMAND_LOCALE_STRING = 0x00000003;

enum : uint
{
    MSIDXSPROP_PARSE_TREE            = 0x00000005,
    MSIDXSPROP_MAX_RANK              = 0x00000006,
    MSIDXSPROP_RESULTS_FOUND         = 0x00000007,
    MSIDXSPROP_WHEREID               = 0x00000008,
    MSIDXSPROP_SERVER_VERSION        = 0x00000009,
    MSIDXSPROP_SERVER_WINVER_MAJOR   = 0x0000000a,
    MSIDXSPROP_SERVER_WINVER_MINOR   = 0x0000000b,
    MSIDXSPROP_SERVER_NLSVERSION     = 0x0000000c,
    MSIDXSPROP_SERVER_NLSVER_DEFINED = 0x0000000d,
}

enum : uint
{
    STAT_BUSY          = 0x00000000,
    STAT_ERROR         = 0x00000001,
    STAT_DONE          = 0x00000002,
    STAT_REFRESH       = 0x00000003,
    STAT_PARTIAL_SCOPE = 0x00000008,
}

enum uint STAT_CONTENT_OUT_OF_DATE = 0x00000020;
enum uint STAT_CONTENT_QUERY_INCOMPLETE = 0x00000080;
enum uint STAT_SHARING_VIOLATION = 0x00000200;
enum uint STAT_MISSING_PROP_IN_RELDOC = 0x00000800;
enum uint STAT_COALESCE_COMP_ALL_NOISE = 0x00002000;

enum : uint
{
    QUERY_DEEP          = 0x00000001,
    QUERY_PHYSICAL_PATH = 0x00000000,
}

enum : uint
{
    PROPID_QUERY_WORKID       = 0x00000005,
    PROPID_QUERY_UNFILTERED   = 0x00000007,
    PROPID_QUERY_VIRTUALPATH  = 0x00000009,
    PROPID_QUERY_LASTSEENTIME = 0x0000000a,
}

enum : uint
{
    CICAT_READONLY  = 0x00000002,
    CICAT_WRITABLE  = 0x00000004,
    CICAT_NO_QUERY  = 0x00000008,
    CICAT_GET_STATE = 0x00000010,
}

enum : uint
{
    CI_STATE_SHADOW_MERGE          = 0x00000001,
    CI_STATE_MASTER_MERGE          = 0x00000002,
    CI_STATE_CONTENT_SCAN_REQUIRED = 0x00000004,
}

enum : uint
{
    CI_STATE_SCANNING              = 0x00000010,
    CI_STATE_RECOVERING            = 0x00000020,
    CI_STATE_INDEX_MIGRATION_MERGE = 0x00000040,
}

enum : uint
{
    CI_STATE_HIGH_IO             = 0x00000100,
    CI_STATE_MASTER_MERGE_PAUSED = 0x00000200,
}

enum : uint
{
    CI_STATE_BATTERY_POWER  = 0x00000800,
    CI_STATE_USER_ACTIVE    = 0x00001000,
    CI_STATE_STARTING       = 0x00002000,
    CI_STATE_READING_USNS   = 0x00004000,
    CI_STATE_DELETION_MERGE = 0x00008000,
}

enum : uint
{
    CI_STATE_HIGH_CPU       = 0x00020000,
    CI_STATE_BATTERY_POLICY = 0x00040000,
}

enum : uint
{
    GENERATE_METHOD_PREFIX  = 0x00000001,
    GENERATE_METHOD_INFLECT = 0x00000002,
}

enum : uint
{
    SCOPE_FLAG_INCLUDE = 0x00000001,
    SCOPE_FLAG_DEEP    = 0x00000002,
}

enum : uint
{
    SCOPE_TYPE_WINPATH = 0x00000100,
    SCOPE_TYPE_VPATH   = 0x00000200,
}

enum : uint
{
    PROPID_QUERY_RANK     = 0x00000003,
    PROPID_QUERY_HITCOUNT = 0x00000004,
    PROPID_QUERY_ALL      = 0x00000006,
    PROPID_STG_CONTENTS   = 0x00000013,
}

enum : uint
{
    VECTOR_RANK_MAX     = 0x00000001,
    VECTOR_RANK_INNER   = 0x00000002,
    VECTOR_RANK_DICE    = 0x00000003,
    VECTOR_RANK_JACCARD = 0x00000004,
}

enum : uint
{
    DBSETFUNC_ALL      = 0x00000001,
    DBSETFUNC_DISTINCT = 0x00000002,
}

enum : uint
{
    PROXIMITY_UNIT_SENTENCE  = 0x00000001,
    PROXIMITY_UNIT_PARAGRAPH = 0x00000002,
    PROXIMITY_UNIT_CHAPTER   = 0x00000003,
}

enum : HRESULT
{
    FILTER_E_END_OF_CHUNKS  = HRESULT(0x80041700),
    FILTER_E_NO_MORE_TEXT   = HRESULT(0x80041701),
    FILTER_E_NO_MORE_VALUES = HRESULT(0x80041702),
}

enum HRESULT FILTER_W_MONIKER_CLIPPED = HRESULT(0x00041704);

enum : HRESULT
{
    FILTER_E_NO_VALUES             = HRESULT(0x80041706),
    FILTER_E_EMBEDDING_UNAVAILABLE = HRESULT(0x80041707),
}

enum : HRESULT
{
    FILTER_S_LAST_TEXT   = HRESULT(0x00041709),
    FILTER_S_LAST_VALUES = HRESULT(0x0004170a),
}

enum HRESULT FILTER_E_UNKNOWNFORMAT = HRESULT(0x8004170c);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntquery/ns-ntquery-ci_state))], [])
struct CI_STATE
{
    uint cbStruct;
    uint cWordList;
    uint cPersistentIndex;
    uint cQueries;
    uint cDocuments;
    uint cFreshTest;
    uint dwMergeProgress;
    uint eState;
    uint cFilteredDocuments;
    uint cTotalDocuments;
    uint cPendingScans;
    uint dwIndexSize;
    uint cUniqueKeys;
    uint cSecQDocuments;
    uint dwPropCacheSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/ns-filter-fullpropspec))], [])
struct FULLPROPSPEC
{
    GUID     guidPropSet;
    PROPSPEC psProperty;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/ns-filter-filterregion))], [])
struct FILTERREGION
{
    uint idChunk;
    uint cwcStart;
    uint cwcExtent;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/ns-filter-stat_chunk))], [])
struct STAT_CHUNK
{
    uint            idChunk;
    CHUNK_BREAKTYPE breakType;
    CHUNKSTATE      flags;
    uint            locale;
    FULLPROPSPEC    attribute;
    uint            idChunkSource;
    uint            cwcStartSource;
    uint            cwcLenSource;
}

struct IMAGE_INFO
{
    uint              Width;
    uint              Height;
    IMAGE_PIXELFORMAT Format;
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oledbguid/ns-oledbguid-dbid))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct DBID
{
union uGuid
    {
    align (2):
        GUID  guid;
        GUID* pguid;
    }
    uint            eKind;
union uName
    {
    align (2):
        PWSTR pwszName;
        uint  ulPropid;
    }
}
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oledbguid/ns-oledbguid-dbid))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct DBID
{
align (2):
union uGuid
    {
    align (2):
        GUID  guid;
        GUID* pguid;
    }
    uint eKind;
union uName
    {
    align (2):
        PWSTR pwszName;
        uint  ulPropid;
    }
}
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntquery/nf-ntquery-loadifilter))], [])
@DllImport("query.dll")
HRESULT LoadIFilter(const(PWSTR) pwcsPath, IUnknown pUnkOuter, void** ppIUnk);

@DllImport("query.dll")
HRESULT LoadIFilterEx(const(PWSTR) pwcsPath, uint dwFlags, const(GUID)* riid, void** ppIUnk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntquery/nf-ntquery-bindifilterfromstorage))], [])
@DllImport("query.dll")
HRESULT BindIFilterFromStorage(IStorage pStg, IUnknown pUnkOuter, void** ppIUnk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntquery/nf-ntquery-bindifilterfromstream))], [])
@DllImport("query.dll")
HRESULT BindIFilterFromStream(IStream pStm, IUnknown pUnkOuter, void** ppIUnk);


// Interfaces

@GUID("89bcb740-6119-101a-bcb7-00dd010655af")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/nn-filter-ifilter))], [])
interface IFilter : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-init))], [])
    int Init(uint grfFlags, uint cAttributes, const(FULLPROPSPEC)* aAttributes, uint* pFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-getchunk))], [])
    int GetChunk(STAT_CHUNK* pStat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-gettext))], [])
    int GetText(uint* pcwcBuffer, PWSTR awcBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-getvalue))], [])
    int GetValue(PROPVARIANT** ppPropValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/filter/nf-filter-ifilter-bindregion))], [])
    int BindRegion(FILTERREGION origPos, const(GUID)* riid, void** ppunk);
}

@GUID("3d7df9a7-8da6-4fbf-a45b-7592f06d93a9")
interface IPixelFilter : IFilter
{
    HRESULT GetImageInfo(IMAGE_INFO* imageInfo);
    HRESULT GetPixelsForImage(float scalingFactor, const(RECT)* sourceRect, uint pixelBufferSize, 
                              ubyte* pixelBuffer);
}

@GUID("cc906ff0-c058-101a-b554-08002b33b0e6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/indexsrv/nn-indexsrv-iphrasesink))], [])
interface IPhraseSink : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/indexsrv/nf-indexsrv-iphrasesink-putsmallphrase))], [])
    HRESULT PutSmallPhrase(const(PWSTR) pwcNoun, uint cwcNoun, const(PWSTR) pwcModifier, uint cwcModifier, 
                           uint ulAttachmentType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/indexsrv/nf-indexsrv-iphrasesink-putphrase))], [])
    HRESULT PutPhrase(const(PWSTR) pwcPhrase, uint cwcPhrase);
}


// GUIDs


const GUID IID_IFilter      = GUIDOF!IFilter;
const GUID IID_IPhraseSink  = GUIDOF!IPhraseSink;
const GUID IID_IPixelFilter = GUIDOF!IPixelFilter;
