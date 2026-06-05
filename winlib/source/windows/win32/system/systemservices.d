// Written in the D programming language.

module windows.win32.system.systemservices;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, CHAR, HANDLE, LUID, PSTR, PWSTR;
public import windows.win32.graphics.gdi : LOGPALETTE;
public import windows.win32.security : PSID, SECURITY_IMPERSONATION_LEVEL, SID, SID_AND_ATTRIBUTES, TOKEN_ELEVATION,
                                       TOKEN_ELEVATION_TYPE, TOKEN_TYPE, TOKEN_USER;
public import windows.win32.system.com : BYTE_BLOB, DWORD_BLOB, FLAGGED_BYTE_BLOB;
public import windows.win32.system.diagnostics.debug_ : EXCEPTION_POINTERS, IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY,
                                                        IMAGE_RUNTIME_FUNCTION_ENTRY;
public import windows.win32.system.power : SYSTEM_BATTERY_STATE;

extern(Windows) @nogc nothrow:


// Enums


alias ALERT_SYSTEM_SEV = uint;
enum : uint
{
    ALERT_SYSTEM_INFORMATIONAL = 0x00000001,
    ALERT_SYSTEM_WARNING       = 0x00000002,
    ALERT_SYSTEM_ERROR         = 0x00000003,
    ALERT_SYSTEM_QUERY         = 0x00000004,
    ALERT_SYSTEM_CRITICAL      = 0x00000005,
}

alias APPCOMMAND_ID = uint;
enum : uint
{
    APPCOMMAND_BROWSER_BACKWARD                  = 0x00000001,
    APPCOMMAND_BROWSER_FORWARD                   = 0x00000002,
    APPCOMMAND_BROWSER_REFRESH                   = 0x00000003,
    APPCOMMAND_BROWSER_STOP                      = 0x00000004,
    APPCOMMAND_BROWSER_SEARCH                    = 0x00000005,
    APPCOMMAND_BROWSER_FAVORITES                 = 0x00000006,
    APPCOMMAND_BROWSER_HOME                      = 0x00000007,
    APPCOMMAND_VOLUME_MUTE                       = 0x00000008,
    APPCOMMAND_VOLUME_DOWN                       = 0x00000009,
    APPCOMMAND_VOLUME_UP                         = 0x0000000a,
    APPCOMMAND_MEDIA_NEXTTRACK                   = 0x0000000b,
    APPCOMMAND_MEDIA_PREVIOUSTRACK               = 0x0000000c,
    APPCOMMAND_MEDIA_STOP                        = 0x0000000d,
    APPCOMMAND_MEDIA_PLAY_PAUSE                  = 0x0000000e,
    APPCOMMAND_LAUNCH_MAIL                       = 0x0000000f,
    APPCOMMAND_LAUNCH_MEDIA_SELECT               = 0x00000010,
    APPCOMMAND_LAUNCH_APP1                       = 0x00000011,
    APPCOMMAND_LAUNCH_APP2                       = 0x00000012,
    APPCOMMAND_BASS_DOWN                         = 0x00000013,
    APPCOMMAND_BASS_BOOST                        = 0x00000014,
    APPCOMMAND_BASS_UP                           = 0x00000015,
    APPCOMMAND_TREBLE_DOWN                       = 0x00000016,
    APPCOMMAND_TREBLE_UP                         = 0x00000017,
    APPCOMMAND_MICROPHONE_VOLUME_MUTE            = 0x00000018,
    APPCOMMAND_MICROPHONE_VOLUME_DOWN            = 0x00000019,
    APPCOMMAND_MICROPHONE_VOLUME_UP              = 0x0000001a,
    APPCOMMAND_HELP                              = 0x0000001b,
    APPCOMMAND_FIND                              = 0x0000001c,
    APPCOMMAND_NEW                               = 0x0000001d,
    APPCOMMAND_OPEN                              = 0x0000001e,
    APPCOMMAND_CLOSE                             = 0x0000001f,
    APPCOMMAND_SAVE                              = 0x00000020,
    APPCOMMAND_PRINT                             = 0x00000021,
    APPCOMMAND_UNDO                              = 0x00000022,
    APPCOMMAND_REDO                              = 0x00000023,
    APPCOMMAND_COPY                              = 0x00000024,
    APPCOMMAND_CUT                               = 0x00000025,
    APPCOMMAND_PASTE                             = 0x00000026,
    APPCOMMAND_REPLY_TO_MAIL                     = 0x00000027,
    APPCOMMAND_FORWARD_MAIL                      = 0x00000028,
    APPCOMMAND_SEND_MAIL                         = 0x00000029,
    APPCOMMAND_SPELL_CHECK                       = 0x0000002a,
    APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE = 0x0000002b,
    APPCOMMAND_MIC_ON_OFF_TOGGLE                 = 0x0000002c,
    APPCOMMAND_CORRECTION_LIST                   = 0x0000002d,
    APPCOMMAND_MEDIA_PLAY                        = 0x0000002e,
    APPCOMMAND_MEDIA_PAUSE                       = 0x0000002f,
    APPCOMMAND_MEDIA_RECORD                      = 0x00000030,
    APPCOMMAND_MEDIA_FAST_FORWARD                = 0x00000031,
    APPCOMMAND_MEDIA_REWIND                      = 0x00000032,
    APPCOMMAND_MEDIA_CHANNEL_UP                  = 0x00000033,
    APPCOMMAND_MEDIA_CHANNEL_DOWN                = 0x00000034,
    APPCOMMAND_DELETE                            = 0x00000035,
    APPCOMMAND_DWM_FLIP3D                        = 0x00000036,
}

alias ATF_FLAGS = uint;
enum : uint
{
    ATF_TIMEOUTON     = 0x00000001,
    ATF_ONOFFFEEDBACK = 0x00000002,
}

alias GESTURECONFIG_FLAGS = uint;
enum : uint
{
    GC_ALLGESTURES                         = 0x00000001,
    GC_ZOOM                                = 0x00000001,
    GC_PAN                                 = 0x00000001,
    GC_PAN_WITH_SINGLE_FINGER_VERTICALLY   = 0x00000002,
    GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY = 0x00000004,
    GC_PAN_WITH_GUTTER                     = 0x00000008,
    GC_PAN_WITH_INERTIA                    = 0x00000010,
    GC_ROTATE                              = 0x00000001,
    GC_TWOFINGERTAP                        = 0x00000001,
    GC_PRESSANDTAP                         = 0x00000001,
    GC_ROLLOVER                            = 0x00000001,
}

alias CFE_UNDERLINE = uint;
enum : uint
{
    CFU_CF1UNDERLINE             = 0x000000ff,
    CFU_INVERT                   = 0x000000fe,
    CFU_UNDERLINETHICKLONGDASH   = 0x00000012,
    CFU_UNDERLINETHICKDOTTED     = 0x00000011,
    CFU_UNDERLINETHICKDASHDOTDOT = 0x00000010,
    CFU_UNDERLINETHICKDASHDOT    = 0x0000000f,
    CFU_UNDERLINETHICKDASH       = 0x0000000e,
    CFU_UNDERLINELONGDASH        = 0x0000000d,
    CFU_UNDERLINEHEAVYWAVE       = 0x0000000c,
    CFU_UNDERLINEDOUBLEWAVE      = 0x0000000b,
    CFU_UNDERLINEHAIRLINE        = 0x0000000a,
    CFU_UNDERLINETHICK           = 0x00000009,
    CFU_UNDERLINEWAVE            = 0x00000008,
    CFU_UNDERLINEDASHDOTDOT      = 0x00000007,
    CFU_UNDERLINEDASHDOT         = 0x00000006,
    CFU_UNDERLINEDASH            = 0x00000005,
    CFU_UNDERLINEDOTTED          = 0x00000004,
    CFU_UNDERLINEDOUBLE          = 0x00000003,
    CFU_UNDERLINEWORD            = 0x00000002,
    CFU_UNDERLINE                = 0x00000001,
    CFU_UNDERLINENONE            = 0x00000000,
}

alias IGP_ID = uint;
enum : uint
{
    IGP_GETIMEVERSION = 0xfffffffc,
    IGP_PROPERTY      = 0x00000004,
    IGP_CONVERSION    = 0x00000008,
    IGP_SENTENCE      = 0x0000000c,
    IGP_UI            = 0x00000010,
    IGP_SETCOMPSTR    = 0x00000014,
    IGP_SELECT        = 0x00000018,
}

alias WORD_WHEEL_OPEN_FLAGS = uint;
enum : uint
{
    ITWW_OPEN_CONNECT = 0x00000000,
}

alias TAPE_GET_DRIVE_PARAMETERS_FEATURES_HIGH = uint;
enum : uint
{
    TAPE_DRIVE_ABS_BLK_IMMED    = 0x80002000,
    TAPE_DRIVE_ABSOLUTE_BLK     = 0x80001000,
    TAPE_DRIVE_END_OF_DATA      = 0x80010000,
    TAPE_DRIVE_FILEMARKS        = 0x80040000,
    TAPE_DRIVE_LOAD_UNLOAD      = 0x80000001,
    TAPE_DRIVE_LOAD_UNLD_IMMED  = 0x80000020,
    TAPE_DRIVE_LOCK_UNLOCK      = 0x80000004,
    TAPE_DRIVE_LOCK_UNLK_IMMED  = 0x80000080,
    TAPE_DRIVE_LOG_BLK_IMMED    = 0x80008000,
    TAPE_DRIVE_LOGICAL_BLK      = 0x80004000,
    TAPE_DRIVE_RELATIVE_BLKS    = 0x80020000,
    TAPE_DRIVE_REVERSE_POSITION = 0x80400000,
    TAPE_DRIVE_REWIND_IMMEDIATE = 0x80000008,
    TAPE_DRIVE_SEQUENTIAL_FMKS  = 0x80080000,
    TAPE_DRIVE_SEQUENTIAL_SMKS  = 0x80200000,
    TAPE_DRIVE_SET_BLOCK_SIZE   = 0x80000010,
    TAPE_DRIVE_SET_COMPRESSION  = 0x80000200,
    TAPE_DRIVE_SET_ECC          = 0x80000100,
    TAPE_DRIVE_SET_PADDING      = 0x80000400,
    TAPE_DRIVE_SET_REPORT_SMKS  = 0x80000800,
    TAPE_DRIVE_SETMARKS         = 0x80100000,
    TAPE_DRIVE_SPACE_IMMEDIATE  = 0x80800000,
    TAPE_DRIVE_TENSION          = 0x80000002,
    TAPE_DRIVE_TENSION_IMMED    = 0x80000040,
    TAPE_DRIVE_WRITE_FILEMARKS  = 0x82000000,
    TAPE_DRIVE_WRITE_LONG_FMKS  = 0x88000000,
    TAPE_DRIVE_WRITE_MARK_IMMED = 0x90000000,
    TAPE_DRIVE_WRITE_SETMARKS   = 0x81000000,
    TAPE_DRIVE_WRITE_SHORT_FMKS = 0x84000000,
}

alias MODIFIERKEYS_FLAGS = uint;
enum : uint
{
    MK_LBUTTON  = 0x00000001,
    MK_RBUTTON  = 0x00000002,
    MK_SHIFT    = 0x00000004,
    MK_CONTROL  = 0x00000008,
    MK_MBUTTON  = 0x00000010,
    MK_XBUTTON1 = 0x00000020,
    MK_XBUTTON2 = 0x00000040,
}

alias STATIC_STYLES = uint;
enum : uint
{
    SS_LEFT            = 0x00000000,
    SS_CENTER          = 0x00000001,
    SS_RIGHT           = 0x00000002,
    SS_ICON            = 0x00000003,
    SS_BLACKRECT       = 0x00000004,
    SS_GRAYRECT        = 0x00000005,
    SS_WHITERECT       = 0x00000006,
    SS_BLACKFRAME      = 0x00000007,
    SS_GRAYFRAME       = 0x00000008,
    SS_WHITEFRAME      = 0x00000009,
    SS_USERITEM        = 0x0000000a,
    SS_SIMPLE          = 0x0000000b,
    SS_LEFTNOWORDWRAP  = 0x0000000c,
    SS_OWNERDRAW       = 0x0000000d,
    SS_BITMAP          = 0x0000000e,
    SS_ENHMETAFILE     = 0x0000000f,
    SS_ETCHEDHORZ      = 0x00000010,
    SS_ETCHEDVERT      = 0x00000011,
    SS_ETCHEDFRAME     = 0x00000012,
    SS_TYPEMASK        = 0x0000001f,
    SS_REALSIZECONTROL = 0x00000040,
    SS_NOPREFIX        = 0x00000080,
    SS_NOTIFY          = 0x00000100,
    SS_CENTERIMAGE     = 0x00000200,
    SS_RIGHTJUST       = 0x00000400,
    SS_REALSIZEIMAGE   = 0x00000800,
    SS_SUNKEN          = 0x00001000,
    SS_EDITCONTROL     = 0x00002000,
    SS_ENDELLIPSIS     = 0x00004000,
    SS_PATHELLIPSIS    = 0x00008000,
    SS_WORDELLIPSIS    = 0x0000c000,
    SS_ELLIPSISMASK    = 0x0000c000,
}

alias RECO_FLAGS = uint;
enum : uint
{
    RECO_PASTE = 0x00000000,
    RECO_DROP  = 0x00000001,
    RECO_COPY  = 0x00000002,
    RECO_CUT   = 0x00000003,
    RECO_DRAG  = 0x00000004,
}

alias SFGAO_FLAGS = uint;
enum : uint
{
    SFGAO_CANCOPY         = 0x00000001,
    SFGAO_CANMOVE         = 0x00000002,
    SFGAO_CANLINK         = 0x00000004,
    SFGAO_STORAGE         = 0x00000008,
    SFGAO_CANRENAME       = 0x00000010,
    SFGAO_CANDELETE       = 0x00000020,
    SFGAO_HASPROPSHEET    = 0x00000040,
    SFGAO_DROPTARGET      = 0x00000100,
    SFGAO_CAPABILITYMASK  = 0x00000177,
    SFGAO_PLACEHOLDER     = 0x00000800,
    SFGAO_SYSTEM          = 0x00001000,
    SFGAO_ENCRYPTED       = 0x00002000,
    SFGAO_ISSLOW          = 0x00004000,
    SFGAO_GHOSTED         = 0x00008000,
    SFGAO_LINK            = 0x00010000,
    SFGAO_SHARE           = 0x00020000,
    SFGAO_READONLY        = 0x00040000,
    SFGAO_HIDDEN          = 0x00080000,
    SFGAO_DISPLAYATTRMASK = 0x000fc000,
    SFGAO_FILESYSANCESTOR = 0x10000000,
    SFGAO_FOLDER          = 0x20000000,
    SFGAO_FILESYSTEM      = 0x40000000,
    SFGAO_HASSUBFOLDER    = 0x80000000,
    SFGAO_CONTENTSMASK    = 0x80000000,
    SFGAO_VALIDATE        = 0x01000000,
    SFGAO_REMOVABLE       = 0x02000000,
    SFGAO_COMPRESSED      = 0x04000000,
    SFGAO_BROWSABLE       = 0x08000000,
    SFGAO_NONENUMERATED   = 0x00100000,
    SFGAO_NEWCONTENT      = 0x00200000,
    SFGAO_CANMONIKER      = 0x00400000,
    SFGAO_HASSTORAGE      = 0x00400000,
    SFGAO_STREAM          = 0x00400000,
    SFGAO_STORAGEANCESTOR = 0x00800000,
    SFGAO_STORAGECAPMASK  = 0x70c50008,
    SFGAO_PKEYSFGAOMASK   = 0x81044000,
}

alias ACCESS_REASON_TYPE = int;
enum : int
{
    AccessReasonNone                     = 0x00000000,
    AccessReasonAllowedAce               = 0x00010000,
    AccessReasonDeniedAce                = 0x00020000,
    AccessReasonAllowedParentAce         = 0x00030000,
    AccessReasonDeniedParentAce          = 0x00040000,
    AccessReasonNotGrantedByCape         = 0x00050000,
    AccessReasonNotGrantedByParentCape   = 0x00060000,
    AccessReasonNotGrantedToAppContainer = 0x00070000,
    AccessReasonMissingPrivilege         = 0x00100000,
    AccessReasonFromPrivilege            = 0x00200000,
    AccessReasonIntegrityLevel           = 0x00300000,
    AccessReasonOwnership                = 0x00400000,
    AccessReasonNullDacl                 = 0x00500000,
    AccessReasonEmptyDacl                = 0x00600000,
    AccessReasonNoSD                     = 0x00700000,
    AccessReasonNoGrant                  = 0x00800000,
    AccessReasonTrustLabel               = 0x00900000,
    AccessReasonFilterAce                = 0x00a00000,
}

alias SE_IMAGE_SIGNATURE_TYPE = int;
enum : int
{
    SeImageSignatureNone             = 0x00000000,
    SeImageSignatureEmbedded         = 0x00000001,
    SeImageSignatureCache            = 0x00000002,
    SeImageSignatureCatalogCached    = 0x00000003,
    SeImageSignatureCatalogNotCached = 0x00000004,
    SeImageSignatureCatalogHint      = 0x00000005,
    SeImageSignaturePackageCatalog   = 0x00000006,
    SeImageSignaturePplMitigated     = 0x00000007,
}

alias SERVERSILO_STATE = int;
enum : int
{
    SERVERSILO_INITING       = 0x00000000,
    SERVERSILO_STARTED       = 0x00000001,
    SERVERSILO_SHUTTING_DOWN = 0x00000002,
    SERVERSILO_TERMINATING   = 0x00000003,
    SERVERSILO_TERMINATED    = 0x00000004,
}

alias RUNTIME_REPORT_TYPE = int;
enum : int
{
    RuntimeReportTypeDriver = 0x00000000,
    RuntimeReportTypeMax    = 0x00000001,
}

enum SharedVirtualDiskSupportType : int
{
    SharedVirtualDisksUnsupported          = 0x00000000,
    SharedVirtualDisksSupported            = 0x00000001,
    SharedVirtualDiskSnapshotsSupported    = 0x00000003,
    SharedVirtualDiskCDPSnapshotsSupported = 0x00000007,
}

enum SharedVirtualDiskHandleState : int
{
    SharedVirtualDiskHandleStateNone         = 0x00000000,
    SharedVirtualDiskHandleStateFileShared   = 0x00000001,
    SharedVirtualDiskHandleStateHandleShared = 0x00000003,
}

alias MONITOR_DISPLAY_STATE = int;
enum : int
{
    PowerMonitorOff = 0x00000000,
    PowerMonitorOn  = 0x00000001,
    PowerMonitorDim = 0x00000002,
}

alias ENERGY_SAVER_STATUS = int;
enum : int
{
    ENERGY_SAVER_OFF          = 0x00000000,
    ENERGY_SAVER_STANDARD     = 0x00000001,
    ENERGY_SAVER_HIGH_SAVINGS = 0x00000002,
}

alias POWER_LIMIT_TYPES = int;
enum : int
{
    PowerLimitContinuous       = 0x00000000,
    PowerLimitType1            = 0x00000000,
    PowerLimitBurst            = 0x00000001,
    PowerLimitType2            = 0x00000001,
    PowerLimitRapid            = 0x00000002,
    PowerLimitType3            = 0x00000002,
    PowerLimitPreemptive       = 0x00000003,
    PowerLimitType4            = 0x00000003,
    PowerLimitPreemptiveOffset = 0x00000004,
    PowerLimitTypeMax          = 0x00000005,
}

alias HIBERFILE_BUCKET_SIZE = int;
enum : int
{
    HiberFileBucket1GB       = 0x00000000,
    HiberFileBucket2GB       = 0x00000001,
    HiberFileBucket4GB       = 0x00000002,
    HiberFileBucket8GB       = 0x00000003,
    HiberFileBucket16GB      = 0x00000004,
    HiberFileBucket32GB      = 0x00000005,
    HiberFileBucketUnlimited = 0x00000006,
    HiberFileBucketMax       = 0x00000007,
}

alias IMAGE_AUX_SYMBOL_TYPE = int;
enum : int
{
    IMAGE_AUX_SYMBOL_TYPE_TOKEN_DEF = 0x00000001,
}

alias ARM64_FNPDATA_FLAGS = int;
enum : int
{
    PdataRefToFullXdata       = 0x00000000,
    PdataPackedUnwindFunction = 0x00000001,
    PdataPackedUnwindFragment = 0x00000002,
}

alias ARM64_FNPDATA_CR = int;
enum : int
{
    PdataCrUnchained        = 0x00000000,
    PdataCrUnchainedSavedLr = 0x00000001,
    PdataCrChainedWithPac   = 0x00000002,
    PdataCrChained          = 0x00000003,
}

alias IMPORT_OBJECT_TYPE = int;
enum : int
{
    IMPORT_OBJECT_CODE  = 0x00000000,
    IMPORT_OBJECT_DATA  = 0x00000001,
    IMPORT_OBJECT_CONST = 0x00000002,
}

alias IMPORT_OBJECT_NAME_TYPE = int;
enum : int
{
    IMPORT_OBJECT_ORDINAL         = 0x00000000,
    IMPORT_OBJECT_NAME            = 0x00000001,
    IMPORT_OBJECT_NAME_NO_PREFIX  = 0x00000002,
    IMPORT_OBJECT_NAME_UNDECORATE = 0x00000003,
    IMPORT_OBJECT_NAME_EXPORTAS   = 0x00000004,
}

enum ReplacesCorHdrNumericDefines : int
{
    COMIMAGE_FLAGS_ILONLY                      = 0x00000001,
    COMIMAGE_FLAGS_32BITREQUIRED               = 0x00000002,
    COMIMAGE_FLAGS_IL_LIBRARY                  = 0x00000004,
    COMIMAGE_FLAGS_STRONGNAMESIGNED            = 0x00000008,
    COMIMAGE_FLAGS_NATIVE_ENTRYPOINT           = 0x00000010,
    COMIMAGE_FLAGS_TRACKDEBUGDATA              = 0x00010000,
    COMIMAGE_FLAGS_32BITPREFERRED              = 0x00020000,
    COR_VERSION_MAJOR_V2                       = 0x00000002,
    COR_VERSION_MAJOR                          = 0x00000002,
    COR_VERSION_MINOR                          = 0x00000005,
    COR_DELETED_NAME_LENGTH                    = 0x00000008,
    COR_VTABLEGAP_NAME_LENGTH                  = 0x00000008,
    NATIVE_TYPE_MAX_CB                         = 0x00000001,
    COR_ILMETHOD_SECT_SMALL_MAX_DATASIZE       = 0x000000ff,
    IMAGE_COR_MIH_METHODRVA                    = 0x00000001,
    IMAGE_COR_MIH_EHRVA                        = 0x00000002,
    IMAGE_COR_MIH_BASICBLOCK                   = 0x00000008,
    COR_VTABLE_32BIT                           = 0x00000001,
    COR_VTABLE_64BIT                           = 0x00000002,
    COR_VTABLE_FROM_UNMANAGED                  = 0x00000004,
    COR_VTABLE_FROM_UNMANAGED_RETAIN_APPDOMAIN = 0x00000008,
    COR_VTABLE_CALL_MOST_DERIVED               = 0x00000010,
    IMAGE_COR_EATJ_THUNK_SIZE                  = 0x00000020,
    MAX_CLASS_NAME                             = 0x00000400,
    MAX_PACKAGE_NAME                           = 0x00000400,
}

alias RTL_UMS_SCHEDULER_REASON = int;
enum : int
{
    UmsSchedulerStartup       = 0x00000000,
    UmsSchedulerThreadBlocked = 0x00000001,
    UmsSchedulerThreadYield   = 0x00000002,
}

alias IMAGE_POLICY_ENTRY_TYPE = int;
enum : int
{
    ImagePolicyEntryTypeNone          = 0x00000000,
    ImagePolicyEntryTypeBool          = 0x00000001,
    ImagePolicyEntryTypeInt8          = 0x00000002,
    ImagePolicyEntryTypeUInt8         = 0x00000003,
    ImagePolicyEntryTypeInt16         = 0x00000004,
    ImagePolicyEntryTypeUInt16        = 0x00000005,
    ImagePolicyEntryTypeInt32         = 0x00000006,
    ImagePolicyEntryTypeUInt32        = 0x00000007,
    ImagePolicyEntryTypeInt64         = 0x00000008,
    ImagePolicyEntryTypeUInt64        = 0x00000009,
    ImagePolicyEntryTypeAnsiString    = 0x0000000a,
    ImagePolicyEntryTypeUnicodeString = 0x0000000b,
    ImagePolicyEntryTypeOverride      = 0x0000000c,
    ImagePolicyEntryTypeMaximum       = 0x0000000d,
}

