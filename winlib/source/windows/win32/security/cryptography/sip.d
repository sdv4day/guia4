// Written in the D programming language.

module windows.win32.security.cryptography.sip;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, PWSTR;
public import windows.win32.security.cryptography : CERT_QUERY_ENCODING_TYPE, CRYPT_ALGORITHM_IDENTIFIER,
                                                    CRYPT_ATTRIBUTE_TYPE_VALUE, CRYPT_INTEGER_BLOB;
public import windows.win32.security.cryptography.catalog : MS_ADDINFO_CATALOGMEMBER;

extern(Windows) @nogc nothrow:


// Constants


enum uint MSSIP_FLAGS_PROHIBIT_RESIZE_ON_CREATE = 0x00010000;
enum uint MSSIP_FLAGS_MULTI_HASH = 0x00040000;
enum uint SPC_MARKER_CHECK_SKIP_SIP_INDIRECT_DATA_FLAG = 0x00000001;

enum : uint
{
    MSSIP_ADDINFO_NONE        = 0x00000000,
    MSSIP_ADDINFO_FLAT        = 0x00000001,
    MSSIP_ADDINFO_CATMEMBER   = 0x00000002,
    MSSIP_ADDINFO_BLOB        = 0x00000003,
    MSSIP_ADDINFO_DETACHEDSIG = 0x00000004,
    MSSIP_ADDINFO_NONMSSIP    = 0x000001f4,
}

enum : uint
{
    SIP_CAP_SET_VERSION_3 = 0x00000003,
    SIP_CAP_SET_CUR_VER   = 0x00000003,
    SIP_CAP_FLAG_SEALING  = 0x00000001,
}

// Callbacks

alias pCryptSIPGetSignedDataMsg = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint* pdwEncodingType, uint dwIndex, 
                                                uint* pcbSignedDataMsg, ubyte* pbSignedDataMsg);
alias pCryptSIPPutSignedDataMsg = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint dwEncodingType, uint* pdwIndex, 
                                                uint cbSignedDataMsg, ubyte* pbSignedDataMsg);
alias pCryptSIPCreateIndirectData = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint* pcbIndirectData, 
                                                  SIP_INDIRECT_DATA* pIndirectData);
alias pCryptSIPVerifyIndirectData = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, SIP_INDIRECT_DATA* pIndirectData);
alias pCryptSIPRemoveSignedDataMsg = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint dwIndex);
alias pfnIsFileSupported = BOOL function(HANDLE hFile, GUID* pgSubject);
alias pfnIsFileSupportedName = BOOL function(PWSTR pwszFileName, GUID* pgSubject);
alias pCryptSIPGetCaps = BOOL function(SIP_SUBJECTINFO* pSubjInfo, SIP_CAP_SET_V3* pCaps);
alias pCryptSIPGetSealedDigest = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, const(ubyte)* pSig, uint dwSig, 
                                               ubyte* pbDigest, uint* pcbDigest);

// Structs


//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/ns-mssip-sip_subjectinfo))], [])
struct SIP_SUBJECTINFO
{
    uint         cbSize;
    GUID*        pgSubjectType;
    HANDLE       hFile;
    const(PWSTR) pwsFileName;
    const(PWSTR) pwsDisplayName;
    uint         dwReserved1;
    uint         dwIntVersion;
    size_t       hProv;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    uint         dwFlags;
    uint         dwEncodingType;
    uint         dwReserved2;
    uint         fdwCAPISettings;
    uint         fdwSecuritySettings;
    uint         dwIndex;
    uint         dwUnionChoice;
union Anonymous
    {
        MS_ADDINFO_FLAT* psFlat;
        MS_ADDINFO_CATALOGMEMBER* psCatMember;
        MS_ADDINFO_BLOB* psBlob;
        MS_ADDINFO_DETACHEDSIG* psDetachedSig;
    }
    void*        pClientData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/ns-mssip-ms_addinfo_flat))], [])
struct MS_ADDINFO_FLAT
{
    uint               cbStruct;
    SIP_INDIRECT_DATA* pIndirectData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/ns-mssip-ms_addinfo_blob))], [])
struct MS_ADDINFO_BLOB
{
    uint   cbStruct;
    uint   cbMemObject;
    ubyte* pbMemObject;
    uint   cbMemSignedMsg;
    ubyte* pbMemSignedMsg;
}

struct MS_ADDINFO_DETACHEDSIG
{
    uint   cbStruct;
    HANDLE hSignatureFile;
    uint   cbSignatureObject;
    ubyte* pbSignatureObject;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/ns-mssip-sip_cap_set_v2))], [])
