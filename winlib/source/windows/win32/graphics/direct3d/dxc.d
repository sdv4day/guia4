// Written in the D programming language.

module windows.win32.graphics.direct3d.dxc;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HRESULT, PSTR, PWSTR;
public import windows.win32.system.com : IMalloc, IStream, IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias DXC_CP = uint;
enum : uint
{
    DXC_CP_ACP   = 0x00000000,
    DXC_CP_UTF16 = 0x000004b0,
    DXC_CP_UTF8  = 0x0000fde9,
    DXC_CP_UTF32 = 0x00002ee0,
    DXC_CP_WIDE  = 0x000004b0,
}

alias DXC_OUT_KIND = int;
enum : int
{
    DXC_OUT_NONE           = 0x00000000,
    DXC_OUT_OBJECT         = 0x00000001,
    DXC_OUT_ERRORS         = 0x00000002,
    DXC_OUT_PDB            = 0x00000003,
    DXC_OUT_SHADER_HASH    = 0x00000004,
    DXC_OUT_DISASSEMBLY    = 0x00000005,
    DXC_OUT_HLSL           = 0x00000006,
    DXC_OUT_TEXT           = 0x00000007,
    DXC_OUT_REFLECTION     = 0x00000008,
    DXC_OUT_ROOT_SIGNATURE = 0x00000009,
    DXC_OUT_EXTRA_OUTPUTS  = 0x0000000a,
    DXC_OUT_REMARKS        = 0x0000000b,
    DXC_OUT_TIME_REPORT    = 0x0000000c,
    DXC_OUT_TIME_TRACE     = 0x0000000d,
    DXC_OUT_LAST           = 0x0000000d,
    DXC_OUT_NUM_ENUMS      = 0x0000000e,
}

// Constants


enum uint DXC_HASHFLAG_INCLUDES_SOURCE = 0x00000001;

enum : const(wchar)*
{
    DXC_ARG_SKIP_VALIDATION    = "-Vd",
    DXC_ARG_SKIP_OPTIMIZATIONS = "-Od",
}

enum const(wchar)* DXC_ARG_PACK_MATRIX_COLUMN_MAJOR = "-Zpc";
enum const(wchar)* DXC_ARG_PREFER_FLOW_CONTROL = "-Gfp";
enum const(wchar)* DXC_ARG_ENABLE_BACKWARDS_COMPATIBILITY = "-Gec";

enum : const(wchar)*
{
    DXC_ARG_OPTIMIZATION_LEVEL0 = "-O0",
    DXC_ARG_OPTIMIZATION_LEVEL1 = "-O1",
    DXC_ARG_OPTIMIZATION_LEVEL2 = "-O2",
    DXC_ARG_OPTIMIZATION_LEVEL3 = "-O3",
}

enum const(wchar)* DXC_ARG_RESOURCES_MAY_ALIAS = "-res_may_alias";

enum : const(wchar)*
{
    DXC_ARG_DEBUG_NAME_FOR_SOURCE = "-Zss",
    DXC_ARG_DEBUG_NAME_FOR_BINARY = "-Zsb",
}

enum const(wchar)* DXC_EXTRA_OUTPUT_NAME_STDERR = "*stderr*";

enum : uint
{
    DxcValidatorFlags_InPlaceEdit       = 0x00000001,
    DxcValidatorFlags_RootSignatureOnly = 0x00000002,
    DxcValidatorFlags_ModuleOnly        = 0x00000004,
    DxcValidatorFlags_ValidMask         = 0x00000007,
}

enum : uint
{
    DxcVersionInfoFlags_Debug    = 0x00000001,
    DxcVersionInfoFlags_Internal = 0x00000002,
}

// Callbacks

alias DxcCreateInstanceProc = HRESULT function(const(GUID)* rclsid, const(GUID)* riid, void** ppv);
alias DxcCreateInstance2Proc = HRESULT function(IMalloc pMalloc, const(GUID)* rclsid, const(GUID)* riid, 
                                                void** ppv);

