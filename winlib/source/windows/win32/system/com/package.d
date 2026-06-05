// Written in the D programming language.

module windows.win32.system.com;

public import windows.core;
public import windows.win32.system.com.urlmon;
public import windows.win32.system.com.structuredstorage;
public import windows.win32.foundation : BOOL, BSTR, FILETIME, HANDLE, HGLOBAL, HINSTANCE, HRESULT, HWND, PSTR, PWSTR;
public import windows.win32.graphics.gdi : HBITMAP, HENHMETAFILE;
public import windows.win32.security : PSECURITY_DESCRIPTOR, SECURITY_ATTRIBUTES;
public import windows.win32.system.com.structuredstorage : IStorage;
public import windows.win32.system.ole : ARRAYDESC, PARAMDESC;
public import windows.win32.system.systemservices : userHBITMAP, userHENHMETAFILE, userHGLOBAL, userHMETAFILEPICT,
                                                    userHPALETTE;
public import windows.win32.system.variant : VARENUM, VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias URI_CREATE_FLAGS = uint;
enum : uint
{
    Uri_CREATE_ALLOW_RELATIVE                 = 0x00000001,
    Uri_CREATE_ALLOW_IMPLICIT_WILDCARD_SCHEME = 0x00000002,
    Uri_CREATE_ALLOW_IMPLICIT_FILE_SCHEME     = 0x00000004,
    Uri_CREATE_NOFRAG                         = 0x00000008,
    Uri_CREATE_NO_CANONICALIZE                = 0x00000010,
    Uri_CREATE_CANONICALIZE                   = 0x00000100,
    Uri_CREATE_FILE_USE_DOS_PATH              = 0x00000020,
    Uri_CREATE_DECODE_EXTRA_INFO              = 0x00000040,
    Uri_CREATE_NO_DECODE_EXTRA_INFO           = 0x00000080,
    Uri_CREATE_CRACK_UNKNOWN_SCHEMES          = 0x00000200,
    Uri_CREATE_NO_CRACK_UNKNOWN_SCHEMES       = 0x00000400,
    Uri_CREATE_PRE_PROCESS_HTML_URI           = 0x00000800,
    Uri_CREATE_NO_PRE_PROCESS_HTML_URI        = 0x00001000,
    Uri_CREATE_IE_SETTINGS                    = 0x00002000,
    Uri_CREATE_NO_IE_SETTINGS                 = 0x00004000,
    Uri_CREATE_NO_ENCODE_FORBIDDEN_CHARACTERS = 0x00008000,
    Uri_CREATE_NORMALIZE_INTL_CHARACTERS      = 0x00010000,
    Uri_CREATE_CANONICALIZE_ABSOLUTE          = 0x00020000,
}

alias RPC_C_AUTHN_LEVEL = uint;
enum : uint
{
    RPC_C_AUTHN_LEVEL_DEFAULT       = 0x00000000,
    RPC_C_AUTHN_LEVEL_NONE          = 0x00000001,
    RPC_C_AUTHN_LEVEL_CONNECT       = 0x00000002,
    RPC_C_AUTHN_LEVEL_CALL          = 0x00000003,
    RPC_C_AUTHN_LEVEL_PKT           = 0x00000004,
    RPC_C_AUTHN_LEVEL_PKT_INTEGRITY = 0x00000005,
    RPC_C_AUTHN_LEVEL_PKT_PRIVACY   = 0x00000006,
}

alias RPC_C_IMP_LEVEL = uint;
enum : uint
{
    RPC_C_IMP_LEVEL_DEFAULT     = 0x00000000,
    RPC_C_IMP_LEVEL_ANONYMOUS   = 0x00000001,
    RPC_C_IMP_LEVEL_IDENTIFY    = 0x00000002,
    RPC_C_IMP_LEVEL_IMPERSONATE = 0x00000003,
    RPC_C_IMP_LEVEL_DELEGATE    = 0x00000004,
}

alias ROT_FLAGS = uint;
enum : uint
{
    ROTFLAGS_REGISTRATIONKEEPSALIVE = 0x00000001,
    ROTFLAGS_ALLOWANYCLIENT         = 0x00000002,
}

alias ADVANCED_FEATURE_FLAGS = ushort;
enum : ushort
{
    FADF_AUTO        = cast(ushort)0x0001,
    FADF_STATIC      = cast(ushort)0x0002,
    FADF_EMBEDDED    = cast(ushort)0x0004,
    FADF_FIXEDSIZE   = cast(ushort)0x0010,
    FADF_RECORD      = cast(ushort)0x0020,
    FADF_HAVEIID     = cast(ushort)0x0040,
    FADF_HAVEVARTYPE = cast(ushort)0x0080,
    FADF_BSTR        = cast(ushort)0x0100,
    FADF_UNKNOWN     = cast(ushort)0x0200,
    FADF_DISPATCH    = cast(ushort)0x0400,
    FADF_VARIANT     = cast(ushort)0x0800,
    FADF_RESERVED    = cast(ushort)0xf008,
}

alias IMPLTYPEFLAGS = int;
enum : int
{
    IMPLTYPEFLAG_FDEFAULT       = 0x00000001,
    IMPLTYPEFLAG_FSOURCE        = 0x00000002,
    IMPLTYPEFLAG_FRESTRICTED    = 0x00000004,
    IMPLTYPEFLAG_FDEFAULTVTABLE = 0x00000008,
}

alias IDLFLAGS = ushort;
enum : ushort
{
    IDLFLAG_NONE    = cast(ushort)0x0000,
    IDLFLAG_FIN     = cast(ushort)0x0001,
    IDLFLAG_FOUT    = cast(ushort)0x0002,
    IDLFLAG_FLCID   = cast(ushort)0x0004,
    IDLFLAG_FRETVAL = cast(ushort)0x0008,
}

alias DISPATCH_FLAGS = ushort;
enum : ushort
{
    DISPATCH_METHOD         = cast(ushort)0x0001,
    DISPATCH_PROPERTYGET    = cast(ushort)0x0002,
    DISPATCH_PROPERTYPUT    = cast(ushort)0x0004,
    DISPATCH_PROPERTYPUTREF = cast(ushort)0x0008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Stg/stgm-constants))], [])

alias STGM = uint;
enum : uint
{
    STGM_DIRECT           = 0x00000000,
    STGM_TRANSACTED       = 0x00010000,
    STGM_SIMPLE           = 0x08000000,
    STGM_READ             = 0x00000000,
    STGM_WRITE            = 0x00000001,
    STGM_READWRITE        = 0x00000002,
    STGM_SHARE_DENY_NONE  = 0x00000040,
    STGM_SHARE_DENY_READ  = 0x00000030,
    STGM_SHARE_DENY_WRITE = 0x00000020,
    STGM_SHARE_EXCLUSIVE  = 0x00000010,
    STGM_PRIORITY         = 0x00040000,
    STGM_DELETEONRELEASE  = 0x04000000,
    STGM_NOSCRATCH        = 0x00100000,
    STGM_CREATE           = 0x00001000,
    STGM_CONVERT          = 0x00020000,
    STGM_FAILIFTHERE      = 0x00000000,
    STGM_NOSNAPSHOT       = 0x00200000,
    STGM_DIRECT_SWMR      = 0x00400000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ne-wtypes-dvaspect))], [])

alias DVASPECT = uint;
enum : uint
{
    DVASPECT_CONTENT     = 0x00000001,
    DVASPECT_THUMBNAIL   = 0x00000002,
    DVASPECT_ICON        = 0x00000004,
    DVASPECT_DOCPRINT    = 0x00000008,
    DVASPECT_OPAQUE      = 0x00000010,
    DVASPECT_TRANSPARENT = 0x00000020,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ne-wtypes-stgc))], [])

alias STGC = int;
enum : int
{
    STGC_DEFAULT                            = 0x00000000,
    STGC_OVERWRITE                          = 0x00000001,
    STGC_ONLYIFCURRENT                      = 0x00000002,
    STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE = 0x00000004,
    STGC_CONSOLIDATE                        = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ne-wtypes-statflag))], [])

alias STATFLAG = int;
enum : int
{
    STATFLAG_DEFAULT = 0x00000000,
    STATFLAG_NONAME  = 0x00000001,
    STATFLAG_NOOPEN  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ne-wtypes-tyspec))], [])

alias TYSPEC = int;
enum : int
{
    TYSPEC_CLSID       = 0x00000000,
    TYSPEC_FILEEXT     = 0x00000001,
    TYSPEC_MIMETYPE    = 0x00000002,
    TYSPEC_FILENAME    = 0x00000003,
    TYSPEC_PROGID      = 0x00000004,
    TYSPEC_PACKAGENAME = 0x00000005,
    TYSPEC_OBJECTID    = 0x00000006,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/ne-combaseapi-regcls))], [])

alias REGCLS = int;
enum : int
{
    REGCLS_SINGLEUSE      = 0x00000000,
    REGCLS_MULTIPLEUSE    = 0x00000001,
    REGCLS_MULTI_SEPARATE = 0x00000002,
    REGCLS_SUSPENDED      = 0x00000004,
    REGCLS_SURROGATE      = 0x00000008,
    REGCLS_AGILE          = 0x00000010,
}

alias COINITBASE = int;
enum : int
{
    COINITBASE_MULTITHREADED = 0x00000000,
}

alias MEMCTX = int;
enum : int
{
    MEMCTX_TASK      = 0x00000001,
    MEMCTX_SHARED    = 0x00000002,
    MEMCTX_MACSYSTEM = 0x00000003,
    MEMCTX_UNKNOWN   = 0xffffffff,
    MEMCTX_SAME      = 0xfffffffe,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypesbase/ne-wtypesbase-clsctx))], [])

alias CLSCTX = uint;
enum : uint
{
    CLSCTX_INPROC_SERVER                             = 0x00000001,
    CLSCTX_INPROC_HANDLER                            = 0x00000002,
    CLSCTX_LOCAL_SERVER                              = 0x00000004,
    CLSCTX_INPROC_SERVER16                           = 0x00000008,
    CLSCTX_REMOTE_SERVER                             = 0x00000010,
    CLSCTX_INPROC_HANDLER16                          = 0x00000020,
    CLSCTX_RESERVED1                                 = 0x00000040,
    CLSCTX_RESERVED2                                 = 0x00000080,
    CLSCTX_RESERVED3                                 = 0x00000100,
    CLSCTX_RESERVED4                                 = 0x00000200,
    CLSCTX_NO_CODE_DOWNLOAD                          = 0x00000400,
    CLSCTX_RESERVED5                                 = 0x00000800,
    CLSCTX_NO_CUSTOM_MARSHAL                         = 0x00001000,
    CLSCTX_ENABLE_CODE_DOWNLOAD                      = 0x00002000,
    CLSCTX_NO_FAILURE_LOG                            = 0x00004000,
    CLSCTX_DISABLE_AAA                               = 0x00008000,
    CLSCTX_ENABLE_AAA                                = 0x00010000,
    CLSCTX_FROM_DEFAULT_CONTEXT                      = 0x00020000,
    CLSCTX_ACTIVATE_X86_SERVER                       = 0x00040000,
    CLSCTX_ACTIVATE_32_BIT_SERVER                    = 0x00040000,
    CLSCTX_ACTIVATE_64_BIT_SERVER                    = 0x00080000,
    CLSCTX_ENABLE_CLOAKING                           = 0x00100000,
    CLSCTX_APPCONTAINER                              = 0x00400000,
    CLSCTX_ACTIVATE_AAA_AS_IU                        = 0x00800000,
    CLSCTX_RESERVED6                                 = 0x01000000,
    CLSCTX_ACTIVATE_ARM32_SERVER                     = 0x02000000,
    CLSCTX_ALLOW_LOWER_TRUST_REGISTRATION            = 0x04000000,
    CLSCTX_SERVER_MUST_BE_EQUAL_OR_GREATER_PRIVILEGE = 0x08000000,
    CLSCTX_DO_NOT_ELEVATE_SERVER                     = 0x10000000,
    CLSCTX_PS_DLL                                    = 0x80000000,
    CLSCTX_ALL                                       = 0x00000017,
    CLSCTX_SERVER                                    = 0x00000015,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypesbase/ne-wtypesbase-mshlflags))], [])

alias MSHLFLAGS = int;
enum : int
{
    MSHLFLAGS_NORMAL      = 0x00000000,
    MSHLFLAGS_TABLESTRONG = 0x00000001,
    MSHLFLAGS_TABLEWEAK   = 0x00000002,
    MSHLFLAGS_NOPING      = 0x00000004,
    MSHLFLAGS_RESERVED1   = 0x00000008,
    MSHLFLAGS_RESERVED2   = 0x00000010,
    MSHLFLAGS_RESERVED3   = 0x00000020,
    MSHLFLAGS_RESERVED4   = 0x00000040,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypesbase/ne-wtypesbase-mshctx))], [])

alias MSHCTX = int;
enum : int
{
    MSHCTX_LOCAL            = 0x00000000,
    MSHCTX_NOSHAREDMEM      = 0x00000001,
    MSHCTX_DIFFERENTMACHINE = 0x00000002,
    MSHCTX_INPROC           = 0x00000003,
    MSHCTX_CROSSCTX         = 0x00000004,
    MSHCTX_CONTAINER        = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ne-objidlbase-extconn))], [])

alias EXTCONN = int;
enum : int
{
    EXTCONN_STRONG   = 0x00000001,
    EXTCONN_WEAK     = 0x00000002,
    EXTCONN_CALLABLE = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-stgty))], [])

alias STGTY = int;
enum : int
{
    STGTY_STORAGE   = 0x00000001,
    STGTY_STREAM    = 0x00000002,
    STGTY_LOCKBYTES = 0x00000003,
    STGTY_PROPERTY  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-stream_seek))], [])

alias STREAM_SEEK = uint;
enum : uint
{
    STREAM_SEEK_SET = 0x00000000,
    STREAM_SEEK_CUR = 0x00000001,
    STREAM_SEEK_END = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-locktype))], [])

alias LOCKTYPE = int;
enum : int
{
    LOCK_WRITE     = 0x00000001,
    LOCK_EXCLUSIVE = 0x00000002,
    LOCK_ONLYONCE  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ne-objidlbase-eole_authentication_capabilities))], [])

alias EOLE_AUTHENTICATION_CAPABILITIES = int;
enum : int
{
    EOAC_NONE              = 0x00000000,
    EOAC_MUTUAL_AUTH       = 0x00000001,
    EOAC_STATIC_CLOAKING   = 0x00000020,
    EOAC_DYNAMIC_CLOAKING  = 0x00000040,
    EOAC_ANY_AUTHORITY     = 0x00000080,
    EOAC_MAKE_FULLSIC      = 0x00000100,
    EOAC_DEFAULT           = 0x00000800,
    EOAC_SECURE_REFS       = 0x00000002,
    EOAC_ACCESS_CONTROL    = 0x00000004,
    EOAC_APPID             = 0x00000008,
    EOAC_DYNAMIC           = 0x00000010,
    EOAC_REQUIRE_FULLSIC   = 0x00000200,
    EOAC_AUTO_IMPERSONATE  = 0x00000400,
    EOAC_DISABLE_AAA       = 0x00001000,
    EOAC_NO_CUSTOM_MARSHAL = 0x00002000,
    EOAC_RESERVED1         = 0x00004000,
}

alias RPCOPT_PROPERTIES = int;
enum : int
{
    COMBND_RPCTIMEOUT      = 0x00000001,
    COMBND_SERVER_LOCALITY = 0x00000002,
    COMBND_RESERVED1       = 0x00000004,
    COMBND_RESERVED2       = 0x00000005,
    COMBND_RESERVED3       = 0x00000008,
    COMBND_RESERVED4       = 0x00000010,
}

alias RPCOPT_SERVER_LOCALITY_VALUES = int;
enum : int
{
    SERVER_LOCALITY_PROCESS_LOCAL = 0x00000000,
    SERVER_LOCALITY_MACHINE_LOCAL = 0x00000001,
    SERVER_LOCALITY_REMOTE        = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ne-objidlbase-globalopt_properties))], [])

alias GLOBALOPT_PROPERTIES = int;
enum : int
{
    COMGLB_EXCEPTION_HANDLING     = 0x00000001,
    COMGLB_APPID                  = 0x00000002,
    COMGLB_RPC_THREADPOOL_SETTING = 0x00000003,
    COMGLB_RO_SETTINGS            = 0x00000004,
    COMGLB_UNMARSHALING_POLICY    = 0x00000005,
    COMGLB_PROPERTIES_RESERVED1   = 0x00000006,
    COMGLB_PROPERTIES_RESERVED2   = 0x00000007,
    COMGLB_PROPERTIES_RESERVED3   = 0x00000008,
}

alias GLOBALOPT_EH_VALUES = int;
enum : int
{
    COMGLB_EXCEPTION_HANDLE             = 0x00000000,
    COMGLB_EXCEPTION_DONOT_HANDLE_FATAL = 0x00000001,
    COMGLB_EXCEPTION_DONOT_HANDLE       = 0x00000001,
    COMGLB_EXCEPTION_DONOT_HANDLE_ANY   = 0x00000002,
}

alias GLOBALOPT_RPCTP_VALUES = int;
enum : int
{
    COMGLB_RPC_THREADPOOL_SETTING_DEFAULT_POOL = 0x00000000,
    COMGLB_RPC_THREADPOOL_SETTING_PRIVATE_POOL = 0x00000001,
}

