// Written in the D programming language.

module windows.win32.system.kernel;

public import windows.core;
public import windows.win32.foundation : PSTR;
public import windows.win32.networking.winsock : DL_EUI48, IN_ADDR;
public import windows.win32.system.diagnostics.debug_ : CONTEXT, EXCEPTION_RECORD;

extern(Windows) @nogc nothrow:


// Enums


alias EXCEPTION_DISPOSITION = int;
enum : int
{
    ExceptionContinueExecution = 0x00000000,
    ExceptionContinueSearch    = 0x00000001,
    ExceptionNestedException   = 0x00000002,
    ExceptionCollidedUnwind    = 0x00000003,
}

alias EVENT_TYPE = int;
enum : int
{
    NotificationEvent    = 0x00000000,
    SynchronizationEvent = 0x00000001,
}

alias TIMER_TYPE = int;
enum : int
{
    NotificationTimer    = 0x00000000,
    SynchronizationTimer = 0x00000001,
}

alias WAIT_TYPE = int;
enum : int
{
    WaitAll          = 0x00000000,
    WaitAny          = 0x00000001,
    WaitNotification = 0x00000002,
    WaitDequeue      = 0x00000003,
    WaitDpc          = 0x00000004,
}

alias NT_PRODUCT_TYPE = int;
enum : int
{
    NtProductWinNt    = 0x00000001,
    NtProductLanManNt = 0x00000002,
    NtProductServer   = 0x00000003,
}

alias SUITE_TYPE = int;
enum : int
{
    SmallBusiness           = 0x00000000,
    Enterprise              = 0x00000001,
    BackOffice              = 0x00000002,
    CommunicationServer     = 0x00000003,
    TerminalServer          = 0x00000004,
    SmallBusinessRestricted = 0x00000005,
    EmbeddedNT              = 0x00000006,
    DataCenter              = 0x00000007,
    SingleUserTS            = 0x00000008,
    Personal                = 0x00000009,
    Blade                   = 0x0000000a,
    EmbeddedRestricted      = 0x0000000b,
    SecurityAppliance       = 0x0000000c,
    StorageServer           = 0x0000000d,
    ComputeServer           = 0x0000000e,
    WHServer                = 0x0000000f,
    PhoneNT                 = 0x00000010,
    MultiUserTS             = 0x00000011,
    MaxSuiteType            = 0x00000012,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-compartment_id))], [])

alias COMPARTMENT_ID = int;
enum : int
{
    UNSPECIFIED_COMPARTMENT_ID = 0x00000000,
    DEFAULT_COMPARTMENT_ID     = 0x00000001,
}

// Constants


enum int OBJ_HANDLE_TAGBITS = 0x00000003;
enum uint NULL64 = 0x00000000;

enum : uint
{
    MAXUSHORT = 0x0000ffff,
    MAXULONG  = 0xffffffff,
}

// Callbacks

alias EXCEPTION_ROUTINE = EXCEPTION_DISPOSITION function(EXCEPTION_RECORD* ExceptionRecord, void* EstablisherFrame, 
                                                         CONTEXT* ContextRecord, void* DispatcherContext);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-slist_entry))], [])
struct SLIST_ENTRY
{
    SLIST_ENTRY* Next;
}

version (X86) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 4)))], [])
union SLIST_HEADER
{
struct Anonymous
    {
        SINGLE_LIST_ENTRY Next;
        ushort            Depth;
        ushort            CpuId;
    }
struct HeaderArm64
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Sequence)), FixedArgSig(ElementSig(16)), FixedArgSig(ElementSig(48))], [])*/ulong _bitfield1;
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(NextEntry)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(60))], [])*/ulong _bitfield2;
    }
}
}

struct QUAD
{
union Anonymous
    {
        long   UseThisFieldToCopy;
        double DoNotUseThisField;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_number))], [])
struct PROCESSOR_NUMBER
{
    ushort Group;
    ubyte  Number;
    ubyte  Reserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntdef/ns-ntdef-string))], [])
