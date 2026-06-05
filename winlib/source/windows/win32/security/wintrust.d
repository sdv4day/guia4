// Written in the D programming language.

module windows.win32.security.wintrust;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, FILETIME, HANDLE, HRESULT, HWND, PSTR, PWSTR;
public import windows.win32.security.cryptography : CERT_CHAIN_CONTEXT, CERT_CHAIN_ELEMENT, CERT_CHAIN_PARA,
                                                    CERT_CONTEXT, CERT_INFO, CERT_STRONG_SIGN_PARA, CERT_USAGE_MATCH,
                                                    CMSG_SIGNER_INFO, CRYPT_ALGORITHM_IDENTIFIER,
                                                    CRYPT_ATTRIBUTE_TYPE_VALUE, CRYPT_BIT_BLOB, CRYPT_INTEGER_BLOB,
                                                    CTL_CONTEXT, HCERTCHAINENGINE, HCERTSTORE;
public import windows.win32.security.cryptography.sip : SIP_DISPATCH_INFO, SIP_INDIRECT_DATA, SIP_SUBJECTINFO;

extern(Windows) @nogc nothrow:


// Enums


alias WINTRUST_GET_DEFAULT_FOR_USAGE_ACTION = uint;
enum : uint
{
    DWACTION_ALLOCANDFILL = 0x00000001,
    DWACTION_FREE         = 0x00000002,
}

alias WINTRUST_POLICY_FLAGS = uint;
enum : uint
{
    WTPF_TRUSTTEST            = 0x00000020,
    WTPF_TESTCANBEVALID       = 0x00000080,
    WTPF_IGNOREEXPIRATION     = 0x00000100,
    WTPF_IGNOREREVOKATION     = 0x00000200,
    WTPF_OFFLINEOK_IND        = 0x00000400,
    WTPF_OFFLINEOK_COM        = 0x00000800,
    WTPF_OFFLINEOKNBU_IND     = 0x00001000,
    WTPF_OFFLINEOKNBU_COM     = 0x00002000,
    WTPF_VERIFY_V1_OFF        = 0x00010000,
    WTPF_IGNOREREVOCATIONONTS = 0x00020000,
    WTPF_ALLOWONLYPERTRUST    = 0x00040000,
}

alias WINTRUST_DATA_PROVIDER_FLAGS = uint;
enum : uint
{
    WTD_USE_IE4_TRUST_FLAG                  = 0x00000001,
    WTD_NO_IE4_CHAIN_FLAG                   = 0x00000002,
    WTD_NO_POLICY_USAGE_FLAG                = 0x00000004,
    WTD_REVOCATION_CHECK_NONE               = 0x00000010,
    WTD_REVOCATION_CHECK_END_CERT           = 0x00000020,
    WTD_REVOCATION_CHECK_CHAIN              = 0x00000040,
    WTD_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT = 0x00000080,
    WTD_SAFER_FLAG                          = 0x00000100,
    WTD_HASH_ONLY_FLAG                      = 0x00000200,
    WTD_USE_DEFAULT_OSVER_CHECK             = 0x00000400,
    WTD_LIFETIME_SIGNING_FLAG               = 0x00000800,
    WTD_CACHE_ONLY_URL_RETRIEVAL            = 0x00001000,
    WTD_DISABLE_MD2_MD4                     = 0x00002000,
    WTD_MOTW                                = 0x00004000,
}

alias WINTRUST_DATA_UICHOICE = uint;
enum : uint
{
    WTD_UI_ALL    = 0x00000001,
    WTD_UI_NONE   = 0x00000002,
    WTD_UI_NOBAD  = 0x00000003,
    WTD_UI_NOGOOD = 0x00000004,
}

alias WINTRUST_SIGNATURE_SETTINGS_FLAGS = uint;
enum : uint
{
    WSS_VERIFY_SPECIFIC         = 0x00000001,
    WSS_GET_SECONDARY_SIG_COUNT = 0x00000002,
}

alias WINTRUST_DATA_STATE_ACTION = uint;
enum : uint
{
    WTD_STATEACTION_IGNORE           = 0x00000000,
    WTD_STATEACTION_VERIFY           = 0x00000001,
    WTD_STATEACTION_CLOSE            = 0x00000002,
    WTD_STATEACTION_AUTO_CACHE       = 0x00000003,
    WTD_STATEACTION_AUTO_CACHE_FLUSH = 0x00000004,
}

alias WINTRUST_DATA_UNION_CHOICE = uint;
enum : uint
{
    WTD_CHOICE_FILE    = 0x00000001,
    WTD_CHOICE_CATALOG = 0x00000002,
    WTD_CHOICE_BLOB    = 0x00000003,
    WTD_CHOICE_SIGNER  = 0x00000004,
    WTD_CHOICE_CERT    = 0x00000005,
}

alias WINTRUST_DATA_REVOCATION_CHECKS = uint;
enum : uint
{
    WTD_REVOKE_NONE       = 0x00000000,
    WTD_REVOKE_WHOLECHAIN = 0x00000001,
}