alias IMAGE_POLICY_ID = int;
enum : int
{
    ImagePolicyIdNone                  = 0x00000000,
    ImagePolicyIdEtw                   = 0x00000001,
    ImagePolicyIdDebug                 = 0x00000002,
    ImagePolicyIdCrashDump             = 0x00000003,
    ImagePolicyIdCrashDumpKey          = 0x00000004,
    ImagePolicyIdCrashDumpKeyGuid      = 0x00000005,
    ImagePolicyIdParentSd              = 0x00000006,
    ImagePolicyIdParentSdRev           = 0x00000007,
    ImagePolicyIdSvn                   = 0x00000008,
    ImagePolicyIdDeviceId              = 0x00000009,
    ImagePolicyIdCapability            = 0x0000000a,
    ImagePolicyIdScenarioId            = 0x0000000b,
    ImagePolicyIdCapabilityOverridable = 0x0000000c,
    ImagePolicyIdTrustletIdOverridable = 0x0000000d,
    ImagePolicyIdMaximum               = 0x0000000e,
}

alias ACTIVATION_CONTEXT_INFO_CLASS = int;
enum : int
{
    ActivationContextBasicInformation                      = 0x00000001,
    ActivationContextDetailedInformation                   = 0x00000002,
    AssemblyDetailedInformationInActivationContext         = 0x00000003,
    FileInformationInAssemblyOfAssemblyInActivationContext = 0x00000004,
    RunlevelInformationInActivationContext                 = 0x00000005,
    CompatibilityInformationInActivationContext            = 0x00000006,
    ActivationContextManifestResourceName                  = 0x00000007,
    MaxActivationContextInfoClass                          = 0x00000008,
    AssemblyDetailedInformationInActivationContxt          = 0x00000003,
    FileInformationInAssemblyOfAssemblyInActivationContxt  = 0x00000004,
}

alias SERVICE_NODE_TYPE = int;
enum : int
{
    DriverType               = 0x00000001,
    FileSystemType           = 0x00000002,
    Win32ServiceOwnProcess   = 0x00000010,
    Win32ServiceShareProcess = 0x00000020,
    AdapterType              = 0x00000004,
    RecognizerType           = 0x00000008,
}

alias SERVICE_LOAD_TYPE = int;
enum : int
{
    BootLoad    = 0x00000000,
    SystemLoad  = 0x00000001,
    AutoLoad    = 0x00000002,
    DemandLoad  = 0x00000003,
    DisableLoad = 0x00000004,
}

alias SERVICE_ERROR_TYPE = int;
enum : int
{
    IgnoreError   = 0x00000000,
    NormalError   = 0x00000001,
    SevereError   = 0x00000002,
    CriticalError = 0x00000003,
}

alias TAPE_DRIVE_PROBLEM_TYPE = int;
enum : int
{
    TapeDriveProblemNone         = 0x00000000,
    TapeDriveReadWriteWarning    = 0x00000001,
    TapeDriveReadWriteError      = 0x00000002,
    TapeDriveReadWarning         = 0x00000003,
    TapeDriveWriteWarning        = 0x00000004,
    TapeDriveReadError           = 0x00000005,
    TapeDriveWriteError          = 0x00000006,
    TapeDriveHardwareError       = 0x00000007,
    TapeDriveUnsupportedMedia    = 0x00000008,
    TapeDriveScsiConnectionError = 0x00000009,
    TapeDriveTimetoClean         = 0x0000000a,
    TapeDriveCleanDriveNow       = 0x0000000b,
    TapeDriveMediaLifeExpired    = 0x0000000c,
    TapeDriveSnappedTape         = 0x0000000d,
}

alias TRANSACTION_STATE = int;
enum : int
{
    TransactionStateNormal          = 0x00000001,
    TransactionStateIndoubt         = 0x00000002,
    TransactionStateCommittedNotify = 0x00000003,
}

alias TRANSACTION_INFORMATION_CLASS = int;
enum : int
{
    TransactionBasicInformation              = 0x00000000,
    TransactionPropertiesInformation         = 0x00000001,
    TransactionEnlistmentInformation         = 0x00000002,
    TransactionSuperiorEnlistmentInformation = 0x00000003,
    TransactionBindInformation               = 0x00000004,
    TransactionDTCPrivateInformation         = 0x00000005,
}

alias TRANSACTIONMANAGER_INFORMATION_CLASS = int;
enum : int
{
    TransactionManagerBasicInformation             = 0x00000000,
    TransactionManagerLogInformation               = 0x00000001,
    TransactionManagerLogPathInformation           = 0x00000002,
    TransactionManagerRecoveryInformation          = 0x00000004,
    TransactionManagerOnlineProbeInformation       = 0x00000003,
    TransactionManagerOldestTransactionInformation = 0x00000005,
}

alias RESOURCEMANAGER_INFORMATION_CLASS = int;
enum : int
{
    ResourceManagerBasicInformation      = 0x00000000,
    ResourceManagerCompletionInformation = 0x00000001,
}

alias ENLISTMENT_INFORMATION_CLASS = int;
enum : int
{
    EnlistmentBasicInformation    = 0x00000000,
    EnlistmentRecoveryInformation = 0x00000001,
    EnlistmentCrmInformation      = 0x00000002,
}

alias KTMOBJECT_TYPE = int;
enum : int
{
    KTMOBJECT_TRANSACTION         = 0x00000000,
    KTMOBJECT_TRANSACTION_MANAGER = 0x00000001,
    KTMOBJECT_RESOURCE_MANAGER    = 0x00000002,
    KTMOBJECT_ENLISTMENT          = 0x00000003,
    KTMOBJECT_INVALID             = 0x00000004,
}

// Constants


enum : uint
{
    _MM_HINT_T0  = 0x00000001,
    _MM_HINT_T1  = 0x00000002,
    _MM_HINT_T2  = 0x00000003,
    _MM_HINT_NTA = 0x00000000,
}

enum uint MEMORY_ALLOCATION_ALIGNMENT = 0x00000010;
enum uint ARM_CACHE_ALIGNMENT_SIZE = 0x00000080;
enum uint PRAGMA_DEPRECATED_DDK = 0x00000001;
enum uint MIN_UCSCHAR = 0x00000000;

enum : uint
{
    MAXIMUM_PROC_PER_GROUP = 0x00000040,
    MAXIMUM_PROCESSORS     = 0x00000040,
}

enum : uint
{
    ERROR_SEVERITY_SUCCESS       = 0x00000000,
    ERROR_SEVERITY_INFORMATIONAL = 0x40000000,
    ERROR_SEVERITY_WARNING       = 0x80000000,
    ERROR_SEVERITY_ERROR         = 0xc0000000,
}

enum uint UNICODE_STRING_MAX_CHARS = 0x00007fff;
enum uint MAXCHAR = 0x0000007f;
enum uint MAXSHORT = 0x00007fff;

enum : uint
{
    MAXLONG  = 0x7fffffff,
    MAXBYTE  = 0x000000ff,
    MAXWORD  = 0x0000ffff,
    MAXDWORD = 0xffffffff,
}

enum uint ENCLAVE_LONG_ID_LENGTH = 0x00000020;
enum uint VER_WORKSTATION_NT = 0x40000000;

enum : uint
{
    VER_SUITE_ENTERPRISE               = 0x00000002,
    VER_SUITE_BACKOFFICE               = 0x00000004,
    VER_SUITE_COMMUNICATIONS           = 0x00000008,
    VER_SUITE_TERMINAL                 = 0x00000010,
    VER_SUITE_SMALLBUSINESS_RESTRICTED = 0x00000020,
}

enum : uint
{
    VER_SUITE_DATACENTER          = 0x00000080,
    VER_SUITE_SINGLEUSERTS        = 0x00000100,
    VER_SUITE_PERSONAL            = 0x00000200,
    VER_SUITE_BLADE               = 0x00000400,
    VER_SUITE_EMBEDDED_RESTRICTED = 0x00000800,
}

enum : uint
{
    VER_SUITE_STORAGE_SERVER = 0x00002000,
    VER_SUITE_COMPUTE_SERVER = 0x00004000,
    VER_SUITE_WH_SERVER      = 0x00008000,
    VER_SUITE_MULTIUSERTS    = 0x00020000,
}

enum uint LANG_INVARIANT = 0x0000007f;

enum : uint
{
    LANG_ALBANIAN    = 0x0000001c,
    LANG_ALSATIAN    = 0x00000084,
    LANG_AMHARIC     = 0x0000005e,
    LANG_ARABIC      = 0x00000001,
    LANG_ARMENIAN    = 0x0000002b,
    LANG_ASSAMESE    = 0x0000004d,
    LANG_AZERI       = 0x0000002c,
    LANG_AZERBAIJANI = 0x0000002c,
}

enum : uint
{
    LANG_BASHKIR         = 0x0000006d,
    LANG_BASQUE          = 0x0000002d,
    LANG_BELARUSIAN      = 0x00000023,
    LANG_BENGALI         = 0x00000045,
    LANG_BRETON          = 0x0000007e,
    LANG_BOSNIAN         = 0x0000001a,
    LANG_BOSNIAN_NEUTRAL = 0x0000781a,
}

enum : uint
{
    LANG_CATALAN         = 0x00000003,
    LANG_CENTRAL_KURDISH = 0x00000092,
}

enum : uint
{
    LANG_CHINESE             = 0x00000004,
    LANG_CHINESE_SIMPLIFIED  = 0x00000004,
    LANG_CHINESE_TRADITIONAL = 0x00007c04,
}

enum : uint
{
    LANG_CROATIAN = 0x0000001a,
    LANG_CZECH    = 0x00000005,
    LANG_DANISH   = 0x00000006,
    LANG_DARI     = 0x0000008c,
    LANG_DIVEHI   = 0x00000065,
    LANG_DUTCH    = 0x00000013,
    LANG_ENGLISH  = 0x00000009,
    LANG_ESTONIAN = 0x00000025,
}

enum : uint
{
    LANG_FARSI       = 0x00000029,
    LANG_FILIPINO    = 0x00000064,
    LANG_FINNISH     = 0x0000000b,
    LANG_FRENCH      = 0x0000000c,
    LANG_FRISIAN     = 0x00000062,
    LANG_FULAH       = 0x00000067,
    LANG_GALICIAN    = 0x00000056,
    LANG_GEORGIAN    = 0x00000037,
    LANG_GERMAN      = 0x00000007,
    LANG_GREEK       = 0x00000008,
    LANG_GREENLANDIC = 0x0000006f,
}

enum : uint
{
    LANG_HAUSA     = 0x00000068,
    LANG_HAWAIIAN  = 0x00000075,
    LANG_HEBREW    = 0x0000000d,
    LANG_HINDI     = 0x00000039,
    LANG_HUNGARIAN = 0x0000000e,
}

enum : uint
{
    LANG_IGBO       = 0x00000070,
    LANG_INDONESIAN = 0x00000021,
    LANG_INUKTITUT  = 0x0000005d,
    LANG_IRISH      = 0x0000003c,
    LANG_ITALIAN    = 0x00000010,
    LANG_JAPANESE   = 0x00000011,
}

enum : uint
{
    LANG_KASHMIRI    = 0x00000060,
    LANG_KAZAK       = 0x0000003f,
    LANG_KHMER       = 0x00000053,
    LANG_KICHE       = 0x00000086,
    LANG_KINYARWANDA = 0x00000087,
}

enum : uint
{
    LANG_KOREAN     = 0x00000012,
    LANG_KYRGYZ     = 0x00000040,
    LANG_LAO        = 0x00000054,
    LANG_LATVIAN    = 0x00000026,
    LANG_LITHUANIAN = 0x00000027,
}

enum uint LANG_LUXEMBOURGISH = 0x0000006e;

enum : uint
{
    LANG_MALAY      = 0x0000003e,
    LANG_MALAYALAM  = 0x0000004c,
    LANG_MALTESE    = 0x0000003a,
    LANG_MANIPURI   = 0x00000058,
    LANG_MAORI      = 0x00000081,
    LANG_MAPUDUNGUN = 0x0000007a,
    LANG_MARATHI    = 0x0000004e,
    LANG_MOHAWK     = 0x0000007c,
    LANG_MONGOLIAN  = 0x00000050,
}

enum uint LANG_NORWEGIAN = 0x00000014;

enum : uint
{
    LANG_ODIA       = 0x00000048,
    LANG_ORIYA      = 0x00000048,
    LANG_PASHTO     = 0x00000063,
    LANG_PERSIAN    = 0x00000029,
    LANG_POLISH     = 0x00000015,
    LANG_PORTUGUESE = 0x00000016,
}

enum : uint
{
    LANG_PUNJABI         = 0x00000046,
    LANG_QUECHUA         = 0x0000006b,
    LANG_ROMANIAN        = 0x00000018,
    LANG_ROMANSH         = 0x00000017,
    LANG_RUSSIAN         = 0x00000019,
    LANG_SAKHA           = 0x00000085,
    LANG_SAMI            = 0x0000003b,
    LANG_SANSKRIT        = 0x0000004f,
    LANG_SCOTTISH_GAELIC = 0x00000091,
}

enum uint LANG_SERBIAN_NEUTRAL = 0x00007c1a;

enum : uint
{
    LANG_SINHALESE     = 0x0000005b,
    LANG_SLOVAK        = 0x0000001b,
    LANG_SLOVENIAN     = 0x00000024,
    LANG_SOTHO         = 0x0000006c,
    LANG_SPANISH       = 0x0000000a,
    LANG_SWAHILI       = 0x00000041,
    LANG_SWEDISH       = 0x0000001d,
    LANG_SYRIAC        = 0x0000005a,
    LANG_TAJIK         = 0x00000028,
    LANG_TAMAZIGHT     = 0x0000005f,
    LANG_TAMIL         = 0x00000049,
    LANG_TATAR         = 0x00000044,
    LANG_TELUGU        = 0x0000004a,
    LANG_THAI          = 0x0000001e,
    LANG_TIBETAN       = 0x00000051,
    LANG_TIGRIGNA      = 0x00000073,
    LANG_TIGRINYA      = 0x00000073,
    LANG_TSWANA        = 0x00000032,
    LANG_TURKISH       = 0x0000001f,
    LANG_TURKMEN       = 0x00000042,
    LANG_UIGHUR        = 0x00000080,
    LANG_UKRAINIAN     = 0x00000022,
    LANG_UPPER_SORBIAN = 0x0000002e,
}

enum : uint
{
    LANG_UZBEK      = 0x00000043,
    LANG_VALENCIAN  = 0x00000003,
    LANG_VIETNAMESE = 0x0000002a,
}

enum : uint
{
    LANG_WOLOF  = 0x00000088,
    LANG_XHOSA  = 0x00000034,
    LANG_YAKUT  = 0x00000085,
    LANG_YI     = 0x00000078,
    LANG_YORUBA = 0x0000006a,
    LANG_ZULU   = 0x00000035,
}

enum : uint
{
    SUBLANG_DEFAULT            = 0x00000001,
    SUBLANG_SYS_DEFAULT        = 0x00000002,
    SUBLANG_CUSTOM_DEFAULT     = 0x00000003,
    SUBLANG_CUSTOM_UNSPECIFIED = 0x00000004,
}

enum uint SUBLANG_AFRIKAANS_SOUTH_AFRICA = 0x00000001;
enum uint SUBLANG_ALSATIAN_FRANCE = 0x00000001;

enum : uint
{
    SUBLANG_ARABIC_SAUDI_ARABIA = 0x00000001,
    SUBLANG_ARABIC_IRAQ         = 0x00000002,
    SUBLANG_ARABIC_EGYPT        = 0x00000003,
    SUBLANG_ARABIC_LIBYA        = 0x00000004,
    SUBLANG_ARABIC_ALGERIA      = 0x00000005,
    SUBLANG_ARABIC_MOROCCO      = 0x00000006,
    SUBLANG_ARABIC_TUNISIA      = 0x00000007,
    SUBLANG_ARABIC_OMAN         = 0x00000008,
    SUBLANG_ARABIC_YEMEN        = 0x00000009,
    SUBLANG_ARABIC_SYRIA        = 0x0000000a,
    SUBLANG_ARABIC_JORDAN       = 0x0000000b,
    SUBLANG_ARABIC_LEBANON      = 0x0000000c,
    SUBLANG_ARABIC_KUWAIT       = 0x0000000d,
    SUBLANG_ARABIC_UAE          = 0x0000000e,
    SUBLANG_ARABIC_BAHRAIN      = 0x0000000f,
    SUBLANG_ARABIC_QATAR        = 0x00000010,
    SUBLANG_ARMENIAN_ARMENIA    = 0x00000001,
}

enum : uint
{
    SUBLANG_AZERI_LATIN                     = 0x00000001,
    SUBLANG_AZERI_CYRILLIC                  = 0x00000002,
    SUBLANG_AZERBAIJANI_AZERBAIJAN_LATIN    = 0x00000001,
    SUBLANG_AZERBAIJANI_AZERBAIJAN_CYRILLIC = 0x00000002,
}

enum uint SUBLANG_BANGLA_BANGLADESH = 0x00000002;

enum : uint
{
    SUBLANG_BASQUE_BASQUE      = 0x00000001,
    SUBLANG_BELARUSIAN_BELARUS = 0x00000001,
}

enum uint SUBLANG_BENGALI_BANGLADESH = 0x00000002;
enum uint SUBLANG_BOSNIAN_BOSNIA_HERZEGOVINA_CYRILLIC = 0x00000008;
enum uint SUBLANG_BULGARIAN_BULGARIA = 0x00000001;
enum uint SUBLANG_CENTRAL_KURDISH_IRAQ = 0x00000001;

enum : uint
{
    SUBLANG_CHINESE_TRADITIONAL = 0x00000001,
    SUBLANG_CHINESE_SIMPLIFIED  = 0x00000002,
    SUBLANG_CHINESE_HONGKONG    = 0x00000003,
    SUBLANG_CHINESE_SINGAPORE   = 0x00000004,
    SUBLANG_CHINESE_MACAU       = 0x00000005,
    SUBLANG_CORSICAN_FRANCE     = 0x00000001,
}

enum : uint
{
    SUBLANG_CROATIAN_CROATIA                  = 0x00000001,
    SUBLANG_CROATIAN_BOSNIA_HERZEGOVINA_LATIN = 0x00000004,
}

enum uint SUBLANG_DARI_AFGHANISTAN = 0x00000001;

enum : uint
{
    SUBLANG_DUTCH         = 0x00000001,
    SUBLANG_DUTCH_BELGIAN = 0x00000002,
}

enum : uint
{
    SUBLANG_ENGLISH_UK           = 0x00000002,
    SUBLANG_ENGLISH_AUS          = 0x00000003,
    SUBLANG_ENGLISH_CAN          = 0x00000004,
    SUBLANG_ENGLISH_NZ           = 0x00000005,
    SUBLANG_ENGLISH_EIRE         = 0x00000006,
    SUBLANG_ENGLISH_SOUTH_AFRICA = 0x00000007,
    SUBLANG_ENGLISH_JAMAICA      = 0x00000008,
    SUBLANG_ENGLISH_CARIBBEAN    = 0x00000009,
    SUBLANG_ENGLISH_BELIZE       = 0x0000000a,
    SUBLANG_ENGLISH_TRINIDAD     = 0x0000000b,
    SUBLANG_ENGLISH_ZIMBABWE     = 0x0000000c,
    SUBLANG_ENGLISH_PHILIPPINES  = 0x0000000d,
    SUBLANG_ENGLISH_INDIA        = 0x00000010,
    SUBLANG_ENGLISH_MALAYSIA     = 0x00000011,
    SUBLANG_ENGLISH_SINGAPORE    = 0x00000012,
}

enum uint SUBLANG_FAEROESE_FAROE_ISLANDS = 0x00000001;
enum uint SUBLANG_FINNISH_FINLAND = 0x00000001;

enum : uint
{
    SUBLANG_FRENCH_BELGIAN      = 0x00000002,
    SUBLANG_FRENCH_CANADIAN     = 0x00000003,
    SUBLANG_FRENCH_SWISS        = 0x00000004,
    SUBLANG_FRENCH_LUXEMBOURG   = 0x00000005,
    SUBLANG_FRENCH_MONACO       = 0x00000006,
    SUBLANG_FRISIAN_NETHERLANDS = 0x00000001,
}

enum uint SUBLANG_GALICIAN_GALICIAN = 0x00000001;

enum : uint
{
    SUBLANG_GERMAN               = 0x00000001,
    SUBLANG_GERMAN_SWISS         = 0x00000002,
    SUBLANG_GERMAN_AUSTRIAN      = 0x00000003,
    SUBLANG_GERMAN_LUXEMBOURG    = 0x00000004,
    SUBLANG_GERMAN_LIECHTENSTEIN = 0x00000005,
}

enum uint SUBLANG_GREENLANDIC_GREENLAND = 0x00000001;
enum uint SUBLANG_HAUSA_NIGERIA_LATIN = 0x00000001;

enum : uint
{
    SUBLANG_HEBREW_ISRAEL     = 0x00000001,
    SUBLANG_HINDI_INDIA       = 0x00000001,
    SUBLANG_HUNGARIAN_HUNGARY = 0x00000001,
}

enum : uint
{
    SUBLANG_IGBO_NIGERIA         = 0x00000001,
    SUBLANG_INDONESIAN_INDONESIA = 0x00000001,
}

enum uint SUBLANG_INUKTITUT_CANADA_LATIN = 0x00000002;

enum : uint
{
    SUBLANG_ITALIAN       = 0x00000001,
    SUBLANG_ITALIAN_SWISS = 0x00000002,
}

enum : uint
{
    SUBLANG_KANNADA_INDIA    = 0x00000001,
    SUBLANG_KASHMIRI_SASIA   = 0x00000002,
    SUBLANG_KASHMIRI_INDIA   = 0x00000002,
    SUBLANG_KAZAK_KAZAKHSTAN = 0x00000001,
}

enum : uint
{
    SUBLANG_KICHE_GUATEMALA    = 0x00000001,
    SUBLANG_KINYARWANDA_RWANDA = 0x00000001,
}

enum : uint
{
    SUBLANG_KOREAN            = 0x00000001,
    SUBLANG_KYRGYZ_KYRGYZSTAN = 0x00000001,
}

enum : uint
{
    SUBLANG_LATVIAN_LATVIA        = 0x00000001,
    SUBLANG_LITHUANIAN            = 0x00000001,
    SUBLANG_LOWER_SORBIAN_GERMANY = 0x00000002,
}

enum uint SUBLANG_MACEDONIAN_MACEDONIA = 0x00000001;

enum : uint
{
    SUBLANG_MALAY_BRUNEI_DARUSSALAM = 0x00000002,
    SUBLANG_MALAYALAM_INDIA         = 0x00000001,
    SUBLANG_MALTESE_MALTA           = 0x00000001,
    SUBLANG_MAORI_NEW_ZEALAND       = 0x00000001,
}

enum : uint
{
    SUBLANG_MARATHI_INDIA               = 0x00000001,
    SUBLANG_MOHAWK_MOHAWK               = 0x00000001,
    SUBLANG_MONGOLIAN_CYRILLIC_MONGOLIA = 0x00000001,
    SUBLANG_MONGOLIAN_PRC               = 0x00000002,
}

enum : uint
{
    SUBLANG_NEPALI_NEPAL      = 0x00000001,
    SUBLANG_NORWEGIAN_BOKMAL  = 0x00000001,
    SUBLANG_NORWEGIAN_NYNORSK = 0x00000002,
}

enum : uint
{
    SUBLANG_ODIA_INDIA         = 0x00000001,
    SUBLANG_ORIYA_INDIA        = 0x00000001,
    SUBLANG_PASHTO_AFGHANISTAN = 0x00000001,
}

enum : uint
{
    SUBLANG_POLISH_POLAND        = 0x00000001,
    SUBLANG_PORTUGUESE           = 0x00000002,
    SUBLANG_PORTUGUESE_BRAZILIAN = 0x00000001,
}

enum : uint
{
    SUBLANG_PUNJABI_INDIA    = 0x00000001,
    SUBLANG_PUNJABI_PAKISTAN = 0x00000002,
}

enum : uint
{
    SUBLANG_QUECHUA_ECUADOR = 0x00000002,
    SUBLANG_QUECHUA_PERU    = 0x00000003,
}

enum uint SUBLANG_ROMANSH_SWITZERLAND = 0x00000001;

enum : uint
{
    SUBLANG_SAKHA_RUSSIA          = 0x00000001,
    SUBLANG_SAMI_NORTHERN_NORWAY  = 0x00000001,
    SUBLANG_SAMI_NORTHERN_SWEDEN  = 0x00000002,
    SUBLANG_SAMI_NORTHERN_FINLAND = 0x00000003,
    SUBLANG_SAMI_LULE_NORWAY      = 0x00000004,
    SUBLANG_SAMI_LULE_SWEDEN      = 0x00000005,
    SUBLANG_SAMI_SOUTHERN_NORWAY  = 0x00000006,
    SUBLANG_SAMI_SOUTHERN_SWEDEN  = 0x00000007,
    SUBLANG_SAMI_SKOLT_FINLAND    = 0x00000008,
    SUBLANG_SAMI_INARI_FINLAND    = 0x00000009,
}

enum uint SUBLANG_SCOTTISH_GAELIC = 0x00000001;
enum uint SUBLANG_SERBIAN_BOSNIA_HERZEGOVINA_CYRILLIC = 0x00000007;

