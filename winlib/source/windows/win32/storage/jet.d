// Written in the D programming language.

module windows.win32.storage.jet;

public import windows.core;
public import windows.win32.storage.structuredstorage : JET_API_PTR, JET_HANDLE, JET_TABLEID;

extern(Windows) @nogc nothrow:


// Enums


alias JET_RELOP = int;
enum : int
{
    JET_relopEquals               = 0x00000000,
    JET_relopPrefixEquals         = 0x00000001,
    JET_relopNotEquals            = 0x00000002,
    JET_relopLessThanOrEqual      = 0x00000003,
    JET_relopLessThan             = 0x00000004,
    JET_relopGreaterThanOrEqual   = 0x00000005,
    JET_relopGreaterThan          = 0x00000006,
    JET_relopBitmaskEqualsZero    = 0x00000007,
    JET_relopBitmaskNotEqualsZero = 0x00000008,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-errcat-enumeration))], [])

alias JET_ERRCAT = int;
enum : int
{
    JET_errcatUnknown       = 0x00000000,
    JET_errcatError         = 0x00000001,
    JET_errcatOperation     = 0x00000002,
    JET_errcatFatal         = 0x00000003,
    JET_errcatIO            = 0x00000004,
    JET_errcatResource      = 0x00000005,
    JET_errcatMemory        = 0x00000006,
    JET_errcatQuota         = 0x00000007,
    JET_errcatDisk          = 0x00000008,
    JET_errcatData          = 0x00000009,
    JET_errcatCorruption    = 0x0000000a,
    JET_errcatInconsistent  = 0x0000000b,
    JET_errcatFragmentation = 0x0000000c,
    JET_errcatApi           = 0x0000000d,
    JET_errcatUsage         = 0x0000000e,
    JET_errcatState         = 0x0000000f,
    JET_errcatObsolete      = 0x00000010,
    JET_errcatMax           = 0x00000011,
}

alias JET_INDEXCHECKING = int;
enum : int
{
    JET_IndexCheckingOff              = 0x00000000,
    JET_IndexCheckingOn               = 0x00000001,
    JET_IndexCheckingDeferToOpenTable = 0x00000002,
    JET_IndexCheckingMax              = 0x00000003,
}

// Constants


enum uint JET_VERSION = 0x00000500;

enum : uint
{
    JET_bitConfigStoreReadControlInhibitRead = 0x00000001,
    JET_bitConfigStoreReadControlDisableAll  = 0x00000002,
    JET_bitConfigStoreReadControlDefault     = 0x00000000,
}

enum const(wchar)* JET_wszConfigStoreRelPathSysParamOverride = "SysParamOverride";
enum uint JET_efvUsePersistedFormat = 0x40000002;

enum : uint
{
    JET_efvWindows19H1Rtm    = 0x000022d8,
    JET_efvWindows10v2004    = 0x000023dc,
    JET_efvWindowsServer2022 = 0x00002490,
    JET_efvWindows11v21H2    = 0x000024b8,
    JET_efvWindows11v22H2    = 0x00002508,
    JET_efvWindows11v23H2    = 0x00002580,
}

enum : uint
{
    JET_bitDefragmentBatchStop           = 0x00000002,
    JET_bitDefragmentAvailSpaceTreesOnly = 0x00000040,
    JET_bitDefragmentNoPartialMerges     = 0x00000080,
    JET_bitDefragmentBTree               = 0x00000100,
}

enum : uint
{
    JET_cbtypFinalize                = 0x00000001,
    JET_cbtypBeforeInsert            = 0x00000002,
    JET_cbtypAfterInsert             = 0x00000004,
    JET_cbtypBeforeReplace           = 0x00000008,
    JET_cbtypAfterReplace            = 0x00000010,
    JET_cbtypBeforeDelete            = 0x00000020,
    JET_cbtypAfterDelete             = 0x00000040,
    JET_cbtypUserDefinedDefaultValue = 0x00000080,
}

enum : uint
{
    JET_cbtypFreeCursorLS = 0x00000200,
    JET_cbtypFreeTableLS  = 0x00000400,
}

enum : uint
{
    JET_bitTableInfoBookmark = 0x00000002,
    JET_bitTableInfoRollback = 0x00000004,
}

enum : uint
{
    JET_bitObjectTableFixedDDL                         = 0x40000000,
    JET_bitObjectTableTemplate                         = 0x20000000,
    JET_bitObjectTableDerived                          = 0x10000000,
    JET_bitObjectTableNoFixedVarColumnsInDerivedTables = 0x04000000,
}

enum uint cColumnInfoCols = 0x0000000e;
enum uint JET_MAX_COMPUTERNAME_LENGTH = 0x0000000f;
enum uint JET_cbBookmarkMost = 0x00000100;
enum uint JET_cbFullNameMost = 0x000000ff;
enum uint JET_cbLVDefaultValueMost = 0x000000ff;
enum uint JET_cbLVColumnMost = 0x7fffffff;

enum : uint
{
    JET_cbKeyMost4KBytePage = 0x000003e8,
    JET_cbKeyMost2KBytePage = 0x000001f4,
    JET_cbKeyMostMin        = 0x000000ff,
    JET_cbKeyMost           = 0x000000ff,
    JET_cbLimitKeyMost      = 0x00000100,
}

enum uint JET_cbSecondaryKeyMost = 0x000000ff;

enum : uint
{
    JET_ccolMost       = 0x0000fee0,
    JET_ccolFixedMost  = 0x0000007f,
    JET_ccolVarMost    = 0x00000080,
    JET_ccolTaggedMost = 0x0000fde1,
}

enum : uint
{
    JET_EventLoggingLevelMin    = 0x00000001,
    JET_EventLoggingLevelLow    = 0x00000019,
    JET_EventLoggingLevelMedium = 0x00000032,
    JET_EventLoggingLevelHigh   = 0x0000004b,
    JET_EventLoggingLevelMax    = 0x00000064,
}

enum uint JET_IOPriorityLow = 0x00000001;

enum : uint
{
    JET_configRemoveQuotas     = 0x00000002,
    JET_configLowDiskFootprint = 0x00000004,
}

enum : uint
{
    JET_configLowMemory           = 0x00000010,
    JET_configDynamicMediumMemory = 0x00000020,
}

enum : uint
{
    JET_configSSDProfileIO      = 0x00000080,
    JET_configRunSilent         = 0x00000100,
    JET_configUnthrottledMemory = 0x00000200,
}

enum : uint
{
    JET_paramSystemPath             = 0x00000000,
    JET_paramTempPath               = 0x00000001,
    JET_paramLogFilePath            = 0x00000002,
    JET_paramBaseName               = 0x00000003,
    JET_paramEventSource            = 0x00000004,
    JET_paramMaxSessions            = 0x00000005,
    JET_paramMaxOpenTables          = 0x00000006,
    JET_paramPreferredMaxOpenTables = 0x00000007,
}

enum : uint
{
    JET_paramMaxCursors        = 0x00000008,
    JET_paramMaxVerPages       = 0x00000009,
    JET_paramPreferredVerPages = 0x0000003f,
}

enum uint JET_paramVersionStoreTaskQueueMax = 0x00000069;

enum : uint
{
    JET_paramLogFileSize         = 0x0000000b,
    JET_paramLogBuffers          = 0x0000000c,
    JET_paramWaitLogFlush        = 0x0000000d,
    JET_paramLogCheckpointPeriod = 0x0000000e,
    JET_paramLogWaitingUserMax   = 0x0000000f,
}

enum : uint
{
    JET_paramCircularLog     = 0x00000011,
    JET_paramDbExtensionSize = 0x00000012,
}

enum : uint
{
    JET_paramPageFragment    = 0x00000014,
    JET_paramEnableFileCache = 0x0000007e,
}

enum : uint
{
    JET_paramConfiguration  = 0x00000081,
    JET_paramEnableAdvanced = 0x00000082,
}

enum uint JET_paramBatchIOBufferMax = 0x00000016;

enum : uint
{
    JET_paramCacheSizeMin       = 0x0000003c,
    JET_paramCacheSizeMax       = 0x00000017,
    JET_paramCheckpointDepthMax = 0x00000018,
}

enum : uint
{
    JET_paramLRUKHistoryMax      = 0x0000001a,
    JET_paramLRUKPolicy          = 0x0000001b,
    JET_paramLRUKTimeout         = 0x0000001c,
    JET_paramLRUKTrxCorrInterval = 0x0000001d,
}

enum uint JET_paramStartFlushThreshold = 0x0000001f;
enum uint JET_paramEnableViewCache = 0x0000007f;

enum : uint
{
    JET_paramTableClass1Name  = 0x00000089,
    JET_paramTableClass2Name  = 0x0000008a,
    JET_paramTableClass3Name  = 0x0000008b,
    JET_paramTableClass4Name  = 0x0000008c,
    JET_paramTableClass5Name  = 0x0000008d,
    JET_paramTableClass6Name  = 0x0000008e,
    JET_paramTableClass7Name  = 0x0000008f,
    JET_paramTableClass8Name  = 0x00000090,
    JET_paramTableClass9Name  = 0x00000091,
    JET_paramTableClass10Name = 0x00000092,
    JET_paramTableClass11Name = 0x00000093,
    JET_paramTableClass12Name = 0x00000094,
    JET_paramTableClass13Name = 0x00000095,
    JET_paramTableClass14Name = 0x00000096,
    JET_paramTableClass15Name = 0x00000097,
}

enum : uint
{
    JET_paramRecovery           = 0x00000022,
    JET_paramEnableOnlineDefrag = 0x00000023,
}

enum uint JET_paramEnableTempTableVersioning = 0x0000002e;

enum : uint
{
    JET_paramDeleteOldLogs  = 0x00000030,
    JET_paramEventSourceKey = 0x00000031,
}

enum uint JET_paramEventLoggingLevel = 0x00000033;
enum uint JET_paramAccessDeniedRetryPeriod = 0x00000035;
enum uint JET_paramEnableIndexCleanup = 0x00000036;
enum uint JET_paramDisableCallbacks = 0x00000041;

enum : uint
{
    JET_paramErrorToString            = 0x00000046,
    JET_paramZeroDatabaseDuringBackup = 0x00000047,
}

enum uint JET_paramRuntimeCallback = 0x00000049;
enum uint JET_paramRecordUpgradeDirtyLevel = 0x0000004e;

enum : uint
{
    JET_paramExceptionAction      = 0x00000062,
    JET_paramEventLogCache        = 0x00000063,
    JET_paramCreatePathIfNotExist = 0x00000064,
}

enum uint JET_paramOneDatabasePerSession = 0x00000066;
enum uint JET_paramDisablePerfmon = 0x0000006b;

enum : uint
{
    JET_paramIndexTuplesLengthMax  = 0x0000006f,
    JET_paramIndexTuplesToIndexMax = 0x00000070,
}

enum : uint
{
    JET_paramIndexTupleIncrement = 0x00000084,
    JET_paramIndexTupleStart     = 0x00000085,
}

enum uint JET_paramLegacyFileNames = 0x00000088;
enum uint JET_paramWaypointLatency = 0x00000099;
enum uint JET_paramDefragmentSequentialBTreesDensityCheckFrequency = 0x000000a1;
enum uint JET_paramLVChunkSizeMost = 0x000000a3;

enum : uint
{
    JET_paramMaxCoalesceWriteSize    = 0x000000a5,
    JET_paramMaxCoalesceReadGapSize  = 0x000000a6,
    JET_paramMaxCoalesceWriteGapSize = 0x000000a7,
}

enum : uint
{
    JET_paramDbScanThrottle       = 0x000000aa,
    JET_paramDbScanIntervalMinSec = 0x000000ab,
    JET_paramDbScanIntervalMaxSec = 0x000000ac,
}

enum uint JET_paramMaxTransactionSize = 0x000000b2;
enum uint JET_paramEnableDBScanSerialization = 0x000000b4;

enum : uint
{
    JET_paramHungIOActions    = 0x000000b6,
    JET_paramMinDataForXpress = 0x000000b7,
}

enum uint JET_paramProcessFriendlyName = 0x000000ba;

enum : uint
{
    JET_paramEnableSqm       = 0x000000bc,
    JET_paramConfigStoreSpec = 0x000000bd,
}

enum uint JET_paramUseFlushForWriteDurability = 0x000000d6;

enum : uint
{
    JET_paramRBSFilePath            = 0x000000d8,
    JET_paramPerfmonRefreshInterval = 0x000000d9,
}

enum : uint
{
    JET_paramTraceFlags      = 0x000000df,
    JET_paramMaxValueInvalid = 0x000000e8,
}

enum : uint
{
    JET_sesparamTransactionLevel = 0x00001003,
    JET_sesparamOperationContext = 0x00001004,
    JET_sesparamCorrelationID    = 0x00001005,
    JET_sesparamMaxValueInvalid  = 0x0000100f,
}

enum uint JET_bitEightDotThreeSoftCompat = 0x00000002;

enum : uint
{
    JET_bitShrinkDatabaseOff      = 0x00000000,
    JET_bitShrinkDatabaseOn       = 0x00000001,
    JET_bitShrinkDatabaseRealtime = 0x00000002,
    JET_bitShrinkDatabaseTrim     = 0x00000001,
}

enum uint JET_bitRecoveryWithoutUndo = 0x00000008;
enum uint JET_bitReplayMissingMapEntryDB = 0x00000020;
enum uint JET_bitReplayIgnoreLostLogs = 0x00000080;

enum : uint
{
    JET_bitTermComplete           = 0x00000001,
    JET_bitTermAbrupt             = 0x00000002,
    JET_bitTermStopBackup         = 0x00000004,
    JET_bitTermDirty              = 0x00000008,
    JET_bitIdleFlushBuffers       = 0x00000001,
    JET_bitIdleCompact            = 0x00000002,
    JET_bitIdleStatus             = 0x00000004,
    JET_bitDbReadOnly             = 0x00000001,
    JET_bitDbExclusive            = 0x00000002,
    JET_bitDbDeleteCorruptIndexes = 0x00000010,
    JET_bitDbDeleteUnicodeIndexes = 0x00000400,
}

enum uint JET_bitDbEnableBackgroundMaintenance = 0x00000800;
enum uint JET_bitForceDetach = 0x00000001;

enum : uint
{
    JET_bitDbShadowingOff      = 0x00000080,
    JET_bitDbOverwriteExisting = 0x00000200,
}

enum : uint
{
    JET_bitBackupAtomic       = 0x00000004,
    JET_bitBackupSnapshot     = 0x00000010,
    JET_bitBackupEndNormal    = 0x00000001,
    JET_bitBackupEndAbort     = 0x00000002,
    JET_bitBackupTruncateDone = 0x00000100,
}