alias WINTRUST_DATA_UICONTEXT = uint;
enum : uint
{
    WTD_UICONTEXT_EXECUTE = 0x00000000,
    WTD_UICONTEXT_INSTALL = 0x00000001,
}

// Constants


enum const(wchar)* WINTRUST_CONFIG_REGPATH = "Software\\Microsoft\\Cryptography\\Wintrust\\Config";
enum uint WINTRUST_MAX_HEADER_BYTES_TO_MAP_DEFAULT = 0x00a00000;
enum uint WINTRUST_MAX_HASH_BYTES_TO_MAP_DEFAULT = 0x00100000;
enum uint WTD_PROV_FLAGS_MASK = 0x0000ffff;
enum uint WTD_CODE_INTEGRITY_DRIVER_MODE = 0x00008000;
enum uint WSS_INPUT_FLAG_MASK = 0x00000007;
enum uint WSS_OUT_HAS_SEALING_INTENT = 0x40000000;
enum uint WSS_OUTPUT_FLAG_MASK = 0xe0000000;
enum uint WINTRUST_DETACHED_SIG_CHOICE_BLOB = 0x00000002;
enum uint WTCI_OPEN_ONLY_ROOT = 0x00000002;

enum : uint
{
    TRUSTERROR_STEP_WVTPARAMS              = 0x00000000,
    TRUSTERROR_STEP_FILEIO                 = 0x00000002,
    TRUSTERROR_STEP_SIP                    = 0x00000003,
    TRUSTERROR_STEP_SIPSUBJINFO            = 0x00000005,
    TRUSTERROR_STEP_CATALOGFILE            = 0x00000006,
    TRUSTERROR_STEP_CERTSTORE              = 0x00000007,
    TRUSTERROR_STEP_MESSAGE                = 0x00000008,
    TRUSTERROR_STEP_MSG_SIGNERCOUNT        = 0x00000009,
    TRUSTERROR_STEP_MSG_INNERCNTTYPE       = 0x0000000a,
    TRUSTERROR_STEP_MSG_INNERCNT           = 0x0000000b,
    TRUSTERROR_STEP_MSG_STORE              = 0x0000000c,
    TRUSTERROR_STEP_MSG_SIGNERINFO         = 0x0000000d,
    TRUSTERROR_STEP_MSG_SIGNERCERT         = 0x0000000e,
    TRUSTERROR_STEP_MSG_CERTCHAIN          = 0x0000000f,
    TRUSTERROR_STEP_MSG_COUNTERSIGINFO     = 0x00000010,
    TRUSTERROR_STEP_MSG_COUNTERSIGCERT     = 0x00000011,
    TRUSTERROR_STEP_VERIFY_MSGHASH         = 0x00000012,
    TRUSTERROR_STEP_VERIFY_MSGINDIRECTDATA = 0x00000013,
    TRUSTERROR_STEP_FINAL_WVTINIT          = 0x0000001e,
    TRUSTERROR_STEP_FINAL_INITPROV         = 0x0000001f,
    TRUSTERROR_STEP_FINAL_OBJPROV          = 0x00000020,
    TRUSTERROR_STEP_FINAL_SIGPROV          = 0x00000021,
    TRUSTERROR_STEP_FINAL_CERTPROV         = 0x00000022,
    TRUSTERROR_STEP_FINAL_CERTCHKPROV      = 0x00000023,
    TRUSTERROR_STEP_FINAL_POLICYPROV       = 0x00000024,
    TRUSTERROR_STEP_FINAL_UIPROV           = 0x00000025,
}

enum uint CPD_CHOICE_SIP = 0x00000001;

enum : uint
{
    CPD_REVOCATION_CHECK_NONE               = 0x00010000,
    CPD_REVOCATION_CHECK_END_CERT           = 0x00020000,
    CPD_REVOCATION_CHECK_CHAIN              = 0x00040000,
    CPD_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT = 0x00080000,
}

enum uint CPD_RFC3161v21 = 0x00200000;

enum : uint
{
    CPD_UISTATE_MODE_BLOCK = 0x00000001,
    CPD_UISTATE_MODE_ALLOW = 0x00000002,
    CPD_UISTATE_MODE_MASK  = 0x00000003,
}

enum uint WSS_SIGTRUST_SUPPORT = 0x00000002;
enum uint SGNR_TYPE_TIMESTAMP = 0x00000010;

enum : uint
{
    CERT_CONFIDENCE_TIME      = 0x01000000,
    CERT_CONFIDENCE_TIMENEST  = 0x00100000,
    CERT_CONFIDENCE_AUTHIDEXT = 0x00010000,
    CERT_CONFIDENCE_HYGIENE   = 0x00001000,
    CERT_CONFIDENCE_HIGHEST   = 0x11111000,
}

enum : const(wchar)*
{
    WT_PROVIDER_DLL_NAME           = "WINTRUST.DLL",
    WT_PROVIDER_CERTTRUST_FUNCTION = "WintrustCertificateTrust",
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    szOID_TRUSTED_CODESIGNING_CA_LIST = "1.3.6.1.4.1.311.2.2.1",
    szOID_TRUSTED_CLIENT_AUTH_CA_LIST = "1.3.6.1.4.1.311.2.2.2",
    szOID_TRUSTED_SERVER_AUTH_CA_LIST = "1.3.6.1.4.1.311.2.2.3",
}

enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_TIME_STAMP_REQUEST_OBJID = "1.3.6.1.4.1.311.3.2.1";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_SP_AGENCY_INFO_OBJID = "1.3.6.1.4.1.311.2.1.10";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_SP_OPUS_INFO_OBJID = "1.3.6.1.4.1.311.2.1.12";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_PE_IMAGE_DATA_OBJID = "1.3.6.1.4.1.311.2.1.15";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_STRUCTURED_STORAGE_DATA_OBJID = "1.3.6.1.4.1.311.2.1.19";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_INDIVIDUAL_SP_KEY_PURPOSE_OBJID = "1.3.6.1.4.1.311.2.1.21";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_CAB_DATA_OBJID = "1.3.6.1.4.1.311.2.1.25";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_MINIMAL_CRITERIA_OBJID = "1.3.6.1.4.1.311.2.1.26";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_LINK_OBJID = "1.3.6.1.4.1.311.2.1.28";

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    SPC_PE_IMAGE_PAGE_HASHES_V1_OBJID = "1.3.6.1.4.1.311.2.3.1",
    SPC_PE_IMAGE_PAGE_HASHES_V2_OBJID = "1.3.6.1.4.1.311.2.3.2",
}

enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* szOID_INTENT_TO_SEAL = "1.3.6.1.4.1.311.2.4.2";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* szOID_SEALING_TIMESTAMP = "1.3.6.1.4.1.311.2.4.4";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_RELAXED_PE_MARKER_CHECK_OBJID = "1.3.6.1.4.1.311.2.6.1";

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    szOID_SIGNED_ATTRIBUTE_INTERNAL_NAME     = "1.3.6.1.4.1.311.2.7.1",
    szOID_SIGNED_ATTRIBUTE_FILE_VERSION      = "1.3.6.1.4.1.311.2.7.2",
    szOID_SIGNED_ATTRIBUTE_FILE_DESCRIPTION  = "1.3.6.1.4.1.311.2.7.3",
    szOID_SIGNED_ATTRIBUTE_PRODUCT           = "1.3.6.1.4.1.311.2.7.4",
    szOID_SIGNED_ATTRIBUTE_PRODUCT_VERSION   = "1.3.6.1.4.1.311.2.7.5",
    szOID_SIGNED_ATTRIBUTE_ORIGINAL_FILENAME = "1.3.6.1.4.1.311.2.7.6",
    szOID_SIGNED_ATTRIBUTE_LANGUAGE          = "1.3.6.1.4.1.311.2.7.7",
    szOID_SIGNED_ATTRIBUTE_AUTHOR            = "1.3.6.1.4.1.311.2.7.8",
    szOID_SIGNED_ATTRIBUTE_PUBLISH_TIME      = "1.3.6.1.4.1.311.2.7.9",
    szOID_SIGNED_ATTRIBUTE_SOURCE_URL        = "1.3.6.1.4.1.311.2.7.10",
}

enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* CAT_NAMEVALUE_OBJID = "1.3.6.1.4.1.311.12.2.1";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* CAT_MEMBERINFO2_OBJID = "1.3.6.1.4.1.311.12.2.3";
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* SPC_NATURAL_AUTH_PLUGIN_OBJID = "1.3.6.1.4.1.311.96.1.1";
enum PSTR SPC_MINIMAL_CRITERIA_STRUCT = PSTR(cast(ubyte*)0x000007d1);
enum PSTR SPC_INDIRECT_DATA_CONTENT_STRUCT = PSTR(cast(ubyte*)0x000007d3);
enum PSTR SPC_LINK_STRUCT = PSTR(cast(ubyte*)0x000007d5);
enum PSTR SPC_SP_OPUS_INFO_STRUCT = PSTR(cast(ubyte*)0x000007d7);
enum PSTR SPC_JAVA_CLASS_DATA_STRUCT = PSTR(cast(ubyte*)0x000007d9);
enum PSTR SEALING_SIGNATURE_ATTRIBUTE_STRUCT = PSTR(cast(ubyte*)0x000007db);
enum PSTR SPC_SIGINFO_STRUCT = PSTR(cast(ubyte*)0x00000852);

enum : PSTR
{
    CAT_MEMBERINFO_STRUCT  = PSTR(cast(ubyte*)0x000008ae),
    CAT_MEMBERINFO2_STRUCT = PSTR(cast(ubyte*)0x000008af),
}

enum uint SPC_URL_LINK_CHOICE = 0x00000001;
enum uint SPC_FILE_LINK_CHOICE = 0x00000003;

enum : uint
{
    WIN_CERT_REVISION_2_0          = 0x00000200,
    WIN_CERT_TYPE_X509             = 0x00000001,
    WIN_CERT_TYPE_PKCS_SIGNED_DATA = 0x00000002,
    WIN_CERT_TYPE_RESERVED_1       = 0x00000003,
    WIN_CERT_TYPE_TS_STACK_SIGNED  = 0x00000004,
}