enum : uint
{
    SUBLANG_SERBIAN_MONTENEGRO_CYRILLIC = 0x0000000c,
    SUBLANG_SERBIAN_SERBIA_LATIN        = 0x00000009,
    SUBLANG_SERBIAN_SERBIA_CYRILLIC     = 0x0000000a,
    SUBLANG_SERBIAN_CROATIA             = 0x00000001,
    SUBLANG_SERBIAN_LATIN               = 0x00000002,
    SUBLANG_SERBIAN_CYRILLIC            = 0x00000003,
}

enum : uint
{
    SUBLANG_SINDHI_PAKISTAN     = 0x00000002,
    SUBLANG_SINDHI_AFGHANISTAN  = 0x00000002,
    SUBLANG_SINHALESE_SRI_LANKA = 0x00000001,
}

enum : uint
{
    SUBLANG_SLOVAK_SLOVAKIA    = 0x00000001,
    SUBLANG_SLOVENIAN_SLOVENIA = 0x00000001,
}

enum : uint
{
    SUBLANG_SPANISH_MEXICAN            = 0x00000002,
    SUBLANG_SPANISH_MODERN             = 0x00000003,
    SUBLANG_SPANISH_GUATEMALA          = 0x00000004,
    SUBLANG_SPANISH_COSTA_RICA         = 0x00000005,
    SUBLANG_SPANISH_PANAMA             = 0x00000006,
    SUBLANG_SPANISH_DOMINICAN_REPUBLIC = 0x00000007,
    SUBLANG_SPANISH_VENEZUELA          = 0x00000008,
    SUBLANG_SPANISH_COLOMBIA           = 0x00000009,
    SUBLANG_SPANISH_PERU               = 0x0000000a,
    SUBLANG_SPANISH_ARGENTINA          = 0x0000000b,
    SUBLANG_SPANISH_ECUADOR            = 0x0000000c,
    SUBLANG_SPANISH_CHILE              = 0x0000000d,
    SUBLANG_SPANISH_URUGUAY            = 0x0000000e,
    SUBLANG_SPANISH_PARAGUAY           = 0x0000000f,
    SUBLANG_SPANISH_BOLIVIA            = 0x00000010,
    SUBLANG_SPANISH_EL_SALVADOR        = 0x00000011,
    SUBLANG_SPANISH_HONDURAS           = 0x00000012,
    SUBLANG_SPANISH_NICARAGUA          = 0x00000013,
    SUBLANG_SPANISH_PUERTO_RICO        = 0x00000014,
    SUBLANG_SPANISH_US                 = 0x00000015,
    SUBLANG_SWAHILI_KENYA              = 0x00000001,
    SUBLANG_SWEDISH                    = 0x00000001,
    SUBLANG_SWEDISH_FINLAND            = 0x00000002,
}

enum : uint
{
    SUBLANG_TAJIK_TAJIKISTAN           = 0x00000001,
    SUBLANG_TAMAZIGHT_ALGERIA_LATIN    = 0x00000002,
    SUBLANG_TAMAZIGHT_MOROCCO_TIFINAGH = 0x00000004,
}

enum : uint
{
    SUBLANG_TAMIL_SRI_LANKA   = 0x00000002,
    SUBLANG_TATAR_RUSSIA      = 0x00000001,
    SUBLANG_TELUGU_INDIA      = 0x00000001,
    SUBLANG_THAI_THAILAND     = 0x00000001,
    SUBLANG_TIBETAN_PRC       = 0x00000001,
    SUBLANG_TIGRIGNA_ERITREA  = 0x00000002,
    SUBLANG_TIGRINYA_ERITREA  = 0x00000002,
    SUBLANG_TIGRINYA_ETHIOPIA = 0x00000001,
}

enum uint SUBLANG_TSWANA_SOUTH_AFRICA = 0x00000001;
enum uint SUBLANG_TURKMEN_TURKMENISTAN = 0x00000001;
enum uint SUBLANG_UKRAINIAN_UKRAINE = 0x00000001;

enum : uint
{
    SUBLANG_URDU_PAKISTAN  = 0x00000001,
    SUBLANG_URDU_INDIA     = 0x00000002,
    SUBLANG_UZBEK_LATIN    = 0x00000001,
    SUBLANG_UZBEK_CYRILLIC = 0x00000002,
}

enum uint SUBLANG_VIETNAMESE_VIETNAM = 0x00000001;
enum uint SUBLANG_WOLOF_SENEGAL = 0x00000001;

enum : uint
{
    SUBLANG_YAKUT_RUSSIA   = 0x00000001,
    SUBLANG_YI_PRC         = 0x00000001,
    SUBLANG_YORUBA_NIGERIA = 0x00000001,
}

enum : uint
{
    SORT_DEFAULT        = 0x00000000,
    SORT_INVARIANT_MATH = 0x00000001,
}

enum : uint
{
    SORT_JAPANESE_UNICODE       = 0x00000001,
    SORT_JAPANESE_RADICALSTROKE = 0x00000004,
}

enum : uint
{
    SORT_CHINESE_PRCP          = 0x00000000,
    SORT_CHINESE_UNICODE       = 0x00000001,
    SORT_CHINESE_PRC           = 0x00000002,
    SORT_CHINESE_BOPOMOFO      = 0x00000003,
    SORT_CHINESE_RADICALSTROKE = 0x00000004,
}

enum uint SORT_KOREAN_UNICODE = 0x00000001;

enum : uint
{
    SORT_HUNGARIAN_DEFAULT   = 0x00000000,
    SORT_HUNGARIAN_TECHNICAL = 0x00000001,
}

enum uint SORT_GEORGIAN_MODERN = 0x00000001;
enum uint LOCALE_NAME_MAX_LENGTH = 0x00000055;

enum : uint
{
    LOCALE_TRANSIENT_KEYBOARD2 = 0x00002400,
    LOCALE_TRANSIENT_KEYBOARD3 = 0x00002800,
    LOCALE_TRANSIENT_KEYBOARD4 = 0x00002c00,
}

enum uint MAXIMUM_WAIT_OBJECTS = 0x00000040;
enum uint XSTATE_CONTEXT_FLAG_LOOKASIDE = 0x00000001;

enum : uint
{
    PF_TEMPORAL_LEVEL_2 = 0x00000002,
    PF_TEMPORAL_LEVEL_3 = 0x00000003,
}

enum : uint
{
    EXCEPTION_READ_FAULT    = 0x00000000,
    EXCEPTION_WRITE_FAULT   = 0x00000001,
    EXCEPTION_EXECUTE_FAULT = 0x00000008,
}

enum uint INITIAL_FPCSR = 0x0000027f;
enum uint UNW_FLAG_NO_EPILOGUE = 0x80000000;
enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* OUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK_EXPORT_NAME = "OutOfProcessFunctionTableCallback";
enum uint INITIAL_FPSCR = 0x00000000;
enum uint ARM_MAX_WATCHPOINTS = 0x00000001;

enum : uint
{
    ARM64_PREFETCH_PLI  = 0x00000008,
    ARM64_PREFETCH_PST  = 0x00000010,
    ARM64_PREFETCH_L1   = 0x00000000,
    ARM64_PREFETCH_L2   = 0x00000002,
    ARM64_PREFETCH_L3   = 0x00000004,
    ARM64_PREFETCH_KEEP = 0x00000000,
    ARM64_PREFETCH_STRM = 0x00000001,
}

enum : uint
{
    ARM64_MAX_BREAKPOINTS = 0x00000008,
    ARM64_MAX_WATCHPOINTS = 0x00000002,
}

enum uint NONVOL_FP_NUMREG_ARM64 = 0x00000008;
enum uint ASSERT_BREAKPOINT = 0x00080003;
enum uint MAXIMUM_SUPPORTED_EXTENSION = 0x00000200;

enum : uint
{
    EXCEPTION_UNWINDING       = 0x00000002,
    EXCEPTION_EXIT_UNWIND     = 0x00000004,
    EXCEPTION_STACK_INVALID   = 0x00000008,
    EXCEPTION_NESTED_CALL     = 0x00000010,
    EXCEPTION_TARGET_UNWIND   = 0x00000020,
    EXCEPTION_COLLIDED_UNWIND = 0x00000040,
}

enum uint EXCEPTION_MAXIMUM_PARAMETERS = 0x0000000f;
enum uint MAXIMUM_ALLOWED = 0x02000000;
enum uint SID_MAX_SUB_AUTHORITIES = 0x0000000f;
enum uint SID_HASH_SIZE = 0x00000020;

enum : int
{
    SECURITY_WORLD_RID       = 0x00000000,
    SECURITY_LOCAL_RID       = 0x00000000,
    SECURITY_LOCAL_LOGON_RID = 0x00000001,
}

enum : int
{
    SECURITY_CREATOR_GROUP_RID        = 0x00000001,
    SECURITY_CREATOR_OWNER_SERVER_RID = 0x00000002,
    SECURITY_CREATOR_GROUP_SERVER_RID = 0x00000003,
    SECURITY_CREATOR_OWNER_RIGHTS_RID = 0x00000004,
}

enum : int
{
    SECURITY_NETWORK_RID     = 0x00000002,
    SECURITY_BATCH_RID       = 0x00000003,
    SECURITY_INTERACTIVE_RID = 0x00000004,
}

enum int SECURITY_LOGON_IDS_RID_COUNT = 0x00000003;
enum int SECURITY_ANONYMOUS_LOGON_RID = 0x00000007;
enum int SECURITY_ENTERPRISE_CONTROLLERS_RID = 0x00000009;
enum int SECURITY_PRINCIPAL_SELF_RID = 0x0000000a;
enum int SECURITY_RESTRICTED_CODE_RID = 0x0000000c;
enum int SECURITY_REMOTE_LOGON_RID = 0x0000000e;

enum : int
{
    SECURITY_IUSER_RID         = 0x00000011,
    SECURITY_LOCAL_SYSTEM_RID  = 0x00000012,
    SECURITY_LOCAL_SERVICE_RID = 0x00000013,
}

enum : int
{
    SECURITY_NT_NON_UNIQUE                = 0x00000015,
    SECURITY_NT_NON_UNIQUE_SUB_AUTH_COUNT = 0x00000003,
}

enum int SECURITY_BUILTIN_DOMAIN_RID = 0x00000020;

enum : int
{
    SECURITY_PACKAGE_BASE_RID     = 0x00000040,
    SECURITY_PACKAGE_RID_COUNT    = 0x00000002,
    SECURITY_PACKAGE_NTLM_RID     = 0x0000000a,
    SECURITY_PACKAGE_SCHANNEL_RID = 0x0000000e,
    SECURITY_PACKAGE_DIGEST_RID   = 0x00000015,
}

enum : int
{
    SECURITY_CRED_TYPE_RID_COUNT         = 0x00000002,
    SECURITY_CRED_TYPE_THIS_ORG_CERT_RID = 0x00000001,
}

enum : int
{
    SECURITY_SERVICE_ID_BASE_RID  = 0x00000050,
    SECURITY_SERVICE_ID_RID_COUNT = 0x00000006,
}

enum : int
{
    SECURITY_APPPOOL_ID_BASE_RID  = 0x00000052,
    SECURITY_APPPOOL_ID_RID_COUNT = 0x00000006,
}

enum int SECURITY_VIRTUALSERVER_ID_RID_COUNT = 0x00000006;
enum int SECURITY_USERMODEDRIVERHOST_ID_RID_COUNT = 0x00000006;
enum int SECURITY_CLOUD_INFRASTRUCTURE_SERVICES_ID_RID_COUNT = 0x00000006;
enum int SECURITY_WMIHOST_ID_RID_COUNT = 0x00000006;
enum int SECURITY_NFS_ID_BASE_RID = 0x00000058;
enum int SECURITY_WINDOW_MANAGER_BASE_RID = 0x0000005a;

enum : int
{
    SECURITY_DASHOST_ID_BASE_RID  = 0x0000005c,
    SECURITY_DASHOST_ID_RID_COUNT = 0x00000006,
}

enum int SECURITY_USERMANAGER_ID_RID_COUNT = 0x00000006;
enum int SECURITY_WINRM_ID_RID_COUNT = 0x00000006;

enum : int
{
    SECURITY_UMFD_BASE_RID               = 0x00000060,
    SECURITY_UNIQUIFIED_SERVICE_BASE_RID = 0x00000061,
}

enum int SECURITY_EDGE_CLOUD_INFRASTRUCTURE_SERVICE_ID_BASE_RID = 0x00000062;
enum int SECURITY_RESTRICTED_SERVICES_RID_COUNT = 0x00000006;
enum int SECURITY_MAX_ALWAYS_FILTERED = 0x000003e7;
enum int SECURITY_OTHER_ORGANIZATION_RID = 0x000003e8;

enum : uint
{
    SECURITY_INSTALLER_GROUP_CAPABILITY_BASE      = 0x00000020,
    SECURITY_INSTALLER_GROUP_CAPABILITY_RID_COUNT = 0x00000009,
    SECURITY_INSTALLER_CAPABILITY_RID_COUNT       = 0x0000000a,
}

enum int SECURITY_LOCAL_ACCOUNT_AND_ADMIN_RID = 0x00000072;
enum int DOMAIN_GROUP_RID_AUTHORIZATION_DATA_CONTAINS_CLAIMS = 0x000001f1;
enum int FOREST_USER_RID_MAX = 0x000001f3;

enum : int
{
    DOMAIN_USER_RID_GUEST           = 0x000001f5,
    DOMAIN_USER_RID_KRBTGT          = 0x000001f6,
    DOMAIN_USER_RID_DEFAULT_ACCOUNT = 0x000001f7,
    DOMAIN_USER_RID_WDAG_ACCOUNT    = 0x000001f8,
    DOMAIN_USER_RID_MAX             = 0x000003e7,
}

enum : int
{
    DOMAIN_GROUP_RID_USERS                 = 0x00000201,
    DOMAIN_GROUP_RID_GUESTS                = 0x00000202,
    DOMAIN_GROUP_RID_COMPUTERS             = 0x00000203,
    DOMAIN_GROUP_RID_CONTROLLERS           = 0x00000204,
    DOMAIN_GROUP_RID_CERT_ADMINS           = 0x00000205,
    DOMAIN_GROUP_RID_SCHEMA_ADMINS         = 0x00000206,
    DOMAIN_GROUP_RID_ENTERPRISE_ADMINS     = 0x00000207,
    DOMAIN_GROUP_RID_POLICY_ADMINS         = 0x00000208,
    DOMAIN_GROUP_RID_READONLY_CONTROLLERS  = 0x00000209,
    DOMAIN_GROUP_RID_CLONEABLE_CONTROLLERS = 0x0000020a,
    DOMAIN_GROUP_RID_CDC_RESERVED          = 0x0000020c,
    DOMAIN_GROUP_RID_PROTECTED_USERS       = 0x0000020d,
    DOMAIN_GROUP_RID_KEY_ADMINS            = 0x0000020e,
    DOMAIN_GROUP_RID_ENTERPRISE_KEY_ADMINS = 0x0000020f,
    DOMAIN_GROUP_RID_FOREST_TRUSTS         = 0x00000210,
    DOMAIN_GROUP_RID_EXTERNAL_TRUSTS       = 0x00000211,
}

enum : int
{
    DOMAIN_ALIAS_RID_USERS                          = 0x00000221,
    DOMAIN_ALIAS_RID_GUESTS                         = 0x00000222,
    DOMAIN_ALIAS_RID_POWER_USERS                    = 0x00000223,
    DOMAIN_ALIAS_RID_ACCOUNT_OPS                    = 0x00000224,
    DOMAIN_ALIAS_RID_SYSTEM_OPS                     = 0x00000225,
    DOMAIN_ALIAS_RID_PRINT_OPS                      = 0x00000226,
    DOMAIN_ALIAS_RID_BACKUP_OPS                     = 0x00000227,
    DOMAIN_ALIAS_RID_REPLICATOR                     = 0x00000228,
    DOMAIN_ALIAS_RID_RAS_SERVERS                    = 0x00000229,
    DOMAIN_ALIAS_RID_PREW2KCOMPACCESS               = 0x0000022a,
    DOMAIN_ALIAS_RID_REMOTE_DESKTOP_USERS           = 0x0000022b,
    DOMAIN_ALIAS_RID_NETWORK_CONFIGURATION_OPS      = 0x0000022c,
    DOMAIN_ALIAS_RID_INCOMING_FOREST_TRUST_BUILDERS = 0x0000022d,
}

enum : int
{
    DOMAIN_ALIAS_RID_LOGGING_USERS              = 0x0000022f,
    DOMAIN_ALIAS_RID_AUTHORIZATIONACCESS        = 0x00000230,
    DOMAIN_ALIAS_RID_TS_LICENSE_SERVERS         = 0x00000231,
    DOMAIN_ALIAS_RID_DCOM_USERS                 = 0x00000232,
    DOMAIN_ALIAS_RID_IUSERS                     = 0x00000238,
    DOMAIN_ALIAS_RID_CRYPTO_OPERATORS           = 0x00000239,
    DOMAIN_ALIAS_RID_CACHEABLE_PRINCIPALS_GROUP = 0x0000023b,
}

enum : int
{
    DOMAIN_ALIAS_RID_EVENT_LOG_READERS_GROUP       = 0x0000023d,
    DOMAIN_ALIAS_RID_CERTSVC_DCOM_ACCESS_GROUP     = 0x0000023e,
    DOMAIN_ALIAS_RID_RDS_REMOTE_ACCESS_SERVERS     = 0x0000023f,
    DOMAIN_ALIAS_RID_RDS_ENDPOINT_SERVERS          = 0x00000240,
    DOMAIN_ALIAS_RID_RDS_MANAGEMENT_SERVERS        = 0x00000241,
    DOMAIN_ALIAS_RID_HYPER_V_ADMINS                = 0x00000242,
    DOMAIN_ALIAS_RID_ACCESS_CONTROL_ASSISTANCE_OPS = 0x00000243,
}

enum : int
{
    DOMAIN_ALIAS_RID_DEFAULT_ACCOUNT              = 0x00000245,
    DOMAIN_ALIAS_RID_STORAGE_REPLICA_ADMINS       = 0x00000246,
    DOMAIN_ALIAS_RID_DEVICE_OWNERS                = 0x00000247,
    DOMAIN_ALIAS_RID_USER_MODE_HARDWARE_OPERATORS = 0x00000248,
}

enum int SECURITY_APP_PACKAGE_BASE_RID = 0x00000002;
enum int SECURITY_APP_PACKAGE_RID_COUNT = 0x00000008;

enum : int
{
    SECURITY_CAPABILITY_APP_RID      = 0x00000400,
    SECURITY_CAPABILITY_APP_SILO_RID = 0x00010000,
}

enum int SECURITY_CAPABILITY_RID_COUNT = 0x00000005;
enum int SECURITY_CHILD_PACKAGE_RID_COUNT = 0x0000000c;
enum int SECURITY_BUILTIN_PACKAGE_ANY_RESTRICTED_PACKAGE = 0x00000002;

enum : int
{
    SECURITY_CAPABILITY_INTERNET_CLIENT_SERVER        = 0x00000002,
    SECURITY_CAPABILITY_PRIVATE_NETWORK_CLIENT_SERVER = 0x00000003,
    SECURITY_CAPABILITY_PICTURES_LIBRARY              = 0x00000004,
    SECURITY_CAPABILITY_VIDEOS_LIBRARY                = 0x00000005,
    SECURITY_CAPABILITY_MUSIC_LIBRARY                 = 0x00000006,
    SECURITY_CAPABILITY_DOCUMENTS_LIBRARY             = 0x00000007,
    SECURITY_CAPABILITY_ENTERPRISE_AUTHENTICATION     = 0x00000008,
    SECURITY_CAPABILITY_SHARED_USER_CERTIFICATES      = 0x00000009,
    SECURITY_CAPABILITY_REMOVABLE_STORAGE             = 0x0000000a,
    SECURITY_CAPABILITY_APPOINTMENTS                  = 0x0000000b,
    SECURITY_CAPABILITY_CONTACTS                      = 0x0000000c,
    SECURITY_CAPABILITY_INTERNET_EXPLORER             = 0x00001000,
}

enum : int
{
    SECURITY_MANDATORY_LOW_RID    = 0x00001000,
    SECURITY_MANDATORY_MEDIUM_RID = 0x00002000,
}

enum : int
{
    SECURITY_MANDATORY_HIGH_RID              = 0x00003000,
    SECURITY_MANDATORY_SYSTEM_RID            = 0x00004000,
    SECURITY_MANDATORY_PROTECTED_PROCESS_RID = 0x00005000,
}

enum int SECURITY_MANDATORY_MAXIMUM_USER_RID = 0x00004000;

enum : int
{
    SECURITY_AUTHENTICATION_AUTHORITY_ASSERTED_RID       = 0x00000001,
    SECURITY_AUTHENTICATION_SERVICE_ASSERTED_RID         = 0x00000002,
    SECURITY_AUTHENTICATION_FRESH_KEY_AUTH_RID           = 0x00000003,
    SECURITY_AUTHENTICATION_KEY_TRUST_RID                = 0x00000004,
    SECURITY_AUTHENTICATION_KEY_PROPERTY_MFA_RID         = 0x00000005,
    SECURITY_AUTHENTICATION_KEY_PROPERTY_ATTESTATION_RID = 0x00000006,
}

enum : int
{
    SECURITY_PROCESS_PROTECTION_TYPE_FULL_RID          = 0x00000400,
    SECURITY_PROCESS_PROTECTION_TYPE_LITE_RID          = 0x00000200,
    SECURITY_PROCESS_PROTECTION_TYPE_NONE_RID          = 0x00000000,
    SECURITY_PROCESS_PROTECTION_LEVEL_WINTCB_RID       = 0x00002000,
    SECURITY_PROCESS_PROTECTION_LEVEL_WINDOWS_RID      = 0x00001000,
    SECURITY_PROCESS_PROTECTION_LEVEL_APP_RID          = 0x00000800,
    SECURITY_PROCESS_PROTECTION_LEVEL_ANTIMALWARE_RID  = 0x00000600,
    SECURITY_PROCESS_PROTECTION_LEVEL_AUTHENTICODE_RID = 0x00000400,
    SECURITY_PROCESS_PROTECTION_LEVEL_NONE_RID         = 0x00000000,
}

enum : uint
{
    SECURITY_TRUSTED_INSTALLER_RID2 = 0xcbc28419,
    SECURITY_TRUSTED_INSTALLER_RID3 = 0x6d236c5c,
    SECURITY_TRUSTED_INSTALLER_RID4 = 0x6e770057,
    SECURITY_TRUSTED_INSTALLER_RID5 = 0x876402c0,
}

enum : int
{
    SE_GROUP_ENABLED_BY_DEFAULT = 0x00000002,
    SE_GROUP_ENABLED            = 0x00000004,
    SE_GROUP_OWNER              = 0x00000008,
    SE_GROUP_USE_FOR_DENY_ONLY  = 0x00000010,
}

enum int SE_GROUP_INTEGRITY_ENABLED = 0x00000040;
enum int SE_GROUP_RESOURCE = 0x20000000;

enum : uint
{
    ACL_REVISION2 = 0x00000002,
    ACL_REVISION3 = 0x00000003,
    ACL_REVISION4 = 0x00000004,
}

enum uint ACCESS_MIN_MS_ACE_TYPE = 0x00000000;
enum uint ACCESS_DENIED_ACE_TYPE = 0x00000001;
enum uint SYSTEM_ALARM_ACE_TYPE = 0x00000003;
enum uint ACCESS_ALLOWED_COMPOUND_ACE_TYPE = 0x00000004;
enum uint ACCESS_MIN_MS_OBJECT_ACE_TYPE = 0x00000005;
enum uint ACCESS_DENIED_OBJECT_ACE_TYPE = 0x00000006;
enum uint SYSTEM_ALARM_OBJECT_ACE_TYPE = 0x00000008;

enum : uint
{
    ACCESS_MAX_MS_V4_ACE_TYPE = 0x00000008,
    ACCESS_MAX_MS_ACE_TYPE    = 0x00000008,
}

enum uint ACCESS_DENIED_CALLBACK_ACE_TYPE = 0x0000000a;
enum uint ACCESS_DENIED_CALLBACK_OBJECT_ACE_TYPE = 0x0000000c;
enum uint SYSTEM_ALARM_CALLBACK_ACE_TYPE = 0x0000000e;
enum uint SYSTEM_ALARM_CALLBACK_OBJECT_ACE_TYPE = 0x00000010;
enum uint SYSTEM_RESOURCE_ATTRIBUTE_ACE_TYPE = 0x00000012;
enum uint SYSTEM_PROCESS_TRUST_LABEL_ACE_TYPE = 0x00000014;
enum uint ACCESS_MAX_MS_V5_ACE_TYPE = 0x00000015;
enum uint CRITICAL_ACE_FLAG = 0x00000020;

enum : uint
{
    SYSTEM_MANDATORY_LABEL_NO_WRITE_UP   = 0x00000001,
    SYSTEM_MANDATORY_LABEL_NO_READ_UP    = 0x00000002,
    SYSTEM_MANDATORY_LABEL_NO_EXECUTE_UP = 0x00000004,
}