enum : uint
{
    JET_bitTableCreateTemplateTable                    = 0x00000002,
    JET_bitTableCreateNoFixedVarColumnsInDerivedTables = 0x00000004,
}

enum : uint
{
    JET_bitColumnFixed              = 0x00000001,
    JET_bitColumnTagged             = 0x00000002,
    JET_bitColumnNotNULL            = 0x00000004,
    JET_bitColumnVersion            = 0x00000008,
    JET_bitColumnAutoincrement      = 0x00000010,
    JET_bitColumnUpdatable          = 0x00000020,
    JET_bitColumnTTKey              = 0x00000040,
    JET_bitColumnTTDescending       = 0x00000080,
    JET_bitColumnMultiValued        = 0x00000400,
    JET_bitColumnEscrowUpdate       = 0x00000800,
    JET_bitColumnUnversioned        = 0x00001000,
    JET_bitColumnMaybeNull          = 0x00002000,
    JET_bitColumnFinalize           = 0x00004000,
    JET_bitColumnUserDefinedDefault = 0x00008000,
    JET_bitColumnDeleteOnZero       = 0x00020000,
    JET_bitColumnCompressed         = 0x00080000,
}

enum : uint
{
    JET_bitMoveFirst   = 0x00000000,
    JET_bitNoMove      = 0x00000002,
    JET_bitNewKey      = 0x00000001,
    JET_bitStrLimit    = 0x00000002,
    JET_bitSubStrLimit = 0x00000004,
}

enum uint JET_bitKeyDataZeroLength = 0x00000010;
enum uint JET_bitFullColumnEndLimit = 0x00000200;
enum uint JET_bitPartialColumnEndLimit = 0x00000800;

enum : uint
{
    JET_bitRangeUpperLimit      = 0x00000002,
    JET_bitRangeInstantDuration = 0x00000004,
    JET_bitRangeRemove          = 0x00000008,
    JET_bitReadLock             = 0x00000001,
    JET_bitWriteLock            = 0x00000002,
}

enum int JET_MovePrevious = 0xffffffff;

enum : uint
{
    JET_bitMoveKeyNE     = 0x00000001,
    JET_bitSeekEQ        = 0x00000001,
    JET_bitSeekLT        = 0x00000002,
    JET_bitSeekLE        = 0x00000004,
    JET_bitSeekGE        = 0x00000008,
    JET_bitSeekGT        = 0x00000010,
    JET_bitSetIndexRange = 0x00000020,
}

enum uint JET_bitBookmarkPermitVirtualCurrency = 0x00000001;
enum uint JET_bitIndexColumnMustBeNonNull = 0x00000002;
enum uint JET_bitRecordNotInIndex = 0x00000002;

enum : uint
{
    JET_bitIndexPrimary            = 0x00000002,
    JET_bitIndexDisallowNull       = 0x00000004,
    JET_bitIndexIgnoreNull         = 0x00000008,
    JET_bitIndexIgnoreAnyNull      = 0x00000020,
    JET_bitIndexIgnoreFirstNull    = 0x00000040,
    JET_bitIndexLazyFlush          = 0x00000080,
    JET_bitIndexEmpty              = 0x00000100,
    JET_bitIndexUnversioned        = 0x00000200,
    JET_bitIndexSortNullsHigh      = 0x00000400,
    JET_bitIndexUnicode            = 0x00000800,
    JET_bitIndexTuples             = 0x00001000,
    JET_bitIndexTupleLimits        = 0x00002000,
    JET_bitIndexCrossProduct       = 0x00004000,
    JET_bitIndexKeyMost            = 0x00008000,
    JET_bitIndexDisallowTruncation = 0x00010000,
}

enum : uint
{
    JET_bitIndexDotNetGuid         = 0x00040000,
    JET_bitIndexImmutableStructure = 0x00080000,
}

enum uint JET_bitKeyDescending = 0x00000001;

enum : uint
{
    JET_bitTableDenyRead      = 0x00000002,
    JET_bitTableReadOnly      = 0x00000004,
    JET_bitTableUpdatable     = 0x00000008,
    JET_bitTablePermitDDL     = 0x00000010,
    JET_bitTableNoCache       = 0x00000020,
    JET_bitTablePreread       = 0x00000040,
    JET_bitTableOpportuneRead = 0x00000080,
    JET_bitTableSequential    = 0x00008000,
    JET_bitTableClassMask     = 0x001f0000,
    JET_bitTableClassNone     = 0x00000000,
    JET_bitTableClass1        = 0x00010000,
    JET_bitTableClass2        = 0x00020000,
    JET_bitTableClass3        = 0x00030000,
    JET_bitTableClass4        = 0x00040000,
    JET_bitTableClass5        = 0x00050000,
    JET_bitTableClass6        = 0x00060000,
    JET_bitTableClass7        = 0x00070000,
    JET_bitTableClass8        = 0x00080000,
    JET_bitTableClass9        = 0x00090000,
    JET_bitTableClass10       = 0x000a0000,
    JET_bitTableClass11       = 0x000b0000,
    JET_bitTableClass12       = 0x000c0000,
    JET_bitTableClass13       = 0x000d0000,
    JET_bitTableClass14       = 0x000e0000,
    JET_bitTableClass15       = 0x000f0000,
}

enum : uint
{
    JET_bitLSCursor             = 0x00000002,
    JET_bitLSTable              = 0x00000004,
    JET_bitPrereadForward       = 0x00000001,
    JET_bitPrereadBackward      = 0x00000002,
    JET_bitPrereadFirstPage     = 0x00000004,
    JET_bitPrereadNormalizedKey = 0x00000008,
}

enum : uint
{
    JET_bitTTUnique               = 0x00000002,
    JET_bitTTUpdatable            = 0x00000004,
    JET_bitTTScrollable           = 0x00000008,
    JET_bitTTSortNullsHigh        = 0x00000010,
    JET_bitTTForceMaterialization = 0x00000020,
}

enum : uint
{
    JET_bitTTForwardOnly      = 0x00000040,
    JET_bitTTIntrinsicLVsOnly = 0x00000080,
}

enum uint JET_bitTTMaterializeBBT = 0x00000200;

enum : uint
{
    JET_bitSetOverwriteLV                 = 0x00000004,
    JET_bitSetSizeLV                      = 0x00000008,
    JET_bitSetZeroLength                  = 0x00000020,
    JET_bitSetSeparateLV                  = 0x00000040,
    JET_bitSetUniqueMultiValues           = 0x00000080,
    JET_bitSetUniqueNormalizedMultiValues = 0x00000100,
}

enum : uint
{
    JET_bitSetIntrinsicLV  = 0x00000400,
    JET_bitSetUncompressed = 0x00010000,
    JET_bitSetCompressed   = 0x00020000,
    JET_bitSetContiguousLV = 0x00040000,
}

enum : uint
{
    JET_bitCreateHintAppendSequential   = 0x00000002,
    JET_bitCreateHintHotpointSequential = 0x00000004,
}

enum : uint
{
    JET_bitRetrieveHintTableScanForward  = 0x00000010,
    JET_bitRetrieveHintTableScanBackward = 0x00000020,
    JET_bitRetrieveHintReserve2          = 0x00000040,
    JET_bitRetrieveHintReserve3          = 0x00000080,
}

enum : uint
{
    JET_prepInsert        = 0x00000000,
    JET_prepReplace       = 0x00000002,
    JET_prepCancel        = 0x00000003,
    JET_prepReplaceNoLock = 0x00000004,
}

enum : uint
{
    JET_prepInsertCopyDeleteOriginal  = 0x00000007,
    JET_prepInsertCopyReplaceOriginal = 0x00000009,
}

enum : uint
{
    JET_sqmEnable   = 0x00000001,
    JET_sqmFromCEIP = 0x00000002,
}

enum uint JET_bitEscrowNoRollback = 0x00000001;

enum : uint
{
    JET_bitRetrieveFromIndex           = 0x00000002,
    JET_bitRetrieveFromPrimaryBookmark = 0x00000004,
    JET_bitRetrieveTag                 = 0x00000008,
    JET_bitRetrieveNull                = 0x00000010,
    JET_bitRetrieveIgnoreDefault       = 0x00000020,
    JET_bitRetrieveTuple               = 0x00000800,
}

enum : uint
{
    JET_bitEnumerateCopy                     = 0x00000001,
    JET_bitEnumerateIgnoreDefault            = 0x00000020,
    JET_bitEnumeratePresenceOnly             = 0x00020000,
    JET_bitEnumerateTaggedOnly               = 0x00040000,
    JET_bitEnumerateCompressOutput           = 0x00080000,
    JET_bitEnumerateIgnoreUserDefinedDefault = 0x00100000,
    JET_bitEnumerateInRecordOnly             = 0x00200000,
}

enum : uint
{
    JET_bitRecordSizeRunningTotal = 0x00000002,
    JET_bitRecordSizeLocal        = 0x00000004,
}

enum uint JET_bitCommitLazyFlush = 0x00000001;
enum uint JET_bitWaitAllLevel0Commit = 0x00000008;
enum uint JET_bitRollbackAll = 0x00000001;

enum : uint
{
    JET_bitCopySnapshot      = 0x00000002,
    JET_bitContinueAfterThaw = 0x00000004,
}

enum uint JET_bitAllDatabasesSnapshot = 0x00000001;

enum : uint
{
    JET_DbInfoFilename       = 0x00000000,
    JET_DbInfoConnect        = 0x00000001,
    JET_DbInfoCountry        = 0x00000002,
    JET_DbInfoLCID           = 0x00000003,
    JET_DbInfoLangid         = 0x00000003,
    JET_DbInfoCp             = 0x00000004,
    JET_DbInfoCollate        = 0x00000005,
    JET_DbInfoOptions        = 0x00000006,
    JET_DbInfoTransactions   = 0x00000007,
    JET_DbInfoVersion        = 0x00000008,
    JET_DbInfoIsam           = 0x00000009,
    JET_DbInfoFilesize       = 0x0000000a,
    JET_DbInfoSpaceOwned     = 0x0000000b,
    JET_DbInfoSpaceAvailable = 0x0000000c,
    JET_DbInfoUpgrade        = 0x0000000d,
    JET_DbInfoMisc           = 0x0000000e,
    JET_DbInfoDBInUse        = 0x0000000f,
    JET_DbInfoPageSize       = 0x00000011,
    JET_DbInfoFileType       = 0x00000013,
    JET_DbInfoFilesizeOnDisk = 0x00000015,
}

enum : uint
{
    JET_dbstateDirtyShutdown  = 0x00000002,
    JET_dbstateCleanShutdown  = 0x00000003,
    JET_dbstateBeingConverted = 0x00000004,
    JET_dbstateForceDetach    = 0x00000005,
}

enum : uint
{
    JET_filetypeDatabase     = 0x00000001,
    JET_filetypeLog          = 0x00000003,
    JET_filetypeCheckpoint   = 0x00000004,
    JET_filetypeTempDatabase = 0x00000005,
    JET_filetypeFlushMap     = 0x00000007,
}

enum : uint
{
    JET_coltypBit              = 0x00000001,
    JET_coltypUnsignedByte     = 0x00000002,
    JET_coltypShort            = 0x00000003,
    JET_coltypLong             = 0x00000004,
    JET_coltypCurrency         = 0x00000005,
    JET_coltypIEEESingle       = 0x00000006,
    JET_coltypIEEEDouble       = 0x00000007,
    JET_coltypDateTime         = 0x00000008,
    JET_coltypBinary           = 0x00000009,
    JET_coltypText             = 0x0000000a,
    JET_coltypLongBinary       = 0x0000000b,
    JET_coltypLongText         = 0x0000000c,
    JET_coltypMax              = 0x0000000d,
    JET_coltypSLV              = 0x0000000d,
    JET_coltypUnsignedLong     = 0x0000000e,
    JET_coltypLongLong         = 0x0000000f,
    JET_coltypGUID             = 0x00000010,
    JET_coltypUnsignedShort    = 0x00000011,
    JET_coltypUnsignedLongLong = 0x00000012,
}

enum : uint
{
    JET_ColInfoGrbitMinimalInfo    = 0x40000000,
    JET_ColInfoGrbitSortByColumnid = 0x20000000,
}

enum uint JET_objtypTable = 0x00000001;
enum uint JET_bitCompactRepair = 0x00000040;

enum : uint
{
    JET_snpCompact             = 0x00000004,
    JET_snpRestore             = 0x00000008,
    JET_snpBackup              = 0x00000009,
    JET_snpUpgrade             = 0x0000000a,
    JET_snpScrub               = 0x0000000b,
    JET_snpUpgradeRecordFormat = 0x0000000c,
}

enum uint JET_sntRequirements = 0x00000007;

enum : uint
{
    JET_sntComplete = 0x00000006,
    JET_sntFail     = 0x00000003,
}

enum : uint
{
    JET_ExceptionNone     = 0x00000002,
    JET_ExceptionFailFast = 0x00000004,
}

enum : uint
{
    JET_OnlineDefragAllOBSOLETE = 0x00000001,
    JET_OnlineDefragDatabases   = 0x00000002,
    JET_OnlineDefragSpaceTrees  = 0x00000004,
    JET_OnlineDefragAll         = 0x0000ffff,
}

enum uint JET_bitResizeDatabaseOnlyShrink = 0x00000002;

enum : uint
{
    JET_bitStopServiceBackgroundUserTasks = 0x00000002,
    JET_bitStopServiceQuiesceCaches       = 0x00000004,
    JET_bitStopServiceResume              = 0x80000000,
}

enum int JET_wrnNyi = 0xffffffff;
enum int JET_errRfsNotArmed = 0xffffff9b;
enum int JET_errOutOfThreads = 0xffffff99;
enum int JET_errTaskDropped = 0xffffff96;
enum int JET_errDisabledFunctionality = 0xffffff90;
enum int JET_errDatabaseBufferDependenciesCorrupted = 0xffffff01;
enum int JET_errPreviousVersion = 0xfffffebe;
enum int JET_errKeyBoundary = 0xfffffebc;
enum int JET_errBadBookmark = 0xfffffeb8;
enum int JET_errBadParentPageLink = 0xfffffeae;

enum : int
{
    JET_errSPAvailExtCorrupted        = 0xfffffeab,
    JET_errSPAvailExtCacheOutOfMemory = 0xfffffeaa,
}

enum int JET_errDbTimeCorrupted = 0xfffffea8;
enum int JET_errKeyTruncated = 0xfffffea6;
enum int JET_errBadEmptyPage = 0xfffffea1;
enum uint wrnBTNotVisibleAccumulated = 0x00000161;
enum int JET_errPageTagCorrupted = 0xfffffe9b;