enum : uint
{
    WT_TRUSTDBDIALOG_ONLY_PUB_TAB_FLAG     = 0x00000002,
    WT_TRUSTDBDIALOG_WRITE_LEGACY_REG_FLAG = 0x00000100,
    WT_TRUSTDBDIALOG_WRITE_IEAK_STORE_FLAG = 0x00000200,
}

enum const(wchar)* SP_INIT_FUNCTION = "SoftpubInitialize";
enum const(wchar)* SP_SIGTRUST_FUNCTION = "SoftpubLoadSignature";
enum const(wchar)* SP_FINALPOLICY_FUNCTION = "SoftpubAuthenticode";
enum const(wchar)* SP_TESTDUMPPOLICY_FUNCTION_TEST = "SoftpubDumpStructure";

enum : const(wchar)*
{
    GENERIC_CHAIN_FINALPOLICY_FUNCTION = "GenericChainFinalProv",
    GENERIC_CHAIN_CERTTRUST_FUNCTION   = "GenericChainCertificateTrust",
}

enum const(wchar)* HTTPS_CHKCERT_FUNCTION = "HTTPSCheckCertProv";
enum const(wchar)* OFFICE_POLICY_PROVIDER_DLL_NAME = "WINTRUST.DLL";
enum const(wchar)* OFFICE_CLEANUPPOLICY_FUNCTION = "OfficeCleanupPolicy";
enum const(wchar)* DRIVER_FINALPOLPROV_FUNCTION = "DriverFinalPolicy";

enum : uint
{
    CCPI_RESULT_ALLOW = 0x00000001,
    CCPI_RESULT_DENY  = 0x00000002,
    CCPI_RESULT_AUDIT = 0x00000003,
}

// Callbacks

alias PFN_CPD_MEM_ALLOC = void* function(uint cbSize);
alias PFN_CPD_MEM_FREE = void function(void* pvMem2Free);
alias PFN_CPD_ADD_STORE = BOOL function(CRYPT_PROVIDER_DATA* pProvData, HCERTSTORE hStore2Add);
alias PFN_CPD_ADD_SGNR = BOOL function(CRYPT_PROVIDER_DATA* pProvData, BOOL fCounterSigner, uint idxSigner, 
                                       CRYPT_PROVIDER_SGNR* pSgnr2Add);
alias PFN_CPD_ADD_CERT = BOOL function(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, BOOL fCounterSigner, 
                                       uint idxCounterSigner, const(CERT_CONTEXT)* pCert2Add);
alias PFN_CPD_ADD_PRIVDATA = BOOL function(CRYPT_PROVIDER_DATA* pProvData, CRYPT_PROVIDER_PRIVDATA* pPrivData2Add);
alias PFN_PROVIDER_INIT_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_OBJTRUST_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_SIGTRUST_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CERTTRUST_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_FINALPOLICY_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_TESTFINALPOLICY_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CLEANUP_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CERTCHKPOLICY_CALL = BOOL function(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, 
                                                      BOOL fCounterSignerChain, uint idxCounterSigner);
alias PFN_PROVUI_CALL = BOOL function(HWND hWndSecurityDialog, CRYPT_PROVIDER_DATA* pProvData);
alias PFN_ALLOCANDFILLDEFUSAGE = BOOL function(const(PSTR) pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psDefUsage);
alias PFN_FREEDEFUSAGE = BOOL function(const(PSTR) pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psDefUsage);
alias PFN_WTD_GENERIC_CHAIN_POLICY_CALLBACK = HRESULT function(CRYPT_PROVIDER_DATA* pProvData, uint dwStepError, 
                                                               uint dwRegPolicySettings, uint cSigner, 
                                                               WTD_GENERIC_CHAIN_POLICY_SIGNER_INFO** rgpSigner, 
                                                               void* pvPolicyArg);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_data))], [])
struct WINTRUST_DATA
{
    uint   cbStruct;
    void*  pPolicyCallbackData;
    void*  pSIPClientData;
    WINTRUST_DATA_UICHOICE dwUIChoice;
    WINTRUST_DATA_REVOCATION_CHECKS fdwRevocationChecks;
    WINTRUST_DATA_UNION_CHOICE dwUnionChoice;
union Anonymous
    {
        WINTRUST_FILE_INFO* pFile;
        WINTRUST_CATALOG_INFO* pCatalog;
        WINTRUST_BLOB_INFO* pBlob;
        WINTRUST_SGNR_INFO* pSgnr;
        WINTRUST_CERT_INFO* pCert;
        WINTRUST_DETACHED_SIG_INFO* pDetachedSig;
    }
    WINTRUST_DATA_STATE_ACTION dwStateAction;
    HANDLE hWVTStateData;
    PWSTR  pwszURLReference;
    WINTRUST_DATA_PROVIDER_FLAGS dwProvFlags;
    WINTRUST_DATA_UICONTEXT dwUIContext;
    WINTRUST_SIGNATURE_SETTINGS* pSignatureSettings;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_signature_settings))], [])
struct WINTRUST_SIGNATURE_SETTINGS
{
    uint cbStruct;
    uint dwIndex;
    WINTRUST_SIGNATURE_SETTINGS_FLAGS dwFlags;
    uint cSecondarySigs;
    uint dwVerifiedSigIndex;
    CERT_STRONG_SIGN_PARA* pCryptoPolicy;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_file_info))], [])