struct SIP_CAP_SET_V2
{
    uint cbSize;
    uint dwVersion;
    BOOL isMultiSign;
    uint dwReserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/ns-mssip-sip_cap_set_v3))], [])
struct SIP_CAP_SET_V3
{
    uint cbSize;
    uint dwVersion;
    BOOL isMultiSign;
union Anonymous
    {
        uint dwFlags;
        uint dwReserved;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/ns-mssip-sip_indirect_data))], [])
struct SIP_INDIRECT_DATA
{
    CRYPT_ATTRIBUTE_TYPE_VALUE Data;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    CRYPT_INTEGER_BLOB Digest;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/ns-mssip-sip_dispatch_info))], [])
struct SIP_DISPATCH_INFO
{
    uint   cbSize;
    HANDLE hSIP;
    pCryptSIPGetSignedDataMsg pfGet;
    pCryptSIPPutSignedDataMsg pfPut;
    pCryptSIPCreateIndirectData pfCreate;
    pCryptSIPVerifyIndirectData pfVerify;
    pCryptSIPRemoveSignedDataMsg pfRemove;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/ns-mssip-sip_add_newprovider))], [])
struct SIP_ADD_NEWPROVIDER
{
    uint  cbStruct;
    GUID* pgSubject;
    PWSTR pwszDLLFileName;
    PWSTR pwszMagicNumber;
    PWSTR pwszIsFunctionName;
    PWSTR pwszGetFuncName;
    PWSTR pwszPutFuncName;
    PWSTR pwszCreateFuncName;
    PWSTR pwszVerifyFuncName;
    PWSTR pwszRemoveFuncName;
    PWSTR pwszIsFunctionNameFmt2;
    PWSTR pwszGetCapFuncName;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipgetsigneddatamsg))], [])
@DllImport("WINTRUST.dll")
BOOL CryptSIPGetSignedDataMsg(SIP_SUBJECTINFO* pSubjectInfo, CERT_QUERY_ENCODING_TYPE* pdwEncodingType, 
                              uint dwIndex, uint* pcbSignedDataMsg, ubyte* pbSignedDataMsg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipputsigneddatamsg))], [])
@DllImport("WINTRUST.dll")
BOOL CryptSIPPutSignedDataMsg(SIP_SUBJECTINFO* pSubjectInfo, CERT_QUERY_ENCODING_TYPE dwEncodingType, 
                              uint* pdwIndex, uint cbSignedDataMsg, ubyte* pbSignedDataMsg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipcreateindirectdata))], [])
@DllImport("WINTRUST.dll")
BOOL CryptSIPCreateIndirectData(SIP_SUBJECTINFO* pSubjectInfo, uint* pcbIndirectData, 
                                SIP_INDIRECT_DATA* pIndirectData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipverifyindirectdata))], [])
@DllImport("WINTRUST.dll")
BOOL CryptSIPVerifyIndirectData(SIP_SUBJECTINFO* pSubjectInfo, SIP_INDIRECT_DATA* pIndirectData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipremovesigneddatamsg))], [])
@DllImport("WINTRUST.dll")
BOOL CryptSIPRemoveSignedDataMsg(SIP_SUBJECTINFO* pSubjectInfo, uint dwIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipload))], [])
@DllImport("CRYPT32.dll")
BOOL CryptSIPLoad(const(GUID)* pgSubject, uint dwFlags, SIP_DISPATCH_INFO* pSipDispatch);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipretrievesubjectguid))], [])
@DllImport("CRYPT32.dll")
BOOL CryptSIPRetrieveSubjectGuid(const(PWSTR) FileName, HANDLE hFileIn, GUID* pgSubject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipretrievesubjectguidforcatalogfile))], [])
@DllImport("CRYPT32.dll")
BOOL CryptSIPRetrieveSubjectGuidForCatalogFile(const(PWSTR) FileName, HANDLE hFileIn, GUID* pgSubject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipaddprovider))], [])
@DllImport("CRYPT32.dll")
BOOL CryptSIPAddProvider(SIP_ADD_NEWPROVIDER* psNewProv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipremoveprovider))], [])
@DllImport("CRYPT32.dll")
BOOL CryptSIPRemoveProvider(GUID* pgProv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mssip/nf-mssip-cryptsipgetcaps))], [])
@DllImport("WINTRUST.dll")
BOOL CryptSIPGetCaps(SIP_SUBJECTINFO* pSubjInfo, SIP_CAP_SET_V3* pCaps);

@DllImport("WINTRUST.dll")
BOOL CryptSIPGetSealedDigest(SIP_SUBJECTINFO* pSubjectInfo, const(ubyte)* pSig, uint dwSig, ubyte* pbDigest, 
                             uint* pcbDigest);


