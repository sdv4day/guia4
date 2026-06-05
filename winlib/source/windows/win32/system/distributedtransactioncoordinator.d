// Written in the D programming language.

module windows.win32.system.distributedtransactioncoordinator;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, FILETIME, HANDLE, HRESULT, PSTR, PWSTR;
public import windows.win32.system.com : IMoniker, IUnknown;

extern(Windows) @nogc nothrow:


// Enums


alias DTC_STATUS_ = int;
enum : int
{
    DTC_STATUS_UNKNOWN       = 0x00000000,
    DTC_STATUS_STARTING      = 0x00000001,
    DTC_STATUS_STARTED       = 0x00000002,
    DTC_STATUS_PAUSING       = 0x00000003,
    DTC_STATUS_PAUSED        = 0x00000004,
    DTC_STATUS_CONTINUING    = 0x00000005,
    DTC_STATUS_STOPPING      = 0x00000006,
    DTC_STATUS_STOPPED       = 0x00000007,
    DTC_STATUS_E_CANTCONTROL = 0x00000008,
    DTC_STATUS_FAILED        = 0x00000009,
}

alias TX_MISC_CONSTANTS = int;
enum : int
{
    MAX_TRAN_DESC = 0x00000028,
}

alias ISOLATIONLEVEL = int;
enum : int
{
    ISOLATIONLEVEL_UNSPECIFIED     = 0xffffffff,
    ISOLATIONLEVEL_CHAOS           = 0x00000010,
    ISOLATIONLEVEL_READUNCOMMITTED = 0x00000100,
    ISOLATIONLEVEL_BROWSE          = 0x00000100,
    ISOLATIONLEVEL_CURSORSTABILITY = 0x00001000,
    ISOLATIONLEVEL_READCOMMITTED   = 0x00001000,
    ISOLATIONLEVEL_REPEATABLEREAD  = 0x00010000,
    ISOLATIONLEVEL_SERIALIZABLE    = 0x00100000,
    ISOLATIONLEVEL_ISOLATED        = 0x00100000,
}

alias ISOFLAG = int;
enum : int
{
    ISOFLAG_RETAIN_COMMIT_DC = 0x00000001,
    ISOFLAG_RETAIN_COMMIT    = 0x00000002,
    ISOFLAG_RETAIN_COMMIT_NO = 0x00000003,
    ISOFLAG_RETAIN_ABORT_DC  = 0x00000004,
    ISOFLAG_RETAIN_ABORT     = 0x00000008,
    ISOFLAG_RETAIN_ABORT_NO  = 0x0000000c,
    ISOFLAG_RETAIN_DONTCARE  = 0x00000005,
    ISOFLAG_RETAIN_BOTH      = 0x0000000a,
    ISOFLAG_RETAIN_NONE      = 0x0000000f,
    ISOFLAG_OPTIMISTIC       = 0x00000010,
    ISOFLAG_READONLY         = 0x00000020,
}

alias XACTTC = int;
enum : int
{
    XACTTC_NONE           = 0x00000000,
    XACTTC_SYNC_PHASEONE  = 0x00000001,
    XACTTC_SYNC_PHASETWO  = 0x00000002,
    XACTTC_SYNC           = 0x00000002,
    XACTTC_ASYNC_PHASEONE = 0x00000004,
    XACTTC_ASYNC          = 0x00000004,
}

alias XACTRM = int;
enum : int
{
    XACTRM_OPTIMISTICLASTWINS = 0x00000001,
    XACTRM_NOREADONLYPREPARES = 0x00000002,
}

alias XACTCONST = int;
enum : int
{
    XACTCONST_TIMEOUTINFINITE = 0x00000000,
}

alias XACTHEURISTIC = int;
enum : int
{
    XACTHEURISTIC_ABORT  = 0x00000001,
    XACTHEURISTIC_COMMIT = 0x00000002,
    XACTHEURISTIC_DAMAGE = 0x00000003,
    XACTHEURISTIC_DANGER = 0x00000004,
}

alias XACTSTAT = int;
enum : int
{
    XACTSTAT_NONE             = 0x00000000,
    XACTSTAT_OPENNORMAL       = 0x00000001,
    XACTSTAT_OPENREFUSED      = 0x00000002,
    XACTSTAT_PREPARING        = 0x00000004,
    XACTSTAT_PREPARED         = 0x00000008,
    XACTSTAT_PREPARERETAINING = 0x00000010,
    XACTSTAT_PREPARERETAINED  = 0x00000020,
    XACTSTAT_COMMITTING       = 0x00000040,
    XACTSTAT_COMMITRETAINING  = 0x00000080,
    XACTSTAT_ABORTING         = 0x00000100,
    XACTSTAT_ABORTED          = 0x00000200,
    XACTSTAT_COMMITTED        = 0x00000400,
    XACTSTAT_HEURISTIC_ABORT  = 0x00000800,
    XACTSTAT_HEURISTIC_COMMIT = 0x00001000,
    XACTSTAT_HEURISTIC_DAMAGE = 0x00002000,
    XACTSTAT_HEURISTIC_DANGER = 0x00004000,
    XACTSTAT_FORCED_ABORT     = 0x00008000,
    XACTSTAT_FORCED_COMMIT    = 0x00010000,
    XACTSTAT_INDOUBT          = 0x00020000,
    XACTSTAT_CLOSED           = 0x00040000,
    XACTSTAT_OPEN             = 0x00000003,
    XACTSTAT_NOTPREPARED      = 0x0007ffc3,
    XACTSTAT_ALL              = 0x0007ffff,
}

alias AUTHENTICATION_LEVEL = int;
enum : int
{
    NO_AUTHENTICATION_REQUIRED       = 0x00000000,
    INCOMING_AUTHENTICATION_REQUIRED = 0x00000001,
    MUTUAL_AUTHENTICATION_REQUIRED   = 0x00000002,
}

alias APPLICATIONTYPE = int;
enum : int
{
    LOCAL_APPLICATIONTYPE           = 0x00000000,
    CLUSTERRESOURCE_APPLICATIONTYPE = 0x00000001,
}