struct WINTRUST_FILE_INFO
{
    uint         cbStruct;
    const(PWSTR) pcwszFilePath;
    HANDLE       hFile;
    GUID*        pgKnownSubject;
}

struct WINTRUST_DETACHED_SIG_FILE_HANDLES
{
    HANDLE hContentFile;
    HANDLE hSignatureFile;
}

struct WINTRUST_DETACHED_SIG_BLOBS
{
    long   cbContentObject;
    ubyte* pbContentObject;
    uint   cbSignatureObject;
    ubyte* pbSignatureObject;
}

struct WINTRUST_DETACHED_SIG_INFO
{
    uint cbStruct;
    uint dwUnionChoice;
union Anonymous
    {
        WINTRUST_DETACHED_SIG_FILE_HANDLES* pDetachedSigHandles;
        WINTRUST_DETACHED_SIG_BLOBS* pDetachedSigBlobs;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_catalog_info))], [])
struct WINTRUST_CATALOG_INFO
{
    uint         cbStruct;
    uint         dwCatalogVersion;
    const(PWSTR) pcwszCatalogFilePath;
    const(PWSTR) pcwszMemberTag;
    const(PWSTR) pcwszMemberFilePath;
    HANDLE       hMemberFile;
    ubyte*       pbCalculatedFileHash;
    uint         cbCalculatedFileHash;
    CTL_CONTEXT* pcCatalogContext;
    ptrdiff_t    hCatAdmin;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_blob_info))], [])
struct WINTRUST_BLOB_INFO
{
    uint         cbStruct;
    GUID         gSubject;
    const(PWSTR) pcwszDisplayName;
    uint         cbMemObject;
    ubyte*       pbMemObject;
    uint         cbMemSignedMsg;
    ubyte*       pbMemSignedMsg;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_sgnr_info))], [])
struct WINTRUST_SGNR_INFO
{
    uint              cbStruct;
    const(PWSTR)      pcwszDisplayName;
    CMSG_SIGNER_INFO* psSignerInfo;
    uint              chStores;
    HCERTSTORE*       pahStores;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-wintrust_cert_info))], [])
struct WINTRUST_CERT_INFO
{
    uint          cbStruct;
    const(PWSTR)  pcwszDisplayName;
    CERT_CONTEXT* psCertContext;
    uint          chStores;
    HCERTSTORE*   pahStores;
    uint          dwFlags;
    FILETIME*     psftVerifyAsOf;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_data))], [])
struct CRYPT_PROVIDER_DATA
{
    uint                 cbStruct;
    WINTRUST_DATA*       pWintrustData;
    BOOL                 fOpenedFile;
    HWND                 hWndParent;
    GUID*                pgActionID;
    size_t               hProv;
    uint                 dwError;
    uint                 dwRegSecuritySettings;
    uint                 dwRegPolicySettings;
    CRYPT_PROVIDER_FUNCTIONS* psPfns;
    uint                 cdwTrustStepErrors;
    uint*                padwTrustStepErrors;
    uint                 chStores;
    HCERTSTORE*          pahStores;
    uint                 dwEncoding;
    void*                hMsg;
    uint                 csSigners;
    CRYPT_PROVIDER_SGNR* pasSigners;
    uint                 csProvPrivData;
    CRYPT_PROVIDER_PRIVDATA* pasProvPrivData;
    uint                 dwSubjectChoice;
union Anonymous
    {
        PROVDATA_SIP* pPDSip;
    }
    PSTR                 pszUsageOID;
    BOOL                 fRecallWithState;
    FILETIME             sftSystemTime;
    PSTR                 pszCTLSignerUsageOID;
    uint                 dwProvFlags;
    uint                 dwFinalError;
    CERT_USAGE_MATCH*    pRequestUsage;
    uint                 dwTrustPubSettings;
    uint                 dwUIStateFlags;
    CRYPT_PROVIDER_SIGSTATE* pSigState;
    WINTRUST_SIGNATURE_SETTINGS* pSigSettings;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_sigstate))], [])
struct CRYPT_PROVIDER_SIGSTATE
{
    uint   cbStruct;
    void** rhSecondarySigs;
    void*  hPrimarySig;
    BOOL   fFirstAttemptMade;
    BOOL   fNoMoreSigs;
    uint   cSecondarySigs;
    uint   dwCurrentIndex;
    BOOL   fSupportMultiSig;
    uint   dwCryptoPolicySupport;
    uint   iAttemptCount;
    BOOL   fCheckedSealing;
    SEALING_SIGNATURE_ATTRIBUTE* pSealingSignature;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_functions))], [])