enum : int
{
    JET_errBBTNodeCorrupted = 0xfffffe94,
    JET_errBBTBuffCorrupted = 0xfffffe93,
}

enum : int
{
    JET_errKeyTooBig                 = 0xfffffe68,
    JET_errCannotSeparateIntrinsicLV = 0xfffffe60,
}

enum int JET_errMustBeSeparateLongValue = 0xfffffe59;
enum int JET_errInvalidLoggedOperation = 0xfffffe0c;
enum int JET_errNoBackupDirectory = 0xfffffe09;
enum int JET_errBackupInProgress = 0xfffffe07;
enum int JET_errMissingPreviousLogFile = 0xfffffe03;
enum int JET_errLogDisabledDueToRecoveryFailure = 0xfffffe01;
enum int JET_errLogGenerationMismatch = 0xfffffdff;
enum int JET_errInvalidLogSequence = 0xfffffdfd;

enum : int
{
    JET_errLogBufferTooSmall = 0xfffffdfb,
    JET_errLogSequenceEnd    = 0xfffffdf9,
}

enum int JET_errInvalidBackupSequence = 0xfffffdf7;
enum int JET_errDeleteBackupFileFail = 0xfffffdf4;
enum int JET_errInvalidBackup = 0xfffffdf2;
enum int JET_errMissingLogFile = 0xfffffdf0;

enum : int
{
    JET_errBadLogSignature        = 0xfffffdee,
    JET_errBadDbSignature         = 0xfffffded,
    JET_errBadCheckpointSignature = 0xfffffdec,
}

enum int JET_errMissingPatchPage = 0xfffffdea;
enum int JET_errRedoAbruptEnded = 0xfffffde8;

enum : int
{
    JET_errDatabaseLogSetMismatch        = 0xfffffde5,
    JET_errDatabaseStreamingFileMismatch = 0xfffffde4,
}

enum int JET_errCheckpointFileNotFound = 0xfffffde2;
enum int JET_errSoftRecoveryOnBackupDatabase = 0xfffffde0;

enum : int
{
    JET_errLogSectorSizeMismatch                    = 0xfffffdde,
    JET_errLogSectorSizeMismatchDatabasesConsistent = 0xfffffddd,
}

enum int JET_errStreamingDataNotLogged = 0xfffffddb;
enum int JET_errDatabaseInconsistent = 0xfffffdda;
enum int JET_errDatabasePatchFileMismatch = 0xfffffdd8;
enum int JET_errStartingRestoreLogTooHigh = 0xfffffdd6;
enum int JET_errGivenLogFileIsNotContiguous = 0xfffffdd4;

enum : uint
{
    JET_wrnExistingLogFileHasBadSignature = 0x0000022e,
    JET_wrnExistingLogFileIsNotContiguous = 0x0000022f,
}

enum int JET_errBadBackupDatabaseSize = 0xfffffdcf;
enum int JET_errDatabaseIncompleteUpgrade = 0xfffffdcd;
enum int JET_errMissingCurrentLogFiles = 0xfffffdcb;
enum int JET_errDbTimeTooNew = 0xfffffdc9;

enum : int
{
    JET_errLogTornWriteDuringHardRestore  = 0xfffffdc6,
    JET_errLogTornWriteDuringHardRecovery = 0xfffffdc5,
}

enum int JET_errLogCorruptDuringHardRecovery = 0xfffffdc2;
enum int JET_errBadRestoreTargetInstance = 0xfffffdbf;
enum int JET_errRecoveredWithoutUndo = 0xfffffdbd;
enum int JET_errSoftRecoveryOnSnapshot = 0xfffffdbb;
enum int JET_errSectorSizeNotSupported = 0xfffffdb9;
enum uint JET_wrnCommittedLogFilesLost = 0x00000249;
enum uint JET_wrnCommittedLogFilesRemoved = 0x0000024b;
enum int JET_errLogSequenceChecksumMismatch = 0xfffffdb2;
enum int JET_errPageInitializedMismatch = 0xfffffdac;

enum : int
{
    JET_errUnicodeTranslationFail           = 0xfffffda6,
    JET_errUnicodeNormalizationNotSupported = 0xfffffda5,
}

enum : int
{
    JET_errExistingLogFileHasBadSignature = 0xfffffd9e,
    JET_errExistingLogFileIsNotContiguous = 0xfffffd9d,
}

enum int JET_errCheckpointDepthTooDeep = 0xfffffd9a;
enum int JET_errLogFileNotCopied = 0xfffffd98;

enum : int
{
    JET_errEngineFormatVersionNoLongerSupportedTooLow           = 0xfffffd95,
    JET_errEngineFormatVersionNotYetImplementedTooHigh          = 0xfffffd94,
    JET_errEngineFormatVersionParamTooLowForRequestedFeature    = 0xfffffd93,
    JET_errEngineFormatVersionSpecifiedTooLowForLogVersion      = 0xfffffd92,
    JET_errEngineFormatVersionSpecifiedTooLowForDatabaseVersion = 0xfffffd91,
}

enum int JET_errLogOperationInconsistentWithDatabase = 0xfffffd8e;
enum int JET_errBackupAbortByServer = 0xfffffcdf;
enum int JET_errTermInProgress = 0xfffffc18;

enum : int
{
    JET_errInvalidName      = 0xfffffc16,
    JET_errInvalidParameter = 0xfffffc15,
}

enum uint JET_wrnBufferTruncated = 0x000003ee;
enum int JET_errDatabaseFileReadOnly = 0xfffffc10;
enum int JET_errInvalidDatabaseId = 0xfffffc0e;

enum : int
{
    JET_errOutOfDatabaseSpace = 0xfffffc0c,
    JET_errOutOfCursors       = 0xfffffc0b,
    JET_errOutOfBuffers       = 0xfffffc0a,
}

enum int JET_errTooManyKeys = 0xfffffc08;
enum int JET_errReadVerifyFailure = 0xfffffc06;
enum int JET_errOutOfFileHandles = 0xfffffc04;

enum : int
{
    JET_errDiskIO              = 0xfffffc02,
    JET_errInvalidPath         = 0xfffffc01,
    JET_errInvalidSystemPath   = 0xfffffc00,
    JET_errInvalidLogDirectory = 0xfffffbff,
}

enum int JET_errTooManyOpenDatabases = 0xfffffbfd;
enum int JET_errNotInitialized = 0xfffffbfb;
enum int JET_errInitInProgress = 0xfffffbf9;
enum int JET_errBufferTooSmall = 0xfffffbf2;
enum int JET_errTooManyColumns = 0xfffffbf0;

enum : int
{
    JET_errInvalidFilename = 0xfffffbec,
    JET_errInvalidBookmark = 0xfffffbeb,
}

enum int JET_errInvalidBufferSize = 0xfffffbe9;

enum : int
{
    JET_errIndexInUse       = 0xfffffbe5,
    JET_errLinkNotSupported = 0xfffffbe4,
}

enum int JET_errNotInTransaction = 0xfffffbe2;
enum int JET_errMustRollback = 0xfffffbdf;
enum int JET_errTooManyActiveUsers = 0xfffffbdd;

enum : int
{
    JET_errInvalidLanguageId       = 0xfffffbda,
    JET_errInvalidCodePage         = 0xfffffbd9,
    JET_errInvalidLCMapStringFlags = 0xfffffbd8,
}

enum int JET_errVersionStoreOutOfMemoryAndCleanupTimedOut = 0xfffffbd6;
enum uint JET_wrnColumnSetNull = 0x0000042c;
enum int JET_errCannotIndex = 0xfffffbd1;
enum int JET_errTooManyMempoolEntries = 0xfffffbcf;

enum : int
{
    JET_errOutOfLongValueIDs        = 0xfffffbcd,
    JET_errOutOfAutoincrementValues = 0xfffffbcc,
}

enum int JET_errOutOfSequentialIndexValues = 0xfffffbca;
enum int JET_errRunningInMultiInstanceMode = 0xfffffbc7;
enum int JET_errSystemPathInUse = 0xfffffbc5;
enum int JET_errTempPathInUse = 0xfffffbc3;
enum int JET_errSystemParameterConflict = 0xfffffbc1;
enum int JET_errDatabaseUnavailable = 0xfffffbbd;
enum int JET_errInvalidSesparamId = 0xfffffbbb;
enum int JET_errInvalidDbparamId = 0xfffffbb9;
enum int JET_errWriteConflict = 0xfffffbb2;
enum int JET_errInvalidSesid = 0xfffffbb0;
enum int JET_errInTransaction = 0xfffffbac;
enum int JET_errTransReadOnly = 0xfffffbaa;
enum int JET_errRecordTooBigForBackwardCompatibility = 0xfffffba8;
enum int JET_errSesidTableIdMismatch = 0xfffffba6;
enum int JET_errDirtyShutdown = 0xfffffba4;
enum int JET_errReadLostFlushVerifyFailure = 0xfffffba1;
enum uint JET_wrnShrinkNotPossible = 0x00000462;
enum int JET_errFilteredMoveNotSupported = 0xfffffb9c;

enum : int
{
    JET_errDatabaseInUse        = 0xfffffb4e,
    JET_errDatabaseNotFound     = 0xfffffb4d,
    JET_errDatabaseInvalidName  = 0xfffffb4c,
    JET_errDatabaseInvalidPages = 0xfffffb4b,
    JET_errDatabaseCorrupted    = 0xfffffb4a,
    JET_errDatabaseLocked       = 0xfffffb49,
}

enum int JET_errInvalidDatabaseVersion = 0xfffffb47;

enum : int
{
    JET_errDatabase400Format = 0xfffffb45,
    JET_errDatabase500Format = 0xfffffb44,
}

enum int JET_errTooManyInstances = 0xfffffb42;
enum int JET_errAttachedDatabaseMismatch = 0xfffffb40;
enum int JET_errDatabaseIdInUse = 0xfffffb3e;
enum int JET_errCatalogCorrupted = 0xfffffb3c;

enum : int
{
    JET_errDatabaseSignInUse         = 0xfffffb3a,
    JET_errDatabaseCorruptedNoRepair = 0xfffffb38,
}

enum : int
{
    JET_errDatabaseNotReady            = 0xfffffb32,
    JET_errDatabaseAttachedForRecovery = 0xfffffb31,
}

enum uint JET_wrnTableEmpty = 0x00000515;

enum : int
{
    JET_errTableDuplicate = 0xfffffae9,
    JET_errTableInUse     = 0xfffffae8,
    JET_errObjectNotFound = 0xfffffae7,
}

enum int JET_errTableNotEmpty = 0xfffffae4;
enum int JET_errTooManyOpenTables = 0xfffffae1;
enum int JET_errTooManyOpenTablesAndCleanupTimedOut = 0xfffffadf;
enum int JET_errInvalidObject = 0xfffffadc;

enum : int
{
    JET_errCannotDeleteSystemTable   = 0xfffffada,
    JET_errCannotDeleteTemplateTable = 0xfffffad9,
}

enum : int
{
    JET_errFixedDDL          = 0xfffffad5,
    JET_errFixedInheritedDDL = 0xfffffad4,
}

enum int JET_errDDLNotInheritable = 0xfffffad2;
enum int JET_errInvalidSettings = 0xfffffad0;
enum int JET_errCannotAddFixedVarColumnToDerivedTable = 0xffffface;

enum : int
{
    JET_errIndexHasPrimary    = 0xfffffa86,
    JET_errIndexDuplicate     = 0xfffffa85,
    JET_errIndexNotFound      = 0xfffffa84,
    JET_errIndexMustStay      = 0xfffffa83,
    JET_errIndexInvalidDef    = 0xfffffa82,
    JET_errInvalidCreateIndex = 0xfffffa7f,
}

enum int JET_errMultiValuedIndexViolation = 0xfffffa7d;
enum int JET_errPrimaryIndexCorrupted = 0xfffffa7b;
enum uint JET_wrnCorruptIndexDeleted = 0x00000587;
enum uint JET_wrnPrimaryIndexOutOfDate = 0x00000589;

enum : int
{
    JET_errIndexTuplesSecondaryIndexOnly      = 0xfffffa6a,
    JET_errIndexTuplesTooManyColumns          = 0xfffffa69,
    JET_errIndexTuplesOneColumnOnly           = 0xfffffa69,
    JET_errIndexTuplesNonUniqueOnly           = 0xfffffa68,
    JET_errIndexTuplesTextBinaryColumnsOnly   = 0xfffffa67,
    JET_errIndexTuplesTextColumnsOnly         = 0xfffffa67,
    JET_errIndexTuplesVarSegMacNotAllowed     = 0xfffffa66,
    JET_errIndexTuplesInvalidLimits           = 0xfffffa65,
    JET_errIndexTuplesCannotRetrieveFromIndex = 0xfffffa64,
    JET_errIndexTuplesKeyTooSmall             = 0xfffffa63,
}

enum int JET_errColumnCannotBeEncrypted = 0xfffffa61;

enum : int
{
    JET_errColumnLong       = 0xfffffa23,
    JET_errColumnNoChunk    = 0xfffffa22,
    JET_errColumnDoesNotFit = 0xfffffa21,
}

enum : int
{
    JET_errColumnIndexed   = 0xfffffa1f,
    JET_errColumnTooBig    = 0xfffffa1e,
    JET_errColumnNotFound  = 0xfffffa1d,
    JET_errColumnDuplicate = 0xfffffa1c,
}

enum int JET_errColumnRedundant = 0xfffffa1a;
enum uint JET_wrnColumnMaxTruncated = 0x000005e8;
enum int JET_errNoCurrentIndex = 0xfffffa15;

enum : int
{
    JET_errBadColumnId     = 0xfffffa13,
    JET_errBadItagSequence = 0xfffffa12,
}

enum uint JET_wrnCopyLongValue = 0x000005f0;
enum int JET_errDefaultValueTooBig = 0xfffffa0c;
enum int JET_errLVCorrupted = 0xfffffa0a;
enum int JET_errDerivedColumnCorruption = 0xfffffa07;

enum : uint
{
    JET_wrnColumnSkipped     = 0x000005fb,
    JET_wrnColumnNotLocal    = 0x000005fc,
    JET_wrnColumnMoreTags    = 0x000005fd,
    JET_wrnColumnTruncated   = 0x000005fe,
    JET_wrnColumnPresent     = 0x000005ff,
    JET_wrnColumnSingleValue = 0x00000600,
    JET_wrnColumnDefault     = 0x00000601,
}