// Structs


struct DxcShaderHash
{
    uint      Flags;
    ubyte[16] HashDigest;
}

struct DxcBuffer
{
    const(void)* Ptr;
    size_t       Size;
    uint         Encoding;
}

struct DxcDefine
{
    const(PWSTR) Name;
    const(PWSTR) Value;
}

struct DxcArgPair
{
    const(PWSTR) pName;
    const(PWSTR) pValue;
}

// Functions

@DllImport("dxcompiler.dll")
HRESULT DxcCreateInstance(const(GUID)* rclsid, const(GUID)* riid, void** ppv);

@DllImport("dxcompiler.dll")
HRESULT DxcCreateInstance2(IMalloc pMalloc, const(GUID)* rclsid, const(GUID)* riid, void** ppv);


// Interfaces

@GUID("8ba5fb08-5195-40e2-ac58-0d989c3a0102")
interface IDxcBlob : IUnknown
{
    void*  GetBufferPointer();
    size_t GetBufferSize();
}

@GUID("7241d424-2646-4191-97c0-98e96e42fc68")
interface IDxcBlobEncoding : IDxcBlob
{
    HRESULT GetEncoding(BOOL* pKnown, DXC_CP* pCodePage);
}

@GUID("a3f84eab-0faa-497e-a39c-ee6ed60b2d84")
interface IDxcBlobUtf16 : IDxcBlobEncoding
{
    PWSTR  GetStringPointer();
    size_t GetStringLength();
}

@GUID("3da636c9-ba71-4024-a301-30cbf125305b")
interface IDxcBlobUtf8 : IDxcBlobEncoding
{
    PSTR   GetStringPointer();
    size_t GetStringLength();
}

@GUID("7f61fc7d-950d-467f-b3e3-3c02fb49187c")
interface IDxcIncludeHandler : IUnknown
{
    HRESULT LoadSource(const(PWSTR) pFilename, IDxcBlob* ppIncludeSource);
}

@GUID("73effe2a-70dc-45f8-9690-eff64c02429d")
interface IDxcCompilerArgs : IUnknown
{
    PWSTR*  GetArguments();
    uint    GetCount();
    HRESULT AddArguments(const(PWSTR)* pArguments, uint argCount);
    HRESULT AddArgumentsUTF8(const(PSTR)* pArguments, uint argCount);
    HRESULT AddDefines(const(DxcDefine)* pDefines, uint defineCount);
}

@GUID("e5204dc7-d18c-4c3c-bdfb-851673980fe7")
interface IDxcLibrary : IUnknown
{
    HRESULT SetMalloc(IMalloc pMalloc);
    HRESULT CreateBlobFromBlob(IDxcBlob pBlob, uint offset, uint length, IDxcBlob* ppResult);
    HRESULT CreateBlobFromFile(const(PWSTR) pFileName, DXC_CP* codePage, IDxcBlobEncoding* pBlobEncoding);
    HRESULT CreateBlobWithEncodingFromPinned(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pText, 
                                             uint size, DXC_CP codePage, IDxcBlobEncoding* pBlobEncoding);
    HRESULT CreateBlobWithEncodingOnHeapCopy(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pText, 
                                             uint size, DXC_CP codePage, IDxcBlobEncoding* pBlobEncoding);
    HRESULT CreateBlobWithEncodingOnMalloc(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pText, 
                                           IMalloc pIMalloc, uint size, DXC_CP codePage, 
                                           IDxcBlobEncoding* pBlobEncoding);
    HRESULT CreateIncludeHandler(IDxcIncludeHandler* ppResult);
    HRESULT CreateStreamFromBlobReadOnly(IDxcBlob pBlob, IStream* ppStream);
    HRESULT GetBlobAsUtf8(IDxcBlob pBlob, IDxcBlobEncoding* pBlobEncoding);
    HRESULT GetBlobAsWide(IDxcBlob pBlob, IDxcBlobEncoding* pBlobEncoding);
}