struct CRYPT_PROVIDER_FUNCTIONS
{
    uint                 cbStruct;
    PFN_CPD_MEM_ALLOC    pfnAlloc;
    PFN_CPD_MEM_FREE     pfnFree;
    PFN_CPD_ADD_STORE    pfnAddStore2Chain;
    PFN_CPD_ADD_SGNR     pfnAddSgnr2Chain;
    PFN_CPD_ADD_CERT     pfnAddCert2Chain;
    PFN_CPD_ADD_PRIVDATA pfnAddPrivData2Chain;
    PFN_PROVIDER_INIT_CALL pfnInitialize;
    PFN_PROVIDER_OBJTRUST_CALL pfnObjectTrust;
    PFN_PROVIDER_SIGTRUST_CALL pfnSignatureTrust;
    PFN_PROVIDER_CERTTRUST_CALL pfnCertificateTrust;
    PFN_PROVIDER_FINALPOLICY_CALL pfnFinalPolicy;
    PFN_PROVIDER_CERTCHKPOLICY_CALL pfnCertCheckPolicy;
    PFN_PROVIDER_TESTFINALPOLICY_CALL pfnTestFinalPolicy;
    CRYPT_PROVUI_FUNCS*  psUIpfns;
    PFN_PROVIDER_CLEANUP_CALL pfnCleanupPolicy;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provui_funcs))], [])
struct CRYPT_PROVUI_FUNCS
{
    uint               cbStruct;
    CRYPT_PROVUI_DATA* psUIData;
    PFN_PROVUI_CALL    pfnOnMoreInfoClick;
    PFN_PROVUI_CALL    pfnOnMoreInfoClickDefault;
    PFN_PROVUI_CALL    pfnOnAdvancedClick;
    PFN_PROVUI_CALL    pfnOnAdvancedClickDefault;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provui_data))], [])
struct CRYPT_PROVUI_DATA
{
    uint  cbStruct;
    uint  dwFinalError;
    PWSTR pYesButtonText;
    PWSTR pNoButtonText;
    PWSTR pMoreInfoButtonText;
    PWSTR pAdvancedLinkText;
    PWSTR pCopyActionText;
    PWSTR pCopyActionTextNoTS;
    PWSTR pCopyActionTextNotSigned;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_sgnr))], [])
struct CRYPT_PROVIDER_SGNR
{
    uint                 cbStruct;
    FILETIME             sftVerifyAsOf;
    uint                 csCertChain;
    CRYPT_PROVIDER_CERT* pasCertChain;
    uint                 dwSignerType;
    CMSG_SIGNER_INFO*    psSigner;
    uint                 dwError;
    uint                 csCounterSigners;
    CRYPT_PROVIDER_SGNR* pasCounterSigners;
    CERT_CHAIN_CONTEXT*  pChainContext;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_cert))], [])
struct CRYPT_PROVIDER_CERT
{
    uint                 cbStruct;
    const(CERT_CONTEXT)* pCert;
    BOOL                 fCommercial;
    BOOL                 fTrustedRoot;
    BOOL                 fSelfSigned;
    BOOL                 fTestCert;
    uint                 dwRevokedReason;
    uint                 dwConfidence;
    uint                 dwError;
    CTL_CONTEXT*         pTrustListContext;
    BOOL                 fTrustListSignerCert;
    CTL_CONTEXT*         pCtlContext;
    uint                 dwCtlError;
    BOOL                 fIsCyclic;
    CERT_CHAIN_ELEMENT*  pChainElement;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_privdata))], [])
struct CRYPT_PROVIDER_PRIVDATA
{
    uint  cbStruct;
    GUID  gProviderID;
    uint  cbProvData;
    void* pvProvData;
}

struct PROVDATA_SIP
{
    uint               cbStruct;
    GUID               gSubject;
    SIP_DISPATCH_INFO* pSip;
    SIP_DISPATCH_INFO* pCATSip;
    SIP_SUBJECTINFO*   psSipSubjectInfo;
    SIP_SUBJECTINFO*   psSipCATSubjectInfo;
    SIP_INDIRECT_DATA* psIndirectData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_trust_reg_entry))], [])
struct CRYPT_TRUST_REG_ENTRY
{
    uint  cbStruct;
    PWSTR pwszDLLName;
    PWSTR pwszFunctionName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_register_actionid))], [])
struct CRYPT_REGISTER_ACTIONID
{
    uint cbStruct;
    CRYPT_TRUST_REG_ENTRY sInitProvider;
    CRYPT_TRUST_REG_ENTRY sObjectProvider;
    CRYPT_TRUST_REG_ENTRY sSignatureProvider;
    CRYPT_TRUST_REG_ENTRY sCertificateProvider;
    CRYPT_TRUST_REG_ENTRY sCertificatePolicyProvider;
    CRYPT_TRUST_REG_ENTRY sFinalPolicyProvider;
    CRYPT_TRUST_REG_ENTRY sTestPolicyProvider;
    CRYPT_TRUST_REG_ENTRY sCleanupProvider;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_regdefusage))], [])
struct CRYPT_PROVIDER_REGDEFUSAGE
{
    uint  cbStruct;
    GUID* pgActionID;
    PWSTR pwszDllName;
    PSTR  pwszLoadCallbackDataFunctionName;
    PSTR  pwszFreeCallbackDataFunctionName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-crypt_provider_defusage))], [])
struct CRYPT_PROVIDER_DEFUSAGE
{
    uint  cbStruct;
    GUID  gActionID;
    void* pDefPolicyCallbackData;
    void* pDefSIPClientData;
}