alias XACT_DTC_CONSTANTS = int;
enum : int
{
    XACT_E_CONNECTION_REQUEST_DENIED = 0x8004d100,
    XACT_E_TOOMANY_ENLISTMENTS       = 0x8004d101,
    XACT_E_DUPLICATE_GUID            = 0x8004d102,
    XACT_E_NOTSINGLEPHASE            = 0x8004d103,
    XACT_E_RECOVERYALREADYDONE       = 0x8004d104,
    XACT_E_PROTOCOL                  = 0x8004d105,
    XACT_E_RM_FAILURE                = 0x8004d106,
    XACT_E_RECOVERY_FAILED           = 0x8004d107,
    XACT_E_LU_NOT_FOUND              = 0x8004d108,
    XACT_E_DUPLICATE_LU              = 0x8004d109,
    XACT_E_LU_NOT_CONNECTED          = 0x8004d10a,
    XACT_E_DUPLICATE_TRANSID         = 0x8004d10b,
    XACT_E_LU_BUSY                   = 0x8004d10c,
    XACT_E_LU_NO_RECOVERY_PROCESS    = 0x8004d10d,
    XACT_E_LU_DOWN                   = 0x8004d10e,
    XACT_E_LU_RECOVERING             = 0x8004d10f,
    XACT_E_LU_RECOVERY_MISMATCH      = 0x8004d110,
    XACT_E_RM_UNAVAILABLE            = 0x8004d111,
    XACT_E_LRMRECOVERYALREADYDONE    = 0x8004d112,
    XACT_E_NOLASTRESOURCEINTERFACE   = 0x8004d113,
    XACT_S_NONOTIFY                  = 0x0004d100,
    XACT_OK_NONOTIFY                 = 0x0004d101,
    dwUSER_MS_SQLSERVER              = 0x0000ffff,
}

alias DTCINITIATEDRECOVERYWORK = int;
enum : int
{
    DTCINITIATEDRECOVERYWORK_CHECKLUSTATUS = 0x00000001,
    DTCINITIATEDRECOVERYWORK_TRANS         = 0x00000002,
    DTCINITIATEDRECOVERYWORK_TMDOWN        = 0x00000003,
}

alias DTCLUXLN = int;
enum : int
{
    DTCLUXLN_COLD = 0x00000001,
    DTCLUXLN_WARM = 0x00000002,
}

alias DTCLUXLNCONFIRMATION = int;
enum : int
{
    DTCLUXLNCONFIRMATION_CONFIRM          = 0x00000001,
    DTCLUXLNCONFIRMATION_LOGNAMEMISMATCH  = 0x00000002,
    DTCLUXLNCONFIRMATION_COLDWARMMISMATCH = 0x00000003,
    DTCLUXLNCONFIRMATION_OBSOLETE         = 0x00000004,
}

alias DTCLUXLNRESPONSE = int;
enum : int
{
    DTCLUXLNRESPONSE_OK_SENDOURXLNBACK   = 0x00000001,
    DTCLUXLNRESPONSE_OK_SENDCONFIRMATION = 0x00000002,
    DTCLUXLNRESPONSE_LOGNAMEMISMATCH     = 0x00000003,
    DTCLUXLNRESPONSE_COLDWARMMISMATCH    = 0x00000004,
}

alias DTCLUXLNERROR = int;
enum : int
{
    DTCLUXLNERROR_PROTOCOL         = 0x00000001,
    DTCLUXLNERROR_LOGNAMEMISMATCH  = 0x00000002,
    DTCLUXLNERROR_COLDWARMMISMATCH = 0x00000003,
}

alias DTCLUCOMPARESTATE = int;
enum : int
{
    DTCLUCOMPARESTATE_COMMITTED          = 0x00000001,
    DTCLUCOMPARESTATE_HEURISTICCOMMITTED = 0x00000002,
    DTCLUCOMPARESTATE_HEURISTICMIXED     = 0x00000003,
    DTCLUCOMPARESTATE_HEURISTICRESET     = 0x00000004,
    DTCLUCOMPARESTATE_INDOUBT            = 0x00000005,
    DTCLUCOMPARESTATE_RESET              = 0x00000006,
}

alias DTCLUCOMPARESTATESCONFIRMATION = int;
enum : int
{
    DTCLUCOMPARESTATESCONFIRMATION_CONFIRM  = 0x00000001,
    DTCLUCOMPARESTATESCONFIRMATION_PROTOCOL = 0x00000002,
}

alias DTCLUCOMPARESTATESERROR = int;
enum : int
{
    DTCLUCOMPARESTATESERROR_PROTOCOL = 0x00000001,
}

alias DTCLUCOMPARESTATESRESPONSE = int;
enum : int
{
    DTCLUCOMPARESTATESRESPONSE_OK       = 0x00000001,
    DTCLUCOMPARESTATESRESPONSE_PROTOCOL = 0x00000002,
}

// Constants


enum int DTCINSTALL_E_CLIENT_ALREADY_INSTALLED = 0x00000180;
enum uint XA_SWITCH_F_DTC = 0x00000001;
enum uint XA_FMTID_DTC_VER1 = 0x01445443;
enum uint MAXGTRIDSIZE = 0x00000040;
enum uint RMNAMESZ = 0x00000020;
enum int TMNOFLAGS = 0x00000000;
enum int TMNOMIGRATE = 0x00000002;
enum int TMASYNC = 0x80000000;
enum int TMFAIL = 0x20000000;
enum int TMRESUME = 0x08000000;
enum int TMSUSPEND = 0x02000000;
enum int TMENDRSCAN = 0x00800000;
enum int TMJOIN = 0x00200000;

enum : uint
{
    TM_JOIN   = 0x00000002,
    TM_RESUME = 0x00000001,
}

enum : int
{
    TMER_TMERR = 0xffffffff,
    TMER_INVAL = 0xfffffffe,
    TMER_PROTO = 0xfffffffd,
}

enum uint XA_RBROLLBACK = 0x00000064;
enum uint XA_RBDEADLOCK = 0x00000066;

enum : uint
{
    XA_RBOTHER     = 0x00000068,
    XA_RBPROTO     = 0x00000069,
    XA_RBTIMEOUT   = 0x0000006a,
    XA_RBTRANSIENT = 0x0000006b,
}

enum uint XA_NOMIGRATE = 0x00000009;

enum : uint
{
    XA_HEURCOM = 0x00000007,
    XA_HEURRB  = 0x00000006,
    XA_HEURMIX = 0x00000005,
}

enum uint XA_RDONLY = 0x00000003;