struct STRING
{
    ushort Length;
    ushort MaximumLength;
    /*FIELD ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Buffer;
}

struct CSTRING
{
    ushort      Length;
    ushort      MaximumLength;
    const(PSTR) Buffer;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntdef/ns-ntdef-list_entry))], [])
struct LIST_ENTRY
{
    LIST_ENTRY* Flink;
    LIST_ENTRY* Blink;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ntdef/ns-ntdef-single_list_entry))], [])
struct SINGLE_LIST_ENTRY
{
    SINGLE_LIST_ENTRY* Next;
}

struct RTL_BALANCED_NODE
{
union Anonymous1
    {
        RTL_BALANCED_NODE[2]* Children;
struct Anonymous
        {
        align (1):
            ushort   Flags;
            ushort   MappedPort;
            IN_ADDR  MappedAddress;
            IN_ADDR  LocalAddress;
            uint     InterfaceIndex;
            ushort   LocalPort;
            DL_EUI48 DlDestination;
        }
    }
union Anonymous2
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Balance)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(2))], [])*/ubyte _bitfield147;
        size_t ParentValue;
    }
}

struct LIST_ENTRY32
{
    uint Flink;
    uint Blink;
}

struct LIST_ENTRY64
{
    ulong Flink;
    ulong Blink;
}

struct SINGLE_LIST_ENTRY32
{
    uint Next;
}

struct WNF_STATE_NAME
{
    uint[2] Data;
}

struct STRING32
{
    ushort Length;
    ushort MaximumLength;
    uint   Buffer;
}

struct STRING64
{
    ushort Length;
    ushort MaximumLength;
    ulong  Buffer;
}

struct OBJECTID
{
    GUID Lineage;
    uint Uniquifier;
}

version (ARM64) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 2)))], [])
union SLIST_HEADER
{
struct Anonymous
    {
        SINGLE_LIST_ENTRY Next;
        ushort            Depth;
        ushort            CpuId;
    }
struct HeaderX64
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Sequence)), FixedArgSig(ElementSig(16)), FixedArgSig(ElementSig(48))], [])*/ulong _bitfield1;
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(NextEntry)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(60))], [])*/ulong _bitfield2;
    }
}
}

version (X86) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct FLOATING_SAVE_AREA
{
    uint      ControlWord;
    uint      StatusWord;
    uint      TagWord;
    uint      ErrorOffset;
    uint      ErrorSelector;
    uint      DataOffset;
    uint      DataSelector;
    ubyte[80] RegisterArea;
    uint      Cr0NpxState;
}
}

version (X86_64) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct FLOATING_SAVE_AREA
{
    uint      ControlWord;
    uint      StatusWord;
    uint      TagWord;
    uint      ErrorOffset;
    uint      ErrorSelector;
    uint      DataOffset;
    uint      DataSelector;
    ubyte[80] RegisterArea;
    uint      Spare0;
}
}

struct EXCEPTION_REGISTRATION_RECORD
{
    EXCEPTION_REGISTRATION_RECORD* Next;
    EXCEPTION_ROUTINE Handler;
}

struct NT_TIB
{
    EXCEPTION_REGISTRATION_RECORD* ExceptionList;
    void*   StackBase;
    void*   StackLimit;
    void*   SubSystemTib;
union Anonymous
    {
        void* FiberData;
        uint  Version;
    }
    void*   ArbitraryUserPointer;
    NT_TIB* Self;
}

version (X86_64) {
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
union SLIST_HEADER
{
    ulong Alignment;
struct Anonymous
    {
        SINGLE_LIST_ENTRY Next;
        ushort            Depth;
        ushort            CpuId;
    }
}
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlinitializeslisthead))], [])
@DllImport("ntdll.dll")
void RtlInitializeSListHead(SLIST_HEADER* ListHead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlfirstentryslist))], [])
@DllImport("ntdll.dll")
SLIST_ENTRY* RtlFirstEntrySList(const(SLIST_HEADER)* ListHead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlinterlockedpopentryslist))], [])
@DllImport("ntdll.dll")
SLIST_ENTRY* RtlInterlockedPopEntrySList(SLIST_HEADER* ListHead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlinterlockedpushentryslist))], [])
@DllImport("ntdll.dll")
SLIST_ENTRY* RtlInterlockedPushEntrySList(SLIST_HEADER* ListHead, SLIST_ENTRY* ListEntry);

@DllImport("ntdll.dll")
SLIST_ENTRY* RtlInterlockedPushListSListEx(SLIST_HEADER* ListHead, SLIST_ENTRY* List, SLIST_ENTRY* ListEnd, 
                                           uint Count);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlinterlockedflushslist))], [])
@DllImport("ntdll.dll")
SLIST_ENTRY* RtlInterlockedFlushSList(SLIST_HEADER* ListHead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlquerydepthslist))], [])
@DllImport("ntdll.dll")
ushort RtlQueryDepthSList(SLIST_HEADER* ListHead);