enum uint JET_wrnColumnNotInRecord = 0x00000603;
enum uint JET_wrnColumnReference = 0x00000605;
enum int JET_errRecordNoCopy = 0xfffff9be;
enum int JET_errRecordPrimaryChanged = 0xfffff9bc;
enum int JET_errAlreadyPrepared = 0xfffff9b9;
enum int JET_errUpdateNotPrepared = 0xfffff9b7;
enum int JET_errDataHasChanged = 0xfffff9b5;
enum int JET_errLanguageNotSupported = 0xfffff9ad;
enum int JET_errUpdateMustVersion = 0xfffff9ab;
enum int JET_errEncryptionBadItag = 0xfffff9a9;
enum int JET_errAutoIncrementNotSet = 0xfffff9a7;
enum int JET_errInvalidOnSort = 0xfffff95a;
enum int JET_errTooManyAttachedDatabases = 0xfffff8f3;
enum int JET_errPermissionDenied = 0xfffff8ef;
enum int JET_errFileInvalidType = 0xfffff8ec;
enum int JET_errFileAlreadyExists = 0xfffff8ea;
enum int JET_errLogCorrupted = 0xfffff8c4;
enum int JET_errAccessDenied = 0xfffff88d;
enum int JET_errTooManySplits = 0xfffff88b;
enum int JET_errEntryPointNotFound = 0xfffff889;
enum int JET_errSessionContextNotSetByThisThread = 0xfffff887;
enum int JET_errRecordFormatConversionFailed = 0xfffff885;
enum int JET_errRollbackError = 0xfffff883;

enum : int
{
    JET_errFlushMapDatabaseMismatch = 0xfffff881,
    JET_errFlushMapUnrecoverable    = 0xfffff880,
}

enum uint JET_wrnDefragNotRunning = 0x000007d1;
enum uint JET_wrnCallbackNotRegistered = 0x00000834;
enum int JET_errCallbackNotResolved = 0xfffff7ca;

enum : int
{
    JET_errOSSnapshotInvalidSequence = 0xfffff69f,
    JET_errOSSnapshotTimeOut         = 0xfffff69e,
    JET_errOSSnapshotNotAllowed      = 0xfffff69d,
    JET_errOSSnapshotInvalidSnapId   = 0xfffff69c,
}

enum : int
{
    JET_errLSAlreadySet    = 0xfffff447,
    JET_errLSNotSet        = 0xfffff446,
    JET_errFileIOSparse    = 0xfffff060,
    JET_errFileIOBeyondEOF = 0xfffff05f,
    JET_errFileIOAbort     = 0xfffff05e,
    JET_errFileIORetry     = 0xfffff05d,
    JET_errFileIOFail      = 0xfffff05c,
    JET_errFileCompressed  = 0xfffff05b,
}

enum int JET_errClientSpaceEnd = 0xffffd121;

enum : uint
{
    JET_bitDumpMinimum                    = 0x00000001,
    JET_bitDumpMaximum                    = 0x00000002,
    JET_bitDumpCacheMinimum               = 0x00000004,
    JET_bitDumpCacheMaximum               = 0x00000008,
    JET_bitDumpCacheIncludeDirtyPages     = 0x00000010,
    JET_bitDumpCacheIncludeCachedPages    = 0x00000020,
    JET_bitDumpCacheIncludeCorruptedPages = 0x00000040,
    JET_bitDumpCacheNoDecommit            = 0x00000080,
}

// Callbacks

alias JET_PFNSTATUS = int function(JET_SESID sesid, uint snp, uint snt, void* pv);
alias JET_CALLBACK = int function(JET_SESID sesid, uint dbid, JET_TABLEID tableid, uint cbtyp, void* pvArg1, 
                                  void* pvArg2, void* pvContext, JET_API_PTR ulUnused);
alias JET_PFNDURABLECOMMITCALLBACK = int function(JET_INSTANCE instance, JET_COMMIT_ID* pCommitIdSeen, uint grbit);
alias JET_PFNREALLOC = void* function(void* pvContext, void* pv, uint cb);

// Structs


@RAIIFree!JetTerm
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-instance))], [])
struct JET_INSTANCE
{
    size_t Value;
}

@RAIIFree!JetEndSession
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-sesid-structure))], [])
struct JET_SESID
{
    size_t Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-ossnapid))], [])
struct JET_OSSNAPID
{
    size_t Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-ls))], [])
struct JET_LS
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-ls.value-property))], [])*/size_t Value;
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexid-structure))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct JET_INDEXID
{
    uint      cbStruct;
    ubyte[16] rgbIndexId;
}
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo-constructor))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct JET_OBJECTINFO
{
    uint   cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.objtyp-property))], [])*/uint objtyp;
    double dtCreate;
    double dtUpdate;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.grbit-property))], [])*/uint grbit;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.flags-property))], [])*/uint flags;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.crecord-property))], [])*/uint cRecord;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.cpage-property))], [])*/uint cPage;
}
}

version (X86) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct JET_RECPOS2
{
    uint  cbStruct;
    uint  centriesLTDeprecated;
    uint  centriesInRangeDeprecated;
    uint  centriesTotalDeprecated;
    ulong centriesLT;
    ulong centriesTotal;
}
}

version (X86) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct JET_THREADSTATS2
{
    uint  cbStruct;
    uint  cPageReferenced;
    uint  cPageRead;
    uint  cPagePreread;
    uint  cPageDirtied;
    uint  cPageRedirtied;
    uint  cLogRecord;
    uint  cbLogRecord;
    ulong cusecPageCacheMiss;
    uint  cPageCacheMiss;
}
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-commit-id-class))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct JET_COMMIT_ID
{
    JET_SIGNATURE signLog;
    int           reserved;
    long          commitId;
}
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize-structure2))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct JET_RECSIZE
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cbdata-property))], [])*/ulong cbData;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvaluedata-property))], [])*/ulong cbLongValueData;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cboverhead-property))], [])*/ulong cbOverhead;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvalueoverhead-property))], [])*/ulong cbLongValueOverhead;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cnontaggedcolumns-property))], [])*/ulong cNonTaggedColumns;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.ctaggedcolumns-property))], [])*/ulong cTaggedColumns;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.clongvalues-property))], [])*/ulong cLongValues;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cmultivalues-property))], [])*/ulong cMultiValues;
}
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize2-structure))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct JET_RECSIZE2
{
    ulong cbData;
    ulong cbLongValueData;
    ulong cbOverhead;
    ulong cbLongValueOverhead;
    ulong cNonTaggedColumns;
    ulong cTaggedColumns;
    ulong cLongValues;
    ulong cMultiValues;
    ulong cCompressedColumns;
    ulong cbDataCompressed;
    ulong cbLongValueDataCompressed;
}
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexid-structure))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct JET_INDEXID
{
    uint      cbStruct;
    ubyte[12] rgbIndexId;
}
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_RSTMAP_A
{
    byte* szDatabaseName;
    byte* szNewDatabaseName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_RSTMAP_W
{
    ushort* szDatabaseName;
    ushort* szNewDatabaseName;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_CONVERT_A
{
    byte* szOldDll;
union Anonymous
    {
        uint fFlags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fSchemaChangesOnly)), FixedArgSig(ElementSig(0)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield0;
        }
    }
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_CONVERT_W
{
    ushort* szOldDll;
union Anonymous
    {
        uint fFlags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fSchemaChangesOnly)), FixedArgSig(ElementSig(0)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield1;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-snprog-class))], [])
struct JET_SNPROG
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-snprog.cunitdone-property))], [])*/uint cunitDone;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-snprog.cunittotal-property))], [])*/uint cunitTotal;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfoupgrade-structure))], [])
struct JET_DBINFOUPGRADE
{
    uint cbStruct;
    uint cbFilesizeLow;
    uint cbFilesizeHigh;
    uint cbFreeSpaceRequiredLow;
    uint cbFreeSpaceRequiredHigh;
    uint csecToUpgrade;
union Anonymous
    {
        uint ulFlags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fAlreadyUpgraded)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield2;
        }
    }
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo-constructor))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct JET_OBJECTINFO
{
align (4):
    uint   cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.objtyp-property))], [])*/uint objtyp;
    double dtCreate;
    double dtUpdate;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.grbit-property))], [])*/uint grbit;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.flags-property))], [])*/uint flags;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.crecord-property))], [])*/uint cRecord;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.cpage-property))], [])*/uint cPage;
}
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist-class))], [])
struct JET_OBJECTLIST
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.tableid-property))], [])*/JET_TABLEID tableid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.crecord-property))], [])*/uint cRecord;
    uint columnidcontainername;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidobjectname-property))], [])*/uint columnidobjectname;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidobjtyp-property))], [])*/uint columnidobjtyp;
    uint columniddtCreate;
    uint columniddtUpdate;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidgrbit-property))], [])*/uint columnidgrbit;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidflags-property))], [])*/uint columnidflags;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidcrecord-property))], [])*/uint columnidcRecord;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidcpage-property))], [])*/uint columnidcPage;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist-structure))], [])
struct JET_COLUMNLIST
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.tableid-property))], [])*/JET_TABLEID tableid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.crecord-property))], [])*/uint cRecord;
    uint columnidPresentationOrder;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcolumnname-property))], [])*/uint columnidcolumnname;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcolumnid-property))], [])*/uint columnidcolumnid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcoltyp-property))], [])*/uint columnidcoltyp;
    uint columnidCountry;
    uint columnidLangid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcp-property))], [])*/uint columnidCp;
    uint columnidCollate;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcbmax-property))], [])*/uint columnidcbMax;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidgrbit-property))], [])*/uint columnidgrbit;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columniddefault-property))], [])*/uint columnidDefault;
    uint columnidBaseTableName;
    uint columnidBaseColumnName;
    uint columnidDefinitionName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef-constructor))], [])
struct JET_COLUMNDEF
{
    uint   cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.columnid-property))], [])*/uint columnid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.coltyp-property))], [])*/uint coltyp;
    ushort wCountry;
    ushort langid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.cp-property))], [])*/ushort cp;
    ushort wCollate;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.cbmax-property))], [])*/uint cbMax;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.grbit-property))], [])*/uint grbit;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_COLUMNBASE_A
{
    uint      cbStruct;
    uint      columnid;
    uint      coltyp;
    ushort    wCountry;
    ushort    langid;
    ushort    cp;
    ushort    wFiller;
    uint      cbMax;
    uint      grbit;
    byte[256] szBaseTableName;
    byte[256] szBaseColumnName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_COLUMNBASE_W
{
    uint        cbStruct;
    uint        columnid;
    uint        coltyp;
    ushort      wCountry;
    ushort      langid;
    ushort      cp;
    ushort      wFiller;
    uint        cbMax;
    uint        grbit;
    ushort[256] szBaseTableName;
    ushort[256] szBaseColumnName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist-structure))], [])
struct JET_INDEXLIST
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.tableid-property))], [])*/JET_TABLEID tableid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.crecord-property))], [])*/uint cRecord;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidindexname-property))], [])*/uint columnidindexname;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidgrbitindex-property))], [])*/uint columnidgrbitIndex;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidckey-property))], [])*/uint columnidcKey;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcentry-property))], [])*/uint columnidcEntry;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcpage-property))], [])*/uint columnidcPage;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidccolumn-property))], [])*/uint columnidcColumn;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidicolumn-property))], [])*/uint columnidiColumn;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcolumnid-property))], [])*/uint columnidcolumnid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcoltyp-property))], [])*/uint columnidcoltyp;
    uint columnidCountry;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidlangid-property))], [])*/uint columnidLangid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcp-property))], [])*/uint columnidCp;
    uint columnidCollate;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidgrbitcolumn-property))], [])*/uint columnidgrbitColumn;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcolumnname-property))], [])*/uint columnidcolumnname;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidlcmapflags-property))], [])*/uint columnidLCMapFlags;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_COLUMNCREATE_A
{
    uint  cbStruct;
    byte* szColumnName;
    uint  coltyp;
    uint  cbMax;
    uint  grbit;
    void* pvDefault;
    uint  cbDefault;
    uint  cp;
    uint  columnid;
    int   err;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_COLUMNCREATE_W
{
    uint    cbStruct;
    ushort* szColumnName;
    uint    coltyp;
    uint    cbMax;
    uint    grbit;
    void*   pvDefault;
    uint    cbDefault;
    uint    cp;
    uint    columnid;
    int     err;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_USERDEFINEDDEFAULT_A
{
    byte*  szCallback;
    ubyte* pbUserData;
    uint   cbUserData;
    byte*  szDependantColumns;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_USERDEFINEDDEFAULT_W
{
    ushort* szCallback;
    ubyte*  pbUserData;
    uint    cbUserData;
    ushort* szDependantColumns;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_CONDITIONALCOLUMN_A
{
    uint  cbStruct;
    byte* szColumnName;
    uint  grbit;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_CONDITIONALCOLUMN_W
{
    uint    cbStruct;
    ushort* szColumnName;
    uint    grbit;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-unicodeindex-structure))], [])
struct JET_UNICODEINDEX
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-unicodeindex.lcid-property))], [])*/uint lcid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-unicodeindex.dwmapflags-property))], [])*/uint dwMapFlags;
}

struct JET_UNICODEINDEX2
{
    ushort* szLocaleName;
    uint    dwMapFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-tuplelimits-structure))], [])
struct JET_TUPLELIMITS
{
    uint chLengthMin;
    uint chLengthMax;
    uint chToIndexMax;
    uint cchIncrement;
    uint ichStart;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints-class))], [])