@GUID("cedb484a-d4e9-445a-b991-ca21ca157dc2")
interface IDxcOperationResult : IUnknown
{
    HRESULT GetStatus(HRESULT* pStatus);
    HRESULT GetResult(IDxcBlob* ppResult);
    HRESULT GetErrorBuffer(IDxcBlobEncoding* ppErrors);
}

@GUID("8c210bf3-011f-4422-8d70-6f9acb8db617")
interface IDxcCompiler : IUnknown
{
    HRESULT Compile(IDxcBlob pSource, const(PWSTR) pSourceName, const(PWSTR) pEntryPoint, 
                    const(PWSTR) pTargetProfile, const(PWSTR)* pArguments, uint argCount, const(DxcDefine)* pDefines, 
                    uint defineCount, IDxcIncludeHandler pIncludeHandler, IDxcOperationResult* ppResult);
    HRESULT Preprocess(IDxcBlob pSource, const(PWSTR) pSourceName, const(PWSTR)* pArguments, uint argCount, 
                       const(DxcDefine)* pDefines, uint defineCount, IDxcIncludeHandler pIncludeHandler, 
                       IDxcOperationResult* ppResult);
    HRESULT Disassemble(IDxcBlob pSource, IDxcBlobEncoding* ppDisassembly);
}

@GUID("a005a9d9-b8bb-4594-b5c9-0e633bec4d37")
interface IDxcCompiler2 : IDxcCompiler
{
    HRESULT CompileWithDebug(IDxcBlob pSource, const(PWSTR) pSourceName, const(PWSTR) pEntryPoint, 
                             const(PWSTR) pTargetProfile, const(PWSTR)* pArguments, uint argCount, 
                             const(DxcDefine)* pDefines, uint defineCount, IDxcIncludeHandler pIncludeHandler, 
                             IDxcOperationResult* ppResult, PWSTR* ppDebugBlobName, IDxcBlob* ppDebugBlob);
}

@GUID("f1b5be2a-62dd-4327-a1c2-42ac1e1e78e6")
interface IDxcLinker : IUnknown
{
    HRESULT RegisterLibrary(const(PWSTR) pLibName, IDxcBlob pLib);
    HRESULT Link(const(PWSTR) pEntryName, const(PWSTR) pTargetProfile, const(PWSTR)* pLibNames, uint libCount, 
                 const(PWSTR)* pArguments, uint argCount, IDxcOperationResult* ppResult);
}

@GUID("4605c4cb-2019-492a-ada4-65f20bb7d67f")
interface IDxcUtils : IUnknown
{
    HRESULT CreateBlobFromBlob(IDxcBlob pBlob, uint offset, uint length, IDxcBlob* ppResult);
    HRESULT CreateBlobFromPinned(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pData, 
                                 uint size, DXC_CP codePage, IDxcBlobEncoding* ppBlobEncoding);
    HRESULT MoveToBlob(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pData, 
                       IMalloc pIMalloc, uint size, DXC_CP codePage, IDxcBlobEncoding* ppBlobEncoding);
    HRESULT CreateBlob(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pData, 
                       uint size, DXC_CP codePage, IDxcBlobEncoding* ppBlobEncoding);
    HRESULT LoadFile(const(PWSTR) pFileName, DXC_CP* pCodePage, IDxcBlobEncoding* ppBlobEncoding);
    HRESULT CreateReadOnlyStreamFromBlob(IDxcBlob pBlob, IStream* ppStream);
    HRESULT CreateDefaultIncludeHandler(IDxcIncludeHandler* ppResult);
    HRESULT GetBlobAsUtf8(IDxcBlob pBlob, IDxcBlobUtf8* ppBlobEncoding);
    HRESULT GetBlobAsWide(IDxcBlob pBlob, IDxcBlobUtf16* ppBlobEncoding);
    HRESULT GetDxilContainerPart(const(DxcBuffer)* pShader, uint DxcPart, void** ppPartData, 
                                 uint* pPartSizeInBytes);
    HRESULT CreateReflection(const(DxcBuffer)* pData, const(GUID)* iid, void** ppvReflection);
    HRESULT BuildArguments(const(PWSTR) pSourceName, const(PWSTR) pEntryPoint, const(PWSTR) pTargetProfile, 
                           const(PWSTR)* pArguments, uint argCount, const(DxcDefine)* pDefines, uint defineCount, 
                           IDxcCompilerArgs* ppArgs);
    HRESULT GetPDBContents(IDxcBlob pPDBBlob, IDxcBlob* ppHash, IDxcBlob* ppContainer);
}