alias GLOBALOPT_RO_FLAGS = int;
enum : int
{
    COMGLB_STA_MODALLOOP_REMOVE_TOUCH_MESSAGES                    = 0x00000001,
    COMGLB_STA_MODALLOOP_SHARED_QUEUE_REMOVE_INPUT_MESSAGES       = 0x00000002,
    COMGLB_STA_MODALLOOP_SHARED_QUEUE_DONOT_REMOVE_INPUT_MESSAGES = 0x00000004,
    COMGLB_FAST_RUNDOWN                                           = 0x00000008,
    COMGLB_RESERVED1                                              = 0x00000010,
    COMGLB_RESERVED2                                              = 0x00000020,
    COMGLB_RESERVED3                                              = 0x00000040,
    COMGLB_STA_MODALLOOP_SHARED_QUEUE_REORDER_POINTER_MESSAGES    = 0x00000080,
    COMGLB_RESERVED4                                              = 0x00000100,
    COMGLB_RESERVED5                                              = 0x00000200,
    COMGLB_RESERVED6                                              = 0x00000400,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ne-objidlbase-globalopt_unmarshaling_policy_values))], [])

alias GLOBALOPT_UNMARSHALING_POLICY_VALUES = int;
enum : int
{
    COMGLB_UNMARSHALING_POLICY_NORMAL = 0x00000000,
    COMGLB_UNMARSHALING_POLICY_STRONG = 0x00000001,
    COMGLB_UNMARSHALING_POLICY_HYBRID = 0x00000002,
}

alias DCOM_CALL_STATE = int;
enum : int
{
    DCOM_NONE          = 0x00000000,
    DCOM_CALL_COMPLETE = 0x00000001,
    DCOM_CALL_CANCELED = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ne-objidlbase-apttypequalifier))], [])

alias APTTYPEQUALIFIER = int;
enum : int
{
    APTTYPEQUALIFIER_NONE               = 0x00000000,
    APTTYPEQUALIFIER_IMPLICIT_MTA       = 0x00000001,
    APTTYPEQUALIFIER_NA_ON_MTA          = 0x00000002,
    APTTYPEQUALIFIER_NA_ON_STA          = 0x00000003,
    APTTYPEQUALIFIER_NA_ON_IMPLICIT_MTA = 0x00000004,
    APTTYPEQUALIFIER_NA_ON_MAINSTA      = 0x00000005,
    APTTYPEQUALIFIER_APPLICATION_STA    = 0x00000006,
    APTTYPEQUALIFIER_RESERVED_1         = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ne-objidlbase-apttype))], [])

alias APTTYPE = int;
enum : int
{
    APTTYPE_CURRENT = 0xffffffff,
    APTTYPE_STA     = 0x00000000,
    APTTYPE_MTA     = 0x00000001,
    APTTYPE_NA      = 0x00000002,
    APTTYPE_MAINSTA = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ne-objidlbase-thdtype))], [])

alias THDTYPE = int;
enum : int
{
    THDTYPE_BLOCKMESSAGES   = 0x00000000,
    THDTYPE_PROCESSMESSAGES = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ne-objidlbase-co_marshaling_context_attributes))], [])

alias CO_MARSHALING_CONTEXT_ATTRIBUTES = int;
enum : int
{
    CO_MARSHALING_SOURCE_IS_APP_CONTAINER       = 0x00000000,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_1  = 0x80000000,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_2  = 0x80000001,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_3  = 0x80000002,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_4  = 0x80000003,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_5  = 0x80000004,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_6  = 0x80000005,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_7  = 0x80000006,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_8  = 0x80000007,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_9  = 0x80000008,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_10 = 0x80000009,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_11 = 0x8000000a,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_12 = 0x8000000b,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_13 = 0x8000000c,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_14 = 0x8000000d,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_15 = 0x8000000e,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_16 = 0x8000000f,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_17 = 0x80000010,
    CO_MARSHALING_CONTEXT_ATTRIBUTE_RESERVED_18 = 0x80000011,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-bind_flags))], [])

alias BIND_FLAGS = int;
enum : int
{
    BIND_MAYBOTHERUSER     = 0x00000001,
    BIND_JUSTTESTEXISTENCE = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-mksys))], [])

alias MKSYS = int;
enum : int
{
    MKSYS_NONE             = 0x00000000,
    MKSYS_GENERICCOMPOSITE = 0x00000001,
    MKSYS_FILEMONIKER      = 0x00000002,
    MKSYS_ANTIMONIKER      = 0x00000003,
    MKSYS_ITEMMONIKER      = 0x00000004,
    MKSYS_POINTERMONIKER   = 0x00000005,
    MKSYS_CLASSMONIKER     = 0x00000007,
    MKSYS_OBJREFMONIKER    = 0x00000008,
    MKSYS_SESSIONMONIKER   = 0x00000009,
    MKSYS_LUAMONIKER       = 0x0000000a,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-mkrreduce))], [])

alias MKRREDUCE = int;
enum : int
{
    MKRREDUCE_ONE         = 0x00030000,
    MKRREDUCE_TOUSER      = 0x00020000,
    MKRREDUCE_THROUGHUSER = 0x00010000,
    MKRREDUCE_ALL         = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-advf))], [])

alias ADVF = int;
enum : int
{
    ADVF_NODATA            = 0x00000001,
    ADVF_PRIMEFIRST        = 0x00000002,
    ADVF_ONLYONCE          = 0x00000004,
    ADVF_DATAONSTOP        = 0x00000040,
    ADVFCACHE_NOHANDLER    = 0x00000008,
    ADVFCACHE_FORCEBUILTIN = 0x00000010,
    ADVFCACHE_ONSAVE       = 0x00000020,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-tymed))], [])

alias TYMED = int;
enum : int
{
    TYMED_HGLOBAL  = 0x00000001,
    TYMED_FILE     = 0x00000002,
    TYMED_ISTREAM  = 0x00000004,
    TYMED_ISTORAGE = 0x00000008,
    TYMED_GDI      = 0x00000010,
    TYMED_MFPICT   = 0x00000020,
    TYMED_ENHMF    = 0x00000040,
    TYMED_NULL     = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-datadir))], [])

alias DATADIR = int;
enum : int
{
    DATADIR_GET = 0x00000001,
    DATADIR_SET = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-calltype))], [])

alias CALLTYPE = int;
enum : int
{
    CALLTYPE_TOPLEVEL             = 0x00000001,
    CALLTYPE_NESTED               = 0x00000002,
    CALLTYPE_ASYNC                = 0x00000003,
    CALLTYPE_TOPLEVEL_CALLPENDING = 0x00000004,
    CALLTYPE_ASYNC_CALLPENDING    = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-servercall))], [])

alias SERVERCALL = int;
enum : int
{
    SERVERCALL_ISHANDLED  = 0x00000000,
    SERVERCALL_REJECTED   = 0x00000001,
    SERVERCALL_RETRYLATER = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-pendingtype))], [])

alias PENDINGTYPE = int;
enum : int
{
    PENDINGTYPE_TOPLEVEL = 0x00000001,
    PENDINGTYPE_NESTED   = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ne-objidl-pendingmsg))], [])

alias PENDINGMSG = int;
enum : int
{
    PENDINGMSG_CANCELCALL     = 0x00000000,
    PENDINGMSG_WAITNOPROCESS  = 0x00000001,
    PENDINGMSG_WAITDEFPROCESS = 0x00000002,
}

enum ApplicationType : int
{
    ServerApplication  = 0x00000000,
    LibraryApplication = 0x00000001,
}

enum ShutdownType : int
{
    IdleShutdown   = 0x00000000,
    ForcedShutdown = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/ne-objbase-coinit))], [])

alias COINIT = int;
enum : int
{
    COINIT_APARTMENTTHREADED = 0x00000002,
    COINIT_MULTITHREADED     = 0x00000000,
    COINIT_DISABLE_OLE1DDE   = 0x00000004,
    COINIT_SPEED_OVER_MEMORY = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/ne-objbase-comsd))], [])

alias COMSD = int;
enum : int
{
    SD_LAUNCHPERMISSIONS  = 0x00000000,
    SD_ACCESSPERMISSIONS  = 0x00000001,
    SD_LAUNCHRESTRICTIONS = 0x00000002,
    SD_ACCESSRESTRICTIONS = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/ne-combaseapi-cowait_flags))], [])

alias COWAIT_FLAGS = int;
enum : int
{
    COWAIT_DEFAULT                  = 0x00000000,
    COWAIT_WAITALL                  = 0x00000001,
    COWAIT_ALERTABLE                = 0x00000002,
    COWAIT_INPUTAVAILABLE           = 0x00000004,
    COWAIT_DISPATCH_CALLS           = 0x00000008,
    COWAIT_DISPATCH_WINDOW_MESSAGES = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/ne-combaseapi-cwmo_flags))], [])

alias CWMO_FLAGS = int;
enum : int
{
    CWMO_DEFAULT                  = 0x00000000,
    CWMO_DISPATCH_CALLS           = 0x00000001,
    CWMO_DISPATCH_WINDOW_MESSAGES = 0x00000002,
}

alias BINDINFOF = int;
enum : int
{
    BINDINFOF_URLENCODESTGMEDDATA = 0x00000001,
    BINDINFOF_URLENCODEDEXTRAINFO = 0x00000002,
}

alias Uri_PROPERTY = int;
enum : int
{
    Uri_PROPERTY_ABSOLUTE_URI   = 0x00000000,
    Uri_PROPERTY_STRING_START   = 0x00000000,
    Uri_PROPERTY_AUTHORITY      = 0x00000001,
    Uri_PROPERTY_DISPLAY_URI    = 0x00000002,
    Uri_PROPERTY_DOMAIN         = 0x00000003,
    Uri_PROPERTY_EXTENSION      = 0x00000004,
    Uri_PROPERTY_FRAGMENT       = 0x00000005,
    Uri_PROPERTY_HOST           = 0x00000006,
    Uri_PROPERTY_PASSWORD       = 0x00000007,
    Uri_PROPERTY_PATH           = 0x00000008,
    Uri_PROPERTY_PATH_AND_QUERY = 0x00000009,
    Uri_PROPERTY_QUERY          = 0x0000000a,
    Uri_PROPERTY_RAW_URI        = 0x0000000b,
    Uri_PROPERTY_SCHEME_NAME    = 0x0000000c,
    Uri_PROPERTY_USER_INFO      = 0x0000000d,
    Uri_PROPERTY_USER_NAME      = 0x0000000e,
    Uri_PROPERTY_STRING_LAST    = 0x0000000e,
    Uri_PROPERTY_HOST_TYPE      = 0x0000000f,
    Uri_PROPERTY_DWORD_START    = 0x0000000f,
    Uri_PROPERTY_PORT           = 0x00000010,
    Uri_PROPERTY_SCHEME         = 0x00000011,
    Uri_PROPERTY_ZONE           = 0x00000012,
    Uri_PROPERTY_DWORD_LAST     = 0x00000012,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-typekind))], [])

alias TYPEKIND = int;
enum : int
{
    TKIND_ENUM      = 0x00000000,
    TKIND_RECORD    = 0x00000001,
    TKIND_MODULE    = 0x00000002,
    TKIND_INTERFACE = 0x00000003,
    TKIND_DISPATCH  = 0x00000004,
    TKIND_COCLASS   = 0x00000005,
    TKIND_ALIAS     = 0x00000006,
    TKIND_UNION     = 0x00000007,
    TKIND_MAX       = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-callconv))], [])

alias CALLCONV = int;
enum : int
{
    CC_FASTCALL   = 0x00000000,
    CC_CDECL      = 0x00000001,
    CC_MSCPASCAL  = 0x00000002,
    CC_PASCAL     = 0x00000002,
    CC_MACPASCAL  = 0x00000003,
    CC_STDCALL    = 0x00000004,
    CC_FPFASTCALL = 0x00000005,
    CC_SYSCALL    = 0x00000006,
    CC_MPWCDECL   = 0x00000007,
    CC_MPWPASCAL  = 0x00000008,
    CC_MAX        = 0x00000009,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-funckind))], [])

alias FUNCKIND = int;
enum : int
{
    FUNC_VIRTUAL     = 0x00000000,
    FUNC_PUREVIRTUAL = 0x00000001,
    FUNC_NONVIRTUAL  = 0x00000002,
    FUNC_STATIC      = 0x00000003,
    FUNC_DISPATCH    = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-invokekind))], [])

alias INVOKEKIND = int;
enum : int
{
    INVOKE_FUNC           = 0x00000001,
    INVOKE_PROPERTYGET    = 0x00000002,
    INVOKE_PROPERTYPUT    = 0x00000004,
    INVOKE_PROPERTYPUTREF = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-varkind))], [])

alias VARKIND = int;
enum : int
{
    VAR_PERINSTANCE = 0x00000000,
    VAR_STATIC      = 0x00000001,
    VAR_CONST       = 0x00000002,
    VAR_DISPATCH    = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-funcflags))], [])

alias FUNCFLAGS = ushort;
enum : ushort
{
    FUNCFLAG_FRESTRICTED       = cast(ushort)0x0001,
    FUNCFLAG_FSOURCE           = cast(ushort)0x0002,
    FUNCFLAG_FBINDABLE         = cast(ushort)0x0004,
    FUNCFLAG_FREQUESTEDIT      = cast(ushort)0x0008,
    FUNCFLAG_FDISPLAYBIND      = cast(ushort)0x0010,
    FUNCFLAG_FDEFAULTBIND      = cast(ushort)0x0020,
    FUNCFLAG_FHIDDEN           = cast(ushort)0x0040,
    FUNCFLAG_FUSESGETLASTERROR = cast(ushort)0x0080,
    FUNCFLAG_FDEFAULTCOLLELEM  = cast(ushort)0x0100,
    FUNCFLAG_FUIDEFAULT        = cast(ushort)0x0200,
    FUNCFLAG_FNONBROWSABLE     = cast(ushort)0x0400,
    FUNCFLAG_FREPLACEABLE      = cast(ushort)0x0800,
    FUNCFLAG_FIMMEDIATEBIND    = cast(ushort)0x1000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-varflags))], [])

alias VARFLAGS = ushort;
enum : ushort
{
    VARFLAG_FREADONLY        = cast(ushort)0x0001,
    VARFLAG_FSOURCE          = cast(ushort)0x0002,
    VARFLAG_FBINDABLE        = cast(ushort)0x0004,
    VARFLAG_FREQUESTEDIT     = cast(ushort)0x0008,
    VARFLAG_FDISPLAYBIND     = cast(ushort)0x0010,
    VARFLAG_FDEFAULTBIND     = cast(ushort)0x0020,
    VARFLAG_FHIDDEN          = cast(ushort)0x0040,
    VARFLAG_FRESTRICTED      = cast(ushort)0x0080,
    VARFLAG_FDEFAULTCOLLELEM = cast(ushort)0x0100,
    VARFLAG_FUIDEFAULT       = cast(ushort)0x0200,
    VARFLAG_FNONBROWSABLE    = cast(ushort)0x0400,
    VARFLAG_FREPLACEABLE     = cast(ushort)0x0800,
    VARFLAG_FIMMEDIATEBIND   = cast(ushort)0x1000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-desckind))], [])

alias DESCKIND = int;
enum : int
{
    DESCKIND_NONE           = 0x00000000,
    DESCKIND_FUNCDESC       = 0x00000001,
    DESCKIND_VARDESC        = 0x00000002,
    DESCKIND_TYPECOMP       = 0x00000003,
    DESCKIND_IMPLICITAPPOBJ = 0x00000004,
    DESCKIND_MAX            = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ne-oaidl-syskind))], [])

alias SYSKIND = int;
enum : int
{
    SYS_WIN16 = 0x00000000,
    SYS_WIN32 = 0x00000001,
    SYS_MAC   = 0x00000002,
    SYS_WIN64 = 0x00000003,
}

// Constants


enum PWSTR COLE_DEFAULT_PRINCIPAL = PWSTR(cast(wchar*)0xffffffff);
enum uint MARSHALINTERFACE_MIN = 0x000001f4;
enum int ASYNC_MODE_DEFAULT = 0x00000000;

enum : int
{
    STG_TOEND              = 0xffffffff,
    STG_LAYOUT_SEQUENTIAL  = 0x00000000,
    STG_LAYOUT_INTERLEAVED = 0x00000001,
}

enum : uint
{
    COM_RIGHTS_EXECUTE_LOCAL   = 0x00000002,
    COM_RIGHTS_EXECUTE_REMOTE  = 0x00000004,
    COM_RIGHTS_ACTIVATE_LOCAL  = 0x00000008,
    COM_RIGHTS_ACTIVATE_REMOTE = 0x00000010,
    COM_RIGHTS_RESERVED1       = 0x00000020,
    COM_RIGHTS_RESERVED2       = 0x00000040,
}

enum uint ROTREGFLAGS_ALLOWANYCLIENT = 0x00000001;
enum uint APPIDREGFLAGS_SECURE_SERVER_PROCESS_SD_AND_BIND = 0x00000002;

enum : uint
{
    APPIDREGFLAGS_IUSERVER_UNMODIFIED_LOGON_TOKEN          = 0x00000008,
    APPIDREGFLAGS_IUSERVER_SELF_SID_IN_LAUNCH_PERMISSION   = 0x00000010,
    APPIDREGFLAGS_IUSERVER_ACTIVATE_IN_CLIENT_SESSION_ONLY = 0x00000020,
}

enum : uint
{
    APPIDREGFLAGS_RESERVED2                      = 0x00000080,
    APPIDREGFLAGS_RESERVED3                      = 0x00000100,
    APPIDREGFLAGS_RESERVED4                      = 0x00000200,
    APPIDREGFLAGS_RESERVED5                      = 0x00000400,
    APPIDREGFLAGS_AAA_NO_IMPLICIT_ACTIVATE_AS_IU = 0x00000800,
}

enum : uint
{
    APPIDREGFLAGS_RESERVED8  = 0x00002000,
    APPIDREGFLAGS_RESERVED9  = 0x00004000,
    APPIDREGFLAGS_RESERVED10 = 0x00008000,
}

enum uint DCOMSCM_ACTIVATION_DISALLOW_UNSECURE_CALL = 0x00000002;
enum uint DCOMSCM_RESOLVE_DISALLOW_UNSECURE_CALL = 0x00000008;
enum uint DCOMSCM_PING_DISALLOW_UNSECURE_CALL = 0x00000020;
enum uint DMUS_ERRBASE = 0x00001000;