enum : int
{
    XAER_ASYNC   = 0xfffffffe,
    XAER_RMERR   = 0xfffffffd,
    XAER_NOTA    = 0xfffffffc,
    XAER_INVAL   = 0xfffffffb,
    XAER_PROTO   = 0xfffffffa,
    XAER_RMFAIL  = 0xfffffff9,
    XAER_DUPID   = 0xfffffff8,
    XAER_OUTSIDE = 0xfffffff7,
}

enum uint DTC_INSTALL_OVERWRITE_SERVER = 0x00000002;
enum uint OLE_TM_CONFIG_VERSION_2 = 0x00000002;

enum : uint
{
    OLE_TM_FLAG_NODEMANDSTART            = 0x00000001,
    OLE_TM_FLAG_NOAGILERECOVERY          = 0x00000002,
    OLE_TM_FLAG_QUERY_SERVICE_LOCKSTATUS = 0x80000000,
}

// Callbacks

alias DTC_GET_TRANSACTION_MANAGER = HRESULT function(PSTR pszHost, PSTR pszTmName, const(GUID)* rid, 
                                                     uint dwReserved1, ushort wcbReserved2, void* pvReserved2, 
                                                     void** ppvObject);
//DELEGATE ATTR: AnsiAttribute : CustomAttributeSig([], [])
alias DTC_GET_TRANSACTION_MANAGER_EX_A = HRESULT function(PSTR i_pszHost, PSTR i_pszTmName, const(GUID)* i_riid, 
                                                          uint i_grfOptions, void* i_pvConfigParams, 
                                                          void** o_ppvObject);
//DELEGATE ATTR: UnicodeAttribute : CustomAttributeSig([], [])
alias DTC_GET_TRANSACTION_MANAGER_EX_W = HRESULT function(PWSTR i_pwszHost, PWSTR i_pwszTmName, 
                                                          const(GUID)* i_riid, uint i_grfOptions, 
                                                          void* i_pvConfigParams, void** o_ppvObject);
alias DTC_INSTALL_CLIENT = HRESULT function(byte* i_pszRemoteTmHostName, uint i_dwProtocol, uint i_dwOverwrite);
alias XA_OPEN_EPT = int function(PSTR param0, int param1, int param2);
alias XA_CLOSE_EPT = int function(PSTR param0, int param1, int param2);
alias XA_START_EPT = int function(XID* param0, int param1, int param2);
alias XA_END_EPT = int function(XID* param0, int param1, int param2);
alias XA_ROLLBACK_EPT = int function(XID* param0, int param1, int param2);
alias XA_PREPARE_EPT = int function(XID* param0, int param1, int param2);
alias XA_COMMIT_EPT = int function(XID* param0, int param1, int param2);
alias XA_RECOVER_EPT = int function(XID* param0, int param1, int param2, int param3);
alias XA_FORGET_EPT = int function(XID* param0, int param1, int param2);
alias XA_COMPLETE_EPT = int function(int* param0, int* param1, int param2, int param3);

// Structs


struct BOID
{
    ubyte[16] rgb;
}

struct XACTTRANSINFO
{
    BOID uow;
    int  isoLevel;
    uint isoFlags;
    uint grfTCSupported;
    uint grfRMSupported;
    uint grfTCSupportedRetaining;
    uint grfRMSupportedRetaining;
}

struct XACTSTATS
{
    uint     cOpen;
    uint     cCommitting;
    uint     cCommitted;
    uint     cAborting;
    uint     cAborted;
    uint     cInDoubt;
    uint     cHeuristicDecision;
    FILETIME timeTransactionsUp;
}

struct XACTOPT
{
    uint      ulTimeout;
    ubyte[40] szDescription;
}

struct XID
{
    int       formatID;
    int       gtrid_length;
    int       bqual_length;
    CHAR[128] data;
}

struct xa_switch_t
{
    CHAR[32]  name;
    int       flags;
    int       version_;
    ptrdiff_t xa_open_entry;
    ptrdiff_t xa_close_entry;
    ptrdiff_t xa_start_entry;
    ptrdiff_t xa_end_entry;
    ptrdiff_t xa_rollback_entry;
    ptrdiff_t xa_prepare_entry;
    ptrdiff_t xa_commit_entry;
    ptrdiff_t xa_recover_entry;
    ptrdiff_t xa_forget_entry;
    ptrdiff_t xa_complete_entry;
}

struct OLE_TM_CONFIG_PARAMS_V1
{
    uint dwVersion;
    uint dwcConcurrencyHint;
}

struct OLE_TM_CONFIG_PARAMS_V2
{
    uint            dwVersion;
    uint            dwcConcurrencyHint;
    APPLICATIONTYPE applicationType;
    GUID            clusterResourceId;
}

struct PROXY_CONFIG_PARAMS
{
    ushort wcThreadsMax;
}

// Functions

@DllImport("XOLEHLP.dll")
HRESULT DtcGetTransactionManager(PSTR i_pszHost, PSTR i_pszTmName, const(GUID)* i_riid, uint i_dwReserved1, 
                                 ushort i_wcbReserved2, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* i_pvReserved2, 
                                 void** o_ppvObject);

@DllImport("XOLEHLP.dll")
HRESULT DtcGetTransactionManagerC(PSTR i_pszHost, PSTR i_pszTmName, const(GUID)* i_riid, uint i_dwReserved1, 
                                  ushort i_wcbReserved2, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* i_pvReserved2, 
                                  void** o_ppvObject);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("XOLEHLP.dll")
HRESULT DtcGetTransactionManagerExA(PSTR i_pszHost, PSTR i_pszTmName, const(GUID)* i_riid, uint i_grfOptions, 
                                    void* i_pvConfigParams, void** o_ppvObject);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("XOLEHLP.dll")
HRESULT DtcGetTransactionManagerExW(PWSTR i_pwszHost, PWSTR i_pwszTmName, const(GUID)* i_riid, uint i_grfOptions, 
                                    void* i_pvConfigParams, void** o_ppvObject);


// Interfaces

@GUID("0fb15084-af41-11ce-bd2b-204c4f4f5020")
interface ITransaction : IUnknown
{
    HRESULT Commit(BOOL fRetaining, uint grfTC, uint grfRM);
    HRESULT Abort(BOID* pboidReason, BOOL fRetaining, BOOL fAsync);
    HRESULT GetTransactionInfo(XACTTRANSINFO* pinfo);
}