@GUID("58346cda-dde7-4497-9461-6f87af5e0659")
interface IDxcResult : IDxcOperationResult
{
    BOOL    HasOutput(DXC_OUT_KIND dxcOutKind);
    HRESULT GetOutput(DXC_OUT_KIND dxcOutKind, const(GUID)* iid, void** ppvObject, IDxcBlobUtf16* ppOutputName);
    uint    GetNumOutputs();
    DXC_OUT_KIND GetOutputByIndex(uint Index);
    DXC_OUT_KIND PrimaryOutput();
}

@GUID("319b37a2-a5c2-494a-a5de-4801b2faf989")
interface IDxcExtraOutputs : IUnknown
{
    uint    GetOutputCount();
    HRESULT GetOutput(uint uIndex, const(GUID)* iid, void** ppvObject, IDxcBlobUtf16* ppOutputType, 
                      IDxcBlobUtf16* ppOutputName);
}

@GUID("228b4687-5a6a-4730-900c-9702b2203f54")
interface IDxcCompiler3 : IUnknown
{
    HRESULT Compile(const(DxcBuffer)* pSource, const(PWSTR)* pArguments, uint argCount, 
                    IDxcIncludeHandler pIncludeHandler, const(GUID)* riid, void** ppResult);
    HRESULT Disassemble(const(DxcBuffer)* pObject, const(GUID)* riid, void** ppResult);
}

@GUID("a6e82bd2-1fd7-4826-9811-2857e797f49a")
interface IDxcValidator : IUnknown
{
    HRESULT Validate(IDxcBlob pShader, uint Flags, IDxcOperationResult* ppResult);
}

@GUID("458e1fd1-b1b2-4750-a6e1-9c10f03bed92")
interface IDxcValidator2 : IDxcValidator
{
    HRESULT ValidateWithDebug(IDxcBlob pShader, uint Flags, DxcBuffer* pOptDebugBitcode, 
                              IDxcOperationResult* ppResult);
}

@GUID("334b1f50-2292-4b35-99a1-25588d8c17fe")
interface IDxcContainerBuilder : IUnknown
{
    HRESULT Load(IDxcBlob pDxilContainerHeader);
    HRESULT AddPart(uint fourCC, IDxcBlob pSource);
    HRESULT RemovePart(uint fourCC);
    HRESULT SerializeContainer(IDxcOperationResult* ppResult);
}

@GUID("091f7a26-1c1f-4948-904b-e6e3a8a771d5")
interface IDxcAssembler : IUnknown
{
    HRESULT AssembleToContainer(IDxcBlob pShader, IDxcOperationResult* ppResult);
}

@GUID("d2c21b26-8350-4bdc-976a-331ce6f4c54c")
interface IDxcContainerReflection : IUnknown
{
    HRESULT Load(IDxcBlob pContainer);
    HRESULT GetPartCount(uint* pResult);
    HRESULT GetPartKind(uint idx, uint* pResult);
    HRESULT GetPartContent(uint idx, IDxcBlob* ppResult);
    HRESULT FindFirstPartKind(uint kind, uint* pResult);
    HRESULT GetPartReflection(uint idx, const(GUID)* iid, void** ppvObject);
}