enum uint SYSTEM_PROCESS_TRUST_NOCONSTRAINT_MASK = 0xffffffff;
enum uint SYSTEM_ACCESS_FILTER_NOCONSTRAINT_MASK = 0xffffffff;
enum uint SECURITY_DESCRIPTOR_REVISION1 = 0x00000001;

enum : uint
{
    ACCESS_PROPERTY_SET_GUID = 0x00000001,
    ACCESS_PROPERTY_GUID     = 0x00000002,
}

enum uint AUDIT_ALLOW_NO_PRIVILEGE = 0x00000001;

enum : const(wchar)*
{
    ACCESS_DS_SOURCE_W           = "DS",
    ACCESS_DS_OBJECT_TYPE_NAME_A = "Directory Service Object",
    ACCESS_DS_OBJECT_TYPE_NAME_W = "Directory Service Object",
}

enum : uint
{
    ACCESS_REASON_TYPE_MASK    = 0x00ff0000,
    ACCESS_REASON_DATA_MASK    = 0x0000ffff,
    ACCESS_REASON_STAGING_MASK = 0x80000000,
    ACCESS_REASON_EXDATA_MASK  = 0x7f000000,
}

enum : uint
{
    SE_SECURITY_DESCRIPTOR_FLAG_NO_LABEL_ACE         = 0x00000002,
    SE_SECURITY_DESCRIPTOR_FLAG_NO_ACCESS_FILTER_ACE = 0x00000004,
    SE_SECURITY_DESCRIPTOR_VALID_FLAGS               = 0x00000007,
}

enum uint SE_ACCESS_CHECK_VALID_FLAGS = 0x00000008;
enum const(wchar)* SE_CONSTRAINED_IMPERSONATION_CAPABILITY = "constrainedImpersonation";
enum const(wchar)* SE_MUMA_CAPABILITY = "muma";
enum const(wchar)* SE_LEARNING_MODE_LOGGING_CAPABILITY = "learningModeLogging";
enum const(wchar)* SE_APP_SILO_VOLUME_ROOT_MINIMAL_CAPABILITY = "isolatedWin32-volumeRootMinimal";
enum const(wchar)* SE_APP_SILO_USER_PROFILE_MINIMAL_CAPABILITY = "isolatedWin32-userProfileMinimal";
enum const(wchar)* SE_APP_SILO_ACCESS_TO_PUBLISHER_DIRECTORY_CAPABILITY = "isolatedWin32-accessToPublisherDirectory";
enum uint POLICY_AUDIT_SUBCATEGORY_COUNT = 0x0000003c;

enum : uint
{
    CLAIM_SECURITY_ATTRIBUTE_TYPE_INVALID            = 0x00000000,
    CLAIM_SECURITY_ATTRIBUTE_CUSTOM_FLAGS            = 0xffff0000,
    CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1 = 0x00000001,
    CLAIM_SECURITY_ATTRIBUTES_INFORMATION_VERSION    = 0x00000001,
}

enum int ACCESS_FILTER_SECURITY_INFORMATION = 0x00000100;

enum : uint
{
    SE_SIGNING_LEVEL_UNSIGNED        = 0x00000001,
    SE_SIGNING_LEVEL_ENTERPRISE      = 0x00000002,
    SE_SIGNING_LEVEL_CUSTOM_1        = 0x00000003,
    SE_SIGNING_LEVEL_DEVELOPER       = 0x00000003,
    SE_SIGNING_LEVEL_AUTHENTICODE    = 0x00000004,
    SE_SIGNING_LEVEL_CUSTOM_2        = 0x00000005,
    SE_SIGNING_LEVEL_STORE           = 0x00000006,
    SE_SIGNING_LEVEL_CUSTOM_3        = 0x00000007,
    SE_SIGNING_LEVEL_ANTIMALWARE     = 0x00000007,
    SE_SIGNING_LEVEL_MICROSOFT       = 0x00000008,
    SE_SIGNING_LEVEL_CUSTOM_4        = 0x00000009,
    SE_SIGNING_LEVEL_CUSTOM_5        = 0x0000000a,
    SE_SIGNING_LEVEL_DYNAMIC_CODEGEN = 0x0000000b,
    SE_SIGNING_LEVEL_WINDOWS         = 0x0000000c,
    SE_SIGNING_LEVEL_CUSTOM_7        = 0x0000000d,
    SE_SIGNING_LEVEL_WINDOWS_TCB     = 0x0000000e,
    SE_SIGNING_LEVEL_CUSTOM_6        = 0x0000000f,
}

enum : uint
{
    JOB_OBJECT_SET_ATTRIBUTES          = 0x00000002,
    JOB_OBJECT_QUERY                   = 0x00000004,
    JOB_OBJECT_TERMINATE               = 0x00000008,
    JOB_OBJECT_SET_SECURITY_ATTRIBUTES = 0x00000010,
}

enum uint FLS_MAXIMUM_AVAILABLE = 0x00000ff0;
enum uint THREAD_DYNAMIC_CODE_ALLOW = 0x00000001;
enum uint THREAD_BASE_PRIORITY_MAX = 0x00000002;
enum int THREAD_BASE_PRIORITY_IDLE = 0xfffffff1;
enum uint COMPONENT_VALID_FLAGS = 0x00000001;

enum : uint
{
    DYNAMIC_EH_CONTINUATION_TARGET_ADD       = 0x00000001,
    DYNAMIC_EH_CONTINUATION_TARGET_PROCESSED = 0x00000002,
}

enum uint DYNAMIC_ENFORCED_ADDRESS_RANGE_PROCESSED = 0x00000002;
enum uint MAX_HW_COUNTERS = 0x00000010;
enum uint JOB_OBJECT_NET_RATE_CONTROL_MAX_DSCP_TAG = 0x00000040;

enum : uint
{
    JOB_OBJECT_MSG_END_OF_PROCESS_TIME             = 0x00000002,
    JOB_OBJECT_MSG_ACTIVE_PROCESS_LIMIT            = 0x00000003,
    JOB_OBJECT_MSG_ACTIVE_PROCESS_ZERO             = 0x00000004,
    JOB_OBJECT_MSG_NEW_PROCESS                     = 0x00000006,
    JOB_OBJECT_MSG_EXIT_PROCESS                    = 0x00000007,
    JOB_OBJECT_MSG_ABNORMAL_EXIT_PROCESS           = 0x00000008,
    JOB_OBJECT_MSG_PROCESS_MEMORY_LIMIT            = 0x00000009,
    JOB_OBJECT_MSG_JOB_MEMORY_LIMIT                = 0x0000000a,
    JOB_OBJECT_MSG_NOTIFICATION_LIMIT              = 0x0000000b,
    JOB_OBJECT_MSG_JOB_CYCLE_TIME_LIMIT            = 0x0000000c,
    JOB_OBJECT_MSG_SILO_TERMINATED                 = 0x0000000d,
    JOB_OBJECT_MSG_MINIMUM                         = 0x00000001,
    JOB_OBJECT_MSG_MAXIMUM                         = 0x0000000d,
    JOB_OBJECT_UILIMIT_IME                         = 0x00000100,
    JOB_OBJECT_UILIMIT_INJECTION                   = 0x00000200,
    JOB_OBJECT_UILIMIT_ALL                         = 0x000003ff,
    JOB_OBJECT_UI_VALID_FLAGS                      = 0x000003ff,
    JOB_OBJECT_CPU_RATE_CONTROL_PER_PROCESSOR_CAPS = 0x00000020,
}

enum uint MEMORY_PARTITION_MODIFY_ACCESS = 0x00000002;

enum : uint
{
    TIME_ZONE_ID_UNKNOWN  = 0x00000000,
    TIME_ZONE_ID_STANDARD = 0x00000001,
    TIME_ZONE_ID_DAYLIGHT = 0x00000002,
}

enum uint CACHE_FULLY_ASSOCIATIVE = 0x000000ff;

enum : uint
{
    PROCESSOR_INTEL_486     = 0x000001e6,
    PROCESSOR_INTEL_PENTIUM = 0x0000024a,
    PROCESSOR_INTEL_IA64    = 0x00000898,
    PROCESSOR_AMD_X8664     = 0x000021d8,
    PROCESSOR_MIPS_R4000    = 0x00000fa0,
    PROCESSOR_ALPHA_21064   = 0x00005248,
    PROCESSOR_PPC_601       = 0x00000259,
    PROCESSOR_PPC_603       = 0x0000025b,
    PROCESSOR_PPC_604       = 0x0000025c,
    PROCESSOR_PPC_620       = 0x0000026c,
    PROCESSOR_HITACHI_SH3   = 0x00002713,
    PROCESSOR_HITACHI_SH3E  = 0x00002714,
    PROCESSOR_HITACHI_SH4   = 0x00002715,
    PROCESSOR_MOTOROLA_821  = 0x00000335,
    PROCESSOR_SHx_SH3       = 0x00000067,
    PROCESSOR_SHx_SH4       = 0x00000068,
    PROCESSOR_STRONGARM     = 0x00000a11,
    PROCESSOR_ARM720        = 0x00000720,
    PROCESSOR_ARM820        = 0x00000820,
    PROCESSOR_ARM920        = 0x00000920,
    PROCESSOR_ARM_7TDMI     = 0x00011171,
    PROCESSOR_OPTIL         = 0x0000494f,
}

enum : uint
{
    XSTATE_LEGACY_SSE      = 0x00000001,
    XSTATE_GSSE            = 0x00000002,
    XSTATE_AVX             = 0x00000002,
    XSTATE_MPX_BNDREGS     = 0x00000003,
    XSTATE_MPX_BNDCSR      = 0x00000004,
    XSTATE_AVX512_KMASK    = 0x00000005,
    XSTATE_AVX512_ZMM_H    = 0x00000006,
    XSTATE_AVX512_ZMM      = 0x00000007,
    XSTATE_IPT             = 0x00000008,
    XSTATE_PASID           = 0x0000000a,
    XSTATE_CET_U           = 0x0000000b,
    XSTATE_CET_S           = 0x0000000c,
    XSTATE_AMX_TILE_CONFIG = 0x00000011,
    XSTATE_AMX_TILE_DATA   = 0x00000012,
}

enum uint MAXIMUM_XSTATE_FEATURES = 0x00000040;
enum uint XSTATE_FIRST_NON_LEGACY_FEATURE = 0x00000002;

enum : uint
{
    XSTATE_ALIGN_BIT                 = 0x00000001,
    XSTATE_XFD_BIT                   = 0x00000002,
    XSTATE_CONTROLFLAG_XSAVEOPT_MASK = 0x00000001,
    XSTATE_CONTROLFLAG_XSAVEC_MASK   = 0x00000002,
    XSTATE_CONTROLFLAG_XFD_MASK      = 0x00000004,
}

enum uint RUNTIME_REPORT_PACKAGE_VERSION_CURRENT = 0x00000001;

enum : uint
{
    RUNTIME_REPORT_DIGEST_MAX_SIZE                        = 0x00000040,
    RUNTIME_REPORT_SIGNATURE_SCHEME_SHA512_RSA_PSS_SHA512 = 0x00000001,
}

enum uint DRIVER_REPORT_NAME_MAX_LENGTH = 0x00000020;

enum : uint
{
    CFG_CALL_TARGET_PROCESSED                          = 0x00000002,
    CFG_CALL_TARGET_CONVERT_EXPORT_SUPPRESSED_TO_VALID = 0x00000004,
}

enum uint CFG_CALL_TARGET_CONVERT_XFG_TO_CFG = 0x00000010;
enum uint SESSION_MODIFY_ACCESS = 0x00000002;
enum uint MEM_WRITE_WATCH = 0x00200000;
enum uint MEM_ROTATE = 0x00800000;
enum uint MEM_4MB_PAGES = 0x80000000;

enum : uint
{
    MEM_EXTENDED_PARAMETER_GRAPHICS            = 0x00000001,
    MEM_EXTENDED_PARAMETER_NONPAGED            = 0x00000002,
    MEM_EXTENDED_PARAMETER_ZERO_PAGES_OPTIONAL = 0x00000004,
    MEM_EXTENDED_PARAMETER_NONPAGED_LARGE      = 0x00000008,
    MEM_EXTENDED_PARAMETER_NONPAGED_HUGE       = 0x00000010,
    MEM_EXTENDED_PARAMETER_SOFT_FAULT_PAGES    = 0x00000020,
    MEM_EXTENDED_PARAMETER_EC_CODE             = 0x00000040,
    MEM_EXTENDED_PARAMETER_TYPE_BITS           = 0x00000008,
}

enum uint WRITE_WATCH_FLAG_RESET = 0x00000001;

enum : uint
{
    ENCLAVE_TYPE_SGX       = 0x00000001,
    ENCLAVE_TYPE_SGX2      = 0x00000002,
    ENCLAVE_TYPE_VBS       = 0x00000010,
    ENCLAVE_VBS_FLAG_DEBUG = 0x00000001,
}

enum : uint
{
    VBS_BASIC_PAGE_MEASURED_DATA     = 0x00000001,
    VBS_BASIC_PAGE_UNMEASURED_DATA   = 0x00000002,
    VBS_BASIC_PAGE_ZERO_FILL         = 0x00000003,
    VBS_BASIC_PAGE_THREAD_DESCRIPTOR = 0x00000004,
    VBS_BASIC_PAGE_SYSTEM_CALL       = 0x00000005,
}

enum : uint
{
    TREE_CONNECT_ATTRIBUTE_PRIVACY   = 0x00004000,
    TREE_CONNECT_ATTRIBUTE_INTEGRITY = 0x00008000,
    TREE_CONNECT_ATTRIBUTE_GLOBAL    = 0x00000004,
    TREE_CONNECT_ATTRIBUTE_PINNED    = 0x00000002,
}

enum : uint
{
    MAILSLOT_NO_MESSAGE   = 0xffffffff,
    MAILSLOT_WAIT_FOREVER = 0xffffffff,
}

enum uint FILE_CASE_PRESERVED_NAMES = 0x00000002;
enum uint FILE_PERSISTENT_ACLS = 0x00000008;
enum uint FILE_VOLUME_QUOTAS = 0x00000020;

enum : uint
{
    FILE_SUPPORTS_REPARSE_POINTS = 0x00000080,
    FILE_SUPPORTS_REMOTE_STORAGE = 0x00000100,
}

enum : uint
{
    FILE_SUPPORTS_POSIX_UNLINK_RENAME = 0x00000400,
    FILE_SUPPORTS_BYPASS_IO           = 0x00000800,
    FILE_SUPPORTS_STREAM_SNAPSHOTS    = 0x00001000,
    FILE_SUPPORTS_CASE_SENSITIVE_DIRS = 0x00002000,
}

enum : uint
{
    FILE_SUPPORTS_OBJECT_IDS = 0x00010000,
    FILE_SUPPORTS_ENCRYPTION = 0x00020000,
}

enum uint FILE_READ_ONLY_VOLUME = 0x00080000;

enum : uint
{
    FILE_SUPPORTS_TRANSACTIONS        = 0x00200000,
    FILE_SUPPORTS_HARD_LINKS          = 0x00400000,
    FILE_SUPPORTS_EXTENDED_ATTRIBUTES = 0x00800000,
    FILE_SUPPORTS_OPEN_BY_FILE_ID     = 0x01000000,
    FILE_SUPPORTS_USN_JOURNAL         = 0x02000000,
    FILE_SUPPORTS_INTEGRITY_STREAMS   = 0x04000000,
    FILE_SUPPORTS_BLOCK_REFCOUNTING   = 0x08000000,
    FILE_SUPPORTS_SPARSE_VDL          = 0x10000000,
}

enum uint FILE_SUPPORTS_GHOSTING = 0x40000000;

enum : uint
{
    FILE_NAME_FLAG_NTFS         = 0x00000001,
    FILE_NAME_FLAG_DOS          = 0x00000002,
    FILE_NAME_FLAG_BOTH         = 0x00000003,
    FILE_NAME_FLAGS_UNSPECIFIED = 0x00000080,
}

enum : uint
{
    LX_FILE_METADATA_HAS_GID       = 0x00000002,
    LX_FILE_METADATA_HAS_MODE      = 0x00000004,
    LX_FILE_METADATA_HAS_DEVICE_ID = 0x00000008,
}

enum uint FILE_CS_FLAG_CASE_SENSITIVE_DIR = 0x00000001;

enum : uint
{
    FLUSH_FLAGS_NO_SYNC             = 0x00000002,
    FLUSH_FLAGS_FILE_DATA_SYNC_ONLY = 0x00000004,
    FLUSH_FLAGS_FLUSH_AND_PURGE     = 0x00000008,
}

enum : uint
{
    IO_REPARSE_TAG_RESERVED_ONE   = 0x00000001,
    IO_REPARSE_TAG_RESERVED_TWO   = 0x00000002,
    IO_REPARSE_TAG_RESERVED_RANGE = 0x00000002,
}

enum : uint
{
    IO_REPARSE_TAG_MOUNT_POINT      = 0xa0000003,
    IO_REPARSE_TAG_HSM              = 0xc0000004,
    IO_REPARSE_TAG_HSM2             = 0x80000006,
    IO_REPARSE_TAG_SIS              = 0x80000007,
    IO_REPARSE_TAG_WIM              = 0x80000008,
    IO_REPARSE_TAG_CSV              = 0x80000009,
    IO_REPARSE_TAG_DFS              = 0x8000000a,
    IO_REPARSE_TAG_SYMLINK          = 0xa000000c,
    IO_REPARSE_TAG_DFSR             = 0x80000012,
    IO_REPARSE_TAG_DEDUP            = 0x80000013,
    IO_REPARSE_TAG_NFS              = 0x80000014,
    IO_REPARSE_TAG_FILE_PLACEHOLDER = 0x80000015,
    IO_REPARSE_TAG_WOF              = 0x80000017,
    IO_REPARSE_TAG_WCI              = 0x80000018,
    IO_REPARSE_TAG_WCI_1            = 0x90001018,
    IO_REPARSE_TAG_GLOBAL_REPARSE   = 0xa0000019,
    IO_REPARSE_TAG_CLOUD            = 0x9000001a,
    IO_REPARSE_TAG_CLOUD_1          = 0x9000101a,
    IO_REPARSE_TAG_CLOUD_2          = 0x9000201a,
    IO_REPARSE_TAG_CLOUD_3          = 0x9000301a,
    IO_REPARSE_TAG_CLOUD_4          = 0x9000401a,
    IO_REPARSE_TAG_CLOUD_5          = 0x9000501a,
    IO_REPARSE_TAG_CLOUD_6          = 0x9000601a,
    IO_REPARSE_TAG_CLOUD_7          = 0x9000701a,
    IO_REPARSE_TAG_CLOUD_8          = 0x9000801a,
    IO_REPARSE_TAG_CLOUD_9          = 0x9000901a,
    IO_REPARSE_TAG_CLOUD_A          = 0x9000a01a,
    IO_REPARSE_TAG_CLOUD_B          = 0x9000b01a,
    IO_REPARSE_TAG_CLOUD_C          = 0x9000c01a,
    IO_REPARSE_TAG_CLOUD_D          = 0x9000d01a,
    IO_REPARSE_TAG_CLOUD_E          = 0x9000e01a,
    IO_REPARSE_TAG_CLOUD_F          = 0x9000f01a,
    IO_REPARSE_TAG_CLOUD_MASK       = 0x0000f000,
    IO_REPARSE_TAG_APPEXECLINK      = 0x8000001b,
    IO_REPARSE_TAG_PROJFS           = 0x9000001c,
    IO_REPARSE_TAG_STORAGE_SYNC     = 0x8000001e,
    IO_REPARSE_TAG_WCI_TOMBSTONE    = 0xa000001f,
    IO_REPARSE_TAG_UNHANDLED        = 0x80000020,
    IO_REPARSE_TAG_ONEDRIVE         = 0x80000021,
    IO_REPARSE_TAG_PROJFS_TOMBSTONE = 0xa0000022,
    IO_REPARSE_TAG_AF_UNIX          = 0x80000023,
}

enum : uint
{
    IO_REPARSE_TAG_WCI_LINK     = 0xa0000027,
    IO_REPARSE_TAG_WCI_LINK_1   = 0xa0001027,
    IO_REPARSE_TAG_DATALESS_CIM = 0xa0000028,
}

enum : uint
{
    SCRUB_DATA_INPUT_FLAG_SKIP_IN_SYNC            = 0x00000002,
    SCRUB_DATA_INPUT_FLAG_SKIP_NON_INTEGRITY_DATA = 0x00000004,
    SCRUB_DATA_INPUT_FLAG_IGNORE_REDUNDANCY       = 0x00000008,
    SCRUB_DATA_INPUT_FLAG_SKIP_DATA               = 0x00000010,
    SCRUB_DATA_INPUT_FLAG_SCRUB_BY_OBJECT_ID      = 0x00000020,
    SCRUB_DATA_INPUT_FLAG_OPLOCK_NOT_ACQUIRED     = 0x00000040,
}

enum : uint
{
    SCRUB_DATA_OUTPUT_FLAG_NON_USER_DATA_RANGE             = 0x00010000,
    SCRUB_DATA_OUTPUT_FLAG_PARITY_EXTENT_DATA_RETURNED     = 0x00020000,
    SCRUB_DATA_OUTPUT_FLAG_RESUME_CONTEXT_LENGTH_SPECIFIED = 0x00040000,
}

enum uint IO_COMPLETION_MODIFY_STATE = 0x00000002;
enum uint NETWORK_APP_INSTANCE_CSV_FLAGS_VALID_ONLY_IF_CSV_COORDINATOR = 0x00000001;

enum : uint
{
    POWERBUTTON_ACTION_INDEX_SLEEP                = 0x00000001,
    POWERBUTTON_ACTION_INDEX_HIBERNATE            = 0x00000002,
    POWERBUTTON_ACTION_INDEX_SHUTDOWN             = 0x00000003,
    POWERBUTTON_ACTION_INDEX_TURN_OFF_THE_DISPLAY = 0x00000004,
    POWERBUTTON_ACTION_VALUE_NOTHING              = 0x00000000,
    POWERBUTTON_ACTION_VALUE_SLEEP                = 0x00000002,
    POWERBUTTON_ACTION_VALUE_HIBERNATE            = 0x00000003,
    POWERBUTTON_ACTION_VALUE_SHUTDOWN             = 0x00000006,
    POWERBUTTON_ACTION_VALUE_TURN_OFF_THE_DISPLAY = 0x00000008,
}

enum : uint
{
    PERFSTATE_POLICY_CHANGE_SINGLE           = 0x00000001,
    PERFSTATE_POLICY_CHANGE_ROCKET           = 0x00000002,
    PERFSTATE_POLICY_CHANGE_IDEAL_AGGRESSIVE = 0x00000003,
    PERFSTATE_POLICY_CHANGE_DECREASE_MAX     = 0x00000002,
    PERFSTATE_POLICY_CHANGE_INCREASE_MAX     = 0x00000003,
}

enum : uint
{
    PROCESSOR_THROTTLE_ENABLED   = 0x00000001,
    PROCESSOR_THROTTLE_AUTOMATIC = 0x00000002,
}

enum : uint
{
    PROCESSOR_PERF_BOOST_POLICY_MAX                              = 0x00000064,
    PROCESSOR_PERF_BOOST_MODE_DISABLED                           = 0x00000000,
    PROCESSOR_PERF_BOOST_MODE_ENABLED                            = 0x00000001,
    PROCESSOR_PERF_BOOST_MODE_AGGRESSIVE                         = 0x00000002,
    PROCESSOR_PERF_BOOST_MODE_EFFICIENT_ENABLED                  = 0x00000003,
    PROCESSOR_PERF_BOOST_MODE_EFFICIENT_AGGRESSIVE               = 0x00000004,
    PROCESSOR_PERF_BOOST_MODE_AGGRESSIVE_AT_GUARANTEED           = 0x00000005,
    PROCESSOR_PERF_BOOST_MODE_EFFICIENT_AGGRESSIVE_AT_GUARANTEED = 0x00000006,
    PROCESSOR_PERF_BOOST_MODE_MAX                                = 0x00000006,
    PROCESSOR_PERF_AUTONOMOUS_MODE_DISABLED                      = 0x00000000,
    PROCESSOR_PERF_AUTONOMOUS_MODE_ENABLED                       = 0x00000001,
}

enum : uint
{
    PROCESSOR_PERF_ENERGY_PREFERENCE       = 0x00000000,
    PROCESSOR_PERF_MINIMUM_ACTIVITY_WINDOW = 0x00000000,
    PROCESSOR_PERF_MAXIMUM_ACTIVITY_WINDOW = 0x4bb2a980,
}

enum uint PROCESSOR_DUTY_CYCLING_ENABLED = 0x00000001;

enum : uint
{
    CORE_PARKING_POLICY_CHANGE_SINGLE    = 0x00000001,
    CORE_PARKING_POLICY_CHANGE_ROCKET    = 0x00000002,
    CORE_PARKING_POLICY_CHANGE_MULTISTEP = 0x00000003,
    CORE_PARKING_POLICY_CHANGE_MAX       = 0x00000003,
}