@GUID("02656950-2152-11d0-944c-00a0c905416e")
interface ITransactionCloner : ITransaction
{
    HRESULT CloneWithCommitDisabled(ITransaction* ppITransaction);
}

@GUID("34021548-0065-11d3-bac1-00c04f797be2")
interface ITransaction2 : ITransactionCloner
{
    HRESULT GetTransactionInfo2(XACTTRANSINFO* pinfo);
}

@GUID("3a6ad9e1-23b9-11cf-ad60-00aa00a74ccd")
interface ITransactionDispenser : IUnknown
{
    HRESULT GetOptionsObject(ITransactionOptions* ppOptions);
    HRESULT BeginTransaction(IUnknown punkOuter, int isoLevel, uint isoFlags, ITransactionOptions pOptions, 
                             ITransaction* ppTransaction);
}

@GUID("3a6ad9e0-23b9-11cf-ad60-00aa00a74ccd")
interface ITransactionOptions : IUnknown
{
    HRESULT SetOptions(XACTOPT* pOptions);
    HRESULT GetOptions(XACTOPT* pOptions);
}

@GUID("3a6ad9e2-23b9-11cf-ad60-00aa00a74ccd")
interface ITransactionOutcomeEvents : IUnknown
{
    HRESULT Committed(BOOL fRetaining, BOID* pNewUOW, HRESULT hr);
    HRESULT Aborted(BOID* pboidReason, BOOL fRetaining, BOID* pNewUOW, HRESULT hr);
    HRESULT HeuristicDecision(uint dwDecision, BOID* pboidReason, HRESULT hr);
    HRESULT Indoubt();
}

@GUID("30274f88-6ee4-474e-9b95-7807bc9ef8cf")
interface ITmNodeName : IUnknown
{
    HRESULT GetNodeNameSize(uint* pcbNodeNameSize);
    HRESULT GetNodeName(uint cbNodeNameBufferSize, PWSTR pNodeNameBuffer);
}

@GUID("79427a2b-f895-40e0-be79-b57dc82ed231")
interface IKernelTransaction : IUnknown
{
    HRESULT GetHandle(HANDLE* pHandle);
}

@GUID("69e971f0-23ce-11cf-ad60-00aa00a74ccd")
interface ITransactionResourceAsync : IUnknown
{
    HRESULT PrepareRequest(BOOL fRetaining, uint grfRM, BOOL fWantMoniker, BOOL fSinglePhase);
    HRESULT CommitRequest(uint grfRM, BOID* pNewUOW);
    HRESULT AbortRequest(BOID* pboidReason, BOOL fRetaining, BOID* pNewUOW);
    HRESULT TMDown();
}

@GUID("c82bd532-5b30-11d3-8a91-00c04f79eb6d")
interface ITransactionLastResourceAsync : IUnknown
{
    HRESULT DelegateCommit(uint grfRM);
    HRESULT ForgetRequest(BOID* pNewUOW);
}

@GUID("ee5ff7b3-4572-11d0-9452-00a0c905416e")
interface ITransactionResource : IUnknown
{
    HRESULT PrepareRequest(BOOL fRetaining, uint grfRM, BOOL fWantMoniker, BOOL fSinglePhase);
    HRESULT CommitRequest(uint grfRM, BOID* pNewUOW);
    HRESULT AbortRequest(BOID* pboidReason, BOOL fRetaining, BOID* pNewUOW);
    HRESULT TMDown();
}

@GUID("0fb15081-af41-11ce-bd2b-204c4f4f5020")
interface ITransactionEnlistmentAsync : IUnknown
{
    HRESULT PrepareRequestDone(HRESULT hr, IMoniker pmk, BOID* pboidReason);
    HRESULT CommitRequestDone(HRESULT hr);
    HRESULT AbortRequestDone(HRESULT hr);
}

@GUID("c82bd533-5b30-11d3-8a91-00c04f79eb6d")
interface ITransactionLastEnlistmentAsync : IUnknown
{
    HRESULT TransactionOutcome(XACTSTAT XactStat, BOID* pboidReason);
}

@GUID("e1cf9b53-8745-11ce-a9ba-00aa006c3706")
interface ITransactionExportFactory : IUnknown
{
    HRESULT GetRemoteClassId(GUID* pclsid);
    HRESULT Create(uint cbWhereabouts, ubyte* rgbWhereabouts, ITransactionExport* ppExport);
}

@GUID("0141fda4-8fc0-11ce-bd18-204c4f4f5020")
interface ITransactionImportWhereabouts : IUnknown
{
    HRESULT GetWhereaboutsSize(uint* pcbWhereabouts);
    HRESULT GetWhereabouts(uint cbWhereabouts, ubyte* rgbWhereabouts, uint* pcbUsed);
}

@GUID("0141fda5-8fc0-11ce-bd18-204c4f4f5020")
interface ITransactionExport : IUnknown
{
    HRESULT Export(IUnknown punkTransaction, uint* pcbTransactionCookie);
    HRESULT GetTransactionCookie(IUnknown punkTransaction, uint cbTransactionCookie, ubyte* rgbTransactionCookie, 
                                 uint* pcbUsed);
}

@GUID("e1cf9b5a-8745-11ce-a9ba-00aa006c3706")
interface ITransactionImport : IUnknown
{
    HRESULT Import(uint cbTransactionCookie, ubyte* rgbTransactionCookie, const(GUID)* piid, void** ppvTransaction);
}

@GUID("17cf72d0-bac5-11d1-b1bf-00c04fc2f3ef")
interface ITipTransaction : IUnknown
{
    HRESULT Push(ubyte* i_pszRemoteTmUrl, PSTR* o_ppszRemoteTxUrl);
    HRESULT GetTransactionUrl(PSTR* o_ppszLocalTxUrl);
}

@GUID("17cf72d1-bac5-11d1-b1bf-00c04fc2f3ef")
interface ITipHelper : IUnknown
{
    HRESULT Pull(ubyte* i_pszTxUrl, ITransaction* o_ppITransaction);
    HRESULT PullAsync(ubyte* i_pszTxUrl, ITipPullSink i_pTipPullSink, ITransaction* o_ppITransaction);
    HRESULT GetLocalTmUrl(ubyte** o_ppszLocalTmUrl);
}

@GUID("17cf72d2-bac5-11d1-b1bf-00c04fc2f3ef")
interface ITipPullSink : IUnknown
{
    HRESULT PullComplete(HRESULT i_hrPull);
}