// Callbacks

alias LPEXCEPFINO_DEFERRED_FILLIN = HRESULT function(EXCEPINFO* pExcepInfo);
alias LPFNGETCLASSOBJECT = HRESULT function(const(GUID)* param0, const(GUID)* param1, void** param2);
alias LPFNCANUNLOADNOW = HRESULT function();
alias PFNCONTEXTCALL = HRESULT function(ComCallData* pParam);

// Structs


@RAIIFree!CoDecrementMTAUsage
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct CO_MTA_USAGE_COOKIE
{
    void* Value;
}

@RAIIFree!CoRevokeDeviceCatalog
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct CO_DEVICE_CATALOG_COOKIE
{
    void* Value;
}

struct MachineGlobalObjectTableRegistrationToken
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ns-wtypes-cy~r1))], [])
union CY
{
struct Anonymous
    {
        uint Lo;
        int  Hi;
    }
    long int64;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ns-wtypes-csplatform))], [])
struct CSPLATFORM
{
    uint dwPlatformId;
    uint dwVersionHi;
    uint dwVersionLo;
    uint dwProcessorArch;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ns-wtypes-querycontext))], [])
struct QUERYCONTEXT
{
    uint       dwContext;
    CSPLATFORM Platform;
    uint       Locale;
    uint       dwVersionHi;
    uint       dwVersionLo;
}

struct uCLSSPEC
{
    uint tyspec;
union tagged_union
    {
        GUID  clsid;
        PWSTR pFileExt;
        PWSTR pMimeType;
        PWSTR pProgId;
        PWSTR pFileName;
struct ByName
        {
            PWSTR pPackageName;
            GUID  PolicyId;
        }
struct ByObjectId
        {
            GUID ObjectId;
            GUID PolicyId;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypesbase/ns-wtypesbase-coauthidentity))], [])
struct COAUTHIDENTITY
{
    ushort* User;
    uint    UserLength;
    ushort* Domain;
    uint    DomainLength;
    ushort* Password;
    uint    PasswordLength;
    uint    Flags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypesbase/ns-wtypesbase-coauthinfo))], [])
struct COAUTHINFO
{
    uint            dwAuthnSvc;
    uint            dwAuthzSvc;
    PWSTR           pwszServerPrincName;
    uint            dwAuthnLevel;
    uint            dwImpersonationLevel;
    COAUTHIDENTITY* pAuthIdentityData;
    uint            dwCapabilities;
}

struct BYTE_BLOB
{
    uint clSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] abData;
}

struct WORD_BLOB
{
    uint clSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ushort[1] asData;
}

struct DWORD_BLOB
{
    uint clSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] alData;
}

struct FLAGGED_BYTE_BLOB
{
    uint fFlags;
    uint clSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] abData;
}

struct FLAGGED_WORD_BLOB
{
    uint fFlags;
    uint clSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ushort[1] asData;
}

struct BYTE_SIZEDARR
{
    uint   clSize;
    ubyte* pData;
}

struct WORD_SIZEDARR
{
    uint    clSize;
    ushort* pData;
}

struct DWORD_SIZEDARR
{
    uint  clSize;
    uint* pData;
}

struct HYPER_SIZEDARR
{
    uint  clSize;
    long* pData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-blob))], [])
struct BLOB
{
    uint   cbSize;
    ubyte* pBlobData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ns-objidlbase-coserverinfo))], [])
struct COSERVERINFO
{
    uint        dwReserved1;
    PWSTR       pwszName;
    COAUTHINFO* pAuthInfo;
    uint        dwReserved2;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ns-objidlbase-multi_qi))], [])
struct MULTI_QI
{
    const(GUID)* pIID;
    IUnknown     pItf;
    HRESULT      hr;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-statstg))], [])
struct STATSTG
{
    PWSTR    pwcsName;
    uint     type;
    ulong    cbSize;
    FILETIME mtime;
    FILETIME ctime;
    FILETIME atime;
    STGM     grfMode;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(LOCKTYPE))], [])*/uint grfLocksSupported;
    GUID     clsid;
    uint     grfStateBits;
    uint     reserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ns-objidlbase-rpcolemessage))], [])
struct RPCOLEMESSAGE
{
    void*    reserved1;
    uint     dataRepresentation;
    void*    Buffer;
    uint     cbBuffer;
    uint     iMethod;
    void[5]* reserved2;
    uint     rpcFlags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct SChannelHookCallInfo
{
    GUID  iid;
    uint  cbSize;
    GUID  uCausality;
    uint  dwServerPid;
    uint  iMethod;
    void* pObject;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ns-objidlbase-sole_authentication_service))], [])
struct SOLE_AUTHENTICATION_SERVICE
{
    uint    dwAuthnSvc;
    uint    dwAuthzSvc;
    PWSTR   pPrincipalName;
    HRESULT hr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ns-objidlbase-sole_authentication_info))], [])
struct SOLE_AUTHENTICATION_INFO
{
    uint  dwAuthnSvc;
    uint  dwAuthzSvc;
    void* pAuthInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/ns-objidlbase-sole_authentication_list))], [])
struct SOLE_AUTHENTICATION_LIST
{
    uint cAuthInfo;
    SOLE_AUTHENTICATION_INFO* aAuthInfo;
}

struct ContextProperty
{
    GUID     policyId;
    uint     flags;
    IUnknown pUnk;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-bind_opts))], [])
struct BIND_OPTS
{
    uint cbStruct;
    uint grfFlags;
    uint grfMode;
    uint dwTickCountDeadline;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-bind_opts2~r1))], [])
struct BIND_OPTS2
{
    BIND_OPTS     Base;
    uint          dwTrackFlags;
    uint          dwClassContext;
    uint          locale;
    COSERVERINFO* pServerInfo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-bind_opts3~r1))], [])
struct BIND_OPTS3
{
    BIND_OPTS2 Base;
    HWND       hwnd;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-dvtargetdevice))], [])
struct DVTARGETDEVICE
{
    uint   tdSize;
    ushort tdDriverNameOffset;
    ushort tdDeviceNameOffset;
    ushort tdPortNameOffset;
    ushort tdExtDevmodeOffset;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] tdData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-formatetc))], [])
struct FORMATETC
{
    ushort          cfFormat;
    DVTARGETDEVICE* ptd;
    uint            dwAspect;
    int             lindex;
    uint            tymed;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-statdata))], [])
struct STATDATA
{
    FORMATETC   formatetc;
    uint        advf;
    IAdviseSink pAdvSink;
    uint        dwConnection;
}

struct RemSTGMEDIUM
{
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(TYMED))], [])*/uint tymed;
    uint dwHandleType;
    uint pData;
    uint pUnkForRelease;
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] data;
}

struct STGMEDIUM
{
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(TYMED))], [])*/uint tymed;
union u
    {
        HBITMAP      hBitmap;
        void*        hMetaFilePict;
        HENHMETAFILE hEnhMetaFile;
        HGLOBAL      hGlobal;
        PWSTR        lpszFileName;
        IStream      pstm;
        IStorage     pstg;
    }
    IUnknown pUnkForRelease;
}

struct GDI_OBJECT
{
    uint ObjectType;
union u
    {
        userHBITMAP*  hBitmap;
        userHPALETTE* hPalette;
        userHGLOBAL*  hGeneric;
    }
}

struct userSTGMEDIUM
{
struct u
    {
        uint tymed;
union u
        {
            userHMETAFILEPICT* hMetaFilePict;
            userHENHMETAFILE*  hHEnhMetaFile;
            GDI_OBJECT*        hGdiHandle;
            userHGLOBAL*       hGlobal;
            PWSTR              lpszFileName;
            BYTE_BLOB*         pstm;
            BYTE_BLOB*         pstg;
        }
    }
    IUnknown pUnkForRelease;
}

struct userFLAG_STGMEDIUM
{
    int           ContextFlags;
    int           fPassOwnership;
    userSTGMEDIUM Stgmed;
}

struct FLAG_STGMEDIUM
{
    int       ContextFlags;
    int       fPassOwnership;
    STGMEDIUM Stgmed;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-interfaceinfo))], [])
struct INTERFACEINFO
{
    IUnknown pUnk;
    GUID     iid;
    ushort   wMethod;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/ns-objidl-storagelayout))], [])
struct StorageLayout
{
    uint  LayoutType;
    PWSTR pwcsElementName;
    long  cOffset;
    long  cBytes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/ns-comcat-categoryinfo))], [])
struct CATEGORYINFO
{
    GUID       catid;
    uint       lcid;
    wchar[128] szDescription;
}

struct ComCallData
{
    uint  dwDispid;
    uint  dwReserved;
    void* pUserDefined;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct BINDINFO
{
    uint                cbSize;
    PWSTR               szExtraInfo;
    STGMEDIUM           stgmedData;
    uint                grfBindInfoF;
    uint                dwBindVerb;
    PWSTR               szCustomVerb;
    uint                cbstgmedData;
    uint                dwOptions;
    uint                dwOptionsFlags;
    uint                dwCodePage;
    SECURITY_ATTRIBUTES securityAttributes;
    GUID                iid;
    IUnknown            pUnk;
    uint                dwReserved;
}

struct AUTHENTICATEINFO
{
    uint dwFlags;
    uint dwReserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-safearraybound))], [])
struct SAFEARRAYBOUND
{
    uint cElements;
    int  lLbound;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-safearray))], [])
struct SAFEARRAY
{
    ushort cDims;
    ADVANCED_FEATURE_FLAGS fFeatures;
    uint   cbElements;
    uint   cLocks;
    void*  pvData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SAFEARRAYBOUND[1] rgsabound;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-typedesc))], [])
struct TYPEDESC
{
union Anonymous
    {
        TYPEDESC*  lptdesc;
        ARRAYDESC* lpadesc;
        uint       hreftype;
    }
    VARENUM vt;
}

struct IDLDESC
{
    size_t   dwReserved;
    IDLFLAGS wIDLFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-elemdesc~r1))], [])
struct ELEMDESC
{
    TYPEDESC tdesc;
union Anonymous
    {
        IDLDESC   idldesc;
        PARAMDESC paramdesc;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-typeattr))], [])
struct TYPEATTR
{
    GUID     guid;
    uint     lcid;
    uint     dwReserved;
    int      memidConstructor;
    int      memidDestructor;
    PWSTR    lpstrSchema;
    uint     cbSizeInstance;
    TYPEKIND typekind;
    ushort   cFuncs;
    ushort   cVars;
    ushort   cImplTypes;
    ushort   cbSizeVft;
    ushort   cbAlignment;
    ushort   wTypeFlags;
    ushort   wMajorVerNum;
    ushort   wMinorVerNum;
    TYPEDESC tdescAlias;
    IDLDESC  idldescType;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-dispparams))], [])
struct DISPPARAMS
{
    VARIANT* rgvarg;
    int*     rgdispidNamedArgs;
    uint     cArgs;
    uint     cNamedArgs;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-excepinfo))], [])
struct EXCEPINFO
{
    ushort wCode;
    ushort wReserved;
    BSTR   bstrSource;
    BSTR   bstrDescription;
    BSTR   bstrHelpFile;
    uint   dwHelpContext;
    void*  pvReserved;
    LPEXCEPFINO_DEFERRED_FILLIN pfnDeferredFillIn;
    int    scode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-funcdesc))], [])
struct FUNCDESC
{
    int        memid;
    int*       lprgscode;
    ELEMDESC*  lprgelemdescParam;
    FUNCKIND   funckind;
    INVOKEKIND invkind;
    CALLCONV   callconv;
    short      cParams;
    short      cParamsOpt;
    short      oVft;
    short      cScodes;
    ELEMDESC   elemdescFunc;
    FUNCFLAGS  wFuncFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-vardesc))], [])
struct VARDESC
{
    int      memid;
    PWSTR    lpstrSchema;
union Anonymous
    {
        uint     oInst;
        VARIANT* lpvarValue;
    }
    ELEMDESC elemdescVar;
    VARFLAGS wVarFlags;
    VARKIND  varkind;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-custdataitem))], [])
struct CUSTDATAITEM
{
    GUID    guid;
    VARIANT varValue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-custdata))], [])
struct CUSTDATA
{
    uint          cCustData;
    CUSTDATAITEM* prgCustData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-bindptr))], [])
union BINDPTR
{
    FUNCDESC* lpfuncdesc;
    VARDESC*  lpvardesc;
    ITypeComp lptcomp;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/ns-oaidl-tlibattr))], [])
struct TLIBATTR
{
    GUID    guid;
    uint    lcid;
    SYSKIND syskind;
    ushort  wMajorVerNum;
    ushort  wMinorVerNum;
    ushort  wLibFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/ns-ocidl-connectdata))], [])
struct CONNECTDATA
{
    IUnknown pUnk;
    uint     dwCookie;
}

// Functions

@DllImport("ole32.dll")
uint CoBuildVersion();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-coinitialize))], [])
@DllImport("OLE32.dll")
HRESULT CoInitialize(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-coregistermallocspy))], [])
@DllImport("OLE32.dll")
HRESULT CoRegisterMallocSpy(IMallocSpy pMallocSpy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-corevokemallocspy))], [])
@DllImport("OLE32.dll")
HRESULT CoRevokeMallocSpy();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-coregisterinitializespy))], [])
@DllImport("OLE32.dll")
HRESULT CoRegisterInitializeSpy(IInitializeSpy pSpy, ulong* puliCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-corevokeinitializespy))], [])
@DllImport("OLE32.dll")
HRESULT CoRevokeInitializeSpy(ulong uliCookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-cogetsystemsecuritypermissions))], [])
@DllImport("OLE32.dll")
HRESULT CoGetSystemSecurityPermissions(COMSD comSDType, PSECURITY_DESCRIPTOR* ppSD);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-coloadlibrary))], [])
@DllImport("OLE32.dll")
HINSTANCE CoLoadLibrary(PWSTR lpszLibName, BOOL bAutoFree);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-cofreelibrary))], [])
@DllImport("OLE32.dll")
void CoFreeLibrary(HINSTANCE hInst);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-cofreealllibraries))], [])
@DllImport("OLE32.dll")
void CoFreeAllLibraries();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-coallowsetforegroundwindow))], [])
@DllImport("OLE32.dll")
HRESULT CoAllowSetForegroundWindow(IUnknown pUnk, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpvReserved);

@DllImport("ole32.dll")
HRESULT DcomChannelSetHResult(void* pvReserved, uint* pulReserved, HRESULT appsHR);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-coisole1class))], [])
@DllImport("ole32.dll")
BOOL CoIsOle1Class(const(GUID)* rclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-clsidfromprogidex))], [])
@DllImport("OLE32.dll")
HRESULT CLSIDFromProgIDEx(const(PWSTR) lpszProgID, GUID* lpclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-cofiletimetodosdatetime))], [])
@DllImport("OLE32.dll")
BOOL CoFileTimeToDosDateTime(FILETIME* lpFileTime, ushort* lpDosDate, ushort* lpDosTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-codosdatetimetofiletime))], [])
@DllImport("OLE32.dll")
BOOL CoDosDateTimeToFileTime(ushort nDosDate, ushort nDosTime, FILETIME* lpFileTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cofiletimenow))], [])
@DllImport("OLE32.dll")
HRESULT CoFileTimeNow(FILETIME* lpFileTime);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-coregisterchannelhook))], [])
@DllImport("ole32.dll")
HRESULT CoRegisterChannelHook(const(GUID)* ExtensionUuid, IChannelHook pChannelHook);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-cotreatasclass))], [])
@DllImport("OLE32.dll")
HRESULT CoTreatAsClass(const(GUID)* clsidOld, const(GUID)* clsidNew);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ole2/nf-ole2-createdataadviseholder))], [])
@DllImport("OLE32.dll")
HRESULT CreateDataAdviseHolder(IDataAdviseHolder* ppDAHolder);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-createdatacache))], [])
@DllImport("OLE32.dll")
HRESULT CreateDataCache(IUnknown pUnkOuter, const(GUID)* rclsid, const(GUID)* iid, void** ppv);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-coinstall))], [])
@DllImport("ole32.dll")
HRESULT CoInstall(IBindCtx pbc, uint dwFlags, uCLSSPEC* pClassSpec, QUERYCONTEXT* pQuery, PWSTR pszCodeBase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-bindmoniker))], [])
@DllImport("OLE32.dll")
HRESULT BindMoniker(IMoniker pmk, uint grfOpt, const(GUID)* iidResult, void** ppvResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-cogetobject))], [])
@DllImport("OLE32.dll")
HRESULT CoGetObject(const(PWSTR) pszName, BIND_OPTS* pBindOptions, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-mkparsedisplayname))], [])
@DllImport("OLE32.dll")
HRESULT MkParseDisplayName(IBindCtx pbc, const(PWSTR) szUserName, uint* pchEaten, IMoniker* ppmk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-monikerrelativepathto))], [])
@DllImport("ole32.dll")
HRESULT MonikerRelativePathTo(IMoniker pmkSrc, IMoniker pmkDest, IMoniker* ppmkRelPath, BOOL dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-monikercommonprefixwith))], [])
@DllImport("ole32.dll")
HRESULT MonikerCommonPrefixWith(IMoniker pmkThis, IMoniker pmkOther, IMoniker* ppmkCommon);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-createbindctx))], [])
@DllImport("OLE32.dll")
HRESULT CreateBindCtx(uint reserved, IBindCtx* ppbc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-creategenericcomposite))], [])
@DllImport("OLE32.dll")
HRESULT CreateGenericComposite(IMoniker pmkFirst, IMoniker pmkRest, IMoniker* ppmkComposite);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-getclassfile))], [])
@DllImport("OLE32.dll")
HRESULT GetClassFile(const(PWSTR) szFilename, GUID* pclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-createclassmoniker))], [])
@DllImport("OLE32.dll")
HRESULT CreateClassMoniker(const(GUID)* rclsid, IMoniker* ppmk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-createfilemoniker))], [])
@DllImport("OLE32.dll")
HRESULT CreateFileMoniker(const(PWSTR) lpszPathName, IMoniker* ppmk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-createitemmoniker))], [])
@DllImport("OLE32.dll")
HRESULT CreateItemMoniker(const(PWSTR) lpszDelim, const(PWSTR) lpszItem, IMoniker* ppmk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-createantimoniker))], [])
@DllImport("OLE32.dll")
HRESULT CreateAntiMoniker(IMoniker* ppmk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-createpointermoniker))], [])
@DllImport("OLE32.dll")
HRESULT CreatePointerMoniker(IUnknown punk, IMoniker* ppmk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-createobjrefmoniker))], [])
@DllImport("OLE32.dll")
HRESULT CreateObjrefMoniker(IUnknown punk, IMoniker* ppmk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objbase/nf-objbase-getrunningobjecttable))], [])
@DllImport("OLE32.dll")
HRESULT GetRunningObjectTable(uint reserved, IRunningObjectTable* pprot);