struct SPC_SERIALIZED_OBJECT
{
    ubyte[16]          ClassId;
    CRYPT_INTEGER_BLOB SerializedData;
}

struct SPC_SIGINFO
{
    uint dwSipVersion;
    GUID gSIPGuid;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
    uint dwReserved4;
    uint dwReserved5;
}

struct SPC_LINK
{
    uint dwLinkChoice;
union Anonymous
    {
        PWSTR pwszUrl;
        SPC_SERIALIZED_OBJECT Moniker;
        PWSTR pwszFile;
    }
}

struct SPC_PE_IMAGE_DATA
{
    CRYPT_BIT_BLOB Flags;
    SPC_LINK*      pFile;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-spc_indirect_data_content))], [])
struct SPC_INDIRECT_DATA_CONTENT
{
    CRYPT_ATTRIBUTE_TYPE_VALUE Data;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    CRYPT_INTEGER_BLOB Digest;
}

struct SPC_FINANCIAL_CRITERIA
{
    BOOL fFinancialInfoAvailable;
    BOOL fMeetsCriteria;
}

struct SPC_IMAGE
{
    SPC_LINK*          pImageLink;
    CRYPT_INTEGER_BLOB Bitmap;
    CRYPT_INTEGER_BLOB Metafile;
    CRYPT_INTEGER_BLOB EnhancedMetafile;
    CRYPT_INTEGER_BLOB GifFile;
}

struct SPC_SP_AGENCY_INFO
{
    SPC_LINK*  pPolicyInformation;
    PWSTR      pwszPolicyDisplayText;
    SPC_IMAGE* pLogoImage;
    SPC_LINK*  pLogoLink;
}

struct SPC_STATEMENT_TYPE
{
    uint  cKeyPurposeId;
    PSTR* rgpszKeyPurposeId;
}

struct SPC_SP_OPUS_INFO
{
    const(PWSTR) pwszProgramName;
    SPC_LINK*    pMoreInfo;
    SPC_LINK*    pPublisherInfo;
}

struct CAT_NAMEVALUE
{
    PWSTR              pwszTag;
    uint               fdwFlags;
    CRYPT_INTEGER_BLOB Value;
}

struct CAT_MEMBERINFO
{
    PWSTR pwszSubjGuid;
    uint  dwCertVersion;
}

struct CAT_MEMBERINFO2
{
    GUID SubjectGuid;
    uint dwCertVersion;
}

struct INTENT_TO_SEAL_ATTRIBUTE
{
    uint    version_;
    BOOLEAN seal;
}

struct SEALING_SIGNATURE_ATTRIBUTE
{
    uint               version_;
    uint               signerIndex;
    CRYPT_ALGORITHM_IDENTIFIER signatureAlgorithm;
    CRYPT_INTEGER_BLOB encryptedDigest;
}

struct SEALING_TIMESTAMP_ATTRIBUTE
{
    uint               version_;
    uint               signerIndex;
    CRYPT_INTEGER_BLOB sealTimeStampToken;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/ns-wintrust-win_certificate))], [])
struct WIN_CERTIFICATE
{
    uint   dwLength;
    ushort wRevision;
    ushort wCertificateType;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] bCertificate;
}

struct WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT
{
    HANDLE hClientToken;
    GUID*  SubjectType;
    void*  Subject;
}

struct WIN_TRUST_ACTDATA_SUBJECT_ONLY
{
    GUID* SubjectType;
    void* Subject;
}

struct WIN_TRUST_SUBJECT_FILE
{
    HANDLE       hFile;
    const(PWSTR) lpPath;
}

struct WIN_TRUST_SUBJECT_FILE_AND_DISPLAY
{
    HANDLE       hFile;
    const(PWSTR) lpPath;
    const(PWSTR) lpDisplayName;
}

struct WIN_SPUB_TRUSTED_PUBLISHER_DATA
{
    HANDLE           hClientToken;
    WIN_CERTIFICATE* lpCertificate;
}

struct WTD_GENERIC_CHAIN_POLICY_SIGNER_INFO
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
union Anonymous
    {
        uint cbStruct;
        uint cbSize;
    }
    CERT_CHAIN_CONTEXT* pChainContext;
    uint                dwSignerType;
    CMSG_SIGNER_INFO*   pMsgSignerInfo;
    uint                dwError;
    uint                cCounterSigner;
    WTD_GENERIC_CHAIN_POLICY_SIGNER_INFO** rgpCounterSigner;
}

struct WTD_GENERIC_CHAIN_POLICY_CREATE_INFO
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
union Anonymous
    {
        uint cbStruct;
        uint cbSize;
    }
    HCERTCHAINENGINE hChainEngine;
    CERT_CHAIN_PARA* pChainPara;
    uint             dwFlags;
    void*            pvReserved;
}

struct WTD_GENERIC_CHAIN_POLICY_DATA
{
    //STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
union Anonymous
    {
        uint cbStruct;
        uint cbSize;
    }
    WTD_GENERIC_CHAIN_POLICY_CREATE_INFO* pSignerChainInfo;
    WTD_GENERIC_CHAIN_POLICY_CREATE_INFO* pCounterSignerChainInfo;
    PFN_WTD_GENERIC_CHAIN_POLICY_CALLBACK pfnPolicyCallback;
    void* pvPolicyArg;
}