@GUID("9797c15d-a428-4291-87b6-0995031a678d")
interface IDtcNetworkAccessConfig : IUnknown
{
    HRESULT GetAnyNetworkAccess(BOOL* pbAnyNetworkAccess);
    HRESULT SetAnyNetworkAccess(BOOL bAnyNetworkAccess);
    HRESULT GetNetworkAdministrationAccess(BOOL* pbNetworkAdministrationAccess);
    HRESULT SetNetworkAdministrationAccess(BOOL bNetworkAdministrationAccess);
    HRESULT GetNetworkTransactionAccess(BOOL* pbNetworkTransactionAccess);
    HRESULT SetNetworkTransactionAccess(BOOL bNetworkTransactionAccess);
    HRESULT GetNetworkClientAccess(BOOL* pbNetworkClientAccess);
    HRESULT SetNetworkClientAccess(BOOL bNetworkClientAccess);
    HRESULT GetNetworkTIPAccess(BOOL* pbNetworkTIPAccess);
    HRESULT SetNetworkTIPAccess(BOOL bNetworkTIPAccess);
    HRESULT GetXAAccess(BOOL* pbXAAccess);
    HRESULT SetXAAccess(BOOL bXAAccess);
    HRESULT RestartDtcService();
}

@GUID("a7aa013b-eb7d-4f42-b41c-b2dec09ae034")
interface IDtcNetworkAccessConfig2 : IDtcNetworkAccessConfig
{
    HRESULT GetNetworkInboundAccess(BOOL* pbInbound);
    HRESULT GetNetworkOutboundAccess(BOOL* pbOutbound);
    HRESULT SetNetworkInboundAccess(BOOL bInbound);
    HRESULT SetNetworkOutboundAccess(BOOL bOutbound);
    HRESULT GetAuthenticationLevel(AUTHENTICATION_LEVEL* pAuthLevel);
    HRESULT SetAuthenticationLevel(AUTHENTICATION_LEVEL AuthLevel);
}

@GUID("76e4b4f3-2ca5-466b-89d5-fd218ee75b49")
interface IDtcNetworkAccessConfig3 : IDtcNetworkAccessConfig2
{
    HRESULT GetLUAccess(BOOL* pbLUAccess);
    HRESULT SetLUAccess(BOOL bLUAccess);
}

@GUID("64ffabe0-7ce9-11d0-8ce6-00c04fdc877e")
interface IDtcToXaMapper : IUnknown
{
    HRESULT RequestNewResourceManager(PSTR pszDSN, PSTR pszClientDllName, uint* pdwRMCookie);
    HRESULT TranslateTridToXid(uint* pdwITransaction, uint dwRMCookie, XID* pXid);
    HRESULT EnlistResourceManager(uint dwRMCookie, uint* pdwITransaction);
    HRESULT ReleaseResourceManager(uint dwRMCookie);
}

@GUID("a9861610-304a-11d1-9813-00a0c905416e")
interface IDtcToXaHelperFactory : IUnknown
{
    HRESULT Create(PSTR pszDSN, PSTR pszClientDllName, GUID* pguidRm, IDtcToXaHelper* ppXaHelper);
}

@GUID("a9861611-304a-11d1-9813-00a0c905416e")
interface IDtcToXaHelper : IUnknown
{
    HRESULT Close(BOOL i_fDoRecovery);
    HRESULT TranslateTridToXid(ITransaction pITransaction, GUID* pguidBqual, XID* pXid);
}

@GUID("47ed4971-53b3-11d1-bbb9-00c04fd658f6")
interface IDtcToXaHelperSinglePipe : IUnknown
{
    HRESULT XARMCreate(PSTR pszDSN, PSTR pszClientDll, uint* pdwRMCookie);
    HRESULT ConvertTridToXID(uint* pdwITrans, uint dwRMCookie, XID* pxid);
    HRESULT EnlistWithRM(uint dwRMCookie, ITransaction i_pITransaction, ITransactionResourceAsync i_pITransRes, 
                         ITransactionEnlistmentAsync* o_ppITransEnslitment);
    void    ReleaseRMCookie(uint i_dwRMCookie, BOOL i_fNormal);
}

@GUID("f3b1f131-eeda-11ce-aed4-00aa0051e2c4")
interface IXATransLookup : IUnknown
{
    HRESULT Lookup(ITransaction* ppTransaction);
}

@GUID("bf193c85-0d1a-4290-b88f-d2cb8873d1e7")
interface IXATransLookup2 : IUnknown
{
    HRESULT Lookup(XID* pXID, ITransaction* ppTransaction);
}

@GUID("0d563181-defb-11ce-aed1-00aa0051e2c4")
interface IResourceManagerSink : IUnknown
{
    HRESULT TMDown();
}

@GUID("13741d21-87eb-11ce-8081-0080c758527e")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iresourcemanager))], [])
interface IResourceManager : IUnknown
{
    HRESULT Enlist(ITransaction pTransaction, ITransactionResourceAsync pRes, BOID* pUOW, int* pisoLevel, 
                   ITransactionEnlistmentAsync* ppEnlist);
    HRESULT Reenlist(ubyte* pPrepInfo, uint cbPrepInfo, uint lTimeout, XACTSTAT* pXactStat);
    HRESULT ReenlistmentComplete();
    HRESULT GetDistributedTransactionManager(const(GUID)* iid, void** ppvObject);
}

@GUID("4d964ad4-5b33-11d3-8a91-00c04f79eb6d")
interface ILastResourceManager : IUnknown
{
    HRESULT TransactionCommitted(ubyte* pPrepInfo, uint cbPrepInfo);
    HRESULT RecoveryDone();
}

@GUID("d136c69a-f749-11d1-8f47-00c04f8ee57d")
interface IResourceManager2 : IResourceManager
{
    HRESULT Enlist2(ITransaction pTransaction, ITransactionResourceAsync pResAsync, BOID* pUOW, int* pisoLevel, 
                    XID* pXid, ITransactionEnlistmentAsync* ppEnlist);
    HRESULT Reenlist2(XID* pXid, uint dwTimeout, XACTSTAT* pXactStat);
}

