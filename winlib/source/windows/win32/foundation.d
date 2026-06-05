// Written in the D programming language.

module windows.win32.foundation;

public import windows.core;

extern(Windows) @nogc nothrow:


// Enums


alias WIN32_ERROR = uint;
enum : uint
{
    NO_ERROR                                                                       = 0x00000000,
    ERROR_EXPECTED_SECTION_NAME                                                    = 0xe0000000,
    ERROR_BAD_SECTION_NAME_LINE                                                    = 0xe0000001,
    ERROR_SECTION_NAME_TOO_LONG                                                    = 0xe0000002,
    ERROR_GENERAL_SYNTAX                                                           = 0xe0000003,
    ERROR_WRONG_INF_STYLE                                                          = 0xe0000100,
    ERROR_SECTION_NOT_FOUND                                                        = 0xe0000101,
    ERROR_LINE_NOT_FOUND                                                           = 0xe0000102,
    ERROR_NO_BACKUP                                                                = 0xe0000103,
    ERROR_NO_ASSOCIATED_CLASS                                                      = 0xe0000200,
    ERROR_CLASS_MISMATCH                                                           = 0xe0000201,
    ERROR_DUPLICATE_FOUND                                                          = 0xe0000202,
    ERROR_NO_DRIVER_SELECTED                                                       = 0xe0000203,
    ERROR_KEY_DOES_NOT_EXIST                                                       = 0xe0000204,
    ERROR_INVALID_DEVINST_NAME                                                     = 0xe0000205,
    ERROR_INVALID_CLASS                                                            = 0xe0000206,
    ERROR_DEVINST_ALREADY_EXISTS                                                   = 0xe0000207,
    ERROR_DEVINFO_NOT_REGISTERED                                                   = 0xe0000208,
    ERROR_INVALID_REG_PROPERTY                                                     = 0xe0000209,
    ERROR_NO_INF                                                                   = 0xe000020a,
    ERROR_NO_SUCH_DEVINST                                                          = 0xe000020b,
    ERROR_CANT_LOAD_CLASS_ICON                                                     = 0xe000020c,
    ERROR_INVALID_CLASS_INSTALLER                                                  = 0xe000020d,
    ERROR_DI_DO_DEFAULT                                                            = 0xe000020e,
    ERROR_DI_NOFILECOPY                                                            = 0xe000020f,
    ERROR_INVALID_HWPROFILE                                                        = 0xe0000210,
    ERROR_NO_DEVICE_SELECTED                                                       = 0xe0000211,
    ERROR_DEVINFO_LIST_LOCKED                                                      = 0xe0000212,
    ERROR_DEVINFO_DATA_LOCKED                                                      = 0xe0000213,
    ERROR_DI_BAD_PATH                                                              = 0xe0000214,
    ERROR_NO_CLASSINSTALL_PARAMS                                                   = 0xe0000215,
    ERROR_FILEQUEUE_LOCKED                                                         = 0xe0000216,
    ERROR_BAD_SERVICE_INSTALLSECT                                                  = 0xe0000217,
    ERROR_NO_CLASS_DRIVER_LIST                                                     = 0xe0000218,
    ERROR_NO_ASSOCIATED_SERVICE                                                    = 0xe0000219,
    ERROR_NO_DEFAULT_DEVICE_INTERFACE                                              = 0xe000021a,
    ERROR_DEVICE_INTERFACE_ACTIVE                                                  = 0xe000021b,
    ERROR_DEVICE_INTERFACE_REMOVED                                                 = 0xe000021c,
    ERROR_BAD_INTERFACE_INSTALLSECT                                                = 0xe000021d,
    ERROR_NO_SUCH_INTERFACE_CLASS                                                  = 0xe000021e,
    ERROR_INVALID_REFERENCE_STRING                                                 = 0xe000021f,
    ERROR_INVALID_MACHINENAME                                                      = 0xe0000220,
    ERROR_REMOTE_COMM_FAILURE                                                      = 0xe0000221,
    ERROR_MACHINE_UNAVAILABLE                                                      = 0xe0000222,
    ERROR_NO_CONFIGMGR_SERVICES                                                    = 0xe0000223,
    ERROR_INVALID_PROPPAGE_PROVIDER                                                = 0xe0000224,
    ERROR_NO_SUCH_DEVICE_INTERFACE                                                 = 0xe0000225,
    ERROR_DI_POSTPROCESSING_REQUIRED                                               = 0xe0000226,
    ERROR_INVALID_COINSTALLER                                                      = 0xe0000227,
    ERROR_NO_COMPAT_DRIVERS                                                        = 0xe0000228,
    ERROR_NO_DEVICE_ICON                                                           = 0xe0000229,
    ERROR_INVALID_INF_LOGCONFIG                                                    = 0xe000022a,
    ERROR_DI_DONT_INSTALL                                                          = 0xe000022b,
    ERROR_INVALID_FILTER_DRIVER                                                    = 0xe000022c,
    ERROR_NON_WINDOWS_NT_DRIVER                                                    = 0xe000022d,
    ERROR_NON_WINDOWS_DRIVER                                                       = 0xe000022e,
    ERROR_NO_CATALOG_FOR_OEM_INF                                                   = 0xe000022f,
    ERROR_DEVINSTALL_QUEUE_NONNATIVE                                               = 0xe0000230,
    ERROR_NOT_DISABLEABLE                                                          = 0xe0000231,
    ERROR_CANT_REMOVE_DEVINST                                                      = 0xe0000232,
    ERROR_INVALID_TARGET                                                           = 0xe0000233,
    ERROR_DRIVER_NONNATIVE                                                         = 0xe0000234,
    ERROR_IN_WOW64                                                                 = 0xe0000235,
    ERROR_SET_SYSTEM_RESTORE_POINT                                                 = 0xe0000236,
    ERROR_SCE_DISABLED                                                             = 0xe0000238,
    ERROR_UNKNOWN_EXCEPTION                                                        = 0xe0000239,
    ERROR_PNP_REGISTRY_ERROR                                                       = 0xe000023a,
    ERROR_REMOTE_REQUEST_UNSUPPORTED                                               = 0xe000023b,
    ERROR_NOT_AN_INSTALLED_OEM_INF                                                 = 0xe000023c,
    ERROR_INF_IN_USE_BY_DEVICES                                                    = 0xe000023d,
    ERROR_DI_FUNCTION_OBSOLETE                                                     = 0xe000023e,
    ERROR_NO_AUTHENTICODE_CATALOG                                                  = 0xe000023f,
    ERROR_AUTHENTICODE_DISALLOWED                                                  = 0xe0000240,
    ERROR_AUTHENTICODE_TRUSTED_PUBLISHER                                           = 0xe0000241,
    ERROR_AUTHENTICODE_TRUST_NOT_ESTABLISHED                                       = 0xe0000242,
    ERROR_AUTHENTICODE_PUBLISHER_NOT_TRUSTED                                       = 0xe0000243,
    ERROR_SIGNATURE_OSATTRIBUTE_MISMATCH                                           = 0xe0000244,
    ERROR_ONLY_VALIDATE_VIA_AUTHENTICODE                                           = 0xe0000245,
    ERROR_DEVICE_INSTALLER_NOT_READY                                               = 0xe0000246,
    ERROR_DRIVER_STORE_ADD_FAILED                                                  = 0xe0000247,
    ERROR_DEVICE_INSTALL_BLOCKED                                                   = 0xe0000248,
    ERROR_DRIVER_INSTALL_BLOCKED                                                   = 0xe0000249,
    ERROR_WRONG_INF_TYPE                                                           = 0xe000024a,
    ERROR_FILE_HASH_NOT_IN_CATALOG                                                 = 0xe000024b,
    ERROR_DRIVER_STORE_DELETE_FAILED                                               = 0xe000024c,
    ERROR_UNRECOVERABLE_STACK_OVERFLOW                                             = 0xe0000300,
    ERROR_NO_DEFAULT_INTERFACE_DEVICE                                              = 0xe000021a,
    ERROR_INTERFACE_DEVICE_ACTIVE                                                  = 0xe000021b,
    ERROR_INTERFACE_DEVICE_REMOVED                                                 = 0xe000021c,
    ERROR_NO_SUCH_INTERFACE_DEVICE                                                 = 0xe0000225,
    ERROR_NOT_INSTALLED                                                            = 0xe0001000,
    ERROR_SUCCESS                                                                  = 0x00000000,
    ERROR_INVALID_FUNCTION                                                         = 0x00000001,
    ERROR_FILE_NOT_FOUND                                                           = 0x00000002,
    ERROR_PATH_NOT_FOUND                                                           = 0x00000003,
    ERROR_TOO_MANY_OPEN_FILES                                                      = 0x00000004,
    ERROR_ACCESS_DENIED                                                            = 0x00000005,
    ERROR_INVALID_HANDLE                                                           = 0x00000006,
    ERROR_ARENA_TRASHED                                                            = 0x00000007,
    ERROR_NOT_ENOUGH_MEMORY                                                        = 0x00000008,
    ERROR_INVALID_BLOCK                                                            = 0x00000009,
    ERROR_BAD_ENVIRONMENT                                                          = 0x0000000a,
    ERROR_BAD_FORMAT                                                               = 0x0000000b,
    ERROR_INVALID_ACCESS                                                           = 0x0000000c,
    ERROR_INVALID_DATA                                                             = 0x0000000d,
    ERROR_OUTOFMEMORY                                                              = 0x0000000e,
    ERROR_INVALID_DRIVE                                                            = 0x0000000f,
    ERROR_CURRENT_DIRECTORY                                                        = 0x00000010,
    ERROR_NOT_SAME_DEVICE                                                          = 0x00000011,
    ERROR_NO_MORE_FILES                                                            = 0x00000012,
    ERROR_WRITE_PROTECT                                                            = 0x00000013,
    ERROR_BAD_UNIT                                                                 = 0x00000014,
    ERROR_NOT_READY                                                                = 0x00000015,
    ERROR_BAD_COMMAND                                                              = 0x00000016,
    ERROR_CRC                                                                      = 0x00000017,
    ERROR_BAD_LENGTH                                                               = 0x00000018,
    ERROR_SEEK                                                                     = 0x00000019,
    ERROR_NOT_DOS_DISK                                                             = 0x0000001a,
    ERROR_SECTOR_NOT_FOUND                                                         = 0x0000001b,
    ERROR_OUT_OF_PAPER                                                             = 0x0000001c,
    ERROR_WRITE_FAULT                                                              = 0x0000001d,
    ERROR_READ_FAULT                                                               = 0x0000001e,
    ERROR_GEN_FAILURE                                                              = 0x0000001f,
    ERROR_SHARING_VIOLATION                                                        = 0x00000020,
    ERROR_LOCK_VIOLATION                                                           = 0x00000021,
    ERROR_WRONG_DISK                                                               = 0x00000022,
    ERROR_SHARING_BUFFER_EXCEEDED                                                  = 0x00000024,
    ERROR_HANDLE_EOF                                                               = 0x00000026,
    ERROR_HANDLE_DISK_FULL                                                         = 0x00000027,
    ERROR_NOT_SUPPORTED                                                            = 0x00000032,
    ERROR_REM_NOT_LIST                                                             = 0x00000033,
    ERROR_DUP_NAME                                                                 = 0x00000034,
    ERROR_BAD_NETPATH                                                              = 0x00000035,
    ERROR_NETWORK_BUSY                                                             = 0x00000036,
    ERROR_DEV_NOT_EXIST                                                            = 0x00000037,
    ERROR_TOO_MANY_CMDS                                                            = 0x00000038,
    ERROR_ADAP_HDW_ERR                                                             = 0x00000039,
    ERROR_BAD_NET_RESP                                                             = 0x0000003a,
    ERROR_UNEXP_NET_ERR                                                            = 0x0000003b,
    ERROR_BAD_REM_ADAP                                                             = 0x0000003c,
    ERROR_PRINTQ_FULL                                                              = 0x0000003d,
    ERROR_NO_SPOOL_SPACE                                                           = 0x0000003e,
    ERROR_PRINT_CANCELLED                                                          = 0x0000003f,
    ERROR_NETNAME_DELETED                                                          = 0x00000040,
    ERROR_NETWORK_ACCESS_DENIED                                                    = 0x00000041,
    ERROR_BAD_DEV_TYPE                                                             = 0x00000042,
    ERROR_BAD_NET_NAME                                                             = 0x00000043,
    ERROR_TOO_MANY_NAMES                                                           = 0x00000044,
    ERROR_TOO_MANY_SESS                                                            = 0x00000045,
    ERROR_SHARING_PAUSED                                                           = 0x00000046,
    ERROR_REQ_NOT_ACCEP                                                            = 0x00000047,
    ERROR_REDIR_PAUSED                                                             = 0x00000048,
    ERROR_FILE_EXISTS                                                              = 0x00000050,
    ERROR_CANNOT_MAKE                                                              = 0x00000052,
    ERROR_FAIL_I24                                                                 = 0x00000053,
    ERROR_OUT_OF_STRUCTURES                                                        = 0x00000054,
    ERROR_ALREADY_ASSIGNED                                                         = 0x00000055,
    ERROR_INVALID_PASSWORD                                                         = 0x00000056,
    ERROR_INVALID_PARAMETER                                                        = 0x00000057,
    ERROR_NET_WRITE_FAULT                                                          = 0x00000058,
    ERROR_NO_PROC_SLOTS                                                            = 0x00000059,
    ERROR_TOO_MANY_SEMAPHORES                                                      = 0x00000064,
    ERROR_EXCL_SEM_ALREADY_OWNED                                                   = 0x00000065,
    ERROR_SEM_IS_SET                                                               = 0x00000066,
    ERROR_TOO_MANY_SEM_REQUESTS                                                    = 0x00000067,
    ERROR_INVALID_AT_INTERRUPT_TIME                                                = 0x00000068,
    ERROR_SEM_OWNER_DIED                                                           = 0x00000069,
    ERROR_SEM_USER_LIMIT                                                           = 0x0000006a,
    ERROR_DISK_CHANGE                                                              = 0x0000006b,
    ERROR_DRIVE_LOCKED                                                             = 0x0000006c,
    ERROR_BROKEN_PIPE                                                              = 0x0000006d,
    ERROR_OPEN_FAILED                                                              = 0x0000006e,
    ERROR_BUFFER_OVERFLOW                                                          = 0x0000006f,
    ERROR_DISK_FULL                                                                = 0x00000070,
    ERROR_NO_MORE_SEARCH_HANDLES                                                   = 0x00000071,
    ERROR_INVALID_TARGET_HANDLE                                                    = 0x00000072,
    ERROR_INVALID_CATEGORY                                                         = 0x00000075,
    ERROR_INVALID_VERIFY_SWITCH                                                    = 0x00000076,
    ERROR_BAD_DRIVER_LEVEL                                                         = 0x00000077,
    ERROR_CALL_NOT_IMPLEMENTED                                                     = 0x00000078,
    ERROR_SEM_TIMEOUT                                                              = 0x00000079,
    ERROR_INSUFFICIENT_BUFFER                                                      = 0x0000007a,
    ERROR_INVALID_NAME                                                             = 0x0000007b,
    ERROR_INVALID_LEVEL                                                            = 0x0000007c,
    ERROR_NO_VOLUME_LABEL                                                          = 0x0000007d,
    ERROR_MOD_NOT_FOUND                                                            = 0x0000007e,
    ERROR_PROC_NOT_FOUND                                                           = 0x0000007f,
    ERROR_WAIT_NO_CHILDREN                                                         = 0x00000080,
    ERROR_CHILD_NOT_COMPLETE                                                       = 0x00000081,
    ERROR_DIRECT_ACCESS_HANDLE                                                     = 0x00000082,
    ERROR_NEGATIVE_SEEK                                                            = 0x00000083,
    ERROR_SEEK_ON_DEVICE                                                           = 0x00000084,
    ERROR_IS_JOIN_TARGET                                                           = 0x00000085,
    ERROR_IS_JOINED                                                                = 0x00000086,
    ERROR_IS_SUBSTED                                                               = 0x00000087,
    ERROR_NOT_JOINED                                                               = 0x00000088,
    ERROR_NOT_SUBSTED                                                              = 0x00000089,
    ERROR_JOIN_TO_JOIN                                                             = 0x0000008a,
    ERROR_SUBST_TO_SUBST                                                           = 0x0000008b,
    ERROR_JOIN_TO_SUBST                                                            = 0x0000008c,
    ERROR_SUBST_TO_JOIN                                                            = 0x0000008d,
    ERROR_BUSY_DRIVE                                                               = 0x0000008e,
    ERROR_SAME_DRIVE                                                               = 0x0000008f,
    ERROR_DIR_NOT_ROOT                                                             = 0x00000090,
    ERROR_DIR_NOT_EMPTY                                                            = 0x00000091,
    ERROR_IS_SUBST_PATH                                                            = 0x00000092,
    ERROR_IS_JOIN_PATH                                                             = 0x00000093,
    ERROR_PATH_BUSY                                                                = 0x00000094,
    ERROR_IS_SUBST_TARGET                                                          = 0x00000095,
    ERROR_SYSTEM_TRACE                                                             = 0x00000096,
    ERROR_INVALID_EVENT_COUNT                                                      = 0x00000097,
    ERROR_TOO_MANY_MUXWAITERS                                                      = 0x00000098,
    ERROR_INVALID_LIST_FORMAT                                                      = 0x00000099,
    ERROR_LABEL_TOO_LONG                                                           = 0x0000009a,
    ERROR_TOO_MANY_TCBS                                                            = 0x0000009b,
    ERROR_SIGNAL_REFUSED                                                           = 0x0000009c,
    ERROR_DISCARDED                                                                = 0x0000009d,
    ERROR_NOT_LOCKED                                                               = 0x0000009e,
    ERROR_BAD_THREADID_ADDR                                                        = 0x0000009f,
    ERROR_BAD_ARGUMENTS                                                            = 0x000000a0,
    ERROR_BAD_PATHNAME                                                             = 0x000000a1,
    ERROR_SIGNAL_PENDING                                                           = 0x000000a2,
    ERROR_MAX_THRDS_REACHED                                                        = 0x000000a4,
    ERROR_LOCK_FAILED                                                              = 0x000000a7,
    ERROR_BUSY                                                                     = 0x000000aa,
    ERROR_DEVICE_SUPPORT_IN_PROGRESS                                               = 0x000000ab,
    ERROR_CANCEL_VIOLATION                                                         = 0x000000ad,
    ERROR_ATOMIC_LOCKS_NOT_SUPPORTED                                               = 0x000000ae,
    ERROR_INVALID_SEGMENT_NUMBER                                                   = 0x000000b4,
    ERROR_INVALID_ORDINAL                                                          = 0x000000b6,
    ERROR_ALREADY_EXISTS                                                           = 0x000000b7,
    ERROR_INVALID_FLAG_NUMBER                                                      = 0x000000ba,
    ERROR_SEM_NOT_FOUND                                                            = 0x000000bb,
    ERROR_INVALID_STARTING_CODESEG                                                 = 0x000000bc,
    ERROR_INVALID_STACKSEG                                                         = 0x000000bd,
    ERROR_INVALID_MODULETYPE                                                       = 0x000000be,
    ERROR_INVALID_EXE_SIGNATURE                                                    = 0x000000bf,
    ERROR_EXE_MARKED_INVALID                                                       = 0x000000c0,
    ERROR_BAD_EXE_FORMAT                                                           = 0x000000c1,
    ERROR_ITERATED_DATA_EXCEEDS_64k                                                = 0x000000c2,
    ERROR_INVALID_MINALLOCSIZE                                                     = 0x000000c3,
    ERROR_DYNLINK_FROM_INVALID_RING                                                = 0x000000c4,
    ERROR_IOPL_NOT_ENABLED                                                         = 0x000000c5,
    ERROR_INVALID_SEGDPL                                                           = 0x000000c6,
    ERROR_AUTODATASEG_EXCEEDS_64k                                                  = 0x000000c7,
    ERROR_RING2SEG_MUST_BE_MOVABLE                                                 = 0x000000c8,
    ERROR_RELOC_CHAIN_XEEDS_SEGLIM                                                 = 0x000000c9,
    ERROR_INFLOOP_IN_RELOC_CHAIN                                                   = 0x000000ca,
    ERROR_ENVVAR_NOT_FOUND                                                         = 0x000000cb,
    ERROR_NO_SIGNAL_SENT                                                           = 0x000000cd,
    ERROR_FILENAME_EXCED_RANGE                                                     = 0x000000ce,
    ERROR_RING2_STACK_IN_USE                                                       = 0x000000cf,
    ERROR_META_EXPANSION_TOO_LONG                                                  = 0x000000d0,
    ERROR_INVALID_SIGNAL_NUMBER                                                    = 0x000000d1,
    ERROR_THREAD_1_INACTIVE                                                        = 0x000000d2,
    ERROR_LOCKED                                                                   = 0x000000d4,
    ERROR_TOO_MANY_MODULES                                                         = 0x000000d6,
    ERROR_NESTING_NOT_ALLOWED                                                      = 0x000000d7,
    ERROR_EXE_MACHINE_TYPE_MISMATCH                                                = 0x000000d8,
    ERROR_EXE_CANNOT_MODIFY_SIGNED_BINARY                                          = 0x000000d9,
    ERROR_EXE_CANNOT_MODIFY_STRONG_SIGNED_BINARY                                   = 0x000000da,
    ERROR_FILE_CHECKED_OUT                                                         = 0x000000dc,
    ERROR_CHECKOUT_REQUIRED                                                        = 0x000000dd,
    ERROR_BAD_FILE_TYPE                                                            = 0x000000de,
    ERROR_FILE_TOO_LARGE                                                           = 0x000000df,
    ERROR_FORMS_AUTH_REQUIRED                                                      = 0x000000e0,
    ERROR_VIRUS_INFECTED                                                           = 0x000000e1,
    ERROR_VIRUS_DELETED                                                            = 0x000000e2,
    ERROR_PIPE_LOCAL                                                               = 0x000000e5,
    ERROR_BAD_PIPE                                                                 = 0x000000e6,
    ERROR_PIPE_BUSY                                                                = 0x000000e7,
    ERROR_NO_DATA                                                                  = 0x000000e8,
    ERROR_PIPE_NOT_CONNECTED                                                       = 0x000000e9,
    ERROR_MORE_DATA                                                                = 0x000000ea,
    ERROR_NO_WORK_DONE                                                             = 0x000000eb,
    ERROR_VC_DISCONNECTED                                                          = 0x000000f0,
    ERROR_INVALID_EA_NAME                                                          = 0x000000fe,
    ERROR_EA_LIST_INCONSISTENT                                                     = 0x000000ff,
    ERROR_NO_MORE_ITEMS                                                            = 0x00000103,
    ERROR_CANNOT_COPY                                                              = 0x0000010a,
    ERROR_DIRECTORY                                                                = 0x0000010b,
    ERROR_EAS_DIDNT_FIT                                                            = 0x00000113,
    ERROR_EA_FILE_CORRUPT                                                          = 0x00000114,
    ERROR_EA_TABLE_FULL                                                            = 0x00000115,
    ERROR_INVALID_EA_HANDLE                                                        = 0x00000116,
    ERROR_EAS_NOT_SUPPORTED                                                        = 0x0000011a,
    ERROR_NOT_OWNER                                                                = 0x00000120,
    ERROR_TOO_MANY_POSTS                                                           = 0x0000012a,
    ERROR_PARTIAL_COPY                                                             = 0x0000012b,
    ERROR_OPLOCK_NOT_GRANTED                                                       = 0x0000012c,
    ERROR_INVALID_OPLOCK_PROTOCOL                                                  = 0x0000012d,
    ERROR_DISK_TOO_FRAGMENTED                                                      = 0x0000012e,
    ERROR_DELETE_PENDING                                                           = 0x0000012f,
    ERROR_INCOMPATIBLE_WITH_GLOBAL_SHORT_NAME_REGISTRY_SETTING                     = 0x00000130,
    ERROR_SHORT_NAMES_NOT_ENABLED_ON_VOLUME                                        = 0x00000131,
    ERROR_SECURITY_STREAM_IS_INCONSISTENT                                          = 0x00000132,
    ERROR_INVALID_LOCK_RANGE                                                       = 0x00000133,
    ERROR_IMAGE_SUBSYSTEM_NOT_PRESENT                                              = 0x00000134,
    ERROR_NOTIFICATION_GUID_ALREADY_DEFINED                                        = 0x00000135,
    ERROR_INVALID_EXCEPTION_HANDLER                                                = 0x00000136,
    ERROR_DUPLICATE_PRIVILEGES                                                     = 0x00000137,
    ERROR_NO_RANGES_PROCESSED                                                      = 0x00000138,
    ERROR_NOT_ALLOWED_ON_SYSTEM_FILE                                               = 0x00000139,
    ERROR_DISK_RESOURCES_EXHAUSTED                                                 = 0x0000013a,
    ERROR_INVALID_TOKEN                                                            = 0x0000013b,
    ERROR_DEVICE_FEATURE_NOT_SUPPORTED                                             = 0x0000013c,
    ERROR_MR_MID_NOT_FOUND                                                         = 0x0000013d,
    ERROR_SCOPE_NOT_FOUND                                                          = 0x0000013e,
    ERROR_UNDEFINED_SCOPE                                                          = 0x0000013f,
    ERROR_INVALID_CAP                                                              = 0x00000140,
    ERROR_DEVICE_UNREACHABLE                                                       = 0x00000141,
    ERROR_DEVICE_NO_RESOURCES                                                      = 0x00000142,
    ERROR_DATA_CHECKSUM_ERROR                                                      = 0x00000143,
    ERROR_INTERMIXED_KERNEL_EA_OPERATION                                           = 0x00000144,
    ERROR_FILE_LEVEL_TRIM_NOT_SUPPORTED                                            = 0x00000146,
    ERROR_OFFSET_ALIGNMENT_VIOLATION                                               = 0x00000147,
    ERROR_INVALID_FIELD_IN_PARAMETER_LIST                                          = 0x00000148,
    ERROR_OPERATION_IN_PROGRESS                                                    = 0x00000149,
    ERROR_BAD_DEVICE_PATH                                                          = 0x0000014a,
    ERROR_TOO_MANY_DESCRIPTORS                                                     = 0x0000014b,
    ERROR_SCRUB_DATA_DISABLED                                                      = 0x0000014c,
    ERROR_NOT_REDUNDANT_STORAGE                                                    = 0x0000014d,
    ERROR_RESIDENT_FILE_NOT_SUPPORTED                                              = 0x0000014e,
    ERROR_COMPRESSED_FILE_NOT_SUPPORTED                                            = 0x0000014f,
    ERROR_DIRECTORY_NOT_SUPPORTED                                                  = 0x00000150,
    ERROR_NOT_READ_FROM_COPY                                                       = 0x00000151,
    ERROR_FT_WRITE_FAILURE                                                         = 0x00000152,
    ERROR_FT_DI_SCAN_REQUIRED                                                      = 0x00000153,
    ERROR_INVALID_KERNEL_INFO_VERSION                                              = 0x00000154,
    ERROR_INVALID_PEP_INFO_VERSION                                                 = 0x00000155,
    ERROR_OBJECT_NOT_EXTERNALLY_BACKED                                             = 0x00000156,
    ERROR_EXTERNAL_BACKING_PROVIDER_UNKNOWN                                        = 0x00000157,
    ERROR_COMPRESSION_NOT_BENEFICIAL                                               = 0x00000158,
    ERROR_STORAGE_TOPOLOGY_ID_MISMATCH                                             = 0x00000159,
    ERROR_BLOCKED_BY_PARENTAL_CONTROLS                                             = 0x0000015a,
    ERROR_BLOCK_TOO_MANY_REFERENCES                                                = 0x0000015b,
    ERROR_MARKED_TO_DISALLOW_WRITES                                                = 0x0000015c,
    ERROR_ENCLAVE_FAILURE                                                          = 0x0000015d,
    ERROR_FAIL_NOACTION_REBOOT                                                     = 0x0000015e,
    ERROR_FAIL_SHUTDOWN                                                            = 0x0000015f,
    ERROR_FAIL_RESTART                                                             = 0x00000160,
    ERROR_MAX_SESSIONS_REACHED                                                     = 0x00000161,
    ERROR_NETWORK_ACCESS_DENIED_EDP                                                = 0x00000162,
    ERROR_DEVICE_HINT_NAME_BUFFER_TOO_SMALL                                        = 0x00000163,
    ERROR_EDP_POLICY_DENIES_OPERATION                                              = 0x00000164,
    ERROR_EDP_DPL_POLICY_CANT_BE_SATISFIED                                         = 0x00000165,
    ERROR_CLOUD_FILE_SYNC_ROOT_METADATA_CORRUPT                                    = 0x00000166,
    ERROR_DEVICE_IN_MAINTENANCE                                                    = 0x00000167,
    ERROR_NOT_SUPPORTED_ON_DAX                                                     = 0x00000168,
    ERROR_DAX_MAPPING_EXISTS                                                       = 0x00000169,
    ERROR_CLOUD_FILE_PROVIDER_NOT_RUNNING                                          = 0x0000016a,
    ERROR_CLOUD_FILE_METADATA_CORRUPT                                              = 0x0000016b,
    ERROR_CLOUD_FILE_METADATA_TOO_LARGE                                            = 0x0000016c,
    ERROR_CLOUD_FILE_PROPERTY_BLOB_TOO_LARGE                                       = 0x0000016d,
    ERROR_CLOUD_FILE_PROPERTY_BLOB_CHECKSUM_MISMATCH                               = 0x0000016e,
    ERROR_CHILD_PROCESS_BLOCKED                                                    = 0x0000016f,
    ERROR_STORAGE_LOST_DATA_PERSISTENCE                                            = 0x00000170,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_UNAVAILABLE                                   = 0x00000171,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_METADATA_CORRUPT                              = 0x00000172,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_BUSY                                          = 0x00000173,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_PROVIDER_UNKNOWN                              = 0x00000174,
    ERROR_GDI_HANDLE_LEAK                                                          = 0x00000175,
    ERROR_CLOUD_FILE_TOO_MANY_PROPERTY_BLOBS                                       = 0x00000176,
    ERROR_CLOUD_FILE_PROPERTY_VERSION_NOT_SUPPORTED                                = 0x00000177,
    ERROR_NOT_A_CLOUD_FILE                                                         = 0x00000178,
    ERROR_CLOUD_FILE_NOT_IN_SYNC                                                   = 0x00000179,
    ERROR_CLOUD_FILE_ALREADY_CONNECTED                                             = 0x0000017a,
    ERROR_CLOUD_FILE_NOT_SUPPORTED                                                 = 0x0000017b,
    ERROR_CLOUD_FILE_INVALID_REQUEST                                               = 0x0000017c,
    ERROR_CLOUD_FILE_READ_ONLY_VOLUME                                              = 0x0000017d,
    ERROR_CLOUD_FILE_CONNECTED_PROVIDER_ONLY                                       = 0x0000017e,
    ERROR_CLOUD_FILE_VALIDATION_FAILED                                             = 0x0000017f,
    ERROR_SMB1_NOT_AVAILABLE                                                       = 0x00000180,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_INVALID_OPERATION                             = 0x00000181,
    ERROR_CLOUD_FILE_AUTHENTICATION_FAILED                                         = 0x00000182,
    ERROR_CLOUD_FILE_INSUFFICIENT_RESOURCES                                        = 0x00000183,
    ERROR_CLOUD_FILE_NETWORK_UNAVAILABLE                                           = 0x00000184,
    ERROR_CLOUD_FILE_UNSUCCESSFUL                                                  = 0x00000185,
    ERROR_CLOUD_FILE_NOT_UNDER_SYNC_ROOT                                           = 0x00000186,
    ERROR_CLOUD_FILE_IN_USE                                                        = 0x00000187,
    ERROR_CLOUD_FILE_PINNED                                                        = 0x00000188,
    ERROR_CLOUD_FILE_REQUEST_ABORTED                                               = 0x00000189,
    ERROR_CLOUD_FILE_PROPERTY_CORRUPT                                              = 0x0000018a,
    ERROR_CLOUD_FILE_ACCESS_DENIED                                                 = 0x0000018b,
    ERROR_CLOUD_FILE_INCOMPATIBLE_HARDLINKS                                        = 0x0000018c,
    ERROR_CLOUD_FILE_PROPERTY_LOCK_CONFLICT                                        = 0x0000018d,
    ERROR_CLOUD_FILE_REQUEST_CANCELED                                              = 0x0000018e,
    ERROR_EXTERNAL_SYSKEY_NOT_SUPPORTED                                            = 0x0000018f,
    ERROR_THREAD_MODE_ALREADY_BACKGROUND                                           = 0x00000190,
    ERROR_THREAD_MODE_NOT_BACKGROUND                                               = 0x00000191,
    ERROR_PROCESS_MODE_ALREADY_BACKGROUND                                          = 0x00000192,
    ERROR_PROCESS_MODE_NOT_BACKGROUND                                              = 0x00000193,
    ERROR_CLOUD_FILE_PROVIDER_TERMINATED                                           = 0x00000194,
    ERROR_NOT_A_CLOUD_SYNC_ROOT                                                    = 0x00000195,
    ERROR_FILE_PROTECTED_UNDER_DPL                                                 = 0x00000196,
    ERROR_VOLUME_NOT_CLUSTER_ALIGNED                                               = 0x00000197,
    ERROR_NO_PHYSICALLY_ALIGNED_FREE_SPACE_FOUND                                   = 0x00000198,
    ERROR_APPX_FILE_NOT_ENCRYPTED                                                  = 0x00000199,
    ERROR_RWRAW_ENCRYPTED_FILE_NOT_ENCRYPTED                                       = 0x0000019a,
    ERROR_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILEOFFSET                             = 0x0000019b,
    ERROR_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILERANGE                              = 0x0000019c,
    ERROR_RWRAW_ENCRYPTED_INVALID_EDATAINFO_PARAMETER                              = 0x0000019d,
    ERROR_LINUX_SUBSYSTEM_NOT_PRESENT                                              = 0x0000019e,
    ERROR_FT_READ_FAILURE                                                          = 0x0000019f,
    ERROR_STORAGE_RESERVE_ID_INVALID                                               = 0x000001a0,
    ERROR_STORAGE_RESERVE_DOES_NOT_EXIST                                           = 0x000001a1,
    ERROR_STORAGE_RESERVE_ALREADY_EXISTS                                           = 0x000001a2,
    ERROR_STORAGE_RESERVE_NOT_EMPTY                                                = 0x000001a3,
    ERROR_NOT_A_DAX_VOLUME                                                         = 0x000001a4,
    ERROR_NOT_DAX_MAPPABLE                                                         = 0x000001a5,
    ERROR_TIME_SENSITIVE_THREAD                                                    = 0x000001a6,
    ERROR_DPL_NOT_SUPPORTED_FOR_USER                                               = 0x000001a7,
    ERROR_CASE_DIFFERING_NAMES_IN_DIR                                              = 0x000001a8,
    ERROR_FILE_NOT_SUPPORTED                                                       = 0x000001a9,
    ERROR_CLOUD_FILE_REQUEST_TIMEOUT                                               = 0x000001aa,
    ERROR_NO_TASK_QUEUE                                                            = 0x000001ab,
    ERROR_SRC_SRV_DLL_LOAD_FAILED                                                  = 0x000001ac,
    ERROR_NOT_SUPPORTED_WITH_BTT                                                   = 0x000001ad,
    ERROR_ENCRYPTION_DISABLED                                                      = 0x000001ae,
    ERROR_ENCRYPTING_METADATA_DISALLOWED                                           = 0x000001af,
    ERROR_CANT_CLEAR_ENCRYPTION_FLAG                                               = 0x000001b0,
    ERROR_NO_SUCH_DEVICE                                                           = 0x000001b1,
    ERROR_CLOUD_FILE_DEHYDRATION_DISALLOWED                                        = 0x000001b2,
    ERROR_FILE_SNAP_IN_PROGRESS                                                    = 0x000001b3,
    ERROR_FILE_SNAP_USER_SECTION_NOT_SUPPORTED                                     = 0x000001b4,
    ERROR_FILE_SNAP_MODIFY_NOT_SUPPORTED                                           = 0x000001b5,
    ERROR_FILE_SNAP_IO_NOT_COORDINATED                                             = 0x000001b6,
    ERROR_FILE_SNAP_UNEXPECTED_ERROR                                               = 0x000001b7,
    ERROR_FILE_SNAP_INVALID_PARAMETER                                              = 0x000001b8,
    ERROR_UNSATISFIED_DEPENDENCIES                                                 = 0x000001b9,
    ERROR_CASE_SENSITIVE_PATH                                                      = 0x000001ba,
    ERROR_UNEXPECTED_NTCACHEMANAGER_ERROR                                          = 0x000001bb,
    ERROR_LINUX_SUBSYSTEM_UPDATE_REQUIRED                                          = 0x000001bc,
    ERROR_DLP_POLICY_WARNS_AGAINST_OPERATION                                       = 0x000001bd,
    ERROR_DLP_POLICY_DENIES_OPERATION                                              = 0x000001be,
    ERROR_SECURITY_DENIES_OPERATION                                                = 0x000001bf,
    ERROR_UNTRUSTED_MOUNT_POINT                                                    = 0x000001c0,
    ERROR_DLP_POLICY_SILENTLY_FAIL                                                 = 0x000001c1,
    ERROR_CAPAUTHZ_NOT_DEVUNLOCKED                                                 = 0x000001c2,
    ERROR_CAPAUTHZ_CHANGE_TYPE                                                     = 0x000001c3,
    ERROR_CAPAUTHZ_NOT_PROVISIONED                                                 = 0x000001c4,
    ERROR_CAPAUTHZ_NOT_AUTHORIZED                                                  = 0x000001c5,
    ERROR_CAPAUTHZ_NO_POLICY                                                       = 0x000001c6,
    ERROR_CAPAUTHZ_DB_CORRUPTED                                                    = 0x000001c7,
    ERROR_CAPAUTHZ_SCCD_INVALID_CATALOG                                            = 0x000001c8,
    ERROR_CAPAUTHZ_SCCD_NO_AUTH_ENTITY                                             = 0x000001c9,
    ERROR_CAPAUTHZ_SCCD_PARSE_ERROR                                                = 0x000001ca,
    ERROR_CAPAUTHZ_SCCD_DEV_MODE_REQUIRED                                          = 0x000001cb,
    ERROR_CAPAUTHZ_SCCD_NO_CAPABILITY_MATCH                                        = 0x000001cc,
    ERROR_CIMFS_IMAGE_CORRUPT                                                      = 0x000001d6,
    ERROR_CIMFS_IMAGE_VERSION_NOT_SUPPORTED                                        = 0x000001d7,
    ERROR_STORAGE_STACK_ACCESS_DENIED                                              = 0x000001d8,
    ERROR_INSUFFICIENT_VIRTUAL_ADDR_RESOURCES                                      = 0x000001d9,
    ERROR_INDEX_OUT_OF_BOUNDS                                                      = 0x000001da,
    ERROR_CLOUD_FILE_US_MESSAGE_TIMEOUT                                            = 0x000001db,
    ERROR_NOT_A_DEV_VOLUME                                                         = 0x000001dc,
    ERROR_FS_GUID_MISMATCH                                                         = 0x000001dd,
    ERROR_CANT_ATTACH_TO_DEV_VOLUME                                                = 0x000001de,
    ERROR_MEMORY_DECOMPRESSION_FAILURE                                             = 0x000001df,
    ERROR_PNP_QUERY_REMOVE_DEVICE_TIMEOUT                                          = 0x000001e0,
    ERROR_PNP_QUERY_REMOVE_RELATED_DEVICE_TIMEOUT                                  = 0x000001e1,
    ERROR_PNP_QUERY_REMOVE_UNRELATED_DEVICE_TIMEOUT                                = 0x000001e2,
    ERROR_DEVICE_HARDWARE_ERROR                                                    = 0x000001e3,
    ERROR_INVALID_ADDRESS                                                          = 0x000001e7,
    ERROR_HAS_SYSTEM_CRITICAL_FILES                                                = 0x000001e8,
    ERROR_ENCRYPTED_FILE_NOT_SUPPORTED                                             = 0x000001e9,
    ERROR_SPARSE_FILE_NOT_SUPPORTED                                                = 0x000001ea,
    ERROR_PAGEFILE_NOT_SUPPORTED                                                   = 0x000001eb,
    ERROR_VOLUME_NOT_SUPPORTED                                                     = 0x000001ec,
    ERROR_NOT_SUPPORTED_WITH_BYPASSIO                                              = 0x000001ed,
    ERROR_NO_BYPASSIO_DRIVER_SUPPORT                                               = 0x000001ee,
    ERROR_NOT_SUPPORTED_WITH_ENCRYPTION                                            = 0x000001ef,
    ERROR_NOT_SUPPORTED_WITH_COMPRESSION                                           = 0x000001f0,
    ERROR_NOT_SUPPORTED_WITH_REPLICATION                                           = 0x000001f1,
    ERROR_NOT_SUPPORTED_WITH_DEDUPLICATION                                         = 0x000001f2,
    ERROR_NOT_SUPPORTED_WITH_AUDITING                                              = 0x000001f3,
    ERROR_USER_PROFILE_LOAD                                                        = 0x000001f4,
    ERROR_SESSION_KEY_TOO_SHORT                                                    = 0x000001f5,
    ERROR_ACCESS_DENIED_APPDATA                                                    = 0x000001f6,
    ERROR_NOT_SUPPORTED_WITH_MONITORING                                            = 0x000001f7,
    ERROR_NOT_SUPPORTED_WITH_SNAPSHOT                                              = 0x000001f8,
    ERROR_NOT_SUPPORTED_WITH_VIRTUALIZATION                                        = 0x000001f9,
    ERROR_BYPASSIO_FLT_NOT_SUPPORTED                                               = 0x000001fa,
    ERROR_DEVICE_RESET_REQUIRED                                                    = 0x000001fb,
    ERROR_VOLUME_WRITE_ACCESS_DENIED                                               = 0x000001fc,
    ERROR_NOT_SUPPORTED_WITH_CACHED_HANDLE                                         = 0x000001fd,
    ERROR_FS_METADATA_INCONSISTENT                                                 = 0x000001fe,
    ERROR_BLOCK_WEAK_REFERENCE_INVALID                                             = 0x000001ff,
    ERROR_BLOCK_SOURCE_WEAK_REFERENCE_INVALID                                      = 0x00000200,
    ERROR_BLOCK_TARGET_WEAK_REFERENCE_INVALID                                      = 0x00000201,
    ERROR_BLOCK_SHARED                                                             = 0x00000202,
    ERROR_VOLUME_UPGRADE_NOT_NEEDED                                                = 0x00000203,
    ERROR_VOLUME_UPGRADE_PENDING                                                   = 0x00000204,
    ERROR_VOLUME_UPGRADE_DISABLED                                                  = 0x00000205,
    ERROR_VOLUME_UPGRADE_DISABLED_TILL_OS_DOWNGRADE_EXPIRED                        = 0x00000206,
    ERROR_INVALID_CONFIG_VALUE                                                     = 0x00000207,
    ERROR_MEMORY_DECOMPRESSION_HW_ERROR                                            = 0x00000208,
    ERROR_VOLUME_ROLLBACK_DETECTED                                                 = 0x00000209,
    ERROR_CLOUD_FILE_HYDRATION_NOT_AVAILABLE                                       = 0x0000020b,
    ERROR_SYSTEM_FILE_NOT_SUPPORTED                                                = 0x0000020d,
    ERROR_ARITHMETIC_OVERFLOW                                                      = 0x00000216,
    ERROR_PIPE_CONNECTED                                                           = 0x00000217,
    ERROR_PIPE_LISTENING                                                           = 0x00000218,
    ERROR_VERIFIER_STOP                                                            = 0x00000219,
    ERROR_ABIOS_ERROR                                                              = 0x0000021a,
    ERROR_WX86_WARNING                                                             = 0x0000021b,
    ERROR_WX86_ERROR                                                               = 0x0000021c,
    ERROR_TIMER_NOT_CANCELED                                                       = 0x0000021d,
    ERROR_UNWIND                                                                   = 0x0000021e,
    ERROR_BAD_STACK                                                                = 0x0000021f,
    ERROR_INVALID_UNWIND_TARGET                                                    = 0x00000220,
    ERROR_INVALID_PORT_ATTRIBUTES                                                  = 0x00000221,
    ERROR_PORT_MESSAGE_TOO_LONG                                                    = 0x00000222,
    ERROR_INVALID_QUOTA_LOWER                                                      = 0x00000223,
    ERROR_DEVICE_ALREADY_ATTACHED                                                  = 0x00000224,
    ERROR_INSTRUCTION_MISALIGNMENT                                                 = 0x00000225,
    ERROR_PROFILING_NOT_STARTED                                                    = 0x00000226,
    ERROR_PROFILING_NOT_STOPPED                                                    = 0x00000227,
    ERROR_COULD_NOT_INTERPRET                                                      = 0x00000228,
    ERROR_PROFILING_AT_LIMIT                                                       = 0x00000229,
    ERROR_CANT_WAIT                                                                = 0x0000022a,
    ERROR_CANT_TERMINATE_SELF                                                      = 0x0000022b,
    ERROR_UNEXPECTED_MM_CREATE_ERR                                                 = 0x0000022c,
    ERROR_UNEXPECTED_MM_MAP_ERROR                                                  = 0x0000022d,
    ERROR_UNEXPECTED_MM_EXTEND_ERR                                                 = 0x0000022e,
    ERROR_BAD_FUNCTION_TABLE                                                       = 0x0000022f,
    ERROR_NO_GUID_TRANSLATION                                                      = 0x00000230,
    ERROR_INVALID_LDT_SIZE                                                         = 0x00000231,
    ERROR_INVALID_LDT_OFFSET                                                       = 0x00000233,
    ERROR_INVALID_LDT_DESCRIPTOR                                                   = 0x00000234,
    ERROR_TOO_MANY_THREADS                                                         = 0x00000235,
    ERROR_THREAD_NOT_IN_PROCESS                                                    = 0x00000236,
    ERROR_PAGEFILE_QUOTA_EXCEEDED                                                  = 0x00000237,
    ERROR_LOGON_SERVER_CONFLICT                                                    = 0x00000238,
    ERROR_SYNCHRONIZATION_REQUIRED                                                 = 0x00000239,
    ERROR_NET_OPEN_FAILED                                                          = 0x0000023a,
    ERROR_IO_PRIVILEGE_FAILED                                                      = 0x0000023b,
    ERROR_CONTROL_C_EXIT                                                           = 0x0000023c,
    ERROR_MISSING_SYSTEMFILE                                                       = 0x0000023d,
    ERROR_UNHANDLED_EXCEPTION                                                      = 0x0000023e,
    ERROR_APP_INIT_FAILURE                                                         = 0x0000023f,
    ERROR_PAGEFILE_CREATE_FAILED                                                   = 0x00000240,
    ERROR_INVALID_IMAGE_HASH                                                       = 0x00000241,
    ERROR_NO_PAGEFILE                                                              = 0x00000242,
    ERROR_ILLEGAL_FLOAT_CONTEXT                                                    = 0x00000243,
    ERROR_NO_EVENT_PAIR                                                            = 0x00000244,
    ERROR_DOMAIN_CTRLR_CONFIG_ERROR                                                = 0x00000245,
    ERROR_ILLEGAL_CHARACTER                                                        = 0x00000246,
    ERROR_UNDEFINED_CHARACTER                                                      = 0x00000247,
    ERROR_FLOPPY_VOLUME                                                            = 0x00000248,
    ERROR_BIOS_FAILED_TO_CONNECT_INTERRUPT                                         = 0x00000249,
    ERROR_BACKUP_CONTROLLER                                                        = 0x0000024a,
    ERROR_MUTANT_LIMIT_EXCEEDED                                                    = 0x0000024b,
    ERROR_FS_DRIVER_REQUIRED                                                       = 0x0000024c,
    ERROR_CANNOT_LOAD_REGISTRY_FILE                                                = 0x0000024d,
    ERROR_DEBUG_ATTACH_FAILED                                                      = 0x0000024e,
    ERROR_SYSTEM_PROCESS_TERMINATED                                                = 0x0000024f,
    ERROR_DATA_NOT_ACCEPTED                                                        = 0x00000250,
    ERROR_VDM_HARD_ERROR                                                           = 0x00000251,
    ERROR_DRIVER_CANCEL_TIMEOUT                                                    = 0x00000252,
    ERROR_REPLY_MESSAGE_MISMATCH                                                   = 0x00000253,
    ERROR_LOST_WRITEBEHIND_DATA                                                    = 0x00000254,
    ERROR_CLIENT_SERVER_PARAMETERS_INVALID                                         = 0x00000255,
    ERROR_NOT_TINY_STREAM                                                          = 0x00000256,
    ERROR_STACK_OVERFLOW_READ                                                      = 0x00000257,
    ERROR_CONVERT_TO_LARGE                                                         = 0x00000258,
    ERROR_FOUND_OUT_OF_SCOPE                                                       = 0x00000259,
    ERROR_ALLOCATE_BUCKET                                                          = 0x0000025a,
    ERROR_MARSHALL_OVERFLOW                                                        = 0x0000025b,
    ERROR_INVALID_VARIANT                                                          = 0x0000025c,
    ERROR_BAD_COMPRESSION_BUFFER                                                   = 0x0000025d,
    ERROR_AUDIT_FAILED                                                             = 0x0000025e,
    ERROR_TIMER_RESOLUTION_NOT_SET                                                 = 0x0000025f,
    ERROR_INSUFFICIENT_LOGON_INFO                                                  = 0x00000260,
    ERROR_BAD_DLL_ENTRYPOINT                                                       = 0x00000261,
    ERROR_BAD_SERVICE_ENTRYPOINT                                                   = 0x00000262,
    ERROR_IP_ADDRESS_CONFLICT1                                                     = 0x00000263,
    ERROR_IP_ADDRESS_CONFLICT2                                                     = 0x00000264,
    ERROR_REGISTRY_QUOTA_LIMIT                                                     = 0x00000265,
    ERROR_NO_CALLBACK_ACTIVE                                                       = 0x00000266,
    ERROR_PWD_TOO_SHORT                                                            = 0x00000267,
    ERROR_PWD_TOO_RECENT                                                           = 0x00000268,
    ERROR_PWD_HISTORY_CONFLICT                                                     = 0x00000269,
    ERROR_UNSUPPORTED_COMPRESSION                                                  = 0x0000026a,
    ERROR_INVALID_HW_PROFILE                                                       = 0x0000026b,
    ERROR_INVALID_PLUGPLAY_DEVICE_PATH                                             = 0x0000026c,
    ERROR_QUOTA_LIST_INCONSISTENT                                                  = 0x0000026d,
    ERROR_EVALUATION_EXPIRATION                                                    = 0x0000026e,
    ERROR_ILLEGAL_DLL_RELOCATION                                                   = 0x0000026f,
    ERROR_DLL_INIT_FAILED_LOGOFF                                                   = 0x00000270,
    ERROR_VALIDATE_CONTINUE                                                        = 0x00000271,
    ERROR_NO_MORE_MATCHES                                                          = 0x00000272,
    ERROR_RANGE_LIST_CONFLICT                                                      = 0x00000273,
    ERROR_SERVER_SID_MISMATCH                                                      = 0x00000274,
    ERROR_CANT_ENABLE_DENY_ONLY                                                    = 0x00000275,
    ERROR_FLOAT_MULTIPLE_FAULTS                                                    = 0x00000276,
    ERROR_FLOAT_MULTIPLE_TRAPS                                                     = 0x00000277,
    ERROR_NOINTERFACE                                                              = 0x00000278,
    ERROR_DRIVER_FAILED_SLEEP                                                      = 0x00000279,
    ERROR_CORRUPT_SYSTEM_FILE                                                      = 0x0000027a,
    ERROR_COMMITMENT_MINIMUM                                                       = 0x0000027b,
    ERROR_PNP_RESTART_ENUMERATION                                                  = 0x0000027c,
    ERROR_SYSTEM_IMAGE_BAD_SIGNATURE                                               = 0x0000027d,
    ERROR_PNP_REBOOT_REQUIRED                                                      = 0x0000027e,
    ERROR_INSUFFICIENT_POWER                                                       = 0x0000027f,
    ERROR_MULTIPLE_FAULT_VIOLATION                                                 = 0x00000280,
    ERROR_SYSTEM_SHUTDOWN                                                          = 0x00000281,
    ERROR_PORT_NOT_SET                                                             = 0x00000282,
    ERROR_DS_VERSION_CHECK_FAILURE                                                 = 0x00000283,
    ERROR_RANGE_NOT_FOUND                                                          = 0x00000284,
    ERROR_NOT_SAFE_MODE_DRIVER                                                     = 0x00000286,
    ERROR_FAILED_DRIVER_ENTRY                                                      = 0x00000287,
    ERROR_DEVICE_ENUMERATION_ERROR                                                 = 0x00000288,
    ERROR_MOUNT_POINT_NOT_RESOLVED                                                 = 0x00000289,
    ERROR_INVALID_DEVICE_OBJECT_PARAMETER                                          = 0x0000028a,
    ERROR_MCA_OCCURED                                                              = 0x0000028b,
    ERROR_DRIVER_DATABASE_ERROR                                                    = 0x0000028c,
    ERROR_SYSTEM_HIVE_TOO_LARGE                                                    = 0x0000028d,
    ERROR_DRIVER_FAILED_PRIOR_UNLOAD                                               = 0x0000028e,
    ERROR_VOLSNAP_PREPARE_HIBERNATE                                                = 0x0000028f,
    ERROR_HIBERNATION_FAILURE                                                      = 0x00000290,
    ERROR_PWD_TOO_LONG                                                             = 0x00000291,
    ERROR_FILE_SYSTEM_LIMITATION                                                   = 0x00000299,
    ERROR_ASSERTION_FAILURE                                                        = 0x0000029c,
    ERROR_ACPI_ERROR                                                               = 0x0000029d,
    ERROR_WOW_ASSERTION                                                            = 0x0000029e,
    ERROR_PNP_BAD_MPS_TABLE                                                        = 0x0000029f,
    ERROR_PNP_TRANSLATION_FAILED                                                   = 0x000002a0,
    ERROR_PNP_IRQ_TRANSLATION_FAILED                                               = 0x000002a1,
    ERROR_PNP_INVALID_ID                                                           = 0x000002a2,
    ERROR_WAKE_SYSTEM_DEBUGGER                                                     = 0x000002a3,
    ERROR_HANDLES_CLOSED                                                           = 0x000002a4,
    ERROR_EXTRANEOUS_INFORMATION                                                   = 0x000002a5,
    ERROR_RXACT_COMMIT_NECESSARY                                                   = 0x000002a6,
    ERROR_MEDIA_CHECK                                                              = 0x000002a7,
    ERROR_GUID_SUBSTITUTION_MADE                                                   = 0x000002a8,
    ERROR_STOPPED_ON_SYMLINK                                                       = 0x000002a9,
    ERROR_LONGJUMP                                                                 = 0x000002aa,
    ERROR_PLUGPLAY_QUERY_VETOED                                                    = 0x000002ab,
    ERROR_UNWIND_CONSOLIDATE                                                       = 0x000002ac,
    ERROR_REGISTRY_HIVE_RECOVERED                                                  = 0x000002ad,
    ERROR_DLL_MIGHT_BE_INSECURE                                                    = 0x000002ae,
    ERROR_DLL_MIGHT_BE_INCOMPATIBLE                                                = 0x000002af,
    ERROR_DBG_EXCEPTION_NOT_HANDLED                                                = 0x000002b0,
    ERROR_DBG_REPLY_LATER                                                          = 0x000002b1,
    ERROR_DBG_UNABLE_TO_PROVIDE_HANDLE                                             = 0x000002b2,
    ERROR_DBG_TERMINATE_THREAD                                                     = 0x000002b3,
    ERROR_DBG_TERMINATE_PROCESS                                                    = 0x000002b4,
    ERROR_DBG_CONTROL_C                                                            = 0x000002b5,
    ERROR_DBG_PRINTEXCEPTION_C                                                     = 0x000002b6,
    ERROR_DBG_RIPEXCEPTION                                                         = 0x000002b7,
    ERROR_DBG_CONTROL_BREAK                                                        = 0x000002b8,
    ERROR_DBG_COMMAND_EXCEPTION                                                    = 0x000002b9,
    ERROR_OBJECT_NAME_EXISTS                                                       = 0x000002ba,
    ERROR_THREAD_WAS_SUSPENDED                                                     = 0x000002bb,
    ERROR_IMAGE_NOT_AT_BASE                                                        = 0x000002bc,
    ERROR_RXACT_STATE_CREATED                                                      = 0x000002bd,
    ERROR_SEGMENT_NOTIFICATION                                                     = 0x000002be,
    ERROR_BAD_CURRENT_DIRECTORY                                                    = 0x000002bf,
    ERROR_FT_READ_RECOVERY_FROM_BACKUP                                             = 0x000002c0,
    ERROR_FT_WRITE_RECOVERY                                                        = 0x000002c1,
    ERROR_IMAGE_MACHINE_TYPE_MISMATCH                                              = 0x000002c2,
    ERROR_RECEIVE_PARTIAL                                                          = 0x000002c3,
    ERROR_RECEIVE_EXPEDITED                                                        = 0x000002c4,
    ERROR_RECEIVE_PARTIAL_EXPEDITED                                                = 0x000002c5,
    ERROR_EVENT_DONE                                                               = 0x000002c6,
    ERROR_EVENT_PENDING                                                            = 0x000002c7,
    ERROR_CHECKING_FILE_SYSTEM                                                     = 0x000002c8,
    ERROR_FATAL_APP_EXIT                                                           = 0x000002c9,
    ERROR_PREDEFINED_HANDLE                                                        = 0x000002ca,
    ERROR_WAS_UNLOCKED                                                             = 0x000002cb,
    ERROR_SERVICE_NOTIFICATION                                                     = 0x000002cc,
    ERROR_WAS_LOCKED                                                               = 0x000002cd,
    ERROR_LOG_HARD_ERROR                                                           = 0x000002ce,
    ERROR_ALREADY_WIN32                                                            = 0x000002cf,
    ERROR_IMAGE_MACHINE_TYPE_MISMATCH_EXE                                          = 0x000002d0,
    ERROR_NO_YIELD_PERFORMED                                                       = 0x000002d1,
    ERROR_TIMER_RESUME_IGNORED                                                     = 0x000002d2,
    ERROR_ARBITRATION_UNHANDLED                                                    = 0x000002d3,
    ERROR_CARDBUS_NOT_SUPPORTED                                                    = 0x000002d4,
    ERROR_MP_PROCESSOR_MISMATCH                                                    = 0x000002d5,
    ERROR_HIBERNATED                                                               = 0x000002d6,
    ERROR_RESUME_HIBERNATION                                                       = 0x000002d7,
    ERROR_FIRMWARE_UPDATED                                                         = 0x000002d8,
    ERROR_DRIVERS_LEAKING_LOCKED_PAGES                                             = 0x000002d9,
    ERROR_WAKE_SYSTEM                                                              = 0x000002da,
    ERROR_WAIT_1                                                                   = 0x000002db,
    ERROR_WAIT_2                                                                   = 0x000002dc,
    ERROR_WAIT_3                                                                   = 0x000002dd,
    ERROR_WAIT_63                                                                  = 0x000002de,
    ERROR_ABANDONED_WAIT_0                                                         = 0x000002df,
    ERROR_ABANDONED_WAIT_63                                                        = 0x000002e0,
    ERROR_USER_APC                                                                 = 0x000002e1,
    ERROR_KERNEL_APC                                                               = 0x000002e2,
    ERROR_ALERTED                                                                  = 0x000002e3,
    ERROR_ELEVATION_REQUIRED                                                       = 0x000002e4,
    ERROR_REPARSE                                                                  = 0x000002e5,
    ERROR_OPLOCK_BREAK_IN_PROGRESS                                                 = 0x000002e6,
    ERROR_VOLUME_MOUNTED                                                           = 0x000002e7,
    ERROR_RXACT_COMMITTED                                                          = 0x000002e8,
    ERROR_NOTIFY_CLEANUP                                                           = 0x000002e9,
    ERROR_PRIMARY_TRANSPORT_CONNECT_FAILED                                         = 0x000002ea,
    ERROR_PAGE_FAULT_TRANSITION                                                    = 0x000002eb,
    ERROR_PAGE_FAULT_DEMAND_ZERO                                                   = 0x000002ec,
    ERROR_PAGE_FAULT_COPY_ON_WRITE                                                 = 0x000002ed,
    ERROR_PAGE_FAULT_GUARD_PAGE                                                    = 0x000002ee,
    ERROR_PAGE_FAULT_PAGING_FILE                                                   = 0x000002ef,
    ERROR_CACHE_PAGE_LOCKED                                                        = 0x000002f0,
    ERROR_CRASH_DUMP                                                               = 0x000002f1,
    ERROR_BUFFER_ALL_ZEROS                                                         = 0x000002f2,
    ERROR_REPARSE_OBJECT                                                           = 0x000002f3,
    ERROR_RESOURCE_REQUIREMENTS_CHANGED                                            = 0x000002f4,
    ERROR_TRANSLATION_COMPLETE                                                     = 0x000002f5,
    ERROR_NOTHING_TO_TERMINATE                                                     = 0x000002f6,
    ERROR_PROCESS_NOT_IN_JOB                                                       = 0x000002f7,
    ERROR_PROCESS_IN_JOB                                                           = 0x000002f8,
    ERROR_VOLSNAP_HIBERNATE_READY                                                  = 0x000002f9,
    ERROR_FSFILTER_OP_COMPLETED_SUCCESSFULLY                                       = 0x000002fa,
    ERROR_INTERRUPT_VECTOR_ALREADY_CONNECTED                                       = 0x000002fb,
    ERROR_INTERRUPT_STILL_CONNECTED                                                = 0x000002fc,
    ERROR_WAIT_FOR_OPLOCK                                                          = 0x000002fd,
    ERROR_DBG_EXCEPTION_HANDLED                                                    = 0x000002fe,
    ERROR_DBG_CONTINUE                                                             = 0x000002ff,
    ERROR_CALLBACK_POP_STACK                                                       = 0x00000300,
    ERROR_COMPRESSION_DISABLED                                                     = 0x00000301,
    ERROR_CANTFETCHBACKWARDS                                                       = 0x00000302,
    ERROR_CANTSCROLLBACKWARDS                                                      = 0x00000303,
    ERROR_ROWSNOTRELEASED                                                          = 0x00000304,
    ERROR_BAD_ACCESSOR_FLAGS                                                       = 0x00000305,
    ERROR_ERRORS_ENCOUNTERED                                                       = 0x00000306,
    ERROR_NOT_CAPABLE                                                              = 0x00000307,
    ERROR_REQUEST_OUT_OF_SEQUENCE                                                  = 0x00000308,
    ERROR_VERSION_PARSE_ERROR                                                      = 0x00000309,
    ERROR_BADSTARTPOSITION                                                         = 0x0000030a,
    ERROR_MEMORY_HARDWARE                                                          = 0x0000030b,
    ERROR_DISK_REPAIR_DISABLED                                                     = 0x0000030c,
    ERROR_INSUFFICIENT_RESOURCE_FOR_SPECIFIED_SHARED_SECTION_SIZE                  = 0x0000030d,
    ERROR_SYSTEM_POWERSTATE_TRANSITION                                             = 0x0000030e,
    ERROR_SYSTEM_POWERSTATE_COMPLEX_TRANSITION                                     = 0x0000030f,
    ERROR_MCA_EXCEPTION                                                            = 0x00000310,
    ERROR_ACCESS_AUDIT_BY_POLICY                                                   = 0x00000311,
    ERROR_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY                                    = 0x00000312,
    ERROR_ABANDON_HIBERFILE                                                        = 0x00000313,
    ERROR_LOST_WRITEBEHIND_DATA_NETWORK_DISCONNECTED                               = 0x00000314,
    ERROR_LOST_WRITEBEHIND_DATA_NETWORK_SERVER_ERROR                               = 0x00000315,
    ERROR_LOST_WRITEBEHIND_DATA_LOCAL_DISK_ERROR                                   = 0x00000316,
    ERROR_BAD_MCFG_TABLE                                                           = 0x00000317,
    ERROR_DISK_REPAIR_REDIRECTED                                                   = 0x00000318,
    ERROR_DISK_REPAIR_UNSUCCESSFUL                                                 = 0x00000319,
    ERROR_CORRUPT_LOG_OVERFULL                                                     = 0x0000031a,
    ERROR_CORRUPT_LOG_CORRUPTED                                                    = 0x0000031b,
    ERROR_CORRUPT_LOG_UNAVAILABLE                                                  = 0x0000031c,
    ERROR_CORRUPT_LOG_DELETED_FULL                                                 = 0x0000031d,
    ERROR_CORRUPT_LOG_CLEARED                                                      = 0x0000031e,
    ERROR_ORPHAN_NAME_EXHAUSTED                                                    = 0x0000031f,
    ERROR_OPLOCK_SWITCHED_TO_NEW_HANDLE                                            = 0x00000320,
    ERROR_CANNOT_GRANT_REQUESTED_OPLOCK                                            = 0x00000321,
    ERROR_CANNOT_BREAK_OPLOCK                                                      = 0x00000322,
    ERROR_OPLOCK_HANDLE_CLOSED                                                     = 0x00000323,
    ERROR_NO_ACE_CONDITION                                                         = 0x00000324,
    ERROR_INVALID_ACE_CONDITION                                                    = 0x00000325,
    ERROR_FILE_HANDLE_REVOKED                                                      = 0x00000326,
    ERROR_IMAGE_AT_DIFFERENT_BASE                                                  = 0x00000327,
    ERROR_ENCRYPTED_IO_NOT_POSSIBLE                                                = 0x00000328,
    ERROR_FILE_METADATA_OPTIMIZATION_IN_PROGRESS                                   = 0x00000329,
    ERROR_QUOTA_ACTIVITY                                                           = 0x0000032a,
    ERROR_HANDLE_REVOKED                                                           = 0x0000032b,
    ERROR_CALLBACK_INVOKE_INLINE                                                   = 0x0000032c,
    ERROR_CPU_SET_INVALID                                                          = 0x0000032d,
    ERROR_ENCLAVE_NOT_TERMINATED                                                   = 0x0000032e,
    ERROR_ENCLAVE_VIOLATION                                                        = 0x0000032f,
    ERROR_SERVER_TRANSPORT_CONFLICT                                                = 0x00000330,
    ERROR_CERTIFICATE_VALIDATION_PREFERENCE_CONFLICT                               = 0x00000331,
    ERROR_FT_READ_FROM_COPY_FAILURE                                                = 0x00000332,
    ERROR_SECTION_DIRECT_MAP_ONLY                                                  = 0x00000333,
    ERROR_EA_ACCESS_DENIED                                                         = 0x000003e2,
    ERROR_OPERATION_ABORTED                                                        = 0x000003e3,
    ERROR_IO_INCOMPLETE                                                            = 0x000003e4,
    ERROR_IO_PENDING                                                               = 0x000003e5,
    ERROR_NOACCESS                                                                 = 0x000003e6,
    ERROR_SWAPERROR                                                                = 0x000003e7,
    ERROR_STACK_OVERFLOW                                                           = 0x000003e9,
    ERROR_INVALID_MESSAGE                                                          = 0x000003ea,
    ERROR_CAN_NOT_COMPLETE                                                         = 0x000003eb,
    ERROR_INVALID_FLAGS                                                            = 0x000003ec,
    ERROR_UNRECOGNIZED_VOLUME                                                      = 0x000003ed,
    ERROR_FILE_INVALID                                                             = 0x000003ee,
    ERROR_FULLSCREEN_MODE                                                          = 0x000003ef,
    ERROR_NO_TOKEN                                                                 = 0x000003f0,
    ERROR_BADDB                                                                    = 0x000003f1,
    ERROR_BADKEY                                                                   = 0x000003f2,
    ERROR_CANTOPEN                                                                 = 0x000003f3,
    ERROR_CANTREAD                                                                 = 0x000003f4,
    ERROR_CANTWRITE                                                                = 0x000003f5,
    ERROR_REGISTRY_RECOVERED                                                       = 0x000003f6,
    ERROR_REGISTRY_CORRUPT                                                         = 0x000003f7,
    ERROR_REGISTRY_IO_FAILED                                                       = 0x000003f8,
    ERROR_NOT_REGISTRY_FILE                                                        = 0x000003f9,
    ERROR_KEY_DELETED                                                              = 0x000003fa,
    ERROR_NO_LOG_SPACE                                                             = 0x000003fb,
    ERROR_KEY_HAS_CHILDREN                                                         = 0x000003fc,
    ERROR_CHILD_MUST_BE_VOLATILE                                                   = 0x000003fd,
    ERROR_NOTIFY_ENUM_DIR                                                          = 0x000003fe,
    ERROR_DEPENDENT_SERVICES_RUNNING                                               = 0x0000041b,
    ERROR_INVALID_SERVICE_CONTROL                                                  = 0x0000041c,
    ERROR_SERVICE_REQUEST_TIMEOUT                                                  = 0x0000041d,
    ERROR_SERVICE_NO_THREAD                                                        = 0x0000041e,
    ERROR_SERVICE_DATABASE_LOCKED                                                  = 0x0000041f,
    ERROR_SERVICE_ALREADY_RUNNING                                                  = 0x00000420,
    ERROR_INVALID_SERVICE_ACCOUNT                                                  = 0x00000421,
    ERROR_SERVICE_DISABLED                                                         = 0x00000422,
    ERROR_CIRCULAR_DEPENDENCY                                                      = 0x00000423,
    ERROR_SERVICE_DOES_NOT_EXIST                                                   = 0x00000424,
    ERROR_SERVICE_CANNOT_ACCEPT_CTRL                                               = 0x00000425,
    ERROR_SERVICE_NOT_ACTIVE                                                       = 0x00000426,
    ERROR_FAILED_SERVICE_CONTROLLER_CONNECT                                        = 0x00000427,
    ERROR_EXCEPTION_IN_SERVICE                                                     = 0x00000428,
    ERROR_DATABASE_DOES_NOT_EXIST                                                  = 0x00000429,
    ERROR_SERVICE_SPECIFIC_ERROR                                                   = 0x0000042a,
    ERROR_PROCESS_ABORTED                                                          = 0x0000042b,
    ERROR_SERVICE_DEPENDENCY_FAIL                                                  = 0x0000042c,
    ERROR_SERVICE_LOGON_FAILED                                                     = 0x0000042d,
    ERROR_SERVICE_START_HANG                                                       = 0x0000042e,
    ERROR_INVALID_SERVICE_LOCK                                                     = 0x0000042f,
    ERROR_SERVICE_MARKED_FOR_DELETE                                                = 0x00000430,
    ERROR_SERVICE_EXISTS                                                           = 0x00000431,
    ERROR_ALREADY_RUNNING_LKG                                                      = 0x00000432,
    ERROR_SERVICE_DEPENDENCY_DELETED                                               = 0x00000433,
    ERROR_BOOT_ALREADY_ACCEPTED                                                    = 0x00000434,
    ERROR_SERVICE_NEVER_STARTED                                                    = 0x00000435,
    ERROR_DUPLICATE_SERVICE_NAME                                                   = 0x00000436,
    ERROR_DIFFERENT_SERVICE_ACCOUNT                                                = 0x00000437,
    ERROR_CANNOT_DETECT_DRIVER_FAILURE                                             = 0x00000438,
    ERROR_CANNOT_DETECT_PROCESS_ABORT                                              = 0x00000439,
    ERROR_NO_RECOVERY_PROGRAM                                                      = 0x0000043a,
    ERROR_SERVICE_NOT_IN_EXE                                                       = 0x0000043b,
    ERROR_NOT_SAFEBOOT_SERVICE                                                     = 0x0000043c,
    ERROR_END_OF_MEDIA                                                             = 0x0000044c,
    ERROR_FILEMARK_DETECTED                                                        = 0x0000044d,
    ERROR_BEGINNING_OF_MEDIA                                                       = 0x0000044e,
    ERROR_SETMARK_DETECTED                                                         = 0x0000044f,
    ERROR_NO_DATA_DETECTED                                                         = 0x00000450,
    ERROR_PARTITION_FAILURE                                                        = 0x00000451,
    ERROR_INVALID_BLOCK_LENGTH                                                     = 0x00000452,
    ERROR_DEVICE_NOT_PARTITIONED                                                   = 0x00000453,
    ERROR_UNABLE_TO_LOCK_MEDIA                                                     = 0x00000454,
    ERROR_UNABLE_TO_UNLOAD_MEDIA                                                   = 0x00000455,
    ERROR_MEDIA_CHANGED                                                            = 0x00000456,
    ERROR_BUS_RESET                                                                = 0x00000457,
    ERROR_NO_MEDIA_IN_DRIVE                                                        = 0x00000458,
    ERROR_NO_UNICODE_TRANSLATION                                                   = 0x00000459,
    ERROR_DLL_INIT_FAILED                                                          = 0x0000045a,
    ERROR_SHUTDOWN_IN_PROGRESS                                                     = 0x0000045b,
    ERROR_NO_SHUTDOWN_IN_PROGRESS                                                  = 0x0000045c,
    ERROR_IO_DEVICE                                                                = 0x0000045d,
    ERROR_SERIAL_NO_DEVICE                                                         = 0x0000045e,
    ERROR_IRQ_BUSY                                                                 = 0x0000045f,
    ERROR_MORE_WRITES                                                              = 0x00000460,
    ERROR_COUNTER_TIMEOUT                                                          = 0x00000461,
    ERROR_FLOPPY_ID_MARK_NOT_FOUND                                                 = 0x00000462,
    ERROR_FLOPPY_WRONG_CYLINDER                                                    = 0x00000463,
    ERROR_FLOPPY_UNKNOWN_ERROR                                                     = 0x00000464,
    ERROR_FLOPPY_BAD_REGISTERS                                                     = 0x00000465,
    ERROR_DISK_RECALIBRATE_FAILED                                                  = 0x00000466,
    ERROR_DISK_OPERATION_FAILED                                                    = 0x00000467,
    ERROR_DISK_RESET_FAILED                                                        = 0x00000468,
    ERROR_EOM_OVERFLOW                                                             = 0x00000469,
    ERROR_NOT_ENOUGH_SERVER_MEMORY                                                 = 0x0000046a,
    ERROR_POSSIBLE_DEADLOCK                                                        = 0x0000046b,
    ERROR_MAPPED_ALIGNMENT                                                         = 0x0000046c,
    ERROR_SET_POWER_STATE_VETOED                                                   = 0x00000474,
    ERROR_SET_POWER_STATE_FAILED                                                   = 0x00000475,
    ERROR_TOO_MANY_LINKS                                                           = 0x00000476,
    ERROR_OLD_WIN_VERSION                                                          = 0x0000047e,
    ERROR_APP_WRONG_OS                                                             = 0x0000047f,
    ERROR_SINGLE_INSTANCE_APP                                                      = 0x00000480,
    ERROR_RMODE_APP                                                                = 0x00000481,
    ERROR_INVALID_DLL                                                              = 0x00000482,
    ERROR_NO_ASSOCIATION                                                           = 0x00000483,
    ERROR_DDE_FAIL                                                                 = 0x00000484,
    ERROR_DLL_NOT_FOUND                                                            = 0x00000485,
    ERROR_NO_MORE_USER_HANDLES                                                     = 0x00000486,
    ERROR_MESSAGE_SYNC_ONLY                                                        = 0x00000487,
    ERROR_SOURCE_ELEMENT_EMPTY                                                     = 0x00000488,
    ERROR_DESTINATION_ELEMENT_FULL                                                 = 0x00000489,
    ERROR_ILLEGAL_ELEMENT_ADDRESS                                                  = 0x0000048a,
    ERROR_MAGAZINE_NOT_PRESENT                                                     = 0x0000048b,
    ERROR_DEVICE_REINITIALIZATION_NEEDED                                           = 0x0000048c,
    ERROR_DEVICE_REQUIRES_CLEANING                                                 = 0x0000048d,
    ERROR_DEVICE_DOOR_OPEN                                                         = 0x0000048e,
    ERROR_DEVICE_NOT_CONNECTED                                                     = 0x0000048f,
    ERROR_NOT_FOUND                                                                = 0x00000490,
    ERROR_NO_MATCH                                                                 = 0x00000491,
    ERROR_SET_NOT_FOUND                                                            = 0x00000492,
    ERROR_POINT_NOT_FOUND                                                          = 0x00000493,
    ERROR_NO_TRACKING_SERVICE                                                      = 0x00000494,
    ERROR_NO_VOLUME_ID                                                             = 0x00000495,
    ERROR_UNABLE_TO_REMOVE_REPLACED                                                = 0x00000497,
    ERROR_UNABLE_TO_MOVE_REPLACEMENT                                               = 0x00000498,
    ERROR_UNABLE_TO_MOVE_REPLACEMENT_2                                             = 0x00000499,
    ERROR_JOURNAL_DELETE_IN_PROGRESS                                               = 0x0000049a,
    ERROR_JOURNAL_NOT_ACTIVE                                                       = 0x0000049b,
    ERROR_POTENTIAL_FILE_FOUND                                                     = 0x0000049c,
    ERROR_JOURNAL_ENTRY_DELETED                                                    = 0x0000049d,
    ERROR_PARTITION_TERMINATING                                                    = 0x000004a0,
    ERROR_SHUTDOWN_IS_SCHEDULED                                                    = 0x000004a6,
    ERROR_SHUTDOWN_USERS_LOGGED_ON                                                 = 0x000004a7,
    ERROR_SHUTDOWN_DISKS_NOT_IN_MAINTENANCE_MODE                                   = 0x000004a8,
    ERROR_BAD_DEVICE                                                               = 0x000004b0,
    ERROR_CONNECTION_UNAVAIL                                                       = 0x000004b1,
    ERROR_DEVICE_ALREADY_REMEMBERED                                                = 0x000004b2,
    ERROR_NO_NET_OR_BAD_PATH                                                       = 0x000004b3,
    ERROR_BAD_PROVIDER                                                             = 0x000004b4,
    ERROR_CANNOT_OPEN_PROFILE                                                      = 0x000004b5,
    ERROR_BAD_PROFILE                                                              = 0x000004b6,
    ERROR_NOT_CONTAINER                                                            = 0x000004b7,
    ERROR_EXTENDED_ERROR                                                           = 0x000004b8,
    ERROR_INVALID_GROUPNAME                                                        = 0x000004b9,
    ERROR_INVALID_COMPUTERNAME                                                     = 0x000004ba,
    ERROR_INVALID_EVENTNAME                                                        = 0x000004bb,
    ERROR_INVALID_DOMAINNAME                                                       = 0x000004bc,
    ERROR_INVALID_SERVICENAME                                                      = 0x000004bd,
    ERROR_INVALID_NETNAME                                                          = 0x000004be,
    ERROR_INVALID_SHARENAME                                                        = 0x000004bf,
    ERROR_INVALID_PASSWORDNAME                                                     = 0x000004c0,
    ERROR_INVALID_MESSAGENAME                                                      = 0x000004c1,
    ERROR_INVALID_MESSAGEDEST                                                      = 0x000004c2,
    ERROR_SESSION_CREDENTIAL_CONFLICT                                              = 0x000004c3,
    ERROR_REMOTE_SESSION_LIMIT_EXCEEDED                                            = 0x000004c4,
    ERROR_DUP_DOMAINNAME                                                           = 0x000004c5,
    ERROR_NO_NETWORK                                                               = 0x000004c6,
    ERROR_CANCELLED                                                                = 0x000004c7,
    ERROR_USER_MAPPED_FILE                                                         = 0x000004c8,
    ERROR_CONNECTION_REFUSED                                                       = 0x000004c9,
    ERROR_GRACEFUL_DISCONNECT                                                      = 0x000004ca,
    ERROR_ADDRESS_ALREADY_ASSOCIATED                                               = 0x000004cb,
    ERROR_ADDRESS_NOT_ASSOCIATED                                                   = 0x000004cc,
    ERROR_CONNECTION_INVALID                                                       = 0x000004cd,
    ERROR_CONNECTION_ACTIVE                                                        = 0x000004ce,
    ERROR_NETWORK_UNREACHABLE                                                      = 0x000004cf,
    ERROR_HOST_UNREACHABLE                                                         = 0x000004d0,
    ERROR_PROTOCOL_UNREACHABLE                                                     = 0x000004d1,
    ERROR_PORT_UNREACHABLE                                                         = 0x000004d2,
    ERROR_REQUEST_ABORTED                                                          = 0x000004d3,
    ERROR_CONNECTION_ABORTED                                                       = 0x000004d4,
    ERROR_RETRY                                                                    = 0x000004d5,
    ERROR_CONNECTION_COUNT_LIMIT                                                   = 0x000004d6,
    ERROR_LOGIN_TIME_RESTRICTION                                                   = 0x000004d7,
    ERROR_LOGIN_WKSTA_RESTRICTION                                                  = 0x000004d8,
    ERROR_INCORRECT_ADDRESS                                                        = 0x000004d9,
    ERROR_ALREADY_REGISTERED                                                       = 0x000004da,
    ERROR_SERVICE_NOT_FOUND                                                        = 0x000004db,
    ERROR_NOT_AUTHENTICATED                                                        = 0x000004dc,
    ERROR_NOT_LOGGED_ON                                                            = 0x000004dd,
    ERROR_CONTINUE                                                                 = 0x000004de,
    ERROR_ALREADY_INITIALIZED                                                      = 0x000004df,
    ERROR_NO_MORE_DEVICES                                                          = 0x000004e0,
    ERROR_NO_SUCH_SITE                                                             = 0x000004e1,
    ERROR_DOMAIN_CONTROLLER_EXISTS                                                 = 0x000004e2,
    ERROR_ONLY_IF_CONNECTED                                                        = 0x000004e3,
    ERROR_OVERRIDE_NOCHANGES                                                       = 0x000004e4,
    ERROR_BAD_USER_PROFILE                                                         = 0x000004e5,
    ERROR_NOT_SUPPORTED_ON_SBS                                                     = 0x000004e6,
    ERROR_SERVER_SHUTDOWN_IN_PROGRESS                                              = 0x000004e7,
    ERROR_HOST_DOWN                                                                = 0x000004e8,
    ERROR_NON_ACCOUNT_SID                                                          = 0x000004e9,
    ERROR_NON_DOMAIN_SID                                                           = 0x000004ea,
    ERROR_APPHELP_BLOCK                                                            = 0x000004eb,
    ERROR_ACCESS_DISABLED_BY_POLICY                                                = 0x000004ec,
    ERROR_REG_NAT_CONSUMPTION                                                      = 0x000004ed,
    ERROR_CSCSHARE_OFFLINE                                                         = 0x000004ee,
    ERROR_PKINIT_FAILURE                                                           = 0x000004ef,
    ERROR_SMARTCARD_SUBSYSTEM_FAILURE                                              = 0x000004f0,
    ERROR_DOWNGRADE_DETECTED                                                       = 0x000004f1,
    ERROR_MACHINE_LOCKED                                                           = 0x000004f7,
    ERROR_SMB_GUEST_LOGON_BLOCKED                                                  = 0x000004f8,
    ERROR_CALLBACK_SUPPLIED_INVALID_DATA                                           = 0x000004f9,
    ERROR_SYNC_FOREGROUND_REFRESH_REQUIRED                                         = 0x000004fa,
    ERROR_DRIVER_BLOCKED                                                           = 0x000004fb,
    ERROR_INVALID_IMPORT_OF_NON_DLL                                                = 0x000004fc,
    ERROR_ACCESS_DISABLED_WEBBLADE                                                 = 0x000004fd,
    ERROR_ACCESS_DISABLED_WEBBLADE_TAMPER                                          = 0x000004fe,
    ERROR_RECOVERY_FAILURE                                                         = 0x000004ff,
    ERROR_ALREADY_FIBER                                                            = 0x00000500,
    ERROR_ALREADY_THREAD                                                           = 0x00000501,
    ERROR_STACK_BUFFER_OVERRUN                                                     = 0x00000502,
    ERROR_PARAMETER_QUOTA_EXCEEDED                                                 = 0x00000503,
    ERROR_DEBUGGER_INACTIVE                                                        = 0x00000504,
    ERROR_DELAY_LOAD_FAILED                                                        = 0x00000505,
    ERROR_VDM_DISALLOWED                                                           = 0x00000506,
    ERROR_UNIDENTIFIED_ERROR                                                       = 0x00000507,
    ERROR_INVALID_CRUNTIME_PARAMETER                                               = 0x00000508,
    ERROR_BEYOND_VDL                                                               = 0x00000509,
    ERROR_INCOMPATIBLE_SERVICE_SID_TYPE                                            = 0x0000050a,
    ERROR_DRIVER_PROCESS_TERMINATED                                                = 0x0000050b,
    ERROR_IMPLEMENTATION_LIMIT                                                     = 0x0000050c,
    ERROR_PROCESS_IS_PROTECTED                                                     = 0x0000050d,
    ERROR_SERVICE_NOTIFY_CLIENT_LAGGING                                            = 0x0000050e,
    ERROR_DISK_QUOTA_EXCEEDED                                                      = 0x0000050f,
    ERROR_CONTENT_BLOCKED                                                          = 0x00000510,
    ERROR_INCOMPATIBLE_SERVICE_PRIVILEGE                                           = 0x00000511,
    ERROR_APP_HANG                                                                 = 0x00000512,
    ERROR_INVALID_LABEL                                                            = 0x00000513,
    ERROR_NOT_ALL_ASSIGNED                                                         = 0x00000514,
    ERROR_SOME_NOT_MAPPED                                                          = 0x00000515,
    ERROR_NO_QUOTAS_FOR_ACCOUNT                                                    = 0x00000516,
    ERROR_LOCAL_USER_SESSION_KEY                                                   = 0x00000517,
    ERROR_NULL_LM_PASSWORD                                                         = 0x00000518,
    ERROR_UNKNOWN_REVISION                                                         = 0x00000519,
    ERROR_REVISION_MISMATCH                                                        = 0x0000051a,
    ERROR_INVALID_OWNER                                                            = 0x0000051b,
    ERROR_INVALID_PRIMARY_GROUP                                                    = 0x0000051c,
    ERROR_NO_IMPERSONATION_TOKEN                                                   = 0x0000051d,
    ERROR_CANT_DISABLE_MANDATORY                                                   = 0x0000051e,
    ERROR_NO_LOGON_SERVERS                                                         = 0x0000051f,
    ERROR_NO_SUCH_LOGON_SESSION                                                    = 0x00000520,
    ERROR_NO_SUCH_PRIVILEGE                                                        = 0x00000521,
    ERROR_PRIVILEGE_NOT_HELD                                                       = 0x00000522,
    ERROR_INVALID_ACCOUNT_NAME                                                     = 0x00000523,
    ERROR_USER_EXISTS                                                              = 0x00000524,
    ERROR_NO_SUCH_USER                                                             = 0x00000525,
    ERROR_GROUP_EXISTS                                                             = 0x00000526,
    ERROR_NO_SUCH_GROUP                                                            = 0x00000527,
    ERROR_MEMBER_IN_GROUP                                                          = 0x00000528,
    ERROR_MEMBER_NOT_IN_GROUP                                                      = 0x00000529,
    ERROR_LAST_ADMIN                                                               = 0x0000052a,
    ERROR_WRONG_PASSWORD                                                           = 0x0000052b,
    ERROR_ILL_FORMED_PASSWORD                                                      = 0x0000052c,
    ERROR_PASSWORD_RESTRICTION                                                     = 0x0000052d,
    ERROR_LOGON_FAILURE                                                            = 0x0000052e,
    ERROR_ACCOUNT_RESTRICTION                                                      = 0x0000052f,
    ERROR_INVALID_LOGON_HOURS                                                      = 0x00000530,
    ERROR_INVALID_WORKSTATION                                                      = 0x00000531,
    ERROR_PASSWORD_EXPIRED                                                         = 0x00000532,
    ERROR_ACCOUNT_DISABLED                                                         = 0x00000533,
    ERROR_NONE_MAPPED                                                              = 0x00000534,
    ERROR_TOO_MANY_LUIDS_REQUESTED                                                 = 0x00000535,
    ERROR_LUIDS_EXHAUSTED                                                          = 0x00000536,
    ERROR_INVALID_SUB_AUTHORITY                                                    = 0x00000537,
    ERROR_INVALID_ACL                                                              = 0x00000538,
    ERROR_INVALID_SID                                                              = 0x00000539,
    ERROR_INVALID_SECURITY_DESCR                                                   = 0x0000053a,
    ERROR_BAD_INHERITANCE_ACL                                                      = 0x0000053c,
    ERROR_SERVER_DISABLED                                                          = 0x0000053d,
    ERROR_SERVER_NOT_DISABLED                                                      = 0x0000053e,
    ERROR_INVALID_ID_AUTHORITY                                                     = 0x0000053f,
    ERROR_ALLOTTED_SPACE_EXCEEDED                                                  = 0x00000540,
    ERROR_INVALID_GROUP_ATTRIBUTES                                                 = 0x00000541,
    ERROR_BAD_IMPERSONATION_LEVEL                                                  = 0x00000542,
    ERROR_CANT_OPEN_ANONYMOUS                                                      = 0x00000543,
    ERROR_BAD_VALIDATION_CLASS                                                     = 0x00000544,
    ERROR_BAD_TOKEN_TYPE                                                           = 0x00000545,
    ERROR_NO_SECURITY_ON_OBJECT                                                    = 0x00000546,
    ERROR_CANT_ACCESS_DOMAIN_INFO                                                  = 0x00000547,
    ERROR_INVALID_SERVER_STATE                                                     = 0x00000548,
    ERROR_INVALID_DOMAIN_STATE                                                     = 0x00000549,
    ERROR_INVALID_DOMAIN_ROLE                                                      = 0x0000054a,
    ERROR_NO_SUCH_DOMAIN                                                           = 0x0000054b,
    ERROR_DOMAIN_EXISTS                                                            = 0x0000054c,
    ERROR_DOMAIN_LIMIT_EXCEEDED                                                    = 0x0000054d,
    ERROR_INTERNAL_DB_CORRUPTION                                                   = 0x0000054e,
    ERROR_INTERNAL_ERROR                                                           = 0x0000054f,
    ERROR_GENERIC_NOT_MAPPED                                                       = 0x00000550,
    ERROR_BAD_DESCRIPTOR_FORMAT                                                    = 0x00000551,
    ERROR_NOT_LOGON_PROCESS                                                        = 0x00000552,
    ERROR_LOGON_SESSION_EXISTS                                                     = 0x00000553,
    ERROR_NO_SUCH_PACKAGE                                                          = 0x00000554,
    ERROR_BAD_LOGON_SESSION_STATE                                                  = 0x00000555,
    ERROR_LOGON_SESSION_COLLISION                                                  = 0x00000556,
    ERROR_INVALID_LOGON_TYPE                                                       = 0x00000557,
    ERROR_CANNOT_IMPERSONATE                                                       = 0x00000558,
    ERROR_RXACT_INVALID_STATE                                                      = 0x00000559,
    ERROR_RXACT_COMMIT_FAILURE                                                     = 0x0000055a,
    ERROR_SPECIAL_ACCOUNT                                                          = 0x0000055b,
    ERROR_SPECIAL_GROUP                                                            = 0x0000055c,
    ERROR_SPECIAL_USER                                                             = 0x0000055d,
    ERROR_MEMBERS_PRIMARY_GROUP                                                    = 0x0000055e,
    ERROR_TOKEN_ALREADY_IN_USE                                                     = 0x0000055f,
    ERROR_NO_SUCH_ALIAS                                                            = 0x00000560,
    ERROR_MEMBER_NOT_IN_ALIAS                                                      = 0x00000561,
    ERROR_MEMBER_IN_ALIAS                                                          = 0x00000562,
    ERROR_ALIAS_EXISTS                                                             = 0x00000563,
    ERROR_LOGON_NOT_GRANTED                                                        = 0x00000564,
    ERROR_TOO_MANY_SECRETS                                                         = 0x00000565,
    ERROR_SECRET_TOO_LONG                                                          = 0x00000566,
    ERROR_INTERNAL_DB_ERROR                                                        = 0x00000567,
    ERROR_TOO_MANY_CONTEXT_IDS                                                     = 0x00000568,
    ERROR_LOGON_TYPE_NOT_GRANTED                                                   = 0x00000569,
    ERROR_NT_CROSS_ENCRYPTION_REQUIRED                                             = 0x0000056a,
    ERROR_NO_SUCH_MEMBER                                                           = 0x0000056b,
    ERROR_INVALID_MEMBER                                                           = 0x0000056c,
    ERROR_TOO_MANY_SIDS                                                            = 0x0000056d,
    ERROR_LM_CROSS_ENCRYPTION_REQUIRED                                             = 0x0000056e,
    ERROR_NO_INHERITANCE                                                           = 0x0000056f,
    ERROR_FILE_CORRUPT                                                             = 0x00000570,
    ERROR_DISK_CORRUPT                                                             = 0x00000571,
    ERROR_NO_USER_SESSION_KEY                                                      = 0x00000572,
    ERROR_LICENSE_QUOTA_EXCEEDED                                                   = 0x00000573,
    ERROR_WRONG_TARGET_NAME                                                        = 0x00000574,
    ERROR_MUTUAL_AUTH_FAILED                                                       = 0x00000575,
    ERROR_TIME_SKEW                                                                = 0x00000576,
    ERROR_CURRENT_DOMAIN_NOT_ALLOWED                                               = 0x00000577,
    ERROR_INVALID_WINDOW_HANDLE                                                    = 0x00000578,
    ERROR_INVALID_MENU_HANDLE                                                      = 0x00000579,
    ERROR_INVALID_CURSOR_HANDLE                                                    = 0x0000057a,
    ERROR_INVALID_ACCEL_HANDLE                                                     = 0x0000057b,
    ERROR_INVALID_HOOK_HANDLE                                                      = 0x0000057c,
    ERROR_INVALID_DWP_HANDLE                                                       = 0x0000057d,
    ERROR_TLW_WITH_WSCHILD                                                         = 0x0000057e,
    ERROR_CANNOT_FIND_WND_CLASS                                                    = 0x0000057f,
    ERROR_WINDOW_OF_OTHER_THREAD                                                   = 0x00000580,
    ERROR_HOTKEY_ALREADY_REGISTERED                                                = 0x00000581,
    ERROR_CLASS_ALREADY_EXISTS                                                     = 0x00000582,
    ERROR_CLASS_DOES_NOT_EXIST                                                     = 0x00000583,
    ERROR_CLASS_HAS_WINDOWS                                                        = 0x00000584,
    ERROR_INVALID_INDEX                                                            = 0x00000585,
    ERROR_INVALID_ICON_HANDLE                                                      = 0x00000586,
    ERROR_PRIVATE_DIALOG_INDEX                                                     = 0x00000587,
    ERROR_LISTBOX_ID_NOT_FOUND                                                     = 0x00000588,
    ERROR_NO_WILDCARD_CHARACTERS                                                   = 0x00000589,
    ERROR_CLIPBOARD_NOT_OPEN                                                       = 0x0000058a,
    ERROR_HOTKEY_NOT_REGISTERED                                                    = 0x0000058b,
    ERROR_WINDOW_NOT_DIALOG                                                        = 0x0000058c,
    ERROR_CONTROL_ID_NOT_FOUND                                                     = 0x0000058d,
    ERROR_INVALID_COMBOBOX_MESSAGE                                                 = 0x0000058e,
    ERROR_WINDOW_NOT_COMBOBOX                                                      = 0x0000058f,
    ERROR_INVALID_EDIT_HEIGHT                                                      = 0x00000590,
    ERROR_DC_NOT_FOUND                                                             = 0x00000591,
    ERROR_INVALID_HOOK_FILTER                                                      = 0x00000592,
    ERROR_INVALID_FILTER_PROC                                                      = 0x00000593,
    ERROR_HOOK_NEEDS_HMOD                                                          = 0x00000594,
    ERROR_GLOBAL_ONLY_HOOK                                                         = 0x00000595,
    ERROR_JOURNAL_HOOK_SET                                                         = 0x00000596,
    ERROR_HOOK_NOT_INSTALLED                                                       = 0x00000597,
    ERROR_INVALID_LB_MESSAGE                                                       = 0x00000598,
    ERROR_SETCOUNT_ON_BAD_LB                                                       = 0x00000599,
    ERROR_LB_WITHOUT_TABSTOPS                                                      = 0x0000059a,
    ERROR_DESTROY_OBJECT_OF_OTHER_THREAD                                           = 0x0000059b,
    ERROR_CHILD_WINDOW_MENU                                                        = 0x0000059c,
    ERROR_NO_SYSTEM_MENU                                                           = 0x0000059d,
    ERROR_INVALID_MSGBOX_STYLE                                                     = 0x0000059e,
    ERROR_INVALID_SPI_VALUE                                                        = 0x0000059f,
    ERROR_SCREEN_ALREADY_LOCKED                                                    = 0x000005a0,
    ERROR_HWNDS_HAVE_DIFF_PARENT                                                   = 0x000005a1,
    ERROR_NOT_CHILD_WINDOW                                                         = 0x000005a2,
    ERROR_INVALID_GW_COMMAND                                                       = 0x000005a3,
    ERROR_INVALID_THREAD_ID                                                        = 0x000005a4,
    ERROR_NON_MDICHILD_WINDOW                                                      = 0x000005a5,
    ERROR_POPUP_ALREADY_ACTIVE                                                     = 0x000005a6,
    ERROR_NO_SCROLLBARS                                                            = 0x000005a7,
    ERROR_INVALID_SCROLLBAR_RANGE                                                  = 0x000005a8,
    ERROR_INVALID_SHOWWIN_COMMAND                                                  = 0x000005a9,
    ERROR_NO_SYSTEM_RESOURCES                                                      = 0x000005aa,
    ERROR_NONPAGED_SYSTEM_RESOURCES                                                = 0x000005ab,
    ERROR_PAGED_SYSTEM_RESOURCES                                                   = 0x000005ac,
    ERROR_WORKING_SET_QUOTA                                                        = 0x000005ad,
    ERROR_PAGEFILE_QUOTA                                                           = 0x000005ae,
    ERROR_COMMITMENT_LIMIT                                                         = 0x000005af,
    ERROR_MENU_ITEM_NOT_FOUND                                                      = 0x000005b0,
    ERROR_INVALID_KEYBOARD_HANDLE                                                  = 0x000005b1,
    ERROR_HOOK_TYPE_NOT_ALLOWED                                                    = 0x000005b2,
    ERROR_REQUIRES_INTERACTIVE_WINDOWSTATION                                       = 0x000005b3,
    ERROR_TIMEOUT                                                                  = 0x000005b4,
    ERROR_INVALID_MONITOR_HANDLE                                                   = 0x000005b5,
    ERROR_INCORRECT_SIZE                                                           = 0x000005b6,
    ERROR_SYMLINK_CLASS_DISABLED                                                   = 0x000005b7,
    ERROR_SYMLINK_NOT_SUPPORTED                                                    = 0x000005b8,
    ERROR_XML_PARSE_ERROR                                                          = 0x000005b9,
    ERROR_XMLDSIG_ERROR                                                            = 0x000005ba,
    ERROR_RESTART_APPLICATION                                                      = 0x000005bb,
    ERROR_WRONG_COMPARTMENT                                                        = 0x000005bc,
    ERROR_AUTHIP_FAILURE                                                           = 0x000005bd,
    ERROR_NO_NVRAM_RESOURCES                                                       = 0x000005be,
    ERROR_NOT_GUI_PROCESS                                                          = 0x000005bf,
    ERROR_EVENTLOG_FILE_CORRUPT                                                    = 0x000005dc,
    ERROR_EVENTLOG_CANT_START                                                      = 0x000005dd,
    ERROR_LOG_FILE_FULL                                                            = 0x000005de,
    ERROR_EVENTLOG_FILE_CHANGED                                                    = 0x000005df,
    ERROR_CONTAINER_ASSIGNED                                                       = 0x000005e0,
    ERROR_JOB_NO_CONTAINER                                                         = 0x000005e1,
    ERROR_INVALID_TASK_NAME                                                        = 0x0000060e,
    ERROR_INVALID_TASK_INDEX                                                       = 0x0000060f,
    ERROR_THREAD_ALREADY_IN_TASK                                                   = 0x00000610,
    ERROR_INSTALL_SERVICE_FAILURE                                                  = 0x00000641,
    ERROR_INSTALL_USEREXIT                                                         = 0x00000642,
    ERROR_INSTALL_FAILURE                                                          = 0x00000643,
    ERROR_INSTALL_SUSPEND                                                          = 0x00000644,
    ERROR_UNKNOWN_PRODUCT                                                          = 0x00000645,
    ERROR_UNKNOWN_FEATURE                                                          = 0x00000646,
    ERROR_UNKNOWN_COMPONENT                                                        = 0x00000647,
    ERROR_UNKNOWN_PROPERTY                                                         = 0x00000648,
    ERROR_INVALID_HANDLE_STATE                                                     = 0x00000649,
    ERROR_BAD_CONFIGURATION                                                        = 0x0000064a,
    ERROR_INDEX_ABSENT                                                             = 0x0000064b,
    ERROR_INSTALL_SOURCE_ABSENT                                                    = 0x0000064c,
    ERROR_INSTALL_PACKAGE_VERSION                                                  = 0x0000064d,
    ERROR_PRODUCT_UNINSTALLED                                                      = 0x0000064e,
    ERROR_BAD_QUERY_SYNTAX                                                         = 0x0000064f,
    ERROR_INVALID_FIELD                                                            = 0x00000650,
    ERROR_DEVICE_REMOVED                                                           = 0x00000651,
    ERROR_INSTALL_ALREADY_RUNNING                                                  = 0x00000652,
    ERROR_INSTALL_PACKAGE_OPEN_FAILED                                              = 0x00000653,
    ERROR_INSTALL_PACKAGE_INVALID                                                  = 0x00000654,
    ERROR_INSTALL_UI_FAILURE                                                       = 0x00000655,
    ERROR_INSTALL_LOG_FAILURE                                                      = 0x00000656,
    ERROR_INSTALL_LANGUAGE_UNSUPPORTED                                             = 0x00000657,
    ERROR_INSTALL_TRANSFORM_FAILURE                                                = 0x00000658,
    ERROR_INSTALL_PACKAGE_REJECTED                                                 = 0x00000659,
    ERROR_FUNCTION_NOT_CALLED                                                      = 0x0000065a,
    ERROR_FUNCTION_FAILED                                                          = 0x0000065b,
    ERROR_INVALID_TABLE                                                            = 0x0000065c,
    ERROR_DATATYPE_MISMATCH                                                        = 0x0000065d,
    ERROR_UNSUPPORTED_TYPE                                                         = 0x0000065e,
    ERROR_CREATE_FAILED                                                            = 0x0000065f,
    ERROR_INSTALL_TEMP_UNWRITABLE                                                  = 0x00000660,
    ERROR_INSTALL_PLATFORM_UNSUPPORTED                                             = 0x00000661,
    ERROR_INSTALL_NOTUSED                                                          = 0x00000662,
    ERROR_PATCH_PACKAGE_OPEN_FAILED                                                = 0x00000663,
    ERROR_PATCH_PACKAGE_INVALID                                                    = 0x00000664,
    ERROR_PATCH_PACKAGE_UNSUPPORTED                                                = 0x00000665,
    ERROR_PRODUCT_VERSION                                                          = 0x00000666,
    ERROR_INVALID_COMMAND_LINE                                                     = 0x00000667,
    ERROR_INSTALL_REMOTE_DISALLOWED                                                = 0x00000668,
    ERROR_SUCCESS_REBOOT_INITIATED                                                 = 0x00000669,
    ERROR_PATCH_TARGET_NOT_FOUND                                                   = 0x0000066a,
    ERROR_PATCH_PACKAGE_REJECTED                                                   = 0x0000066b,
    ERROR_INSTALL_TRANSFORM_REJECTED                                               = 0x0000066c,
    ERROR_INSTALL_REMOTE_PROHIBITED                                                = 0x0000066d,
    ERROR_PATCH_REMOVAL_UNSUPPORTED                                                = 0x0000066e,
    ERROR_UNKNOWN_PATCH                                                            = 0x0000066f,
    ERROR_PATCH_NO_SEQUENCE                                                        = 0x00000670,
    ERROR_PATCH_REMOVAL_DISALLOWED                                                 = 0x00000671,
    ERROR_INVALID_PATCH_XML                                                        = 0x00000672,
    ERROR_PATCH_MANAGED_ADVERTISED_PRODUCT                                         = 0x00000673,
    ERROR_INSTALL_SERVICE_SAFEBOOT                                                 = 0x00000674,
    ERROR_FAIL_FAST_EXCEPTION                                                      = 0x00000675,
    ERROR_INSTALL_REJECTED                                                         = 0x00000676,
    ERROR_DYNAMIC_CODE_BLOCKED                                                     = 0x00000677,
    ERROR_NOT_SAME_OBJECT                                                          = 0x00000678,
    ERROR_STRICT_CFG_VIOLATION                                                     = 0x00000679,
    ERROR_SET_CONTEXT_DENIED                                                       = 0x0000067c,
    ERROR_CROSS_PARTITION_VIOLATION                                                = 0x0000067d,
    ERROR_RETURN_ADDRESS_HIJACK_ATTEMPT                                            = 0x0000067e,
    ERROR_INVALID_USER_BUFFER                                                      = 0x000006f8,
    ERROR_UNRECOGNIZED_MEDIA                                                       = 0x000006f9,
    ERROR_NO_TRUST_LSA_SECRET                                                      = 0x000006fa,
    ERROR_NO_TRUST_SAM_ACCOUNT                                                     = 0x000006fb,
    ERROR_TRUSTED_DOMAIN_FAILURE                                                   = 0x000006fc,
    ERROR_TRUSTED_RELATIONSHIP_FAILURE                                             = 0x000006fd,
    ERROR_TRUST_FAILURE                                                            = 0x000006fe,
    ERROR_NETLOGON_NOT_STARTED                                                     = 0x00000700,
    ERROR_ACCOUNT_EXPIRED                                                          = 0x00000701,
    ERROR_REDIRECTOR_HAS_OPEN_HANDLES                                              = 0x00000702,
    ERROR_PRINTER_DRIVER_ALREADY_INSTALLED                                         = 0x00000703,
    ERROR_UNKNOWN_PORT                                                             = 0x00000704,
    ERROR_UNKNOWN_PRINTER_DRIVER                                                   = 0x00000705,
    ERROR_UNKNOWN_PRINTPROCESSOR                                                   = 0x00000706,
    ERROR_INVALID_SEPARATOR_FILE                                                   = 0x00000707,
    ERROR_INVALID_PRIORITY                                                         = 0x00000708,
    ERROR_INVALID_PRINTER_NAME                                                     = 0x00000709,
    ERROR_PRINTER_ALREADY_EXISTS                                                   = 0x0000070a,
    ERROR_INVALID_PRINTER_COMMAND                                                  = 0x0000070b,
    ERROR_INVALID_DATATYPE                                                         = 0x0000070c,
    ERROR_INVALID_ENVIRONMENT                                                      = 0x0000070d,
    ERROR_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT                                        = 0x0000070f,
    ERROR_NOLOGON_WORKSTATION_TRUST_ACCOUNT                                        = 0x00000710,
    ERROR_NOLOGON_SERVER_TRUST_ACCOUNT                                             = 0x00000711,
    ERROR_DOMAIN_TRUST_INCONSISTENT                                                = 0x00000712,
    ERROR_SERVER_HAS_OPEN_HANDLES                                                  = 0x00000713,
    ERROR_RESOURCE_DATA_NOT_FOUND                                                  = 0x00000714,
    ERROR_RESOURCE_TYPE_NOT_FOUND                                                  = 0x00000715,
    ERROR_RESOURCE_NAME_NOT_FOUND                                                  = 0x00000716,
    ERROR_RESOURCE_LANG_NOT_FOUND                                                  = 0x00000717,
    ERROR_NOT_ENOUGH_QUOTA                                                         = 0x00000718,
    ERROR_INVALID_TIME                                                             = 0x0000076d,
    ERROR_INVALID_FORM_NAME                                                        = 0x0000076e,
    ERROR_INVALID_FORM_SIZE                                                        = 0x0000076f,
    ERROR_ALREADY_WAITING                                                          = 0x00000770,
    ERROR_PRINTER_DELETED                                                          = 0x00000771,
    ERROR_INVALID_PRINTER_STATE                                                    = 0x00000772,
    ERROR_PASSWORD_MUST_CHANGE                                                     = 0x00000773,
    ERROR_DOMAIN_CONTROLLER_NOT_FOUND                                              = 0x00000774,
    ERROR_ACCOUNT_LOCKED_OUT                                                       = 0x00000775,
    ERROR_NO_SITENAME                                                              = 0x0000077f,
    ERROR_CANT_ACCESS_FILE                                                         = 0x00000780,
    ERROR_CANT_RESOLVE_FILENAME                                                    = 0x00000781,
    ERROR_KM_DRIVER_BLOCKED                                                        = 0x0000078a,
    ERROR_CONTEXT_EXPIRED                                                          = 0x0000078b,
    ERROR_PER_USER_TRUST_QUOTA_EXCEEDED                                            = 0x0000078c,
    ERROR_ALL_USER_TRUST_QUOTA_EXCEEDED                                            = 0x0000078d,
    ERROR_USER_DELETE_TRUST_QUOTA_EXCEEDED                                         = 0x0000078e,
    ERROR_AUTHENTICATION_FIREWALL_FAILED                                           = 0x0000078f,
    ERROR_REMOTE_PRINT_CONNECTIONS_BLOCKED                                         = 0x00000790,
    ERROR_NTLM_BLOCKED                                                             = 0x00000791,
    ERROR_PASSWORD_CHANGE_REQUIRED                                                 = 0x00000792,
    ERROR_LOST_MODE_LOGON_RESTRICTION                                              = 0x00000793,
    ERROR_INVALID_PIXEL_FORMAT                                                     = 0x000007d0,
    ERROR_BAD_DRIVER                                                               = 0x000007d1,
    ERROR_INVALID_WINDOW_STYLE                                                     = 0x000007d2,
    ERROR_METAFILE_NOT_SUPPORTED                                                   = 0x000007d3,
    ERROR_TRANSFORM_NOT_SUPPORTED                                                  = 0x000007d4,
    ERROR_CLIPPING_NOT_SUPPORTED                                                   = 0x000007d5,
    ERROR_INVALID_CMM                                                              = 0x000007da,
    ERROR_INVALID_PROFILE                                                          = 0x000007db,
    ERROR_TAG_NOT_FOUND                                                            = 0x000007dc,
    ERROR_TAG_NOT_PRESENT                                                          = 0x000007dd,
    ERROR_DUPLICATE_TAG                                                            = 0x000007de,
    ERROR_PROFILE_NOT_ASSOCIATED_WITH_DEVICE                                       = 0x000007df,
    ERROR_PROFILE_NOT_FOUND                                                        = 0x000007e0,
    ERROR_INVALID_COLORSPACE                                                       = 0x000007e1,
    ERROR_ICM_NOT_ENABLED                                                          = 0x000007e2,
    ERROR_DELETING_ICM_XFORM                                                       = 0x000007e3,
    ERROR_INVALID_TRANSFORM                                                        = 0x000007e4,
    ERROR_COLORSPACE_MISMATCH                                                      = 0x000007e5,
    ERROR_INVALID_COLORINDEX                                                       = 0x000007e6,
    ERROR_PROFILE_DOES_NOT_MATCH_DEVICE                                            = 0x000007e7,
    ERROR_CONNECTED_OTHER_PASSWORD                                                 = 0x0000083c,
    ERROR_CONNECTED_OTHER_PASSWORD_DEFAULT                                         = 0x0000083d,
    ERROR_BAD_USERNAME                                                             = 0x0000089a,
    ERROR_NOT_CONNECTED                                                            = 0x000008ca,
    ERROR_OPEN_FILES                                                               = 0x00000961,
    ERROR_ACTIVE_CONNECTIONS                                                       = 0x00000962,
    ERROR_DEVICE_IN_USE                                                            = 0x00000964,
    ERROR_UNKNOWN_PRINT_MONITOR                                                    = 0x00000bb8,
    ERROR_PRINTER_DRIVER_IN_USE                                                    = 0x00000bb9,
    ERROR_SPOOL_FILE_NOT_FOUND                                                     = 0x00000bba,
    ERROR_SPL_NO_STARTDOC                                                          = 0x00000bbb,
    ERROR_SPL_NO_ADDJOB                                                            = 0x00000bbc,
    ERROR_PRINT_PROCESSOR_ALREADY_INSTALLED                                        = 0x00000bbd,
    ERROR_PRINT_MONITOR_ALREADY_INSTALLED                                          = 0x00000bbe,
    ERROR_INVALID_PRINT_MONITOR                                                    = 0x00000bbf,
    ERROR_PRINT_MONITOR_IN_USE                                                     = 0x00000bc0,
    ERROR_PRINTER_HAS_JOBS_QUEUED                                                  = 0x00000bc1,
    ERROR_SUCCESS_REBOOT_REQUIRED                                                  = 0x00000bc2,
    ERROR_SUCCESS_RESTART_REQUIRED                                                 = 0x00000bc3,
    ERROR_PRINTER_NOT_FOUND                                                        = 0x00000bc4,
    ERROR_PRINTER_DRIVER_WARNED                                                    = 0x00000bc5,
    ERROR_PRINTER_DRIVER_BLOCKED                                                   = 0x00000bc6,
    ERROR_PRINTER_DRIVER_PACKAGE_IN_USE                                            = 0x00000bc7,
    ERROR_CORE_DRIVER_PACKAGE_NOT_FOUND                                            = 0x00000bc8,
    ERROR_FAIL_REBOOT_REQUIRED                                                     = 0x00000bc9,
    ERROR_FAIL_REBOOT_INITIATED                                                    = 0x00000bca,
    ERROR_PRINTER_DRIVER_DOWNLOAD_NEEDED                                           = 0x00000bcb,
    ERROR_PRINT_JOB_RESTART_REQUIRED                                               = 0x00000bcc,
    ERROR_INVALID_PRINTER_DRIVER_MANIFEST                                          = 0x00000bcd,
    ERROR_PRINTER_NOT_SHAREABLE                                                    = 0x00000bce,
    ERROR_SERVER_SERVICE_CALL_REQUIRES_SMB1                                        = 0x00000bcf,
    ERROR_NETWORK_AUTHENTICATION_PROMPT_CANCELED                                   = 0x00000bd0,
    ERROR_REMOTE_MAILSLOTS_DEPRECATED                                              = 0x00000bd1,
    ERROR_REQUEST_PAUSED                                                           = 0x00000bea,
    ERROR_APPEXEC_CONDITION_NOT_SATISFIED                                          = 0x00000bf4,
    ERROR_APPEXEC_HANDLE_INVALIDATED                                               = 0x00000bf5,
    ERROR_APPEXEC_INVALID_HOST_GENERATION                                          = 0x00000bf6,
    ERROR_APPEXEC_UNEXPECTED_PROCESS_REGISTRATION                                  = 0x00000bf7,
    ERROR_APPEXEC_INVALID_HOST_STATE                                               = 0x00000bf8,
    ERROR_APPEXEC_NO_DONOR                                                         = 0x00000bf9,
    ERROR_APPEXEC_HOST_ID_MISMATCH                                                 = 0x00000bfa,
    ERROR_APPEXEC_UNKNOWN_USER                                                     = 0x00000bfb,
    ERROR_APPEXEC_APP_COMPAT_BLOCK                                                 = 0x00000bfc,
    ERROR_APPEXEC_CALLER_WAIT_TIMEOUT                                              = 0x00000bfd,
    ERROR_APPEXEC_CALLER_WAIT_TIMEOUT_TERMINATION                                  = 0x00000bfe,
    ERROR_APPEXEC_CALLER_WAIT_TIMEOUT_LICENSING                                    = 0x00000bff,
    ERROR_APPEXEC_CALLER_WAIT_TIMEOUT_RESOURCES                                    = 0x00000c00,
    ERROR_VRF_VOLATILE_CFG_AND_IO_ENABLED                                          = 0x00000c08,
    ERROR_VRF_VOLATILE_NOT_STOPPABLE                                               = 0x00000c09,
    ERROR_VRF_VOLATILE_SAFE_MODE                                                   = 0x00000c0a,
    ERROR_VRF_VOLATILE_NOT_RUNNABLE_SYSTEM                                         = 0x00000c0b,
    ERROR_VRF_VOLATILE_NOT_SUPPORTED_RULECLASS                                     = 0x00000c0c,
    ERROR_VRF_VOLATILE_PROTECTED_DRIVER                                            = 0x00000c0d,
    ERROR_VRF_VOLATILE_NMI_REGISTERED                                              = 0x00000c0e,
    ERROR_VRF_VOLATILE_SETTINGS_CONFLICT                                           = 0x00000c0f,
    ERROR_CAR_LKD_IN_PROGRESS                                                      = 0x00000c10,
    ERROR_DIF_ZERO_SIZE_INFORMATION                                                = 0x00000c73,
    ERROR_DIF_DRIVER_PLUGIN_MISMATCH                                               = 0x00000c74,
    ERROR_DIF_DRIVER_THUNKS_NOT_ALLOWED                                            = 0x00000c75,
    ERROR_DIF_IOCALLBACK_NOT_REPLACED                                              = 0x00000c76,
    ERROR_DIF_LIVEDUMP_LIMIT_EXCEEDED                                              = 0x00000c77,
    ERROR_DIF_VOLATILE_SECTION_NOT_LOCKED                                          = 0x00000c78,
    ERROR_DIF_VOLATILE_DRIVER_HOTPATCHED                                           = 0x00000c79,
    ERROR_DIF_VOLATILE_INVALID_INFO                                                = 0x00000c7a,
    ERROR_DIF_VOLATILE_DRIVER_IS_NOT_RUNNING                                       = 0x00000c7b,
    ERROR_DIF_VOLATILE_PLUGIN_IS_NOT_RUNNING                                       = 0x00000c7c,
    ERROR_DIF_VOLATILE_PLUGIN_CHANGE_NOT_ALLOWED                                   = 0x00000c7d,
    ERROR_DIF_VOLATILE_NOT_ALLOWED                                                 = 0x00000c7e,
    ERROR_DIF_BINDING_API_NOT_FOUND                                                = 0x00000c7f,
    ERROR_IO_REISSUE_AS_CACHED                                                     = 0x00000f6e,
    ERROR_WINS_INTERNAL                                                            = 0x00000fa0,
    ERROR_CAN_NOT_DEL_LOCAL_WINS                                                   = 0x00000fa1,
    ERROR_STATIC_INIT                                                              = 0x00000fa2,
    ERROR_INC_BACKUP                                                               = 0x00000fa3,
    ERROR_FULL_BACKUP                                                              = 0x00000fa4,
    ERROR_REC_NON_EXISTENT                                                         = 0x00000fa5,
    ERROR_RPL_NOT_ALLOWED                                                          = 0x00000fa6,
    ERROR_DHCP_ADDRESS_CONFLICT                                                    = 0x00001004,
    ERROR_WMI_GUID_NOT_FOUND                                                       = 0x00001068,
    ERROR_WMI_INSTANCE_NOT_FOUND                                                   = 0x00001069,
    ERROR_WMI_ITEMID_NOT_FOUND                                                     = 0x0000106a,
    ERROR_WMI_TRY_AGAIN                                                            = 0x0000106b,
    ERROR_WMI_DP_NOT_FOUND                                                         = 0x0000106c,
    ERROR_WMI_UNRESOLVED_INSTANCE_REF                                              = 0x0000106d,
    ERROR_WMI_ALREADY_ENABLED                                                      = 0x0000106e,
    ERROR_WMI_GUID_DISCONNECTED                                                    = 0x0000106f,
    ERROR_WMI_SERVER_UNAVAILABLE                                                   = 0x00001070,
    ERROR_WMI_DP_FAILED                                                            = 0x00001071,
    ERROR_WMI_INVALID_MOF                                                          = 0x00001072,
    ERROR_WMI_INVALID_REGINFO                                                      = 0x00001073,
    ERROR_WMI_ALREADY_DISABLED                                                     = 0x00001074,
    ERROR_WMI_READ_ONLY                                                            = 0x00001075,
    ERROR_WMI_SET_FAILURE                                                          = 0x00001076,
    ERROR_NOT_APPCONTAINER                                                         = 0x0000109a,
    ERROR_APPCONTAINER_REQUIRED                                                    = 0x0000109b,
    ERROR_NOT_SUPPORTED_IN_APPCONTAINER                                            = 0x0000109c,
    ERROR_INVALID_PACKAGE_SID_LENGTH                                               = 0x0000109d,
    ERROR_INVALID_MEDIA                                                            = 0x000010cc,
    ERROR_INVALID_LIBRARY                                                          = 0x000010cd,
    ERROR_INVALID_MEDIA_POOL                                                       = 0x000010ce,
    ERROR_DRIVE_MEDIA_MISMATCH                                                     = 0x000010cf,
    ERROR_MEDIA_OFFLINE                                                            = 0x000010d0,
    ERROR_LIBRARY_OFFLINE                                                          = 0x000010d1,
    ERROR_EMPTY                                                                    = 0x000010d2,
    ERROR_NOT_EMPTY                                                                = 0x000010d3,
    ERROR_MEDIA_UNAVAILABLE                                                        = 0x000010d4,
    ERROR_RESOURCE_DISABLED                                                        = 0x000010d5,
    ERROR_INVALID_CLEANER                                                          = 0x000010d6,
    ERROR_UNABLE_TO_CLEAN                                                          = 0x000010d7,
    ERROR_OBJECT_NOT_FOUND                                                         = 0x000010d8,
    ERROR_DATABASE_FAILURE                                                         = 0x000010d9,
    ERROR_DATABASE_FULL                                                            = 0x000010da,
    ERROR_MEDIA_INCOMPATIBLE                                                       = 0x000010db,
    ERROR_RESOURCE_NOT_PRESENT                                                     = 0x000010dc,
    ERROR_INVALID_OPERATION                                                        = 0x000010dd,
    ERROR_MEDIA_NOT_AVAILABLE                                                      = 0x000010de,
    ERROR_DEVICE_NOT_AVAILABLE                                                     = 0x000010df,
    ERROR_REQUEST_REFUSED                                                          = 0x000010e0,
    ERROR_INVALID_DRIVE_OBJECT                                                     = 0x000010e1,
    ERROR_LIBRARY_FULL                                                             = 0x000010e2,
    ERROR_MEDIUM_NOT_ACCESSIBLE                                                    = 0x000010e3,
    ERROR_UNABLE_TO_LOAD_MEDIUM                                                    = 0x000010e4,
    ERROR_UNABLE_TO_INVENTORY_DRIVE                                                = 0x000010e5,
    ERROR_UNABLE_TO_INVENTORY_SLOT                                                 = 0x000010e6,
    ERROR_UNABLE_TO_INVENTORY_TRANSPORT                                            = 0x000010e7,
    ERROR_TRANSPORT_FULL                                                           = 0x000010e8,
    ERROR_CONTROLLING_IEPORT                                                       = 0x000010e9,
    ERROR_UNABLE_TO_EJECT_MOUNTED_MEDIA                                            = 0x000010ea,
    ERROR_CLEANER_SLOT_SET                                                         = 0x000010eb,
    ERROR_CLEANER_SLOT_NOT_SET                                                     = 0x000010ec,
    ERROR_CLEANER_CARTRIDGE_SPENT                                                  = 0x000010ed,
    ERROR_UNEXPECTED_OMID                                                          = 0x000010ee,
    ERROR_CANT_DELETE_LAST_ITEM                                                    = 0x000010ef,
    ERROR_MESSAGE_EXCEEDS_MAX_SIZE                                                 = 0x000010f0,
    ERROR_VOLUME_CONTAINS_SYS_FILES                                                = 0x000010f1,
    ERROR_INDIGENOUS_TYPE                                                          = 0x000010f2,
    ERROR_NO_SUPPORTING_DRIVES                                                     = 0x000010f3,
    ERROR_CLEANER_CARTRIDGE_INSTALLED                                              = 0x000010f4,
    ERROR_IEPORT_FULL                                                              = 0x000010f5,
    ERROR_FILE_OFFLINE                                                             = 0x000010fe,
    ERROR_REMOTE_STORAGE_NOT_ACTIVE                                                = 0x000010ff,
    ERROR_REMOTE_STORAGE_MEDIA_ERROR                                               = 0x00001100,
    ERROR_NOT_A_REPARSE_POINT                                                      = 0x00001126,
    ERROR_REPARSE_ATTRIBUTE_CONFLICT                                               = 0x00001127,
    ERROR_INVALID_REPARSE_DATA                                                     = 0x00001128,
    ERROR_REPARSE_TAG_INVALID                                                      = 0x00001129,
    ERROR_REPARSE_TAG_MISMATCH                                                     = 0x0000112a,
    ERROR_REPARSE_POINT_ENCOUNTERED                                                = 0x0000112b,
    ERROR_APP_DATA_NOT_FOUND                                                       = 0x00001130,
    ERROR_APP_DATA_EXPIRED                                                         = 0x00001131,
    ERROR_APP_DATA_CORRUPT                                                         = 0x00001132,
    ERROR_APP_DATA_LIMIT_EXCEEDED                                                  = 0x00001133,
    ERROR_APP_DATA_REBOOT_REQUIRED                                                 = 0x00001134,
    ERROR_SECUREBOOT_ROLLBACK_DETECTED                                             = 0x00001144,
    ERROR_SECUREBOOT_POLICY_VIOLATION                                              = 0x00001145,
    ERROR_SECUREBOOT_INVALID_POLICY                                                = 0x00001146,
    ERROR_SECUREBOOT_POLICY_PUBLISHER_NOT_FOUND                                    = 0x00001147,
    ERROR_SECUREBOOT_POLICY_NOT_SIGNED                                             = 0x00001148,
    ERROR_SECUREBOOT_NOT_ENABLED                                                   = 0x00001149,
    ERROR_SECUREBOOT_FILE_REPLACED                                                 = 0x0000114a,
    ERROR_SECUREBOOT_POLICY_NOT_AUTHORIZED                                         = 0x0000114b,
    ERROR_SECUREBOOT_POLICY_UNKNOWN                                                = 0x0000114c,
    ERROR_SECUREBOOT_POLICY_MISSING_ANTIROLLBACKVERSION                            = 0x0000114d,
    ERROR_SECUREBOOT_PLATFORM_ID_MISMATCH                                          = 0x0000114e,
    ERROR_SECUREBOOT_POLICY_ROLLBACK_DETECTED                                      = 0x0000114f,
    ERROR_SECUREBOOT_POLICY_UPGRADE_MISMATCH                                       = 0x00001150,
    ERROR_SECUREBOOT_REQUIRED_POLICY_FILE_MISSING                                  = 0x00001151,
    ERROR_SECUREBOOT_NOT_BASE_POLICY                                               = 0x00001152,
    ERROR_SECUREBOOT_NOT_SUPPLEMENTAL_POLICY                                       = 0x00001153,
    ERROR_OFFLOAD_READ_FLT_NOT_SUPPORTED                                           = 0x00001158,
    ERROR_OFFLOAD_WRITE_FLT_NOT_SUPPORTED                                          = 0x00001159,
    ERROR_OFFLOAD_READ_FILE_NOT_SUPPORTED                                          = 0x0000115a,
    ERROR_OFFLOAD_WRITE_FILE_NOT_SUPPORTED                                         = 0x0000115b,
    ERROR_ALREADY_HAS_STREAM_ID                                                    = 0x0000115c,
    ERROR_SMR_GARBAGE_COLLECTION_REQUIRED                                          = 0x0000115d,
    ERROR_WOF_WIM_HEADER_CORRUPT                                                   = 0x0000115e,
    ERROR_WOF_WIM_RESOURCE_TABLE_CORRUPT                                           = 0x0000115f,
    ERROR_WOF_FILE_RESOURCE_TABLE_CORRUPT                                          = 0x00001160,
    ERROR_OBJECT_IS_IMMUTABLE                                                      = 0x00001161,
    ERROR_VOLUME_NOT_SIS_ENABLED                                                   = 0x00001194,
    ERROR_SYSTEM_INTEGRITY_ROLLBACK_DETECTED                                       = 0x000011c6,
    ERROR_SYSTEM_INTEGRITY_POLICY_VIOLATION                                        = 0x000011c7,
    ERROR_SYSTEM_INTEGRITY_INVALID_POLICY                                          = 0x000011c8,
    ERROR_SYSTEM_INTEGRITY_POLICY_NOT_SIGNED                                       = 0x000011c9,
    ERROR_SYSTEM_INTEGRITY_TOO_MANY_POLICIES                                       = 0x000011ca,
    ERROR_SYSTEM_INTEGRITY_SUPPLEMENTAL_POLICY_NOT_AUTHORIZED                      = 0x000011cb,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_MALICIOUS                                    = 0x000011cc,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_PUA                                          = 0x000011cd,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_DANGEROUS_EXT                                = 0x000011ce,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_OFFLINE                                      = 0x000011cf,
    ERROR_VSM_NOT_INITIALIZED                                                      = 0x000011d0,
    ERROR_VSM_DMA_PROTECTION_NOT_IN_USE                                            = 0x000011d1,
    ERROR_VSM_KEY_CI_POLICY_ROLLBACK_DETECTED                                      = 0x000011d2,
    ERROR_VSMIDK_KEYGEN_FAILURE                                                    = 0x000011d3,
    ERROR_VSMIDK_EXPORT_FAILURE                                                    = 0x000011d4,
    ERROR_VSMIDK_MODULUS_MISMATCH                                                  = 0x000011d5,
    ERROR_PLATFORM_MANIFEST_NOT_AUTHORIZED                                         = 0x000011da,
    ERROR_PLATFORM_MANIFEST_INVALID                                                = 0x000011db,
    ERROR_PLATFORM_MANIFEST_FILE_NOT_AUTHORIZED                                    = 0x000011dc,
    ERROR_PLATFORM_MANIFEST_CATALOG_NOT_AUTHORIZED                                 = 0x000011dd,
    ERROR_PLATFORM_MANIFEST_BINARY_ID_NOT_FOUND                                    = 0x000011de,
    ERROR_PLATFORM_MANIFEST_NOT_ACTIVE                                             = 0x000011df,
    ERROR_PLATFORM_MANIFEST_NOT_SIGNED                                             = 0x000011e0,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_UNFRIENDLY_FILE                              = 0x000011e4,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_UNATTAINABLE                                 = 0x000011e5,
    ERROR_SYSTEM_INTEGRITY_REPUTATION_EXPLICIT_DENY_FILE                           = 0x000011e6,
    ERROR_SYSTEM_INTEGRITY_WHQL_NOT_SATISFIED                                      = 0x000011e7,
    ERROR_DEPENDENT_RESOURCE_EXISTS                                                = 0x00001389,
    ERROR_DEPENDENCY_NOT_FOUND                                                     = 0x0000138a,
    ERROR_DEPENDENCY_ALREADY_EXISTS                                                = 0x0000138b,
    ERROR_RESOURCE_NOT_ONLINE                                                      = 0x0000138c,
    ERROR_HOST_NODE_NOT_AVAILABLE                                                  = 0x0000138d,
    ERROR_RESOURCE_NOT_AVAILABLE                                                   = 0x0000138e,
    ERROR_RESOURCE_NOT_FOUND                                                       = 0x0000138f,
    ERROR_SHUTDOWN_CLUSTER                                                         = 0x00001390,
    ERROR_CANT_EVICT_ACTIVE_NODE                                                   = 0x00001391,
    ERROR_OBJECT_ALREADY_EXISTS                                                    = 0x00001392,
    ERROR_OBJECT_IN_LIST                                                           = 0x00001393,
    ERROR_GROUP_NOT_AVAILABLE                                                      = 0x00001394,
    ERROR_GROUP_NOT_FOUND                                                          = 0x00001395,
    ERROR_GROUP_NOT_ONLINE                                                         = 0x00001396,
    ERROR_HOST_NODE_NOT_RESOURCE_OWNER                                             = 0x00001397,
    ERROR_HOST_NODE_NOT_GROUP_OWNER                                                = 0x00001398,
    ERROR_RESMON_CREATE_FAILED                                                     = 0x00001399,
    ERROR_RESMON_ONLINE_FAILED                                                     = 0x0000139a,
    ERROR_RESOURCE_ONLINE                                                          = 0x0000139b,
    ERROR_QUORUM_RESOURCE                                                          = 0x0000139c,
    ERROR_NOT_QUORUM_CAPABLE                                                       = 0x0000139d,
    ERROR_CLUSTER_SHUTTING_DOWN                                                    = 0x0000139e,
    ERROR_INVALID_STATE                                                            = 0x0000139f,
    ERROR_RESOURCE_PROPERTIES_STORED                                               = 0x000013a0,
    ERROR_NOT_QUORUM_CLASS                                                         = 0x000013a1,
    ERROR_CORE_RESOURCE                                                            = 0x000013a2,
    ERROR_QUORUM_RESOURCE_ONLINE_FAILED                                            = 0x000013a3,
    ERROR_QUORUMLOG_OPEN_FAILED                                                    = 0x000013a4,
    ERROR_CLUSTERLOG_CORRUPT                                                       = 0x000013a5,
    ERROR_CLUSTERLOG_RECORD_EXCEEDS_MAXSIZE                                        = 0x000013a6,
    ERROR_CLUSTERLOG_EXCEEDS_MAXSIZE                                               = 0x000013a7,
    ERROR_CLUSTERLOG_CHKPOINT_NOT_FOUND                                            = 0x000013a8,
    ERROR_CLUSTERLOG_NOT_ENOUGH_SPACE                                              = 0x000013a9,
    ERROR_QUORUM_OWNER_ALIVE                                                       = 0x000013aa,
    ERROR_NETWORK_NOT_AVAILABLE                                                    = 0x000013ab,
    ERROR_NODE_NOT_AVAILABLE                                                       = 0x000013ac,
    ERROR_ALL_NODES_NOT_AVAILABLE                                                  = 0x000013ad,
    ERROR_RESOURCE_FAILED                                                          = 0x000013ae,
    ERROR_CLUSTER_INVALID_NODE                                                     = 0x000013af,
    ERROR_CLUSTER_NODE_EXISTS                                                      = 0x000013b0,
    ERROR_CLUSTER_JOIN_IN_PROGRESS                                                 = 0x000013b1,
    ERROR_CLUSTER_NODE_NOT_FOUND                                                   = 0x000013b2,
    ERROR_CLUSTER_LOCAL_NODE_NOT_FOUND                                             = 0x000013b3,
    ERROR_CLUSTER_NETWORK_EXISTS                                                   = 0x000013b4,
    ERROR_CLUSTER_NETWORK_NOT_FOUND                                                = 0x000013b5,
    ERROR_CLUSTER_NETINTERFACE_EXISTS                                              = 0x000013b6,
    ERROR_CLUSTER_NETINTERFACE_NOT_FOUND                                           = 0x000013b7,
    ERROR_CLUSTER_INVALID_REQUEST                                                  = 0x000013b8,
    ERROR_CLUSTER_INVALID_NETWORK_PROVIDER                                         = 0x000013b9,
    ERROR_CLUSTER_NODE_DOWN                                                        = 0x000013ba,
    ERROR_CLUSTER_NODE_UNREACHABLE                                                 = 0x000013bb,
    ERROR_CLUSTER_NODE_NOT_MEMBER                                                  = 0x000013bc,
    ERROR_CLUSTER_JOIN_NOT_IN_PROGRESS                                             = 0x000013bd,
    ERROR_CLUSTER_INVALID_NETWORK                                                  = 0x000013be,
    ERROR_CLUSTER_NODE_UP                                                          = 0x000013c0,
    ERROR_CLUSTER_IPADDR_IN_USE                                                    = 0x000013c1,
    ERROR_CLUSTER_NODE_NOT_PAUSED                                                  = 0x000013c2,
    ERROR_CLUSTER_NO_SECURITY_CONTEXT                                              = 0x000013c3,
    ERROR_CLUSTER_NETWORK_NOT_INTERNAL                                             = 0x000013c4,
    ERROR_CLUSTER_NODE_ALREADY_UP                                                  = 0x000013c5,
    ERROR_CLUSTER_NODE_ALREADY_DOWN                                                = 0x000013c6,
    ERROR_CLUSTER_NETWORK_ALREADY_ONLINE                                           = 0x000013c7,
    ERROR_CLUSTER_NETWORK_ALREADY_OFFLINE                                          = 0x000013c8,
    ERROR_CLUSTER_NODE_ALREADY_MEMBER                                              = 0x000013c9,
    ERROR_CLUSTER_LAST_INTERNAL_NETWORK                                            = 0x000013ca,
    ERROR_CLUSTER_NETWORK_HAS_DEPENDENTS                                           = 0x000013cb,
    ERROR_INVALID_OPERATION_ON_QUORUM                                              = 0x000013cc,
    ERROR_DEPENDENCY_NOT_ALLOWED                                                   = 0x000013cd,
    ERROR_CLUSTER_NODE_PAUSED                                                      = 0x000013ce,
    ERROR_NODE_CANT_HOST_RESOURCE                                                  = 0x000013cf,
    ERROR_CLUSTER_NODE_NOT_READY                                                   = 0x000013d0,
    ERROR_CLUSTER_NODE_SHUTTING_DOWN                                               = 0x000013d1,
    ERROR_CLUSTER_JOIN_ABORTED                                                     = 0x000013d2,
    ERROR_CLUSTER_INCOMPATIBLE_VERSIONS                                            = 0x000013d3,
    ERROR_CLUSTER_MAXNUM_OF_RESOURCES_EXCEEDED                                     = 0x000013d4,
    ERROR_CLUSTER_SYSTEM_CONFIG_CHANGED                                            = 0x000013d5,
    ERROR_CLUSTER_RESOURCE_TYPE_NOT_FOUND                                          = 0x000013d6,
    ERROR_CLUSTER_RESTYPE_NOT_SUPPORTED                                            = 0x000013d7,
    ERROR_CLUSTER_RESNAME_NOT_FOUND                                                = 0x000013d8,
    ERROR_CLUSTER_NO_RPC_PACKAGES_REGISTERED                                       = 0x000013d9,
    ERROR_CLUSTER_OWNER_NOT_IN_PREFLIST                                            = 0x000013da,
    ERROR_CLUSTER_DATABASE_SEQMISMATCH                                             = 0x000013db,
    ERROR_RESMON_INVALID_STATE                                                     = 0x000013dc,
    ERROR_CLUSTER_GUM_NOT_LOCKER                                                   = 0x000013dd,
    ERROR_QUORUM_DISK_NOT_FOUND                                                    = 0x000013de,
    ERROR_DATABASE_BACKUP_CORRUPT                                                  = 0x000013df,
    ERROR_CLUSTER_NODE_ALREADY_HAS_DFS_ROOT                                        = 0x000013e0,
    ERROR_RESOURCE_PROPERTY_UNCHANGEABLE                                           = 0x000013e1,
    ERROR_NO_ADMIN_ACCESS_POINT                                                    = 0x000013e2,
    ERROR_CLUSTER_MEMBERSHIP_INVALID_STATE                                         = 0x00001702,
    ERROR_CLUSTER_QUORUMLOG_NOT_FOUND                                              = 0x00001703,
    ERROR_CLUSTER_MEMBERSHIP_HALT                                                  = 0x00001704,
    ERROR_CLUSTER_INSTANCE_ID_MISMATCH                                             = 0x00001705,
    ERROR_CLUSTER_NETWORK_NOT_FOUND_FOR_IP                                         = 0x00001706,
    ERROR_CLUSTER_PROPERTY_DATA_TYPE_MISMATCH                                      = 0x00001707,
    ERROR_CLUSTER_EVICT_WITHOUT_CLEANUP                                            = 0x00001708,
    ERROR_CLUSTER_PARAMETER_MISMATCH                                               = 0x00001709,
    ERROR_NODE_CANNOT_BE_CLUSTERED                                                 = 0x0000170a,
    ERROR_CLUSTER_WRONG_OS_VERSION                                                 = 0x0000170b,
    ERROR_CLUSTER_CANT_CREATE_DUP_CLUSTER_NAME                                     = 0x0000170c,
    ERROR_CLUSCFG_ALREADY_COMMITTED                                                = 0x0000170d,
    ERROR_CLUSCFG_ROLLBACK_FAILED                                                  = 0x0000170e,
    ERROR_CLUSCFG_SYSTEM_DISK_DRIVE_LETTER_CONFLICT                                = 0x0000170f,
    ERROR_CLUSTER_OLD_VERSION                                                      = 0x00001710,
    ERROR_CLUSTER_MISMATCHED_COMPUTER_ACCT_NAME                                    = 0x00001711,
    ERROR_CLUSTER_NO_NET_ADAPTERS                                                  = 0x00001712,
    ERROR_CLUSTER_POISONED                                                         = 0x00001713,
    ERROR_CLUSTER_GROUP_MOVING                                                     = 0x00001714,
    ERROR_CLUSTER_RESOURCE_TYPE_BUSY                                               = 0x00001715,
    ERROR_RESOURCE_CALL_TIMED_OUT                                                  = 0x00001716,
    ERROR_INVALID_CLUSTER_IPV6_ADDRESS                                             = 0x00001717,
    ERROR_CLUSTER_INTERNAL_INVALID_FUNCTION                                        = 0x00001718,
    ERROR_CLUSTER_PARAMETER_OUT_OF_BOUNDS                                          = 0x00001719,
    ERROR_CLUSTER_PARTIAL_SEND                                                     = 0x0000171a,
    ERROR_CLUSTER_REGISTRY_INVALID_FUNCTION                                        = 0x0000171b,
    ERROR_CLUSTER_INVALID_STRING_TERMINATION                                       = 0x0000171c,
    ERROR_CLUSTER_INVALID_STRING_FORMAT                                            = 0x0000171d,
    ERROR_CLUSTER_DATABASE_TRANSACTION_IN_PROGRESS                                 = 0x0000171e,
    ERROR_CLUSTER_DATABASE_TRANSACTION_NOT_IN_PROGRESS                             = 0x0000171f,
    ERROR_CLUSTER_NULL_DATA                                                        = 0x00001720,
    ERROR_CLUSTER_PARTIAL_READ                                                     = 0x00001721,
    ERROR_CLUSTER_PARTIAL_WRITE                                                    = 0x00001722,
    ERROR_CLUSTER_CANT_DESERIALIZE_DATA                                            = 0x00001723,
    ERROR_DEPENDENT_RESOURCE_PROPERTY_CONFLICT                                     = 0x00001724,
    ERROR_CLUSTER_NO_QUORUM                                                        = 0x00001725,
    ERROR_CLUSTER_INVALID_IPV6_NETWORK                                             = 0x00001726,
    ERROR_CLUSTER_INVALID_IPV6_TUNNEL_NETWORK                                      = 0x00001727,
    ERROR_QUORUM_NOT_ALLOWED_IN_THIS_GROUP                                         = 0x00001728,
    ERROR_DEPENDENCY_TREE_TOO_COMPLEX                                              = 0x00001729,
    ERROR_EXCEPTION_IN_RESOURCE_CALL                                               = 0x0000172a,
    ERROR_CLUSTER_RHS_FAILED_INITIALIZATION                                        = 0x0000172b,
    ERROR_CLUSTER_NOT_INSTALLED                                                    = 0x0000172c,
    ERROR_CLUSTER_RESOURCES_MUST_BE_ONLINE_ON_THE_SAME_NODE                        = 0x0000172d,
    ERROR_CLUSTER_MAX_NODES_IN_CLUSTER                                             = 0x0000172e,
    ERROR_CLUSTER_TOO_MANY_NODES                                                   = 0x0000172f,
    ERROR_CLUSTER_OBJECT_ALREADY_USED                                              = 0x00001730,
    ERROR_NONCORE_GROUPS_FOUND                                                     = 0x00001731,
    ERROR_FILE_SHARE_RESOURCE_CONFLICT                                             = 0x00001732,
    ERROR_CLUSTER_EVICT_INVALID_REQUEST                                            = 0x00001733,
    ERROR_CLUSTER_SINGLETON_RESOURCE                                               = 0x00001734,
    ERROR_CLUSTER_GROUP_SINGLETON_RESOURCE                                         = 0x00001735,
    ERROR_CLUSTER_RESOURCE_PROVIDER_FAILED                                         = 0x00001736,
    ERROR_CLUSTER_RESOURCE_CONFIGURATION_ERROR                                     = 0x00001737,
    ERROR_CLUSTER_GROUP_BUSY                                                       = 0x00001738,
    ERROR_CLUSTER_NOT_SHARED_VOLUME                                                = 0x00001739,
    ERROR_CLUSTER_INVALID_SECURITY_DESCRIPTOR                                      = 0x0000173a,
    ERROR_CLUSTER_SHARED_VOLUMES_IN_USE                                            = 0x0000173b,
    ERROR_CLUSTER_USE_SHARED_VOLUMES_API                                           = 0x0000173c,
    ERROR_CLUSTER_BACKUP_IN_PROGRESS                                               = 0x0000173d,
    ERROR_NON_CSV_PATH                                                             = 0x0000173e,
    ERROR_CSV_VOLUME_NOT_LOCAL                                                     = 0x0000173f,
    ERROR_CLUSTER_WATCHDOG_TERMINATING                                             = 0x00001740,
    ERROR_CLUSTER_RESOURCE_VETOED_MOVE_INCOMPATIBLE_NODES                          = 0x00001741,
    ERROR_CLUSTER_INVALID_NODE_WEIGHT                                              = 0x00001742,
    ERROR_CLUSTER_RESOURCE_VETOED_CALL                                             = 0x00001743,
    ERROR_RESMON_SYSTEM_RESOURCES_LACKING                                          = 0x00001744,
    ERROR_CLUSTER_RESOURCE_VETOED_MOVE_NOT_ENOUGH_RESOURCES_ON_DESTINATION         = 0x00001745,
    ERROR_CLUSTER_RESOURCE_VETOED_MOVE_NOT_ENOUGH_RESOURCES_ON_SOURCE              = 0x00001746,
    ERROR_CLUSTER_GROUP_QUEUED                                                     = 0x00001747,
    ERROR_CLUSTER_RESOURCE_LOCKED_STATUS                                           = 0x00001748,
    ERROR_CLUSTER_SHARED_VOLUME_FAILOVER_NOT_ALLOWED                               = 0x00001749,
    ERROR_CLUSTER_NODE_DRAIN_IN_PROGRESS                                           = 0x0000174a,
    ERROR_CLUSTER_DISK_NOT_CONNECTED                                               = 0x0000174b,
    ERROR_DISK_NOT_CSV_CAPABLE                                                     = 0x0000174c,
    ERROR_RESOURCE_NOT_IN_AVAILABLE_STORAGE                                        = 0x0000174d,
    ERROR_CLUSTER_SHARED_VOLUME_REDIRECTED                                         = 0x0000174e,
    ERROR_CLUSTER_SHARED_VOLUME_NOT_REDIRECTED                                     = 0x0000174f,
    ERROR_CLUSTER_CANNOT_RETURN_PROPERTIES                                         = 0x00001750,
    ERROR_CLUSTER_RESOURCE_CONTAINS_UNSUPPORTED_DIFF_AREA_FOR_SHARED_VOLUMES       = 0x00001751,
    ERROR_CLUSTER_RESOURCE_IS_IN_MAINTENANCE_MODE                                  = 0x00001752,
    ERROR_CLUSTER_AFFINITY_CONFLICT                                                = 0x00001753,
    ERROR_CLUSTER_RESOURCE_IS_REPLICA_VIRTUAL_MACHINE                              = 0x00001754,
    ERROR_CLUSTER_UPGRADE_INCOMPATIBLE_VERSIONS                                    = 0x00001755,
    ERROR_CLUSTER_UPGRADE_FIX_QUORUM_NOT_SUPPORTED                                 = 0x00001756,
    ERROR_CLUSTER_UPGRADE_RESTART_REQUIRED                                         = 0x00001757,
    ERROR_CLUSTER_UPGRADE_IN_PROGRESS                                              = 0x00001758,
    ERROR_CLUSTER_UPGRADE_INCOMPLETE                                               = 0x00001759,
    ERROR_CLUSTER_NODE_IN_GRACE_PERIOD                                             = 0x0000175a,
    ERROR_CLUSTER_CSV_IO_PAUSE_TIMEOUT                                             = 0x0000175b,
    ERROR_NODE_NOT_ACTIVE_CLUSTER_MEMBER                                           = 0x0000175c,
    ERROR_CLUSTER_RESOURCE_NOT_MONITORED                                           = 0x0000175d,
    ERROR_CLUSTER_RESOURCE_DOES_NOT_SUPPORT_UNMONITORED                            = 0x0000175e,
    ERROR_CLUSTER_RESOURCE_IS_REPLICATED                                           = 0x0000175f,
    ERROR_CLUSTER_NODE_ISOLATED                                                    = 0x00001760,
    ERROR_CLUSTER_NODE_QUARANTINED                                                 = 0x00001761,
    ERROR_CLUSTER_DATABASE_UPDATE_CONDITION_FAILED                                 = 0x00001762,
    ERROR_CLUSTER_SPACE_DEGRADED                                                   = 0x00001763,
    ERROR_CLUSTER_TOKEN_DELEGATION_NOT_SUPPORTED                                   = 0x00001764,
    ERROR_CLUSTER_CSV_INVALID_HANDLE                                               = 0x00001765,
    ERROR_CLUSTER_CSV_SUPPORTED_ONLY_ON_COORDINATOR                                = 0x00001766,
    ERROR_GROUPSET_NOT_AVAILABLE                                                   = 0x00001767,
    ERROR_GROUPSET_NOT_FOUND                                                       = 0x00001768,
    ERROR_GROUPSET_CANT_PROVIDE                                                    = 0x00001769,
    ERROR_CLUSTER_FAULT_DOMAIN_PARENT_NOT_FOUND                                    = 0x0000176a,
    ERROR_CLUSTER_FAULT_DOMAIN_INVALID_HIERARCHY                                   = 0x0000176b,
    ERROR_CLUSTER_FAULT_DOMAIN_FAILED_S2D_VALIDATION                               = 0x0000176c,
    ERROR_CLUSTER_FAULT_DOMAIN_S2D_CONNECTIVITY_LOSS                               = 0x0000176d,
    ERROR_CLUSTER_INVALID_INFRASTRUCTURE_FILESERVER_NAME                           = 0x0000176e,
    ERROR_CLUSTERSET_MANAGEMENT_CLUSTER_UNREACHABLE                                = 0x0000176f,
    ERROR_ENCRYPTION_FAILED                                                        = 0x00001770,
    ERROR_DECRYPTION_FAILED                                                        = 0x00001771,
    ERROR_FILE_ENCRYPTED                                                           = 0x00001772,
    ERROR_NO_RECOVERY_POLICY                                                       = 0x00001773,
    ERROR_NO_EFS                                                                   = 0x00001774,
    ERROR_WRONG_EFS                                                                = 0x00001775,
    ERROR_NO_USER_KEYS                                                             = 0x00001776,
    ERROR_FILE_NOT_ENCRYPTED                                                       = 0x00001777,
    ERROR_NOT_EXPORT_FORMAT                                                        = 0x00001778,
    ERROR_FILE_READ_ONLY                                                           = 0x00001779,
    ERROR_DIR_EFS_DISALLOWED                                                       = 0x0000177a,
    ERROR_EFS_SERVER_NOT_TRUSTED                                                   = 0x0000177b,
    ERROR_BAD_RECOVERY_POLICY                                                      = 0x0000177c,
    ERROR_EFS_ALG_BLOB_TOO_BIG                                                     = 0x0000177d,
    ERROR_VOLUME_NOT_SUPPORT_EFS                                                   = 0x0000177e,
    ERROR_EFS_DISABLED                                                             = 0x0000177f,
    ERROR_EFS_VERSION_NOT_SUPPORT                                                  = 0x00001780,
    ERROR_CS_ENCRYPTION_INVALID_SERVER_RESPONSE                                    = 0x00001781,
    ERROR_CS_ENCRYPTION_UNSUPPORTED_SERVER                                         = 0x00001782,
    ERROR_CS_ENCRYPTION_EXISTING_ENCRYPTED_FILE                                    = 0x00001783,
    ERROR_CS_ENCRYPTION_NEW_ENCRYPTED_FILE                                         = 0x00001784,
    ERROR_CS_ENCRYPTION_FILE_NOT_CSE                                               = 0x00001785,
    ERROR_ENCRYPTION_POLICY_DENIES_OPERATION                                       = 0x00001786,
    ERROR_WIP_ENCRYPTION_FAILED                                                    = 0x00001787,
    ERROR_PDE_ENCRYPTION_UNAVAILABLE_FAILURE                                       = 0x00001788,
    ERROR_PDE_DECRYPTION_UNAVAILABLE_FAILURE                                       = 0x00001789,
    ERROR_PDE_DECRYPTION_UNAVAILABLE                                               = 0x0000178a,
    ERROR_NO_BROWSER_SERVERS_FOUND                                                 = 0x000017e6,
    ERROR_CLUSTER_OBJECT_IS_CLUSTER_SET_VM                                         = 0x0000186a,
    ERROR_CNU_TEMPLATE_ALREADY_EXISTS                                              = 0x0000186b,
    ERROR_CNU_TEMPLATE_NAME_NOT_FOUND                                              = 0x0000186c,
    ERROR_CNU_RUN_NAME_NOT_FOUND                                                   = 0x0000186d,
    ERROR_CNU_RUN_ALREADY_IN_PROGRESS                                              = 0x0000186e,
    ERROR_CNU_RUN_NOT_IN_PROGRESS                                                  = 0x0000186f,
    ERROR_CNU_NOT_READY                                                            = 0x00001870,
    ERROR_CAMERA_INVALID_CONFIGURATION                                             = 0x000018ce,
    ERROR_CAMERA_INSUFFICIENT_BANDWIDTH                                            = 0x000018cf,
    ERROR_LOG_SECTOR_INVALID                                                       = 0x000019c8,
    ERROR_LOG_SECTOR_PARITY_INVALID                                                = 0x000019c9,
    ERROR_LOG_SECTOR_REMAPPED                                                      = 0x000019ca,
    ERROR_LOG_BLOCK_INCOMPLETE                                                     = 0x000019cb,
    ERROR_LOG_INVALID_RANGE                                                        = 0x000019cc,
    ERROR_LOG_BLOCKS_EXHAUSTED                                                     = 0x000019cd,
    ERROR_LOG_READ_CONTEXT_INVALID                                                 = 0x000019ce,
    ERROR_LOG_RESTART_INVALID                                                      = 0x000019cf,
    ERROR_LOG_BLOCK_VERSION                                                        = 0x000019d0,
    ERROR_LOG_BLOCK_INVALID                                                        = 0x000019d1,
    ERROR_LOG_READ_MODE_INVALID                                                    = 0x000019d2,
    ERROR_LOG_NO_RESTART                                                           = 0x000019d3,
    ERROR_LOG_METADATA_CORRUPT                                                     = 0x000019d4,
    ERROR_LOG_METADATA_INVALID                                                     = 0x000019d5,
    ERROR_LOG_METADATA_INCONSISTENT                                                = 0x000019d6,
    ERROR_LOG_RESERVATION_INVALID                                                  = 0x000019d7,
    ERROR_LOG_CANT_DELETE                                                          = 0x000019d8,
    ERROR_LOG_CONTAINER_LIMIT_EXCEEDED                                             = 0x000019d9,
    ERROR_LOG_START_OF_LOG                                                         = 0x000019da,
    ERROR_LOG_POLICY_ALREADY_INSTALLED                                             = 0x000019db,
    ERROR_LOG_POLICY_NOT_INSTALLED                                                 = 0x000019dc,
    ERROR_LOG_POLICY_INVALID                                                       = 0x000019dd,
    ERROR_LOG_POLICY_CONFLICT                                                      = 0x000019de,
    ERROR_LOG_PINNED_ARCHIVE_TAIL                                                  = 0x000019df,
    ERROR_LOG_RECORD_NONEXISTENT                                                   = 0x000019e0,
    ERROR_LOG_RECORDS_RESERVED_INVALID                                             = 0x000019e1,
    ERROR_LOG_SPACE_RESERVED_INVALID                                               = 0x000019e2,
    ERROR_LOG_TAIL_INVALID                                                         = 0x000019e3,
    ERROR_LOG_FULL                                                                 = 0x000019e4,
    ERROR_COULD_NOT_RESIZE_LOG                                                     = 0x000019e5,
    ERROR_LOG_MULTIPLEXED                                                          = 0x000019e6,
    ERROR_LOG_DEDICATED                                                            = 0x000019e7,
    ERROR_LOG_ARCHIVE_NOT_IN_PROGRESS                                              = 0x000019e8,
    ERROR_LOG_ARCHIVE_IN_PROGRESS                                                  = 0x000019e9,
    ERROR_LOG_EPHEMERAL                                                            = 0x000019ea,
    ERROR_LOG_NOT_ENOUGH_CONTAINERS                                                = 0x000019eb,
    ERROR_LOG_CLIENT_ALREADY_REGISTERED                                            = 0x000019ec,
    ERROR_LOG_CLIENT_NOT_REGISTERED                                                = 0x000019ed,
    ERROR_LOG_FULL_HANDLER_IN_PROGRESS                                             = 0x000019ee,
    ERROR_LOG_CONTAINER_READ_FAILED                                                = 0x000019ef,
    ERROR_LOG_CONTAINER_WRITE_FAILED                                               = 0x000019f0,
    ERROR_LOG_CONTAINER_OPEN_FAILED                                                = 0x000019f1,
    ERROR_LOG_CONTAINER_STATE_INVALID                                              = 0x000019f2,
    ERROR_LOG_STATE_INVALID                                                        = 0x000019f3,
    ERROR_LOG_PINNED                                                               = 0x000019f4,
    ERROR_LOG_METADATA_FLUSH_FAILED                                                = 0x000019f5,
    ERROR_LOG_INCONSISTENT_SECURITY                                                = 0x000019f6,
    ERROR_LOG_APPENDED_FLUSH_FAILED                                                = 0x000019f7,
    ERROR_LOG_PINNED_RESERVATION                                                   = 0x000019f8,
    ERROR_INVALID_TRANSACTION                                                      = 0x00001a2c,
    ERROR_TRANSACTION_NOT_ACTIVE                                                   = 0x00001a2d,
    ERROR_TRANSACTION_REQUEST_NOT_VALID                                            = 0x00001a2e,
    ERROR_TRANSACTION_NOT_REQUESTED                                                = 0x00001a2f,
    ERROR_TRANSACTION_ALREADY_ABORTED                                              = 0x00001a30,
    ERROR_TRANSACTION_ALREADY_COMMITTED                                            = 0x00001a31,
    ERROR_TM_INITIALIZATION_FAILED                                                 = 0x00001a32,
    ERROR_RESOURCEMANAGER_READ_ONLY                                                = 0x00001a33,
    ERROR_TRANSACTION_NOT_JOINED                                                   = 0x00001a34,
    ERROR_TRANSACTION_SUPERIOR_EXISTS                                              = 0x00001a35,
    ERROR_CRM_PROTOCOL_ALREADY_EXISTS                                              = 0x00001a36,
    ERROR_TRANSACTION_PROPAGATION_FAILED                                           = 0x00001a37,
    ERROR_CRM_PROTOCOL_NOT_FOUND                                                   = 0x00001a38,
    ERROR_TRANSACTION_INVALID_MARSHALL_BUFFER                                      = 0x00001a39,
    ERROR_CURRENT_TRANSACTION_NOT_VALID                                            = 0x00001a3a,
    ERROR_TRANSACTION_NOT_FOUND                                                    = 0x00001a3b,
    ERROR_RESOURCEMANAGER_NOT_FOUND                                                = 0x00001a3c,
    ERROR_ENLISTMENT_NOT_FOUND                                                     = 0x00001a3d,
    ERROR_TRANSACTIONMANAGER_NOT_FOUND                                             = 0x00001a3e,
    ERROR_TRANSACTIONMANAGER_NOT_ONLINE                                            = 0x00001a3f,
    ERROR_TRANSACTIONMANAGER_RECOVERY_NAME_COLLISION                               = 0x00001a40,
    ERROR_TRANSACTION_NOT_ROOT                                                     = 0x00001a41,
    ERROR_TRANSACTION_OBJECT_EXPIRED                                               = 0x00001a42,
    ERROR_TRANSACTION_RESPONSE_NOT_ENLISTED                                        = 0x00001a43,
    ERROR_TRANSACTION_RECORD_TOO_LONG                                              = 0x00001a44,
    ERROR_IMPLICIT_TRANSACTION_NOT_SUPPORTED                                       = 0x00001a45,
    ERROR_TRANSACTION_INTEGRITY_VIOLATED                                           = 0x00001a46,
    ERROR_TRANSACTIONMANAGER_IDENTITY_MISMATCH                                     = 0x00001a47,
    ERROR_RM_CANNOT_BE_FROZEN_FOR_SNAPSHOT                                         = 0x00001a48,
    ERROR_TRANSACTION_MUST_WRITETHROUGH                                            = 0x00001a49,
    ERROR_TRANSACTION_NO_SUPERIOR                                                  = 0x00001a4a,
    ERROR_HEURISTIC_DAMAGE_POSSIBLE                                                = 0x00001a4b,
    ERROR_TRANSACTIONAL_CONFLICT                                                   = 0x00001a90,
    ERROR_RM_NOT_ACTIVE                                                            = 0x00001a91,
    ERROR_RM_METADATA_CORRUPT                                                      = 0x00001a92,
    ERROR_DIRECTORY_NOT_RM                                                         = 0x00001a93,
    ERROR_TRANSACTIONS_UNSUPPORTED_REMOTE                                          = 0x00001a95,
    ERROR_LOG_RESIZE_INVALID_SIZE                                                  = 0x00001a96,
    ERROR_OBJECT_NO_LONGER_EXISTS                                                  = 0x00001a97,
    ERROR_STREAM_MINIVERSION_NOT_FOUND                                             = 0x00001a98,
    ERROR_STREAM_MINIVERSION_NOT_VALID                                             = 0x00001a99,
    ERROR_MINIVERSION_INACCESSIBLE_FROM_SPECIFIED_TRANSACTION                      = 0x00001a9a,
    ERROR_CANT_OPEN_MINIVERSION_WITH_MODIFY_INTENT                                 = 0x00001a9b,
    ERROR_CANT_CREATE_MORE_STREAM_MINIVERSIONS                                     = 0x00001a9c,
    ERROR_REMOTE_FILE_VERSION_MISMATCH                                             = 0x00001a9e,
    ERROR_HANDLE_NO_LONGER_VALID                                                   = 0x00001a9f,
    ERROR_NO_TXF_METADATA                                                          = 0x00001aa0,
    ERROR_LOG_CORRUPTION_DETECTED                                                  = 0x00001aa1,
    ERROR_CANT_RECOVER_WITH_HANDLE_OPEN                                            = 0x00001aa2,
    ERROR_RM_DISCONNECTED                                                          = 0x00001aa3,
    ERROR_ENLISTMENT_NOT_SUPERIOR                                                  = 0x00001aa4,
    ERROR_RECOVERY_NOT_NEEDED                                                      = 0x00001aa5,
    ERROR_RM_ALREADY_STARTED                                                       = 0x00001aa6,
    ERROR_FILE_IDENTITY_NOT_PERSISTENT                                             = 0x00001aa7,
    ERROR_CANT_BREAK_TRANSACTIONAL_DEPENDENCY                                      = 0x00001aa8,
    ERROR_CANT_CROSS_RM_BOUNDARY                                                   = 0x00001aa9,
    ERROR_TXF_DIR_NOT_EMPTY                                                        = 0x00001aaa,
    ERROR_INDOUBT_TRANSACTIONS_EXIST                                               = 0x00001aab,
    ERROR_TM_VOLATILE                                                              = 0x00001aac,
    ERROR_ROLLBACK_TIMER_EXPIRED                                                   = 0x00001aad,
    ERROR_TXF_ATTRIBUTE_CORRUPT                                                    = 0x00001aae,
    ERROR_EFS_NOT_ALLOWED_IN_TRANSACTION                                           = 0x00001aaf,
    ERROR_TRANSACTIONAL_OPEN_NOT_ALLOWED                                           = 0x00001ab0,
    ERROR_LOG_GROWTH_FAILED                                                        = 0x00001ab1,
    ERROR_TRANSACTED_MAPPING_UNSUPPORTED_REMOTE                                    = 0x00001ab2,
    ERROR_TXF_METADATA_ALREADY_PRESENT                                             = 0x00001ab3,
    ERROR_TRANSACTION_SCOPE_CALLBACKS_NOT_SET                                      = 0x00001ab4,
    ERROR_TRANSACTION_REQUIRED_PROMOTION                                           = 0x00001ab5,
    ERROR_CANNOT_EXECUTE_FILE_IN_TRANSACTION                                       = 0x00001ab6,
    ERROR_TRANSACTIONS_NOT_FROZEN                                                  = 0x00001ab7,
    ERROR_TRANSACTION_FREEZE_IN_PROGRESS                                           = 0x00001ab8,
    ERROR_NOT_SNAPSHOT_VOLUME                                                      = 0x00001ab9,
    ERROR_NO_SAVEPOINT_WITH_OPEN_FILES                                             = 0x00001aba,
    ERROR_DATA_LOST_REPAIR                                                         = 0x00001abb,
    ERROR_SPARSE_NOT_ALLOWED_IN_TRANSACTION                                        = 0x00001abc,
    ERROR_TM_IDENTITY_MISMATCH                                                     = 0x00001abd,
    ERROR_FLOATED_SECTION                                                          = 0x00001abe,
    ERROR_CANNOT_ACCEPT_TRANSACTED_WORK                                            = 0x00001abf,
    ERROR_CANNOT_ABORT_TRANSACTIONS                                                = 0x00001ac0,
    ERROR_BAD_CLUSTERS                                                             = 0x00001ac1,
    ERROR_COMPRESSION_NOT_ALLOWED_IN_TRANSACTION                                   = 0x00001ac2,
    ERROR_VOLUME_DIRTY                                                             = 0x00001ac3,
    ERROR_NO_LINK_TRACKING_IN_TRANSACTION                                          = 0x00001ac4,
    ERROR_OPERATION_NOT_SUPPORTED_IN_TRANSACTION                                   = 0x00001ac5,
    ERROR_EXPIRED_HANDLE                                                           = 0x00001ac6,
    ERROR_TRANSACTION_NOT_ENLISTED                                                 = 0x00001ac7,
    ERROR_ENLISTMENT_NOT_INITIALIZED                                               = 0x00001ac8,
    ERROR_CTX_WINSTATION_NAME_INVALID                                              = 0x00001b59,
    ERROR_CTX_INVALID_PD                                                           = 0x00001b5a,
    ERROR_CTX_PD_NOT_FOUND                                                         = 0x00001b5b,
    ERROR_CTX_WD_NOT_FOUND                                                         = 0x00001b5c,
    ERROR_CTX_CANNOT_MAKE_EVENTLOG_ENTRY                                           = 0x00001b5d,
    ERROR_CTX_SERVICE_NAME_COLLISION                                               = 0x00001b5e,
    ERROR_CTX_CLOSE_PENDING                                                        = 0x00001b5f,
    ERROR_CTX_NO_OUTBUF                                                            = 0x00001b60,
    ERROR_CTX_MODEM_INF_NOT_FOUND                                                  = 0x00001b61,
    ERROR_CTX_INVALID_MODEMNAME                                                    = 0x00001b62,
    ERROR_CTX_MODEM_RESPONSE_ERROR                                                 = 0x00001b63,
    ERROR_CTX_MODEM_RESPONSE_TIMEOUT                                               = 0x00001b64,
    ERROR_CTX_MODEM_RESPONSE_NO_CARRIER                                            = 0x00001b65,
    ERROR_CTX_MODEM_RESPONSE_NO_DIALTONE                                           = 0x00001b66,
    ERROR_CTX_MODEM_RESPONSE_BUSY                                                  = 0x00001b67,
    ERROR_CTX_MODEM_RESPONSE_VOICE                                                 = 0x00001b68,
    ERROR_CTX_TD_ERROR                                                             = 0x00001b69,
    ERROR_CTX_WINSTATION_NOT_FOUND                                                 = 0x00001b6e,
    ERROR_CTX_WINSTATION_ALREADY_EXISTS                                            = 0x00001b6f,
    ERROR_CTX_WINSTATION_BUSY                                                      = 0x00001b70,
    ERROR_CTX_BAD_VIDEO_MODE                                                       = 0x00001b71,
    ERROR_CTX_GRAPHICS_INVALID                                                     = 0x00001b7b,
    ERROR_CTX_LOGON_DISABLED                                                       = 0x00001b7d,
    ERROR_CTX_NOT_CONSOLE                                                          = 0x00001b7e,
    ERROR_CTX_CLIENT_QUERY_TIMEOUT                                                 = 0x00001b80,
    ERROR_CTX_CONSOLE_DISCONNECT                                                   = 0x00001b81,
    ERROR_CTX_CONSOLE_CONNECT                                                      = 0x00001b82,
    ERROR_CTX_SHADOW_DENIED                                                        = 0x00001b84,
    ERROR_CTX_WINSTATION_ACCESS_DENIED                                             = 0x00001b85,
    ERROR_CTX_INVALID_WD                                                           = 0x00001b89,
    ERROR_CTX_SHADOW_INVALID                                                       = 0x00001b8a,
    ERROR_CTX_SHADOW_DISABLED                                                      = 0x00001b8b,
    ERROR_CTX_CLIENT_LICENSE_IN_USE                                                = 0x00001b8c,
    ERROR_CTX_CLIENT_LICENSE_NOT_SET                                               = 0x00001b8d,
    ERROR_CTX_LICENSE_NOT_AVAILABLE                                                = 0x00001b8e,
    ERROR_CTX_LICENSE_CLIENT_INVALID                                               = 0x00001b8f,
    ERROR_CTX_LICENSE_EXPIRED                                                      = 0x00001b90,
    ERROR_CTX_SHADOW_NOT_RUNNING                                                   = 0x00001b91,
    ERROR_CTX_SHADOW_ENDED_BY_MODE_CHANGE                                          = 0x00001b92,
    ERROR_ACTIVATION_COUNT_EXCEEDED                                                = 0x00001b93,
    ERROR_CTX_WINSTATIONS_DISABLED                                                 = 0x00001b94,
    ERROR_CTX_ENCRYPTION_LEVEL_REQUIRED                                            = 0x00001b95,
    ERROR_CTX_SESSION_IN_USE                                                       = 0x00001b96,
    ERROR_CTX_NO_FORCE_LOGOFF                                                      = 0x00001b97,
    ERROR_CTX_ACCOUNT_RESTRICTION                                                  = 0x00001b98,
    ERROR_RDP_PROTOCOL_ERROR                                                       = 0x00001b99,
    ERROR_CTX_CDM_CONNECT                                                          = 0x00001b9a,
    ERROR_CTX_CDM_DISCONNECT                                                       = 0x00001b9b,
    ERROR_CTX_SECURITY_LAYER_ERROR                                                 = 0x00001b9c,
    ERROR_TS_INCOMPATIBLE_SESSIONS                                                 = 0x00001b9d,
    ERROR_TS_VIDEO_SUBSYSTEM_ERROR                                                 = 0x00001b9e,
    ERROR_DS_NOT_INSTALLED                                                         = 0x00002008,
    ERROR_DS_MEMBERSHIP_EVALUATED_LOCALLY                                          = 0x00002009,
    ERROR_DS_NO_ATTRIBUTE_OR_VALUE                                                 = 0x0000200a,
    ERROR_DS_INVALID_ATTRIBUTE_SYNTAX                                              = 0x0000200b,
    ERROR_DS_ATTRIBUTE_TYPE_UNDEFINED                                              = 0x0000200c,
    ERROR_DS_ATTRIBUTE_OR_VALUE_EXISTS                                             = 0x0000200d,
    ERROR_DS_BUSY                                                                  = 0x0000200e,
    ERROR_DS_UNAVAILABLE                                                           = 0x0000200f,
    ERROR_DS_NO_RIDS_ALLOCATED                                                     = 0x00002010,
    ERROR_DS_NO_MORE_RIDS                                                          = 0x00002011,
    ERROR_DS_INCORRECT_ROLE_OWNER                                                  = 0x00002012,
    ERROR_DS_RIDMGR_INIT_ERROR                                                     = 0x00002013,
    ERROR_DS_OBJ_CLASS_VIOLATION                                                   = 0x00002014,
    ERROR_DS_CANT_ON_NON_LEAF                                                      = 0x00002015,
    ERROR_DS_CANT_ON_RDN                                                           = 0x00002016,
    ERROR_DS_CANT_MOD_OBJ_CLASS                                                    = 0x00002017,
    ERROR_DS_CROSS_DOM_MOVE_ERROR                                                  = 0x00002018,
    ERROR_DS_GC_NOT_AVAILABLE                                                      = 0x00002019,
    ERROR_SHARED_POLICY                                                            = 0x0000201a,
    ERROR_POLICY_OBJECT_NOT_FOUND                                                  = 0x0000201b,
    ERROR_POLICY_ONLY_IN_DS                                                        = 0x0000201c,
    ERROR_PROMOTION_ACTIVE                                                         = 0x0000201d,
    ERROR_NO_PROMOTION_ACTIVE                                                      = 0x0000201e,
    ERROR_DS_OPERATIONS_ERROR                                                      = 0x00002020,
    ERROR_DS_PROTOCOL_ERROR                                                        = 0x00002021,
    ERROR_DS_TIMELIMIT_EXCEEDED                                                    = 0x00002022,
    ERROR_DS_SIZELIMIT_EXCEEDED                                                    = 0x00002023,
    ERROR_DS_ADMIN_LIMIT_EXCEEDED                                                  = 0x00002024,
    ERROR_DS_COMPARE_FALSE                                                         = 0x00002025,
    ERROR_DS_COMPARE_TRUE                                                          = 0x00002026,
    ERROR_DS_AUTH_METHOD_NOT_SUPPORTED                                             = 0x00002027,
    ERROR_DS_STRONG_AUTH_REQUIRED                                                  = 0x00002028,
    ERROR_DS_INAPPROPRIATE_AUTH                                                    = 0x00002029,
    ERROR_DS_AUTH_UNKNOWN                                                          = 0x0000202a,
    ERROR_DS_REFERRAL                                                              = 0x0000202b,
    ERROR_DS_UNAVAILABLE_CRIT_EXTENSION                                            = 0x0000202c,
    ERROR_DS_CONFIDENTIALITY_REQUIRED                                              = 0x0000202d,
    ERROR_DS_INAPPROPRIATE_MATCHING                                                = 0x0000202e,
    ERROR_DS_CONSTRAINT_VIOLATION                                                  = 0x0000202f,
    ERROR_DS_NO_SUCH_OBJECT                                                        = 0x00002030,
    ERROR_DS_ALIAS_PROBLEM                                                         = 0x00002031,
    ERROR_DS_INVALID_DN_SYNTAX                                                     = 0x00002032,
    ERROR_DS_IS_LEAF                                                               = 0x00002033,
    ERROR_DS_ALIAS_DEREF_PROBLEM                                                   = 0x00002034,
    ERROR_DS_UNWILLING_TO_PERFORM                                                  = 0x00002035,
    ERROR_DS_LOOP_DETECT                                                           = 0x00002036,
    ERROR_DS_NAMING_VIOLATION                                                      = 0x00002037,
    ERROR_DS_OBJECT_RESULTS_TOO_LARGE                                              = 0x00002038,
    ERROR_DS_AFFECTS_MULTIPLE_DSAS                                                 = 0x00002039,
    ERROR_DS_SERVER_DOWN                                                           = 0x0000203a,
    ERROR_DS_LOCAL_ERROR                                                           = 0x0000203b,
    ERROR_DS_ENCODING_ERROR                                                        = 0x0000203c,
    ERROR_DS_DECODING_ERROR                                                        = 0x0000203d,
    ERROR_DS_FILTER_UNKNOWN                                                        = 0x0000203e,
    ERROR_DS_PARAM_ERROR                                                           = 0x0000203f,
    ERROR_DS_NOT_SUPPORTED                                                         = 0x00002040,
    ERROR_DS_NO_RESULTS_RETURNED                                                   = 0x00002041,
    ERROR_DS_CONTROL_NOT_FOUND                                                     = 0x00002042,
    ERROR_DS_CLIENT_LOOP                                                           = 0x00002043,
    ERROR_DS_REFERRAL_LIMIT_EXCEEDED                                               = 0x00002044,
    ERROR_DS_SORT_CONTROL_MISSING                                                  = 0x00002045,
    ERROR_DS_OFFSET_RANGE_ERROR                                                    = 0x00002046,
    ERROR_DS_RIDMGR_DISABLED                                                       = 0x00002047,
    ERROR_DS_ROOT_MUST_BE_NC                                                       = 0x0000206d,
    ERROR_DS_ADD_REPLICA_INHIBITED                                                 = 0x0000206e,
    ERROR_DS_ATT_NOT_DEF_IN_SCHEMA                                                 = 0x0000206f,
    ERROR_DS_MAX_OBJ_SIZE_EXCEEDED                                                 = 0x00002070,
    ERROR_DS_OBJ_STRING_NAME_EXISTS                                                = 0x00002071,
    ERROR_DS_NO_RDN_DEFINED_IN_SCHEMA                                              = 0x00002072,
    ERROR_DS_RDN_DOESNT_MATCH_SCHEMA                                               = 0x00002073,
    ERROR_DS_NO_REQUESTED_ATTS_FOUND                                               = 0x00002074,
    ERROR_DS_USER_BUFFER_TO_SMALL                                                  = 0x00002075,
    ERROR_DS_ATT_IS_NOT_ON_OBJ                                                     = 0x00002076,
    ERROR_DS_ILLEGAL_MOD_OPERATION                                                 = 0x00002077,
    ERROR_DS_OBJ_TOO_LARGE                                                         = 0x00002078,
    ERROR_DS_BAD_INSTANCE_TYPE                                                     = 0x00002079,
    ERROR_DS_MASTERDSA_REQUIRED                                                    = 0x0000207a,
    ERROR_DS_OBJECT_CLASS_REQUIRED                                                 = 0x0000207b,
    ERROR_DS_MISSING_REQUIRED_ATT                                                  = 0x0000207c,
    ERROR_DS_ATT_NOT_DEF_FOR_CLASS                                                 = 0x0000207d,
    ERROR_DS_ATT_ALREADY_EXISTS                                                    = 0x0000207e,
    ERROR_DS_CANT_ADD_ATT_VALUES                                                   = 0x00002080,
    ERROR_DS_SINGLE_VALUE_CONSTRAINT                                               = 0x00002081,
    ERROR_DS_RANGE_CONSTRAINT                                                      = 0x00002082,
    ERROR_DS_ATT_VAL_ALREADY_EXISTS                                                = 0x00002083,
    ERROR_DS_CANT_REM_MISSING_ATT                                                  = 0x00002084,
    ERROR_DS_CANT_REM_MISSING_ATT_VAL                                              = 0x00002085,
    ERROR_DS_ROOT_CANT_BE_SUBREF                                                   = 0x00002086,
    ERROR_DS_NO_CHAINING                                                           = 0x00002087,
    ERROR_DS_NO_CHAINED_EVAL                                                       = 0x00002088,
    ERROR_DS_NO_PARENT_OBJECT                                                      = 0x00002089,
    ERROR_DS_PARENT_IS_AN_ALIAS                                                    = 0x0000208a,
    ERROR_DS_CANT_MIX_MASTER_AND_REPS                                              = 0x0000208b,
    ERROR_DS_CHILDREN_EXIST                                                        = 0x0000208c,
    ERROR_DS_OBJ_NOT_FOUND                                                         = 0x0000208d,
    ERROR_DS_ALIASED_OBJ_MISSING                                                   = 0x0000208e,
    ERROR_DS_BAD_NAME_SYNTAX                                                       = 0x0000208f,
    ERROR_DS_ALIAS_POINTS_TO_ALIAS                                                 = 0x00002090,
    ERROR_DS_CANT_DEREF_ALIAS                                                      = 0x00002091,
    ERROR_DS_OUT_OF_SCOPE                                                          = 0x00002092,
    ERROR_DS_OBJECT_BEING_REMOVED                                                  = 0x00002093,
    ERROR_DS_CANT_DELETE_DSA_OBJ                                                   = 0x00002094,
    ERROR_DS_GENERIC_ERROR                                                         = 0x00002095,
    ERROR_DS_DSA_MUST_BE_INT_MASTER                                                = 0x00002096,
    ERROR_DS_CLASS_NOT_DSA                                                         = 0x00002097,
    ERROR_DS_INSUFF_ACCESS_RIGHTS                                                  = 0x00002098,
    ERROR_DS_ILLEGAL_SUPERIOR                                                      = 0x00002099,
    ERROR_DS_ATTRIBUTE_OWNED_BY_SAM                                                = 0x0000209a,
    ERROR_DS_NAME_TOO_MANY_PARTS                                                   = 0x0000209b,
    ERROR_DS_NAME_TOO_LONG                                                         = 0x0000209c,
    ERROR_DS_NAME_VALUE_TOO_LONG                                                   = 0x0000209d,
    ERROR_DS_NAME_UNPARSEABLE                                                      = 0x0000209e,
    ERROR_DS_NAME_TYPE_UNKNOWN                                                     = 0x0000209f,
    ERROR_DS_NOT_AN_OBJECT                                                         = 0x000020a0,
    ERROR_DS_SEC_DESC_TOO_SHORT                                                    = 0x000020a1,
    ERROR_DS_SEC_DESC_INVALID                                                      = 0x000020a2,
    ERROR_DS_NO_DELETED_NAME                                                       = 0x000020a3,
    ERROR_DS_SUBREF_MUST_HAVE_PARENT                                               = 0x000020a4,
    ERROR_DS_NCNAME_MUST_BE_NC                                                     = 0x000020a5,
    ERROR_DS_CANT_ADD_SYSTEM_ONLY                                                  = 0x000020a6,
    ERROR_DS_CLASS_MUST_BE_CONCRETE                                                = 0x000020a7,
    ERROR_DS_INVALID_DMD                                                           = 0x000020a8,
    ERROR_DS_OBJ_GUID_EXISTS                                                       = 0x000020a9,
    ERROR_DS_NOT_ON_BACKLINK                                                       = 0x000020aa,
    ERROR_DS_NO_CROSSREF_FOR_NC                                                    = 0x000020ab,
    ERROR_DS_SHUTTING_DOWN                                                         = 0x000020ac,
    ERROR_DS_UNKNOWN_OPERATION                                                     = 0x000020ad,
    ERROR_DS_INVALID_ROLE_OWNER                                                    = 0x000020ae,
    ERROR_DS_COULDNT_CONTACT_FSMO                                                  = 0x000020af,
    ERROR_DS_CROSS_NC_DN_RENAME                                                    = 0x000020b0,
    ERROR_DS_CANT_MOD_SYSTEM_ONLY                                                  = 0x000020b1,
    ERROR_DS_REPLICATOR_ONLY                                                       = 0x000020b2,
    ERROR_DS_OBJ_CLASS_NOT_DEFINED                                                 = 0x000020b3,
    ERROR_DS_OBJ_CLASS_NOT_SUBCLASS                                                = 0x000020b4,
    ERROR_DS_NAME_REFERENCE_INVALID                                                = 0x000020b5,
    ERROR_DS_CROSS_REF_EXISTS                                                      = 0x000020b6,
    ERROR_DS_CANT_DEL_MASTER_CROSSREF                                              = 0x000020b7,
    ERROR_DS_SUBTREE_NOTIFY_NOT_NC_HEAD                                            = 0x000020b8,
    ERROR_DS_NOTIFY_FILTER_TOO_COMPLEX                                             = 0x000020b9,
    ERROR_DS_DUP_RDN                                                               = 0x000020ba,
    ERROR_DS_DUP_OID                                                               = 0x000020bb,
    ERROR_DS_DUP_MAPI_ID                                                           = 0x000020bc,
    ERROR_DS_DUP_SCHEMA_ID_GUID                                                    = 0x000020bd,
    ERROR_DS_DUP_LDAP_DISPLAY_NAME                                                 = 0x000020be,
    ERROR_DS_SEMANTIC_ATT_TEST                                                     = 0x000020bf,
    ERROR_DS_SYNTAX_MISMATCH                                                       = 0x000020c0,
    ERROR_DS_EXISTS_IN_MUST_HAVE                                                   = 0x000020c1,
    ERROR_DS_EXISTS_IN_MAY_HAVE                                                    = 0x000020c2,
    ERROR_DS_NONEXISTENT_MAY_HAVE                                                  = 0x000020c3,
    ERROR_DS_NONEXISTENT_MUST_HAVE                                                 = 0x000020c4,
    ERROR_DS_AUX_CLS_TEST_FAIL                                                     = 0x000020c5,
    ERROR_DS_NONEXISTENT_POSS_SUP                                                  = 0x000020c6,
    ERROR_DS_SUB_CLS_TEST_FAIL                                                     = 0x000020c7,
    ERROR_DS_BAD_RDN_ATT_ID_SYNTAX                                                 = 0x000020c8,
    ERROR_DS_EXISTS_IN_AUX_CLS                                                     = 0x000020c9,
    ERROR_DS_EXISTS_IN_SUB_CLS                                                     = 0x000020ca,
    ERROR_DS_EXISTS_IN_POSS_SUP                                                    = 0x000020cb,
    ERROR_DS_RECALCSCHEMA_FAILED                                                   = 0x000020cc,
    ERROR_DS_TREE_DELETE_NOT_FINISHED                                              = 0x000020cd,
    ERROR_DS_CANT_DELETE                                                           = 0x000020ce,
    ERROR_DS_ATT_SCHEMA_REQ_ID                                                     = 0x000020cf,
    ERROR_DS_BAD_ATT_SCHEMA_SYNTAX                                                 = 0x000020d0,
    ERROR_DS_CANT_CACHE_ATT                                                        = 0x000020d1,
    ERROR_DS_CANT_CACHE_CLASS                                                      = 0x000020d2,
    ERROR_DS_CANT_REMOVE_ATT_CACHE                                                 = 0x000020d3,
    ERROR_DS_CANT_REMOVE_CLASS_CACHE                                               = 0x000020d4,
    ERROR_DS_CANT_RETRIEVE_DN                                                      = 0x000020d5,
    ERROR_DS_MISSING_SUPREF                                                        = 0x000020d6,
    ERROR_DS_CANT_RETRIEVE_INSTANCE                                                = 0x000020d7,
    ERROR_DS_CODE_INCONSISTENCY                                                    = 0x000020d8,
    ERROR_DS_DATABASE_ERROR                                                        = 0x000020d9,
    ERROR_DS_GOVERNSID_MISSING                                                     = 0x000020da,
    ERROR_DS_MISSING_EXPECTED_ATT                                                  = 0x000020db,
    ERROR_DS_NCNAME_MISSING_CR_REF                                                 = 0x000020dc,
    ERROR_DS_SECURITY_CHECKING_ERROR                                               = 0x000020dd,
    ERROR_DS_SCHEMA_NOT_LOADED                                                     = 0x000020de,
    ERROR_DS_SCHEMA_ALLOC_FAILED                                                   = 0x000020df,
    ERROR_DS_ATT_SCHEMA_REQ_SYNTAX                                                 = 0x000020e0,
    ERROR_DS_GCVERIFY_ERROR                                                        = 0x000020e1,
    ERROR_DS_DRA_SCHEMA_MISMATCH                                                   = 0x000020e2,
    ERROR_DS_CANT_FIND_DSA_OBJ                                                     = 0x000020e3,
    ERROR_DS_CANT_FIND_EXPECTED_NC                                                 = 0x000020e4,
    ERROR_DS_CANT_FIND_NC_IN_CACHE                                                 = 0x000020e5,
    ERROR_DS_CANT_RETRIEVE_CHILD                                                   = 0x000020e6,
    ERROR_DS_SECURITY_ILLEGAL_MODIFY                                               = 0x000020e7,
    ERROR_DS_CANT_REPLACE_HIDDEN_REC                                               = 0x000020e8,
    ERROR_DS_BAD_HIERARCHY_FILE                                                    = 0x000020e9,
    ERROR_DS_BUILD_HIERARCHY_TABLE_FAILED                                          = 0x000020ea,
    ERROR_DS_CONFIG_PARAM_MISSING                                                  = 0x000020eb,
    ERROR_DS_COUNTING_AB_INDICES_FAILED                                            = 0x000020ec,
    ERROR_DS_HIERARCHY_TABLE_MALLOC_FAILED                                         = 0x000020ed,
    ERROR_DS_INTERNAL_FAILURE                                                      = 0x000020ee,
    ERROR_DS_UNKNOWN_ERROR                                                         = 0x000020ef,
    ERROR_DS_ROOT_REQUIRES_CLASS_TOP                                               = 0x000020f0,
    ERROR_DS_REFUSING_FSMO_ROLES                                                   = 0x000020f1,
    ERROR_DS_MISSING_FSMO_SETTINGS                                                 = 0x000020f2,
    ERROR_DS_UNABLE_TO_SURRENDER_ROLES                                             = 0x000020f3,
    ERROR_DS_DRA_GENERIC                                                           = 0x000020f4,
    ERROR_DS_DRA_INVALID_PARAMETER                                                 = 0x000020f5,
    ERROR_DS_DRA_BUSY                                                              = 0x000020f6,
    ERROR_DS_DRA_BAD_DN                                                            = 0x000020f7,
    ERROR_DS_DRA_BAD_NC                                                            = 0x000020f8,
    ERROR_DS_DRA_DN_EXISTS                                                         = 0x000020f9,
    ERROR_DS_DRA_INTERNAL_ERROR                                                    = 0x000020fa,
    ERROR_DS_DRA_INCONSISTENT_DIT                                                  = 0x000020fb,
    ERROR_DS_DRA_CONNECTION_FAILED                                                 = 0x000020fc,
    ERROR_DS_DRA_BAD_INSTANCE_TYPE                                                 = 0x000020fd,
    ERROR_DS_DRA_OUT_OF_MEM                                                        = 0x000020fe,
    ERROR_DS_DRA_MAIL_PROBLEM                                                      = 0x000020ff,
    ERROR_DS_DRA_REF_ALREADY_EXISTS                                                = 0x00002100,
    ERROR_DS_DRA_REF_NOT_FOUND                                                     = 0x00002101,
    ERROR_DS_DRA_OBJ_IS_REP_SOURCE                                                 = 0x00002102,
    ERROR_DS_DRA_DB_ERROR                                                          = 0x00002103,
    ERROR_DS_DRA_NO_REPLICA                                                        = 0x00002104,
    ERROR_DS_DRA_ACCESS_DENIED                                                     = 0x00002105,
    ERROR_DS_DRA_NOT_SUPPORTED                                                     = 0x00002106,
    ERROR_DS_DRA_RPC_CANCELLED                                                     = 0x00002107,
    ERROR_DS_DRA_SOURCE_DISABLED                                                   = 0x00002108,
    ERROR_DS_DRA_SINK_DISABLED                                                     = 0x00002109,
    ERROR_DS_DRA_NAME_COLLISION                                                    = 0x0000210a,
    ERROR_DS_DRA_SOURCE_REINSTALLED                                                = 0x0000210b,
    ERROR_DS_DRA_MISSING_PARENT                                                    = 0x0000210c,
    ERROR_DS_DRA_PREEMPTED                                                         = 0x0000210d,
    ERROR_DS_DRA_ABANDON_SYNC                                                      = 0x0000210e,
    ERROR_DS_DRA_SHUTDOWN                                                          = 0x0000210f,
    ERROR_DS_DRA_INCOMPATIBLE_PARTIAL_SET                                          = 0x00002110,
    ERROR_DS_DRA_SOURCE_IS_PARTIAL_REPLICA                                         = 0x00002111,
    ERROR_DS_DRA_EXTN_CONNECTION_FAILED                                            = 0x00002112,
    ERROR_DS_INSTALL_SCHEMA_MISMATCH                                               = 0x00002113,
    ERROR_DS_DUP_LINK_ID                                                           = 0x00002114,
    ERROR_DS_NAME_ERROR_RESOLVING                                                  = 0x00002115,
    ERROR_DS_NAME_ERROR_NOT_FOUND                                                  = 0x00002116,
    ERROR_DS_NAME_ERROR_NOT_UNIQUE                                                 = 0x00002117,
    ERROR_DS_NAME_ERROR_NO_MAPPING                                                 = 0x00002118,
    ERROR_DS_NAME_ERROR_DOMAIN_ONLY                                                = 0x00002119,
    ERROR_DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING                                     = 0x0000211a,
    ERROR_DS_CONSTRUCTED_ATT_MOD                                                   = 0x0000211b,
    ERROR_DS_WRONG_OM_OBJ_CLASS                                                    = 0x0000211c,
    ERROR_DS_DRA_REPL_PENDING                                                      = 0x0000211d,
    ERROR_DS_DS_REQUIRED                                                           = 0x0000211e,
    ERROR_DS_INVALID_LDAP_DISPLAY_NAME                                             = 0x0000211f,
    ERROR_DS_NON_BASE_SEARCH                                                       = 0x00002120,
    ERROR_DS_CANT_RETRIEVE_ATTS                                                    = 0x00002121,
    ERROR_DS_BACKLINK_WITHOUT_LINK                                                 = 0x00002122,
    ERROR_DS_EPOCH_MISMATCH                                                        = 0x00002123,
    ERROR_DS_SRC_NAME_MISMATCH                                                     = 0x00002124,
    ERROR_DS_SRC_AND_DST_NC_IDENTICAL                                              = 0x00002125,
    ERROR_DS_DST_NC_MISMATCH                                                       = 0x00002126,
    ERROR_DS_NOT_AUTHORITIVE_FOR_DST_NC                                            = 0x00002127,
    ERROR_DS_SRC_GUID_MISMATCH                                                     = 0x00002128,
    ERROR_DS_CANT_MOVE_DELETED_OBJECT                                              = 0x00002129,
    ERROR_DS_PDC_OPERATION_IN_PROGRESS                                             = 0x0000212a,
    ERROR_DS_CROSS_DOMAIN_CLEANUP_REQD                                             = 0x0000212b,
    ERROR_DS_ILLEGAL_XDOM_MOVE_OPERATION                                           = 0x0000212c,
    ERROR_DS_CANT_WITH_ACCT_GROUP_MEMBERSHPS                                       = 0x0000212d,
    ERROR_DS_NC_MUST_HAVE_NC_PARENT                                                = 0x0000212e,
    ERROR_DS_CR_IMPOSSIBLE_TO_VALIDATE                                             = 0x0000212f,
    ERROR_DS_DST_DOMAIN_NOT_NATIVE                                                 = 0x00002130,
    ERROR_DS_MISSING_INFRASTRUCTURE_CONTAINER                                      = 0x00002131,
    ERROR_DS_CANT_MOVE_ACCOUNT_GROUP                                               = 0x00002132,
    ERROR_DS_CANT_MOVE_RESOURCE_GROUP                                              = 0x00002133,
    ERROR_DS_INVALID_SEARCH_FLAG                                                   = 0x00002134,
    ERROR_DS_NO_TREE_DELETE_ABOVE_NC                                               = 0x00002135,
    ERROR_DS_COULDNT_LOCK_TREE_FOR_DELETE                                          = 0x00002136,
    ERROR_DS_COULDNT_IDENTIFY_OBJECTS_FOR_TREE_DELETE                              = 0x00002137,
    ERROR_DS_SAM_INIT_FAILURE                                                      = 0x00002138,
    ERROR_DS_SENSITIVE_GROUP_VIOLATION                                             = 0x00002139,
    ERROR_DS_CANT_MOD_PRIMARYGROUPID                                               = 0x0000213a,
    ERROR_DS_ILLEGAL_BASE_SCHEMA_MOD                                               = 0x0000213b,
    ERROR_DS_NONSAFE_SCHEMA_CHANGE                                                 = 0x0000213c,
    ERROR_DS_SCHEMA_UPDATE_DISALLOWED                                              = 0x0000213d,
    ERROR_DS_CANT_CREATE_UNDER_SCHEMA                                              = 0x0000213e,
    ERROR_DS_INSTALL_NO_SRC_SCH_VERSION                                            = 0x0000213f,
    ERROR_DS_INSTALL_NO_SCH_VERSION_IN_INIFILE                                     = 0x00002140,
    ERROR_DS_INVALID_GROUP_TYPE                                                    = 0x00002141,
    ERROR_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN                                    = 0x00002142,
    ERROR_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN                                     = 0x00002143,
    ERROR_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER                                         = 0x00002144,
    ERROR_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER                                     = 0x00002145,
    ERROR_DS_UNIVERSAL_CANT_HAVE_LOCAL_MEMBER                                      = 0x00002146,
    ERROR_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER                                   = 0x00002147,
    ERROR_DS_LOCAL_CANT_HAVE_CROSSDOMAIN_LOCAL_MEMBER                              = 0x00002148,
    ERROR_DS_HAVE_PRIMARY_MEMBERS                                                  = 0x00002149,
    ERROR_DS_STRING_SD_CONVERSION_FAILED                                           = 0x0000214a,
    ERROR_DS_NAMING_MASTER_GC                                                      = 0x0000214b,
    ERROR_DS_DNS_LOOKUP_FAILURE                                                    = 0x0000214c,
    ERROR_DS_COULDNT_UPDATE_SPNS                                                   = 0x0000214d,
    ERROR_DS_CANT_RETRIEVE_SD                                                      = 0x0000214e,
    ERROR_DS_KEY_NOT_UNIQUE                                                        = 0x0000214f,
    ERROR_DS_WRONG_LINKED_ATT_SYNTAX                                               = 0x00002150,
    ERROR_DS_SAM_NEED_BOOTKEY_PASSWORD                                             = 0x00002151,
    ERROR_DS_SAM_NEED_BOOTKEY_FLOPPY                                               = 0x00002152,
    ERROR_DS_CANT_START                                                            = 0x00002153,
    ERROR_DS_INIT_FAILURE                                                          = 0x00002154,
    ERROR_DS_NO_PKT_PRIVACY_ON_CONNECTION                                          = 0x00002155,
    ERROR_DS_SOURCE_DOMAIN_IN_FOREST                                               = 0x00002156,
    ERROR_DS_DESTINATION_DOMAIN_NOT_IN_FOREST                                      = 0x00002157,
    ERROR_DS_DESTINATION_AUDITING_NOT_ENABLED                                      = 0x00002158,
    ERROR_DS_CANT_FIND_DC_FOR_SRC_DOMAIN                                           = 0x00002159,
    ERROR_DS_SRC_OBJ_NOT_GROUP_OR_USER                                             = 0x0000215a,
    ERROR_DS_SRC_SID_EXISTS_IN_FOREST                                              = 0x0000215b,
    ERROR_DS_SRC_AND_DST_OBJECT_CLASS_MISMATCH                                     = 0x0000215c,
    ERROR_SAM_INIT_FAILURE                                                         = 0x0000215d,
    ERROR_DS_DRA_SCHEMA_INFO_SHIP                                                  = 0x0000215e,
    ERROR_DS_DRA_SCHEMA_CONFLICT                                                   = 0x0000215f,
    ERROR_DS_DRA_EARLIER_SCHEMA_CONFLICT                                           = 0x00002160,
    ERROR_DS_DRA_OBJ_NC_MISMATCH                                                   = 0x00002161,
    ERROR_DS_NC_STILL_HAS_DSAS                                                     = 0x00002162,
    ERROR_DS_GC_REQUIRED                                                           = 0x00002163,
    ERROR_DS_LOCAL_MEMBER_OF_LOCAL_ONLY                                            = 0x00002164,
    ERROR_DS_NO_FPO_IN_UNIVERSAL_GROUPS                                            = 0x00002165,
    ERROR_DS_CANT_ADD_TO_GC                                                        = 0x00002166,
    ERROR_DS_NO_CHECKPOINT_WITH_PDC                                                = 0x00002167,
    ERROR_DS_SOURCE_AUDITING_NOT_ENABLED                                           = 0x00002168,
    ERROR_DS_CANT_CREATE_IN_NONDOMAIN_NC                                           = 0x00002169,
    ERROR_DS_INVALID_NAME_FOR_SPN                                                  = 0x0000216a,
    ERROR_DS_FILTER_USES_CONTRUCTED_ATTRS                                          = 0x0000216b,
    ERROR_DS_UNICODEPWD_NOT_IN_QUOTES                                              = 0x0000216c,
    ERROR_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED                                        = 0x0000216d,
    ERROR_DS_MUST_BE_RUN_ON_DST_DC                                                 = 0x0000216e,
    ERROR_DS_SRC_DC_MUST_BE_SP4_OR_GREATER                                         = 0x0000216f,
    ERROR_DS_CANT_TREE_DELETE_CRITICAL_OBJ                                         = 0x00002170,
    ERROR_DS_INIT_FAILURE_CONSOLE                                                  = 0x00002171,
    ERROR_DS_SAM_INIT_FAILURE_CONSOLE                                              = 0x00002172,
    ERROR_DS_FOREST_VERSION_TOO_HIGH                                               = 0x00002173,
    ERROR_DS_DOMAIN_VERSION_TOO_HIGH                                               = 0x00002174,
    ERROR_DS_FOREST_VERSION_TOO_LOW                                                = 0x00002175,
    ERROR_DS_DOMAIN_VERSION_TOO_LOW                                                = 0x00002176,
    ERROR_DS_INCOMPATIBLE_VERSION                                                  = 0x00002177,
    ERROR_DS_LOW_DSA_VERSION                                                       = 0x00002178,
    ERROR_DS_NO_BEHAVIOR_VERSION_IN_MIXEDDOMAIN                                    = 0x00002179,
    ERROR_DS_NOT_SUPPORTED_SORT_ORDER                                              = 0x0000217a,
    ERROR_DS_NAME_NOT_UNIQUE                                                       = 0x0000217b,
    ERROR_DS_MACHINE_ACCOUNT_CREATED_PRENT4                                        = 0x0000217c,
    ERROR_DS_OUT_OF_VERSION_STORE                                                  = 0x0000217d,
    ERROR_DS_INCOMPATIBLE_CONTROLS_USED                                            = 0x0000217e,
    ERROR_DS_NO_REF_DOMAIN                                                         = 0x0000217f,
    ERROR_DS_RESERVED_LINK_ID                                                      = 0x00002180,
    ERROR_DS_LINK_ID_NOT_AVAILABLE                                                 = 0x00002181,
    ERROR_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER                                         = 0x00002182,
    ERROR_DS_MODIFYDN_DISALLOWED_BY_INSTANCE_TYPE                                  = 0x00002183,
    ERROR_DS_NO_OBJECT_MOVE_IN_SCHEMA_NC                                           = 0x00002184,
    ERROR_DS_MODIFYDN_DISALLOWED_BY_FLAG                                           = 0x00002185,
    ERROR_DS_MODIFYDN_WRONG_GRANDPARENT                                            = 0x00002186,
    ERROR_DS_NAME_ERROR_TRUST_REFERRAL                                             = 0x00002187,
    ERROR_NOT_SUPPORTED_ON_STANDARD_SERVER                                         = 0x00002188,
    ERROR_DS_CANT_ACCESS_REMOTE_PART_OF_AD                                         = 0x00002189,
    ERROR_DS_CR_IMPOSSIBLE_TO_VALIDATE_V2                                          = 0x0000218a,
    ERROR_DS_THREAD_LIMIT_EXCEEDED                                                 = 0x0000218b,
    ERROR_DS_NOT_CLOSEST                                                           = 0x0000218c,
    ERROR_DS_CANT_DERIVE_SPN_WITHOUT_SERVER_REF                                    = 0x0000218d,
    ERROR_DS_SINGLE_USER_MODE_FAILED                                               = 0x0000218e,
    ERROR_DS_NTDSCRIPT_SYNTAX_ERROR                                                = 0x0000218f,
    ERROR_DS_NTDSCRIPT_PROCESS_ERROR                                               = 0x00002190,
    ERROR_DS_DIFFERENT_REPL_EPOCHS                                                 = 0x00002191,
    ERROR_DS_DRS_EXTENSIONS_CHANGED                                                = 0x00002192,
    ERROR_DS_REPLICA_SET_CHANGE_NOT_ALLOWED_ON_DISABLED_CR                         = 0x00002193,
    ERROR_DS_NO_MSDS_INTID                                                         = 0x00002194,
    ERROR_DS_DUP_MSDS_INTID                                                        = 0x00002195,
    ERROR_DS_EXISTS_IN_RDNATTID                                                    = 0x00002196,
    ERROR_DS_AUTHORIZATION_FAILED                                                  = 0x00002197,
    ERROR_DS_INVALID_SCRIPT                                                        = 0x00002198,
    ERROR_DS_REMOTE_CROSSREF_OP_FAILED                                             = 0x00002199,
    ERROR_DS_CROSS_REF_BUSY                                                        = 0x0000219a,
    ERROR_DS_CANT_DERIVE_SPN_FOR_DELETED_DOMAIN                                    = 0x0000219b,
    ERROR_DS_CANT_DEMOTE_WITH_WRITEABLE_NC                                         = 0x0000219c,
    ERROR_DS_DUPLICATE_ID_FOUND                                                    = 0x0000219d,
    ERROR_DS_INSUFFICIENT_ATTR_TO_CREATE_OBJECT                                    = 0x0000219e,
    ERROR_DS_GROUP_CONVERSION_ERROR                                                = 0x0000219f,
    ERROR_DS_CANT_MOVE_APP_BASIC_GROUP                                             = 0x000021a0,
    ERROR_DS_CANT_MOVE_APP_QUERY_GROUP                                             = 0x000021a1,
    ERROR_DS_ROLE_NOT_VERIFIED                                                     = 0x000021a2,
    ERROR_DS_WKO_CONTAINER_CANNOT_BE_SPECIAL                                       = 0x000021a3,
    ERROR_DS_DOMAIN_RENAME_IN_PROGRESS                                             = 0x000021a4,
    ERROR_DS_EXISTING_AD_CHILD_NC                                                  = 0x000021a5,
    ERROR_DS_REPL_LIFETIME_EXCEEDED                                                = 0x000021a6,
    ERROR_DS_DISALLOWED_IN_SYSTEM_CONTAINER                                        = 0x000021a7,
    ERROR_DS_LDAP_SEND_QUEUE_FULL                                                  = 0x000021a8,
    ERROR_DS_DRA_OUT_SCHEDULE_WINDOW                                               = 0x000021a9,
    ERROR_DS_POLICY_NOT_KNOWN                                                      = 0x000021aa,
    ERROR_NO_SITE_SETTINGS_OBJECT                                                  = 0x000021ab,
    ERROR_NO_SECRETS                                                               = 0x000021ac,
    ERROR_NO_WRITABLE_DC_FOUND                                                     = 0x000021ad,
    ERROR_DS_NO_SERVER_OBJECT                                                      = 0x000021ae,
    ERROR_DS_NO_NTDSA_OBJECT                                                       = 0x000021af,
    ERROR_DS_NON_ASQ_SEARCH                                                        = 0x000021b0,
    ERROR_DS_AUDIT_FAILURE                                                         = 0x000021b1,
    ERROR_DS_INVALID_SEARCH_FLAG_SUBTREE                                           = 0x000021b2,
    ERROR_DS_INVALID_SEARCH_FLAG_TUPLE                                             = 0x000021b3,
    ERROR_DS_HIERARCHY_TABLE_TOO_DEEP                                              = 0x000021b4,
    ERROR_DS_DRA_CORRUPT_UTD_VECTOR                                                = 0x000021b5,
    ERROR_DS_DRA_SECRETS_DENIED                                                    = 0x000021b6,
    ERROR_DS_RESERVED_MAPI_ID                                                      = 0x000021b7,
    ERROR_DS_MAPI_ID_NOT_AVAILABLE                                                 = 0x000021b8,
    ERROR_DS_DRA_MISSING_KRBTGT_SECRET                                             = 0x000021b9,
    ERROR_DS_DOMAIN_NAME_EXISTS_IN_FOREST                                          = 0x000021ba,
    ERROR_DS_FLAT_NAME_EXISTS_IN_FOREST                                            = 0x000021bb,
    ERROR_INVALID_USER_PRINCIPAL_NAME                                              = 0x000021bc,
    ERROR_DS_OID_MAPPED_GROUP_CANT_HAVE_MEMBERS                                    = 0x000021bd,
    ERROR_DS_OID_NOT_FOUND                                                         = 0x000021be,
    ERROR_DS_DRA_RECYCLED_TARGET                                                   = 0x000021bf,
    ERROR_DS_DISALLOWED_NC_REDIRECT                                                = 0x000021c0,
    ERROR_DS_HIGH_ADLDS_FFL                                                        = 0x000021c1,
    ERROR_DS_HIGH_DSA_VERSION                                                      = 0x000021c2,
    ERROR_DS_LOW_ADLDS_FFL                                                         = 0x000021c3,
    ERROR_DOMAIN_SID_SAME_AS_LOCAL_WORKSTATION                                     = 0x000021c4,
    ERROR_DS_UNDELETE_SAM_VALIDATION_FAILED                                        = 0x000021c5,
    ERROR_INCORRECT_ACCOUNT_TYPE                                                   = 0x000021c6,
    ERROR_DS_SPN_VALUE_NOT_UNIQUE_IN_FOREST                                        = 0x000021c7,
    ERROR_DS_UPN_VALUE_NOT_UNIQUE_IN_FOREST                                        = 0x000021c8,
    ERROR_DS_MISSING_FOREST_TRUST                                                  = 0x000021c9,
    ERROR_DS_VALUE_KEY_NOT_UNIQUE                                                  = 0x000021ca,
    ERROR_WEAK_WHFBKEY_BLOCKED                                                     = 0x000021cb,
    ERROR_DS_PER_ATTRIBUTE_AUTHZ_FAILED_DURING_ADD                                 = 0x000021cc,
    ERROR_LOCAL_POLICY_MODIFICATION_NOT_SUPPORTED                                  = 0x000021cd,
    ERROR_POLICY_CONTROLLED_ACCOUNT                                                = 0x000021ce,
    ERROR_LAPS_LEGACY_SCHEMA_MISSING                                               = 0x000021cf,
    ERROR_LAPS_SCHEMA_MISSING                                                      = 0x000021d0,
    ERROR_LAPS_ENCRYPTION_REQUIRES_2016_DFL                                        = 0x000021d1,
    ERROR_LAPS_PROCESS_TERMINATED                                                  = 0x000021d2,
    ERROR_DS_JET_RECORD_TOO_BIG                                                    = 0x000021d3,
    ERROR_DS_REPLICA_PAGE_SIZE_MISMATCH                                            = 0x000021d4,
    DNS_ERROR_RESPONSE_CODES_BASE                                                  = 0x00002328,
    DNS_ERROR_RCODE_NO_ERROR                                                       = 0x00000000,
    DNS_ERROR_MASK                                                                 = 0x00002328,
    DNS_ERROR_RCODE_FORMAT_ERROR                                                   = 0x00002329,
    DNS_ERROR_RCODE_SERVER_FAILURE                                                 = 0x0000232a,
    DNS_ERROR_RCODE_NAME_ERROR                                                     = 0x0000232b,
    DNS_ERROR_RCODE_NOT_IMPLEMENTED                                                = 0x0000232c,
    DNS_ERROR_RCODE_REFUSED                                                        = 0x0000232d,
    DNS_ERROR_RCODE_YXDOMAIN                                                       = 0x0000232e,
    DNS_ERROR_RCODE_YXRRSET                                                        = 0x0000232f,
    DNS_ERROR_RCODE_NXRRSET                                                        = 0x00002330,
    DNS_ERROR_RCODE_NOTAUTH                                                        = 0x00002331,
    DNS_ERROR_RCODE_NOTZONE                                                        = 0x00002332,
    DNS_ERROR_RCODE_BADSIG                                                         = 0x00002338,
    DNS_ERROR_RCODE_BADKEY                                                         = 0x00002339,
    DNS_ERROR_RCODE_BADTIME                                                        = 0x0000233a,
    DNS_ERROR_RCODE_LAST                                                           = 0x0000233a,
    DNS_ERROR_DNSSEC_BASE                                                          = 0x0000238c,
    DNS_ERROR_KEYMASTER_REQUIRED                                                   = 0x0000238d,
    DNS_ERROR_NOT_ALLOWED_ON_SIGNED_ZONE                                           = 0x0000238e,
    DNS_ERROR_NSEC3_INCOMPATIBLE_WITH_RSA_SHA1                                     = 0x0000238f,
    DNS_ERROR_NOT_ENOUGH_SIGNING_KEY_DESCRIPTORS                                   = 0x00002390,
    DNS_ERROR_UNSUPPORTED_ALGORITHM                                                = 0x00002391,
    DNS_ERROR_INVALID_KEY_SIZE                                                     = 0x00002392,
    DNS_ERROR_SIGNING_KEY_NOT_ACCESSIBLE                                           = 0x00002393,
    DNS_ERROR_KSP_DOES_NOT_SUPPORT_PROTECTION                                      = 0x00002394,
    DNS_ERROR_UNEXPECTED_DATA_PROTECTION_ERROR                                     = 0x00002395,
    DNS_ERROR_UNEXPECTED_CNG_ERROR                                                 = 0x00002396,
    DNS_ERROR_UNKNOWN_SIGNING_PARAMETER_VERSION                                    = 0x00002397,
    DNS_ERROR_KSP_NOT_ACCESSIBLE                                                   = 0x00002398,
    DNS_ERROR_TOO_MANY_SKDS                                                        = 0x00002399,
    DNS_ERROR_INVALID_ROLLOVER_PERIOD                                              = 0x0000239a,
    DNS_ERROR_INVALID_INITIAL_ROLLOVER_OFFSET                                      = 0x0000239b,
    DNS_ERROR_ROLLOVER_IN_PROGRESS                                                 = 0x0000239c,
    DNS_ERROR_STANDBY_KEY_NOT_PRESENT                                              = 0x0000239d,
    DNS_ERROR_NOT_ALLOWED_ON_ZSK                                                   = 0x0000239e,
    DNS_ERROR_NOT_ALLOWED_ON_ACTIVE_SKD                                            = 0x0000239f,
    DNS_ERROR_ROLLOVER_ALREADY_QUEUED                                              = 0x000023a0,
    DNS_ERROR_NOT_ALLOWED_ON_UNSIGNED_ZONE                                         = 0x000023a1,
    DNS_ERROR_BAD_KEYMASTER                                                        = 0x000023a2,
    DNS_ERROR_INVALID_SIGNATURE_VALIDITY_PERIOD                                    = 0x000023a3,
    DNS_ERROR_INVALID_NSEC3_ITERATION_COUNT                                        = 0x000023a4,
    DNS_ERROR_DNSSEC_IS_DISABLED                                                   = 0x000023a5,
    DNS_ERROR_INVALID_XML                                                          = 0x000023a6,
    DNS_ERROR_NO_VALID_TRUST_ANCHORS                                               = 0x000023a7,
    DNS_ERROR_ROLLOVER_NOT_POKEABLE                                                = 0x000023a8,
    DNS_ERROR_NSEC3_NAME_COLLISION                                                 = 0x000023a9,
    DNS_ERROR_NSEC_INCOMPATIBLE_WITH_NSEC3_RSA_SHA1                                = 0x000023aa,
    DNS_ERROR_PACKET_FMT_BASE                                                      = 0x0000251c,
    DNS_ERROR_BAD_PACKET                                                           = 0x0000251e,
    DNS_ERROR_NO_PACKET                                                            = 0x0000251f,
    DNS_ERROR_RCODE                                                                = 0x00002520,
    DNS_ERROR_UNSECURE_PACKET                                                      = 0x00002521,
    DNS_ERROR_NO_MEMORY                                                            = 0x0000000e,
    DNS_ERROR_INVALID_NAME                                                         = 0x0000007b,
    DNS_ERROR_INVALID_DATA                                                         = 0x0000000d,
    DNS_ERROR_GENERAL_API_BASE                                                     = 0x0000254e,
    DNS_ERROR_INVALID_TYPE                                                         = 0x0000254f,
    DNS_ERROR_INVALID_IP_ADDRESS                                                   = 0x00002550,
    DNS_ERROR_INVALID_PROPERTY                                                     = 0x00002551,
    DNS_ERROR_TRY_AGAIN_LATER                                                      = 0x00002552,
    DNS_ERROR_NOT_UNIQUE                                                           = 0x00002553,
    DNS_ERROR_NON_RFC_NAME                                                         = 0x00002554,
    DNS_ERROR_INVALID_NAME_CHAR                                                    = 0x00002558,
    DNS_ERROR_NUMERIC_NAME                                                         = 0x00002559,
    DNS_ERROR_NOT_ALLOWED_ON_ROOT_SERVER                                           = 0x0000255a,
    DNS_ERROR_NOT_ALLOWED_UNDER_DELEGATION                                         = 0x0000255b,
    DNS_ERROR_CANNOT_FIND_ROOT_HINTS                                               = 0x0000255c,
    DNS_ERROR_INCONSISTENT_ROOT_HINTS                                              = 0x0000255d,
    DNS_ERROR_DWORD_VALUE_TOO_SMALL                                                = 0x0000255e,
    DNS_ERROR_DWORD_VALUE_TOO_LARGE                                                = 0x0000255f,
    DNS_ERROR_BACKGROUND_LOADING                                                   = 0x00002560,
    DNS_ERROR_NOT_ALLOWED_ON_RODC                                                  = 0x00002561,
    DNS_ERROR_NOT_ALLOWED_UNDER_DNAME                                              = 0x00002562,
    DNS_ERROR_DELEGATION_REQUIRED                                                  = 0x00002563,
    DNS_ERROR_INVALID_POLICY_TABLE                                                 = 0x00002564,
    DNS_ERROR_ADDRESS_REQUIRED                                                     = 0x00002565,
    DNS_ERROR_ZONE_BASE                                                            = 0x00002580,
    DNS_ERROR_ZONE_DOES_NOT_EXIST                                                  = 0x00002581,
    DNS_ERROR_NO_ZONE_INFO                                                         = 0x00002582,
    DNS_ERROR_INVALID_ZONE_OPERATION                                               = 0x00002583,
    DNS_ERROR_ZONE_CONFIGURATION_ERROR                                             = 0x00002584,
    DNS_ERROR_ZONE_HAS_NO_SOA_RECORD                                               = 0x00002585,
    DNS_ERROR_ZONE_HAS_NO_NS_RECORDS                                               = 0x00002586,
    DNS_ERROR_ZONE_LOCKED                                                          = 0x00002587,
    DNS_ERROR_ZONE_CREATION_FAILED                                                 = 0x00002588,
    DNS_ERROR_ZONE_ALREADY_EXISTS                                                  = 0x00002589,
    DNS_ERROR_AUTOZONE_ALREADY_EXISTS                                              = 0x0000258a,
    DNS_ERROR_INVALID_ZONE_TYPE                                                    = 0x0000258b,
    DNS_ERROR_SECONDARY_REQUIRES_MASTER_IP                                         = 0x0000258c,
    DNS_ERROR_ZONE_NOT_SECONDARY                                                   = 0x0000258d,
    DNS_ERROR_NEED_SECONDARY_ADDRESSES                                             = 0x0000258e,
    DNS_ERROR_WINS_INIT_FAILED                                                     = 0x0000258f,
    DNS_ERROR_NEED_WINS_SERVERS                                                    = 0x00002590,
    DNS_ERROR_NBSTAT_INIT_FAILED                                                   = 0x00002591,
    DNS_ERROR_SOA_DELETE_INVALID                                                   = 0x00002592,
    DNS_ERROR_FORWARDER_ALREADY_EXISTS                                             = 0x00002593,
    DNS_ERROR_ZONE_REQUIRES_MASTER_IP                                              = 0x00002594,
    DNS_ERROR_ZONE_IS_SHUTDOWN                                                     = 0x00002595,
    DNS_ERROR_ZONE_LOCKED_FOR_SIGNING                                              = 0x00002596,
    DNS_ERROR_DATAFILE_BASE                                                        = 0x000025b2,
    DNS_ERROR_PRIMARY_REQUIRES_DATAFILE                                            = 0x000025b3,
    DNS_ERROR_INVALID_DATAFILE_NAME                                                = 0x000025b4,
    DNS_ERROR_DATAFILE_OPEN_FAILURE                                                = 0x000025b5,
    DNS_ERROR_FILE_WRITEBACK_FAILED                                                = 0x000025b6,
    DNS_ERROR_DATAFILE_PARSING                                                     = 0x000025b7,
    DNS_ERROR_DATABASE_BASE                                                        = 0x000025e4,
    DNS_ERROR_RECORD_DOES_NOT_EXIST                                                = 0x000025e5,
    DNS_ERROR_RECORD_FORMAT                                                        = 0x000025e6,
    DNS_ERROR_NODE_CREATION_FAILED                                                 = 0x000025e7,
    DNS_ERROR_UNKNOWN_RECORD_TYPE                                                  = 0x000025e8,
    DNS_ERROR_RECORD_TIMED_OUT                                                     = 0x000025e9,
    DNS_ERROR_NAME_NOT_IN_ZONE                                                     = 0x000025ea,
    DNS_ERROR_CNAME_LOOP                                                           = 0x000025eb,
    DNS_ERROR_NODE_IS_CNAME                                                        = 0x000025ec,
    DNS_ERROR_CNAME_COLLISION                                                      = 0x000025ed,
    DNS_ERROR_RECORD_ONLY_AT_ZONE_ROOT                                             = 0x000025ee,
    DNS_ERROR_RECORD_ALREADY_EXISTS                                                = 0x000025ef,
    DNS_ERROR_SECONDARY_DATA                                                       = 0x000025f0,
    DNS_ERROR_NO_CREATE_CACHE_DATA                                                 = 0x000025f1,
    DNS_ERROR_NAME_DOES_NOT_EXIST                                                  = 0x000025f2,
    DNS_ERROR_DS_UNAVAILABLE                                                       = 0x000025f5,
    DNS_ERROR_DS_ZONE_ALREADY_EXISTS                                               = 0x000025f6,
    DNS_ERROR_NO_BOOTFILE_IF_DS_ZONE                                               = 0x000025f7,
    DNS_ERROR_NODE_IS_DNAME                                                        = 0x000025f8,
    DNS_ERROR_DNAME_COLLISION                                                      = 0x000025f9,
    DNS_ERROR_ALIAS_LOOP                                                           = 0x000025fa,
    DNS_ERROR_OPERATION_BASE                                                       = 0x00002616,
    DNS_ERROR_AXFR                                                                 = 0x00002618,
    DNS_ERROR_SECURE_BASE                                                          = 0x00002648,
    DNS_ERROR_SETUP_BASE                                                           = 0x0000267a,
    DNS_ERROR_NO_TCPIP                                                             = 0x0000267b,
    DNS_ERROR_NO_DNS_SERVERS                                                       = 0x0000267c,
    DNS_ERROR_DP_BASE                                                              = 0x000026ac,
    DNS_ERROR_DP_DOES_NOT_EXIST                                                    = 0x000026ad,
    DNS_ERROR_DP_ALREADY_EXISTS                                                    = 0x000026ae,
    DNS_ERROR_DP_NOT_ENLISTED                                                      = 0x000026af,
    DNS_ERROR_DP_ALREADY_ENLISTED                                                  = 0x000026b0,
    DNS_ERROR_DP_NOT_AVAILABLE                                                     = 0x000026b1,
    DNS_ERROR_DP_FSMO_ERROR                                                        = 0x000026b2,
    DNS_ERROR_RRL_NOT_ENABLED                                                      = 0x000026b7,
    DNS_ERROR_RRL_INVALID_WINDOW_SIZE                                              = 0x000026b8,
    DNS_ERROR_RRL_INVALID_IPV4_PREFIX                                              = 0x000026b9,
    DNS_ERROR_RRL_INVALID_IPV6_PREFIX                                              = 0x000026ba,
    DNS_ERROR_RRL_INVALID_TC_RATE                                                  = 0x000026bb,
    DNS_ERROR_RRL_INVALID_LEAK_RATE                                                = 0x000026bc,
    DNS_ERROR_RRL_LEAK_RATE_LESSTHAN_TC_RATE                                       = 0x000026bd,
    DNS_ERROR_VIRTUALIZATION_INSTANCE_ALREADY_EXISTS                               = 0x000026c1,
    DNS_ERROR_VIRTUALIZATION_INSTANCE_DOES_NOT_EXIST                               = 0x000026c2,
    DNS_ERROR_VIRTUALIZATION_TREE_LOCKED                                           = 0x000026c3,
    DNS_ERROR_INVAILD_VIRTUALIZATION_INSTANCE_NAME                                 = 0x000026c4,
    DNS_ERROR_DEFAULT_VIRTUALIZATION_INSTANCE                                      = 0x000026c5,
    DNS_ERROR_ZONESCOPE_ALREADY_EXISTS                                             = 0x000026df,
    DNS_ERROR_ZONESCOPE_DOES_NOT_EXIST                                             = 0x000026e0,
    DNS_ERROR_DEFAULT_ZONESCOPE                                                    = 0x000026e1,
    DNS_ERROR_INVALID_ZONESCOPE_NAME                                               = 0x000026e2,
    DNS_ERROR_NOT_ALLOWED_WITH_ZONESCOPES                                          = 0x000026e3,
    DNS_ERROR_LOAD_ZONESCOPE_FAILED                                                = 0x000026e4,
    DNS_ERROR_ZONESCOPE_FILE_WRITEBACK_FAILED                                      = 0x000026e5,
    DNS_ERROR_INVALID_SCOPE_NAME                                                   = 0x000026e6,
    DNS_ERROR_SCOPE_DOES_NOT_EXIST                                                 = 0x000026e7,
    DNS_ERROR_DEFAULT_SCOPE                                                        = 0x000026e8,
    DNS_ERROR_INVALID_SCOPE_OPERATION                                              = 0x000026e9,
    DNS_ERROR_SCOPE_LOCKED                                                         = 0x000026ea,
    DNS_ERROR_SCOPE_ALREADY_EXISTS                                                 = 0x000026eb,
    DNS_ERROR_POLICY_ALREADY_EXISTS                                                = 0x000026f3,
    DNS_ERROR_POLICY_DOES_NOT_EXIST                                                = 0x000026f4,
    DNS_ERROR_POLICY_INVALID_CRITERIA                                              = 0x000026f5,
    DNS_ERROR_POLICY_INVALID_SETTINGS                                              = 0x000026f6,
    DNS_ERROR_CLIENT_SUBNET_IS_ACCESSED                                            = 0x000026f7,
    DNS_ERROR_CLIENT_SUBNET_DOES_NOT_EXIST                                         = 0x000026f8,
    DNS_ERROR_CLIENT_SUBNET_ALREADY_EXISTS                                         = 0x000026f9,
    DNS_ERROR_SUBNET_DOES_NOT_EXIST                                                = 0x000026fa,
    DNS_ERROR_SUBNET_ALREADY_EXISTS                                                = 0x000026fb,
    DNS_ERROR_POLICY_LOCKED                                                        = 0x000026fc,
    DNS_ERROR_POLICY_INVALID_WEIGHT                                                = 0x000026fd,
    DNS_ERROR_POLICY_INVALID_NAME                                                  = 0x000026fe,
    DNS_ERROR_POLICY_MISSING_CRITERIA                                              = 0x000026ff,
    DNS_ERROR_INVALID_CLIENT_SUBNET_NAME                                           = 0x00002700,
    DNS_ERROR_POLICY_PROCESSING_ORDER_INVALID                                      = 0x00002701,
    DNS_ERROR_POLICY_SCOPE_MISSING                                                 = 0x00002702,
    DNS_ERROR_POLICY_SCOPE_NOT_ALLOWED                                             = 0x00002703,
    DNS_ERROR_SERVERSCOPE_IS_REFERENCED                                            = 0x00002704,
    DNS_ERROR_ZONESCOPE_IS_REFERENCED                                              = 0x00002705,
    DNS_ERROR_POLICY_INVALID_CRITERIA_CLIENT_SUBNET                                = 0x00002706,
    DNS_ERROR_POLICY_INVALID_CRITERIA_TRANSPORT_PROTOCOL                           = 0x00002707,
    DNS_ERROR_POLICY_INVALID_CRITERIA_NETWORK_PROTOCOL                             = 0x00002708,
    DNS_ERROR_POLICY_INVALID_CRITERIA_INTERFACE                                    = 0x00002709,
    DNS_ERROR_POLICY_INVALID_CRITERIA_FQDN                                         = 0x0000270a,
    DNS_ERROR_POLICY_INVALID_CRITERIA_QUERY_TYPE                                   = 0x0000270b,
    DNS_ERROR_POLICY_INVALID_CRITERIA_TIME_OF_DAY                                  = 0x0000270c,
    ERROR_IPSEC_QM_POLICY_EXISTS                                                   = 0x000032c8,
    ERROR_IPSEC_QM_POLICY_NOT_FOUND                                                = 0x000032c9,
    ERROR_IPSEC_QM_POLICY_IN_USE                                                   = 0x000032ca,
    ERROR_IPSEC_MM_POLICY_EXISTS                                                   = 0x000032cb,
    ERROR_IPSEC_MM_POLICY_NOT_FOUND                                                = 0x000032cc,
    ERROR_IPSEC_MM_POLICY_IN_USE                                                   = 0x000032cd,
    ERROR_IPSEC_MM_FILTER_EXISTS                                                   = 0x000032ce,
    ERROR_IPSEC_MM_FILTER_NOT_FOUND                                                = 0x000032cf,
    ERROR_IPSEC_TRANSPORT_FILTER_EXISTS                                            = 0x000032d0,
    ERROR_IPSEC_TRANSPORT_FILTER_NOT_FOUND                                         = 0x000032d1,
    ERROR_IPSEC_MM_AUTH_EXISTS                                                     = 0x000032d2,
    ERROR_IPSEC_MM_AUTH_NOT_FOUND                                                  = 0x000032d3,
    ERROR_IPSEC_MM_AUTH_IN_USE                                                     = 0x000032d4,
    ERROR_IPSEC_DEFAULT_MM_POLICY_NOT_FOUND                                        = 0x000032d5,
    ERROR_IPSEC_DEFAULT_MM_AUTH_NOT_FOUND                                          = 0x000032d6,
    ERROR_IPSEC_DEFAULT_QM_POLICY_NOT_FOUND                                        = 0x000032d7,
    ERROR_IPSEC_TUNNEL_FILTER_EXISTS                                               = 0x000032d8,
    ERROR_IPSEC_TUNNEL_FILTER_NOT_FOUND                                            = 0x000032d9,
    ERROR_IPSEC_MM_FILTER_PENDING_DELETION                                         = 0x000032da,
    ERROR_IPSEC_TRANSPORT_FILTER_PENDING_DELETION                                  = 0x000032db,
    ERROR_IPSEC_TUNNEL_FILTER_PENDING_DELETION                                     = 0x000032dc,
    ERROR_IPSEC_MM_POLICY_PENDING_DELETION                                         = 0x000032dd,
    ERROR_IPSEC_MM_AUTH_PENDING_DELETION                                           = 0x000032de,
    ERROR_IPSEC_QM_POLICY_PENDING_DELETION                                         = 0x000032df,
    ERROR_IPSEC_IKE_NEG_STATUS_BEGIN                                               = 0x000035e8,
    ERROR_IPSEC_IKE_AUTH_FAIL                                                      = 0x000035e9,
    ERROR_IPSEC_IKE_ATTRIB_FAIL                                                    = 0x000035ea,
    ERROR_IPSEC_IKE_NEGOTIATION_PENDING                                            = 0x000035eb,
    ERROR_IPSEC_IKE_GENERAL_PROCESSING_ERROR                                       = 0x000035ec,
    ERROR_IPSEC_IKE_TIMED_OUT                                                      = 0x000035ed,
    ERROR_IPSEC_IKE_NO_CERT                                                        = 0x000035ee,
    ERROR_IPSEC_IKE_SA_DELETED                                                     = 0x000035ef,
    ERROR_IPSEC_IKE_SA_REAPED                                                      = 0x000035f0,
    ERROR_IPSEC_IKE_MM_ACQUIRE_DROP                                                = 0x000035f1,
    ERROR_IPSEC_IKE_QM_ACQUIRE_DROP                                                = 0x000035f2,
    ERROR_IPSEC_IKE_QUEUE_DROP_MM                                                  = 0x000035f3,
    ERROR_IPSEC_IKE_QUEUE_DROP_NO_MM                                               = 0x000035f4,
    ERROR_IPSEC_IKE_DROP_NO_RESPONSE                                               = 0x000035f5,
    ERROR_IPSEC_IKE_MM_DELAY_DROP                                                  = 0x000035f6,
    ERROR_IPSEC_IKE_QM_DELAY_DROP                                                  = 0x000035f7,
    ERROR_IPSEC_IKE_ERROR                                                          = 0x000035f8,
    ERROR_IPSEC_IKE_CRL_FAILED                                                     = 0x000035f9,
    ERROR_IPSEC_IKE_INVALID_KEY_USAGE                                              = 0x000035fa,
    ERROR_IPSEC_IKE_INVALID_CERT_TYPE                                              = 0x000035fb,
    ERROR_IPSEC_IKE_NO_PRIVATE_KEY                                                 = 0x000035fc,
    ERROR_IPSEC_IKE_SIMULTANEOUS_REKEY                                             = 0x000035fd,
    ERROR_IPSEC_IKE_DH_FAIL                                                        = 0x000035fe,
    ERROR_IPSEC_IKE_CRITICAL_PAYLOAD_NOT_RECOGNIZED                                = 0x000035ff,
    ERROR_IPSEC_IKE_INVALID_HEADER                                                 = 0x00003600,
    ERROR_IPSEC_IKE_NO_POLICY                                                      = 0x00003601,
    ERROR_IPSEC_IKE_INVALID_SIGNATURE                                              = 0x00003602,
    ERROR_IPSEC_IKE_KERBEROS_ERROR                                                 = 0x00003603,
    ERROR_IPSEC_IKE_NO_PUBLIC_KEY                                                  = 0x00003604,
    ERROR_IPSEC_IKE_PROCESS_ERR                                                    = 0x00003605,
    ERROR_IPSEC_IKE_PROCESS_ERR_SA                                                 = 0x00003606,
    ERROR_IPSEC_IKE_PROCESS_ERR_PROP                                               = 0x00003607,
    ERROR_IPSEC_IKE_PROCESS_ERR_TRANS                                              = 0x00003608,
    ERROR_IPSEC_IKE_PROCESS_ERR_KE                                                 = 0x00003609,
    ERROR_IPSEC_IKE_PROCESS_ERR_ID                                                 = 0x0000360a,
    ERROR_IPSEC_IKE_PROCESS_ERR_CERT                                               = 0x0000360b,
    ERROR_IPSEC_IKE_PROCESS_ERR_CERT_REQ                                           = 0x0000360c,
    ERROR_IPSEC_IKE_PROCESS_ERR_HASH                                               = 0x0000360d,
    ERROR_IPSEC_IKE_PROCESS_ERR_SIG                                                = 0x0000360e,
    ERROR_IPSEC_IKE_PROCESS_ERR_NONCE                                              = 0x0000360f,
    ERROR_IPSEC_IKE_PROCESS_ERR_NOTIFY                                             = 0x00003610,
    ERROR_IPSEC_IKE_PROCESS_ERR_DELETE                                             = 0x00003611,
    ERROR_IPSEC_IKE_PROCESS_ERR_VENDOR                                             = 0x00003612,
    ERROR_IPSEC_IKE_INVALID_PAYLOAD                                                = 0x00003613,
    ERROR_IPSEC_IKE_LOAD_SOFT_SA                                                   = 0x00003614,
    ERROR_IPSEC_IKE_SOFT_SA_TORN_DOWN                                              = 0x00003615,
    ERROR_IPSEC_IKE_INVALID_COOKIE                                                 = 0x00003616,
    ERROR_IPSEC_IKE_NO_PEER_CERT                                                   = 0x00003617,
    ERROR_IPSEC_IKE_PEER_CRL_FAILED                                                = 0x00003618,
    ERROR_IPSEC_IKE_POLICY_CHANGE                                                  = 0x00003619,
    ERROR_IPSEC_IKE_NO_MM_POLICY                                                   = 0x0000361a,
    ERROR_IPSEC_IKE_NOTCBPRIV                                                      = 0x0000361b,
    ERROR_IPSEC_IKE_SECLOADFAIL                                                    = 0x0000361c,
    ERROR_IPSEC_IKE_FAILSSPINIT                                                    = 0x0000361d,
    ERROR_IPSEC_IKE_FAILQUERYSSP                                                   = 0x0000361e,
    ERROR_IPSEC_IKE_SRVACQFAIL                                                     = 0x0000361f,
    ERROR_IPSEC_IKE_SRVQUERYCRED                                                   = 0x00003620,
    ERROR_IPSEC_IKE_GETSPIFAIL                                                     = 0x00003621,
    ERROR_IPSEC_IKE_INVALID_FILTER                                                 = 0x00003622,
    ERROR_IPSEC_IKE_OUT_OF_MEMORY                                                  = 0x00003623,
    ERROR_IPSEC_IKE_ADD_UPDATE_KEY_FAILED                                          = 0x00003624,
    ERROR_IPSEC_IKE_INVALID_POLICY                                                 = 0x00003625,
    ERROR_IPSEC_IKE_UNKNOWN_DOI                                                    = 0x00003626,
    ERROR_IPSEC_IKE_INVALID_SITUATION                                              = 0x00003627,
    ERROR_IPSEC_IKE_DH_FAILURE                                                     = 0x00003628,
    ERROR_IPSEC_IKE_INVALID_GROUP                                                  = 0x00003629,
    ERROR_IPSEC_IKE_ENCRYPT                                                        = 0x0000362a,
    ERROR_IPSEC_IKE_DECRYPT                                                        = 0x0000362b,
    ERROR_IPSEC_IKE_POLICY_MATCH                                                   = 0x0000362c,
    ERROR_IPSEC_IKE_UNSUPPORTED_ID                                                 = 0x0000362d,
    ERROR_IPSEC_IKE_INVALID_HASH                                                   = 0x0000362e,
    ERROR_IPSEC_IKE_INVALID_HASH_ALG                                               = 0x0000362f,
    ERROR_IPSEC_IKE_INVALID_HASH_SIZE                                              = 0x00003630,
    ERROR_IPSEC_IKE_INVALID_ENCRYPT_ALG                                            = 0x00003631,
    ERROR_IPSEC_IKE_INVALID_AUTH_ALG                                               = 0x00003632,
    ERROR_IPSEC_IKE_INVALID_SIG                                                    = 0x00003633,
    ERROR_IPSEC_IKE_LOAD_FAILED                                                    = 0x00003634,
    ERROR_IPSEC_IKE_RPC_DELETE                                                     = 0x00003635,
    ERROR_IPSEC_IKE_BENIGN_REINIT                                                  = 0x00003636,
    ERROR_IPSEC_IKE_INVALID_RESPONDER_LIFETIME_NOTIFY                              = 0x00003637,
    ERROR_IPSEC_IKE_INVALID_MAJOR_VERSION                                          = 0x00003638,
    ERROR_IPSEC_IKE_INVALID_CERT_KEYLEN                                            = 0x00003639,
    ERROR_IPSEC_IKE_MM_LIMIT                                                       = 0x0000363a,
    ERROR_IPSEC_IKE_NEGOTIATION_DISABLED                                           = 0x0000363b,
    ERROR_IPSEC_IKE_QM_LIMIT                                                       = 0x0000363c,
    ERROR_IPSEC_IKE_MM_EXPIRED                                                     = 0x0000363d,
    ERROR_IPSEC_IKE_PEER_MM_ASSUMED_INVALID                                        = 0x0000363e,
    ERROR_IPSEC_IKE_CERT_CHAIN_POLICY_MISMATCH                                     = 0x0000363f,
    ERROR_IPSEC_IKE_UNEXPECTED_MESSAGE_ID                                          = 0x00003640,
    ERROR_IPSEC_IKE_INVALID_AUTH_PAYLOAD                                           = 0x00003641,
    ERROR_IPSEC_IKE_DOS_COOKIE_SENT                                                = 0x00003642,
    ERROR_IPSEC_IKE_SHUTTING_DOWN                                                  = 0x00003643,
    ERROR_IPSEC_IKE_CGA_AUTH_FAILED                                                = 0x00003644,
    ERROR_IPSEC_IKE_PROCESS_ERR_NATOA                                              = 0x00003645,
    ERROR_IPSEC_IKE_INVALID_MM_FOR_QM                                              = 0x00003646,
    ERROR_IPSEC_IKE_QM_EXPIRED                                                     = 0x00003647,
    ERROR_IPSEC_IKE_TOO_MANY_FILTERS                                               = 0x00003648,
    ERROR_IPSEC_IKE_NEG_STATUS_END                                                 = 0x00003649,
    ERROR_IPSEC_IKE_KILL_DUMMY_NAP_TUNNEL                                          = 0x0000364a,
    ERROR_IPSEC_IKE_INNER_IP_ASSIGNMENT_FAILURE                                    = 0x0000364b,
    ERROR_IPSEC_IKE_REQUIRE_CP_PAYLOAD_MISSING                                     = 0x0000364c,
    ERROR_IPSEC_KEY_MODULE_IMPERSONATION_NEGOTIATION_PENDING                       = 0x0000364d,
    ERROR_IPSEC_IKE_COEXISTENCE_SUPPRESS                                           = 0x0000364e,
    ERROR_IPSEC_IKE_RATELIMIT_DROP                                                 = 0x0000364f,
    ERROR_IPSEC_IKE_PEER_DOESNT_SUPPORT_MOBIKE                                     = 0x00003650,
    ERROR_IPSEC_IKE_AUTHORIZATION_FAILURE                                          = 0x00003651,
    ERROR_IPSEC_IKE_STRONG_CRED_AUTHORIZATION_FAILURE                              = 0x00003652,
    ERROR_IPSEC_IKE_AUTHORIZATION_FAILURE_WITH_OPTIONAL_RETRY                      = 0x00003653,
    ERROR_IPSEC_IKE_STRONG_CRED_AUTHORIZATION_AND_CERTMAP_FAILURE                  = 0x00003654,
    ERROR_IPSEC_IKE_NEG_STATUS_EXTENDED_END                                        = 0x00003655,
    ERROR_IPSEC_BAD_SPI                                                            = 0x00003656,
    ERROR_IPSEC_SA_LIFETIME_EXPIRED                                                = 0x00003657,
    ERROR_IPSEC_WRONG_SA                                                           = 0x00003658,
    ERROR_IPSEC_REPLAY_CHECK_FAILED                                                = 0x00003659,
    ERROR_IPSEC_INVALID_PACKET                                                     = 0x0000365a,
    ERROR_IPSEC_INTEGRITY_CHECK_FAILED                                             = 0x0000365b,
    ERROR_IPSEC_CLEAR_TEXT_DROP                                                    = 0x0000365c,
    ERROR_IPSEC_AUTH_FIREWALL_DROP                                                 = 0x0000365d,
    ERROR_IPSEC_THROTTLE_DROP                                                      = 0x0000365e,
    ERROR_IPSEC_DOSP_BLOCK                                                         = 0x00003665,
    ERROR_IPSEC_DOSP_RECEIVED_MULTICAST                                            = 0x00003666,
    ERROR_IPSEC_DOSP_INVALID_PACKET                                                = 0x00003667,
    ERROR_IPSEC_DOSP_STATE_LOOKUP_FAILED                                           = 0x00003668,
    ERROR_IPSEC_DOSP_MAX_ENTRIES                                                   = 0x00003669,
    ERROR_IPSEC_DOSP_KEYMOD_NOT_ALLOWED                                            = 0x0000366a,
    ERROR_IPSEC_DOSP_NOT_INSTALLED                                                 = 0x0000366b,
    ERROR_IPSEC_DOSP_MAX_PER_IP_RATELIMIT_QUEUES                                   = 0x0000366c,
    ERROR_SXS_SECTION_NOT_FOUND                                                    = 0x000036b0,
    ERROR_SXS_CANT_GEN_ACTCTX                                                      = 0x000036b1,
    ERROR_SXS_INVALID_ACTCTXDATA_FORMAT                                            = 0x000036b2,
    ERROR_SXS_ASSEMBLY_NOT_FOUND                                                   = 0x000036b3,
    ERROR_SXS_MANIFEST_FORMAT_ERROR                                                = 0x000036b4,
    ERROR_SXS_MANIFEST_PARSE_ERROR                                                 = 0x000036b5,
    ERROR_SXS_ACTIVATION_CONTEXT_DISABLED                                          = 0x000036b6,
    ERROR_SXS_KEY_NOT_FOUND                                                        = 0x000036b7,
    ERROR_SXS_VERSION_CONFLICT                                                     = 0x000036b8,
    ERROR_SXS_WRONG_SECTION_TYPE                                                   = 0x000036b9,
    ERROR_SXS_THREAD_QUERIES_DISABLED                                              = 0x000036ba,
    ERROR_SXS_PROCESS_DEFAULT_ALREADY_SET                                          = 0x000036bb,
    ERROR_SXS_UNKNOWN_ENCODING_GROUP                                               = 0x000036bc,
    ERROR_SXS_UNKNOWN_ENCODING                                                     = 0x000036bd,
    ERROR_SXS_INVALID_XML_NAMESPACE_URI                                            = 0x000036be,
    ERROR_SXS_ROOT_MANIFEST_DEPENDENCY_NOT_INSTALLED                               = 0x000036bf,
    ERROR_SXS_LEAF_MANIFEST_DEPENDENCY_NOT_INSTALLED                               = 0x000036c0,
    ERROR_SXS_INVALID_ASSEMBLY_IDENTITY_ATTRIBUTE                                  = 0x000036c1,
    ERROR_SXS_MANIFEST_MISSING_REQUIRED_DEFAULT_NAMESPACE                          = 0x000036c2,
    ERROR_SXS_MANIFEST_INVALID_REQUIRED_DEFAULT_NAMESPACE                          = 0x000036c3,
    ERROR_SXS_PRIVATE_MANIFEST_CROSS_PATH_WITH_REPARSE_POINT                       = 0x000036c4,
    ERROR_SXS_DUPLICATE_DLL_NAME                                                   = 0x000036c5,
    ERROR_SXS_DUPLICATE_WINDOWCLASS_NAME                                           = 0x000036c6,
    ERROR_SXS_DUPLICATE_CLSID                                                      = 0x000036c7,
    ERROR_SXS_DUPLICATE_IID                                                        = 0x000036c8,
    ERROR_SXS_DUPLICATE_TLBID                                                      = 0x000036c9,
    ERROR_SXS_DUPLICATE_PROGID                                                     = 0x000036ca,
    ERROR_SXS_DUPLICATE_ASSEMBLY_NAME                                              = 0x000036cb,
    ERROR_SXS_FILE_HASH_MISMATCH                                                   = 0x000036cc,
    ERROR_SXS_POLICY_PARSE_ERROR                                                   = 0x000036cd,
    ERROR_SXS_XML_E_MISSINGQUOTE                                                   = 0x000036ce,
    ERROR_SXS_XML_E_COMMENTSYNTAX                                                  = 0x000036cf,
    ERROR_SXS_XML_E_BADSTARTNAMECHAR                                               = 0x000036d0,
    ERROR_SXS_XML_E_BADNAMECHAR                                                    = 0x000036d1,
    ERROR_SXS_XML_E_BADCHARINSTRING                                                = 0x000036d2,
    ERROR_SXS_XML_E_XMLDECLSYNTAX                                                  = 0x000036d3,
    ERROR_SXS_XML_E_BADCHARDATA                                                    = 0x000036d4,
    ERROR_SXS_XML_E_MISSINGWHITESPACE                                              = 0x000036d5,
    ERROR_SXS_XML_E_EXPECTINGTAGEND                                                = 0x000036d6,
    ERROR_SXS_XML_E_MISSINGSEMICOLON                                               = 0x000036d7,
    ERROR_SXS_XML_E_UNBALANCEDPAREN                                                = 0x000036d8,
    ERROR_SXS_XML_E_INTERNALERROR                                                  = 0x000036d9,
    ERROR_SXS_XML_E_UNEXPECTED_WHITESPACE                                          = 0x000036da,
    ERROR_SXS_XML_E_INCOMPLETE_ENCODING                                            = 0x000036db,
    ERROR_SXS_XML_E_MISSING_PAREN                                                  = 0x000036dc,
    ERROR_SXS_XML_E_EXPECTINGCLOSEQUOTE                                            = 0x000036dd,
    ERROR_SXS_XML_E_MULTIPLE_COLONS                                                = 0x000036de,
    ERROR_SXS_XML_E_INVALID_DECIMAL                                                = 0x000036df,
    ERROR_SXS_XML_E_INVALID_HEXIDECIMAL                                            = 0x000036e0,
    ERROR_SXS_XML_E_INVALID_UNICODE                                                = 0x000036e1,
    ERROR_SXS_XML_E_WHITESPACEORQUESTIONMARK                                       = 0x000036e2,
    ERROR_SXS_XML_E_UNEXPECTEDENDTAG                                               = 0x000036e3,
    ERROR_SXS_XML_E_UNCLOSEDTAG                                                    = 0x000036e4,
    ERROR_SXS_XML_E_DUPLICATEATTRIBUTE                                             = 0x000036e5,
    ERROR_SXS_XML_E_MULTIPLEROOTS                                                  = 0x000036e6,
    ERROR_SXS_XML_E_INVALIDATROOTLEVEL                                             = 0x000036e7,
    ERROR_SXS_XML_E_BADXMLDECL                                                     = 0x000036e8,
    ERROR_SXS_XML_E_MISSINGROOT                                                    = 0x000036e9,
    ERROR_SXS_XML_E_UNEXPECTEDEOF                                                  = 0x000036ea,
    ERROR_SXS_XML_E_BADPEREFINSUBSET                                               = 0x000036eb,
    ERROR_SXS_XML_E_UNCLOSEDSTARTTAG                                               = 0x000036ec,
    ERROR_SXS_XML_E_UNCLOSEDENDTAG                                                 = 0x000036ed,
    ERROR_SXS_XML_E_UNCLOSEDSTRING                                                 = 0x000036ee,
    ERROR_SXS_XML_E_UNCLOSEDCOMMENT                                                = 0x000036ef,
    ERROR_SXS_XML_E_UNCLOSEDDECL                                                   = 0x000036f0,
    ERROR_SXS_XML_E_UNCLOSEDCDATA                                                  = 0x000036f1,
    ERROR_SXS_XML_E_RESERVEDNAMESPACE                                              = 0x000036f2,
    ERROR_SXS_XML_E_INVALIDENCODING                                                = 0x000036f3,
    ERROR_SXS_XML_E_INVALIDSWITCH                                                  = 0x000036f4,
    ERROR_SXS_XML_E_BADXMLCASE                                                     = 0x000036f5,
    ERROR_SXS_XML_E_INVALID_STANDALONE                                             = 0x000036f6,
    ERROR_SXS_XML_E_UNEXPECTED_STANDALONE                                          = 0x000036f7,
    ERROR_SXS_XML_E_INVALID_VERSION                                                = 0x000036f8,
    ERROR_SXS_XML_E_MISSINGEQUALS                                                  = 0x000036f9,
    ERROR_SXS_PROTECTION_RECOVERY_FAILED                                           = 0x000036fa,
    ERROR_SXS_PROTECTION_PUBLIC_KEY_TOO_SHORT                                      = 0x000036fb,
    ERROR_SXS_PROTECTION_CATALOG_NOT_VALID                                         = 0x000036fc,
    ERROR_SXS_UNTRANSLATABLE_HRESULT                                               = 0x000036fd,
    ERROR_SXS_PROTECTION_CATALOG_FILE_MISSING                                      = 0x000036fe,
    ERROR_SXS_MISSING_ASSEMBLY_IDENTITY_ATTRIBUTE                                  = 0x000036ff,
    ERROR_SXS_INVALID_ASSEMBLY_IDENTITY_ATTRIBUTE_NAME                             = 0x00003700,
    ERROR_SXS_ASSEMBLY_MISSING                                                     = 0x00003701,
    ERROR_SXS_CORRUPT_ACTIVATION_STACK                                             = 0x00003702,
    ERROR_SXS_CORRUPTION                                                           = 0x00003703,
    ERROR_SXS_EARLY_DEACTIVATION                                                   = 0x00003704,
    ERROR_SXS_INVALID_DEACTIVATION                                                 = 0x00003705,
    ERROR_SXS_MULTIPLE_DEACTIVATION                                                = 0x00003706,
    ERROR_SXS_PROCESS_TERMINATION_REQUESTED                                        = 0x00003707,
    ERROR_SXS_RELEASE_ACTIVATION_CONTEXT                                           = 0x00003708,
    ERROR_SXS_SYSTEM_DEFAULT_ACTIVATION_CONTEXT_EMPTY                              = 0x00003709,
    ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE                                     = 0x0000370a,
    ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME                                      = 0x0000370b,
    ERROR_SXS_IDENTITY_DUPLICATE_ATTRIBUTE                                         = 0x0000370c,
    ERROR_SXS_IDENTITY_PARSE_ERROR                                                 = 0x0000370d,
    ERROR_MALFORMED_SUBSTITUTION_STRING                                            = 0x0000370e,
    ERROR_SXS_INCORRECT_PUBLIC_KEY_TOKEN                                           = 0x0000370f,
    ERROR_UNMAPPED_SUBSTITUTION_STRING                                             = 0x00003710,
    ERROR_SXS_ASSEMBLY_NOT_LOCKED                                                  = 0x00003711,
    ERROR_SXS_COMPONENT_STORE_CORRUPT                                              = 0x00003712,
    ERROR_ADVANCED_INSTALLER_FAILED                                                = 0x00003713,
    ERROR_XML_ENCODING_MISMATCH                                                    = 0x00003714,
    ERROR_SXS_MANIFEST_IDENTITY_SAME_BUT_CONTENTS_DIFFERENT                        = 0x00003715,
    ERROR_SXS_IDENTITIES_DIFFERENT                                                 = 0x00003716,
    ERROR_SXS_ASSEMBLY_IS_NOT_A_DEPLOYMENT                                         = 0x00003717,
    ERROR_SXS_FILE_NOT_PART_OF_ASSEMBLY                                            = 0x00003718,
    ERROR_SXS_MANIFEST_TOO_BIG                                                     = 0x00003719,
    ERROR_SXS_SETTING_NOT_REGISTERED                                               = 0x0000371a,
    ERROR_SXS_TRANSACTION_CLOSURE_INCOMPLETE                                       = 0x0000371b,
    ERROR_SMI_PRIMITIVE_INSTALLER_FAILED                                           = 0x0000371c,
    ERROR_GENERIC_COMMAND_FAILED                                                   = 0x0000371d,
    ERROR_SXS_FILE_HASH_MISSING                                                    = 0x0000371e,
    ERROR_SXS_DUPLICATE_ACTIVATABLE_CLASS                                          = 0x0000371f,
    ERROR_EVT_INVALID_CHANNEL_PATH                                                 = 0x00003a98,
    ERROR_EVT_INVALID_QUERY                                                        = 0x00003a99,
    ERROR_EVT_PUBLISHER_METADATA_NOT_FOUND                                         = 0x00003a9a,
    ERROR_EVT_EVENT_TEMPLATE_NOT_FOUND                                             = 0x00003a9b,
    ERROR_EVT_INVALID_PUBLISHER_NAME                                               = 0x00003a9c,
    ERROR_EVT_INVALID_EVENT_DATA                                                   = 0x00003a9d,
    ERROR_EVT_CHANNEL_NOT_FOUND                                                    = 0x00003a9f,
    ERROR_EVT_MALFORMED_XML_TEXT                                                   = 0x00003aa0,
    ERROR_EVT_SUBSCRIPTION_TO_DIRECT_CHANNEL                                       = 0x00003aa1,
    ERROR_EVT_CONFIGURATION_ERROR                                                  = 0x00003aa2,
    ERROR_EVT_QUERY_RESULT_STALE                                                   = 0x00003aa3,
    ERROR_EVT_QUERY_RESULT_INVALID_POSITION                                        = 0x00003aa4,
    ERROR_EVT_NON_VALIDATING_MSXML                                                 = 0x00003aa5,
    ERROR_EVT_FILTER_ALREADYSCOPED                                                 = 0x00003aa6,
    ERROR_EVT_FILTER_NOTELTSET                                                     = 0x00003aa7,
    ERROR_EVT_FILTER_INVARG                                                        = 0x00003aa8,
    ERROR_EVT_FILTER_INVTEST                                                       = 0x00003aa9,
    ERROR_EVT_FILTER_INVTYPE                                                       = 0x00003aaa,
    ERROR_EVT_FILTER_PARSEERR                                                      = 0x00003aab,
    ERROR_EVT_FILTER_UNSUPPORTEDOP                                                 = 0x00003aac,
    ERROR_EVT_FILTER_UNEXPECTEDTOKEN                                               = 0x00003aad,
    ERROR_EVT_INVALID_OPERATION_OVER_ENABLED_DIRECT_CHANNEL                        = 0x00003aae,
    ERROR_EVT_INVALID_CHANNEL_PROPERTY_VALUE                                       = 0x00003aaf,
    ERROR_EVT_INVALID_PUBLISHER_PROPERTY_VALUE                                     = 0x00003ab0,
    ERROR_EVT_CHANNEL_CANNOT_ACTIVATE                                              = 0x00003ab1,
    ERROR_EVT_FILTER_TOO_COMPLEX                                                   = 0x00003ab2,
    ERROR_EVT_MESSAGE_NOT_FOUND                                                    = 0x00003ab3,
    ERROR_EVT_MESSAGE_ID_NOT_FOUND                                                 = 0x00003ab4,
    ERROR_EVT_UNRESOLVED_VALUE_INSERT                                              = 0x00003ab5,
    ERROR_EVT_UNRESOLVED_PARAMETER_INSERT                                          = 0x00003ab6,
    ERROR_EVT_MAX_INSERTS_REACHED                                                  = 0x00003ab7,
    ERROR_EVT_EVENT_DEFINITION_NOT_FOUND                                           = 0x00003ab8,
    ERROR_EVT_MESSAGE_LOCALE_NOT_FOUND                                             = 0x00003ab9,
    ERROR_EVT_VERSION_TOO_OLD                                                      = 0x00003aba,
    ERROR_EVT_VERSION_TOO_NEW                                                      = 0x00003abb,
    ERROR_EVT_CANNOT_OPEN_CHANNEL_OF_QUERY                                         = 0x00003abc,
    ERROR_EVT_PUBLISHER_DISABLED                                                   = 0x00003abd,
    ERROR_EVT_FILTER_OUT_OF_RANGE                                                  = 0x00003abe,
    ERROR_EC_SUBSCRIPTION_CANNOT_ACTIVATE                                          = 0x00003ae8,
    ERROR_EC_LOG_DISABLED                                                          = 0x00003ae9,
    ERROR_EC_CIRCULAR_FORWARDING                                                   = 0x00003aea,
    ERROR_EC_CREDSTORE_FULL                                                        = 0x00003aeb,
    ERROR_EC_CRED_NOT_FOUND                                                        = 0x00003aec,
    ERROR_EC_NO_ACTIVE_CHANNEL                                                     = 0x00003aed,
    ERROR_MUI_FILE_NOT_FOUND                                                       = 0x00003afc,
    ERROR_MUI_INVALID_FILE                                                         = 0x00003afd,
    ERROR_MUI_INVALID_RC_CONFIG                                                    = 0x00003afe,
    ERROR_MUI_INVALID_LOCALE_NAME                                                  = 0x00003aff,
    ERROR_MUI_INVALID_ULTIMATEFALLBACK_NAME                                        = 0x00003b00,
    ERROR_MUI_FILE_NOT_LOADED                                                      = 0x00003b01,
    ERROR_RESOURCE_ENUM_USER_STOP                                                  = 0x00003b02,
    ERROR_MUI_INTLSETTINGS_UILANG_NOT_INSTALLED                                    = 0x00003b03,
    ERROR_MUI_INTLSETTINGS_INVALID_LOCALE_NAME                                     = 0x00003b04,
    ERROR_MRM_RUNTIME_NO_DEFAULT_OR_NEUTRAL_RESOURCE                               = 0x00003b06,
    ERROR_MRM_INVALID_PRICONFIG                                                    = 0x00003b07,
    ERROR_MRM_INVALID_FILE_TYPE                                                    = 0x00003b08,
    ERROR_MRM_UNKNOWN_QUALIFIER                                                    = 0x00003b09,
    ERROR_MRM_INVALID_QUALIFIER_VALUE                                              = 0x00003b0a,
    ERROR_MRM_NO_CANDIDATE                                                         = 0x00003b0b,
    ERROR_MRM_NO_MATCH_OR_DEFAULT_CANDIDATE                                        = 0x00003b0c,
    ERROR_MRM_RESOURCE_TYPE_MISMATCH                                               = 0x00003b0d,
    ERROR_MRM_DUPLICATE_MAP_NAME                                                   = 0x00003b0e,
    ERROR_MRM_DUPLICATE_ENTRY                                                      = 0x00003b0f,
    ERROR_MRM_INVALID_RESOURCE_IDENTIFIER                                          = 0x00003b10,
    ERROR_MRM_FILEPATH_TOO_LONG                                                    = 0x00003b11,
    ERROR_MRM_UNSUPPORTED_DIRECTORY_TYPE                                           = 0x00003b12,
    ERROR_MRM_INVALID_PRI_FILE                                                     = 0x00003b16,
    ERROR_MRM_NAMED_RESOURCE_NOT_FOUND                                             = 0x00003b17,
    ERROR_MRM_MAP_NOT_FOUND                                                        = 0x00003b1f,
    ERROR_MRM_UNSUPPORTED_PROFILE_TYPE                                             = 0x00003b20,
    ERROR_MRM_INVALID_QUALIFIER_OPERATOR                                           = 0x00003b21,
    ERROR_MRM_INDETERMINATE_QUALIFIER_VALUE                                        = 0x00003b22,
    ERROR_MRM_AUTOMERGE_ENABLED                                                    = 0x00003b23,
    ERROR_MRM_TOO_MANY_RESOURCES                                                   = 0x00003b24,
    ERROR_MRM_UNSUPPORTED_FILE_TYPE_FOR_MERGE                                      = 0x00003b25,
    ERROR_MRM_UNSUPPORTED_FILE_TYPE_FOR_LOAD_UNLOAD_PRI_FILE                       = 0x00003b26,
    ERROR_MRM_NO_CURRENT_VIEW_ON_THREAD                                            = 0x00003b27,
    ERROR_DIFFERENT_PROFILE_RESOURCE_MANAGER_EXIST                                 = 0x00003b28,
    ERROR_OPERATION_NOT_ALLOWED_FROM_SYSTEM_COMPONENT                              = 0x00003b29,
    ERROR_MRM_DIRECT_REF_TO_NON_DEFAULT_RESOURCE                                   = 0x00003b2a,
    ERROR_MRM_GENERATION_COUNT_MISMATCH                                            = 0x00003b2b,
    ERROR_PRI_MERGE_VERSION_MISMATCH                                               = 0x00003b2c,
    ERROR_PRI_MERGE_MISSING_SCHEMA                                                 = 0x00003b2d,
    ERROR_PRI_MERGE_LOAD_FILE_FAILED                                               = 0x00003b2e,
    ERROR_PRI_MERGE_ADD_FILE_FAILED                                                = 0x00003b2f,
    ERROR_PRI_MERGE_WRITE_FILE_FAILED                                              = 0x00003b30,
    ERROR_PRI_MERGE_MULTIPLE_PACKAGE_FAMILIES_NOT_ALLOWED                          = 0x00003b31,
    ERROR_PRI_MERGE_MULTIPLE_MAIN_PACKAGES_NOT_ALLOWED                             = 0x00003b32,
    ERROR_PRI_MERGE_BUNDLE_PACKAGES_NOT_ALLOWED                                    = 0x00003b33,
    ERROR_PRI_MERGE_MAIN_PACKAGE_REQUIRED                                          = 0x00003b34,
    ERROR_PRI_MERGE_RESOURCE_PACKAGE_REQUIRED                                      = 0x00003b35,
    ERROR_PRI_MERGE_INVALID_FILE_NAME                                              = 0x00003b36,
    ERROR_MRM_PACKAGE_NOT_FOUND                                                    = 0x00003b37,
    ERROR_MRM_MISSING_DEFAULT_LANGUAGE                                             = 0x00003b38,
    ERROR_MRM_SCOPE_ITEM_CONFLICT                                                  = 0x00003b39,
    ERROR_MCA_INVALID_CAPABILITIES_STRING                                          = 0x00003b60,
    ERROR_MCA_INVALID_VCP_VERSION                                                  = 0x00003b61,
    ERROR_MCA_MONITOR_VIOLATES_MCCS_SPECIFICATION                                  = 0x00003b62,
    ERROR_MCA_MCCS_VERSION_MISMATCH                                                = 0x00003b63,
    ERROR_MCA_UNSUPPORTED_MCCS_VERSION                                             = 0x00003b64,
    ERROR_MCA_INTERNAL_ERROR                                                       = 0x00003b65,
    ERROR_MCA_INVALID_TECHNOLOGY_TYPE_RETURNED                                     = 0x00003b66,
    ERROR_MCA_UNSUPPORTED_COLOR_TEMPERATURE                                        = 0x00003b67,
    ERROR_AMBIGUOUS_SYSTEM_DEVICE                                                  = 0x00003b92,
    ERROR_SYSTEM_DEVICE_NOT_FOUND                                                  = 0x00003bc3,
    ERROR_HASH_NOT_SUPPORTED                                                       = 0x00003bc4,
    ERROR_HASH_NOT_PRESENT                                                         = 0x00003bc5,
    ERROR_SECONDARY_IC_PROVIDER_NOT_REGISTERED                                     = 0x00003bd9,
    ERROR_GPIO_CLIENT_INFORMATION_INVALID                                          = 0x00003bda,
    ERROR_GPIO_VERSION_NOT_SUPPORTED                                               = 0x00003bdb,
    ERROR_GPIO_INVALID_REGISTRATION_PACKET                                         = 0x00003bdc,
    ERROR_GPIO_OPERATION_DENIED                                                    = 0x00003bdd,
    ERROR_GPIO_INCOMPATIBLE_CONNECT_MODE                                           = 0x00003bde,
    ERROR_GPIO_INTERRUPT_ALREADY_UNMASKED                                          = 0x00003bdf,
    ERROR_CANNOT_COMPOSE_APISET_EXTENSION                                          = 0x00003c14,
    ERROR_APISET_SCHEMA_VERSION_NOT_SUPPORTED                                      = 0x00003c15,
    ERROR_CANNOT_SWITCH_RUNLEVEL                                                   = 0x00003c28,
    ERROR_INVALID_RUNLEVEL_SETTING                                                 = 0x00003c29,
    ERROR_RUNLEVEL_SWITCH_TIMEOUT                                                  = 0x00003c2a,
    ERROR_RUNLEVEL_SWITCH_AGENT_TIMEOUT                                            = 0x00003c2b,
    ERROR_RUNLEVEL_SWITCH_IN_PROGRESS                                              = 0x00003c2c,
    ERROR_SERVICES_FAILED_AUTOSTART                                                = 0x00003c2d,
    ERROR_COM_TASK_STOP_PENDING                                                    = 0x00003c8d,
    ERROR_INSTALL_OPEN_PACKAGE_FAILED                                              = 0x00003cf0,
    ERROR_INSTALL_PACKAGE_NOT_FOUND                                                = 0x00003cf1,
    ERROR_INSTALL_INVALID_PACKAGE                                                  = 0x00003cf2,
    ERROR_INSTALL_RESOLVE_DEPENDENCY_FAILED                                        = 0x00003cf3,
    ERROR_INSTALL_OUT_OF_DISK_SPACE                                                = 0x00003cf4,
    ERROR_INSTALL_NETWORK_FAILURE                                                  = 0x00003cf5,
    ERROR_INSTALL_REGISTRATION_FAILURE                                             = 0x00003cf6,
    ERROR_INSTALL_DEREGISTRATION_FAILURE                                           = 0x00003cf7,
    ERROR_INSTALL_CANCEL                                                           = 0x00003cf8,
    ERROR_INSTALL_FAILED                                                           = 0x00003cf9,
    ERROR_REMOVE_FAILED                                                            = 0x00003cfa,
    ERROR_PACKAGE_ALREADY_EXISTS                                                   = 0x00003cfb,
    ERROR_NEEDS_REMEDIATION                                                        = 0x00003cfc,
    ERROR_INSTALL_PREREQUISITE_FAILED                                              = 0x00003cfd,
    ERROR_PACKAGE_REPOSITORY_CORRUPTED                                             = 0x00003cfe,
    ERROR_INSTALL_POLICY_FAILURE                                                   = 0x00003cff,
    ERROR_PACKAGE_UPDATING                                                         = 0x00003d00,
    ERROR_DEPLOYMENT_BLOCKED_BY_POLICY                                             = 0x00003d01,
    ERROR_PACKAGES_IN_USE                                                          = 0x00003d02,
    ERROR_RECOVERY_FILE_CORRUPT                                                    = 0x00003d03,
    ERROR_INVALID_STAGED_SIGNATURE                                                 = 0x00003d04,
    ERROR_DELETING_EXISTING_APPLICATIONDATA_STORE_FAILED                           = 0x00003d05,
    ERROR_INSTALL_PACKAGE_DOWNGRADE                                                = 0x00003d06,
    ERROR_SYSTEM_NEEDS_REMEDIATION                                                 = 0x00003d07,
    ERROR_APPX_INTEGRITY_FAILURE_CLR_NGEN                                          = 0x00003d08,
    ERROR_RESILIENCY_FILE_CORRUPT                                                  = 0x00003d09,
    ERROR_INSTALL_FIREWALL_SERVICE_NOT_RUNNING                                     = 0x00003d0a,
    ERROR_PACKAGE_MOVE_FAILED                                                      = 0x00003d0b,
    ERROR_INSTALL_VOLUME_NOT_EMPTY                                                 = 0x00003d0c,
    ERROR_INSTALL_VOLUME_OFFLINE                                                   = 0x00003d0d,
    ERROR_INSTALL_VOLUME_CORRUPT                                                   = 0x00003d0e,
    ERROR_NEEDS_REGISTRATION                                                       = 0x00003d0f,
    ERROR_INSTALL_WRONG_PROCESSOR_ARCHITECTURE                                     = 0x00003d10,
    ERROR_DEV_SIDELOAD_LIMIT_EXCEEDED                                              = 0x00003d11,
    ERROR_INSTALL_OPTIONAL_PACKAGE_REQUIRES_MAIN_PACKAGE                           = 0x00003d12,
    ERROR_PACKAGE_NOT_SUPPORTED_ON_FILESYSTEM                                      = 0x00003d13,
    ERROR_PACKAGE_MOVE_BLOCKED_BY_STREAMING                                        = 0x00003d14,
    ERROR_INSTALL_OPTIONAL_PACKAGE_APPLICATIONID_NOT_UNIQUE                        = 0x00003d15,
    ERROR_PACKAGE_STAGING_ONHOLD                                                   = 0x00003d16,
    ERROR_INSTALL_INVALID_RELATED_SET_UPDATE                                       = 0x00003d17,
    ERROR_INSTALL_OPTIONAL_PACKAGE_REQUIRES_MAIN_PACKAGE_FULLTRUST_CAPABILITY      = 0x00003d18,
    ERROR_DEPLOYMENT_BLOCKED_BY_USER_LOG_OFF                                       = 0x00003d19,
    ERROR_PROVISION_OPTIONAL_PACKAGE_REQUIRES_MAIN_PACKAGE_PROVISIONED             = 0x00003d1a,
    ERROR_PACKAGES_REPUTATION_CHECK_FAILED                                         = 0x00003d1b,
    ERROR_PACKAGES_REPUTATION_CHECK_TIMEDOUT                                       = 0x00003d1c,
    ERROR_DEPLOYMENT_OPTION_NOT_SUPPORTED                                          = 0x00003d1d,
    ERROR_APPINSTALLER_ACTIVATION_BLOCKED                                          = 0x00003d1e,
    ERROR_REGISTRATION_FROM_REMOTE_DRIVE_NOT_SUPPORTED                             = 0x00003d1f,
    ERROR_APPX_RAW_DATA_WRITE_FAILED                                               = 0x00003d20,
    ERROR_DEPLOYMENT_BLOCKED_BY_VOLUME_POLICY_PACKAGE                              = 0x00003d21,
    ERROR_DEPLOYMENT_BLOCKED_BY_VOLUME_POLICY_MACHINE                              = 0x00003d22,
    ERROR_DEPLOYMENT_BLOCKED_BY_PROFILE_POLICY                                     = 0x00003d23,
    ERROR_DEPLOYMENT_FAILED_CONFLICTING_MUTABLE_PACKAGE_DIRECTORY                  = 0x00003d24,
    ERROR_SINGLETON_RESOURCE_INSTALLED_IN_ACTIVE_USER                              = 0x00003d25,
    ERROR_DIFFERENT_VERSION_OF_PACKAGED_SERVICE_INSTALLED                          = 0x00003d26,
    ERROR_SERVICE_EXISTS_AS_NON_PACKAGED_SERVICE                                   = 0x00003d27,
    ERROR_PACKAGED_SERVICE_REQUIRES_ADMIN_PRIVILEGES                               = 0x00003d28,
    ERROR_REDIRECTION_TO_DEFAULT_ACCOUNT_NOT_ALLOWED                               = 0x00003d29,
    ERROR_PACKAGE_LACKS_CAPABILITY_TO_DEPLOY_ON_HOST                               = 0x00003d2a,
    ERROR_UNSIGNED_PACKAGE_INVALID_CONTENT                                         = 0x00003d2b,
    ERROR_UNSIGNED_PACKAGE_INVALID_PUBLISHER_NAMESPACE                             = 0x00003d2c,
    ERROR_SIGNED_PACKAGE_INVALID_PUBLISHER_NAMESPACE                               = 0x00003d2d,
    ERROR_PACKAGE_EXTERNAL_LOCATION_NOT_ALLOWED                                    = 0x00003d2e,
    ERROR_INSTALL_FULLTRUST_HOSTRUNTIME_REQUIRES_MAIN_PACKAGE_FULLTRUST_CAPABILITY = 0x00003d2f,
    ERROR_PACKAGE_LACKS_CAPABILITY_FOR_MANDATORY_STARTUPTASKS                      = 0x00003d30,
    ERROR_INSTALL_RESOLVE_HOSTRUNTIME_DEPENDENCY_FAILED                            = 0x00003d31,
    ERROR_MACHINE_SCOPE_NOT_ALLOWED                                                = 0x00003d32,
    ERROR_CLASSIC_COMPAT_MODE_NOT_ALLOWED                                          = 0x00003d33,
    ERROR_STAGEFROMUPDATEAGENT_PACKAGE_NOT_APPLICABLE                              = 0x00003d34,
    ERROR_PACKAGE_NOT_REGISTERED_FOR_USER                                          = 0x00003d35,
    ERROR_PACKAGE_NAME_MISMATCH                                                    = 0x00003d36,
    ERROR_APPINSTALLER_URI_IN_USE                                                  = 0x00003d37,
    ERROR_APPINSTALLER_IS_MANAGED_BY_SYSTEM                                        = 0x00003d38,
    ERROR_SERVICE_BLOCKED_BY_SYSPREP_IN_PROGRESS                                   = 0x00003d39,
    ERROR_UNSUPPORTED_ARM32_PACKAGE_REQUIRES_REMEDIAITON                           = 0x00003d3a,
    ERROR_UUP_PRODUCT_NOT_APPLICABLE                                               = 0x00003d3b,
    ERROR_BLOCKED_BY_PENDING_PACKAGE_REMOVAL                                       = 0x00003d3c,
    ERROR_PACKAGE_REPOSITORY_ROOT_CORRUPTED                                        = 0x00003d3d,
    ERROR_PACKAGE_MANIFEST_NOT_FOUND                                               = 0x00003d3e,
    ERROR_DEPLOYMENT_BLOCKED_BY_REMOVEDEFAULTPACKAGES_POLICY                       = 0x00003d3f,
    ERROR_URI_BLOCKED_BY_POLICY_MSIXALLOWEDZONES                                   = 0x00003d40,
    ERROR_URI_RECOMMENDED_BLOCK_BY_SMARTSCREEN                                     = 0x00003d41,
    APPMODEL_ERROR_NO_PACKAGE                                                      = 0x00003d54,
    APPMODEL_ERROR_PACKAGE_RUNTIME_CORRUPT                                         = 0x00003d55,
    APPMODEL_ERROR_PACKAGE_IDENTITY_CORRUPT                                        = 0x00003d56,
    APPMODEL_ERROR_NO_APPLICATION                                                  = 0x00003d57,
    APPMODEL_ERROR_DYNAMIC_PROPERTY_READ_FAILED                                    = 0x00003d58,
    APPMODEL_ERROR_DYNAMIC_PROPERTY_INVALID                                        = 0x00003d59,
    APPMODEL_ERROR_PACKAGE_NOT_AVAILABLE                                           = 0x00003d5a,
    APPMODEL_ERROR_NO_MUTABLE_DIRECTORY                                            = 0x00003d5b,
    ERROR_STATE_LOAD_STORE_FAILED                                                  = 0x00003db8,
    ERROR_STATE_GET_VERSION_FAILED                                                 = 0x00003db9,
    ERROR_STATE_SET_VERSION_FAILED                                                 = 0x00003dba,
    ERROR_STATE_STRUCTURED_RESET_FAILED                                            = 0x00003dbb,
    ERROR_STATE_OPEN_CONTAINER_FAILED                                              = 0x00003dbc,
    ERROR_STATE_CREATE_CONTAINER_FAILED                                            = 0x00003dbd,
    ERROR_STATE_DELETE_CONTAINER_FAILED                                            = 0x00003dbe,
    ERROR_STATE_READ_SETTING_FAILED                                                = 0x00003dbf,
    ERROR_STATE_WRITE_SETTING_FAILED                                               = 0x00003dc0,
    ERROR_STATE_DELETE_SETTING_FAILED                                              = 0x00003dc1,
    ERROR_STATE_QUERY_SETTING_FAILED                                               = 0x00003dc2,
    ERROR_STATE_READ_COMPOSITE_SETTING_FAILED                                      = 0x00003dc3,
    ERROR_STATE_WRITE_COMPOSITE_SETTING_FAILED                                     = 0x00003dc4,
    ERROR_STATE_ENUMERATE_CONTAINER_FAILED                                         = 0x00003dc5,
    ERROR_STATE_ENUMERATE_SETTINGS_FAILED                                          = 0x00003dc6,
    ERROR_STATE_COMPOSITE_SETTING_VALUE_SIZE_LIMIT_EXCEEDED                        = 0x00003dc7,
    ERROR_STATE_SETTING_VALUE_SIZE_LIMIT_EXCEEDED                                  = 0x00003dc8,
    ERROR_STATE_SETTING_NAME_SIZE_LIMIT_EXCEEDED                                   = 0x00003dc9,
    ERROR_STATE_CONTAINER_NAME_SIZE_LIMIT_EXCEEDED                                 = 0x00003dca,
    ERROR_API_UNAVAILABLE                                                          = 0x00003de1,
    ERROR_NDIS_INTERFACE_CLOSING                                                   = 0x80340002,
    ERROR_NDIS_BAD_VERSION                                                         = 0x80340004,
    ERROR_NDIS_BAD_CHARACTERISTICS                                                 = 0x80340005,
    ERROR_NDIS_ADAPTER_NOT_FOUND                                                   = 0x80340006,
    ERROR_NDIS_OPEN_FAILED                                                         = 0x80340007,
    ERROR_NDIS_DEVICE_FAILED                                                       = 0x80340008,
    ERROR_NDIS_MULTICAST_FULL                                                      = 0x80340009,
    ERROR_NDIS_MULTICAST_EXISTS                                                    = 0x8034000a,
    ERROR_NDIS_MULTICAST_NOT_FOUND                                                 = 0x8034000b,
    ERROR_NDIS_REQUEST_ABORTED                                                     = 0x8034000c,
    ERROR_NDIS_RESET_IN_PROGRESS                                                   = 0x8034000d,
    ERROR_NDIS_NOT_SUPPORTED                                                       = 0x803400bb,
    ERROR_NDIS_INVALID_PACKET                                                      = 0x8034000f,
    ERROR_NDIS_ADAPTER_NOT_READY                                                   = 0x80340011,
    ERROR_NDIS_INVALID_LENGTH                                                      = 0x80340014,
    ERROR_NDIS_INVALID_DATA                                                        = 0x80340015,
    ERROR_NDIS_BUFFER_TOO_SHORT                                                    = 0x80340016,
    ERROR_NDIS_INVALID_OID                                                         = 0x80340017,
    ERROR_NDIS_ADAPTER_REMOVED                                                     = 0x80340018,
    ERROR_NDIS_UNSUPPORTED_MEDIA                                                   = 0x80340019,
    ERROR_NDIS_GROUP_ADDRESS_IN_USE                                                = 0x8034001a,
    ERROR_NDIS_FILE_NOT_FOUND                                                      = 0x8034001b,
    ERROR_NDIS_ERROR_READING_FILE                                                  = 0x8034001c,
    ERROR_NDIS_ALREADY_MAPPED                                                      = 0x8034001d,
    ERROR_NDIS_RESOURCE_CONFLICT                                                   = 0x8034001e,
    ERROR_NDIS_MEDIA_DISCONNECTED                                                  = 0x8034001f,
    ERROR_NDIS_INVALID_ADDRESS                                                     = 0x80340022,
    ERROR_NDIS_INVALID_DEVICE_REQUEST                                              = 0x80340010,
    ERROR_NDIS_PAUSED                                                              = 0x8034002a,
    ERROR_NDIS_INTERFACE_NOT_FOUND                                                 = 0x8034002b,
    ERROR_NDIS_UNSUPPORTED_REVISION                                                = 0x8034002c,
    ERROR_NDIS_INVALID_PORT                                                        = 0x8034002d,
    ERROR_NDIS_INVALID_PORT_STATE                                                  = 0x8034002e,
    ERROR_NDIS_LOW_POWER_STATE                                                     = 0x8034002f,
    ERROR_NDIS_REINIT_REQUIRED                                                     = 0x80340030,
    ERROR_NDIS_NO_QUEUES                                                           = 0x80340031,
    ERROR_NDIS_DOT11_AUTO_CONFIG_ENABLED                                           = 0x80342000,
    ERROR_NDIS_DOT11_MEDIA_IN_USE                                                  = 0x80342001,
    ERROR_NDIS_DOT11_POWER_STATE_INVALID                                           = 0x80342002,
    ERROR_NDIS_PM_WOL_PATTERN_LIST_FULL                                            = 0x80342003,
    ERROR_NDIS_PM_PROTOCOL_OFFLOAD_LIST_FULL                                       = 0x80342004,
    ERROR_NDIS_DOT11_AP_CHANNEL_CURRENTLY_NOT_AVAILABLE                            = 0x80342005,
    ERROR_NDIS_DOT11_AP_BAND_CURRENTLY_NOT_AVAILABLE                               = 0x80342006,
    ERROR_NDIS_DOT11_AP_CHANNEL_NOT_ALLOWED                                        = 0x80342007,
    ERROR_NDIS_DOT11_AP_BAND_NOT_ALLOWED                                           = 0x80342008,
    ERROR_NDIS_DOT11_AP_RADIO_RESTRICTION                                          = 0x80342009,
    ERROR_NDIS_INDICATION_REQUIRED                                                 = 0x00340001,
    ERROR_NDIS_OFFLOAD_POLICY                                                      = 0xc034100f,
    ERROR_NDIS_OFFLOAD_CONNECTION_REJECTED                                         = 0xc0341012,
    ERROR_NDIS_OFFLOAD_PATH_REJECTED                                               = 0xc0341013,
    ERROR_HV_INVALID_HYPERCALL_CODE                                                = 0xc0350002,
    ERROR_HV_INVALID_HYPERCALL_INPUT                                               = 0xc0350003,
    ERROR_HV_INVALID_ALIGNMENT                                                     = 0xc0350004,
    ERROR_HV_INVALID_PARAMETER                                                     = 0xc0350005,
    ERROR_HV_ACCESS_DENIED                                                         = 0xc0350006,
    ERROR_HV_INVALID_PARTITION_STATE                                               = 0xc0350007,
    ERROR_HV_OPERATION_DENIED                                                      = 0xc0350008,
    ERROR_HV_UNKNOWN_PROPERTY                                                      = 0xc0350009,
    ERROR_HV_PROPERTY_VALUE_OUT_OF_RANGE                                           = 0xc035000a,
    ERROR_HV_INSUFFICIENT_MEMORY                                                   = 0xc035000b,
    ERROR_HV_PARTITION_TOO_DEEP                                                    = 0xc035000c,
    ERROR_HV_INVALID_PARTITION_ID                                                  = 0xc035000d,
    ERROR_HV_INVALID_VP_INDEX                                                      = 0xc035000e,
    ERROR_HV_INVALID_PORT_ID                                                       = 0xc0350011,
    ERROR_HV_INVALID_CONNECTION_ID                                                 = 0xc0350012,
    ERROR_HV_INSUFFICIENT_BUFFERS                                                  = 0xc0350013,
    ERROR_HV_NOT_ACKNOWLEDGED                                                      = 0xc0350014,
    ERROR_HV_INVALID_VP_STATE                                                      = 0xc0350015,
    ERROR_HV_ACKNOWLEDGED                                                          = 0xc0350016,
    ERROR_HV_INVALID_SAVE_RESTORE_STATE                                            = 0xc0350017,
    ERROR_HV_INVALID_SYNIC_STATE                                                   = 0xc0350018,
    ERROR_HV_OBJECT_IN_USE                                                         = 0xc0350019,
    ERROR_HV_INVALID_PROXIMITY_DOMAIN_INFO                                         = 0xc035001a,
    ERROR_HV_NO_DATA                                                               = 0xc035001b,
    ERROR_HV_INACTIVE                                                              = 0xc035001c,
    ERROR_HV_NO_RESOURCES                                                          = 0xc035001d,
    ERROR_HV_FEATURE_UNAVAILABLE                                                   = 0xc035001e,
    ERROR_HV_INSUFFICIENT_BUFFER                                                   = 0xc0350033,
    ERROR_HV_INSUFFICIENT_DEVICE_DOMAINS                                           = 0xc0350038,
    ERROR_HV_CPUID_FEATURE_VALIDATION                                              = 0xc035003c,
    ERROR_HV_CPUID_XSAVE_FEATURE_VALIDATION                                        = 0xc035003d,
    ERROR_HV_PROCESSOR_STARTUP_TIMEOUT                                             = 0xc035003e,
    ERROR_HV_SMX_ENABLED                                                           = 0xc035003f,
    ERROR_HV_INVALID_LP_INDEX                                                      = 0xc0350041,
    ERROR_HV_INVALID_REGISTER_VALUE                                                = 0xc0350050,
    ERROR_HV_INVALID_VTL_STATE                                                     = 0xc0350051,
    ERROR_HV_NX_NOT_DETECTED                                                       = 0xc0350055,
    ERROR_HV_INVALID_DEVICE_ID                                                     = 0xc0350057,
    ERROR_HV_INVALID_DEVICE_STATE                                                  = 0xc0350058,
    ERROR_HV_PENDING_PAGE_REQUESTS                                                 = 0x00350059,
    ERROR_HV_PAGE_REQUEST_INVALID                                                  = 0xc0350060,
    ERROR_HV_INVALID_CPU_GROUP_ID                                                  = 0xc035006f,
    ERROR_HV_INVALID_CPU_GROUP_STATE                                               = 0xc0350070,
    ERROR_HV_OPERATION_FAILED                                                      = 0xc0350071,
    ERROR_HV_NOT_ALLOWED_WITH_NESTED_VIRT_ACTIVE                                   = 0xc0350072,
    ERROR_HV_INSUFFICIENT_ROOT_MEMORY                                              = 0xc0350073,
    ERROR_HV_EVENT_BUFFER_ALREADY_FREED                                            = 0xc0350074,
    ERROR_HV_INSUFFICIENT_CONTIGUOUS_MEMORY                                        = 0xc0350075,
    ERROR_HV_DEVICE_NOT_IN_DOMAIN                                                  = 0xc0350076,
    ERROR_HV_NESTED_VM_EXIT                                                        = 0xc0350077,
    ERROR_HV_MSR_ACCESS_FAILED                                                     = 0xc0350080,
    ERROR_HV_INSUFFICIENT_MEMORY_MIRRORING                                         = 0xc0350081,
    ERROR_HV_INSUFFICIENT_CONTIGUOUS_MEMORY_MIRRORING                              = 0xc0350082,
    ERROR_HV_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY                                   = 0xc0350083,
    ERROR_HV_INSUFFICIENT_ROOT_MEMORY_MIRRORING                                    = 0xc0350084,
    ERROR_HV_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY_MIRRORING                         = 0xc0350085,
    ERROR_HV_VTL_ALREADY_ENABLED                                                   = 0xc0350086,
    ERROR_HV_SPDM_REQUEST                                                          = 0xc0350088,
    ERROR_HV_NOT_PRESENT                                                           = 0xc0351000,
    ERROR_VID_DUPLICATE_HANDLER                                                    = 0xc0370001,
    ERROR_VID_TOO_MANY_HANDLERS                                                    = 0xc0370002,
    ERROR_VID_QUEUE_FULL                                                           = 0xc0370003,
    ERROR_VID_HANDLER_NOT_PRESENT                                                  = 0xc0370004,
    ERROR_VID_INVALID_OBJECT_NAME                                                  = 0xc0370005,
    ERROR_VID_PARTITION_NAME_TOO_LONG                                              = 0xc0370006,
    ERROR_VID_MESSAGE_QUEUE_NAME_TOO_LONG                                          = 0xc0370007,
    ERROR_VID_PARTITION_ALREADY_EXISTS                                             = 0xc0370008,
    ERROR_VID_PARTITION_DOES_NOT_EXIST                                             = 0xc0370009,
    ERROR_VID_PARTITION_NAME_NOT_FOUND                                             = 0xc037000a,
    ERROR_VID_MESSAGE_QUEUE_ALREADY_EXISTS                                         = 0xc037000b,
    ERROR_VID_EXCEEDED_MBP_ENTRY_MAP_LIMIT                                         = 0xc037000c,
    ERROR_VID_MB_STILL_REFERENCED                                                  = 0xc037000d,
    ERROR_VID_CHILD_GPA_PAGE_SET_CORRUPTED                                         = 0xc037000e,
    ERROR_VID_INVALID_NUMA_SETTINGS                                                = 0xc037000f,
    ERROR_VID_INVALID_NUMA_NODE_INDEX                                              = 0xc0370010,
    ERROR_VID_NOTIFICATION_QUEUE_ALREADY_ASSOCIATED                                = 0xc0370011,
    ERROR_VID_INVALID_MEMORY_BLOCK_HANDLE                                          = 0xc0370012,
    ERROR_VID_PAGE_RANGE_OVERFLOW                                                  = 0xc0370013,
    ERROR_VID_INVALID_MESSAGE_QUEUE_HANDLE                                         = 0xc0370014,
    ERROR_VID_INVALID_GPA_RANGE_HANDLE                                             = 0xc0370015,
    ERROR_VID_NO_MEMORY_BLOCK_NOTIFICATION_QUEUE                                   = 0xc0370016,
    ERROR_VID_MEMORY_BLOCK_LOCK_COUNT_EXCEEDED                                     = 0xc0370017,
    ERROR_VID_INVALID_PPM_HANDLE                                                   = 0xc0370018,
    ERROR_VID_MBPS_ARE_LOCKED                                                      = 0xc0370019,
    ERROR_VID_MESSAGE_QUEUE_CLOSED                                                 = 0xc037001a,
    ERROR_VID_VIRTUAL_PROCESSOR_LIMIT_EXCEEDED                                     = 0xc037001b,
    ERROR_VID_STOP_PENDING                                                         = 0xc037001c,
    ERROR_VID_INVALID_PROCESSOR_STATE                                              = 0xc037001d,
    ERROR_VID_EXCEEDED_KM_CONTEXT_COUNT_LIMIT                                      = 0xc037001e,
    ERROR_VID_KM_INTERFACE_ALREADY_INITIALIZED                                     = 0xc037001f,
    ERROR_VID_MB_PROPERTY_ALREADY_SET_RESET                                        = 0xc0370020,
    ERROR_VID_MMIO_RANGE_DESTROYED                                                 = 0xc0370021,
    ERROR_VID_INVALID_CHILD_GPA_PAGE_SET                                           = 0xc0370022,
    ERROR_VID_RESERVE_PAGE_SET_IS_BEING_USED                                       = 0xc0370023,
    ERROR_VID_RESERVE_PAGE_SET_TOO_SMALL                                           = 0xc0370024,
    ERROR_VID_MBP_ALREADY_LOCKED_USING_RESERVED_PAGE                               = 0xc0370025,
    ERROR_VID_MBP_COUNT_EXCEEDED_LIMIT                                             = 0xc0370026,
    ERROR_VID_SAVED_STATE_CORRUPT                                                  = 0xc0370027,
    ERROR_VID_SAVED_STATE_UNRECOGNIZED_ITEM                                        = 0xc0370028,
    ERROR_VID_SAVED_STATE_INCOMPATIBLE                                             = 0xc0370029,
    ERROR_VID_VTL_ACCESS_DENIED                                                    = 0xc037002a,
    ERROR_VID_INSUFFICIENT_RESOURCES_RESERVE                                       = 0xc037002b,
    ERROR_VID_INSUFFICIENT_RESOURCES_PHYSICAL_BUFFER                               = 0xc037002c,
    ERROR_VID_INSUFFICIENT_RESOURCES_HV_DEPOSIT                                    = 0xc037002d,
    ERROR_VID_MEMORY_TYPE_NOT_SUPPORTED                                            = 0xc037002e,
    ERROR_VID_INSUFFICIENT_RESOURCES_WITHDRAW                                      = 0xc037002f,
    ERROR_VID_PROCESS_ALREADY_SET                                                  = 0xc0370030,
    ERROR_VMCOMPUTE_TERMINATED_DURING_START                                        = 0xc0370100,
    ERROR_VMCOMPUTE_IMAGE_MISMATCH                                                 = 0xc0370101,
    ERROR_VMCOMPUTE_HYPERV_NOT_INSTALLED                                           = 0xc0370102,
    ERROR_VMCOMPUTE_OPERATION_PENDING                                              = 0xc0370103,
    ERROR_VMCOMPUTE_TOO_MANY_NOTIFICATIONS                                         = 0xc0370104,
    ERROR_VMCOMPUTE_INVALID_STATE                                                  = 0xc0370105,
    ERROR_VMCOMPUTE_UNEXPECTED_EXIT                                                = 0xc0370106,
    ERROR_VMCOMPUTE_TERMINATED                                                     = 0xc0370107,
    ERROR_VMCOMPUTE_CONNECT_FAILED                                                 = 0xc0370108,
    ERROR_VMCOMPUTE_TIMEOUT                                                        = 0xc0370109,
    ERROR_VMCOMPUTE_CONNECTION_CLOSED                                              = 0xc037010a,
    ERROR_VMCOMPUTE_UNKNOWN_MESSAGE                                                = 0xc037010b,
    ERROR_VMCOMPUTE_UNSUPPORTED_PROTOCOL_VERSION                                   = 0xc037010c,
    ERROR_VMCOMPUTE_INVALID_JSON                                                   = 0xc037010d,
    ERROR_VMCOMPUTE_SYSTEM_NOT_FOUND                                               = 0xc037010e,
    ERROR_VMCOMPUTE_SYSTEM_ALREADY_EXISTS                                          = 0xc037010f,
    ERROR_VMCOMPUTE_SYSTEM_ALREADY_STOPPED                                         = 0xc0370110,
    ERROR_VMCOMPUTE_PROTOCOL_ERROR                                                 = 0xc0370111,
    ERROR_VMCOMPUTE_INVALID_LAYER                                                  = 0xc0370112,
    ERROR_VMCOMPUTE_WINDOWS_INSIDER_REQUIRED                                       = 0xc0370113,
    ERROR_VNET_VIRTUAL_SWITCH_NAME_NOT_FOUND                                       = 0xc0370200,
    ERROR_VID_REMOTE_NODE_PARENT_GPA_PAGES_USED                                    = 0x80370001,
    ERROR_VSMB_SAVED_STATE_FILE_NOT_FOUND                                          = 0xc0370400,
    ERROR_VSMB_SAVED_STATE_CORRUPT                                                 = 0xc0370401,
    ERROR_VOLMGR_INCOMPLETE_REGENERATION                                           = 0x80380001,
    ERROR_VOLMGR_INCOMPLETE_DISK_MIGRATION                                         = 0x80380002,
    ERROR_VOLMGR_DATABASE_FULL                                                     = 0xc0380001,
    ERROR_VOLMGR_DISK_CONFIGURATION_CORRUPTED                                      = 0xc0380002,
    ERROR_VOLMGR_DISK_CONFIGURATION_NOT_IN_SYNC                                    = 0xc0380003,
    ERROR_VOLMGR_PACK_CONFIG_UPDATE_FAILED                                         = 0xc0380004,
    ERROR_VOLMGR_DISK_CONTAINS_NON_SIMPLE_VOLUME                                   = 0xc0380005,
    ERROR_VOLMGR_DISK_DUPLICATE                                                    = 0xc0380006,
    ERROR_VOLMGR_DISK_DYNAMIC                                                      = 0xc0380007,
    ERROR_VOLMGR_DISK_ID_INVALID                                                   = 0xc0380008,
    ERROR_VOLMGR_DISK_INVALID                                                      = 0xc0380009,
    ERROR_VOLMGR_DISK_LAST_VOTER                                                   = 0xc038000a,
    ERROR_VOLMGR_DISK_LAYOUT_INVALID                                               = 0xc038000b,
    ERROR_VOLMGR_DISK_LAYOUT_NON_BASIC_BETWEEN_BASIC_PARTITIONS                    = 0xc038000c,
    ERROR_VOLMGR_DISK_LAYOUT_NOT_CYLINDER_ALIGNED                                  = 0xc038000d,
    ERROR_VOLMGR_DISK_LAYOUT_PARTITIONS_TOO_SMALL                                  = 0xc038000e,
    ERROR_VOLMGR_DISK_LAYOUT_PRIMARY_BETWEEN_LOGICAL_PARTITIONS                    = 0xc038000f,
    ERROR_VOLMGR_DISK_LAYOUT_TOO_MANY_PARTITIONS                                   = 0xc0380010,
    ERROR_VOLMGR_DISK_MISSING                                                      = 0xc0380011,
    ERROR_VOLMGR_DISK_NOT_EMPTY                                                    = 0xc0380012,
    ERROR_VOLMGR_DISK_NOT_ENOUGH_SPACE                                             = 0xc0380013,
    ERROR_VOLMGR_DISK_REVECTORING_FAILED                                           = 0xc0380014,
    ERROR_VOLMGR_DISK_SECTOR_SIZE_INVALID                                          = 0xc0380015,
    ERROR_VOLMGR_DISK_SET_NOT_CONTAINED                                            = 0xc0380016,
    ERROR_VOLMGR_DISK_USED_BY_MULTIPLE_MEMBERS                                     = 0xc0380017,
    ERROR_VOLMGR_DISK_USED_BY_MULTIPLE_PLEXES                                      = 0xc0380018,
    ERROR_VOLMGR_DYNAMIC_DISK_NOT_SUPPORTED                                        = 0xc0380019,
    ERROR_VOLMGR_EXTENT_ALREADY_USED                                               = 0xc038001a,
    ERROR_VOLMGR_EXTENT_NOT_CONTIGUOUS                                             = 0xc038001b,
    ERROR_VOLMGR_EXTENT_NOT_IN_PUBLIC_REGION                                       = 0xc038001c,
    ERROR_VOLMGR_EXTENT_NOT_SECTOR_ALIGNED                                         = 0xc038001d,
    ERROR_VOLMGR_EXTENT_OVERLAPS_EBR_PARTITION                                     = 0xc038001e,
    ERROR_VOLMGR_EXTENT_VOLUME_LENGTHS_DO_NOT_MATCH                                = 0xc038001f,
    ERROR_VOLMGR_FAULT_TOLERANT_NOT_SUPPORTED                                      = 0xc0380020,
    ERROR_VOLMGR_INTERLEAVE_LENGTH_INVALID                                         = 0xc0380021,
    ERROR_VOLMGR_MAXIMUM_REGISTERED_USERS                                          = 0xc0380022,
    ERROR_VOLMGR_MEMBER_IN_SYNC                                                    = 0xc0380023,
    ERROR_VOLMGR_MEMBER_INDEX_DUPLICATE                                            = 0xc0380024,
    ERROR_VOLMGR_MEMBER_INDEX_INVALID                                              = 0xc0380025,
    ERROR_VOLMGR_MEMBER_MISSING                                                    = 0xc0380026,
    ERROR_VOLMGR_MEMBER_NOT_DETACHED                                               = 0xc0380027,
    ERROR_VOLMGR_MEMBER_REGENERATING                                               = 0xc0380028,
    ERROR_VOLMGR_ALL_DISKS_FAILED                                                  = 0xc0380029,
    ERROR_VOLMGR_NO_REGISTERED_USERS                                               = 0xc038002a,
    ERROR_VOLMGR_NO_SUCH_USER                                                      = 0xc038002b,
    ERROR_VOLMGR_NOTIFICATION_RESET                                                = 0xc038002c,
    ERROR_VOLMGR_NUMBER_OF_MEMBERS_INVALID                                         = 0xc038002d,
    ERROR_VOLMGR_NUMBER_OF_PLEXES_INVALID                                          = 0xc038002e,
    ERROR_VOLMGR_PACK_DUPLICATE                                                    = 0xc038002f,
    ERROR_VOLMGR_PACK_ID_INVALID                                                   = 0xc0380030,
    ERROR_VOLMGR_PACK_INVALID                                                      = 0xc0380031,
    ERROR_VOLMGR_PACK_NAME_INVALID                                                 = 0xc0380032,
    ERROR_VOLMGR_PACK_OFFLINE                                                      = 0xc0380033,
    ERROR_VOLMGR_PACK_HAS_QUORUM                                                   = 0xc0380034,
    ERROR_VOLMGR_PACK_WITHOUT_QUORUM                                               = 0xc0380035,
    ERROR_VOLMGR_PARTITION_STYLE_INVALID                                           = 0xc0380036,
    ERROR_VOLMGR_PARTITION_UPDATE_FAILED                                           = 0xc0380037,
    ERROR_VOLMGR_PLEX_IN_SYNC                                                      = 0xc0380038,
    ERROR_VOLMGR_PLEX_INDEX_DUPLICATE                                              = 0xc0380039,
    ERROR_VOLMGR_PLEX_INDEX_INVALID                                                = 0xc038003a,
    ERROR_VOLMGR_PLEX_LAST_ACTIVE                                                  = 0xc038003b,
    ERROR_VOLMGR_PLEX_MISSING                                                      = 0xc038003c,
    ERROR_VOLMGR_PLEX_REGENERATING                                                 = 0xc038003d,
    ERROR_VOLMGR_PLEX_TYPE_INVALID                                                 = 0xc038003e,
    ERROR_VOLMGR_PLEX_NOT_RAID5                                                    = 0xc038003f,
    ERROR_VOLMGR_PLEX_NOT_SIMPLE                                                   = 0xc0380040,
    ERROR_VOLMGR_STRUCTURE_SIZE_INVALID                                            = 0xc0380041,
    ERROR_VOLMGR_TOO_MANY_NOTIFICATION_REQUESTS                                    = 0xc0380042,
    ERROR_VOLMGR_TRANSACTION_IN_PROGRESS                                           = 0xc0380043,
    ERROR_VOLMGR_UNEXPECTED_DISK_LAYOUT_CHANGE                                     = 0xc0380044,
    ERROR_VOLMGR_VOLUME_CONTAINS_MISSING_DISK                                      = 0xc0380045,
    ERROR_VOLMGR_VOLUME_ID_INVALID                                                 = 0xc0380046,
    ERROR_VOLMGR_VOLUME_LENGTH_INVALID                                             = 0xc0380047,
    ERROR_VOLMGR_VOLUME_LENGTH_NOT_SECTOR_SIZE_MULTIPLE                            = 0xc0380048,
    ERROR_VOLMGR_VOLUME_NOT_MIRRORED                                               = 0xc0380049,
    ERROR_VOLMGR_VOLUME_NOT_RETAINED                                               = 0xc038004a,
    ERROR_VOLMGR_VOLUME_OFFLINE                                                    = 0xc038004b,
    ERROR_VOLMGR_VOLUME_RETAINED                                                   = 0xc038004c,
    ERROR_VOLMGR_NUMBER_OF_EXTENTS_INVALID                                         = 0xc038004d,
    ERROR_VOLMGR_DIFFERENT_SECTOR_SIZE                                             = 0xc038004e,
    ERROR_VOLMGR_BAD_BOOT_DISK                                                     = 0xc038004f,
    ERROR_VOLMGR_PACK_CONFIG_OFFLINE                                               = 0xc0380050,
    ERROR_VOLMGR_PACK_CONFIG_ONLINE                                                = 0xc0380051,
    ERROR_VOLMGR_NOT_PRIMARY_PACK                                                  = 0xc0380052,
    ERROR_VOLMGR_PACK_LOG_UPDATE_FAILED                                            = 0xc0380053,
    ERROR_VOLMGR_NUMBER_OF_DISKS_IN_PLEX_INVALID                                   = 0xc0380054,
    ERROR_VOLMGR_NUMBER_OF_DISKS_IN_MEMBER_INVALID                                 = 0xc0380055,
    ERROR_VOLMGR_VOLUME_MIRRORED                                                   = 0xc0380056,
    ERROR_VOLMGR_PLEX_NOT_SIMPLE_SPANNED                                           = 0xc0380057,
    ERROR_VOLMGR_NO_VALID_LOG_COPIES                                               = 0xc0380058,
    ERROR_VOLMGR_PRIMARY_PACK_PRESENT                                              = 0xc0380059,
    ERROR_VOLMGR_NUMBER_OF_DISKS_INVALID                                           = 0xc038005a,
    ERROR_VOLMGR_MIRROR_NOT_SUPPORTED                                              = 0xc038005b,
    ERROR_VOLMGR_RAID5_NOT_SUPPORTED                                               = 0xc038005c,
    ERROR_BCD_NOT_ALL_ENTRIES_IMPORTED                                             = 0x80390001,
    ERROR_BCD_TOO_MANY_ELEMENTS                                                    = 0xc0390002,
    ERROR_BCD_NOT_ALL_ENTRIES_SYNCHRONIZED                                         = 0x80390003,
    ERROR_VHD_DRIVE_FOOTER_MISSING                                                 = 0xc03a0001,
    ERROR_VHD_DRIVE_FOOTER_CHECKSUM_MISMATCH                                       = 0xc03a0002,
    ERROR_VHD_DRIVE_FOOTER_CORRUPT                                                 = 0xc03a0003,
    ERROR_VHD_FORMAT_UNKNOWN                                                       = 0xc03a0004,
    ERROR_VHD_FORMAT_UNSUPPORTED_VERSION                                           = 0xc03a0005,
    ERROR_VHD_SPARSE_HEADER_CHECKSUM_MISMATCH                                      = 0xc03a0006,
    ERROR_VHD_SPARSE_HEADER_UNSUPPORTED_VERSION                                    = 0xc03a0007,
    ERROR_VHD_SPARSE_HEADER_CORRUPT                                                = 0xc03a0008,
    ERROR_VHD_BLOCK_ALLOCATION_FAILURE                                             = 0xc03a0009,
    ERROR_VHD_BLOCK_ALLOCATION_TABLE_CORRUPT                                       = 0xc03a000a,
    ERROR_VHD_INVALID_BLOCK_SIZE                                                   = 0xc03a000b,
    ERROR_VHD_BITMAP_MISMATCH                                                      = 0xc03a000c,
    ERROR_VHD_PARENT_VHD_NOT_FOUND                                                 = 0xc03a000d,
    ERROR_VHD_CHILD_PARENT_ID_MISMATCH                                             = 0xc03a000e,
    ERROR_VHD_CHILD_PARENT_TIMESTAMP_MISMATCH                                      = 0xc03a000f,
    ERROR_VHD_METADATA_READ_FAILURE                                                = 0xc03a0010,
    ERROR_VHD_METADATA_WRITE_FAILURE                                               = 0xc03a0011,
    ERROR_VHD_INVALID_SIZE                                                         = 0xc03a0012,
    ERROR_VHD_INVALID_FILE_SIZE                                                    = 0xc03a0013,
    ERROR_VIRTDISK_PROVIDER_NOT_FOUND                                              = 0xc03a0014,
    ERROR_VIRTDISK_NOT_VIRTUAL_DISK                                                = 0xc03a0015,
    ERROR_VHD_PARENT_VHD_ACCESS_DENIED                                             = 0xc03a0016,
    ERROR_VHD_CHILD_PARENT_SIZE_MISMATCH                                           = 0xc03a0017,
    ERROR_VHD_DIFFERENCING_CHAIN_CYCLE_DETECTED                                    = 0xc03a0018,
    ERROR_VHD_DIFFERENCING_CHAIN_ERROR_IN_PARENT                                   = 0xc03a0019,
    ERROR_VIRTUAL_DISK_LIMITATION                                                  = 0xc03a001a,
    ERROR_VHD_INVALID_TYPE                                                         = 0xc03a001b,
    ERROR_VHD_INVALID_STATE                                                        = 0xc03a001c,
    ERROR_VIRTDISK_UNSUPPORTED_DISK_SECTOR_SIZE                                    = 0xc03a001d,
    ERROR_VIRTDISK_DISK_ALREADY_OWNED                                              = 0xc03a001e,
    ERROR_VIRTDISK_DISK_ONLINE_AND_WRITABLE                                        = 0xc03a001f,
    ERROR_CTLOG_TRACKING_NOT_INITIALIZED                                           = 0xc03a0020,
    ERROR_CTLOG_LOGFILE_SIZE_EXCEEDED_MAXSIZE                                      = 0xc03a0021,
    ERROR_CTLOG_VHD_CHANGED_OFFLINE                                                = 0xc03a0022,
    ERROR_CTLOG_INVALID_TRACKING_STATE                                             = 0xc03a0023,
    ERROR_CTLOG_INCONSISTENT_TRACKING_FILE                                         = 0xc03a0024,
    ERROR_VHD_RESIZE_WOULD_TRUNCATE_DATA                                           = 0xc03a0025,
    ERROR_VHD_COULD_NOT_COMPUTE_MINIMUM_VIRTUAL_SIZE                               = 0xc03a0026,
    ERROR_VHD_ALREADY_AT_OR_BELOW_MINIMUM_VIRTUAL_SIZE                             = 0xc03a0027,
    ERROR_VHD_METADATA_FULL                                                        = 0xc03a0028,
    ERROR_VHD_INVALID_CHANGE_TRACKING_ID                                           = 0xc03a0029,
    ERROR_VHD_CHANGE_TRACKING_DISABLED                                             = 0xc03a002a,
    ERROR_VHD_MISSING_CHANGE_TRACKING_INFORMATION                                  = 0xc03a0030,
    ERROR_VHD_UNEXPECTED_ID                                                        = 0xc03a0034,
    ERROR_QUERY_STORAGE_ERROR                                                      = 0x803a0001,
}

alias WAIT_EVENT = uint;
enum : uint
{
    WAIT_OBJECT_0      = 0x00000000,
    WAIT_ABANDONED     = 0x00000080,
    WAIT_ABANDONED_0   = 0x00000080,
    WAIT_IO_COMPLETION = 0x000000c0,
    WAIT_TIMEOUT       = 0x00000102,
    WAIT_FAILED        = 0xffffffff,
}

alias NTSTATUS_FACILITY_CODE = uint;
enum : uint
{
    FACILITY_MCA_ERROR_CODE             = 0x00000005,
    FACILITY_DEBUGGER                   = 0x00000001,
    FACILITY_RPC_RUNTIME                = 0x00000002,
    FACILITY_RPC_STUBS                  = 0x00000003,
    FACILITY_IO_ERROR_CODE              = 0x00000004,
    FACILITY_CODCLASS_ERROR_CODE        = 0x00000006,
    FACILITY_NTWIN32                    = 0x00000007,
    FACILITY_NTCERT                     = 0x00000008,
    FACILITY_NTSSPI                     = 0x00000009,
    FACILITY_TERMINAL_SERVER            = 0x0000000a,
    FACILITY_USB_ERROR_CODE             = 0x00000010,
    FACILITY_HID_ERROR_CODE             = 0x00000011,
    FACILITY_FIREWIRE_ERROR_CODE        = 0x00000012,
    FACILITY_CLUSTER_ERROR_CODE         = 0x00000013,
    FACILITY_ACPI_ERROR_CODE            = 0x00000014,
    FACILITY_SXS_ERROR_CODE             = 0x00000015,
    FACILITY_TRANSACTION                = 0x00000019,
    FACILITY_COMMONLOG                  = 0x0000001a,
    FACILITY_VIDEO                      = 0x0000001b,
    FACILITY_FILTER_MANAGER             = 0x0000001c,
    FACILITY_MONITOR                    = 0x0000001d,
    FACILITY_GRAPHICS_KERNEL            = 0x0000001e,
    FACILITY_CAMERA                     = 0x0000001f,
    FACILITY_DRIVER_FRAMEWORK           = 0x00000020,
    FACILITY_FVE_ERROR_CODE             = 0x00000021,
    FACILITY_FWP_ERROR_CODE             = 0x00000022,
    FACILITY_NDIS_ERROR_CODE            = 0x00000023,
    FACILITY_QUIC_ERROR_CODE            = 0x00000024,
    FACILITY_TPM                        = 0x00000029,
    FACILITY_RTPM                       = 0x0000002a,
    FACILITY_HYPERVISOR                 = 0x00000035,
    FACILITY_IPSEC                      = 0x00000036,
    FACILITY_VIRTUALIZATION             = 0x00000037,
    FACILITY_VOLMGR                     = 0x00000038,
    FACILITY_BCD_ERROR_CODE             = 0x00000039,
    FACILITY_WIN32K_NTUSER              = 0x0000003e,
    FACILITY_WIN32K_NTGDI               = 0x0000003f,
    FACILITY_RESUME_KEY_FILTER          = 0x00000040,
    FACILITY_RDBSS                      = 0x00000041,
    FACILITY_BTH_ATT                    = 0x00000042,
    FACILITY_SECUREBOOT                 = 0x00000043,
    FACILITY_AUDIO_KERNEL               = 0x00000044,
    FACILITY_VSM                        = 0x00000045,
    FACILITY_NT_IORING                  = 0x00000046,
    FACILITY_VOLSNAP                    = 0x00000050,
    FACILITY_SDBUS                      = 0x00000051,
    FACILITY_SHARED_VHDX                = 0x0000005c,
    FACILITY_SMB                        = 0x0000005d,
    FACILITY_XVS                        = 0x0000005e,
    FACILITY_INTERIX                    = 0x00000099,
    FACILITY_SPACES                     = 0x000000e7,
    FACILITY_SECURITY_CORE              = 0x000000e8,
    FACILITY_SYSTEM_INTEGRITY           = 0x000000e9,
    FACILITY_LICENSING                  = 0x000000ea,
    FACILITY_PLATFORM_MANIFEST          = 0x000000eb,
    FACILITY_APP_EXEC                   = 0x000000ec,
    FACILITY_UNIONFS                    = 0x000000ed,
    FACILITY_PLATFORM_RUNTIME_MECHANISM = 0x000000ee,
    FACILITY_WIN_ACCEL                  = 0x000000ef,
    FACILITY_MAXIMUM_VALUE              = 0x000000f0,
}

alias NTSTATUS_SEVERITY_CODE = uint;
enum : uint
{
    STATUS_SEVERITY_SUCCESS       = 0x00000000,
    STATUS_SEVERITY_INFORMATIONAL = 0x00000001,
    STATUS_SEVERITY_WARNING       = 0x00000002,
    STATUS_SEVERITY_ERROR         = 0x00000003,
}

alias DUPLICATE_HANDLE_OPTIONS = uint;
enum : uint
{
    DUPLICATE_CLOSE_SOURCE = 0x00000001,
    DUPLICATE_SAME_ACCESS  = 0x00000002,
}

alias HANDLE_FLAGS = uint;
enum : uint
{
    HANDLE_FLAG_INHERIT            = 0x00000001,
    HANDLE_FLAG_PROTECT_FROM_CLOSE = 0x00000002,
}

alias GENERIC_ACCESS_RIGHTS = uint;
enum : uint
{
    GENERIC_READ    = 0x80000000,
    GENERIC_WRITE   = 0x40000000,
    GENERIC_EXECUTE = 0x20000000,
    GENERIC_ALL     = 0x10000000,
}

alias OBJECT_ATTRIBUTE_FLAGS = uint;
enum : uint
{
    OBJ_INHERIT                       = 0x00000002,
    OBJ_PERMANENT                     = 0x00000010,
    OBJ_EXCLUSIVE                     = 0x00000020,
    OBJ_CASE_INSENSITIVE              = 0x00000040,
    OBJ_OPENIF                        = 0x00000080,
    OBJ_OPENLINK                      = 0x00000100,
    OBJ_KERNEL_HANDLE                 = 0x00000200,
    OBJ_FORCE_ACCESS_CHECK            = 0x00000400,
    OBJ_IGNORE_IMPERSONATED_DEVICEMAP = 0x00000800,
    OBJ_DONT_REPARSE                  = 0x00001000,
    OBJ_VALID_ATTRIBUTES              = 0x00001ff2,
}

// Constants


enum BOOL TRUE = BOOL(0x00000001);

enum : VARIANT_BOOL
{
    VARIANT_TRUE  = VARIANT_BOOL(cast(short)0xffff),
    VARIANT_FALSE = VARIANT_BOOL(cast(short)0x0000),
}

enum HRESULT CO_E_NOTINITIALIZED = HRESULT(0x800401f0);
enum NTSTATUS EXCEPTION_ACCESS_VIOLATION = NTSTATUS(0xc0000005);

enum : NTSTATUS
{
    EXCEPTION_BREAKPOINT            = NTSTATUS(0x80000003),
    EXCEPTION_SINGLE_STEP           = NTSTATUS(0x80000004),
    EXCEPTION_ARRAY_BOUNDS_EXCEEDED = NTSTATUS(0xc000008c),
}

enum : NTSTATUS
{
    EXCEPTION_FLT_DIVIDE_BY_ZERO    = NTSTATUS(0xc000008e),
    EXCEPTION_FLT_INEXACT_RESULT    = NTSTATUS(0xc000008f),
    EXCEPTION_FLT_INVALID_OPERATION = NTSTATUS(0xc0000090),
    EXCEPTION_FLT_OVERFLOW          = NTSTATUS(0xc0000091),
    EXCEPTION_FLT_STACK_CHECK       = NTSTATUS(0xc0000092),
    EXCEPTION_FLT_UNDERFLOW         = NTSTATUS(0xc0000093),
    EXCEPTION_INT_DIVIDE_BY_ZERO    = NTSTATUS(0xc0000094),
    EXCEPTION_INT_OVERFLOW          = NTSTATUS(0xc0000095),
    EXCEPTION_PRIV_INSTRUCTION      = NTSTATUS(0xc0000096),
}

enum NTSTATUS EXCEPTION_ILLEGAL_INSTRUCTION = NTSTATUS(0xc000001d);

enum : NTSTATUS
{
    EXCEPTION_STACK_OVERFLOW      = NTSTATUS(0xc00000fd),
    EXCEPTION_INVALID_DISPOSITION = NTSTATUS(0xc0000026),
}

enum : NTSTATUS
{
    EXCEPTION_INVALID_HANDLE    = NTSTATUS(0xc0000008),
    EXCEPTION_POSSIBLE_DEADLOCK = NTSTATUS(0xc0000194),
}

enum NTSTATUS CONTROL_C_EXIT = NTSTATUS(0xc000013a);
enum HRESULT E_NOTIMPL = HRESULT(0x80004001);
enum HRESULT E_INVALIDARG = HRESULT(0x80070057);
enum uint STRICT = 0x00000001;
enum NTSTATUS IO_ERR_INSUFFICIENT_RESOURCES = NTSTATUS(0xc0040002);

enum : NTSTATUS
{
    IO_ERR_SEEK_ERROR       = NTSTATUS(0xc0040006),
    IO_ERR_BAD_BLOCK        = NTSTATUS(0xc0040007),
    IO_ERR_TIMEOUT          = NTSTATUS(0xc0040009),
    IO_ERR_CONTROLLER_ERROR = NTSTATUS(0xc004000b),
}

enum NTSTATUS IO_ERR_INVALID_REQUEST = NTSTATUS(0xc0040010);
enum NTSTATUS IO_ERR_BAD_FIRMWARE = NTSTATUS(0xc0040019);
enum NTSTATUS IO_WRITE_CACHE_ENABLED = NTSTATUS(0x80040020);
enum NTSTATUS IO_WRITE_CACHE_DISABLED = NTSTATUS(0x80040022);
enum NTSTATUS IO_WRN_FAILURE_PREDICTED = NTSTATUS(0x80040034);

enum : NTSTATUS
{
    IO_WARNING_DUPLICATE_SIGNATURE = NTSTATUS(0x8004003a),
    IO_WARNING_DUPLICATE_PATH      = NTSTATUS(0x8004003b),
    IO_WARNING_WRITE_FUA_PROBLEM   = NTSTATUS(0x80040084),
}

enum NTSTATUS IO_WARNING_DEVICE_HAS_INTERNAL_DUMP = NTSTATUS(0x8004008f);

enum : NTSTATUS
{
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX           = NTSTATUS(0x80040091),
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX_LUN_LUN   = NTSTATUS(0x80040092),
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX_LUN_POOL  = NTSTATUS(0x80040093),
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX_POOL_LUN  = NTSTATUS(0x80040094),
    IO_WARNING_SOFT_THRESHOLD_REACHED_EX_POOL_POOL = NTSTATUS(0x80040095),
}

enum : NTSTATUS
{
    IO_WARNING_DISK_CAPACITY_CHANGED          = NTSTATUS(0x80040097),
    IO_WARNING_DISK_PROVISIONING_TYPE_CHANGED = NTSTATUS(0x80040098),
}

enum NTSTATUS IO_ERROR_IO_HARDWARE_ERROR = NTSTATUS(0xc004009a);
enum NTSTATUS IO_WARNING_DISK_SURPRISE_REMOVED = NTSTATUS(0x8004009d);
enum NTSTATUS IO_WARNING_DISK_FIRMWARE_UPDATED = NTSTATUS(0x4004009f);
enum NTSTATUS IO_DUMP_CREATION_SUCCESS = NTSTATUS(0x000400a2);

enum : NTSTATUS
{
    IO_FILE_QUOTA_LIMIT     = NTSTATUS(0x40040025),
    IO_FILE_QUOTA_STARTED   = NTSTATUS(0x40040026),
    IO_FILE_QUOTA_SUCCEEDED = NTSTATUS(0x40040027),
}

enum NTSTATUS IO_CDROM_EXCLUSIVE_LOCK = NTSTATUS(0x40040085);
enum NTSTATUS IO_FILE_QUOTA_FAILED = NTSTATUS(0x80040028);
enum NTSTATUS IO_WARNING_INTERRUPT_STILL_PENDING = NTSTATUS(0x80040035);

enum : NTSTATUS
{
    IO_WARNING_LOG_FLUSH_FAILED = NTSTATUS(0x80040039),
    IO_WARNING_BUS_RESET        = NTSTATUS(0x80040076),
    IO_WARNING_RESET            = NTSTATUS(0x80040081),
}

enum : NTSTATUS
{
    IO_LOST_DELAYED_WRITE_NETWORK_SERVER_ERROR     = NTSTATUS(0x8004008c),
    IO_LOST_DELAYED_WRITE_NETWORK_LOCAL_DISK_ERROR = NTSTATUS(0x8004008d),
}

enum NTSTATUS IO_ERR_CONFIGURATION_ERROR = NTSTATUS(0xc0040003);
enum NTSTATUS IO_ERR_OVERRUN_ERROR = NTSTATUS(0xc0040008);

enum : NTSTATUS
{
    IO_ERR_INTERNAL_ERROR = NTSTATUS(0xc004000c),
    IO_ERR_INCORRECT_IRQL = NTSTATUS(0xc004000d),
    IO_ERR_INVALID_IOBASE = NTSTATUS(0xc004000e),
}

enum NTSTATUS IO_ERR_LAYERED_FAILURE = NTSTATUS(0xc0040012);
enum NTSTATUS IO_ERR_MEMORY_CONFLICT_DETECTED = NTSTATUS(0xc0040015);
enum NTSTATUS IO_ERR_DMA_CONFLICT_DETECTED = NTSTATUS(0xc0040017);
enum NTSTATUS IO_ERR_DMA_RESOURCE_CONFLICT = NTSTATUS(0xc004001b);
enum NTSTATUS IO_ERR_MEMORY_RESOURCE_CONFLICT = NTSTATUS(0xc004001d);
enum NTSTATUS IO_BAD_BLOCK_WITH_NAME = NTSTATUS(0xc004001f);
enum NTSTATUS IO_FILE_QUOTA_CORRUPT = NTSTATUS(0xc004002a);
enum NTSTATUS IO_DUMP_POINTER_FAILURE = NTSTATUS(0xc004002c);
enum NTSTATUS IO_DUMP_INITIALIZATION_FAILURE = NTSTATUS(0xc004002e);
enum NTSTATUS IO_DUMP_DIRECT_CONFIG_FAILED = NTSTATUS(0xc0040030);
enum NTSTATUS IO_FILE_SYSTEM_CORRUPT_WITH_NAME = NTSTATUS(0xc0040037);
enum NTSTATUS IO_ERR_PORT_TIMEOUT = NTSTATUS(0xc0040075);
enum NTSTATUS IO_DUMP_CALLBACK_EXCEPTION = NTSTATUS(0xc00400a3);
enum NTSTATUS MCA_INFO_CPU_THERMAL_THROTTLING_REMOVED = NTSTATUS(0x40050070);
enum NTSTATUS MCA_INFO_MEMORY_PAGE_MARKED_BAD = NTSTATUS(0x40050074);

enum : NTSTATUS
{
    MCA_WARNING_TLB                          = NTSTATUS(0x8005003e),
    MCA_WARNING_CPU_BUS                      = NTSTATUS(0x80050040),
    MCA_WARNING_REGISTER_FILE                = NTSTATUS(0x80050042),
    MCA_WARNING_MAS                          = NTSTATUS(0x80050044),
    MCA_WARNING_MEM_UNKNOWN                  = NTSTATUS(0x80050046),
    MCA_WARNING_MEM_1_2                      = NTSTATUS(0x80050048),
    MCA_WARNING_MEM_1_2_5                    = NTSTATUS(0x8005004a),
    MCA_WARNING_MEM_1_2_5_4                  = NTSTATUS(0x8005004c),
    MCA_WARNING_SYSTEM_EVENT                 = NTSTATUS(0x8005004e),
    MCA_WARNING_PCI_BUS_PARITY               = NTSTATUS(0x80050050),
    MCA_WARNING_PCI_BUS_PARITY_NO_INFO       = NTSTATUS(0x80050052),
    MCA_WARNING_PCI_BUS_SERR                 = NTSTATUS(0x80050054),
    MCA_WARNING_PCI_BUS_SERR_NO_INFO         = NTSTATUS(0x80050056),
    MCA_WARNING_PCI_BUS_MASTER_ABORT         = NTSTATUS(0x80050058),
    MCA_WARNING_PCI_BUS_MASTER_ABORT_NO_INFO = NTSTATUS(0x8005005a),
    MCA_WARNING_PCI_BUS_TIMEOUT              = NTSTATUS(0x8005005c),
    MCA_WARNING_PCI_BUS_TIMEOUT_NO_INFO      = NTSTATUS(0x8005005e),
    MCA_WARNING_PCI_BUS_UNKNOWN              = NTSTATUS(0x80050060),
    MCA_WARNING_PCI_DEVICE                   = NTSTATUS(0x80050062),
    MCA_WARNING_SMBIOS                       = NTSTATUS(0x80050064),
    MCA_WARNING_PLATFORM_SPECIFIC            = NTSTATUS(0x80050066),
    MCA_WARNING_UNKNOWN                      = NTSTATUS(0x80050068),
    MCA_WARNING_UNKNOWN_NO_CPU               = NTSTATUS(0x8005006a),
    MCA_WARNING_CMC_THRESHOLD_EXCEEDED       = NTSTATUS(0x8005006d),
}

enum : NTSTATUS
{
    MCA_WARNING_CPU_THERMAL_THROTTLED = NTSTATUS(0x8005006f),
    MCA_WARNING_CPU                   = NTSTATUS(0x80050071),
}

enum : NTSTATUS
{
    MCA_ERROR_TLB                          = NTSTATUS(0xc005003f),
    MCA_ERROR_CPU_BUS                      = NTSTATUS(0xc0050041),
    MCA_ERROR_REGISTER_FILE                = NTSTATUS(0xc0050043),
    MCA_ERROR_MAS                          = NTSTATUS(0xc0050045),
    MCA_ERROR_MEM_UNKNOWN                  = NTSTATUS(0xc0050047),
    MCA_ERROR_MEM_1_2                      = NTSTATUS(0xc0050049),
    MCA_ERROR_MEM_1_2_5                    = NTSTATUS(0xc005004b),
    MCA_ERROR_MEM_1_2_5_4                  = NTSTATUS(0xc005004d),
    MCA_ERROR_SYSTEM_EVENT                 = NTSTATUS(0xc005004f),
    MCA_ERROR_PCI_BUS_PARITY               = NTSTATUS(0xc0050051),
    MCA_ERROR_PCI_BUS_PARITY_NO_INFO       = NTSTATUS(0xc0050053),
    MCA_ERROR_PCI_BUS_SERR                 = NTSTATUS(0xc0050055),
    MCA_ERROR_PCI_BUS_SERR_NO_INFO         = NTSTATUS(0xc0050057),
    MCA_ERROR_PCI_BUS_MASTER_ABORT         = NTSTATUS(0xc0050059),
    MCA_ERROR_PCI_BUS_MASTER_ABORT_NO_INFO = NTSTATUS(0xc005005b),
    MCA_ERROR_PCI_BUS_TIMEOUT              = NTSTATUS(0xc005005d),
    MCA_ERROR_PCI_BUS_TIMEOUT_NO_INFO      = NTSTATUS(0xc005005f),
    MCA_ERROR_PCI_BUS_UNKNOWN              = NTSTATUS(0xc0050061),
    MCA_ERROR_PCI_DEVICE                   = NTSTATUS(0xc0050063),
    MCA_ERROR_SMBIOS                       = NTSTATUS(0xc0050065),
    MCA_ERROR_PLATFORM_SPECIFIC            = NTSTATUS(0xc0050067),
}

enum : NTSTATUS
{
    MCA_ERROR_UNKNOWN_NO_CPU = NTSTATUS(0xc005006b),
    MCA_ERROR_CPU            = NTSTATUS(0xc0050072),
}

enum NTSTATUS MCA_TLB_ERROR = NTSTATUS(0xc0050079);
enum NTSTATUS MCA_BUS_TIMEOUT_ERROR = NTSTATUS(0xc005007b);
enum NTSTATUS MCA_MICROCODE_ROM_PARITY_ERROR = NTSTATUS(0xc005007e);
enum NTSTATUS MCA_FRC_ERROR = NTSTATUS(0xc0050080);

enum : NTSTATUS
{
    VOLMGR_KSR_READ_ERROR = NTSTATUS(0x80380002),
    VOLMGR_KSR_BYPASS     = NTSTATUS(0x80380003),
}

enum uint FACILTIY_MUI_ERROR_CODE = 0x0000000b;

enum : NTSTATUS
{
    STATUS_WAIT_1            = NTSTATUS(0x00000001),
    STATUS_WAIT_2            = NTSTATUS(0x00000002),
    STATUS_WAIT_3            = NTSTATUS(0x00000003),
    STATUS_WAIT_63           = NTSTATUS(0x0000003f),
    STATUS_ABANDONED         = NTSTATUS(0x00000080),
    STATUS_ABANDONED_WAIT_0  = NTSTATUS(0x00000080),
    STATUS_ABANDONED_WAIT_63 = NTSTATUS(0x000000bf),
}

enum NTSTATUS STATUS_ALREADY_COMPLETE = NTSTATUS(0x000000ff);

enum : NTSTATUS
{
    STATUS_ALERTED      = NTSTATUS(0x00000101),
    STATUS_TIMEOUT      = NTSTATUS(0x00000102),
    STATUS_PENDING      = NTSTATUS(0x00000103),
    STATUS_REPARSE      = NTSTATUS(0x00000104),
    STATUS_MORE_ENTRIES = NTSTATUS(0x00000105),
}

enum NTSTATUS STATUS_SOME_NOT_MAPPED = NTSTATUS(0x00000107);
enum NTSTATUS STATUS_VOLUME_MOUNTED = NTSTATUS(0x00000109);

enum : NTSTATUS
{
    STATUS_NOTIFY_CLEANUP        = NTSTATUS(0x0000010b),
    STATUS_NOTIFY_ENUM_DIR       = NTSTATUS(0x0000010c),
    STATUS_NO_QUOTAS_FOR_ACCOUNT = NTSTATUS(0x0000010d),
}

enum : NTSTATUS
{
    STATUS_PAGE_FAULT_TRANSITION    = NTSTATUS(0x00000110),
    STATUS_PAGE_FAULT_DEMAND_ZERO   = NTSTATUS(0x00000111),
    STATUS_PAGE_FAULT_COPY_ON_WRITE = NTSTATUS(0x00000112),
    STATUS_PAGE_FAULT_GUARD_PAGE    = NTSTATUS(0x00000113),
    STATUS_PAGE_FAULT_PAGING_FILE   = NTSTATUS(0x00000114),
}

enum : NTSTATUS
{
    STATUS_CRASH_DUMP       = NTSTATUS(0x00000116),
    STATUS_BUFFER_ALL_ZEROS = NTSTATUS(0x00000117),
}

enum NTSTATUS STATUS_RESOURCE_REQUIREMENTS_CHANGED = NTSTATUS(0x00000119);
enum NTSTATUS STATUS_DS_MEMBERSHIP_EVALUATED_LOCALLY = NTSTATUS(0x00000121);

enum : NTSTATUS
{
    STATUS_PROCESS_NOT_IN_JOB = NTSTATUS(0x00000123),
    STATUS_PROCESS_IN_JOB     = NTSTATUS(0x00000124),
}

enum NTSTATUS STATUS_FSFILTER_OP_COMPLETED_SUCCESSFULLY = NTSTATUS(0x00000126);
enum NTSTATUS STATUS_INTERRUPT_STILL_CONNECTED = NTSTATUS(0x00000128);

enum : NTSTATUS
{
    STATUS_FILE_LOCKED_WITH_ONLY_READERS = NTSTATUS(0x0000012a),
    STATUS_FILE_LOCKED_WITH_WRITERS      = NTSTATUS(0x0000012b),
}

enum : NTSTATUS
{
    STATUS_VALID_CATALOG_HASH     = NTSTATUS(0x0000012d),
    STATUS_VALID_STRONG_CODE_HASH = NTSTATUS(0x0000012e),
}

enum NTSTATUS STATUS_DATA_OVERWRITTEN = NTSTATUS(0x00000130);

enum : NTSTATUS
{
    STATUS_RING_PREVIOUSLY_EMPTY       = NTSTATUS(0x00000210),
    STATUS_RING_PREVIOUSLY_FULL        = NTSTATUS(0x00000211),
    STATUS_RING_PREVIOUSLY_ABOVE_QUOTA = NTSTATUS(0x00000212),
}

enum NTSTATUS STATUS_RING_SIGNAL_OPPOSITE_ENDPOINT = NTSTATUS(0x00000214);
enum NTSTATUS STATUS_OPLOCK_HANDLE_CLOSED = NTSTATUS(0x00000216);
enum NTSTATUS STATUS_REPARSE_GLOBAL = NTSTATUS(0x00000368);
enum NTSTATUS DBG_EXCEPTION_HANDLED = NTSTATUS(0x00010001);
enum NTSTATUS STATUS_FLT_IO_COMPLETE = NTSTATUS(0x001c0001);
enum NTSTATUS STATUS_THREAD_WAS_SUSPENDED = NTSTATUS(0x40000001);
enum NTSTATUS STATUS_IMAGE_NOT_AT_BASE = NTSTATUS(0x40000003);
enum NTSTATUS STATUS_SEGMENT_NOTIFICATION = NTSTATUS(0x40000005);
enum NTSTATUS STATUS_BAD_CURRENT_DIRECTORY = NTSTATUS(0x40000007);
enum NTSTATUS STATUS_REGISTRY_RECOVERED = NTSTATUS(0x40000009);
enum NTSTATUS STATUS_FT_WRITE_RECOVERY = NTSTATUS(0x4000000b);
enum NTSTATUS STATUS_NULL_LM_PASSWORD = NTSTATUS(0x4000000d);

enum : NTSTATUS
{
    STATUS_RECEIVE_PARTIAL           = NTSTATUS(0x4000000f),
    STATUS_RECEIVE_EXPEDITED         = NTSTATUS(0x40000010),
    STATUS_RECEIVE_PARTIAL_EXPEDITED = NTSTATUS(0x40000011),
}

enum NTSTATUS STATUS_EVENT_PENDING = NTSTATUS(0x40000013);
enum NTSTATUS STATUS_FATAL_APP_EXIT = NTSTATUS(0x40000015);
enum NTSTATUS STATUS_WAS_UNLOCKED = NTSTATUS(0x40000017);

enum : NTSTATUS
{
    STATUS_WAS_LOCKED     = NTSTATUS(0x40000019),
    STATUS_LOG_HARD_ERROR = NTSTATUS(0x4000001a),
}

enum : NTSTATUS
{
    STATUS_WX86_UNSIMULATE           = NTSTATUS(0x4000001c),
    STATUS_WX86_CONTINUE             = NTSTATUS(0x4000001d),
    STATUS_WX86_SINGLE_STEP          = NTSTATUS(0x4000001e),
    STATUS_WX86_BREAKPOINT           = NTSTATUS(0x4000001f),
    STATUS_WX86_EXCEPTION_CONTINUE   = NTSTATUS(0x40000020),
    STATUS_WX86_EXCEPTION_LASTCHANCE = NTSTATUS(0x40000021),
    STATUS_WX86_EXCEPTION_CHAIN      = NTSTATUS(0x40000022),
}

enum NTSTATUS STATUS_NO_YIELD_PERFORMED = NTSTATUS(0x40000024);
enum NTSTATUS STATUS_ARBITRATION_UNHANDLED = NTSTATUS(0x40000026);
enum NTSTATUS STATUS_WX86_CREATEWX86TIB = NTSTATUS(0x40000028);

enum : NTSTATUS
{
    STATUS_HIBERNATED         = NTSTATUS(0x4000002a),
    STATUS_RESUME_HIBERNATION = NTSTATUS(0x4000002b),
}

enum NTSTATUS STATUS_DRIVERS_LEAKING_LOCKED_PAGES = NTSTATUS(0x4000002d);
enum NTSTATUS STATUS_SYSTEM_POWERSTATE_TRANSITION = NTSTATUS(0x4000002f);
enum NTSTATUS STATUS_SYSTEM_POWERSTATE_COMPLEX_TRANSITION = NTSTATUS(0x40000031);
enum NTSTATUS STATUS_ABANDON_HIBERFILE = NTSTATUS(0x40000033);
enum NTSTATUS STATUS_FT_READ_FROM_COPY = NTSTATUS(0x40000035);
enum NTSTATUS STATUS_PATCH_DEFERRED = NTSTATUS(0x40000037);

enum : NTSTATUS
{
    STATUS_EMULATION_SYSCALL         = NTSTATUS(0x40000039),
    STATUS_EMULATION_FLOAT_EXCEPTION = NTSTATUS(0x4000003a),
}

enum NTSTATUS DBG_UNABLE_TO_PROVIDE_HANDLE = NTSTATUS(0x40010002);
enum NTSTATUS DBG_TERMINATE_PROCESS = NTSTATUS(0x40010004);
enum NTSTATUS DBG_PRINTEXCEPTION_C = NTSTATUS(0x40010006);
enum NTSTATUS DBG_CONTROL_BREAK = NTSTATUS(0x40010008);
enum NTSTATUS DBG_PRINTEXCEPTION_WIDE_C = NTSTATUS(0x4001000a);
enum NTSTATUS STATUS_GUARD_PAGE_VIOLATION = NTSTATUS(0x80000001);

enum : NTSTATUS
{
    STATUS_BREAKPOINT  = NTSTATUS(0x80000003),
    STATUS_SINGLE_STEP = NTSTATUS(0x80000004),
}

enum NTSTATUS STATUS_NO_MORE_FILES = NTSTATUS(0x80000006);
enum NTSTATUS STATUS_HANDLES_CLOSED = NTSTATUS(0x8000000a);
enum NTSTATUS STATUS_GUID_SUBSTITUTION_MADE = NTSTATUS(0x8000000c);

enum : NTSTATUS
{
    STATUS_DEVICE_PAPER_EMPTY = NTSTATUS(0x8000000e),
    STATUS_DEVICE_POWERED_OFF = NTSTATUS(0x8000000f),
    STATUS_DEVICE_OFF_LINE    = NTSTATUS(0x80000010),
    STATUS_DEVICE_BUSY        = NTSTATUS(0x80000011),
}

enum NTSTATUS STATUS_INVALID_EA_NAME = NTSTATUS(0x80000013);
enum NTSTATUS STATUS_INVALID_EA_FLAG = NTSTATUS(0x80000015);
enum NTSTATUS STATUS_EXTRANEOUS_INFORMATION = NTSTATUS(0x80000017);
enum NTSTATUS STATUS_NO_MORE_ENTRIES = NTSTATUS(0x8000001a);
enum NTSTATUS STATUS_MEDIA_CHANGED = NTSTATUS(0x8000001c);
enum NTSTATUS STATUS_END_OF_MEDIA = NTSTATUS(0x8000001e);
enum NTSTATUS STATUS_MEDIA_CHECK = NTSTATUS(0x80000020);
enum NTSTATUS STATUS_NO_DATA_DETECTED = NTSTATUS(0x80000022);
enum NTSTATUS STATUS_SERVER_HAS_OPEN_HANDLES = NTSTATUS(0x80000024);

enum : NTSTATUS
{
    STATUS_LONGJUMP                    = NTSTATUS(0x80000026),
    STATUS_CLEANER_CARTRIDGE_INSTALLED = NTSTATUS(0x80000027),
}

enum NTSTATUS STATUS_UNWIND_CONSOLIDATE = NTSTATUS(0x80000029);

enum : NTSTATUS
{
    STATUS_DLL_MIGHT_BE_INSECURE     = NTSTATUS(0x8000002b),
    STATUS_DLL_MIGHT_BE_INCOMPATIBLE = NTSTATUS(0x8000002c),
}

enum NTSTATUS STATUS_CANNOT_GRANT_REQUESTED_OPLOCK = NTSTATUS(0x8000002e);

enum : NTSTATUS
{
    STATUS_DEVICE_SUPPORT_IN_PROGRESS  = NTSTATUS(0x80000030),
    STATUS_DEVICE_POWER_CYCLE_REQUIRED = NTSTATUS(0x80000031),
}

enum NTSTATUS STATUS_RETURN_ADDRESS_HIJACK_ATTEMPT = NTSTATUS(0x80000033);
enum NTSTATUS STATUS_PTE_CHANGE_NOT_COMPLETED = NTSTATUS(0x80000035);

enum : NTSTATUS
{
    STATUS_CLUSTER_NODE_ALREADY_UP         = NTSTATUS(0x80130001),
    STATUS_CLUSTER_NODE_ALREADY_DOWN       = NTSTATUS(0x80130002),
    STATUS_CLUSTER_NETWORK_ALREADY_ONLINE  = NTSTATUS(0x80130003),
    STATUS_CLUSTER_NETWORK_ALREADY_OFFLINE = NTSTATUS(0x80130004),
    STATUS_CLUSTER_NODE_ALREADY_MEMBER     = NTSTATUS(0x80130005),
}

enum NTSTATUS STATUS_GRAPHICS_LINK_CONFIGURATION_IN_PROGRESS = NTSTATUS(0x801e0000);
enum NTSTATUS STATUS_FVE_TRANSIENT_STATE = NTSTATUS(0x80210002);
enum NTSTATUS STATUS_UNSUCCESSFUL = NTSTATUS(0xc0000001);
enum NTSTATUS STATUS_INVALID_INFO_CLASS = NTSTATUS(0xc0000003);
enum NTSTATUS STATUS_ACCESS_VIOLATION = NTSTATUS(0xc0000005);
enum NTSTATUS STATUS_PAGEFILE_QUOTA = NTSTATUS(0xc0000007);

enum : NTSTATUS
{
    STATUS_BAD_INITIAL_STACK = NTSTATUS(0xc0000009),
    STATUS_BAD_INITIAL_PC    = NTSTATUS(0xc000000a),
}

enum NTSTATUS STATUS_TIMER_NOT_CANCELED = NTSTATUS(0xc000000c);

enum : NTSTATUS
{
    STATUS_NO_SUCH_DEVICE = NTSTATUS(0xc000000e),
    STATUS_NO_SUCH_FILE   = NTSTATUS(0xc000000f),
}

enum NTSTATUS STATUS_END_OF_FILE = NTSTATUS(0xc0000011);
enum NTSTATUS STATUS_NO_MEDIA_IN_DEVICE = NTSTATUS(0xc0000013);
enum NTSTATUS STATUS_NONEXISTENT_SECTOR = NTSTATUS(0xc0000015);

enum : NTSTATUS
{
    STATUS_NO_MEMORY             = NTSTATUS(0xc0000017),
    STATUS_CONFLICTING_ADDRESSES = NTSTATUS(0xc0000018),
}

enum : NTSTATUS
{
    STATUS_UNABLE_TO_FREE_VM        = NTSTATUS(0xc000001a),
    STATUS_UNABLE_TO_DELETE_SECTION = NTSTATUS(0xc000001b),
}

enum NTSTATUS STATUS_ILLEGAL_INSTRUCTION = NTSTATUS(0xc000001d);

enum : NTSTATUS
{
    STATUS_INVALID_VIEW_SIZE        = NTSTATUS(0xc000001f),
    STATUS_INVALID_FILE_FOR_SECTION = NTSTATUS(0xc0000020),
}

enum NTSTATUS STATUS_BUFFER_TOO_SMALL = NTSTATUS(0xc0000023);
enum NTSTATUS STATUS_NONCONTINUABLE_EXCEPTION = NTSTATUS(0xc0000025);

enum : NTSTATUS
{
    STATUS_UNWIND                = NTSTATUS(0xc0000027),
    STATUS_BAD_STACK             = NTSTATUS(0xc0000028),
    STATUS_INVALID_UNWIND_TARGET = NTSTATUS(0xc0000029),
}

enum NTSTATUS STATUS_PARITY_ERROR = NTSTATUS(0xc000002b);
enum NTSTATUS STATUS_NOT_COMMITTED = NTSTATUS(0xc000002d);
enum NTSTATUS STATUS_PORT_MESSAGE_TOO_LONG = NTSTATUS(0xc000002f);
enum NTSTATUS STATUS_INVALID_QUOTA_LOWER = NTSTATUS(0xc0000031);

enum : NTSTATUS
{
    STATUS_OBJECT_NAME_INVALID   = NTSTATUS(0xc0000033),
    STATUS_OBJECT_NAME_NOT_FOUND = NTSTATUS(0xc0000034),
    STATUS_OBJECT_NAME_COLLISION = NTSTATUS(0xc0000035),
}

enum NTSTATUS STATUS_PORT_DISCONNECTED = NTSTATUS(0xc0000037);

enum : NTSTATUS
{
    STATUS_OBJECT_PATH_INVALID    = NTSTATUS(0xc0000039),
    STATUS_OBJECT_PATH_NOT_FOUND  = NTSTATUS(0xc000003a),
    STATUS_OBJECT_PATH_SYNTAX_BAD = NTSTATUS(0xc000003b),
}

enum : NTSTATUS
{
    STATUS_DATA_LATE_ERROR = NTSTATUS(0xc000003d),
    STATUS_DATA_ERROR      = NTSTATUS(0xc000003e),
    STATUS_CRC_ERROR       = NTSTATUS(0xc000003f),
    STATUS_SECTION_TOO_BIG = NTSTATUS(0xc0000040),
}

enum NTSTATUS STATUS_INVALID_PORT_HANDLE = NTSTATUS(0xc0000042);
enum NTSTATUS STATUS_QUOTA_EXCEEDED = NTSTATUS(0xc0000044);
enum NTSTATUS STATUS_MUTANT_NOT_OWNED = NTSTATUS(0xc0000046);
enum NTSTATUS STATUS_PORT_ALREADY_SET = NTSTATUS(0xc0000048);
enum NTSTATUS STATUS_SUSPEND_COUNT_EXCEEDED = NTSTATUS(0xc000004a);
enum NTSTATUS STATUS_BAD_WORKING_SET_LIMIT = NTSTATUS(0xc000004c);
enum NTSTATUS STATUS_SECTION_PROTECTION = NTSTATUS(0xc000004e);
enum NTSTATUS STATUS_EA_TOO_LARGE = NTSTATUS(0xc0000050);
enum NTSTATUS STATUS_NO_EAS_ON_FILE = NTSTATUS(0xc0000052);
enum NTSTATUS STATUS_FILE_LOCK_CONFLICT = NTSTATUS(0xc0000054);
enum NTSTATUS STATUS_DELETE_PENDING = NTSTATUS(0xc0000056);
enum NTSTATUS STATUS_UNKNOWN_REVISION = NTSTATUS(0xc0000058);

enum : NTSTATUS
{
    STATUS_INVALID_OWNER         = NTSTATUS(0xc000005a),
    STATUS_INVALID_PRIMARY_GROUP = NTSTATUS(0xc000005b),
}

enum NTSTATUS STATUS_CANT_DISABLE_MANDATORY = NTSTATUS(0xc000005d);
enum NTSTATUS STATUS_NO_SUCH_PRIVILEGE = NTSTATUS(0xc0000060);
enum NTSTATUS STATUS_INVALID_ACCOUNT_NAME = NTSTATUS(0xc0000062);
enum NTSTATUS STATUS_GROUP_EXISTS = NTSTATUS(0xc0000065);

enum : NTSTATUS
{
    STATUS_MEMBER_IN_GROUP     = NTSTATUS(0xc0000067),
    STATUS_MEMBER_NOT_IN_GROUP = NTSTATUS(0xc0000068),
}

enum NTSTATUS STATUS_ILL_FORMED_PASSWORD = NTSTATUS(0xc000006b);

enum : NTSTATUS
{
    STATUS_INVALID_LOGON_HOURS = NTSTATUS(0xc000006f),
    STATUS_INVALID_WORKSTATION = NTSTATUS(0xc0000070),
}

enum NTSTATUS STATUS_TOO_MANY_LUIDS_REQUESTED = NTSTATUS(0xc0000074);

enum : NTSTATUS
{
    STATUS_INVALID_SUB_AUTHORITY  = NTSTATUS(0xc0000076),
    STATUS_INVALID_ACL            = NTSTATUS(0xc0000077),
    STATUS_INVALID_SID            = NTSTATUS(0xc0000078),
    STATUS_INVALID_SECURITY_DESCR = NTSTATUS(0xc0000079),
}

enum NTSTATUS STATUS_INVALID_IMAGE_FORMAT = NTSTATUS(0xc000007b);
enum NTSTATUS STATUS_BAD_INHERITANCE_ACL = NTSTATUS(0xc000007d);

enum : NTSTATUS
{
    STATUS_DISK_FULL           = NTSTATUS(0xc000007f),
    STATUS_SERVER_DISABLED     = NTSTATUS(0xc0000080),
    STATUS_SERVER_NOT_DISABLED = NTSTATUS(0xc0000081),
}

enum NTSTATUS STATUS_GUIDS_EXHAUSTED = NTSTATUS(0xc0000083);
enum NTSTATUS STATUS_AGENTS_EXHAUSTED = NTSTATUS(0xc0000085);
enum NTSTATUS STATUS_SECTION_NOT_EXTENDED = NTSTATUS(0xc0000087);

enum : NTSTATUS
{
    STATUS_RESOURCE_DATA_NOT_FOUND = NTSTATUS(0xc0000089),
    STATUS_RESOURCE_TYPE_NOT_FOUND = NTSTATUS(0xc000008a),
    STATUS_RESOURCE_NAME_NOT_FOUND = NTSTATUS(0xc000008b),
}

enum : NTSTATUS
{
    STATUS_FLOAT_DENORMAL_OPERAND  = NTSTATUS(0xc000008d),
    STATUS_FLOAT_DIVIDE_BY_ZERO    = NTSTATUS(0xc000008e),
    STATUS_FLOAT_INEXACT_RESULT    = NTSTATUS(0xc000008f),
    STATUS_FLOAT_INVALID_OPERATION = NTSTATUS(0xc0000090),
    STATUS_FLOAT_OVERFLOW          = NTSTATUS(0xc0000091),
    STATUS_FLOAT_STACK_CHECK       = NTSTATUS(0xc0000092),
    STATUS_FLOAT_UNDERFLOW         = NTSTATUS(0xc0000093),
}

enum NTSTATUS STATUS_INTEGER_OVERFLOW = NTSTATUS(0xc0000095);
enum NTSTATUS STATUS_TOO_MANY_PAGING_FILES = NTSTATUS(0xc0000097);
enum NTSTATUS STATUS_ALLOTTED_SPACE_EXCEEDED = NTSTATUS(0xc0000099);
enum NTSTATUS STATUS_DFS_EXIT_PATH_FOUND = NTSTATUS(0xc000009b);

enum : NTSTATUS
{
    STATUS_DEVICE_NOT_CONNECTED = NTSTATUS(0xc000009d),
    STATUS_DEVICE_POWER_FAILURE = NTSTATUS(0xc000009e),
}

enum NTSTATUS STATUS_MEMORY_NOT_ALLOCATED = NTSTATUS(0xc00000a0);
enum NTSTATUS STATUS_MEDIA_WRITE_PROTECTED = NTSTATUS(0xc00000a2);
enum NTSTATUS STATUS_INVALID_GROUP_ATTRIBUTES = NTSTATUS(0xc00000a4);
enum NTSTATUS STATUS_CANT_OPEN_ANONYMOUS = NTSTATUS(0xc00000a6);

enum : NTSTATUS
{
    STATUS_BAD_TOKEN_TYPE         = NTSTATUS(0xc00000a8),
    STATUS_BAD_MASTER_BOOT_RECORD = NTSTATUS(0xc00000a9),
}

enum NTSTATUS STATUS_INSTANCE_NOT_AVAILABLE = NTSTATUS(0xc00000ab);
enum NTSTATUS STATUS_INVALID_PIPE_STATE = NTSTATUS(0xc00000ad);
enum NTSTATUS STATUS_ILLEGAL_FUNCTION = NTSTATUS(0xc00000af);

enum : NTSTATUS
{
    STATUS_PIPE_CLOSING   = NTSTATUS(0xc00000b1),
    STATUS_PIPE_CONNECTED = NTSTATUS(0xc00000b2),
    STATUS_PIPE_LISTENING = NTSTATUS(0xc00000b3),
}

enum : NTSTATUS
{
    STATUS_IO_TIMEOUT         = NTSTATUS(0xc00000b5),
    STATUS_FILE_FORCED_CLOSED = NTSTATUS(0xc00000b6),
}

enum NTSTATUS STATUS_PROFILING_NOT_STOPPED = NTSTATUS(0xc00000b8);
enum NTSTATUS STATUS_FILE_IS_A_DIRECTORY = NTSTATUS(0xc00000ba);
enum NTSTATUS STATUS_REMOTE_NOT_LISTENING = NTSTATUS(0xc00000bc);
enum NTSTATUS STATUS_BAD_NETWORK_PATH = NTSTATUS(0xc00000be);
enum NTSTATUS STATUS_DEVICE_DOES_NOT_EXIST = NTSTATUS(0xc00000c0);
enum NTSTATUS STATUS_ADAPTER_HARDWARE_ERROR = NTSTATUS(0xc00000c2);
enum NTSTATUS STATUS_UNEXPECTED_NETWORK_ERROR = NTSTATUS(0xc00000c4);
enum NTSTATUS STATUS_PRINT_QUEUE_FULL = NTSTATUS(0xc00000c6);
enum NTSTATUS STATUS_PRINT_CANCELLED = NTSTATUS(0xc00000c8);
enum NTSTATUS STATUS_NETWORK_ACCESS_DENIED = NTSTATUS(0xc00000ca);
enum NTSTATUS STATUS_BAD_NETWORK_NAME = NTSTATUS(0xc00000cc);
enum NTSTATUS STATUS_TOO_MANY_SESSIONS = NTSTATUS(0xc00000ce);
enum NTSTATUS STATUS_REQUEST_NOT_ACCEPTED = NTSTATUS(0xc00000d0);
enum NTSTATUS STATUS_NET_WRITE_FAULT = NTSTATUS(0xc00000d2);
enum NTSTATUS STATUS_NOT_SAME_DEVICE = NTSTATUS(0xc00000d4);
enum NTSTATUS STATUS_VIRTUAL_CIRCUIT_CLOSED = NTSTATUS(0xc00000d6);

enum : NTSTATUS
{
    STATUS_CANT_WAIT               = NTSTATUS(0xc00000d8),
    STATUS_PIPE_EMPTY              = NTSTATUS(0xc00000d9),
    STATUS_CANT_ACCESS_DOMAIN_INFO = NTSTATUS(0xc00000da),
}

enum : NTSTATUS
{
    STATUS_INVALID_SERVER_STATE = NTSTATUS(0xc00000dc),
    STATUS_INVALID_DOMAIN_STATE = NTSTATUS(0xc00000dd),
    STATUS_INVALID_DOMAIN_ROLE  = NTSTATUS(0xc00000de),
}

enum : NTSTATUS
{
    STATUS_DOMAIN_EXISTS         = NTSTATUS(0xc00000e0),
    STATUS_DOMAIN_LIMIT_EXCEEDED = NTSTATUS(0xc00000e1),
}

enum NTSTATUS STATUS_INVALID_OPLOCK_PROTOCOL = NTSTATUS(0xc00000e3);
enum NTSTATUS STATUS_INTERNAL_ERROR = NTSTATUS(0xc00000e5);
enum NTSTATUS STATUS_BAD_DESCRIPTOR_FORMAT = NTSTATUS(0xc00000e7);

enum : NTSTATUS
{
    STATUS_UNEXPECTED_IO_ERROR      = NTSTATUS(0xc00000e9),
    STATUS_UNEXPECTED_MM_CREATE_ERR = NTSTATUS(0xc00000ea),
    STATUS_UNEXPECTED_MM_MAP_ERROR  = NTSTATUS(0xc00000eb),
    STATUS_UNEXPECTED_MM_EXTEND_ERR = NTSTATUS(0xc00000ec),
}

enum NTSTATUS STATUS_LOGON_SESSION_EXISTS = NTSTATUS(0xc00000ee);

enum : NTSTATUS
{
    STATUS_INVALID_PARAMETER_2  = NTSTATUS(0xc00000f0),
    STATUS_INVALID_PARAMETER_3  = NTSTATUS(0xc00000f1),
    STATUS_INVALID_PARAMETER_4  = NTSTATUS(0xc00000f2),
    STATUS_INVALID_PARAMETER_5  = NTSTATUS(0xc00000f3),
    STATUS_INVALID_PARAMETER_6  = NTSTATUS(0xc00000f4),
    STATUS_INVALID_PARAMETER_7  = NTSTATUS(0xc00000f5),
    STATUS_INVALID_PARAMETER_8  = NTSTATUS(0xc00000f6),
    STATUS_INVALID_PARAMETER_9  = NTSTATUS(0xc00000f7),
    STATUS_INVALID_PARAMETER_10 = NTSTATUS(0xc00000f8),
    STATUS_INVALID_PARAMETER_11 = NTSTATUS(0xc00000f9),
    STATUS_INVALID_PARAMETER_12 = NTSTATUS(0xc00000fa),
}

enum NTSTATUS STATUS_REDIRECTOR_STARTED = NTSTATUS(0xc00000fc);
enum NTSTATUS STATUS_NO_SUCH_PACKAGE = NTSTATUS(0xc00000fe);
enum NTSTATUS STATUS_VARIABLE_NOT_FOUND = NTSTATUS(0xc0000100);
enum NTSTATUS STATUS_FILE_CORRUPT_ERROR = NTSTATUS(0xc0000102);
enum NTSTATUS STATUS_BAD_LOGON_SESSION_STATE = NTSTATUS(0xc0000104);
enum NTSTATUS STATUS_NAME_TOO_LONG = NTSTATUS(0xc0000106);
enum NTSTATUS STATUS_CONNECTION_IN_USE = NTSTATUS(0xc0000108);
enum NTSTATUS STATUS_PROCESS_IS_TERMINATING = NTSTATUS(0xc000010a);
enum NTSTATUS STATUS_NO_GUID_TRANSLATION = NTSTATUS(0xc000010c);
enum NTSTATUS STATUS_IMAGE_ALREADY_LOADED = NTSTATUS(0xc000010e);

enum : NTSTATUS
{
    STATUS_ABIOS_LID_NOT_EXIST          = NTSTATUS(0xc0000110),
    STATUS_ABIOS_LID_ALREADY_OWNED      = NTSTATUS(0xc0000111),
    STATUS_ABIOS_NOT_LID_OWNER          = NTSTATUS(0xc0000112),
    STATUS_ABIOS_INVALID_COMMAND        = NTSTATUS(0xc0000113),
    STATUS_ABIOS_INVALID_LID            = NTSTATUS(0xc0000114),
    STATUS_ABIOS_SELECTOR_NOT_AVAILABLE = NTSTATUS(0xc0000115),
}

enum : NTSTATUS
{
    STATUS_NO_LDT                  = NTSTATUS(0xc0000117),
    STATUS_INVALID_LDT_SIZE        = NTSTATUS(0xc0000118),
    STATUS_INVALID_LDT_OFFSET      = NTSTATUS(0xc0000119),
    STATUS_INVALID_LDT_DESCRIPTOR  = NTSTATUS(0xc000011a),
    STATUS_INVALID_IMAGE_NE_FORMAT = NTSTATUS(0xc000011b),
}

enum NTSTATUS STATUS_RXACT_COMMIT_FAILURE = NTSTATUS(0xc000011d);
enum NTSTATUS STATUS_TOO_MANY_OPENED_FILES = NTSTATUS(0xc000011f);
enum NTSTATUS STATUS_CANNOT_DELETE = NTSTATUS(0xc0000121);
enum NTSTATUS STATUS_FILE_DELETED = NTSTATUS(0xc0000123);

enum : NTSTATUS
{
    STATUS_SPECIAL_GROUP = NTSTATUS(0xc0000125),
    STATUS_SPECIAL_USER  = NTSTATUS(0xc0000126),
}

enum NTSTATUS STATUS_FILE_CLOSED = NTSTATUS(0xc0000128);
enum NTSTATUS STATUS_THREAD_NOT_IN_PROCESS = NTSTATUS(0xc000012a);
enum NTSTATUS STATUS_PAGEFILE_QUOTA_EXCEEDED = NTSTATUS(0xc000012c);

enum : NTSTATUS
{
    STATUS_INVALID_IMAGE_LE_FORMAT = NTSTATUS(0xc000012e),
    STATUS_INVALID_IMAGE_NOT_MZ    = NTSTATUS(0xc000012f),
    STATUS_INVALID_IMAGE_PROTECT   = NTSTATUS(0xc0000130),
    STATUS_INVALID_IMAGE_WIN_16    = NTSTATUS(0xc0000131),
}

enum NTSTATUS STATUS_TIME_DIFFERENCE_AT_DC = NTSTATUS(0xc0000133);
enum NTSTATUS STATUS_DLL_NOT_FOUND = NTSTATUS(0xc0000135);
enum NTSTATUS STATUS_IO_PRIVILEGE_FAILED = NTSTATUS(0xc0000137);
enum NTSTATUS STATUS_ENTRYPOINT_NOT_FOUND = NTSTATUS(0xc0000139);
enum NTSTATUS STATUS_LOCAL_DISCONNECT = NTSTATUS(0xc000013b);
enum NTSTATUS STATUS_REMOTE_RESOURCES = NTSTATUS(0xc000013d);
enum NTSTATUS STATUS_LINK_TIMEOUT = NTSTATUS(0xc000013f);
enum NTSTATUS STATUS_INVALID_ADDRESS = NTSTATUS(0xc0000141);
enum NTSTATUS STATUS_MISSING_SYSTEMFILE = NTSTATUS(0xc0000143);
enum NTSTATUS STATUS_APP_INIT_FAILURE = NTSTATUS(0xc0000145);
enum NTSTATUS STATUS_NO_PAGEFILE = NTSTATUS(0xc0000147);
enum NTSTATUS STATUS_WRONG_PASSWORD_CORE = NTSTATUS(0xc0000149);
enum NTSTATUS STATUS_PIPE_BROKEN = NTSTATUS(0xc000014b);
enum NTSTATUS STATUS_REGISTRY_IO_FAILED = NTSTATUS(0xc000014d);
enum NTSTATUS STATUS_UNRECOGNIZED_VOLUME = NTSTATUS(0xc000014f);
enum NTSTATUS STATUS_NO_SUCH_ALIAS = NTSTATUS(0xc0000151);
enum NTSTATUS STATUS_MEMBER_IN_ALIAS = NTSTATUS(0xc0000153);
enum NTSTATUS STATUS_LOGON_NOT_GRANTED = NTSTATUS(0xc0000155);
enum NTSTATUS STATUS_SECRET_TOO_LONG = NTSTATUS(0xc0000157);
enum NTSTATUS STATUS_FULLSCREEN_MODE = NTSTATUS(0xc0000159);
enum NTSTATUS STATUS_NOT_REGISTRY_FILE = NTSTATUS(0xc000015c);
enum NTSTATUS STATUS_DOMAIN_CTRLR_CONFIG_ERROR = NTSTATUS(0xc000015e);
enum NTSTATUS STATUS_ILL_FORMED_SERVICE_ENTRY = NTSTATUS(0xc0000160);
enum NTSTATUS STATUS_UNMAPPABLE_CHARACTER = NTSTATUS(0xc0000162);

enum : NTSTATUS
{
    STATUS_FLOPPY_VOLUME            = NTSTATUS(0xc0000164),
    STATUS_FLOPPY_ID_MARK_NOT_FOUND = NTSTATUS(0xc0000165),
    STATUS_FLOPPY_WRONG_CYLINDER    = NTSTATUS(0xc0000166),
    STATUS_FLOPPY_UNKNOWN_ERROR     = NTSTATUS(0xc0000167),
    STATUS_FLOPPY_BAD_REGISTERS     = NTSTATUS(0xc0000168),
}

enum : NTSTATUS
{
    STATUS_DISK_OPERATION_FAILED = NTSTATUS(0xc000016a),
    STATUS_DISK_RESET_FAILED     = NTSTATUS(0xc000016b),
}

enum NTSTATUS STATUS_FT_ORPHANING = NTSTATUS(0xc000016d);
enum NTSTATUS STATUS_PARTITION_FAILURE = NTSTATUS(0xc0000172);
enum NTSTATUS STATUS_DEVICE_NOT_PARTITIONED = NTSTATUS(0xc0000174);
enum NTSTATUS STATUS_UNABLE_TO_UNLOAD_MEDIA = NTSTATUS(0xc0000176);

enum : NTSTATUS
{
    STATUS_NO_MEDIA       = NTSTATUS(0xc0000178),
    STATUS_NO_SUCH_MEMBER = NTSTATUS(0xc000017a),
}

enum NTSTATUS STATUS_KEY_DELETED = NTSTATUS(0xc000017c);
enum NTSTATUS STATUS_TOO_MANY_SIDS = NTSTATUS(0xc000017e);
enum NTSTATUS STATUS_KEY_HAS_CHILDREN = NTSTATUS(0xc0000180);
enum NTSTATUS STATUS_DEVICE_CONFIGURATION_ERROR = NTSTATUS(0xc0000182);
enum NTSTATUS STATUS_INVALID_DEVICE_STATE = NTSTATUS(0xc0000184);
enum NTSTATUS STATUS_DEVICE_PROTOCOL_ERROR = NTSTATUS(0xc0000186);
enum NTSTATUS STATUS_LOG_FILE_FULL = NTSTATUS(0xc0000188);

enum : NTSTATUS
{
    STATUS_NO_TRUST_LSA_SECRET  = NTSTATUS(0xc000018a),
    STATUS_NO_TRUST_SAM_ACCOUNT = NTSTATUS(0xc000018b),
}

enum NTSTATUS STATUS_TRUSTED_RELATIONSHIP_FAILURE = NTSTATUS(0xc000018d);
enum NTSTATUS STATUS_EVENTLOG_CANT_START = NTSTATUS(0xc000018f);
enum NTSTATUS STATUS_MUTANT_LIMIT_EXCEEDED = NTSTATUS(0xc0000191);
enum NTSTATUS STATUS_POSSIBLE_DEADLOCK = NTSTATUS(0xc0000194);
enum NTSTATUS STATUS_REMOTE_SESSION_LIMIT = NTSTATUS(0xc0000196);
enum NTSTATUS STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT = NTSTATUS(0xc0000198);
enum NTSTATUS STATUS_NOLOGON_SERVER_TRUST_ACCOUNT = NTSTATUS(0xc000019a);
enum NTSTATUS STATUS_FS_DRIVER_REQUIRED = NTSTATUS(0xc000019c);
enum NTSTATUS STATUS_INCOMPATIBLE_WITH_GLOBAL_SHORT_NAME_REGISTRY_SETTING = NTSTATUS(0xc000019e);
enum NTSTATUS STATUS_SECURITY_STREAM_IS_INCONSISTENT = NTSTATUS(0xc00001a0);
enum NTSTATUS STATUS_INVALID_ACE_CONDITION = NTSTATUS(0xc00001a2);
enum NTSTATUS STATUS_NOTIFICATION_GUID_ALREADY_DEFINED = NTSTATUS(0xc00001a4);
enum NTSTATUS STATUS_DUPLICATE_PRIVILEGES = NTSTATUS(0xc00001a6);
enum NTSTATUS STATUS_REPAIR_NEEDED = NTSTATUS(0xc00001a8);
enum NTSTATUS STATUS_NO_APPLICATION_PACKAGE = NTSTATUS(0xc00001aa);
enum NTSTATUS STATUS_NOT_SAME_OBJECT = NTSTATUS(0xc00001ac);
enum NTSTATUS STATUS_ERROR_PROCESS_NOT_IN_JOB = NTSTATUS(0xc00001ae);
enum NTSTATUS STATUS_IO_DEVICE_INVALID_DATA = NTSTATUS(0xc00001b0);
enum NTSTATUS STATUS_CONTROL_STACK_VIOLATION = NTSTATUS(0xc00001b2);
enum NTSTATUS STATUS_SERVER_TRANSPORT_CONFLICT = NTSTATUS(0xc00001b4);
enum NTSTATUS STATUS_DEVICE_RESET_REQUIRED = NTSTATUS(0x800001b6);
enum NTSTATUS STATUS_NO_USER_SESSION_KEY = NTSTATUS(0xc0000202);
enum NTSTATUS STATUS_RESOURCE_LANG_NOT_FOUND = NTSTATUS(0xc0000204);

enum : NTSTATUS
{
    STATUS_INVALID_BUFFER_SIZE       = NTSTATUS(0xc0000206),
    STATUS_INVALID_ADDRESS_COMPONENT = NTSTATUS(0xc0000207),
    STATUS_INVALID_ADDRESS_WILDCARD  = NTSTATUS(0xc0000208),
}

enum : NTSTATUS
{
    STATUS_ADDRESS_ALREADY_EXISTS = NTSTATUS(0xc000020a),
    STATUS_ADDRESS_CLOSED         = NTSTATUS(0xc000020b),
}

enum NTSTATUS STATUS_CONNECTION_RESET = NTSTATUS(0xc000020d);

enum : NTSTATUS
{
    STATUS_TRANSACTION_ABORTED      = NTSTATUS(0xc000020f),
    STATUS_TRANSACTION_TIMED_OUT    = NTSTATUS(0xc0000210),
    STATUS_TRANSACTION_NO_RELEASE   = NTSTATUS(0xc0000211),
    STATUS_TRANSACTION_NO_MATCH     = NTSTATUS(0xc0000212),
    STATUS_TRANSACTION_RESPONDED    = NTSTATUS(0xc0000213),
    STATUS_TRANSACTION_INVALID_ID   = NTSTATUS(0xc0000214),
    STATUS_TRANSACTION_INVALID_TYPE = NTSTATUS(0xc0000215),
}

enum NTSTATUS STATUS_NOT_CLIENT_SESSION = NTSTATUS(0xc0000217);
enum NTSTATUS STATUS_DEBUG_ATTACH_FAILED = NTSTATUS(0xc0000219);
enum NTSTATUS STATUS_DATA_NOT_ACCEPTED = NTSTATUS(0xc000021b);
enum NTSTATUS STATUS_VDM_HARD_ERROR = NTSTATUS(0xc000021d);
enum NTSTATUS STATUS_REPLY_MESSAGE_MISMATCH = NTSTATUS(0xc000021f);
enum NTSTATUS STATUS_IMAGE_CHECKSUM_MISMATCH = NTSTATUS(0xc0000221);
enum NTSTATUS STATUS_CLIENT_SERVER_PARAMETERS_INVALID = NTSTATUS(0xc0000223);
enum NTSTATUS STATUS_NOT_TINY_STREAM = NTSTATUS(0xc0000226);
enum NTSTATUS STATUS_STACK_OVERFLOW_READ = NTSTATUS(0xc0000228);
enum NTSTATUS STATUS_DUPLICATE_OBJECTID = NTSTATUS(0xc000022a);
enum NTSTATUS STATUS_CONVERT_TO_LARGE = NTSTATUS(0xc000022c);
enum NTSTATUS STATUS_FOUND_OUT_OF_SCOPE = NTSTATUS(0xc000022e);
enum NTSTATUS STATUS_PROPSET_NOT_FOUND = NTSTATUS(0xc0000230);
enum NTSTATUS STATUS_INVALID_VARIANT = NTSTATUS(0xc0000232);
enum NTSTATUS STATUS_HANDLE_NOT_CLOSABLE = NTSTATUS(0xc0000235);
enum NTSTATUS STATUS_GRACEFUL_DISCONNECT = NTSTATUS(0xc0000237);
enum NTSTATUS STATUS_ADDRESS_NOT_ASSOCIATED = NTSTATUS(0xc0000239);
enum NTSTATUS STATUS_CONNECTION_ACTIVE = NTSTATUS(0xc000023b);
enum NTSTATUS STATUS_HOST_UNREACHABLE = NTSTATUS(0xc000023d);
enum NTSTATUS STATUS_PORT_UNREACHABLE = NTSTATUS(0xc000023f);
enum NTSTATUS STATUS_CONNECTION_ABORTED = NTSTATUS(0xc0000241);
enum NTSTATUS STATUS_USER_MAPPED_FILE = NTSTATUS(0xc0000243);
enum NTSTATUS STATUS_TIMER_RESOLUTION_NOT_SET = NTSTATUS(0xc0000245);

enum : NTSTATUS
{
    STATUS_LOGIN_TIME_RESTRICTION  = NTSTATUS(0xc0000247),
    STATUS_LOGIN_WKSTA_RESTRICTION = NTSTATUS(0xc0000248),
}

enum NTSTATUS STATUS_INSUFFICIENT_LOGON_INFO = NTSTATUS(0xc0000250);
enum NTSTATUS STATUS_BAD_SERVICE_ENTRYPOINT = NTSTATUS(0xc0000252);

enum : NTSTATUS
{
    STATUS_IP_ADDRESS_CONFLICT1 = NTSTATUS(0xc0000254),
    STATUS_IP_ADDRESS_CONFLICT2 = NTSTATUS(0xc0000255),
}

enum NTSTATUS STATUS_PATH_NOT_COVERED = NTSTATUS(0xc0000257);
enum NTSTATUS STATUS_LICENSE_QUOTA_EXCEEDED = NTSTATUS(0xc0000259);

enum : NTSTATUS
{
    STATUS_PWD_TOO_RECENT       = NTSTATUS(0xc000025b),
    STATUS_PWD_HISTORY_CONFLICT = NTSTATUS(0xc000025c),
}

enum NTSTATUS STATUS_UNSUPPORTED_COMPRESSION = NTSTATUS(0xc000025f);
enum NTSTATUS STATUS_INVALID_PLUGPLAY_DEVICE_PATH = NTSTATUS(0xc0000261);
enum NTSTATUS STATUS_DRIVER_ENTRYPOINT_NOT_FOUND = NTSTATUS(0xc0000263);
enum NTSTATUS STATUS_TOO_MANY_LINKS = NTSTATUS(0xc0000265);
enum NTSTATUS STATUS_FILE_IS_OFFLINE = NTSTATUS(0xc0000267);
enum NTSTATUS STATUS_ILLEGAL_DLL_RELOCATION = NTSTATUS(0xc0000269);
enum NTSTATUS STATUS_DLL_INIT_FAILED_LOGOFF = NTSTATUS(0xc000026b);
enum NTSTATUS STATUS_DFS_UNAVAILABLE = NTSTATUS(0xc000026d);

enum : NTSTATUS
{
    STATUS_WX86_INTERNAL_ERROR    = NTSTATUS(0xc000026f),
    STATUS_WX86_FLOAT_STACK_CHECK = NTSTATUS(0xc0000270),
}

enum : NTSTATUS
{
    STATUS_NO_MATCH            = NTSTATUS(0xc0000272),
    STATUS_NO_MORE_MATCHES     = NTSTATUS(0xc0000273),
    STATUS_NOT_A_REPARSE_POINT = NTSTATUS(0xc0000275),
}

enum : NTSTATUS
{
    STATUS_IO_REPARSE_TAG_MISMATCH    = NTSTATUS(0xc0000277),
    STATUS_IO_REPARSE_DATA_INVALID    = NTSTATUS(0xc0000278),
    STATUS_IO_REPARSE_TAG_NOT_HANDLED = NTSTATUS(0xc0000279),
}

enum NTSTATUS STATUS_STOWED_EXCEPTION = NTSTATUS(0xc000027b);
enum NTSTATUS STATUS_REPARSE_POINT_NOT_RESOLVED = NTSTATUS(0xc0000280);
enum NTSTATUS STATUS_RANGE_LIST_CONFLICT = NTSTATUS(0xc0000282);
enum NTSTATUS STATUS_DESTINATION_ELEMENT_FULL = NTSTATUS(0xc0000284);
enum NTSTATUS STATUS_MAGAZINE_NOT_PRESENT = NTSTATUS(0xc0000286);

enum : NTSTATUS
{
    STATUS_DEVICE_REQUIRES_CLEANING = NTSTATUS(0x80000288),
    STATUS_DEVICE_DOOR_OPEN         = NTSTATUS(0x80000289),
}

enum NTSTATUS STATUS_DECRYPTION_FAILED = NTSTATUS(0xc000028b);
enum NTSTATUS STATUS_NO_RECOVERY_POLICY = NTSTATUS(0xc000028d);

enum : NTSTATUS
{
    STATUS_WRONG_EFS    = NTSTATUS(0xc000028f),
    STATUS_NO_USER_KEYS = NTSTATUS(0xc0000290),
}

enum NTSTATUS STATUS_NOT_EXPORT_FORMAT = NTSTATUS(0xc0000292);

enum : NTSTATUS
{
    STATUS_WAKE_SYSTEM            = NTSTATUS(0x40000294),
    STATUS_WMI_GUID_NOT_FOUND     = NTSTATUS(0xc0000295),
    STATUS_WMI_INSTANCE_NOT_FOUND = NTSTATUS(0xc0000296),
    STATUS_WMI_ITEMID_NOT_FOUND   = NTSTATUS(0xc0000297),
    STATUS_WMI_TRY_AGAIN          = NTSTATUS(0xc0000298),
}

enum : NTSTATUS
{
    STATUS_POLICY_OBJECT_NOT_FOUND = NTSTATUS(0xc000029a),
    STATUS_POLICY_ONLY_IN_DS       = NTSTATUS(0xc000029b),
}

enum : NTSTATUS
{
    STATUS_REMOTE_STORAGE_NOT_ACTIVE  = NTSTATUS(0xc000029d),
    STATUS_REMOTE_STORAGE_MEDIA_ERROR = NTSTATUS(0xc000029e),
}

enum NTSTATUS STATUS_SERVER_SID_MISMATCH = NTSTATUS(0xc00002a0);
enum NTSTATUS STATUS_DS_INVALID_ATTRIBUTE_SYNTAX = NTSTATUS(0xc00002a2);
enum NTSTATUS STATUS_DS_ATTRIBUTE_OR_VALUE_EXISTS = NTSTATUS(0xc00002a4);

enum : NTSTATUS
{
    STATUS_DS_UNAVAILABLE          = NTSTATUS(0xc00002a6),
    STATUS_DS_NO_RIDS_ALLOCATED    = NTSTATUS(0xc00002a7),
    STATUS_DS_NO_MORE_RIDS         = NTSTATUS(0xc00002a8),
    STATUS_DS_INCORRECT_ROLE_OWNER = NTSTATUS(0xc00002a9),
}

enum NTSTATUS STATUS_DS_OBJ_CLASS_VIOLATION = NTSTATUS(0xc00002ab);

enum : NTSTATUS
{
    STATUS_DS_CANT_ON_RDN        = NTSTATUS(0xc00002ad),
    STATUS_DS_CANT_MOD_OBJ_CLASS = NTSTATUS(0xc00002ae),
}

enum NTSTATUS STATUS_DS_GC_NOT_AVAILABLE = NTSTATUS(0xc00002b0);
enum NTSTATUS STATUS_REPARSE_ATTRIBUTE_CONFLICT = NTSTATUS(0xc00002b2);

enum : NTSTATUS
{
    STATUS_FLOAT_MULTIPLE_FAULTS = NTSTATUS(0xc00002b4),
    STATUS_FLOAT_MULTIPLE_TRAPS  = NTSTATUS(0xc00002b5),
}

enum : NTSTATUS
{
    STATUS_JOURNAL_DELETE_IN_PROGRESS = NTSTATUS(0xc00002b7),
    STATUS_JOURNAL_NOT_ACTIVE         = NTSTATUS(0xc00002b8),
}

enum NTSTATUS STATUS_DS_RIDMGR_DISABLED = NTSTATUS(0xc00002ba);
enum NTSTATUS STATUS_DRIVER_FAILED_SLEEP = NTSTATUS(0xc00002c2);
enum NTSTATUS STATUS_CORRUPT_SYSTEM_FILE = NTSTATUS(0xc00002c4);

enum : NTSTATUS
{
    STATUS_WMI_READ_ONLY   = NTSTATUS(0xc00002c6),
    STATUS_WMI_SET_FAILURE = NTSTATUS(0xc00002c7),
}

enum NTSTATUS STATUS_REG_NAT_CONSUMPTION = NTSTATUS(0xc00002c9);
enum NTSTATUS STATUS_DS_SAM_INIT_FAILURE = NTSTATUS(0xc00002cb);
enum NTSTATUS STATUS_DS_SENSITIVE_GROUP_VIOLATION = NTSTATUS(0xc00002cd);
enum NTSTATUS STATUS_JOURNAL_ENTRY_DELETED = NTSTATUS(0xc00002cf);
enum NTSTATUS STATUS_SYSTEM_IMAGE_BAD_SIGNATURE = NTSTATUS(0xc00002d1);
enum NTSTATUS STATUS_POWER_STATE_INVALID = NTSTATUS(0xc00002d3);

enum : NTSTATUS
{
    STATUS_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN = NTSTATUS(0xc00002d5),
    STATUS_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN  = NTSTATUS(0xc00002d6),
}

enum NTSTATUS STATUS_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER = NTSTATUS(0xc00002d8);
enum NTSTATUS STATUS_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER = NTSTATUS(0xc00002da);
enum NTSTATUS STATUS_DS_HAVE_PRIMARY_MEMBERS = NTSTATUS(0xc00002dc);
enum NTSTATUS STATUS_INSUFFICIENT_POWER = NTSTATUS(0xc00002de);
enum NTSTATUS STATUS_SAM_NEED_BOOTKEY_FLOPPY = NTSTATUS(0xc00002e0);
enum NTSTATUS STATUS_DS_INIT_FAILURE = NTSTATUS(0xc00002e2);

enum : NTSTATUS
{
    STATUS_DS_GC_REQUIRED                = NTSTATUS(0xc00002e4),
    STATUS_DS_LOCAL_MEMBER_OF_LOCAL_ONLY = NTSTATUS(0xc00002e5),
}

enum NTSTATUS STATUS_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED = NTSTATUS(0xc00002e7);
enum NTSTATUS STATUS_CURRENT_DOMAIN_NOT_ALLOWED = NTSTATUS(0xc00002e9);
enum NTSTATUS STATUS_SYSTEM_SHUTDOWN = NTSTATUS(0xc00002eb);
enum NTSTATUS STATUS_DS_SAM_INIT_FAILURE_CONSOLE = NTSTATUS(0xc00002ed);
enum NTSTATUS STATUS_NO_TGT_REPLY = NTSTATUS(0xc00002ef);
enum NTSTATUS STATUS_NO_IP_ADDRESSES = NTSTATUS(0xc00002f1);
enum NTSTATUS STATUS_CRYPTO_SYSTEM_INVALID = NTSTATUS(0xc00002f3);
enum NTSTATUS STATUS_MUST_BE_KDC = NTSTATUS(0xc00002f5);
enum NTSTATUS STATUS_TOO_MANY_PRINCIPALS = NTSTATUS(0xc00002f7);
enum NTSTATUS STATUS_PKINIT_NAME_MISMATCH = NTSTATUS(0xc00002f9);

enum : NTSTATUS
{
    STATUS_KDC_INVALID_REQUEST = NTSTATUS(0xc00002fb),
    STATUS_KDC_UNABLE_TO_REFER = NTSTATUS(0xc00002fc),
    STATUS_KDC_UNKNOWN_ETYPE   = NTSTATUS(0xc00002fd),
}

enum NTSTATUS STATUS_SERVER_SHUTDOWN_IN_PROGRESS = NTSTATUS(0xc00002ff);
enum NTSTATUS STATUS_WMI_GUID_DISCONNECTED = NTSTATUS(0xc0000301);
enum NTSTATUS STATUS_WMI_ALREADY_ENABLED = NTSTATUS(0xc0000303);
enum NTSTATUS STATUS_COPY_PROTECTION_FAILURE = NTSTATUS(0xc0000305);

enum : NTSTATUS
{
    STATUS_CSS_KEY_NOT_PRESENT     = NTSTATUS(0xc0000307),
    STATUS_CSS_KEY_NOT_ESTABLISHED = NTSTATUS(0xc0000308),
}

enum : NTSTATUS
{
    STATUS_CSS_REGION_MISMATCH  = NTSTATUS(0xc000030a),
    STATUS_CSS_RESETS_EXHAUSTED = NTSTATUS(0xc000030b),
}

enum NTSTATUS STATUS_LOST_MODE_LOGON_RESTRICTION = NTSTATUS(0xc000030d);
enum NTSTATUS STATUS_SMARTCARD_SUBSYSTEM_FAILURE = NTSTATUS(0xc0000321);

enum : NTSTATUS
{
    STATUS_HOST_DOWN           = NTSTATUS(0xc0000350),
    STATUS_UNSUPPORTED_PREAUTH = NTSTATUS(0xc0000351),
}

enum NTSTATUS STATUS_PORT_NOT_SET = NTSTATUS(0xc0000353);
enum NTSTATUS STATUS_DS_VERSION_CHECK_FAILURE = NTSTATUS(0xc0000355);
enum NTSTATUS STATUS_PRENT4_MACHINE_ACCOUNT = NTSTATUS(0xc0000357);

enum : NTSTATUS
{
    STATUS_INVALID_IMAGE_WIN_32 = NTSTATUS(0xc0000359),
    STATUS_INVALID_IMAGE_WIN_64 = NTSTATUS(0xc000035a),
}

enum NTSTATUS STATUS_NETWORK_SESSION_EXPIRED = NTSTATUS(0xc000035c);
enum NTSTATUS STATUS_ALL_SIDS_FILTERED = NTSTATUS(0xc000035e);

enum : NTSTATUS
{
    STATUS_ACCESS_DISABLED_BY_POLICY_DEFAULT   = NTSTATUS(0xc0000361),
    STATUS_ACCESS_DISABLED_BY_POLICY_PATH      = NTSTATUS(0xc0000362),
    STATUS_ACCESS_DISABLED_BY_POLICY_PUBLISHER = NTSTATUS(0xc0000363),
    STATUS_ACCESS_DISABLED_BY_POLICY_OTHER     = NTSTATUS(0xc0000364),
}

enum NTSTATUS STATUS_DEVICE_ENUMERATION_ERROR = NTSTATUS(0xc0000366);
enum NTSTATUS STATUS_INVALID_DEVICE_OBJECT_PARAMETER = NTSTATUS(0xc0000369);

enum : NTSTATUS
{
    STATUS_DRIVER_BLOCKED_CRITICAL = NTSTATUS(0xc000036b),
    STATUS_DRIVER_BLOCKED          = NTSTATUS(0xc000036c),
    STATUS_DRIVER_DATABASE_ERROR   = NTSTATUS(0xc000036d),
}

enum NTSTATUS STATUS_INVALID_IMPORT_OF_NON_DLL = NTSTATUS(0xc000036f);

enum : NTSTATUS
{
    STATUS_NO_SECRETS                            = NTSTATUS(0xc0000371),
    STATUS_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY = NTSTATUS(0xc0000372),
}

enum NTSTATUS STATUS_HEAP_CORRUPTION = NTSTATUS(0xc0000374);

enum : NTSTATUS
{
    STATUS_SMARTCARD_CARD_BLOCKED           = NTSTATUS(0xc0000381),
    STATUS_SMARTCARD_CARD_NOT_AUTHENTICATED = NTSTATUS(0xc0000382),
    STATUS_SMARTCARD_NO_CARD                = NTSTATUS(0xc0000383),
    STATUS_SMARTCARD_NO_KEY_CONTAINER       = NTSTATUS(0xc0000384),
    STATUS_SMARTCARD_NO_CERTIFICATE         = NTSTATUS(0xc0000385),
    STATUS_SMARTCARD_NO_KEYSET              = NTSTATUS(0xc0000386),
    STATUS_SMARTCARD_IO_ERROR               = NTSTATUS(0xc0000387),
    STATUS_SMARTCARD_CERT_REVOKED           = NTSTATUS(0xc0000389),
}

enum NTSTATUS STATUS_REVOCATION_OFFLINE_C = NTSTATUS(0xc000038b);
enum NTSTATUS STATUS_SMARTCARD_CERT_EXPIRED = NTSTATUS(0xc000038d);
enum NTSTATUS STATUS_SMARTCARD_SILENT_CONTEXT = NTSTATUS(0xc000038f);
enum NTSTATUS STATUS_ALL_USER_TRUST_QUOTA_EXCEEDED = NTSTATUS(0xc0000402);
enum NTSTATUS STATUS_DS_NAME_NOT_UNIQUE = NTSTATUS(0xc0000404);
enum NTSTATUS STATUS_DS_GROUP_CONVERSION_ERROR = NTSTATUS(0xc0000406);
enum NTSTATUS STATUS_USER2USER_REQUIRED = NTSTATUS(0xc0000408);
enum NTSTATUS STATUS_NO_S4U_PROT_SUPPORT = NTSTATUS(0xc000040a);
enum NTSTATUS STATUS_REVOCATION_OFFLINE_KDC = NTSTATUS(0xc000040c);

enum : NTSTATUS
{
    STATUS_KDC_CERT_EXPIRED = NTSTATUS(0xc000040e),
    STATUS_KDC_CERT_REVOKED = NTSTATUS(0xc000040f),
}

enum NTSTATUS STATUS_HIBERNATION_FAILURE = NTSTATUS(0xc0000411);
enum NTSTATUS STATUS_VDM_DISALLOWED = NTSTATUS(0xc0000414);
enum NTSTATUS STATUS_INSUFFICIENT_RESOURCE_FOR_SPECIFIED_SHARED_SECTION_SIZE = NTSTATUS(0xc0000416);
enum NTSTATUS STATUS_NTLM_BLOCKED = NTSTATUS(0xc0000418);
enum NTSTATUS STATUS_DS_DOMAIN_NAME_EXISTS_IN_FOREST = NTSTATUS(0xc000041a);
enum NTSTATUS STATUS_INVALID_USER_PRINCIPAL_NAME = NTSTATUS(0xc000041c);
enum NTSTATUS STATUS_ASSERTION_FAILURE = NTSTATUS(0xc0000420);
enum NTSTATUS STATUS_CALLBACK_POP_STACK = NTSTATUS(0xc0000423);
enum NTSTATUS STATUS_HIVE_UNLOADED = NTSTATUS(0xc0000425);
enum NTSTATUS STATUS_FILE_SYSTEM_LIMITATION = NTSTATUS(0xc0000427);
enum NTSTATUS STATUS_NOT_CAPABLE = NTSTATUS(0xc0000429);
enum NTSTATUS STATUS_IMPLEMENTATION_LIMIT = NTSTATUS(0xc000042b);
enum NTSTATUS STATUS_NO_SECURITY_CONTEXT = NTSTATUS(0xc000042d);

enum : NTSTATUS
{
    STATUS_BEYOND_VDL                    = NTSTATUS(0xc0000432),
    STATUS_ENCOUNTERED_WRITE_IN_PROGRESS = NTSTATUS(0xc0000433),
}

enum NTSTATUS STATUS_PURGE_FAILED = NTSTATUS(0xc0000435);

enum : NTSTATUS
{
    STATUS_CS_ENCRYPTION_INVALID_SERVER_RESPONSE = NTSTATUS(0xc0000441),
    STATUS_CS_ENCRYPTION_UNSUPPORTED_SERVER      = NTSTATUS(0xc0000442),
    STATUS_CS_ENCRYPTION_EXISTING_ENCRYPTED_FILE = NTSTATUS(0xc0000443),
    STATUS_CS_ENCRYPTION_NEW_ENCRYPTED_FILE      = NTSTATUS(0xc0000444),
    STATUS_CS_ENCRYPTION_FILE_NOT_CSE            = NTSTATUS(0xc0000445),
}

enum NTSTATUS STATUS_DRIVER_PROCESS_TERMINATED = NTSTATUS(0xc0000450);
enum NTSTATUS STATUS_SYSTEM_DEVICE_NOT_FOUND = NTSTATUS(0xc0000452);
enum NTSTATUS STATUS_INSUFFICIENT_NVRAM_RESOURCES = NTSTATUS(0xc0000454);

enum : NTSTATUS
{
    STATUS_THREAD_ALREADY_IN_SESSION = NTSTATUS(0xc0000456),
    STATUS_THREAD_NOT_IN_SESSION     = NTSTATUS(0xc0000457),
}

enum NTSTATUS STATUS_REQUEST_PAUSED = NTSTATUS(0xc0000459);
enum NTSTATUS STATUS_DISK_RESOURCES_EXHAUSTED = NTSTATUS(0xc0000461);
enum NTSTATUS STATUS_DEVICE_FEATURE_NOT_SUPPORTED = NTSTATUS(0xc0000463);
enum NTSTATUS STATUS_INVALID_TOKEN = NTSTATUS(0xc0000465);
enum NTSTATUS STATUS_FILE_NOT_AVAILABLE = NTSTATUS(0xc0000467);
enum NTSTATUS STATUS_PACKAGE_UPDATING = NTSTATUS(0xc0000469);

enum : NTSTATUS
{
    STATUS_FT_WRITE_FAILURE    = NTSTATUS(0xc000046b),
    STATUS_FT_DI_SCAN_REQUIRED = NTSTATUS(0xc000046c),
}

enum NTSTATUS STATUS_EXTERNAL_BACKING_PROVIDER_UNKNOWN = NTSTATUS(0xc000046e);
enum NTSTATUS STATUS_DATA_CHECKSUM_ERROR = NTSTATUS(0xc0000470);
enum NTSTATUS STATUS_TRIM_READ_ZERO_NOT_SUPPORTED = NTSTATUS(0xc0000472);

enum : NTSTATUS
{
    STATUS_INVALID_OFFSET_ALIGNMENT        = NTSTATUS(0xc0000474),
    STATUS_INVALID_FIELD_IN_PARAMETER_LIST = NTSTATUS(0xc0000475),
}

enum NTSTATUS STATUS_INVALID_INITIATOR_TARGET_PATH = NTSTATUS(0xc0000477);
enum NTSTATUS STATUS_NOT_REDUNDANT_STORAGE = NTSTATUS(0xc0000479);
enum NTSTATUS STATUS_COMPRESSED_FILE_NOT_SUPPORTED = NTSTATUS(0xc000047b);
enum NTSTATUS STATUS_IO_OPERATION_TIMEOUT = NTSTATUS(0xc000047d);
enum NTSTATUS STATUS_APPX_INTEGRITY_FAILURE_CLR_NGEN = NTSTATUS(0xc000047f);

enum : NTSTATUS
{
    STATUS_APISET_NOT_HOSTED  = NTSTATUS(0xc0000481),
    STATUS_APISET_NOT_PRESENT = NTSTATUS(0xc0000482),
}

enum : NTSTATUS
{
    STATUS_FIRMWARE_SLOT_INVALID  = NTSTATUS(0xc0000484),
    STATUS_FIRMWARE_IMAGE_INVALID = NTSTATUS(0xc0000485),
}

enum NTSTATUS STATUS_WIM_NOT_BOOTABLE = NTSTATUS(0xc0000487);
enum NTSTATUS STATUS_NEEDS_REGISTRATION = NTSTATUS(0xc0000489);
enum NTSTATUS STATUS_CALLBACK_INVOKE_INLINE = NTSTATUS(0xc000048b);
enum NTSTATUS STATUS_MARKED_TO_DISALLOW_WRITES = NTSTATUS(0xc000048d);
enum NTSTATUS STATUS_ENCLAVE_FAILURE = NTSTATUS(0xc000048f);

enum : NTSTATUS
{
    STATUS_PNP_DRIVER_PACKAGE_NOT_FOUND        = NTSTATUS(0xc0000491),
    STATUS_PNP_DRIVER_CONFIGURATION_NOT_FOUND  = NTSTATUS(0xc0000492),
    STATUS_PNP_DRIVER_CONFIGURATION_INCOMPLETE = NTSTATUS(0xc0000493),
}

enum NTSTATUS STATUS_PNP_DEVICE_CONFIGURATION_PENDING = NTSTATUS(0xc0000495);
enum NTSTATUS STATUS_PACKAGE_NOT_AVAILABLE = NTSTATUS(0xc0000497);
enum NTSTATUS STATUS_NOT_SUPPORTED_ON_DAX = NTSTATUS(0xc000049a);
enum NTSTATUS STATUS_DAX_MAPPING_EXISTS = NTSTATUS(0xc000049c);
enum NTSTATUS STATUS_STORAGE_LOST_DATA_PERSISTENCE = NTSTATUS(0xc000049e);
enum NTSTATUS STATUS_EXTERNAL_SYSKEY_NOT_SUPPORTED = NTSTATUS(0xc00004a1);
enum NTSTATUS STATUS_FILE_PROTECTED_UNDER_DPL = NTSTATUS(0xc00004a3);
enum NTSTATUS STATUS_NO_PHYSICALLY_ALIGNED_FREE_SPACE_FOUND = NTSTATUS(0xc00004a5);

enum : NTSTATUS
{
    STATUS_RWRAW_ENCRYPTED_FILE_NOT_ENCRYPTED           = NTSTATUS(0xc00004a7),
    STATUS_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILEOFFSET = NTSTATUS(0xc00004a8),
    STATUS_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILERANGE  = NTSTATUS(0xc00004a9),
    STATUS_RWRAW_ENCRYPTED_INVALID_EDATAINFO_PARAMETER  = NTSTATUS(0xc00004aa),
}

enum NTSTATUS STATUS_PATCH_CONFLICT = NTSTATUS(0xc00004ac);

enum : NTSTATUS
{
    STATUS_STORAGE_RESERVE_DOES_NOT_EXIST = NTSTATUS(0xc00004ae),
    STATUS_STORAGE_RESERVE_ALREADY_EXISTS = NTSTATUS(0xc00004af),
    STATUS_STORAGE_RESERVE_NOT_EMPTY      = NTSTATUS(0xc00004b0),
}

enum NTSTATUS STATUS_NOT_DAX_MAPPABLE = NTSTATUS(0xc00004b2);
enum NTSTATUS STATUS_FILE_NOT_SUPPORTED = NTSTATUS(0xc00004b4);

enum : NTSTATUS
{
    STATUS_ENCRYPTION_DISABLED            = NTSTATUS(0xc00004b6),
    STATUS_ENCRYPTING_METADATA_DISALLOWED = NTSTATUS(0xc00004b7),
}

enum NTSTATUS STATUS_UNSATISFIED_DEPENDENCIES = NTSTATUS(0xc00004b9);
enum NTSTATUS STATUS_UNSUPPORTED_PAGING_MODE = NTSTATUS(0xc00004bb);
enum NTSTATUS STATUS_HAS_SYSTEM_CRITICAL_FILES = NTSTATUS(0xc00004bd);
enum NTSTATUS STATUS_FT_READ_FROM_COPY_FAILURE = NTSTATUS(0xc00004bf);
enum NTSTATUS STATUS_STORAGE_STACK_ACCESS_DENIED = NTSTATUS(0xc00004c1);
enum NTSTATUS STATUS_ENCRYPTED_FILE_NOT_SUPPORTED = NTSTATUS(0xc00004c3);
enum NTSTATUS STATUS_PAGEFILE_NOT_SUPPORTED = NTSTATUS(0xc00004c5);
enum NTSTATUS STATUS_NOT_SUPPORTED_WITH_BYPASSIO = NTSTATUS(0xc00004c7);

enum : NTSTATUS
{
    STATUS_NOT_SUPPORTED_WITH_ENCRYPTION     = NTSTATUS(0xc00004c9),
    STATUS_NOT_SUPPORTED_WITH_COMPRESSION    = NTSTATUS(0xc00004ca),
    STATUS_NOT_SUPPORTED_WITH_REPLICATION    = NTSTATUS(0xc00004cb),
    STATUS_NOT_SUPPORTED_WITH_DEDUPLICATION  = NTSTATUS(0xc00004cc),
    STATUS_NOT_SUPPORTED_WITH_AUDITING       = NTSTATUS(0xc00004cd),
    STATUS_NOT_SUPPORTED_WITH_MONITORING     = NTSTATUS(0xc00004ce),
    STATUS_NOT_SUPPORTED_WITH_SNAPSHOT       = NTSTATUS(0xc00004cf),
    STATUS_NOT_SUPPORTED_WITH_VIRTUALIZATION = NTSTATUS(0xc00004d0),
}

enum NTSTATUS STATUS_BYPASSIO_FLT_NOT_SUPPORTED = NTSTATUS(0xc00004d2);
enum NTSTATUS STATUS_PATCH_NOT_REGISTERED = NTSTATUS(0xc00004d4);
enum NTSTATUS STATUS_PDE_ENCRYPTION_UNAVAILABLE_FAILURE = NTSTATUS(0xc00004d6);
enum NTSTATUS STATUS_PDE_DECRYPTION_UNAVAILABLE = NTSTATUS(0xc00004d8);

enum : NTSTATUS
{
    STATUS_VOLUME_UPGRADE_PENDING                            = NTSTATUS(0x400004da),
    STATUS_VOLUME_UPGRADE_DISABLED                           = NTSTATUS(0xc00004db),
    STATUS_VOLUME_UPGRADE_DISABLED_TILL_OS_DOWNGRADE_EXPIRED = NTSTATUS(0xc00004dc),
}

enum NTSTATUS STATUS_FS_GUID_MISMATCH = NTSTATUS(0xc00004de);
enum NTSTATUS STATUS_MEMORY_DECOMPRESSION_FAILURE = NTSTATUS(0xc00004e0);
enum NTSTATUS STATUS_MEMORY_DECOMPRESSION_HW_ERROR = NTSTATUS(0xc00004e2);

enum : NTSTATUS
{
    STATUS_INVALID_TASK_NAME  = NTSTATUS(0xc0000500),
    STATUS_INVALID_TASK_INDEX = NTSTATUS(0xc0000501),
}

enum NTSTATUS STATUS_CALLBACK_BYPASS = NTSTATUS(0xc0000503);
enum NTSTATUS STATUS_INVALID_CAP = NTSTATUS(0xc0000505);
enum NTSTATUS STATUS_DEVICE_HUNG = NTSTATUS(0xc0000507);
enum NTSTATUS STATUS_JOB_NO_CONTAINER = NTSTATUS(0xc0000509);
enum NTSTATUS STATUS_REPARSE_POINT_ENCOUNTERED = NTSTATUS(0xc000050b);
enum NTSTATUS STATUS_NOT_A_TIERED_VOLUME = NTSTATUS(0xc000050d);
enum NTSTATUS STATUS_JOB_NOT_EMPTY = NTSTATUS(0xc000050f);

enum : NTSTATUS
{
    STATUS_ENCLAVE_NOT_TERMINATED = NTSTATUS(0xc0000511),
    STATUS_ENCLAVE_IS_TERMINATING = NTSTATUS(0xc0000512),
}

enum NTSTATUS STATUS_SMR_GARBAGE_COLLECTION_REQUIRED = NTSTATUS(0xc0000514);
enum NTSTATUS STATUS_THREAD_NOT_RUNNING = NTSTATUS(0xc0000516);
enum NTSTATUS STATUS_FS_METADATA_INCONSISTENT = NTSTATUS(0xc0000518);
enum NTSTATUS STATUS_IMAGE_CERT_REVOKED = NTSTATUS(0xc0000603);
enum NTSTATUS STATUS_IMAGE_CERT_EXPIRED = NTSTATUS(0xc0000605);
enum NTSTATUS STATUS_SET_CONTEXT_DENIED = NTSTATUS(0xc000060a);
enum NTSTATUS STATUS_PORT_CLOSED = NTSTATUS(0xc0000700);
enum NTSTATUS STATUS_INVALID_MESSAGE = NTSTATUS(0xc0000702);
enum NTSTATUS STATUS_RECURSIVE_DISPATCH = NTSTATUS(0xc0000704);
enum NTSTATUS STATUS_LPC_INVALID_CONNECTION_USAGE = NTSTATUS(0xc0000706);
enum NTSTATUS STATUS_RESOURCE_IN_USE = NTSTATUS(0xc0000708);

enum : NTSTATUS
{
    STATUS_THREADPOOL_HANDLE_EXCEPTION               = NTSTATUS(0xc000070a),
    STATUS_THREADPOOL_SET_EVENT_ON_COMPLETION_FAILED = NTSTATUS(0xc000070b),
}

enum NTSTATUS STATUS_THREADPOOL_RELEASE_MUTEX_ON_COMPLETION_FAILED = NTSTATUS(0xc000070d);
enum NTSTATUS STATUS_THREADPOOL_RELEASED_DURING_OPERATION = NTSTATUS(0xc000070f);
enum NTSTATUS STATUS_APC_RETURNED_WHILE_IMPERSONATING = NTSTATUS(0xc0000711);
enum NTSTATUS STATUS_MCA_EXCEPTION = NTSTATUS(0xc0000713);
enum NTSTATUS STATUS_SYMLINK_CLASS_DISABLED = NTSTATUS(0xc0000715);
enum NTSTATUS STATUS_NO_UNICODE_TRANSLATION = NTSTATUS(0xc0000717);
enum NTSTATUS STATUS_CONTEXT_MISMATCH = NTSTATUS(0xc0000719);
enum NTSTATUS STATUS_CALLBACK_RETURNED_THREAD_PRIORITY = NTSTATUS(0xc000071b);

enum : NTSTATUS
{
    STATUS_CALLBACK_RETURNED_TRANSACTION     = NTSTATUS(0xc000071d),
    STATUS_CALLBACK_RETURNED_LDR_LOCK        = NTSTATUS(0xc000071e),
    STATUS_CALLBACK_RETURNED_LANG            = NTSTATUS(0xc000071f),
    STATUS_CALLBACK_RETURNED_PRI_BACK        = NTSTATUS(0xc0000720),
    STATUS_CALLBACK_RETURNED_THREAD_AFFINITY = NTSTATUS(0xc0000721),
}

enum NTSTATUS STATUS_EXECUTABLE_MEMORY_WRITE = NTSTATUS(0xc0000723);
enum NTSTATUS STATUS_ATTACHED_EXECUTABLE_MEMORY_WRITE = NTSTATUS(0xc0000725);
enum NTSTATUS STATUS_DISK_REPAIR_DISABLED = NTSTATUS(0xc0000800);
enum NTSTATUS STATUS_DISK_QUOTA_EXCEEDED = NTSTATUS(0xc0000802);
enum NTSTATUS STATUS_CONTENT_BLOCKED = NTSTATUS(0xc0000804);
enum NTSTATUS STATUS_VOLUME_DIRTY = NTSTATUS(0xc0000806);
enum NTSTATUS STATUS_DISK_REPAIR_UNSUCCESSFUL = NTSTATUS(0xc0000808);

enum : NTSTATUS
{
    STATUS_CORRUPT_LOG_CORRUPTED    = NTSTATUS(0xc000080a),
    STATUS_CORRUPT_LOG_UNAVAILABLE  = NTSTATUS(0xc000080b),
    STATUS_CORRUPT_LOG_DELETED_FULL = NTSTATUS(0xc000080c),
    STATUS_CORRUPT_LOG_CLEARED      = NTSTATUS(0xc000080d),
}

enum NTSTATUS STATUS_PROACTIVE_SCAN_IN_PROGRESS = NTSTATUS(0xc000080f);
enum NTSTATUS STATUS_CORRUPT_LOG_UPLEVEL_RECORDS = NTSTATUS(0xc0000811);
enum NTSTATUS STATUS_CHECKOUT_REQUIRED = NTSTATUS(0xc0000902);
enum NTSTATUS STATUS_FILE_TOO_LARGE = NTSTATUS(0xc0000904);

enum : NTSTATUS
{
    STATUS_VIRUS_INFECTED = NTSTATUS(0xc0000906),
    STATUS_VIRUS_DELETED  = NTSTATUS(0xc0000907),
}

enum NTSTATUS STATUS_CANNOT_BREAK_OPLOCK = NTSTATUS(0xc0000909);

enum : NTSTATUS
{
    STATUS_BAD_DATA            = NTSTATUS(0xc000090b),
    STATUS_NO_KEY              = NTSTATUS(0xc000090c),
    STATUS_FILE_HANDLE_REVOKED = NTSTATUS(0xc0000910),
}

enum NTSTATUS STATUS_BLOCK_WEAK_REFERENCE_INVALID = NTSTATUS(0xc0000912);
enum NTSTATUS STATUS_BLOCK_TARGET_WEAK_REFERENCE_INVALID = NTSTATUS(0xc0000914);
enum NTSTATUS STATUS_SYSTEM_FILE_NOT_SUPPORTED = NTSTATUS(0xc0000916);

enum : NTSTATUS
{
    STATUS_VRF_VOLATILE_NOT_STOPPABLE           = NTSTATUS(0xc0000c09),
    STATUS_VRF_VOLATILE_SAFE_MODE               = NTSTATUS(0xc0000c0a),
    STATUS_VRF_VOLATILE_NOT_RUNNABLE_SYSTEM     = NTSTATUS(0xc0000c0b),
    STATUS_VRF_VOLATILE_NOT_SUPPORTED_RULECLASS = NTSTATUS(0xc0000c0c),
    STATUS_VRF_VOLATILE_PROTECTED_DRIVER        = NTSTATUS(0xc0000c0d),
    STATUS_VRF_VOLATILE_NMI_REGISTERED          = NTSTATUS(0xc0000c0e),
    STATUS_VRF_VOLATILE_SETTINGS_CONFLICT       = NTSTATUS(0xc0000c0f),
}

enum NTSTATUS STATUS_DIF_ZERO_SIZE_INFORMATION = NTSTATUS(0xc0000c73);
enum NTSTATUS STATUS_DIF_DRIVER_THUNKS_NOT_ALLOWED = NTSTATUS(0xc0000c75);
enum NTSTATUS STATUS_DIF_LIVEDUMP_LIMIT_EXCEEDED = NTSTATUS(0xc0000c77);

enum : NTSTATUS
{
    STATUS_DIF_VOLATILE_DRIVER_HOTPATCHED         = NTSTATUS(0xc0000c79),
    STATUS_DIF_VOLATILE_INVALID_INFO              = NTSTATUS(0xc0000c7a),
    STATUS_DIF_VOLATILE_DRIVER_IS_NOT_RUNNING     = NTSTATUS(0xc0000c7b),
    STATUS_DIF_VOLATILE_PLUGIN_IS_NOT_RUNNING     = NTSTATUS(0xc0000c7c),
    STATUS_DIF_VOLATILE_PLUGIN_CHANGE_NOT_ALLOWED = NTSTATUS(0xc0000c7d),
    STATUS_DIF_VOLATILE_NOT_ALLOWED               = NTSTATUS(0xc0000c7e),
}

enum NTSTATUS STATUS_WOW_ASSERTION = NTSTATUS(0xc0009898);
enum NTSTATUS STATUS_HMAC_NOT_SUPPORTED = NTSTATUS(0xc000a001);

enum : NTSTATUS
{
    STATUS_INVALID_STATE_TRANSITION    = NTSTATUS(0xc000a003),
    STATUS_INVALID_KERNEL_INFO_VERSION = NTSTATUS(0xc000a004),
    STATUS_INVALID_PEP_INFO_VERSION    = NTSTATUS(0xc000a005),
}

enum NTSTATUS STATUS_EOF_ON_GHOSTED_RANGE = NTSTATUS(0xc000a007);
enum NTSTATUS STATUS_IPSEC_QUEUE_OVERFLOW = NTSTATUS(0xc000a010);
enum NTSTATUS STATUS_HOPLIMIT_EXCEEDED = NTSTATUS(0xc000a012);
enum NTSTATUS STATUS_FASTPATH_REJECTED = NTSTATUS(0xc000a014);

enum : NTSTATUS
{
    STATUS_LOST_WRITEBEHIND_DATA_NETWORK_SERVER_ERROR = NTSTATUS(0xc000a081),
    STATUS_LOST_WRITEBEHIND_DATA_LOCAL_DISK_ERROR     = NTSTATUS(0xc000a082),
}

enum NTSTATUS STATUS_XMLDSIG_ERROR = NTSTATUS(0xc000a084);
enum NTSTATUS STATUS_AUTHIP_FAILURE = NTSTATUS(0xc000a086);
enum NTSTATUS STATUS_DS_OID_NOT_FOUND = NTSTATUS(0xc000a088);
enum NTSTATUS STATUS_LOCAL_POLICY_MODIFICATION_NOT_SUPPORTED = NTSTATUS(0xc000a08a);
enum NTSTATUS STATUS_LAPS_LEGACY_SCHEMA_MISSING = NTSTATUS(0xc000a08c);
enum NTSTATUS STATUS_LAPS_ENCRYPTION_REQUIRES_2016_DFL = NTSTATUS(0xc000a08e);
enum NTSTATUS STATUS_DS_JET_RECORD_TOO_BIG = NTSTATUS(0xc000a090);

enum : NTSTATUS
{
    STATUS_HASH_NOT_SUPPORTED = NTSTATUS(0xc000a100),
    STATUS_HASH_NOT_PRESENT   = NTSTATUS(0xc000a101),
}

enum NTSTATUS STATUS_GPIO_CLIENT_INFORMATION_INVALID = NTSTATUS(0xc000a122);
enum NTSTATUS STATUS_GPIO_INVALID_REGISTRATION_PACKET = NTSTATUS(0xc000a124);
enum NTSTATUS STATUS_GPIO_INCOMPATIBLE_CONNECT_MODE = NTSTATUS(0xc000a126);
enum NTSTATUS STATUS_CANNOT_SWITCH_RUNLEVEL = NTSTATUS(0xc000a141);
enum NTSTATUS STATUS_RUNLEVEL_SWITCH_TIMEOUT = NTSTATUS(0xc000a143);

enum : NTSTATUS
{
    STATUS_RUNLEVEL_SWITCH_AGENT_TIMEOUT = NTSTATUS(0xc000a145),
    STATUS_RUNLEVEL_SWITCH_IN_PROGRESS   = NTSTATUS(0xc000a146),
}

enum NTSTATUS STATUS_APISET_SCHEMA_VERSION_NOT_SUPPORTED = NTSTATUS(0xc000a162);
enum NTSTATUS STATUS_NOT_SUPPORTED_IN_APPCONTAINER = NTSTATUS(0xc000a201);
enum NTSTATUS STATUS_LPAC_ACCESS_DENIED = NTSTATUS(0xc000a203);

enum : NTSTATUS
{
    STATUS_APP_DATA_NOT_FOUND       = NTSTATUS(0xc000a281),
    STATUS_APP_DATA_EXPIRED         = NTSTATUS(0xc000a282),
    STATUS_APP_DATA_CORRUPT         = NTSTATUS(0xc000a283),
    STATUS_APP_DATA_LIMIT_EXCEEDED  = NTSTATUS(0xc000a284),
    STATUS_APP_DATA_REBOOT_REQUIRED = NTSTATUS(0xc000a285),
}

enum NTSTATUS STATUS_OFFLOAD_WRITE_FLT_NOT_SUPPORTED = NTSTATUS(0xc000a2a2);
enum NTSTATUS STATUS_OFFLOAD_WRITE_FILE_NOT_SUPPORTED = NTSTATUS(0xc000a2a4);
enum NTSTATUS STATUS_WOF_WIM_RESOURCE_TABLE_CORRUPT = NTSTATUS(0xc000a2a6);

enum : NTSTATUS
{
    STATUS_CIMFS_IMAGE_CORRUPT               = NTSTATUS(0xc000c001),
    STATUS_CIMFS_IMAGE_VERSION_NOT_SUPPORTED = NTSTATUS(0xc000c002),
}

enum : NTSTATUS
{
    STATUS_FILE_SYSTEM_VIRTUALIZATION_METADATA_CORRUPT  = NTSTATUS(0xc000ce02),
    STATUS_FILE_SYSTEM_VIRTUALIZATION_BUSY              = NTSTATUS(0xc000ce03),
    STATUS_FILE_SYSTEM_VIRTUALIZATION_PROVIDER_UNKNOWN  = NTSTATUS(0xc000ce04),
    STATUS_FILE_SYSTEM_VIRTUALIZATION_INVALID_OPERATION = NTSTATUS(0xc000ce05),
}

enum : NTSTATUS
{
    STATUS_CLOUD_FILE_PROVIDER_NOT_RUNNING           = NTSTATUS(0xc000cf01),
    STATUS_CLOUD_FILE_METADATA_CORRUPT               = NTSTATUS(0xc000cf02),
    STATUS_CLOUD_FILE_METADATA_TOO_LARGE             = NTSTATUS(0xc000cf03),
    STATUS_CLOUD_FILE_PROPERTY_BLOB_TOO_LARGE        = NTSTATUS(0x8000cf04),
    STATUS_CLOUD_FILE_TOO_MANY_PROPERTY_BLOBS        = NTSTATUS(0x8000cf05),
    STATUS_CLOUD_FILE_PROPERTY_VERSION_NOT_SUPPORTED = NTSTATUS(0xc000cf06),
}

enum : NTSTATUS
{
    STATUS_CLOUD_FILE_NOT_IN_SYNC             = NTSTATUS(0xc000cf08),
    STATUS_CLOUD_FILE_ALREADY_CONNECTED       = NTSTATUS(0xc000cf09),
    STATUS_CLOUD_FILE_NOT_SUPPORTED           = NTSTATUS(0xc000cf0a),
    STATUS_CLOUD_FILE_INVALID_REQUEST         = NTSTATUS(0xc000cf0b),
    STATUS_CLOUD_FILE_READ_ONLY_VOLUME        = NTSTATUS(0xc000cf0c),
    STATUS_CLOUD_FILE_CONNECTED_PROVIDER_ONLY = NTSTATUS(0xc000cf0d),
    STATUS_CLOUD_FILE_VALIDATION_FAILED       = NTSTATUS(0xc000cf0e),
    STATUS_CLOUD_FILE_AUTHENTICATION_FAILED   = NTSTATUS(0xc000cf0f),
    STATUS_CLOUD_FILE_INSUFFICIENT_RESOURCES  = NTSTATUS(0xc000cf10),
    STATUS_CLOUD_FILE_NETWORK_UNAVAILABLE     = NTSTATUS(0xc000cf11),
    STATUS_CLOUD_FILE_UNSUCCESSFUL            = NTSTATUS(0xc000cf12),
    STATUS_CLOUD_FILE_NOT_UNDER_SYNC_ROOT     = NTSTATUS(0xc000cf13),
    STATUS_CLOUD_FILE_IN_USE                  = NTSTATUS(0xc000cf14),
    STATUS_CLOUD_FILE_PINNED                  = NTSTATUS(0xc000cf15),
    STATUS_CLOUD_FILE_REQUEST_ABORTED         = NTSTATUS(0xc000cf16),
    STATUS_CLOUD_FILE_PROPERTY_CORRUPT        = NTSTATUS(0xc000cf17),
    STATUS_CLOUD_FILE_ACCESS_DENIED           = NTSTATUS(0xc000cf18),
    STATUS_CLOUD_FILE_INCOMPATIBLE_HARDLINKS  = NTSTATUS(0xc000cf19),
    STATUS_CLOUD_FILE_PROPERTY_LOCK_CONFLICT  = NTSTATUS(0xc000cf1a),
    STATUS_CLOUD_FILE_REQUEST_CANCELED        = NTSTATUS(0xc000cf1b),
    STATUS_CLOUD_FILE_PROVIDER_TERMINATED     = NTSTATUS(0xc000cf1d),
}

enum : NTSTATUS
{
    STATUS_CLOUD_FILE_REQUEST_TIMEOUT         = NTSTATUS(0xc000cf1f),
    STATUS_CLOUD_FILE_DEHYDRATION_DISALLOWED  = NTSTATUS(0xc000cf20),
    STATUS_CLOUD_FILE_US_MESSAGE_TIMEOUT      = NTSTATUS(0xc000cf21),
    STATUS_CLOUD_FILE_HYDRATION_NOT_AVAILABLE = NTSTATUS(0xc000cf22),
}

enum NTSTATUS STATUS_FILE_SNAP_USER_SECTION_NOT_SUPPORTED = NTSTATUS(0xc000f501);

enum : NTSTATUS
{
    STATUS_FILE_SNAP_IO_NOT_COORDINATED = NTSTATUS(0xc000f503),
    STATUS_FILE_SNAP_UNEXPECTED_ERROR   = NTSTATUS(0xc000f504),
    STATUS_FILE_SNAP_INVALID_PARAMETER  = NTSTATUS(0xc000f505),
}

enum : NTSTATUS
{
    STATUS_UNIONFS_CANNOT_EXIT_UNION       = NTSTATUS(0xc0ed0002),
    STATUS_UNIONFS_CANNOT_PRESERVE_LINK    = NTSTATUS(0xc0ed0003),
    STATUS_UNIONFS_INVALID_TOMBSTONE_STATE = NTSTATUS(0xc0ed0004),
}

enum : NTSTATUS
{
    STATUS_UNIONFS_NESTED_LAYER             = NTSTATUS(0xc0ed0006),
    STATUS_UNIONFS_UNION_DUPLICATE_ID       = NTSTATUS(0xc0ed0007),
    STATUS_UNIONFS_INACTIVE_UNION           = NTSTATUS(0xc0ed0008),
    STATUS_UNIONFS_TOO_MANY_LAYERS          = NTSTATUS(0xc0ed0009),
    STATUS_UNIONFS_TOO_LATE                 = NTSTATUS(0xc0ed000a),
    STATUS_UNIONFS_NESTED_UNION             = NTSTATUS(0xc0ed000b),
    STATUS_UNIONFS_NESTED_UNION_NOT_ALLOWED = NTSTATUS(0xc0ed000c),
}

enum NTSTATUS DBG_APP_NOT_IDLE = NTSTATUS(0xc0010002);
enum NTSTATUS RPC_NT_WRONG_KIND_OF_BINDING = NTSTATUS(0xc0020002);
enum NTSTATUS RPC_NT_PROTSEQ_NOT_SUPPORTED = NTSTATUS(0xc0020004);

enum : NTSTATUS
{
    RPC_NT_INVALID_STRING_UUID     = NTSTATUS(0xc0020006),
    RPC_NT_INVALID_ENDPOINT_FORMAT = NTSTATUS(0xc0020007),
    RPC_NT_INVALID_NET_ADDR        = NTSTATUS(0xc0020008),
}

enum NTSTATUS RPC_NT_INVALID_TIMEOUT = NTSTATUS(0xc002000a);
enum NTSTATUS RPC_NT_ALREADY_REGISTERED = NTSTATUS(0xc002000c);
enum NTSTATUS RPC_NT_ALREADY_LISTENING = NTSTATUS(0xc002000e);
enum NTSTATUS RPC_NT_NOT_LISTENING = NTSTATUS(0xc0020010);

enum : NTSTATUS
{
    RPC_NT_UNKNOWN_IF  = NTSTATUS(0xc0020012),
    RPC_NT_NO_BINDINGS = NTSTATUS(0xc0020013),
    RPC_NT_NO_PROTSEQS = NTSTATUS(0xc0020014),
}

enum NTSTATUS RPC_NT_OUT_OF_RESOURCES = NTSTATUS(0xc0020016);
enum NTSTATUS RPC_NT_SERVER_TOO_BUSY = NTSTATUS(0xc0020018);
enum NTSTATUS RPC_NT_NO_CALL_ACTIVE = NTSTATUS(0xc002001a);
enum NTSTATUS RPC_NT_CALL_FAILED_DNE = NTSTATUS(0xc002001c);

enum : NTSTATUS
{
    RPC_NT_UNSUPPORTED_TRANS_SYN = NTSTATUS(0xc002001f),
    RPC_NT_UNSUPPORTED_TYPE      = NTSTATUS(0xc0020021),
}

enum NTSTATUS RPC_NT_INVALID_BOUND = NTSTATUS(0xc0020023);
enum NTSTATUS RPC_NT_INVALID_NAME_SYNTAX = NTSTATUS(0xc0020025);
enum NTSTATUS RPC_NT_UUID_NO_ADDRESS = NTSTATUS(0xc0020028);
enum NTSTATUS RPC_NT_UNKNOWN_AUTHN_TYPE = NTSTATUS(0xc002002a);
enum NTSTATUS RPC_NT_STRING_TOO_LONG = NTSTATUS(0xc002002c);
enum NTSTATUS RPC_NT_PROCNUM_OUT_OF_RANGE = NTSTATUS(0xc002002e);

enum : NTSTATUS
{
    RPC_NT_UNKNOWN_AUTHN_SERVICE = NTSTATUS(0xc0020030),
    RPC_NT_UNKNOWN_AUTHN_LEVEL   = NTSTATUS(0xc0020031),
}

enum NTSTATUS RPC_NT_UNKNOWN_AUTHZ_SERVICE = NTSTATUS(0xc0020033);
enum NTSTATUS EPT_NT_CANT_PERFORM_OP = NTSTATUS(0xc0020035);
enum NTSTATUS RPC_NT_NOTHING_TO_EXPORT = NTSTATUS(0xc0020037);
enum NTSTATUS RPC_NT_INVALID_VERS_OPTION = NTSTATUS(0xc0020039);
enum NTSTATUS RPC_NT_NOT_ALL_OBJS_UNEXPORTED = NTSTATUS(0xc002003b);

enum : NTSTATUS
{
    RPC_NT_ENTRY_ALREADY_EXISTS = NTSTATUS(0xc002003d),
    RPC_NT_ENTRY_NOT_FOUND      = NTSTATUS(0xc002003e),
}

enum NTSTATUS RPC_NT_INVALID_NAF_ID = NTSTATUS(0xc0020040);
enum NTSTATUS RPC_NT_NO_CONTEXT_AVAILABLE = NTSTATUS(0xc0020042);
enum NTSTATUS RPC_NT_ZERO_DIVIDE = NTSTATUS(0xc0020044);

enum : NTSTATUS
{
    RPC_NT_FP_DIV_ZERO  = NTSTATUS(0xc0020046),
    RPC_NT_FP_UNDERFLOW = NTSTATUS(0xc0020047),
    RPC_NT_FP_OVERFLOW  = NTSTATUS(0xc0020048),
}

enum : NTSTATUS
{
    RPC_NT_SS_CHAR_TRANS_OPEN_FAIL  = NTSTATUS(0xc0030002),
    RPC_NT_SS_CHAR_TRANS_SHORT_FILE = NTSTATUS(0xc0030003),
}

enum : NTSTATUS
{
    RPC_NT_SS_CONTEXT_MISMATCH = NTSTATUS(0xc0030005),
    RPC_NT_SS_CONTEXT_DAMAGED  = NTSTATUS(0xc0030006),
}

enum NTSTATUS RPC_NT_SS_CANNOT_GET_CALL_HANDLE = NTSTATUS(0xc0030008);
enum NTSTATUS RPC_NT_ENUM_VALUE_OUT_OF_RANGE = NTSTATUS(0xc003000a);
enum NTSTATUS RPC_NT_BAD_STUB_DATA = NTSTATUS(0xc003000c);
enum NTSTATUS RPC_NT_NO_MORE_BINDINGS = NTSTATUS(0xc002004a);
enum NTSTATUS EPT_NT_CANT_CREATE = NTSTATUS(0xc002004c);
enum NTSTATUS RPC_NT_NO_INTERFACES = NTSTATUS(0xc002004f);
enum NTSTATUS RPC_NT_BINDING_INCOMPLETE = NTSTATUS(0xc0020051);
enum NTSTATUS RPC_NT_UNSUPPORTED_AUTHN_LEVEL = NTSTATUS(0xc0020053);
enum NTSTATUS RPC_NT_NOT_RPC_ERROR = NTSTATUS(0xc0020055);
enum NTSTATUS RPC_NT_SEC_PKG_ERROR = NTSTATUS(0xc0020057);
enum NTSTATUS RPC_NT_INVALID_ES_ACTION = NTSTATUS(0xc0030059);
enum NTSTATUS RPC_NT_WRONG_STUB_VERSION = NTSTATUS(0xc003005b);
enum NTSTATUS RPC_NT_INVALID_PIPE_OPERATION = NTSTATUS(0xc003005d);

enum : NTSTATUS
{
    RPC_NT_PIPE_CLOSED           = NTSTATUS(0xc003005f),
    RPC_NT_PIPE_DISCIPLINE_ERROR = NTSTATUS(0xc0030060),
    RPC_NT_PIPE_EMPTY            = NTSTATUS(0xc0030061),
    RPC_NT_INVALID_ASYNC_HANDLE  = NTSTATUS(0xc0020062),
    RPC_NT_INVALID_ASYNC_CALL    = NTSTATUS(0xc0020063),
}

enum NTSTATUS RPC_NT_COOKIE_AUTH_FAILED = NTSTATUS(0xc0020065);

enum : NTSTATUS
{
    STATUS_ACPI_INVALID_OPCODE           = NTSTATUS(0xc0140001),
    STATUS_ACPI_STACK_OVERFLOW           = NTSTATUS(0xc0140002),
    STATUS_ACPI_ASSERT_FAILED            = NTSTATUS(0xc0140003),
    STATUS_ACPI_INVALID_INDEX            = NTSTATUS(0xc0140004),
    STATUS_ACPI_INVALID_ARGUMENT         = NTSTATUS(0xc0140005),
    STATUS_ACPI_FATAL                    = NTSTATUS(0xc0140006),
    STATUS_ACPI_INVALID_SUPERNAME        = NTSTATUS(0xc0140007),
    STATUS_ACPI_INVALID_ARGTYPE          = NTSTATUS(0xc0140008),
    STATUS_ACPI_INVALID_OBJTYPE          = NTSTATUS(0xc0140009),
    STATUS_ACPI_INVALID_TARGETTYPE       = NTSTATUS(0xc014000a),
    STATUS_ACPI_INCORRECT_ARGUMENT_COUNT = NTSTATUS(0xc014000b),
}

enum : NTSTATUS
{
    STATUS_ACPI_INVALID_EVENTTYPE   = NTSTATUS(0xc014000d),
    STATUS_ACPI_HANDLER_COLLISION   = NTSTATUS(0xc014000e),
    STATUS_ACPI_INVALID_DATA        = NTSTATUS(0xc014000f),
    STATUS_ACPI_INVALID_REGION      = NTSTATUS(0xc0140010),
    STATUS_ACPI_INVALID_ACCESS_SIZE = NTSTATUS(0xc0140011),
}

enum NTSTATUS STATUS_ACPI_ALREADY_INITIALIZED = NTSTATUS(0xc0140013);
enum NTSTATUS STATUS_ACPI_INVALID_MUTEX_LEVEL = NTSTATUS(0xc0140015);

enum : NTSTATUS
{
    STATUS_ACPI_MUTEX_NOT_OWNER    = NTSTATUS(0xc0140017),
    STATUS_ACPI_RS_ACCESS          = NTSTATUS(0xc0140018),
    STATUS_ACPI_INVALID_TABLE      = NTSTATUS(0xc0140019),
    STATUS_ACPI_REG_HANDLER_FAILED = NTSTATUS(0xc0140020),
}

enum NTSTATUS STATUS_CTX_WINSTATION_NAME_INVALID = NTSTATUS(0xc00a0001);

enum : NTSTATUS
{
    STATUS_CTX_PD_NOT_FOUND        = NTSTATUS(0xc00a0003),
    STATUS_CTX_CDM_CONNECT         = NTSTATUS(0x400a0004),
    STATUS_CTX_CDM_DISCONNECT      = NTSTATUS(0x400a0005),
    STATUS_CTX_CLOSE_PENDING       = NTSTATUS(0xc00a0006),
    STATUS_CTX_NO_OUTBUF           = NTSTATUS(0xc00a0007),
    STATUS_CTX_MODEM_INF_NOT_FOUND = NTSTATUS(0xc00a0008),
}

enum : NTSTATUS
{
    STATUS_CTX_RESPONSE_ERROR             = NTSTATUS(0xc00a000a),
    STATUS_CTX_MODEM_RESPONSE_TIMEOUT     = NTSTATUS(0xc00a000b),
    STATUS_CTX_MODEM_RESPONSE_NO_CARRIER  = NTSTATUS(0xc00a000c),
    STATUS_CTX_MODEM_RESPONSE_NO_DIALTONE = NTSTATUS(0xc00a000d),
    STATUS_CTX_MODEM_RESPONSE_BUSY        = NTSTATUS(0xc00a000e),
    STATUS_CTX_MODEM_RESPONSE_VOICE       = NTSTATUS(0xc00a000f),
}

enum : NTSTATUS
{
    STATUS_CTX_LICENSE_CLIENT_INVALID    = NTSTATUS(0xc00a0012),
    STATUS_CTX_LICENSE_NOT_AVAILABLE     = NTSTATUS(0xc00a0013),
    STATUS_CTX_LICENSE_EXPIRED           = NTSTATUS(0xc00a0014),
    STATUS_CTX_WINSTATION_NOT_FOUND      = NTSTATUS(0xc00a0015),
    STATUS_CTX_WINSTATION_NAME_COLLISION = NTSTATUS(0xc00a0016),
    STATUS_CTX_WINSTATION_BUSY           = NTSTATUS(0xc00a0017),
    STATUS_CTX_BAD_VIDEO_MODE            = NTSTATUS(0xc00a0018),
    STATUS_CTX_GRAPHICS_INVALID          = NTSTATUS(0xc00a0022),
    STATUS_CTX_NOT_CONSOLE               = NTSTATUS(0xc00a0024),
    STATUS_CTX_CLIENT_QUERY_TIMEOUT      = NTSTATUS(0xc00a0026),
}

enum : NTSTATUS
{
    STATUS_CTX_CONSOLE_CONNECT          = NTSTATUS(0xc00a0028),
    STATUS_CTX_SHADOW_DENIED            = NTSTATUS(0xc00a002a),
    STATUS_CTX_WINSTATION_ACCESS_DENIED = NTSTATUS(0xc00a002b),
}

enum : NTSTATUS
{
    STATUS_CTX_WD_NOT_FOUND    = NTSTATUS(0xc00a002f),
    STATUS_CTX_SHADOW_INVALID  = NTSTATUS(0xc00a0030),
    STATUS_CTX_SHADOW_DISABLED = NTSTATUS(0xc00a0031),
}

enum : NTSTATUS
{
    STATUS_CTX_CLIENT_LICENSE_NOT_SET = NTSTATUS(0xc00a0033),
    STATUS_CTX_CLIENT_LICENSE_IN_USE  = NTSTATUS(0xc00a0034),
}

enum NTSTATUS STATUS_CTX_SHADOW_NOT_RUNNING = NTSTATUS(0xc00a0036);
enum NTSTATUS STATUS_CTX_SECURITY_LAYER_ERROR = NTSTATUS(0xc00a0038);
enum NTSTATUS STATUS_TS_VIDEO_SUBSYSTEM_ERROR = NTSTATUS(0xc00a003a);
enum NTSTATUS STATUS_PNP_TRANSLATION_FAILED = NTSTATUS(0xc0040036);
enum NTSTATUS STATUS_PNP_INVALID_ID = NTSTATUS(0xc0040038);

enum : NTSTATUS
{
    STATUS_MUI_FILE_NOT_FOUND                = NTSTATUS(0xc00b0001),
    STATUS_MUI_INVALID_FILE                  = NTSTATUS(0xc00b0002),
    STATUS_MUI_INVALID_RC_CONFIG             = NTSTATUS(0xc00b0003),
    STATUS_MUI_INVALID_LOCALE_NAME           = NTSTATUS(0xc00b0004),
    STATUS_MUI_INVALID_ULTIMATEFALLBACK_NAME = NTSTATUS(0xc00b0005),
}

enum NTSTATUS STATUS_RESOURCE_ENUM_USER_STOP = NTSTATUS(0xc00b0007);
enum NTSTATUS STATUS_FLT_CONTEXT_ALREADY_DEFINED = NTSTATUS(0xc01c0002);
enum NTSTATUS STATUS_FLT_DISALLOW_FAST_IO = NTSTATUS(0xc01c0004);
enum NTSTATUS STATUS_FLT_INVALID_NAME_REQUEST = NTSTATUS(0xc01c0005);

enum : NTSTATUS
{
    STATUS_FLT_NOT_INITIALIZED        = NTSTATUS(0xc01c0007),
    STATUS_FLT_FILTER_NOT_READY       = NTSTATUS(0xc01c0008),
    STATUS_FLT_POST_OPERATION_CLEANUP = NTSTATUS(0xc01c0009),
}

enum : NTSTATUS
{
    STATUS_FLT_DELETING_OBJECT       = NTSTATUS(0xc01c000b),
    STATUS_FLT_MUST_BE_NONPAGED_POOL = NTSTATUS(0xc01c000c),
}

enum : NTSTATUS
{
    STATUS_FLT_CBDQ_DISABLED               = NTSTATUS(0xc01c000e),
    STATUS_FLT_DO_NOT_ATTACH               = NTSTATUS(0xc01c000f),
    STATUS_FLT_DO_NOT_DETACH               = NTSTATUS(0xc01c0010),
    STATUS_FLT_INSTANCE_ALTITUDE_COLLISION = NTSTATUS(0xc01c0011),
    STATUS_FLT_INSTANCE_NAME_COLLISION     = NTSTATUS(0xc01c0012),
}

enum : NTSTATUS
{
    STATUS_FLT_VOLUME_NOT_FOUND   = NTSTATUS(0xc01c0014),
    STATUS_FLT_INSTANCE_NOT_FOUND = NTSTATUS(0xc01c0015),
}

enum NTSTATUS STATUS_FLT_INVALID_CONTEXT_REGISTRATION = NTSTATUS(0xc01c0017);

enum : NTSTATUS
{
    STATUS_FLT_NO_DEVICE_OBJECT       = NTSTATUS(0xc01c0019),
    STATUS_FLT_VOLUME_ALREADY_MOUNTED = NTSTATUS(0xc01c001a),
}

enum NTSTATUS STATUS_FLT_CONTEXT_ALREADY_LINKED = NTSTATUS(0xc01c001c);
enum NTSTATUS STATUS_FLT_REGISTRATION_BUSY = NTSTATUS(0xc01c0023);
enum NTSTATUS STATUS_SXS_SECTION_NOT_FOUND = NTSTATUS(0xc0150001);
enum NTSTATUS STATUS_SXS_INVALID_ACTCTXDATA_FORMAT = NTSTATUS(0xc0150003);

enum : NTSTATUS
{
    STATUS_SXS_MANIFEST_FORMAT_ERROR = NTSTATUS(0xc0150005),
    STATUS_SXS_MANIFEST_PARSE_ERROR  = NTSTATUS(0xc0150006),
}

enum : NTSTATUS
{
    STATUS_SXS_KEY_NOT_FOUND      = NTSTATUS(0xc0150008),
    STATUS_SXS_VERSION_CONFLICT   = NTSTATUS(0xc0150009),
    STATUS_SXS_WRONG_SECTION_TYPE = NTSTATUS(0xc015000a),
}

enum : NTSTATUS
{
    STATUS_SXS_ASSEMBLY_MISSING           = NTSTATUS(0xc015000c),
    STATUS_SXS_RELEASE_ACTIVATION_CONTEXT = NTSTATUS(0x4015000d),
}

enum NTSTATUS STATUS_SXS_EARLY_DEACTIVATION = NTSTATUS(0xc015000f);
enum NTSTATUS STATUS_SXS_MULTIPLE_DEACTIVATION = NTSTATUS(0xc0150011);
enum NTSTATUS STATUS_SXS_PROCESS_TERMINATION_REQUESTED = NTSTATUS(0xc0150013);

enum : NTSTATUS
{
    STATUS_SXS_CORRUPTION                       = NTSTATUS(0xc0150015),
    STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE = NTSTATUS(0xc0150016),
    STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME  = NTSTATUS(0xc0150017),
}

enum NTSTATUS STATUS_SXS_IDENTITY_PARSE_ERROR = NTSTATUS(0xc0150019);
enum NTSTATUS STATUS_SXS_FILE_HASH_MISMATCH = NTSTATUS(0xc015001b);
enum NTSTATUS STATUS_SXS_IDENTITIES_DIFFERENT = NTSTATUS(0xc015001d);
enum NTSTATUS STATUS_SXS_FILE_NOT_PART_OF_ASSEMBLY = NTSTATUS(0xc015001f);
enum NTSTATUS STATUS_XML_ENCODING_MISMATCH = NTSTATUS(0xc0150021);
enum NTSTATUS STATUS_SXS_SETTING_NOT_REGISTERED = NTSTATUS(0xc0150023);
enum NTSTATUS STATUS_SMI_PRIMITIVE_INSTALLER_FAILED = NTSTATUS(0xc0150025);
enum NTSTATUS STATUS_SXS_FILE_HASH_MISSING = NTSTATUS(0xc0150027);

enum : NTSTATUS
{
    STATUS_CLUSTER_NODE_EXISTS              = NTSTATUS(0xc0130002),
    STATUS_CLUSTER_JOIN_IN_PROGRESS         = NTSTATUS(0xc0130003),
    STATUS_CLUSTER_NODE_NOT_FOUND           = NTSTATUS(0xc0130004),
    STATUS_CLUSTER_LOCAL_NODE_NOT_FOUND     = NTSTATUS(0xc0130005),
    STATUS_CLUSTER_NETWORK_EXISTS           = NTSTATUS(0xc0130006),
    STATUS_CLUSTER_NETWORK_NOT_FOUND        = NTSTATUS(0xc0130007),
    STATUS_CLUSTER_NETINTERFACE_EXISTS      = NTSTATUS(0xc0130008),
    STATUS_CLUSTER_NETINTERFACE_NOT_FOUND   = NTSTATUS(0xc0130009),
    STATUS_CLUSTER_INVALID_REQUEST          = NTSTATUS(0xc013000a),
    STATUS_CLUSTER_INVALID_NETWORK_PROVIDER = NTSTATUS(0xc013000b),
}

enum : NTSTATUS
{
    STATUS_CLUSTER_NODE_UNREACHABLE                  = NTSTATUS(0xc013000d),
    STATUS_CLUSTER_NODE_NOT_MEMBER                   = NTSTATUS(0xc013000e),
    STATUS_CLUSTER_JOIN_NOT_IN_PROGRESS              = NTSTATUS(0xc013000f),
    STATUS_CLUSTER_INVALID_NETWORK                   = NTSTATUS(0xc0130010),
    STATUS_CLUSTER_NO_NET_ADAPTERS                   = NTSTATUS(0xc0130011),
    STATUS_CLUSTER_NODE_UP                           = NTSTATUS(0xc0130012),
    STATUS_CLUSTER_NODE_PAUSED                       = NTSTATUS(0xc0130013),
    STATUS_CLUSTER_NODE_NOT_PAUSED                   = NTSTATUS(0xc0130014),
    STATUS_CLUSTER_NO_SECURITY_CONTEXT               = NTSTATUS(0xc0130015),
    STATUS_CLUSTER_NETWORK_NOT_INTERNAL              = NTSTATUS(0xc0130016),
    STATUS_CLUSTER_POISONED                          = NTSTATUS(0xc0130017),
    STATUS_CLUSTER_NON_CSV_PATH                      = NTSTATUS(0xc0130018),
    STATUS_CLUSTER_CSV_VOLUME_NOT_LOCAL              = NTSTATUS(0xc0130019),
    STATUS_CLUSTER_CSV_READ_OPLOCK_BREAK_IN_PROGRESS = NTSTATUS(0xc0130020),
}

enum : NTSTATUS
{
    STATUS_CLUSTER_CSV_REDIRECTED                    = NTSTATUS(0xc0130022),
    STATUS_CLUSTER_CSV_NOT_REDIRECTED                = NTSTATUS(0xc0130023),
    STATUS_CLUSTER_CSV_VOLUME_DRAINING               = NTSTATUS(0xc0130024),
    STATUS_CLUSTER_CSV_SNAPSHOT_CREATION_IN_PROGRESS = NTSTATUS(0xc0130025),
}

enum NTSTATUS STATUS_CLUSTER_CSV_NO_SNAPSHOTS = NTSTATUS(0xc0130027);

enum : NTSTATUS
{
    STATUS_CLUSTER_CSV_INVALID_HANDLE                = NTSTATUS(0xc0130029),
    STATUS_CLUSTER_CSV_SUPPORTED_ONLY_ON_COORDINATOR = NTSTATUS(0xc0130030),
}

enum NTSTATUS STATUS_TRANSACTIONAL_CONFLICT = NTSTATUS(0xc0190001);
enum NTSTATUS STATUS_TRANSACTION_NOT_ACTIVE = NTSTATUS(0xc0190003);

enum : NTSTATUS
{
    STATUS_RM_NOT_ACTIVE       = NTSTATUS(0xc0190005),
    STATUS_RM_METADATA_CORRUPT = NTSTATUS(0xc0190006),
}

enum NTSTATUS STATUS_DIRECTORY_NOT_RM = NTSTATUS(0xc0190008);
enum NTSTATUS STATUS_TRANSACTIONS_UNSUPPORTED_REMOTE = NTSTATUS(0xc019000a);
enum NTSTATUS STATUS_REMOTE_FILE_VERSION_MISMATCH = NTSTATUS(0xc019000c);
enum NTSTATUS STATUS_TRANSACTION_PROPAGATION_FAILED = NTSTATUS(0xc0190010);

enum : NTSTATUS
{
    STATUS_TRANSACTION_SUPERIOR_EXISTS         = NTSTATUS(0xc0190012),
    STATUS_TRANSACTION_REQUEST_NOT_VALID       = NTSTATUS(0xc0190013),
    STATUS_TRANSACTION_NOT_REQUESTED           = NTSTATUS(0xc0190014),
    STATUS_TRANSACTION_ALREADY_ABORTED         = NTSTATUS(0xc0190015),
    STATUS_TRANSACTION_ALREADY_COMMITTED       = NTSTATUS(0xc0190016),
    STATUS_TRANSACTION_INVALID_MARSHALL_BUFFER = NTSTATUS(0xc0190017),
}

enum NTSTATUS STATUS_LOG_GROWTH_FAILED = NTSTATUS(0xc0190019);

enum : NTSTATUS
{
    STATUS_STREAM_MINIVERSION_NOT_FOUND = NTSTATUS(0xc0190022),
    STATUS_STREAM_MINIVERSION_NOT_VALID = NTSTATUS(0xc0190023),
}

enum NTSTATUS STATUS_CANT_OPEN_MINIVERSION_WITH_MODIFY_INTENT = NTSTATUS(0xc0190025);
enum NTSTATUS STATUS_HANDLE_NO_LONGER_VALID = NTSTATUS(0xc0190028);
enum NTSTATUS STATUS_LOG_CORRUPTION_DETECTED = NTSTATUS(0xc0190030);
enum NTSTATUS STATUS_RM_DISCONNECTED = NTSTATUS(0xc0190032);
enum NTSTATUS STATUS_RECOVERY_NOT_NEEDED = NTSTATUS(0x40190034);
enum NTSTATUS STATUS_FILE_IDENTITY_NOT_PERSISTENT = NTSTATUS(0xc0190036);
enum NTSTATUS STATUS_CANT_CROSS_RM_BOUNDARY = NTSTATUS(0xc0190038);
enum NTSTATUS STATUS_INDOUBT_TRANSACTIONS_EXIST = NTSTATUS(0xc019003a);
enum NTSTATUS STATUS_ROLLBACK_TIMER_EXPIRED = NTSTATUS(0xc019003c);
enum NTSTATUS STATUS_EFS_NOT_ALLOWED_IN_TRANSACTION = NTSTATUS(0xc019003e);
enum NTSTATUS STATUS_TRANSACTED_MAPPING_UNSUPPORTED_REMOTE = NTSTATUS(0xc0190040);

enum : NTSTATUS
{
    STATUS_TRANSACTION_SCOPE_CALLBACKS_NOT_SET = NTSTATUS(0x80190042),
    STATUS_TRANSACTION_REQUIRED_PROMOTION      = NTSTATUS(0xc0190043),
}

enum : NTSTATUS
{
    STATUS_TRANSACTIONS_NOT_FROZEN        = NTSTATUS(0xc0190045),
    STATUS_TRANSACTION_FREEZE_IN_PROGRESS = NTSTATUS(0xc0190046),
}

enum NTSTATUS STATUS_NO_SAVEPOINT_WITH_OPEN_FILES = NTSTATUS(0xc0190048);
enum NTSTATUS STATUS_TM_IDENTITY_MISMATCH = NTSTATUS(0xc019004a);

enum : NTSTATUS
{
    STATUS_CANNOT_ACCEPT_TRANSACTED_WORK = NTSTATUS(0xc019004c),
    STATUS_CANNOT_ABORT_TRANSACTIONS     = NTSTATUS(0xc019004d),
}

enum NTSTATUS STATUS_RESOURCEMANAGER_NOT_FOUND = NTSTATUS(0xc019004f);

enum : NTSTATUS
{
    STATUS_TRANSACTIONMANAGER_NOT_FOUND               = NTSTATUS(0xc0190051),
    STATUS_TRANSACTIONMANAGER_NOT_ONLINE              = NTSTATUS(0xc0190052),
    STATUS_TRANSACTIONMANAGER_RECOVERY_NAME_COLLISION = NTSTATUS(0xc0190053),
}

enum NTSTATUS STATUS_TRANSACTION_OBJECT_EXPIRED = NTSTATUS(0xc0190055);

enum : NTSTATUS
{
    STATUS_TRANSACTION_RESPONSE_NOT_ENLISTED = NTSTATUS(0xc0190057),
    STATUS_TRANSACTION_RECORD_TOO_LONG       = NTSTATUS(0xc0190058),
}

enum NTSTATUS STATUS_OPERATION_NOT_SUPPORTED_IN_TRANSACTION = NTSTATUS(0xc019005a);
enum NTSTATUS STATUS_TRANSACTIONMANAGER_IDENTITY_MISMATCH = NTSTATUS(0xc019005c);

enum : NTSTATUS
{
    STATUS_TRANSACTION_MUST_WRITETHROUGH = NTSTATUS(0xc019005e),
    STATUS_TRANSACTION_NO_SUPERIOR       = NTSTATUS(0xc019005f),
}

enum NTSTATUS STATUS_TRANSACTION_NOT_ENLISTED = NTSTATUS(0xc0190061);

enum : NTSTATUS
{
    STATUS_LOG_SECTOR_INVALID        = NTSTATUS(0xc01a0001),
    STATUS_LOG_SECTOR_PARITY_INVALID = NTSTATUS(0xc01a0002),
    STATUS_LOG_SECTOR_REMAPPED       = NTSTATUS(0xc01a0003),
    STATUS_LOG_BLOCK_INCOMPLETE      = NTSTATUS(0xc01a0004),
    STATUS_LOG_INVALID_RANGE         = NTSTATUS(0xc01a0005),
    STATUS_LOG_BLOCKS_EXHAUSTED      = NTSTATUS(0xc01a0006),
    STATUS_LOG_READ_CONTEXT_INVALID  = NTSTATUS(0xc01a0007),
    STATUS_LOG_RESTART_INVALID       = NTSTATUS(0xc01a0008),
    STATUS_LOG_BLOCK_VERSION         = NTSTATUS(0xc01a0009),
    STATUS_LOG_BLOCK_INVALID         = NTSTATUS(0xc01a000a),
    STATUS_LOG_READ_MODE_INVALID     = NTSTATUS(0xc01a000b),
}

enum : NTSTATUS
{
    STATUS_LOG_METADATA_CORRUPT      = NTSTATUS(0xc01a000d),
    STATUS_LOG_METADATA_INVALID      = NTSTATUS(0xc01a000e),
    STATUS_LOG_METADATA_INCONSISTENT = NTSTATUS(0xc01a000f),
}

enum : NTSTATUS
{
    STATUS_LOG_CANT_DELETE              = NTSTATUS(0xc01a0011),
    STATUS_LOG_CONTAINER_LIMIT_EXCEEDED = NTSTATUS(0xc01a0012),
}

enum : NTSTATUS
{
    STATUS_LOG_POLICY_ALREADY_INSTALLED = NTSTATUS(0xc01a0014),
    STATUS_LOG_POLICY_NOT_INSTALLED     = NTSTATUS(0xc01a0015),
    STATUS_LOG_POLICY_INVALID           = NTSTATUS(0xc01a0016),
    STATUS_LOG_POLICY_CONFLICT          = NTSTATUS(0xc01a0017),
    STATUS_LOG_PINNED_ARCHIVE_TAIL      = NTSTATUS(0xc01a0018),
}

enum NTSTATUS STATUS_LOG_RECORDS_RESERVED_INVALID = NTSTATUS(0xc01a001a);

enum : NTSTATUS
{
    STATUS_LOG_TAIL_INVALID            = NTSTATUS(0xc01a001c),
    STATUS_LOG_FULL                    = NTSTATUS(0xc01a001d),
    STATUS_LOG_MULTIPLEXED             = NTSTATUS(0xc01a001e),
    STATUS_LOG_DEDICATED               = NTSTATUS(0xc01a001f),
    STATUS_LOG_ARCHIVE_NOT_IN_PROGRESS = NTSTATUS(0xc01a0020),
    STATUS_LOG_ARCHIVE_IN_PROGRESS     = NTSTATUS(0xc01a0021),
}

enum NTSTATUS STATUS_LOG_NOT_ENOUGH_CONTAINERS = NTSTATUS(0xc01a0023);
enum NTSTATUS STATUS_LOG_CLIENT_NOT_REGISTERED = NTSTATUS(0xc01a0025);

enum : NTSTATUS
{
    STATUS_LOG_CONTAINER_READ_FAILED   = NTSTATUS(0xc01a0027),
    STATUS_LOG_CONTAINER_WRITE_FAILED  = NTSTATUS(0xc01a0028),
    STATUS_LOG_CONTAINER_OPEN_FAILED   = NTSTATUS(0xc01a0029),
    STATUS_LOG_CONTAINER_STATE_INVALID = NTSTATUS(0xc01a002a),
}

enum : NTSTATUS
{
    STATUS_LOG_PINNED                = NTSTATUS(0xc01a002c),
    STATUS_LOG_METADATA_FLUSH_FAILED = NTSTATUS(0xc01a002d),
}

enum NTSTATUS STATUS_LOG_APPENDED_FLUSH_FAILED = NTSTATUS(0xc01a002f);

enum : NTSTATUS
{
    STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD           = NTSTATUS(0xc01b00ea),
    STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD_RECOVERED = NTSTATUS(0x801b00eb),
}

enum : NTSTATUS
{
    STATUS_MONITOR_NO_DESCRIPTOR             = NTSTATUS(0xc01d0001),
    STATUS_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT = NTSTATUS(0xc01d0002),
}

enum NTSTATUS STATUS_MONITOR_INVALID_STANDARD_TIMING_BLOCK = NTSTATUS(0xc01d0004);

enum : NTSTATUS
{
    STATUS_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK = NTSTATUS(0xc01d0006),
    STATUS_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK = NTSTATUS(0xc01d0007),
}

enum : NTSTATUS
{
    STATUS_MONITOR_INVALID_DETAILED_TIMING_BLOCK = NTSTATUS(0xc01d0009),
    STATUS_MONITOR_INVALID_MANUFACTURE_DATE      = NTSTATUS(0xc01d000a),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INSUFFICIENT_DMA_BUFFER      = NTSTATUS(0xc01e0001),
    STATUS_GRAPHICS_INVALID_DISPLAY_ADAPTER      = NTSTATUS(0xc01e0002),
    STATUS_GRAPHICS_ADAPTER_WAS_RESET            = NTSTATUS(0xc01e0003),
    STATUS_GRAPHICS_INVALID_DRIVER_MODEL         = NTSTATUS(0xc01e0004),
    STATUS_GRAPHICS_PRESENT_MODE_CHANGED         = NTSTATUS(0xc01e0005),
    STATUS_GRAPHICS_PRESENT_OCCLUDED             = NTSTATUS(0xc01e0006),
    STATUS_GRAPHICS_PRESENT_DENIED               = NTSTATUS(0xc01e0007),
    STATUS_GRAPHICS_CANNOTCOLORCONVERT           = NTSTATUS(0xc01e0008),
    STATUS_GRAPHICS_DRIVER_MISMATCH              = NTSTATUS(0xc01e0009),
    STATUS_GRAPHICS_PARTIAL_DATA_POPULATED       = NTSTATUS(0x401e000a),
    STATUS_GRAPHICS_PRESENT_REDIRECTION_DISABLED = NTSTATUS(0xc01e000b),
    STATUS_GRAPHICS_PRESENT_UNOCCLUDED           = NTSTATUS(0xc01e000c),
    STATUS_GRAPHICS_WINDOWDC_NOT_AVAILABLE       = NTSTATUS(0xc01e000d),
    STATUS_GRAPHICS_WINDOWLESS_PRESENT_DISABLED  = NTSTATUS(0xc01e000e),
}

enum NTSTATUS STATUS_GRAPHICS_PRESENT_BUFFER_NOT_BOUND = NTSTATUS(0xc01e0010);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INDIRECT_DISPLAY_ABANDON_SWAPCHAIN = NTSTATUS(0xc01e0012),
    STATUS_GRAPHICS_INDIRECT_DISPLAY_DEVICE_STOPPED    = NTSTATUS(0xc01e0013),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_SETDISPLAYMODE_REQUIRED          = NTSTATUS(0xc01e0019),
    STATUS_GRAPHICS_NO_VIDEO_MEMORY                  = NTSTATUS(0xc01e0100),
    STATUS_GRAPHICS_CANT_LOCK_MEMORY                 = NTSTATUS(0xc01e0101),
    STATUS_GRAPHICS_ALLOCATION_BUSY                  = NTSTATUS(0xc01e0102),
    STATUS_GRAPHICS_TOO_MANY_REFERENCES              = NTSTATUS(0xc01e0103),
    STATUS_GRAPHICS_TRY_AGAIN_LATER                  = NTSTATUS(0xc01e0104),
    STATUS_GRAPHICS_TRY_AGAIN_NOW                    = NTSTATUS(0xc01e0105),
    STATUS_GRAPHICS_ALLOCATION_INVALID               = NTSTATUS(0xc01e0106),
    STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE = NTSTATUS(0xc01e0107),
    STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED = NTSTATUS(0xc01e0108),
}

enum NTSTATUS STATUS_GRAPHICS_INVALID_ALLOCATION_USAGE = NTSTATUS(0xc01e0110);

enum : NTSTATUS
{
    STATUS_GRAPHICS_ALLOCATION_CLOSED           = NTSTATUS(0xc01e0112),
    STATUS_GRAPHICS_INVALID_ALLOCATION_INSTANCE = NTSTATUS(0xc01e0113),
    STATUS_GRAPHICS_INVALID_ALLOCATION_HANDLE   = NTSTATUS(0xc01e0114),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_ALLOCATION_CONTENT_LOST     = NTSTATUS(0xc01e0116),
    STATUS_GRAPHICS_GPU_EXCEPTION_ON_DEVICE     = NTSTATUS(0xc01e0200),
    STATUS_GRAPHICS_SKIP_ALLOCATION_PREPARATION = NTSTATUS(0x401e0201),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED           = NTSTATUS(0xc01e0301),
    STATUS_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED = NTSTATUS(0xc01e0302),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE = NTSTATUS(0xc01e0304),
    STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET = NTSTATUS(0xc01e0305),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_MODE_NOT_PINNED                   = NTSTATUS(0x401e0307),
    STATUS_GRAPHICS_INVALID_VIDPN_SOURCEMODESET       = NTSTATUS(0xc01e0308),
    STATUS_GRAPHICS_INVALID_VIDPN_TARGETMODESET       = NTSTATUS(0xc01e0309),
    STATUS_GRAPHICS_INVALID_FREQUENCY                 = NTSTATUS(0xc01e030a),
    STATUS_GRAPHICS_INVALID_ACTIVE_REGION             = NTSTATUS(0xc01e030b),
    STATUS_GRAPHICS_INVALID_TOTAL_REGION              = NTSTATUS(0xc01e030c),
    STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE = NTSTATUS(0xc01e0310),
    STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE = NTSTATUS(0xc01e0311),
}

enum NTSTATUS STATUS_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY = NTSTATUS(0xc01e0313);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET = NTSTATUS(0xc01e0315),
    STATUS_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET = NTSTATUS(0xc01e0316),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_TARGET_ALREADY_IN_SET      = NTSTATUS(0xc01e0318),
    STATUS_GRAPHICS_INVALID_VIDPN_PRESENT_PATH = NTSTATUS(0xc01e0319),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET = NTSTATUS(0xc01e031b),
    STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE    = NTSTATUS(0xc01e031c),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_NO_PREFERRED_MODE             = NTSTATUS(0x401e031e),
    STATUS_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET = NTSTATUS(0xc01e031f),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_MONITOR_SOURCEMODESET = NTSTATUS(0xc01e0321),
    STATUS_GRAPHICS_INVALID_MONITOR_SOURCE_MODE   = NTSTATUS(0xc01e0322),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_MODE_ID_MUST_BE_UNIQUE                          = NTSTATUS(0xc01e0324),
    STATUS_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION = NTSTATUS(0xc01e0325),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_PATH_NOT_IN_TOPOLOGY                  = NTSTATUS(0xc01e0327),
    STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE = NTSTATUS(0xc01e0328),
    STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET = NTSTATUS(0xc01e0329),
}

enum NTSTATUS STATUS_GRAPHICS_INVALID_MONITORDESCRIPTOR = NTSTATUS(0xc01e032b);

enum : NTSTATUS
{
    STATUS_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET    = NTSTATUS(0xc01e032d),
    STATUS_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE = NTSTATUS(0xc01e032e),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_RESOURCES_NOT_RELATED    = NTSTATUS(0xc01e0330),
    STATUS_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE = NTSTATUS(0xc01e0331),
}

enum NTSTATUS STATUS_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET = NTSTATUS(0xc01e0333);

enum : NTSTATUS
{
    STATUS_GRAPHICS_NO_VIDPNMGR                  = NTSTATUS(0xc01e0335),
    STATUS_GRAPHICS_NO_ACTIVE_VIDPN              = NTSTATUS(0xc01e0336),
    STATUS_GRAPHICS_STALE_VIDPN_TOPOLOGY         = NTSTATUS(0xc01e0337),
    STATUS_GRAPHICS_MONITOR_NOT_CONNECTED        = NTSTATUS(0xc01e0338),
    STATUS_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY       = NTSTATUS(0xc01e0339),
    STATUS_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE  = NTSTATUS(0xc01e033a),
    STATUS_GRAPHICS_INVALID_VISIBLEREGION_SIZE   = NTSTATUS(0xc01e033b),
    STATUS_GRAPHICS_INVALID_STRIDE               = NTSTATUS(0xc01e033c),
    STATUS_GRAPHICS_INVALID_PIXELFORMAT          = NTSTATUS(0xc01e033d),
    STATUS_GRAPHICS_INVALID_COLORBASIS           = NTSTATUS(0xc01e033e),
    STATUS_GRAPHICS_INVALID_PIXELVALUEACCESSMODE = NTSTATUS(0xc01e033f),
}

enum NTSTATUS STATUS_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT = NTSTATUS(0xc01e0341);
enum NTSTATUS STATUS_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN = NTSTATUS(0xc01e0343);
enum NTSTATUS STATUS_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION = NTSTATUS(0xc01e0345);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_GAMMA_RAMP       = NTSTATUS(0xc01e0347),
    STATUS_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED = NTSTATUS(0xc01e0348),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_MODE_NOT_IN_MODESET         = NTSTATUS(0xc01e034a),
    STATUS_GRAPHICS_DATASET_IS_EMPTY            = NTSTATUS(0x401e034b),
    STATUS_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET = NTSTATUS(0x401e034c),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_INVALID_PATH_CONTENT_TYPE   = NTSTATUS(0xc01e034e),
    STATUS_GRAPHICS_INVALID_COPYPROTECTION_TYPE = NTSTATUS(0xc01e034f),
}

enum NTSTATUS STATUS_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED = NTSTATUS(0x401e0351);
enum NTSTATUS STATUS_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED = NTSTATUS(0xc01e0353);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT               = NTSTATUS(0xc01e0355),
    STATUS_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM            = NTSTATUS(0xc01e0356),
    STATUS_GRAPHICS_INVALID_MONITOR_CAPABILITY_ORIGIN         = NTSTATUS(0xc01e0357),
    STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE_CONSTRAINT = NTSTATUS(0xc01e0358),
}

enum NTSTATUS STATUS_GRAPHICS_CANCEL_VIDPN_TOPOLOGY_AUGMENTATION = NTSTATUS(0xc01e035a);

enum : NTSTATUS
{
    STATUS_GRAPHICS_CLIENTVIDPN_NOT_SET               = NTSTATUS(0xc01e035c),
    STATUS_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED = NTSTATUS(0xc01e0400),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_UNKNOWN_CHILD_STATUS      = NTSTATUS(0x401e042f),
    STATUS_GRAPHICS_NOT_A_LINKED_ADAPTER      = NTSTATUS(0xc01e0430),
    STATUS_GRAPHICS_LEADLINK_NOT_ENUMERATED   = NTSTATUS(0xc01e0431),
    STATUS_GRAPHICS_CHAINLINKS_NOT_ENUMERATED = NTSTATUS(0xc01e0432),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_CHAINLINKS_NOT_STARTED    = NTSTATUS(0xc01e0434),
    STATUS_GRAPHICS_CHAINLINKS_NOT_POWERED_ON = NTSTATUS(0xc01e0435),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_LEADLINK_START_DEFERRED     = NTSTATUS(0x401e0437),
    STATUS_GRAPHICS_NOT_POST_DEVICE_DRIVER      = NTSTATUS(0xc01e0438),
    STATUS_GRAPHICS_POLLING_TOO_FREQUENTLY      = NTSTATUS(0x401e0439),
    STATUS_GRAPHICS_START_DEFERRED              = NTSTATUS(0x401e043a),
    STATUS_GRAPHICS_ADAPTER_ACCESS_NOT_EXCLUDED = NTSTATUS(0xc01e043b),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_OPM_NOT_SUPPORTED                = NTSTATUS(0xc01e0500),
    STATUS_GRAPHICS_COPP_NOT_SUPPORTED               = NTSTATUS(0xc01e0501),
    STATUS_GRAPHICS_UAB_NOT_SUPPORTED                = NTSTATUS(0xc01e0502),
    STATUS_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS = NTSTATUS(0xc01e0503),
    STATUS_GRAPHICS_OPM_NO_PROTECTED_OUTPUTS_EXIST   = NTSTATUS(0xc01e0505),
    STATUS_GRAPHICS_OPM_INTERNAL_ERROR               = NTSTATUS(0xc01e050b),
    STATUS_GRAPHICS_OPM_INVALID_HANDLE               = NTSTATUS(0xc01e050c),
    STATUS_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH   = NTSTATUS(0xc01e050e),
}

enum NTSTATUS STATUS_GRAPHICS_OPM_THEATER_MODE_ENABLED = NTSTATUS(0xc01e0510);

enum : NTSTATUS
{
    STATUS_GRAPHICS_OPM_INVALID_SRM                      = NTSTATUS(0xc01e0512),
    STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP     = NTSTATUS(0xc01e0513),
    STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP      = NTSTATUS(0xc01e0514),
    STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA    = NTSTATUS(0xc01e0515),
    STATUS_GRAPHICS_OPM_HDCP_SRM_NEVER_SET               = NTSTATUS(0xc01e0516),
    STATUS_GRAPHICS_OPM_RESOLUTION_TOO_HIGH              = NTSTATUS(0xc01e0517),
    STATUS_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE = NTSTATUS(0xc01e0518),
}

enum NTSTATUS STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_COPP_SEMANTICS = NTSTATUS(0xc01e051c);

enum : NTSTATUS
{
    STATUS_GRAPHICS_OPM_DRIVER_INTERNAL_ERROR                        = NTSTATUS(0xc01e051e),
    STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_OPM_SEMANTICS = NTSTATUS(0xc01e051f),
}

enum NTSTATUS STATUS_GRAPHICS_OPM_INVALID_CONFIGURATION_REQUEST = NTSTATUS(0xc01e0521);

enum : NTSTATUS
{
    STATUS_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST   = NTSTATUS(0xc01e0581),
    STATUS_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA = NTSTATUS(0xc01e0582),
    STATUS_GRAPHICS_I2C_ERROR_RECEIVING_DATA    = NTSTATUS(0xc01e0583),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_DDCCI_INVALID_DATA                                = NTSTATUS(0xc01e0585),
    STATUS_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYTE = NTSTATUS(0xc01e0586),
}

enum : NTSTATUS
{
    STATUS_GRAPHICS_MCA_INTERNAL_ERROR             = NTSTATUS(0xc01e0588),
    STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND  = NTSTATUS(0xc01e0589),
    STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH   = NTSTATUS(0xc01e058a),
    STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM = NTSTATUS(0xc01e058b),
}

enum NTSTATUS STATUS_GRAPHICS_MONITOR_NO_LONGER_EXISTS = NTSTATUS(0xc01e058d);
enum NTSTATUS STATUS_GRAPHICS_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME = NTSTATUS(0xc01e05e1);
enum NTSTATUS STATUS_GRAPHICS_MIRRORING_DEVICES_NOT_SUPPORTED = NTSTATUS(0xc01e05e3);
enum NTSTATUS STATUS_GRAPHICS_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE = NTSTATUS(0xc01e05e5);

enum : NTSTATUS
{
    STATUS_GRAPHICS_INTERNAL_ERROR                  = NTSTATUS(0xc01e05e7),
    STATUS_GRAPHICS_SESSION_TYPE_CHANGE_IN_PROGRESS = NTSTATUS(0xc01e05e8),
}

enum NTSTATUS STATUS_GRAPHICS_UEFI_FRAME_BUFFER_NOT_FOUND = NTSTATUS(0xc01e0601);
enum NTSTATUS STATUS_CAMERA_INSUFFICIENT_BANDWIDTH = NTSTATUS(0xc01f0001);

enum : NTSTATUS
{
    STATUS_FVE_NOT_ENCRYPTED      = NTSTATUS(0xc0210001),
    STATUS_FVE_BAD_INFORMATION    = NTSTATUS(0xc0210002),
    STATUS_FVE_TOO_SMALL          = NTSTATUS(0xc0210003),
    STATUS_FVE_FAILED_WRONG_FS    = NTSTATUS(0xc0210004),
    STATUS_FVE_BAD_PARTITION_SIZE = NTSTATUS(0xc0210005),
}

enum : NTSTATUS
{
    STATUS_FVE_FS_MOUNTED         = NTSTATUS(0xc0210007),
    STATUS_FVE_NO_LICENSE         = NTSTATUS(0xc0210008),
    STATUS_FVE_ACTION_NOT_ALLOWED = NTSTATUS(0xc0210009),
}

enum : NTSTATUS
{
    STATUS_FVE_VOLUME_NOT_BOUND  = NTSTATUS(0xc021000b),
    STATUS_FVE_NOT_DATA_VOLUME   = NTSTATUS(0xc021000c),
    STATUS_FVE_CONV_READ_ERROR   = NTSTATUS(0xc021000d),
    STATUS_FVE_CONV_WRITE_ERROR  = NTSTATUS(0xc021000e),
    STATUS_FVE_OVERLAPPED_UPDATE = NTSTATUS(0xc021000f),
}

enum NTSTATUS STATUS_FVE_FAILED_AUTHENTICATION = NTSTATUS(0xc0210011);

enum : NTSTATUS
{
    STATUS_FVE_KEYFILE_NOT_FOUND        = NTSTATUS(0xc0210013),
    STATUS_FVE_KEYFILE_INVALID          = NTSTATUS(0xc0210014),
    STATUS_FVE_KEYFILE_NO_VMK           = NTSTATUS(0xc0210015),
    STATUS_FVE_TPM_DISABLED             = NTSTATUS(0xc0210016),
    STATUS_FVE_TPM_SRK_AUTH_NOT_ZERO    = NTSTATUS(0xc0210017),
    STATUS_FVE_TPM_INVALID_PCR          = NTSTATUS(0xc0210018),
    STATUS_FVE_TPM_NO_VMK               = NTSTATUS(0xc0210019),
    STATUS_FVE_PIN_INVALID              = NTSTATUS(0xc021001a),
    STATUS_FVE_AUTH_INVALID_APPLICATION = NTSTATUS(0xc021001b),
    STATUS_FVE_AUTH_INVALID_CONFIG      = NTSTATUS(0xc021001c),
}

enum : NTSTATUS
{
    STATUS_FVE_DRY_RUN_FAILED       = NTSTATUS(0xc021001e),
    STATUS_FVE_BAD_METADATA_POINTER = NTSTATUS(0xc021001f),
}

enum : NTSTATUS
{
    STATUS_FVE_REBOOT_REQUIRED          = NTSTATUS(0xc0210021),
    STATUS_FVE_RAW_ACCESS               = NTSTATUS(0xc0210022),
    STATUS_FVE_RAW_BLOCKED              = NTSTATUS(0xc0210023),
    STATUS_FVE_NO_AUTOUNLOCK_MASTER_KEY = NTSTATUS(0xc0210024),
}

enum NTSTATUS STATUS_FVE_NO_FEATURE_LICENSE = NTSTATUS(0xc0210026);
enum NTSTATUS STATUS_FVE_CONV_RECOVERY_FAILED = NTSTATUS(0xc0210028);
enum NTSTATUS STATUS_FVE_INVALID_DATUM_TYPE = NTSTATUS(0xc021002a);

enum : NTSTATUS
{
    STATUS_FVE_ENH_PIN_INVALID                           = NTSTATUS(0xc0210031),
    STATUS_FVE_FULL_ENCRYPTION_NOT_ALLOWED_ON_TP_STORAGE = NTSTATUS(0xc0210032),
}

enum : NTSTATUS
{
    STATUS_FVE_NOT_ALLOWED_ON_CSV_STACK                = NTSTATUS(0xc0210034),
    STATUS_FVE_NOT_ALLOWED_ON_CLUSTER                  = NTSTATUS(0xc0210035),
    STATUS_FVE_NOT_ALLOWED_TO_UPGRADE_WHILE_CONVERTING = NTSTATUS(0xc0210036),
}

enum NTSTATUS STATUS_FVE_EDRIVE_DRY_RUN_FAILED = NTSTATUS(0xc0210038);
enum NTSTATUS STATUS_FVE_SECUREBOOT_CONFIG_CHANGE = NTSTATUS(0xc021003a);
enum NTSTATUS STATUS_FVE_VOLUME_EXTEND_PREVENTS_EOW_DECRYPT = NTSTATUS(0xc021003c);

enum : NTSTATUS
{
    STATUS_FVE_PROTECTION_DISABLED           = NTSTATUS(0xc021003e),
    STATUS_FVE_PROTECTION_CANNOT_BE_DISABLED = NTSTATUS(0xc021003f),
}

enum NTSTATUS STATUS_FVE_EDRIVE_BAND_ENUMERATION_FAILED = NTSTATUS(0xc0210041);

enum : NTSTATUS
{
    STATUS_FVE_DATASET_FULL                   = NTSTATUS(0xc0210043),
    STATUS_FVE_METADATA_FULL                  = NTSTATUS(0xc0210044),
    STATUS_FVE_SUSPEND_PROTECTION_NOT_ALLOWED = NTSTATUS(0xc0210045),
}

enum NTSTATUS STATUS_FVE_DATASET_TPM_DATUMS_INCONSISTENT = NTSTATUS(0xc0210047);
enum NTSTATUS STATUS_FVE_SECURE_BOOT_BINDING_DATA_OUT_OF_SYNC = NTSTATUS(0xc0210049);
enum NTSTATUS STATUS_FVE_BAD_TPM_DATUM_ASSOCIATION = NTSTATUS(0xc021004b);
enum NTSTATUS STATUS_FVE_MATCHING_PCRS_TPM_FAILURE = NTSTATUS(0xc021004d);

enum : NTSTATUS
{
    STATUS_FVE_TPM_NONEXISTENT           = NTSTATUS(0xc021004f),
    STATUS_FVE_NO_PCR_BOOT_LOCK_BOUNDARY = NTSTATUS(0xc0210050),
}

enum NTSTATUS STATUS_FVE_FW_UPDATE_TPM_BINDINGS_NOT_REFRESHED = NTSTATUS(0xc0210052);
enum NTSTATUS STATUS_FVE_TOO_MANY_TPM_BINDINGS = NTSTATUS(0xc0210054);
enum NTSTATUS STATUS_FVE_ORPHANED_PCR_DIGEST_DATUM = NTSTATUS(0xc0210056);
enum NTSTATUS STATUS_FVE_NO_MATCHING_TPM_BINDINGS = NTSTATUS(0xc0210058);

enum : NTSTATUS
{
    STATUS_FVE_NO_TPM_BINDINGS             = NTSTATUS(0xc021005a),
    STATUS_FVE_FW_UPDATE_PCRS_BLOCK        = NTSTATUS(0xc021005c),
    STATUS_FVE_FW_UPDATE_PCRS_NOT_EXCLUDED = NTSTATUS(0xc021005d),
}

enum : NTSTATUS
{
    STATUS_FVE_HARDWARE_CRYPTO_ACCELERATOR_NOT_FIPS_COMPLIANT = NTSTATUS(0xc021005f),
    STATUS_FVE_HARDWARE_CRYPTO_KEY_MANAGER_NOT_FIPS_COMPLIANT = NTSTATUS(0xc0210060),
}

enum : NTSTATUS
{
    STATUS_FWP_CALLOUT_NOT_FOUND   = NTSTATUS(0xc0220001),
    STATUS_FWP_CONDITION_NOT_FOUND = NTSTATUS(0xc0220002),
}

enum : NTSTATUS
{
    STATUS_FWP_LAYER_NOT_FOUND            = NTSTATUS(0xc0220004),
    STATUS_FWP_PROVIDER_NOT_FOUND         = NTSTATUS(0xc0220005),
    STATUS_FWP_PROVIDER_CONTEXT_NOT_FOUND = NTSTATUS(0xc0220006),
}

enum : NTSTATUS
{
    STATUS_FWP_NOT_FOUND                   = NTSTATUS(0xc0220008),
    STATUS_FWP_ALREADY_EXISTS              = NTSTATUS(0xc0220009),
    STATUS_FWP_IN_USE                      = NTSTATUS(0xc022000a),
    STATUS_FWP_DYNAMIC_SESSION_IN_PROGRESS = NTSTATUS(0xc022000b),
}

enum NTSTATUS STATUS_FWP_NO_TXN_IN_PROGRESS = NTSTATUS(0xc022000d);

enum : NTSTATUS
{
    STATUS_FWP_TXN_ABORTED         = NTSTATUS(0xc022000f),
    STATUS_FWP_SESSION_ABORTED     = NTSTATUS(0xc0220010),
    STATUS_FWP_INCOMPATIBLE_TXN    = NTSTATUS(0xc0220011),
    STATUS_FWP_TIMEOUT             = NTSTATUS(0xc0220012),
    STATUS_FWP_NET_EVENTS_DISABLED = NTSTATUS(0xc0220013),
}

enum : NTSTATUS
{
    STATUS_FWP_KM_CLIENTS_ONLY   = NTSTATUS(0xc0220015),
    STATUS_FWP_LIFETIME_MISMATCH = NTSTATUS(0xc0220016),
}

enum NTSTATUS STATUS_FWP_TOO_MANY_CALLOUTS = NTSTATUS(0xc0220018);

enum : NTSTATUS
{
    STATUS_FWP_TRAFFIC_MISMATCH      = NTSTATUS(0xc022001a),
    STATUS_FWP_INCOMPATIBLE_SA_STATE = NTSTATUS(0xc022001b),
}

enum : NTSTATUS
{
    STATUS_FWP_INVALID_ENUMERATOR = NTSTATUS(0xc022001d),
    STATUS_FWP_INVALID_FLAGS      = NTSTATUS(0xc022001e),
    STATUS_FWP_INVALID_NET_MASK   = NTSTATUS(0xc022001f),
    STATUS_FWP_INVALID_RANGE      = NTSTATUS(0xc0220020),
    STATUS_FWP_INVALID_INTERVAL   = NTSTATUS(0xc0220021),
    STATUS_FWP_ZERO_LENGTH_ARRAY  = NTSTATUS(0xc0220022),
}

enum : NTSTATUS
{
    STATUS_FWP_INVALID_ACTION_TYPE = NTSTATUS(0xc0220024),
    STATUS_FWP_INVALID_WEIGHT      = NTSTATUS(0xc0220025),
    STATUS_FWP_MATCH_TYPE_MISMATCH = NTSTATUS(0xc0220026),
}

enum : NTSTATUS
{
    STATUS_FWP_OUT_OF_BOUNDS                     = NTSTATUS(0xc0220028),
    STATUS_FWP_RESERVED                          = NTSTATUS(0xc0220029),
    STATUS_FWP_DUPLICATE_CONDITION               = NTSTATUS(0xc022002a),
    STATUS_FWP_DUPLICATE_KEYMOD                  = NTSTATUS(0xc022002b),
    STATUS_FWP_ACTION_INCOMPATIBLE_WITH_LAYER    = NTSTATUS(0xc022002c),
    STATUS_FWP_ACTION_INCOMPATIBLE_WITH_SUBLAYER = NTSTATUS(0xc022002d),
}

enum NTSTATUS STATUS_FWP_CONTEXT_INCOMPATIBLE_WITH_CALLOUT = NTSTATUS(0xc022002f);
enum NTSTATUS STATUS_FWP_INCOMPATIBLE_DH_GROUP = NTSTATUS(0xc0220031);

enum : NTSTATUS
{
    STATUS_FWP_NEVER_MATCH               = NTSTATUS(0xc0220033),
    STATUS_FWP_PROVIDER_CONTEXT_MISMATCH = NTSTATUS(0xc0220034),
}

enum NTSTATUS STATUS_FWP_TOO_MANY_SUBLAYERS = NTSTATUS(0xc0220036);

enum : NTSTATUS
{
    STATUS_FWP_INVALID_AUTH_TRANSFORM   = NTSTATUS(0xc0220038),
    STATUS_FWP_INVALID_CIPHER_TRANSFORM = NTSTATUS(0xc0220039),
}

enum NTSTATUS STATUS_FWP_INVALID_TRANSFORM_COMBINATION = NTSTATUS(0xc022003b);
enum NTSTATUS STATUS_FWP_INVALID_TUNNEL_ENDPOINT = NTSTATUS(0xc022003d);

enum : NTSTATUS
{
    STATUS_FWP_KEY_DICTATOR_ALREADY_REGISTERED       = NTSTATUS(0xc022003f),
    STATUS_FWP_KEY_DICTATION_INVALID_KEYING_MATERIAL = NTSTATUS(0xc0220040),
}

enum : NTSTATUS
{
    STATUS_FWP_INVALID_DNS_NAME   = NTSTATUS(0xc0220042),
    STATUS_FWP_STILL_ON           = NTSTATUS(0xc0220043),
    STATUS_FWP_IKEEXT_NOT_RUNNING = NTSTATUS(0xc0220044),
}

enum : NTSTATUS
{
    STATUS_FWP_INJECT_HANDLE_CLOSING = NTSTATUS(0xc0220101),
    STATUS_FWP_INJECT_HANDLE_STALE   = NTSTATUS(0xc0220102),
}

enum NTSTATUS STATUS_FWP_DROP_NOICMP = NTSTATUS(0xc0220104);

enum : NTSTATUS
{
    STATUS_NDIS_BAD_VERSION         = NTSTATUS(0xc0230004),
    STATUS_NDIS_BAD_CHARACTERISTICS = NTSTATUS(0xc0230005),
}

enum : NTSTATUS
{
    STATUS_NDIS_OPEN_FAILED         = NTSTATUS(0xc0230007),
    STATUS_NDIS_DEVICE_FAILED       = NTSTATUS(0xc0230008),
    STATUS_NDIS_MULTICAST_FULL      = NTSTATUS(0xc0230009),
    STATUS_NDIS_MULTICAST_EXISTS    = NTSTATUS(0xc023000a),
    STATUS_NDIS_MULTICAST_NOT_FOUND = NTSTATUS(0xc023000b),
}

enum : NTSTATUS
{
    STATUS_NDIS_RESET_IN_PROGRESS    = NTSTATUS(0xc023000d),
    STATUS_NDIS_NOT_SUPPORTED        = NTSTATUS(0xc02300bb),
    STATUS_NDIS_INVALID_PACKET       = NTSTATUS(0xc023000f),
    STATUS_NDIS_ADAPTER_NOT_READY    = NTSTATUS(0xc0230011),
    STATUS_NDIS_INVALID_LENGTH       = NTSTATUS(0xc0230014),
    STATUS_NDIS_INVALID_DATA         = NTSTATUS(0xc0230015),
    STATUS_NDIS_BUFFER_TOO_SHORT     = NTSTATUS(0xc0230016),
    STATUS_NDIS_INVALID_OID          = NTSTATUS(0xc0230017),
    STATUS_NDIS_ADAPTER_REMOVED      = NTSTATUS(0xc0230018),
    STATUS_NDIS_UNSUPPORTED_MEDIA    = NTSTATUS(0xc0230019),
    STATUS_NDIS_GROUP_ADDRESS_IN_USE = NTSTATUS(0xc023001a),
}

enum NTSTATUS STATUS_NDIS_ERROR_READING_FILE = NTSTATUS(0xc023001c);

enum : NTSTATUS
{
    STATUS_NDIS_RESOURCE_CONFLICT  = NTSTATUS(0xc023001e),
    STATUS_NDIS_MEDIA_DISCONNECTED = NTSTATUS(0xc023001f),
}

enum NTSTATUS STATUS_NDIS_INVALID_DEVICE_REQUEST = NTSTATUS(0xc0230010);
enum NTSTATUS STATUS_NDIS_INTERFACE_NOT_FOUND = NTSTATUS(0xc023002b);

enum : NTSTATUS
{
    STATUS_NDIS_INVALID_PORT       = NTSTATUS(0xc023002d),
    STATUS_NDIS_INVALID_PORT_STATE = NTSTATUS(0xc023002e),
}

enum : NTSTATUS
{
    STATUS_NDIS_REINIT_REQUIRED           = NTSTATUS(0xc0230030),
    STATUS_NDIS_NO_QUEUES                 = NTSTATUS(0xc0230031),
    STATUS_NDIS_DOT11_AUTO_CONFIG_ENABLED = NTSTATUS(0xc0232000),
    STATUS_NDIS_DOT11_MEDIA_IN_USE        = NTSTATUS(0xc0232001),
    STATUS_NDIS_DOT11_POWER_STATE_INVALID = NTSTATUS(0xc0232002),
}

enum NTSTATUS STATUS_NDIS_PM_PROTOCOL_OFFLOAD_LIST_FULL = NTSTATUS(0xc0232004);

enum : NTSTATUS
{
    STATUS_NDIS_DOT11_AP_BAND_CURRENTLY_NOT_AVAILABLE = NTSTATUS(0xc0232006),
    STATUS_NDIS_DOT11_AP_CHANNEL_NOT_ALLOWED          = NTSTATUS(0xc0232007),
    STATUS_NDIS_DOT11_AP_BAND_NOT_ALLOWED             = NTSTATUS(0xc0232008),
    STATUS_NDIS_DOT11_AP_RADIO_RESTRICTION            = NTSTATUS(0xc0232009),
}

enum : NTSTATUS
{
    STATUS_NDIS_OFFLOAD_POLICY              = NTSTATUS(0xc023100f),
    STATUS_NDIS_OFFLOAD_CONNECTION_REJECTED = NTSTATUS(0xc0231012),
    STATUS_NDIS_OFFLOAD_PATH_REJECTED       = NTSTATUS(0xc0231013),
}

enum : NTSTATUS
{
    STATUS_TPM_AUTHFAIL          = NTSTATUS(0xc0290001),
    STATUS_TPM_BADINDEX          = NTSTATUS(0xc0290002),
    STATUS_TPM_BAD_PARAMETER     = NTSTATUS(0xc0290003),
    STATUS_TPM_AUDITFAILURE      = NTSTATUS(0xc0290004),
    STATUS_TPM_CLEAR_DISABLED    = NTSTATUS(0xc0290005),
    STATUS_TPM_DEACTIVATED       = NTSTATUS(0xc0290006),
    STATUS_TPM_DISABLED          = NTSTATUS(0xc0290007),
    STATUS_TPM_DISABLED_CMD      = NTSTATUS(0xc0290008),
    STATUS_TPM_FAIL              = NTSTATUS(0xc0290009),
    STATUS_TPM_BAD_ORDINAL       = NTSTATUS(0xc029000a),
    STATUS_TPM_INSTALL_DISABLED  = NTSTATUS(0xc029000b),
    STATUS_TPM_INVALID_KEYHANDLE = NTSTATUS(0xc029000c),
}

enum NTSTATUS STATUS_TPM_INAPPROPRIATE_ENC = NTSTATUS(0xc029000e);

enum : NTSTATUS
{
    STATUS_TPM_INVALID_PCR_INFO   = NTSTATUS(0xc0290010),
    STATUS_TPM_NOSPACE            = NTSTATUS(0xc0290011),
    STATUS_TPM_NOSRK              = NTSTATUS(0xc0290012),
    STATUS_TPM_NOTSEALED_BLOB     = NTSTATUS(0xc0290013),
    STATUS_TPM_OWNER_SET          = NTSTATUS(0xc0290014),
    STATUS_TPM_RESOURCES          = NTSTATUS(0xc0290015),
    STATUS_TPM_SHORTRANDOM        = NTSTATUS(0xc0290016),
    STATUS_TPM_SIZE               = NTSTATUS(0xc0290017),
    STATUS_TPM_WRONGPCRVAL        = NTSTATUS(0xc0290018),
    STATUS_TPM_BAD_PARAM_SIZE     = NTSTATUS(0xc0290019),
    STATUS_TPM_SHA_THREAD         = NTSTATUS(0xc029001a),
    STATUS_TPM_SHA_ERROR          = NTSTATUS(0xc029001b),
    STATUS_TPM_FAILEDSELFTEST     = NTSTATUS(0xc029001c),
    STATUS_TPM_AUTH2FAIL          = NTSTATUS(0xc029001d),
    STATUS_TPM_BADTAG             = NTSTATUS(0xc029001e),
    STATUS_TPM_IOERROR            = NTSTATUS(0xc029001f),
    STATUS_TPM_ENCRYPT_ERROR      = NTSTATUS(0xc0290020),
    STATUS_TPM_DECRYPT_ERROR      = NTSTATUS(0xc0290021),
    STATUS_TPM_INVALID_AUTHHANDLE = NTSTATUS(0xc0290022),
}

enum : NTSTATUS
{
    STATUS_TPM_INVALID_KEYUSAGE  = NTSTATUS(0xc0290024),
    STATUS_TPM_WRONG_ENTITYTYPE  = NTSTATUS(0xc0290025),
    STATUS_TPM_INVALID_POSTINIT  = NTSTATUS(0xc0290026),
    STATUS_TPM_INAPPROPRIATE_SIG = NTSTATUS(0xc0290027),
}

enum : NTSTATUS
{
    STATUS_TPM_BAD_MIGRATION     = NTSTATUS(0xc0290029),
    STATUS_TPM_BAD_SCHEME        = NTSTATUS(0xc029002a),
    STATUS_TPM_BAD_DATASIZE      = NTSTATUS(0xc029002b),
    STATUS_TPM_BAD_MODE          = NTSTATUS(0xc029002c),
    STATUS_TPM_BAD_PRESENCE      = NTSTATUS(0xc029002d),
    STATUS_TPM_BAD_VERSION       = NTSTATUS(0xc029002e),
    STATUS_TPM_NO_WRAP_TRANSPORT = NTSTATUS(0xc029002f),
}

enum NTSTATUS STATUS_TPM_AUDITFAIL_SUCCESSFUL = NTSTATUS(0xc0290031);

enum : NTSTATUS
{
    STATUS_TPM_NOTLOCAL          = NTSTATUS(0xc0290033),
    STATUS_TPM_BAD_TYPE          = NTSTATUS(0xc0290034),
    STATUS_TPM_INVALID_RESOURCE  = NTSTATUS(0xc0290035),
    STATUS_TPM_NOTFIPS           = NTSTATUS(0xc0290036),
    STATUS_TPM_INVALID_FAMILY    = NTSTATUS(0xc0290037),
    STATUS_TPM_NO_NV_PERMISSION  = NTSTATUS(0xc0290038),
    STATUS_TPM_REQUIRES_SIGN     = NTSTATUS(0xc0290039),
    STATUS_TPM_KEY_NOTSUPPORTED  = NTSTATUS(0xc029003a),
    STATUS_TPM_AUTH_CONFLICT     = NTSTATUS(0xc029003b),
    STATUS_TPM_AREA_LOCKED       = NTSTATUS(0xc029003c),
    STATUS_TPM_BAD_LOCALITY      = NTSTATUS(0xc029003d),
    STATUS_TPM_READ_ONLY         = NTSTATUS(0xc029003e),
    STATUS_TPM_PER_NOWRITE       = NTSTATUS(0xc029003f),
    STATUS_TPM_FAMILYCOUNT       = NTSTATUS(0xc0290040),
    STATUS_TPM_WRITE_LOCKED      = NTSTATUS(0xc0290041),
    STATUS_TPM_BAD_ATTRIBUTES    = NTSTATUS(0xc0290042),
    STATUS_TPM_INVALID_STRUCTURE = NTSTATUS(0xc0290043),
}

enum : NTSTATUS
{
    STATUS_TPM_BAD_COUNTER            = NTSTATUS(0xc0290045),
    STATUS_TPM_NOT_FULLWRITE          = NTSTATUS(0xc0290046),
    STATUS_TPM_CONTEXT_GAP            = NTSTATUS(0xc0290047),
    STATUS_TPM_MAXNVWRITES            = NTSTATUS(0xc0290048),
    STATUS_TPM_NOOPERATOR             = NTSTATUS(0xc0290049),
    STATUS_TPM_RESOURCEMISSING        = NTSTATUS(0xc029004a),
    STATUS_TPM_DELEGATE_LOCK          = NTSTATUS(0xc029004b),
    STATUS_TPM_DELEGATE_FAMILY        = NTSTATUS(0xc029004c),
    STATUS_TPM_DELEGATE_ADMIN         = NTSTATUS(0xc029004d),
    STATUS_TPM_TRANSPORT_NOTEXCLUSIVE = NTSTATUS(0xc029004e),
}

enum : NTSTATUS
{
    STATUS_TPM_DAA_RESOURCES          = NTSTATUS(0xc0290050),
    STATUS_TPM_DAA_INPUT_DATA0        = NTSTATUS(0xc0290051),
    STATUS_TPM_DAA_INPUT_DATA1        = NTSTATUS(0xc0290052),
    STATUS_TPM_DAA_ISSUER_SETTINGS    = NTSTATUS(0xc0290053),
    STATUS_TPM_DAA_TPM_SETTINGS       = NTSTATUS(0xc0290054),
    STATUS_TPM_DAA_STAGE              = NTSTATUS(0xc0290055),
    STATUS_TPM_DAA_ISSUER_VALIDITY    = NTSTATUS(0xc0290056),
    STATUS_TPM_DAA_WRONG_W            = NTSTATUS(0xc0290057),
    STATUS_TPM_BAD_HANDLE             = NTSTATUS(0xc0290058),
    STATUS_TPM_BAD_DELEGATE           = NTSTATUS(0xc0290059),
    STATUS_TPM_BADCONTEXT             = NTSTATUS(0xc029005a),
    STATUS_TPM_TOOMANYCONTEXTS        = NTSTATUS(0xc029005b),
    STATUS_TPM_MA_TICKET_SIGNATURE    = NTSTATUS(0xc029005c),
    STATUS_TPM_MA_DESTINATION         = NTSTATUS(0xc029005d),
    STATUS_TPM_MA_SOURCE              = NTSTATUS(0xc029005e),
    STATUS_TPM_MA_AUTHORITY           = NTSTATUS(0xc029005f),
    STATUS_TPM_PERMANENTEK            = NTSTATUS(0xc0290061),
    STATUS_TPM_BAD_SIGNATURE          = NTSTATUS(0xc0290062),
    STATUS_TPM_NOCONTEXTSPACE         = NTSTATUS(0xc0290063),
    STATUS_TPM_20_E_ASYMMETRIC        = NTSTATUS(0xc0290081),
    STATUS_TPM_20_E_ATTRIBUTES        = NTSTATUS(0xc0290082),
    STATUS_TPM_20_E_HASH              = NTSTATUS(0xc0290083),
    STATUS_TPM_20_E_VALUE             = NTSTATUS(0xc0290084),
    STATUS_TPM_20_E_HIERARCHY         = NTSTATUS(0xc0290085),
    STATUS_TPM_20_E_KEY_SIZE          = NTSTATUS(0xc0290087),
    STATUS_TPM_20_E_MGF               = NTSTATUS(0xc0290088),
    STATUS_TPM_20_E_MODE              = NTSTATUS(0xc0290089),
    STATUS_TPM_20_E_TYPE              = NTSTATUS(0xc029008a),
    STATUS_TPM_20_E_HANDLE            = NTSTATUS(0xc029008b),
    STATUS_TPM_20_E_KDF               = NTSTATUS(0xc029008c),
    STATUS_TPM_20_E_RANGE             = NTSTATUS(0xc029008d),
    STATUS_TPM_20_E_AUTH_FAIL         = NTSTATUS(0xc029008e),
    STATUS_TPM_20_E_NONCE             = NTSTATUS(0xc029008f),
    STATUS_TPM_20_E_PP                = NTSTATUS(0xc0290090),
    STATUS_TPM_20_E_SCHEME            = NTSTATUS(0xc0290092),
    STATUS_TPM_20_E_SIZE              = NTSTATUS(0xc0290095),
    STATUS_TPM_20_E_SYMMETRIC         = NTSTATUS(0xc0290096),
    STATUS_TPM_20_E_TAG               = NTSTATUS(0xc0290097),
    STATUS_TPM_20_E_SELECTOR          = NTSTATUS(0xc0290098),
    STATUS_TPM_20_E_INSUFFICIENT      = NTSTATUS(0xc029009a),
    STATUS_TPM_20_E_SIGNATURE         = NTSTATUS(0xc029009b),
    STATUS_TPM_20_E_KEY               = NTSTATUS(0xc029009c),
    STATUS_TPM_20_E_POLICY_FAIL       = NTSTATUS(0xc029009d),
    STATUS_TPM_20_E_INTEGRITY         = NTSTATUS(0xc029009f),
    STATUS_TPM_20_E_TICKET            = NTSTATUS(0xc02900a0),
    STATUS_TPM_20_E_RESERVED_BITS     = NTSTATUS(0xc02900a1),
    STATUS_TPM_20_E_BAD_AUTH          = NTSTATUS(0xc02900a2),
    STATUS_TPM_20_E_EXPIRED           = NTSTATUS(0xc02900a3),
    STATUS_TPM_20_E_POLICY_CC         = NTSTATUS(0xc02900a4),
    STATUS_TPM_20_E_BINDING           = NTSTATUS(0xc02900a5),
    STATUS_TPM_20_E_CURVE             = NTSTATUS(0xc02900a6),
    STATUS_TPM_20_E_ECC_POINT         = NTSTATUS(0xc02900a7),
    STATUS_TPM_20_E_INITIALIZE        = NTSTATUS(0xc0290100),
    STATUS_TPM_20_E_FAILURE           = NTSTATUS(0xc0290101),
    STATUS_TPM_20_E_SEQUENCE          = NTSTATUS(0xc0290103),
    STATUS_TPM_20_E_PRIVATE           = NTSTATUS(0xc029010b),
    STATUS_TPM_20_E_HMAC              = NTSTATUS(0xc0290119),
    STATUS_TPM_20_E_DISABLED          = NTSTATUS(0xc0290120),
    STATUS_TPM_20_E_EXCLUSIVE         = NTSTATUS(0xc0290121),
    STATUS_TPM_20_E_ECC_CURVE         = NTSTATUS(0xc0290123),
    STATUS_TPM_20_E_AUTH_TYPE         = NTSTATUS(0xc0290124),
    STATUS_TPM_20_E_AUTH_MISSING      = NTSTATUS(0xc0290125),
    STATUS_TPM_20_E_POLICY            = NTSTATUS(0xc0290126),
    STATUS_TPM_20_E_PCR               = NTSTATUS(0xc0290127),
    STATUS_TPM_20_E_PCR_CHANGED       = NTSTATUS(0xc0290128),
    STATUS_TPM_20_E_UPGRADE           = NTSTATUS(0xc029012d),
    STATUS_TPM_20_E_TOO_MANY_CONTEXTS = NTSTATUS(0xc029012e),
    STATUS_TPM_20_E_AUTH_UNAVAILABLE  = NTSTATUS(0xc029012f),
    STATUS_TPM_20_E_REBOOT            = NTSTATUS(0xc0290130),
    STATUS_TPM_20_E_UNBALANCED        = NTSTATUS(0xc0290131),
    STATUS_TPM_20_E_COMMAND_SIZE      = NTSTATUS(0xc0290142),
    STATUS_TPM_20_E_COMMAND_CODE      = NTSTATUS(0xc0290143),
    STATUS_TPM_20_E_AUTHSIZE          = NTSTATUS(0xc0290144),
    STATUS_TPM_20_E_AUTH_CONTEXT      = NTSTATUS(0xc0290145),
    STATUS_TPM_20_E_NV_RANGE          = NTSTATUS(0xc0290146),
    STATUS_TPM_20_E_NV_SIZE           = NTSTATUS(0xc0290147),
    STATUS_TPM_20_E_NV_LOCKED         = NTSTATUS(0xc0290148),
    STATUS_TPM_20_E_NV_AUTHORIZATION  = NTSTATUS(0xc0290149),
    STATUS_TPM_20_E_NV_UNINITIALIZED  = NTSTATUS(0xc029014a),
    STATUS_TPM_20_E_NV_SPACE          = NTSTATUS(0xc029014b),
    STATUS_TPM_20_E_NV_DEFINED        = NTSTATUS(0xc029014c),
    STATUS_TPM_20_E_BAD_CONTEXT       = NTSTATUS(0xc0290150),
    STATUS_TPM_20_E_CPHASH            = NTSTATUS(0xc0290151),
    STATUS_TPM_20_E_PARENT            = NTSTATUS(0xc0290152),
    STATUS_TPM_20_E_NEEDS_TEST        = NTSTATUS(0xc0290153),
    STATUS_TPM_20_E_NO_RESULT         = NTSTATUS(0xc0290154),
    STATUS_TPM_20_E_SENSITIVE         = NTSTATUS(0xc0290155),
    STATUS_TPM_COMMAND_BLOCKED        = NTSTATUS(0xc0290400),
    STATUS_TPM_INVALID_HANDLE         = NTSTATUS(0xc0290401),
    STATUS_TPM_DUPLICATE_VHANDLE      = NTSTATUS(0xc0290402),
}

enum NTSTATUS STATUS_TPM_EMBEDDED_COMMAND_UNSUPPORTED = NTSTATUS(0xc0290404);

enum : NTSTATUS
{
    STATUS_TPM_NEEDS_SELFTEST      = NTSTATUS(0xc0290801),
    STATUS_TPM_DOING_SELFTEST      = NTSTATUS(0xc0290802),
    STATUS_TPM_DEFEND_LOCK_RUNNING = NTSTATUS(0xc0290803),
}

enum NTSTATUS STATUS_TPM_TOO_MANY_CONTEXTS = NTSTATUS(0xc0291002);

enum : NTSTATUS
{
    STATUS_TPM_ACCESS_DENIED       = NTSTATUS(0xc0291004),
    STATUS_TPM_INSUFFICIENT_BUFFER = NTSTATUS(0xc0291005),
}

enum NTSTATUS STATUS_TPM_IN_EXCLUSIVE_MODE = NTSTATUS(0xc0291007);

enum : NTSTATUS
{
    STATUS_PCP_ERROR_MASK        = NTSTATUS(0xc0292000),
    STATUS_PCP_DEVICE_NOT_READY  = NTSTATUS(0xc0292001),
    STATUS_PCP_INVALID_HANDLE    = NTSTATUS(0xc0292002),
    STATUS_PCP_INVALID_PARAMETER = NTSTATUS(0xc0292003),
}

enum : NTSTATUS
{
    STATUS_PCP_NOT_SUPPORTED          = NTSTATUS(0xc0292005),
    STATUS_PCP_BUFFER_TOO_SMALL       = NTSTATUS(0xc0292006),
    STATUS_PCP_INTERNAL_ERROR         = NTSTATUS(0xc0292007),
    STATUS_PCP_AUTHENTICATION_FAILED  = NTSTATUS(0xc0292008),
    STATUS_PCP_AUTHENTICATION_IGNORED = NTSTATUS(0xc0292009),
}

enum NTSTATUS STATUS_PCP_PROFILE_NOT_FOUND = NTSTATUS(0xc029200b);

enum : NTSTATUS
{
    STATUS_PCP_DEVICE_NOT_FOUND     = NTSTATUS(0xc029200d),
    STATUS_PCP_WRONG_PARENT         = NTSTATUS(0xc029200e),
    STATUS_PCP_KEY_NOT_LOADED       = NTSTATUS(0xc029200f),
    STATUS_PCP_NO_KEY_CERTIFICATION = NTSTATUS(0xc0292010),
}

enum NTSTATUS STATUS_PCP_ATTESTATION_CHALLENGE_NOT_SET = NTSTATUS(0xc0292012);

enum : NTSTATUS
{
    STATUS_PCP_KEY_ALREADY_FINALIZED          = NTSTATUS(0xc0292014),
    STATUS_PCP_KEY_USAGE_POLICY_NOT_SUPPORTED = NTSTATUS(0xc0292015),
    STATUS_PCP_KEY_USAGE_POLICY_INVALID       = NTSTATUS(0xc0292016),
}

enum : NTSTATUS
{
    STATUS_PCP_KEY_NOT_AUTHENTICATED = NTSTATUS(0xc0292018),
    STATUS_PCP_KEY_NOT_AIK           = NTSTATUS(0xc0292019),
    STATUS_PCP_KEY_NOT_SIGNING_KEY   = NTSTATUS(0xc029201a),
}

enum NTSTATUS STATUS_PCP_CLAIM_TYPE_NOT_SUPPORTED = NTSTATUS(0xc029201c);
enum NTSTATUS STATUS_PCP_BUFFER_LENGTH_MISMATCH = NTSTATUS(0xc029201e);

enum : NTSTATUS
{
    STATUS_PCP_TICKET_MISSING           = NTSTATUS(0xc0292020),
    STATUS_PCP_RAW_POLICY_NOT_SUPPORTED = NTSTATUS(0xc0292021),
}

enum NTSTATUS STATUS_PCP_UNSUPPORTED_PSS_SALT = NTSTATUS(0x40292023);

enum : NTSTATUS
{
    STATUS_RTPM_CONTEXT_COMPLETE    = NTSTATUS(0x00293001),
    STATUS_RTPM_NO_RESULT           = NTSTATUS(0xc0293002),
    STATUS_RTPM_PCR_READ_INCOMPLETE = NTSTATUS(0xc0293003),
}

enum NTSTATUS STATUS_RTPM_UNSUPPORTED_CMD = NTSTATUS(0xc0293005);
enum NTSTATUS STATUS_DRTM_ENVIRONMENT_UNSAFE = NTSTATUS(0xc0295000);

enum : NTSTATUS
{
    STATUS_HV_INVALID_HYPERCALL_CODE  = NTSTATUS(0xc0350002),
    STATUS_HV_INVALID_HYPERCALL_INPUT = NTSTATUS(0xc0350003),
    STATUS_HV_INVALID_ALIGNMENT       = NTSTATUS(0xc0350004),
    STATUS_HV_INVALID_PARAMETER       = NTSTATUS(0xc0350005),
}

enum NTSTATUS STATUS_HV_INVALID_PARTITION_STATE = NTSTATUS(0xc0350007);
enum NTSTATUS STATUS_HV_UNKNOWN_PROPERTY = NTSTATUS(0xc0350009);
enum NTSTATUS STATUS_HV_INSUFFICIENT_MEMORY = NTSTATUS(0xc035000b);

enum : NTSTATUS
{
    STATUS_HV_INVALID_PARTITION_ID  = NTSTATUS(0xc035000d),
    STATUS_HV_INVALID_VP_INDEX      = NTSTATUS(0xc035000e),
    STATUS_HV_INVALID_PORT_ID       = NTSTATUS(0xc0350011),
    STATUS_HV_INVALID_CONNECTION_ID = NTSTATUS(0xc0350012),
}

enum NTSTATUS STATUS_HV_NOT_ACKNOWLEDGED = NTSTATUS(0xc0350014);

enum : NTSTATUS
{
    STATUS_HV_ACKNOWLEDGED               = NTSTATUS(0xc0350016),
    STATUS_HV_INVALID_SAVE_RESTORE_STATE = NTSTATUS(0xc0350017),
    STATUS_HV_INVALID_SYNIC_STATE        = NTSTATUS(0xc0350018),
}

enum NTSTATUS STATUS_HV_INVALID_PROXIMITY_DOMAIN_INFO = NTSTATUS(0xc035001a);

enum : NTSTATUS
{
    STATUS_HV_INACTIVE            = NTSTATUS(0xc035001c),
    STATUS_HV_NO_RESOURCES        = NTSTATUS(0xc035001d),
    STATUS_HV_FEATURE_UNAVAILABLE = NTSTATUS(0xc035001e),
}

enum NTSTATUS STATUS_HV_INSUFFICIENT_DEVICE_DOMAINS = NTSTATUS(0xc0350038);
enum NTSTATUS STATUS_HV_CPUID_XSAVE_FEATURE_VALIDATION_ERROR = NTSTATUS(0xc035003d);

enum : NTSTATUS
{
    STATUS_HV_SMX_ENABLED            = NTSTATUS(0xc035003f),
    STATUS_HV_INVALID_LP_INDEX       = NTSTATUS(0xc0350041),
    STATUS_HV_INVALID_REGISTER_VALUE = NTSTATUS(0xc0350050),
    STATUS_HV_INVALID_VTL_STATE      = NTSTATUS(0xc0350051),
}

enum : NTSTATUS
{
    STATUS_HV_INVALID_DEVICE_ID    = NTSTATUS(0xc0350057),
    STATUS_HV_INVALID_DEVICE_STATE = NTSTATUS(0xc0350058),
}

enum NTSTATUS STATUS_HV_PAGE_REQUEST_INVALID = NTSTATUS(0xc0350060);
enum NTSTATUS STATUS_HV_INVALID_CPU_GROUP_STATE = NTSTATUS(0xc0350070);
enum NTSTATUS STATUS_HV_NOT_ALLOWED_WITH_NESTED_VIRT_ACTIVE = NTSTATUS(0xc0350072);
enum NTSTATUS STATUS_HV_EVENT_BUFFER_ALREADY_FREED = NTSTATUS(0xc0350074);
enum NTSTATUS STATUS_HV_DEVICE_NOT_IN_DOMAIN = NTSTATUS(0xc0350076);

enum : NTSTATUS
{
    STATUS_HV_CALL_PENDING      = NTSTATUS(0xc0350079),
    STATUS_HV_MSR_ACCESS_FAILED = NTSTATUS(0xc0350080),
}

enum : NTSTATUS
{
    STATUS_HV_INSUFFICIENT_CONTIGUOUS_MEMORY_MIRRORING      = NTSTATUS(0xc0350082),
    STATUS_HV_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY           = NTSTATUS(0xc0350083),
    STATUS_HV_INSUFFICIENT_ROOT_MEMORY_MIRRORING            = NTSTATUS(0xc0350084),
    STATUS_HV_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY_MIRRORING = NTSTATUS(0xc0350085),
}

enum : NTSTATUS
{
    STATUS_HV_SPDM_REQUEST = NTSTATUS(0xc0350088),
    STATUS_HV_NOT_PRESENT  = NTSTATUS(0xc0351000),
}

enum NTSTATUS STATUS_VID_TOO_MANY_HANDLERS = NTSTATUS(0xc0370002);
enum NTSTATUS STATUS_VID_HANDLER_NOT_PRESENT = NTSTATUS(0xc0370004);
enum NTSTATUS STATUS_VID_PARTITION_NAME_TOO_LONG = NTSTATUS(0xc0370006);

enum : NTSTATUS
{
    STATUS_VID_PARTITION_ALREADY_EXISTS = NTSTATUS(0xc0370008),
    STATUS_VID_PARTITION_DOES_NOT_EXIST = NTSTATUS(0xc0370009),
    STATUS_VID_PARTITION_NAME_NOT_FOUND = NTSTATUS(0xc037000a),
}

enum NTSTATUS STATUS_VID_EXCEEDED_MBP_ENTRY_MAP_LIMIT = NTSTATUS(0xc037000c);
enum NTSTATUS STATUS_VID_CHILD_GPA_PAGE_SET_CORRUPTED = NTSTATUS(0xc037000e);
enum NTSTATUS STATUS_VID_INVALID_NUMA_NODE_INDEX = NTSTATUS(0xc0370010);
enum NTSTATUS STATUS_VID_INVALID_MEMORY_BLOCK_HANDLE = NTSTATUS(0xc0370012);

enum : NTSTATUS
{
    STATUS_VID_INVALID_MESSAGE_QUEUE_HANDLE = NTSTATUS(0xc0370014),
    STATUS_VID_INVALID_GPA_RANGE_HANDLE     = NTSTATUS(0xc0370015),
}

enum NTSTATUS STATUS_VID_MEMORY_BLOCK_LOCK_COUNT_EXCEEDED = NTSTATUS(0xc0370017);

enum : NTSTATUS
{
    STATUS_VID_MBPS_ARE_LOCKED      = NTSTATUS(0xc0370019),
    STATUS_VID_MESSAGE_QUEUE_CLOSED = NTSTATUS(0xc037001a),
}

enum : NTSTATUS
{
    STATUS_VID_STOP_PENDING            = NTSTATUS(0xc037001c),
    STATUS_VID_INVALID_PROCESSOR_STATE = NTSTATUS(0xc037001d),
}

enum NTSTATUS STATUS_VID_KM_INTERFACE_ALREADY_INITIALIZED = NTSTATUS(0xc037001f);
enum NTSTATUS STATUS_VID_MMIO_RANGE_DESTROYED = NTSTATUS(0xc0370021);

enum : NTSTATUS
{
    STATUS_VID_RESERVE_PAGE_SET_IS_BEING_USED = NTSTATUS(0xc0370023),
    STATUS_VID_RESERVE_PAGE_SET_TOO_SMALL     = NTSTATUS(0xc0370024),
}

enum NTSTATUS STATUS_VID_MBP_COUNT_EXCEEDED_LIMIT = NTSTATUS(0xc0370026);

enum : NTSTATUS
{
    STATUS_VID_SAVED_STATE_UNRECOGNIZED_ITEM = NTSTATUS(0xc0370028),
    STATUS_VID_SAVED_STATE_INCOMPATIBLE      = NTSTATUS(0xc0370029),
}

enum : NTSTATUS
{
    STATUS_VID_INSUFFICIENT_RESOURCES_RESERVE         = NTSTATUS(0xc037002b),
    STATUS_VID_INSUFFICIENT_RESOURCES_PHYSICAL_BUFFER = NTSTATUS(0xc037002c),
    STATUS_VID_INSUFFICIENT_RESOURCES_HV_DEPOSIT      = NTSTATUS(0xc037002d),
}

enum NTSTATUS STATUS_VID_INSUFFICIENT_RESOURCES_WITHDRAW = NTSTATUS(0xc037002f);
enum NTSTATUS STATUS_DM_OPERATION_LIMIT_EXCEEDED = NTSTATUS(0xc0370600);

enum : NTSTATUS
{
    STATUS_IPSEC_BAD_SPI                = NTSTATUS(0xc0360001),
    STATUS_IPSEC_SA_LIFETIME_EXPIRED    = NTSTATUS(0xc0360002),
    STATUS_IPSEC_WRONG_SA               = NTSTATUS(0xc0360003),
    STATUS_IPSEC_REPLAY_CHECK_FAILED    = NTSTATUS(0xc0360004),
    STATUS_IPSEC_INVALID_PACKET         = NTSTATUS(0xc0360005),
    STATUS_IPSEC_INTEGRITY_CHECK_FAILED = NTSTATUS(0xc0360006),
}

enum : NTSTATUS
{
    STATUS_IPSEC_AUTH_FIREWALL_DROP               = NTSTATUS(0xc0360008),
    STATUS_IPSEC_THROTTLE_DROP                    = NTSTATUS(0xc0360009),
    STATUS_IPSEC_DOSP_BLOCK                       = NTSTATUS(0xc0368000),
    STATUS_IPSEC_DOSP_RECEIVED_MULTICAST          = NTSTATUS(0xc0368001),
    STATUS_IPSEC_DOSP_INVALID_PACKET              = NTSTATUS(0xc0368002),
    STATUS_IPSEC_DOSP_STATE_LOOKUP_FAILED         = NTSTATUS(0xc0368003),
    STATUS_IPSEC_DOSP_MAX_ENTRIES                 = NTSTATUS(0xc0368004),
    STATUS_IPSEC_DOSP_KEYMOD_NOT_ALLOWED          = NTSTATUS(0xc0368005),
    STATUS_IPSEC_DOSP_MAX_PER_IP_RATELIMIT_QUEUES = NTSTATUS(0xc0368006),
}

enum NTSTATUS STATUS_VOLMGR_INCOMPLETE_DISK_MIGRATION = NTSTATUS(0x80380002);

enum : NTSTATUS
{
    STATUS_VOLMGR_DISK_CONFIGURATION_CORRUPTED   = NTSTATUS(0xc0380002),
    STATUS_VOLMGR_DISK_CONFIGURATION_NOT_IN_SYNC = NTSTATUS(0xc0380003),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_DISK_CONTAINS_NON_SIMPLE_VOLUME                = NTSTATUS(0xc0380005),
    STATUS_VOLMGR_DISK_DUPLICATE                                 = NTSTATUS(0xc0380006),
    STATUS_VOLMGR_DISK_DYNAMIC                                   = NTSTATUS(0xc0380007),
    STATUS_VOLMGR_DISK_ID_INVALID                                = NTSTATUS(0xc0380008),
    STATUS_VOLMGR_DISK_INVALID                                   = NTSTATUS(0xc0380009),
    STATUS_VOLMGR_DISK_LAST_VOTER                                = NTSTATUS(0xc038000a),
    STATUS_VOLMGR_DISK_LAYOUT_INVALID                            = NTSTATUS(0xc038000b),
    STATUS_VOLMGR_DISK_LAYOUT_NON_BASIC_BETWEEN_BASIC_PARTITIONS = NTSTATUS(0xc038000c),
    STATUS_VOLMGR_DISK_LAYOUT_NOT_CYLINDER_ALIGNED               = NTSTATUS(0xc038000d),
    STATUS_VOLMGR_DISK_LAYOUT_PARTITIONS_TOO_SMALL               = NTSTATUS(0xc038000e),
    STATUS_VOLMGR_DISK_LAYOUT_PRIMARY_BETWEEN_LOGICAL_PARTITIONS = NTSTATUS(0xc038000f),
    STATUS_VOLMGR_DISK_LAYOUT_TOO_MANY_PARTITIONS                = NTSTATUS(0xc0380010),
    STATUS_VOLMGR_DISK_MISSING                                   = NTSTATUS(0xc0380011),
    STATUS_VOLMGR_DISK_NOT_EMPTY                                 = NTSTATUS(0xc0380012),
    STATUS_VOLMGR_DISK_NOT_ENOUGH_SPACE                          = NTSTATUS(0xc0380013),
    STATUS_VOLMGR_DISK_REVECTORING_FAILED                        = NTSTATUS(0xc0380014),
    STATUS_VOLMGR_DISK_SECTOR_SIZE_INVALID                       = NTSTATUS(0xc0380015),
    STATUS_VOLMGR_DISK_SET_NOT_CONTAINED                         = NTSTATUS(0xc0380016),
    STATUS_VOLMGR_DISK_USED_BY_MULTIPLE_MEMBERS                  = NTSTATUS(0xc0380017),
    STATUS_VOLMGR_DISK_USED_BY_MULTIPLE_PLEXES                   = NTSTATUS(0xc0380018),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_EXTENT_ALREADY_USED                = NTSTATUS(0xc038001a),
    STATUS_VOLMGR_EXTENT_NOT_CONTIGUOUS              = NTSTATUS(0xc038001b),
    STATUS_VOLMGR_EXTENT_NOT_IN_PUBLIC_REGION        = NTSTATUS(0xc038001c),
    STATUS_VOLMGR_EXTENT_NOT_SECTOR_ALIGNED          = NTSTATUS(0xc038001d),
    STATUS_VOLMGR_EXTENT_OVERLAPS_EBR_PARTITION      = NTSTATUS(0xc038001e),
    STATUS_VOLMGR_EXTENT_VOLUME_LENGTHS_DO_NOT_MATCH = NTSTATUS(0xc038001f),
}

enum NTSTATUS STATUS_VOLMGR_INTERLEAVE_LENGTH_INVALID = NTSTATUS(0xc0380021);

enum : NTSTATUS
{
    STATUS_VOLMGR_MEMBER_IN_SYNC            = NTSTATUS(0xc0380023),
    STATUS_VOLMGR_MEMBER_INDEX_DUPLICATE    = NTSTATUS(0xc0380024),
    STATUS_VOLMGR_MEMBER_INDEX_INVALID      = NTSTATUS(0xc0380025),
    STATUS_VOLMGR_MEMBER_MISSING            = NTSTATUS(0xc0380026),
    STATUS_VOLMGR_MEMBER_NOT_DETACHED       = NTSTATUS(0xc0380027),
    STATUS_VOLMGR_MEMBER_REGENERATING       = NTSTATUS(0xc0380028),
    STATUS_VOLMGR_ALL_DISKS_FAILED          = NTSTATUS(0xc0380029),
    STATUS_VOLMGR_NO_REGISTERED_USERS       = NTSTATUS(0xc038002a),
    STATUS_VOLMGR_NO_SUCH_USER              = NTSTATUS(0xc038002b),
    STATUS_VOLMGR_NOTIFICATION_RESET        = NTSTATUS(0xc038002c),
    STATUS_VOLMGR_NUMBER_OF_MEMBERS_INVALID = NTSTATUS(0xc038002d),
    STATUS_VOLMGR_NUMBER_OF_PLEXES_INVALID  = NTSTATUS(0xc038002e),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_PACK_ID_INVALID         = NTSTATUS(0xc0380030),
    STATUS_VOLMGR_PACK_INVALID            = NTSTATUS(0xc0380031),
    STATUS_VOLMGR_PACK_NAME_INVALID       = NTSTATUS(0xc0380032),
    STATUS_VOLMGR_PACK_OFFLINE            = NTSTATUS(0xc0380033),
    STATUS_VOLMGR_PACK_HAS_QUORUM         = NTSTATUS(0xc0380034),
    STATUS_VOLMGR_PACK_WITHOUT_QUORUM     = NTSTATUS(0xc0380035),
    STATUS_VOLMGR_PARTITION_STYLE_INVALID = NTSTATUS(0xc0380036),
    STATUS_VOLMGR_PARTITION_UPDATE_FAILED = NTSTATUS(0xc0380037),
    STATUS_VOLMGR_PLEX_IN_SYNC            = NTSTATUS(0xc0380038),
    STATUS_VOLMGR_PLEX_INDEX_DUPLICATE    = NTSTATUS(0xc0380039),
    STATUS_VOLMGR_PLEX_INDEX_INVALID      = NTSTATUS(0xc038003a),
    STATUS_VOLMGR_PLEX_LAST_ACTIVE        = NTSTATUS(0xc038003b),
    STATUS_VOLMGR_PLEX_MISSING            = NTSTATUS(0xc038003c),
    STATUS_VOLMGR_PLEX_REGENERATING       = NTSTATUS(0xc038003d),
    STATUS_VOLMGR_PLEX_TYPE_INVALID       = NTSTATUS(0xc038003e),
    STATUS_VOLMGR_PLEX_NOT_RAID5          = NTSTATUS(0xc038003f),
    STATUS_VOLMGR_PLEX_NOT_SIMPLE         = NTSTATUS(0xc0380040),
    STATUS_VOLMGR_STRUCTURE_SIZE_INVALID  = NTSTATUS(0xc0380041),
}

enum NTSTATUS STATUS_VOLMGR_TRANSACTION_IN_PROGRESS = NTSTATUS(0xc0380043);

enum : NTSTATUS
{
    STATUS_VOLMGR_VOLUME_CONTAINS_MISSING_DISK           = NTSTATUS(0xc0380045),
    STATUS_VOLMGR_VOLUME_ID_INVALID                      = NTSTATUS(0xc0380046),
    STATUS_VOLMGR_VOLUME_LENGTH_INVALID                  = NTSTATUS(0xc0380047),
    STATUS_VOLMGR_VOLUME_LENGTH_NOT_SECTOR_SIZE_MULTIPLE = NTSTATUS(0xc0380048),
    STATUS_VOLMGR_VOLUME_NOT_MIRRORED                    = NTSTATUS(0xc0380049),
    STATUS_VOLMGR_VOLUME_NOT_RETAINED                    = NTSTATUS(0xc038004a),
    STATUS_VOLMGR_VOLUME_OFFLINE                         = NTSTATUS(0xc038004b),
    STATUS_VOLMGR_VOLUME_RETAINED                        = NTSTATUS(0xc038004c),
    STATUS_VOLMGR_NUMBER_OF_EXTENTS_INVALID              = NTSTATUS(0xc038004d),
}

enum : NTSTATUS
{
    STATUS_VOLMGR_BAD_BOOT_DISK          = NTSTATUS(0xc038004f),
    STATUS_VOLMGR_PACK_CONFIG_OFFLINE    = NTSTATUS(0xc0380050),
    STATUS_VOLMGR_PACK_CONFIG_ONLINE     = NTSTATUS(0xc0380051),
    STATUS_VOLMGR_NOT_PRIMARY_PACK       = NTSTATUS(0xc0380052),
    STATUS_VOLMGR_PACK_LOG_UPDATE_FAILED = NTSTATUS(0xc0380053),
}

enum NTSTATUS STATUS_VOLMGR_NUMBER_OF_DISKS_IN_MEMBER_INVALID = NTSTATUS(0xc0380055);
enum NTSTATUS STATUS_VOLMGR_PLEX_NOT_SIMPLE_SPANNED = NTSTATUS(0xc0380057);

enum : NTSTATUS
{
    STATUS_VOLMGR_PRIMARY_PACK_PRESENT    = NTSTATUS(0xc0380059),
    STATUS_VOLMGR_NUMBER_OF_DISKS_INVALID = NTSTATUS(0xc038005a),
}

enum NTSTATUS STATUS_VOLMGR_RAID5_NOT_SUPPORTED = NTSTATUS(0xc038005c);
enum NTSTATUS STATUS_BCD_TOO_MANY_ELEMENTS = NTSTATUS(0xc0390002);

enum : NTSTATUS
{
    STATUS_VHD_DRIVE_FOOTER_MISSING           = NTSTATUS(0xc03a0001),
    STATUS_VHD_DRIVE_FOOTER_CHECKSUM_MISMATCH = NTSTATUS(0xc03a0002),
    STATUS_VHD_DRIVE_FOOTER_CORRUPT           = NTSTATUS(0xc03a0003),
}

enum NTSTATUS STATUS_VHD_FORMAT_UNSUPPORTED_VERSION = NTSTATUS(0xc03a0005);

enum : NTSTATUS
{
    STATUS_VHD_SPARSE_HEADER_UNSUPPORTED_VERSION = NTSTATUS(0xc03a0007),
    STATUS_VHD_SPARSE_HEADER_CORRUPT             = NTSTATUS(0xc03a0008),
}

enum NTSTATUS STATUS_VHD_BLOCK_ALLOCATION_TABLE_CORRUPT = NTSTATUS(0xc03a000a);

enum : NTSTATUS
{
    STATUS_VHD_BITMAP_MISMATCH      = NTSTATUS(0xc03a000c),
    STATUS_VHD_PARENT_VHD_NOT_FOUND = NTSTATUS(0xc03a000d),
}

enum NTSTATUS STATUS_VHD_CHILD_PARENT_TIMESTAMP_MISMATCH = NTSTATUS(0xc03a000f);
enum NTSTATUS STATUS_VHD_METADATA_WRITE_FAILURE = NTSTATUS(0xc03a0011);
enum NTSTATUS STATUS_VHD_INVALID_FILE_SIZE = NTSTATUS(0xc03a0013);
enum NTSTATUS STATUS_VIRTDISK_NOT_VIRTUAL_DISK = NTSTATUS(0xc03a0015);
enum NTSTATUS STATUS_VHD_CHILD_PARENT_SIZE_MISMATCH = NTSTATUS(0xc03a0017);
enum NTSTATUS STATUS_VHD_DIFFERENCING_CHAIN_ERROR_IN_PARENT = NTSTATUS(0xc03a0019);

enum : NTSTATUS
{
    STATUS_VHD_INVALID_TYPE  = NTSTATUS(0xc03a001b),
    STATUS_VHD_INVALID_STATE = NTSTATUS(0xc03a001c),
}

enum : NTSTATUS
{
    STATUS_VIRTDISK_DISK_ALREADY_OWNED       = NTSTATUS(0xc03a001e),
    STATUS_VIRTDISK_DISK_ONLINE_AND_WRITABLE = NTSTATUS(0xc03a001f),
}

enum NTSTATUS STATUS_CTLOG_LOGFILE_SIZE_EXCEEDED_MAXSIZE = NTSTATUS(0xc03a0021);

enum : NTSTATUS
{
    STATUS_CTLOG_INVALID_TRACKING_STATE     = NTSTATUS(0xc03a0023),
    STATUS_CTLOG_INCONSISTENT_TRACKING_FILE = NTSTATUS(0xc03a0024),
}

enum NTSTATUS STATUS_VHD_INVALID_CHANGE_TRACKING_ID = NTSTATUS(0xc03a0029);
enum NTSTATUS STATUS_VHD_MISSING_CHANGE_TRACKING_INFORMATION = NTSTATUS(0xc03a0030);
enum NTSTATUS STATUS_VHD_COULD_NOT_COMPUTE_MINIMUM_VIRTUAL_SIZE = NTSTATUS(0xc03a0032);
enum NTSTATUS STATUS_VHD_UNEXPECTED_ID = NTSTATUS(0xc03a0034);
enum NTSTATUS STATUS_GDI_HANDLE_LEAK = NTSTATUS(0x803f0001);

enum : NTSTATUS
{
    STATUS_RKF_DUPLICATE_KEY = NTSTATUS(0xc0400002),
    STATUS_RKF_BLOB_FULL     = NTSTATUS(0xc0400003),
    STATUS_RKF_STORE_FULL    = NTSTATUS(0xc0400004),
    STATUS_RKF_FILE_BLOCKED  = NTSTATUS(0xc0400005),
    STATUS_RKF_ACTIVE_KEY    = NTSTATUS(0xc0400006),
}

enum : NTSTATUS
{
    STATUS_RDBSS_CONTINUE_OPERATION = NTSTATUS(0xc0410002),
    STATUS_RDBSS_POST_OPERATION     = NTSTATUS(0xc0410003),
    STATUS_RDBSS_RETRY_LOOKUP       = NTSTATUS(0xc0410004),
}

enum : NTSTATUS
{
    STATUS_BTH_ATT_READ_NOT_PERMITTED          = NTSTATUS(0xc0420002),
    STATUS_BTH_ATT_WRITE_NOT_PERMITTED         = NTSTATUS(0xc0420003),
    STATUS_BTH_ATT_INVALID_PDU                 = NTSTATUS(0xc0420004),
    STATUS_BTH_ATT_INSUFFICIENT_AUTHENTICATION = NTSTATUS(0xc0420005),
}

enum : NTSTATUS
{
    STATUS_BTH_ATT_INVALID_OFFSET             = NTSTATUS(0xc0420007),
    STATUS_BTH_ATT_INSUFFICIENT_AUTHORIZATION = NTSTATUS(0xc0420008),
}

enum : NTSTATUS
{
    STATUS_BTH_ATT_ATTRIBUTE_NOT_FOUND              = NTSTATUS(0xc042000a),
    STATUS_BTH_ATT_ATTRIBUTE_NOT_LONG               = NTSTATUS(0xc042000b),
    STATUS_BTH_ATT_INSUFFICIENT_ENCRYPTION_KEY_SIZE = NTSTATUS(0xc042000c),
}

enum : NTSTATUS
{
    STATUS_BTH_ATT_UNLIKELY                = NTSTATUS(0xc042000e),
    STATUS_BTH_ATT_INSUFFICIENT_ENCRYPTION = NTSTATUS(0xc042000f),
}

enum : NTSTATUS
{
    STATUS_BTH_ATT_INSUFFICIENT_RESOURCES = NTSTATUS(0xc0420011),
    STATUS_BTH_ATT_UNKNOWN_ERROR          = NTSTATUS(0xc0421000),
}

enum : NTSTATUS
{
    STATUS_SECUREBOOT_POLICY_VIOLATION                   = NTSTATUS(0xc0430002),
    STATUS_SECUREBOOT_INVALID_POLICY                     = NTSTATUS(0xc0430003),
    STATUS_SECUREBOOT_POLICY_PUBLISHER_NOT_FOUND         = NTSTATUS(0xc0430004),
    STATUS_SECUREBOOT_POLICY_NOT_SIGNED                  = NTSTATUS(0xc0430005),
    STATUS_SECUREBOOT_NOT_ENABLED                        = NTSTATUS(0x80430006),
    STATUS_SECUREBOOT_FILE_REPLACED                      = NTSTATUS(0xc0430007),
    STATUS_SECUREBOOT_POLICY_NOT_AUTHORIZED              = NTSTATUS(0xc0430008),
    STATUS_SECUREBOOT_POLICY_UNKNOWN                     = NTSTATUS(0xc0430009),
    STATUS_SECUREBOOT_POLICY_MISSING_ANTIROLLBACKVERSION = NTSTATUS(0xc043000a),
}

enum : NTSTATUS
{
    STATUS_SECUREBOOT_POLICY_ROLLBACK_DETECTED     = NTSTATUS(0xc043000c),
    STATUS_SECUREBOOT_POLICY_UPGRADE_MISMATCH      = NTSTATUS(0xc043000d),
    STATUS_SECUREBOOT_REQUIRED_POLICY_FILE_MISSING = NTSTATUS(0xc043000e),
}

enum NTSTATUS STATUS_SECUREBOOT_NOT_SUPPLEMENTAL_POLICY = NTSTATUS(0xc0430010);

enum : NTSTATUS
{
    STATUS_PLATFORM_MANIFEST_INVALID                = NTSTATUS(0xc0eb0002),
    STATUS_PLATFORM_MANIFEST_FILE_NOT_AUTHORIZED    = NTSTATUS(0xc0eb0003),
    STATUS_PLATFORM_MANIFEST_CATALOG_NOT_AUTHORIZED = NTSTATUS(0xc0eb0004),
    STATUS_PLATFORM_MANIFEST_BINARY_ID_NOT_FOUND    = NTSTATUS(0xc0eb0005),
    STATUS_PLATFORM_MANIFEST_NOT_ACTIVE             = NTSTATUS(0xc0eb0006),
    STATUS_PLATFORM_MANIFEST_NOT_SIGNED             = NTSTATUS(0xc0eb0007),
}

enum : NTSTATUS
{
    STATUS_SYSTEM_INTEGRITY_POLICY_VIOLATION                   = NTSTATUS(0xc0e90002),
    STATUS_SYSTEM_INTEGRITY_INVALID_POLICY                     = NTSTATUS(0xc0e90003),
    STATUS_SYSTEM_INTEGRITY_POLICY_NOT_SIGNED                  = NTSTATUS(0xc0e90004),
    STATUS_SYSTEM_INTEGRITY_TOO_MANY_POLICIES                  = NTSTATUS(0xc0e90005),
    STATUS_SYSTEM_INTEGRITY_SUPPLEMENTAL_POLICY_NOT_AUTHORIZED = NTSTATUS(0xc0e90006),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_MALICIOUS               = NTSTATUS(0xc0e90007),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_PUA                     = NTSTATUS(0xc0e90008),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_DANGEROUS_EXT           = NTSTATUS(0xc0e90009),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_OFFLINE                 = NTSTATUS(0xc0e9000a),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_UNFRIENDLY_FILE         = NTSTATUS(0xc0e9000b),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_UNATTAINABLE            = NTSTATUS(0xc0e9000c),
    STATUS_SYSTEM_INTEGRITY_REPUTATION_EXPLICIT_DENY_FILE      = NTSTATUS(0xc0e9000d),
    STATUS_SYSTEM_INTEGRITY_WHQL_NOT_SATISFIED                 = NTSTATUS(0xc0e9000e),
}

enum : NTSTATUS
{
    STATUS_CLIP_LICENSE_NOT_FOUND      = NTSTATUS(0xc0ea0002),
    STATUS_CLIP_DEVICE_LICENSE_MISSING = NTSTATUS(0xc0ea0003),
}

enum NTSTATUS STATUS_CLIP_KEYHOLDER_LICENSE_MISSING_OR_INVALID = NTSTATUS(0xc0ea0005);

enum : NTSTATUS
{
    STATUS_CLIP_LICENSE_SIGNED_BY_UNKNOWN_SOURCE     = NTSTATUS(0xc0ea0007),
    STATUS_CLIP_LICENSE_NOT_SIGNED                   = NTSTATUS(0xc0ea0008),
    STATUS_CLIP_LICENSE_HARDWARE_ID_OUT_OF_TOLERANCE = NTSTATUS(0xc0ea0009),
    STATUS_CLIP_LICENSE_DEVICE_ID_MISMATCH           = NTSTATUS(0xc0ea000a),
}

enum : NTSTATUS
{
    STATUS_HDAUDIO_EMPTY_CONNECTION_LIST         = NTSTATUS(0xc0440002),
    STATUS_HDAUDIO_CONNECTION_LIST_NOT_SUPPORTED = NTSTATUS(0xc0440003),
}

enum NTSTATUS STATUS_HDAUDIO_NULL_LINKED_LIST_ENTRY = NTSTATUS(0xc0440005);

enum : NTSTATUS
{
    STATUS_SOUNDWIRE_COMMAND_IGNORED = NTSTATUS(0xc0440007),
    STATUS_SOUNDWIRE_COMMAND_FAILED  = NTSTATUS(0xc0440008),
}

enum : NTSTATUS
{
    STATUS_SPACES_PAUSE                     = NTSTATUS(0x00e70001),
    STATUS_SPACES_COMPLETE                  = NTSTATUS(0x00e70002),
    STATUS_SPACES_REDIRECT                  = NTSTATUS(0x00e70003),
    STATUS_SPACES_FAULT_DOMAIN_TYPE_INVALID = NTSTATUS(0xc0e70001),
}

enum : NTSTATUS
{
    STATUS_SPACES_DRIVE_SECTOR_SIZE_INVALID = NTSTATUS(0xc0e70004),
    STATUS_SPACES_DRIVE_REDUNDANCY_INVALID  = NTSTATUS(0xc0e70006),
}

enum NTSTATUS STATUS_SPACES_INTERLEAVE_LENGTH_INVALID = NTSTATUS(0xc0e70009);

enum : NTSTATUS
{
    STATUS_SPACES_NOT_ENOUGH_DRIVES         = NTSTATUS(0xc0e7000b),
    STATUS_SPACES_EXTENDED_ERROR            = NTSTATUS(0xc0e7000c),
    STATUS_SPACES_PROVISIONING_TYPE_INVALID = NTSTATUS(0xc0e7000d),
}

enum NTSTATUS STATUS_SPACES_ENCLOSURE_AWARE_INVALID = NTSTATUS(0xc0e7000f);
enum NTSTATUS STATUS_SPACES_NUMBER_OF_GROUPS_INVALID = NTSTATUS(0xc0e70011);

enum : NTSTATUS
{
    STATUS_SPACES_UPDATE_COLUMN_STATE    = NTSTATUS(0xc0e70013),
    STATUS_SPACES_MAP_REQUIRED           = NTSTATUS(0xc0e70014),
    STATUS_SPACES_UNSUPPORTED_VERSION    = NTSTATUS(0xc0e70015),
    STATUS_SPACES_CORRUPT_METADATA       = NTSTATUS(0xc0e70016),
    STATUS_SPACES_DRT_FULL               = NTSTATUS(0xc0e70017),
    STATUS_SPACES_INCONSISTENCY          = NTSTATUS(0xc0e70018),
    STATUS_SPACES_LOG_NOT_READY          = NTSTATUS(0xc0e70019),
    STATUS_SPACES_NO_REDUNDANCY          = NTSTATUS(0xc0e7001a),
    STATUS_SPACES_DRIVE_NOT_READY        = NTSTATUS(0xc0e7001b),
    STATUS_SPACES_DRIVE_SPLIT            = NTSTATUS(0xc0e7001c),
    STATUS_SPACES_DRIVE_LOST_DATA        = NTSTATUS(0xc0e7001d),
    STATUS_SPACES_ENTRY_INCOMPLETE       = NTSTATUS(0xc0e7001e),
    STATUS_SPACES_ENTRY_INVALID          = NTSTATUS(0xc0e7001f),
    STATUS_SPACES_MARK_DIRTY             = NTSTATUS(0xc0e70020),
    STATUS_SPACES_PD_NOT_FOUND           = NTSTATUS(0xc0e70021),
    STATUS_SPACES_PD_LENGTH_MISMATCH     = NTSTATUS(0xc0e70022),
    STATUS_SPACES_PD_UNSUPPORTED_VERSION = NTSTATUS(0xc0e70023),
    STATUS_SPACES_PD_INVALID_DATA        = NTSTATUS(0xc0e70024),
    STATUS_SPACES_FLUSH_METADATA         = NTSTATUS(0xc0e70025),
    STATUS_SPACES_CACHE_FULL             = NTSTATUS(0xc0e70026),
    STATUS_SPACES_REPAIR_IN_PROGRESS     = NTSTATUS(0xc0e70027),
}

enum : NTSTATUS
{
    STATUS_VOLSNAP_ACTIVATION_TIMEOUT        = NTSTATUS(0xc0500004),
    STATUS_VOLSNAP_NO_BYPASSIO_WITH_SNAPSHOT = NTSTATUS(0xc0500005),
}

enum : NTSTATUS
{
    STATUS_SVHDX_ERROR_STORED                                = NTSTATUS(0xc05c0000),
    STATUS_SVHDX_ERROR_NOT_AVAILABLE                         = NTSTATUS(0xc05cff00),
    STATUS_SVHDX_UNIT_ATTENTION_AVAILABLE                    = NTSTATUS(0xc05cff01),
    STATUS_SVHDX_UNIT_ATTENTION_CAPACITY_DATA_CHANGED        = NTSTATUS(0xc05cff02),
    STATUS_SVHDX_UNIT_ATTENTION_RESERVATIONS_PREEMPTED       = NTSTATUS(0xc05cff03),
    STATUS_SVHDX_UNIT_ATTENTION_RESERVATIONS_RELEASED        = NTSTATUS(0xc05cff04),
    STATUS_SVHDX_UNIT_ATTENTION_REGISTRATIONS_PREEMPTED      = NTSTATUS(0xc05cff05),
    STATUS_SVHDX_UNIT_ATTENTION_OPERATING_DEFINITION_CHANGED = NTSTATUS(0xc05cff06),
}

enum : NTSTATUS
{
    STATUS_SVHDX_WRONG_FILE_TYPE  = NTSTATUS(0xc05cff08),
    STATUS_SVHDX_VERSION_MISMATCH = NTSTATUS(0xc05cff09),
}

enum NTSTATUS STATUS_SVHDX_NO_INITIATOR = NTSTATUS(0xc05cff0b);
enum NTSTATUS STATUS_SMB_NO_PREAUTH_INTEGRITY_HASH_OVERLAP = NTSTATUS(0xc05d0000);
enum NTSTATUS STATUS_SMB_GUEST_LOGON_BLOCKED = NTSTATUS(0xc05d0002);
enum NTSTATUS STATUS_NETWORK_AUTHENTICATION_PROMPT_CANCELED = NTSTATUS(0xc05d0004);
enum NTSTATUS STATUS_SMB_GUEST_LOGON_BLOCKED_SIGNING_REQUIRED = NTSTATUS(0xc05d0006);
enum NTSTATUS STATUS_SMB_ENCRYPTION_NOT_SUPPORTED_BY_PEER = NTSTATUS(0xc05d0008);
enum NTSTATUS STATUS_SECCORE_INVALID_COMMAND = NTSTATUS(0xc0e80000);
enum NTSTATUS STATUS_VSM_DMA_PROTECTION_NOT_IN_USE = NTSTATUS(0xc0450001);

enum : NTSTATUS
{
    STATUS_VSMIDK_KEYGEN_FAILURE   = NTSTATUS(0xc0450003),
    STATUS_VSMIDK_EXPORT_FAILURE   = NTSTATUS(0xc0450004),
    STATUS_VSMIDK_MODULUS_MISMATCH = NTSTATUS(0xc0450005),
}

enum : NTSTATUS
{
    STATUS_APPEXEC_HANDLE_INVALIDATED      = NTSTATUS(0xc0ec0001),
    STATUS_APPEXEC_INVALID_HOST_GENERATION = NTSTATUS(0xc0ec0002),
}

enum : NTSTATUS
{
    STATUS_APPEXEC_INVALID_HOST_STATE              = NTSTATUS(0xc0ec0004),
    STATUS_APPEXEC_NO_DONOR                        = NTSTATUS(0xc0ec0005),
    STATUS_APPEXEC_HOST_ID_MISMATCH                = NTSTATUS(0xc0ec0006),
    STATUS_APPEXEC_UNKNOWN_USER                    = NTSTATUS(0xc0ec0007),
    STATUS_APPEXEC_APP_COMPAT_BLOCK                = NTSTATUS(0xc0ec0008),
    STATUS_APPEXEC_CALLER_WAIT_TIMEOUT             = NTSTATUS(0xc0ec0009),
    STATUS_APPEXEC_CALLER_WAIT_TIMEOUT_TERMINATION = NTSTATUS(0xc0ec000a),
    STATUS_APPEXEC_CALLER_WAIT_TIMEOUT_LICENSING   = NTSTATUS(0xc0ec000b),
    STATUS_APPEXEC_CALLER_WAIT_TIMEOUT_RESOURCES   = NTSTATUS(0xc0ec000c),
}

enum : NTSTATUS
{
    STATUS_QUIC_VER_NEG_FAILURE    = NTSTATUS(0xc0240001),
    STATUS_QUIC_USER_CANCELED      = NTSTATUS(0xc0240002),
    STATUS_QUIC_INTERNAL_ERROR     = NTSTATUS(0xc0240003),
    STATUS_QUIC_PROTOCOL_VIOLATION = NTSTATUS(0xc0240004),
}

enum NTSTATUS STATUS_QUIC_CONNECTION_TIMEOUT = NTSTATUS(0xc0240006);
enum NTSTATUS STATUS_QUIC_STREAM_LIMIT_REACHED = NTSTATUS(0xc0240008);

enum : NTSTATUS
{
    STATUS_QUIC_TLS_UNEXPECTED_MESSAGE      = NTSTATUS(0xc024010a),
    STATUS_QUIC_TLS_BAD_CERTIFICATE         = NTSTATUS(0xc024012a),
    STATUS_QUIC_TLS_UNSUPPORTED_CERTIFICATE = NTSTATUS(0xc024012b),
    STATUS_QUIC_TLS_CERTIFICATE_REVOKED     = NTSTATUS(0xc024012c),
    STATUS_QUIC_TLS_CERTIFICATE_EXPIRED     = NTSTATUS(0xc024012d),
    STATUS_QUIC_TLS_CERTIFICATE_UNKNOWN     = NTSTATUS(0xc024012e),
    STATUS_QUIC_TLS_ILLEGAL_PARAMETER       = NTSTATUS(0xc024012f),
    STATUS_QUIC_TLS_UNKNOWN_CA              = NTSTATUS(0xc0240130),
    STATUS_QUIC_TLS_ACCESS_DENIED           = NTSTATUS(0xc0240131),
    STATUS_QUIC_TLS_INSUFFICIENT_SECURITY   = NTSTATUS(0xc0240147),
    STATUS_QUIC_TLS_INTERNAL_ERROR          = NTSTATUS(0xc0240150),
    STATUS_QUIC_TLS_USER_CANCELED           = NTSTATUS(0xc024015a),
    STATUS_QUIC_TLS_CERTIFICATE_REQUIRED    = NTSTATUS(0xc0240174),
}

enum NTSTATUS STATUS_IORING_SUBMISSION_QUEUE_FULL = NTSTATUS(0xc0460002);
enum NTSTATUS STATUS_IORING_SUBMISSION_QUEUE_TOO_BIG = NTSTATUS(0xc0460004);

enum : NTSTATUS
{
    STATUS_IORING_SUBMIT_IN_PROGRESS        = NTSTATUS(0xc0460006),
    STATUS_IORING_CORRUPT                   = NTSTATUS(0xc0460007),
    STATUS_IORING_COMPLETION_QUEUE_TOO_FULL = NTSTATUS(0xc0460008),
}

enum NTSTATUS STATUS_PRM_CONCURRENT_OPERATION = NTSTATUS(0xc0ee0202);

enum : NTSTATUS
{
    STATUS_PRM_MODULE_LOCKED               = NTSTATUS(0xc0ee0204),
    STATUS_PRM_UPDATE_INCOMPATIBLE_VERSION = NTSTATUS(0xc0ee0205),
    STATUS_PRM_UPDATE_MODULE_MISMATCH      = NTSTATUS(0xc0ee0206),
    STATUS_PRM_UPDATE_MODULE_NOT_FOUND     = NTSTATUS(0xc0ee0207),
    STATUS_PRM_UPDATE_MISSING_EXPORT       = NTSTATUS(0xc0ee0208),
    STATUS_PRM_UPDATE_MODULE_LOCKED        = NTSTATUS(0xc0ee0209),
    STATUS_PRM_UPDATE_BAD_SIGNATURE        = NTSTATUS(0xc0ee020a),
    STATUS_PRM_UPDATE_VERSION_MISMATCH     = NTSTATUS(0xc0ee020b),
}

enum NTSTATUS STATUS_PRM_INTERFACE_INACCESSIBLE = NTSTATUS(0xc0ee020d);

enum : NTSTATUS
{
    STATUS_AAD_CLOUDAP_E_APNONCE_INVALID                = NTSTATUS(0xc0048550),
    STATUS_AAD_CLOUDAP_E_BAD_DEVICE_ACCESS_TOKEN_FORMAT = NTSTATUS(0xc0048551),
    STATUS_AAD_CLOUDAP_E_ASSERTION_MALFORMED            = NTSTATUS(0xc0048552),
    STATUS_AAD_CLOUDAP_E_INVALID_TENANT                 = NTSTATUS(0xc0048553),
    STATUS_AAD_CLOUDAP_E_INVALID_DEVICE                 = NTSTATUS(0xc0048554),
    STATUS_AAD_CLOUDAP_E_INVALID_ACCESS_TOKEN           = NTSTATUS(0xc0048556),
    STATUS_AAD_CLOUDAP_E_INVALID_BINDING_KEY_ID         = NTSTATUS(0xc0048557),
    STATUS_AAD_CLOUDAP_E_CANT_FIND_ROOT_CERT            = NTSTATUS(0xc0048559),
    STATUS_AAD_CLOUDAP_E_ASSERTION_INVALID              = NTSTATUS(0xc004855a),
    STATUS_AAD_CLOUDAP_E_CALLER_MISMATCH                = NTSTATUS(0xc004855b),
}

enum uint APP_LOCAL_DEVICE_ID_SIZE = 0x00000020;
enum int RPC_X_NO_MORE_ENTRIES = 0x000006ec;
enum int RPC_X_SS_CHAR_TRANS_SHORT_FILE = 0x000006ee;
enum int RPC_X_SS_CONTEXT_DAMAGED = 0x000006f1;
enum int RPC_X_SS_CANNOT_GET_CALL_HANDLE = 0x000006f3;
enum int RPC_X_ENUM_VALUE_OUT_OF_RANGE = 0x000006f5;
enum int RPC_X_BAD_STUB_DATA = 0x000006f7;

enum : int
{
    RPC_X_WRONG_ES_VERSION   = 0x00000724,
    RPC_X_WRONG_STUB_VERSION = 0x00000725,
}

enum : int
{
    RPC_X_WRONG_PIPE_ORDER   = 0x00000727,
    RPC_X_WRONG_PIPE_VERSION = 0x00000728,
}

enum : int
{
    OR_INVALID_OID = 0x00000777,
    OR_INVALID_SET = 0x00000778,
}

enum : int
{
    RPC_X_PIPE_DISCIPLINE_ERROR = 0x0000077d,
    RPC_X_PIPE_EMPTY            = 0x0000077e,
}

enum int PEERDIST_ERROR_CANNOT_PARSE_CONTENTINFO = 0x00000fd3;

enum : int
{
    PEERDIST_ERROR_NO_MORE               = 0x00000fd5,
    PEERDIST_ERROR_NOT_INITIALIZED       = 0x00000fd6,
    PEERDIST_ERROR_ALREADY_INITIALIZED   = 0x00000fd7,
    PEERDIST_ERROR_SHUTDOWN_IN_PROGRESS  = 0x00000fd8,
    PEERDIST_ERROR_INVALIDATED           = 0x00000fd9,
    PEERDIST_ERROR_ALREADY_EXISTS        = 0x00000fda,
    PEERDIST_ERROR_OPERATION_NOTFOUND    = 0x00000fdb,
    PEERDIST_ERROR_ALREADY_COMPLETED     = 0x00000fdc,
    PEERDIST_ERROR_OUT_OF_BOUNDS         = 0x00000fdd,
    PEERDIST_ERROR_VERSION_UNSUPPORTED   = 0x00000fde,
    PEERDIST_ERROR_INVALID_CONFIGURATION = 0x00000fdf,
    PEERDIST_ERROR_NOT_LICENSED          = 0x00000fe0,
    PEERDIST_ERROR_SERVICE_UNAVAILABLE   = 0x00000fe1,
    PEERDIST_ERROR_TRUST_FAILURE         = 0x00000fe2,
}

enum int FRS_ERR_INVALID_API_SEQUENCE = 0x00001f41;
enum int FRS_ERR_STOPPING_SERVICE = 0x00001f43;

enum : int
{
    FRS_ERR_INTERNAL     = 0x00001f45,
    FRS_ERR_SERVICE_COMM = 0x00001f46,
}

enum int FRS_ERR_AUTHENTICATION = 0x00001f48;
enum int FRS_ERR_PARENT_AUTHENTICATION = 0x00001f4a;
enum int FRS_ERR_PARENT_TO_CHILD_COMM = 0x00001f4c;

enum : int
{
    FRS_ERR_SYSVOL_POPULATE_TIMEOUT = 0x00001f4e,
    FRS_ERR_SYSVOL_IS_BUSY          = 0x00001f4f,
    FRS_ERR_SYSVOL_DEMOTE           = 0x00001f50,
}

enum int DNS_INFO_NO_RECORDS = 0x0000251d;

enum : int
{
    DNS_STATUS_FQDN             = 0x00002555,
    DNS_STATUS_DOTTED_NAME      = 0x00002556,
    DNS_STATUS_SINGLE_PART_NAME = 0x00002557,
}

enum int DNS_WARNING_DOMAIN_UNDELETED = 0x000025f4;
enum int DNS_INFO_ADDED_LOCAL_WINS = 0x00002619;

enum : int
{
    WARNING_IPSEC_MM_POLICY_PRUNED = 0x000032e0,
    WARNING_IPSEC_QM_POLICY_PRUNED = 0x000032e1,
}

enum : int
{
    STORE_ERROR_UNLICENSED_USER         = 0x00003df6,
    STORE_ERROR_PENDING_COM_TRANSACTION = 0x00003df7,
}

enum : uint
{
    SEVERITY_SUCCESS = 0x00000000,
    SEVERITY_ERROR   = 0x00000001,
}

enum HRESULT E_UNEXPECTED = HRESULT(0x8000ffff);
enum HRESULT E_POINTER = HRESULT(0x80004003);

enum : HRESULT
{
    E_ABORT        = HRESULT(0x80004004),
    E_ACCESSDENIED = HRESULT(0x80070005),
}

enum HRESULT E_CHANGED_STATE = HRESULT(0x8000000c);
enum HRESULT E_ILLEGAL_METHOD_CALL = HRESULT(0x8000000e);

enum : HRESULT
{
    RO_E_METADATA_NAME_IS_NAMESPACE   = HRESULT(0x80000010),
    RO_E_METADATA_INVALID_TYPE_FORMAT = HRESULT(0x80000011),
}

enum : HRESULT
{
    RO_E_CLOSED          = HRESULT(0x80000013),
    RO_E_EXCLUSIVE_WRITE = HRESULT(0x80000014),
}

enum HRESULT RO_E_ERROR_STRING_NOT_FOUND = HRESULT(0x80000016);
enum HRESULT E_ILLEGAL_DELEGATE_ASSIGNMENT = HRESULT(0x80000018);

enum : HRESULT
{
    E_APPLICATION_EXITING      = HRESULT(0x8000001a),
    E_APPLICATION_VIEW_EXITING = HRESULT(0x8000001b),
}

enum HRESULT RO_E_UNSUPPORTED_FROM_MTA = HRESULT(0x8000001d);
enum HRESULT RO_E_BLOCKED_CROSS_ASTA_CALL = HRESULT(0x8000001f);
enum HRESULT RO_E_CANNOT_ACTIVATE_UNIVERSAL_APPLICATION_SERVER = HRESULT(0x80000021);
enum HRESULT CO_E_INIT_SHARED_ALLOCATOR = HRESULT(0x80004007);

enum : HRESULT
{
    CO_E_INIT_CLASS_CACHE             = HRESULT(0x80004009),
    CO_E_INIT_RPC_CHANNEL             = HRESULT(0x8000400a),
    CO_E_INIT_TLS_SET_CHANNEL_CONTROL = HRESULT(0x8000400b),
    CO_E_INIT_TLS_CHANNEL_CONTROL     = HRESULT(0x8000400c),
}

enum : HRESULT
{
    CO_E_INIT_SCM_MUTEX_EXISTS        = HRESULT(0x8000400e),
    CO_E_INIT_SCM_FILE_MAPPING_EXISTS = HRESULT(0x8000400f),
    CO_E_INIT_SCM_MAP_VIEW_OF_FILE    = HRESULT(0x80004010),
    CO_E_INIT_SCM_EXEC_FAILURE        = HRESULT(0x80004011),
}

enum HRESULT CO_E_CANT_REMOTE = HRESULT(0x80004013);
enum HRESULT CO_E_WRONG_SERVER_IDENTITY = HRESULT(0x80004015);
enum HRESULT CO_E_RUNAS_SYNTAX = HRESULT(0x80004017);
enum HRESULT CO_E_RUNAS_CREATEPROCESS_FAILURE = HRESULT(0x80004019);
enum HRESULT CO_E_LAUNCH_PERMSSION_DENIED = HRESULT(0x8000401b);
enum HRESULT CO_E_REMOTE_COMMUNICATION_FAILURE = HRESULT(0x8000401d);
enum HRESULT CO_E_CLSREG_INCONSISTENT = HRESULT(0x8000401f);
enum HRESULT CO_E_NOT_SUPPORTED = HRESULT(0x80004021);
enum HRESULT CO_E_MSI_ERROR = HRESULT(0x80004023);

enum : HRESULT
{
    CO_E_SERVER_PAUSED     = HRESULT(0x80004025),
    CO_E_SERVER_NOT_PAUSED = HRESULT(0x80004026),
}

enum HRESULT CO_E_CLRNOTAVAILABLE = HRESULT(0x80004028);
enum HRESULT CO_E_SERVER_INIT_TIMEOUT = HRESULT(0x8000402a);
enum HRESULT CO_E_TRACKER_CONFIG = HRESULT(0x80004030);
enum HRESULT CO_E_SXS_CONFIG = HRESULT(0x80004032);
enum HRESULT CO_E_UNREVOKED_REGISTRATION_ON_APARTMENT_SHUTDOWN = HRESULT(0x80004034);

enum : HRESULT
{
    S_OK    = HRESULT(0x00000000),
    S_FALSE = HRESULT(0x00000001),
}

enum HRESULT OLE_E_LAST = HRESULT(0x800400ff);
enum HRESULT OLE_S_LAST = HRESULT(0x000400ff);

enum : HRESULT
{
    OLE_E_ADVF        = HRESULT(0x80040001),
    OLE_E_ENUM_NOMORE = HRESULT(0x80040002),
}

enum : HRESULT
{
    OLE_E_NOCONNECTION      = HRESULT(0x80040004),
    OLE_E_NOTRUNNING        = HRESULT(0x80040005),
    OLE_E_NOCACHE           = HRESULT(0x80040006),
    OLE_E_BLANK             = HRESULT(0x80040007),
    OLE_E_CLASSDIFF         = HRESULT(0x80040008),
    OLE_E_CANT_GETMONIKER   = HRESULT(0x80040009),
    OLE_E_CANT_BINDTOSOURCE = HRESULT(0x8004000a),
}

enum HRESULT OLE_E_PROMPTSAVECANCELLED = HRESULT(0x8004000c);
enum HRESULT OLE_E_WRONGCOMPOBJ = HRESULT(0x8004000e);
enum HRESULT OLE_E_NOT_INPLACEACTIVE = HRESULT(0x80040010);
enum HRESULT OLE_E_NOSTORAGE = HRESULT(0x80040012);
enum HRESULT DV_E_DVTARGETDEVICE = HRESULT(0x80040065);
enum HRESULT DV_E_STATDATA = HRESULT(0x80040067);

enum : HRESULT
{
    DV_E_TYMED      = HRESULT(0x80040069),
    DV_E_CLIPFORMAT = HRESULT(0x8004006a),
}

enum HRESULT DV_E_DVTARGETDEVICE_SIZE = HRESULT(0x8004006c);

enum : int
{
    DRAGDROP_E_FIRST = 0x80040100,
    DRAGDROP_E_LAST  = 0x8004010f,
    DRAGDROP_S_FIRST = 0x00040100,
    DRAGDROP_S_LAST  = 0x0004010f,
}

enum HRESULT DRAGDROP_E_ALREADYREGISTERED = HRESULT(0x80040101);
enum HRESULT DRAGDROP_E_CONCURRENT_DRAG_ATTEMPTED = HRESULT(0x80040103);

enum : int
{
    CLASSFACTORY_E_LAST  = 0x8004011f,
    CLASSFACTORY_S_FIRST = 0x00040110,
    CLASSFACTORY_S_LAST  = 0x0004011f,
}

enum HRESULT CLASS_E_CLASSNOTAVAILABLE = HRESULT(0x80040111);

enum : int
{
    MARSHAL_E_FIRST = 0x80040120,
    MARSHAL_E_LAST  = 0x8004012f,
    MARSHAL_S_FIRST = 0x00040120,
    MARSHAL_S_LAST  = 0x0004012f,
}

enum : int
{
    DATA_E_LAST  = 0x8004013f,
    DATA_S_FIRST = 0x00040130,
    DATA_S_LAST  = 0x0004013f,
}

enum : int
{
    VIEW_E_LAST  = 0x8004014f,
    VIEW_S_FIRST = 0x00040140,
    VIEW_S_LAST  = 0x0004014f,
}

enum : int
{
    REGDB_E_FIRST = 0x80040150,
    REGDB_E_LAST  = 0x8004015f,
    REGDB_S_FIRST = 0x00040150,
    REGDB_S_LAST  = 0x0004015f,
}

enum : HRESULT
{
    REGDB_E_WRITEREGDB   = HRESULT(0x80040151),
    REGDB_E_KEYMISSING   = HRESULT(0x80040152),
    REGDB_E_INVALIDVALUE = HRESULT(0x80040153),
}

enum : HRESULT
{
    REGDB_E_IIDNOTREG         = HRESULT(0x80040155),
    REGDB_E_BADTHREADINGMODEL = HRESULT(0x80040156),
}

enum : int
{
    CAT_E_FIRST = 0x80040160,
    CAT_E_LAST  = 0x80040161,
}

enum HRESULT CAT_E_NODESCRIPTION = HRESULT(0x80040161);
enum int CS_E_LAST = 0x8004016f;
enum HRESULT CS_E_NOT_DELETABLE = HRESULT(0x80040165);
enum HRESULT CS_E_INVALID_VERSION = HRESULT(0x80040167);

enum : HRESULT
{
    CS_E_OBJECT_NOTFOUND       = HRESULT(0x80040169),
    CS_E_OBJECT_ALREADY_EXISTS = HRESULT(0x8004016a),
}

enum HRESULT CS_E_NETWORK_ERROR = HRESULT(0x8004016c);
enum HRESULT CS_E_SCHEMA_MISMATCH = HRESULT(0x8004016e);

enum : int
{
    CACHE_E_FIRST = 0x80040170,
    CACHE_E_LAST  = 0x8004017f,
    CACHE_S_FIRST = 0x00040170,
    CACHE_S_LAST  = 0x0004017f,
}

enum : int
{
    OLEOBJ_E_FIRST = 0x80040180,
    OLEOBJ_E_LAST  = 0x8004018f,
    OLEOBJ_S_FIRST = 0x00040180,
    OLEOBJ_S_LAST  = 0x0004018f,
}

enum HRESULT OLEOBJ_E_INVALIDVERB = HRESULT(0x80040181);

enum : int
{
    CLIENTSITE_E_LAST  = 0x8004019f,
    CLIENTSITE_S_FIRST = 0x00040190,
    CLIENTSITE_S_LAST  = 0x0004019f,
}

enum HRESULT INPLACE_E_NOTOOLSPACE = HRESULT(0x800401a1);

enum : int
{
    INPLACE_E_LAST  = 0x800401af,
    INPLACE_S_FIRST = 0x000401a0,
    INPLACE_S_LAST  = 0x000401af,
}

enum : int
{
    ENUM_E_LAST  = 0x800401bf,
    ENUM_S_FIRST = 0x000401b0,
    ENUM_S_LAST  = 0x000401bf,
}

enum : int
{
    CONVERT10_E_LAST  = 0x800401cf,
    CONVERT10_S_FIRST = 0x000401c0,
    CONVERT10_S_LAST  = 0x000401cf,
}

enum : HRESULT
{
    CONVERT10_E_OLESTREAM_PUT           = HRESULT(0x800401c1),
    CONVERT10_E_OLESTREAM_FMT           = HRESULT(0x800401c2),
    CONVERT10_E_OLESTREAM_BITMAP_TO_DIB = HRESULT(0x800401c3),
}

enum : HRESULT
{
    CONVERT10_E_STG_NO_STD_STREAM = HRESULT(0x800401c5),
    CONVERT10_E_STG_DIB_TO_BITMAP = HRESULT(0x800401c6),
    CONVERT10_E_OLELINK_DISABLED  = HRESULT(0x800401c7),
}

enum : int
{
    CLIPBRD_E_LAST  = 0x800401df,
    CLIPBRD_S_FIRST = 0x000401d0,
    CLIPBRD_S_LAST  = 0x000401df,
}

enum : HRESULT
{
    CLIPBRD_E_CANT_EMPTY = HRESULT(0x800401d1),
    CLIPBRD_E_CANT_SET   = HRESULT(0x800401d2),
    CLIPBRD_E_BAD_DATA   = HRESULT(0x800401d3),
    CLIPBRD_E_CANT_CLOSE = HRESULT(0x800401d4),
}

enum int MK_E_LAST = 0x800401ef;
enum int MK_S_LAST = 0x000401ef;
enum HRESULT MK_E_EXCEEDEDDEADLINE = HRESULT(0x800401e1);
enum HRESULT MK_E_UNAVAILABLE = HRESULT(0x800401e3);
enum HRESULT MK_E_NOOBJECT = HRESULT(0x800401e5);
enum HRESULT MK_E_INTERMEDIATEINTERFACENOTSUPPORTED = HRESULT(0x800401e7);
enum HRESULT MK_E_NOTBOUND = HRESULT(0x800401e9);
enum HRESULT MK_E_MUSTBOTHERUSER = HRESULT(0x800401eb);

enum : HRESULT
{
    MK_E_NOSTORAGE = HRESULT(0x800401ed),
    MK_E_NOPREFIX  = HRESULT(0x800401ee),
}

enum : int
{
    CO_E_FIRST = 0x800401f0,
    CO_E_LAST  = 0x800401ff,
}

enum int CO_S_LAST = 0x000401ff;
enum HRESULT CO_E_CANTDETERMINECLASS = HRESULT(0x800401f2);
enum HRESULT CO_E_IIDSTRING = HRESULT(0x800401f4);
enum HRESULT CO_E_APPSINGLEUSE = HRESULT(0x800401f6);
enum HRESULT CO_E_DLLNOTFOUND = HRESULT(0x800401f8);
enum HRESULT CO_E_WRONGOSFORAPP = HRESULT(0x800401fa);

enum : HRESULT
{
    CO_E_OBJISREG        = HRESULT(0x800401fc),
    CO_E_OBJNOTCONNECTED = HRESULT(0x800401fd),
}

enum HRESULT CO_E_RELEASED = HRESULT(0x800401ff);

enum : int
{
    EVENT_E_LAST  = 0x8004021f,
    EVENT_S_FIRST = 0x00040200,
    EVENT_S_LAST  = 0x0004021f,
}

enum HRESULT EVENT_E_ALL_SUBSCRIBERS_FAILED = HRESULT(0x80040201);

enum : HRESULT
{
    EVENT_E_QUERYSYNTAX          = HRESULT(0x80040203),
    EVENT_E_QUERYFIELD           = HRESULT(0x80040204),
    EVENT_E_INTERNALEXCEPTION    = HRESULT(0x80040205),
    EVENT_E_INTERNALERROR        = HRESULT(0x80040206),
    EVENT_E_INVALID_PER_USER_SID = HRESULT(0x80040207),
}

enum HRESULT EVENT_E_TOO_MANY_METHODS = HRESULT(0x80040209);
enum HRESULT EVENT_E_NOT_ALL_REMOVED = HRESULT(0x8004020b);

enum : HRESULT
{
    EVENT_E_CANT_MODIFY_OR_DELETE_UNCONFIGURED_OBJECT = HRESULT(0x8004020d),
    EVENT_E_CANT_MODIFY_OR_DELETE_CONFIGURED_OBJECT   = HRESULT(0x8004020e),
}

enum HRESULT EVENT_E_PER_USER_SID_NOT_LOGGED_ON = HRESULT(0x80040210);
enum HRESULT TPC_E_NO_DEFAULT_TABLET = HRESULT(0x80040212);

enum : HRESULT
{
    TPC_E_INVALID_INPUT_RECT = HRESULT(0x80040219),
    TPC_E_INVALID_STROKE     = HRESULT(0x80040222),
}

enum HRESULT TPC_E_NOT_RELEVANT = HRESULT(0x80040232);
enum HRESULT TPC_E_RECOGNIZER_NOT_REGISTERED = HRESULT(0x80040235);
enum HRESULT TPC_E_OUT_OF_ORDER_CALL = HRESULT(0x80040237);

enum : HRESULT
{
    TPC_E_INVALID_CONFIGURATION        = HRESULT(0x80040239),
    TPC_E_INVALID_DATA_FROM_RECOGNIZER = HRESULT(0x8004023a),
}

enum HRESULT TPC_S_INTERRUPTED = HRESULT(0x00040253);

enum : uint
{
    XACT_E_FIRST = 0x8004d000,
    XACT_E_LAST  = 0x8004d02b,
    XACT_S_FIRST = 0x0004d000,
    XACT_S_LAST  = 0x0004d010,
}

enum : HRESULT
{
    XACT_E_CANTRETAIN      = HRESULT(0x8004d001),
    XACT_E_COMMITFAILED    = HRESULT(0x8004d002),
    XACT_E_COMMITPREVENTED = HRESULT(0x8004d003),
}

enum : HRESULT
{
    XACT_E_HEURISTICCOMMIT = HRESULT(0x8004d005),
    XACT_E_HEURISTICDAMAGE = HRESULT(0x8004d006),
    XACT_E_HEURISTICDANGER = HRESULT(0x8004d007),
}

enum : HRESULT
{
    XACT_E_NOASYNC       = HRESULT(0x8004d009),
    XACT_E_NOENLIST      = HRESULT(0x8004d00a),
    XACT_E_NOISORETAIN   = HRESULT(0x8004d00b),
    XACT_E_NORESOURCE    = HRESULT(0x8004d00c),
    XACT_E_NOTCURRENT    = HRESULT(0x8004d00d),
    XACT_E_NOTRANSACTION = HRESULT(0x8004d00e),
    XACT_E_NOTSUPPORTED  = HRESULT(0x8004d00f),
}

enum : HRESULT
{
    XACT_E_WRONGSTATE  = HRESULT(0x8004d011),
    XACT_E_WRONGUOW    = HRESULT(0x8004d012),
    XACT_E_XTIONEXISTS = HRESULT(0x8004d013),
}

enum : HRESULT
{
    XACT_E_INVALIDCOOKIE     = HRESULT(0x8004d015),
    XACT_E_INDOUBT           = HRESULT(0x8004d016),
    XACT_E_NOTIMEOUT         = HRESULT(0x8004d017),
    XACT_E_ALREADYINPROGRESS = HRESULT(0x8004d018),
}

enum : HRESULT
{
    XACT_E_LOGFULL        = HRESULT(0x8004d01a),
    XACT_E_TMNOTAVAILABLE = HRESULT(0x8004d01b),
}

enum HRESULT XACT_E_CONNECTION_DENIED = HRESULT(0x8004d01d);

enum : HRESULT
{
    XACT_E_TIP_CONNECT_FAILED = HRESULT(0x8004d01f),
    XACT_E_TIP_PROTOCOL_ERROR = HRESULT(0x8004d020),
    XACT_E_TIP_PULL_FAILED    = HRESULT(0x8004d021),
}

enum HRESULT XACT_E_TIP_DISABLED = HRESULT(0x8004d023);
enum HRESULT XACT_E_PARTNER_NETWORK_TX_DISABLED = HRESULT(0x8004d025);

enum : HRESULT
{
    XACT_E_UNABLE_TO_READ_DTC_CONFIG = HRESULT(0x8004d027),
    XACT_E_UNABLE_TO_LOAD_DTC_PROXY  = HRESULT(0x8004d028),
}

enum HRESULT XACT_E_PUSH_COMM_FAILURE = HRESULT(0x8004d02a);
enum HRESULT XACT_E_LU_TX_DISABLED = HRESULT(0x8004d02c);
enum HRESULT XACT_E_CLERKEXISTS = HRESULT(0x8004d081);
enum HRESULT XACT_E_TRANSACTIONCLOSED = HRESULT(0x8004d083);
enum HRESULT XACT_E_REPLAYREQUEST = HRESULT(0x8004d085);

enum : HRESULT
{
    XACT_S_DEFECT       = HRESULT(0x0004d001),
    XACT_S_READONLY     = HRESULT(0x0004d002),
    XACT_S_SOMENORETAIN = HRESULT(0x0004d003),
}

enum : HRESULT
{
    XACT_S_MADECHANGESCONTENT = HRESULT(0x0004d005),
    XACT_S_MADECHANGESINFORM  = HRESULT(0x0004d006),
}

enum : HRESULT
{
    XACT_S_ABORTING    = HRESULT(0x0004d008),
    XACT_S_SINGLEPHASE = HRESULT(0x0004d009),
}

enum HRESULT XACT_S_LASTRESOURCEMANAGER = HRESULT(0x0004d010);

enum : int
{
    CONTEXT_E_LAST  = 0x8004e02f,
    CONTEXT_S_FIRST = 0x0004e000,
    CONTEXT_S_LAST  = 0x0004e02f,
}

enum : HRESULT
{
    CONTEXT_E_ABORTING       = HRESULT(0x8004e003),
    CONTEXT_E_NOCONTEXT      = HRESULT(0x8004e004),
    CONTEXT_E_WOULD_DEADLOCK = HRESULT(0x8004e005),
    CONTEXT_E_SYNCH_TIMEOUT  = HRESULT(0x8004e006),
    CONTEXT_E_OLDREF         = HRESULT(0x8004e007),
    CONTEXT_E_ROLENOTFOUND   = HRESULT(0x8004e00c),
    CONTEXT_E_TMNOTAVAILABLE = HRESULT(0x8004e00f),
}

enum : HRESULT
{
    CO_E_ACTIVATIONFAILED_EVENTLOGGED  = HRESULT(0x8004e022),
    CO_E_ACTIVATIONFAILED_CATALOGERROR = HRESULT(0x8004e023),
    CO_E_ACTIVATIONFAILED_TIMEOUT      = HRESULT(0x8004e024),
}

enum : HRESULT
{
    CONTEXT_E_NOJIT         = HRESULT(0x8004e026),
    CONTEXT_E_NOTRANSACTION = HRESULT(0x8004e027),
}

enum HRESULT CO_E_NOIISINTRINSICS = HRESULT(0x8004e029);

enum : HRESULT
{
    CO_E_DBERROR        = HRESULT(0x8004e02b),
    CO_E_NOTPOOLED      = HRESULT(0x8004e02c),
    CO_E_NOTCONSTRUCTED = HRESULT(0x8004e02d),
}

enum HRESULT CO_E_ISOLEVELMISMATCH = HRESULT(0x8004e02f);
enum HRESULT CO_E_EXIT_TRANSACTION_SCOPE_NOT_CALLED = HRESULT(0x8004e031);

enum : HRESULT
{
    OLE_S_STATIC         = HRESULT(0x00040001),
    OLE_S_MAC_CLIPFORMAT = HRESULT(0x00040002),
}

enum : HRESULT
{
    DRAGDROP_S_CANCEL            = HRESULT(0x00040101),
    DRAGDROP_S_USEDEFAULTCURSORS = HRESULT(0x00040102),
}

enum HRESULT VIEW_S_ALREADY_FROZEN = HRESULT(0x00040140);

enum : HRESULT
{
    CACHE_S_SAMECACHE             = HRESULT(0x00040171),
    CACHE_S_SOMECACHES_NOTUPDATED = HRESULT(0x00040172),
}

enum HRESULT OLEOBJ_S_CANNOT_DOVERB_NOW = HRESULT(0x00040181);
enum HRESULT INPLACE_S_TRUNCATED = HRESULT(0x000401a0);
enum HRESULT MK_S_REDUCED_TO_SELF = HRESULT(0x000401e2);

enum : HRESULT
{
    MK_S_HIM                      = HRESULT(0x000401e5),
    MK_S_US                       = HRESULT(0x000401e6),
    MK_S_MONIKERALREADYREGISTERED = HRESULT(0x000401e7),
}

enum : HRESULT
{
    SCHED_S_TASK_RUNNING           = HRESULT(0x00041301),
    SCHED_S_TASK_DISABLED          = HRESULT(0x00041302),
    SCHED_S_TASK_HAS_NOT_RUN       = HRESULT(0x00041303),
    SCHED_S_TASK_NO_MORE_RUNS      = HRESULT(0x00041304),
    SCHED_S_TASK_NOT_SCHEDULED     = HRESULT(0x00041305),
    SCHED_S_TASK_TERMINATED        = HRESULT(0x00041306),
    SCHED_S_TASK_NO_VALID_TRIGGERS = HRESULT(0x00041307),
}

enum HRESULT SCHED_E_TRIGGER_NOT_FOUND = HRESULT(0x80041309);
enum HRESULT SCHED_E_TASK_NOT_RUNNING = HRESULT(0x8004130b);
enum HRESULT SCHED_E_CANNOT_OPEN_TASK = HRESULT(0x8004130d);

enum : HRESULT
{
    SCHED_E_ACCOUNT_INFORMATION_NOT_SET = HRESULT(0x8004130f),
    SCHED_E_ACCOUNT_NAME_NOT_FOUND      = HRESULT(0x80041310),
    SCHED_E_ACCOUNT_DBASE_CORRUPT       = HRESULT(0x80041311),
}

enum HRESULT SCHED_E_UNKNOWN_OBJECT_VERSION = HRESULT(0x80041313);
enum HRESULT SCHED_E_SERVICE_NOT_RUNNING = HRESULT(0x80041315);

enum : HRESULT
{
    SCHED_E_NAMESPACE    = HRESULT(0x80041317),
    SCHED_E_INVALIDVALUE = HRESULT(0x80041318),
}

enum HRESULT SCHED_E_MALFORMEDXML = HRESULT(0x8004131a);
enum HRESULT SCHED_S_BATCH_LOGON_PROBLEM = HRESULT(0x0004131c);
enum HRESULT SCHED_E_PAST_END_BOUNDARY = HRESULT(0x8004131e);
enum HRESULT SCHED_E_USER_NOT_LOGGED_ON = HRESULT(0x80041320);

enum : HRESULT
{
    SCHED_E_SERVICE_NOT_AVAILABLE = HRESULT(0x80041322),
    SCHED_E_SERVICE_TOO_BUSY      = HRESULT(0x80041323),
}

enum HRESULT SCHED_S_TASK_QUEUED = HRESULT(0x00041325);
enum HRESULT SCHED_E_TASK_NOT_V1_COMPAT = HRESULT(0x80041327);
enum HRESULT SCHED_E_TASK_NOT_UBPM_COMPAT = HRESULT(0x80041329);
enum HRESULT CO_E_CLASS_CREATE_FAILED = HRESULT(0x80080001);
enum HRESULT CO_E_SCM_RPC_FAILURE = HRESULT(0x80080003);
enum HRESULT CO_E_SERVER_EXEC_FAILURE = HRESULT(0x80080005);
enum HRESULT MK_E_NO_NORMALIZED = HRESULT(0x80080007);

enum : HRESULT
{
    MEM_E_INVALID_ROOT = HRESULT(0x80080009),
    MEM_E_INVALID_LINK = HRESULT(0x80080010),
    MEM_E_INVALID_SIZE = HRESULT(0x80080011),
}

enum HRESULT CO_S_MACHINENAMENOTFOUND = HRESULT(0x00080013);
enum HRESULT CO_E_RUNAS_VALUE_MUST_BE_AAA = HRESULT(0x80080016);
enum HRESULT APPX_E_PACKAGING_INTERNAL = HRESULT(0x80080200);
enum HRESULT APPX_E_RELATIONSHIPS_NOT_ALLOWED = HRESULT(0x80080202);

enum : HRESULT
{
    APPX_E_INVALID_MANIFEST = HRESULT(0x80080204),
    APPX_E_INVALID_BLOCKMAP = HRESULT(0x80080205),
}

enum HRESULT APPX_E_BLOCK_HASH_INVALID = HRESULT(0x80080207);

enum : HRESULT
{
    APPX_E_INVALID_SIP_CLIENT_DATA = HRESULT(0x80080209),
    APPX_E_INVALID_KEY_INFO        = HRESULT(0x8008020a),
    APPX_E_INVALID_CONTENTGROUPMAP = HRESULT(0x8008020b),
    APPX_E_INVALID_APPINSTALLER    = HRESULT(0x8008020c),
}

enum HRESULT APPX_E_DELTA_PACKAGE_MISSING_FILE = HRESULT(0x8008020e);
enum HRESULT APPX_E_DELTA_APPENDED_PACKAGE_NOT_ALLOWED = HRESULT(0x80080210);
enum HRESULT APPX_E_INVALID_PACKAGESIGNCONFIG = HRESULT(0x80080212);
enum HRESULT APPX_E_FILE_COMPRESSION_MISMATCH = HRESULT(0x80080214);
enum HRESULT APPX_E_INVALID_ENCRYPTION_EXCLUSION_FILE_LIST = HRESULT(0x80080216);
enum HRESULT APPX_E_INVALID_PUBLISHER_BRIDGING = HRESULT(0x80080218);
enum HRESULT BT_E_SPURIOUS_ACTIVATION = HRESULT(0x80080300);
enum HRESULT DISP_E_MEMBERNOTFOUND = HRESULT(0x80020003);
enum HRESULT DISP_E_TYPEMISMATCH = HRESULT(0x80020005);
enum HRESULT DISP_E_NONAMEDARGS = HRESULT(0x80020007);

enum : HRESULT
{
    DISP_E_EXCEPTION   = HRESULT(0x80020009),
    DISP_E_OVERFLOW    = HRESULT(0x8002000a),
    DISP_E_BADINDEX    = HRESULT(0x8002000b),
    DISP_E_UNKNOWNLCID = HRESULT(0x8002000c),
}

enum HRESULT DISP_E_BADPARAMCOUNT = HRESULT(0x8002000e);

enum : HRESULT
{
    DISP_E_BADCALLEE      = HRESULT(0x80020010),
    DISP_E_NOTACOLLECTION = HRESULT(0x80020011),
}

enum HRESULT DISP_E_BUFFERTOOSMALL = HRESULT(0x80020013);
enum HRESULT TYPE_E_FIELDNOTFOUND = HRESULT(0x80028017);
enum HRESULT TYPE_E_UNSUPFORMAT = HRESULT(0x80028019);
enum HRESULT TYPE_E_LIBNOTREGISTERED = HRESULT(0x8002801d);
enum HRESULT TYPE_E_QUALIFIEDNAMEDISALLOWED = HRESULT(0x80028028);
enum HRESULT TYPE_E_WRONGTYPEKIND = HRESULT(0x8002802a);
enum HRESULT TYPE_E_AMBIGUOUSNAME = HRESULT(0x8002802c);
enum HRESULT TYPE_E_UNKNOWNLCID = HRESULT(0x8002802e);
enum HRESULT TYPE_E_BADMODULEKIND = HRESULT(0x800288bd);
enum HRESULT TYPE_E_DUPLICATEID = HRESULT(0x800288c6);
enum HRESULT TYPE_E_TYPEMISMATCH = HRESULT(0x80028ca0);

enum : HRESULT
{
    TYPE_E_IOERROR           = HRESULT(0x80028ca2),
    TYPE_E_CANTCREATETMPFILE = HRESULT(0x80028ca3),
    TYPE_E_CANTLOADLIBRARY   = HRESULT(0x80029c4a),
}

enum HRESULT TYPE_E_CIRCULARTYPE = HRESULT(0x80029c84);
enum HRESULT STG_E_FILENOTFOUND = HRESULT(0x80030002);
enum HRESULT STG_E_TOOMANYOPENFILES = HRESULT(0x80030004);

enum : HRESULT
{
    STG_E_INVALIDHANDLE      = HRESULT(0x80030006),
    STG_E_INSUFFICIENTMEMORY = HRESULT(0x80030008),
}

enum HRESULT STG_E_NOMOREFILES = HRESULT(0x80030012);
enum HRESULT STG_E_SEEKERROR = HRESULT(0x80030019);
enum HRESULT STG_E_READFAULT = HRESULT(0x8003001e);
enum HRESULT STG_E_LOCKVIOLATION = HRESULT(0x80030021);
enum HRESULT STG_E_INVALIDPARAMETER = HRESULT(0x80030057);
enum HRESULT STG_E_PROPSETMISMATCHED = HRESULT(0x800300f0);

enum : HRESULT
{
    STG_E_INVALIDHEADER = HRESULT(0x800300fb),
    STG_E_INVALIDNAME   = HRESULT(0x800300fc),
}

enum HRESULT STG_E_UNIMPLEMENTEDFUNCTION = HRESULT(0x800300fe);

enum : HRESULT
{
    STG_E_INUSE      = HRESULT(0x80030100),
    STG_E_NOTCURRENT = HRESULT(0x80030101),
}

enum : HRESULT
{
    STG_E_CANTSAVE      = HRESULT(0x80030103),
    STG_E_OLDFORMAT     = HRESULT(0x80030104),
    STG_E_OLDDLL        = HRESULT(0x80030105),
    STG_E_SHAREREQUIRED = HRESULT(0x80030106),
}

enum HRESULT STG_E_EXTANTMARSHALLINGS = HRESULT(0x80030108);
enum HRESULT STG_E_BADBASEADDRESS = HRESULT(0x80030110);
enum HRESULT STG_E_NOTSIMPLEFORMAT = HRESULT(0x80030112);
enum HRESULT STG_E_TERMINATED = HRESULT(0x80030202);

enum : HRESULT
{
    STG_S_BLOCK         = HRESULT(0x00030201),
    STG_S_RETRYNOW      = HRESULT(0x00030202),
    STG_S_MONITORING    = HRESULT(0x00030203),
    STG_S_MULTIPLEOPENS = HRESULT(0x00030204),
}

enum HRESULT STG_S_CANNOTCONSOLIDATE = HRESULT(0x00030206);

enum : HRESULT
{
    STG_E_FIRMWARE_SLOT_INVALID  = HRESULT(0x80030208),
    STG_E_FIRMWARE_IMAGE_INVALID = HRESULT(0x80030209),
}

enum HRESULT STG_E_STATUS_COPY_PROTECTION_FAILURE = HRESULT(0x80030305);

enum : HRESULT
{
    STG_E_CSS_KEY_NOT_PRESENT     = HRESULT(0x80030307),
    STG_E_CSS_KEY_NOT_ESTABLISHED = HRESULT(0x80030308),
}

enum HRESULT STG_E_CSS_REGION_MISMATCH = HRESULT(0x8003030a);

enum : HRESULT
{
    RPC_E_CALL_REJECTED       = HRESULT(0x80010001),
    RPC_E_CALL_CANCELED       = HRESULT(0x80010002),
    RPC_E_CANTPOST_INSENDCALL = HRESULT(0x80010003),
}

enum HRESULT RPC_E_CANTCALLOUT_INEXTERNALCALL = HRESULT(0x80010005);
enum HRESULT RPC_E_SERVER_DIED = HRESULT(0x80010007);
enum HRESULT RPC_E_INVALID_DATAPACKET = HRESULT(0x80010009);

enum : HRESULT
{
    RPC_E_CLIENT_CANTMARSHAL_DATA   = HRESULT(0x8001000b),
    RPC_E_CLIENT_CANTUNMARSHAL_DATA = HRESULT(0x8001000c),
}

enum HRESULT RPC_E_SERVER_CANTUNMARSHAL_DATA = HRESULT(0x8001000e);
enum HRESULT RPC_E_INVALID_PARAMETER = HRESULT(0x80010010);
enum HRESULT RPC_E_SERVER_DIED_DNE = HRESULT(0x80010012);
enum HRESULT RPC_E_OUT_OF_RESOURCES = HRESULT(0x80010101);
enum HRESULT RPC_E_NOT_REGISTERED = HRESULT(0x80010103);
enum HRESULT RPC_E_SERVERFAULT = HRESULT(0x80010105);
enum HRESULT RPC_E_INVALIDMETHOD = HRESULT(0x80010107);

enum : HRESULT
{
    RPC_E_RETRY                 = HRESULT(0x80010109),
    RPC_E_SERVERCALL_RETRYLATER = HRESULT(0x8001010a),
    RPC_E_SERVERCALL_REJECTED   = HRESULT(0x8001010b),
}

enum HRESULT RPC_E_CANTCALLOUT_ININPUTSYNCCALL = HRESULT(0x8001010d);
enum HRESULT RPC_E_THREAD_NOT_INIT = HRESULT(0x8001010f);

enum : HRESULT
{
    RPC_E_INVALID_HEADER    = HRESULT(0x80010111),
    RPC_E_INVALID_EXTENSION = HRESULT(0x80010112),
    RPC_E_INVALID_IPID      = HRESULT(0x80010113),
    RPC_E_INVALID_OBJECT    = HRESULT(0x80010114),
}

enum HRESULT RPC_S_WAITONTIMER = HRESULT(0x80010116);
enum HRESULT RPC_E_UNSECURE_CALL = HRESULT(0x80010118);
enum HRESULT RPC_E_NO_GOOD_SECURITY_PACKAGES = HRESULT(0x8001011a);
enum HRESULT RPC_E_REMOTE_DISABLED = HRESULT(0x8001011c);
enum HRESULT RPC_E_NO_CONTEXT = HRESULT(0x8001011e);

enum : HRESULT
{
    RPC_E_NO_SYNC          = HRESULT(0x80010120),
    RPC_E_FULLSIC_REQUIRED = HRESULT(0x80010121),
}

enum : HRESULT
{
    CO_E_FAILEDTOIMPERSONATE     = HRESULT(0x80010123),
    CO_E_FAILEDTOGETSECCTX       = HRESULT(0x80010124),
    CO_E_FAILEDTOOPENTHREADTOKEN = HRESULT(0x80010125),
    CO_E_FAILEDTOGETTOKENINFO    = HRESULT(0x80010126),
}

enum : HRESULT
{
    CO_E_FAILEDTOQUERYCLIENTBLANKET = HRESULT(0x80010128),
    CO_E_FAILEDTOSETDACL            = HRESULT(0x80010129),
}

enum HRESULT CO_E_NETACCESSAPIFAILED = HRESULT(0x8001012b);
enum HRESULT CO_E_INVALIDSID = HRESULT(0x8001012d);
enum HRESULT CO_E_NOMATCHINGSIDFOUND = HRESULT(0x8001012f);
enum HRESULT CO_E_NOMATCHINGNAMEFOUND = HRESULT(0x80010131);
enum HRESULT CO_E_SETSERLHNDLFAILED = HRESULT(0x80010133);
enum HRESULT CO_E_PATHTOOLONG = HRESULT(0x80010135);

enum : HRESULT
{
    CO_E_FAILEDTOCREATEFILE  = HRESULT(0x80010137),
    CO_E_FAILEDTOCLOSEHANDLE = HRESULT(0x80010138),
}

enum HRESULT CO_E_ACESINWRONGORDER = HRESULT(0x8001013a);
enum HRESULT CO_E_FAILEDTOOPENPROCESSTOKEN = HRESULT(0x8001013c);
enum HRESULT CO_E_ACNOTINITIALIZED = HRESULT(0x8001013f);
enum HRESULT CO_E_SERVER_CANNOT_BE_EQUAL_OR_GREATER_PRIVILEGE = HRESULT(0x80010141);
enum HRESULT RPC_E_UNEXPECTED = HRESULT(0x8001ffff);
enum HRESULT ERROR_ALL_SIDS_FILTERED = HRESULT(0xc0090002);

enum : HRESULT
{
    NTE_BAD_UID        = HRESULT(0x80090001),
    NTE_BAD_HASH       = HRESULT(0x80090002),
    NTE_BAD_KEY        = HRESULT(0x80090003),
    NTE_BAD_LEN        = HRESULT(0x80090004),
    NTE_BAD_DATA       = HRESULT(0x80090005),
    NTE_BAD_SIGNATURE  = HRESULT(0x80090006),
    NTE_BAD_VER        = HRESULT(0x80090007),
    NTE_BAD_ALGID      = HRESULT(0x80090008),
    NTE_BAD_FLAGS      = HRESULT(0x80090009),
    NTE_BAD_TYPE       = HRESULT(0x8009000a),
    NTE_BAD_KEY_STATE  = HRESULT(0x8009000b),
    NTE_BAD_HASH_STATE = HRESULT(0x8009000c),
}

enum HRESULT NTE_NO_MEMORY = HRESULT(0x8009000e);

enum : HRESULT
{
    NTE_PERM      = HRESULT(0x80090010),
    NTE_NOT_FOUND = HRESULT(0x80090011),
}

enum : HRESULT
{
    NTE_BAD_PROVIDER   = HRESULT(0x80090013),
    NTE_BAD_PROV_TYPE  = HRESULT(0x80090014),
    NTE_BAD_PUBLIC_KEY = HRESULT(0x80090015),
    NTE_BAD_KEYSET     = HRESULT(0x80090016),
}

enum HRESULT NTE_PROV_TYPE_ENTRY_BAD = HRESULT(0x80090018);
enum HRESULT NTE_KEYSET_ENTRY_BAD = HRESULT(0x8009001a);
enum HRESULT NTE_SIGNATURE_FILE_BAD = HRESULT(0x8009001c);
enum HRESULT NTE_PROV_DLL_NOT_FOUND = HRESULT(0x8009001e);

enum : HRESULT
{
    NTE_FAIL           = HRESULT(0x80090020),
    NTE_SYS_ERR        = HRESULT(0x80090021),
    NTE_SILENT_CONTEXT = HRESULT(0x80090022),
}

enum HRESULT NTE_TEMPORARY_PROFILE = HRESULT(0x80090024);

enum : HRESULT
{
    NTE_INVALID_HANDLE    = HRESULT(0x80090026),
    NTE_INVALID_PARAMETER = HRESULT(0x80090027),
}

enum HRESULT NTE_NOT_SUPPORTED = HRESULT(0x80090029);
enum HRESULT NTE_BUFFERS_OVERLAP = HRESULT(0x8009002b);
enum HRESULT NTE_INTERNAL_ERROR = HRESULT(0x8009002d);
enum HRESULT NTE_HMAC_NOT_SUPPORTED = HRESULT(0x8009002f);
enum HRESULT NTE_AUTHENTICATION_IGNORED = HRESULT(0x80090031);
enum HRESULT NTE_INCORRECT_PASSWORD = HRESULT(0x80090033);
enum HRESULT NTE_DEVICE_NOT_FOUND = HRESULT(0x80090035);
enum HRESULT NTE_PASSWORD_CHANGE_REQUIRED = HRESULT(0x80090037);

enum : HRESULT
{
    NTE_VBS_UNAVAILABLE        = HRESULT(0x80090039),
    NTE_VBS_CANNOT_DECRYPT_KEY = HRESULT(0x8009003a),
}

enum HRESULT SEC_E_INVALID_HANDLE = HRESULT(0x80090301);
enum HRESULT SEC_E_TARGET_UNKNOWN = HRESULT(0x80090303);
enum HRESULT SEC_E_SECPKG_NOT_FOUND = HRESULT(0x80090305);
enum HRESULT SEC_E_CANNOT_INSTALL = HRESULT(0x80090307);
enum HRESULT SEC_E_CANNOT_PACK = HRESULT(0x80090309);
enum HRESULT SEC_E_NO_IMPERSONATION = HRESULT(0x8009030b);
enum HRESULT SEC_E_UNKNOWN_CREDENTIALS = HRESULT(0x8009030d);
enum HRESULT SEC_E_MESSAGE_ALTERED = HRESULT(0x8009030f);
enum HRESULT SEC_E_NO_AUTHENTICATING_AUTHORITY = HRESULT(0x80090311);

enum : HRESULT
{
    SEC_I_COMPLETE_NEEDED       = HRESULT(0x00090313),
    SEC_I_COMPLETE_AND_CONTINUE = HRESULT(0x00090314),
}

enum HRESULT SEC_I_GENERIC_EXTENSION_RECEIVED = HRESULT(0x00090316);
enum HRESULT SEC_E_CONTEXT_EXPIRED = HRESULT(0x80090317);

enum : HRESULT
{
    SEC_E_INCOMPLETE_MESSAGE     = HRESULT(0x80090318),
    SEC_E_INCOMPLETE_CREDENTIALS = HRESULT(0x80090320),
}

enum HRESULT SEC_I_INCOMPLETE_CREDENTIALS = HRESULT(0x00090320);
enum HRESULT SEC_E_WRONG_PRINCIPAL = HRESULT(0x80090322);
enum HRESULT SEC_E_TIME_SKEW = HRESULT(0x80090324);
enum HRESULT SEC_E_ILLEGAL_MESSAGE = HRESULT(0x80090326);
enum HRESULT SEC_E_CERT_EXPIRED = HRESULT(0x80090328);
enum HRESULT SEC_E_DECRYPT_FAILURE = HRESULT(0x80090330);
enum HRESULT SEC_E_SECURITY_QOS_FAILED = HRESULT(0x80090332);

enum : HRESULT
{
    SEC_E_NO_TGT_REPLY    = HRESULT(0x80090334),
    SEC_E_NO_IP_ADDRESSES = HRESULT(0x80090335),
}

enum HRESULT SEC_E_CRYPTO_SYSTEM_INVALID = HRESULT(0x80090337);
enum HRESULT SEC_E_MUST_BE_KDC = HRESULT(0x80090339);
enum HRESULT SEC_E_TOO_MANY_PRINCIPALS = HRESULT(0x8009033b);
enum HRESULT SEC_E_PKINIT_NAME_MISMATCH = HRESULT(0x8009033d);
enum HRESULT SEC_E_SHUTDOWN_IN_PROGRESS = HRESULT(0x8009033f);

enum : HRESULT
{
    SEC_E_KDC_UNABLE_TO_REFER = HRESULT(0x80090341),
    SEC_E_KDC_UNKNOWN_ETYPE   = HRESULT(0x80090342),
}

enum HRESULT SEC_E_DELEGATION_REQUIRED = HRESULT(0x80090345);
enum HRESULT SEC_E_MULTIPLE_ACCOUNTS = HRESULT(0x80090347);
enum HRESULT SEC_E_CERT_WRONG_USAGE = HRESULT(0x80090349);
enum HRESULT SEC_E_SMARTCARD_CERT_REVOKED = HRESULT(0x80090351);
enum HRESULT SEC_E_REVOCATION_OFFLINE_C = HRESULT(0x80090353);
enum HRESULT SEC_E_SMARTCARD_CERT_EXPIRED = HRESULT(0x80090355);
enum HRESULT SEC_E_CROSSREALM_DELEGATION_FAILURE = HRESULT(0x80090357);
enum HRESULT SEC_E_ISSUING_CA_UNTRUSTED_KDC = HRESULT(0x80090359);
enum HRESULT SEC_E_KDC_CERT_REVOKED = HRESULT(0x8009035b);
enum HRESULT SEC_E_INVALID_PARAMETER = HRESULT(0x8009035d);
enum HRESULT SEC_E_POLICY_NLTM_ONLY = HRESULT(0x8009035f);
enum HRESULT SEC_E_NO_CONTEXT = HRESULT(0x80090361);
enum HRESULT SEC_E_MUTUAL_AUTH_FAILED = HRESULT(0x80090363);
enum HRESULT SEC_E_ONLY_HTTPS_ALLOWED = HRESULT(0x80090365);
enum HRESULT SEC_E_APPLICATION_PROTOCOL_MISMATCH = HRESULT(0x80090367);
enum HRESULT SEC_E_INVALID_UPN_NAME = HRESULT(0x80090369);
enum HRESULT SEC_E_INSUFFICIENT_BUFFERS = HRESULT(0x8009036b);

enum : int
{
    SEC_E_NO_SPM        = 0x80090304,
    SEC_E_NOT_SUPPORTED = 0x80090302,
}

enum HRESULT CRYPT_E_UNKNOWN_ALGO = HRESULT(0x80091002);
enum HRESULT CRYPT_E_INVALID_MSG_TYPE = HRESULT(0x80091004);
enum HRESULT CRYPT_E_AUTH_ATTR_MISSING = HRESULT(0x80091006);
enum HRESULT CRYPT_E_INVALID_INDEX = HRESULT(0x80091008);
enum HRESULT CRYPT_E_NOT_DECRYPTED = HRESULT(0x8009100a);
enum HRESULT CRYPT_E_CONTROL_TYPE = HRESULT(0x8009100c);
enum HRESULT CRYPT_E_SIGNER_NOT_FOUND = HRESULT(0x8009100e);

enum : HRESULT
{
    CRYPT_E_STREAM_MSG_NOT_READY     = HRESULT(0x80091010),
    CRYPT_E_STREAM_INSUFFICIENT_DATA = HRESULT(0x80091011),
}

enum : HRESULT
{
    CRYPT_E_BAD_LEN      = HRESULT(0x80092001),
    CRYPT_E_BAD_ENCODE   = HRESULT(0x80092002),
    CRYPT_E_FILE_ERROR   = HRESULT(0x80092003),
    CRYPT_E_NOT_FOUND    = HRESULT(0x80092004),
    CRYPT_E_EXISTS       = HRESULT(0x80092005),
    CRYPT_E_NO_PROVIDER  = HRESULT(0x80092006),
    CRYPT_E_SELF_SIGNED  = HRESULT(0x80092007),
    CRYPT_E_DELETED_PREV = HRESULT(0x80092008),
}

enum HRESULT CRYPT_E_UNEXPECTED_MSG_TYPE = HRESULT(0x8009200a);
enum HRESULT CRYPT_E_NO_DECRYPT_CERT = HRESULT(0x8009200c);

enum : HRESULT
{
    CRYPT_E_NO_SIGNER     = HRESULT(0x8009200e),
    CRYPT_E_PENDING_CLOSE = HRESULT(0x8009200f),
}

enum : HRESULT
{
    CRYPT_E_NO_REVOCATION_DLL   = HRESULT(0x80092011),
    CRYPT_E_NO_REVOCATION_CHECK = HRESULT(0x80092012),
}

enum HRESULT CRYPT_E_NOT_IN_REVOCATION_DATABASE = HRESULT(0x80092014);

enum : HRESULT
{
    CRYPT_E_INVALID_PRINTABLE_STRING = HRESULT(0x80092021),
    CRYPT_E_INVALID_IA5_STRING       = HRESULT(0x80092022),
    CRYPT_E_INVALID_X500_STRING      = HRESULT(0x80092023),
}

enum : HRESULT
{
    CRYPT_E_FILERESIZED       = HRESULT(0x80092025),
    CRYPT_E_SECURITY_SETTINGS = HRESULT(0x80092026),
}

enum HRESULT CRYPT_E_NO_VERIFY_USAGE_CHECK = HRESULT(0x80092028);

enum : HRESULT
{
    CRYPT_E_NOT_IN_CTL        = HRESULT(0x8009202a),
    CRYPT_E_NO_TRUSTED_SIGNER = HRESULT(0x8009202b),
}

enum HRESULT CRYPT_E_OBJECT_LOCATOR_OBJECT_NOT_FOUND = HRESULT(0x8009202d);
enum HRESULT OSS_MORE_BUF = HRESULT(0x80093001);
enum HRESULT OSS_PDU_RANGE = HRESULT(0x80093003);
enum HRESULT OSS_DATA_ERROR = HRESULT(0x80093005);
enum HRESULT OSS_BAD_VERSION = HRESULT(0x80093007);
enum HRESULT OSS_PDU_MISMATCH = HRESULT(0x80093009);

enum : HRESULT
{
    OSS_BAD_PTR  = HRESULT(0x8009300b),
    OSS_BAD_TIME = HRESULT(0x8009300c),
}

enum HRESULT OSS_MEM_ERROR = HRESULT(0x8009300e);
enum HRESULT OSS_TOO_LONG = HRESULT(0x80093010);
enum HRESULT OSS_FATAL_ERROR = HRESULT(0x80093012);

enum : HRESULT
{
    OSS_NULL_TBL = HRESULT(0x80093014),
    OSS_NULL_FCN = HRESULT(0x80093015),
}

enum HRESULT OSS_UNAVAIL_ENCRULES = HRESULT(0x80093017);
enum HRESULT OSS_UNIMPLEMENTED = HRESULT(0x80093019);
enum HRESULT OSS_CANT_OPEN_TRACE_FILE = HRESULT(0x8009301b);
enum HRESULT OSS_TABLE_MISMATCH = HRESULT(0x8009301d);
enum HRESULT OSS_REAL_DLL_NOT_LINKED = HRESULT(0x8009301f);
enum HRESULT OSS_OUT_OF_RANGE = HRESULT(0x80093021);
enum HRESULT OSS_CONSTRAINT_DLL_NOT_LINKED = HRESULT(0x80093023);
enum HRESULT OSS_COMPARATOR_CODE_NOT_LINKED = HRESULT(0x80093025);
enum HRESULT OSS_PDV_DLL_NOT_LINKED = HRESULT(0x80093027);
enum HRESULT OSS_API_DLL_NOT_LINKED = HRESULT(0x80093029);
enum HRESULT OSS_PER_DLL_NOT_LINKED = HRESULT(0x8009302b);
enum HRESULT OSS_MUTEX_NOT_CREATED = HRESULT(0x8009302d);

enum : HRESULT
{
    CRYPT_E_ASN1_ERROR      = HRESULT(0x80093100),
    CRYPT_E_ASN1_INTERNAL   = HRESULT(0x80093101),
    CRYPT_E_ASN1_EOD        = HRESULT(0x80093102),
    CRYPT_E_ASN1_CORRUPT    = HRESULT(0x80093103),
    CRYPT_E_ASN1_LARGE      = HRESULT(0x80093104),
    CRYPT_E_ASN1_CONSTRAINT = HRESULT(0x80093105),
    CRYPT_E_ASN1_MEMORY     = HRESULT(0x80093106),
    CRYPT_E_ASN1_OVERFLOW   = HRESULT(0x80093107),
    CRYPT_E_ASN1_BADPDU     = HRESULT(0x80093108),
    CRYPT_E_ASN1_BADARGS    = HRESULT(0x80093109),
    CRYPT_E_ASN1_BADREAL    = HRESULT(0x8009310a),
    CRYPT_E_ASN1_BADTAG     = HRESULT(0x8009310b),
    CRYPT_E_ASN1_CHOICE     = HRESULT(0x8009310c),
    CRYPT_E_ASN1_RULE       = HRESULT(0x8009310d),
    CRYPT_E_ASN1_UTF8       = HRESULT(0x8009310e),
    CRYPT_E_ASN1_PDU_TYPE   = HRESULT(0x80093133),
    CRYPT_E_ASN1_NYI        = HRESULT(0x80093134),
    CRYPT_E_ASN1_EXTENDED   = HRESULT(0x80093201),
    CRYPT_E_ASN1_NOEOD      = HRESULT(0x80093202),
}

enum : HRESULT
{
    CERTSRV_E_NO_REQUEST        = HRESULT(0x80094002),
    CERTSRV_E_BAD_REQUESTSTATUS = HRESULT(0x80094003),
}

enum HRESULT CERTSRV_E_INVALID_CA_CERTIFICATE = HRESULT(0x80094005);
enum HRESULT CERTSRV_E_ENCODING_LENGTH = HRESULT(0x80094007);
enum HRESULT CERTSRV_E_RESTRICTEDOFFICER = HRESULT(0x80094009);

enum : HRESULT
{
    CERTSRV_E_NO_VALID_KRA             = HRESULT(0x8009400b),
    CERTSRV_E_BAD_REQUEST_KEY_ARCHIVAL = HRESULT(0x8009400c),
}

enum HRESULT CERTSRV_E_BAD_RENEWAL_CERT_ATTRIBUTE = HRESULT(0x8009400e);
enum HRESULT CERTSRV_E_ALIGNMENT_FAULT = HRESULT(0x80094010);
enum HRESULT CERTSRV_E_TEMPLATE_DENIED = HRESULT(0x80094012);
enum HRESULT CERTSRV_E_ADMIN_DENIED_REQUEST = HRESULT(0x80094014);
enum HRESULT CERTSRV_E_WEAK_SIGNATURE_OR_KEY = HRESULT(0x80094016);
enum HRESULT CERTSRV_E_ENCRYPTION_CERT_REQUIRED = HRESULT(0x80094018);

enum : HRESULT
{
    CERTSRV_E_NO_CERT_TYPE      = HRESULT(0x80094801),
    CERTSRV_E_TEMPLATE_CONFLICT = HRESULT(0x80094802),
}

enum HRESULT CERTSRV_E_ARCHIVED_KEY_REQUIRED = HRESULT(0x80094804);

enum : HRESULT
{
    CERTSRV_E_BAD_RENEWAL_SUBJECT  = HRESULT(0x80094806),
    CERTSRV_E_BAD_TEMPLATE_VERSION = HRESULT(0x80094807),
}

enum : HRESULT
{
    CERTSRV_E_SIGNATURE_POLICY_REQUIRED = HRESULT(0x80094809),
    CERTSRV_E_SIGNATURE_COUNT           = HRESULT(0x8009480a),
    CERTSRV_E_SIGNATURE_REJECTED        = HRESULT(0x8009480b),
}

enum : HRESULT
{
    CERTSRV_E_SUBJECT_UPN_REQUIRED            = HRESULT(0x8009480d),
    CERTSRV_E_SUBJECT_DIRECTORY_GUID_REQUIRED = HRESULT(0x8009480e),
    CERTSRV_E_SUBJECT_DNS_REQUIRED            = HRESULT(0x8009480f),
}

enum : HRESULT
{
    CERTSRV_E_KEY_LENGTH             = HRESULT(0x80094811),
    CERTSRV_E_SUBJECT_EMAIL_REQUIRED = HRESULT(0x80094812),
}

enum HRESULT CERTSRV_E_CERT_TYPE_OVERLAP = HRESULT(0x80094814);
enum HRESULT CERTSRV_E_RENEWAL_BAD_PUBLIC_KEY = HRESULT(0x80094816);

enum : HRESULT
{
    CERTSRV_E_INVALID_IDBINDING   = HRESULT(0x80094818),
    CERTSRV_E_INVALID_ATTESTATION = HRESULT(0x80094819),
}

enum HRESULT CERTSRV_E_CORRUPT_KEY_ATTESTATION = HRESULT(0x8009481b);

enum : HRESULT
{
    CERTSRV_E_INVALID_RESPONSE  = HRESULT(0x8009481d),
    CERTSRV_E_INVALID_REQUESTID = HRESULT(0x8009481e),
}

enum HRESULT CERTSRV_E_PENDING_CLIENT_RESPONSE = HRESULT(0x80094820);
enum HRESULT XENROLL_E_KEY_NOT_EXPORTABLE = HRESULT(0x80095000);

enum : HRESULT
{
    XENROLL_E_RESPONSE_KA_HASH_NOT_FOUND  = HRESULT(0x80095002),
    XENROLL_E_RESPONSE_UNEXPECTED_KA_HASH = HRESULT(0x80095003),
    XENROLL_E_RESPONSE_KA_HASH_MISMATCH   = HRESULT(0x80095004),
}

enum HRESULT TRUST_E_SYSTEM_ERROR = HRESULT(0x80096001);

enum : HRESULT
{
    TRUST_E_COUNTER_SIGNER = HRESULT(0x80096003),
    TRUST_E_CERT_SIGNATURE = HRESULT(0x80096004),
}

enum : HRESULT
{
    TRUST_E_BAD_DIGEST          = HRESULT(0x80096010),
    TRUST_E_MALFORMED_SIGNATURE = HRESULT(0x80096011),
}

enum HRESULT TRUST_E_FINANCIAL_CRITERIA = HRESULT(0x8009601e);

enum : HRESULT
{
    MSSIPOTF_E_CANTGETOBJECT             = HRESULT(0x80097002),
    MSSIPOTF_E_NOHEADTABLE               = HRESULT(0x80097003),
    MSSIPOTF_E_BAD_MAGICNUMBER           = HRESULT(0x80097004),
    MSSIPOTF_E_BAD_OFFSET_TABLE          = HRESULT(0x80097005),
    MSSIPOTF_E_TABLE_TAGORDER            = HRESULT(0x80097006),
    MSSIPOTF_E_TABLE_LONGWORD            = HRESULT(0x80097007),
    MSSIPOTF_E_BAD_FIRST_TABLE_PLACEMENT = HRESULT(0x80097008),
}

enum : HRESULT
{
    MSSIPOTF_E_TABLE_PADBYTES     = HRESULT(0x8009700a),
    MSSIPOTF_E_FILETOOSMALL       = HRESULT(0x8009700b),
    MSSIPOTF_E_TABLE_CHECKSUM     = HRESULT(0x8009700c),
    MSSIPOTF_E_FILE_CHECKSUM      = HRESULT(0x8009700d),
    MSSIPOTF_E_FAILED_POLICY      = HRESULT(0x80097010),
    MSSIPOTF_E_FAILED_HINTS_CHECK = HRESULT(0x80097011),
}

enum : HRESULT
{
    MSSIPOTF_E_FILE           = HRESULT(0x80097013),
    MSSIPOTF_E_CRYPT          = HRESULT(0x80097014),
    MSSIPOTF_E_BADVERSION     = HRESULT(0x80097015),
    MSSIPOTF_E_DSIG_STRUCTURE = HRESULT(0x80097016),
    MSSIPOTF_E_PCONST_CHECK   = HRESULT(0x80097017),
    MSSIPOTF_E_STRUCTURE      = HRESULT(0x80097018),
}

enum uint NTE_OP_OK = 0x00000000;
enum HRESULT TRUST_E_ACTION_UNKNOWN = HRESULT(0x800b0002);
enum HRESULT TRUST_E_SUBJECT_NOT_TRUSTED = HRESULT(0x800b0004);

enum : HRESULT
{
    DIGSIG_E_DECODE        = HRESULT(0x800b0006),
    DIGSIG_E_EXTENSIBILITY = HRESULT(0x800b0007),
    DIGSIG_E_CRYPTO        = HRESULT(0x800b0008),
}

enum : HRESULT
{
    PERSIST_E_SIZEINDEFINITE = HRESULT(0x800b000a),
    PERSIST_E_NOTSELFSIZING  = HRESULT(0x800b000b),
}

enum : HRESULT
{
    CERT_E_EXPIRED               = HRESULT(0x800b0101),
    CERT_E_VALIDITYPERIODNESTING = HRESULT(0x800b0102),
}

enum HRESULT CERT_E_PATHLENCONST = HRESULT(0x800b0104);

enum : HRESULT
{
    CERT_E_PURPOSE        = HRESULT(0x800b0106),
    CERT_E_ISSUERCHAINING = HRESULT(0x800b0107),
}

enum HRESULT CERT_E_UNTRUSTEDROOT = HRESULT(0x800b0109);
enum HRESULT TRUST_E_FAIL = HRESULT(0x800b010b);
enum HRESULT CERT_E_UNTRUSTEDTESTROOT = HRESULT(0x800b010d);
enum HRESULT CERT_E_CN_NO_MATCH = HRESULT(0x800b010f);
enum HRESULT TRUST_E_EXPLICIT_DISTRUST = HRESULT(0x800b0111);

enum : HRESULT
{
    CERT_E_INVALID_POLICY = HRESULT(0x800b0113),
    CERT_E_INVALID_NAME   = HRESULT(0x800b0114),
}

enum HRESULT SPAPI_E_BAD_SECTION_NAME_LINE = HRESULT(0x800f0001);
enum HRESULT SPAPI_E_GENERAL_SYNTAX = HRESULT(0x800f0003);
enum HRESULT SPAPI_E_SECTION_NOT_FOUND = HRESULT(0x800f0101);

enum : HRESULT
{
    SPAPI_E_NO_BACKUP           = HRESULT(0x800f0103),
    SPAPI_E_NO_ASSOCIATED_CLASS = HRESULT(0x800f0200),
}

enum HRESULT SPAPI_E_DUPLICATE_FOUND = HRESULT(0x800f0202);
enum HRESULT SPAPI_E_KEY_DOES_NOT_EXIST = HRESULT(0x800f0204);
enum HRESULT SPAPI_E_INVALID_CLASS = HRESULT(0x800f0206);
enum HRESULT SPAPI_E_DEVINFO_NOT_REGISTERED = HRESULT(0x800f0208);

enum : HRESULT
{
    SPAPI_E_NO_INF          = HRESULT(0x800f020a),
    SPAPI_E_NO_SUCH_DEVINST = HRESULT(0x800f020b),
}

enum HRESULT SPAPI_E_INVALID_CLASS_INSTALLER = HRESULT(0x800f020d);
enum HRESULT SPAPI_E_DI_NOFILECOPY = HRESULT(0x800f020f);
enum HRESULT SPAPI_E_NO_DEVICE_SELECTED = HRESULT(0x800f0211);
enum HRESULT SPAPI_E_DEVINFO_DATA_LOCKED = HRESULT(0x800f0213);
enum HRESULT SPAPI_E_NO_CLASSINSTALL_PARAMS = HRESULT(0x800f0215);
enum HRESULT SPAPI_E_BAD_SERVICE_INSTALLSECT = HRESULT(0x800f0217);
enum HRESULT SPAPI_E_NO_ASSOCIATED_SERVICE = HRESULT(0x800f0219);

enum : HRESULT
{
    SPAPI_E_DEVICE_INTERFACE_ACTIVE  = HRESULT(0x800f021b),
    SPAPI_E_DEVICE_INTERFACE_REMOVED = HRESULT(0x800f021c),
}

enum HRESULT SPAPI_E_NO_SUCH_INTERFACE_CLASS = HRESULT(0x800f021e);
enum HRESULT SPAPI_E_INVALID_MACHINENAME = HRESULT(0x800f0220);
enum HRESULT SPAPI_E_MACHINE_UNAVAILABLE = HRESULT(0x800f0222);
enum HRESULT SPAPI_E_INVALID_PROPPAGE_PROVIDER = HRESULT(0x800f0224);
enum HRESULT SPAPI_E_DI_POSTPROCESSING_REQUIRED = HRESULT(0x800f0226);

enum : HRESULT
{
    SPAPI_E_NO_COMPAT_DRIVERS = HRESULT(0x800f0228),
    SPAPI_E_NO_DEVICE_ICON    = HRESULT(0x800f0229),
}

enum HRESULT SPAPI_E_DI_DONT_INSTALL = HRESULT(0x800f022b);

enum : HRESULT
{
    SPAPI_E_NON_WINDOWS_NT_DRIVER = HRESULT(0x800f022d),
    SPAPI_E_NON_WINDOWS_DRIVER    = HRESULT(0x800f022e),
}

enum HRESULT SPAPI_E_DEVINSTALL_QUEUE_NONNATIVE = HRESULT(0x800f0230);
enum HRESULT SPAPI_E_CANT_REMOVE_DEVINST = HRESULT(0x800f0232);
enum HRESULT SPAPI_E_DRIVER_NONNATIVE = HRESULT(0x800f0234);
enum HRESULT SPAPI_E_SET_SYSTEM_RESTORE_POINT = HRESULT(0x800f0236);
enum HRESULT SPAPI_E_SCE_DISABLED = HRESULT(0x800f0238);
enum HRESULT SPAPI_E_PNP_REGISTRY_ERROR = HRESULT(0x800f023a);
enum HRESULT SPAPI_E_NOT_AN_INSTALLED_OEM_INF = HRESULT(0x800f023c);
enum HRESULT SPAPI_E_DI_FUNCTION_OBSOLETE = HRESULT(0x800f023e);

enum : HRESULT
{
    SPAPI_E_AUTHENTICODE_DISALLOWED            = HRESULT(0x800f0240),
    SPAPI_E_AUTHENTICODE_TRUSTED_PUBLISHER     = HRESULT(0x800f0241),
    SPAPI_E_AUTHENTICODE_TRUST_NOT_ESTABLISHED = HRESULT(0x800f0242),
    SPAPI_E_AUTHENTICODE_PUBLISHER_NOT_TRUSTED = HRESULT(0x800f0243),
}

enum HRESULT SPAPI_E_ONLY_VALIDATE_VIA_AUTHENTICODE = HRESULT(0x800f0245);
enum HRESULT SPAPI_E_DRIVER_STORE_ADD_FAILED = HRESULT(0x800f0247);
enum HRESULT SPAPI_E_DRIVER_INSTALL_BLOCKED = HRESULT(0x800f0249);
enum HRESULT SPAPI_E_FILE_HASH_NOT_IN_CATALOG = HRESULT(0x800f024b);
enum HRESULT SPAPI_E_UNRECOVERABLE_STACK_OVERFLOW = HRESULT(0x800f0300);
enum HRESULT SCARD_F_INTERNAL_ERROR = HRESULT(0x80100001);

enum : HRESULT
{
    SCARD_E_INVALID_HANDLE    = HRESULT(0x80100003),
    SCARD_E_INVALID_PARAMETER = HRESULT(0x80100004),
    SCARD_E_INVALID_TARGET    = HRESULT(0x80100005),
}

enum HRESULT SCARD_F_WAITED_TOO_LONG = HRESULT(0x80100007);
enum HRESULT SCARD_E_UNKNOWN_READER = HRESULT(0x80100009);
enum HRESULT SCARD_E_SHARING_VIOLATION = HRESULT(0x8010000b);
enum HRESULT SCARD_E_UNKNOWN_CARD = HRESULT(0x8010000d);
enum HRESULT SCARD_E_PROTO_MISMATCH = HRESULT(0x8010000f);
enum HRESULT SCARD_E_INVALID_VALUE = HRESULT(0x80100011);

enum : HRESULT
{
    SCARD_F_COMM_ERROR    = HRESULT(0x80100013),
    SCARD_F_UNKNOWN_ERROR = HRESULT(0x80100014),
}

enum HRESULT SCARD_E_NOT_TRANSACTED = HRESULT(0x80100016);
enum HRESULT SCARD_P_SHUTDOWN = HRESULT(0x80100018);
enum HRESULT SCARD_E_READER_UNSUPPORTED = HRESULT(0x8010001a);
enum HRESULT SCARD_E_CARD_UNSUPPORTED = HRESULT(0x8010001c);
enum HRESULT SCARD_E_SERVICE_STOPPED = HRESULT(0x8010001e);

enum : HRESULT
{
    SCARD_E_ICC_INSTALLATION = HRESULT(0x80100020),
    SCARD_E_ICC_CREATEORDER  = HRESULT(0x80100021),
}

enum HRESULT SCARD_E_DIR_NOT_FOUND = HRESULT(0x80100023);

enum : HRESULT
{
    SCARD_E_NO_DIR         = HRESULT(0x80100025),
    SCARD_E_NO_FILE        = HRESULT(0x80100026),
    SCARD_E_NO_ACCESS      = HRESULT(0x80100027),
    SCARD_E_WRITE_TOO_MANY = HRESULT(0x80100028),
}

enum : HRESULT
{
    SCARD_E_INVALID_CHV     = HRESULT(0x8010002a),
    SCARD_E_UNKNOWN_RES_MNG = HRESULT(0x8010002b),
}

enum HRESULT SCARD_E_CERTIFICATE_UNAVAILABLE = HRESULT(0x8010002d);
enum HRESULT SCARD_E_COMM_DATA_LOST = HRESULT(0x8010002f);
enum HRESULT SCARD_E_SERVER_TOO_BUSY = HRESULT(0x80100031);
enum HRESULT SCARD_E_NO_PIN_CACHE = HRESULT(0x80100033);

enum : HRESULT
{
    SCARD_W_UNSUPPORTED_CARD  = HRESULT(0x80100065),
    SCARD_W_UNRESPONSIVE_CARD = HRESULT(0x80100066),
}

enum : HRESULT
{
    SCARD_W_RESET_CARD   = HRESULT(0x80100068),
    SCARD_W_REMOVED_CARD = HRESULT(0x80100069),
}

enum : HRESULT
{
    SCARD_W_WRONG_CHV         = HRESULT(0x8010006b),
    SCARD_W_CHV_BLOCKED       = HRESULT(0x8010006c),
    SCARD_W_EOF               = HRESULT(0x8010006d),
    SCARD_W_CANCELLED_BY_USER = HRESULT(0x8010006e),
}

enum : HRESULT
{
    SCARD_W_CACHE_ITEM_NOT_FOUND = HRESULT(0x80100070),
    SCARD_W_CACHE_ITEM_STALE     = HRESULT(0x80100071),
    SCARD_W_CACHE_ITEM_TOO_BIG   = HRESULT(0x80100072),
}

enum : HRESULT
{
    COMADMIN_E_OBJECTINVALID      = HRESULT(0x80110402),
    COMADMIN_E_KEYMISSING         = HRESULT(0x80110403),
    COMADMIN_E_ALREADYINSTALLED   = HRESULT(0x80110404),
    COMADMIN_E_APP_FILE_WRITEFAIL = HRESULT(0x80110407),
    COMADMIN_E_APP_FILE_READFAIL  = HRESULT(0x80110408),
    COMADMIN_E_APP_FILE_VERSION   = HRESULT(0x80110409),
    COMADMIN_E_BADPATH            = HRESULT(0x8011040a),
    COMADMIN_E_APPLICATIONEXISTS  = HRESULT(0x8011040b),
}

enum : HRESULT
{
    COMADMIN_E_CANTCOPYFILE      = HRESULT(0x8011040d),
    COMADMIN_E_NOUSER            = HRESULT(0x8011040f),
    COMADMIN_E_INVALIDUSERIDS    = HRESULT(0x80110410),
    COMADMIN_E_NOREGISTRYCLSID   = HRESULT(0x80110411),
    COMADMIN_E_BADREGISTRYPROGID = HRESULT(0x80110412),
}

enum HRESULT COMADMIN_E_USERPASSWDNOTVALID = HRESULT(0x80110414);

enum : HRESULT
{
    COMADMIN_E_REMOTEINTERFACE   = HRESULT(0x80110419),
    COMADMIN_E_DLLREGISTERSERVER = HRESULT(0x8011041a),
}

enum : HRESULT
{
    COMADMIN_E_DLLLOADFAILED           = HRESULT(0x8011041d),
    COMADMIN_E_BADREGISTRYLIBID        = HRESULT(0x8011041e),
    COMADMIN_E_APPDIRNOTFOUND          = HRESULT(0x8011041f),
    COMADMIN_E_REGISTRARFAILED         = HRESULT(0x80110423),
    COMADMIN_E_COMPFILE_DOESNOTEXIST   = HRESULT(0x80110424),
    COMADMIN_E_COMPFILE_LOADDLLFAIL    = HRESULT(0x80110425),
    COMADMIN_E_COMPFILE_GETCLASSOBJ    = HRESULT(0x80110426),
    COMADMIN_E_COMPFILE_CLASSNOTAVAIL  = HRESULT(0x80110427),
    COMADMIN_E_COMPFILE_BADTLB         = HRESULT(0x80110428),
    COMADMIN_E_COMPFILE_NOTINSTALLABLE = HRESULT(0x80110429),
}

enum : HRESULT
{
    COMADMIN_E_NOTDELETEABLE      = HRESULT(0x8011042b),
    COMADMIN_E_SESSION            = HRESULT(0x8011042c),
    COMADMIN_E_COMP_MOVE_LOCKED   = HRESULT(0x8011042d),
    COMADMIN_E_COMP_MOVE_BAD_DEST = HRESULT(0x8011042e),
}

enum : HRESULT
{
    COMADMIN_E_SYSTEMAPP            = HRESULT(0x80110433),
    COMADMIN_E_COMPFILE_NOREGISTRAR = HRESULT(0x80110434),
    COMADMIN_E_COREQCOMPINSTALLED   = HRESULT(0x80110435),
}

enum HRESULT COMADMIN_E_PROPERTYSAVEFAILED = HRESULT(0x80110437);

enum : HRESULT
{
    COMADMIN_E_COMPONENTEXISTS   = HRESULT(0x80110439),
    COMADMIN_E_REGFILE_CORRUPT   = HRESULT(0x8011043b),
    COMADMIN_E_PROPERTY_OVERFLOW = HRESULT(0x8011043c),
}

enum HRESULT COMADMIN_E_OBJECTNOTPOOLABLE = HRESULT(0x8011043f);
enum HRESULT COMADMIN_E_ROLE_DOES_NOT_EXIST = HRESULT(0x80110447);
enum HRESULT COMADMIN_E_REQUIRES_DIFFERENT_PLATFORM = HRESULT(0x80110449);

enum : HRESULT
{
    COMADMIN_E_CAN_NOT_START_APP           = HRESULT(0x8011044b),
    COMADMIN_E_CAN_NOT_EXPORT_SYS_APP      = HRESULT(0x8011044c),
    COMADMIN_E_CANT_SUBSCRIBE_TO_COMPONENT = HRESULT(0x8011044d),
}

enum HRESULT COMADMIN_E_LIB_APP_PROXY_INCOMPATIBLE = HRESULT(0x8011044f);
enum HRESULT COMADMIN_E_START_APP_DISABLED = HRESULT(0x80110451);

enum : HRESULT
{
    COMADMIN_E_CAT_INVALID_PARTITION_NAME = HRESULT(0x80110458),
    COMADMIN_E_CAT_PARTITION_IN_USE       = HRESULT(0x80110459),
}

enum HRESULT COMADMIN_E_CAT_IMPORTED_COMPONENTS_NOT_ALLOWED = HRESULT(0x8011045b);
enum HRESULT COMADMIN_E_AMBIGUOUS_PARTITION_NAME = HRESULT(0x8011045d);

enum : HRESULT
{
    COMADMIN_E_REGDB_NOTOPEN        = HRESULT(0x80110473),
    COMADMIN_E_REGDB_SYSTEMERR      = HRESULT(0x80110474),
    COMADMIN_E_REGDB_ALREADYRUNNING = HRESULT(0x80110475),
}

enum HRESULT COMADMIN_E_MIG_SCHEMANOTFOUND = HRESULT(0x80110481);

enum : HRESULT
{
    COMADMIN_E_CAT_UNACCEPTABLEBITNESS        = HRESULT(0x80110483),
    COMADMIN_E_CAT_WRONGAPPBITNESS            = HRESULT(0x80110484),
    COMADMIN_E_CAT_PAUSE_RESUME_NOT_SUPPORTED = HRESULT(0x80110485),
}

enum HRESULT COMQC_E_APPLICATION_NOT_QUEUED = HRESULT(0x80110600);
enum HRESULT COMQC_E_QUEUING_SERVICE_NOT_AVAILABLE = HRESULT(0x80110602);

enum : HRESULT
{
    COMQC_E_BAD_MESSAGE        = HRESULT(0x80110604),
    COMQC_E_UNAUTHENTICATED    = HRESULT(0x80110605),
    COMQC_E_UNTRUSTED_ENQUEUER = HRESULT(0x80110606),
}

enum : HRESULT
{
    COMADMIN_E_OBJECT_PARENT_MISSING = HRESULT(0x80110808),
    COMADMIN_E_OBJECT_DOES_NOT_EXIST = HRESULT(0x80110809),
}

enum HRESULT COMADMIN_E_INVALID_PARTITION = HRESULT(0x8011080b);

enum : HRESULT
{
    COMADMIN_E_USER_IN_SET            = HRESULT(0x8011080e),
    COMADMIN_E_CANTRECYCLELIBRARYAPPS = HRESULT(0x8011080f),
    COMADMIN_E_CANTRECYCLESERVICEAPPS = HRESULT(0x80110811),
}

enum HRESULT COMADMIN_E_PAUSEDPROCESSMAYNOTBERECYCLED = HRESULT(0x80110813);
enum HRESULT COMADMIN_E_PROGIDINUSEBYCLSID = HRESULT(0x80110815);
enum HRESULT COMADMIN_E_RECYCLEDPROCESSMAYNOTBEPAUSED = HRESULT(0x80110817);
enum HRESULT COMADMIN_E_PARTITION_MSI_ONLY = HRESULT(0x80110819);
enum HRESULT COMADMIN_E_LEGACYCOMPS_NOT_ALLOWED_IN_NONBASE_PARTITIONS = HRESULT(0x8011081b);

enum : HRESULT
{
    COMADMIN_E_COMP_MOVE_DEST    = HRESULT(0x8011081d),
    COMADMIN_E_COMP_MOVE_PRIVATE = HRESULT(0x8011081e),
}

enum HRESULT COMADMIN_E_CANNOT_ALIAS_EVENTCLASS = HRESULT(0x80110820);

enum : HRESULT
{
    COMADMIN_E_SAFERINVALID          = HRESULT(0x80110822),
    COMADMIN_E_REGISTRY_ACCESSDENIED = HRESULT(0x80110823),
}

enum HRESULT MENROLL_S_ENROLLMENT_SUSPENDED = HRESULT(0x00180011);

enum : HRESULT
{
    WER_S_REPORT_UPLOADED = HRESULT(0x001b0001),
    WER_S_REPORT_QUEUED   = HRESULT(0x001b0002),
}

enum HRESULT WER_S_SUSPENDED_UPLOAD = HRESULT(0x001b0004);
enum HRESULT WER_S_DISABLED_ARCHIVE = HRESULT(0x001b0006);

enum : HRESULT
{
    WER_S_IGNORE_ASSERT_INSTANCE = HRESULT(0x001b0008),
    WER_S_IGNORE_ALL_ASSERTS     = HRESULT(0x001b0009),
}

enum HRESULT WER_S_THROTTLED = HRESULT(0x001b000b);
enum HRESULT WER_E_CRASH_FAILURE = HRESULT(0x801b8000);
enum HRESULT WER_E_NETWORK_FAILURE = HRESULT(0x801b8002);
enum HRESULT WER_E_ALREADY_REPORTING = HRESULT(0x801b8004);
enum HRESULT WER_E_INSUFFICIENT_CONSENT = HRESULT(0x801b8006);

enum : HRESULT
{
    ERROR_FLT_IO_COMPLETE        = HRESULT(0x001f0001),
    ERROR_FLT_NO_HANDLER_DEFINED = HRESULT(0x801f0001),
}

enum HRESULT ERROR_FLT_INVALID_ASYNCHRONOUS_REQUEST = HRESULT(0x801f0003);
enum HRESULT ERROR_FLT_INVALID_NAME_REQUEST = HRESULT(0x801f0005);
enum HRESULT ERROR_FLT_NOT_INITIALIZED = HRESULT(0x801f0007);
enum HRESULT ERROR_FLT_POST_OPERATION_CLEANUP = HRESULT(0x801f0009);
enum HRESULT ERROR_FLT_DELETING_OBJECT = HRESULT(0x801f000b);
enum HRESULT ERROR_FLT_DUPLICATE_ENTRY = HRESULT(0x801f000d);

enum : HRESULT
{
    ERROR_FLT_DO_NOT_ATTACH               = HRESULT(0x801f000f),
    ERROR_FLT_DO_NOT_DETACH               = HRESULT(0x801f0010),
    ERROR_FLT_INSTANCE_ALTITUDE_COLLISION = HRESULT(0x801f0011),
    ERROR_FLT_INSTANCE_NAME_COLLISION     = HRESULT(0x801f0012),
}

enum HRESULT ERROR_FLT_VOLUME_NOT_FOUND = HRESULT(0x801f0014);
enum HRESULT ERROR_FLT_CONTEXT_ALLOCATION_NOT_FOUND = HRESULT(0x801f0016);

enum : HRESULT
{
    ERROR_FLT_NAME_CACHE_MISS  = HRESULT(0x801f0018),
    ERROR_FLT_NO_DEVICE_OBJECT = HRESULT(0x801f0019),
}

enum HRESULT ERROR_FLT_ALREADY_ENLISTED = HRESULT(0x801f001b);
enum HRESULT ERROR_FLT_NO_WAITER_FOR_REPLY = HRESULT(0x801f0020);
enum HRESULT ERROR_FLT_WCOS_NOT_SUPPORTED = HRESULT(0x801f0024);
enum HRESULT DWM_E_COMPOSITIONDISABLED = HRESULT(0x80263001);
enum HRESULT DWM_E_NO_REDIRECTION_SURFACE_AVAILABLE = HRESULT(0x80263003);
enum HRESULT DWM_E_ADAPTER_NOT_FOUND = HRESULT(0x80263005);
enum HRESULT DWM_E_TEXTURE_TOO_LARGE = HRESULT(0x80263007);

enum : HRESULT
{
    ERROR_MONITOR_NO_DESCRIPTOR             = HRESULT(0x00261001),
    ERROR_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT = HRESULT(0x00261002),
}

enum HRESULT ERROR_MONITOR_INVALID_STANDARD_TIMING_BLOCK = HRESULT(0xc0261004);

enum : HRESULT
{
    ERROR_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK = HRESULT(0xc0261006),
    ERROR_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK = HRESULT(0xc0261007),
}

enum : HRESULT
{
    ERROR_MONITOR_INVALID_DETAILED_TIMING_BLOCK = HRESULT(0xc0261009),
    ERROR_MONITOR_INVALID_MANUFACTURE_DATE      = HRESULT(0xc026100a),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INSUFFICIENT_DMA_BUFFER = HRESULT(0xc0262001),
    ERROR_GRAPHICS_INVALID_DISPLAY_ADAPTER = HRESULT(0xc0262002),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_DRIVER_MODEL         = HRESULT(0xc0262004),
    ERROR_GRAPHICS_PRESENT_MODE_CHANGED         = HRESULT(0xc0262005),
    ERROR_GRAPHICS_PRESENT_OCCLUDED             = HRESULT(0xc0262006),
    ERROR_GRAPHICS_PRESENT_DENIED               = HRESULT(0xc0262007),
    ERROR_GRAPHICS_CANNOTCOLORCONVERT           = HRESULT(0xc0262008),
    ERROR_GRAPHICS_DRIVER_MISMATCH              = HRESULT(0xc0262009),
    ERROR_GRAPHICS_PARTIAL_DATA_POPULATED       = HRESULT(0x4026200a),
    ERROR_GRAPHICS_PRESENT_REDIRECTION_DISABLED = HRESULT(0xc026200b),
    ERROR_GRAPHICS_PRESENT_UNOCCLUDED           = HRESULT(0xc026200c),
    ERROR_GRAPHICS_WINDOWDC_NOT_AVAILABLE       = HRESULT(0xc026200d),
    ERROR_GRAPHICS_WINDOWLESS_PRESENT_DISABLED  = HRESULT(0xc026200e),
}

enum HRESULT ERROR_GRAPHICS_PRESENT_BUFFER_NOT_BOUND = HRESULT(0xc0262010);

enum : HRESULT
{
    ERROR_GRAPHICS_INDIRECT_DISPLAY_ABANDON_SWAPCHAIN = HRESULT(0xc0262012),
    ERROR_GRAPHICS_INDIRECT_DISPLAY_DEVICE_STOPPED    = HRESULT(0xc0262013),
}

enum : HRESULT
{
    ERROR_GRAPHICS_VAIL_FAILED_TO_SEND_DESTROY_SUPERWETINK_MESSAGE    = HRESULT(0xc0262015),
    ERROR_GRAPHICS_VAIL_FAILED_TO_SEND_COMPOSITION_WINDOW_DPI_MESSAGE = HRESULT(0xc0262016),
}

enum HRESULT ERROR_GRAPHICS_MPO_ALLOCATION_UNPINNED = HRESULT(0xc0262018);

enum : HRESULT
{
    ERROR_GRAPHICS_NO_VIDEO_MEMORY                  = HRESULT(0xc0262100),
    ERROR_GRAPHICS_CANT_LOCK_MEMORY                 = HRESULT(0xc0262101),
    ERROR_GRAPHICS_ALLOCATION_BUSY                  = HRESULT(0xc0262102),
    ERROR_GRAPHICS_TOO_MANY_REFERENCES              = HRESULT(0xc0262103),
    ERROR_GRAPHICS_TRY_AGAIN_LATER                  = HRESULT(0xc0262104),
    ERROR_GRAPHICS_TRY_AGAIN_NOW                    = HRESULT(0xc0262105),
    ERROR_GRAPHICS_ALLOCATION_INVALID               = HRESULT(0xc0262106),
    ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE = HRESULT(0xc0262107),
    ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED = HRESULT(0xc0262108),
}

enum HRESULT ERROR_GRAPHICS_INVALID_ALLOCATION_USAGE = HRESULT(0xc0262110);

enum : HRESULT
{
    ERROR_GRAPHICS_ALLOCATION_CLOSED           = HRESULT(0xc0262112),
    ERROR_GRAPHICS_INVALID_ALLOCATION_INSTANCE = HRESULT(0xc0262113),
    ERROR_GRAPHICS_INVALID_ALLOCATION_HANDLE   = HRESULT(0xc0262114),
}

enum HRESULT ERROR_GRAPHICS_ALLOCATION_CONTENT_LOST = HRESULT(0xc0262116);
enum HRESULT ERROR_GRAPHICS_SKIP_ALLOCATION_PREPARATION = HRESULT(0x40262201);

enum : HRESULT
{
    ERROR_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED           = HRESULT(0xc0262301),
    ERROR_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED = HRESULT(0xc0262302),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE = HRESULT(0xc0262304),
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET = HRESULT(0xc0262305),
}

enum : HRESULT
{
    ERROR_GRAPHICS_MODE_NOT_PINNED                   = HRESULT(0x00262307),
    ERROR_GRAPHICS_INVALID_VIDPN_SOURCEMODESET       = HRESULT(0xc0262308),
    ERROR_GRAPHICS_INVALID_VIDPN_TARGETMODESET       = HRESULT(0xc0262309),
    ERROR_GRAPHICS_INVALID_FREQUENCY                 = HRESULT(0xc026230a),
    ERROR_GRAPHICS_INVALID_ACTIVE_REGION             = HRESULT(0xc026230b),
    ERROR_GRAPHICS_INVALID_TOTAL_REGION              = HRESULT(0xc026230c),
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE = HRESULT(0xc0262310),
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE = HRESULT(0xc0262311),
}

enum HRESULT ERROR_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY = HRESULT(0xc0262313);

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET = HRESULT(0xc0262315),
    ERROR_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET = HRESULT(0xc0262316),
}

enum : HRESULT
{
    ERROR_GRAPHICS_TARGET_ALREADY_IN_SET      = HRESULT(0xc0262318),
    ERROR_GRAPHICS_INVALID_VIDPN_PRESENT_PATH = HRESULT(0xc0262319),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET = HRESULT(0xc026231b),
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE    = HRESULT(0xc026231c),
}

enum : HRESULT
{
    ERROR_GRAPHICS_NO_PREFERRED_MODE             = HRESULT(0x0026231e),
    ERROR_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET = HRESULT(0xc026231f),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_MONITOR_SOURCEMODESET = HRESULT(0xc0262321),
    ERROR_GRAPHICS_INVALID_MONITOR_SOURCE_MODE   = HRESULT(0xc0262322),
}

enum : HRESULT
{
    ERROR_GRAPHICS_MODE_ID_MUST_BE_UNIQUE                          = HRESULT(0xc0262324),
    ERROR_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION = HRESULT(0xc0262325),
}

enum : HRESULT
{
    ERROR_GRAPHICS_PATH_NOT_IN_TOPOLOGY                  = HRESULT(0xc0262327),
    ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE = HRESULT(0xc0262328),
    ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET = HRESULT(0xc0262329),
}

enum HRESULT ERROR_GRAPHICS_INVALID_MONITORDESCRIPTOR = HRESULT(0xc026232b);

enum : HRESULT
{
    ERROR_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET    = HRESULT(0xc026232d),
    ERROR_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE = HRESULT(0xc026232e),
}

enum : HRESULT
{
    ERROR_GRAPHICS_RESOURCES_NOT_RELATED    = HRESULT(0xc0262330),
    ERROR_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE = HRESULT(0xc0262331),
}

enum HRESULT ERROR_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET = HRESULT(0xc0262333);

enum : HRESULT
{
    ERROR_GRAPHICS_NO_VIDPNMGR                  = HRESULT(0xc0262335),
    ERROR_GRAPHICS_NO_ACTIVE_VIDPN              = HRESULT(0xc0262336),
    ERROR_GRAPHICS_STALE_VIDPN_TOPOLOGY         = HRESULT(0xc0262337),
    ERROR_GRAPHICS_MONITOR_NOT_CONNECTED        = HRESULT(0xc0262338),
    ERROR_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY       = HRESULT(0xc0262339),
    ERROR_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE  = HRESULT(0xc026233a),
    ERROR_GRAPHICS_INVALID_VISIBLEREGION_SIZE   = HRESULT(0xc026233b),
    ERROR_GRAPHICS_INVALID_STRIDE               = HRESULT(0xc026233c),
    ERROR_GRAPHICS_INVALID_PIXELFORMAT          = HRESULT(0xc026233d),
    ERROR_GRAPHICS_INVALID_COLORBASIS           = HRESULT(0xc026233e),
    ERROR_GRAPHICS_INVALID_PIXELVALUEACCESSMODE = HRESULT(0xc026233f),
}

enum HRESULT ERROR_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT = HRESULT(0xc0262341);
enum HRESULT ERROR_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN = HRESULT(0xc0262343);
enum HRESULT ERROR_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION = HRESULT(0xc0262345);

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_GAMMA_RAMP       = HRESULT(0xc0262347),
    ERROR_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED = HRESULT(0xc0262348),
}

enum : HRESULT
{
    ERROR_GRAPHICS_MODE_NOT_IN_MODESET         = HRESULT(0xc026234a),
    ERROR_GRAPHICS_DATASET_IS_EMPTY            = HRESULT(0x0026234b),
    ERROR_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET = HRESULT(0x0026234c),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_PATH_CONTENT_TYPE   = HRESULT(0xc026234e),
    ERROR_GRAPHICS_INVALID_COPYPROTECTION_TYPE = HRESULT(0xc026234f),
}

enum HRESULT ERROR_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED = HRESULT(0x00262351);
enum HRESULT ERROR_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED = HRESULT(0xc0262353);

enum : HRESULT
{
    ERROR_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT               = HRESULT(0xc0262355),
    ERROR_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM            = HRESULT(0xc0262356),
    ERROR_GRAPHICS_INVALID_MONITOR_CAPABILITY_ORIGIN         = HRESULT(0xc0262357),
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE_CONSTRAINT = HRESULT(0xc0262358),
}

enum HRESULT ERROR_GRAPHICS_CANCEL_VIDPN_TOPOLOGY_AUGMENTATION = HRESULT(0xc026235a);

enum : HRESULT
{
    ERROR_GRAPHICS_CLIENTVIDPN_NOT_SET               = HRESULT(0xc026235c),
    ERROR_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED = HRESULT(0xc0262400),
}

enum : HRESULT
{
    ERROR_GRAPHICS_UNKNOWN_CHILD_STATUS    = HRESULT(0x4026242f),
    ERROR_GRAPHICS_NOT_A_LINKED_ADAPTER    = HRESULT(0xc0262430),
    ERROR_GRAPHICS_LEADLINK_NOT_ENUMERATED = HRESULT(0xc0262431),
}

enum HRESULT ERROR_GRAPHICS_ADAPTER_CHAIN_NOT_READY = HRESULT(0xc0262433);
enum HRESULT ERROR_GRAPHICS_CHAINLINKS_NOT_POWERED_ON = HRESULT(0xc0262435);
enum HRESULT ERROR_GRAPHICS_LEADLINK_START_DEFERRED = HRESULT(0x40262437);

enum : HRESULT
{
    ERROR_GRAPHICS_POLLING_TOO_FREQUENTLY      = HRESULT(0x40262439),
    ERROR_GRAPHICS_START_DEFERRED              = HRESULT(0x4026243a),
    ERROR_GRAPHICS_ADAPTER_ACCESS_NOT_EXCLUDED = HRESULT(0xc026243b),
}

enum : HRESULT
{
    ERROR_GRAPHICS_OPM_NOT_SUPPORTED                = HRESULT(0xc0262500),
    ERROR_GRAPHICS_COPP_NOT_SUPPORTED               = HRESULT(0xc0262501),
    ERROR_GRAPHICS_UAB_NOT_SUPPORTED                = HRESULT(0xc0262502),
    ERROR_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS = HRESULT(0xc0262503),
    ERROR_GRAPHICS_OPM_NO_VIDEO_OUTPUTS_EXIST       = HRESULT(0xc0262505),
    ERROR_GRAPHICS_OPM_INTERNAL_ERROR               = HRESULT(0xc026250b),
    ERROR_GRAPHICS_OPM_INVALID_HANDLE               = HRESULT(0xc026250c),
    ERROR_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH   = HRESULT(0xc026250e),
}

enum HRESULT ERROR_GRAPHICS_OPM_THEATER_MODE_ENABLED = HRESULT(0xc0262510);

enum : HRESULT
{
    ERROR_GRAPHICS_OPM_INVALID_SRM                   = HRESULT(0xc0262512),
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP  = HRESULT(0xc0262513),
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP   = HRESULT(0xc0262514),
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA = HRESULT(0xc0262515),
}

enum : HRESULT
{
    ERROR_GRAPHICS_OPM_RESOLUTION_TOO_HIGH              = HRESULT(0xc0262517),
    ERROR_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE = HRESULT(0xc0262518),
}

enum HRESULT ERROR_GRAPHICS_OPM_SESSION_TYPE_CHANGE_IN_PROGRESS = HRESULT(0xc026251b);

enum : HRESULT
{
    ERROR_GRAPHICS_OPM_INVALID_INFORMATION_REQUEST              = HRESULT(0xc026251d),
    ERROR_GRAPHICS_OPM_DRIVER_INTERNAL_ERROR                    = HRESULT(0xc026251e),
    ERROR_GRAPHICS_OPM_VIDEO_OUTPUT_DOES_NOT_HAVE_OPM_SEMANTICS = HRESULT(0xc026251f),
}

enum HRESULT ERROR_GRAPHICS_OPM_INVALID_CONFIGURATION_REQUEST = HRESULT(0xc0262521);

enum : HRESULT
{
    ERROR_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST   = HRESULT(0xc0262581),
    ERROR_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA = HRESULT(0xc0262582),
    ERROR_GRAPHICS_I2C_ERROR_RECEIVING_DATA    = HRESULT(0xc0262583),
}

enum : HRESULT
{
    ERROR_GRAPHICS_DDCCI_INVALID_DATA                                = HRESULT(0xc0262585),
    ERROR_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYTE = HRESULT(0xc0262586),
}

enum : HRESULT
{
    ERROR_GRAPHICS_MCA_INTERNAL_ERROR             = HRESULT(0xc0262588),
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND  = HRESULT(0xc0262589),
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH   = HRESULT(0xc026258a),
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM = HRESULT(0xc026258b),
}

enum HRESULT ERROR_GRAPHICS_MONITOR_NO_LONGER_EXISTS = HRESULT(0xc026258d);

enum : HRESULT
{
    ERROR_GRAPHICS_MCA_INVALID_VCP_VERSION                 = HRESULT(0xc02625d9),
    ERROR_GRAPHICS_MCA_MONITOR_VIOLATES_MCCS_SPECIFICATION = HRESULT(0xc02625da),
}

enum : HRESULT
{
    ERROR_GRAPHICS_MCA_UNSUPPORTED_MCCS_VERSION         = HRESULT(0xc02625dc),
    ERROR_GRAPHICS_MCA_INVALID_TECHNOLOGY_TYPE_RETURNED = HRESULT(0xc02625de),
}

enum HRESULT ERROR_GRAPHICS_ONLY_CONSOLE_SESSION_SUPPORTED = HRESULT(0xc02625e0);
enum HRESULT ERROR_GRAPHICS_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP = HRESULT(0xc02625e2);

enum : HRESULT
{
    ERROR_GRAPHICS_INVALID_POINTER                          = HRESULT(0xc02625e4),
    ERROR_GRAPHICS_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE = HRESULT(0xc02625e5),
}

enum : HRESULT
{
    ERROR_GRAPHICS_INTERNAL_ERROR                  = HRESULT(0xc02625e7),
    ERROR_GRAPHICS_SESSION_TYPE_CHANGE_IN_PROGRESS = HRESULT(0xc02605e8),
}

enum HRESULT ERROR_GRAPHICS_UEFI_FRAME_BUFFER_NOT_FOUND = HRESULT(0xc0262601);
enum HRESULT NAP_E_MISSING_SOH = HRESULT(0x80270002);
enum HRESULT NAP_E_NO_CACHED_SOH = HRESULT(0x80270004);

enum : HRESULT
{
    NAP_E_NOT_REGISTERED  = HRESULT(0x80270006),
    NAP_E_NOT_INITIALIZED = HRESULT(0x80270007),
}

enum HRESULT NAP_E_NOT_PENDING = HRESULT(0x80270009);
enum HRESULT NAP_E_MAXSIZE_TOO_SMALL = HRESULT(0x8027000b);
enum HRESULT NAP_S_CERT_ALREADY_PRESENT = HRESULT(0x0027000d);
enum HRESULT NAP_E_NETSH_GROUPPOLICY_ERROR = HRESULT(0x8027000f);

enum : HRESULT
{
    NAP_E_SHV_CONFIG_EXISTED   = HRESULT(0x80270011),
    NAP_E_SHV_CONFIG_NOT_FOUND = HRESULT(0x80270012),
}

enum HRESULT TPM_E_ERROR_MASK = HRESULT(0x80280000);

enum : HRESULT
{
    TPM_E_BADINDEX      = HRESULT(0x80280002),
    TPM_E_BAD_PARAMETER = HRESULT(0x80280003),
}

enum HRESULT TPM_E_CLEAR_DISABLED = HRESULT(0x80280005);

enum : HRESULT
{
    TPM_E_DISABLED     = HRESULT(0x80280007),
    TPM_E_DISABLED_CMD = HRESULT(0x80280008),
}

enum HRESULT TPM_E_BAD_ORDINAL = HRESULT(0x8028000a);
enum HRESULT TPM_E_INVALID_KEYHANDLE = HRESULT(0x8028000c);
enum HRESULT TPM_E_INAPPROPRIATE_ENC = HRESULT(0x8028000e);
enum HRESULT TPM_E_INVALID_PCR_INFO = HRESULT(0x80280010);

enum : HRESULT
{
    TPM_E_NOSRK          = HRESULT(0x80280012),
    TPM_E_NOTSEALED_BLOB = HRESULT(0x80280013),
}

enum HRESULT TPM_E_RESOURCES = HRESULT(0x80280015);

enum : HRESULT
{
    TPM_E_SIZE        = HRESULT(0x80280017),
    TPM_E_WRONGPCRVAL = HRESULT(0x80280018),
}

enum : HRESULT
{
    TPM_E_SHA_THREAD = HRESULT(0x8028001a),
    TPM_E_SHA_ERROR  = HRESULT(0x8028001b),
}

enum HRESULT TPM_E_AUTH2FAIL = HRESULT(0x8028001d);

enum : HRESULT
{
    TPM_E_IOERROR       = HRESULT(0x8028001f),
    TPM_E_ENCRYPT_ERROR = HRESULT(0x80280020),
}

enum HRESULT TPM_E_INVALID_AUTHHANDLE = HRESULT(0x80280022);
enum HRESULT TPM_E_INVALID_KEYUSAGE = HRESULT(0x80280024);
enum HRESULT TPM_E_INVALID_POSTINIT = HRESULT(0x80280026);

enum : HRESULT
{
    TPM_E_BAD_KEY_PROPERTY = HRESULT(0x80280028),
    TPM_E_BAD_MIGRATION    = HRESULT(0x80280029),
    TPM_E_BAD_SCHEME       = HRESULT(0x8028002a),
    TPM_E_BAD_DATASIZE     = HRESULT(0x8028002b),
    TPM_E_BAD_MODE         = HRESULT(0x8028002c),
    TPM_E_BAD_PRESENCE     = HRESULT(0x8028002d),
    TPM_E_BAD_VERSION      = HRESULT(0x8028002e),
}

enum : HRESULT
{
    TPM_E_AUDITFAIL_UNSUCCESSFUL = HRESULT(0x80280030),
    TPM_E_AUDITFAIL_SUCCESSFUL   = HRESULT(0x80280031),
}

enum : HRESULT
{
    TPM_E_NOTLOCAL         = HRESULT(0x80280033),
    TPM_E_BAD_TYPE         = HRESULT(0x80280034),
    TPM_E_INVALID_RESOURCE = HRESULT(0x80280035),
}

enum HRESULT TPM_E_INVALID_FAMILY = HRESULT(0x80280037);
enum HRESULT TPM_E_REQUIRES_SIGN = HRESULT(0x80280039);
enum HRESULT TPM_E_AUTH_CONFLICT = HRESULT(0x8028003b);
enum HRESULT TPM_E_BAD_LOCALITY = HRESULT(0x8028003d);
enum HRESULT TPM_E_PER_NOWRITE = HRESULT(0x8028003f);
enum HRESULT TPM_E_WRITE_LOCKED = HRESULT(0x80280041);
enum HRESULT TPM_E_INVALID_STRUCTURE = HRESULT(0x80280043);
enum HRESULT TPM_E_BAD_COUNTER = HRESULT(0x80280045);
enum HRESULT TPM_E_CONTEXT_GAP = HRESULT(0x80280047);
enum HRESULT TPM_E_NOOPERATOR = HRESULT(0x80280049);

enum : HRESULT
{
    TPM_E_DELEGATE_LOCK   = HRESULT(0x8028004b),
    TPM_E_DELEGATE_FAMILY = HRESULT(0x8028004c),
    TPM_E_DELEGATE_ADMIN  = HRESULT(0x8028004d),
}

enum HRESULT TPM_E_OWNER_CONTROL = HRESULT(0x8028004f);

enum : HRESULT
{
    TPM_E_DAA_INPUT_DATA0     = HRESULT(0x80280051),
    TPM_E_DAA_INPUT_DATA1     = HRESULT(0x80280052),
    TPM_E_DAA_ISSUER_SETTINGS = HRESULT(0x80280053),
}

enum : HRESULT
{
    TPM_E_DAA_STAGE           = HRESULT(0x80280055),
    TPM_E_DAA_ISSUER_VALIDITY = HRESULT(0x80280056),
}

enum : HRESULT
{
    TPM_E_BAD_HANDLE   = HRESULT(0x80280058),
    TPM_E_BAD_DELEGATE = HRESULT(0x80280059),
    TPM_E_BADCONTEXT   = HRESULT(0x8028005a),
}

enum HRESULT TPM_E_MA_TICKET_SIGNATURE = HRESULT(0x8028005c);

enum : HRESULT
{
    TPM_E_MA_SOURCE    = HRESULT(0x8028005e),
    TPM_E_MA_AUTHORITY = HRESULT(0x8028005f),
}

enum HRESULT TPM_E_BAD_SIGNATURE = HRESULT(0x80280062);

enum : HRESULT
{
    TPM_20_E_ASYMMETRIC        = HRESULT(0x80280081),
    TPM_20_E_ATTRIBUTES        = HRESULT(0x80280082),
    TPM_20_E_HASH              = HRESULT(0x80280083),
    TPM_20_E_VALUE             = HRESULT(0x80280084),
    TPM_20_E_HIERARCHY         = HRESULT(0x80280085),
    TPM_20_E_KEY_SIZE          = HRESULT(0x80280087),
    TPM_20_E_MGF               = HRESULT(0x80280088),
    TPM_20_E_MODE              = HRESULT(0x80280089),
    TPM_20_E_TYPE              = HRESULT(0x8028008a),
    TPM_20_E_HANDLE            = HRESULT(0x8028008b),
    TPM_20_E_KDF               = HRESULT(0x8028008c),
    TPM_20_E_RANGE             = HRESULT(0x8028008d),
    TPM_20_E_AUTH_FAIL         = HRESULT(0x8028008e),
    TPM_20_E_NONCE             = HRESULT(0x8028008f),
    TPM_20_E_PP                = HRESULT(0x80280090),
    TPM_20_E_SCHEME            = HRESULT(0x80280092),
    TPM_20_E_SIZE              = HRESULT(0x80280095),
    TPM_20_E_SYMMETRIC         = HRESULT(0x80280096),
    TPM_20_E_TAG               = HRESULT(0x80280097),
    TPM_20_E_SELECTOR          = HRESULT(0x80280098),
    TPM_20_E_INSUFFICIENT      = HRESULT(0x8028009a),
    TPM_20_E_SIGNATURE         = HRESULT(0x8028009b),
    TPM_20_E_KEY               = HRESULT(0x8028009c),
    TPM_20_E_POLICY_FAIL       = HRESULT(0x8028009d),
    TPM_20_E_INTEGRITY         = HRESULT(0x8028009f),
    TPM_20_E_TICKET            = HRESULT(0x802800a0),
    TPM_20_E_RESERVED_BITS     = HRESULT(0x802800a1),
    TPM_20_E_BAD_AUTH          = HRESULT(0x802800a2),
    TPM_20_E_EXPIRED           = HRESULT(0x802800a3),
    TPM_20_E_POLICY_CC         = HRESULT(0x802800a4),
    TPM_20_E_BINDING           = HRESULT(0x802800a5),
    TPM_20_E_CURVE             = HRESULT(0x802800a6),
    TPM_20_E_ECC_POINT         = HRESULT(0x802800a7),
    TPM_20_E_INITIALIZE        = HRESULT(0x80280100),
    TPM_20_E_FAILURE           = HRESULT(0x80280101),
    TPM_20_E_SEQUENCE          = HRESULT(0x80280103),
    TPM_20_E_PRIVATE           = HRESULT(0x8028010b),
    TPM_20_E_HMAC              = HRESULT(0x80280119),
    TPM_20_E_DISABLED          = HRESULT(0x80280120),
    TPM_20_E_EXCLUSIVE         = HRESULT(0x80280121),
    TPM_20_E_ECC_CURVE         = HRESULT(0x80280123),
    TPM_20_E_AUTH_TYPE         = HRESULT(0x80280124),
    TPM_20_E_AUTH_MISSING      = HRESULT(0x80280125),
    TPM_20_E_POLICY            = HRESULT(0x80280126),
    TPM_20_E_PCR               = HRESULT(0x80280127),
    TPM_20_E_PCR_CHANGED       = HRESULT(0x80280128),
    TPM_20_E_UPGRADE           = HRESULT(0x8028012d),
    TPM_20_E_TOO_MANY_CONTEXTS = HRESULT(0x8028012e),
}

enum : HRESULT
{
    TPM_20_E_REBOOT           = HRESULT(0x80280130),
    TPM_20_E_UNBALANCED       = HRESULT(0x80280131),
    TPM_20_E_COMMAND_SIZE     = HRESULT(0x80280142),
    TPM_20_E_COMMAND_CODE     = HRESULT(0x80280143),
    TPM_20_E_AUTHSIZE         = HRESULT(0x80280144),
    TPM_20_E_AUTH_CONTEXT     = HRESULT(0x80280145),
    TPM_20_E_NV_RANGE         = HRESULT(0x80280146),
    TPM_20_E_NV_SIZE          = HRESULT(0x80280147),
    TPM_20_E_NV_LOCKED        = HRESULT(0x80280148),
    TPM_20_E_NV_AUTHORIZATION = HRESULT(0x80280149),
    TPM_20_E_NV_UNINITIALIZED = HRESULT(0x8028014a),
    TPM_20_E_NV_SPACE         = HRESULT(0x8028014b),
    TPM_20_E_NV_DEFINED       = HRESULT(0x8028014c),
    TPM_20_E_BAD_CONTEXT      = HRESULT(0x80280150),
    TPM_20_E_CPHASH           = HRESULT(0x80280151),
    TPM_20_E_PARENT           = HRESULT(0x80280152),
    TPM_20_E_NEEDS_TEST       = HRESULT(0x80280153),
    TPM_20_E_NO_RESULT        = HRESULT(0x80280154),
    TPM_20_E_SENSITIVE        = HRESULT(0x80280155),
}

enum HRESULT TPM_E_INVALID_HANDLE = HRESULT(0x80280401);

enum : HRESULT
{
    TPM_E_EMBEDDED_COMMAND_BLOCKED     = HRESULT(0x80280403),
    TPM_E_EMBEDDED_COMMAND_UNSUPPORTED = HRESULT(0x80280404),
}

enum HRESULT TPM_E_NEEDS_SELFTEST = HRESULT(0x80280801);
enum HRESULT TPM_E_DEFEND_LOCK_RUNNING = HRESULT(0x80280803);

enum : HRESULT
{
    TPM_20_E_OBJECT_MEMORY  = HRESULT(0x80280902),
    TPM_20_E_SESSION_MEMORY = HRESULT(0x80280903),
}

enum HRESULT TPM_20_E_SESSION_HANDLES = HRESULT(0x80280905);

enum : HRESULT
{
    TPM_20_E_LOCALITY       = HRESULT(0x80280907),
    TPM_20_E_YIELDED        = HRESULT(0x80280908),
    TPM_20_E_CANCELED       = HRESULT(0x80280909),
    TPM_20_E_TESTING        = HRESULT(0x8028090a),
    TPM_20_E_NV_RATE        = HRESULT(0x80280920),
    TPM_20_E_LOCKOUT        = HRESULT(0x80280921),
    TPM_20_E_RETRY          = HRESULT(0x80280922),
    TPM_20_E_NV_UNAVAILABLE = HRESULT(0x80280923),
}

enum HRESULT TBS_E_BAD_PARAMETER = HRESULT(0x80284002);
enum HRESULT TBS_E_INVALID_CONTEXT = HRESULT(0x80284004);

enum : HRESULT
{
    TBS_E_IOERROR               = HRESULT(0x80284006),
    TBS_E_INVALID_CONTEXT_PARAM = HRESULT(0x80284007),
}

enum : HRESULT
{
    TBS_E_TOO_MANY_TBS_CONTEXTS = HRESULT(0x80284009),
    TBS_E_TOO_MANY_RESOURCES    = HRESULT(0x8028400a),
}

enum HRESULT TBS_E_PPI_NOT_SUPPORTED = HRESULT(0x8028400c);
enum HRESULT TBS_E_BUFFER_TOO_LARGE = HRESULT(0x8028400e);
enum HRESULT TBS_E_SERVICE_DISABLED = HRESULT(0x80284010);
enum HRESULT TBS_E_ACCESS_DENIED = HRESULT(0x80284012);
enum HRESULT TBS_E_PPI_FUNCTION_UNSUPPORTED = HRESULT(0x80284014);
enum HRESULT TBS_E_PROVISIONING_INCOMPLETE = HRESULT(0x80284016);
enum HRESULT TBS_E_TPM_REBOOT_REQUIRED = HRESULT(0x80284018);
enum HRESULT TPMAPI_E_NOT_ENOUGH_DATA = HRESULT(0x80290101);

enum : HRESULT
{
    TPMAPI_E_INVALID_OUTPUT_POINTER = HRESULT(0x80290103),
    TPMAPI_E_INVALID_PARAMETER      = HRESULT(0x80290104),
}

enum HRESULT TPMAPI_E_BUFFER_TOO_SMALL = HRESULT(0x80290106);

enum : HRESULT
{
    TPMAPI_E_ACCESS_DENIED        = HRESULT(0x80290108),
    TPMAPI_E_AUTHORIZATION_FAILED = HRESULT(0x80290109),
}

enum HRESULT TPMAPI_E_TBS_COMMUNICATION_ERROR = HRESULT(0x8029010b);
enum HRESULT TPMAPI_E_MESSAGE_TOO_LARGE = HRESULT(0x8029010d);
enum HRESULT TPMAPI_E_INVALID_KEY_SIZE = HRESULT(0x8029010f);

enum : HRESULT
{
    TPMAPI_E_INVALID_KEY_PARAMS                   = HRESULT(0x80290111),
    TPMAPI_E_INVALID_MIGRATION_AUTHORIZATION_BLOB = HRESULT(0x80290112),
}

enum : HRESULT
{
    TPMAPI_E_INVALID_DELEGATE_BLOB  = HRESULT(0x80290114),
    TPMAPI_E_INVALID_CONTEXT_PARAMS = HRESULT(0x80290115),
    TPMAPI_E_INVALID_KEY_BLOB       = HRESULT(0x80290116),
    TPMAPI_E_INVALID_PCR_DATA       = HRESULT(0x80290117),
    TPMAPI_E_INVALID_OWNER_AUTH     = HRESULT(0x80290118),
}

enum : HRESULT
{
    TPMAPI_E_EMPTY_TCG_LOG         = HRESULT(0x8029011a),
    TPMAPI_E_INVALID_TCG_LOG_ENTRY = HRESULT(0x8029011b),
}

enum HRESULT TPMAPI_E_TCG_INVALID_DIGEST_ENTRY = HRESULT(0x8029011d);

enum : HRESULT
{
    TPMAPI_E_NV_BITS_NOT_DEFINED = HRESULT(0x8029011f),
    TPMAPI_E_NV_BITS_NOT_READY   = HRESULT(0x80290120),
}

enum HRESULT TPMAPI_E_NO_AUTHORIZATION_CHAIN_FOUND = HRESULT(0x80290122);
enum HRESULT TPMAPI_E_OWNER_AUTH_NOT_NULL = HRESULT(0x80290124);
enum HRESULT TPMAPI_E_AUTHORIZATION_REVOKED = HRESULT(0x80290126);
enum HRESULT TPMAPI_E_AUTHORIZING_KEY_NOT_SUPPORTED = HRESULT(0x80290128);

enum : HRESULT
{
    TPMAPI_E_MALFORMED_AUTHORIZATION_POLICY = HRESULT(0x8029012a),
    TPMAPI_E_MALFORMED_AUTHORIZATION_OTHER  = HRESULT(0x8029012b),
}

enum : HRESULT
{
    TPMAPI_E_INVALID_TPM_VERSION          = HRESULT(0x8029012d),
    TPMAPI_E_INVALID_POLICYAUTH_BLOB_TYPE = HRESULT(0x8029012e),
    TPMAPI_E_INVALID_TAG                  = HRESULT(0x80290130),
    TPMAPI_E_INVALID_STRUCT_SIZE          = HRESULT(0x80290131),
}

enum HRESULT TPMAPI_E_COUNTER_CORRUPTED = HRESULT(0x80290133);
enum HRESULT TBSIMP_E_BUFFER_TOO_SMALL = HRESULT(0x80290200);

enum : HRESULT
{
    TBSIMP_E_INVALID_CONTEXT_HANDLE = HRESULT(0x80290202),
    TBSIMP_E_INVALID_CONTEXT_PARAM  = HRESULT(0x80290203),
}

enum : HRESULT
{
    TBSIMP_E_HASH_BAD_KEY      = HRESULT(0x80290205),
    TBSIMP_E_DUPLICATE_VHANDLE = HRESULT(0x80290206),
}

enum HRESULT TBSIMP_E_INVALID_PARAMETER = HRESULT(0x80290208);
enum HRESULT TBSIMP_E_SCHEDULER_NOT_RUNNING = HRESULT(0x8029020a);

enum : HRESULT
{
    TBSIMP_E_OUT_OF_MEMORY      = HRESULT(0x8029020c),
    TBSIMP_E_LIST_NO_MORE_ITEMS = HRESULT(0x8029020d),
    TBSIMP_E_LIST_NOT_FOUND     = HRESULT(0x8029020e),
}

enum HRESULT TBSIMP_E_NOT_ENOUGH_TPM_CONTEXTS = HRESULT(0x80290210);
enum HRESULT TBSIMP_E_UNKNOWN_ORDINAL = HRESULT(0x80290212);
enum HRESULT TBSIMP_E_INVALID_RESOURCE = HRESULT(0x80290214);
enum HRESULT TBSIMP_E_HASH_TABLE_FULL = HRESULT(0x80290216);
enum HRESULT TBSIMP_E_TOO_MANY_RESOURCES = HRESULT(0x80290218);
enum HRESULT TBSIMP_E_TPM_INCOMPATIBLE = HRESULT(0x8029021a);

enum : HRESULT
{
    TPM_E_PPI_ACPI_FAILURE    = HRESULT(0x80290300),
    TPM_E_PPI_USER_ABORT      = HRESULT(0x80290301),
    TPM_E_PPI_BIOS_FAILURE    = HRESULT(0x80290302),
    TPM_E_PPI_NOT_SUPPORTED   = HRESULT(0x80290303),
    TPM_E_PPI_BLOCKED_IN_BIOS = HRESULT(0x80290304),
}

enum HRESULT TPM_E_PCP_DEVICE_NOT_READY = HRESULT(0x80290401);
enum HRESULT TPM_E_PCP_INVALID_PARAMETER = HRESULT(0x80290403);

enum : HRESULT
{
    TPM_E_PCP_NOT_SUPPORTED    = HRESULT(0x80290405),
    TPM_E_PCP_BUFFER_TOO_SMALL = HRESULT(0x80290406),
}

enum : HRESULT
{
    TPM_E_PCP_AUTHENTICATION_FAILED  = HRESULT(0x80290408),
    TPM_E_PCP_AUTHENTICATION_IGNORED = HRESULT(0x80290409),
}

enum HRESULT TPM_E_PCP_PROFILE_NOT_FOUND = HRESULT(0x8029040b);
enum HRESULT TPM_E_PCP_WRONG_PARENT = HRESULT(0x8029040e);
enum HRESULT TPM_E_NO_KEY_CERTIFICATION = HRESULT(0x80290410);
enum HRESULT TPM_E_ATTESTATION_CHALLENGE_NOT_SET = HRESULT(0x80290412);
enum HRESULT TPM_E_KEY_ALREADY_FINALIZED = HRESULT(0x80290414);
enum HRESULT TPM_E_KEY_USAGE_POLICY_INVALID = HRESULT(0x80290416);
enum HRESULT TPM_E_KEY_NOT_AUTHENTICATED = HRESULT(0x80290418);
enum HRESULT TPM_E_KEY_NOT_SIGNING_KEY = HRESULT(0x8029041a);
enum HRESULT TPM_E_CLAIM_TYPE_NOT_SUPPORTED = HRESULT(0x8029041c);
enum HRESULT TPM_E_BUFFER_LENGTH_MISMATCH = HRESULT(0x8029041e);

enum : HRESULT
{
    TPM_E_PCP_TICKET_MISSING           = HRESULT(0x80290420),
    TPM_E_PCP_RAW_POLICY_NOT_SUPPORTED = HRESULT(0x80290421),
}

enum HRESULT TPM_E_PCP_UNSUPPORTED_PSS_SALT = HRESULT(0x40290423);

enum : HRESULT
{
    TPM_E_PCP_PLATFORM_CLAIM_OUTDATED = HRESULT(0x40290425),
    TPM_E_PCP_PLATFORM_CLAIM_REBOOT   = HRESULT(0x40290426),
}

enum HRESULT DRTM_E_ENVIRONMENT_UNSAFE = HRESULT(0x80290501);
enum HRESULT TPM_E_PROVISIONING_INCOMPLETE = HRESULT(0x80290600);
enum HRESULT TPM_E_TOO_MUCH_DATA = HRESULT(0x80290602);

enum : HRESULT
{
    PLA_E_DCS_NOT_FOUND = HRESULT(0x80300002),
    PLA_E_DCS_IN_USE    = HRESULT(0x803000aa),
}

enum HRESULT PLA_E_NO_MIN_DISK = HRESULT(0x80300070);
enum HRESULT PLA_S_PROPERTY_IGNORED = HRESULT(0x00300100);
enum HRESULT PLA_E_DCS_SINGLETON_REQUIRED = HRESULT(0x80300102);
enum HRESULT PLA_E_DCS_NOT_RUNNING = HRESULT(0x80300104);
enum HRESULT PLA_E_NETWORK_EXE_NOT_VALID = HRESULT(0x80300106);
enum HRESULT PLA_E_EXE_PATH_NOT_VALID = HRESULT(0x80300108);
enum HRESULT PLA_E_DCS_START_WAIT_TIMEOUT = HRESULT(0x8030010a);
enum HRESULT PLA_E_REPORT_WAIT_TIMEOUT = HRESULT(0x8030010c);
enum HRESULT PLA_E_EXE_FULL_PATH_REQUIRED = HRESULT(0x8030010e);
enum HRESULT PLA_E_PLA_CHANNEL_NOT_ENABLED = HRESULT(0x80300110);
enum HRESULT PLA_E_RULES_MANAGER_FAILED = HRESULT(0x80300112);
enum HRESULT FVE_E_LOCKED_VOLUME = HRESULT(0x80310000);

enum : HRESULT
{
    FVE_E_NO_TPM_BIOS          = HRESULT(0x80310002),
    FVE_E_NO_MBR_METRIC        = HRESULT(0x80310003),
    FVE_E_NO_BOOTSECTOR_METRIC = HRESULT(0x80310004),
    FVE_E_NO_BOOTMGR_METRIC    = HRESULT(0x80310005),
}

enum HRESULT FVE_E_SECURE_KEY_REQUIRED = HRESULT(0x80310007);
enum HRESULT FVE_E_ACTION_NOT_ALLOWED = HRESULT(0x80310009);

enum : HRESULT
{
    FVE_E_AD_INVALID_DATATYPE = HRESULT(0x8031000b),
    FVE_E_AD_INVALID_DATASIZE = HRESULT(0x8031000c),
}

enum : HRESULT
{
    FVE_E_AD_ATTR_NOT_SET   = HRESULT(0x8031000e),
    FVE_E_AD_GUID_NOT_FOUND = HRESULT(0x8031000f),
}

enum HRESULT FVE_E_TOO_SMALL = HRESULT(0x80310011);
enum HRESULT FVE_E_FAILED_WRONG_FS = HRESULT(0x80310013);
enum HRESULT FVE_E_NOT_SUPPORTED = HRESULT(0x80310015);
enum HRESULT FVE_E_VOLUME_NOT_BOUND = HRESULT(0x80310017);
enum HRESULT FVE_E_NOT_DATA_VOLUME = HRESULT(0x80310019);

enum : HRESULT
{
    FVE_E_CONV_READ  = HRESULT(0x8031001b),
    FVE_E_CONV_WRITE = HRESULT(0x8031001c),
}

enum HRESULT FVE_E_CLUSTERING_NOT_SUPPORTED = HRESULT(0x8031001e);
enum HRESULT FVE_E_OS_NOT_PROTECTED = HRESULT(0x80310020);
enum HRESULT FVE_E_RECOVERY_KEY_REQUIRED = HRESULT(0x80310022);
enum HRESULT FVE_E_OVERLAPPED_UPDATE = HRESULT(0x80310024);

enum : HRESULT
{
    FVE_E_FAILED_SECTOR_SIZE    = HRESULT(0x80310026),
    FVE_E_FAILED_AUTHENTICATION = HRESULT(0x80310027),
}

enum HRESULT FVE_E_AUTOUNLOCK_ENABLED = HRESULT(0x80310029);
enum HRESULT FVE_E_WRONG_SYSTEM_FS = HRESULT(0x8031002b);

enum : HRESULT
{
    FVE_E_CANNOT_SET_FVEK_ENCRYPTED = HRESULT(0x8031002d),
    FVE_E_CANNOT_ENCRYPT_NO_KEY     = HRESULT(0x8031002e),
}

enum HRESULT FVE_E_PROTECTOR_EXISTS = HRESULT(0x80310031);
enum HRESULT FVE_E_PROTECTOR_NOT_FOUND = HRESULT(0x80310033);
enum HRESULT FVE_E_INVALID_PASSWORD_FORMAT = HRESULT(0x80310035);

enum : HRESULT
{
    FVE_E_FIPS_PREVENTS_RECOVERY_PASSWORD   = HRESULT(0x80310037),
    FVE_E_FIPS_PREVENTS_EXTERNAL_KEY_EXPORT = HRESULT(0x80310038),
}

enum HRESULT FVE_E_INVALID_PROTECTOR_TYPE = HRESULT(0x8031003a);

enum : HRESULT
{
    FVE_E_KEYFILE_NOT_FOUND = HRESULT(0x8031003c),
    FVE_E_KEYFILE_INVALID   = HRESULT(0x8031003d),
    FVE_E_KEYFILE_NO_VMK    = HRESULT(0x8031003e),
}

enum HRESULT FVE_E_NOT_ALLOWED_IN_SAFE_MODE = HRESULT(0x80310040);
enum HRESULT FVE_E_TPM_NO_VMK = HRESULT(0x80310042);

enum : HRESULT
{
    FVE_E_AUTH_INVALID_APPLICATION = HRESULT(0x80310044),
    FVE_E_AUTH_INVALID_CONFIG      = HRESULT(0x80310045),
}

enum HRESULT FVE_E_FS_NOT_EXTENDED = HRESULT(0x80310047);

enum : HRESULT
{
    FVE_E_NO_LICENSE   = HRESULT(0x80310049),
    FVE_E_NOT_ON_STACK = HRESULT(0x8031004a),
}

enum HRESULT FVE_E_TOKEN_NOT_IMPERSONATED = HRESULT(0x8031004c);
enum HRESULT FVE_E_REBOOT_REQUIRED = HRESULT(0x8031004e);

enum : HRESULT
{
    FVE_E_RAW_ACCESS  = HRESULT(0x80310050),
    FVE_E_RAW_BLOCKED = HRESULT(0x80310051),
}

enum HRESULT FVE_E_NOT_ALLOWED_IN_VERSION = HRESULT(0x80310053);
enum HRESULT FVE_E_MOR_FAILED = HRESULT(0x80310055);
enum HRESULT FVE_E_TRANSIENT_STATE = HRESULT(0x80310057);
enum HRESULT FVE_E_VOLUME_HANDLE_OPEN = HRESULT(0x80310059);
enum HRESULT FVE_E_INVALID_STARTUP_OPTIONS = HRESULT(0x8031005b);

enum : HRESULT
{
    FVE_E_POLICY_RECOVERY_PASSWORD_REQUIRED = HRESULT(0x8031005d),
    FVE_E_POLICY_RECOVERY_KEY_NOT_ALLOWED   = HRESULT(0x8031005e),
    FVE_E_POLICY_RECOVERY_KEY_REQUIRED      = HRESULT(0x8031005f),
}

enum : HRESULT
{
    FVE_E_POLICY_STARTUP_PIN_REQUIRED        = HRESULT(0x80310061),
    FVE_E_POLICY_STARTUP_KEY_NOT_ALLOWED     = HRESULT(0x80310062),
    FVE_E_POLICY_STARTUP_KEY_REQUIRED        = HRESULT(0x80310063),
    FVE_E_POLICY_STARTUP_PIN_KEY_NOT_ALLOWED = HRESULT(0x80310064),
    FVE_E_POLICY_STARTUP_PIN_KEY_REQUIRED    = HRESULT(0x80310065),
    FVE_E_POLICY_STARTUP_TPM_NOT_ALLOWED     = HRESULT(0x80310066),
    FVE_E_POLICY_STARTUP_TPM_REQUIRED        = HRESULT(0x80310067),
}

enum HRESULT FVE_E_KEY_PROTECTOR_NOT_SUPPORTED = HRESULT(0x80310069);
enum HRESULT FVE_E_POLICY_PASSPHRASE_REQUIRED = HRESULT(0x8031006b);
enum HRESULT FVE_E_OS_VOLUME_PASSPHRASE_NOT_ALLOWED = HRESULT(0x8031006d);
enum HRESULT FVE_E_VOLUME_TOO_SMALL = HRESULT(0x8031006f);
enum HRESULT FVE_E_DV_NOT_ALLOWED_BY_GP = HRESULT(0x80310071);

enum : HRESULT
{
    FVE_E_POLICY_USER_CERTIFICATE_REQUIRED                 = HRESULT(0x80310073),
    FVE_E_POLICY_USER_CERT_MUST_BE_HW                      = HRESULT(0x80310074),
    FVE_E_POLICY_USER_CONFIGURE_FDV_AUTOUNLOCK_NOT_ALLOWED = HRESULT(0x80310075),
    FVE_E_POLICY_USER_CONFIGURE_RDV_AUTOUNLOCK_NOT_ALLOWED = HRESULT(0x80310076),
    FVE_E_POLICY_USER_CONFIGURE_RDV_NOT_ALLOWED            = HRESULT(0x80310077),
    FVE_E_POLICY_USER_ENABLE_RDV_NOT_ALLOWED               = HRESULT(0x80310078),
    FVE_E_POLICY_USER_DISABLE_RDV_NOT_ALLOWED              = HRESULT(0x80310079),
}

enum HRESULT FVE_E_POLICY_PASSPHRASE_TOO_SIMPLE = HRESULT(0x80310081);

enum : HRESULT
{
    FVE_E_POLICY_CONFLICT_FDV_RK_OFF_AUK_ON = HRESULT(0x80310083),
    FVE_E_POLICY_CONFLICT_RDV_RK_OFF_AUK_ON = HRESULT(0x80310084),
}

enum HRESULT FVE_E_POLICY_PROHIBITS_SELFSIGNED = HRESULT(0x80310086);
enum HRESULT FVE_E_CONV_RECOVERY_FAILED = HRESULT(0x80310088);

enum : HRESULT
{
    FVE_E_POLICY_CONFLICT_OSV_RP_OFF_ADB_ON = HRESULT(0x80310090),
    FVE_E_POLICY_CONFLICT_FDV_RP_OFF_ADB_ON = HRESULT(0x80310091),
    FVE_E_POLICY_CONFLICT_RDV_RP_OFF_ADB_ON = HRESULT(0x80310092),
}

enum HRESULT FVE_E_PRIVATEKEY_AUTH_FAILED = HRESULT(0x80310094);
enum HRESULT FVE_E_OPERATION_NOT_SUPPORTED_ON_VISTA_VOLUME = HRESULT(0x80310096);
enum HRESULT FVE_E_FIPS_HASH_KDF_NOT_ALLOWED = HRESULT(0x80310098);

enum : HRESULT
{
    FVE_E_INVALID_PIN_CHARS  = HRESULT(0x8031009a),
    FVE_E_INVALID_DATUM_TYPE = HRESULT(0x8031009b),
}

enum HRESULT FVE_E_MULTIPLE_NKP_CERTS = HRESULT(0x8031009d);
enum HRESULT FVE_E_INVALID_NKP_CERT = HRESULT(0x8031009f);
enum HRESULT FVE_E_PROTECTOR_CHANGE_PIN_MISMATCH = HRESULT(0x803100a1);
enum HRESULT FVE_E_PROTECTOR_CHANGE_MAX_PIN_CHANGE_ATTEMPTS_REACHED = HRESULT(0x803100a3);
enum HRESULT FVE_E_FULL_ENCRYPTION_NOT_ALLOWED_ON_TP_STORAGE = HRESULT(0x803100a5);
enum HRESULT FVE_E_KEY_LENGTH_NOT_SUPPORTED_BY_EDRIVE = HRESULT(0x803100a7);
enum HRESULT FVE_E_PROTECTOR_CHANGE_PASSPHRASE_MISMATCH = HRESULT(0x803100a9);
enum HRESULT FVE_E_NO_PASSPHRASE_WITH_TPM = HRESULT(0x803100ab);

enum : HRESULT
{
    FVE_E_NOT_ALLOWED_ON_CSV_STACK = HRESULT(0x803100ad),
    FVE_E_NOT_ALLOWED_ON_CLUSTER   = HRESULT(0x803100ae),
}

enum : HRESULT
{
    FVE_E_EDRIVE_BAND_IN_USE         = HRESULT(0x803100b0),
    FVE_E_EDRIVE_DISALLOWED_BY_GP    = HRESULT(0x803100b1),
    FVE_E_EDRIVE_INCOMPATIBLE_VOLUME = HRESULT(0x803100b2),
}

enum HRESULT FVE_E_EDRIVE_DV_NOT_SUPPORTED = HRESULT(0x803100b4);
enum HRESULT FVE_E_NO_PREBOOT_KEYBOARD_OR_WINRE_DETECTED = HRESULT(0x803100b6);
enum HRESULT FVE_E_POLICY_REQUIRES_RECOVERY_PASSWORD_ON_TOUCH_DEVICE = HRESULT(0x803100b8);

enum : HRESULT
{
    FVE_E_SECUREBOOT_DISABLED              = HRESULT(0x803100ba),
    FVE_E_SECUREBOOT_CONFIGURATION_INVALID = HRESULT(0x803100bb),
}

enum HRESULT FVE_E_SHADOW_COPY_PRESENT = HRESULT(0x803100bd);
enum HRESULT FVE_E_EDRIVE_INCOMPATIBLE_FIRMWARE = HRESULT(0x803100bf);
enum HRESULT FVE_E_PASSPHRASE_PROTECTOR_CHANGE_BY_STD_USER_DISALLOWED = HRESULT(0x803100c1);
enum HRESULT FVE_E_LIVEID_ACCOUNT_BLOCKED = HRESULT(0x803100c3);
enum HRESULT FVE_E_DE_FIXED_DATA_NOT_SUPPORTED = HRESULT(0x803100c5);
enum HRESULT FVE_E_DE_WINRE_NOT_CONFIGURED = HRESULT(0x803100c7);
enum HRESULT FVE_E_DE_OS_VOLUME_NOT_PROTECTED = HRESULT(0x803100c9);
enum HRESULT FVE_E_DE_PROTECTION_NOT_YET_ENABLED = HRESULT(0x803100cb);
enum HRESULT FVE_E_DEVICE_LOCKOUT_COUNTER_UNAVAILABLE = HRESULT(0x803100cd);
enum HRESULT FVE_E_BUFFER_TOO_LARGE = HRESULT(0x803100cf);
enum HRESULT FVE_E_DE_PREVENTED_FOR_OS = HRESULT(0x803100d1);
enum HRESULT FVE_E_DE_VOLUME_NOT_SUPPORTED = HRESULT(0x803100d3);
enum HRESULT FVE_E_ADBACKUP_NOT_ENABLED = HRESULT(0x803100d5);
enum HRESULT FVE_E_NOT_DE_VOLUME = HRESULT(0x803100d7);
enum HRESULT FVE_E_OSV_KSR_NOT_ALLOWED = HRESULT(0x803100d9);

enum : HRESULT
{
    FVE_E_AD_BACKUP_REQUIRED_POLICY_NOT_SET_FIXED_DRIVE     = HRESULT(0x803100db),
    FVE_E_AD_BACKUP_REQUIRED_POLICY_NOT_SET_REMOVABLE_DRIVE = HRESULT(0x803100dc),
}

enum HRESULT FVE_E_EXECUTE_REQUEST_SENT_TOO_SOON = HRESULT(0x803100de);
enum HRESULT FVE_E_DEVICE_NOT_JOINED_AAD = HRESULT(0x803100e0);
enum HRESULT FVE_E_INVALID_NBP_CERT = HRESULT(0x803100e2);
enum HRESULT FVE_E_POLICY_ON_RDV_EXCLUSION_LIST = HRESULT(0x803100e4);
enum HRESULT FVE_E_SETUP_TPM_CALLBACK_NOT_SUPPORTED = HRESULT(0x803100e6);
enum HRESULT FVE_E_UPDATE_INVALID_CONFIG = HRESULT(0x803100e8);
enum HRESULT FVE_E_AAD_SERVER_FAIL_BACKOFF_AAD = HRESULT(0x803100ea);
enum HRESULT FVE_E_METADATA_FULL = HRESULT(0x803100ec);
enum HRESULT FVE_E_EXCEED_LIMIT_RP = HRESULT(0x803100ee);
enum HRESULT FVE_E_SUSPEND_PROTECTION_NOT_ALLOWED = HRESULT(0x803100f0);

enum : HRESULT
{
    FVE_E_ENTRY_ALREADY_EXISTS = HRESULT(0x803100f2),
    FVE_E_ENTRY_NOT_FOUND      = HRESULT(0x803100f3),
}

enum HRESULT FVE_E_DATASET_TPM_DATUMS_INCONSISTENT = HRESULT(0x803100f5);
enum HRESULT FVE_E_SECURE_BOOT_BINDING_DATA_OUT_OF_SYNC = HRESULT(0x803100f7);
enum HRESULT FVE_E_BAD_TPM_DATUM_ASSOCIATION = HRESULT(0x803100f9);
enum HRESULT FVE_E_MATCHING_PCRS_TPM_FAILURE = HRESULT(0x803100fb);
enum HRESULT FVE_E_MSA_BACKUP_CACHE_NOT_ALLOCATED = HRESULT(0x803100fd);
enum HRESULT FVE_E_GENERAL_TPM_FAILURE = HRESULT(0x803100ff);
enum HRESULT FVE_E_NO_PCR_BOOT_LOCK_BOUNDARY = HRESULT(0xc0310101);
enum HRESULT FVE_E_FW_UPDATE_TPM_BINDINGS_NOT_REFRESHED = HRESULT(0xc0310103);
enum HRESULT FVE_E_INVALID_TPM_BINDING_CONFIGURATION = HRESULT(0xc0310105);
enum HRESULT FVE_E_TPM_BINDING_ASSOCIATION_FAILURE = HRESULT(0xc0310107);
enum HRESULT FVE_E_HW_ACCELERATED_ENCRYPTION_NOT_ALLOWED = HRESULT(0xc0310109);
enum HRESULT FVE_E_TPMPV2_USED_FAILURE = HRESULT(0xc031010b);

enum : HRESULT
{
    FVE_E_FW_UPDATE_PCRS_BLOCK        = HRESULT(0xc031010e),
    FVE_E_FW_UPDATE_PCRS_NOT_EXCLUDED = HRESULT(0xc031010f),
}

enum : HRESULT
{
    FVE_E_AAD_SERVER_FAIL_RETRY_AFTER = HRESULT(0x80310111),
    FVE_E_AAD_SERVER_FAIL_BACKOFF     = HRESULT(0x80310112),
}

enum : HRESULT
{
    FVE_E_HARDWARE_CRYPTO_ACCELERATOR_NOT_FIPS_COMPLIANT = HRESULT(0xc0310114),
    FVE_E_HARDWARE_CRYPTO_KEY_MANAGER_NOT_FIPS_COMPLIANT = HRESULT(0xc0310115),
}

enum HRESULT FWP_E_CALLOUT_NOT_FOUND = HRESULT(0x80320001);
enum HRESULT FWP_E_FILTER_NOT_FOUND = HRESULT(0x80320003);

enum : HRESULT
{
    FWP_E_PROVIDER_NOT_FOUND         = HRESULT(0x80320005),
    FWP_E_PROVIDER_CONTEXT_NOT_FOUND = HRESULT(0x80320006),
}

enum HRESULT FWP_E_NOT_FOUND = HRESULT(0x80320008);

enum : HRESULT
{
    FWP_E_IN_USE                      = HRESULT(0x8032000a),
    FWP_E_DYNAMIC_SESSION_IN_PROGRESS = HRESULT(0x8032000b),
}

enum HRESULT FWP_E_NO_TXN_IN_PROGRESS = HRESULT(0x8032000d);
enum HRESULT FWP_E_TXN_ABORTED = HRESULT(0x8032000f);
enum HRESULT FWP_E_INCOMPATIBLE_TXN = HRESULT(0x80320011);
enum HRESULT FWP_E_NET_EVENTS_DISABLED = HRESULT(0x80320013);
enum HRESULT FWP_E_KM_CLIENTS_ONLY = HRESULT(0x80320015);
enum HRESULT FWP_E_BUILTIN_OBJECT = HRESULT(0x80320017);
enum HRESULT FWP_E_NOTIFICATION_DROPPED = HRESULT(0x80320019);
enum HRESULT FWP_E_INCOMPATIBLE_SA_STATE = HRESULT(0x8032001b);

enum : HRESULT
{
    FWP_E_INVALID_ENUMERATOR = HRESULT(0x8032001d),
    FWP_E_INVALID_FLAGS      = HRESULT(0x8032001e),
    FWP_E_INVALID_NET_MASK   = HRESULT(0x8032001f),
    FWP_E_INVALID_RANGE      = HRESULT(0x80320020),
    FWP_E_INVALID_INTERVAL   = HRESULT(0x80320021),
}

enum HRESULT FWP_E_NULL_DISPLAY_NAME = HRESULT(0x80320023);
enum HRESULT FWP_E_INVALID_WEIGHT = HRESULT(0x80320025);
enum HRESULT FWP_E_TYPE_MISMATCH = HRESULT(0x80320027);

enum : HRESULT
{
    FWP_E_RESERVED            = HRESULT(0x80320029),
    FWP_E_DUPLICATE_CONDITION = HRESULT(0x8032002a),
    FWP_E_DUPLICATE_KEYMOD    = HRESULT(0x8032002b),
}

enum HRESULT FWP_E_ACTION_INCOMPATIBLE_WITH_SUBLAYER = HRESULT(0x8032002d);
enum HRESULT FWP_E_CONTEXT_INCOMPATIBLE_WITH_CALLOUT = HRESULT(0x8032002f);
enum HRESULT FWP_E_INCOMPATIBLE_DH_GROUP = HRESULT(0x80320031);
enum HRESULT FWP_E_NEVER_MATCH = HRESULT(0x80320033);
enum HRESULT FWP_E_INVALID_PARAMETER = HRESULT(0x80320035);
enum HRESULT FWP_E_CALLOUT_NOTIFICATION_FAILED = HRESULT(0x80320037);
enum HRESULT FWP_E_INVALID_CIPHER_TRANSFORM = HRESULT(0x80320039);
enum HRESULT FWP_E_INVALID_TRANSFORM_COMBINATION = HRESULT(0x8032003b);
enum HRESULT FWP_E_INVALID_TUNNEL_ENDPOINT = HRESULT(0x8032003d);

enum : HRESULT
{
    FWP_E_KEY_DICTATOR_ALREADY_REGISTERED       = HRESULT(0x8032003f),
    FWP_E_KEY_DICTATION_INVALID_KEYING_MATERIAL = HRESULT(0x80320040),
}

enum HRESULT FWP_E_INVALID_DNS_NAME = HRESULT(0x80320042);
enum HRESULT FWP_E_IKEEXT_NOT_RUNNING = HRESULT(0x80320044);

enum : HRESULT
{
    WS_S_ASYNC = HRESULT(0x003d0000),
    WS_S_END   = HRESULT(0x003d0001),
}

enum HRESULT WS_E_OBJECT_FAULTED = HRESULT(0x803d0001);
enum HRESULT WS_E_INVALID_OPERATION = HRESULT(0x803d0003);
enum HRESULT WS_E_ENDPOINT_ACCESS_DENIED = HRESULT(0x803d0005);
enum HRESULT WS_E_OPERATION_ABANDONED = HRESULT(0x803d0007);
enum HRESULT WS_E_NO_TRANSLATION_AVAILABLE = HRESULT(0x803d0009);

enum : HRESULT
{
    WS_E_ADDRESS_IN_USE        = HRESULT(0x803d000b),
    WS_E_ADDRESS_NOT_AVAILABLE = HRESULT(0x803d000c),
}

enum : HRESULT
{
    WS_E_ENDPOINT_NOT_AVAILABLE        = HRESULT(0x803d000e),
    WS_E_ENDPOINT_FAILURE              = HRESULT(0x803d000f),
    WS_E_ENDPOINT_UNREACHABLE          = HRESULT(0x803d0010),
    WS_E_ENDPOINT_ACTION_NOT_SUPPORTED = HRESULT(0x803d0011),
    WS_E_ENDPOINT_TOO_BUSY             = HRESULT(0x803d0012),
    WS_E_ENDPOINT_FAULT_RECEIVED       = HRESULT(0x803d0013),
    WS_E_ENDPOINT_DISCONNECTED         = HRESULT(0x803d0014),
}

enum HRESULT WS_E_PROXY_ACCESS_DENIED = HRESULT(0x803d0016);

enum : HRESULT
{
    WS_E_PROXY_REQUIRES_BASIC_AUTH     = HRESULT(0x803d0018),
    WS_E_PROXY_REQUIRES_DIGEST_AUTH    = HRESULT(0x803d0019),
    WS_E_PROXY_REQUIRES_NTLM_AUTH      = HRESULT(0x803d001a),
    WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH = HRESULT(0x803d001b),
}

enum : HRESULT
{
    WS_E_SERVER_REQUIRES_DIGEST_AUTH    = HRESULT(0x803d001d),
    WS_E_SERVER_REQUIRES_NTLM_AUTH      = HRESULT(0x803d001e),
    WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH = HRESULT(0x803d001f),
}

enum : HRESULT
{
    WS_E_OTHER                   = HRESULT(0x803d0021),
    WS_E_SECURITY_TOKEN_EXPIRED  = HRESULT(0x803d0022),
    WS_E_SECURITY_SYSTEM_FAILURE = HRESULT(0x803d0023),
}

enum HRESULT HCS_E_IMAGE_MISMATCH = HRESULT(0x80370101);
enum HRESULT HCS_E_INVALID_STATE = HRESULT(0x80370105);
enum HRESULT HCS_E_TERMINATED = HRESULT(0x80370107);

enum : HRESULT
{
    HCS_E_CONNECTION_TIMEOUT = HRESULT(0x80370109),
    HCS_E_CONNECTION_CLOSED  = HRESULT(0x8037010a),
}

enum HRESULT HCS_E_UNSUPPORTED_PROTOCOL_VERSION = HRESULT(0x8037010c);

enum : HRESULT
{
    HCS_E_SYSTEM_NOT_FOUND       = HRESULT(0x8037010e),
    HCS_E_SYSTEM_ALREADY_EXISTS  = HRESULT(0x8037010f),
    HCS_E_SYSTEM_ALREADY_STOPPED = HRESULT(0x80370110),
}

enum HRESULT HCS_E_INVALID_LAYER = HRESULT(0x80370112);
enum HRESULT HCS_E_SERVICE_NOT_AVAILABLE = HRESULT(0x80370114);

enum : HRESULT
{
    HCS_E_OPERATION_ALREADY_STARTED             = HRESULT(0x80370116),
    HCS_E_OPERATION_PENDING                     = HRESULT(0x80370117),
    HCS_E_OPERATION_TIMEOUT                     = HRESULT(0x80370118),
    HCS_E_OPERATION_SYSTEM_CALLBACK_ALREADY_SET = HRESULT(0x80370119),
}

enum HRESULT HCS_E_ACCESS_DENIED = HRESULT(0x8037011b);
enum HRESULT HCS_E_PROCESS_INFO_NOT_AVAILABLE = HRESULT(0x8037011d);
enum HRESULT HCS_E_PROCESS_ALREADY_STOPPED = HRESULT(0x8037011f);
enum HRESULT HCS_E_OPERATION_ALREADY_CANCELLED = HRESULT(0x80370121);
enum HRESULT WHV_E_INSUFFICIENT_BUFFER = HRESULT(0x80370301);
enum HRESULT WHV_E_UNSUPPORTED_HYPERVISOR_CONFIG = HRESULT(0x80370303);
enum HRESULT WHV_E_GPA_RANGE_NOT_FOUND = HRESULT(0x80370305);
enum HRESULT WHV_E_VP_DOES_NOT_EXIST = HRESULT(0x80370307);
enum HRESULT WHV_E_INVALID_VP_REGISTER_NAME = HRESULT(0x80370309);

enum : HRESULT
{
    VM_SAVED_STATE_DUMP_E_PARTITION_STATE_NOT_FOUND           = HRESULT(0xc0370500),
    VM_SAVED_STATE_DUMP_E_GUEST_MEMORY_NOT_FOUND              = HRESULT(0xc0370501),
    VM_SAVED_STATE_DUMP_E_NO_VP_FOUND_IN_PARTITION_STATE      = HRESULT(0xc0370502),
    VM_SAVED_STATE_DUMP_E_NESTED_VIRTUALIZATION_NOT_SUPPORTED = HRESULT(0xc0370503),
}

enum : HRESULT
{
    VM_SAVED_STATE_DUMP_E_VA_NOT_MAPPED      = HRESULT(0xc0370505),
    VM_SAVED_STATE_DUMP_E_INVALID_VP_STATE   = HRESULT(0xc0370506),
    VM_SAVED_STATE_DUMP_E_VP_VTL_NOT_ENABLED = HRESULT(0xc0370509),
}

enum HRESULT VM_E_CLIENT_NAME_REQUIRED = HRESULT(0xc0370700);
enum HRESULT VM_E_VTL2_NOT_AVAILABLE = HRESULT(0xc0370702);

enum : HRESULT
{
    VM_E_MANAGEMENT_VTL_RELOAD_INVALID_PROTOCOL_RESPONSE             = HRESULT(0xc0370801),
    VM_E_MANAGEMENT_VTL_RELOAD_SAVE_FAILURE                          = HRESULT(0xc0370802),
    VM_E_MANAGEMENT_VTL_RELOAD_RESTORE_FAILURE                       = HRESULT(0xc0370803),
    VM_E_MANAGEMENT_VTL_RELOAD_NO_SAVED_STATE                        = HRESULT(0xc0370804),
    VM_E_MANAGEMENT_VTL_RELOAD_INVALID_SAVE_NOTIFICATION_RECEIVED    = HRESULT(0xc0370805),
    VM_E_MANAGEMENT_VTL_RELOAD_INVALID_RESTORE_REQUEST_RECEIVED      = HRESULT(0xc0370806),
    VM_E_MANAGEMENT_VTL_RELOAD_INVALID_RESTORE_NOTIFICATION_RECEIVED = HRESULT(0xc0370807),
    VM_E_MANAGEMENT_VTL_RELOAD_NO_IGVM_FILE                          = HRESULT(0xc0370808),
    VM_E_MANAGEMENT_VTL_RELOAD_UNSUPPORTED                           = HRESULT(0xc0370809),
    VM_E_MANAGEMENT_VTL_PROTOCOL_ESTABLISHMENT_TIMEOUT               = HRESULT(0xc037080a),
}

enum HRESULT HCN_E_ENDPOINT_NOT_FOUND = HRESULT(0x803b0002);
enum HRESULT HCN_E_SWITCH_NOT_FOUND = HRESULT(0x803b0004);
enum HRESULT HCN_E_ADAPTER_NOT_FOUND = HRESULT(0x803b0006);
enum HRESULT HCN_E_POLICY_NOT_FOUND = HRESULT(0x803b0008);

enum : HRESULT
{
    HCN_E_INVALID_NETWORK                   = HRESULT(0x803b000a),
    HCN_E_INVALID_NETWORK_TYPE              = HRESULT(0x803b000b),
    HCN_E_INVALID_ENDPOINT                  = HRESULT(0x803b000c),
    HCN_E_INVALID_POLICY                    = HRESULT(0x803b000d),
    HCN_E_INVALID_POLICY_TYPE               = HRESULT(0x803b000e),
    HCN_E_INVALID_REMOTE_ENDPOINT_OPERATION = HRESULT(0x803b000f),
}

enum HRESULT HCN_E_LAYER_ALREADY_EXISTS = HRESULT(0x803b0011);
enum HRESULT HCN_E_PORT_ALREADY_EXISTS = HRESULT(0x803b0013);
enum HRESULT HCN_E_REQUEST_UNSUPPORTED = HRESULT(0x803b0015);
enum HRESULT HCN_E_DEGRADED_OPERATION = HRESULT(0x803b0017);
enum HRESULT HCN_E_GUID_CONVERSION_FAILURE = HRESULT(0x803b0019);

enum : HRESULT
{
    HCN_E_INVALID_JSON           = HRESULT(0x803b001b),
    HCN_E_INVALID_JSON_REFERENCE = HRESULT(0x803b001c),
}

enum HRESULT HCN_E_INVALID_IP = HRESULT(0x803b001e);
enum HRESULT HCN_E_MANAGER_STOPPED = HRESULT(0x803b0020);
enum HRESULT GCN_E_NO_REQUEST_HANDLERS = HRESULT(0x803b0022);
enum HRESULT GCN_E_RUNTIMEKEYS_FAILED = HRESULT(0x803b0024);
enum HRESULT GCN_E_NETADAPTER_NOT_FOUND = HRESULT(0x803b0026);
enum HRESULT GCN_E_NETINTERFACE_NOT_FOUND = HRESULT(0x803b0028);
enum HRESULT HCN_E_ICS_DISABLED = HRESULT(0x803b002a);
enum HRESULT HCN_E_ENTITY_HAS_REFERENCES = HRESULT(0x803b002c);
enum HRESULT HCN_E_NAMESPACE_ATTACH_FAILED = HRESULT(0x803b002e);
enum HRESULT HCN_E_INVALID_PREFIX = HRESULT(0x803b0030);

enum : HRESULT
{
    HCN_E_INVALID_SUBNET    = HRESULT(0x803b0032),
    HCN_E_INVALID_IP_SUBNET = HRESULT(0x803b0033),
}

enum HRESULT HCN_E_ENDPOINT_NOT_LOCAL = HRESULT(0x803b0035);
enum HRESULT HCN_E_VFP_NOT_ALLOWED = HRESULT(0x803b0037);

enum : int
{
    SDIAG_E_SCRIPT      = 0x803c0101,
    SDIAG_E_POWERSHELL  = 0x803c0102,
    SDIAG_E_MANAGEDHOST = 0x803c0103,
    SDIAG_E_NOVERIFIER  = 0x803c0104,
}

enum : int
{
    SDIAG_E_DISABLED  = 0x803c0106,
    SDIAG_E_TRUST     = 0x803c0107,
    SDIAG_E_CANNOTRUN = 0x803c0108,
    SDIAG_E_VERSION   = 0x803c0109,
    SDIAG_E_RESOURCE  = 0x803c010a,
    SDIAG_E_ROOTCAUSE = 0x803c010b,
}

enum HRESULT WPN_E_CHANNEL_REQUEST_NOT_COMPLETE = HRESULT(0x803e0101);
enum HRESULT WPN_E_OUTSTANDING_CHANNEL_REQUEST = HRESULT(0x803e0103);
enum HRESULT WPN_E_PLATFORM_UNAVAILABLE = HRESULT(0x803e0105);

enum : HRESULT
{
    WPN_E_NOTIFICATION_HIDDEN     = HRESULT(0x803e0107),
    WPN_E_NOTIFICATION_NOT_POSTED = HRESULT(0x803e0108),
}

enum : HRESULT
{
    WPN_E_CLOUD_INCAPABLE           = HRESULT(0x803e0110),
    WPN_E_CLOUD_AUTH_UNAVAILABLE    = HRESULT(0x803e011a),
    WPN_E_CLOUD_SERVICE_UNAVAILABLE = HRESULT(0x803e011b),
}

enum : HRESULT
{
    WPN_E_NOTIFICATION_DISABLED  = HRESULT(0x803e0111),
    WPN_E_NOTIFICATION_INCAPABLE = HRESULT(0x803e0112),
}

enum : HRESULT
{
    WPN_E_NOTIFICATION_TYPE_DISABLED = HRESULT(0x803e0114),
    WPN_E_NOTIFICATION_SIZE          = HRESULT(0x803e0115),
}

enum HRESULT WPN_E_ACCESS_DENIED = HRESULT(0x803e0117);
enum HRESULT WPN_E_PUSH_NOTIFICATION_INCAPABLE = HRESULT(0x803e0119);
enum HRESULT WPN_E_TAG_ALPHANUMERIC = HRESULT(0x803e012a);
enum HRESULT WPN_E_OUT_OF_SESSION = HRESULT(0x803e0200);
enum HRESULT WPN_E_IMAGE_NOT_FOUND_IN_CACHE = HRESULT(0x803e0202);
enum HRESULT WPN_E_INVALID_CLOUD_IMAGE = HRESULT(0x803e0204);
enum HRESULT WPN_E_CALLBACK_ALREADY_REGISTERED = HRESULT(0x803e0206);
enum HRESULT WPN_E_STORAGE_LOCKED = HRESULT(0x803e0208);
enum HRESULT WPN_E_GROUP_ALPHANUMERIC = HRESULT(0x803e020a);
enum HRESULT E_MBN_CONTEXT_NOT_ACTIVATED = HRESULT(0x80548201);
enum HRESULT E_MBN_DATA_CLASS_NOT_AVAILABLE = HRESULT(0x80548203);
enum HRESULT E_MBN_MAX_ACTIVATED_CONTEXTS = HRESULT(0x80548205);
enum HRESULT E_MBN_PROVIDER_NOT_VISIBLE = HRESULT(0x80548207);
enum HRESULT E_MBN_SERVICE_NOT_ACTIVATED = HRESULT(0x80548209);
enum HRESULT E_MBN_VOICE_CALL_IN_PROGRESS = HRESULT(0x8054820b);
enum HRESULT E_MBN_NOT_REGISTERED = HRESULT(0x8054820d);

enum : HRESULT
{
    E_MBN_PIN_NOT_SUPPORTED = HRESULT(0x8054820f),
    E_MBN_PIN_REQUIRED      = HRESULT(0x80548210),
    E_MBN_PIN_DISABLED      = HRESULT(0x80548211),
}

enum HRESULT E_MBN_INVALID_PROFILE = HRESULT(0x80548218);
enum HRESULT E_MBN_SMS_ENCODING_NOT_SUPPORTED = HRESULT(0x80548220);
enum HRESULT E_MBN_SMS_INVALID_MEMORY_INDEX = HRESULT(0x80548222);

enum : HRESULT
{
    E_MBN_SMS_MEMORY_FAILURE  = HRESULT(0x80548224),
    E_MBN_SMS_NETWORK_TIMEOUT = HRESULT(0x80548225),
}

enum HRESULT E_MBN_SMS_FORMAT_NOT_SUPPORTED = HRESULT(0x80548227);
enum HRESULT E_MBN_SMS_MEMORY_FULL = HRESULT(0x80548229);
enum HRESULT PEER_E_NOT_INITIALIZED = HRESULT(0x80630002);
enum HRESULT PEER_E_NOT_LICENSED = HRESULT(0x80630004);
enum HRESULT PEER_E_DBNAME_CHANGED = HRESULT(0x80630011);

enum : HRESULT
{
    PEER_E_GRAPH_NOT_READY     = HRESULT(0x80630013),
    PEER_E_GRAPH_SHUTTING_DOWN = HRESULT(0x80630014),
    PEER_E_GRAPH_IN_USE        = HRESULT(0x80630015),
}

enum HRESULT PEER_E_TOO_MANY_ATTRIBUTES = HRESULT(0x80630017);
enum HRESULT PEER_E_CONNECT_SELF = HRESULT(0x80630106);
enum HRESULT PEER_E_NODE_NOT_FOUND = HRESULT(0x80630108);

enum : HRESULT
{
    PEER_E_CONNECTION_NOT_AUTHENTICATED = HRESULT(0x8063010a),
    PEER_E_CONNECTION_REFUSED           = HRESULT(0x8063010b),
}

enum HRESULT PEER_E_TOO_MANY_IDENTITIES = HRESULT(0x80630202);
enum HRESULT PEER_E_GROUPS_EXIST = HRESULT(0x80630204);
enum HRESULT PEER_E_DATABASE_ACCESSDENIED = HRESULT(0x80630302);
enum HRESULT PEER_E_MAX_RECORD_SIZE_EXCEEDED = HRESULT(0x80630304);
enum HRESULT PEER_E_DATABASE_NOT_PRESENT = HRESULT(0x80630306);
enum HRESULT PEER_E_EVENT_HANDLE_NOT_FOUND = HRESULT(0x80630501);
enum HRESULT PEER_E_INVALID_ATTRIBUTES = HRESULT(0x80630602);
enum HRESULT PEER_E_CHAIN_TOO_LONG = HRESULT(0x80630703);
enum HRESULT PEER_E_CIRCULAR_CHAIN_DETECTED = HRESULT(0x80630706);

enum : HRESULT
{
    PEER_E_NO_CLOUD             = HRESULT(0x80631001),
    PEER_E_CLOUD_NAME_AMBIGUOUS = HRESULT(0x80631005),
}

enum HRESULT PEER_E_NOT_AUTHORIZED = HRESULT(0x80632020);
enum HRESULT PEER_E_DEFERRED_VALIDATION = HRESULT(0x80632030);

enum : HRESULT
{
    PEER_E_INVALID_PEER_NAME           = HRESULT(0x80632050),
    PEER_E_INVALID_CLASSIFIER          = HRESULT(0x80632060),
    PEER_E_INVALID_FRIENDLY_NAME       = HRESULT(0x80632070),
    PEER_E_INVALID_ROLE_PROPERTY       = HRESULT(0x80632071),
    PEER_E_INVALID_CLASSIFIER_PROPERTY = HRESULT(0x80632072),
    PEER_E_INVALID_RECORD_EXPIRATION   = HRESULT(0x80632080),
    PEER_E_INVALID_CREDENTIAL_INFO     = HRESULT(0x80632081),
    PEER_E_INVALID_CREDENTIAL          = HRESULT(0x80632082),
    PEER_E_INVALID_RECORD_SIZE         = HRESULT(0x80632083),
}

enum : HRESULT
{
    PEER_E_GROUP_NOT_READY = HRESULT(0x80632091),
    PEER_E_GROUP_IN_USE    = HRESULT(0x80632092),
}

enum : HRESULT
{
    PEER_E_NO_MEMBERS_FOUND      = HRESULT(0x80632094),
    PEER_E_NO_MEMBER_CONNECTIONS = HRESULT(0x80632095),
}

enum HRESULT PEER_E_IDENTITY_DELETED = HRESULT(0x806320a0);
enum HRESULT PEER_E_CONTACT_NOT_FOUND = HRESULT(0x80636001);
enum HRESULT PEER_S_NO_EVENT_DATA = HRESULT(0x00630002);
enum HRESULT PEER_S_SUBSCRIPTION_EXISTS = HRESULT(0x00636000);
enum HRESULT PEER_S_ALREADY_A_MEMBER = HRESULT(0x00630006);
enum HRESULT PEER_E_INVALID_PEER_HOST_NAME = HRESULT(0x80634002);
enum HRESULT PEER_E_PNRP_DUPLICATE_PEER_NAME = HRESULT(0x80634005);
enum HRESULT PEER_E_INVITE_RESPONSE_NOT_AVAILABLE = HRESULT(0x80637001);
enum HRESULT PEER_E_PRIVACY_DECLINED = HRESULT(0x80637004);
enum HRESULT PEER_E_INVALID_ADDRESS = HRESULT(0x80637007);

enum : HRESULT
{
    PEER_E_FW_BLOCKED_BY_POLICY     = HRESULT(0x80637009),
    PEER_E_FW_BLOCKED_BY_SHIELDS_UP = HRESULT(0x8063700a),
}

enum HRESULT UI_E_CREATE_FAILED = HRESULT(0x802a0001);
enum HRESULT UI_E_ILLEGAL_REENTRANCY = HRESULT(0x802a0003);

enum : HRESULT
{
    UI_E_VALUE_NOT_SET        = HRESULT(0x802a0005),
    UI_E_VALUE_NOT_DETERMINED = HRESULT(0x802a0006),
}

enum HRESULT UI_E_BOOLEAN_EXPECTED = HRESULT(0x802a0008);
enum HRESULT UI_E_AMBIGUOUS_MATCH = HRESULT(0x802a000a);
enum HRESULT UI_E_WRONG_THREAD = HRESULT(0x802a000c);
enum HRESULT UI_E_STORYBOARD_NOT_PLAYING = HRESULT(0x802a0102);
enum HRESULT UI_E_END_KEYFRAME_NOT_DETERMINED = HRESULT(0x802a0104);

enum : HRESULT
{
    UI_E_TRANSITION_ALREADY_USED      = HRESULT(0x802a0106),
    UI_E_TRANSITION_NOT_IN_STORYBOARD = HRESULT(0x802a0107),
    UI_E_TRANSITION_ECLIPSED          = HRESULT(0x802a0108),
}

enum HRESULT UI_E_TIMER_CLIENT_ALREADY_CONNECTED = HRESULT(0x802a010a);
enum HRESULT UI_E_PRIMITIVE_OUT_OF_BOUNDS = HRESULT(0x802a010c);

enum : HRESULT
{
    E_BLUETOOTH_ATT_INVALID_HANDLE              = HRESULT(0x80650001),
    E_BLUETOOTH_ATT_READ_NOT_PERMITTED          = HRESULT(0x80650002),
    E_BLUETOOTH_ATT_WRITE_NOT_PERMITTED         = HRESULT(0x80650003),
    E_BLUETOOTH_ATT_INVALID_PDU                 = HRESULT(0x80650004),
    E_BLUETOOTH_ATT_INSUFFICIENT_AUTHENTICATION = HRESULT(0x80650005),
}

enum : HRESULT
{
    E_BLUETOOTH_ATT_INVALID_OFFSET             = HRESULT(0x80650007),
    E_BLUETOOTH_ATT_INSUFFICIENT_AUTHORIZATION = HRESULT(0x80650008),
}

enum : HRESULT
{
    E_BLUETOOTH_ATT_ATTRIBUTE_NOT_FOUND              = HRESULT(0x8065000a),
    E_BLUETOOTH_ATT_ATTRIBUTE_NOT_LONG               = HRESULT(0x8065000b),
    E_BLUETOOTH_ATT_INSUFFICIENT_ENCRYPTION_KEY_SIZE = HRESULT(0x8065000c),
}

enum : HRESULT
{
    E_BLUETOOTH_ATT_UNLIKELY                = HRESULT(0x8065000e),
    E_BLUETOOTH_ATT_INSUFFICIENT_ENCRYPTION = HRESULT(0x8065000f),
    E_BLUETOOTH_ATT_UNSUPPORTED_GROUP_TYPE  = HRESULT(0x80650010),
    E_BLUETOOTH_ATT_INSUFFICIENT_RESOURCES  = HRESULT(0x80650011),
    E_BLUETOOTH_ATT_UNKNOWN_ERROR           = HRESULT(0x80651000),
}

enum HRESULT E_HDAUDIO_EMPTY_CONNECTION_LIST = HRESULT(0x80660002);
enum HRESULT E_HDAUDIO_NO_LOGICAL_DEVICES_CREATED = HRESULT(0x80660004);

enum : HRESULT
{
    E_SOUNDWIRE_COMMAND_ABORTED = HRESULT(0x80660006),
    E_SOUNDWIRE_COMMAND_IGNORED = HRESULT(0x80660007),
    E_SOUNDWIRE_COMMAND_FAILED  = HRESULT(0x80660008),
}

enum : HRESULT
{
    STATEREPOSITORY_E_STATEMENT_INPROGRESS           = HRESULT(0x80670002),
    STATEREPOSITORY_E_CONFIGURATION_INVALID          = HRESULT(0x80670003),
    STATEREPOSITORY_E_UNKNOWN_SCHEMA_VERSION         = HRESULT(0x80670004),
    STATEREPOSITORY_ERROR_DICTIONARY_CORRUPTED       = HRESULT(0x80670005),
    STATEREPOSITORY_E_BLOCKED                        = HRESULT(0x80670006),
    STATEREPOSITORY_E_BUSY_RETRY                     = HRESULT(0x80670007),
    STATEREPOSITORY_E_BUSY_RECOVERY_RETRY            = HRESULT(0x80670008),
    STATEREPOSITORY_E_LOCKED_RETRY                   = HRESULT(0x80670009),
    STATEREPOSITORY_E_LOCKED_SHAREDCACHE_RETRY       = HRESULT(0x8067000a),
    STATEREPOSITORY_E_TRANSACTION_REQUIRED           = HRESULT(0x8067000b),
    STATEREPOSITORY_E_BUSY_TIMEOUT_EXCEEDED          = HRESULT(0x8067000c),
    STATEREPOSITORY_E_BUSY_RECOVERY_TIMEOUT_EXCEEDED = HRESULT(0x8067000d),
}

enum HRESULT STATEREPOSITORY_E_LOCKED_SHAREDCACHE_TIMEOUT_EXCEEDED = HRESULT(0x8067000f);
enum HRESULT STATEREPOSTORY_E_NESTED_TRANSACTION_NOT_SUPPORTED = HRESULT(0x80670011);

enum : HRESULT
{
    STATEREPOSITORY_TRANSACTION_CALLER_ID_CHANGED = HRESULT(0x00670013),
    STATEREPOSITORY_TRANSACTION_IN_PROGRESS       = HRESULT(0x80670014),
    STATEREPOSITORY_E_CACHE_NOT_INIITALIZED       = HRESULT(0x80670015),
    STATEREPOSITORY_E_DEPENDENCY_NOT_RESOLVED     = HRESULT(0x80670016),
}

enum HRESULT ERROR_SPACES_FAULT_DOMAIN_TYPE_INVALID = HRESULT(0x80e70001);
enum HRESULT ERROR_SPACES_RESILIENCY_TYPE_INVALID = HRESULT(0x80e70003);
enum HRESULT ERROR_SPACES_DRIVE_REDUNDANCY_INVALID = HRESULT(0x80e70006);
enum HRESULT ERROR_SPACES_PARITY_LAYOUT_INVALID = HRESULT(0x80e70008);
enum HRESULT ERROR_SPACES_NUMBER_OF_COLUMNS_INVALID = HRESULT(0x80e7000a);

enum : HRESULT
{
    ERROR_SPACES_EXTENDED_ERROR            = HRESULT(0x80e7000c),
    ERROR_SPACES_PROVISIONING_TYPE_INVALID = HRESULT(0x80e7000d),
}

enum HRESULT ERROR_SPACES_ENCLOSURE_AWARE_INVALID = HRESULT(0x80e7000f);
enum HRESULT ERROR_SPACES_NUMBER_OF_GROUPS_INVALID = HRESULT(0x80e70011);

enum : HRESULT
{
    ERROR_SPACES_ENTRY_INCOMPLETE    = HRESULT(0x80e70013),
    ERROR_SPACES_ENTRY_INVALID       = HRESULT(0x80e70014),
    ERROR_SPACES_UPDATE_COLUMN_STATE = HRESULT(0x80e70015),
    ERROR_SPACES_MAP_REQUIRED        = HRESULT(0x80e70016),
    ERROR_SPACES_UNSUPPORTED_VERSION = HRESULT(0x80e70017),
    ERROR_SPACES_CORRUPT_METADATA    = HRESULT(0x80e70018),
    ERROR_SPACES_DRT_FULL            = HRESULT(0x80e70019),
    ERROR_SPACES_INCONSISTENCY       = HRESULT(0x80e7001a),
    ERROR_SPACES_LOG_NOT_READY       = HRESULT(0x80e7001b),
    ERROR_SPACES_NO_REDUNDANCY       = HRESULT(0x80e7001c),
    ERROR_SPACES_DRIVE_NOT_READY     = HRESULT(0x80e7001d),
    ERROR_SPACES_DRIVE_SPLIT         = HRESULT(0x80e7001e),
    ERROR_SPACES_DRIVE_LOST_DATA     = HRESULT(0x80e7001f),
    ERROR_SPACES_MARK_DIRTY          = HRESULT(0x80e70020),
    ERROR_SPACES_FLUSH_METADATA      = HRESULT(0x80e70025),
    ERROR_SPACES_CACHE_FULL          = HRESULT(0x80e70026),
    ERROR_SPACES_REPAIR_IN_PROGRESS  = HRESULT(0x80e70027),
}

enum : HRESULT
{
    ERROR_VOLSNAP_ACTIVATION_TIMEOUT        = HRESULT(0x80820002),
    ERROR_VOLSNAP_NO_BYPASSIO_WITH_SNAPSHOT = HRESULT(0x80820003),
}

enum HRESULT ERROR_TIERING_VOLUME_DISMOUNT_IN_PROGRESS = HRESULT(0x80830002);

enum : HRESULT
{
    ERROR_TIERING_INVALID_FILE_ID    = HRESULT(0x80830004),
    ERROR_TIERING_WRONG_CLUSTER_NODE = HRESULT(0x80830005),
    ERROR_TIERING_ALREADY_PROCESSING = HRESULT(0x80830006),
    ERROR_TIERING_CANNOT_PIN_OBJECT  = HRESULT(0x80830007),
    ERROR_TIERING_FILE_IS_NOT_PINNED = HRESULT(0x80830008),
}

enum HRESULT ERROR_ATTRIBUTE_NOT_PRESENT = HRESULT(0x8083000a);
enum HRESULT ERROR_NO_APPLICABLE_APP_LICENSES_FOUND = HRESULT(0xc0ea0001);
enum HRESULT ERROR_CLIP_DEVICE_LICENSE_MISSING = HRESULT(0xc0ea0003);
enum HRESULT ERROR_CLIP_KEYHOLDER_LICENSE_MISSING_OR_INVALID = HRESULT(0xc0ea0005);

enum : HRESULT
{
    ERROR_CLIP_LICENSE_SIGNED_BY_UNKNOWN_SOURCE     = HRESULT(0xc0ea0007),
    ERROR_CLIP_LICENSE_NOT_SIGNED                   = HRESULT(0xc0ea0008),
    ERROR_CLIP_LICENSE_HARDWARE_ID_OUT_OF_TOLERANCE = HRESULT(0xc0ea0009),
    ERROR_CLIP_LICENSE_DEVICE_ID_MISMATCH           = HRESULT(0xc0ea000a),
}

enum : HRESULT
{
    DXGI_STATUS_CLIPPED                      = HRESULT(0x087a0002),
    DXGI_STATUS_NO_REDIRECTION               = HRESULT(0x087a0004),
    DXGI_STATUS_NO_DESKTOP_ACCESS            = HRESULT(0x087a0005),
    DXGI_STATUS_GRAPHICS_VIDPN_SOURCE_IN_USE = HRESULT(0x087a0006),
}

enum HRESULT DXGI_STATUS_MODE_CHANGE_IN_PROGRESS = HRESULT(0x087a0008);
enum HRESULT PRESENTATION_ERROR_LOST = HRESULT(0x88810001);
enum HRESULT DXGI_STATUS_DDA_WAS_STILL_DRAWING = HRESULT(0x087a000a);

enum : HRESULT
{
    DXGI_DDI_ERR_WASSTILLDRAWING = HRESULT(0x887b0001),
    DXGI_DDI_ERR_UNSUPPORTED     = HRESULT(0x887b0002),
    DXGI_DDI_ERR_NONEXCLUSIVE    = HRESULT(0x887b0003),
}

enum HRESULT D3D10_ERROR_FILE_NOT_FOUND = HRESULT(0x88790002);

enum : HRESULT
{
    D3D11_ERROR_FILE_NOT_FOUND               = HRESULT(0x887c0002),
    D3D11_ERROR_TOO_MANY_UNIQUE_VIEW_OBJECTS = HRESULT(0x887c0003),
}

enum : HRESULT
{
    D3D12_ERROR_ADAPTER_NOT_FOUND       = HRESULT(0x887e0001),
    D3D12_ERROR_DRIVER_VERSION_MISMATCH = HRESULT(0x887e0002),
}

enum HRESULT D2DERR_WRONG_STATE = HRESULT(0x88990001);
enum HRESULT D2DERR_UNSUPPORTED_OPERATION = HRESULT(0x88990003);
enum HRESULT D2DERR_SCREEN_ACCESS_DENIED = HRESULT(0x88990005);
enum HRESULT D2DERR_ZERO_VECTOR = HRESULT(0x88990007);
enum HRESULT D2DERR_DISPLAY_FORMAT_NOT_SUPPORTED = HRESULT(0x88990009);
enum HRESULT D2DERR_NO_HARDWARE_DEVICE = HRESULT(0x8899000b);
enum HRESULT D2DERR_TOO_MANY_SHADER_ELEMENTS = HRESULT(0x8899000d);
enum HRESULT D2DERR_MAX_TEXTURE_SIZE_EXCEEDED = HRESULT(0x8899000f);

enum : HRESULT
{
    D2DERR_BAD_NUMBER    = HRESULT(0x88990011),
    D2DERR_WRONG_FACTORY = HRESULT(0x88990012),
}

enum HRESULT D2DERR_POP_CALL_DID_NOT_MATCH_PUSH = HRESULT(0x88990014);
enum HRESULT D2DERR_PUSH_POP_UNBALANCED = HRESULT(0x88990016);
enum HRESULT D2DERR_INCOMPATIBLE_BRUSH_TYPES = HRESULT(0x88990018);
enum HRESULT D2DERR_TARGET_NOT_GDI_COMPATIBLE = HRESULT(0x8899001a);
enum HRESULT D2DERR_TEXT_RENDERER_NOT_RELEASED = HRESULT(0x8899001c);

enum : HRESULT
{
    D2DERR_INVALID_GRAPH_CONFIGURATION          = HRESULT(0x8899001e),
    D2DERR_INVALID_INTERNAL_GRAPH_CONFIGURATION = HRESULT(0x8899001f),
}

enum HRESULT D2DERR_BITMAP_CANNOT_DRAW = HRESULT(0x88990021);
enum HRESULT D2DERR_ORIGINAL_TARGET_NOT_BOUND = HRESULT(0x88990023);
enum HRESULT D2DERR_BITMAP_BOUND_AS_TARGET = HRESULT(0x88990025);
enum HRESULT D2DERR_INTERMEDIATE_TOO_LARGE = HRESULT(0x88990027);
enum HRESULT D2DERR_INVALID_PROPERTY = HRESULT(0x88990029);

enum : HRESULT
{
    D2DERR_PRINT_JOB_CLOSED           = HRESULT(0x8899002b),
    D2DERR_PRINT_FORMAT_NOT_SUPPORTED = HRESULT(0x8899002c),
}

enum HRESULT D2DERR_INVALID_GLYPH_IMAGE = HRESULT(0x8899002e);

enum : HRESULT
{
    DWRITE_E_UNEXPECTED             = HRESULT(0x88985001),
    DWRITE_E_NOFONT                 = HRESULT(0x88985002),
    DWRITE_E_FILENOTFOUND           = HRESULT(0x88985003),
    DWRITE_E_FILEACCESS             = HRESULT(0x88985004),
    DWRITE_E_FONTCOLLECTIONOBSOLETE = HRESULT(0x88985005),
}

enum : HRESULT
{
    DWRITE_E_CACHEFORMAT          = HRESULT(0x88985007),
    DWRITE_E_CACHEVERSION         = HRESULT(0x88985008),
    DWRITE_E_UNSUPPORTEDOPERATION = HRESULT(0x88985009),
}

enum HRESULT DWRITE_E_FLOWDIRECTIONCONFLICTS = HRESULT(0x8898500b);

enum : HRESULT
{
    WINCODEC_ERR_WRONGSTATE            = HRESULT(0x88982f04),
    WINCODEC_ERR_VALUEOUTOFRANGE       = HRESULT(0x88982f05),
    WINCODEC_ERR_UNKNOWNIMAGEFORMAT    = HRESULT(0x88982f07),
    WINCODEC_ERR_UNSUPPORTEDVERSION    = HRESULT(0x88982f0b),
    WINCODEC_ERR_NOTINITIALIZED        = HRESULT(0x88982f0c),
    WINCODEC_ERR_ALREADYLOCKED         = HRESULT(0x88982f0d),
    WINCODEC_ERR_PROPERTYNOTFOUND      = HRESULT(0x88982f40),
    WINCODEC_ERR_PROPERTYNOTSUPPORTED  = HRESULT(0x88982f41),
    WINCODEC_ERR_PROPERTYSIZE          = HRESULT(0x88982f42),
    WINCODEC_ERR_CODECPRESENT          = HRESULT(0x88982f43),
    WINCODEC_ERR_CODECNOTHUMBNAIL      = HRESULT(0x88982f44),
    WINCODEC_ERR_PALETTEUNAVAILABLE    = HRESULT(0x88982f45),
    WINCODEC_ERR_CODECTOOMANYSCANLINES = HRESULT(0x88982f46),
}

enum HRESULT WINCODEC_ERR_SOURCERECTDOESNOTMATCHDIMENSIONS = HRESULT(0x88982f49);

enum : HRESULT
{
    WINCODEC_ERR_IMAGESIZEOUTOFRANGE    = HRESULT(0x88982f51),
    WINCODEC_ERR_TOOMUCHMETADATA        = HRESULT(0x88982f52),
    WINCODEC_ERR_BADIMAGE               = HRESULT(0x88982f60),
    WINCODEC_ERR_BADHEADER              = HRESULT(0x88982f61),
    WINCODEC_ERR_FRAMEMISSING           = HRESULT(0x88982f62),
    WINCODEC_ERR_BADMETADATAHEADER      = HRESULT(0x88982f63),
    WINCODEC_ERR_BADSTREAMDATA          = HRESULT(0x88982f70),
    WINCODEC_ERR_STREAMWRITE            = HRESULT(0x88982f71),
    WINCODEC_ERR_STREAMREAD             = HRESULT(0x88982f72),
    WINCODEC_ERR_STREAMNOTAVAILABLE     = HRESULT(0x88982f73),
    WINCODEC_ERR_UNSUPPORTEDPIXELFORMAT = HRESULT(0x88982f80),
    WINCODEC_ERR_UNSUPPORTEDOPERATION   = HRESULT(0x88982f81),
}

enum HRESULT WINCODEC_ERR_COMPONENTINITIALIZEFAILURE = HRESULT(0x88982f8b);
enum HRESULT WINCODEC_ERR_DUPLICATEMETADATAPRESENT = HRESULT(0x88982f8d);

enum : HRESULT
{
    WINCODEC_ERR_UNEXPECTEDSIZE         = HRESULT(0x88982f8f),
    WINCODEC_ERR_INVALIDQUERYREQUEST    = HRESULT(0x88982f90),
    WINCODEC_ERR_UNEXPECTEDMETADATATYPE = HRESULT(0x88982f91),
}

enum HRESULT WINCODEC_ERR_INVALIDQUERYCHARACTER = HRESULT(0x88982f93);

enum : HRESULT
{
    WINCODEC_ERR_INVALIDPROGRESSIVELEVEL = HRESULT(0x88982f95),
    WINCODEC_ERR_INVALIDJPEGSCANINDEX    = HRESULT(0x88982f96),
}

enum : HRESULT
{
    MILERR_OBJECTBUSY         = HRESULT(0x88980001),
    MILERR_INSUFFICIENTBUFFER = HRESULT(0x88980002),
}

enum : HRESULT
{
    MILERR_SCANNER_FAILED     = HRESULT(0x88980004),
    MILERR_SCREENACCESSDENIED = HRESULT(0x88980005),
}

enum HRESULT MILERR_NONINVERTIBLEMATRIX = HRESULT(0x88980007);

enum : HRESULT
{
    MILERR_TERMINATED    = HRESULT(0x88980009),
    MILERR_BADNUMBER     = HRESULT(0x8898000a),
    MILERR_INTERNALERROR = HRESULT(0x88980080),
}

enum HRESULT MILERR_INVALIDCALL = HRESULT(0x88980085);

enum : HRESULT
{
    MILERR_NOTLOCKED              = HRESULT(0x88980087),
    MILERR_DEVICECANNOTRENDERTEXT = HRESULT(0x88980088),
}

enum HRESULT MILERR_MALFORMEDGLYPHCACHE = HRESULT(0x8898008a);
enum HRESULT MILERR_MALFORMED_GUIDELINE_DATA = HRESULT(0x8898008c);
enum HRESULT MILERR_NEED_RECREATE_AND_PRESENT = HRESULT(0x8898008e);
enum HRESULT MILERR_MISMATCHED_SIZE = HRESULT(0x88980090);
enum HRESULT MILERR_REMOTING_NOT_SUPPORTED = HRESULT(0x88980092);
enum HRESULT MILERR_NOT_QUEUING_PRESENTS = HRESULT(0x88980094);
enum HRESULT MILERR_TOOMANYSHADERELEMNTS = HRESULT(0x88980096);
enum HRESULT MILERR_MROW_UPDATE_FAILED = HRESULT(0x88980098);
enum HRESULT MILERR_MAX_TEXTURE_SIZE_EXCEEDED = HRESULT(0x8898009a);
enum HRESULT MILERR_DXGI_ENUMERATION_OUT_OF_SYNC = HRESULT(0x8898009d);
enum HRESULT MILERR_COLORSPACE_NOT_SUPPORTED = HRESULT(0x8898009f);
enum HRESULT MILERR_DISPLAYID_ACCESS_DENIED = HRESULT(0x889800a1);
enum HRESULT MILERR_INTEL_DEVICE_CREATION_FAILURE = HRESULT(0x889800b1);
enum HRESULT MILERR_NVIDIA_DEVICE_CREATION_FAILURE = HRESULT(0x889800b3);
enum HRESULT MILERR_SWAPCHAIN_CREATION_FAILURE = HRESULT(0x889800c0);
enum HRESULT MILERR_AMD_SWAPCHAIN_CREATION_FAILURE = HRESULT(0x889800c2);
enum HRESULT MILERR_QC_SWAPCHAIN_CREATION_FAILURE = HRESULT(0x889800c4);
enum HRESULT MILERR_PRESENT_FAILURE = HRESULT(0x889800d0);
enum HRESULT MILERR_AMD_PRESENT_FAILURE = HRESULT(0x889800d2);
enum HRESULT MILERR_QC_PRESENT_FAILURE = HRESULT(0x889800d4);
enum HRESULT UCEERR_INVALIDPACKETHEADER = HRESULT(0x88980400);
enum HRESULT UCEERR_ILLEGALPACKET = HRESULT(0x88980402);
enum HRESULT UCEERR_ILLEGALHANDLE = HRESULT(0x88980404);
enum HRESULT UCEERR_RENDERTHREADFAILURE = HRESULT(0x88980406);
enum HRESULT UCEERR_CONNECTIONIDLOOKUPFAILED = HRESULT(0x88980408);
enum HRESULT UCEERR_MEMORYFAILURE = HRESULT(0x8898040a);
enum HRESULT UCEERR_ILLEGALRECORDTYPE = HRESULT(0x8898040c);
enum HRESULT UCEERR_UNCHANGABLE_UPDATE_ATTEMPTED = HRESULT(0x8898040e);
enum HRESULT UCEERR_REMOTINGNOTSUPPORTED = HRESULT(0x88980410);
enum HRESULT UCEERR_MISSINGBEGINCOMMAND = HRESULT(0x88980412);
enum HRESULT UCEERR_CHANNELSYNCABANDONED = HRESULT(0x88980414);
enum HRESULT UCEERR_TRANSPORTUNAVAILABLE = HRESULT(0x88980416);
enum HRESULT UCEERR_COMMANDTRANSPORTDENIED = HRESULT(0x88980418);
enum HRESULT UCEERR_GRAPHICSSTREAMALREADYOPEN = HRESULT(0x88980420);
enum HRESULT UCEERR_TRANSPORTOVERLOADED = HRESULT(0x88980422);

enum : HRESULT
{
    MILAVERR_NOCLOCK          = HRESULT(0x88980500),
    MILAVERR_NOMEDIATYPE      = HRESULT(0x88980501),
    MILAVERR_NOVIDEOMIXER     = HRESULT(0x88980502),
    MILAVERR_NOVIDEOPRESENTER = HRESULT(0x88980503),
    MILAVERR_NOREADYFRAMES    = HRESULT(0x88980504),
    MILAVERR_MODULENOTLOADED  = HRESULT(0x88980505),
}

enum : HRESULT
{
    MILAVERR_INVALIDWMPVERSION          = HRESULT(0x88980507),
    MILAVERR_INSUFFICIENTVIDEORESOURCES = HRESULT(0x88980508),
}

enum HRESULT MILAVERR_REQUESTEDTEXTURETOOBIG = HRESULT(0x8898050a);
enum HRESULT MILAVERR_UNEXPECTEDWMPFAILURE = HRESULT(0x8898050c);
enum HRESULT MILAVERR_UNKNOWNHARDWAREERROR = HRESULT(0x8898050e);

enum : HRESULT
{
    MILEFFECTSERR_EFFECTNOTPARTOFGROUP  = HRESULT(0x8898060f),
    MILEFFECTSERR_NOINPUTSOURCEATTACHED = HRESULT(0x88980610),
}

enum HRESULT MILEFFECTSERR_CONNECTORNOTASSOCIATEDWITHEFFECT = HRESULT(0x88980612);

enum : HRESULT
{
    MILEFFECTSERR_CYCLEDETECTED             = HRESULT(0x88980614),
    MILEFFECTSERR_EFFECTINMORETHANONEGRAPH  = HRESULT(0x88980615),
    MILEFFECTSERR_EFFECTALREADYINAGRAPH     = HRESULT(0x88980616),
    MILEFFECTSERR_EFFECTHASNOCHILDREN       = HRESULT(0x88980617),
    MILEFFECTSERR_ALREADYATTACHEDTOLISTENER = HRESULT(0x88980618),
}

enum : HRESULT
{
    MILEFFECTSERR_EMPTYBOUNDS        = HRESULT(0x8898061a),
    MILEFFECTSERR_OUTPUTSIZETOOLARGE = HRESULT(0x8898061b),
}

enum HRESULT DWMERR_THEME_FAILED = HRESULT(0x88980701);

enum : HRESULT
{
    DCOMPOSITION_ERROR_WINDOW_ALREADY_COMPOSED    = HRESULT(0x88980800),
    DCOMPOSITION_ERROR_SURFACE_BEING_RENDERED     = HRESULT(0x88980801),
    DCOMPOSITION_ERROR_SURFACE_NOT_BEING_RENDERED = HRESULT(0x88980802),
}

enum HRESULT ONL_E_ACCESS_DENIED_BY_TOU = HRESULT(0x80860002);
enum HRESULT ONL_E_PASSWORD_UPDATE_REQUIRED = HRESULT(0x80860004);
enum HRESULT ONL_E_FORCESIGNIN = HRESULT(0x80860006);
enum HRESULT ONL_E_PARENTAL_CONSENT_REQUIRED = HRESULT(0x80860008);

enum : HRESULT
{
    ONL_E_ACCOUNT_SUSPENDED_COMPROIMISE = HRESULT(0x8086000a),
    ONL_E_ACCOUNT_SUSPENDED_ABUSE       = HRESULT(0x8086000b),
}

enum HRESULT ONL_CONNECTION_COUNT_LIMIT = HRESULT(0x8086000d);
enum HRESULT ONL_E_USER_AUTHENTICATION_REQUIRED = HRESULT(0x8086000f);
enum HRESULT FA_E_MAX_PERSISTED_ITEMS_REACHED = HRESULT(0x80270220);
enum HRESULT E_MONITOR_RESOLUTION_TOO_LOW = HRESULT(0x80270250);
enum HRESULT E_UAC_DISABLED = HRESULT(0x80270252);
enum HRESULT E_APPLICATION_NOT_REGISTERED = HRESULT(0x80270254);
enum HRESULT E_MULTIPLE_PACKAGES_FOR_FAMILY = HRESULT(0x80270256);
enum HRESULT S_STORE_LAUNCHED_FOR_REMEDIATION = HRESULT(0x00270258);

enum : HRESULT
{
    E_APPLICATION_ACTIVATION_TIMED_OUT    = HRESULT(0x8027025a),
    E_APPLICATION_ACTIVATION_EXEC_FAILURE = HRESULT(0x8027025b),
}

enum HRESULT E_APPLICATION_TRIAL_LICENSE_EXPIRED = HRESULT(0x8027025d);

enum : HRESULT
{
    E_SKYDRIVE_ROOT_TARGET_OVERLAP      = HRESULT(0x80270261),
    E_SKYDRIVE_ROOT_TARGET_CANNOT_INDEX = HRESULT(0x80270262),
}

enum HRESULT E_SKYDRIVE_UPDATE_AVAILABILITY_FAIL = HRESULT(0x80270264);

enum : HRESULT
{
    E_SYNCENGINE_FILE_SIZE_OVER_LIMIT              = HRESULT(0x8802b001),
    E_SYNCENGINE_FILE_SIZE_EXCEEDS_REMAINING_QUOTA = HRESULT(0x8802b002),
}

enum HRESULT E_SYNCENGINE_FOLDER_ITEM_COUNT_LIMIT_EXCEEDED = HRESULT(0x8802b004);
enum HRESULT E_SYNCENGINE_SYNC_PAUSED_BY_SERVICE = HRESULT(0x8802b006);
enum HRESULT E_SYNCENGINE_SERVICE_AUTHENTICATION_FAILED = HRESULT(0x8802c003);
enum HRESULT E_SYNCENGINE_SERVICE_RETURNED_UNEXPECTED_SIZE = HRESULT(0x8802c005);
enum HRESULT E_SYNCENGINE_REQUEST_BLOCKED_DUE_TO_CLIENT_ERROR = HRESULT(0x8802c007);

enum : HRESULT
{
    E_SYNCENGINE_UNSUPPORTED_FOLDER_NAME    = HRESULT(0x8802d002),
    E_SYNCENGINE_UNSUPPORTED_MARKET         = HRESULT(0x8802d003),
    E_SYNCENGINE_PATH_LENGTH_LIMIT_EXCEEDED = HRESULT(0x8802d004),
}

enum HRESULT E_SYNCENGINE_CLIENT_UPDATE_NEEDED = HRESULT(0x8802d006);
enum HRESULT E_SYNCENGINE_STORAGE_SERVICE_PROVISIONING_FAILED = HRESULT(0x8802d008);
enum HRESULT E_SYNCENGINE_STORAGE_SERVICE_BLOCKED = HRESULT(0x8802d00a);

enum : HRESULT
{
    EAS_E_POLICY_NOT_MANAGED_BY_OS      = HRESULT(0x80550001),
    EAS_E_POLICY_COMPLIANT_WITH_ACTIONS = HRESULT(0x80550002),
}

enum HRESULT EAS_E_CURRENT_USER_HAS_BLANK_PASSWORD = HRESULT(0x80550004);
enum HRESULT EAS_E_USER_CANNOT_CHANGE_PASSWORD = HRESULT(0x80550006);
enum HRESULT EAS_E_ADMINS_CANNOT_CHANGE_PASSWORD = HRESULT(0x80550008);
enum HRESULT EAS_E_PASSWORD_POLICY_NOT_ENFORCEABLE_FOR_CONNECTED_ADMINS = HRESULT(0x8055000a);
enum HRESULT EAS_E_PASSWORD_POLICY_NOT_ENFORCEABLE_FOR_CURRENT_CONNECTED_USER = HRESULT(0x8055000c);
enum HRESULT WEB_E_UNSUPPORTED_FORMAT = HRESULT(0x83750001);

enum : HRESULT
{
    WEB_E_MISSING_REQUIRED_ELEMENT   = HRESULT(0x83750003),
    WEB_E_MISSING_REQUIRED_ATTRIBUTE = HRESULT(0x83750004),
}

enum HRESULT WEB_E_RESOURCE_TOO_LARGE = HRESULT(0x83750006);
enum HRESULT WEB_E_INVALID_JSON_NUMBER = HRESULT(0x83750008);

enum : HRESULT
{
    HTTP_E_STATUS_UNEXPECTED              = HRESULT(0x80190001),
    HTTP_E_STATUS_UNEXPECTED_REDIRECTION  = HRESULT(0x80190003),
    HTTP_E_STATUS_UNEXPECTED_CLIENT_ERROR = HRESULT(0x80190004),
    HTTP_E_STATUS_UNEXPECTED_SERVER_ERROR = HRESULT(0x80190005),
}

enum : HRESULT
{
    HTTP_E_STATUS_MOVED                 = HRESULT(0x8019012d),
    HTTP_E_STATUS_REDIRECT              = HRESULT(0x8019012e),
    HTTP_E_STATUS_REDIRECT_METHOD       = HRESULT(0x8019012f),
    HTTP_E_STATUS_NOT_MODIFIED          = HRESULT(0x80190130),
    HTTP_E_STATUS_USE_PROXY             = HRESULT(0x80190131),
    HTTP_E_STATUS_REDIRECT_KEEP_VERB    = HRESULT(0x80190133),
    HTTP_E_STATUS_BAD_REQUEST           = HRESULT(0x80190190),
    HTTP_E_STATUS_DENIED                = HRESULT(0x80190191),
    HTTP_E_STATUS_PAYMENT_REQ           = HRESULT(0x80190192),
    HTTP_E_STATUS_FORBIDDEN             = HRESULT(0x80190193),
    HTTP_E_STATUS_NOT_FOUND             = HRESULT(0x80190194),
    HTTP_E_STATUS_BAD_METHOD            = HRESULT(0x80190195),
    HTTP_E_STATUS_NONE_ACCEPTABLE       = HRESULT(0x80190196),
    HTTP_E_STATUS_PROXY_AUTH_REQ        = HRESULT(0x80190197),
    HTTP_E_STATUS_REQUEST_TIMEOUT       = HRESULT(0x80190198),
    HTTP_E_STATUS_CONFLICT              = HRESULT(0x80190199),
    HTTP_E_STATUS_GONE                  = HRESULT(0x8019019a),
    HTTP_E_STATUS_LENGTH_REQUIRED       = HRESULT(0x8019019b),
    HTTP_E_STATUS_PRECOND_FAILED        = HRESULT(0x8019019c),
    HTTP_E_STATUS_REQUEST_TOO_LARGE     = HRESULT(0x8019019d),
    HTTP_E_STATUS_URI_TOO_LONG          = HRESULT(0x8019019e),
    HTTP_E_STATUS_UNSUPPORTED_MEDIA     = HRESULT(0x8019019f),
    HTTP_E_STATUS_RANGE_NOT_SATISFIABLE = HRESULT(0x801901a0),
}

enum : HRESULT
{
    HTTP_E_STATUS_SERVER_ERROR    = HRESULT(0x801901f4),
    HTTP_E_STATUS_NOT_SUPPORTED   = HRESULT(0x801901f5),
    HTTP_E_STATUS_BAD_GATEWAY     = HRESULT(0x801901f6),
    HTTP_E_STATUS_SERVICE_UNAVAIL = HRESULT(0x801901f7),
    HTTP_E_STATUS_GATEWAY_TIMEOUT = HRESULT(0x801901f8),
    HTTP_E_STATUS_VERSION_NOT_SUP = HRESULT(0x801901f9),
}

enum HRESULT E_INVALID_PROTOCOL_FORMAT = HRESULT(0x83760002);
enum HRESULT E_SUBPROTOCOL_NOT_SUPPORTED = HRESULT(0x83760004);
enum HRESULT INPUT_E_OUT_OF_ORDER = HRESULT(0x80400000);

enum : HRESULT
{
    INPUT_E_MULTIMODAL      = HRESULT(0x80400002),
    INPUT_E_PACKET          = HRESULT(0x80400003),
    INPUT_E_FRAME           = HRESULT(0x80400004),
    INPUT_E_HISTORY         = HRESULT(0x80400005),
    INPUT_E_DEVICE_INFO     = HRESULT(0x80400006),
    INPUT_E_TRANSFORM       = HRESULT(0x80400007),
    INPUT_E_DEVICE_PROPERTY = HRESULT(0x80400008),
}

enum HRESULT ERROR_DBG_ATTACH_PROCESS_FAILURE_LOCKDOWN = HRESULT(0x80b00002);
enum HRESULT ERROR_DBG_START_SERVER_FAILURE_LOCKDOWN = HRESULT(0x80b00004);
enum HRESULT HSP_E_INTERNAL_ERROR = HRESULT(0x81280fff);
enum HRESULT HSP_BS_INTERNAL_ERROR = HRESULT(0x812810ff);
enum HRESULT HSP_DRV_INTERNAL_ERROR = HRESULT(0x812900ff);
enum HRESULT HSP_BASE_INTERNAL_ERROR = HRESULT(0x812901ff);
enum HRESULT HSP_KSP_DEVICE_NOT_READY = HRESULT(0x81290201);

enum : HRESULT
{
    HSP_KSP_INVALID_KEY_HANDLE = HRESULT(0x81290203),
    HSP_KSP_INVALID_PARAMETER  = HRESULT(0x81290204),
}

enum HRESULT HSP_KSP_NOT_SUPPORTED = HRESULT(0x81290206);
enum HRESULT HSP_KSP_INVALID_FLAGS = HRESULT(0x81290208);

enum : HRESULT
{
    HSP_KSP_KEY_ALREADY_FINALIZED = HRESULT(0x8129020a),
    HSP_KSP_KEY_NOT_FINALIZED     = HRESULT(0x8129020b),
}

enum : HRESULT
{
    HSP_KSP_NO_MEMORY         = HRESULT(0x81290210),
    HSP_KSP_PARAMETER_NOT_SET = HRESULT(0x81290211),
}

enum : HRESULT
{
    HSP_KSP_KEY_MISSING   = HRESULT(0x81290216),
    HSP_KSP_KEY_LOAD_FAIL = HRESULT(0x81290217),
}

enum HRESULT HSP_KSP_INTERNAL_ERROR = HRESULT(0x812902ff);
enum HRESULT JSCRIPT_E_CANTEXECUTE = HRESULT(0x89020001);
enum HRESULT WEP_E_FIXED_DATA_NOT_SUPPORTED = HRESULT(0x88010002);
enum HRESULT WEP_E_LOCK_NOT_CONFIGURED = HRESULT(0x88010004);
enum HRESULT WEP_E_NO_LICENSE = HRESULT(0x88010006);
enum HRESULT WEP_E_UNEXPECTED_FAIL = HRESULT(0x88010008);

enum : HRESULT
{
    ERROR_SVHDX_ERROR_STORED        = HRESULT(0xc05c0000),
    ERROR_SVHDX_ERROR_NOT_AVAILABLE = HRESULT(0xc05cff00),
}

enum : HRESULT
{
    ERROR_SVHDX_UNIT_ATTENTION_CAPACITY_DATA_CHANGED        = HRESULT(0xc05cff02),
    ERROR_SVHDX_UNIT_ATTENTION_RESERVATIONS_PREEMPTED       = HRESULT(0xc05cff03),
    ERROR_SVHDX_UNIT_ATTENTION_RESERVATIONS_RELEASED        = HRESULT(0xc05cff04),
    ERROR_SVHDX_UNIT_ATTENTION_REGISTRATIONS_PREEMPTED      = HRESULT(0xc05cff05),
    ERROR_SVHDX_UNIT_ATTENTION_OPERATING_DEFINITION_CHANGED = HRESULT(0xc05cff06),
}

enum : HRESULT
{
    ERROR_SVHDX_WRONG_FILE_TYPE  = HRESULT(0xc05cff08),
    ERROR_SVHDX_VERSION_MISMATCH = HRESULT(0xc05cff09),
}

enum HRESULT ERROR_SVHDX_NO_INITIATOR = HRESULT(0xc05cff0b);
enum HRESULT ERROR_SMB_NO_PREAUTH_INTEGRITY_HASH_OVERLAP = HRESULT(0xc05d0000);
enum HRESULT ERROR_SMB_NO_SIGNING_ALGORITHM_OVERLAP = HRESULT(0xc05d0002);
enum HRESULT ERROR_SMB_GUEST_ENCRYPTION_NOT_SUPPORTED = HRESULT(0xc05d0004);
enum HRESULT ERROR_SMB_CERT_NO_PRIVATE_KEY = HRESULT(0xc05d0006);

enum : HRESULT
{
    WININET_E_OUT_OF_HANDLES      = HRESULT(0x80072ee1),
    WININET_E_TIMEOUT             = HRESULT(0x80072ee2),
    WININET_E_EXTENDED_ERROR      = HRESULT(0x80072ee3),
    WININET_E_INTERNAL_ERROR      = HRESULT(0x80072ee4),
    WININET_E_INVALID_URL         = HRESULT(0x80072ee5),
    WININET_E_UNRECOGNIZED_SCHEME = HRESULT(0x80072ee6),
}

enum HRESULT WININET_E_PROTOCOL_NOT_FOUND = HRESULT(0x80072ee8);
enum HRESULT WININET_E_BAD_OPTION_LENGTH = HRESULT(0x80072eea);

enum : HRESULT
{
    WININET_E_SHUTDOWN            = HRESULT(0x80072eec),
    WININET_E_INCORRECT_USER_NAME = HRESULT(0x80072eed),
    WININET_E_INCORRECT_PASSWORD  = HRESULT(0x80072eee),
}

enum HRESULT WININET_E_INVALID_OPERATION = HRESULT(0x80072ef0);

enum : HRESULT
{
    WININET_E_INCORRECT_HANDLE_TYPE  = HRESULT(0x80072ef2),
    WININET_E_INCORRECT_HANDLE_STATE = HRESULT(0x80072ef3),
}

enum HRESULT WININET_E_REGISTRY_VALUE_NOT_FOUND = HRESULT(0x80072ef5);

enum : HRESULT
{
    WININET_E_NO_DIRECT_ACCESS = HRESULT(0x80072ef7),
    WININET_E_NO_CONTEXT       = HRESULT(0x80072ef8),
    WININET_E_NO_CALLBACK      = HRESULT(0x80072ef9),
    WININET_E_REQUEST_PENDING  = HRESULT(0x80072efa),
}

enum : HRESULT
{
    WININET_E_ITEM_NOT_FOUND     = HRESULT(0x80072efc),
    WININET_E_CANNOT_CONNECT     = HRESULT(0x80072efd),
    WININET_E_CONNECTION_ABORTED = HRESULT(0x80072efe),
    WININET_E_CONNECTION_RESET   = HRESULT(0x80072eff),
}

enum HRESULT WININET_E_INVALID_PROXY_REQUEST = HRESULT(0x80072f01);

enum : HRESULT
{
    WININET_E_HANDLE_EXISTS         = HRESULT(0x80072f04),
    WININET_E_SEC_CERT_DATE_INVALID = HRESULT(0x80072f05),
    WININET_E_SEC_CERT_CN_INVALID   = HRESULT(0x80072f06),
}

enum HRESULT WININET_E_HTTPS_TO_HTTP_ON_REDIR = HRESULT(0x80072f08);
enum HRESULT WININET_E_CHG_POST_IS_NON_SECURE = HRESULT(0x80072f0a);
enum HRESULT WININET_E_CLIENT_AUTH_CERT_NEEDED = HRESULT(0x80072f0c);
enum HRESULT WININET_E_CLIENT_AUTH_NOT_SETUP = HRESULT(0x80072f0e);
enum HRESULT WININET_E_REDIRECT_SCHEME_CHANGE = HRESULT(0x80072f10);

enum : HRESULT
{
    WININET_E_RETRY_DIALOG      = HRESULT(0x80072f12),
    WININET_E_NO_NEW_CONTAINERS = HRESULT(0x80072f13),
}

enum : HRESULT
{
    WININET_E_SEC_CERT_ERRORS     = HRESULT(0x80072f17),
    WININET_E_SEC_CERT_REV_FAILED = HRESULT(0x80072f19),
}

enum HRESULT WININET_E_DOWNLEVEL_SERVER = HRESULT(0x80072f77);

enum : HRESULT
{
    WININET_E_INVALID_HEADER        = HRESULT(0x80072f79),
    WININET_E_INVALID_QUERY_REQUEST = HRESULT(0x80072f7a),
}

enum HRESULT WININET_E_REDIRECT_FAILED = HRESULT(0x80072f7c);
enum HRESULT WININET_E_UNABLE_TO_CACHE_FILE = HRESULT(0x80072f7e);

enum : HRESULT
{
    WININET_E_DISCONNECTED       = HRESULT(0x80072f83),
    WININET_E_SERVER_UNREACHABLE = HRESULT(0x80072f84),
}

enum HRESULT WININET_E_BAD_AUTO_PROXY_SCRIPT = HRESULT(0x80072f86);

enum : HRESULT
{
    WININET_E_SEC_INVALID_CERT = HRESULT(0x80072f89),
    WININET_E_SEC_CERT_REVOKED = HRESULT(0x80072f8a),
}

enum HRESULT WININET_E_NOT_INITIALIZED = HRESULT(0x80072f8c);
enum HRESULT WININET_E_DECODING_FAILED = HRESULT(0x80072f8f);

enum : HRESULT
{
    WININET_E_COOKIE_NEEDS_CONFIRMATION = HRESULT(0x80072f81),
    WININET_E_COOKIE_DECLINED           = HRESULT(0x80072f82),
}

enum : HRESULT
{
    SQLITE_E_ERROR                   = HRESULT(0x87af0001),
    SQLITE_E_INTERNAL                = HRESULT(0x87af0002),
    SQLITE_E_PERM                    = HRESULT(0x87af0003),
    SQLITE_E_ABORT                   = HRESULT(0x87af0004),
    SQLITE_E_BUSY                    = HRESULT(0x87af0005),
    SQLITE_E_LOCKED                  = HRESULT(0x87af0006),
    SQLITE_E_NOMEM                   = HRESULT(0x87af0007),
    SQLITE_E_READONLY                = HRESULT(0x87af0008),
    SQLITE_E_INTERRUPT               = HRESULT(0x87af0009),
    SQLITE_E_IOERR                   = HRESULT(0x87af000a),
    SQLITE_E_CORRUPT                 = HRESULT(0x87af000b),
    SQLITE_E_NOTFOUND                = HRESULT(0x87af000c),
    SQLITE_E_FULL                    = HRESULT(0x87af000d),
    SQLITE_E_CANTOPEN                = HRESULT(0x87af000e),
    SQLITE_E_PROTOCOL                = HRESULT(0x87af000f),
    SQLITE_E_EMPTY                   = HRESULT(0x87af0010),
    SQLITE_E_SCHEMA                  = HRESULT(0x87af0011),
    SQLITE_E_TOOBIG                  = HRESULT(0x87af0012),
    SQLITE_E_CONSTRAINT              = HRESULT(0x87af0013),
    SQLITE_E_MISMATCH                = HRESULT(0x87af0014),
    SQLITE_E_MISUSE                  = HRESULT(0x87af0015),
    SQLITE_E_NOLFS                   = HRESULT(0x87af0016),
    SQLITE_E_AUTH                    = HRESULT(0x87af0017),
    SQLITE_E_FORMAT                  = HRESULT(0x87af0018),
    SQLITE_E_RANGE                   = HRESULT(0x87af0019),
    SQLITE_E_NOTADB                  = HRESULT(0x87af001a),
    SQLITE_E_NOTICE                  = HRESULT(0x87af001b),
    SQLITE_E_WARNING                 = HRESULT(0x87af001c),
    SQLITE_E_ROW                     = HRESULT(0x87af0064),
    SQLITE_E_DONE                    = HRESULT(0x87af0065),
    SQLITE_E_IOERR_READ              = HRESULT(0x87af010a),
    SQLITE_E_IOERR_SHORT_READ        = HRESULT(0x87af020a),
    SQLITE_E_IOERR_WRITE             = HRESULT(0x87af030a),
    SQLITE_E_IOERR_FSYNC             = HRESULT(0x87af040a),
    SQLITE_E_IOERR_DIR_FSYNC         = HRESULT(0x87af050a),
    SQLITE_E_IOERR_TRUNCATE          = HRESULT(0x87af060a),
    SQLITE_E_IOERR_FSTAT             = HRESULT(0x87af070a),
    SQLITE_E_IOERR_UNLOCK            = HRESULT(0x87af080a),
    SQLITE_E_IOERR_RDLOCK            = HRESULT(0x87af090a),
    SQLITE_E_IOERR_DELETE            = HRESULT(0x87af0a0a),
    SQLITE_E_IOERR_BLOCKED           = HRESULT(0x87af0b0a),
    SQLITE_E_IOERR_NOMEM             = HRESULT(0x87af0c0a),
    SQLITE_E_IOERR_ACCESS            = HRESULT(0x87af0d0a),
    SQLITE_E_IOERR_CHECKRESERVEDLOCK = HRESULT(0x87af0e0a),
    SQLITE_E_IOERR_LOCK              = HRESULT(0x87af0f0a),
    SQLITE_E_IOERR_CLOSE             = HRESULT(0x87af100a),
    SQLITE_E_IOERR_DIR_CLOSE         = HRESULT(0x87af110a),
    SQLITE_E_IOERR_SHMOPEN           = HRESULT(0x87af120a),
    SQLITE_E_IOERR_SHMSIZE           = HRESULT(0x87af130a),
    SQLITE_E_IOERR_SHMLOCK           = HRESULT(0x87af140a),
    SQLITE_E_IOERR_SHMMAP            = HRESULT(0x87af150a),
    SQLITE_E_IOERR_SEEK              = HRESULT(0x87af160a),
    SQLITE_E_IOERR_DELETE_NOENT      = HRESULT(0x87af170a),
    SQLITE_E_IOERR_MMAP              = HRESULT(0x87af180a),
    SQLITE_E_IOERR_GETTEMPPATH       = HRESULT(0x87af190a),
    SQLITE_E_IOERR_CONVPATH          = HRESULT(0x87af1a0a),
    SQLITE_E_IOERR_VNODE             = HRESULT(0x87af1b0a),
    SQLITE_E_IOERR_AUTH              = HRESULT(0x87af1c0a),
    SQLITE_E_IOERR_BEGIN_ATOMIC      = HRESULT(0x87af1d0a),
    SQLITE_E_IOERR_COMMIT_ATOMIC     = HRESULT(0x87af1e0a),
    SQLITE_E_IOERR_ROLLBACK_ATOMIC   = HRESULT(0x87af1f0a),
    SQLITE_E_IOERR_DATA              = HRESULT(0x87af200a),
    SQLITE_E_IOERR_CORRUPTFS         = HRESULT(0x87af210a),
    SQLITE_E_IOERR_IN_PAGE           = HRESULT(0x87af220a),
    SQLITE_E_LOCKED_SHAREDCACHE      = HRESULT(0x87af0106),
    SQLITE_E_LOCKED_VTAB             = HRESULT(0x87af0206),
    SQLITE_E_BUSY_RECOVERY           = HRESULT(0x87af0105),
    SQLITE_E_BUSY_SNAPSHOT           = HRESULT(0x87af0205),
    SQLITE_E_BUSY_TIMEOUT            = HRESULT(0x87af0305),
    SQLITE_E_CANTOPEN_NOTEMPDIR      = HRESULT(0x87af010e),
    SQLITE_E_CANTOPEN_ISDIR          = HRESULT(0x87af020e),
    SQLITE_E_CANTOPEN_FULLPATH       = HRESULT(0x87af030e),
    SQLITE_E_CANTOPEN_CONVPATH       = HRESULT(0x87af040e),
    SQLITE_E_CANTOPEN_DIRTYWAL       = HRESULT(0x87af050e),
    SQLITE_E_CANTOPEN_SYMLINK        = HRESULT(0x87af060e),
}

enum : HRESULT
{
    SQLITE_E_CORRUPT_SEQUENCE   = HRESULT(0x87af020b),
    SQLITE_E_CORRUPT_INDEX      = HRESULT(0x87af030b),
    SQLITE_E_READONLY_RECOVERY  = HRESULT(0x87af0108),
    SQLITE_E_READONLY_CANTLOCK  = HRESULT(0x87af0208),
    SQLITE_E_READONLY_ROLLBACK  = HRESULT(0x87af0308),
    SQLITE_E_READONLY_DBMOVED   = HRESULT(0x87af0408),
    SQLITE_E_READONLY_CANTINIT  = HRESULT(0x87af0508),
    SQLITE_E_READONLY_DIRECTORY = HRESULT(0x87af0608),
}

enum : HRESULT
{
    SQLITE_E_CONSTRAINT_CHECK      = HRESULT(0x87af0113),
    SQLITE_E_CONSTRAINT_COMMITHOOK = HRESULT(0x87af0213),
    SQLITE_E_CONSTRAINT_FOREIGNKEY = HRESULT(0x87af0313),
    SQLITE_E_CONSTRAINT_FUNCTION   = HRESULT(0x87af0413),
    SQLITE_E_CONSTRAINT_NOTNULL    = HRESULT(0x87af0513),
    SQLITE_E_CONSTRAINT_PRIMARYKEY = HRESULT(0x87af0613),
    SQLITE_E_CONSTRAINT_TRIGGER    = HRESULT(0x87af0713),
    SQLITE_E_CONSTRAINT_UNIQUE     = HRESULT(0x87af0813),
    SQLITE_E_CONSTRAINT_VTAB       = HRESULT(0x87af0913),
    SQLITE_E_CONSTRAINT_ROWID      = HRESULT(0x87af0a13),
    SQLITE_E_CONSTRAINT_PINNED     = HRESULT(0x87af0b13),
    SQLITE_E_CONSTRAINT_DATATYPE   = HRESULT(0x87af0c13),
}

enum : HRESULT
{
    SQLITE_E_NOTICE_RECOVER_ROLLBACK = HRESULT(0x87af021b),
    SQLITE_E_NOTICE_RECOVER_RBU      = HRESULT(0x87af031b),
}

enum HRESULT SQLITE_E_AUTH_USER = HRESULT(0x87af0117);
enum HRESULT UTC_E_ALTERNATIVE_TRACE_CANNOT_PREEMPT = HRESULT(0x87c51002);
enum HRESULT UTC_E_SCRIPT_TYPE_INVALID = HRESULT(0x87c51004);
enum HRESULT UTC_E_TRACEPROFILE_NOT_FOUND = HRESULT(0x87c51006);
enum HRESULT UTC_E_FORWARDER_ALREADY_DISABLED = HRESULT(0x87c51008);
enum HRESULT UTC_E_DIAGRULES_SCHEMAVERSION_MISMATCH = HRESULT(0x87c5100a);
enum HRESULT UTC_E_INVALID_CUSTOM_FILTER = HRESULT(0x87c5100c);
enum HRESULT UTC_E_REESCALATED_TOO_QUICKLY = HRESULT(0x87c5100e);
enum HRESULT UTC_E_PERFTRACK_ALREADY_TRACING = HRESULT(0x87c51010);
enum HRESULT UTC_E_FORWARDER_PRODUCER_MISMATCH = HRESULT(0x87c51012);
enum HRESULT UTC_E_SQM_INIT_FAILED = HRESULT(0x87c51014);
enum HRESULT UTC_E_TRACERS_DONT_EXIST = HRESULT(0x87c51016);
enum HRESULT UTC_E_SCENARIODEF_SCHEMAVERSION_MISMATCH = HRESULT(0x87c51018);
enum HRESULT UTC_E_EXE_TERMINATED = HRESULT(0x87c5101a);
enum HRESULT UTC_E_SETUP_NOT_AUTHORIZED = HRESULT(0x87c5101c);
enum HRESULT UTC_E_COMMAND_LINE_NOT_AUTHORIZED = HRESULT(0x87c5101e);
enum HRESULT UTC_E_ESCALATION_TIMED_OUT = HRESULT(0x87c51020);

enum : HRESULT
{
    UTC_E_TRIGGER_MISMATCH  = HRESULT(0x87c51022),
    UTC_E_TRIGGER_NOT_FOUND = HRESULT(0x87c51023),
}

enum HRESULT UTC_E_DELAY_TERMINATED = HRESULT(0x87c51025);
enum HRESULT UTC_E_TRACE_BUFFER_LIMIT_EXCEEDED = HRESULT(0x87c51027);

enum : HRESULT
{
    UTC_E_RPC_TIMEOUT     = HRESULT(0x87c51029),
    UTC_E_RPC_WAIT_FAILED = HRESULT(0x87c5102a),
}

enum HRESULT UTC_E_TRACE_MIN_DURATION_REQUIREMENT_NOT_MET = HRESULT(0x87c5102c);
enum HRESULT UTC_E_GETFILE_FILE_PATH_NOT_APPROVED = HRESULT(0x87c5102e);

enum : HRESULT
{
    UTC_E_TIME_TRIGGER_ON_START_INVALID                = HRESULT(0x87c51030),
    UTC_E_TIME_TRIGGER_ONLY_VALID_ON_SINGLE_TRANSITION = HRESULT(0x87c51031),
}

enum HRESULT UTC_E_MULTIPLE_TIME_TRIGGER_ON_SINGLE_STATE = HRESULT(0x87c51033);
enum HRESULT UTC_E_FAILED_TO_RESOLVE_CONTAINER_ID = HRESULT(0x87c51036);
enum HRESULT UTC_E_THROTTLED = HRESULT(0x87c51038);
enum HRESULT UTC_E_SCRIPT_MISSING = HRESULT(0x87c5103a);
enum HRESULT UTC_E_API_NOT_SUPPORTED = HRESULT(0x87c5103c);
enum HRESULT UTC_E_TRY_GET_SCENARIO_TIMEOUT_EXCEEDED = HRESULT(0x87c5103e);
enum HRESULT UTC_E_FAILED_TO_START_NDISCAP = HRESULT(0x87c51040);
enum HRESULT UTC_E_MISSING_AGGREGATE_EVENT_TAG = HRESULT(0x87c51042);
enum HRESULT UTC_E_ACTION_NOT_SUPPORTED_IN_DESTINATION = HRESULT(0x87c51044);

enum : HRESULT
{
    UTC_E_FILTER_INVALID_TYPE            = HRESULT(0x87c51046),
    UTC_E_FILTER_VARIABLE_NOT_FOUND      = HRESULT(0x87c51047),
    UTC_E_FILTER_FUNCTION_RESTRICTED     = HRESULT(0x87c51048),
    UTC_E_FILTER_VERSION_MISMATCH        = HRESULT(0x87c51049),
    UTC_E_FILTER_INVALID_FUNCTION        = HRESULT(0x87c51050),
    UTC_E_FILTER_INVALID_FUNCTION_PARAMS = HRESULT(0x87c51051),
    UTC_E_FILTER_INVALID_COMMAND         = HRESULT(0x87c51052),
    UTC_E_FILTER_ILLEGAL_EVAL            = HRESULT(0x87c51053),
}

enum HRESULT UTC_E_AGENT_DIAGNOSTICS_TOO_LARGE = HRESULT(0x87c51055);
enum HRESULT UTC_E_SCENARIO_HAS_NO_ACTIONS = HRESULT(0x87c51057);
enum HRESULT UTC_E_INSUFFICIENT_SPACE_TO_START_TRACE = HRESULT(0x87c51059);
enum HRESULT UTC_E_GETFILEINFOACTION_FILE_NOT_APPROVED = HRESULT(0x87c5105b);
enum HRESULT UTC_E_TRACE_THROTTLED = HRESULT(0x87c5105d);
enum HRESULT WINML_ERR_INVALID_BINDING = HRESULT(0x88900002);
enum HRESULT WINML_ERR_SIZE_MISMATCH = HRESULT(0x88900004);

enum : HRESULT
{
    ERROR_QUIC_VER_NEG_FAILURE    = HRESULT(0x80410001),
    ERROR_QUIC_USER_CANCELED      = HRESULT(0x80410002),
    ERROR_QUIC_INTERNAL_ERROR     = HRESULT(0x80410003),
    ERROR_QUIC_PROTOCOL_VIOLATION = HRESULT(0x80410004),
}

enum HRESULT ERROR_QUIC_CONNECTION_TIMEOUT = HRESULT(0x80410006);
enum HRESULT ERROR_QUIC_STREAM_LIMIT_REACHED = HRESULT(0x80410008);

enum : HRESULT
{
    ERROR_QUIC_TLS_UNEXPECTED_MESSAGE      = HRESULT(0x8041010a),
    ERROR_QUIC_TLS_BAD_CERTIFICATE         = HRESULT(0x8041012a),
    ERROR_QUIC_TLS_UNSUPPORTED_CERTIFICATE = HRESULT(0x8041012b),
}

enum : HRESULT
{
    ERROR_QUIC_TLS_CERTIFICATE_EXPIRED   = HRESULT(0x8041012d),
    ERROR_QUIC_TLS_CERTIFICATE_UNKNOWN   = HRESULT(0x8041012e),
    ERROR_QUIC_TLS_ILLEGAL_PARAMETER     = HRESULT(0x8041012f),
    ERROR_QUIC_TLS_UNKNOWN_CA            = HRESULT(0x80410130),
    ERROR_QUIC_TLS_ACCESS_DENIED         = HRESULT(0x80410131),
    ERROR_QUIC_TLS_INSUFFICIENT_SECURITY = HRESULT(0x80410147),
    ERROR_QUIC_TLS_INTERNAL_ERROR        = HRESULT(0x80410150),
    ERROR_QUIC_TLS_USER_CANCELED         = HRESULT(0x8041015a),
    ERROR_QUIC_TLS_CERTIFICATE_REQUIRED  = HRESULT(0x80410174),
}

enum HRESULT IORING_E_SUBMISSION_QUEUE_FULL = HRESULT(0x80460002);
enum HRESULT IORING_E_SUBMISSION_QUEUE_TOO_BIG = HRESULT(0x80460004);
enum HRESULT IORING_E_SUBMIT_IN_PROGRESS = HRESULT(0x80460006);
enum HRESULT IORING_E_COMPLETION_QUEUE_TOO_FULL = HRESULT(0x80460008);

enum : HRESULT
{
    UNIONFS_E_CANNOT_EXIT_UNION    = HRESULT(0x89250002),
    UNIONFS_E_CANNOT_PRESERVE_LINK = HRESULT(0x89250003),
}

enum : HRESULT
{
    UNIONFS_E_LAYERS_PRESENT     = HRESULT(0x89250005),
    UNIONFS_E_NESTED_LAYER       = HRESULT(0x89250006),
    UNIONFS_E_UNION_DUPLICATE_ID = HRESULT(0x89250007),
}

enum : HRESULT
{
    UNIONFS_E_TOO_MANY_LAYERS          = HRESULT(0x89250009),
    UNIONFS_E_TOO_LATE                 = HRESULT(0x8925000a),
    UNIONFS_E_NESTED_UNION             = HRESULT(0x8925000b),
    UNIONFS_E_NESTED_UNION_NOT_ALLOWED = HRESULT(0x8925000c),
}

enum HRESULT ERROR_PRM_CONCURRENT_OPERATION = HRESULT(0xc9260202);

enum : HRESULT
{
    ERROR_PRM_MODULE_LOCKED               = HRESULT(0xc9260204),
    ERROR_PRM_UPDATE_INCOMPATIBLE_VERSION = HRESULT(0xc9260205),
    ERROR_PRM_UPDATE_MODULE_MISMATCH      = HRESULT(0xc9260206),
    ERROR_PRM_UPDATE_MODULE_NOT_FOUND     = HRESULT(0xc9260207),
    ERROR_PRM_UPDATE_MISSING_EXPORT       = HRESULT(0xc9260208),
    ERROR_PRM_UPDATE_MODULE_LOCKED        = HRESULT(0xc9260209),
    ERROR_PRM_UPDATE_BAD_SIGNATURE        = HRESULT(0xc926020a),
    ERROR_PRM_UPDATE_VERSION_MISMATCH     = HRESULT(0xc926020b),
}

enum HRESULT ERROR_PRM_INTERFACE_INACCESSIBLE = HRESULT(0xc926020d);
enum HRESULT PPF_E_TRANSFORM_DIGEST_ALGO_NOT_SUPPORTED = HRESULT(0xc9280000);

enum : HRESULT
{
    PPF_E_TRANSFORM_CLEANED_UP_NA           = HRESULT(0xc9280002),
    PPF_E_TRANSFORM_CLEANED_UP_STATE_CHANGE = HRESULT(0xc9280003),
    PPF_E_TRANSFORM_DIGEST_ALGO_NOT_PRESENT = HRESULT(0xc9280004),
}

enum int RPC_X_INVALID_PIPE_OPERATION = 0x00000727;
enum int RPC_X_NO_MEMORY = 0xc0000017;

enum : int
{
    RPC_X_INVALID_TAG    = 0xc0020022,
    RPC_X_INVALID_BUFFER = 0xc0000206,
}

enum : uint
{
    STATUS_SEVERITY_COERROR = 0x00000002,
    STATUS_SEVERITY_COFAIL  = 0x00000003,
}

enum : HRESULT
{
    QUERY_E_FAILED             = HRESULT(0x80041600),
    QUERY_E_INVALIDQUERY       = HRESULT(0x80041601),
    QUERY_E_INVALIDRESTRICTION = HRESULT(0x80041602),
    QUERY_E_INVALIDSORT        = HRESULT(0x80041603),
    QUERY_E_INVALIDCATEGORIZE  = HRESULT(0x80041604),
}

enum : HRESULT
{
    QUERY_E_TOOCOMPLEX              = HRESULT(0x80041606),
    QUERY_E_TIMEDOUT                = HRESULT(0x80041607),
    QUERY_E_DUPLICATE_OUTPUT_COLUMN = HRESULT(0x80041608),
}

enum HRESULT QUERY_E_INVALID_DIRECTORY = HRESULT(0x8004160a);
enum HRESULT QUERY_S_NO_QUERY = HRESULT(0x8004160c);

enum : HRESULT
{
    QPLIST_E_READ_ERROR     = HRESULT(0x80041652),
    QPLIST_E_EXPECTING_NAME = HRESULT(0x80041653),
    QPLIST_E_EXPECTING_TYPE = HRESULT(0x80041654),
}

enum : HRESULT
{
    QPLIST_E_EXPECTING_INTEGER     = HRESULT(0x80041656),
    QPLIST_E_EXPECTING_CLOSE_PAREN = HRESULT(0x80041657),
    QPLIST_E_EXPECTING_GUID        = HRESULT(0x80041658),
}

enum HRESULT QPLIST_E_EXPECTING_PROP_SPEC = HRESULT(0x8004165a);

enum : HRESULT
{
    QPLIST_E_DUPLICATE              = HRESULT(0x8004165c),
    QPLIST_E_VECTORBYREF_USED_ALONE = HRESULT(0x8004165d),
}

enum HRESULT QPARSE_E_UNEXPECTED_NOT = HRESULT(0x80041660);

enum : HRESULT
{
    QPARSE_E_EXPECTING_REAL     = HRESULT(0x80041662),
    QPARSE_E_EXPECTING_DATE     = HRESULT(0x80041663),
    QPARSE_E_EXPECTING_CURRENCY = HRESULT(0x80041664),
    QPARSE_E_EXPECTING_GUID     = HRESULT(0x80041665),
    QPARSE_E_EXPECTING_BRACE    = HRESULT(0x80041666),
    QPARSE_E_EXPECTING_PAREN    = HRESULT(0x80041667),
    QPARSE_E_EXPECTING_PROPERTY = HRESULT(0x80041668),
}

enum HRESULT QPARSE_E_EXPECTING_PHRASE = HRESULT(0x8004166a);

enum : HRESULT
{
    QPARSE_E_EXPECTING_REGEX          = HRESULT(0x8004166c),
    QPARSE_E_EXPECTING_REGEX_PROPERTY = HRESULT(0x8004166d),
}

enum HRESULT QPARSE_E_NO_SUCH_PROPERTY = HRESULT(0x8004166f);
enum HRESULT QPARSE_E_EXPECTING_COMMA = HRESULT(0x80041671);
enum HRESULT QPARSE_E_WEIGHT_OUT_OF_RANGE = HRESULT(0x80041673);
enum HRESULT QPARSE_E_INVALID_SORT_ORDER = HRESULT(0x80041675);
enum HRESULT QPARSE_E_INVALID_GROUPING = HRESULT(0x80041677);
enum HRESULT QPLIST_S_DUPLICATE = HRESULT(0x00041679);
enum HRESULT QPARSE_E_INVALID_RANKMETHOD = HRESULT(0x8004167b);

enum : HRESULT
{
    FDAEMON_E_LOWRESOURCE      = HRESULT(0x80041681),
    FDAEMON_E_FATALERROR       = HRESULT(0x80041682),
    FDAEMON_E_PARTITIONDELETED = HRESULT(0x80041683),
}

enum HRESULT FDAEMON_W_EMPTYWORDLIST = HRESULT(0x00041685);

enum : HRESULT
{
    FDAEMON_E_NOWORDLIST            = HRESULT(0x80041687),
    FDAEMON_E_TOOMANYFILTEREDBLOCKS = HRESULT(0x80041688),
}

enum : HRESULT
{
    SEARCH_E_NOMONIKER = HRESULT(0x800416a1),
    SEARCH_E_NOREGION  = HRESULT(0x800416a2),
}

enum HRESULT FILTER_S_PARTIAL_CONTENTSCAN_IMMEDIATE = HRESULT(0x00041731);
enum HRESULT FILTER_S_CONTENTSCAN_DELAYED = HRESULT(0x00041733);
enum HRESULT FILTER_S_DISK_FULL = HRESULT(0x00041735);

enum : HRESULT
{
    FILTER_E_UNREACHABLE = HRESULT(0x80041737),
    FILTER_E_IN_USE      = HRESULT(0x80041738),
    FILTER_E_NOT_OPEN    = HRESULT(0x80041739),
    FILTER_S_NO_PROPSETS = HRESULT(0x0004173a),
}

enum HRESULT FILTER_S_NO_SECURITY_DESCRIPTOR = HRESULT(0x0004173c);
enum HRESULT FILTER_E_PARTIALLY_FILTERED = HRESULT(0x8004173e);
enum HRESULT LANGUAGE_S_LARGE_WORD = HRESULT(0x00041781);
enum HRESULT WBREAK_E_BUFFER_TOO_SMALL = HRESULT(0x80041783);
enum HRESULT WBREAK_E_INIT_FAILED = HRESULT(0x80041785);

enum : HRESULT
{
    PSINK_E_INDEX_ONLY       = HRESULT(0x80041791),
    PSINK_E_LARGE_ATTACHMENT = HRESULT(0x80041792),
}

enum : HRESULT
{
    CI_CORRUPT_DATABASE = HRESULT(0xc0041800),
    CI_CORRUPT_CATALOG  = HRESULT(0xc0041801),
}

enum HRESULT CI_INVALID_PRIORITY = HRESULT(0xc0041803);
enum HRESULT CI_OUT_OF_INDEX_IDS = HRESULT(0xc0041805);
enum HRESULT CI_CORRUPT_FILTER_BUFFER = HRESULT(0xc0041807);
enum HRESULT CI_PROPSTORE_INCONSISTENCY = HRESULT(0xc0041809);
enum HRESULT CI_E_NOT_INITIALIZED = HRESULT(0x8004180b);
enum HRESULT CI_E_PROPERTY_NOT_CACHED = HRESULT(0x8004180d);
enum HRESULT CI_E_INVALID_STATE = HRESULT(0x8004180f);
enum HRESULT CI_E_DISK_FULL = HRESULT(0x80041811);
enum HRESULT CI_E_WORKID_NOTVALID = HRESULT(0x80041813);
enum HRESULT CI_E_NOT_FOUND = HRESULT(0x80041815);
enum HRESULT CI_E_DUPLICATE_NOTIFICATION = HRESULT(0x80041817);
enum HRESULT CI_E_INVALID_FLAGS_COMBINATION = HRESULT(0x80041819);
enum HRESULT CI_E_SHARING_VIOLATION = HRESULT(0x8004181b);
enum HRESULT CI_E_NO_CATALOG = HRESULT(0x8004181d);

enum : HRESULT
{
    CI_E_TIMEOUT     = HRESULT(0x8004181f),
    CI_E_NOT_RUNNING = HRESULT(0x80041820),
}

enum HRESULT CI_E_ENUMERATION_STARTED = HRESULT(0xc0041822);
enum HRESULT CI_E_CLIENT_FILTER_ABORT = HRESULT(0xc0041824);
enum HRESULT CI_S_CAT_STOPPED = HRESULT(0x00041826);
enum HRESULT CI_E_CONFIG_DISK_FULL = HRESULT(0x80041828);
enum uint ROUTEBASE = 0x00000384;
enum uint ERROR_ROUTER_STOPPED = 0x00000384;
enum uint ERROR_UNKNOWN_PROTOCOL_ID = 0x00000386;
enum uint ERROR_INTERFACE_ALREADY_EXISTS = 0x00000388;
enum uint ERROR_INTERFACE_NOT_CONNECTED = 0x0000038a;
enum uint ERROR_INTERFACE_CONNECTED = 0x0000038c;
enum uint ERROR_ALREADY_CONNECTING = 0x0000038e;
enum uint ERROR_INTERFACE_CONFIGURATION = 0x00000390;
enum uint ERROR_NOT_ROUTER_PORT = 0x00000392;
enum uint ERROR_INTERFACE_DISABLED = 0x00000394;
enum uint ERROR_NO_AUTH_PROTOCOL_AVAILABLE = 0x00000396;
enum uint ERROR_REMOTE_NO_DIALIN_PERMISSION = 0x00000398;

enum : uint
{
    ERROR_REMOTE_ACCT_DISABLED          = 0x0000039a,
    ERROR_REMOTE_RESTRICTED_LOGON_HOURS = 0x0000039b,
}

enum uint ERROR_INTERFACE_HAS_NO_DEVICES = 0x0000039d;
enum uint ERROR_INTERFACE_UNREACHABLE = 0x0000039f;
enum uint ERROR_INTERFACE_DISCONNECTED = 0x000003a1;
enum uint ERROR_PORT_LIMIT_REACHED = 0x000003a3;
enum uint ERROR_MAX_LAN_INTERFACE_LIMIT = 0x000003a5;
enum uint ERROR_MAX_CLIENT_INTERFACE_LIMIT = 0x000003a7;
enum uint ERROR_USER_LIMIT = 0x000003a9;
enum uint ERROR_INVALID_RADIUS_RESPONSE = 0x000003ab;
enum uint ERROR_ALLOWED_PORT_TYPE_RESTRICTION = 0x000003ad;
enum uint ERROR_BAP_REQUIRED = 0x000003af;
enum uint ERROR_ROUTER_CONFIG_INCOMPATIBLE = 0x000003b1;
enum uint ERROR_PROTOCOL_ALREADY_INSTALLED = 0x000003b4;
enum uint ERROR_INVALID_SIGNATURE = 0x000003b6;

enum : uint
{
    ERROR_INVALID_PACKET_LENGTH_OR_ID = 0x000003b8,
    ERROR_INVALID_ATTRIBUTE_LENGTH    = 0x000003b9,
    ERROR_INVALID_PACKET              = 0x000003ba,
}

enum uint ERROR_REMOTEACCESS_NOT_CONFIGURED = 0x000003bc;

enum : uint
{
    _WIN32_MAXVER         = 0x00000a00,
    _WIN32_WINDOWS_MAXVER = 0x00000a00,
}

enum : uint
{
    _WIN32_IE_MAXVER    = 0x00000a00,
    _WIN32_WINNT_MAXVER = 0x00000a00,
}

// Callbacks

alias FARPROC = ptrdiff_t function();
alias NEARPROC = ptrdiff_t function();
alias PROC = ptrdiff_t function();
alias PAPCFUNC = void function(size_t Parameter);

// Structs


@RAIIFree!SysFreeString
struct BSTR
{
    wchar* Value;
}

@RAIIFree!CloseHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HANDLE
{
    void* Value;
}

struct BOOL
{
    int Value;
}

struct BOOLEAN
{
    ubyte Value;
}

struct VARIANT_BOOL
{
    short Value;
}

@RAIIFree!FreeLibrary
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HINSTANCE))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HMODULE
{
    void* Value;
}

@RAIIFree!FreeLibrary
//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HMODULE))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HINSTANCE
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/hresult))], [])
struct HRESULT
{
    int Value;
}

//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(HANDLE))], [])
struct HWND
{
    void* Value;
}

struct LPARAM
{
    ptrdiff_t Value;
}

struct LRESULT
{
    ptrdiff_t Value;
}

struct NTSTATUS
{
    int Value;
}

struct PSTR
{
    ubyte* Value;
}

struct PWSTR
{
    wchar* Value;
}

struct WPARAM
{
    size_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/gdi/colorref))], [])
struct COLORREF
{
    uint Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HRSRC
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HTASK
{
    void* Value;
}

@RAIIFree!LocalFree
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HLOCAL
{
    void* Value;
}

@RAIIFree!GlobalFree
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HGLOBAL
{
    void* Value;
}

struct CHAR
{
    byte Value;
}

struct SHANDLE_PTR
{
    ptrdiff_t Value;
}

struct HANDLE_PTR
{
    size_t Value;
}

struct HSPRITE
{
    void* Value;
}

struct HSTR
{
    void* Value;
}

struct HUMPD
{
    void* Value;
}

struct HLSURF
{
    void* Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-systemtime))], [])
struct SYSTEMTIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDayOfWeek;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ns-wtypes-decimal~r1))], [])
struct DECIMAL
{
    ushort wReserved;
union Anonymous1
    {
struct Anonymous
        {
            ubyte scale;
            ubyte sign;
        }
        ushort signscale;
    }
    uint   Hi32;
union Anonymous2
    {
struct Anonymous
        {
            uint Lo32;
            uint Mid32;
        }
        ulong Lo64;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wtypes/ns-wtypes-propertykey))], [])
struct PROPERTYKEY
{
    GUID fmtid;
    uint pid;
}

//STRUCT ATTR: AlsoUsableForAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PROPERTYKEY))], [])
struct DEVPROPKEY
{
    GUID fmtid;
    uint pid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/office/client-developer/outlook/mapi/filetime))], [])
struct FILETIME
{
    uint dwLowDateTime;
    uint dwHighDateTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windef/ns-windef-rect))], [])
struct RECT
{
    int left;
    int top;
    int right;
    int bottom;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windef/ns-windef-rectl))], [])
struct RECTL
{
    int left;
    int top;
    int right;
    int bottom;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windef/ns-windef-point))], [])
struct POINT
{
    int x;
    int y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windef/ns-windef-pointl))], [])
struct POINTL
{
    int x;
    int y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windef/ns-windef-size))], [])
struct SIZE
{
    int cx;
    int cy;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/windef/ns-windef-points))], [])
struct POINTS
{
    short x;
    short y;
}

struct APP_LOCAL_DEVICE_ID
{
    ubyte[32] value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/subauth/ns-subauth-unicode_string))], [])
struct UNICODE_STRING
{
    ushort Length;
    ushort MaximumLength;
    /*FIELD ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR Buffer;
}

struct FLOAT128
{
    long LowPart;
    long HighPart;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntdef/ns-ntdef-luid))], [])
struct LUID
{
    uint LowPart;
    int  HighPart;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysallocstring))], [])
@DllImport("OLEAUT32.dll")
BSTR SysAllocString(const(PWSTR) psz);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysreallocstring))], [])
@DllImport("OLEAUT32.dll")
int SysReAllocString(BSTR* pbstr, const(PWSTR) psz);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysallocstringlen))], [])
@DllImport("OLEAUT32.dll")
BSTR SysAllocStringLen(const(PWSTR) strIn, uint ui);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysreallocstringlen))], [])
@DllImport("OLEAUT32.dll")
int SysReAllocStringLen(BSTR* pbstr, const(PWSTR) psz, uint len);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysaddrefstring))], [])
@DllImport("OLEAUT32.dll")
HRESULT SysAddRefString(BSTR bstrString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysreleasestring))], [])
@DllImport("OLEAUT32.dll")
void SysReleaseString(BSTR bstrString);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysfreestring))], [])
@DllImport("OLEAUT32.dll")
void SysFreeString(BSTR bstrString);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysstringlen))], [])
@DllImport("OLEAUT32.dll")
uint SysStringLen(BSTR pbstr);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysstringbytelen))], [])
@DllImport("OLEAUT32.dll")
uint SysStringByteLen(BSTR bstr);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/oleauto/nf-oleauto-sysallocstringbytelen))], [])
@DllImport("OLEAUT32.dll")
BSTR SysAllocStringByteLen(const(PSTR) psz, uint len);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/handleapi/nf-handleapi-closehandle))], [])
@DllImport("KERNEL32.dll")
BOOL CloseHandle(HANDLE hObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/handleapi/nf-handleapi-duplicatehandle))], [])
@DllImport("KERNEL32.dll")
BOOL DuplicateHandle(HANDLE hSourceProcessHandle, HANDLE hSourceHandle, HANDLE hTargetProcessHandle, 
                     HANDLE* lpTargetHandle, uint dwDesiredAccess, BOOL bInheritHandle, 
                     DUPLICATE_HANDLE_OPTIONS dwOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/handleapi/nf-handleapi-compareobjecthandles))], [])
@DllImport("api-ms-win-core-handle-l1-1-0.dll")
BOOL CompareObjectHandles(HANDLE hFirstObjectHandle, HANDLE hSecondObjectHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/handleapi/nf-handleapi-gethandleinformation))], [])
@DllImport("KERNEL32.dll")
BOOL GetHandleInformation(HANDLE hObject, uint* lpdwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/handleapi/nf-handleapi-sethandleinformation))], [])
@DllImport("KERNEL32.dll")
BOOL SetHandleInformation(HANDLE hObject, uint dwMask, HANDLE_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/libloaderapi/nf-libloaderapi-freelibrary))], [])
@DllImport("KERNEL32.dll")
BOOL FreeLibrary(HMODULE hLibModule);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror))], [])
@DllImport("KERNEL32.dll")
WIN32_ERROR GetLastError();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/errhandlingapi/nf-errhandlingapi-setlasterror))], [])
@DllImport("KERNEL32.dll")
void SetLastError(WIN32_ERROR dwErrCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winuser/nf-winuser-setlasterrorex))], [])
@DllImport("USER32.dll")
void SetLastErrorEx(WIN32_ERROR dwErrCode, uint dwType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-globalfree))], [])
@DllImport("KERNEL32.dll")
HGLOBAL GlobalFree(HGLOBAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: CanReturnErrorsAsSuccessAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-localfree))], [])
@DllImport("KERNEL32.dll")
HLOCAL LocalFree(HLOCAL hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winternl/nf-winternl-rtlntstatustodoserror))], [])
@DllImport("ntdll.dll")
uint RtlNtStatusToDosError(NTSTATUS Status);