@DllImport("ole32.dll")
HRESULT CreateStdProgressIndicator(HWND hwndParent, const(PWSTR) pszTitle, IBindStatusCallback pIbscCaller, 
                                   IBindStatusCallback* ppIbsc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetmalloc))], [])
@DllImport("OLE32.dll")
HRESULT CoGetMalloc(uint dwMemContext, IMalloc* ppMalloc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-couninitialize))], [])
@DllImport("OLE32.dll")
void CoUninitialize();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetcurrentprocess))], [])
@DllImport("OLE32.dll")
uint CoGetCurrentProcess();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coinitializeex))], [])
@DllImport("OLE32.dll")
HRESULT CoInitializeEx(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved, 
                       /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(COINIT))], [])*/uint dwCoInit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetcallertid))], [])
@DllImport("OLE32.dll")
HRESULT CoGetCallerTID(uint* lpdwTID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetcurrentlogicalthreadid))], [])
@DllImport("OLE32.dll")
HRESULT CoGetCurrentLogicalThreadId(GUID* pguid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetcontexttoken))], [])
@DllImport("OLE32.dll")
HRESULT CoGetContextToken(size_t* pToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetapartmenttype))], [])
@DllImport("OLE32.dll")
HRESULT CoGetApartmentType(APTTYPE* pAptType, APTTYPEQUALIFIER* pAptQualifier);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coincrementmtausage))], [])
@DllImport("OLE32.dll")
HRESULT CoIncrementMTAUsage(CO_MTA_USAGE_COOKIE* pCookie);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-codecrementmtausage))], [])
@DllImport("OLE32.dll")
HRESULT CoDecrementMTAUsage(CO_MTA_USAGE_COOKIE Cookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coallowunmarshalerclsid))], [])
@DllImport("OLE32.dll")
HRESULT CoAllowUnmarshalerCLSID(const(GUID)* clsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetobjectcontext))], [])
@DllImport("OLE32.dll")
HRESULT CoGetObjectContext(const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetclassobject))], [])
@DllImport("OLE32.dll")
HRESULT CoGetClassObject(const(GUID)* rclsid, 
                         /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CLSCTX))], [])*/uint dwClsContext, 
                         void* pvReserved, const(GUID)* riid, void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coregisterclassobject))], [])
@DllImport("OLE32.dll")
HRESULT CoRegisterClassObject(const(GUID)* rclsid, IUnknown pUnk, CLSCTX dwClsContext, 
                              /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(REGCLS))], [])*/uint flags, 
                              uint* lpdwRegister);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-corevokeclassobject))], [])
@DllImport("OLE32.dll")
HRESULT CoRevokeClassObject(uint dwRegister);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coresumeclassobjects))], [])
@DllImport("OLE32.dll")
HRESULT CoResumeClassObjects();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cosuspendclassobjects))], [])
@DllImport("OLE32.dll")
HRESULT CoSuspendClassObjects();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coaddrefserverprocess))], [])
@DllImport("OLE32.dll")
uint CoAddRefServerProcess();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coreleaseserverprocess))], [])
@DllImport("OLE32.dll")
uint CoReleaseServerProcess();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetpsclsid))], [])
@DllImport("OLE32.dll")
HRESULT CoGetPSClsid(const(GUID)* riid, GUID* pClsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coregisterpsclsid))], [])
@DllImport("OLE32.dll")
HRESULT CoRegisterPSClsid(const(GUID)* riid, const(GUID)* rclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coregistersurrogate))], [])
@DllImport("OLE32.dll")
HRESULT CoRegisterSurrogate(ISurrogate pSurrogate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-codisconnectobject))], [])
@DllImport("OLE32.dll")
HRESULT CoDisconnectObject(IUnknown pUnk, 
                           /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-colockobjectexternal))], [])
@DllImport("OLE32.dll")
HRESULT CoLockObjectExternal(IUnknown pUnk, BOOL fLock, BOOL fLastUnlockReleases);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coishandlerconnected))], [])
@DllImport("OLE32.dll")
BOOL CoIsHandlerConnected(IUnknown pUnk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cocreatefreethreadedmarshaler))], [])
@DllImport("OLE32.dll")
HRESULT CoCreateFreeThreadedMarshaler(IUnknown punkOuter, IUnknown* ppunkMarshal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cofreeunusedlibraries))], [])
@DllImport("OLE32.dll")
void CoFreeUnusedLibraries();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cofreeunusedlibrariesex))], [])
@DllImport("OLE32.dll")
void CoFreeUnusedLibrariesEx(uint dwUnloadDelay, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-codisconnectcontext))], [])
@DllImport("OLE32.dll")
HRESULT CoDisconnectContext(uint dwTimeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coinitializesecurity))], [])
@DllImport("OLE32.dll")
HRESULT CoInitializeSecurity(PSECURITY_DESCRIPTOR pSecDesc, int cAuthSvc, SOLE_AUTHENTICATION_SERVICE* asAuthSvc, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved1, 
                             RPC_C_AUTHN_LEVEL dwAuthnLevel, RPC_C_IMP_LEVEL dwImpLevel, void* pAuthList, 
                             /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EOLE_AUTHENTICATION_CAPABILITIES))], [])*/uint dwCapabilities, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved3);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetcallcontext))], [])
@DllImport("OLE32.dll")
HRESULT CoGetCallContext(const(GUID)* riid, void** ppInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coqueryproxyblanket))], [])
@DllImport("OLE32.dll")
HRESULT CoQueryProxyBlanket(IUnknown pProxy, uint* pwAuthnSvc, uint* pAuthzSvc, PWSTR* pServerPrincName, 
                            uint* pAuthnLevel, uint* pImpLevel, void** pAuthInfo, uint* pCapabilites);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cosetproxyblanket))], [])
@DllImport("OLE32.dll")
HRESULT CoSetProxyBlanket(IUnknown pProxy, uint dwAuthnSvc, uint dwAuthzSvc, PWSTR pServerPrincName, 
                          RPC_C_AUTHN_LEVEL dwAuthnLevel, RPC_C_IMP_LEVEL dwImpLevel, void* pAuthInfo, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EOLE_AUTHENTICATION_CAPABILITIES))], [])*/uint dwCapabilities);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cocopyproxy))], [])
@DllImport("OLE32.dll")
HRESULT CoCopyProxy(IUnknown pProxy, IUnknown* ppCopy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coqueryclientblanket))], [])
@DllImport("OLE32.dll")
HRESULT CoQueryClientBlanket(uint* pAuthnSvc, uint* pAuthzSvc, PWSTR* pServerPrincName, uint* pAuthnLevel, 
                             uint* pImpLevel, void** pPrivs, uint* pCapabilities);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coimpersonateclient))], [])
@DllImport("OLE32.dll")
HRESULT CoImpersonateClient();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coreverttoself))], [])
@DllImport("OLE32.dll")
HRESULT CoRevertToSelf();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coqueryauthenticationservices))], [])
@DllImport("OLE32.dll")
HRESULT CoQueryAuthenticationServices(uint* pcAuthSvc, SOLE_AUTHENTICATION_SERVICE** asAuthSvc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coswitchcallcontext))], [])
@DllImport("OLE32.dll")
HRESULT CoSwitchCallContext(IUnknown pNewObject, IUnknown* ppOldObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cocreateinstance))], [])
@DllImport("OLE32.dll")
HRESULT CoCreateInstance(const(GUID)* rclsid, IUnknown pUnkOuter, CLSCTX dwClsContext, const(GUID)* riid, 
                         void** ppv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cocreateinstanceex))], [])
@DllImport("OLE32.dll")
HRESULT CoCreateInstanceEx(const(GUID)* Clsid, IUnknown punkOuter, CLSCTX dwClsCtx, COSERVERINFO* pServerInfo, 
                           uint dwCount, MULTI_QI* pResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cocreateinstancefromapp))], [])
@DllImport("OLE32.dll")
HRESULT CoCreateInstanceFromApp(const(GUID)* Clsid, IUnknown punkOuter, CLSCTX dwClsCtx, void* reserved, 
                                uint dwCount, MULTI_QI* pResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coregisteractivationfilter))], [])
@DllImport("OLE32.dll")
HRESULT CoRegisterActivationFilter(IActivationFilter pActivationFilter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogetcancelobject))], [])
@DllImport("OLE32.dll")
HRESULT CoGetCancelObject(uint dwThreadId, const(GUID)* iid, void** ppUnk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cosetcancelobject))], [])
@DllImport("OLE32.dll")
HRESULT CoSetCancelObject(IUnknown pUnk);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cocancelcall))], [])
@DllImport("OLE32.dll")
HRESULT CoCancelCall(uint dwThreadId, uint ulTimeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cotestcancel))], [])
@DllImport("OLE32.dll")
HRESULT CoTestCancel();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coenablecallcancellation))], [])
@DllImport("OLE32.dll")
HRESULT CoEnableCallCancellation(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-codisablecallcancellation))], [])
@DllImport("OLE32.dll")
HRESULT CoDisableCallCancellation(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-stringfromclsid))], [])
@DllImport("OLE32.dll")
HRESULT StringFromCLSID(const(GUID)* rclsid, PWSTR* lplpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-clsidfromstring))], [])
@DllImport("OLE32.dll")
HRESULT CLSIDFromString(const(PWSTR) lpsz, GUID* pclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-stringfromiid))], [])
@DllImport("OLE32.dll")
HRESULT StringFromIID(const(GUID)* rclsid, PWSTR* lplpsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-iidfromstring))], [])
@DllImport("OLE32.dll")
HRESULT IIDFromString(const(PWSTR) lpsz, GUID* lpiid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-progidfromclsid))], [])
@DllImport("OLE32.dll")
HRESULT ProgIDFromCLSID(const(GUID)* clsid, PWSTR* lplpszProgID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-clsidfromprogid))], [])
@DllImport("OLE32.dll")
HRESULT CLSIDFromProgID(const(PWSTR) lpszProgID, GUID* lpclsid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-stringfromguid2))], [])
@DllImport("OLE32.dll")
int StringFromGUID2(const(GUID)* rguid, PWSTR lpsz, int cchMax);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cocreateguid))], [])
@DllImport("OLE32.dll")
HRESULT CoCreateGuid(GUID* pguid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cowaitformultiplehandles))], [])
@DllImport("OLE32.dll")
HRESULT CoWaitForMultipleHandles(uint dwFlags, uint dwTimeout, uint cHandles, HANDLE* pHandles, uint* lpdwindex);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cowaitformultipleobjects))], [])
@DllImport("OLE32.dll")
HRESULT CoWaitForMultipleObjects(uint dwFlags, uint dwTimeout, uint cHandles, const(HANDLE)* pHandles, 
                                 uint* lpdwindex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cogettreatasclass))], [])
@DllImport("OLE32.dll")
HRESULT CoGetTreatAsClass(const(GUID)* clsidOld, GUID* pClsidNew);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coinvalidateremotemachinebindings))], [])
@DllImport("OLE32.dll")
HRESULT CoInvalidateRemoteMachineBindings(PWSTR pszMachineName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cotaskmemalloc))], [])
@DllImport("OLE32.dll")
void* CoTaskMemAlloc(size_t cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cotaskmemrealloc))], [])
@DllImport("OLE32.dll")
void* CoTaskMemRealloc(void* pv, size_t cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-cotaskmemfree))], [])
@DllImport("OLE32.dll")
void CoTaskMemFree(void* pv);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-coregisterdevicecatalog))], [])
@DllImport("OLE32.dll")
HRESULT CoRegisterDeviceCatalog(const(PWSTR) deviceInstanceId, CO_DEVICE_CATALOG_COOKIE* cookie);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/combaseapi/nf-combaseapi-corevokedevicecatalog))], [])
@DllImport("OLE32.dll")
HRESULT CoRevokeDeviceCatalog(CO_DEVICE_CATALOG_COOKIE cookie);

@DllImport("URLMON.dll")
HRESULT CreateUri(const(PWSTR) pwzURI, URI_CREATE_FLAGS dwFlags, 
                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/size_t dwReserved, IUri* ppURI);

@DllImport("URLMON.dll")
HRESULT CreateUriWithFragment(const(PWSTR) pwzURI, const(PWSTR) pwzFragment, uint dwFlags, 
                              /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/size_t dwReserved, 
                              IUri* ppURI);

@DllImport("urlmon.dll")
HRESULT CreateUriFromMultiByteString(const(PSTR) pszANSIInputUri, uint dwEncodingFlags, uint dwCodePage, 
                                     uint dwCreateFlags, 
                                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/size_t dwReserved, 
                                     IUri* ppUri);

@DllImport("URLMON.dll")
HRESULT CreateIUriBuilder(IUri pIUri, uint dwFlags, size_t dwReserved, IUriBuilder* ppIUriBuilder);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-seterrorinfo))], [])
@DllImport("OLEAUT32.dll")
HRESULT SetErrorInfo(uint dwReserved, IErrorInfo perrinfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-geterrorinfo))], [])
@DllImport("OLEAUT32.dll")
HRESULT GetErrorInfo(uint dwReserved, IErrorInfo* pperrinfo);


// Interfaces

@GUID("00000000-0000-0000-c000-000000000046")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/unknwn/nn-unknwn-iunknown))], [])
interface IUnknown
{
//METH ATTR: CanReturnErrorsAsSuccessAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/unknwn/nf-unknwn-iunknown-queryinterface(refiid_void)))], [])
    HRESULT QueryInterface(const(GUID)* riid, void** ppvObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/unknwn/nf-unknwn-iunknown-addref))], [])
    uint    AddRef();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/unknwn/nf-unknwn-iunknown-release))], [])
    uint    Release();
}

@GUID("000e0000-0000-0000-c000-000000000046")
interface AsyncIUnknown : IUnknown
{
    HRESULT Begin_QueryInterface(const(GUID)* riid);
    HRESULT Finish_QueryInterface(void** ppvObject);
    HRESULT Begin_AddRef();
    uint    Finish_AddRef();
    HRESULT Begin_Release();
    uint    Finish_Release();
}

@GUID("00000001-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/unknwn/nn-unknwn-iclassfactory))], [])
interface IClassFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/unknwn/nf-unknwn-iclassfactory-createinstance))], [])
    HRESULT CreateInstance(IUnknown pUnkOuter, const(GUID)* riid, void** ppvObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/unknwn/nf-unknwn-iclassfactory-lockserver))], [])
    HRESULT LockServer(BOOL fLock);
}

@GUID("ecc8691b-c1db-4dc0-855e-65f6c551af49")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-inomarshal))], [])
interface INoMarshal : IUnknown
{
}

@GUID("94ea2b94-e9cc-49e0-c0ff-ee64ca8f5b90")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-iagileobject))], [])
interface IAgileObject : IUnknown
{
}

@GUID("00000017-0000-0000-c000-000000000046")
interface IActivationFilter : IUnknown
{
    HRESULT HandleActivation(uint dwActivationType, const(GUID)* rclsid, GUID* pReplacementClsId);
}

@GUID("00000002-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-imalloc))], [])
interface IMalloc : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imalloc-alloc))], [])
    void*  Alloc(size_t cb);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imalloc-realloc))], [])
    void*  Realloc(void* pv, size_t cb);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imalloc-free))], [])
    void   Free(void* pv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imalloc-getsize))], [])
    size_t GetSize(void* pv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imalloc-didalloc))], [])
    int    DidAlloc(void* pv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imalloc-heapminimize))], [])
    void   HeapMinimize();
}

@GUID("00000018-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-istdmarshalinfo))], [])
interface IStdMarshalInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-istdmarshalinfo-getclassforhandler))], [])
    HRESULT GetClassForHandler(uint dwDestContext, 
                               /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvDestContext, 
                               GUID* pClsid);
}

@GUID("00000019-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-iexternalconnection))], [])
interface IExternalConnection : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iexternalconnection-addconnection))], [])
    uint AddConnection(uint extconn, uint reserved);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iexternalconnection-releaseconnection))], [])
    uint ReleaseConnection(uint extconn, uint reserved, BOOL fLastReleaseCloses);
}

@GUID("00000020-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-imultiqi))], [])
interface IMultiQI : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-imultiqi-querymultipleinterfaces))], [])
    HRESULT QueryMultipleInterfaces(uint cMQIs, MULTI_QI* pMQIs);
}

@GUID("000e0020-0000-0000-c000-000000000046")
interface AsyncIMultiQI : IUnknown
{
    HRESULT Begin_QueryMultipleInterfaces(uint cMQIs, MULTI_QI* pMQIs);
    HRESULT Finish_QueryMultipleInterfaces(MULTI_QI* pMQIs);
}

@GUID("00000021-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-iinternalunknown))], [])
interface IInternalUnknown : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iinternalunknown-queryinternalinterface))], [])
    HRESULT QueryInternalInterface(const(GUID)* riid, void** ppv);
}