@GUID("6f6de620-b5df-4f3e-9cfa-c8aebd05172b")
interface IResourceManagerRejoinable : IResourceManager2
{
    HRESULT Rejoin(ubyte* pPrepInfo, uint cbPrepInfo, uint lTimeout, XACTSTAT* pXactStat);
}

@GUID("c8a6e3a1-9a8c-11cf-a308-00a0c905416e")
interface IXAConfig : IUnknown
{
    HRESULT Initialize(GUID clsidHelperDll);
    HRESULT Terminate();
}

@GUID("e793f6d1-f53d-11cf-a60d-00a0c905416e")
interface IRMHelper : IUnknown
{
    HRESULT RMCount(uint dwcTotalNumberOfRMs);
    HRESULT RMInfo(xa_switch_t* pXa_Switch, BOOL fCDeclCallingConv, PSTR pszOpenString, PSTR pszCloseString, 
                   GUID guidRMRecovery);
}

@GUID("e793f6d2-f53d-11cf-a60d-00a0c905416e")
interface IXAObtainRMInfo : IUnknown
{
    HRESULT ObtainRMInfo(IRMHelper pIRMHelper);
}

@GUID("13741d20-87eb-11ce-8081-0080c758527e")
interface IResourceManagerFactory : IUnknown
{
    HRESULT Create(GUID* pguidRM, PSTR pszRMName, IResourceManagerSink pIResMgrSink, IResourceManager* ppResMgr);
}

@GUID("6b369c21-fbd2-11d1-8f47-00c04f8ee57d")
interface IResourceManagerFactory2 : IResourceManagerFactory
{
    HRESULT CreateEx(GUID* pguidRM, PSTR pszRMName, IResourceManagerSink pIResMgrSink, const(GUID)* riidRequested, 
                     void** ppvResMgr);
}

@GUID("80c7bfd0-87ee-11ce-8081-0080c758527e")
interface IPrepareInfo : IUnknown
{
    HRESULT GetPrepareInfoSize(uint* pcbPrepInfo);
    HRESULT GetPrepareInfo(ubyte* pPrepInfo);
}

@GUID("5fab2547-9779-11d1-b886-00c04fb9618a")
interface IPrepareInfo2 : IUnknown
{
    HRESULT GetPrepareInfoSize(uint* pcbPrepInfo);
    HRESULT GetPrepareInfo(uint cbPrepareInfo, ubyte* pPrepInfo);
}

@GUID("c23cc370-87ef-11ce-8081-0080c758527e")
interface IGetDispenser : IUnknown
{
    HRESULT GetDispenser(const(GUID)* iid, void** ppvObject);
}

@GUID("5433376c-414d-11d3-b206-00c04fc2f3ef")
interface ITransactionVoterBallotAsync2 : IUnknown
{
    HRESULT VoteRequestDone(HRESULT hr, BOID* pboidReason);
}

@GUID("5433376b-414d-11d3-b206-00c04fc2f3ef")
interface ITransactionVoterNotifyAsync2 : ITransactionOutcomeEvents
{
    HRESULT VoteRequest();
}

@GUID("5433376a-414d-11d3-b206-00c04fc2f3ef")
interface ITransactionVoterFactory2 : IUnknown
{
    HRESULT Create(ITransaction pTransaction, ITransactionVoterNotifyAsync2 pVoterNotify, 
                   ITransactionVoterBallotAsync2* ppVoterBallot);
}

@GUID("82dc88e1-a954-11d1-8f88-00600895e7d5")
interface ITransactionPhase0EnlistmentAsync : IUnknown
{
    HRESULT Enable();
    HRESULT WaitForEnlistment();
    HRESULT Phase0Done();
    HRESULT Unenlist();
    HRESULT GetTransaction(ITransaction* ppITransaction);
}

@GUID("ef081809-0c76-11d2-87a6-00c04f990f34")
interface ITransactionPhase0NotifyAsync : IUnknown
{
    HRESULT Phase0Request(BOOL fAbortingHint);
    HRESULT EnlistCompleted(HRESULT status);
}

@GUID("82dc88e0-a954-11d1-8f88-00600895e7d5")
interface ITransactionPhase0Factory : IUnknown
{
    HRESULT Create(ITransactionPhase0NotifyAsync pPhase0Notify, 
                   ITransactionPhase0EnlistmentAsync* ppPhase0Enlistment);
}

@GUID("59313e01-b36c-11cf-a539-00aa006887c3")
interface ITransactionTransmitter : IUnknown
{
    HRESULT Set(ITransaction pTransaction);
    HRESULT GetPropagationTokenSize(uint* pcbToken);
    HRESULT MarshalPropagationToken(uint cbToken, ubyte* rgbToken, uint* pcbUsed);
    HRESULT UnmarshalReturnToken(uint cbReturnToken, ubyte* rgbReturnToken);
    HRESULT Reset();
}

@GUID("59313e00-b36c-11cf-a539-00aa006887c3")
interface ITransactionTransmitterFactory : IUnknown
{
    HRESULT Create(ITransactionTransmitter* ppTransmitter);
}

@GUID("59313e03-b36c-11cf-a539-00aa006887c3")
interface ITransactionReceiver : IUnknown
{
    HRESULT UnmarshalPropagationToken(uint cbToken, ubyte* rgbToken, ITransaction* ppTransaction);
    HRESULT GetReturnTokenSize(uint* pcbReturnToken);
    HRESULT MarshalReturnToken(uint cbReturnToken, ubyte* rgbReturnToken, uint* pcbUsed);
    HRESULT Reset();
}

@GUID("59313e02-b36c-11cf-a539-00aa006887c3")
interface ITransactionReceiverFactory : IUnknown
{
    HRESULT Create(ITransactionReceiver* ppReceiver);
}

@GUID("4131e760-1aea-11d0-944b-00a0c905416e")
interface IDtcLuConfigure : IUnknown
{
    HRESULT Add(ubyte* pucLuPair, uint cbLuPair);
    HRESULT Delete(ubyte* pucLuPair, uint cbLuPair);
}

@GUID("ac2b8ad2-d6f0-11d0-b386-00a0c9083365")
interface IDtcLuRecovery : IUnknown
{
}

@GUID("4131e762-1aea-11d0-944b-00a0c905416e")
interface IDtcLuRecoveryFactory : IUnknown
{
    HRESULT Create(ubyte* pucLuPair, uint cbLuPair, IDtcLuRecovery* ppRecovery);
}