enum : uint
{
    PARKING_TOPOLOGY_POLICY_ROUNDROBIN = 0x00000001,
    PARKING_TOPOLOGY_POLICY_SEQUENTIAL = 0x00000002,
}

enum : uint
{
    SMT_UNPARKING_POLICY_CORE_PER_THREAD = 0x00000001,
    SMT_UNPARKING_POLICY_LP_ROUNDROBIN   = 0x00000002,
    SMT_UNPARKING_POLICY_LP_SEQUENTIAL   = 0x00000003,
}

enum uint POWER_DEVICE_IDLE_POLICY_CONSERVATIVE = 0x00000001;

enum : uint
{
    POWER_CONNECTIVITY_IN_STANDBY_ENABLED        = 0x00000001,
    POWER_CONNECTIVITY_IN_STANDBY_SYSTEM_MANAGED = 0x00000002,
}

enum uint POWER_DISCONNECTED_STANDBY_MODE_AGGRESSIVE = 0x00000001;

enum : uint
{
    DIAGNOSTIC_REASON_VERSION         = 0x00000000,
    DIAGNOSTIC_REASON_SIMPLE_STRING   = 0x00000001,
    DIAGNOSTIC_REASON_DETAILED_STRING = 0x00000002,
    DIAGNOSTIC_REASON_NOT_SPECIFIED   = 0x80000000,
}

enum uint POWER_SETTING_VALUE_VERSION = 0x00000001;
enum uint PROC_IDLE_BUCKET_COUNT_EX = 0x00000010;

enum : uint
{
    ACPI_PPM_SOFTWARE_ANY = 0x000000fd,
    ACPI_PPM_HARDWARE_ALL = 0x000000fe,
}

enum : uint
{
    POWER_ACTION_QUERY_ALLOWED     = 0x00000001,
    POWER_ACTION_UI_ALLOWED        = 0x00000002,
    POWER_ACTION_OVERRIDE_APPS     = 0x00000004,
    POWER_ACTION_HIBERBOOT         = 0x00000008,
    POWER_ACTION_USER_NOTIFY       = 0x00000010,
    POWER_ACTION_DOZE_TO_HIBERNATE = 0x00000020,
    POWER_ACTION_ACPI_CRITICAL     = 0x01000000,
    POWER_ACTION_ACPI_USER_NOTIFY  = 0x02000000,
    POWER_ACTION_DIRECTED_DRIPS    = 0x04000000,
    POWER_ACTION_PSEUDO_TRANSITION = 0x08000000,
    POWER_ACTION_LIGHTEST_FIRST    = 0x10000000,
    POWER_ACTION_LOCK_CONSOLE      = 0x20000000,
    POWER_ACTION_DISABLE_WAKES     = 0x40000000,
    POWER_ACTION_CRITICAL          = 0x80000000,
}

enum : uint
{
    BATTERY_DISCHARGE_FLAGS_EVENTCODE_MASK = 0x00000007,
    BATTERY_DISCHARGE_FLAGS_ENABLE         = 0x80000000,
}

enum : uint
{
    DISCHARGE_POLICY_CRITICAL = 0x00000000,
    DISCHARGE_POLICY_LOW      = 0x00000001,
}

enum : uint
{
    PO_THROTTLE_NONE     = 0x00000000,
    PO_THROTTLE_CONSTANT = 0x00000001,
    PO_THROTTLE_DEGRADE  = 0x00000002,
    PO_THROTTLE_ADAPTIVE = 0x00000003,
    PO_THROTTLE_MAXIMUM  = 0x00000004,
}

enum : uint
{
    HIBERFILE_TYPE_REDUCED = 0x00000001,
    HIBERFILE_TYPE_FULL    = 0x00000002,
    HIBERFILE_TYPE_MAX     = 0x00000003,
}

enum : ushort
{
    IMAGE_OS2_SIGNATURE    = cast(ushort)0x454e,
    IMAGE_OS2_SIGNATURE_LE = cast(ushort)0x454c,
}

enum uint IMAGE_NT_SIGNATURE = 0x00004550;
enum uint IMAGE_NUMBEROF_DIRECTORY_ENTRIES = 0x00000010;

enum : uint
{
    IMAGE_SIZEOF_SECTION_HEADER = 0x00000028,
    IMAGE_SIZEOF_SYMBOL         = 0x00000012,
}

enum : uint
{
    IMAGE_SYM_SECTION_MAX_EX         = 0x7fffffff,
    IMAGE_SYM_TYPE_NULL              = 0x00000000,
    IMAGE_SYM_TYPE_VOID              = 0x00000001,
    IMAGE_SYM_TYPE_CHAR              = 0x00000002,
    IMAGE_SYM_TYPE_SHORT             = 0x00000003,
    IMAGE_SYM_TYPE_INT               = 0x00000004,
    IMAGE_SYM_TYPE_LONG              = 0x00000005,
    IMAGE_SYM_TYPE_FLOAT             = 0x00000006,
    IMAGE_SYM_TYPE_DOUBLE            = 0x00000007,
    IMAGE_SYM_TYPE_STRUCT            = 0x00000008,
    IMAGE_SYM_TYPE_UNION             = 0x00000009,
    IMAGE_SYM_TYPE_ENUM              = 0x0000000a,
    IMAGE_SYM_TYPE_MOE               = 0x0000000b,
    IMAGE_SYM_TYPE_BYTE              = 0x0000000c,
    IMAGE_SYM_TYPE_WORD              = 0x0000000d,
    IMAGE_SYM_TYPE_UINT              = 0x0000000e,
    IMAGE_SYM_TYPE_DWORD             = 0x0000000f,
    IMAGE_SYM_TYPE_PCODE             = 0x00008000,
    IMAGE_SYM_DTYPE_NULL             = 0x00000000,
    IMAGE_SYM_DTYPE_POINTER          = 0x00000001,
    IMAGE_SYM_DTYPE_FUNCTION         = 0x00000002,
    IMAGE_SYM_DTYPE_ARRAY            = 0x00000003,
    IMAGE_SYM_CLASS_NULL             = 0x00000000,
    IMAGE_SYM_CLASS_AUTOMATIC        = 0x00000001,
    IMAGE_SYM_CLASS_EXTERNAL         = 0x00000002,
    IMAGE_SYM_CLASS_STATIC           = 0x00000003,
    IMAGE_SYM_CLASS_REGISTER         = 0x00000004,
    IMAGE_SYM_CLASS_EXTERNAL_DEF     = 0x00000005,
    IMAGE_SYM_CLASS_LABEL            = 0x00000006,
    IMAGE_SYM_CLASS_UNDEFINED_LABEL  = 0x00000007,
    IMAGE_SYM_CLASS_MEMBER_OF_STRUCT = 0x00000008,
    IMAGE_SYM_CLASS_ARGUMENT         = 0x00000009,
    IMAGE_SYM_CLASS_STRUCT_TAG       = 0x0000000a,
    IMAGE_SYM_CLASS_MEMBER_OF_UNION  = 0x0000000b,
    IMAGE_SYM_CLASS_UNION_TAG        = 0x0000000c,
    IMAGE_SYM_CLASS_TYPE_DEFINITION  = 0x0000000d,
    IMAGE_SYM_CLASS_UNDEFINED_STATIC = 0x0000000e,
    IMAGE_SYM_CLASS_ENUM_TAG         = 0x0000000f,
    IMAGE_SYM_CLASS_MEMBER_OF_ENUM   = 0x00000010,
    IMAGE_SYM_CLASS_REGISTER_PARAM   = 0x00000011,
    IMAGE_SYM_CLASS_BIT_FIELD        = 0x00000012,
    IMAGE_SYM_CLASS_FAR_EXTERNAL     = 0x00000044,
    IMAGE_SYM_CLASS_BLOCK            = 0x00000064,
    IMAGE_SYM_CLASS_FUNCTION         = 0x00000065,
    IMAGE_SYM_CLASS_END_OF_STRUCT    = 0x00000066,
    IMAGE_SYM_CLASS_FILE             = 0x00000067,
    IMAGE_SYM_CLASS_SECTION          = 0x00000068,
    IMAGE_SYM_CLASS_WEAK_EXTERNAL    = 0x00000069,
    IMAGE_SYM_CLASS_CLR_TOKEN        = 0x0000006b,
}

enum : uint
{
    N_TMASK  = 0x00000030,
    N_TMASK1 = 0x000000c0,
    N_TMASK2 = 0x000000f0,
}

enum uint N_TSHIFT = 0x00000002;

enum : uint
{
    IMAGE_COMDAT_SELECT_ANY         = 0x00000002,
    IMAGE_COMDAT_SELECT_SAME_SIZE   = 0x00000003,
    IMAGE_COMDAT_SELECT_EXACT_MATCH = 0x00000004,
    IMAGE_COMDAT_SELECT_ASSOCIATIVE = 0x00000005,
    IMAGE_COMDAT_SELECT_LARGEST     = 0x00000006,
    IMAGE_COMDAT_SELECT_NEWEST      = 0x00000007,
}

enum : uint
{
    IMAGE_WEAK_EXTERN_SEARCH_LIBRARY  = 0x00000002,
    IMAGE_WEAK_EXTERN_SEARCH_ALIAS    = 0x00000003,
    IMAGE_WEAK_EXTERN_ANTI_DEPENDENCY = 0x00000004,
}

enum : uint
{
    IMAGE_REL_I386_DIR16                       = 0x00000001,
    IMAGE_REL_I386_REL16                       = 0x00000002,
    IMAGE_REL_I386_DIR32                       = 0x00000006,
    IMAGE_REL_I386_DIR32NB                     = 0x00000007,
    IMAGE_REL_I386_SEG12                       = 0x00000009,
    IMAGE_REL_I386_SECTION                     = 0x0000000a,
    IMAGE_REL_I386_SECREL                      = 0x0000000b,
    IMAGE_REL_I386_TOKEN                       = 0x0000000c,
    IMAGE_REL_I386_SECREL7                     = 0x0000000d,
    IMAGE_REL_I386_REL32                       = 0x00000014,
    IMAGE_REL_MIPS_ABSOLUTE                    = 0x00000000,
    IMAGE_REL_MIPS_REFHALF                     = 0x00000001,
    IMAGE_REL_MIPS_REFWORD                     = 0x00000002,
    IMAGE_REL_MIPS_JMPADDR                     = 0x00000003,
    IMAGE_REL_MIPS_REFHI                       = 0x00000004,
    IMAGE_REL_MIPS_REFLO                       = 0x00000005,
    IMAGE_REL_MIPS_GPREL                       = 0x00000006,
    IMAGE_REL_MIPS_LITERAL                     = 0x00000007,
    IMAGE_REL_MIPS_SECTION                     = 0x0000000a,
    IMAGE_REL_MIPS_SECREL                      = 0x0000000b,
    IMAGE_REL_MIPS_SECRELLO                    = 0x0000000c,
    IMAGE_REL_MIPS_SECRELHI                    = 0x0000000d,
    IMAGE_REL_MIPS_TOKEN                       = 0x0000000e,
    IMAGE_REL_MIPS_JMPADDR16                   = 0x00000010,
    IMAGE_REL_MIPS_REFWORDNB                   = 0x00000022,
    IMAGE_REL_MIPS_PAIR                        = 0x00000025,
    IMAGE_REL_ALPHA_ABSOLUTE                   = 0x00000000,
    IMAGE_REL_ALPHA_REFLONG                    = 0x00000001,
    IMAGE_REL_ALPHA_REFQUAD                    = 0x00000002,
    IMAGE_REL_ALPHA_GPREL32                    = 0x00000003,
    IMAGE_REL_ALPHA_LITERAL                    = 0x00000004,
    IMAGE_REL_ALPHA_LITUSE                     = 0x00000005,
    IMAGE_REL_ALPHA_GPDISP                     = 0x00000006,
    IMAGE_REL_ALPHA_BRADDR                     = 0x00000007,
    IMAGE_REL_ALPHA_HINT                       = 0x00000008,
    IMAGE_REL_ALPHA_INLINE_REFLONG             = 0x00000009,
    IMAGE_REL_ALPHA_REFHI                      = 0x0000000a,
    IMAGE_REL_ALPHA_REFLO                      = 0x0000000b,
    IMAGE_REL_ALPHA_PAIR                       = 0x0000000c,
    IMAGE_REL_ALPHA_MATCH                      = 0x0000000d,
    IMAGE_REL_ALPHA_SECTION                    = 0x0000000e,
    IMAGE_REL_ALPHA_SECREL                     = 0x0000000f,
    IMAGE_REL_ALPHA_REFLONGNB                  = 0x00000010,
    IMAGE_REL_ALPHA_SECRELLO                   = 0x00000011,
    IMAGE_REL_ALPHA_SECRELHI                   = 0x00000012,
    IMAGE_REL_ALPHA_REFQ3                      = 0x00000013,
    IMAGE_REL_ALPHA_REFQ2                      = 0x00000014,
    IMAGE_REL_ALPHA_REFQ1                      = 0x00000015,
    IMAGE_REL_ALPHA_GPRELLO                    = 0x00000016,
    IMAGE_REL_ALPHA_GPRELHI                    = 0x00000017,
    IMAGE_REL_PPC_ABSOLUTE                     = 0x00000000,
    IMAGE_REL_PPC_ADDR64                       = 0x00000001,
    IMAGE_REL_PPC_ADDR32                       = 0x00000002,
    IMAGE_REL_PPC_ADDR24                       = 0x00000003,
    IMAGE_REL_PPC_ADDR16                       = 0x00000004,
    IMAGE_REL_PPC_ADDR14                       = 0x00000005,
    IMAGE_REL_PPC_REL24                        = 0x00000006,
    IMAGE_REL_PPC_REL14                        = 0x00000007,
    IMAGE_REL_PPC_TOCREL16                     = 0x00000008,
    IMAGE_REL_PPC_TOCREL14                     = 0x00000009,
    IMAGE_REL_PPC_ADDR32NB                     = 0x0000000a,
    IMAGE_REL_PPC_SECREL                       = 0x0000000b,
    IMAGE_REL_PPC_SECTION                      = 0x0000000c,
    IMAGE_REL_PPC_IFGLUE                       = 0x0000000d,
    IMAGE_REL_PPC_IMGLUE                       = 0x0000000e,
    IMAGE_REL_PPC_SECREL16                     = 0x0000000f,
    IMAGE_REL_PPC_REFHI                        = 0x00000010,
    IMAGE_REL_PPC_REFLO                        = 0x00000011,
    IMAGE_REL_PPC_PAIR                         = 0x00000012,
    IMAGE_REL_PPC_SECRELLO                     = 0x00000013,
    IMAGE_REL_PPC_SECRELHI                     = 0x00000014,
    IMAGE_REL_PPC_GPREL                        = 0x00000015,
    IMAGE_REL_PPC_TOKEN                        = 0x00000016,
    IMAGE_REL_PPC_TYPEMASK                     = 0x000000ff,
    IMAGE_REL_PPC_NEG                          = 0x00000100,
    IMAGE_REL_PPC_BRTAKEN                      = 0x00000200,
    IMAGE_REL_PPC_BRNTAKEN                     = 0x00000400,
    IMAGE_REL_PPC_TOCDEFN                      = 0x00000800,
    IMAGE_REL_SH3_ABSOLUTE                     = 0x00000000,
    IMAGE_REL_SH3_DIRECT16                     = 0x00000001,
    IMAGE_REL_SH3_DIRECT32                     = 0x00000002,
    IMAGE_REL_SH3_DIRECT8                      = 0x00000003,
    IMAGE_REL_SH3_DIRECT8_WORD                 = 0x00000004,
    IMAGE_REL_SH3_DIRECT8_LONG                 = 0x00000005,
    IMAGE_REL_SH3_DIRECT4                      = 0x00000006,
    IMAGE_REL_SH3_DIRECT4_WORD                 = 0x00000007,
    IMAGE_REL_SH3_DIRECT4_LONG                 = 0x00000008,
    IMAGE_REL_SH3_PCREL8_WORD                  = 0x00000009,
    IMAGE_REL_SH3_PCREL8_LONG                  = 0x0000000a,
    IMAGE_REL_SH3_PCREL12_WORD                 = 0x0000000b,
    IMAGE_REL_SH3_STARTOF_SECTION              = 0x0000000c,
    IMAGE_REL_SH3_SIZEOF_SECTION               = 0x0000000d,
    IMAGE_REL_SH3_SECTION                      = 0x0000000e,
    IMAGE_REL_SH3_SECREL                       = 0x0000000f,
    IMAGE_REL_SH3_DIRECT32_NB                  = 0x00000010,
    IMAGE_REL_SH3_GPREL4_LONG                  = 0x00000011,
    IMAGE_REL_SH3_TOKEN                        = 0x00000012,
    IMAGE_REL_SHM_PCRELPT                      = 0x00000013,
    IMAGE_REL_SHM_REFLO                        = 0x00000014,
    IMAGE_REL_SHM_REFHALF                      = 0x00000015,
    IMAGE_REL_SHM_RELLO                        = 0x00000016,
    IMAGE_REL_SHM_RELHALF                      = 0x00000017,
    IMAGE_REL_SHM_PAIR                         = 0x00000018,
    IMAGE_REL_SH_NOMODE                        = 0x00008000,
    IMAGE_REL_ARM_ABSOLUTE                     = 0x00000000,
    IMAGE_REL_ARM_ADDR32                       = 0x00000001,
    IMAGE_REL_ARM_ADDR32NB                     = 0x00000002,
    IMAGE_REL_ARM_BRANCH24                     = 0x00000003,
    IMAGE_REL_ARM_BRANCH11                     = 0x00000004,
    IMAGE_REL_ARM_TOKEN                        = 0x00000005,
    IMAGE_REL_ARM_GPREL12                      = 0x00000006,
    IMAGE_REL_ARM_GPREL7                       = 0x00000007,
    IMAGE_REL_ARM_BLX24                        = 0x00000008,
    IMAGE_REL_ARM_BLX11                        = 0x00000009,
    IMAGE_REL_ARM_SECTION                      = 0x0000000e,
    IMAGE_REL_ARM_SECREL                       = 0x0000000f,
    IMAGE_REL_ARM_MOV32A                       = 0x00000010,
    IMAGE_REL_ARM_MOV32                        = 0x00000010,
    IMAGE_REL_ARM_MOV32T                       = 0x00000011,
    IMAGE_REL_THUMB_MOV32                      = 0x00000011,
    IMAGE_REL_ARM_BRANCH20T                    = 0x00000012,
    IMAGE_REL_THUMB_BRANCH20                   = 0x00000012,
    IMAGE_REL_ARM_BRANCH24T                    = 0x00000014,
    IMAGE_REL_THUMB_BRANCH24                   = 0x00000014,
    IMAGE_REL_ARM_BLX23T                       = 0x00000015,
    IMAGE_REL_THUMB_BLX23                      = 0x00000015,
    IMAGE_REL_AM_ABSOLUTE                      = 0x00000000,
    IMAGE_REL_AM_ADDR32                        = 0x00000001,
    IMAGE_REL_AM_ADDR32NB                      = 0x00000002,
    IMAGE_REL_AM_CALL32                        = 0x00000003,
    IMAGE_REL_AM_FUNCINFO                      = 0x00000004,
    IMAGE_REL_AM_REL32_1                       = 0x00000005,
    IMAGE_REL_AM_REL32_2                       = 0x00000006,
    IMAGE_REL_AM_SECREL                        = 0x00000007,
    IMAGE_REL_AM_SECTION                       = 0x00000008,
    IMAGE_REL_AM_TOKEN                         = 0x00000009,
    IMAGE_REL_ARM64_ABSOLUTE                   = 0x00000000,
    IMAGE_REL_ARM64_ADDR32                     = 0x00000001,
    IMAGE_REL_ARM64_ADDR32NB                   = 0x00000002,
    IMAGE_REL_ARM64_BRANCH26                   = 0x00000003,
    IMAGE_REL_ARM64_PAGEBASE_REL21             = 0x00000004,
    IMAGE_REL_ARM64_REL21                      = 0x00000005,
    IMAGE_REL_ARM64_PAGEOFFSET_12A             = 0x00000006,
    IMAGE_REL_ARM64_PAGEOFFSET_12L             = 0x00000007,
    IMAGE_REL_ARM64_SECREL                     = 0x00000008,
    IMAGE_REL_ARM64_SECREL_LOW12A              = 0x00000009,
    IMAGE_REL_ARM64_SECREL_HIGH12A             = 0x0000000a,
    IMAGE_REL_ARM64_SECREL_LOW12L              = 0x0000000b,
    IMAGE_REL_ARM64_TOKEN                      = 0x0000000c,
    IMAGE_REL_ARM64_SECTION                    = 0x0000000d,
    IMAGE_REL_ARM64_ADDR64                     = 0x0000000e,
    IMAGE_REL_ARM64_BRANCH19                   = 0x0000000f,
    IMAGE_REL_AMD64_ABSOLUTE                   = 0x00000000,
    IMAGE_REL_AMD64_ADDR64                     = 0x00000001,
    IMAGE_REL_AMD64_ADDR32                     = 0x00000002,
    IMAGE_REL_AMD64_ADDR32NB                   = 0x00000003,
    IMAGE_REL_AMD64_REL32                      = 0x00000004,
    IMAGE_REL_AMD64_REL32_1                    = 0x00000005,
    IMAGE_REL_AMD64_REL32_2                    = 0x00000006,
    IMAGE_REL_AMD64_REL32_3                    = 0x00000007,
    IMAGE_REL_AMD64_REL32_4                    = 0x00000008,
    IMAGE_REL_AMD64_REL32_5                    = 0x00000009,
    IMAGE_REL_AMD64_SECTION                    = 0x0000000a,
    IMAGE_REL_AMD64_SECREL                     = 0x0000000b,
    IMAGE_REL_AMD64_SECREL7                    = 0x0000000c,
    IMAGE_REL_AMD64_TOKEN                      = 0x0000000d,
    IMAGE_REL_AMD64_SREL32                     = 0x0000000e,
    IMAGE_REL_AMD64_PAIR                       = 0x0000000f,
    IMAGE_REL_AMD64_SSPAN32                    = 0x00000010,
    IMAGE_REL_AMD64_EHANDLER                   = 0x00000011,
    IMAGE_REL_AMD64_IMPORT_BR                  = 0x00000012,
    IMAGE_REL_AMD64_IMPORT_CALL                = 0x00000013,
    IMAGE_REL_AMD64_CFG_BR                     = 0x00000014,
    IMAGE_REL_AMD64_CFG_BR_REX                 = 0x00000015,
    IMAGE_REL_AMD64_CFG_CALL                   = 0x00000016,
    IMAGE_REL_AMD64_INDIR_BR                   = 0x00000017,
    IMAGE_REL_AMD64_INDIR_BR_REX               = 0x00000018,
    IMAGE_REL_AMD64_INDIR_CALL                 = 0x00000019,
    IMAGE_REL_AMD64_INDIR_BR_SWITCHTABLE_FIRST = 0x00000020,
    IMAGE_REL_AMD64_INDIR_BR_SWITCHTABLE_LAST  = 0x0000002f,
}