struct DRIVER_VER_MAJORMINOR
{
    uint dwMajor;
    uint dwMinor;
}

struct DRIVER_VER_INFO
{
    uint                 cbStruct;
    size_t               dwReserved1;
    size_t               dwReserved2;
    uint                 dwPlatform;
    uint                 dwVersion;
    wchar[260]           wszVersion;
    wchar[260]           wszSignedBy;
    const(CERT_CONTEXT)* pcSignerCertContext;
    DRIVER_VER_MAJORMINOR sOSVersionLow;
    DRIVER_VER_MAJORMINOR sOSVersionHigh;
    uint                 dwBuildNumberLow;
    uint                 dwBuildNumberHigh;
}

struct CONFIG_CI_PROV_INFO_RESULT
{
    HRESULT hr;
    uint    dwResult;
    uint    dwPolicyIndex;
    BOOLEAN fIsExplicitDeny;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CONFIG_CI_PROV_INFO_RESULT2
{
    uint    cbSize;
    HRESULT hr;
    uint    dwResult;
    uint    dwPolicyIndex;
    BOOLEAN fIsExplicitDeny;
    uint    cbCalculatedFileHash;
    ubyte*  pbCalculatedFileHash;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CONFIG_CI_PROV_INFO
{
    uint                cbSize;
    uint                dwPolicies;
    CRYPT_INTEGER_BLOB* pPolicies;
    CONFIG_CI_PROV_INFO_RESULT result;
    uint                dwScenario;
    CONFIG_CI_PROV_INFO_RESULT2* result2;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-winverifytrust))], [])
@DllImport("WINTRUST.dll")
int WinVerifyTrust(HWND hwnd, GUID* pgActionID, void* pWVTData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-winverifytrustex))], [])
@DllImport("WINTRUST.dll")
int WinVerifyTrustEx(HWND hwnd, GUID* pgActionID, WINTRUST_DATA* pWinTrustData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wintrustgetregpolicyflags))], [])
@DllImport("WINTRUST.dll")
void WintrustGetRegPolicyFlags(WINTRUST_POLICY_FLAGS* pdwPolicyFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wintrustsetregpolicyflags))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustSetRegPolicyFlags(WINTRUST_POLICY_FLAGS dwPolicyFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wintrustaddactionid))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustAddActionID(GUID* pgActionID, uint fdwFlags, CRYPT_REGISTER_ACTIONID* psProvInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wintrustremoveactionid))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustRemoveActionID(GUID* pgActionID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wintrustloadfunctionpointers))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustLoadFunctionPointers(GUID* pgActionID, CRYPT_PROVIDER_FUNCTIONS* pPfns);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wintrustadddefaultforusage))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustAddDefaultForUsage(const(PSTR) pszUsageOID, CRYPT_PROVIDER_REGDEFUSAGE* psDefUsage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wintrustgetdefaultforusage))], [])
@DllImport("WINTRUST.dll")
BOOL WintrustGetDefaultForUsage(WINTRUST_GET_DEFAULT_FOR_USAGE_ACTION dwAction, const(PSTR) pszUsageOID, 
                                CRYPT_PROVIDER_DEFUSAGE* psUsage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wthelpergetprovsignerfromchain))], [])
@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_SGNR* WTHelperGetProvSignerFromChain(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, 
                                                    BOOL fCounterSigner, uint idxCounterSigner);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wthelpergetprovcertfromchain))], [])
@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_CERT* WTHelperGetProvCertFromChain(CRYPT_PROVIDER_SGNR* pSgnr, uint idxCert);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wthelperprovdatafromstatedata))], [])
@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_DATA* WTHelperProvDataFromStateData(HANDLE hStateData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wthelpergetprovprivatedatafromchain))], [])
@DllImport("WINTRUST.dll")
CRYPT_PROVIDER_PRIVDATA* WTHelperGetProvPrivateDataFromChain(CRYPT_PROVIDER_DATA* pProvData, GUID* pgProviderID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wthelpercertisselfsigned))], [])
@DllImport("WINTRUST.dll")
BOOL WTHelperCertIsSelfSigned(uint dwEncoding, CERT_INFO* pCert);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wthelpercertcheckvalidsignature))], [])
@DllImport("WINTRUST.dll")
HRESULT WTHelperCertCheckValidSignature(CRYPT_PROVIDER_DATA* pProvData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-openpersonaltrustdbdialogex))], [])
@DllImport("WINTRUST.dll")
BOOL OpenPersonalTrustDBDialogEx(HWND hwndParent, uint dwFlags, void** pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-openpersonaltrustdbdialog))], [])
@DllImport("WINTRUST.dll")
BOOL OpenPersonalTrustDBDialog(HWND hwndParent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wintrust/nf-wintrust-wintrustsetdefaultincludepepagehashes))], [])
@DllImport("WINTRUST.dll")
void WintrustSetDefaultIncludePEPageHashes(BOOL fIncludePEPageHashes);