struct JET_SPACEHINTS
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.ulinitialdensity-property))], [])*/uint ulInitialDensity;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.cbinitial-property))], [])*/uint cbInitial;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.grbit-property))], [])*/uint grbit;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.ulmaintdensity-property))], [])*/uint ulMaintDensity;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.ulgrowth-property))], [])*/uint ulGrowth;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.cbminextent-property))], [])*/uint cbMinExtent;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.cbmaxextent-property))], [])*/uint cbMaxExtent;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_INDEXCREATE_A
{
    uint  cbStruct;
    byte* szIndexName;
    byte* szKey;
    uint  cbKey;
    uint  grbit;
    uint  ulDensity;
union Anonymous1
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
union Anonymous2
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint  cConditionalColumn;
    int   err;
    uint  cbKeyMost;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_INDEXCREATE_W
{
    uint    cbStruct;
    ushort* szIndexName;
    ushort* szKey;
    uint    cbKey;
    uint    grbit;
    uint    ulDensity;
union Anonymous1
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
union Anonymous2
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint    cConditionalColumn;
    int     err;
    uint    cbKeyMost;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_INDEXCREATE2_A
{
    uint            cbStruct;
    byte*           szIndexName;
    byte*           szKey;
    uint            cbKey;
    uint            grbit;
    uint            ulDensity;
union Anonymous1
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
union Anonymous2
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint            cConditionalColumn;
    int             err;
    uint            cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_INDEXCREATE2_W
{
    uint            cbStruct;
    ushort*         szIndexName;
    ushort*         szKey;
    uint            cbKey;
    uint            grbit;
    uint            ulDensity;
union Anonymous1
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
union Anonymous2
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint            cConditionalColumn;
    int             err;
    uint            cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_INDEXCREATE3_A
{
    uint               cbStruct;
    byte*              szIndexName;
    byte*              szKey;
    uint               cbKey;
    uint               grbit;
    uint               ulDensity;
    JET_UNICODEINDEX2* pidxunicode;
union Anonymous
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint               cConditionalColumn;
    int                err;
    uint               cbKeyMost;
    JET_SPACEHINTS*    pSpacehints;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_INDEXCREATE3_W
{
    uint               cbStruct;
    ushort*            szIndexName;
    ushort*            szKey;
    uint               cbKey;
    uint               grbit;
    uint               ulDensity;
    JET_UNICODEINDEX2* pidxunicode;
union Anonymous
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint               cConditionalColumn;
    int                err;
    uint               cbKeyMost;
    JET_SPACEHINTS*    pSpacehints;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_TABLECREATE_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE_A*  rgindexcreate;
    uint                cIndexes;
    uint                grbit;
    JET_TABLEID         tableid;
    uint                cCreated;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_TABLECREATE_W
{
    uint                cbStruct;
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE_W*  rgindexcreate;
    uint                cIndexes;
    uint                grbit;
    JET_TABLEID         tableid;
    uint                cCreated;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_TABLECREATE2_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE_A*  rgindexcreate;
    uint                cIndexes;
    byte*               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_TABLEID         tableid;
    uint                cCreated;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_TABLECREATE2_W
{
    uint                cbStruct;
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE_W*  rgindexcreate;
    uint                cIndexes;
    ushort*             szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_TABLEID         tableid;
    uint                cCreated;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_TABLECREATE3_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE2_A* rgindexcreate;
    uint                cIndexes;
    byte*               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    JET_TABLEID         tableid;
    uint                cCreated;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_TABLECREATE3_W
{
    uint                cbStruct;
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE2_W* rgindexcreate;
    uint                cIndexes;
    ushort*             szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    JET_TABLEID         tableid;
    uint                cCreated;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_TABLECREATE4_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE3_A* rgindexcreate;
    uint                cIndexes;
    byte*               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    JET_TABLEID         tableid;
    uint                cCreated;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_TABLECREATE4_W
{
    uint                cbStruct;
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE3_W* rgindexcreate;
    uint                cIndexes;
    ushort*             szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    JET_TABLEID         tableid;
    uint                cCreated;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable-structure))], [])
struct JET_OPENTEMPORARYTABLE
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.prgcolumndef-property))], [])*/const(JET_COLUMNDEF)* prgcolumndef;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.ccolumn-property))], [])*/uint ccolumn;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.pidxunicode-property))], [])*/JET_UNICODEINDEX* pidxunicode;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.grbit-property))], [])*/uint grbit;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.prgcolumnid-property))], [])*/uint* prgcolumnid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.cbkeymost-property))], [])*/uint cbKeyMost;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.cbvarsegmac-property))], [])*/uint cbVarSegMac;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.tableid-property))], [])*/JET_TABLEID tableid;
}

struct JET_OPENTEMPORARYTABLE2
{
    uint               cbStruct;
    const(JET_COLUMNDEF)* prgcolumndef;
    uint               ccolumn;
    JET_UNICODEINDEX2* pidxunicode;
    uint               grbit;
    uint*              prgcolumnid;
    uint               cbKeyMost;
    uint               cbVarSegMac;
    JET_TABLEID        tableid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retinfo-structure))], [])
struct JET_RETINFO
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retinfo.iblongvalue-property))], [])*/uint ibLongValue;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retinfo.itagsequence-property))], [])*/uint itagSequence;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retinfo.columnidnexttagged-property))], [])*/uint columnidNextTagged;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setinfo-class))], [])
struct JET_SETINFO
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setinfo.iblongvalue-property))], [])*/uint ibLongValue;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setinfo.itagsequence-property))], [])*/uint itagSequence;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recpos-constructor))], [])
struct JET_RECPOS
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recpos.centrieslt-property))], [])*/uint centriesLT;
    uint centriesInRange;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recpos.centriestotal-property))], [])*/uint centriesTotal;
}

version (X86_64) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct JET_RECPOS2
{
align (4):
    uint  cbStruct;
    uint  centriesLTDeprecated;
    uint  centriesInRangeDeprecated;
    uint  centriesTotalDeprecated;
    ulong centriesLT;
    ulong centriesTotal;
}
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recordlist-constructor))], [])
struct JET_RECORDLIST
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recordlist.tableid-property))], [])*/JET_TABLEID tableid;
    uint cRecord;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recordlist.columnidbookmark-property))], [])*/uint columnidBookmark;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexrange-structure))], [])
struct JET_INDEXRANGE
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexrange.tableid-property))], [])*/JET_TABLEID tableid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexrange.grbit-property))], [])*/uint grbit;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-column-constructor))], [])
struct JET_INDEX_COLUMN
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-column.columnid-property))], [])*/uint columnid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-column.relop-property))], [])*/JET_RELOP relop;
    void* pv;
    uint  cb;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-column.grbit-property))], [])*/uint grbit;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-range-constructor))], [])
struct JET_INDEX_RANGE
{
    JET_INDEX_COLUMN* rgStartColumns;
    uint              cStartColumns;
    JET_INDEX_COLUMN* rgEndColumns;
    uint              cEndColumns;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-logtime-structure))], [])
struct JET_LOGTIME
{
    byte bSeconds;
    byte bMinutes;
    byte bHours;
    byte bDay;
    byte bMonth;
    byte bYear;
union Anonymous1
    {
        ubyte bFiller1;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(bMillisecondsLow)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(7))], [])*/ubyte _bitfield3;
        }
    }
union Anonymous2
    {
        ubyte bFiller2;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fUnused)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(4))], [])*/ubyte _bitfield4;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bklogtime-structure))], [])
struct JET_BKLOGTIME
{
    byte bSeconds;
    byte bMinutes;
    byte bHours;
    byte bDay;
    byte bMonth;
    byte bYear;
union Anonymous1
    {
        ubyte bFiller1;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fReserved)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(4))], [])*/ubyte _bitfield5;
        }
    }
union Anonymous2
    {
        ubyte bFiller2;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(fReserved)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(4))], [])*/ubyte _bitfield6;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-lgpos-structure2))], [])
struct JET_LGPOS
{
align (1):
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-lgpos.ib-property))], [])*/ushort ib;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-lgpos.isec-property))], [])*/ushort isec;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-lgpos.lgeneration-property))], [])*/int lGeneration;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-signature-structure))], [])
struct JET_SIGNATURE
{
align (1):
    uint        ulRandom;
    JET_LOGTIME logtimeCreate;
    byte[16]    szComputerName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bkinfo-structure2))], [])
struct JET_BKINFO
{
align (1):
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bkinfo.lgposmark-property))], [])*/JET_LGPOS lgposMark;
union Anonymous
    {
        JET_LOGTIME   logtimeMark;
        JET_BKLOGTIME bklogtimeMark;
    }
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bkinfo.genlow-property))], [])*/uint genLow;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bkinfo.genhigh-property))], [])*/uint genHigh;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc-constructor))], [])
struct JET_DBINFOMISC
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.ulversion-property))], [])*/uint ulVersion;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.ulupdate-property))], [])*/uint ulUpdate;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.signdb-property))], [])*/JET_SIGNATURE signDb;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.dbstate-property))], [])*/uint dbstate;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.lgposconsistent-property))], [])*/JET_LGPOS lgposConsistent;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.logtimeconsistent-property))], [])*/JET_LOGTIME logtimeConsistent;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.logtimeattach-property))], [])*/JET_LOGTIME logtimeAttach;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.lgposattach-property))], [])*/JET_LGPOS lgposAttach;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.logtimedetach-property))], [])*/JET_LOGTIME logtimeDetach;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.lgposdetach-property))], [])*/JET_LGPOS lgposDetach;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.signlog-property))], [])*/JET_SIGNATURE signLog;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.bkinfofullprev-property))], [])*/JET_BKINFO bkinfoFullPrev;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.bkinfoincprev-property))], [])*/JET_BKINFO bkinfoIncPrev;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.bkinfofullcur-property))], [])*/JET_BKINFO bkinfoFullCur;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.fshadowingdisabled-property))], [])*/uint fShadowingDisabled;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.fupgradedb-property))], [])*/uint fUpgradeDb;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.dwmajorversion-property))], [])*/uint dwMajorVersion;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.dwminorversion-property))], [])*/uint dwMinorVersion;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.dwbuildnumber-property))], [])*/uint dwBuildNumber;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.lspnumber-property))], [])*/int lSPNumber;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.cbpagesize-property))], [])*/uint cbPageSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc2-structure))], [])
struct JET_DBINFOMISC2
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
    uint          genMinRequired;
    uint          genMaxRequired;
    JET_LOGTIME   logtimeGenMaxCreate;
    uint          ulRepairCount;
    JET_LOGTIME   logtimeRepair;
    uint          ulRepairCountOld;
    uint          ulECCFixSuccess;
    JET_LOGTIME   logtimeECCFixSuccess;
    uint          ulECCFixSuccessOld;
    uint          ulECCFixFail;
    JET_LOGTIME   logtimeECCFixFail;
    uint          ulECCFixFailOld;
    uint          ulBadChecksum;
    JET_LOGTIME   logtimeBadChecksum;
    uint          ulBadChecksumOld;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc3-structure))], [])
struct JET_DBINFOMISC3
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
    uint          genMinRequired;
    uint          genMaxRequired;
    JET_LOGTIME   logtimeGenMaxCreate;
    uint          ulRepairCount;
    JET_LOGTIME   logtimeRepair;
    uint          ulRepairCountOld;
    uint          ulECCFixSuccess;
    JET_LOGTIME   logtimeECCFixSuccess;
    uint          ulECCFixSuccessOld;
    uint          ulECCFixFail;
    JET_LOGTIME   logtimeECCFixFail;
    uint          ulECCFixFailOld;
    uint          ulBadChecksum;
    JET_LOGTIME   logtimeBadChecksum;
    uint          ulBadChecksumOld;
    uint          genCommitted;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc4-structure))], [])
struct JET_DBINFOMISC4
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
    uint          genMinRequired;
    uint          genMaxRequired;
    JET_LOGTIME   logtimeGenMaxCreate;
    uint          ulRepairCount;
    JET_LOGTIME   logtimeRepair;
    uint          ulRepairCountOld;
    uint          ulECCFixSuccess;
    JET_LOGTIME   logtimeECCFixSuccess;
    uint          ulECCFixSuccessOld;
    uint          ulECCFixFail;
    JET_LOGTIME   logtimeECCFixFail;
    uint          ulECCFixFailOld;
    uint          ulBadChecksum;
    JET_LOGTIME   logtimeBadChecksum;
    uint          ulBadChecksumOld;
    uint          genCommitted;
    JET_BKINFO    bkinfoCopyPrev;
    JET_BKINFO    bkinfoDiffPrev;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats-structure2))], [])
struct JET_THREADSTATS
{
    uint cbStruct;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpagereferenced-property))], [])*/uint cPageReferenced;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpageread-property))], [])*/uint cPageRead;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpagepreread-property))], [])*/uint cPagePreread;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpagedirtied-property))], [])*/uint cPageDirtied;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpageredirtied-property))], [])*/uint cPageRedirtied;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.clogrecord-property))], [])*/uint cLogRecord;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cblogrecord-property))], [])*/uint cbLogRecord;
}

version (X86_64) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct JET_THREADSTATS2
{
align (4):
    uint  cbStruct;
    uint  cPageReferenced;
    uint  cPageRead;
    uint  cPagePreread;
    uint  cPageDirtied;
    uint  cPageRedirtied;
    uint  cLogRecord;
    uint  cbLogRecord;
    ulong cusecPageCacheMiss;
    uint  cPageCacheMiss;
}
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_RSTINFO_A
{
    uint          cbStruct;
    JET_RSTMAP_A* rgrstmap;
    int           crstmap;
    JET_LGPOS     lgposStop;
    JET_LOGTIME   logtimeStop;
    JET_PFNSTATUS pfnStatus;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_RSTINFO_W
{
    uint          cbStruct;
    JET_RSTMAP_W* rgrstmap;
    int           crstmap;
    JET_LGPOS     lgposStop;
    JET_LOGTIME   logtimeStop;
    JET_PFNSTATUS pfnStatus;
}

struct JET_ERRINFOBASIC_W
{
    uint       cbStruct;
    int        errValue;
    JET_ERRCAT errcatMostSpecific;
    ubyte[8]   rgCategoricalHierarchy;
    uint       lSourceLine;
    ushort[64] rgszSourceFile;
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-commit-id-class))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct JET_COMMIT_ID
{
align (4):
    JET_SIGNATURE signLog;
    int           reserved;
    long          commitId;
}
}

struct JET_OPERATIONCONTEXT
{
    uint  ulUserID;
    ubyte nOperationID;
    ubyte nOperationType;
    ubyte nClientType;
    ubyte fFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn-constructor))], [])
struct JET_SETCOLUMN
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.columnid-property))], [])*/uint columnid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.pvdata-property))], [])*/void* pvData;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.cbdata-property))], [])*/uint cbData;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.grbit-property))], [])*/uint grbit;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.iblongvalue-property))], [])*/uint ibLongValue;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.itagsequence-property))], [])*/uint itagSequence;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.err-property))], [])*/int err;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_SETSYSPARAM_A
{
    uint        paramid;
    JET_API_PTR lParam;
    byte*       sz;
    int         err;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_SETSYSPARAM_W
{
    uint        paramid;
    JET_API_PTR lParam;
    ushort*     sz;
    int         err;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn-structure))], [])