enum : uint
{
    IMAGE_REL_IA64_IMM14      = 0x00000001,
    IMAGE_REL_IA64_IMM22      = 0x00000002,
    IMAGE_REL_IA64_IMM64      = 0x00000003,
    IMAGE_REL_IA64_DIR32      = 0x00000004,
    IMAGE_REL_IA64_DIR64      = 0x00000005,
    IMAGE_REL_IA64_PCREL21B   = 0x00000006,
    IMAGE_REL_IA64_PCREL21M   = 0x00000007,
    IMAGE_REL_IA64_PCREL21F   = 0x00000008,
    IMAGE_REL_IA64_GPREL22    = 0x00000009,
    IMAGE_REL_IA64_LTOFF22    = 0x0000000a,
    IMAGE_REL_IA64_SECTION    = 0x0000000b,
    IMAGE_REL_IA64_SECREL22   = 0x0000000c,
    IMAGE_REL_IA64_SECREL64I  = 0x0000000d,
    IMAGE_REL_IA64_SECREL32   = 0x0000000e,
    IMAGE_REL_IA64_DIR32NB    = 0x00000010,
    IMAGE_REL_IA64_SREL14     = 0x00000011,
    IMAGE_REL_IA64_SREL22     = 0x00000012,
    IMAGE_REL_IA64_SREL32     = 0x00000013,
    IMAGE_REL_IA64_UREL32     = 0x00000014,
    IMAGE_REL_IA64_PCREL60X   = 0x00000015,
    IMAGE_REL_IA64_PCREL60B   = 0x00000016,
    IMAGE_REL_IA64_PCREL60F   = 0x00000017,
    IMAGE_REL_IA64_PCREL60I   = 0x00000018,
    IMAGE_REL_IA64_PCREL60M   = 0x00000019,
    IMAGE_REL_IA64_IMMGPREL64 = 0x0000001a,
    IMAGE_REL_IA64_TOKEN      = 0x0000001b,
    IMAGE_REL_IA64_GPREL32    = 0x0000001c,
    IMAGE_REL_IA64_ADDEND     = 0x0000001f,
    IMAGE_REL_CEF_ABSOLUTE    = 0x00000000,
    IMAGE_REL_CEF_ADDR32      = 0x00000001,
    IMAGE_REL_CEF_ADDR64      = 0x00000002,
    IMAGE_REL_CEF_ADDR32NB    = 0x00000003,
    IMAGE_REL_CEF_SECTION     = 0x00000004,
    IMAGE_REL_CEF_SECREL      = 0x00000005,
    IMAGE_REL_CEF_TOKEN       = 0x00000006,
    IMAGE_REL_CEE_ABSOLUTE    = 0x00000000,
    IMAGE_REL_CEE_ADDR32      = 0x00000001,
    IMAGE_REL_CEE_ADDR64      = 0x00000002,
    IMAGE_REL_CEE_ADDR32NB    = 0x00000003,
    IMAGE_REL_CEE_SECTION     = 0x00000004,
    IMAGE_REL_CEE_SECREL      = 0x00000005,
    IMAGE_REL_CEE_TOKEN       = 0x00000006,
    IMAGE_REL_M32R_ABSOLUTE   = 0x00000000,
    IMAGE_REL_M32R_ADDR32     = 0x00000001,
    IMAGE_REL_M32R_ADDR32NB   = 0x00000002,
    IMAGE_REL_M32R_ADDR24     = 0x00000003,
    IMAGE_REL_M32R_GPREL16    = 0x00000004,
    IMAGE_REL_M32R_PCREL24    = 0x00000005,
    IMAGE_REL_M32R_PCREL16    = 0x00000006,
    IMAGE_REL_M32R_PCREL8     = 0x00000007,
    IMAGE_REL_M32R_REFHALF    = 0x00000008,
    IMAGE_REL_M32R_REFHI      = 0x00000009,
    IMAGE_REL_M32R_REFLO      = 0x0000000a,
    IMAGE_REL_M32R_PAIR       = 0x0000000b,
    IMAGE_REL_M32R_SECTION    = 0x0000000c,
    IMAGE_REL_M32R_SECREL32   = 0x0000000d,
    IMAGE_REL_M32R_TOKEN      = 0x0000000e,
    IMAGE_REL_EBC_ABSOLUTE    = 0x00000000,
    IMAGE_REL_EBC_ADDR32NB    = 0x00000001,
    IMAGE_REL_EBC_REL32       = 0x00000002,
    IMAGE_REL_EBC_SECTION     = 0x00000003,
    IMAGE_REL_EBC_SECREL      = 0x00000004,
}

enum : uint
{
    EMARCH_ENC_I17_IMM7B_SIZE_X           = 0x00000007,
    EMARCH_ENC_I17_IMM7B_INST_WORD_POS_X  = 0x00000004,
    EMARCH_ENC_I17_IMM7B_VAL_POS_X        = 0x00000000,
    EMARCH_ENC_I17_IMM9D_INST_WORD_X      = 0x00000003,
    EMARCH_ENC_I17_IMM9D_SIZE_X           = 0x00000009,
    EMARCH_ENC_I17_IMM9D_INST_WORD_POS_X  = 0x00000012,
    EMARCH_ENC_I17_IMM9D_VAL_POS_X        = 0x00000007,
    EMARCH_ENC_I17_IMM5C_INST_WORD_X      = 0x00000003,
    EMARCH_ENC_I17_IMM5C_SIZE_X           = 0x00000005,
    EMARCH_ENC_I17_IMM5C_INST_WORD_POS_X  = 0x0000000d,
    EMARCH_ENC_I17_IMM5C_VAL_POS_X        = 0x00000010,
    EMARCH_ENC_I17_IC_INST_WORD_X         = 0x00000003,
    EMARCH_ENC_I17_IC_SIZE_X              = 0x00000001,
    EMARCH_ENC_I17_IC_INST_WORD_POS_X     = 0x0000000c,
    EMARCH_ENC_I17_IC_VAL_POS_X           = 0x00000015,
    EMARCH_ENC_I17_IMM41a_INST_WORD_X     = 0x00000001,
    EMARCH_ENC_I17_IMM41a_SIZE_X          = 0x0000000a,
    EMARCH_ENC_I17_IMM41a_INST_WORD_POS_X = 0x0000000e,
    EMARCH_ENC_I17_IMM41a_VAL_POS_X       = 0x00000016,
    EMARCH_ENC_I17_IMM41b_INST_WORD_X     = 0x00000001,
    EMARCH_ENC_I17_IMM41b_SIZE_X          = 0x00000008,
    EMARCH_ENC_I17_IMM41b_INST_WORD_POS_X = 0x00000018,
    EMARCH_ENC_I17_IMM41b_VAL_POS_X       = 0x00000020,
    EMARCH_ENC_I17_IMM41c_INST_WORD_X     = 0x00000002,
    EMARCH_ENC_I17_IMM41c_SIZE_X          = 0x00000017,
    EMARCH_ENC_I17_IMM41c_INST_WORD_POS_X = 0x00000000,
    EMARCH_ENC_I17_IMM41c_VAL_POS_X       = 0x00000028,
    EMARCH_ENC_I17_SIGN_INST_WORD_X       = 0x00000003,
    EMARCH_ENC_I17_SIGN_SIZE_X            = 0x00000001,
    EMARCH_ENC_I17_SIGN_INST_WORD_POS_X   = 0x0000001b,
    EMARCH_ENC_I17_SIGN_VAL_POS_X         = 0x0000003f,
}

enum : uint
{
    X3_OPCODE_SIZE_X          = 0x00000004,
    X3_OPCODE_INST_WORD_POS_X = 0x0000001c,
}

enum uint X3_I_INST_WORD_X = 0x00000003;
enum uint X3_I_INST_WORD_POS_X = 0x0000001b;

enum : uint
{
    X3_D_WH_INST_WORD_X     = 0x00000003,
    X3_D_WH_SIZE_X          = 0x00000003,
    X3_D_WH_INST_WORD_POS_X = 0x00000018,
}

enum : uint
{
    X3_IMM20_INST_WORD_X     = 0x00000003,
    X3_IMM20_SIZE_X          = 0x00000014,
    X3_IMM20_INST_WORD_POS_X = 0x00000004,
}

enum : uint
{
    X3_IMM39_1_INST_WORD_X     = 0x00000002,
    X3_IMM39_1_SIZE_X          = 0x00000017,
    X3_IMM39_1_INST_WORD_POS_X = 0x00000000,
    X3_IMM39_1_SIGN_VAL_POS_X  = 0x00000024,
}

enum : uint
{
    X3_IMM39_2_SIZE_X          = 0x00000010,
    X3_IMM39_2_INST_WORD_POS_X = 0x00000010,
    X3_IMM39_2_SIGN_VAL_POS_X  = 0x00000014,
}

enum : uint
{
    X3_P_SIZE_X          = 0x00000004,
    X3_P_INST_WORD_POS_X = 0x00000000,
}

enum : uint
{
    X3_TMPLT_INST_WORD_X     = 0x00000000,
    X3_TMPLT_SIZE_X          = 0x00000004,
    X3_TMPLT_INST_WORD_POS_X = 0x00000000,
}

enum : uint
{
    X3_BTYPE_QP_INST_WORD_X     = 0x00000002,
    X3_BTYPE_QP_SIZE_X          = 0x00000009,
    X3_BTYPE_QP_INST_WORD_POS_X = 0x00000017,
    X3_BTYPE_QP_INST_VAL_POS_X  = 0x00000000,
}

enum : uint
{
    X3_EMPTY_SIZE_X          = 0x00000002,
    X3_EMPTY_INST_WORD_POS_X = 0x0000000e,
    X3_EMPTY_INST_VAL_POS_X  = 0x00000000,
}

enum : uint
{
    IMAGE_REL_BASED_HIGH               = 0x00000001,
    IMAGE_REL_BASED_LOW                = 0x00000002,
    IMAGE_REL_BASED_HIGHLOW            = 0x00000003,
    IMAGE_REL_BASED_HIGHADJ            = 0x00000004,
    IMAGE_REL_BASED_MACHINE_SPECIFIC_5 = 0x00000005,
    IMAGE_REL_BASED_RESERVED           = 0x00000006,
    IMAGE_REL_BASED_MACHINE_SPECIFIC_7 = 0x00000007,
    IMAGE_REL_BASED_MACHINE_SPECIFIC_8 = 0x00000008,
    IMAGE_REL_BASED_MACHINE_SPECIFIC_9 = 0x00000009,
    IMAGE_REL_BASED_DIR64              = 0x0000000a,
    IMAGE_REL_BASED_IA64_IMM64         = 0x00000009,
    IMAGE_REL_BASED_MIPS_JMPADDR       = 0x00000005,
    IMAGE_REL_BASED_MIPS_JMPADDR16     = 0x00000009,
    IMAGE_REL_BASED_ARM_MOV32          = 0x00000005,
    IMAGE_REL_BASED_THUMB_MOV32        = 0x00000007,
}

enum : /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)*
{
    IMAGE_ARCHIVE_START            = "!<arch>\n",
    IMAGE_ARCHIVE_END              = "`\n",
    IMAGE_ARCHIVE_PAD              = "\n",
    IMAGE_ARCHIVE_LINKER_MEMBER    = "/               ",
    IMAGE_ARCHIVE_LONGNAMES_MEMBER = "//              ",
    IMAGE_ARCHIVE_HYBRIDMAP_MEMBER = "/<HYBRIDMAP>/   ",
}

enum ulong IMAGE_ORDINAL_FLAG64 = 0x8000000000000000;

enum : uint
{
    IMAGE_RESOURCE_NAME_IS_STRING    = 0x80000000,
    IMAGE_RESOURCE_DATA_IS_DIRECTORY = 0x80000000,
}

enum : uint
{
    IMAGE_DYNAMIC_RELOCATION_GUARD_RF_EPILOGUE                 = 0x00000002,
    IMAGE_DYNAMIC_RELOCATION_GUARD_IMPORT_CONTROL_TRANSFER     = 0x00000003,
    IMAGE_DYNAMIC_RELOCATION_GUARD_INDIR_CONTROL_TRANSFER      = 0x00000004,
    IMAGE_DYNAMIC_RELOCATION_GUARD_SWITCHTABLE_BRANCH          = 0x00000005,
    IMAGE_DYNAMIC_RELOCATION_FUNCTION_OVERRIDE                 = 0x00000007,
    IMAGE_DYNAMIC_RELOCATION_ARM64_KERNEL_IMPORT_CALL_TRANSFER = 0x00000008,
    IMAGE_DYNAMIC_RELOCATION_IMPORT_CONTROL_TRANSFER           = 0x00000003,
}

enum : uint
{
    IMAGE_FUNCTION_OVERRIDE_X64_REL32      = 0x00000001,
    IMAGE_FUNCTION_OVERRIDE_ARM64_BRANCH26 = 0x00000002,
    IMAGE_FUNCTION_OVERRIDE_ARM64_THUNK    = 0x00000003,
}

enum : uint
{
    IMAGE_HOT_PATCH_INFO_FLAG_HOTSWAP  = 0x00000002,
    IMAGE_HOT_PATCH_BASE_OBLIGATORY    = 0x00000001,
    IMAGE_HOT_PATCH_BASE_CAN_ROLL_BACK = 0x00000002,
    IMAGE_HOT_PATCH_BASE_MACHINE_I386  = 0x00000004,
    IMAGE_HOT_PATCH_BASE_MACHINE_ARM64 = 0x00000008,
    IMAGE_HOT_PATCH_BASE_MACHINE_AMD64 = 0x00000010,
    IMAGE_HOT_PATCH_CHUNK_INVERSE      = 0x80000000,
    IMAGE_HOT_PATCH_CHUNK_OBLIGATORY   = 0x40000000,
    IMAGE_HOT_PATCH_CHUNK_RESERVED     = 0x3ff03000,
    IMAGE_HOT_PATCH_CHUNK_TYPE         = 0x000fc000,
    IMAGE_HOT_PATCH_CHUNK_SOURCE_RVA   = 0x00008000,
    IMAGE_HOT_PATCH_CHUNK_TARGET_RVA   = 0x00004000,
    IMAGE_HOT_PATCH_CHUNK_SIZE         = 0x00000fff,
    IMAGE_HOT_PATCH_NONE               = 0x00000000,
    IMAGE_HOT_PATCH_FUNCTION           = 0x0001c000,
    IMAGE_HOT_PATCH_ABSOLUTE           = 0x0002c000,
    IMAGE_HOT_PATCH_REL32              = 0x0003c000,
    IMAGE_HOT_PATCH_CALL_TARGET        = 0x00044000,
    IMAGE_HOT_PATCH_INDIRECT           = 0x0005c000,
    IMAGE_HOT_PATCH_NO_CALL_TARGET     = 0x00064000,
    IMAGE_HOT_PATCH_DYNAMIC_VALUE      = 0x00078000,
}

enum : uint
{
    IMAGE_GUARD_CFW_INSTRUMENTED          = 0x00000200,
    IMAGE_GUARD_CF_FUNCTION_TABLE_PRESENT = 0x00000400,
}

enum uint IMAGE_GUARD_PROTECT_DELAYLOAD_IAT = 0x00001000;
enum uint IMAGE_GUARD_CF_EXPORT_SUPPRESSION_INFO_PRESENT = 0x00004000;
enum uint IMAGE_GUARD_CF_LONGJUMP_TABLE_PRESENT = 0x00010000;

enum : uint
{
    IMAGE_GUARD_RF_ENABLE                     = 0x00040000,
    IMAGE_GUARD_RF_STRICT                     = 0x00080000,
    IMAGE_GUARD_RETPOLINE_PRESENT             = 0x00100000,
    IMAGE_GUARD_EH_CONTINUATION_TABLE_PRESENT = 0x00400000,
}

enum : uint
{
    IMAGE_GUARD_CASTGUARD_PRESENT            = 0x01000000,
    IMAGE_GUARD_MEMCPY_PRESENT               = 0x02000000,
    IMAGE_GUARD_CF_FUNCTION_TABLE_SIZE_MASK  = 0xf0000000,
    IMAGE_GUARD_CF_FUNCTION_TABLE_SIZE_SHIFT = 0x0000001c,
}

enum : uint
{
    IMAGE_GUARD_FLAG_EXPORT_SUPPRESSED    = 0x00000002,
    IMAGE_GUARD_FLAG_FID_LANGEXCPTHANDLER = 0x00000004,
    IMAGE_GUARD_FLAG_FID_XFG              = 0x00000008,
}

enum : uint
{
    IMAGE_ENCLAVE_SHORT_ID_LENGTH        = 0x00000010,
    IMAGE_ENCLAVE_POLICY_DEBUGGABLE      = 0x00000001,
    IMAGE_ENCLAVE_POLICY_STRICT_MEMORY   = 0x00000002,
    IMAGE_ENCLAVE_FLAG_PRIMARY_IMAGE     = 0x00000001,
    IMAGE_ENCLAVE_IMPORT_MATCH_NONE      = 0x00000000,
    IMAGE_ENCLAVE_IMPORT_MATCH_UNIQUE_ID = 0x00000001,
    IMAGE_ENCLAVE_IMPORT_MATCH_AUTHOR_ID = 0x00000002,
    IMAGE_ENCLAVE_IMPORT_MATCH_FAMILY_ID = 0x00000003,
    IMAGE_ENCLAVE_IMPORT_MATCH_IMAGE_ID  = 0x00000004,
}

enum : uint
{
    IMAGE_DEBUG_TYPE_OMAP_FROM_SRC         = 0x00000008,
    IMAGE_DEBUG_TYPE_RESERVED10            = 0x0000000a,
    IMAGE_DEBUG_TYPE_BBT                   = 0x0000000a,
    IMAGE_DEBUG_TYPE_CLSID                 = 0x0000000b,
    IMAGE_DEBUG_TYPE_VC_FEATURE            = 0x0000000c,
    IMAGE_DEBUG_TYPE_POGO                  = 0x0000000d,
    IMAGE_DEBUG_TYPE_ILTCG                 = 0x0000000e,
    IMAGE_DEBUG_TYPE_MPX                   = 0x0000000f,
    IMAGE_DEBUG_TYPE_REPRO                 = 0x00000010,
    IMAGE_DEBUG_TYPE_SPGO                  = 0x00000012,
    IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS = 0x00000014,
}

enum : uint
{
    FRAME_TRAP   = 0x00000001,
    FRAME_TSS    = 0x00000002,
    FRAME_NONFPO = 0x00000003,
}

enum uint IMAGE_DEBUG_MISC_EXENAME = 0x00000001;
enum uint NON_PAGED_DEBUG_SIGNATURE = 0x0000494e;
enum uint IMAGE_SEPARATE_DEBUG_MISMATCH = 0x00008000;
enum uint UNWIND_HISTORY_TABLE_SIZE = 0x0000000c;
enum uint FAST_FAIL_VTGUARD_CHECK_FAILURE = 0x00000001;
enum uint FAST_FAIL_CORRUPT_LIST_ENTRY = 0x00000003;

enum : uint
{
    FAST_FAIL_INVALID_ARG         = 0x00000005,
    FAST_FAIL_GS_COOKIE_INIT      = 0x00000006,
    FAST_FAIL_FATAL_APP_EXIT      = 0x00000007,
    FAST_FAIL_RANGE_CHECK_FAILURE = 0x00000008,
}

enum : uint
{
    FAST_FAIL_GUARD_ICALL_CHECK_FAILURE = 0x0000000a,
    FAST_FAIL_GUARD_WRITE_CHECK_FAILURE = 0x0000000b,
}

enum : uint
{
    FAST_FAIL_INVALID_SET_OF_CONTEXT  = 0x0000000d,
    FAST_FAIL_INVALID_REFERENCE_COUNT = 0x0000000e,
    FAST_FAIL_INVALID_JUMP_BUFFER     = 0x00000012,
}

enum uint FAST_FAIL_CERTIFICATION_FAILURE = 0x00000014;

enum : uint
{
    FAST_FAIL_CRYPTO_LIBRARY              = 0x00000016,
    FAST_FAIL_INVALID_CALL_IN_DLL_CALLOUT = 0x00000017,
    FAST_FAIL_INVALID_IMAGE_BASE          = 0x00000018,
}

enum uint FAST_FAIL_UNSAFE_EXTENSION_CALL = 0x0000001a;

enum : uint
{
    FAST_FAIL_INVALID_BUFFER_ACCESS = 0x0000001c,
    FAST_FAIL_INVALID_BALANCED_TREE = 0x0000001d,
    FAST_FAIL_INVALID_NEXT_THREAD   = 0x0000001e,
}

enum : uint
{
    FAST_FAIL_APCS_DISABLED      = 0x00000020,
    FAST_FAIL_INVALID_IDLE_STATE = 0x00000021,
}

enum uint FAST_FAIL_UNEXPECTED_HEAP_EXCEPTION = 0x00000023;
enum uint FAST_FAIL_GUARD_JUMPTABLE = 0x00000025;

enum : uint
{
    FAST_FAIL_INVALID_DISPATCH_CONTEXT = 0x00000027,
    FAST_FAIL_INVALID_THREAD           = 0x00000028,
    FAST_FAIL_INVALID_SYSCALL_NUMBER   = 0x00000029,
    FAST_FAIL_INVALID_FILE_OPERATION   = 0x0000002a,
}

enum uint FAST_FAIL_GUARD_SS_FAILURE = 0x0000002c;
enum uint FAST_FAIL_GUARD_EXPORT_SUPPRESSION_FAILURE = 0x0000002e;
enum uint FAST_FAIL_SET_CONTEXT_DENIED = 0x00000030;
enum uint FAST_FAIL_HEAP_METADATA_CORRUPTION = 0x00000032;
enum uint FAST_FAIL_LOW_LABEL_ACCESS_DENIED = 0x00000034;
enum uint FAST_FAIL_UNHANDLED_LSS_EXCEPTON = 0x00000036;
enum uint FAST_FAIL_UNEXPECTED_CALL = 0x00000038;
enum uint FAST_FAIL_UNEXPECTED_HOST_BEHAVIOR = 0x0000003a;

enum : uint
{
    FAST_FAIL_VEH_CORRUPTION                = 0x0000003c,
    FAST_FAIL_ETW_CORRUPTION                = 0x0000003d,
    FAST_FAIL_RIO_ABORT                     = 0x0000003e,
    FAST_FAIL_INVALID_PFN                   = 0x0000003f,
    FAST_FAIL_GUARD_ICALL_CHECK_FAILURE_XFG = 0x00000040,
}

enum uint FAST_FAIL_HOST_VISIBILITY_CHANGE = 0x00000042;
enum uint FAST_FAIL_PATCH_CALLBACK_FAILED = 0x00000044;
enum uint FAST_FAIL_INVALID_FLS_DATA = 0x00000046;
enum uint FAST_FAIL_CLR_EXCEPTION_AOT = 0x00000048;
enum uint FAST_FAIL_INVALID_THREAD_STATE = 0x0000004a;
enum uint FAST_FAIL_INVALID_EXTENDED_STATE = 0x0000004c;
enum uint FAST_FAIL_INVALID_FAST_FAIL_CODE = 0xffffffff;
enum uint IS_TEXT_UNICODE_UTF8 = 0x00000800;

enum : uint
{
    COMPRESSION_ENGINE_MAXIMUM = 0x00000100,
    COMPRESSION_ENGINE_HIBER   = 0x00000200,
}

enum uint SEF_FORCE_USER_MODE = 0x00002000;

enum : uint
{
    MESSAGE_RESOURCE_UNICODE = 0x00000001,
    MESSAGE_RESOURCE_UTF8    = 0x00000002,
}

enum : uint
{
    VER_GREATER       = 0x00000002,
    VER_GREATER_EQUAL = 0x00000003,
}

enum uint VER_LESS_EQUAL = 0x00000005;

enum : uint
{
    VER_OR             = 0x00000007,
    VER_CONDITION_MASK = 0x00000007,
}

enum uint VER_NT_WORKSTATION = 0x00000001;
enum uint VER_NT_SERVER = 0x00000003;
enum uint VRL_PREDEFINED_CLASS_BEGIN = 0x00000001;
enum uint VRL_ENABLE_KERNEL_BREAKS = 0x80000000;
enum uint CTMF_INCLUDE_LPAC = 0x00000002;

enum : uint
{
    WRITE_NV_MEMORY_FLAG_FLUSH        = 0x00000001,
    WRITE_NV_MEMORY_FLAG_NON_TEMPORAL = 0x00000002,
    WRITE_NV_MEMORY_FLAG_NO_DRAIN     = 0x00000100,
}

enum : uint
{
    FILL_NV_MEMORY_FLAG_NON_TEMPORAL = 0x00000002,
    FILL_NV_MEMORY_FLAG_NO_DRAIN     = 0x00000100,
}

enum /*FIELD ATTR: NativeEncodingAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ansi))], [])*/const(wchar)* IMAGE_POLICY_SECTION_NAME = ".tPolicy";
enum uint HEAP_OPTIMIZE_RESOURCES_CURRENT_VERSION = 0x00000001;
enum uint WT_EXECUTEINPERSISTENTIOTHREAD = 0x00000040;
enum uint WT_EXECUTEDELETEWAIT = 0x00000008;

enum : uint
{
    ACTIVATION_CONTEXT_PATH_TYPE_WIN32_FILE  = 0x00000002,
    ACTIVATION_CONTEXT_PATH_TYPE_URL         = 0x00000003,
    ACTIVATION_CONTEXT_PATH_TYPE_ASSEMBLYREF = 0x00000004,
}

enum uint PERFORMANCE_DATA_VERSION = 0x00000001;
enum uint READ_THREAD_PROFILING_FLAG_HARDWARE_COUNTERS = 0x00000002;
enum const(wchar)* UNIFIEDBUILDREVISION_VALUE = "UBR";

enum : const(wchar)*
{
    DEVICEFAMILYDEVICEFORM_KEY   = "\\Registry\\Machine\\Software\\Microsoft\\Windows NT\\CurrentVersion\\OEM",
    DEVICEFAMILYDEVICEFORM_VALUE = "DeviceForm",
}

enum : uint
{
    DLL_THREAD_ATTACH = 0x00000002,
    DLL_THREAD_DETACH = 0x00000003,
}

enum uint EVENTLOG_START_PAIRED_EVENT = 0x00000001;
enum uint EVENTLOG_END_ALL_PAIRED_EVENTS = 0x00000004;
enum uint EVENTLOG_PAIRED_EVENT_INACTIVE = 0x00000010;
enum int REG_REFRESH_HIVE = 0x00000002;
enum int REG_APP_HIVE = 0x00000010;
enum int REG_START_JOURNAL = 0x00000040;

enum : int
{
    REG_HIVE_NO_RM      = 0x00000100,
    REG_HIVE_SINGLE_LOG = 0x00000200,
}