@GUID("00000100-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-ienumunknown))], [])
interface IEnumUnknown : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumunknown-next))], [])
    HRESULT Next(uint celt, IUnknown* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumunknown-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumunknown-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumunknown-clone))], [])
    HRESULT Clone(IEnumUnknown* ppenum);
}

@GUID("00000101-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-ienumstring))], [])
interface IEnumString : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumstring-next))], [])
    HRESULT Next(uint celt, PWSTR* rgelt, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumstring-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumstring-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumstring-clone))], [])
    HRESULT Clone(IEnumString* ppenum);
}

@GUID("0c733a30-2a1c-11ce-ade5-00aa0044773d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-isequentialstream))], [])
interface ISequentialStream : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-isequentialstream-read))], [])
    HRESULT Read(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pv, 
                 uint cb, uint* pcbRead);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-isequentialstream-write))], [])
    HRESULT Write(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pv, 
                  uint cb, uint* pcbWritten);
}

@GUID("0000000c-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-istream))], [])
interface IStream : ISequentialStream
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istream-seek))], [])
    HRESULT Seek(long dlibMove, STREAM_SEEK dwOrigin, ulong* plibNewPosition);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istream-setsize))], [])
    HRESULT SetSize(ulong libNewSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istream-copyto))], [])
    HRESULT CopyTo(IStream pstm, ulong cb, ulong* pcbRead, ulong* pcbWritten);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istream-commit))], [])
    HRESULT Commit(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(STGC))], [])*/uint grfCommitFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istream-revert))], [])
    HRESULT Revert();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istream-lockregion))], [])
    HRESULT LockRegion(ulong libOffset, ulong cb, 
                       /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(LOCKTYPE))], [])*/uint dwLockType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istream-unlockregion))], [])
    HRESULT UnlockRegion(ulong libOffset, ulong cb, uint dwLockType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istream-stat))], [])
    HRESULT Stat(STATSTG* pstatstg, 
                 /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(STATFLAG))], [])*/uint grfStatFlag);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-istream-clone))], [])
    HRESULT Clone(IStream* ppstm);
}

@GUID("d5f56b60-593b-101a-b569-08002b2dbf7a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-irpcchannelbuffer))], [])
interface IRpcChannelBuffer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcchannelbuffer-getbuffer))], [])
    HRESULT GetBuffer(RPCOLEMESSAGE* pMessage, const(GUID)* riid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcchannelbuffer-sendreceive))], [])
    HRESULT SendReceive(RPCOLEMESSAGE* pMessage, uint* pStatus);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcchannelbuffer-freebuffer))], [])
    HRESULT FreeBuffer(RPCOLEMESSAGE* pMessage);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcchannelbuffer-getdestctx))], [])
    HRESULT GetDestCtx(uint* pdwDestContext, void** ppvDestContext);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcchannelbuffer-isconnected))], [])
    HRESULT IsConnected();
}

@GUID("594f31d0-7f19-11d0-b194-00a0c90dc8bf")
interface IRpcChannelBuffer2 : IRpcChannelBuffer
{
    HRESULT GetProtocolVersion(uint* pdwVersion);
}

@GUID("a5029fb6-3c34-11d1-9c99-00c04fb998aa")
interface IAsyncRpcChannelBuffer : IRpcChannelBuffer2
{
    HRESULT Send(RPCOLEMESSAGE* pMsg, ISynchronize pSync, uint* pulStatus);
    HRESULT Receive(RPCOLEMESSAGE* pMsg, uint* pulStatus);
    HRESULT GetDestCtxEx(RPCOLEMESSAGE* pMsg, uint* pdwDestContext, void** ppvDestContext);
}

@GUID("25b15600-0115-11d0-bf0d-00aa00b8dfd2")
interface IRpcChannelBuffer3 : IRpcChannelBuffer2
{
    HRESULT Send(RPCOLEMESSAGE* pMsg, uint* pulStatus);
    HRESULT Receive(RPCOLEMESSAGE* pMsg, uint ulSize, uint* pulStatus);
    HRESULT Cancel(RPCOLEMESSAGE* pMsg);
    HRESULT GetCallContext(RPCOLEMESSAGE* pMsg, const(GUID)* riid, void** pInterface);
    HRESULT GetDestCtxEx(RPCOLEMESSAGE* pMsg, uint* pdwDestContext, void** ppvDestContext);
    HRESULT GetState(RPCOLEMESSAGE* pMsg, uint* pState);
    HRESULT RegisterAsync(RPCOLEMESSAGE* pMsg, IAsyncManager pAsyncMgr);
}

@GUID("58a08519-24c8-4935-b482-3fd823333a4f")
interface IRpcSyntaxNegotiate : IUnknown
{
    HRESULT NegotiateSyntax(RPCOLEMESSAGE* pMsg);
}

@GUID("d5f56a34-593b-101a-b569-08002b2dbf7a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-irpcproxybuffer))], [])
interface IRpcProxyBuffer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcproxybuffer-connect))], [])
    HRESULT Connect(IRpcChannelBuffer pRpcChannelBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcproxybuffer-disconnect))], [])
    void    Disconnect();
}

@GUID("d5f56afc-593b-101a-b569-08002b2dbf7a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-irpcstubbuffer))], [])
interface IRpcStubBuffer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcstubbuffer-connect))], [])
    HRESULT Connect(IUnknown pUnkServer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcstubbuffer-disconnect))], [])
    void    Disconnect();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcstubbuffer-invoke))], [])
    HRESULT Invoke(RPCOLEMESSAGE* _prpcmsg, IRpcChannelBuffer _pRpcChannelBuffer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcstubbuffer-isiidsupported))], [])
    IRpcStubBuffer IsIIDSupported(const(GUID)* riid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcstubbuffer-countrefs))], [])
    uint    CountRefs();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcstubbuffer-debugserverqueryinterface))], [])
    HRESULT DebugServerQueryInterface(void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcstubbuffer-debugserverrelease))], [])
    void    DebugServerRelease(void* pv);
}

@GUID("d5f569d0-593b-101a-b569-08002b2dbf7a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-ipsfactorybuffer))], [])
interface IPSFactoryBuffer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ipsfactorybuffer-createproxy))], [])
    HRESULT CreateProxy(IUnknown pUnkOuter, const(GUID)* riid, IRpcProxyBuffer* ppProxy, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ipsfactorybuffer-createstub))], [])
    HRESULT CreateStub(const(GUID)* riid, IUnknown pUnkServer, IRpcStubBuffer* ppStub);
}

@GUID("1008c4a0-7613-11cf-9af1-0020af6e72f4")
interface IChannelHook : IUnknown
{
    void ClientGetSize(const(GUID)* uExtent, const(GUID)* riid, uint* pDataSize);
    void ClientFillBuffer(const(GUID)* uExtent, const(GUID)* riid, uint* pDataSize, void* pDataBuffer);
    void ClientNotify(const(GUID)* uExtent, const(GUID)* riid, uint cbDataSize, void* pDataBuffer, uint lDataRep, 
                      HRESULT hrFault);
    void ServerNotify(const(GUID)* uExtent, const(GUID)* riid, uint cbDataSize, void* pDataBuffer, uint lDataRep);
    void ServerGetSize(const(GUID)* uExtent, const(GUID)* riid, HRESULT hrFault, uint* pDataSize);
    void ServerFillBuffer(const(GUID)* uExtent, const(GUID)* riid, uint* pDataSize, void* pDataBuffer, 
                          HRESULT hrFault);
}

@GUID("0000013d-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iclientsecurity))], [])
interface IClientSecurity : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iclientsecurity-queryblanket))], [])
    HRESULT QueryBlanket(IUnknown pProxy, uint* pAuthnSvc, uint* pAuthzSvc, ushort** pServerPrincName, 
                         RPC_C_AUTHN_LEVEL* pAuthnLevel, RPC_C_IMP_LEVEL* pImpLevel, void** pAuthInfo, 
                         /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EOLE_AUTHENTICATION_CAPABILITIES))], [])*/uint* pCapabilites);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iclientsecurity-setblanket))], [])
    HRESULT SetBlanket(IUnknown pProxy, uint dwAuthnSvc, uint dwAuthzSvc, PWSTR pServerPrincName, 
                       RPC_C_AUTHN_LEVEL dwAuthnLevel, RPC_C_IMP_LEVEL dwImpLevel, void* pAuthInfo, 
                       /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EOLE_AUTHENTICATION_CAPABILITIES))], [])*/uint dwCapabilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iclientsecurity-copyproxy))], [])
    HRESULT CopyProxy(IUnknown pProxy, IUnknown* ppCopy);
}

@GUID("0000013e-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-iserversecurity))], [])
interface IServerSecurity : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iserversecurity-queryblanket))], [])
    HRESULT QueryBlanket(uint* pAuthnSvc, uint* pAuthzSvc, ushort** pServerPrincName, uint* pAuthnLevel, 
                         uint* pImpLevel, void** pPrivs, uint* pCapabilities);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iserversecurity-impersonateclient))], [])
    HRESULT ImpersonateClient();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iserversecurity-reverttoself))], [])
    HRESULT RevertToSelf();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iserversecurity-isimpersonating))], [])
    BOOL    IsImpersonating();
}

@GUID("00000144-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-irpcoptions))], [])
interface IRpcOptions : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcoptions-set))], [])
    HRESULT Set(IUnknown pPrx, RPCOPT_PROPERTIES dwProperty, size_t dwValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-irpcoptions-query))], [])
    HRESULT Query(IUnknown pPrx, RPCOPT_PROPERTIES dwProperty, size_t* pdwValue);
}

@GUID("0000015b-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-iglobaloptions))], [])
interface IGlobalOptions : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iglobaloptions-set))], [])
    HRESULT Set(GLOBALOPT_PROPERTIES dwProperty, size_t dwValue);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iglobaloptions-query))], [])
    HRESULT Query(GLOBALOPT_PROPERTIES dwProperty, size_t* pdwValue);
}

@GUID("00000022-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-isurrogate))], [])
interface ISurrogate : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-isurrogate-loaddllserver))], [])
    HRESULT LoadDllServer(const(GUID)* Clsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-isurrogate-freesurrogate))], [])
    HRESULT FreeSurrogate();
}

@GUID("00000146-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iglobalinterfacetable))], [])
interface IGlobalInterfaceTable : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iglobalinterfacetable-registerinterfaceinglobal))], [])
    HRESULT RegisterInterfaceInGlobal(IUnknown pUnk, const(GUID)* riid, uint* pdwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iglobalinterfacetable-revokeinterfacefromglobal))], [])
    HRESULT RevokeInterfaceFromGlobal(uint dwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iglobalinterfacetable-getinterfacefromglobal))], [])
    HRESULT GetInterfaceFromGlobal(uint dwCookie, const(GUID)* riid, void** ppv);
}

@GUID("00000030-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-isynchronize))], [])
interface ISynchronize : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-isynchronize-wait))], [])
    HRESULT Wait(uint dwFlags, uint dwMilliseconds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-isynchronize-signal))], [])
    HRESULT Signal();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-isynchronize-reset))], [])
    HRESULT Reset();
}

@GUID("00000031-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-isynchronizehandle))], [])
interface ISynchronizeHandle : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-isynchronizehandle-gethandle))], [])
    HRESULT GetHandle(HANDLE* ph);
}

@GUID("00000032-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-isynchronizeevent))], [])
interface ISynchronizeEvent : ISynchronizeHandle
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-isynchronizeevent-seteventhandle))], [])
    HRESULT SetEventHandle(HANDLE* ph);
}

@GUID("00000033-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-isynchronizecontainer))], [])
interface ISynchronizeContainer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-isynchronizecontainer-addsynchronize))], [])
    HRESULT AddSynchronize(ISynchronize pSync);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-isynchronizecontainer-waitmultiple))], [])
    HRESULT WaitMultiple(uint dwFlags, uint dwTimeOut, ISynchronize* ppSync);
}

@GUID("00000025-0000-0000-c000-000000000046")
interface ISynchronizeMutex : ISynchronize
{
    HRESULT ReleaseMutex();
}

@GUID("00000029-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-icancelmethodcalls))], [])
interface ICancelMethodCalls : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icancelmethodcalls-cancel))], [])
    HRESULT Cancel(uint ulSeconds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icancelmethodcalls-testcancel))], [])
    HRESULT TestCancel();
}

@GUID("0000002a-0000-0000-c000-000000000046")
interface IAsyncManager : IUnknown
{
    HRESULT CompleteCall(HRESULT Result);
    HRESULT GetCallContext(const(GUID)* riid, void** pInterface);
    HRESULT GetState(uint* pulStateFlags);
}

@GUID("1c733a30-2a1c-11ce-ade5-00aa0044773d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-icallfactory))], [])
interface ICallFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icallfactory-createcall))], [])
    HRESULT CreateCall(const(GUID)* riid, IUnknown pCtrlUnk, const(GUID)* riid2, IUnknown* ppv);
}

@GUID("00000149-0000-0000-c000-000000000046")
interface IRpcHelper : IUnknown
{
    HRESULT GetDCOMProtocolVersion(uint* pComVersion);
    HRESULT GetIIDFromOBJREF(void* pObjRef, GUID** piid);
}

@GUID("eb0cb9e8-7996-11d2-872e-0000f8080859")
interface IReleaseMarshalBuffers : IUnknown
{
    HRESULT ReleaseMarshalBuffer(RPCOLEMESSAGE* pMsg, uint dwFlags, IUnknown pChnl);
}

@GUID("0000002b-0000-0000-c000-000000000046")
interface IWaitMultiple : IUnknown
{
    HRESULT WaitMultiple(uint timeout, ISynchronize* pSync);
    HRESULT AddSynchronize(ISynchronize pSync);
}

@GUID("00000147-0000-0000-c000-000000000046")
interface IAddrTrackingControl : IUnknown
{
    HRESULT EnableCOMDynamicAddrTracking();
    HRESULT DisableCOMDynamicAddrTracking();
}

@GUID("00000148-0000-0000-c000-000000000046")
interface IAddrExclusionControl : IUnknown
{
    HRESULT GetCurrentAddrExclusionList(const(GUID)* riid, void** ppEnumerator);
    HRESULT UpdateAddrExclusionList(IUnknown pEnumerator);
}

@GUID("db2f3aca-2f86-11d1-8e04-00c04fb9989a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-ipipebyte))], [])
interface IPipeByte : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ipipebyte-pull))], [])
    HRESULT Pull(ubyte* buf, uint cRequest, uint* pcReturned);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ipipebyte-push))], [])
    HRESULT Push(ubyte* buf, uint cSent);
}

@GUID("db2f3acb-2f86-11d1-8e04-00c04fb9989a")
interface AsyncIPipeByte : IUnknown
{
    HRESULT Begin_Pull(uint cRequest);
    HRESULT Finish_Pull(ubyte* buf, uint* pcReturned);
    HRESULT Begin_Push(ubyte* buf, uint cSent);
    HRESULT Finish_Push();
}

@GUID("db2f3acc-2f86-11d1-8e04-00c04fb9989a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-ipipelong))], [])
interface IPipeLong : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ipipelong-pull))], [])
    HRESULT Pull(int* buf, uint cRequest, uint* pcReturned);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ipipelong-push))], [])
    HRESULT Push(int* buf, uint cSent);
}

@GUID("db2f3acd-2f86-11d1-8e04-00c04fb9989a")
interface AsyncIPipeLong : IUnknown
{
    HRESULT Begin_Pull(uint cRequest);
    HRESULT Finish_Pull(int* buf, uint* pcReturned);
    HRESULT Begin_Push(int* buf, uint cSent);
    HRESULT Finish_Push();
}

@GUID("db2f3ace-2f86-11d1-8e04-00c04fb9989a")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-ipipedouble))], [])
interface IPipeDouble : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ipipedouble-pull))], [])
    HRESULT Pull(double* buf, uint cRequest, uint* pcReturned);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ipipedouble-push))], [])
    HRESULT Push(double* buf, uint cSent);
}

@GUID("db2f3acf-2f86-11d1-8e04-00c04fb9989a")
interface AsyncIPipeDouble : IUnknown
{
    HRESULT Begin_Pull(uint cRequest);
    HRESULT Finish_Pull(double* buf, uint* pcReturned);
    HRESULT Begin_Push(double* buf, uint cSent);
    HRESULT Finish_Push();
}

@GUID("000001c1-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-ienumcontextprops))], [])
interface IEnumContextProps : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumcontextprops-next))], [])
    HRESULT Next(uint celt, ContextProperty* pContextProperties, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumcontextprops-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumcontextprops-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumcontextprops-clone))], [])
    HRESULT Clone(IEnumContextProps* ppEnumContextProps);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-ienumcontextprops-count))], [])
    HRESULT Count(uint* pcelt);
}

@GUID("000001c0-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-icontext))], [])
interface IContext : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icontext-setproperty))], [])
    HRESULT SetProperty(const(GUID)* rpolicyId, uint flags, IUnknown pUnk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icontext-removeproperty))], [])
    HRESULT RemoveProperty(const(GUID)* rPolicyId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icontext-getproperty))], [])
    HRESULT GetProperty(const(GUID)* rGuid, uint* pFlags, IUnknown* ppUnk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icontext-enumcontextprops))], [])
    HRESULT EnumContextProps(IEnumContextProps* ppEnumContextProps);
}

@GUID("000001ce-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-icomthreadinginfo))], [])
interface IComThreadingInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icomthreadinginfo-getcurrentapartmenttype))], [])
    HRESULT GetCurrentApartmentType(APTTYPE* pAptType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icomthreadinginfo-getcurrentthreadtype))], [])
    HRESULT GetCurrentThreadType(THDTYPE* pThreadType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icomthreadinginfo-getcurrentlogicalthreadid))], [])
    HRESULT GetCurrentLogicalThreadId(GUID* pguidLogicalThreadId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-icomthreadinginfo-setcurrentlogicalthreadid))], [])
    HRESULT SetCurrentLogicalThreadId(const(GUID)* rguid);
}