@GUID("4131e765-1aea-11d0-944b-00a0c905416e")
interface IDtcLuRecoveryInitiatedByDtcTransWork : IUnknown
{
    HRESULT GetLogNameSizes(uint* pcbOurLogName, uint* pcbRemoteLogName);
    HRESULT GetOurXln(DTCLUXLN* pXln, ubyte* pOurLogName, ubyte* pRemoteLogName, uint* pdwProtocol);
    HRESULT HandleConfirmationFromOurXln(DTCLUXLNCONFIRMATION Confirmation);
    HRESULT HandleTheirXlnResponse(DTCLUXLN Xln, ubyte* pRemoteLogName, uint cbRemoteLogName, uint dwProtocol, 
                                   DTCLUXLNCONFIRMATION* pConfirmation);
    HRESULT HandleErrorFromOurXln(DTCLUXLNERROR Error);
    HRESULT CheckForCompareStates(BOOL* fCompareStates);
    HRESULT GetOurTransIdSize(uint* pcbOurTransId);
    HRESULT GetOurCompareStates(ubyte* pOurTransId, DTCLUCOMPARESTATE* pCompareState);
    HRESULT HandleTheirCompareStatesResponse(DTCLUCOMPARESTATE CompareState, 
                                             DTCLUCOMPARESTATESCONFIRMATION* pConfirmation);
    HRESULT HandleErrorFromOurCompareStates(DTCLUCOMPARESTATESERROR Error);
    HRESULT ConversationLost();
    HRESULT GetRecoverySeqNum(int* plRecoverySeqNum);
    HRESULT ObsoleteRecoverySeqNum(int lNewRecoverySeqNum);
}

@GUID("4131e766-1aea-11d0-944b-00a0c905416e")
interface IDtcLuRecoveryInitiatedByDtcStatusWork : IUnknown
{
    HRESULT HandleCheckLuStatus(int lRecoverySeqNum);
}

@GUID("4131e764-1aea-11d0-944b-00a0c905416e")
interface IDtcLuRecoveryInitiatedByDtc : IUnknown
{
    HRESULT GetWork(DTCINITIATEDRECOVERYWORK* pWork, void** ppv);
}

@GUID("ac2b8ad1-d6f0-11d0-b386-00a0c9083365")
interface IDtcLuRecoveryInitiatedByLuWork : IUnknown
{
    HRESULT HandleTheirXln(int lRecoverySeqNum, DTCLUXLN Xln, ubyte* pRemoteLogName, uint cbRemoteLogName, 
                           ubyte* pOurLogName, uint cbOurLogName, uint dwProtocol, DTCLUXLNRESPONSE* pResponse);
    HRESULT GetOurLogNameSize(uint* pcbOurLogName);
    HRESULT GetOurXln(DTCLUXLN* pXln, ubyte* pOurLogName, uint* pdwProtocol);
    HRESULT HandleConfirmationOfOurXln(DTCLUXLNCONFIRMATION Confirmation);
    HRESULT HandleTheirCompareStates(ubyte* pRemoteTransId, uint cbRemoteTransId, DTCLUCOMPARESTATE CompareState, 
                                     DTCLUCOMPARESTATESRESPONSE* pResponse, DTCLUCOMPARESTATE* pCompareState);
    HRESULT HandleConfirmationOfOurCompareStates(DTCLUCOMPARESTATESCONFIRMATION Confirmation);
    HRESULT HandleErrorFromOurCompareStates(DTCLUCOMPARESTATESERROR Error);
    HRESULT ConversationLost();
}

@GUID("4131e768-1aea-11d0-944b-00a0c905416e")
interface IDtcLuRecoveryInitiatedByLu : IUnknown
{
    HRESULT GetObjectToHandleWorkFromLu(IDtcLuRecoveryInitiatedByLuWork* ppWork);
}

@GUID("4131e769-1aea-11d0-944b-00a0c905416e")
interface IDtcLuRmEnlistment : IUnknown
{
    HRESULT Unplug(BOOL fConversationLost);
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT RequestCommit();
}

@GUID("4131e770-1aea-11d0-944b-00a0c905416e")
interface IDtcLuRmEnlistmentSink : IUnknown
{
    HRESULT AckUnplug();
    HRESULT TmDown();
    HRESULT SessionLost();
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT Prepare();
    HRESULT RequestCommit();
}

@GUID("4131e771-1aea-11d0-944b-00a0c905416e")
interface IDtcLuRmEnlistmentFactory : IUnknown
{
    HRESULT Create(ubyte* pucLuPair, uint cbLuPair, ITransaction pITransaction, ubyte* pTransId, uint cbTransId, 
                   IDtcLuRmEnlistmentSink pRmEnlistmentSink, IDtcLuRmEnlistment* ppRmEnlistment);
}

@GUID("4131e773-1aea-11d0-944b-00a0c905416e")
interface IDtcLuSubordinateDtc : IUnknown
{
    HRESULT Unplug(BOOL fConversationLost);
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT Prepare();
    HRESULT RequestCommit();
}

@GUID("4131e774-1aea-11d0-944b-00a0c905416e")
interface IDtcLuSubordinateDtcSink : IUnknown
{
    HRESULT AckUnplug();
    HRESULT TmDown();
    HRESULT SessionLost();
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT RequestCommit();
}

@GUID("4131e775-1aea-11d0-944b-00a0c905416e")
interface IDtcLuSubordinateDtcFactory : IUnknown
{
    HRESULT Create(ubyte* pucLuPair, uint cbLuPair, IUnknown punkTransactionOuter, int isoLevel, uint isoFlags, 
                   ITransactionOptions pOptions, ITransaction* ppTransaction, ubyte* pTransId, uint cbTransId, 
                   IDtcLuSubordinateDtcSink pSubordinateDtcSink, IDtcLuSubordinateDtc* ppSubordinateDtc);
}


// GUIDs