struct JET_RETRIEVECOLUMN
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.columnid-property))], [])*/uint columnid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.pvdata-property))], [])*/void* pvData;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.cbdata-property))], [])*/uint cbData;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.cbactual-property))], [])*/uint cbActual;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.grbit-property))], [])*/uint grbit;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.iblongvalue-property))], [])*/uint ibLongValue;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.itagsequence-property))], [])*/uint itagSequence;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.columnidnexttagged-property))], [])*/uint columnidNextTagged;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.err-property))], [])*/int err;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnid-structure))], [])
struct JET_ENUMCOLUMNID
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnid.columnid-property))], [])*/uint columnid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnid.ctagsequence-property))], [])*/uint ctagSequence;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnid.rgtagsequence-property))], [])*/uint* rgtagSequence;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue-constructor))], [])
struct JET_ENUMCOLUMNVALUE
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue.itagsequence-property))], [])*/uint itagSequence;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue.err-property))], [])*/int err;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue.cbdata-property))], [])*/uint cbData;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue.pvdata-property))], [])*/void* pvData;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumn-class))], [])
struct JET_ENUMCOLUMN
{
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumn.columnid-property))], [])*/uint columnid;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumn.err-property))], [])*/int err;
union Anonymous
    {
struct Anonymous1
        {
            uint                 cEnumColumnValue;
            JET_ENUMCOLUMNVALUE* rgEnumColumnValue;
        }
struct Anonymous2
        {
            uint  cbData;
            void* pvData;
        }
    }
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize-structure2))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct JET_RECSIZE
{
align (4):
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cbdata-property))], [])*/ulong cbData;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvaluedata-property))], [])*/ulong cbLongValueData;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cboverhead-property))], [])*/ulong cbOverhead;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvalueoverhead-property))], [])*/ulong cbLongValueOverhead;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cnontaggedcolumns-property))], [])*/ulong cNonTaggedColumns;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.ctaggedcolumns-property))], [])*/ulong cTaggedColumns;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.clongvalues-property))], [])*/ulong cLongValues;
    /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cmultivalues-property))], [])*/ulong cMultiValues;
}
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize2-structure))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct JET_RECSIZE2
{
align (4):
    ulong cbData;
    ulong cbLongValueData;
    ulong cbOverhead;
    ulong cbLongValueOverhead;
    ulong cNonTaggedColumns;
    ulong cTaggedColumns;
    ulong cLongValues;
    ulong cMultiValues;
    ulong cCompressedColumns;
    ulong cbDataCompressed;
    ulong cbLongValueDataCompressed;
}
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct JET_LOGINFO_A
{
    uint    cbSize;
    uint    ulGenLow;
    uint    ulGenHigh;
    byte[4] szBaseName;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct JET_LOGINFO_W
{
    uint      cbSize;
    uint      ulGenLow;
    uint      ulGenHigh;
    ushort[4] szBaseName;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct JET_INSTANCE_INFO_A
{
    JET_INSTANCE hInstanceId;
    byte*        szInstanceName;
    JET_API_PTR  cDatabases;
    byte**       szDatabaseFileName;
    byte**       szDatabaseDisplayName;
    byte**       szDatabaseSLVFileName_Obsolete;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct JET_INSTANCE_INFO_W
{
    JET_INSTANCE hInstanceId;
    ushort*      szInstanceName;
    JET_API_PTR  cDatabases;
    ushort**     szDatabaseFileName;
    ushort**     szDatabaseDisplayName;
    ushort**     szDatabaseSLVFileName_Obsolete;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetinit-function))], [])
@DllImport("ESENT.dll")
int JetInit(JET_INSTANCE* pinstance);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetinit2-function))], [])
@DllImport("ESENT.dll")
int JetInit2(JET_INSTANCE* pinstance, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetinit3-function))], [])
@DllImport("ESENT.dll")
int JetInit3A(JET_INSTANCE* pinstance, JET_RSTINFO_A* prstInfo, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetinit3-function))], [])
@DllImport("ESENT.dll")
int JetInit3W(JET_INSTANCE* pinstance, JET_RSTINFO_W* prstInfo, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateinstance-function))], [])
@DllImport("ESENT.dll")
int JetCreateInstanceA(JET_INSTANCE* pinstance, byte* szInstanceName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateinstance-function))], [])
@DllImport("ESENT.dll")
int JetCreateInstanceW(JET_INSTANCE* pinstance, ushort* szInstanceName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateinstance2-function))], [])
@DllImport("ESENT.dll")
int JetCreateInstance2A(JET_INSTANCE* pinstance, byte* szInstanceName, byte* szDisplayName, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateinstance2-function))], [])
@DllImport("ESENT.dll")
int JetCreateInstance2W(JET_INSTANCE* pinstance, ushort* szInstanceName, ushort* szDisplayName, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetinstancemiscinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetInstanceMiscInfo(JET_INSTANCE instance, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvResult, 
                           uint cbMax, uint InfoLevel);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetterm-function))], [])
@DllImport("ESENT.dll")
int JetTerm(JET_INSTANCE instance);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetterm2-function))], [])
@DllImport("ESENT.dll")
int JetTerm2(JET_INSTANCE instance, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopservice-function))], [])
@DllImport("ESENT.dll")
int JetStopService();

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopserviceinstance-function))], [])
@DllImport("ESENT.dll")
int JetStopServiceInstance(JET_INSTANCE instance);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopserviceinstance2-function))], [])
@DllImport("ESENT.dll")
int JetStopServiceInstance2(JET_INSTANCE instance, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopbackup-function))], [])
@DllImport("ESENT.dll")
int JetStopBackup();

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopbackupinstance-function))], [])
@DllImport("ESENT.dll")
int JetStopBackupInstance(JET_INSTANCE instance);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetsystemparameter-function))], [])
@DllImport("ESENT.dll")
int JetSetSystemParameterA(JET_INSTANCE* pinstance, JET_SESID sesid, uint paramid, JET_API_PTR lParam, 
                           byte* szParam);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetsystemparameter-function))], [])
@DllImport("ESENT.dll")
int JetSetSystemParameterW(JET_INSTANCE* pinstance, JET_SESID sesid, uint paramid, JET_API_PTR lParam, 
                           ushort* szParam);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetsystemparameter-function))], [])
@DllImport("ESENT.dll")
int JetGetSystemParameterA(JET_INSTANCE instance, JET_SESID sesid, uint paramid, JET_API_PTR* plParam, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/byte* szParam, 
                           uint cbMax);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetsystemparameter-function))], [])
@DllImport("ESENT.dll")
int JetGetSystemParameterW(JET_INSTANCE instance, JET_SESID sesid, uint paramid, JET_API_PTR* plParam, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ushort* szParam, 
                           uint cbMax);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetenablemultiinstance-function))], [])
@DllImport("ESENT.dll")
int JetEnableMultiInstanceA(JET_SETSYSPARAM_A* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetenablemultiinstance-function))], [])
@DllImport("ESENT.dll")
int JetEnableMultiInstanceW(JET_SETSYSPARAM_W* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetthreadstats-function))], [])
@DllImport("ESENT.dll")
int JetGetThreadStats(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvResult, 
                      uint cbMax);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbeginsession-function))], [])
@DllImport("ESENT.dll")
int JetBeginSessionA(JET_INSTANCE instance, JET_SESID* psesid, byte* szUserName, byte* szPassword);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbeginsession-function))], [])
@DllImport("ESENT.dll")
int JetBeginSessionW(JET_INSTANCE instance, JET_SESID* psesid, ushort* szUserName, ushort* szPassword);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdupsession-function))], [])
@DllImport("ESENT.dll")
int JetDupSession(JET_SESID sesid, JET_SESID* psesid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetendsession-function))], [])
@DllImport("ESENT.dll")
int JetEndSession(JET_SESID sesid, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetversion-function))], [])
@DllImport("ESENT.dll")
int JetGetVersion(JET_SESID sesid, uint* pwVersion);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetidle-function))], [])
@DllImport("ESENT.dll")
int JetIdle(JET_SESID sesid, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatedatabase-function))], [])
@DllImport("ESENT.dll")
int JetCreateDatabaseA(JET_SESID sesid, byte* szFilename, byte* szConnect, uint* pdbid, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatedatabase-function))], [])
@DllImport("ESENT.dll")
int JetCreateDatabaseW(JET_SESID sesid, ushort* szFilename, ushort* szConnect, uint* pdbid, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatedatabase2-function))], [])
@DllImport("ESENT.dll")
int JetCreateDatabase2A(JET_SESID sesid, byte* szFilename, const(uint) cpgDatabaseSizeMax, uint* pdbid, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatedatabase2-function))], [])
@DllImport("ESENT.dll")
int JetCreateDatabase2W(JET_SESID sesid, ushort* szFilename, const(uint) cpgDatabaseSizeMax, uint* pdbid, 
                        uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetattachdatabase-function))], [])
@DllImport("ESENT.dll")
int JetAttachDatabaseA(JET_SESID sesid, byte* szFilename, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetattachdatabase-function))], [])
@DllImport("ESENT.dll")
int JetAttachDatabaseW(JET_SESID sesid, ushort* szFilename, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetattachdatabase2-function))], [])
@DllImport("ESENT.dll")
int JetAttachDatabase2A(JET_SESID sesid, byte* szFilename, const(uint) cpgDatabaseSizeMax, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetattachdatabase2-function))], [])
@DllImport("ESENT.dll")
int JetAttachDatabase2W(JET_SESID sesid, ushort* szFilename, const(uint) cpgDatabaseSizeMax, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdetachdatabase-function))], [])
@DllImport("ESENT.dll")
int JetDetachDatabaseA(JET_SESID sesid, byte* szFilename);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdetachdatabase-function))], [])
@DllImport("ESENT.dll")
int JetDetachDatabaseW(JET_SESID sesid, ushort* szFilename);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdetachdatabase2-function))], [])
@DllImport("ESENT.dll")
int JetDetachDatabase2A(JET_SESID sesid, byte* szFilename, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdetachdatabase2-function))], [])
@DllImport("ESENT.dll")
int JetDetachDatabase2W(JET_SESID sesid, ushort* szFilename, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetobjectinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetObjectInfoA(JET_SESID sesid, uint dbid, uint objtyp, byte* szContainerName, byte* szObjectName, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvResult, 
                      uint cbMax, uint InfoLevel);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetobjectinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetObjectInfoW(JET_SESID sesid, uint dbid, uint objtyp, ushort* szContainerName, ushort* szObjectName, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvResult, 
                      uint cbMax, uint InfoLevel);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgettableinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetTableInfoA(JET_SESID sesid, JET_TABLEID tableid, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                     uint cbMax, uint InfoLevel);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgettableinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetTableInfoW(JET_SESID sesid, JET_TABLEID tableid, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                     uint cbMax, uint InfoLevel);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatetable-function))], [])
@DllImport("ESENT.dll")
int JetCreateTableA(JET_SESID sesid, uint dbid, byte* szTableName, uint lPages, uint lDensity, 
                    JET_TABLEID* ptableid);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatetable-function))], [])
@DllImport("ESENT.dll")
int JetCreateTableW(JET_SESID sesid, uint dbid, ushort* szTableName, uint lPages, uint lDensity, 
                    JET_TABLEID* ptableid);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatetablecolumnindex-function))], [])
@DllImport("ESENT.dll")
int JetCreateTableColumnIndexA(JET_SESID sesid, uint dbid, JET_TABLECREATE_A* ptablecreate);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatetablecolumnindex-function))], [])
@DllImport("ESENT.dll")
int JetCreateTableColumnIndexW(JET_SESID sesid, uint dbid, JET_TABLECREATE_W* ptablecreate);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatetablecolumnindex2-function))], [])
@DllImport("ESENT.dll")
int JetCreateTableColumnIndex2A(JET_SESID sesid, uint dbid, JET_TABLECREATE2_A* ptablecreate);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatetablecolumnindex2-function))], [])
@DllImport("ESENT.dll")
int JetCreateTableColumnIndex2W(JET_SESID sesid, uint dbid, JET_TABLECREATE2_W* ptablecreate);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatetablecolumnindex3-function))], [])
@DllImport("ESENT.dll")
int JetCreateTableColumnIndex3A(JET_SESID sesid, uint dbid, JET_TABLECREATE3_A* ptablecreate);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatetablecolumnindex3-function))], [])
@DllImport("ESENT.dll")
int JetCreateTableColumnIndex3W(JET_SESID sesid, uint dbid, JET_TABLECREATE3_W* ptablecreate);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetCreateTableColumnIndex4A(JET_SESID sesid, uint dbid, JET_TABLECREATE4_A* ptablecreate);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreatetablecolumnindex4w-function))], [])
@DllImport("ESENT.dll")
int JetCreateTableColumnIndex4W(JET_SESID sesid, uint dbid, JET_TABLECREATE4_W* ptablecreate);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdeletetable-function))], [])
@DllImport("ESENT.dll")
int JetDeleteTableA(JET_SESID sesid, uint dbid, byte* szTableName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdeletetable-function))], [])
@DllImport("ESENT.dll")
int JetDeleteTableW(JET_SESID sesid, uint dbid, ushort* szTableName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrenametable-function))], [])
@DllImport("ESENT.dll")
int JetRenameTableA(JET_SESID sesid, uint dbid, byte* szName, byte* szNameNew);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrenametable-function))], [])
@DllImport("ESENT.dll")
int JetRenameTableW(JET_SESID sesid, uint dbid, ushort* szName, ushort* szNameNew);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgettablecolumninfo-function))], [])
@DllImport("ESENT.dll")
int JetGetTableColumnInfoA(JET_SESID sesid, JET_TABLEID tableid, byte* szColumnName, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvResult, 
                           uint cbMax, uint InfoLevel);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgettablecolumninfo-function))], [])
@DllImport("ESENT.dll")
int JetGetTableColumnInfoW(JET_SESID sesid, JET_TABLEID tableid, ushort* szColumnName, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvResult, 
                           uint cbMax, uint InfoLevel);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetcolumninfo-function))], [])
@DllImport("ESENT.dll")
int JetGetColumnInfoA(JET_SESID sesid, uint dbid, byte* szTableName, byte* pColumnNameOrId, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvResult, 
                      uint cbMax, uint InfoLevel);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetcolumninfo-function))], [])
@DllImport("ESENT.dll")
int JetGetColumnInfoW(JET_SESID sesid, uint dbid, ushort* szTableName, ushort* pwColumnNameOrId, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvResult, 
                      uint cbMax, uint InfoLevel);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetaddcolumn-function))], [])
@DllImport("ESENT.dll")
int JetAddColumnA(JET_SESID sesid, JET_TABLEID tableid, byte* szColumnName, const(JET_COLUMNDEF)* pcolumndef, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvDefault, 
                  uint cbDefault, uint* pcolumnid);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetaddcolumn-function))], [])
@DllImport("ESENT.dll")
int JetAddColumnW(JET_SESID sesid, JET_TABLEID tableid, ushort* szColumnName, const(JET_COLUMNDEF)* pcolumndef, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvDefault, 
                  uint cbDefault, uint* pcolumnid);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdeletecolumn-function))], [])