@GUID("72380d55-8d2b-43a3-8513-2b6ef31434e9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-iprocessinitcontrol))], [])
interface IProcessInitControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nf-objidlbase-iprocessinitcontrol-resetinitializertimeout))], [])
    HRESULT ResetInitializerTimeout(uint dwSecondsRemaining);
}

@GUID("00000040-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidlbase/nn-objidlbase-ifastrundown))], [])
interface IFastRundown : IUnknown
{
}

@GUID("26d709ac-f70b-4421-a96f-d2878fafb00d")
interface IMachineGlobalObjectTable : IUnknown
{
    HRESULT RegisterObject(const(GUID)* clsid, const(PWSTR) identifier, IUnknown object, 
                           MachineGlobalObjectTableRegistrationToken* token);
    HRESULT GetObject(const(GUID)* clsid, const(PWSTR) identifier, const(GUID)* riid, void** ppv);
    HRESULT RevokeObject(MachineGlobalObjectTableRegistrationToken token);
}

@GUID("e9956ef2-3828-4b4b-8fa9-7db61dee4954")
interface ISupportAllowLowerTrustActivation : IUnknown
{
}

@GUID("0a18aae5-5caa-48c5-a9f4-6e46dcd58ad5")
interface ISupportActivationFromPackage : IUnknown
{
}

@GUID("c8059efc-4e98-4fd0-bfc6-44190b80b823")
interface ISupportCoAddComDependencyOnPackage : IUnknown
{
}

@GUID("5bdb3ee2-46bc-4313-b5fb-801c360ba5f9")
interface ISupportServerMustBeEqualOrGreaterPrivilegeActivation : IUnknown
{
}

@GUID("40aefe22-3ff6-43dc-8108-c8c402d57b5c")
interface ISupportDoNotElevateServerActivation : IUnknown
{
}

@GUID("765d1df2-f0af-4ef8-aa50-84789ca330ed")
interface ISupportActivateAsActivatorPackaged : IUnknown
{
}

@GUID("8dc3444e-c7ee-449a-9fb8-b9173988d66a")
interface ISupportPackagedComRegistrationVisibility : IUnknown
{
}

@GUID("b4219019-f712-4d4f-ade7-f468276af0b8")
interface ISupportPackagedComElevationEnabledClasses : IUnknown
{
}

@GUID("8f146474-b228-48fb-a58c-105ebb273abc")
interface IPackagedComSyntaxSupport : IUnknown
{
    HRESULT GetSupportedVersion(uint* supportedVersion);
}

@GUID("0000001d-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-imallocspy))], [])
interface IMallocSpy : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-prealloc))], [])
    size_t PreAlloc(size_t cbRequest);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-postalloc))], [])
    void*  PostAlloc(void* pActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-prefree))], [])
    void*  PreFree(void* pRequest, BOOL fSpyed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-postfree))], [])
    void   PostFree(BOOL fSpyed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-prerealloc))], [])
    size_t PreRealloc(void* pRequest, size_t cbRequest, void** ppNewRequest, BOOL fSpyed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-postrealloc))], [])
    void*  PostRealloc(void* pActual, BOOL fSpyed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-pregetsize))], [])
    void*  PreGetSize(void* pRequest, BOOL fSpyed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-postgetsize))], [])
    size_t PostGetSize(size_t cbActual, BOOL fSpyed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-predidalloc))], [])
    void*  PreDidAlloc(void* pRequest, BOOL fSpyed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-postdidalloc))], [])
    int    PostDidAlloc(void* pRequest, BOOL fSpyed, int fActual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-preheapminimize))], [])
    void   PreHeapMinimize();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imallocspy-postheapminimize))], [])
    void   PostHeapMinimize();
}

@GUID("0000000e-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ibindctx))], [])
interface IBindCtx : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-registerobjectbound))], [])
    HRESULT RegisterObjectBound(IUnknown punk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-revokeobjectbound))], [])
    HRESULT RevokeObjectBound(IUnknown punk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-releaseboundobjects))], [])
    HRESULT ReleaseBoundObjects();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-setbindoptions))], [])
    HRESULT SetBindOptions(BIND_OPTS* pbindopts);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-getbindoptions))], [])
    HRESULT GetBindOptions(BIND_OPTS* pbindopts);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-getrunningobjecttable))], [])
    HRESULT GetRunningObjectTable(IRunningObjectTable* pprot);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-registerobjectparam))], [])
    HRESULT RegisterObjectParam(PWSTR pszKey, IUnknown punk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-getobjectparam))], [])
    HRESULT GetObjectParam(PWSTR pszKey, IUnknown* ppunk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-enumobjectparam))], [])
    HRESULT EnumObjectParam(IEnumString* ppenum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ibindctx-revokeobjectparam))], [])
    HRESULT RevokeObjectParam(PWSTR pszKey);
}

@GUID("00000102-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ienummoniker))], [])
interface IEnumMoniker : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienummoniker-next))], [])
    HRESULT Next(uint celt, IMoniker* rgelt, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienummoniker-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienummoniker-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienummoniker-clone))], [])
    HRESULT Clone(IEnumMoniker* ppenum);
}

@GUID("00000126-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-irunnableobject))], [])
interface IRunnableObject : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunnableobject-getrunningclass))], [])
    HRESULT GetRunningClass(GUID* lpClsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunnableobject-run))], [])
    HRESULT Run(IBindCtx pbc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunnableobject-isrunning))], [])
    BOOL    IsRunning();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunnableobject-lockrunning))], [])
    HRESULT LockRunning(BOOL fLock, BOOL fLastUnlockCloses);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunnableobject-setcontainedobject))], [])
    HRESULT SetContainedObject(BOOL fContained);
}

@GUID("00000010-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-irunningobjecttable))], [])
interface IRunningObjectTable : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunningobjecttable-register))], [])
    HRESULT Register(ROT_FLAGS grfFlags, IUnknown punkObject, IMoniker pmkObjectName, uint* pdwRegister);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunningobjecttable-revoke))], [])
    HRESULT Revoke(uint dwRegister);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunningobjecttable-isrunning))], [])
    HRESULT IsRunning(IMoniker pmkObjectName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunningobjecttable-getobject))], [])
    HRESULT GetObject(IMoniker pmkObjectName, IUnknown* ppunkObject);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunningobjecttable-notechangetime))], [])
    HRESULT NoteChangeTime(uint dwRegister, FILETIME* pfiletime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunningobjecttable-gettimeoflastchange))], [])
    HRESULT GetTimeOfLastChange(IMoniker pmkObjectName, FILETIME* pfiletime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irunningobjecttable-enumrunning))], [])
    HRESULT EnumRunning(IEnumMoniker* ppenumMoniker);
}

@GUID("0000010c-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ipersist))], [])
interface IPersist : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersist-getclassid))], [])
    HRESULT GetClassID(GUID* pClassID);
}

@GUID("00000109-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ipersiststream))], [])
interface IPersistStream : IPersist
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststream-isdirty))], [])
    HRESULT IsDirty();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststream-load))], [])
    HRESULT Load(IStream pStm);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststream-save))], [])
    HRESULT Save(IStream pStm, BOOL fClearDirty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersiststream-getsizemax))], [])
    HRESULT GetSizeMax(ulong* pcbSize);
}

@GUID("0000000f-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-imoniker))], [])
interface IMoniker : IPersistStream
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-bindtoobject))], [])
    HRESULT BindToObject(IBindCtx pbc, IMoniker pmkToLeft, const(GUID)* riidResult, void** ppvResult);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-bindtostorage))], [])
    HRESULT BindToStorage(IBindCtx pbc, IMoniker pmkToLeft, const(GUID)* riid, void** ppvObj);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-reduce))], [])
    HRESULT Reduce(IBindCtx pbc, uint dwReduceHowFar, IMoniker* ppmkToLeft, IMoniker* ppmkReduced);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-composewith))], [])
    HRESULT ComposeWith(IMoniker pmkRight, BOOL fOnlyIfNotGeneric, IMoniker* ppmkComposite);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-enum))], [])
    HRESULT Enum(BOOL fForward, IEnumMoniker* ppenumMoniker);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-isequal))], [])
    HRESULT IsEqual(IMoniker pmkOtherMoniker);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-hash))], [])
    HRESULT Hash(uint* pdwHash);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-isrunning))], [])
    HRESULT IsRunning(IBindCtx pbc, IMoniker pmkToLeft, IMoniker pmkNewlyRunning);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-gettimeoflastchange))], [])
    HRESULT GetTimeOfLastChange(IBindCtx pbc, IMoniker pmkToLeft, FILETIME* pFileTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-inverse))], [])
    HRESULT Inverse(IMoniker* ppmk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-commonprefixwith))], [])
    HRESULT CommonPrefixWith(IMoniker pmkOther, IMoniker* ppmkPrefix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-relativepathto))], [])
    HRESULT RelativePathTo(IMoniker pmkOther, IMoniker* ppmkRelPath);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-getdisplayname))], [])
    HRESULT GetDisplayName(IBindCtx pbc, IMoniker pmkToLeft, PWSTR* ppszDisplayName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-parsedisplayname))], [])
    HRESULT ParseDisplayName(IBindCtx pbc, IMoniker pmkToLeft, PWSTR pszDisplayName, uint* pchEaten, 
                             IMoniker* ppmkOut);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-imoniker-issystemmoniker))], [])
    HRESULT IsSystemMoniker(uint* pdwMksys);
}

@GUID("f29f6bc0-5021-11ce-aa15-00006901293f")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-irotdata))], [])
interface IROTData : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-irotdata-getcomparisondata))], [])
    HRESULT GetComparisonData(ubyte* pbData, uint cbMax, uint* pcbData);
}

@GUID("0000010b-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ipersistfile))], [])
interface IPersistFile : IPersist
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersistfile-isdirty))], [])
    HRESULT IsDirty();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersistfile-load))], [])
    HRESULT Load(const(PWSTR) pszFileName, STGM dwMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersistfile-save))], [])
    HRESULT Save(const(PWSTR) pszFileName, BOOL fRemember);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersistfile-savecompleted))], [])
    HRESULT SaveCompleted(const(PWSTR) pszFileName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ipersistfile-getcurfile))], [])
    HRESULT GetCurFile(PWSTR* ppszFileName);
}

@GUID("00000103-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ienumformatetc))], [])
interface IEnumFORMATETC : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumformatetc-next))], [])
    HRESULT Next(uint celt, FORMATETC* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumformatetc-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumformatetc-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumformatetc-clone))], [])
    HRESULT Clone(IEnumFORMATETC* ppenum);
}

@GUID("00000105-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-ienumstatdata))], [])
interface IEnumSTATDATA : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatdata-next))], [])
    HRESULT Next(uint celt, STATDATA* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatdata-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatdata-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-ienumstatdata-clone))], [])
    HRESULT Clone(IEnumSTATDATA* ppenum);
}

@GUID("0000010f-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iadvisesink))], [])
interface IAdviseSink : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iadvisesink-ondatachange))], [])
    void OnDataChange(FORMATETC* pFormatetc, STGMEDIUM* pStgmed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iadvisesink-onviewchange))], [])
    void OnViewChange(uint dwAspect, int lindex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iadvisesink-onrename))], [])
    void OnRename(IMoniker pmk);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iadvisesink-onsave))], [])
    void OnSave();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iadvisesink-onclose))], [])
    void OnClose();
}

@GUID("00000150-0000-0000-c000-000000000046")
interface AsyncIAdviseSink : IUnknown
{
    void Begin_OnDataChange(FORMATETC* pFormatetc, STGMEDIUM* pStgmed);
    void Finish_OnDataChange();
    void Begin_OnViewChange(uint dwAspect, int lindex);
    void Finish_OnViewChange();
    void Begin_OnRename(IMoniker pmk);
    void Finish_OnRename();
    void Begin_OnSave();
    void Finish_OnSave();
    void Begin_OnClose();
    void Finish_OnClose();
}

@GUID("00000125-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iadvisesink2))], [])
interface IAdviseSink2 : IAdviseSink
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iadvisesink2-onlinksrcchange))], [])
    void OnLinkSrcChange(IMoniker pmk);
}

@GUID("00000151-0000-0000-c000-000000000046")
interface AsyncIAdviseSink2 : AsyncIAdviseSink
{
    void Begin_OnLinkSrcChange(IMoniker pmk);
    void Finish_OnLinkSrcChange();
}

@GUID("0000010e-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-idataobject))], [])
interface IDataObject : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataobject-getdata))], [])
    HRESULT GetData(FORMATETC* pformatetcIn, STGMEDIUM* pmedium);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataobject-getdatahere))], [])
    HRESULT GetDataHere(FORMATETC* pformatetc, STGMEDIUM* pmedium);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataobject-querygetdata))], [])
    HRESULT QueryGetData(FORMATETC* pformatetc);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataobject-getcanonicalformatetc))], [])
    HRESULT GetCanonicalFormatEtc(FORMATETC* pformatectIn, FORMATETC* pformatetcOut);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataobject-setdata))], [])
    HRESULT SetData(FORMATETC* pformatetc, STGMEDIUM* pmedium, BOOL fRelease);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataobject-enumformatetc))], [])
    HRESULT EnumFormatEtc(uint dwDirection, IEnumFORMATETC* ppenumFormatEtc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataobject-dadvise))], [])
    HRESULT DAdvise(FORMATETC* pformatetc, uint advf, IAdviseSink pAdvSink, uint* pdwConnection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataobject-dunadvise))], [])
    HRESULT DUnadvise(uint dwConnection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataobject-enumdadvise))], [])
    HRESULT EnumDAdvise(IEnumSTATDATA* ppenumAdvise);
}

@GUID("00000110-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-idataadviseholder))], [])
interface IDataAdviseHolder : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataadviseholder-advise))], [])
    HRESULT Advise(IDataObject pDataObject, FORMATETC* pFetc, uint advf, IAdviseSink pAdvise, uint* pdwConnection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataadviseholder-unadvise))], [])
    HRESULT Unadvise(uint dwConnection);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataadviseholder-enumadvise))], [])
    HRESULT EnumAdvise(IEnumSTATDATA* ppenumAdvise);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-idataadviseholder-sendondatachange))], [])
    HRESULT SendOnDataChange(IDataObject pDataObject, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwReserved, 
                             uint advf);
}

@GUID("00000140-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iclassactivator))], [])
interface IClassActivator : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iclassactivator-getclassobject))], [])
    HRESULT GetClassObject(const(GUID)* rclsid, uint dwClassContext, uint locale, const(GUID)* riid, void** ppv);
}

@GUID("a9d758a0-4617-11cf-95fc-00aa00680db4")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iprogressnotify))], [])
interface IProgressNotify : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iprogressnotify-onprogress))], [])
    HRESULT OnProgress(uint dwProgressCurrent, uint dwProgressMaximum, BOOL fAccurate, BOOL fOwner);
}

@GUID("30f3d47a-6447-11d1-8e3c-00c04fb9386d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iblockinglock))], [])
interface IBlockingLock : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iblockinglock-lock))], [])
    HRESULT Lock(uint dwTimeout);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iblockinglock-unlock))], [])
    HRESULT Unlock();
}

@GUID("bc0bf6ae-8878-11d1-83e9-00c04fc2c6d4")
interface ITimeAndNoticeControl : IUnknown
{
    HRESULT SuppressChanges(uint res1, uint res2);
}

@GUID("8d19c834-8879-11d1-83e9-00c04fc2c6d4")
interface IOplockStorage : IUnknown
{
    HRESULT CreateStorageEx(const(PWSTR) pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, const(GUID)* riid, 
                            void** ppstgOpen);
    HRESULT OpenStorageEx(const(PWSTR) pwcsName, uint grfMode, uint stgfmt, uint grfAttrs, const(GUID)* riid, 
                          void** ppstgOpen);
}

@GUID("00000026-0000-0000-c000-000000000046")
interface IUrlMon : IUnknown
{
    HRESULT AsyncGetClassBits(const(GUID)* rclsid, const(PWSTR) pszTYPE, const(PWSTR) pszExt, uint dwFileVersionMS, 
                              uint dwFileVersionLS, const(PWSTR) pszCodeBase, IBindCtx pbc, uint dwClassContext, 
                              const(GUID)* riid, uint flags);
}

@GUID("00000145-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iforegroundtransfer))], [])
interface IForegroundTransfer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iforegroundtransfer-allowforegroundtransfer))], [])
    HRESULT AllowForegroundTransfer(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* lpvReserved);
}

@GUID("000001d5-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iprocesslock))], [])
interface IProcessLock : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iprocesslock-addrefonprocess))], [])
    uint AddRefOnProcess();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iprocesslock-releaserefonprocess))], [])
    uint ReleaseRefOnProcess();
}

@GUID("000001d4-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-isurrogateservice))], [])
interface ISurrogateService : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-isurrogateservice-init))], [])
    HRESULT Init(const(GUID)* rguidProcessID, IProcessLock pProcessLock, BOOL* pfApplicationAware);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-isurrogateservice-applicationlaunch))], [])
    HRESULT ApplicationLaunch(const(GUID)* rguidApplID, ApplicationType appType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-isurrogateservice-applicationfree))], [])
    HRESULT ApplicationFree(const(GUID)* rguidApplID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-isurrogateservice-catalogrefresh))], [])
    HRESULT CatalogRefresh(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint ulReserved);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-isurrogateservice-processshutdown))], [])
    HRESULT ProcessShutdown(ShutdownType shutdownType);
}