@GUID("ae2cd79f-cc22-453f-9b6b-b124e7a5204c")
interface IDxcOptimizerPass : IUnknown
{
    HRESULT GetOptionName(PWSTR* ppResult);
    HRESULT GetDescription(PWSTR* ppResult);
    HRESULT GetOptionArgCount(uint* pCount);
    HRESULT GetOptionArgName(uint argIndex, PWSTR* ppResult);
    HRESULT GetOptionArgDescription(uint argIndex, PWSTR* ppResult);
}

@GUID("25740e2e-9cba-401b-9119-4fb42f39f270")
interface IDxcOptimizer : IUnknown
{
    HRESULT GetAvailablePassCount(uint* pCount);
    HRESULT GetAvailablePass(uint index, IDxcOptimizerPass* ppResult);
    HRESULT RunOptimizer(IDxcBlob pBlob, const(PWSTR)* ppOptions, uint optionCount, IDxcBlob* pOutputModule, 
                         IDxcBlobEncoding* ppOutputText);
}

@GUID("b04f5b50-2059-4f12-a8ff-a1e0cde1cc7e")
interface IDxcVersionInfo : IUnknown
{
    HRESULT GetVersion(uint* pMajor, uint* pMinor);
    HRESULT GetFlags(uint* pFlags);
}

@GUID("fb6904c4-42f0-4b62-9c46-983af7da7c83")
interface IDxcVersionInfo2 : IDxcVersionInfo
{
    HRESULT GetCommitInfo(uint* pCommitCount, byte** pCommitHash);
}

@GUID("5e13e843-9d25-473c-9ad2-03b2d0b44b1e")
interface IDxcVersionInfo3 : IUnknown
{
    HRESULT GetCustomVersionString(byte** pVersionString);
}

@GUID("e6c9647e-9d6a-4c3b-b94c-524b5a6c343d")
interface IDxcPdbUtils : IUnknown
{
    HRESULT Load(IDxcBlob pPdbOrDxil);
    HRESULT GetSourceCount(uint* pCount);
    HRESULT GetSource(uint uIndex, IDxcBlobEncoding* ppResult);
    HRESULT GetSourceName(uint uIndex, BSTR* pResult);
    HRESULT GetFlagCount(uint* pCount);
    HRESULT GetFlag(uint uIndex, BSTR* pResult);
    HRESULT GetArgCount(uint* pCount);
    HRESULT GetArg(uint uIndex, BSTR* pResult);
    HRESULT GetArgPairCount(uint* pCount);
    HRESULT GetArgPair(uint uIndex, BSTR* pName, BSTR* pValue);
    HRESULT GetDefineCount(uint* pCount);
    HRESULT GetDefine(uint uIndex, BSTR* pResult);
    HRESULT GetTargetProfile(BSTR* pResult);
    HRESULT GetEntryPoint(BSTR* pResult);
    HRESULT GetMainFileName(BSTR* pResult);
    HRESULT GetHash(IDxcBlob* ppResult);
    HRESULT GetName(BSTR* pResult);
    BOOL    IsFullPDB();
    HRESULT GetFullPDB(IDxcBlob* ppFullPDB);
    HRESULT GetVersionInfo(IDxcVersionInfo* ppVersionInfo);
    HRESULT SetCompiler(IDxcCompiler3 pCompiler);
    HRESULT CompileForFullPDB(IDxcResult* ppResult);
    HRESULT OverrideArgs(DxcArgPair* pArgPairs, uint uNumArgPairs);
    HRESULT OverrideRootSignature(const(PWSTR) pRootSignature);
}