@DllImport("ESENT.dll")
int JetDeleteColumnA(JET_SESID sesid, JET_TABLEID tableid, byte* szColumnName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdeletecolumn-function))], [])
@DllImport("ESENT.dll")
int JetDeleteColumnW(JET_SESID sesid, JET_TABLEID tableid, ushort* szColumnName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdeletecolumn2-function))], [])
@DllImport("ESENT.dll")
int JetDeleteColumn2A(JET_SESID sesid, JET_TABLEID tableid, byte* szColumnName, const(uint) grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdeletecolumn2-function))], [])
@DllImport("ESENT.dll")
int JetDeleteColumn2W(JET_SESID sesid, JET_TABLEID tableid, ushort* szColumnName, const(uint) grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetRenameColumnA(JET_SESID sesid, JET_TABLEID tableid, byte* szName, byte* szNameNew, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetRenameColumnW(JET_SESID sesid, JET_TABLEID tableid, ushort* szName, ushort* szNameNew, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetSetColumnDefaultValueA(JET_SESID sesid, uint dbid, byte* szTableName, byte* szColumnName, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvData, 
                              const(uint) cbData, const(uint) grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetSetColumnDefaultValueW(JET_SESID sesid, uint dbid, ushort* szTableName, ushort* szColumnName, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvData, 
                              const(uint) cbData, const(uint) grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgettableindexinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetTableIndexInfoA(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvResult, 
                          uint cbResult, uint InfoLevel);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgettableindexinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetTableIndexInfoW(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvResult, 
                          uint cbResult, uint InfoLevel);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetindexinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetIndexInfoA(JET_SESID sesid, uint dbid, byte* szTableName, byte* szIndexName, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvResult, 
                     uint cbResult, uint InfoLevel);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetindexinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetIndexInfoW(JET_SESID sesid, uint dbid, ushort* szTableName, ushort* szIndexName, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvResult, 
                     uint cbResult, uint InfoLevel);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateindex-function))], [])
@DllImport("ESENT.dll")
int JetCreateIndexA(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, uint grbit, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/byte* szKey, 
                    uint cbKey, uint lDensity);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateindex-function))], [])
@DllImport("ESENT.dll")
int JetCreateIndexW(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, uint grbit, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ushort* szKey, 
                    uint cbKey, uint lDensity);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateindex2-function))], [])
@DllImport("ESENT.dll")
int JetCreateIndex2A(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE_A* pindexcreate, uint cIndexCreate);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateindex2-function))], [])
@DllImport("ESENT.dll")
int JetCreateIndex2W(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE_W* pindexcreate, uint cIndexCreate);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateindex3-function))], [])
@DllImport("ESENT.dll")
int JetCreateIndex3A(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE2_A* pindexcreate, uint cIndexCreate);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateindex3-function))], [])
@DllImport("ESENT.dll")
int JetCreateIndex3W(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE2_W* pindexcreate, uint cIndexCreate);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetCreateIndex4A(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE3_A* pindexcreate, uint cIndexCreate);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcreateindex4w-function))], [])
@DllImport("ESENT.dll")
int JetCreateIndex4W(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE3_W* pindexcreate, uint cIndexCreate);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdeleteindex-function))], [])
@DllImport("ESENT.dll")
int JetDeleteIndexA(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdeleteindex-function))], [])
@DllImport("ESENT.dll")
int JetDeleteIndexW(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbegintransaction-function))], [])
@DllImport("ESENT.dll")
int JetBeginTransaction(JET_SESID sesid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbegintransaction2-function))], [])
@DllImport("ESENT.dll")
int JetBeginTransaction2(JET_SESID sesid, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbegintransaction3-function))], [])
@DllImport("ESENT.dll")
int JetBeginTransaction3(JET_SESID sesid, long trxid, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcommittransaction-function))], [])
@DllImport("ESENT.dll")
int JetCommitTransaction(JET_SESID sesid, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcommittransaction2-function))], [])
@DllImport("ESENT.dll")
int JetCommitTransaction2(JET_SESID sesid, uint grbit, uint cmsecDurableCommit, JET_COMMIT_ID* pCommitId);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrollback-function))], [])
@DllImport("ESENT.dll")
int JetRollback(JET_SESID sesid, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetGetDatabaseInfoA(JET_SESID sesid, uint dbid, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                        uint cbMax, uint InfoLevel);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetGetDatabaseInfoW(JET_SESID sesid, uint dbid, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                        uint cbMax, uint InfoLevel);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetdatabasefileinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetDatabaseFileInfoA(byte* szDatabaseName, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvResult, 
                            uint cbMax, uint InfoLevel);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetdatabasefileinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetDatabaseFileInfoW(ushort* szDatabaseName, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvResult, 
                            uint cbMax, uint InfoLevel);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopendatabase-function))], [])
@DllImport("ESENT.dll")
int JetOpenDatabaseA(JET_SESID sesid, byte* szFilename, byte* szConnect, uint* pdbid, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopendatabase-function))], [])
@DllImport("ESENT.dll")
int JetOpenDatabaseW(JET_SESID sesid, ushort* szFilename, ushort* szConnect, uint* pdbid, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetclosedatabase-function))], [])
@DllImport("ESENT.dll")
int JetCloseDatabase(JET_SESID sesid, uint dbid, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentable-function))], [])
@DllImport("ESENT.dll")
int JetOpenTableA(JET_SESID sesid, uint dbid, byte* szTableName, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvParameters, 
                  uint cbParameters, uint grbit, JET_TABLEID* ptableid);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentable-function))], [])
@DllImport("ESENT.dll")
int JetOpenTableW(JET_SESID sesid, uint dbid, ushort* szTableName, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvParameters, 
                  uint cbParameters, uint grbit, JET_TABLEID* ptableid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsettablesequential-function))], [])
@DllImport("ESENT.dll")
int JetSetTableSequential(JET_SESID sesid, JET_TABLEID tableid, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetresettablesequential-function))], [])
@DllImport("ESENT.dll")
int JetResetTableSequential(JET_SESID sesid, JET_TABLEID tableid, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetclosetable-function))], [])
@DllImport("ESENT.dll")
int JetCloseTable(JET_SESID sesid, JET_TABLEID tableid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdelete-function))], [])
@DllImport("ESENT.dll")
int JetDelete(JET_SESID sesid, JET_TABLEID tableid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetupdate-function))], [])
@DllImport("ESENT.dll")
int JetUpdate(JET_SESID sesid, JET_TABLEID tableid, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvBookmark, 
              uint cbBookmark, uint* pcbActual);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetupdate2-function))], [])
@DllImport("ESENT.dll")
int JetUpdate2(JET_SESID sesid, JET_TABLEID tableid, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvBookmark, 
               uint cbBookmark, uint* pcbActual, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetescrowupdate-function))], [])
@DllImport("ESENT.dll")
int JetEscrowUpdate(JET_SESID sesid, JET_TABLEID tableid, uint columnid, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pv, 
                    uint cbMax, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvOld, 
                    uint cbOldMax, uint* pcbOldActual, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetretrievecolumn-function))], [])
@DllImport("ESENT.dll")
int JetRetrieveColumn(JET_SESID sesid, JET_TABLEID tableid, uint columnid, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvData, 
                      uint cbData, uint* pcbActual, uint grbit, JET_RETINFO* pretinfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetretrievecolumns-function))], [])
@DllImport("ESENT.dll")
int JetRetrieveColumns(JET_SESID sesid, JET_TABLEID tableid, JET_RETRIEVECOLUMN* pretrievecolumn, 
                       uint cretrievecolumn);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetenumeratecolumns-function))], [])
@DllImport("ESENT.dll")
int JetEnumerateColumns(JET_SESID sesid, JET_TABLEID tableid, uint cEnumColumnId, JET_ENUMCOLUMNID* rgEnumColumnId, 
                        uint* pcEnumColumn, JET_ENUMCOLUMN** prgEnumColumn, JET_PFNREALLOC pfnRealloc, 
                        void* pvReallocContext, uint cbDataMost, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetrecordsize-function))], [])
@DllImport("ESENT.dll")
int JetGetRecordSize(JET_SESID sesid, JET_TABLEID tableid, JET_RECSIZE* precsize, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetrecordsize2-function))], [])
@DllImport("ESENT.dll")
int JetGetRecordSize2(JET_SESID sesid, JET_TABLEID tableid, JET_RECSIZE2* precsize, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcolumn-function))], [])
@DllImport("ESENT.dll")
int JetSetColumn(JET_SESID sesid, JET_TABLEID tableid, uint columnid, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvData, 
                 uint cbData, uint grbit, JET_SETINFO* psetinfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcolumns-function))], [])
@DllImport("ESENT.dll")
int JetSetColumns(JET_SESID sesid, JET_TABLEID tableid, JET_SETCOLUMN* psetcolumn, uint csetcolumn);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetprepareupdate-function))], [])
@DllImport("ESENT.dll")
int JetPrepareUpdate(JET_SESID sesid, JET_TABLEID tableid, uint prep);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetrecordposition-function))], [])
@DllImport("ESENT.dll")
int JetGetRecordPosition(JET_SESID sesid, JET_TABLEID tableid, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/JET_RECPOS* precpos, 
                         uint cbRecpos);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgotoposition-function))], [])
@DllImport("ESENT.dll")
int JetGotoPosition(JET_SESID sesid, JET_TABLEID tableid, JET_RECPOS* precpos);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetcursorinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetCursorInfo(JET_SESID sesid, JET_TABLEID tableid, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                     uint cbMax, uint InfoLevel);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdupcursor-function))], [])
@DllImport("ESENT.dll")
int JetDupCursor(JET_SESID sesid, JET_TABLEID tableid, JET_TABLEID* ptableid, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetcurrentindex-function))], [])
@DllImport("ESENT.dll")
int JetGetCurrentIndexA(JET_SESID sesid, JET_TABLEID tableid, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/byte* szIndexName, 
                        uint cbIndexName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetcurrentindex-function))], [])
@DllImport("ESENT.dll")
int JetGetCurrentIndexW(JET_SESID sesid, JET_TABLEID tableid, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ushort* szIndexName, 
                        uint cbIndexName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcurrentindex-function))], [])
@DllImport("ESENT.dll")
int JetSetCurrentIndexA(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcurrentindex-function))], [])
@DllImport("ESENT.dll")
int JetSetCurrentIndexW(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcurrentindex2-function))], [])
@DllImport("ESENT.dll")
int JetSetCurrentIndex2A(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcurrentindex2-function))], [])
@DllImport("ESENT.dll")
int JetSetCurrentIndex2W(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcurrentindex3-function))], [])
@DllImport("ESENT.dll")
int JetSetCurrentIndex3A(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, uint grbit, uint itagSequence);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcurrentindex3-function))], [])
@DllImport("ESENT.dll")
int JetSetCurrentIndex3W(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, uint grbit, uint itagSequence);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcurrentindex4-function))], [])
@DllImport("ESENT.dll")
int JetSetCurrentIndex4A(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, JET_INDEXID* pindexid, 
                         uint grbit, uint itagSequence);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcurrentindex4-function))], [])
@DllImport("ESENT.dll")
int JetSetCurrentIndex4W(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, JET_INDEXID* pindexid, 
                         uint grbit, uint itagSequence);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetmove-function))], [])
@DllImport("ESENT.dll")
int JetMove(JET_SESID sesid, JET_TABLEID tableid, int cRow, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcursorfilter-function))], [])
@DllImport("ESENT.dll")
int JetSetCursorFilter(JET_SESID sesid, JET_TABLEID tableid, JET_INDEX_COLUMN* rgColumnFilters, 
                       uint cColumnFilters, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetlock-function))], [])
@DllImport("ESENT.dll")
int JetGetLock(JET_SESID sesid, JET_TABLEID tableid, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetmakekey-function))], [])
@DllImport("ESENT.dll")
int JetMakeKey(JET_SESID sesid, JET_TABLEID tableid, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvData, 
               uint cbData, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetseek-function))], [])
@DllImport("ESENT.dll")
int JetSeek(JET_SESID sesid, JET_TABLEID tableid, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetprereadkeys-function))], [])
@DllImport("ESENT.dll")
int JetPrereadKeys(JET_SESID sesid, JET_TABLEID tableid, void** rgpvKeys, const(uint)* rgcbKeys, int ckeys, 
                   int* pckeysPreread, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetprereadindexranges-function))], [])
@DllImport("ESENT.dll")
int JetPrereadIndexRanges(JET_SESID sesid, JET_TABLEID tableid, const(JET_INDEX_RANGE)* rgIndexRanges, 
                          const(uint) cIndexRanges, uint* pcRangesPreread, const(uint)* rgcolumnidPreread, 
                          const(uint) ccolumnidPreread, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetbookmark-function))], [])
@DllImport("ESENT.dll")
int JetGetBookmark(JET_SESID sesid, JET_TABLEID tableid, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvBookmark, 
                   uint cbMax, uint* pcbActual);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetsecondaryindexbookmark-function))], [])
@DllImport("ESENT.dll")
int JetGetSecondaryIndexBookmark(JET_SESID sesid, JET_TABLEID tableid, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvSecondaryKey, 
                                 uint cbSecondaryKeyMax, uint* pcbSecondaryKeyActual, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvPrimaryBookmark, 
                                 uint cbPrimaryBookmarkMax, uint* pcbPrimaryBookmarkActual, const(uint) grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcompact-function))], [])
@DllImport("ESENT.dll")
int JetCompactA(JET_SESID sesid, byte* szDatabaseSrc, byte* szDatabaseDest, JET_PFNSTATUS pfnStatus, 
                JET_CONVERT_A* pconvert, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcompact-function))], [])
@DllImport("ESENT.dll")
int JetCompactW(JET_SESID sesid, ushort* szDatabaseSrc, ushort* szDatabaseDest, JET_PFNSTATUS pfnStatus, 
                JET_CONVERT_W* pconvert, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdefragment-function))], [])