@GUID("00000034-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nn-objidl-iinitializespy))], [])
interface IInitializeSpy : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iinitializespy-preinitialize))], [])
    HRESULT PreInitialize(uint dwCoInit, uint dwCurThreadAptRefs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iinitializespy-postinitialize))], [])
    HRESULT PostInitialize(HRESULT hrCoInit, uint dwCoInit, uint dwNewThreadAptRefs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iinitializespy-preuninitialize))], [])
    HRESULT PreUninitialize(uint dwCurThreadAptRefs);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/objidl/nf-objidl-iinitializespy-postuninitialize))], [])
    HRESULT PostUninitialize(uint dwNewThreadAptRefs);
}

@GUID("6d5140c1-7436-11ce-8034-00aa006009fa")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/servprov/nn-servprov-iserviceprovider))], [])
interface IServiceProvider : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/servprov/nf-servprov-iserviceprovider-queryservice(refguid_refiid_void)))], [])
    HRESULT QueryService(const(GUID)* guidService, const(GUID)* riid, void** ppvObject);
}

@GUID("0002e000-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nn-comcat-ienumguid))], [])
interface IEnumGUID : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-ienumguid-next))], [])
    HRESULT Next(uint celt, GUID* rgelt, uint* pceltFetched);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-ienumguid-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-ienumguid-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-ienumguid-clone))], [])
    HRESULT Clone(IEnumGUID* ppenum);
}

@GUID("0002e011-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nn-comcat-ienumcategoryinfo))], [])
interface IEnumCATEGORYINFO : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-ienumcategoryinfo-next))], [])
    HRESULT Next(uint celt, CATEGORYINFO* rgelt, uint* pceltFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-ienumcategoryinfo-skip))], [])
    HRESULT Skip(uint celt);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-ienumcategoryinfo-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-ienumcategoryinfo-clone))], [])
    HRESULT Clone(IEnumCATEGORYINFO* ppenum);
}

@GUID("0002e012-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nn-comcat-icatregister))], [])
interface ICatRegister : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatregister-registercategories))], [])
    HRESULT RegisterCategories(uint cCategories, CATEGORYINFO* rgCategoryInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatregister-unregistercategories))], [])
    HRESULT UnRegisterCategories(uint cCategories, GUID* rgcatid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatregister-registerclassimplcategories))], [])
    HRESULT RegisterClassImplCategories(const(GUID)* rclsid, uint cCategories, GUID* rgcatid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatregister-unregisterclassimplcategories))], [])
    HRESULT UnRegisterClassImplCategories(const(GUID)* rclsid, uint cCategories, GUID* rgcatid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatregister-registerclassreqcategories))], [])
    HRESULT RegisterClassReqCategories(const(GUID)* rclsid, uint cCategories, GUID* rgcatid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatregister-unregisterclassreqcategories))], [])
    HRESULT UnRegisterClassReqCategories(const(GUID)* rclsid, uint cCategories, GUID* rgcatid);
}

@GUID("0002e013-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nn-comcat-icatinformation))], [])
interface ICatInformation : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatinformation-enumcategories))], [])
    HRESULT EnumCategories(uint lcid, IEnumCATEGORYINFO* ppenumCategoryInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatinformation-getcategorydesc))], [])
    HRESULT GetCategoryDesc(GUID* rcatid, uint lcid, PWSTR* pszDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatinformation-enumclassesofcategories))], [])
    HRESULT EnumClassesOfCategories(uint cImplemented, const(GUID)* rgcatidImpl, uint cRequired, 
                                    const(GUID)* rgcatidReq, IEnumGUID* ppenumClsid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatinformation-isclassofcategories))], [])
    HRESULT IsClassOfCategories(const(GUID)* rclsid, uint cImplemented, const(GUID)* rgcatidImpl, uint cRequired, 
                                const(GUID)* rgcatidReq);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatinformation-enumimplcategoriesofclass))], [])
    HRESULT EnumImplCategoriesOfClass(const(GUID)* rclsid, IEnumGUID* ppenumCatid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/comcat/nf-comcat-icatinformation-enumreqcategoriesofclass))], [])
    HRESULT EnumReqCategoriesOfClass(const(GUID)* rclsid, IEnumGUID* ppenumCatid);
}

@GUID("000001da-0000-0000-c000-000000000046")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ctxtcall/nn-ctxtcall-icontextcallback))], [])
interface IContextCallback : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ctxtcall/nf-ctxtcall-icontextcallback-contextcallback))], [])
    HRESULT ContextCallback(PFNCONTEXTCALL pfnCallback, ComCallData* pParam, const(GUID)* riid, int iMethod, 
                            IUnknown pUnk);
}

@GUID("79eac9c0-baf9-11ce-8c82-00aa004ba90b")
interface IBinding : IUnknown
{
    HRESULT Abort();
    HRESULT Suspend();
    HRESULT Resume();
    HRESULT SetPriority(int nPriority);
    HRESULT GetPriority(int* pnPriority);
    HRESULT GetBindResult(GUID* pclsidProtocol, uint* pdwResult, PWSTR* pszResult, uint* pdwReserved);
}

@GUID("79eac9c1-baf9-11ce-8c82-00aa004ba90b")
interface IBindStatusCallback : IUnknown
{
    HRESULT OnStartBinding(uint dwReserved, IBinding pib);
    HRESULT GetPriority(int* pnPriority);
    HRESULT OnLowResource(uint reserved);
    HRESULT OnProgress(uint ulProgress, uint ulProgressMax, uint ulStatusCode, const(PWSTR) szStatusText);
    HRESULT OnStopBinding(HRESULT hresult, const(PWSTR) szError);
    HRESULT GetBindInfo(uint* grfBINDF, BINDINFO* pbindinfo);
    HRESULT OnDataAvailable(uint grfBSCF, uint dwSize, FORMATETC* pformatetc, STGMEDIUM* pstgmed);
    HRESULT OnObjectAvailable(const(GUID)* riid, IUnknown punk);
}

@GUID("aaa74ef9-8ee7-4659-88d9-f8c504da73cc")
interface IBindStatusCallbackEx : IBindStatusCallback
{
    HRESULT GetBindInfoEx(uint* grfBINDF, BINDINFO* pbindinfo, uint* grfBINDF2, uint* pdwReserved);
}

@GUID("79eac9d0-baf9-11ce-8c82-00aa004ba90b")
interface IAuthenticate : IUnknown
{
    HRESULT Authenticate(HWND* phwnd, PWSTR* pszUsername, PWSTR* pszPassword);
}

@GUID("2ad1edaf-d83d-48b5-9adf-03dbe19f53bd")
interface IAuthenticateEx : IAuthenticate
{
    HRESULT AuthenticateEx(HWND* phwnd, PWSTR* pszUsername, PWSTR* pszPassword, AUTHENTICATEINFO* pauthinfo);
}

@GUID("a39ee748-6a27-4817-a6f2-13914bef5890")
interface IUri : IUnknown
{
    HRESULT GetPropertyBSTR(Uri_PROPERTY uriProp, BSTR* pbstrProperty, uint dwFlags);
    HRESULT GetPropertyLength(Uri_PROPERTY uriProp, uint* pcchProperty, uint dwFlags);
    HRESULT GetPropertyDWORD(Uri_PROPERTY uriProp, uint* pdwProperty, uint dwFlags);
    HRESULT HasProperty(Uri_PROPERTY uriProp, BOOL* pfHasProperty);
    HRESULT GetAbsoluteUri(BSTR* pbstrAbsoluteUri);
    HRESULT GetAuthority(BSTR* pbstrAuthority);
    HRESULT GetDisplayUri(BSTR* pbstrDisplayString);
    HRESULT GetDomain(BSTR* pbstrDomain);
    HRESULT GetExtension(BSTR* pbstrExtension);
    HRESULT GetFragment(BSTR* pbstrFragment);
    HRESULT GetHost(BSTR* pbstrHost);
    HRESULT GetPassword(BSTR* pbstrPassword);
    HRESULT GetPath(BSTR* pbstrPath);
    HRESULT GetPathAndQuery(BSTR* pbstrPathAndQuery);
    HRESULT GetQuery(BSTR* pbstrQuery);
    HRESULT GetRawUri(BSTR* pbstrRawUri);
    HRESULT GetSchemeName(BSTR* pbstrSchemeName);
    HRESULT GetUserInfo(BSTR* pbstrUserInfo);
    HRESULT GetUserName(BSTR* pbstrUserName);
    HRESULT GetHostType(uint* pdwHostType);
    HRESULT GetPort(uint* pdwPort);
    HRESULT GetScheme(uint* pdwScheme);
    HRESULT GetZone(uint* pdwZone);
    HRESULT GetProperties(uint* pdwFlags);
    HRESULT IsEqual(IUri pUri, BOOL* pfEqual);
}

@GUID("4221b2e1-8955-46c0-bd5b-de9897565de7")
interface IUriBuilder : IUnknown
{
    HRESULT CreateUriSimple(uint dwAllowEncodingPropertyMask, size_t dwReserved, IUri* ppIUri);
    HRESULT CreateUri(uint dwCreateFlags, uint dwAllowEncodingPropertyMask, size_t dwReserved, IUri* ppIUri);
    HRESULT CreateUriWithFlags(uint dwCreateFlags, uint dwUriBuilderFlags, uint dwAllowEncodingPropertyMask, 
                               size_t dwReserved, IUri* ppIUri);
    HRESULT GetIUri(IUri* ppIUri);
    HRESULT SetIUri(IUri pIUri);
    HRESULT GetFragment(uint* pcchFragment, const(PWSTR)* ppwzFragment);
    HRESULT GetHost(uint* pcchHost, const(PWSTR)* ppwzHost);
    HRESULT GetPassword(uint* pcchPassword, const(PWSTR)* ppwzPassword);
    HRESULT GetPath(uint* pcchPath, const(PWSTR)* ppwzPath);
    HRESULT GetPort(BOOL* pfHasPort, uint* pdwPort);
    HRESULT GetQuery(uint* pcchQuery, const(PWSTR)* ppwzQuery);
    HRESULT GetSchemeName(uint* pcchSchemeName, const(PWSTR)* ppwzSchemeName);
    HRESULT GetUserName(uint* pcchUserName, const(PWSTR)* ppwzUserName);
    HRESULT SetFragment(const(PWSTR) pwzNewValue);
    HRESULT SetHost(const(PWSTR) pwzNewValue);
    HRESULT SetPassword(const(PWSTR) pwzNewValue);
    HRESULT SetPath(const(PWSTR) pwzNewValue);
    HRESULT SetPort(BOOL fHasPort, uint dwNewValue);
    HRESULT SetQuery(const(PWSTR) pwzNewValue);
    HRESULT SetSchemeName(const(PWSTR) pwzNewValue);
    HRESULT SetUserName(const(PWSTR) pwzNewValue);
    HRESULT RemoveProperties(uint dwPropertyMask);
    HRESULT HasBeenModified(BOOL* pfModified);
}

@GUID("fc4801a1-2ba9-11cf-a229-00aa003d7352")
interface IBindHost : IUnknown
{
    HRESULT CreateMoniker(PWSTR szName, IBindCtx pBC, IMoniker* ppmk, uint dwReserved);
    HRESULT MonikerBindToStorage(IMoniker pMk, IBindCtx pBC, IBindStatusCallback pBSC, const(GUID)* riid, 
                                 void** ppvObj);
    HRESULT MonikerBindToObject(IMoniker pMk, IBindCtx pBC, IBindStatusCallback pBSC, const(GUID)* riid, 
                                void** ppvObj);
}

@GUID("00020400-0000-0000-c000-000000000046")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-idispatch))], [])
interface IDispatch : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-idispatch-gettypeinfocount))], [])
    HRESULT GetTypeInfoCount(uint* pctinfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-idispatch-gettypeinfo))], [])
    HRESULT GetTypeInfo(uint iTInfo, uint lcid, ITypeInfo* ppTInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-idispatch-getidsofnames))], [])
    HRESULT GetIDsOfNames(const(GUID)* riid, PWSTR* rgszNames, uint cNames, uint lcid, int* rgDispId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-idispatch-invoke))], [])
    HRESULT Invoke(int dispIdMember, const(GUID)* riid, uint lcid, DISPATCH_FLAGS wFlags, DISPPARAMS* pDispParams, 
                   VARIANT* pVarResult, EXCEPINFO* pExcepInfo, uint* puArgErr);
}

@GUID("00020403-0000-0000-c000-000000000046")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-itypecomp))], [])
interface ITypeComp : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypecomp-bind))], [])
    HRESULT Bind(PWSTR szName, uint lHashVal, ushort wFlags, ITypeInfo* ppTInfo, DESCKIND* pDescKind, 
                 BINDPTR* pBindPtr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypecomp-bindtype))], [])
    HRESULT BindType(PWSTR szName, uint lHashVal, ITypeInfo* ppTInfo, ITypeComp* ppTComp);
}

@GUID("00020401-0000-0000-c000-000000000046")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-itypeinfo))], [])
interface ITypeInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-gettypeattr))], [])
    HRESULT GetTypeAttr(TYPEATTR** ppTypeAttr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-gettypecomp))], [])
    HRESULT GetTypeComp(ITypeComp* ppTComp);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getfuncdesc))], [])
    HRESULT GetFuncDesc(uint index, FUNCDESC** ppFuncDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getvardesc))], [])
    HRESULT GetVarDesc(uint index, VARDESC** ppVarDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getnames))], [])
    HRESULT GetNames(int memid, BSTR* rgBstrNames, uint cMaxNames, uint* pcNames);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getreftypeofimpltype))], [])
    HRESULT GetRefTypeOfImplType(uint index, uint* pRefType);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getimpltypeflags))], [])
    HRESULT GetImplTypeFlags(uint index, IMPLTYPEFLAGS* pImplTypeFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getidsofnames))], [])
    HRESULT GetIDsOfNames(PWSTR* rgszNames, uint cNames, int* pMemId);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-invoke))], [])
    HRESULT Invoke(void* pvInstance, int memid, DISPATCH_FLAGS wFlags, DISPPARAMS* pDispParams, 
                   VARIANT* pVarResult, EXCEPINFO* pExcepInfo, uint* puArgErr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getdocumentation))], [])
    HRESULT GetDocumentation(int memid, BSTR* pBstrName, BSTR* pBstrDocString, uint* pdwHelpContext, 
                             BSTR* pBstrHelpFile);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getdllentry))], [])
    HRESULT GetDllEntry(int memid, INVOKEKIND invKind, BSTR* pBstrDllName, BSTR* pBstrName, ushort* pwOrdinal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getreftypeinfo))], [])
    HRESULT GetRefTypeInfo(uint hRefType, ITypeInfo* ppTInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-addressofmember))], [])
    HRESULT AddressOfMember(int memid, INVOKEKIND invKind, void** ppv);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-createinstance))], [])
    HRESULT CreateInstance(IUnknown pUnkOuter, const(GUID)* riid, void** ppvObj);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getmops))], [])
    HRESULT GetMops(int memid, BSTR* pBstrMops);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-getcontainingtypelib))], [])
    HRESULT GetContainingTypeLib(ITypeLib* ppTLib, uint* pIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-releasetypeattr))], [])
    void    ReleaseTypeAttr(TYPEATTR* pTypeAttr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-releasefuncdesc))], [])
    void    ReleaseFuncDesc(FUNCDESC* pFuncDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo-releasevardesc))], [])
    void    ReleaseVarDesc(VARDESC* pVarDesc);
}

@GUID("00020412-0000-0000-c000-000000000046")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-itypeinfo2))], [])
interface ITypeInfo2 : ITypeInfo
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-gettypekind))], [])
    HRESULT GetTypeKind(TYPEKIND* pTypeKind);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-gettypeflags))], [])
    HRESULT GetTypeFlags(uint* pTypeFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getfuncindexofmemid))], [])
    HRESULT GetFuncIndexOfMemId(int memid, INVOKEKIND invKind, uint* pFuncIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getvarindexofmemid))], [])
    HRESULT GetVarIndexOfMemId(int memid, uint* pVarIndex);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getcustdata))], [])
    HRESULT GetCustData(const(GUID)* guid, VARIANT* pVarVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getfunccustdata))], [])
    HRESULT GetFuncCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getparamcustdata))], [])
    HRESULT GetParamCustData(uint indexFunc, uint indexParam, const(GUID)* guid, VARIANT* pVarVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getvarcustdata))], [])
    HRESULT GetVarCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getimpltypecustdata))], [])
    HRESULT GetImplTypeCustData(uint index, const(GUID)* guid, VARIANT* pVarVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getdocumentation2))], [])
    HRESULT GetDocumentation2(int memid, uint lcid, BSTR* pbstrHelpString, uint* pdwHelpStringContext, 
                              BSTR* pbstrHelpStringDll);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getallcustdata))], [])
    HRESULT GetAllCustData(CUSTDATA* pCustData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getallfunccustdata))], [])
    HRESULT GetAllFuncCustData(uint index, CUSTDATA* pCustData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getallparamcustdata))], [])
    HRESULT GetAllParamCustData(uint indexFunc, uint indexParam, CUSTDATA* pCustData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getallvarcustdata))], [])
    HRESULT GetAllVarCustData(uint index, CUSTDATA* pCustData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypeinfo2-getallimpltypecustdata))], [])
    HRESULT GetAllImplTypeCustData(uint index, CUSTDATA* pCustData);
}

@GUID("00020402-0000-0000-c000-000000000046")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-itypelib))], [])
interface ITypeLib : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-gettypeinfocount))], [])
    uint    GetTypeInfoCount();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-gettypeinfo))], [])
    HRESULT GetTypeInfo(uint index, ITypeInfo* ppTInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-gettypeinfotype))], [])
    HRESULT GetTypeInfoType(uint index, TYPEKIND* pTKind);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-gettypeinfoofguid))], [])
    HRESULT GetTypeInfoOfGuid(const(GUID)* guid, ITypeInfo* ppTinfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-getlibattr))], [])
    HRESULT GetLibAttr(TLIBATTR** ppTLibAttr);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-gettypecomp))], [])
    HRESULT GetTypeComp(ITypeComp* ppTComp);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-getdocumentation))], [])
    HRESULT GetDocumentation(int index, BSTR* pBstrName, BSTR* pBstrDocString, uint* pdwHelpContext, 
                             BSTR* pBstrHelpFile);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-isname))], [])
    HRESULT IsName(PWSTR szNameBuf, uint lHashVal, BOOL* pfName);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-findname))], [])
    HRESULT FindName(PWSTR szNameBuf, uint lHashVal, ITypeInfo* ppTInfo, int* rgMemId, ushort* pcFound);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib-releasetlibattr))], [])
    void    ReleaseTLibAttr(TLIBATTR* pTLibAttr);
}