const GUID IID_IDtcLuConfigure                        = GUIDOF!IDtcLuConfigure;
const GUID IID_IDtcLuRecovery                         = GUIDOF!IDtcLuRecovery;
const GUID IID_IDtcLuRecoveryFactory                  = GUIDOF!IDtcLuRecoveryFactory;
const GUID IID_IDtcLuRecoveryInitiatedByDtc           = GUIDOF!IDtcLuRecoveryInitiatedByDtc;
const GUID IID_IDtcLuRecoveryInitiatedByDtcStatusWork = GUIDOF!IDtcLuRecoveryInitiatedByDtcStatusWork;
const GUID IID_IDtcLuRecoveryInitiatedByDtcTransWork  = GUIDOF!IDtcLuRecoveryInitiatedByDtcTransWork;
const GUID IID_IDtcLuRecoveryInitiatedByLu            = GUIDOF!IDtcLuRecoveryInitiatedByLu;
const GUID IID_IDtcLuRecoveryInitiatedByLuWork        = GUIDOF!IDtcLuRecoveryInitiatedByLuWork;
const GUID IID_IDtcLuRmEnlistment                     = GUIDOF!IDtcLuRmEnlistment;
const GUID IID_IDtcLuRmEnlistmentFactory              = GUIDOF!IDtcLuRmEnlistmentFactory;
const GUID IID_IDtcLuRmEnlistmentSink                 = GUIDOF!IDtcLuRmEnlistmentSink;
const GUID IID_IDtcLuSubordinateDtc                   = GUIDOF!IDtcLuSubordinateDtc;
const GUID IID_IDtcLuSubordinateDtcFactory            = GUIDOF!IDtcLuSubordinateDtcFactory;
const GUID IID_IDtcLuSubordinateDtcSink               = GUIDOF!IDtcLuSubordinateDtcSink;
const GUID IID_IDtcNetworkAccessConfig                = GUIDOF!IDtcNetworkAccessConfig;
const GUID IID_IDtcNetworkAccessConfig2               = GUIDOF!IDtcNetworkAccessConfig2;
const GUID IID_IDtcNetworkAccessConfig3               = GUIDOF!IDtcNetworkAccessConfig3;
const GUID IID_IDtcToXaHelper                         = GUIDOF!IDtcToXaHelper;
const GUID IID_IDtcToXaHelperFactory                  = GUIDOF!IDtcToXaHelperFactory;
const GUID IID_IDtcToXaHelperSinglePipe               = GUIDOF!IDtcToXaHelperSinglePipe;
const GUID IID_IDtcToXaMapper                         = GUIDOF!IDtcToXaMapper;
const GUID IID_IGetDispenser                          = GUIDOF!IGetDispenser;
const GUID IID_IKernelTransaction                     = GUIDOF!IKernelTransaction;
const GUID IID_ILastResourceManager                   = GUIDOF!ILastResourceManager;
const GUID IID_IPrepareInfo                           = GUIDOF!IPrepareInfo;
const GUID IID_IPrepareInfo2                          = GUIDOF!IPrepareInfo2;
const GUID IID_IRMHelper                              = GUIDOF!IRMHelper;
const GUID IID_IResourceManager                       = GUIDOF!IResourceManager;
const GUID IID_IResourceManager2                      = GUIDOF!IResourceManager2;
const GUID IID_IResourceManagerFactory                = GUIDOF!IResourceManagerFactory;
const GUID IID_IResourceManagerFactory2               = GUIDOF!IResourceManagerFactory2;
const GUID IID_IResourceManagerRejoinable             = GUIDOF!IResourceManagerRejoinable;
const GUID IID_IResourceManagerSink                   = GUIDOF!IResourceManagerSink;
const GUID IID_ITipHelper                             = GUIDOF!ITipHelper;
const GUID IID_ITipPullSink                           = GUIDOF!ITipPullSink;
const GUID IID_ITipTransaction                        = GUIDOF!ITipTransaction;
const GUID IID_ITmNodeName                            = GUIDOF!ITmNodeName;
const GUID IID_ITransaction                           = GUIDOF!ITransaction;
const GUID IID_ITransaction2                          = GUIDOF!ITransaction2;
const GUID IID_ITransactionCloner                     = GUIDOF!ITransactionCloner;
const GUID IID_ITransactionDispenser                  = GUIDOF!ITransactionDispenser;
const GUID IID_ITransactionEnlistmentAsync            = GUIDOF!ITransactionEnlistmentAsync;
const GUID IID_ITransactionExport                     = GUIDOF!ITransactionExport;
const GUID IID_ITransactionExportFactory              = GUIDOF!ITransactionExportFactory;
const GUID IID_ITransactionImport                     = GUIDOF!ITransactionImport;
const GUID IID_ITransactionImportWhereabouts          = GUIDOF!ITransactionImportWhereabouts;
const GUID IID_ITransactionLastEnlistmentAsync        = GUIDOF!ITransactionLastEnlistmentAsync;
const GUID IID_ITransactionLastResourceAsync          = GUIDOF!ITransactionLastResourceAsync;
const GUID IID_ITransactionOptions                    = GUIDOF!ITransactionOptions;
const GUID IID_ITransactionOutcomeEvents              = GUIDOF!ITransactionOutcomeEvents;
const GUID IID_ITransactionPhase0EnlistmentAsync      = GUIDOF!ITransactionPhase0EnlistmentAsync;
const GUID IID_ITransactionPhase0Factory              = GUIDOF!ITransactionPhase0Factory;
const GUID IID_ITransactionPhase0NotifyAsync          = GUIDOF!ITransactionPhase0NotifyAsync;
const GUID IID_ITransactionReceiver                   = GUIDOF!ITransactionReceiver;
const GUID IID_ITransactionReceiverFactory            = GUIDOF!ITransactionReceiverFactory;
const GUID IID_ITransactionResource                   = GUIDOF!ITransactionResource;
const GUID IID_ITransactionResourceAsync              = GUIDOF!ITransactionResourceAsync;
const GUID IID_ITransactionTransmitter                = GUIDOF!ITransactionTransmitter;
const GUID IID_ITransactionTransmitterFactory         = GUIDOF!ITransactionTransmitterFactory;
const GUID IID_ITransactionVoterBallotAsync2          = GUIDOF!ITransactionVoterBallotAsync2;
const GUID IID_ITransactionVoterFactory2              = GUIDOF!ITransactionVoterFactory2;
const GUID IID_ITransactionVoterNotifyAsync2          = GUIDOF!ITransactionVoterNotifyAsync2;
const GUID IID_IXAConfig                              = GUIDOF!IXAConfig;
const GUID IID_IXAObtainRMInfo                        = GUIDOF!IXAObtainRMInfo;
const GUID IID_IXATransLookup                         = GUIDOF!IXATransLookup;
const GUID IID_IXATransLookup2                        = GUIDOF!IXATransLookup2;