@DllImport("ESENT.dll")
int JetDefragmentA(JET_SESID sesid, uint dbid, byte* szTableName, uint* pcPasses, uint* pcSeconds, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdefragment-function))], [])
@DllImport("ESENT.dll")
int JetDefragmentW(JET_SESID sesid, uint dbid, ushort* szTableName, uint* pcPasses, uint* pcSeconds, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdefragment2-function))], [])
@DllImport("ESENT.dll")
int JetDefragment2A(JET_SESID sesid, uint dbid, byte* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdefragment2-function))], [])
@DllImport("ESENT.dll")
int JetDefragment2W(JET_SESID sesid, uint dbid, ushort* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetDefragment3A(JET_SESID sesid, byte* szDatabaseName, byte* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, void* pvContext, uint grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
@DllImport("ESENT.dll")
int JetDefragment3W(JET_SESID sesid, ushort* szDatabaseName, ushort* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, void* pvContext, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetdatabasesize-function))], [])
@DllImport("ESENT.dll")
int JetSetDatabaseSizeA(JET_SESID sesid, byte* szDatabaseName, uint cpg, uint* pcpgReal);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetdatabasesize-function))], [])
@DllImport("ESENT.dll")
int JetSetDatabaseSizeW(JET_SESID sesid, ushort* szDatabaseName, uint cpg, uint* pcpgReal);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgrowdatabase-function))], [])
@DllImport("ESENT.dll")
int JetGrowDatabase(JET_SESID sesid, uint dbid, uint cpg, uint* pcpgReal);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetresizedatabase-function))], [])
@DllImport("ESENT.dll")
int JetResizeDatabase(JET_SESID sesid, uint dbid, uint cpgTarget, uint* pcpgActual, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetsessioncontext-function))], [])
@DllImport("ESENT.dll")
int JetSetSessionContext(JET_SESID sesid, JET_API_PTR ulContext);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetresetsessioncontext-function))], [])
@DllImport("ESENT.dll")
int JetResetSessionContext(JET_SESID sesid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgotobookmark-function))], [])
@DllImport("ESENT.dll")
int JetGotoBookmark(JET_SESID sesid, JET_TABLEID tableid, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvBookmark, 
                    uint cbBookmark);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgotosecondaryindexbookmark-function))], [])
@DllImport("ESENT.dll")
int JetGotoSecondaryIndexBookmark(JET_SESID sesid, JET_TABLEID tableid, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvSecondaryKey, 
                                  uint cbSecondaryKey, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvPrimaryBookmark, 
                                  uint cbPrimaryBookmark, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetintersectindexes-function))], [])
@DllImport("ESENT.dll")
int JetIntersectIndexes(JET_SESID sesid, JET_INDEXRANGE* rgindexrange, uint cindexrange, 
                        JET_RECORDLIST* precordlist, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcomputestats-function))], [])
@DllImport("ESENT.dll")
int JetComputeStats(JET_SESID sesid, JET_TABLEID tableid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemptable-function))], [])
@DllImport("ESENT.dll")
int JetOpenTempTable(JET_SESID sesid, const(JET_COLUMNDEF)* prgcolumndef, uint ccolumn, uint grbit, 
                     JET_TABLEID* ptableid, uint* prgcolumnid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemptable2-function))], [])
@DllImport("ESENT.dll")
int JetOpenTempTable2(JET_SESID sesid, const(JET_COLUMNDEF)* prgcolumndef, uint ccolumn, uint lcid, uint grbit, 
                      JET_TABLEID* ptableid, uint* prgcolumnid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemptable3-function))], [])
@DllImport("ESENT.dll")
int JetOpenTempTable3(JET_SESID sesid, const(JET_COLUMNDEF)* prgcolumndef, uint ccolumn, 
                      JET_UNICODEINDEX* pidxunicode, uint grbit, JET_TABLEID* ptableid, uint* prgcolumnid);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemporarytable-function))], [])
@DllImport("ESENT.dll")
int JetOpenTemporaryTable(JET_SESID sesid, JET_OPENTEMPORARYTABLE* popentemporarytable);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemporarytable2-function))], [])
@DllImport("ESENT.dll")
int JetOpenTemporaryTable2(JET_SESID sesid, JET_OPENTEMPORARYTABLE2* popentemporarytable);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbackup-function))], [])
@DllImport("ESENT.dll")
int JetBackupA(byte* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbackup-function))], [])
@DllImport("ESENT.dll")
int JetBackupW(ushort* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbackupinstance-function))], [])
@DllImport("ESENT.dll")
int JetBackupInstanceA(JET_INSTANCE instance, byte* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbackupinstance-function))], [])
@DllImport("ESENT.dll")
int JetBackupInstanceW(JET_INSTANCE instance, ushort* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrestore-function))], [])
@DllImport("ESENT.dll")
int JetRestoreA(byte* szSource, JET_PFNSTATUS pfn);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrestore-function))], [])
@DllImport("ESENT.dll")
int JetRestoreW(ushort* szSource, JET_PFNSTATUS pfn);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrestore2-function))], [])
@DllImport("ESENT.dll")
int JetRestore2A(byte* sz, byte* szDest, JET_PFNSTATUS pfn);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrestore2-function))], [])
@DllImport("ESENT.dll")
int JetRestore2W(ushort* sz, ushort* szDest, JET_PFNSTATUS pfn);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrestoreinstance-function))], [])
@DllImport("ESENT.dll")
int JetRestoreInstanceA(JET_INSTANCE instance, byte* sz, byte* szDest, JET_PFNSTATUS pfn);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrestoreinstance-function))], [])
@DllImport("ESENT.dll")
int JetRestoreInstanceW(JET_INSTANCE instance, ushort* sz, ushort* szDest, JET_PFNSTATUS pfn);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetindexrange-function))], [])
@DllImport("ESENT.dll")
int JetSetIndexRange(JET_SESID sesid, JET_TABLEID tableidSrc, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetindexrecordcount-function))], [])
@DllImport("ESENT.dll")
int JetIndexRecordCount(JET_SESID sesid, JET_TABLEID tableid, uint* pcrec, uint crecMax);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetretrievekey-function))], [])
@DllImport("ESENT.dll")
int JetRetrieveKey(JET_SESID sesid, JET_TABLEID tableid, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvKey, 
                   uint cbMax, uint* pcbActual, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbeginexternalbackup-function))], [])
@DllImport("ESENT.dll")
int JetBeginExternalBackup(uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbeginexternalbackupinstance-function))], [])
@DllImport("ESENT.dll")
int JetBeginExternalBackupInstance(JET_INSTANCE instance, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetattachinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetAttachInfoA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/byte* szzDatabases, 
                      uint cbMax, uint* pcbActual);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetattachinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetAttachInfoW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ushort* wszzDatabases, 
                      uint cbMax, uint* pcbActual);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetattachinfoinstance-function))], [])
@DllImport("ESENT.dll")
int JetGetAttachInfoInstanceA(JET_INSTANCE instance, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/byte* szzDatabases, 
                              uint cbMax, uint* pcbActual);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetattachinfoinstance-function))], [])
@DllImport("ESENT.dll")
int JetGetAttachInfoInstanceW(JET_INSTANCE instance, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ushort* szzDatabases, 
                              uint cbMax, uint* pcbActual);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopenfile-function))], [])
@DllImport("ESENT.dll")
int JetOpenFileA(byte* szFileName, JET_HANDLE* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopenfile-function))], [])
@DllImport("ESENT.dll")
int JetOpenFileW(ushort* szFileName, JET_HANDLE* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopenfileinstance-function))], [])
@DllImport("ESENT.dll")
int JetOpenFileInstanceA(JET_INSTANCE instance, byte* szFileName, JET_HANDLE* phfFile, uint* pulFileSizeLow, 
                         uint* pulFileSizeHigh);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopenfileinstance-function))], [])
@DllImport("ESENT.dll")
int JetOpenFileInstanceW(JET_INSTANCE instance, ushort* szFileName, JET_HANDLE* phfFile, uint* pulFileSizeLow, 
                         uint* pulFileSizeHigh);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetreadfile-function))], [])
@DllImport("ESENT.dll")
int JetReadFile(JET_HANDLE hfFile, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                uint cb, uint* pcbActual);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetreadfileinstance-function))], [])
@DllImport("ESENT.dll")
int JetReadFileInstance(JET_INSTANCE instance, JET_HANDLE hfFile, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pv, 
                        uint cb, uint* pcbActual);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetclosefile-function))], [])
@DllImport("ESENT.dll")
int JetCloseFile(JET_HANDLE hfFile);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetclosefileinstance-function))], [])
@DllImport("ESENT.dll")
int JetCloseFileInstance(JET_INSTANCE instance, JET_HANDLE hfFile);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetloginfo-function))], [])
@DllImport("ESENT.dll")
int JetGetLogInfoA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/byte* szzLogs, 
                   uint cbMax, uint* pcbActual);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetloginfo-function))], [])
@DllImport("ESENT.dll")
int JetGetLogInfoW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ushort* szzLogs, 
                   uint cbMax, uint* pcbActual);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetloginfoinstance-function))], [])
@DllImport("ESENT.dll")
int JetGetLogInfoInstanceA(JET_INSTANCE instance, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/byte* szzLogs, 
                           uint cbMax, uint* pcbActual);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetloginfoinstance-function))], [])
@DllImport("ESENT.dll")
int JetGetLogInfoInstanceW(JET_INSTANCE instance, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ushort* wszzLogs, 
                           uint cbMax, uint* pcbActual);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetloginfoinstance2-function))], [])
@DllImport("ESENT.dll")
int JetGetLogInfoInstance2A(JET_INSTANCE instance, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/byte* szzLogs, 
                            uint cbMax, uint* pcbActual, JET_LOGINFO_A* pLogInfo);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetloginfoinstance2-function))], [])
@DllImport("ESENT.dll")
int JetGetLogInfoInstance2W(JET_INSTANCE instance, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ushort* wszzLogs, 
                            uint cbMax, uint* pcbActual, JET_LOGINFO_W* pLogInfo);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgettruncateloginfoinstance-function))], [])
@DllImport("ESENT.dll")
int JetGetTruncateLogInfoInstanceA(JET_INSTANCE instance, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/byte* szzLogs, 
                                   uint cbMax, uint* pcbActual);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgettruncateloginfoinstance-function))], [])
@DllImport("ESENT.dll")
int JetGetTruncateLogInfoInstanceW(JET_INSTANCE instance, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ushort* wszzLogs, 
                                   uint cbMax, uint* pcbActual);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jettruncatelog-function))], [])
@DllImport("ESENT.dll")
int JetTruncateLog();

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jettruncateloginstance-function))], [])
@DllImport("ESENT.dll")
int JetTruncateLogInstance(JET_INSTANCE instance);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetendexternalbackup-function))], [])
@DllImport("ESENT.dll")
int JetEndExternalBackup();

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetendexternalbackupinstance-function))], [])
@DllImport("ESENT.dll")
int JetEndExternalBackupInstance(JET_INSTANCE instance);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetendexternalbackupinstance2-function))], [])
@DllImport("ESENT.dll")
int JetEndExternalBackupInstance2(JET_INSTANCE instance, uint grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetexternalrestore-function))], [])
@DllImport("ESENT.dll")
int JetExternalRestoreA(byte* szCheckpointFilePath, byte* szLogPath, JET_RSTMAP_A* rgrstmap, int crstfilemap, 
                        byte* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetexternalrestore-function))], [])
@DllImport("ESENT.dll")
int JetExternalRestoreW(ushort* szCheckpointFilePath, ushort* szLogPath, JET_RSTMAP_W* rgrstmap, int crstfilemap, 
                        ushort* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetexternalrestore2-function))], [])
@DllImport("ESENT.dll")
int JetExternalRestore2A(byte* szCheckpointFilePath, byte* szLogPath, JET_RSTMAP_A* rgrstmap, int crstfilemap, 
                         byte* szBackupLogPath, JET_LOGINFO_A* pLogInfo, byte* szTargetInstanceName, 
                         byte* szTargetInstanceLogPath, byte* szTargetInstanceCheckpointPath, JET_PFNSTATUS pfn);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetexternalrestore2-function))], [])
@DllImport("ESENT.dll")
int JetExternalRestore2W(ushort* szCheckpointFilePath, ushort* szLogPath, JET_RSTMAP_W* rgrstmap, int crstfilemap, 
                         ushort* szBackupLogPath, JET_LOGINFO_W* pLogInfo, ushort* szTargetInstanceName, 
                         ushort* szTargetInstanceLogPath, ushort* szTargetInstanceCheckpointPath, JET_PFNSTATUS pfn);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetregistercallback-function))], [])
@DllImport("ESENT.dll")
int JetRegisterCallback(JET_SESID sesid, JET_TABLEID tableid, uint cbtyp, JET_CALLBACK pCallback, void* pvContext, 
                        JET_HANDLE* phCallbackId);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetunregistercallback-function))], [])
@DllImport("ESENT.dll")
int JetUnregisterCallback(JET_SESID sesid, JET_TABLEID tableid, uint cbtyp, JET_HANDLE hCallbackId);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetinstanceinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetInstanceInfoA(uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetinstanceinfo-function))], [])
@DllImport("ESENT.dll")
int JetGetInstanceInfoW(uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetfreebuffer-function))], [])
@DllImport("ESENT.dll")
int JetFreeBuffer(byte* pbBuf);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetls-function))], [])
@DllImport("ESENT.dll")
int JetSetLS(JET_SESID sesid, JET_TABLEID tableid, JET_LS ls, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetls-function))], [])
@DllImport("ESENT.dll")
int JetGetLS(JET_SESID sesid, JET_TABLEID tableid, JET_LS* pls, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotprepare-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotPrepare(JET_OSSNAPID* psnapId, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotprepareinstance-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotPrepareInstance(JET_OSSNAPID snapId, JET_INSTANCE instance, const(uint) grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotfreeze-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotFreezeA(const(JET_OSSNAPID) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo, 
                         const(uint) grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotfreeze-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotFreezeW(const(JET_OSSNAPID) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo, 
                         const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotthaw-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotThaw(const(JET_OSSNAPID) snapId, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotabort-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotAbort(const(JET_OSSNAPID) snapId, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshottruncatelog-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotTruncateLog(const(JET_OSSNAPID) snapId, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshottruncateloginstance-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotTruncateLogInstance(const(JET_OSSNAPID) snapId, JET_INSTANCE instance, const(uint) grbit);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotgetfreezeinfo-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotGetFreezeInfoA(const(JET_OSSNAPID) snapId, uint* pcInstanceInfo, 
                                JET_INSTANCE_INFO_A** paInstanceInfo, const(uint) grbit);

//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotgetfreezeinfo-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotGetFreezeInfoW(const(JET_OSSNAPID) snapId, uint* pcInstanceInfo, 
                                JET_INSTANCE_INFO_W** paInstanceInfo, const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotend-function))], [])
@DllImport("ESENT.dll")
int JetOSSnapshotEnd(const(JET_OSSNAPID) snapId, const(uint) grbit);

@DllImport("ESENT.dll")
int JetConfigureProcessForCrashDump(const(uint) grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgeterrorinfow-function))], [])
@DllImport("ESENT.dll")
int JetGetErrorInfoW(void* pvContext, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvResult, 
                     uint cbMax, uint InfoLevel, uint grbit);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetsessionparameter-function))], [])
@DllImport("ESENT.dll")
int JetSetSessionParameter(JET_SESID sesid, uint sesparamid, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvParam, 
                           uint cbParam);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetsessionparameter-function))], [])
@DllImport("ESENT.dll")
int JetGetSessionParameter(JET_SESID sesid, uint sesparamid, void* pvParam, uint cbParamMax, uint* pcbParamActual);