@GUID("00020411-0000-0000-c000-000000000046")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-itypelib2))], [])
interface ITypeLib2 : ITypeLib
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib2-getcustdata))], [])
    HRESULT GetCustData(const(GUID)* guid, VARIANT* pVarVal);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib2-getlibstatistics))], [])
    HRESULT GetLibStatistics(uint* pcUniqueNames, uint* pcchUniqueNames);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib2-getdocumentation2))], [])
    HRESULT GetDocumentation2(int index, uint lcid, BSTR* pbstrHelpString, uint* pdwHelpStringContext, 
                              BSTR* pbstrHelpStringDll);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-itypelib2-getallcustdata))], [])
    HRESULT GetAllCustData(CUSTDATA* pCustData);
}

@GUID("1cf2b120-547d-101b-8e65-08002b2bd119")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-ierrorinfo))], [])
interface IErrorInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ierrorinfo-getguid))], [])
    HRESULT GetGUID(GUID* pGUID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ierrorinfo-getsource))], [])
    HRESULT GetSource(BSTR* pBstrSource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ierrorinfo-getdescription))], [])
    HRESULT GetDescription(BSTR* pBstrDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ierrorinfo-gethelpfile))], [])
    HRESULT GetHelpFile(BSTR* pBstrHelpFile);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ierrorinfo-gethelpcontext))], [])
    HRESULT GetHelpContext(uint* pdwHelpContext);
}

@GUID("df0b3d60-548f-101b-8e65-08002b2bd119")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-isupporterrorinfo))], [])
interface ISupportErrorInfo : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-isupporterrorinfo-interfacesupportserrorinfo))], [])
    HRESULT InterfaceSupportsErrorInfo(const(GUID)* riid);
}

@GUID("3127ca40-446e-11ce-8135-00aa004bb851")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nn-oaidl-ierrorlog))], [])
interface IErrorLog : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oaidl/nf-oaidl-ierrorlog-adderror))], [])
    HRESULT AddError(const(PWSTR) pszPropName, EXCEPINFO* pExcepInfo);
}

@GUID("ed6a8a2a-b160-4e77-8f73-aa7435cd5c27")
interface ITypeLibRegistrationReader : IUnknown
{
    HRESULT EnumTypeLibRegistrations(IEnumUnknown* ppEnumUnknown);
}

@GUID("76a3e735-02df-4a12-98eb-043ad3600af3")
interface ITypeLibRegistration : IUnknown
{
    HRESULT GetGuid(GUID* pGuid);
    HRESULT GetVersion(BSTR* pVersion);
    HRESULT GetLcid(uint* pLcid);
    HRESULT GetWin32Path(BSTR* pWin32Path);
    HRESULT GetWin64Path(BSTR* pWin64Path);
    HRESULT GetDisplayName(BSTR* pDisplayName);
    HRESULT GetFlags(uint* pFlags);
    HRESULT GetHelpDir(BSTR* pHelpDir);
}

@GUID("b196b287-bab4-101a-b69c-00aa00341d07")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ienumconnections))], [])
interface IEnumConnections : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumconnections-next))], [])
    HRESULT Next(uint cConnections, CONNECTDATA* rgcd, uint* pcFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumconnections-skip))], [])
    HRESULT Skip(uint cConnections);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumconnections-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumconnections-clone))], [])
    HRESULT Clone(IEnumConnections* ppEnum);
}

@GUID("b196b286-bab4-101a-b69c-00aa00341d07")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iconnectionpoint))], [])
interface IConnectionPoint : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iconnectionpoint-getconnectioninterface))], [])
    HRESULT GetConnectionInterface(GUID* pIID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iconnectionpoint-getconnectionpointcontainer))], [])
    HRESULT GetConnectionPointContainer(IConnectionPointContainer* ppCPC);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iconnectionpoint-advise))], [])
    HRESULT Advise(IUnknown pUnkSink, uint* pdwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iconnectionpoint-unadvise))], [])
    HRESULT Unadvise(uint dwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iconnectionpoint-enumconnections))], [])
    HRESULT EnumConnections(IEnumConnections* ppEnum);
}

@GUID("b196b285-bab4-101a-b69c-00aa00341d07")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ienumconnectionpoints))], [])
interface IEnumConnectionPoints : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumconnectionpoints-next))], [])
    HRESULT Next(uint cConnections, IConnectionPoint* ppCP, uint* pcFetched);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumconnectionpoints-skip))], [])
    HRESULT Skip(uint cConnections);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumconnectionpoints-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ienumconnectionpoints-clone))], [])
    HRESULT Clone(IEnumConnectionPoints* ppEnum);
}

@GUID("b196b284-bab4-101a-b69c-00aa00341d07")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-iconnectionpointcontainer))], [])
interface IConnectionPointContainer : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iconnectionpointcontainer-enumconnectionpoints))], [])
    HRESULT EnumConnectionPoints(IEnumConnectionPoints* ppEnum);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-iconnectionpointcontainer-findconnectionpoint))], [])
    HRESULT FindConnectionPoint(const(GUID)* riid, IConnectionPoint* ppCP);
}

@GUID("bd1ae5e0-a6ae-11ce-bd37-504200c10000")
interface IPersistMemory : IPersist
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsDirty();
    HRESULT Load(void* pMem, uint cbSize);
    HRESULT Save(void* pMem, BOOL fClearDirty, uint cbSize);
    HRESULT GetSizeMax(uint* pCbSize);
    HRESULT InitNew();
}

@GUID("7fd52380-4e07-101b-ae2d-08002b2ec713")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nn-ocidl-ipersiststreaminit))], [])
interface IPersistStreamInit : IPersist
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipersiststreaminit-isdirty))], [])
    HRESULT IsDirty();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipersiststreaminit-load))], [])
    HRESULT Load(IStream pStm);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipersiststreaminit-save))], [])
    HRESULT Save(IStream pStm, BOOL fClearDirty);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipersiststreaminit-getsizemax))], [])
    HRESULT GetSizeMax(ulong* pCbSize);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ocidl/nf-ocidl-ipersiststreaminit-initnew))], [])
    HRESULT InitNew();
}


// GUIDs


const GUID IID_AsyncIAdviseSink                                      = GUIDOF!AsyncIAdviseSink;
const GUID IID_AsyncIAdviseSink2                                     = GUIDOF!AsyncIAdviseSink2;
const GUID IID_AsyncIMultiQI                                         = GUIDOF!AsyncIMultiQI;
const GUID IID_AsyncIPipeByte                                        = GUIDOF!AsyncIPipeByte;
const GUID IID_AsyncIPipeDouble                                      = GUIDOF!AsyncIPipeDouble;
const GUID IID_AsyncIPipeLong                                        = GUIDOF!AsyncIPipeLong;
const GUID IID_AsyncIUnknown                                         = GUIDOF!AsyncIUnknown;
const GUID IID_IActivationFilter                                     = GUIDOF!IActivationFilter;
const GUID IID_IAddrExclusionControl                                 = GUIDOF!IAddrExclusionControl;
const GUID IID_IAddrTrackingControl                                  = GUIDOF!IAddrTrackingControl;
const GUID IID_IAdviseSink                                           = GUIDOF!IAdviseSink;
const GUID IID_IAdviseSink2                                          = GUIDOF!IAdviseSink2;
const GUID IID_IAgileObject                                          = GUIDOF!IAgileObject;
const GUID IID_IAsyncManager                                         = GUIDOF!IAsyncManager;
const GUID IID_IAsyncRpcChannelBuffer                                = GUIDOF!IAsyncRpcChannelBuffer;
const GUID IID_IAuthenticate                                         = GUIDOF!IAuthenticate;
const GUID IID_IAuthenticateEx                                       = GUIDOF!IAuthenticateEx;
const GUID IID_IBindCtx                                              = GUIDOF!IBindCtx;
const GUID IID_IBindHost                                             = GUIDOF!IBindHost;
const GUID IID_IBindStatusCallback                                   = GUIDOF!IBindStatusCallback;
const GUID IID_IBindStatusCallbackEx                                 = GUIDOF!IBindStatusCallbackEx;
const GUID IID_IBinding                                              = GUIDOF!IBinding;
const GUID IID_IBlockingLock                                         = GUIDOF!IBlockingLock;
const GUID IID_ICallFactory                                          = GUIDOF!ICallFactory;
const GUID IID_ICancelMethodCalls                                    = GUIDOF!ICancelMethodCalls;
const GUID IID_ICatInformation                                       = GUIDOF!ICatInformation;
const GUID IID_ICatRegister                                          = GUIDOF!ICatRegister;
const GUID IID_IChannelHook                                          = GUIDOF!IChannelHook;
const GUID IID_IClassActivator                                       = GUIDOF!IClassActivator;
const GUID IID_IClassFactory                                         = GUIDOF!IClassFactory;
const GUID IID_IClientSecurity                                       = GUIDOF!IClientSecurity;
const GUID IID_IComThreadingInfo                                     = GUIDOF!IComThreadingInfo;
const GUID IID_IConnectionPoint                                      = GUIDOF!IConnectionPoint;
const GUID IID_IConnectionPointContainer                             = GUIDOF!IConnectionPointContainer;
const GUID IID_IContext                                              = GUIDOF!IContext;
const GUID IID_IContextCallback                                      = GUIDOF!IContextCallback;
const GUID IID_IDataAdviseHolder                                     = GUIDOF!IDataAdviseHolder;
const GUID IID_IDataObject                                           = GUIDOF!IDataObject;
const GUID IID_IDispatch                                             = GUIDOF!IDispatch;
const GUID IID_IEnumCATEGORYINFO                                     = GUIDOF!IEnumCATEGORYINFO;
const GUID IID_IEnumConnectionPoints                                 = GUIDOF!IEnumConnectionPoints;
const GUID IID_IEnumConnections                                      = GUIDOF!IEnumConnections;
const GUID IID_IEnumContextProps                                     = GUIDOF!IEnumContextProps;
const GUID IID_IEnumFORMATETC                                        = GUIDOF!IEnumFORMATETC;
const GUID IID_IEnumGUID                                             = GUIDOF!IEnumGUID;
const GUID IID_IEnumMoniker                                          = GUIDOF!IEnumMoniker;
const GUID IID_IEnumSTATDATA                                         = GUIDOF!IEnumSTATDATA;
const GUID IID_IEnumString                                           = GUIDOF!IEnumString;
const GUID IID_IEnumUnknown                                          = GUIDOF!IEnumUnknown;
const GUID IID_IErrorInfo                                            = GUIDOF!IErrorInfo;
const GUID IID_IErrorLog                                             = GUIDOF!IErrorLog;
const GUID IID_IExternalConnection                                   = GUIDOF!IExternalConnection;
const GUID IID_IFastRundown                                          = GUIDOF!IFastRundown;
const GUID IID_IForegroundTransfer                                   = GUIDOF!IForegroundTransfer;
const GUID IID_IGlobalInterfaceTable                                 = GUIDOF!IGlobalInterfaceTable;
const GUID IID_IGlobalOptions                                        = GUIDOF!IGlobalOptions;
const GUID IID_IInitializeSpy                                        = GUIDOF!IInitializeSpy;
const GUID IID_IInternalUnknown                                      = GUIDOF!IInternalUnknown;
const GUID IID_IMachineGlobalObjectTable                             = GUIDOF!IMachineGlobalObjectTable;
const GUID IID_IMalloc                                               = GUIDOF!IMalloc;
const GUID IID_IMallocSpy                                            = GUIDOF!IMallocSpy;
const GUID IID_IMoniker                                              = GUIDOF!IMoniker;
const GUID IID_IMultiQI                                              = GUIDOF!IMultiQI;
const GUID IID_INoMarshal                                            = GUIDOF!INoMarshal;
const GUID IID_IOplockStorage                                        = GUIDOF!IOplockStorage;
const GUID IID_IPSFactoryBuffer                                      = GUIDOF!IPSFactoryBuffer;
const GUID IID_IPackagedComSyntaxSupport                             = GUIDOF!IPackagedComSyntaxSupport;
const GUID IID_IPersist                                              = GUIDOF!IPersist;
const GUID IID_IPersistFile                                          = GUIDOF!IPersistFile;
const GUID IID_IPersistMemory                                        = GUIDOF!IPersistMemory;
const GUID IID_IPersistStream                                        = GUIDOF!IPersistStream;
const GUID IID_IPersistStreamInit                                    = GUIDOF!IPersistStreamInit;
const GUID IID_IPipeByte                                             = GUIDOF!IPipeByte;
const GUID IID_IPipeDouble                                           = GUIDOF!IPipeDouble;
const GUID IID_IPipeLong                                             = GUIDOF!IPipeLong;
const GUID IID_IProcessInitControl                                   = GUIDOF!IProcessInitControl;
const GUID IID_IProcessLock                                          = GUIDOF!IProcessLock;
const GUID IID_IProgressNotify                                       = GUIDOF!IProgressNotify;
const GUID IID_IROTData                                              = GUIDOF!IROTData;
const GUID IID_IReleaseMarshalBuffers                                = GUIDOF!IReleaseMarshalBuffers;
const GUID IID_IRpcChannelBuffer                                     = GUIDOF!IRpcChannelBuffer;
const GUID IID_IRpcChannelBuffer2                                    = GUIDOF!IRpcChannelBuffer2;
const GUID IID_IRpcChannelBuffer3                                    = GUIDOF!IRpcChannelBuffer3;
const GUID IID_IRpcHelper                                            = GUIDOF!IRpcHelper;
const GUID IID_IRpcOptions                                           = GUIDOF!IRpcOptions;
const GUID IID_IRpcProxyBuffer                                       = GUIDOF!IRpcProxyBuffer;
const GUID IID_IRpcStubBuffer                                        = GUIDOF!IRpcStubBuffer;
const GUID IID_IRpcSyntaxNegotiate                                   = GUIDOF!IRpcSyntaxNegotiate;
const GUID IID_IRunnableObject                                       = GUIDOF!IRunnableObject;
const GUID IID_IRunningObjectTable                                   = GUIDOF!IRunningObjectTable;
const GUID IID_ISequentialStream                                     = GUIDOF!ISequentialStream;
const GUID IID_IServerSecurity                                       = GUIDOF!IServerSecurity;
const GUID IID_IServiceProvider                                      = GUIDOF!IServiceProvider;
const GUID IID_IStdMarshalInfo                                       = GUIDOF!IStdMarshalInfo;
const GUID IID_IStream                                               = GUIDOF!IStream;
const GUID IID_ISupportActivateAsActivatorPackaged                   = GUIDOF!ISupportActivateAsActivatorPackaged;
const GUID IID_ISupportActivationFromPackage                         = GUIDOF!ISupportActivationFromPackage;
const GUID IID_ISupportAllowLowerTrustActivation                     = GUIDOF!ISupportAllowLowerTrustActivation;
const GUID IID_ISupportCoAddComDependencyOnPackage                   = GUIDOF!ISupportCoAddComDependencyOnPackage;
const GUID IID_ISupportDoNotElevateServerActivation                  = GUIDOF!ISupportDoNotElevateServerActivation;
const GUID IID_ISupportErrorInfo                                     = GUIDOF!ISupportErrorInfo;
const GUID IID_ISupportPackagedComElevationEnabledClasses            = GUIDOF!ISupportPackagedComElevationEnabledClasses;
const GUID IID_ISupportPackagedComRegistrationVisibility             = GUIDOF!ISupportPackagedComRegistrationVisibility;
const GUID IID_ISupportServerMustBeEqualOrGreaterPrivilegeActivation = GUIDOF!ISupportServerMustBeEqualOrGreaterPrivilegeActivation;
const GUID IID_ISurrogate                                            = GUIDOF!ISurrogate;
const GUID IID_ISurrogateService                                     = GUIDOF!ISurrogateService;
const GUID IID_ISynchronize                                          = GUIDOF!ISynchronize;
const GUID IID_ISynchronizeContainer                                 = GUIDOF!ISynchronizeContainer;
const GUID IID_ISynchronizeEvent                                     = GUIDOF!ISynchronizeEvent;
const GUID IID_ISynchronizeHandle                                    = GUIDOF!ISynchronizeHandle;
const GUID IID_ISynchronizeMutex                                     = GUIDOF!ISynchronizeMutex;
const GUID IID_ITimeAndNoticeControl                                 = GUIDOF!ITimeAndNoticeControl;
const GUID IID_ITypeComp                                             = GUIDOF!ITypeComp;
const GUID IID_ITypeInfo                                             = GUIDOF!ITypeInfo;
const GUID IID_ITypeInfo2                                            = GUIDOF!ITypeInfo2;
const GUID IID_ITypeLib                                              = GUIDOF!ITypeLib;
const GUID IID_ITypeLib2                                             = GUIDOF!ITypeLib2;
const GUID IID_ITypeLibRegistration                                  = GUIDOF!ITypeLibRegistration;
const GUID IID_ITypeLibRegistrationReader                            = GUIDOF!ITypeLibRegistrationReader;
const GUID IID_IUnknown                                              = GUIDOF!IUnknown;
const GUID IID_IUri                                                  = GUIDOF!IUri;
const GUID IID_IUriBuilder                                           = GUIDOF!IUriBuilder;
const GUID IID_IUrlMon                                               = GUIDOF!IUrlMon;
const GUID IID_IWaitMultiple                                         = GUIDOF!IWaitMultiple;