@GUID("4315d938-f369-4f93-95a2-252017cc3807")
interface IDxcPdbUtils2 : IUnknown
{
    HRESULT Load(IDxcBlob pPdbOrDxil);
    HRESULT GetSourceCount(uint* pCount);
    HRESULT GetSource(uint uIndex, IDxcBlobEncoding* ppResult);
    HRESULT GetSourceName(uint uIndex, IDxcBlobUtf16* ppResult);
    HRESULT GetLibraryPDBCount(uint* pCount);
    HRESULT GetLibraryPDB(uint uIndex, IDxcPdbUtils2* ppOutPdbUtils, IDxcBlobUtf16* ppLibraryName);
    HRESULT GetFlagCount(uint* pCount);
    HRESULT GetFlag(uint uIndex, IDxcBlobUtf16* ppResult);
    HRESULT GetArgCount(uint* pCount);
    HRESULT GetArg(uint uIndex, IDxcBlobUtf16* ppResult);
    HRESULT GetArgPairCount(uint* pCount);
    HRESULT GetArgPair(uint uIndex, IDxcBlobUtf16* ppName, IDxcBlobUtf16* ppValue);
    HRESULT GetDefineCount(uint* pCount);
    HRESULT GetDefine(uint uIndex, IDxcBlobUtf16* ppResult);
    HRESULT GetTargetProfile(IDxcBlobUtf16* ppResult);
    HRESULT GetEntryPoint(IDxcBlobUtf16* ppResult);
    HRESULT GetMainFileName(IDxcBlobUtf16* ppResult);
    HRESULT GetHash(IDxcBlob* ppResult);
    HRESULT GetName(IDxcBlobUtf16* ppResult);
    HRESULT GetVersionInfo(IDxcVersionInfo* ppVersionInfo);
    HRESULT GetCustomToolchainID(uint* pID);
    HRESULT GetCustomToolchainData(IDxcBlob* ppBlob);
    HRESULT GetWholeDxil(IDxcBlob* ppResult);
    BOOL    IsFullPDB();
    BOOL    IsPDBRef();
}


// GUIDs


const GUID IID_IDxcAssembler           = GUIDOF!IDxcAssembler;
const GUID IID_IDxcBlob                = GUIDOF!IDxcBlob;
const GUID IID_IDxcBlobEncoding        = GUIDOF!IDxcBlobEncoding;
const GUID IID_IDxcBlobUtf16           = GUIDOF!IDxcBlobUtf16;
const GUID IID_IDxcBlobUtf8            = GUIDOF!IDxcBlobUtf8;
const GUID IID_IDxcCompiler            = GUIDOF!IDxcCompiler;
const GUID IID_IDxcCompiler2           = GUIDOF!IDxcCompiler2;
const GUID IID_IDxcCompiler3           = GUIDOF!IDxcCompiler3;
const GUID IID_IDxcCompilerArgs        = GUIDOF!IDxcCompilerArgs;
const GUID IID_IDxcContainerBuilder    = GUIDOF!IDxcContainerBuilder;
const GUID IID_IDxcContainerReflection = GUIDOF!IDxcContainerReflection;
const GUID IID_IDxcExtraOutputs        = GUIDOF!IDxcExtraOutputs;
const GUID IID_IDxcIncludeHandler      = GUIDOF!IDxcIncludeHandler;
const GUID IID_IDxcLibrary             = GUIDOF!IDxcLibrary;
const GUID IID_IDxcLinker              = GUIDOF!IDxcLinker;
const GUID IID_IDxcOperationResult     = GUIDOF!IDxcOperationResult;
const GUID IID_IDxcOptimizer           = GUIDOF!IDxcOptimizer;
const GUID IID_IDxcOptimizerPass       = GUIDOF!IDxcOptimizerPass;
const GUID IID_IDxcPdbUtils            = GUIDOF!IDxcPdbUtils;
const GUID IID_IDxcPdbUtils2           = GUIDOF!IDxcPdbUtils2;
const GUID IID_IDxcResult              = GUIDOF!IDxcResult;
const GUID IID_IDxcUtils               = GUIDOF!IDxcUtils;
const GUID IID_IDxcValidator           = GUIDOF!IDxcValidator;
const GUID IID_IDxcValidator2          = GUIDOF!IDxcValidator2;
const GUID IID_IDxcVersionInfo         = GUIDOF!IDxcVersionInfo;
const GUID IID_IDxcVersionInfo2        = GUIDOF!IDxcVersionInfo2;
const GUID IID_IDxcVersionInfo3        = GUIDOF!IDxcVersionInfo3;