enum int REG_LOAD_HIVE_OPEN_HANDLE = 0x00000800;
enum int REG_OPEN_READ_ONLY = 0x00002000;
enum int REG_NO_IMPERSONATION_FALLBACK = 0x00008000;
enum uint REG_FORCE_UNLOAD = 0x00000001;

enum : uint
{
    SERVICE_USER_SERVICE         = 0x00000040,
    SERVICE_USERSERVICE_INSTANCE = 0x00000080,
}

enum uint SERVICE_PKG_SERVICE = 0x00000200;
enum uint CM_SERVICE_VIRTUAL_DISK_BOOT_LOAD = 0x00000002;
enum uint CM_SERVICE_SD_DISK_BOOT_LOAD = 0x00000008;
enum uint CM_SERVICE_MEASURED_BOOT_LOAD = 0x00000020;

enum : uint
{
    CM_SERVICE_WINPE_BOOT_LOAD    = 0x00000080,
    CM_SERVICE_RAM_DISK_BOOT_LOAD = 0x00000100,
}

enum int TAPE_PSEUDO_LOGICAL_BLOCK = 0x00000003;

enum : uint
{
    TAPE_DRIVE_SELECT           = 0x00000002,
    TAPE_DRIVE_INITIATOR        = 0x00000004,
    TAPE_DRIVE_ERASE_SHORT      = 0x00000010,
    TAPE_DRIVE_ERASE_LONG       = 0x00000020,
    TAPE_DRIVE_ERASE_BOP_ONLY   = 0x00000040,
    TAPE_DRIVE_ERASE_IMMEDIATE  = 0x00000080,
    TAPE_DRIVE_TAPE_CAPACITY    = 0x00000100,
    TAPE_DRIVE_TAPE_REMAINING   = 0x00000200,
    TAPE_DRIVE_FIXED_BLOCK      = 0x00000400,
    TAPE_DRIVE_VARIABLE_BLOCK   = 0x00000800,
    TAPE_DRIVE_WRITE_PROTECT    = 0x00001000,
    TAPE_DRIVE_EOT_WZ_SIZE      = 0x00002000,
    TAPE_DRIVE_ECC              = 0x00010000,
    TAPE_DRIVE_COMPRESSION      = 0x00020000,
    TAPE_DRIVE_PADDING          = 0x00040000,
    TAPE_DRIVE_REPORT_SMKS      = 0x00080000,
    TAPE_DRIVE_GET_ABSOLUTE_BLK = 0x00100000,
    TAPE_DRIVE_GET_LOGICAL_BLK  = 0x00200000,
    TAPE_DRIVE_SET_EOT_WZ_SIZE  = 0x00400000,
    TAPE_DRIVE_EJECT_MEDIA      = 0x01000000,
    TAPE_DRIVE_CLEAN_REQUESTS   = 0x02000000,
    TAPE_DRIVE_SET_CMP_BOP_ONLY = 0x04000000,
    TAPE_DRIVE_RESERVED_BIT     = 0x80000000,
    TAPE_DRIVE_FORMAT           = 0xa0000000,
    TAPE_DRIVE_FORMAT_IMMEDIATE = 0xc0000000,
    TAPE_DRIVE_HIGH_FEATURES    = 0x80000000,
}

enum int TAPE_QUERY_MEDIA_CAPACITY = 0x00000001;

enum : int
{
    TAPE_QUERY_IO_ERROR_DATA     = 0x00000003,
    TAPE_QUERY_DEVICE_ERROR_DATA = 0x00000004,
}

enum : uint
{
    TRANSACTIONMANAGER_SET_INFORMATION  = 0x00000002,
    TRANSACTIONMANAGER_RECOVER          = 0x00000004,
    TRANSACTIONMANAGER_RENAME           = 0x00000008,
    TRANSACTIONMANAGER_CREATE_RM        = 0x00000010,
    TRANSACTIONMANAGER_BIND_TRANSACTION = 0x00000020,
}

enum : uint
{
    TRANSACTION_SET_INFORMATION = 0x00000002,
    TRANSACTION_ENLIST          = 0x00000004,
    TRANSACTION_COMMIT          = 0x00000008,
    TRANSACTION_ROLLBACK        = 0x00000010,
    TRANSACTION_PROPAGATE       = 0x00000020,
    TRANSACTION_RIGHT_RESERVED1 = 0x00000040,
}

enum : uint
{
    RESOURCEMANAGER_SET_INFORMATION      = 0x00000002,
    RESOURCEMANAGER_RECOVER              = 0x00000004,
    RESOURCEMANAGER_ENLIST               = 0x00000008,
    RESOURCEMANAGER_GET_NOTIFICATION     = 0x00000010,
    RESOURCEMANAGER_REGISTER_PROTOCOL    = 0x00000020,
    RESOURCEMANAGER_COMPLETE_PROPAGATION = 0x00000040,
}

enum : uint
{
    ENLISTMENT_SET_INFORMATION    = 0x00000002,
    ENLISTMENT_RECOVER            = 0x00000004,
    ENLISTMENT_SUBORDINATE_RIGHTS = 0x00000008,
    ENLISTMENT_SUPERIOR_RIGHTS    = 0x00000010,
}

enum : uint
{
    ACTIVATION_CONTEXT_SECTION_ASSEMBLY_INFORMATION         = 0x00000001,
    ACTIVATION_CONTEXT_SECTION_DLL_REDIRECTION              = 0x00000002,
    ACTIVATION_CONTEXT_SECTION_WINDOW_CLASS_REDIRECTION     = 0x00000003,
    ACTIVATION_CONTEXT_SECTION_COM_SERVER_REDIRECTION       = 0x00000004,
    ACTIVATION_CONTEXT_SECTION_COM_INTERFACE_REDIRECTION    = 0x00000005,
    ACTIVATION_CONTEXT_SECTION_COM_TYPE_LIBRARY_REDIRECTION = 0x00000006,
    ACTIVATION_CONTEXT_SECTION_COM_PROGID_REDIRECTION       = 0x00000007,
    ACTIVATION_CONTEXT_SECTION_GLOBAL_OBJECT_RENAME_TABLE   = 0x00000008,
    ACTIVATION_CONTEXT_SECTION_CLR_SURROGATES               = 0x00000009,
    ACTIVATION_CONTEXT_SECTION_APPLICATION_SETTINGS         = 0x0000000a,
    ACTIVATION_CONTEXT_SECTION_COMPATIBILITY_INFO           = 0x0000000b,
    ACTIVATION_CONTEXT_SECTION_WINRT_ACTIVATABLE_CLASSES    = 0x0000000c,
}

enum uint WDT_INPROC_CALL = 0x48746457;
enum uint WDT_INPROC64_CALL = 0x50746457;

enum : uint
{
    PROCESS_HEAP_REGION            = 0x00000001,
    PROCESS_HEAP_UNCOMMITTED_RANGE = 0x00000002,
    PROCESS_HEAP_ENTRY_BUSY        = 0x00000004,
    PROCESS_HEAP_SEG_ALLOC         = 0x00000008,
    PROCESS_HEAP_ENTRY_MOVEABLE    = 0x00000010,
    PROCESS_HEAP_ENTRY_DDESHARE    = 0x00000020,
}

enum uint LMEM_NODISCARD = 0x00000020;
enum uint LMEM_DISCARDABLE = 0x00000f00;
enum uint LMEM_INVALID_HANDLE = 0x00008000;
enum uint LMEM_LOCKCOUNT = 0x000000ff;
enum uint REDBOOK_DIGITAL_AUDIO_EXTRACTION_INFO_VERSION = 0x00000001;

// Callbacks

alias PUMS_SCHEDULER_ENTRY_POINT = void function(RTL_UMS_SCHEDULER_REASON Reason, size_t ActivationPayload, 
                                                 void* SchedulerParam);
version (X86) {
alias PTERMINATION_HANDLER = void function(BOOLEAN _abnormal_termination, ulong EstablisherFrame);
}
version (X86) {
alias POUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK = uint function(HANDLE Process, void* TableAddress, uint* Entries, 
                                                              IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY** Functions);
}
version (ARM64) {
alias POUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK = uint function(HANDLE Process, void* TableAddress, uint* Entries, 
                                                              IMAGE_RUNTIME_FUNCTION_ENTRY** Functions);
}
version (X86) {
alias PEXCEPTION_FILTER = int function(EXCEPTION_POINTERS* ExceptionPointers, void* EstablisherFrame);
}
version (ARM64) {
alias PTERMINATION_HANDLER = void function(BOOLEAN _abnormal_termination, void* EstablisherFrame);
}
alias PIMAGE_TLS_CALLBACK = void function(void* DllHandle, uint Reason, void* Reserved);

// Structs


struct RemHGLOBAL
{
    int  fNullHGlobal;
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] data;
}

struct RemHMETAFILEPICT
{
    int  mm;
    int  xExt;
    int  yExt;
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] data;
}

struct RemHENHMETAFILE
{
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] data;
}

struct RemHBITMAP
{
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] data;
}

struct RemHPALETTE
{
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] data;
}

struct RemHBRUSH
{
    uint cbData;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] data;
}

struct userCLIPFORMAT
{
    int fContext;
union u
    {
        uint  dwValue;
        PWSTR pwszName;
    }
}

struct GDI_NONREMOTE
{
    int fContext;
union u
    {
        int         hInproc;
        DWORD_BLOB* hRemote;
    }
}

struct userHGLOBAL
{
    int fContext;
union u
    {
        int                hInproc;
        FLAGGED_BYTE_BLOB* hRemote;
        long               hInproc64;
    }
}

struct userHMETAFILE
{
    int fContext;
union u
    {
        int        hInproc;
        BYTE_BLOB* hRemote;
        long       hInproc64;
    }
}

struct remoteMETAFILEPICT
{
    int            mm;
    int            xExt;
    int            yExt;
    userHMETAFILE* hMF;
}

struct userHMETAFILEPICT
{
    int fContext;
union u
    {
        int                 hInproc;
        remoteMETAFILEPICT* hRemote;
        long                hInproc64;
    }
}

struct userHENHMETAFILE
{
    int fContext;
union u
    {
        int        hInproc;
        BYTE_BLOB* hRemote;
        long       hInproc64;
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct userBITMAP
{
    int    bmType;
    int    bmWidth;
    int    bmHeight;
    int    bmWidthBytes;
    ushort bmPlanes;
    ushort bmBitsPixel;
    uint   cbSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] pBuffer;
}

struct userHBITMAP
{
    int fContext;
union u
    {
        int         hInproc;
        userBITMAP* hRemote;
        long        hInproc64;
    }
}

struct userHPALETTE
{
    int fContext;
union u
    {
        int         hInproc;
        LOGPALETTE* hRemote;
        long        hInproc64;
    }
}

struct RemotableHandle
{
    int fContext;
union u
    {
        int hInproc;
        int hRemote;
    }
}

struct REDBOOK_DIGITAL_AUDIO_EXTRACTION_INFO
{
    uint Version;
    uint Accurate;
    uint Supported;
    uint AccurateMask0;
}

version (X86) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct REARRANGE_FILE_DATA32
{
    ulong SourceStartingOffset;
    ulong TargetOffset;
    uint  SourceFileHandle;
    uint  Length;
    uint  Flags;
}
}

struct XSAVE_CET_U_FORMAT
{
    ulong Ia32CetUMsr;
    ulong Ia32Pl3SspMsr;
}

struct XSAVE_ARM64_SVE_HEADER
{
    uint    VectorLength;
    uint    VectorRegisterOffset;
    uint    PredicateRegisterOffset;
    uint[5] Reserved;
}

struct KERNEL_CET_CONTEXT
{
    ulong     Ssp;
    ulong     Rip;
    ushort    SegCs;
union Anonymous
    {
        ushort AllFlags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Unused)), FixedArgSig(ElementSig(2)), FixedArgSig(ElementSig(14))], [])*/ushort _bitfield106;
        }
    }
    ushort[2] Fill;
}

struct SCOPE_TABLE_AMD64
{
    uint Count;
struct ScopeRecord
    {
        uint BeginAddress;
        uint EndAddress;
        uint HandlerAddress;
        uint JumpTarget;
    }
}

struct SCOPE_TABLE_ARM
{
    uint Count;
struct ScopeRecord
    {
        uint BeginAddress;
        uint EndAddress;
        uint HandlerAddress;
        uint JumpTarget;
    }
}

struct SCOPE_TABLE_ARM64
{
    uint Count;
struct ScopeRecord
    {
        uint BeginAddress;
        uint EndAddress;
        uint HandlerAddress;
        uint JumpTarget;
    }
}

union DISPATCHER_CONTEXT_NONVOLREG_ARM64
{
    ubyte[152] Buffer;
struct Anonymous
    {
        ulong[11] GpNvRegs;
        double[8] FpNvRegs;
    }
}

struct ATTRIBUTES_AND_SID
{
    uint Attributes;
    uint SidStart;
}

struct SECURITY_OBJECT_AI_PARAMS
{
    uint Size;
    uint ConstraintMask;
}

struct SE_TOKEN_USER
{
union Anonymous1
    {
        TOKEN_USER         TokenUser;
        SID_AND_ATTRIBUTES User;
    }
union Anonymous2
    {
        SID       Sid;
        ubyte[68] Buffer;
    }
}

struct TOKEN_LOGGING_INFORMATION
{
    TOKEN_TYPE           TokenType;
    TOKEN_ELEVATION      TokenElevation;
    TOKEN_ELEVATION_TYPE TokenElevationType;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    uint                 IntegrityLevel;
    SID_AND_ATTRIBUTES   User;
    PSID                 TrustLevelSid;
    uint                 SessionId;
    uint                 AppContainerNumber;
    LUID                 AuthenticationId;
    uint                 GroupCount;
    uint                 GroupsLength;
    SID_AND_ATTRIBUTES*  Groups;
}

struct TOKEN_SID_INFORMATION
{
    PSID Sid;
}

struct TOKEN_BNO_ISOLATION_INFORMATION
{
    PWSTR   IsolationPrefix;
    BOOLEAN IsolationEnabled;
}

struct NT_TIB32
{
    uint ExceptionList;
    uint StackBase;
    uint StackLimit;
    uint SubSystemTib;
union Anonymous
    {
        uint FiberData;
        uint Version;
    }
    uint ArbitraryUserPointer;
    uint Self;
}

struct NT_TIB64
{
    ulong ExceptionList;
    ulong StackBase;
    ulong StackLimit;
    ulong SubSystemTib;
union Anonymous
    {
        ulong FiberData;
        uint  Version;
    }
    ulong ArbitraryUserPointer;
    ulong Self;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-ums_create_thread_attributes))], [])
struct UMS_CREATE_THREAD_ATTRIBUTES
{
    uint  UmsVersion;
    void* UmsContext;
    void* UmsCompletionList;
}

struct COMPONENT_FILTER
{
    uint ComponentFlags;
}

union RATE_QUOTA_LIMIT
{
    uint RateData;
struct Anonymous
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved0)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(25))], [])*/uint _bitfield107;
    }
}

struct QUOTA_LIMITS_EX
{
    size_t           PagedPoolLimit;
    size_t           NonPagedPoolLimit;
    size_t           MinimumWorkingSetSize;
    size_t           MaximumWorkingSetSize;
    size_t           PagefileLimit;
    long             TimeLimit;
    size_t           WorkingSetLimit;
    size_t           Reserved2;
    size_t           Reserved3;
    size_t           Reserved4;
    uint             Flags;
    RATE_QUOTA_LIMIT CpuRateLimit;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_aslr_policy))], [])
struct PROCESS_MITIGATION_ASLR_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(28))], [])*/uint _bitfield108;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_dep_policy))], [])
struct PROCESS_MITIGATION_DEP_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(2)), FixedArgSig(ElementSig(30))], [])*/uint _bitfield109;
        }
    }
    BOOLEAN Permanent;
}

struct PROCESS_MITIGATION_SEHOP_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(31))], [])*/uint _bitfield110;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_strict_handle_check_policy))], [])
struct PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(2)), FixedArgSig(ElementSig(30))], [])*/uint _bitfield111;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_system_call_disable_policy))], [])
struct PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(28))], [])*/uint _bitfield112;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_extension_point_disable_policy))], [])
struct PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(31))], [])*/uint _bitfield113;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_dynamic_code_policy))], [])
struct PROCESS_MITIGATION_DYNAMIC_CODE_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(28))], [])*/uint _bitfield114;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_control_flow_guard_policy))], [])
struct PROCESS_MITIGATION_CONTROL_FLOW_GUARD_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(5)), FixedArgSig(ElementSig(27))], [])*/uint _bitfield115;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_binary_signature_policy))], [])
struct PROCESS_MITIGATION_BINARY_SIGNATURE_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(5)), FixedArgSig(ElementSig(27))], [])*/uint _bitfield116;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_font_disable_policy))], [])
struct PROCESS_MITIGATION_FONT_DISABLE_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(2)), FixedArgSig(ElementSig(30))], [])*/uint _bitfield117;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_image_load_policy))], [])
struct PROCESS_MITIGATION_IMAGE_LOAD_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(5)), FixedArgSig(ElementSig(27))], [])*/uint _bitfield118;
        }
    }
}

struct PROCESS_MITIGATION_SYSTEM_CALL_FILTER_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(28))], [])*/uint _bitfield119;
        }
    }
}

struct PROCESS_MITIGATION_PAYLOAD_RESTRICTION_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(12)), FixedArgSig(ElementSig(20))], [])*/uint _bitfield120;
        }
    }
}

struct PROCESS_MITIGATION_CHILD_PROCESS_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(3)), FixedArgSig(ElementSig(29))], [])*/uint _bitfield121;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_side_channel_isolation_policy))], [])
struct PROCESS_MITIGATION_SIDE_CHANNEL_ISOLATION_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(5)), FixedArgSig(ElementSig(27))], [])*/uint _bitfield122;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process_mitigation_user_shadow_stack_policy))], [])
struct PROCESS_MITIGATION_USER_SHADOW_STACK_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(10)), FixedArgSig(ElementSig(22))], [])*/uint _bitfield123;
        }
    }
}

struct PROCESS_MITIGATION_USER_POINTER_AUTH_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(31))], [])*/uint _bitfield124;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-process-mitigation-redirection-trust-policy))], [])
struct PROCESS_MITIGATION_REDIRECTION_TRUST_POLICY
{
union Anonymous
    {
        uint Flags;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ReservedFlags)), FixedArgSig(ElementSig(2)), FixedArgSig(ElementSig(30))], [])*/uint _bitfield125;
        }
    }
}

struct PROCESS_NETWORK_COUNTERS
{
    ulong BytesIn;
    ulong BytesOut;
}

struct JOBOBJECT_NETWORK_ACCOUNTING_INFORMATION
{
    ulong DataBytesIn;
    ulong DataBytesOut;
}

struct SILOOBJECT_BASIC_INFORMATION
{
    uint     SiloId;
    uint     SiloParentId;
    uint     NumberOfProcesses;
    BOOLEAN  IsInServerSilo;
    ubyte[3] Reserved;
}

struct SERVERSILO_BASIC_INFORMATION
{
    uint             ServiceSessionId;
    SERVERSILO_STATE State;
    uint             ExitStatus;
    BOOLEAN          Reserved;
    void*            ApiSetSchema;
    void*            HostApiSetSchema;
    uint             ContainerBuildNumber;
    uint             HostBuildNumber;
}

struct SERVERSILO_DIAGNOSTIC_INFORMATION
{
    GUID      ReportId;
    uint      ExitStatus;
    wchar[15] CriticalProcessName;
}

struct RUNTIME_REPORT_PACKAGE_HEADER
{
    uint   Magic;
    ushort PackageVersion;
    ushort NumberOfReports;
    ulong  ReportTypesBitmap;
    uint   PackageSize;
    ushort ReportDigestType;
    ushort TotalReportDigestsSize;
    ushort Reserved;
    ushort SignatureScheme;
    uint   SignatureSize;
    uint   TotalAuthenticatedReportsSize;
}

struct RUNTIME_REPORT_DIGEST_HEADER
{
    ushort    ReportType;
    ushort    Reserved;
    ubyte[64] ReportDigest;
}

struct RUNTIME_REPORT_HEADER
{
    ushort ReportType;
    ushort Reserved;
    uint   ReportSize;
}

struct DRIVER_INFO_ENTRY
{
    CHAR[32] InternalName;
    ushort   ImageHashAlgorithm;
    ushort   PublisherThumbprintHashAlgorithm;
    uint     ImageHashOffset;
    uint     PublisherThumbprintOffset;
    ushort   LoadCount;
    ushort   OemNameSize;
    uint     OemNameOffset;
union Flags
    {
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(3)), FixedArgSig(ElementSig(13))], [])*/ushort _bitfield126;
        }
        ushort AsUInt16;
    }
    ushort   Padding;
}

struct DRIVER_RUNTIME_REPORT
{
    RUNTIME_REPORT_HEADER Header;
    ushort NumberOfDrivers;
union Flags
    {
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(3)), FixedArgSig(ElementSig(13))], [])*/ushort _bitfield127;
        }
        ushort AsUInt16;
    }
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/DRIVER_INFO_ENTRY[1] DriverEntries;
}

struct FILE_NOTIFY_FULL_INFORMATION
{
    uint   NextEntryOffset;
    uint   Action;
    long   CreationTime;
    long   LastModificationTime;
    long   LastChangeTime;
    long   LastAccessTime;
    long   AllocatedLength;
    long   FileSize;
    uint   FileAttributes;
union Anonymous
    {
        uint ReparsePointTag;
        uint EaSize;
    }
    long   FileId;
    long   ParentFileId;
    ushort FileNameLength;
    ubyte  FileNameFlags;
    ubyte  Reserved;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] FileName;
}

struct FILE_STAT_INFORMATION
{
    long FileId;
    long CreationTime;
    long LastAccessTime;
    long LastWriteTime;
    long ChangeTime;
    long AllocationSize;
    long EndOfFile;
    uint FileAttributes;
    uint ReparseTag;
    uint NumberOfLinks;
    uint EffectiveAccess;
}

struct FILE_STAT_LX_INFORMATION
{
    long FileId;
    long CreationTime;
    long LastAccessTime;
    long LastWriteTime;
    long ChangeTime;
    long AllocationSize;
    long EndOfFile;
    uint FileAttributes;
    uint ReparseTag;
    uint NumberOfLinks;
    uint EffectiveAccess;
    uint LxFlags;
    uint LxUid;
    uint LxGid;
    uint LxMode;
    uint LxDeviceIdMajor;
    uint LxDeviceIdMinor;
}

struct FILE_CASE_SENSITIVE_INFORMATION
{
    uint Flags;
}

struct SCRUB_DATA_INPUT
{
    uint        Size;
    uint        Flags;
    uint        MaximumIos;
    uint[4]     ObjectId;
    ulong       StartingByteOffset;
    ulong       ByteCount;
    uint[36]    Reserved;
    ubyte[1040] ResumeContext;
}

struct SCRUB_PARITY_EXTENT
{
    long  Offset;
    ulong Length;
}

struct SCRUB_PARITY_EXTENT_DATA
{
    ushort Size;
    ushort Flags;
    ushort NumberOfParityExtents;
    ushort MaximumNumberOfParityExtents;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SCRUB_PARITY_EXTENT[1] ParityExtents;
}

struct SCRUB_DATA_OUTPUT
{
    uint        Size;
    uint        Flags;
    uint        Status;
    ulong       ErrorFileOffset;
    ulong       ErrorLength;
    ulong       NumberOfBytesRepaired;
    ulong       NumberOfBytesFailed;
    ulong       InternalFileReference;
    ushort      ResumeContextLength;
    ushort      ParityExtentDataOffset;
    ulong       NextStartingByteOffset;
    ulong       ValidDataLength;
    uint[4]     Reserved;
    ulong       NumberOfMetadataBytesProcessed;
    ulong       NumberOfDataBytesProcessed;
    ulong       TotalNumberOfMetadataBytesInUse;
    ulong       TotalNumberOfDataBytesInUse;
    ulong       DataBytesSkippedDueToNoAllocation;
    ulong       DataBytesSkippedDueToInvalidRun;
    ulong       DataBytesSkippedDueToIntegrityStream;
    ulong       DataBytesSkippedDueToRegionBeingClean;
    ulong       DataBytesSkippedDueToLockConflict;
    ulong       DataBytesSkippedDueToNoScrubDataFlag;
    ulong       DataBytesSkippedDueToNoScrubNonIntegrityStreamFlag;
    ulong       DataBytesScrubbed;
    ubyte[1040] ResumeContext;
}

struct SHARED_VIRTUAL_DISK_SUPPORT
{
    SharedVirtualDiskSupportType SharedVirtualDiskSupport;
    SharedVirtualDiskHandleState HandleState;
}

struct REARRANGE_FILE_DATA
{
    ulong  SourceStartingOffset;
    ulong  TargetOffset;
    HANDLE SourceFileHandle;
    uint   Length;
    uint   Flags;
}

struct SHUFFLE_FILE_DATA
{
    long StartingOffset;
    long Length;
    uint Flags;
}

struct NETWORK_APP_INSTANCE_EA
{
    GUID AppInstanceID;
    uint CsvFlags;
}

struct POWER_LIMIT_ATTRIBUTES
{
    POWER_LIMIT_TYPES Type;
    uint              DomainId;
    uint              MaxValue;
    uint              MinValue;
    uint              MinTimeParameter;
    uint              MaxTimeParameter;
    uint              DefaultACValue;
    uint              DefaultDCValue;
union Flags
    {
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(31))], [])*/uint _bitfield128;
        }
        uint AsUlong;
    }
}

struct POWER_LIMIT_VALUE
{
    POWER_LIMIT_TYPES Type;
    uint              DomainId;
    uint              TargetValue;
    uint              TimeParameter;
}

struct NOTIFY_USER_POWER_SETTING
{
    GUID Guid;
}

struct APPLICATIONLAUNCH_SETTING_VALUE
{
    long ActivationTime;
    uint Flags;
    uint ButtonInstanceID;
}

struct PROCESSOR_IDLESTATE_INFO
{
    uint     TimeCheck;
    ubyte    DemotePercent;
    ubyte    PromotePercent;
    ubyte[2] Spare;
}

struct PROCESSOR_IDLESTATE_POLICY
{
    ushort Revision;
union Flags
    {
        ushort AsWORD;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(2)), FixedArgSig(ElementSig(14))], [])*/ushort _bitfield129;
        }
    }
    uint   PolicyCount;
    PROCESSOR_IDLESTATE_INFO[3] Policy;
}

struct PROCESSOR_PERFSTATE_POLICY
{
    uint  Revision;
    ubyte MaxThrottle;
    ubyte MinThrottle;
    ubyte BusyAdjThreshold;
union Anonymous
    {
        ubyte Spare;
union Flags
        {
            ubyte AsBYTE;
struct Anonymous
            {
                /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(5)), FixedArgSig(ElementSig(3))], [])*/ubyte _bitfield130;
            }
        }
    }
    uint  TimeCheck;
    uint  IncreaseTime;
    uint  DecreaseTime;
    uint  IncreasePercent;
    uint  DecreasePercent;
}

struct HIBERFILE_BUCKET
{
    ulong   MaxPhysicalMemory;
    uint[3] PhysicalMemoryPercent;
}

struct SYSTEM_POWER_SOURCE_STATE
{
    SYSTEM_BATTERY_STATE BatteryState;
    uint                 InstantaneousPeakPower;
    uint                 InstantaneousPeakPeriod;
    uint                 SustainablePeakPower;
    uint                 SustainablePeakPeriod;
    uint                 PeakPower;
    uint                 MaxOutputPower;
    uint                 MaxInputPower;
    int                  BatteryRateInCurrent;
    uint                 BatteryVoltage;
}

struct IMAGE_DOS_HEADER
{
align (2):
    ushort     e_magic;
    ushort     e_cblp;
    ushort     e_cp;
    ushort     e_crlc;
    ushort     e_cparhdr;
    ushort     e_minalloc;
    ushort     e_maxalloc;
    ushort     e_ss;
    ushort     e_sp;
    ushort     e_csum;
    ushort     e_ip;
    ushort     e_cs;
    ushort     e_lfarlc;
    ushort     e_ovno;
    ushort[4]  e_res;
    ushort     e_oemid;
    ushort     e_oeminfo;
    ushort[10] e_res2;
    int        e_lfanew;
}

struct IMAGE_OS2_HEADER
{
align (2):
    ushort ne_magic;
    CHAR   ne_ver;
    CHAR   ne_rev;
    ushort ne_enttab;
    ushort ne_cbenttab;
    int    ne_crc;
    ushort ne_flags;
    ushort ne_autodata;
    ushort ne_heap;
    ushort ne_stack;
    int    ne_csip;
    int    ne_sssp;
    ushort ne_cseg;
    ushort ne_cmod;
    ushort ne_cbnrestab;
    ushort ne_segtab;
    ushort ne_rsrctab;
    ushort ne_restab;
    ushort ne_modtab;
    ushort ne_imptab;
    int    ne_nrestab;
    ushort ne_cmovent;
    ushort ne_align;
    ushort ne_cres;
    ubyte  ne_exetyp;
    ubyte  ne_flagsothers;
    ushort ne_pretthunks;
    ushort ne_psegrefbytes;
    ushort ne_swaparea;
    ushort ne_expver;
}

struct IMAGE_VXD_HEADER
{
align (2):
    ushort    e32_magic;
    ubyte     e32_border;
    ubyte     e32_worder;
    uint      e32_level;
    ushort    e32_cpu;
    ushort    e32_os;
    uint      e32_ver;
    uint      e32_mflags;
    uint      e32_mpages;
    uint      e32_startobj;
    uint      e32_eip;
    uint      e32_stackobj;
    uint      e32_esp;
    uint      e32_pagesize;
    uint      e32_lastpagesize;
    uint      e32_fixupsize;
    uint      e32_fixupsum;
    uint      e32_ldrsize;
    uint      e32_ldrsum;
    uint      e32_objtab;
    uint      e32_objcnt;
    uint      e32_objmap;
    uint      e32_itermap;
    uint      e32_rsrctab;
    uint      e32_rsrccnt;
    uint      e32_restab;
    uint      e32_enttab;
    uint      e32_dirtab;
    uint      e32_dircnt;
    uint      e32_fpagetab;
    uint      e32_frectab;
    uint      e32_impmod;
    uint      e32_impmodcnt;
    uint      e32_impproc;
    uint      e32_pagesum;
    uint      e32_datapage;
    uint      e32_preload;
    uint      e32_nrestab;
    uint      e32_cbnrestab;
    uint      e32_nressum;
    uint      e32_autodata;
    uint      e32_debuginfo;
    uint      e32_debuglen;
    uint      e32_instpreload;
    uint      e32_instdemand;
    uint      e32_heapsize;
    ubyte[12] e32_res3;
    uint      e32_winresoff;
    uint      e32_winreslen;
    ushort    e32_devid;
    ushort    e32_ddkver;
}

struct ANON_OBJECT_HEADER
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    GUID   ClassID;
    uint   SizeOfData;
}

struct ANON_OBJECT_HEADER_V2
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    GUID   ClassID;
    uint   SizeOfData;
    uint   Flags;
    uint   MetaDataSize;
    uint   MetaDataOffset;
}

struct ANON_OBJECT_HEADER_BIGOBJ
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    GUID   ClassID;
    uint   SizeOfData;
    uint   Flags;
    uint   MetaDataSize;
    uint   MetaDataOffset;
    uint   NumberOfSections;
    uint   PointerToSymbolTable;
    uint   NumberOfSymbols;
}

struct IMAGE_SYMBOL
{
align (2):
union N
    {
    align (2):
        ubyte[8] ShortName;
struct Name
        {
        align (2):
            uint Short;
            uint Long;
        }
        uint[2]  LongName;
    }
    uint   Value;
    short  SectionNumber;
    ushort Type;
    ubyte  StorageClass;
    ubyte  NumberOfAuxSymbols;
}

struct IMAGE_SYMBOL_EX
{
align (2):
union N
    {
    align (2):
        ubyte[8] ShortName;
struct Name
        {
        align (2):
            uint Short;
            uint Long;
        }
        uint[2]  LongName;
    }
    uint   Value;
    int    SectionNumber;
    ushort Type;
    ubyte  StorageClass;
    ubyte  NumberOfAuxSymbols;
}

struct IMAGE_AUX_SYMBOL_TOKEN_DEF
{
align (2):
    ubyte     bAuxType;
    ubyte     bReserved;
    uint      SymbolTableIndex;
    ubyte[12] rgbReserved;
}

union IMAGE_AUX_SYMBOL
{
struct Sym
    {
    align (2):
        uint   TagIndex;
union Misc
        {
        align (2):
struct LnSz
            {
                ushort Linenumber;
                ushort Size;
            }
            uint            TotalSize;
        }
union FcnAry
        {
struct Function
            {
            align (2):
                uint PointerToLinenumber;
                uint PointerToNextFunction;
            }
struct Array
            {
                ushort[4] Dimension;
            }
        }
        ushort TvIndex;
    }
struct File
    {
        ubyte[18] Name;
    }
struct Section
    {
    align (2):
        uint   Length;
        ushort NumberOfRelocations;
        ushort NumberOfLinenumbers;
        uint   CheckSum;
        short  Number;
        ubyte  Selection;
        ubyte  bReserved;
        short  HighNumber;
    }
    IMAGE_AUX_SYMBOL_TOKEN_DEF TokenDef;
struct CRC
    {
    align (2):
        uint      crc;
        ubyte[14] rgbReserved;
    }
}

union IMAGE_AUX_SYMBOL_EX
{
struct Sym
    {
    align (2):
        uint      WeakDefaultSymIndex;
        uint      WeakSearchType;
        ubyte[12] rgbReserved;
    }
struct File
    {
        ubyte[20] Name;
    }
struct Section
    {
    align (2):
        uint     Length;
        ushort   NumberOfRelocations;
        ushort   NumberOfLinenumbers;
        uint     CheckSum;
        short    Number;
        ubyte    Selection;
        ubyte    bReserved;
        short    HighNumber;
        ubyte[2] rgbReserved;
    }
struct Anonymous
    {
        IMAGE_AUX_SYMBOL_TOKEN_DEF TokenDef;
        ubyte[2] rgbReserved;
    }
struct CRC
    {
    align (2):
        uint      crc;
        ubyte[16] rgbReserved;
    }
}

struct IMAGE_RELOCATION
{
align (2):
union Anonymous
    {
    align (2):
        uint VirtualAddress;
        uint RelocCount;
    }
    uint   SymbolTableIndex;
    ushort Type;
}

struct IMAGE_LINENUMBER
{
union Type
    {
    align (2):
        uint SymbolTableIndex;
        uint VirtualAddress;
    }
    ushort Linenumber;
}

struct IMAGE_BASE_RELOCATION
{
    uint VirtualAddress;
    uint SizeOfBlock;
}

struct IMAGE_ARCHIVE_MEMBER_HEADER
{
    ubyte[16] Name;
    ubyte[12] Date;
    ubyte[6]  UserID;
    ubyte[6]  GroupID;
    ubyte[8]  Mode;
    ubyte[10] Size;
    ubyte[2]  EndHeader;
}

struct IMAGE_EXPORT_DIRECTORY
{
    uint   Characteristics;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint   Name;
    uint   Base;
    uint   NumberOfFunctions;
    uint   NumberOfNames;
    uint   AddressOfFunctions;
    uint   AddressOfNames;
    uint   AddressOfNameOrdinals;
}

struct IMAGE_IMPORT_BY_NAME
{
    ushort Hint;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/CHAR[1] Name;
}

struct IMAGE_TLS_DIRECTORY64
{
align (4):
    ulong StartAddressOfRawData;
    ulong EndAddressOfRawData;
    ulong AddressOfIndex;
    ulong AddressOfCallBacks;
    uint  SizeOfZeroFill;
union Anonymous
    {
        uint Characteristics;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved1)), FixedArgSig(ElementSig(24)), FixedArgSig(ElementSig(8))], [])*/uint _bitfield131;
        }
    }
}

struct IMAGE_TLS_DIRECTORY32
{
    uint StartAddressOfRawData;
    uint EndAddressOfRawData;
    uint AddressOfIndex;
    uint AddressOfCallBacks;
    uint SizeOfZeroFill;
union Anonymous
    {
        uint Characteristics;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved1)), FixedArgSig(ElementSig(24)), FixedArgSig(ElementSig(8))], [])*/uint _bitfield132;
        }
    }
}

struct IMAGE_IMPORT_DESCRIPTOR
{
union Anonymous
    {
        uint Characteristics;
        uint OriginalFirstThunk;
    }
    uint TimeDateStamp;
    uint ForwarderChain;
    uint Name;
    uint FirstThunk;
}

struct IMAGE_BOUND_IMPORT_DESCRIPTOR
{
    uint   TimeDateStamp;
    ushort OffsetModuleName;
    ushort NumberOfModuleForwarderRefs;
}

struct IMAGE_BOUND_FORWARDER_REF
{
    uint   TimeDateStamp;
    ushort OffsetModuleName;
    ushort Reserved;
}

struct IMAGE_RESOURCE_DIRECTORY
{
    uint   Characteristics;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    ushort NumberOfNamedEntries;
    ushort NumberOfIdEntries;
}

struct IMAGE_RESOURCE_DIRECTORY_ENTRY
{
union Anonymous1
    {
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(NameIsString)), FixedArgSig(ElementSig(31)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield133;
        }
        uint   Name;
        ushort Id;
    }
union Anonymous2
    {
        uint OffsetToData;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DataIsDirectory)), FixedArgSig(ElementSig(31)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield134;
        }
    }
}

struct IMAGE_RESOURCE_DIRECTORY_STRING
{
    ushort Length;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/CHAR[1] NameString;
}

struct IMAGE_RESOURCE_DIR_STRING_U
{
    ushort Length;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] NameString;
}

struct IMAGE_RESOURCE_DATA_ENTRY
{
    uint OffsetToData;
    uint Size;
    uint CodePage;
    uint Reserved;
}

struct IMAGE_DYNAMIC_RELOCATION_TABLE
{
    uint Version;
    uint Size;
}

struct IMAGE_DYNAMIC_RELOCATION32
{
align (1):
    uint Symbol;
    uint BaseRelocSize;
}

struct IMAGE_DYNAMIC_RELOCATION64
{
align (1):
    ulong Symbol;
    uint  BaseRelocSize;
}

struct IMAGE_DYNAMIC_RELOCATION32_V2
{
align (1):
    uint HeaderSize;
    uint FixupInfoSize;
    uint Symbol;
    uint SymbolGroup;
    uint Flags;
}

struct IMAGE_DYNAMIC_RELOCATION64_V2
{
align (1):
    uint  HeaderSize;
    uint  FixupInfoSize;
    ulong Symbol;
    uint  SymbolGroup;
    uint  Flags;
}

struct IMAGE_PROLOGUE_DYNAMIC_RELOCATION_HEADER
{
    ubyte PrologueByteCount;
}

struct IMAGE_EPILOGUE_DYNAMIC_RELOCATION_HEADER
{
align (1):
    uint   EpilogueCount;
    ubyte  EpilogueByteCount;
    ubyte  BranchDescriptorElementSize;
    ushort BranchDescriptorCount;
}

struct IMAGE_IMPORT_CONTROL_TRANSFER_DYNAMIC_RELOCATION
{
align (1):
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IATIndex)), FixedArgSig(ElementSig(13)), FixedArgSig(ElementSig(19))], [])*/uint _bitfield135;
}

struct IMAGE_IMPORT_CONTROL_TRANSFER_ARM64_RELOCATION
{
align (1):
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IATIndex)), FixedArgSig(ElementSig(17)), FixedArgSig(ElementSig(15))], [])*/uint _bitfield136;
}

struct IMAGE_INDIR_CONTROL_TRANSFER_DYNAMIC_RELOCATION
{
align (1):
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(15)), FixedArgSig(ElementSig(1))], [])*/ushort _bitfield137;
}

struct IMAGE_SWITCHTABLE_BRANCH_DYNAMIC_RELOCATION
{
align (1):
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(RegisterNumber)), FixedArgSig(ElementSig(12)), FixedArgSig(ElementSig(4))], [])*/ushort _bitfield138;
}

struct IMAGE_FUNCTION_OVERRIDE_HEADER
{
align (1):
    uint FuncOverrideSize;
}

struct IMAGE_FUNCTION_OVERRIDE_DYNAMIC_RELOCATION
{
align (1):
    uint OriginalRva;
    uint BDDOffset;
    uint RvaSize;
    uint BaseRelocSize;
}

struct IMAGE_BDD_INFO
{
align (1):
    uint Version;
    uint BDDSize;
}

struct IMAGE_BDD_DYNAMIC_RELOCATION
{
align (1):
    ushort Left;
    ushort Right;
    uint   Value;
}

struct IMAGE_HOT_PATCH_INFO
{
    uint Version;
    uint Size;
    uint SequenceNumber;
    uint BaseImageList;
    uint BaseImageCount;
    uint BufferOffset;
    uint ExtraPatchSize;
    uint MinSequenceNumber;
    uint Flags;
}

struct IMAGE_HOT_PATCH_BASE
{
    uint SequenceNumber;
    uint Flags;
    uint OriginalTimeDateStamp;
    uint OriginalCheckSum;
    uint CodeIntegrityInfo;
    uint CodeIntegritySize;
    uint PatchTable;
    uint BufferOffset;
}

struct IMAGE_HOT_PATCH_MACHINE
{
struct Anonymous
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Amd64EC)), FixedArgSig(ElementSig(3)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield139;
    }
}

struct IMAGE_HOT_PATCH_HASHES
{
    ubyte[32] SHA256;
    ubyte[20] SHA1;
}

struct IMAGE_CE_RUNTIME_FUNCTION_ENTRY
{
    uint FuncStart;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ExceptionFlag)), FixedArgSig(ElementSig(31)), FixedArgSig(ElementSig(1))], [])*/uint _bitfield140;
}

struct IMAGE_ARM_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
union Anonymous
    {
        uint UnwindData;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(StackAdjust)), FixedArgSig(ElementSig(22)), FixedArgSig(ElementSig(10))], [])*/uint _bitfield141;
        }
    }
}

union IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA
{
    uint HeaderData;
struct Anonymous
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CodeWords)), FixedArgSig(ElementSig(27)), FixedArgSig(ElementSig(5))], [])*/uint _bitfield142;
    }
}

union IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA_EXTENDED
{
    uint ExtendedHeaderData;
struct Anonymous
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ExtendedCodeWords)), FixedArgSig(ElementSig(16)), FixedArgSig(ElementSig(8))], [])*/uint _bitfield143;
    }
}

union IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA_EPILOG_SCOPE
{
    uint EpilogScopeData;
struct Anonymous
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EpilogStartIndex)), FixedArgSig(ElementSig(22)), FixedArgSig(ElementSig(10))], [])*/uint _bitfield144;
    }
}

struct IMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY
{
align (4):
    ulong BeginAddress;
    ulong EndAddress;
    ulong ExceptionHandler;
    ulong HandlerData;
    ulong PrologEndAddress;
}

struct IMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    uint EndAddress;
    uint ExceptionHandler;
    uint HandlerData;
    uint PrologEndAddress;
}

struct IMAGE_DEBUG_MISC
{
    uint     DataType;
    uint     Length;
    BOOLEAN  Unicode;
    ubyte[3] Reserved;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

struct IMAGE_SEPARATE_DEBUG_HEADER
{
    ushort  Signature;
    ushort  Flags;
    ushort  Machine;
    ushort  Characteristics;
    uint    TimeDateStamp;
    uint    CheckSum;
    uint    ImageBase;
    uint    SizeOfImage;
    uint    NumberOfSections;
    uint    ExportedNamesSize;
    uint    DebugDirectorySize;
    uint    SectionAlignment;
    uint[2] Reserved;
}

struct NON_PAGED_DEBUG_INFO
{
align (4):
    ushort Signature;
    ushort Flags;
    uint   Size;
    ushort Machine;
    ushort Characteristics;
    uint   TimeDateStamp;
    uint   CheckSum;
    uint   SizeOfImage;
    ulong  ImageBase;
}

struct IMAGE_ARCHITECTURE_HEADER
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Anonymous2)), FixedArgSig(ElementSig(16)), FixedArgSig(ElementSig(16))], [])*/uint _bitfield145;
    uint FirstEntryRVA;
}

struct IMAGE_ARCHITECTURE_ENTRY
{
    uint FixupInstRVA;
    uint NewInst;
}

struct IMPORT_OBJECT_HEADER
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    uint   SizeOfData;
union Anonymous
    {
        ushort Ordinal;
        ushort Hint;
    }
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(5)), FixedArgSig(ElementSig(11))], [])*/ushort _bitfield146;
}

struct IMAGE_POLICY_ENTRY
{
    IMAGE_POLICY_ENTRY_TYPE Type;
    IMAGE_POLICY_ID PolicyId;
union u
    {
        const(void)* None;
        BOOLEAN      BoolValue;
        byte         Int8Value;
        ubyte        UInt8Value;
        short        Int16Value;
        ushort       UInt16Value;
        int          Int32Value;
        uint         UInt32Value;
        long         Int64Value;
        ulong        UInt64Value;
        const(PSTR)  AnsiStringValue;
        const(PWSTR) UnicodeStringValue;
    }
}

struct IMAGE_POLICY_METADATA
{
    ubyte    Version;
    ubyte[7] Reserved0;
    ulong    ApplicationId;
    IMAGE_POLICY_ENTRY[1] Policies;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-heap_optimize_resources_information))], [])
struct HEAP_OPTIMIZE_RESOURCES_INFORMATION
{
    uint Version;
    uint Flags;
}

struct SUPPORTED_OS_INFO
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct MAXVERSIONTESTED_INFO
{
    ulong MaxVersionTested;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(struct PACKEDEVENTINFO is deprecated and might not work on all platforms. For more info, see MSDN.))], [])
struct PACKEDEVENTINFO
{
    uint    ulSize;
    uint    ulNumEventsForLogFile;
    uint[1] ulOffsets;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_get_drive_parameters))], [])
struct TAPE_GET_DRIVE_PARAMETERS
{
    BOOLEAN ECC;
    BOOLEAN Compression;
    BOOLEAN DataPadding;
    BOOLEAN ReportSetmarks;
    uint    DefaultBlockSize;
    uint    MaximumBlockSize;
    uint    MinimumBlockSize;
    uint    MaximumPartitionCount;
    uint    FeaturesLow;
    TAPE_GET_DRIVE_PARAMETERS_FEATURES_HIGH FeaturesHigh;
    uint    EOTWarningZoneSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_set_drive_parameters))], [])
struct TAPE_SET_DRIVE_PARAMETERS
{
    BOOLEAN ECC;
    BOOLEAN Compression;
    BOOLEAN DataPadding;
    BOOLEAN ReportSetmarks;
    uint    EOTWarningZoneSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_get_media_parameters))], [])
struct TAPE_GET_MEDIA_PARAMETERS
{
    long    Capacity;
    long    Remaining;
    uint    BlockSize;
    uint    PartitionCount;
    BOOLEAN WriteProtected;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-tape_set_media_parameters))], [])
struct TAPE_SET_MEDIA_PARAMETERS
{
    uint BlockSize;
}

struct TAPE_CREATE_PARTITION
{
    uint Method;
    uint Count;
    uint Size;
}

struct TAPE_WMI_OPERATIONS
{
    uint  Method;
    uint  DataBufferSize;
    void* DataBuffer;
}

struct TRANSACTION_BASIC_INFORMATION
{
    GUID TransactionId;
    uint State;
    uint Outcome;
}

struct TRANSACTIONMANAGER_BASIC_INFORMATION
{
    GUID TmIdentity;
    long VirtualClock;
}

struct TRANSACTIONMANAGER_LOG_INFORMATION
{
    GUID LogIdentity;
}

struct TRANSACTIONMANAGER_LOGPATH_INFORMATION
{
    uint LogPathLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] LogPath;
}

struct TRANSACTIONMANAGER_RECOVERY_INFORMATION
{
    ulong LastRecoveredLsn;
}

struct TRANSACTIONMANAGER_OLDEST_INFORMATION
{
    GUID OldestTransactionGuid;
}

struct TRANSACTION_PROPERTIES_INFORMATION
{
    uint IsolationLevel;
    uint IsolationFlags;
    long Timeout;
    uint Outcome;
    uint DescriptionLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] Description;
}

struct TRANSACTION_BIND_INFORMATION
{
    HANDLE TmHandle;
}

struct TRANSACTION_ENLISTMENT_PAIR
{
    GUID EnlistmentId;
    GUID ResourceManagerId;
}

struct TRANSACTION_ENLISTMENTS_INFORMATION
{
    uint NumberOfEnlistments;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/TRANSACTION_ENLISTMENT_PAIR[1] EnlistmentPair;
}

struct TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION
{
    TRANSACTION_ENLISTMENT_PAIR SuperiorEnlistmentPair;
}

struct RESOURCEMANAGER_BASIC_INFORMATION
{
    GUID ResourceManagerId;
    uint DescriptionLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] Description;
}

struct RESOURCEMANAGER_COMPLETION_INFORMATION
{
    HANDLE IoCompletionPortHandle;
    size_t CompletionKey;
}

struct ENLISTMENT_BASIC_INFORMATION
{
    GUID EnlistmentId;
    GUID TransactionId;
    GUID ResourceManagerId;
}

struct ENLISTMENT_CRM_INFORMATION
{
    GUID CrmTransactionManagerId;
    GUID CrmResourceManagerId;
    GUID CrmEnlistmentId;
}

struct TRANSACTION_LIST_ENTRY
{
    GUID UOW;
}

struct TRANSACTION_LIST_INFORMATION
{
    uint NumberOfTransactions;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/TRANSACTION_LIST_ENTRY[1] TransactionInformation;
}

struct KTMOBJECT_CURSOR
{
    GUID LastQuery;
    uint ObjectIdCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/GUID[1] ObjectIds;
}

