// Written in the D programming language.

module windows.win32.networkmanagement.ndis;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, CHAR, HANDLE;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_oper_status))], [])

alias NET_IF_OPER_STATUS = int;
enum : int
{
    NET_IF_OPER_STATUS_UP               = 0x00000001,
    NET_IF_OPER_STATUS_DOWN             = 0x00000002,
    NET_IF_OPER_STATUS_TESTING          = 0x00000003,
    NET_IF_OPER_STATUS_UNKNOWN          = 0x00000004,
    NET_IF_OPER_STATUS_DORMANT          = 0x00000005,
    NET_IF_OPER_STATUS_NOT_PRESENT      = 0x00000006,
    NET_IF_OPER_STATUS_LOWER_LAYER_DOWN = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_admin_status))], [])

alias NET_IF_ADMIN_STATUS = int;
enum : int
{
    NET_IF_ADMIN_STATUS_UP      = 0x00000001,
    NET_IF_ADMIN_STATUS_DOWN    = 0x00000002,
    NET_IF_ADMIN_STATUS_TESTING = 0x00000003,
}

alias NET_IF_RCV_ADDRESS_TYPE = int;
enum : int
{
    NET_IF_RCV_ADDRESS_TYPE_OTHER        = 0x00000001,
    NET_IF_RCV_ADDRESS_TYPE_VOLATILE     = 0x00000002,
    NET_IF_RCV_ADDRESS_TYPE_NON_VOLATILE = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_connection_type))], [])

alias NET_IF_CONNECTION_TYPE = int;
enum : int
{
    NET_IF_CONNECTION_DEDICATED = 0x00000001,
    NET_IF_CONNECTION_PASSIVE   = 0x00000002,
    NET_IF_CONNECTION_DEMAND    = 0x00000003,
    NET_IF_CONNECTION_MAXIMUM   = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-tunnel_type))], [])

alias TUNNEL_TYPE = int;
enum : int
{
    TUNNEL_TYPE_NONE    = 0x00000000,
    TUNNEL_TYPE_OTHER   = 0x00000001,
    TUNNEL_TYPE_DIRECT  = 0x00000002,
    TUNNEL_TYPE_6TO4    = 0x0000000b,
    TUNNEL_TYPE_ISATAP  = 0x0000000d,
    TUNNEL_TYPE_TEREDO  = 0x0000000e,
    TUNNEL_TYPE_IPHTTPS = 0x0000000f,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_access_type))], [])

alias NET_IF_ACCESS_TYPE = int;
enum : int
{
    NET_IF_ACCESS_LOOPBACK             = 0x00000001,
    NET_IF_ACCESS_BROADCAST            = 0x00000002,
    NET_IF_ACCESS_POINT_TO_POINT       = 0x00000003,
    NET_IF_ACCESS_POINT_TO_MULTI_POINT = 0x00000004,
    NET_IF_ACCESS_MAXIMUM              = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_direction_type))], [])

alias NET_IF_DIRECTION_TYPE = int;
enum : int
{
    NET_IF_DIRECTION_SENDRECEIVE = 0x00000000,
    NET_IF_DIRECTION_SENDONLY    = 0x00000001,
    NET_IF_DIRECTION_RECEIVEONLY = 0x00000002,
    NET_IF_DIRECTION_MAXIMUM     = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_media_connect_state))], [])

alias NET_IF_MEDIA_CONNECT_STATE = int;
enum : int
{
    MediaConnectStateUnknown      = 0x00000000,
    MediaConnectStateConnected    = 0x00000001,
    MediaConnectStateDisconnected = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_media_duplex_state))], [])

alias NET_IF_MEDIA_DUPLEX_STATE = int;
enum : int
{
    MediaDuplexStateUnknown = 0x00000000,
    MediaDuplexStateHalf    = 0x00000001,
    MediaDuplexStateFull    = 0x00000002,
}

alias IF_ADMINISTRATIVE_STATE = int;
enum : int
{
    IF_ADMINISTRATIVE_DISABLED   = 0x00000000,
    IF_ADMINISTRATIVE_ENABLED    = 0x00000001,
    IF_ADMINISTRATIVE_DEMANDDIAL = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-if_oper_status))], [])

alias IF_OPER_STATUS = int;
enum : int
{
    IfOperStatusUp             = 0x00000001,
    IfOperStatusDown           = 0x00000002,
    IfOperStatusTesting        = 0x00000003,
    IfOperStatusUnknown        = 0x00000004,
    IfOperStatusDormant        = 0x00000005,
    IfOperStatusNotPresent     = 0x00000006,
    IfOperStatusLowerLayerDown = 0x00000007,
}

alias NDIS_REQUEST_TYPE = int;
enum : int
{
    NdisRequestQueryInformation = 0x00000000,
    NdisRequestSetInformation   = 0x00000001,
    NdisRequestQueryStatistics  = 0x00000002,
    NdisRequestOpen             = 0x00000003,
    NdisRequestClose            = 0x00000004,
    NdisRequestSend             = 0x00000005,
    NdisRequestTransferData     = 0x00000006,
    NdisRequestReset            = 0x00000007,
    NdisRequestGeneric1         = 0x00000008,
    NdisRequestGeneric2         = 0x00000009,
    NdisRequestGeneric3         = 0x0000000a,
    NdisRequestGeneric4         = 0x0000000b,
}

alias NDIS_INTERRUPT_MODERATION = int;
enum : int
{
    NdisInterruptModerationUnknown      = 0x00000000,
    NdisInterruptModerationNotSupported = 0x00000001,
    NdisInterruptModerationEnabled      = 0x00000002,
    NdisInterruptModerationDisabled     = 0x00000003,
}

alias NDIS_802_11_STATUS_TYPE = int;
enum : int
{
    Ndis802_11StatusType_Authentication      = 0x00000000,
    Ndis802_11StatusType_MediaStreamMode     = 0x00000001,
    Ndis802_11StatusType_PMKID_CandidateList = 0x00000002,
    Ndis802_11StatusTypeMax                  = 0x00000003,
}

alias NDIS_802_11_NETWORK_TYPE = int;
enum : int
{
    Ndis802_11FH             = 0x00000000,
    Ndis802_11DS             = 0x00000001,
    Ndis802_11OFDM5          = 0x00000002,
    Ndis802_11OFDM24         = 0x00000003,
    Ndis802_11Automode       = 0x00000004,
    Ndis802_11NetworkTypeMax = 0x00000005,
}

alias NDIS_802_11_POWER_MODE = int;
enum : int
{
    Ndis802_11PowerModeCAM      = 0x00000000,
    Ndis802_11PowerModeMAX_PSP  = 0x00000001,
    Ndis802_11PowerModeFast_PSP = 0x00000002,
    Ndis802_11PowerModeMax      = 0x00000003,
}

alias NDIS_802_11_NETWORK_INFRASTRUCTURE = int;
enum : int
{
    Ndis802_11IBSS              = 0x00000000,
    Ndis802_11Infrastructure    = 0x00000001,
    Ndis802_11AutoUnknown       = 0x00000002,
    Ndis802_11InfrastructureMax = 0x00000003,
}

alias NDIS_802_11_AUTHENTICATION_MODE = int;
enum : int
{
    Ndis802_11AuthModeOpen       = 0x00000000,
    Ndis802_11AuthModeShared     = 0x00000001,
    Ndis802_11AuthModeAutoSwitch = 0x00000002,
    Ndis802_11AuthModeWPA        = 0x00000003,
    Ndis802_11AuthModeWPAPSK     = 0x00000004,
    Ndis802_11AuthModeWPANone    = 0x00000005,
    Ndis802_11AuthModeWPA2       = 0x00000006,
    Ndis802_11AuthModeWPA2PSK    = 0x00000007,
    Ndis802_11AuthModeWPA3       = 0x00000008,
    Ndis802_11AuthModeWPA3Ent192 = 0x00000008,
    Ndis802_11AuthModeWPA3SAE    = 0x00000009,
    Ndis802_11AuthModeWPA3Ent    = 0x0000000a,
    Ndis802_11AuthModeMax        = 0x0000000b,
}

alias NDIS_802_11_PRIVACY_FILTER = int;
enum : int
{
    Ndis802_11PrivFilterAcceptAll = 0x00000000,
    Ndis802_11PrivFilter8021xWEP  = 0x00000001,
}

alias NDIS_802_11_WEP_STATUS = int;
enum : int
{
    Ndis802_11WEPEnabled             = 0x00000000,
    Ndis802_11Encryption1Enabled     = 0x00000000,
    Ndis802_11WEPDisabled            = 0x00000001,
    Ndis802_11EncryptionDisabled     = 0x00000001,
    Ndis802_11WEPKeyAbsent           = 0x00000002,
    Ndis802_11Encryption1KeyAbsent   = 0x00000002,
    Ndis802_11WEPNotSupported        = 0x00000003,
    Ndis802_11EncryptionNotSupported = 0x00000003,
    Ndis802_11Encryption2Enabled     = 0x00000004,
    Ndis802_11Encryption2KeyAbsent   = 0x00000005,
    Ndis802_11Encryption3Enabled     = 0x00000006,
    Ndis802_11Encryption3KeyAbsent   = 0x00000007,
}

alias NDIS_802_11_RELOAD_DEFAULTS = int;
enum : int
{
    Ndis802_11ReloadWEPKeys = 0x00000000,
}

alias NDIS_802_11_MEDIA_STREAM_MODE = int;
enum : int
{
    Ndis802_11MediaStreamOff = 0x00000000,
    Ndis802_11MediaStreamOn  = 0x00000001,
}

alias NDIS_802_11_RADIO_STATUS = int;
enum : int
{
    Ndis802_11RadioStatusOn                  = 0x00000000,
    Ndis802_11RadioStatusHardwareOff         = 0x00000001,
    Ndis802_11RadioStatusSoftwareOff         = 0x00000002,
    Ndis802_11RadioStatusHardwareSoftwareOff = 0x00000003,
    Ndis802_11RadioStatusMax                 = 0x00000004,
}

alias OFFLOAD_OPERATION_E = int;
enum : int
{
    AUTHENTICATE = 0x00000001,
    ENCRYPT      = 0x00000002,
}

alias OFFLOAD_CONF_ALGO = int;
enum : int
{
    OFFLOAD_IPSEC_CONF_NONE     = 0x00000000,
    OFFLOAD_IPSEC_CONF_DES      = 0x00000001,
    OFFLOAD_IPSEC_CONF_RESERVED = 0x00000002,
    OFFLOAD_IPSEC_CONF_3_DES    = 0x00000003,
    OFFLOAD_IPSEC_CONF_MAX      = 0x00000004,
}

alias OFFLOAD_INTEGRITY_ALGO = int;
enum : int
{
    OFFLOAD_IPSEC_INTEGRITY_NONE = 0x00000000,
    OFFLOAD_IPSEC_INTEGRITY_MD5  = 0x00000001,
    OFFLOAD_IPSEC_INTEGRITY_SHA  = 0x00000002,
    OFFLOAD_IPSEC_INTEGRITY_MAX  = 0x00000003,
}

alias UDP_ENCAP_TYPE = int;
enum : int
{
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_IKE   = 0x00000000,
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_OTHER = 0x00000001,
}

alias NDIS_MEDIUM = int;
enum : int
{
    NdisMedium802_3        = 0x00000000,
    NdisMedium802_5        = 0x00000001,
    NdisMediumFddi         = 0x00000002,
    NdisMediumWan          = 0x00000003,
    NdisMediumLocalTalk    = 0x00000004,
    NdisMediumDix          = 0x00000005,
    NdisMediumArcnetRaw    = 0x00000006,
    NdisMediumArcnet878_2  = 0x00000007,
    NdisMediumAtm          = 0x00000008,
    NdisMediumWirelessWan  = 0x00000009,
    NdisMediumIrda         = 0x0000000a,
    NdisMediumBpc          = 0x0000000b,
    NdisMediumCoWan        = 0x0000000c,
    NdisMedium1394         = 0x0000000d,
    NdisMediumInfiniBand   = 0x0000000e,
    NdisMediumTunnel       = 0x0000000f,
    NdisMediumNative802_11 = 0x00000010,
    NdisMediumLoopback     = 0x00000011,
    NdisMediumWiMAX        = 0x00000012,
    NdisMediumIP           = 0x00000013,
    NdisMediumMax          = 0x00000014,
}

alias NDIS_PHYSICAL_MEDIUM = int;
enum : int
{
    NdisPhysicalMediumUnspecified    = 0x00000000,
    NdisPhysicalMediumWirelessLan    = 0x00000001,
    NdisPhysicalMediumCableModem     = 0x00000002,
    NdisPhysicalMediumPhoneLine      = 0x00000003,
    NdisPhysicalMediumPowerLine      = 0x00000004,
    NdisPhysicalMediumDSL            = 0x00000005,
    NdisPhysicalMediumFibreChannel   = 0x00000006,
    NdisPhysicalMedium1394           = 0x00000007,
    NdisPhysicalMediumWirelessWan    = 0x00000008,
    NdisPhysicalMediumNative802_11   = 0x00000009,
    NdisPhysicalMediumBluetooth      = 0x0000000a,
    NdisPhysicalMediumInfiniband     = 0x0000000b,
    NdisPhysicalMediumWiMax          = 0x0000000c,
    NdisPhysicalMediumUWB            = 0x0000000d,
    NdisPhysicalMedium802_3          = 0x0000000e,
    NdisPhysicalMedium802_5          = 0x0000000f,
    NdisPhysicalMediumIrda           = 0x00000010,
    NdisPhysicalMediumWiredWAN       = 0x00000011,
    NdisPhysicalMediumWiredCoWan     = 0x00000012,
    NdisPhysicalMediumOther          = 0x00000013,
    NdisPhysicalMediumNative802_15_4 = 0x00000014,
    NdisPhysicalMediumMax            = 0x00000015,
}

alias NDIS_HARDWARE_STATUS = int;
enum : int
{
    NdisHardwareStatusReady        = 0x00000000,
    NdisHardwareStatusInitializing = 0x00000001,
    NdisHardwareStatusReset        = 0x00000002,
    NdisHardwareStatusClosing      = 0x00000003,
    NdisHardwareStatusNotReady     = 0x00000004,
}

alias NDIS_DEVICE_POWER_STATE = int;
enum : int
{
    NdisDeviceStateUnspecified = 0x00000000,
    NdisDeviceStateD0          = 0x00000001,
    NdisDeviceStateD1          = 0x00000002,
    NdisDeviceStateD2          = 0x00000003,
    NdisDeviceStateD3          = 0x00000004,
    NdisDeviceStateMaximum     = 0x00000005,
}

alias NDIS_FDDI_ATTACHMENT_TYPE = int;
enum : int
{
    NdisFddiTypeIsolated = 0x00000001,
    NdisFddiTypeLocalA   = 0x00000002,
    NdisFddiTypeLocalB   = 0x00000003,
    NdisFddiTypeLocalAB  = 0x00000004,
    NdisFddiTypeLocalS   = 0x00000005,
    NdisFddiTypeWrapA    = 0x00000006,
    NdisFddiTypeWrapB    = 0x00000007,
    NdisFddiTypeWrapAB   = 0x00000008,
    NdisFddiTypeWrapS    = 0x00000009,
    NdisFddiTypeCWrapA   = 0x0000000a,
    NdisFddiTypeCWrapB   = 0x0000000b,
    NdisFddiTypeCWrapS   = 0x0000000c,
    NdisFddiTypeThrough  = 0x0000000d,
}

alias NDIS_FDDI_RING_MGT_STATE = int;
enum : int
{
    NdisFddiRingIsolated          = 0x00000001,
    NdisFddiRingNonOperational    = 0x00000002,
    NdisFddiRingOperational       = 0x00000003,
    NdisFddiRingDetect            = 0x00000004,
    NdisFddiRingNonOperationalDup = 0x00000005,
    NdisFddiRingOperationalDup    = 0x00000006,
    NdisFddiRingDirected          = 0x00000007,
    NdisFddiRingTrace             = 0x00000008,
}

alias NDIS_FDDI_LCONNECTION_STATE = int;
enum : int
{
    NdisFddiStateOff         = 0x00000001,
    NdisFddiStateBreak       = 0x00000002,
    NdisFddiStateTrace       = 0x00000003,
    NdisFddiStateConnect     = 0x00000004,
    NdisFddiStateNext        = 0x00000005,
    NdisFddiStateSignal      = 0x00000006,
    NdisFddiStateJoin        = 0x00000007,
    NdisFddiStateVerify      = 0x00000008,
    NdisFddiStateActive      = 0x00000009,
    NdisFddiStateMaintenance = 0x0000000a,
}

alias NDIS_WAN_MEDIUM_SUBTYPE = int;
enum : int
{
    NdisWanMediumHub        = 0x00000000,
    NdisWanMediumX_25       = 0x00000001,
    NdisWanMediumIsdn       = 0x00000002,
    NdisWanMediumSerial     = 0x00000003,
    NdisWanMediumFrameRelay = 0x00000004,
    NdisWanMediumAtm        = 0x00000005,
    NdisWanMediumSonet      = 0x00000006,
    NdisWanMediumSW56K      = 0x00000007,
    NdisWanMediumPPTP       = 0x00000008,
    NdisWanMediumL2TP       = 0x00000009,
    NdisWanMediumIrda       = 0x0000000a,
    NdisWanMediumParallel   = 0x0000000b,
    NdisWanMediumPppoe      = 0x0000000c,
    NdisWanMediumSSTP       = 0x0000000d,
    NdisWanMediumAgileVPN   = 0x0000000e,
    NdisWanMediumGre        = 0x0000000f,
    NdisWanMediumSubTypeMax = 0x00000010,
}

alias NDIS_WAN_HEADER_FORMAT = int;
enum : int
{
    NdisWanHeaderNative   = 0x00000000,
    NdisWanHeaderEthernet = 0x00000001,
}

alias NDIS_WAN_QUALITY = int;
enum : int
{
    NdisWanRaw          = 0x00000000,
    NdisWanErrorControl = 0x00000001,
    NdisWanReliable     = 0x00000002,
}

alias NDIS_802_5_RING_STATE = int;
enum : int
{
    NdisRingStateOpened      = 0x00000001,
    NdisRingStateClosed      = 0x00000002,
    NdisRingStateOpening     = 0x00000003,
    NdisRingStateClosing     = 0x00000004,
    NdisRingStateOpenFailure = 0x00000005,
    NdisRingStateRingFailure = 0x00000006,
}

alias NDIS_MEDIA_STATE = int;
enum : int
{
    NdisMediaStateConnected    = 0x00000000,
    NdisMediaStateDisconnected = 0x00000001,
}

alias NDIS_SUPPORTED_PAUSE_FUNCTIONS = int;
enum : int
{
    NdisPauseFunctionsUnsupported    = 0x00000000,
    NdisPauseFunctionsSendOnly       = 0x00000001,
    NdisPauseFunctionsReceiveOnly    = 0x00000002,
    NdisPauseFunctionsSendAndReceive = 0x00000003,
    NdisPauseFunctionsUnknown        = 0x00000004,
}

alias NDIS_PORT_TYPE = int;
enum : int
{
    NdisPortTypeUndefined       = 0x00000000,
    NdisPortTypeBridge          = 0x00000001,
    NdisPortTypeRasConnection   = 0x00000002,
    NdisPortType8021xSupplicant = 0x00000003,
    NdisPortTypeMax             = 0x00000004,
}

alias NDIS_PORT_AUTHORIZATION_STATE = int;
enum : int
{
    NdisPortAuthorizationUnknown = 0x00000000,
    NdisPortAuthorized           = 0x00000001,
    NdisPortUnauthorized         = 0x00000002,
    NdisPortReauthorizing        = 0x00000003,
}

alias NDIS_PORT_CONTROL_STATE = int;
enum : int
{
    NdisPortControlStateUnknown      = 0x00000000,
    NdisPortControlStateControlled   = 0x00000001,
    NdisPortControlStateUncontrolled = 0x00000002,
}

alias NDIS_NETWORK_CHANGE_TYPE = int;
enum : int
{
    NdisPossibleNetworkChange         = 0x00000001,
    NdisDefinitelyNetworkChange       = 0x00000002,
    NdisNetworkChangeFromMediaConnect = 0x00000003,
    NdisNetworkChangeMax              = 0x00000004,
}

alias NDIS_PROCESSOR_VENDOR = int;
enum : int
{
    NdisProcessorVendorUnknown      = 0x00000000,
    NdisProcessorVendorGenuinIntel  = 0x00000001,
    NdisProcessorVendorGenuineIntel = 0x00000001,
    NdisProcessorVendorAuthenticAMD = 0x00000002,
}

alias NDK_RDMA_TECHNOLOGY = int;
enum : int
{
    NdkUndefined     = 0x00000000,
    NdkiWarp         = 0x00000001,
    NdkInfiniBand    = 0x00000002,
    NdkRoCE          = 0x00000003,
    NdkRoCEv2        = 0x00000004,
    NdkMaxTechnology = 0x00000005,
}

// Constants


enum : uint
{
    NET_IF_COMPARTMENT_ID_UNSPECIFIED = 0x00000000,
    NET_IF_COMPARTMENT_ID_PRIMARY     = 0x00000001,
}

enum uint IOCTL_NDIS_RESERVED6 = 0x00178038;

enum : uint
{
    NDIS_OBJECT_TYPE_MINIPORT_INIT_PARAMETERS        = 0x00000081,
    NDIS_OBJECT_TYPE_SG_DMA_DESCRIPTION              = 0x00000083,
    NDIS_OBJECT_TYPE_MINIPORT_INTERRUPT              = 0x00000084,
    NDIS_OBJECT_TYPE_DEVICE_OBJECT_ATTRIBUTES        = 0x00000085,
    NDIS_OBJECT_TYPE_BIND_PARAMETERS                 = 0x00000086,
    NDIS_OBJECT_TYPE_OPEN_PARAMETERS                 = 0x00000087,
    NDIS_OBJECT_TYPE_RSS_CAPABILITIES                = 0x00000088,
    NDIS_OBJECT_TYPE_RSS_PARAMETERS                  = 0x00000089,
    NDIS_OBJECT_TYPE_MINIPORT_DRIVER_CHARACTERISTICS = 0x0000008a,
}

enum : uint
{
    NDIS_OBJECT_TYPE_FILTER_PARTIAL_CHARACTERISTICS                 = 0x0000008c,
    NDIS_OBJECT_TYPE_FILTER_ATTRIBUTES                              = 0x0000008d,
    NDIS_OBJECT_TYPE_CLIENT_CHIMNEY_OFFLOAD_GENERIC_CHARACTERISTICS = 0x0000008e,
}

enum : uint
{
    NDIS_OBJECT_TYPE_CO_PROTOCOL_CHARACTERISTICS = 0x00000090,
    NDIS_OBJECT_TYPE_CO_MINIPORT_CHARACTERISTICS = 0x00000091,
}

enum uint NDIS_OBJECT_TYPE_CLIENT_CHIMNEY_OFFLOAD_CHARACTERISTICS = 0x00000093;
enum uint NDIS_OBJECT_TYPE_PROTOCOL_DRIVER_CHARACTERISTICS = 0x00000095;

enum : uint
{
    NDIS_OBJECT_TYPE_TIMER_CHARACTERISTICS                     = 0x00000097,
    NDIS_OBJECT_TYPE_STATUS_INDICATION                         = 0x00000098,
    NDIS_OBJECT_TYPE_FILTER_ATTACH_PARAMETERS                  = 0x00000099,
    NDIS_OBJECT_TYPE_FILTER_PAUSE_PARAMETERS                   = 0x0000009a,
    NDIS_OBJECT_TYPE_FILTER_RESTART_PARAMETERS                 = 0x0000009b,
    NDIS_OBJECT_TYPE_PORT_CHARACTERISTICS                      = 0x0000009c,
    NDIS_OBJECT_TYPE_PORT_STATE                                = 0x0000009d,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_REGISTRATION_ATTRIBUTES  = 0x0000009e,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_GENERAL_ATTRIBUTES       = 0x0000009f,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_OFFLOAD_ATTRIBUTES       = 0x000000a0,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_NATIVE_802_11_ATTRIBUTES = 0x000000a1,
}

enum uint NDIS_OBJECT_TYPE_PROTOCOL_RESTART_PARAMETERS = 0x000000a3;

enum : uint
{
    NDIS_OBJECT_TYPE_CO_CALL_MANAGER_OPTIONAL_HANDLERS = 0x000000a5,
    NDIS_OBJECT_TYPE_CO_CLIENT_OPTIONAL_HANDLERS       = 0x000000a6,
}

enum : uint
{
    NDIS_OBJECT_TYPE_OFFLOAD_ENCAPSULATION           = 0x000000a8,
    NDIS_OBJECT_TYPE_CONFIGURATION_OBJECT            = 0x000000a9,
    NDIS_OBJECT_TYPE_DRIVER_WRAPPER_OBJECT           = 0x000000aa,
    NDIS_OBJECT_TYPE_HD_SPLIT_ATTRIBUTES             = 0x000000ab,
    NDIS_OBJECT_TYPE_NSI_NETWORK_RW_STRUCT           = 0x000000ac,
    NDIS_OBJECT_TYPE_NSI_COMPARTMENT_RW_STRUCT       = 0x000000ad,
    NDIS_OBJECT_TYPE_NSI_INTERFACE_PERSIST_RW_STRUCT = 0x000000ae,
}

enum uint NDIS_OBJECT_TYPE_SHARED_MEMORY_PROVIDER_CHARACTERISTICS = 0x000000b0;
enum uint NDIS_OBJECT_TYPE_NDK_PROVIDER_CHARACTERISTICS = 0x000000b2;
enum uint NDIS_OBJECT_TYPE_MINIPORT_SS_CHARACTERISTICS = 0x000000b4;

enum : uint
{
    NDIS_OBJECT_TYPE_QOS_PARAMETERS             = 0x000000b6,
    NDIS_OBJECT_TYPE_QOS_CLASSIFICATION_ELEMENT = 0x000000b7,
}

enum : uint
{
    NDIS_OBJECT_TYPE_PD_TRANSMIT_QUEUE                         = 0x000000be,
    NDIS_OBJECT_TYPE_PD_RECEIVE_QUEUE                          = 0x000000bf,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_PACKET_DIRECT_ATTRIBUTES = 0x000000c5,
    NDIS_OBJECT_TYPE_MINIPORT_DEVICE_POWER_NOTIFICATION        = 0x000000c6,
}

enum uint NDIS_OBJECT_TYPE_RSS_SET_INDIRECTION_ENTRIES = 0x000000c9;

enum : uint
{
    NDIS_STATISTICS_FLAGS_VALID_MULTICAST_FRAMES_RCV  = 0x00000002,
    NDIS_STATISTICS_FLAGS_VALID_BROADCAST_FRAMES_RCV  = 0x00000004,
    NDIS_STATISTICS_FLAGS_VALID_BYTES_RCV             = 0x00000008,
    NDIS_STATISTICS_FLAGS_VALID_RCV_DISCARDS          = 0x00000010,
    NDIS_STATISTICS_FLAGS_VALID_RCV_ERROR             = 0x00000020,
    NDIS_STATISTICS_FLAGS_VALID_DIRECTED_FRAMES_XMIT  = 0x00000040,
    NDIS_STATISTICS_FLAGS_VALID_MULTICAST_FRAMES_XMIT = 0x00000080,
    NDIS_STATISTICS_FLAGS_VALID_BROADCAST_FRAMES_XMIT = 0x00000100,
    NDIS_STATISTICS_FLAGS_VALID_BYTES_XMIT            = 0x00000200,
    NDIS_STATISTICS_FLAGS_VALID_XMIT_ERROR            = 0x00000400,
    NDIS_STATISTICS_FLAGS_VALID_XMIT_DISCARDS         = 0x00008000,
    NDIS_STATISTICS_FLAGS_VALID_DIRECTED_BYTES_RCV    = 0x00010000,
    NDIS_STATISTICS_FLAGS_VALID_MULTICAST_BYTES_RCV   = 0x00020000,
    NDIS_STATISTICS_FLAGS_VALID_BROADCAST_BYTES_RCV   = 0x00040000,
    NDIS_STATISTICS_FLAGS_VALID_DIRECTED_BYTES_XMIT   = 0x00080000,
    NDIS_STATISTICS_FLAGS_VALID_MULTICAST_BYTES_XMIT  = 0x00100000,
    NDIS_STATISTICS_FLAGS_VALID_BROADCAST_BYTES_XMIT  = 0x00200000,
}

enum uint NDIS_RSC_STATISTICS_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_INTERRUPT_MODERATION_CHANGE_NEEDS_REINITIALIZE = 0x00000002,
    NDIS_INTERRUPT_MODERATION_PARAMETERS_REVISION_1     = 0x00000001,
}

enum : uint
{
    NDIS_OBJECT_TYPE_PCI_DEVICE_CUSTOM_PROPERTIES_REVISION_1 = 0x00000001,
    NDIS_OBJECT_TYPE_PCI_DEVICE_CUSTOM_PROPERTIES_REVISION_2 = 0x00000002,
}

enum uint OID_GEN_HARDWARE_STATUS = 0x00010102;

enum : uint
{
    OID_GEN_MEDIA_IN_USE       = 0x00010104,
    OID_GEN_MAXIMUM_LOOKAHEAD  = 0x00010105,
    OID_GEN_MAXIMUM_FRAME_SIZE = 0x00010106,
}

enum uint OID_GEN_TRANSMIT_BUFFER_SPACE = 0x00010108;
enum uint OID_GEN_TRANSMIT_BLOCK_SIZE = 0x0001010a;

enum : uint
{
    OID_GEN_VENDOR_ID          = 0x0001010c,
    OID_GEN_VENDOR_DESCRIPTION = 0x0001010d,
}

enum uint OID_GEN_CURRENT_LOOKAHEAD = 0x0001010f;
enum uint OID_GEN_MAXIMUM_TOTAL_SIZE = 0x00010111;

enum : uint
{
    OID_GEN_MAC_OPTIONS          = 0x00010113,
    OID_GEN_MEDIA_CONNECT_STATUS = 0x00010114,
}

enum uint OID_GEN_VENDOR_DRIVER_VERSION = 0x00010116;
enum uint OID_GEN_NETWORK_LAYER_ADDRESSES = 0x00010118;
enum uint OID_GEN_MEDIA_CAPABILITIES = 0x00010201;

enum : uint
{
    OID_GEN_RECEIVE_SCALE_CAPABILITIES = 0x00010203,
    OID_GEN_RECEIVE_SCALE_PARAMETERS   = 0x00010204,
}

enum uint OID_GEN_MAX_LINK_SPEED = 0x00010206;
enum uint OID_GEN_LINK_PARAMETERS = 0x00010208;

enum : uint
{
    OID_GEN_NDIS_RESERVED_3 = 0x0001020a,
    OID_GEN_NDIS_RESERVED_4 = 0x0001020b,
    OID_GEN_NDIS_RESERVED_5 = 0x0001020c,
}

enum : uint
{
    OID_GEN_PORT_STATE                     = 0x0001020e,
    OID_GEN_PORT_AUTHENTICATION_PARAMETERS = 0x0001020f,
}

enum uint OID_GEN_PCI_DEVICE_CUSTOM_PROPERTIES = 0x00010211;
enum uint OID_GEN_PHYSICAL_MEDIUM_EX = 0x00010213;
enum uint OID_GEN_MACHINE_NAME = 0x0001021a;

enum : uint
{
    OID_GEN_VLAN_ID      = 0x0001021c,
    OID_GEN_RECEIVE_HASH = 0x0001021f,
}

enum : uint
{
    OID_GEN_HD_SPLIT_PARAMETERS     = 0x0001021e,
    OID_GEN_HD_SPLIT_CURRENT_CONFIG = 0x00010220,
}

enum : uint
{
    OID_GEN_LAST_CHANGE        = 0x00010281,
    OID_GEN_DISCONTINUITY_TIME = 0x00010282,
}

enum uint OID_GEN_XMIT_LINK_SPEED = 0x00010284;
enum uint OID_GEN_UNKNOWN_PROTOS = 0x00010286;

enum : uint
{
    OID_GEN_ADMIN_STATUS            = 0x00010288,
    OID_GEN_ALIAS                   = 0x00010289,
    OID_GEN_MEDIA_CONNECT_STATUS_EX = 0x0001028a,
}

enum uint OID_GEN_MEDIA_DUPLEX_STATE = 0x0001028c;

enum : uint
{
    OID_WWAN_DRIVER_CAPS         = 0x0e010100,
    OID_WWAN_DEVICE_CAPS         = 0x0e010101,
    OID_WWAN_READY_INFO          = 0x0e010102,
    OID_WWAN_RADIO_STATE         = 0x0e010103,
    OID_WWAN_PIN                 = 0x0e010104,
    OID_WWAN_PIN_LIST            = 0x0e010105,
    OID_WWAN_HOME_PROVIDER       = 0x0e010106,
    OID_WWAN_PREFERRED_PROVIDERS = 0x0e010107,
}

enum uint OID_WWAN_REGISTER_STATE = 0x0e010109;

enum : uint
{
    OID_WWAN_SIGNAL_STATE         = 0x0e01010b,
    OID_WWAN_CONNECT              = 0x0e01010c,
    OID_WWAN_PROVISIONED_CONTEXTS = 0x0e01010d,
}

enum : uint
{
    OID_WWAN_SMS_CONFIGURATION = 0x0e01010f,
    OID_WWAN_SMS_READ          = 0x0e010110,
    OID_WWAN_SMS_SEND          = 0x0e010111,
    OID_WWAN_SMS_DELETE        = 0x0e010112,
    OID_WWAN_SMS_STATUS        = 0x0e010113,
    OID_WWAN_VENDOR_SPECIFIC   = 0x0e010114,
}

enum uint OID_WWAN_ENUMERATE_DEVICE_SERVICES = 0x0e010116;
enum uint OID_WWAN_DEVICE_SERVICE_COMMAND = 0x0e010118;

enum : uint
{
    OID_WWAN_PIN_EX                            = 0x0e010121,
    OID_WWAN_ENUMERATE_DEVICE_SERVICE_COMMANDS = 0x0e010122,
}

enum uint OID_WWAN_DEVICE_SERVICE_SESSION_WRITE = 0x0e010124;

enum : uint
{
    OID_WWAN_CREATE_MAC         = 0x0e010126,
    OID_WWAN_DELETE_MAC         = 0x0e010127,
    OID_WWAN_UICC_FILE_STATUS   = 0x0e010128,
    OID_WWAN_UICC_ACCESS_BINARY = 0x0e010129,
    OID_WWAN_UICC_ACCESS_RECORD = 0x0e01012a,
}

enum : uint
{
    OID_WWAN_MBIM_VERSION   = 0x0e01012c,
    OID_WWAN_SYS_CAPS       = 0x0e01012d,
    OID_WWAN_DEVICE_CAPS_EX = 0x0e01012e,
}

enum uint OID_WWAN_SLOT_INFO_STATUS = 0x0e010130;
enum uint OID_WWAN_REGISTER_STATE_EX = 0x0e010132;
enum uint OID_WWAN_SIGNAL_STATE_EX = 0x0e010134;

enum : uint
{
    OID_WWAN_NITZ              = 0x0e010136,
    OID_WWAN_NETWORK_IDLE_HINT = 0x0e010137,
}

enum : uint
{
    OID_WWAN_UICC_ATR                 = 0x0e010139,
    OID_WWAN_UICC_OPEN_CHANNEL        = 0x0e01013a,
    OID_WWAN_UICC_CLOSE_CHANNEL       = 0x0e01013b,
    OID_WWAN_UICC_APDU                = 0x0e01013c,
    OID_WWAN_UICC_TERMINAL_CAPABILITY = 0x0e01013d,
}

enum : uint
{
    OID_WWAN_SAR_CONFIG              = 0x0e01013f,
    OID_WWAN_SAR_TRANSMISSION_STATUS = 0x0e010140,
}

enum : uint
{
    OID_WWAN_LTE_ATTACH_CONFIG = 0x0e010142,
    OID_WWAN_LTE_ATTACH_STATUS = 0x0e010143,
}

enum : uint
{
    OID_WWAN_PCO                = 0x0e010145,
    OID_WWAN_UICC_RESET         = 0x0e010146,
    OID_WWAN_DEVICE_RESET       = 0x0e010147,
    OID_WWAN_BASE_STATIONS_INFO = 0x0e010148,
}

enum : uint
{
    OID_WWAN_UICC_APP_LIST        = 0x0e01014a,
    OID_WWAN_MODEM_LOGGING_CONFIG = 0x0e01014b,
}

enum uint OID_WWAN_NETWORK_PARAMS = 0x0e01014d;

enum : uint
{
    OID_GEN_XMIT_OK       = 0x00020101,
    OID_GEN_RCV_OK        = 0x00020102,
    OID_GEN_XMIT_ERROR    = 0x00020103,
    OID_GEN_RCV_ERROR     = 0x00020104,
    OID_GEN_RCV_NO_BUFFER = 0x00020105,
}

enum : uint
{
    OID_GEN_DIRECTED_BYTES_XMIT  = 0x00020201,
    OID_GEN_DIRECTED_FRAMES_XMIT = 0x00020202,
}

enum uint OID_GEN_MULTICAST_FRAMES_XMIT = 0x00020204;
enum uint OID_GEN_BROADCAST_FRAMES_XMIT = 0x00020206;
enum uint OID_GEN_DIRECTED_FRAMES_RCV = 0x00020208;
enum uint OID_GEN_MULTICAST_FRAMES_RCV = 0x0002020a;
enum uint OID_GEN_BROADCAST_FRAMES_RCV = 0x0002020c;
enum uint OID_GEN_TRANSMIT_QUEUE_LENGTH = 0x0002020e;
enum uint OID_GEN_GET_NETCARD_TIME = 0x00020210;
enum uint OID_GEN_DEVICE_PROFILE = 0x00020212;
enum uint OID_GEN_RESET_COUNTS = 0x00020214;
enum uint OID_GEN_FRIENDLY_NAME = 0x00020216;
enum uint OID_GEN_NDIS_RESERVED_2 = 0x00020218;

enum : uint
{
    OID_GEN_BYTES_XMIT   = 0x0002021a,
    OID_GEN_RCV_DISCARDS = 0x0002021b,
}

enum uint OID_TCP_RSC_STATISTICS = 0x0002021d;

enum : uint
{
    OID_GEN_CO_SUPPORTED_LIST     = 0x00010101,
    OID_GEN_CO_HARDWARE_STATUS    = 0x00010102,
    OID_GEN_CO_MEDIA_SUPPORTED    = 0x00010103,
    OID_GEN_CO_MEDIA_IN_USE       = 0x00010104,
    OID_GEN_CO_LINK_SPEED         = 0x00010107,
    OID_GEN_CO_VENDOR_ID          = 0x0001010c,
    OID_GEN_CO_VENDOR_DESCRIPTION = 0x0001010d,
}

enum : uint
{
    OID_GEN_CO_PROTOCOL_OPTIONS     = 0x00010112,
    OID_GEN_CO_MAC_OPTIONS          = 0x00010113,
    OID_GEN_CO_MEDIA_CONNECT_STATUS = 0x00010114,
}

enum : uint
{
    OID_GEN_CO_SUPPORTED_GUIDS    = 0x00010117,
    OID_GEN_CO_GET_TIME_CAPS      = 0x0002020f,
    OID_GEN_CO_GET_NETCARD_TIME   = 0x00020210,
    OID_GEN_CO_MINIMUM_LINK_SPEED = 0x00020120,
}

enum : uint
{
    OID_GEN_CO_RCV_PDUS_OK           = 0x00020102,
    OID_GEN_CO_XMIT_PDUS_ERROR       = 0x00020103,
    OID_GEN_CO_RCV_PDUS_ERROR        = 0x00020104,
    OID_GEN_CO_RCV_PDUS_NO_BUFFER    = 0x00020105,
    OID_GEN_CO_RCV_CRC_ERROR         = 0x0002020d,
    OID_GEN_CO_TRANSMIT_QUEUE_LENGTH = 0x0002020e,
}

enum : uint
{
    OID_GEN_CO_BYTES_RCV              = 0x00020207,
    OID_GEN_CO_NETCARD_LOAD           = 0x00020211,
    OID_GEN_CO_DEVICE_PROFILE         = 0x00020212,
    OID_GEN_CO_BYTES_XMIT_OUTSTANDING = 0x00020221,
}

enum : uint
{
    OID_KDNET_ADD_PF               = 0x00020223,
    OID_KDNET_REMOVE_PF            = 0x00020224,
    OID_KDNET_QUERY_PF_INFORMATION = 0x00020225,
}

enum uint OID_802_3_CURRENT_ADDRESS = 0x01010102;

enum : uint
{
    OID_802_3_MAXIMUM_LIST_SIZE = 0x01010104,
    OID_802_3_MAC_OPTIONS       = 0x01010105,
}

enum uint OID_802_3_RCV_ERROR_ALIGNMENT = 0x01020101;

enum : uint
{
    OID_802_3_XMIT_MORE_COLLISIONS = 0x01020103,
    OID_802_3_XMIT_DEFERRED        = 0x01020201,
    OID_802_3_XMIT_MAX_COLLISIONS  = 0x01020202,
}

enum : uint
{
    OID_802_3_XMIT_UNDERRUN          = 0x01020204,
    OID_802_3_XMIT_HEARTBEAT_FAILURE = 0x01020205,
    OID_802_3_XMIT_TIMES_CRS_LOST    = 0x01020206,
    OID_802_3_XMIT_LATE_COLLISIONS   = 0x01020207,
}

enum uint OID_802_3_DELETE_MULTICAST_ADDRESS = 0x01010209;

enum : uint
{
    OID_802_5_CURRENT_ADDRESS    = 0x02010102,
    OID_802_5_CURRENT_FUNCTIONAL = 0x02010103,
    OID_802_5_CURRENT_GROUP      = 0x02010104,
    OID_802_5_LAST_OPEN_STATUS   = 0x02010105,
}

enum uint OID_802_5_CURRENT_RING_STATE = 0x02010107;

enum : uint
{
    OID_802_5_LOST_FRAMES      = 0x02020102,
    OID_802_5_BURST_ERRORS     = 0x02020201,
    OID_802_5_AC_ERRORS        = 0x02020202,
    OID_802_5_ABORT_DELIMETERS = 0x02020203,
}

enum uint OID_802_5_FREQUENCY_ERRORS = 0x02020205;
enum uint OID_802_5_INTERNAL_ERRORS = 0x02020207;

enum : uint
{
    OID_FDDI_LONG_CURRENT_ADDR   = 0x03010102,
    OID_FDDI_LONG_MULTICAST_LIST = 0x03010103,
    OID_FDDI_LONG_MAX_LIST_SIZE  = 0x03010104,
}

enum : uint
{
    OID_FDDI_SHORT_CURRENT_ADDR   = 0x03010106,
    OID_FDDI_SHORT_MULTICAST_LIST = 0x03010107,
    OID_FDDI_SHORT_MAX_LIST_SIZE  = 0x03010108,
}

enum uint OID_FDDI_UPSTREAM_NODE_LONG = 0x03020102;

enum : uint
{
    OID_FDDI_FRAME_ERRORS   = 0x03020104,
    OID_FDDI_FRAMES_LOST    = 0x03020105,
    OID_FDDI_RING_MGT_STATE = 0x03020106,
}

enum : uint
{
    OID_FDDI_LEM_REJECTS       = 0x03020108,
    OID_FDDI_LCONNECTION_STATE = 0x03020109,
}

enum : uint
{
    OID_FDDI_SMT_OP_VERSION_ID        = 0x03030202,
    OID_FDDI_SMT_HI_VERSION_ID        = 0x03030203,
    OID_FDDI_SMT_LO_VERSION_ID        = 0x03030204,
    OID_FDDI_SMT_MANUFACTURER_DATA    = 0x03030205,
    OID_FDDI_SMT_USER_DATA            = 0x03030206,
    OID_FDDI_SMT_MIB_VERSION_ID       = 0x03030207,
    OID_FDDI_SMT_MAC_CT               = 0x03030208,
    OID_FDDI_SMT_NON_MASTER_CT        = 0x03030209,
    OID_FDDI_SMT_MASTER_CT            = 0x0303020a,
    OID_FDDI_SMT_AVAILABLE_PATHS      = 0x0303020b,
    OID_FDDI_SMT_CONFIG_CAPABILITIES  = 0x0303020c,
    OID_FDDI_SMT_CONFIG_POLICY        = 0x0303020d,
    OID_FDDI_SMT_CONNECTION_POLICY    = 0x0303020e,
    OID_FDDI_SMT_T_NOTIFY             = 0x0303020f,
    OID_FDDI_SMT_STAT_RPT_POLICY      = 0x03030210,
    OID_FDDI_SMT_TRACE_MAX_EXPIRATION = 0x03030211,
}

enum : uint
{
    OID_FDDI_SMT_MAC_INDEXES            = 0x03030213,
    OID_FDDI_SMT_BYPASS_PRESENT         = 0x03030214,
    OID_FDDI_SMT_ECM_STATE              = 0x03030215,
    OID_FDDI_SMT_CF_STATE               = 0x03030216,
    OID_FDDI_SMT_HOLD_STATE             = 0x03030217,
    OID_FDDI_SMT_REMOTE_DISCONNECT_FLAG = 0x03030218,
}

enum : uint
{
    OID_FDDI_SMT_PEER_WRAP_FLAG        = 0x0303021a,
    OID_FDDI_SMT_MSG_TIME_STAMP        = 0x0303021b,
    OID_FDDI_SMT_TRANSITION_TIME_STAMP = 0x0303021c,
}

enum uint OID_FDDI_SMT_LAST_SET_STATION_ID = 0x0303021e;

enum : uint
{
    OID_FDDI_MAC_BRIDGE_FUNCTIONS     = 0x03030220,
    OID_FDDI_MAC_T_MAX_CAPABILITY     = 0x03030221,
    OID_FDDI_MAC_TVX_CAPABILITY       = 0x03030222,
    OID_FDDI_MAC_AVAILABLE_PATHS      = 0x03030223,
    OID_FDDI_MAC_CURRENT_PATH         = 0x03030224,
    OID_FDDI_MAC_UPSTREAM_NBR         = 0x03030225,
    OID_FDDI_MAC_DOWNSTREAM_NBR       = 0x03030226,
    OID_FDDI_MAC_OLD_UPSTREAM_NBR     = 0x03030227,
    OID_FDDI_MAC_OLD_DOWNSTREAM_NBR   = 0x03030228,
    OID_FDDI_MAC_DUP_ADDRESS_TEST     = 0x03030229,
    OID_FDDI_MAC_REQUESTED_PATHS      = 0x0303022a,
    OID_FDDI_MAC_DOWNSTREAM_PORT_TYPE = 0x0303022b,
}

enum : uint
{
    OID_FDDI_MAC_SMT_ADDRESS           = 0x0303022d,
    OID_FDDI_MAC_LONG_GRP_ADDRESS      = 0x0303022e,
    OID_FDDI_MAC_SHORT_GRP_ADDRESS     = 0x0303022f,
    OID_FDDI_MAC_T_REQ                 = 0x03030230,
    OID_FDDI_MAC_T_NEG                 = 0x03030231,
    OID_FDDI_MAC_T_MAX                 = 0x03030232,
    OID_FDDI_MAC_TVX_VALUE             = 0x03030233,
    OID_FDDI_MAC_T_PRI0                = 0x03030234,
    OID_FDDI_MAC_T_PRI1                = 0x03030235,
    OID_FDDI_MAC_T_PRI2                = 0x03030236,
    OID_FDDI_MAC_T_PRI3                = 0x03030237,
    OID_FDDI_MAC_T_PRI4                = 0x03030238,
    OID_FDDI_MAC_T_PRI5                = 0x03030239,
    OID_FDDI_MAC_T_PRI6                = 0x0303023a,
    OID_FDDI_MAC_FRAME_CT              = 0x0303023b,
    OID_FDDI_MAC_COPIED_CT             = 0x0303023c,
    OID_FDDI_MAC_TRANSMIT_CT           = 0x0303023d,
    OID_FDDI_MAC_TOKEN_CT              = 0x0303023e,
    OID_FDDI_MAC_ERROR_CT              = 0x0303023f,
    OID_FDDI_MAC_LOST_CT               = 0x03030240,
    OID_FDDI_MAC_TVX_EXPIRED_CT        = 0x03030241,
    OID_FDDI_MAC_NOT_COPIED_CT         = 0x03030242,
    OID_FDDI_MAC_LATE_CT               = 0x03030243,
    OID_FDDI_MAC_RING_OP_CT            = 0x03030244,
    OID_FDDI_MAC_FRAME_ERROR_THRESHOLD = 0x03030245,
    OID_FDDI_MAC_FRAME_ERROR_RATIO     = 0x03030246,
    OID_FDDI_MAC_NOT_COPIED_THRESHOLD  = 0x03030247,
    OID_FDDI_MAC_NOT_COPIED_RATIO      = 0x03030248,
    OID_FDDI_MAC_RMT_STATE             = 0x03030249,
    OID_FDDI_MAC_DA_FLAG               = 0x0303024a,
    OID_FDDI_MAC_UNDA_FLAG             = 0x0303024b,
    OID_FDDI_MAC_FRAME_ERROR_FLAG      = 0x0303024c,
    OID_FDDI_MAC_NOT_COPIED_FLAG       = 0x0303024d,
    OID_FDDI_MAC_MA_UNITDATA_AVAILABLE = 0x0303024e,
}

enum uint OID_FDDI_MAC_MA_UNITDATA_ENABLE = 0x03030250;

enum : uint
{
    OID_FDDI_PATH_RING_LATENCY            = 0x03030252,
    OID_FDDI_PATH_TRACE_STATUS            = 0x03030253,
    OID_FDDI_PATH_SBA_PAYLOAD             = 0x03030254,
    OID_FDDI_PATH_SBA_OVERHEAD            = 0x03030255,
    OID_FDDI_PATH_CONFIGURATION           = 0x03030256,
    OID_FDDI_PATH_T_R_MODE                = 0x03030257,
    OID_FDDI_PATH_SBA_AVAILABLE           = 0x03030258,
    OID_FDDI_PATH_TVX_LOWER_BOUND         = 0x03030259,
    OID_FDDI_PATH_T_MAX_LOWER_BOUND       = 0x0303025a,
    OID_FDDI_PATH_MAX_T_REQ               = 0x0303025b,
    OID_FDDI_PORT_MY_TYPE                 = 0x0303025c,
    OID_FDDI_PORT_NEIGHBOR_TYPE           = 0x0303025d,
    OID_FDDI_PORT_CONNECTION_POLICIES     = 0x0303025e,
    OID_FDDI_PORT_MAC_INDICATED           = 0x0303025f,
    OID_FDDI_PORT_CURRENT_PATH            = 0x03030260,
    OID_FDDI_PORT_REQUESTED_PATHS         = 0x03030261,
    OID_FDDI_PORT_MAC_PLACEMENT           = 0x03030262,
    OID_FDDI_PORT_AVAILABLE_PATHS         = 0x03030263,
    OID_FDDI_PORT_MAC_LOOP_TIME           = 0x03030264,
    OID_FDDI_PORT_PMD_CLASS               = 0x03030265,
    OID_FDDI_PORT_CONNECTION_CAPABILITIES = 0x03030266,
}

enum : uint
{
    OID_FDDI_PORT_MAINT_LS         = 0x03030268,
    OID_FDDI_PORT_BS_FLAG          = 0x03030269,
    OID_FDDI_PORT_PC_LS            = 0x0303026a,
    OID_FDDI_PORT_EB_ERROR_CT      = 0x0303026b,
    OID_FDDI_PORT_LCT_FAIL_CT      = 0x0303026c,
    OID_FDDI_PORT_LER_ESTIMATE     = 0x0303026d,
    OID_FDDI_PORT_LEM_REJECT_CT    = 0x0303026e,
    OID_FDDI_PORT_LEM_CT           = 0x0303026f,
    OID_FDDI_PORT_LER_CUTOFF       = 0x03030270,
    OID_FDDI_PORT_LER_ALARM        = 0x03030271,
    OID_FDDI_PORT_CONNNECT_STATE   = 0x03030272,
    OID_FDDI_PORT_PCM_STATE        = 0x03030273,
    OID_FDDI_PORT_PC_WITHHOLD      = 0x03030274,
    OID_FDDI_PORT_LER_FLAG         = 0x03030275,
    OID_FDDI_PORT_HARDWARE_PRESENT = 0x03030276,
}

enum : uint
{
    OID_FDDI_PORT_ACTION          = 0x03030278,
    OID_FDDI_IF_DESCR             = 0x03030279,
    OID_FDDI_IF_TYPE              = 0x0303027a,
    OID_FDDI_IF_MTU               = 0x0303027b,
    OID_FDDI_IF_SPEED             = 0x0303027c,
    OID_FDDI_IF_PHYS_ADDRESS      = 0x0303027d,
    OID_FDDI_IF_ADMIN_STATUS      = 0x0303027e,
    OID_FDDI_IF_OPER_STATUS       = 0x0303027f,
    OID_FDDI_IF_LAST_CHANGE       = 0x03030280,
    OID_FDDI_IF_IN_OCTETS         = 0x03030281,
    OID_FDDI_IF_IN_UCAST_PKTS     = 0x03030282,
    OID_FDDI_IF_IN_NUCAST_PKTS    = 0x03030283,
    OID_FDDI_IF_IN_DISCARDS       = 0x03030284,
    OID_FDDI_IF_IN_ERRORS         = 0x03030285,
    OID_FDDI_IF_IN_UNKNOWN_PROTOS = 0x03030286,
    OID_FDDI_IF_OUT_OCTETS        = 0x03030287,
    OID_FDDI_IF_OUT_UCAST_PKTS    = 0x03030288,
    OID_FDDI_IF_OUT_NUCAST_PKTS   = 0x03030289,
    OID_FDDI_IF_OUT_DISCARDS      = 0x0303028a,
    OID_FDDI_IF_OUT_ERRORS        = 0x0303028b,
    OID_FDDI_IF_OUT_QLEN          = 0x0303028c,
    OID_FDDI_IF_SPECIFIC          = 0x0303028d,
}

enum uint OID_WAN_CURRENT_ADDRESS = 0x04010102;
enum uint OID_WAN_PROTOCOL_TYPE = 0x04010104;
enum uint OID_WAN_HEADER_FORMAT = 0x04010106;
enum uint OID_WAN_SET_LINK_INFO = 0x04010108;

enum : uint
{
    OID_WAN_LINE_COUNT    = 0x0401010a,
    OID_WAN_PROTOCOL_CAPS = 0x0401010b,
}

enum uint OID_WAN_SET_BRIDGE_INFO = 0x0401020b;
enum uint OID_WAN_SET_COMP_INFO = 0x0401020d;

enum : uint
{
    OID_WAN_CO_GET_INFO       = 0x04010180,
    OID_WAN_CO_SET_LINK_INFO  = 0x04010181,
    OID_WAN_CO_GET_LINK_INFO  = 0x04010182,
    OID_WAN_CO_GET_COMP_INFO  = 0x04010280,
    OID_WAN_CO_SET_COMP_INFO  = 0x04010281,
    OID_WAN_CO_GET_STATS_INFO = 0x04010282,
}

enum : uint
{
    OID_LTALK_IN_BROADCASTS    = 0x05020101,
    OID_LTALK_IN_LENGTH_ERRORS = 0x05020102,
}

enum : uint
{
    OID_LTALK_COLLISIONS        = 0x05020202,
    OID_LTALK_DEFERS            = 0x05020203,
    OID_LTALK_NO_DATA_ERRORS    = 0x05020204,
    OID_LTALK_RANDOM_CTS_ERRORS = 0x05020205,
}

enum uint OID_ARCNET_PERMANENT_ADDRESS = 0x06010101;
enum uint OID_ARCNET_RECONFIGURATIONS = 0x06020201;

enum : uint
{
    OID_TAPI_ANSWER                      = 0x07030102,
    OID_TAPI_CLOSE                       = 0x07030103,
    OID_TAPI_CLOSE_CALL                  = 0x07030104,
    OID_TAPI_CONDITIONAL_MEDIA_DETECTION = 0x07030105,
}

enum : uint
{
    OID_TAPI_DEV_SPECIFIC        = 0x07030107,
    OID_TAPI_DIAL                = 0x07030108,
    OID_TAPI_DROP                = 0x07030109,
    OID_TAPI_GET_ADDRESS_CAPS    = 0x0703010a,
    OID_TAPI_GET_ADDRESS_ID      = 0x0703010b,
    OID_TAPI_GET_ADDRESS_STATUS  = 0x0703010c,
    OID_TAPI_GET_CALL_ADDRESS_ID = 0x0703010d,
    OID_TAPI_GET_CALL_INFO       = 0x0703010e,
    OID_TAPI_GET_CALL_STATUS     = 0x0703010f,
    OID_TAPI_GET_DEV_CAPS        = 0x07030110,
    OID_TAPI_GET_DEV_CONFIG      = 0x07030111,
    OID_TAPI_GET_EXTENSION_ID    = 0x07030112,
    OID_TAPI_GET_ID              = 0x07030113,
    OID_TAPI_GET_LINE_DEV_STATUS = 0x07030114,
}

enum uint OID_TAPI_NEGOTIATE_EXT_VERSION = 0x07030116;

enum : uint
{
    OID_TAPI_PROVIDER_INITIALIZE = 0x07030118,
    OID_TAPI_PROVIDER_SHUTDOWN   = 0x07030119,
}

enum : uint
{
    OID_TAPI_SELECT_EXT_VERSION  = 0x0703011b,
    OID_TAPI_SEND_USER_USER_INFO = 0x0703011c,
}

enum : uint
{
    OID_TAPI_SET_CALL_PARAMS             = 0x0703011e,
    OID_TAPI_SET_DEFAULT_MEDIA_DETECTION = 0x0703011f,
    OID_TAPI_SET_DEV_CONFIG              = 0x07030120,
    OID_TAPI_SET_MEDIA_MODE              = 0x07030121,
    OID_TAPI_SET_STATUS_MESSAGES         = 0x07030122,
}

enum uint OID_TAPI_MONITOR_DIGITS = 0x07030124;

enum : uint
{
    OID_ATM_SUPPORTED_SERVICE_CATEGORY = 0x08010102,
    OID_ATM_SUPPORTED_AAL_TYPES        = 0x08010103,
}

enum : uint
{
    OID_ATM_MAX_ACTIVE_VCS        = 0x08010105,
    OID_ATM_MAX_ACTIVE_VCI_BITS   = 0x08010106,
    OID_ATM_MAX_ACTIVE_VPI_BITS   = 0x08010107,
    OID_ATM_MAX_AAL0_PACKET_SIZE  = 0x08010108,
    OID_ATM_MAX_AAL1_PACKET_SIZE  = 0x08010109,
    OID_ATM_MAX_AAL34_PACKET_SIZE = 0x0801010a,
    OID_ATM_MAX_AAL5_PACKET_SIZE  = 0x0801010b,
}

enum : uint
{
    OID_ATM_ASSIGNED_VPI                 = 0x08010202,
    OID_ATM_ACQUIRE_ACCESS_NET_RESOURCES = 0x08010203,
}

enum : uint
{
    OID_ATM_ILMI_VPIVCI              = 0x08010205,
    OID_ATM_DIGITAL_BROADCAST_VPIVCI = 0x08010206,
}

enum uint OID_ATM_ALIGNMENT_REQUIRED = 0x08010208;
enum uint OID_ATM_SERVICE_ADDRESS = 0x0801020a;
enum uint OID_ATM_CALL_ALERTING = 0x0801020c;

enum : uint
{
    OID_ATM_CALL_NOTIFY      = 0x0801020e,
    OID_ATM_MY_IP_NM_ADDRESS = 0x0801020f,
}

enum uint OID_ATM_XMIT_CELLS_OK = 0x08020102;
enum uint OID_ATM_RCV_INVALID_VPI_VCI = 0x08020201;
enum uint OID_ATM_RCV_REASSEMBLY_ERROR = 0x08020203;

enum : uint
{
    OID_802_11_SSID                    = 0x0d010102,
    OID_802_11_NETWORK_TYPES_SUPPORTED = 0x0d010203,
    OID_802_11_NETWORK_TYPE_IN_USE     = 0x0d010204,
}

enum : uint
{
    OID_802_11_RSSI                = 0x0d010206,
    OID_802_11_RSSI_TRIGGER        = 0x0d010207,
    OID_802_11_INFRASTRUCTURE_MODE = 0x0d010108,
}

enum : uint
{
    OID_802_11_RTS_THRESHOLD      = 0x0d01020a,
    OID_802_11_NUMBER_OF_ANTENNAS = 0x0d01020b,
}

enum uint OID_802_11_TX_ANTENNA_SELECTED = 0x0d01020d;

enum : uint
{
    OID_802_11_DESIRED_RATES       = 0x0d010210,
    OID_802_11_CONFIGURATION       = 0x0d010211,
    OID_802_11_STATISTICS          = 0x0d020212,
    OID_802_11_ADD_WEP             = 0x0d010113,
    OID_802_11_REMOVE_WEP          = 0x0d010114,
    OID_802_11_DISASSOCIATE        = 0x0d010115,
    OID_802_11_POWER_MODE          = 0x0d010216,
    OID_802_11_BSSID_LIST          = 0x0d010217,
    OID_802_11_AUTHENTICATION_MODE = 0x0d010118,
}

enum : uint
{
    OID_802_11_BSSID_LIST_SCAN   = 0x0d01011a,
    OID_802_11_WEP_STATUS        = 0x0d01011b,
    OID_802_11_ENCRYPTION_STATUS = 0x0d01011b,
}

enum : uint
{
    OID_802_11_ADD_KEY                 = 0x0d01011d,
    OID_802_11_REMOVE_KEY              = 0x0d01011e,
    OID_802_11_ASSOCIATION_INFORMATION = 0x0d01011f,
}

enum uint OID_802_11_MEDIA_STREAM_MODE = 0x0d010121;

enum : uint
{
    OID_802_11_PMKID               = 0x0d010123,
    OID_802_11_NON_BCAST_SSID_LIST = 0x0d010124,
}

enum : uint
{
    NDIS_ETH_TYPE_IPV4          = 0x00000800,
    NDIS_ETH_TYPE_ARP           = 0x00000806,
    NDIS_ETH_TYPE_IPV6          = 0x000086dd,
    NDIS_ETH_TYPE_802_1X        = 0x0000888e,
    NDIS_ETH_TYPE_802_1Q        = 0x00008100,
    NDIS_ETH_TYPE_SLOW_PROTOCOL = 0x00008809,
}

enum : uint
{
    NDIS_802_11_LENGTH_RATES                = 0x00000008,
    NDIS_802_11_LENGTH_RATES_EX             = 0x00000010,
    NDIS_802_11_AUTH_REQUEST_AUTH_FIELDS    = 0x0000000f,
    NDIS_802_11_AUTH_REQUEST_REAUTH         = 0x00000001,
    NDIS_802_11_AUTH_REQUEST_KEYUPDATE      = 0x00000002,
    NDIS_802_11_AUTH_REQUEST_PAIRWISE_ERROR = 0x00000006,
    NDIS_802_11_AUTH_REQUEST_GROUP_ERROR    = 0x0000000e,
}

enum : uint
{
    NDIS_802_11_AI_REQFI_CAPABILITIES     = 0x00000001,
    NDIS_802_11_AI_REQFI_LISTENINTERVAL   = 0x00000002,
    NDIS_802_11_AI_REQFI_CURRENTAPADDRESS = 0x00000004,
    NDIS_802_11_AI_RESFI_CAPABILITIES     = 0x00000001,
    NDIS_802_11_AI_RESFI_STATUSCODE       = 0x00000002,
    NDIS_802_11_AI_RESFI_ASSOCIATIONID    = 0x00000004,
}

enum uint OID_IRDA_TURNAROUND_TIME = 0x0a010101;

enum : uint
{
    OID_IRDA_LINK_SPEED     = 0x0a010103,
    OID_IRDA_MEDIA_BUSY     = 0x0a010104,
    OID_IRDA_EXTRA_RCV_BOFS = 0x0a010200,
}

enum : uint
{
    OID_IRDA_UNICAST_LIST            = 0x0a010202,
    OID_IRDA_MAX_UNICAST_LIST_SIZE   = 0x0a010203,
    OID_IRDA_MAX_RECEIVE_WINDOW_SIZE = 0x0a010204,
    OID_IRDA_MAX_SEND_WINDOW_SIZE    = 0x0a010205,
}

enum uint OID_IRDA_RESERVED2 = 0x0a01020f;
enum uint OID_1394_VC_INFO = 0x0c010102;

enum : uint
{
    OID_CO_DELETE_PVC           = 0xfe000002,
    OID_CO_GET_CALL_INFORMATION = 0xfe000003,
}

enum uint OID_CO_DELETE_ADDRESS = 0xfe000005;
enum uint OID_CO_ADDRESS_CHANGE = 0xfe000007;
enum uint OID_CO_SIGNALING_DISABLED = 0xfe000009;

enum : uint
{
    OID_CO_TAPI_CM_CAPS                   = 0xfe001001,
    OID_CO_TAPI_LINE_CAPS                 = 0xfe001002,
    OID_CO_TAPI_ADDRESS_CAPS              = 0xfe001003,
    OID_CO_TAPI_TRANSLATE_TAPI_CALLPARAMS = 0xfe001004,
    OID_CO_TAPI_TRANSLATE_NDIS_CALLPARAMS = 0xfe001005,
    OID_CO_TAPI_TRANSLATE_TAPI_SAP        = 0xfe001006,
}

enum : uint
{
    OID_CO_TAPI_REPORT_DIGITS      = 0xfe001008,
    OID_CO_TAPI_DONT_REPORT_DIGITS = 0xfe001009,
}

enum : uint
{
    OID_PNP_SET_POWER           = 0xfd010101,
    OID_PNP_QUERY_POWER         = 0xfd010102,
    OID_PNP_ADD_WAKE_UP_PATTERN = 0xfd010103,
}

enum uint OID_PNP_WAKE_UP_PATTERN_LIST = 0xfd010105;

enum : uint
{
    OID_PNP_WAKE_UP_OK    = 0xfd020200,
    OID_PNP_WAKE_UP_ERROR = 0xfd020201,
}

enum uint OID_PM_HARDWARE_CAPABILITIES = 0xfd010108;
enum uint OID_PM_ADD_WOL_PATTERN = 0xfd01010a;
enum uint OID_PM_WOL_PATTERN_LIST = 0xfd01010c;
enum uint OID_PM_GET_PROTOCOL_OFFLOAD = 0xfd01010e;
enum uint OID_PM_PROTOCOL_OFFLOAD_LIST = 0xfd010110;

enum : uint
{
    OID_RECEIVE_FILTER_HARDWARE_CAPABILITIES     = 0x00010221,
    OID_RECEIVE_FILTER_GLOBAL_PARAMETERS         = 0x00010222,
    OID_RECEIVE_FILTER_ALLOCATE_QUEUE            = 0x00010223,
    OID_RECEIVE_FILTER_FREE_QUEUE                = 0x00010224,
    OID_RECEIVE_FILTER_ENUM_QUEUES               = 0x00010225,
    OID_RECEIVE_FILTER_QUEUE_PARAMETERS          = 0x00010226,
    OID_RECEIVE_FILTER_SET_FILTER                = 0x00010227,
    OID_RECEIVE_FILTER_CLEAR_FILTER              = 0x00010228,
    OID_RECEIVE_FILTER_ENUM_FILTERS              = 0x00010229,
    OID_RECEIVE_FILTER_PARAMETERS                = 0x0001022a,
    OID_RECEIVE_FILTER_QUEUE_ALLOCATION_COMPLETE = 0x0001022b,
    OID_RECEIVE_FILTER_CURRENT_CAPABILITIES      = 0x0001022d,
}

enum uint OID_NIC_SWITCH_CURRENT_CAPABILITIES = 0x0001022f;

enum : uint
{
    OID_VLAN_RESERVED1 = 0x00010231,
    OID_VLAN_RESERVED2 = 0x00010232,
    OID_VLAN_RESERVED3 = 0x00010233,
    OID_VLAN_RESERVED4 = 0x00010234,
}

enum : uint
{
    OID_NIC_SWITCH_CREATE_SWITCH    = 0x00010237,
    OID_NIC_SWITCH_PARAMETERS       = 0x00010238,
    OID_NIC_SWITCH_DELETE_SWITCH    = 0x00010239,
    OID_NIC_SWITCH_ENUM_SWITCHES    = 0x00010240,
    OID_NIC_SWITCH_CREATE_VPORT     = 0x00010241,
    OID_NIC_SWITCH_VPORT_PARAMETERS = 0x00010242,
    OID_NIC_SWITCH_ENUM_VPORTS      = 0x00010243,
    OID_NIC_SWITCH_DELETE_VPORT     = 0x00010244,
    OID_NIC_SWITCH_ALLOCATE_VF      = 0x00010245,
    OID_NIC_SWITCH_FREE_VF          = 0x00010246,
    OID_NIC_SWITCH_VF_PARAMETERS    = 0x00010247,
    OID_NIC_SWITCH_ENUM_VFS         = 0x00010248,
}

enum uint OID_SRIOV_CURRENT_CAPABILITIES = 0x00010250;
enum uint OID_SRIOV_WRITE_VF_CONFIG_SPACE = 0x00010252;
enum uint OID_SRIOV_WRITE_VF_CONFIG_BLOCK = 0x00010254;
enum uint OID_SRIOV_SET_VF_POWER_STATE = 0x00010256;

enum : uint
{
    OID_SRIOV_PROBED_BARS      = 0x00010258,
    OID_SRIOV_BAR_RESOURCES    = 0x00010259,
    OID_SRIOV_PF_LUID          = 0x00010260,
    OID_SRIOV_CONFIG_STATE     = 0x00010261,
    OID_SRIOV_VF_SERIAL_NUMBER = 0x00010262,
}

enum uint OID_SRIOV_VF_INVALIDATE_CONFIG_BLOCK = 0x00010269;

enum : uint
{
    OID_SWITCH_PROPERTY_UPDATE      = 0x00010264,
    OID_SWITCH_PROPERTY_DELETE      = 0x00010265,
    OID_SWITCH_PROPERTY_ENUM        = 0x00010266,
    OID_SWITCH_FEATURE_STATUS_QUERY = 0x00010267,
}

enum : uint
{
    OID_SWITCH_PORT_PROPERTY_ADD                = 0x00010271,
    OID_SWITCH_PORT_PROPERTY_UPDATE             = 0x00010272,
    OID_SWITCH_PORT_PROPERTY_DELETE             = 0x00010273,
    OID_SWITCH_PORT_PROPERTY_ENUM               = 0x00010274,
    OID_SWITCH_PARAMETERS                       = 0x00010275,
    OID_SWITCH_PORT_ARRAY                       = 0x00010276,
    OID_SWITCH_NIC_ARRAY                        = 0x00010277,
    OID_SWITCH_PORT_CREATE                      = 0x00010278,
    OID_SWITCH_PORT_DELETE                      = 0x00010279,
    OID_SWITCH_NIC_CREATE                       = 0x0001027a,
    OID_SWITCH_NIC_CONNECT                      = 0x0001027b,
    OID_SWITCH_NIC_DISCONNECT                   = 0x0001027c,
    OID_SWITCH_NIC_DELETE                       = 0x0001027d,
    OID_SWITCH_PORT_FEATURE_STATUS_QUERY        = 0x0001027e,
    OID_SWITCH_PORT_TEARDOWN                    = 0x0001027f,
    OID_SWITCH_NIC_SAVE                         = 0x00010290,
    OID_SWITCH_NIC_SAVE_COMPLETE                = 0x00010291,
    OID_SWITCH_NIC_RESTORE                      = 0x00010292,
    OID_SWITCH_NIC_RESTORE_COMPLETE             = 0x00010293,
    OID_SWITCH_NIC_UPDATED                      = 0x00010294,
    OID_SWITCH_PORT_UPDATED                     = 0x00010295,
    OID_SWITCH_NIC_DIRECT_REQUEST               = 0x00010296,
    OID_SWITCH_NIC_SUSPEND                      = 0x00010297,
    OID_SWITCH_NIC_RESUME                       = 0x00010298,
    OID_SWITCH_NIC_SUSPENDED_LM_SOURCE_STARTED  = 0x00010299,
    OID_SWITCH_NIC_SUSPENDED_LM_SOURCE_FINISHED = 0x0001029a,
}

enum uint OID_GEN_ISOLATION_PARAMETERS = 0x00010300;
enum uint OID_GFT_CURRENT_CAPABILITIES = 0x00010402;
enum uint OID_GFT_CREATE_TABLE = 0x00010404;

enum : uint
{
    OID_GFT_ENUM_TABLES       = 0x00010406,
    OID_GFT_ALLOCATE_COUNTERS = 0x00010407,
}

enum uint OID_GFT_ENUM_COUNTERS = 0x00010409;

enum : uint
{
    OID_GFT_STATISTICS       = 0x0001040b,
    OID_GFT_ADD_FLOW_ENTRIES = 0x0001040c,
}

enum uint OID_GFT_ENUM_FLOW_ENTRIES = 0x0001040e;
enum uint OID_GFT_DEACTIVATE_FLOW_ENTRIES = 0x00010410;
enum uint OID_GFT_EXACT_MATCH_PROFILE = 0x00010412;
enum uint OID_GFT_WILDCARD_MATCH_PROFILE = 0x00010414;
enum uint OID_GFT_DELETE_PROFILE = 0x00010416;
enum uint OID_GFT_CREATE_LOGICAL_VPORT = 0x00010418;
enum uint OID_GFT_ENUM_LOGICAL_VPORTS = 0x0001041a;

enum : uint
{
    OID_QOS_OFFLOAD_CURRENT_CAPABILITIES = 0x00010602,
    OID_QOS_OFFLOAD_CREATE_SQ            = 0x00010603,
    OID_QOS_OFFLOAD_DELETE_SQ            = 0x00010604,
    OID_QOS_OFFLOAD_UPDATE_SQ            = 0x00010605,
    OID_QOS_OFFLOAD_ENUM_SQS             = 0x00010606,
    OID_QOS_OFFLOAD_SQ_STATS             = 0x00010607,
}

enum uint OID_PD_CLOSE_PROVIDER = 0x00010502;

enum : uint
{
    NDIS_PNP_WAKE_UP_MAGIC_PACKET  = 0x00000001,
    NDIS_PNP_WAKE_UP_PATTERN_MATCH = 0x00000002,
    NDIS_PNP_WAKE_UP_LINK_CHANGE   = 0x00000004,
}

enum : uint
{
    OID_TCP_TASK_IPSEC_ADD_SA    = 0xfc010202,
    OID_TCP_TASK_IPSEC_DELETE_SA = 0xfc010203,
}

enum : uint
{
    OID_TCP_TASK_IPSEC_ADD_UDPESP_SA    = 0xfc010205,
    OID_TCP_TASK_IPSEC_DELETE_UDPESP_SA = 0xfc010206,
}

enum uint OID_TCP6_OFFLOAD_STATS = 0xfc010208;
enum uint OID_IP6_OFFLOAD_STATS = 0xfc01020a;

enum : uint
{
    OID_TCP_OFFLOAD_PARAMETERS            = 0xfc01020c,
    OID_TCP_OFFLOAD_HARDWARE_CAPABILITIES = 0xfc01020d,
}

enum uint OID_TCP_CONNECTION_OFFLOAD_HARDWARE_CAPABILITIES = 0xfc01020f;

enum : uint
{
    OID_TCP_TASK_IPSEC_OFFLOAD_V2_ADD_SA    = 0xfc030202,
    OID_TCP_TASK_IPSEC_OFFLOAD_V2_DELETE_SA = 0xfc030203,
    OID_TCP_TASK_IPSEC_OFFLOAD_V2_UPDATE_SA = 0xfc030204,
    OID_TCP_TASK_IPSEC_OFFLOAD_V2_ADD_SA_EX = 0xfc030205,
}

enum : uint
{
    OID_FFP_FLUSH        = 0xfc010211,
    OID_FFP_CONTROL      = 0xfc010212,
    OID_FFP_PARAMS       = 0xfc010213,
    OID_FFP_DATA         = 0xfc010214,
    OID_FFP_DRIVER_STATS = 0xfc020210,
}

enum uint OID_TCP_CONNECTION_OFFLOAD_PARAMETERS = 0xfc030201;
enum uint OID_TUNNEL_INTERFACE_RELEASE_OID = 0x0f010107;

enum : uint
{
    OID_QOS_RESERVED2  = 0xfb010101,
    OID_QOS_RESERVED3  = 0xfb010102,
    OID_QOS_RESERVED4  = 0xfb010103,
    OID_QOS_RESERVED5  = 0xfb010104,
    OID_QOS_RESERVED6  = 0xfb010105,
    OID_QOS_RESERVED7  = 0xfb010106,
    OID_QOS_RESERVED8  = 0xfb010107,
    OID_QOS_RESERVED9  = 0xfb010108,
    OID_QOS_RESERVED10 = 0xfb010109,
    OID_QOS_RESERVED11 = 0xfb01010a,
    OID_QOS_RESERVED12 = 0xfb01010b,
    OID_QOS_RESERVED13 = 0xfb01010c,
    OID_QOS_RESERVED14 = 0xfb01010d,
    OID_QOS_RESERVED15 = 0xfb01010e,
    OID_QOS_RESERVED16 = 0xfb01010f,
    OID_QOS_RESERVED17 = 0xfb010110,
    OID_QOS_RESERVED18 = 0xfb010111,
    OID_QOS_RESERVED19 = 0xfb010112,
    OID_QOS_RESERVED20 = 0xfb010113,
}

enum : uint
{
    OFFLOAD_MAX_SAS     = 0x00000003,
    OFFLOAD_INBOUND_SA  = 0x00000001,
    OFFLOAD_OUTBOUND_SA = 0x00000002,
}

enum : uint
{
    NDIS_PROTOCOL_ID_TCP_IP = 0x00000002,
    NDIS_PROTOCOL_ID_IP6    = 0x00000003,
    NDIS_PROTOCOL_ID_IPX    = 0x00000006,
    NDIS_PROTOCOL_ID_NBF    = 0x00000007,
    NDIS_PROTOCOL_ID_MAX    = 0x0000000f,
    NDIS_PROTOCOL_ID_MASK   = 0x0000000f,
}

enum uint CLOCK_NETWORK_DERIVED = 0x00000002;
enum uint RECEIVE_TIME_INDICATION_CAPABLE = 0x00000008;
enum uint TIME_STAMP_CAPABLE = 0x00000020;

enum : uint
{
    NDIS_DEVICE_WAKE_ON_PATTERN_MATCH_ENABLE = 0x00000002,
    NDIS_DEVICE_WAKE_ON_MAGIC_PACKET_ENABLE  = 0x00000004,
}

enum : uint
{
    fNDIS_GUID_TO_OID                = 0x00000001,
    fNDIS_GUID_TO_STATUS             = 0x00000002,
    fNDIS_GUID_ANSI_STRING           = 0x00000004,
    fNDIS_GUID_UNICODE_STRING        = 0x00000008,
    fNDIS_GUID_ARRAY                 = 0x00000010,
    fNDIS_GUID_ALLOW_READ            = 0x00000020,
    fNDIS_GUID_ALLOW_WRITE           = 0x00000040,
    fNDIS_GUID_METHOD                = 0x00000080,
    fNDIS_GUID_NDIS_RESERVED         = 0x00000100,
    fNDIS_GUID_SUPPORT_COMMON_HEADER = 0x00000200,
}

enum : uint
{
    NDIS_PACKET_TYPE_MULTICAST      = 0x00000002,
    NDIS_PACKET_TYPE_ALL_MULTICAST  = 0x00000004,
    NDIS_PACKET_TYPE_BROADCAST      = 0x00000008,
    NDIS_PACKET_TYPE_SOURCE_ROUTING = 0x00000010,
    NDIS_PACKET_TYPE_PROMISCUOUS    = 0x00000020,
    NDIS_PACKET_TYPE_SMT            = 0x00000040,
    NDIS_PACKET_TYPE_ALL_LOCAL      = 0x00000080,
    NDIS_PACKET_TYPE_GROUP          = 0x00001000,
    NDIS_PACKET_TYPE_ALL_FUNCTIONAL = 0x00002000,
    NDIS_PACKET_TYPE_FUNCTIONAL     = 0x00004000,
    NDIS_PACKET_TYPE_MAC_FRAME      = 0x00008000,
    NDIS_PACKET_TYPE_NO_LOCAL       = 0x00010000,
}

enum : uint
{
    NDIS_RING_HARD_ERROR      = 0x00004000,
    NDIS_RING_SOFT_ERROR      = 0x00002000,
    NDIS_RING_TRANSMIT_BEACON = 0x00001000,
}

enum uint NDIS_RING_AUTO_REMOVAL_ERROR = 0x00000400;
enum uint NDIS_RING_COUNTER_OVERFLOW = 0x00000100;
enum uint NDIS_RING_RING_RECOVERY = 0x00000040;

enum : uint
{
    NDIS_PROT_OPTION_NO_LOOPBACK       = 0x00000002,
    NDIS_PROT_OPTION_NO_RSVD_ON_RCVPKT = 0x00000004,
    NDIS_PROT_OPTION_SEND_RESTRICTED   = 0x00000008,
}

enum : uint
{
    NDIS_MAC_OPTION_RECEIVE_SERIALIZED             = 0x00000002,
    NDIS_MAC_OPTION_TRANSFERS_NOT_PEND             = 0x00000004,
    NDIS_MAC_OPTION_NO_LOOPBACK                    = 0x00000008,
    NDIS_MAC_OPTION_FULL_DUPLEX                    = 0x00000010,
    NDIS_MAC_OPTION_EOTX_INDICATION                = 0x00000020,
    NDIS_MAC_OPTION_8021P_PRIORITY                 = 0x00000040,
    NDIS_MAC_OPTION_SUPPORTS_MAC_ADDRESS_OVERWRITE = 0x00000080,
}

enum : uint
{
    NDIS_MAC_OPTION_8021Q_VLAN = 0x00000200,
    NDIS_MAC_OPTION_RESERVED   = 0x80000000,
}

enum uint NDIS_MEDIA_CAP_RECEIVE = 0x00000002;
enum uint NDIS_LINK_STATE_XMIT_LINK_SPEED_AUTO_NEGOTIATED = 0x00000001;

enum : uint
{
    NDIS_LINK_STATE_DUPLEX_AUTO_NEGOTIATED          = 0x00000004,
    NDIS_LINK_STATE_PAUSE_FUNCTIONS_AUTO_NEGOTIATED = 0x00000008,
}

enum uint NDIS_LINK_PARAMETERS_REVISION_1 = 0x00000001;
enum uint MAXIMUM_IP_OPER_STATUS_ADDRESS_FAMILIES_SUPPORTED = 0x00000020;
enum uint NDIS_IP_OPER_STATE_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_OFFLOAD_PARAMETERS_TX_RX_DISABLED             = 0x00000001,
    NDIS_OFFLOAD_PARAMETERS_TX_ENABLED_RX_DISABLED     = 0x00000002,
    NDIS_OFFLOAD_PARAMETERS_RX_ENABLED_TX_DISABLED     = 0x00000003,
    NDIS_OFFLOAD_PARAMETERS_TX_RX_ENABLED              = 0x00000004,
    NDIS_OFFLOAD_PARAMETERS_LSOV1_DISABLED             = 0x00000001,
    NDIS_OFFLOAD_PARAMETERS_LSOV1_ENABLED              = 0x00000002,
    NDIS_OFFLOAD_PARAMETERS_IPSECV1_DISABLED           = 0x00000001,
    NDIS_OFFLOAD_PARAMETERS_IPSECV1_AH_ENABLED         = 0x00000002,
    NDIS_OFFLOAD_PARAMETERS_IPSECV1_ESP_ENABLED        = 0x00000003,
    NDIS_OFFLOAD_PARAMETERS_IPSECV1_AH_AND_ESP_ENABLED = 0x00000004,
    NDIS_OFFLOAD_PARAMETERS_LSOV2_DISABLED             = 0x00000001,
    NDIS_OFFLOAD_PARAMETERS_LSOV2_ENABLED              = 0x00000002,
    NDIS_OFFLOAD_PARAMETERS_IPSECV2_DISABLED           = 0x00000001,
    NDIS_OFFLOAD_PARAMETERS_IPSECV2_AH_ENABLED         = 0x00000002,
    NDIS_OFFLOAD_PARAMETERS_IPSECV2_ESP_ENABLED        = 0x00000003,
    NDIS_OFFLOAD_PARAMETERS_IPSECV2_AH_AND_ESP_ENABLED = 0x00000004,
    NDIS_OFFLOAD_PARAMETERS_RSC_DISABLED               = 0x00000001,
    NDIS_OFFLOAD_PARAMETERS_RSC_ENABLED                = 0x00000002,
}

enum uint NDIS_ENCAPSULATION_TYPE_VXLAN = 0x00000002;

enum : uint
{
    NDIS_OFFLOAD_PARAMETERS_CONNECTION_OFFLOAD_ENABLED = 0x00000002,
    NDIS_OFFLOAD_PARAMETERS_USO_DISABLED               = 0x00000001,
    NDIS_OFFLOAD_PARAMETERS_USO_ENABLED                = 0x00000002,
    NDIS_OFFLOAD_PARAMETERS_REVISION_1                 = 0x00000001,
    NDIS_OFFLOAD_PARAMETERS_REVISION_2                 = 0x00000002,
    NDIS_OFFLOAD_PARAMETERS_REVISION_3                 = 0x00000003,
    NDIS_OFFLOAD_PARAMETERS_REVISION_4                 = 0x00000004,
    NDIS_OFFLOAD_PARAMETERS_REVISION_5                 = 0x00000005,
    NDIS_OFFLOAD_PARAMETERS_REVISION_6                 = 0x00000006,
    NDIS_OFFLOAD_PARAMETERS_SKIP_REGISTRY_UPDATE       = 0x00000001,
}

enum : uint
{
    IPSEC_OFFLOAD_V2_AUTHENTICATION_SHA_1       = 0x00000002,
    IPSEC_OFFLOAD_V2_AUTHENTICATION_SHA_256     = 0x00000004,
    IPSEC_OFFLOAD_V2_AUTHENTICATION_AES_GCM_128 = 0x00000008,
    IPSEC_OFFLOAD_V2_AUTHENTICATION_AES_GCM_192 = 0x00000010,
    IPSEC_OFFLOAD_V2_AUTHENTICATION_AES_GCM_256 = 0x00000020,
}

enum : uint
{
    IPSEC_OFFLOAD_V2_ENCRYPTION_DES_CBC     = 0x00000002,
    IPSEC_OFFLOAD_V2_ENCRYPTION_3_DES_CBC   = 0x00000004,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_GCM_128 = 0x00000008,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_GCM_192 = 0x00000010,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_GCM_256 = 0x00000020,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_CBC_128 = 0x00000040,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_CBC_192 = 0x00000080,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_CBC_256 = 0x00000100,
}

enum : uint
{
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_NOT_SUPPORTED = 0x00000000,
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_INNER_IPV4    = 0x00000001,
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_OUTER_IPV4    = 0x00000002,
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_INNER_IPV6    = 0x00000004,
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_OUTER_IPV6    = 0x00000008,
}

enum : uint
{
    IPSEC_OFFLOAD_V2_AND_TCP_CHECKSUM_COEXISTENCE = 0x00000002,
    IPSEC_OFFLOAD_V2_AND_UDP_CHECKSUM_COEXISTENCE = 0x00000004,
}

enum : uint
{
    NDIS_OFFLOAD_REVISION_2 = 0x00000002,
    NDIS_OFFLOAD_REVISION_3 = 0x00000003,
    NDIS_OFFLOAD_REVISION_4 = 0x00000004,
    NDIS_OFFLOAD_REVISION_5 = 0x00000005,
    NDIS_OFFLOAD_REVISION_6 = 0x00000006,
    NDIS_OFFLOAD_REVISION_7 = 0x00000007,
    NDIS_OFFLOAD_REVISION_8 = 0x00000008,
}

enum uint NDIS_TCP_CONNECTION_OFFLOAD_REVISION_2 = 0x00000002;
enum uint NDIS_WMI_DEFAULT_METHOD_ID = 0x00000001;

enum : uint
{
    NDIS_WMI_OBJECT_TYPE_METHOD       = 0x00000002,
    NDIS_WMI_OBJECT_TYPE_EVENT        = 0x00000003,
    NDIS_WMI_OBJECT_TYPE_ENUM_ADAPTER = 0x00000004,
    NDIS_WMI_OBJECT_TYPE_OUTPUT_INFO  = 0x00000005,
}

enum uint NDIS_WMI_SET_HEADER_REVISION_1 = 0x00000001;
enum uint NDIS_WMI_ENUM_ADAPTER_REVISION_1 = 0x00000001;
enum uint NDIS_HD_SPLIT_PARAMETERS_REVISION_1 = 0x00000001;
enum uint NDIS_HD_SPLIT_CURRENT_CONFIG_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_HD_SPLIT_CAPS_SUPPORTS_IPV4_OPTIONS           = 0x00000002,
    NDIS_HD_SPLIT_CAPS_SUPPORTS_IPV6_EXTENSION_HEADERS = 0x00000004,
    NDIS_HD_SPLIT_CAPS_SUPPORTS_TCP_OPTIONS            = 0x00000008,
}

enum uint NDIS_PM_WOL_BITMAP_PATTERN_SUPPORTED = 0x00000001;

enum : uint
{
    NDIS_PM_WOL_IPV4_TCP_SYN_SUPPORTED            = 0x00000004,
    NDIS_PM_WOL_IPV6_TCP_SYN_SUPPORTED            = 0x00000008,
    NDIS_PM_WOL_IPV4_DEST_ADDR_WILDCARD_SUPPORTED = 0x00000200,
}

enum uint NDIS_PM_WOL_EAPOL_REQUEST_ID_MESSAGE_SUPPORTED = 0x00010000;

enum : uint
{
    NDIS_PM_PROTOCOL_OFFLOAD_NS_SUPPORTED              = 0x00000002,
    NDIS_PM_PROTOCOL_OFFLOAD_80211_RSN_REKEY_SUPPORTED = 0x00000080,
}

enum uint NDIS_PM_WAKE_ON_MEDIA_DISCONNECT_SUPPORTED = 0x00000002;
enum uint NDIS_WLAN_WAKE_ON_AP_ASSOCIATION_LOST_SUPPORTED = 0x00000002;
enum uint NDIS_WLAN_WAKE_ON_4WAY_HANDSHAKE_REQUEST_SUPPORTED = 0x00000008;
enum uint NDIS_WLAN_WAKE_ON_CLIENT_DRIVER_DIAGNOSTIC_SUPPORTED = 0x00000020;

enum : uint
{
    NDIS_WWAN_WAKE_ON_SMS_RECEIVE_SUPPORTED  = 0x00000002,
    NDIS_WWAN_WAKE_ON_USSD_RECEIVE_SUPPORTED = 0x00000004,
    NDIS_WWAN_WAKE_ON_PACKET_STATE_SUPPORTED = 0x00000008,
    NDIS_WWAN_WAKE_ON_UICC_CHANGE_SUPPORTED  = 0x00000010,
}

enum uint NDIS_PM_SELECTIVE_SUSPEND_SUPPORTED = 0x00000002;
enum uint NDIS_PM_WOL_MAGIC_PACKET_ENABLED = 0x00000002;

enum : uint
{
    NDIS_PM_WOL_IPV6_TCP_SYN_ENABLED            = 0x00000008,
    NDIS_PM_WOL_IPV4_DEST_ADDR_WILDCARD_ENABLED = 0x00000200,
}

enum uint NDIS_PM_WOL_EAPOL_REQUEST_ID_MESSAGE_ENABLED = 0x00010000;

enum : uint
{
    NDIS_PM_PROTOCOL_OFFLOAD_NS_ENABLED              = 0x00000002,
    NDIS_PM_PROTOCOL_OFFLOAD_80211_RSN_REKEY_ENABLED = 0x00000080,
}

enum uint NDIS_PM_WAKE_ON_MEDIA_DISCONNECT_ENABLED = 0x00000002;

enum : uint
{
    NDIS_WLAN_WAKE_ON_NLO_DISCOVERY_ENABLED       = 0x00000001,
    NDIS_WLAN_WAKE_ON_AP_ASSOCIATION_LOST_ENABLED = 0x00000002,
}

enum uint NDIS_WLAN_WAKE_ON_4WAY_HANDSHAKE_REQUEST_ENABLED = 0x00000008;
enum uint NDIS_WLAN_WAKE_ON_CLIENT_DRIVER_DIAGNOSTIC_ENABLED = 0x00000020;

enum : uint
{
    NDIS_WWAN_WAKE_ON_SMS_RECEIVE_ENABLED  = 0x00000002,
    NDIS_WWAN_WAKE_ON_USSD_RECEIVE_ENABLED = 0x00000004,
    NDIS_WWAN_WAKE_ON_PACKET_STATE_ENABLED = 0x00000008,
    NDIS_WWAN_WAKE_ON_UICC_CHANGE_ENABLED  = 0x00000010,
}

enum : uint
{
    NDIS_PM_WOL_PRIORITY_NORMAL  = 0x10000000,
    NDIS_PM_WOL_PRIORITY_HIGHEST = 0x00000001,
}

enum : uint
{
    NDIS_PM_PROTOCOL_OFFLOAD_PRIORITY_NORMAL  = 0x10000000,
    NDIS_PM_PROTOCOL_OFFLOAD_PRIORITY_HIGHEST = 0x00000001,
}

enum : uint
{
    NDIS_PM_CAPABILITIES_REVISION_1 = 0x00000001,
    NDIS_PM_CAPABILITIES_REVISION_2 = 0x00000002,
}

enum uint NDIS_PM_PARAMETERS_REVISION_2 = 0x00000002;
enum uint NDIS_PM_MAX_PATTERN_ID = 0x0000ffff;

enum : uint
{
    NDIS_PM_WOL_PATTERN_REVISION_1 = 0x00000001,
    NDIS_PM_WOL_PATTERN_REVISION_2 = 0x00000002,
}

enum : uint
{
    DOT11_RSN_KEK_LENGTH            = 0x00000010,
    DOT11_RSN_MAX_CIPHER_KEY_LENGTH = 0x00000020,
}

enum uint NDIS_PM_PROTOCOL_OFFLOAD_REVISION_2 = 0x00000002;

enum : uint
{
    NDIS_PM_WAKE_REASON_REVISION_1 = 0x00000001,
    NDIS_PM_WAKE_PACKET_REVISION_1 = 0x00000001,
}

enum uint NDIS_WMI_PM_ACTIVE_CAPABILITIES_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_RECEIVE_FILTER_IPV4_HEADER_SUPPORTED            = 0x00000002,
    NDIS_RECEIVE_FILTER_IPV6_HEADER_SUPPORTED            = 0x00000004,
    NDIS_RECEIVE_FILTER_ARP_HEADER_SUPPORTED             = 0x00000008,
    NDIS_RECEIVE_FILTER_UDP_HEADER_SUPPORTED             = 0x00000010,
    NDIS_RECEIVE_FILTER_MAC_HEADER_DEST_ADDR_SUPPORTED   = 0x00000001,
    NDIS_RECEIVE_FILTER_MAC_HEADER_SOURCE_ADDR_SUPPORTED = 0x00000002,
    NDIS_RECEIVE_FILTER_MAC_HEADER_PROTOCOL_SUPPORTED    = 0x00000004,
    NDIS_RECEIVE_FILTER_MAC_HEADER_VLAN_ID_SUPPORTED     = 0x00000008,
    NDIS_RECEIVE_FILTER_MAC_HEADER_PRIORITY_SUPPORTED    = 0x00000010,
    NDIS_RECEIVE_FILTER_MAC_HEADER_PACKET_TYPE_SUPPORTED = 0x00000020,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_ARP_HEADER_SPA_SUPPORTED       = 0x00000002,
    NDIS_RECEIVE_FILTER_ARP_HEADER_TPA_SUPPORTED       = 0x00000004,
    NDIS_RECEIVE_FILTER_IPV4_HEADER_PROTOCOL_SUPPORTED = 0x00000001,
    NDIS_RECEIVE_FILTER_IPV6_HEADER_PROTOCOL_SUPPORTED = 0x00000001,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_TEST_HEADER_FIELD_EQUAL_SUPPORTED      = 0x00000001,
    NDIS_RECEIVE_FILTER_TEST_HEADER_FIELD_MASK_EQUAL_SUPPORTED = 0x00000002,
    NDIS_RECEIVE_FILTER_TEST_HEADER_FIELD_NOT_EQUAL_SUPPORTED  = 0x00000004,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_VM_QUEUE_SUPPORTED                          = 0x00000002,
    NDIS_RECEIVE_FILTER_LOOKAHEAD_SPLIT_SUPPORTED                   = 0x00000004,
    NDIS_RECEIVE_FILTER_DYNAMIC_PROCESSOR_AFFINITY_CHANGE_SUPPORTED = 0x00000008,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_IMPLAT_MIN_OF_QUEUES_MODE                    = 0x00000040,
    NDIS_RECEIVE_FILTER_IMPLAT_SUM_OF_QUEUES_MODE                    = 0x00000080,
    NDIS_RECEIVE_FILTER_PACKET_COALESCING_SUPPORTED_ON_DEFAULT_QUEUE = 0x00000100,
}

enum uint NDIS_RECEIVE_FILTER_DYNAMIC_PROCESSOR_AFFINITY_CHANGE_FOR_DEFAULT_QUEUE_SUPPORTED = 0x00000040;
enum uint NDIS_RECEIVE_FILTER_PACKET_COALESCING_FILTERS_ENABLED = 0x00000002;

enum : uint
{
    NDIS_RECEIVE_FILTER_CAPABILITIES_REVISION_1 = 0x00000001,
    NDIS_RECEIVE_FILTER_CAPABILITIES_REVISION_2 = 0x00000002,
}

enum uint NDIS_NIC_SWITCH_CAPS_PER_VPORT_INTERRUPT_MODERATION_SUPPORTED = 0x00000002;

enum : uint
{
    NDIS_NIC_SWITCH_CAPS_VF_RSS_SUPPORTED                      = 0x00000008,
    NDIS_NIC_SWITCH_CAPS_SINGLE_VPORT_POOL                     = 0x00000010,
    NDIS_NIC_SWITCH_CAPS_RSS_PARAMETERS_PER_PF_VPORT_SUPPORTED = 0x00000020,
}

enum : uint
{
    NDIS_NIC_SWITCH_CAPS_RSS_ON_PF_VPORTS_SUPPORTED                         = 0x00000080,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_INDIRECTION_TABLE_SUPPORTED       = 0x00000100,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_HASH_FUNCTION_SUPPORTED           = 0x00000200,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_HASH_TYPE_SUPPORTED               = 0x00000400,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_HASH_KEY_SUPPORTED                = 0x00000800,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_INDIRECTION_TABLE_SIZE_RESTRICTED = 0x00001000,
}

enum : uint
{
    NDIS_NIC_SWITCH_CAPABILITIES_REVISION_2 = 0x00000002,
    NDIS_NIC_SWITCH_CAPABILITIES_REVISION_3 = 0x00000003,
}

enum : uint
{
    NDIS_DEFAULT_RECEIVE_QUEUE_ID       = 0x00000000,
    NDIS_DEFAULT_RECEIVE_QUEUE_GROUP_ID = 0x00000000,
    NDIS_DEFAULT_RECEIVE_FILTER_ID      = 0x00000000,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_RESERVED                    = 0x000000fe,
    NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_REVISION_1 = 0x00000001,
    NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_REVISION_2 = 0x00000002,
    NDIS_RECEIVE_FILTER_FLAGS_RESERVED              = 0x00000001,
    NDIS_RECEIVE_FILTER_PACKET_ENCAPSULATION_GRE    = 0x00000002,
    NDIS_RECEIVE_FILTER_PACKET_ENCAPSULATION        = 0x00000002,
    NDIS_RECEIVE_FILTER_PARAMETERS_REVISION_1       = 0x00000001,
    NDIS_RECEIVE_FILTER_PARAMETERS_REVISION_2       = 0x00000002,
    NDIS_RECEIVE_FILTER_CLEAR_PARAMETERS_REVISION_1 = 0x00000001,
}

enum : uint
{
    NDIS_RECEIVE_QUEUE_PARAMETERS_LOOKAHEAD_SPLIT_REQUIRED               = 0x00000002,
    NDIS_RECEIVE_QUEUE_PARAMETERS_FLAGS_CHANGED                          = 0x00010000,
    NDIS_RECEIVE_QUEUE_PARAMETERS_PROCESSOR_AFFINITY_CHANGED             = 0x00020000,
    NDIS_RECEIVE_QUEUE_PARAMETERS_SUGGESTED_RECV_BUFFER_NUMBERS_CHANGED  = 0x00040000,
    NDIS_RECEIVE_QUEUE_PARAMETERS_NAME_CHANGED                           = 0x00080000,
    NDIS_RECEIVE_QUEUE_PARAMETERS_INTERRUPT_COALESCING_DOMAIN_ID_CHANGED = 0x00100000,
    NDIS_RECEIVE_QUEUE_PARAMETERS_QOS_SQ_ID_CHANGED                      = 0x00200000,
    NDIS_RECEIVE_QUEUE_PARAMETERS_CHANGE_MASK                            = 0xffff0000,
    NDIS_RECEIVE_QUEUE_PARAMETERS_REVISION_1                             = 0x00000001,
    NDIS_RECEIVE_QUEUE_PARAMETERS_REVISION_2                             = 0x00000002,
    NDIS_RECEIVE_QUEUE_PARAMETERS_REVISION_3                             = 0x00000003,
    NDIS_RECEIVE_QUEUE_FREE_PARAMETERS_REVISION_1                        = 0x00000001,
    NDIS_RECEIVE_QUEUE_INFO_REVISION_1                                   = 0x00000001,
    NDIS_RECEIVE_QUEUE_INFO_REVISION_2                                   = 0x00000002,
    NDIS_RECEIVE_QUEUE_INFO_ARRAY_REVISION_1                             = 0x00000001,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_INFO_ARRAY_REVISION_1         = 0x00000001,
    NDIS_RECEIVE_FILTER_INFO_ARRAY_REVISION_2         = 0x00000002,
    NDIS_RECEIVE_FILTER_INFO_ARRAY_VPORT_ID_SPECIFIED = 0x00000001,
}

enum uint NDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_ARRAY_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_RECEIVE_SCALE_CAPABILITIES_REVISION_2 = 0x00000002,
    NDIS_RECEIVE_SCALE_CAPABILITIES_REVISION_3 = 0x00000003,
}

enum : uint
{
    NDIS_RSS_CAPS_HASH_TYPE_TCP_IPV6    = 0x00000200,
    NDIS_RSS_CAPS_HASH_TYPE_TCP_IPV6_EX = 0x00000400,
    NDIS_RSS_CAPS_HASH_TYPE_UDP_IPV4    = 0x00000800,
    NDIS_RSS_CAPS_HASH_TYPE_UDP_IPV6    = 0x00001000,
    NDIS_RSS_CAPS_HASH_TYPE_UDP_IPV6_EX = 0x00002000,
}

enum : uint
{
    NDIS_RSS_CAPS_CLASSIFICATION_AT_ISR = 0x02000000,
    NDIS_RSS_CAPS_CLASSIFICATION_AT_DPC = 0x04000000,
}

enum uint NDIS_RSS_CAPS_RSS_AVAILABLE_ON_PORTS = 0x10000000;
enum uint NDIS_RSS_CAPS_SUPPORTS_INDEPENDENT_ENTRY_MOVE = 0x40000000;

enum : uint
{
    NDIS_RSS_PARAM_FLAG_HASH_INFO_UNCHANGED         = 0x00000002,
    NDIS_RSS_PARAM_FLAG_ITABLE_UNCHANGED            = 0x00000004,
    NDIS_RSS_PARAM_FLAG_HASH_KEY_UNCHANGED          = 0x00000008,
    NDIS_RSS_PARAM_FLAG_DISABLE_RSS                 = 0x00000010,
    NDIS_RSS_PARAM_FLAG_DEFAULT_PROCESSOR_UNCHANGED = 0x00000020,
}

enum uint NDIS_RSS_HASH_SECRET_KEY_SIZE_REVISION_1 = 0x00000028;

enum : uint
{
    NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_2 = 0x00000002,
    NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_3 = 0x00000003,
}

enum : uint
{
    NDIS_RSS_HASH_SECRET_KEY_MAX_SIZE_REVISION_1 = 0x00000028,
    NDIS_RSS_HASH_SECRET_KEY_MAX_SIZE_REVISION_2 = 0x00000028,
    NDIS_RSS_HASH_SECRET_KEY_MAX_SIZE_REVISION_3 = 0x00000028,
}

enum : uint
{
    NDIS_RECEIVE_SCALE_PARAM_ENABLE_RSS                = 0x00000001,
    NDIS_RECEIVE_SCALE_PARAM_HASH_INFO_CHANGED         = 0x00000002,
    NDIS_RECEIVE_SCALE_PARAM_HASH_KEY_CHANGED          = 0x00000004,
    NDIS_RECEIVE_SCALE_PARAM_NUMBER_OF_QUEUES_CHANGED  = 0x00000008,
    NDIS_RECEIVE_SCALE_PARAM_NUMBER_OF_ENTRIES_CHANGED = 0x00000010,
}

enum : uint
{
    NDIS_RSS_SET_INDIRECTION_ENTRY_FLAG_DEFAULT_PROCESSOR = 0x00000002,
    NDIS_RSS_SET_INDIRECTION_ENTRIES_REVISION_1           = 0x00000001,
}

enum : uint
{
    NDIS_RECEIVE_HASH_FLAG_HASH_INFO_UNCHANGED = 0x00000002,
    NDIS_RECEIVE_HASH_FLAG_HASH_KEY_UNCHANGED  = 0x00000004,
    NDIS_RECEIVE_HASH_PARAMETERS_REVISION_1    = 0x00000001,
}

enum uint NDIS_RSS_PROCESSOR_INFO_REVISION_2 = 0x00000002;

enum : uint
{
    NDIS_HYPERVISOR_INFO_FLAG_HYPERVISOR_PRESENT = 0x00000001,
    NDIS_HYPERVISOR_INFO_REVISION_1              = 0x00000001,
}

enum uint NDIS_WMI_RECEIVE_QUEUE_INFO_REVISION_1 = 0x00000001;

enum : uint
{
    OID_NDK_SET_STATE       = 0xfc040201,
    OID_NDK_STATISTICS      = 0xfc040202,
    OID_NDK_CONNECTIONS     = 0xfc040203,
    OID_NDK_LOCAL_ENDPOINTS = 0xfc040204,
}

enum uint NDIS_NDK_CONNECTIONS_REVISION_1 = 0x00000001;
enum uint OID_QOS_HARDWARE_CAPABILITIES = 0xfc050001;

enum : uint
{
    OID_QOS_PARAMETERS             = 0xfc050003,
    OID_QOS_OPERATIONAL_PARAMETERS = 0xfc050004,
}

enum : uint
{
    NDIS_QOS_MAXIMUM_PRIORITIES      = 0x00000008,
    NDIS_QOS_MAXIMUM_TRAFFIC_CLASSES = 0x00000008,
}

enum : uint
{
    NDIS_QOS_CAPABILITIES_MACSEC_BYPASS_SUPPORTED = 0x00000002,
    NDIS_QOS_CAPABILITIES_CEE_DCBX_SUPPORTED      = 0x00000004,
    NDIS_QOS_CAPABILITIES_IEEE_DCBX_SUPPORTED     = 0x00000008,
    NDIS_QOS_CAPABILITIES_REVISION_1              = 0x00000001,
}

enum uint NDIS_QOS_CLASSIFICATION_ENFORCED_BY_MINIPORT = 0x01000000;

enum : uint
{
    NDIS_QOS_CONDITION_DEFAULT         = 0x00000001,
    NDIS_QOS_CONDITION_TCP_PORT        = 0x00000002,
    NDIS_QOS_CONDITION_UDP_PORT        = 0x00000003,
    NDIS_QOS_CONDITION_TCP_OR_UDP_PORT = 0x00000004,
    NDIS_QOS_CONDITION_ETHERTYPE       = 0x00000005,
    NDIS_QOS_CONDITION_NETDIRECT_PORT  = 0x00000006,
    NDIS_QOS_CONDITION_MAXIMUM         = 0x00000007,
}

enum uint NDIS_QOS_ACTION_MAXIMUM = 0x00000001;

enum : uint
{
    NDIS_QOS_PARAMETERS_ETS_CHANGED               = 0x00000001,
    NDIS_QOS_PARAMETERS_ETS_CONFIGURED            = 0x00000002,
    NDIS_QOS_PARAMETERS_PFC_CHANGED               = 0x00000100,
    NDIS_QOS_PARAMETERS_PFC_CONFIGURED            = 0x00000200,
    NDIS_QOS_PARAMETERS_CLASSIFICATION_CHANGED    = 0x00010000,
    NDIS_QOS_PARAMETERS_CLASSIFICATION_CONFIGURED = 0x00020000,
    NDIS_QOS_PARAMETERS_WILLING                   = 0x80000000,
}

enum : uint
{
    NDIS_QOS_TSA_CBS               = 0x00000001,
    NDIS_QOS_TSA_ETS               = 0x00000002,
    NDIS_QOS_TSA_MAXIMUM           = 0x00000003,
    NDIS_QOS_PARAMETERS_REVISION_1 = 0x00000001,
}

enum uint NDIS_DEFAULT_SWITCH_ID = 0x00000000;

enum : uint
{
    NDIS_NIC_SWITCH_PARAMETERS_SWITCH_NAME_CHANGED                             = 0x00010000,
    NDIS_NIC_SWITCH_PARAMETERS_DEFAULT_NUMBER_OF_QUEUE_PAIRS_FOR_DEFAULT_VPORT = 0x00000001,
}

enum : uint
{
    NDIS_NIC_SWITCH_PARAMETERS_REVISION_2               = 0x00000002,
    NDIS_NIC_SWITCH_DELETE_SWITCH_PARAMETERS_REVISION_1 = 0x00000001,
}

enum : uint
{
    NDIS_NIC_SWITCH_INFO_ARRAY_REVISION_1                   = 0x00000001,
    NDIS_NIC_SWITCH_VPORT_PARAMS_LOOKAHEAD_SPLIT_ENABLED    = 0x00000001,
    NDIS_NIC_SWITCH_VPORT_PARAMS_PACKET_DIRECT_RX_ONLY      = 0x00000002,
    NDIS_NIC_SWITCH_VPORT_PARAMS_ENFORCE_MAX_SG_LIST        = 0x00008000,
    NDIS_NIC_SWITCH_VPORT_PARAMS_CHANGE_MASK                = 0xffff0000,
    NDIS_NIC_SWITCH_VPORT_PARAMS_FLAGS_CHANGED              = 0x00010000,
    NDIS_NIC_SWITCH_VPORT_PARAMS_NAME_CHANGED               = 0x00020000,
    NDIS_NIC_SWITCH_VPORT_PARAMS_INT_MOD_CHANGED            = 0x00040000,
    NDIS_NIC_SWITCH_VPORT_PARAMS_STATE_CHANGED              = 0x00080000,
    NDIS_NIC_SWITCH_VPORT_PARAMS_PROCESSOR_AFFINITY_CHANGED = 0x00100000,
    NDIS_NIC_SWITCH_VPORT_PARAMS_NDK_PARAMS_CHANGED         = 0x00200000,
    NDIS_NIC_SWITCH_VPORT_PARAMS_QOS_SQ_ID_CHANGED          = 0x00400000,
    NDIS_NIC_SWITCH_VPORT_PARAMS_NUM_QUEUE_PAIRS_CHANGED    = 0x00800000,
    NDIS_NIC_SWITCH_VPORT_PARAMETERS_REVISION_1             = 0x00000001,
    NDIS_NIC_SWITCH_VPORT_PARAMETERS_REVISION_2             = 0x00000002,
}

enum : uint
{
    NDIS_NIC_SWITCH_VPORT_INFO_LOOKAHEAD_SPLIT_ENABLED         = 0x00000001,
    NDIS_NIC_SWITCH_VPORT_INFO_PACKET_DIRECT_RX_ONLY           = 0x00000002,
    NDIS_NIC_SWITCH_VPORT_INFO_GFT_ENABLED                     = 0x00000004,
    NDIS_NIC_SWITCH_VPORT_INFO_REVISION_1                      = 0x00000001,
    NDIS_NIC_SWITCH_VPORT_INFO_ARRAY_ENUM_ON_SPECIFIC_FUNCTION = 0x00000001,
    NDIS_NIC_SWITCH_VPORT_INFO_ARRAY_ENUM_ON_SPECIFIC_SWITCH   = 0x00000002,
    NDIS_NIC_SWITCH_VPORT_INFO_ARRAY_REVISION_1                = 0x00000001,
}

enum uint NDIS_NIC_SWITCH_FREE_VF_PARAMETERS_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_NIC_SWITCH_VF_INFO_ARRAY_ENUM_ON_SPECIFIC_SWITCH = 0x00000001,
    NDIS_NIC_SWITCH_VF_INFO_ARRAY_REVISION_1              = 0x00000001,
}

enum : uint
{
    NDIS_SRIOV_CAPS_PF_MINIPORT        = 0x00000002,
    NDIS_SRIOV_CAPS_VF_MINIPORT        = 0x00000004,
    NDIS_SRIOV_CAPABILITIES_REVISION_1 = 0x00000001,
}

enum uint NDIS_SRIOV_WRITE_VF_CONFIG_SPACE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint NDIS_SRIOV_WRITE_VF_CONFIG_BLOCK_PARAMETERS_REVISION_1 = 0x00000001;
enum uint NDIS_SRIOV_SET_VF_POWER_STATE_PARAMETERS_REVISION_1 = 0x00000001;
enum uint NDIS_SRIOV_VF_VENDOR_DEVICE_ID_INFO_REVISION_1 = 0x00000001;
enum uint NDIS_RECEIVE_FILTER_MOVE_FILTER_PARAMETERS_REVISION_1 = 0x00000001;
enum uint NDIS_SRIOV_PF_LUID_INFO_REVISION_1 = 0x00000001;
enum uint NDIS_SRIOV_VF_INVALIDATE_CONFIG_BLOCK_INFO_REVISION_1 = 0x00000001;
enum uint NDIS_ISOLATION_NAME_MAX_STRING_SIZE = 0x0000007f;
enum uint NDIS_ROUTING_DOMAIN_ENTRY_REVISION_1 = 0x00000001;
enum uint NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION_1 = 0x00000001;

enum : uint
{
    NDIS_SWITCH_PORT_PROPERTY_SECURITY_REVISION_2          = 0x00000002,
    NDIS_SWITCH_PORT_PROPERTY_VLAN_REVISION_1              = 0x00000001,
    NDIS_SWITCH_PORT_PROPERTY_PROFILE_REVISION_1           = 0x00000001,
    NDIS_SWITCH_PORT_PROPERTY_ISOLATION_REVISION_1         = 0x00000001,
    NDIS_SWITCH_PORT_PROPERTY_ROUTING_DOMAIN_REVISION_1    = 0x00000001,
    NDIS_SWITCH_PORT_PROPERTY_CUSTOM_REVISION_1            = 0x00000001,
    NDIS_SWITCH_PORT_PROPERTY_PARAMETERS_REVISION_1        = 0x00000001,
    NDIS_SWITCH_PORT_PROPERTY_DELETE_PARAMETERS_REVISION_1 = 0x00000001,
    NDIS_SWITCH_PORT_PROPERTY_ENUM_PARAMETERS_REVISION_1   = 0x00000001,
    NDIS_SWITCH_PORT_PROPERTY_ENUM_INFO_REVISION_1         = 0x00000001,
}

enum uint NDIS_SWITCH_PORT_FEATURE_STATUS_CUSTOM_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_SWITCH_PROPERTY_PARAMETERS_REVISION_1        = 0x00000001,
    NDIS_SWITCH_PROPERTY_DELETE_PARAMETERS_REVISION_1 = 0x00000001,
    NDIS_SWITCH_PROPERTY_ENUM_INFO_REVISION_1         = 0x00000001,
    NDIS_SWITCH_PROPERTY_ENUM_PARAMETERS_REVISION_1   = 0x00000001,
}

enum uint NDIS_SWITCH_FEATURE_STATUS_CUSTOM_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_SWITCH_PORT_PARAMETERS_FLAG_UNTRUSTED_INTERNAL_PORT = 0x00000001,
    NDIS_SWITCH_PORT_PARAMETERS_FLAG_RESTORING_PORT          = 0x00000002,
    NDIS_SWITCH_PORT_PARAMETERS_REVISION_1                   = 0x00000001,
    NDIS_SWITCH_PORT_ARRAY_REVISION_1                        = 0x00000001,
}

enum : uint
{
    NDIS_SWITCH_NIC_FLAGS_NIC_SUSPENDED      = 0x00000002,
    NDIS_SWITCH_NIC_FLAGS_MAPPED_NIC_UPDATED = 0x00000004,
    NDIS_SWITCH_NIC_FLAGS_NIC_SUSPENDED_LM   = 0x00000010,
    NDIS_SWITCH_NIC_PARAMETERS_REVISION_1    = 0x00000001,
    NDIS_SWITCH_NIC_PARAMETERS_REVISION_2    = 0x00000002,
    NDIS_SWITCH_NIC_ARRAY_REVISION_1         = 0x00000001,
    NDIS_SWITCH_NIC_OID_REQUEST_REVISION_1   = 0x00000001,
    NDIS_SWITCH_NIC_SAVE_STATE_REVISION_1    = 0x00000001,
    NDIS_SWITCH_NIC_SAVE_STATE_REVISION_2    = 0x00000002,
}

enum uint NDIS_PORT_CHAR_USE_DEFAULT_AUTH_SETTINGS = 0x00000001;
enum uint NDIS_PORT_ARRAY_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_GFP_HEADER_PRESENT_ETHERNET        = 0x00000001,
    NDIS_GFP_HEADER_PRESENT_IPV4            = 0x00000002,
    NDIS_GFP_HEADER_PRESENT_IPV6            = 0x00000004,
    NDIS_GFP_HEADER_PRESENT_TCP             = 0x00000008,
    NDIS_GFP_HEADER_PRESENT_UDP             = 0x00000010,
    NDIS_GFP_HEADER_PRESENT_ICMP            = 0x00000020,
    NDIS_GFP_HEADER_PRESENT_NO_ENCAP        = 0x00000040,
    NDIS_GFP_HEADER_PRESENT_IP_IN_IP_ENCAP  = 0x00000080,
    NDIS_GFP_HEADER_PRESENT_IP_IN_GRE_ENCAP = 0x00000100,
    NDIS_GFP_HEADER_PRESENT_NVGRE_ENCAP     = 0x00000200,
    NDIS_GFP_HEADER_PRESENT_VXLAN_ENCAP     = 0x00000400,
    NDIS_GFP_HEADER_PRESENT_ESP             = 0x00000800,
}

enum : uint
{
    NDIS_GFP_ENCAPSULATION_TYPE_IP_IN_IP  = 0x00000002,
    NDIS_GFP_ENCAPSULATION_TYPE_IP_IN_GRE = 0x00000004,
    NDIS_GFP_ENCAPSULATION_TYPE_NVGRE     = 0x00000008,
    NDIS_GFP_ENCAPSULATION_TYPE_VXLAN     = 0x00000010,
}

enum : uint
{
    NDIS_GFP_HEADER_GROUP_EXACT_MATCH_PROFILE_IS_TTL_ONE = 0x00000001,
    NDIS_GFP_HEADER_GROUP_EXACT_MATCH_PROFILE_REVISION_1 = 0x00000001,
}

enum uint NDIS_GFP_EXACT_MATCH_PROFILE_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_GFP_HEADER_GROUP_EXACT_MATCH_REVISION_1            = 0x00000001,
    NDIS_GFP_HEADER_GROUP_WILDCARD_MATCH_PROFILE_IS_TTL_ONE = 0x00000001,
    NDIS_GFP_HEADER_GROUP_WILDCARD_MATCH_PROFILE_REVISION_1 = 0x00000001,
}

enum : uint
{
    NDIS_GFP_HEADER_GROUP_WILDCARD_MATCH_IS_TTL_ONE = 0x00000001,
    NDIS_GFP_HEADER_GROUP_WILDCARD_MATCH_REVISION_1 = 0x00000001,
}

enum uint NDIS_PD_CAPS_DRAIN_NOTIFICATIONS_SUPPORTED = 0x00000002;
enum uint NDIS_PD_CAPS_NOTIFICATION_MODERATION_COUNT_SUPPORTED = 0x00000008;
enum uint NDIS_PD_CONFIG_REVISION_1 = 0x00000001;
enum uint NDIS_GFT_UNDEFINED_TABLE_ID = 0x00000000;

enum : uint
{
    NDIS_GFT_TABLE_PARAMETERS_REVISION_1 = 0x00000001,
    NDIS_GFT_TABLE_INFO_REVISION_1       = 0x00000001,
    NDIS_GFT_TABLE_INFO_ARRAY_REVISION_1 = 0x00000001,
}

enum uint NDIS_GFT_UNDEFINED_COUNTER_ID = 0x00000000;

enum : uint
{
    NDIS_GFT_COUNTER_PARAMETERS_CLIENT_SPECIFIED_ADDRESS = 0x00000001,
    NDIS_GFT_COUNTER_PARAMETERS_REVISION_1               = 0x00000001,
}

enum : uint
{
    NDIS_GFT_COUNTER_INFO_REVISION_1                           = 0x00000001,
    NDIS_GFT_COUNTER_INFO_ARRAY_REVISION_1                     = 0x00000001,
    NDIS_GFT_COUNTER_VALUE_ARRAY_UPDATE_MEMORY_MAPPED_COUNTERS = 0x00000001,
    NDIS_GFT_COUNTER_VALUE_ARRAY_GET_VALUES                    = 0x00000002,
    NDIS_GFT_COUNTER_VALUE_ARRAY_REVISION_1                    = 0x00000001,
}

enum : uint
{
    NDIS_GFT_HEADER_GROUP_TRANSPOSITION_PROFILE_DECREMENT_TTL_IF_NOT_ONE = 0x00000001,
    NDIS_GFT_HEADER_GROUP_TRANSPOSITION_PROFILE_REVISION_1               = 0x00000001,
}

enum uint NDIS_GFT_RESERVED_CUSTOM_ACTIONS = 0x00000100;

enum : uint
{
    NDIS_GFT_HTP_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT               = 0x00000001,
    NDIS_GFT_HTP_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT                = 0x00000002,
    NDIS_GFT_HTP_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE = 0x00000004,
    NDIS_GFT_HTP_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE  = 0x00000008,
}

enum : uint
{
    NDIS_GFT_HTP_COPY_FIRST_PACKET      = 0x00000020,
    NDIS_GFT_HTP_COPY_WHEN_TCP_FLAG_SET = 0x00000040,
}

enum uint NDIS_GFT_HTP_META_ACTION_BEFORE_HEADER_TRANSPOSITION = 0x00000100;

enum : uint
{
    NDIS_GFT_HEADER_GROUP_TRANSPOSITION_DECREMENT_TTL_IF_NOT_ONE = 0x00000001,
    NDIS_GFT_HEADER_GROUP_TRANSPOSITION_REVISION_1               = 0x00000001,
}

enum uint NDIS_GFT_CUSTOM_ACTION_REVISION_1 = 0x00000001;
enum uint NDIS_GFT_EMFE_MATCH_AND_ACTION_MUST_BE_SUPPORTED = 0x00000002;

enum : uint
{
    NDIS_GFT_EMFE_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT               = 0x00001000,
    NDIS_GFT_EMFE_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT                = 0x00002000,
    NDIS_GFT_EMFE_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE = 0x00004000,
    NDIS_GFT_EMFE_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE  = 0x00008000,
}

enum : uint
{
    NDIS_GFT_EMFE_COPY_FIRST_PACKET      = 0x00020000,
    NDIS_GFT_EMFE_COPY_WHEN_TCP_FLAG_SET = 0x00040000,
    NDIS_GFT_EMFE_CUSTOM_ACTION_PRESENT  = 0x00080000,
}

enum : uint
{
    NDIS_GFT_EMFE_COPY_AFTER_TCP_FIN_FLAG_SET = 0x00200000,
    NDIS_GFT_EMFE_COPY_AFTER_TCP_RST_FLAG_SET = 0x00400000,
    NDIS_GFT_EMFE_COPY_CONDITION_CHANGED      = 0x01000000,
}

enum : uint
{
    NDIS_GFT_EMFE_COUNTER_ALLOCATE                 = 0x00000001,
    NDIS_GFT_EMFE_COUNTER_MEMORY_MAPPED            = 0x00000002,
    NDIS_GFT_EMFE_COUNTER_CLIENT_SPECIFIED_ADDRESS = 0x00000004,
    NDIS_GFT_EMFE_COUNTER_TRACK_TCP_FLOW           = 0x00000008,
}

enum uint NDIS_GFT_WCFE_ADD_IN_ACTIVATED_STATE = 0x00000001;

enum : uint
{
    NDIS_GFT_WCFE_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT                = 0x00000004,
    NDIS_GFT_WCFE_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE = 0x00000008,
    NDIS_GFT_WCFE_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE  = 0x00000010,
}

enum : uint
{
    NDIS_GFT_WCFE_CUSTOM_ACTION_PRESENT            = 0x00000040,
    NDIS_GFT_WCFE_COUNTER_ALLOCATE                 = 0x00000001,
    NDIS_GFT_WCFE_COUNTER_MEMORY_MAPPED            = 0x00000002,
    NDIS_GFT_WCFE_COUNTER_CLIENT_SPECIFIED_ADDRESS = 0x00000004,
}

enum : uint
{
    NDIS_GFT_PROFILE_INFO_REVISION_1       = 0x00000001,
    NDIS_GFT_PROFILE_INFO_ARRAY_REVISION_1 = 0x00000001,
}

enum uint NDIS_GFT_DELETE_PROFILE_PARAMETERS_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_GFT_FLOW_ENTRY_INFO_ALL_FLOW_ENTRIES          = 0x00000001,
    NDIS_GFT_FLOW_ENTRY_INFO_ARRAY_REVISION_1          = 0x00000001,
    NDIS_GFT_FLOW_ENTRY_ID_ALL_NIC_SWITCH_FLOW_ENTRIES = 0x00000001,
    NDIS_GFT_FLOW_ENTRY_ID_ALL_TABLE_FLOW_ENTRIES      = 0x00000002,
    NDIS_GFT_FLOW_ENTRY_ID_ALL_VPORT_FLOW_ENTRIES      = 0x00000004,
    NDIS_GFT_FLOW_ENTRY_ID_RANGE_DEFINED               = 0x00000008,
    NDIS_GFT_FLOW_ENTRY_ID_ARRAY_DEFINED               = 0x00000010,
    NDIS_GFT_FLOW_ENTRY_ID_ARRAY_COUNTER_VALUES        = 0x00010000,
    NDIS_GFT_FLOW_ENTRY_ID_ARRAY_REVISION_1            = 0x00000001,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_PARAMETERS_CUSTOM_PROVIDER_RESERVED       = 0xff000000,
    NDIS_GFT_OFFLOAD_PARAMETERS_REVISION_1                     = 0x00000001,
    NDIS_GFT_OFFLOAD_CAPS_ADD_FLOW_ENTRY_DEACTIVATED_PREFERRED = 0x00000001,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_MEMORY_MAPPED_COUNTERS                 = 0x00000001,
    NDIS_GFT_OFFLOAD_CAPS_MEMORY_MAPPED_PAKCET_AND_BYTE_COUNTERS = 0x00000002,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_PER_PACKET_COUNTER_UPDATE               = 0x00000008,
    NDIS_GFT_OFFLOAD_CAPS_CLIENT_SPECIFIED_MEMORY_MAPPED_COUNTERS = 0x00000010,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_EGRESS_AGGREGATE_COUNTERS                        = 0x00000040,
    NDIS_GFT_OFFLOAD_CAPS_TRACK_TCP_FLOW_STATE                             = 0x00000080,
    NDIS_GFT_OFFLOAD_CAPS_COMBINED_COUNTER_AND_STATE                       = 0x00000100,
    NDIS_GFT_OFFLOAD_CAPS_INGRESS_WILDCARD_MATCH                           = 0x00000001,
    NDIS_GFT_OFFLOAD_CAPS_EGRESS_WILDCARD_MATCH                            = 0x00000002,
    NDIS_GFT_OFFLOAD_CAPS_INGRESS_EXACT_MATCH                              = 0x00000004,
    NDIS_GFT_OFFLOAD_CAPS_EGRESS_EXACT_MATCH                               = 0x00000008,
    NDIS_GFT_OFFLOAD_CAPS_EXT_VPORT_INGRESS_WILDCARD_MATCH                 = 0x00000010,
    NDIS_GFT_OFFLOAD_CAPS_EXT_VPORT_EGRESS_WILDCARD_MATCH                  = 0x00000020,
    NDIS_GFT_OFFLOAD_CAPS_EXT_VPORT_INGRESS_EXACT_MATCH                    = 0x00000040,
    NDIS_GFT_OFFLOAD_CAPS_EXT_VPORT_EGRESS_EXACT_MATCH                     = 0x00000080,
    NDIS_GFT_OFFLOAD_CAPS_POP                                              = 0x00000001,
    NDIS_GFT_OFFLOAD_CAPS_PUSH                                             = 0x00000002,
    NDIS_GFT_OFFLOAD_CAPS_MODIFY                                           = 0x00000004,
    NDIS_GFT_OFFLOAD_CAPS_IGNORE_ACTION_SUPPORTED                          = 0x00000008,
    NDIS_GFT_OFFLOAD_CAPS_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT               = 0x00000010,
    NDIS_GFT_OFFLOAD_CAPS_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT                = 0x00000020,
    NDIS_GFT_OFFLOAD_CAPS_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE = 0x00000040,
    NDIS_GFT_OFFLOAD_CAPS_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE  = 0x00000080,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_COPY_FIRST                              = 0x00000200,
    NDIS_GFT_OFFLOAD_CAPS_COPY_WHEN_TCP_FLAG_SET                  = 0x00000400,
    NDIS_GFT_OFFLOAD_CAPS_SAMPLE                                  = 0x00000800,
    NDIS_GFT_OFFLOAD_CAPS_META_ACTION_BEFORE_HEADER_TRANSPOSITION = 0x00001000,
    NDIS_GFT_OFFLOAD_CAPS_META_ACTION_AFTER_HEADER_TRANSPOSITION  = 0x00002000,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_DESIGNATED_EXCEPTION_VPORT = 0x00008000,
    NDIS_GFT_OFFLOAD_CAPS_DSCP_MASK                  = 0x00010000,
    NDIS_GFT_OFFLOAD_CAPS_8021P_PRIORITY_MASK        = 0x00020000,
    NDIS_GFT_OFFLOAD_CAPS_ALLOW                      = 0x00040000,
    NDIS_GFT_OFFLOAD_CAPS_DROP                       = 0x00080000,
    NDIS_GFT_OFFLOAD_CAPABILITIES_REVISION_1         = 0x00000001,
}

enum : uint
{
    NDIS_GFT_VPORT_PARSE_VXLAN                       = 0x00000002,
    NDIS_GFT_VPORT_PARSE_VXLAN_NOT_IN_SRC_PORT_RANGE = 0x00000004,
}

enum uint NDIS_GFT_VPORT_EXCEPTION_VPORT_CHANGED = 0x00200000;

enum : uint
{
    NDIS_GFT_VPORT_DSCP_MASK_CHANGED               = 0x00800000,
    NDIS_GFT_VPORT_PRIORITY_MASK_CHANGED           = 0x01000000,
    NDIS_GFT_VPORT_VXLAN_SETTINGS_CHANGED          = 0x02000000,
    NDIS_GFT_VPORT_DSCP_FLAGS_CHANGED              = 0x04000000,
    NDIS_GFT_VPORT_PARAMS_CHANGE_MASK              = 0xfff00000,
    NDIS_GFT_VPORT_PARAMS_CUSTOM_PROVIDER_RESERVED = 0x000ff000,
}

enum uint NDIS_GFT_VPORT_MAX_PRIORITY_MASK_COUNTER_OBJECTS = 0x00000008;

enum : uint
{
    NDIS_GFT_VPORT_DSCP_GUARD_ENABLE_TX  = 0x00000002,
    NDIS_GFT_VPORT_DSCP_MASK_ENABLE_RX   = 0x00000004,
    NDIS_GFT_VPORT_DSCP_MASK_ENABLE_TX   = 0x00000008,
    NDIS_GFT_VPORT_PARAMETERS_REVISION_1 = 0x00000001,
}

enum : uint
{
    NDIS_QOS_SQ_PARAMETERS_REVISION_1 = 0x00000001,
    NDIS_QOS_SQ_PARAMETERS_REVISION_2 = 0x00000002,
}

enum uint NDIS_QOS_SQ_TRANSMIT_RESERVATION_ENABLED = 0x00000002;
enum uint NDIS_QOS_SQ_PARAMETERS_ARRAY_REVISION_1 = 0x00000001;

enum : uint
{
    NDIS_QOS_OFFLOAD_CAPABILITIES_REVISION_1 = 0x00000001,
    NDIS_QOS_OFFLOAD_CAPABILITIES_REVISION_2 = 0x00000002,
    NDIS_QOS_OFFLOAD_CAPS_STANDARD_SQ        = 0x00000001,
    NDIS_QOS_OFFLOAD_CAPS_GFT_SQ             = 0x00000002,
}

enum uint NDIS_TIMESTAMP_CAPABILITIES_REVISION_1 = 0x00000001;
enum uint OID_TIMESTAMP_CURRENT_CONFIG = 0x00a00002;
enum uint OID_TIMESTAMP_GET_CROSSTIMESTAMP = 0x00a00003;

enum : uint
{
    NdisHashFunctionToeplitz  = 0x00000001,
    NdisHashFunctionReserved1 = 0x00000002,
    NdisHashFunctionReserved2 = 0x00000004,
    NdisHashFunctionReserved3 = 0x00000008,
}

enum : uint
{
    NDIS_HASH_TYPE_MASK   = 0x00ffff00,
    NDIS_HASH_IPV4        = 0x00000100,
    NDIS_HASH_TCP_IPV4    = 0x00000200,
    NDIS_HASH_IPV6        = 0x00000400,
    NDIS_HASH_IPV6_EX     = 0x00000800,
    NDIS_HASH_TCP_IPV6    = 0x00001000,
    NDIS_HASH_TCP_IPV6_EX = 0x00002000,
    NDIS_HASH_UDP_IPV4    = 0x00004000,
    NDIS_HASH_UDP_IPV6    = 0x00008000,
    NDIS_HASH_UDP_IPV6_EX = 0x00010000,
}

enum uint NDIS_MAXIMUM_PORTS = 0x01000000;

enum : uint
{
    NDIS_OFFLOAD_NOT_SUPPORTED = 0x00000000,
    NDIS_OFFLOAD_SUPPORTED     = 0x00000001,
    NDIS_OFFLOAD_SET_NO_CHANGE = 0x00000000,
    NDIS_OFFLOAD_SET_ON        = 0x00000001,
    NDIS_OFFLOAD_SET_OFF       = 0x00000002,
}

enum : uint
{
    NDIS_ENCAPSULATION_NULL                      = 0x00000001,
    NDIS_ENCAPSULATION_IEEE_802_3                = 0x00000002,
    NDIS_ENCAPSULATION_IEEE_802_3_P_AND_Q        = 0x00000004,
    NDIS_ENCAPSULATION_IEEE_802_3_P_AND_Q_IN_OOB = 0x00000008,
    NDIS_ENCAPSULATION_IEEE_LLC_SNAP_ROUTED      = 0x00000010,
}

enum : uint
{
    NDIS_SUPPORT_NDIS689 = 0x00000001,
    NDIS_SUPPORT_NDIS688 = 0x00000001,
    NDIS_SUPPORT_NDIS687 = 0x00000001,
    NDIS_SUPPORT_NDIS686 = 0x00000001,
    NDIS_SUPPORT_NDIS685 = 0x00000001,
    NDIS_SUPPORT_NDIS684 = 0x00000001,
    NDIS_SUPPORT_NDIS683 = 0x00000001,
    NDIS_SUPPORT_NDIS682 = 0x00000001,
    NDIS_SUPPORT_NDIS681 = 0x00000001,
    NDIS_SUPPORT_NDIS680 = 0x00000001,
    NDIS_SUPPORT_NDIS670 = 0x00000001,
    NDIS_SUPPORT_NDIS660 = 0x00000001,
    NDIS_SUPPORT_NDIS651 = 0x00000001,
    NDIS_SUPPORT_NDIS650 = 0x00000001,
    NDIS_SUPPORT_NDIS640 = 0x00000001,
    NDIS_SUPPORT_NDIS630 = 0x00000001,
    NDIS_SUPPORT_NDIS620 = 0x00000001,
    NDIS_SUPPORT_NDIS61  = 0x00000001,
    NDIS_SUPPORT_NDIS6   = 0x00000001,
}

enum uint NDK_ADAPTER_FLAG_RDMA_READ_SINK_NOT_REQUIRED = 0x00000002;

enum : uint
{
    NDK_ADAPTER_FLAG_MULTI_ENGINE_SUPPORTED               = 0x00000008,
    NDK_ADAPTER_FLAG_RDMA_READ_LOCAL_INVALIDATE_SUPPORTED = 0x00000010,
}

enum uint NDK_ADAPTER_FLAG_LOOPBACK_CONNECTIONS_SUPPORTED = 0x00010000;

enum : uint
{
    NET_IF_OPER_STATUS_DOWN_NOT_MEDIA_CONNECTED = 0x00000002,
    NET_IF_OPER_STATUS_DORMANT_PAUSED           = 0x00000004,
    NET_IF_OPER_STATUS_DORMANT_LOW_POWER        = 0x00000008,
}

enum : uint
{
    NET_IF_OID_COMPARTMENT_ID = 0x00000002,
    NET_IF_OID_NETWORK_GUID   = 0x00000003,
    NET_IF_OID_IF_ENTRY       = 0x00000004,
}

enum : uint
{
    NET_SITEID_MAXUSER   = 0x07ffffff,
    NET_SITEID_MAXSYSTEM = 0x0fffffff,
}

enum uint NIIF_HARDWARE_INTERFACE = 0x00000001;

enum : uint
{
    NIIF_NDIS_RESERVED1          = 0x00000004,
    NIIF_NDIS_RESERVED2          = 0x00000008,
    NIIF_NDIS_RESERVED3          = 0x00000010,
    NIIF_NDIS_WDM_INTERFACE      = 0x00000020,
    NIIF_NDIS_ENDPOINT_INTERFACE = 0x00000040,
}

enum uint NIIF_NDIS_RESERVED4 = 0x00000100;
enum uint IF_MAX_PHYS_ADDRESS_LENGTH = 0x00000020;

// Structs


struct NET_IF_COMPARTMENT_ID
{
    uint Value;
}

struct NET_IF_RCV_ADDRESS_LH
{
    NET_IF_RCV_ADDRESS_TYPE ifRcvAddressType;
    ushort ifRcvAddressLength;
    ushort ifRcvAddressOffset;
}

struct NET_IF_ALIAS_LH
{
    ushort ifAliasLength;
    ushort ifAliasOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ns-ifdef-net_luid_lh))], [])
union NET_LUID_LH
{
    ulong Value;
struct Info
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IfType)), FixedArgSig(ElementSig(48)), FixedArgSig(ElementSig(16))], [])*/ulong _bitfield71;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ns-ifdef-net_physical_location_lh))], [])
struct NET_PHYSICAL_LOCATION_LH
{
    uint BusNumber;
    uint SlotNumber;
    uint FunctionNumber;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ns-ifdef-if_counted_string_lh))], [])
struct IF_COUNTED_STRING_LH
{
    ushort     Length;
    wchar[257] String;
}

struct IF_PHYSICAL_ADDRESS_LH
{
    ushort    Length;
    ubyte[32] Address;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ifdef/ns-ifdef-ndis_interface_information))], [])
struct NDIS_INTERFACE_INFORMATION
{
    NET_IF_OPER_STATUS ifOperStatus;
    uint               ifOperStatusFlags;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    uint               ifMtu;
    BOOLEAN            ifPromiscuousMode;
    BOOLEAN            ifDeviceWakeUpEnable;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    ulong              ifLastChange;
    ulong              ifCounterDiscontinuityTime;
    ulong              ifInUnknownProtos;
    ulong              ifInDiscards;
    ulong              ifInErrors;
    ulong              ifHCInOctets;
    ulong              ifHCInUcastPkts;
    ulong              ifHCInMulticastPkts;
    ulong              ifHCInBroadcastPkts;
    ulong              ifHCOutOctets;
    ulong              ifHCOutUcastPkts;
    ulong              ifHCOutMulticastPkts;
    ulong              ifHCOutBroadcastPkts;
    ulong              ifOutErrors;
    ulong              ifOutDiscards;
    ulong              ifHCInUcastOctets;
    ulong              ifHCInMulticastOctets;
    ulong              ifHCInBroadcastOctets;
    ulong              ifHCOutUcastOctets;
    ulong              ifHCOutMulticastOctets;
    ulong              ifHCOutBroadcastOctets;
    NET_IF_COMPARTMENT_ID CompartmentId;
    uint               SupportedStatistics;
}

struct NDIS_STATISTICS_VALUE
{
    uint Oid;
    uint DataLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

struct NDIS_STATISTICS_VALUE_EX
{
    uint Oid;
    uint DataLength;
    uint Length;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Data;
}

struct NDIS_VAR_DATA_DESC
{
    ushort Length;
    ushort MaximumLength;
    size_t Offset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/NativeWiFi/ndis-object-header))], [])
struct NDIS_OBJECT_HEADER
{
    ubyte  Type;
    ubyte  Revision;
    ushort Size;
}

struct NDIS_STATISTICS_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               SupportedStatistics;
    ulong              ifInDiscards;
    ulong              ifInErrors;
    ulong              ifHCInOctets;
    ulong              ifHCInUcastPkts;
    ulong              ifHCInMulticastPkts;
    ulong              ifHCInBroadcastPkts;
    ulong              ifHCOutOctets;
    ulong              ifHCOutUcastPkts;
    ulong              ifHCOutMulticastPkts;
    ulong              ifHCOutBroadcastPkts;
    ulong              ifOutErrors;
    ulong              ifOutDiscards;
    ulong              ifHCInUcastOctets;
    ulong              ifHCInMulticastOctets;
    ulong              ifHCInBroadcastOctets;
    ulong              ifHCOutUcastOctets;
    ulong              ifHCOutMulticastOctets;
    ulong              ifHCOutBroadcastOctets;
}

struct NDIS_INTERRUPT_MODERATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    NDIS_INTERRUPT_MODERATION InterruptModeration;
}

struct NDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    uint               TimeoutArrayLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/uint[1] TimeoutArray;
}

struct NDIS_PCI_DEVICE_CUSTOM_PROPERTIES
{
    NDIS_OBJECT_HEADER Header;
    uint               DeviceType;
    uint               CurrentSpeedAndMode;
    uint               CurrentPayloadSize;
    uint               MaxPayloadSize;
    uint               MaxReadRequestSize;
    uint               CurrentLinkSpeed;
    uint               CurrentLinkWidth;
    uint               MaxLinkSpeed;
    uint               MaxLinkWidth;
    uint               PciExpressVersion;
    uint               InterruptType;
    uint               MaxInterruptMessages;
}

struct NDIS_802_11_STATUS_INDICATION
{
    NDIS_802_11_STATUS_TYPE StatusType;
}

struct NDIS_802_11_AUTHENTICATION_REQUEST
{
    uint     Length;
    ubyte[6] Bssid;
    uint     Flags;
}

struct PMKID_CANDIDATE
{
    ubyte[6] BSSID;
    uint     Flags;
}

struct NDIS_802_11_PMKID_CANDIDATE_LIST
{
    uint Version;
    uint NumCandidates;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/PMKID_CANDIDATE[1] CandidateList;
}

struct NDIS_802_11_NETWORK_TYPE_LIST
{
    uint NumberOfItems;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NDIS_802_11_NETWORK_TYPE[1] NetworkType;
}

struct NDIS_802_11_CONFIGURATION_FH
{
    uint Length;
    uint HopPattern;
    uint HopSet;
    uint DwellTime;
}

struct NDIS_802_11_CONFIGURATION
{
    uint Length;
    uint BeaconPeriod;
    uint ATIMWindow;
    uint DSConfig;
    NDIS_802_11_CONFIGURATION_FH FHConfig;
}

struct NDIS_802_11_STATISTICS
{
    uint Length;
    long TransmittedFragmentCount;
    long MulticastTransmittedFrameCount;
    long FailedCount;
    long RetryCount;
    long MultipleRetryCount;
    long RTSSuccessCount;
    long RTSFailureCount;
    long ACKFailureCount;
    long FrameDuplicateCount;
    long ReceivedFragmentCount;
    long MulticastReceivedFrameCount;
    long FCSErrorCount;
    long TKIPLocalMICFailures;
    long TKIPICVErrorCount;
    long TKIPCounterMeasuresInvoked;
    long TKIPReplays;
    long CCMPFormatErrors;
    long CCMPReplays;
    long CCMPDecryptErrors;
    long FourWayHandshakeFailures;
    long WEPUndecryptableCount;
    long WEPICVErrorCount;
    long DecryptSuccessCount;
    long DecryptFailureCount;
}

struct NDIS_802_11_KEY
{
    uint     Length;
    uint     KeyIndex;
    uint     KeyLength;
    ubyte[6] BSSID;
    ulong    KeyRSC;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] KeyMaterial;
}

struct NDIS_802_11_REMOVE_KEY
{
    uint     Length;
    uint     KeyIndex;
    ubyte[6] BSSID;
}

struct NDIS_802_11_WEP
{
    uint Length;
    uint KeyIndex;
    uint KeyLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] KeyMaterial;
}

struct NDIS_802_11_SSID
{
    uint      SsidLength;
    ubyte[32] Ssid;
}

struct NDIS_WLAN_BSSID
{
    uint             Length;
    ubyte[6]         MacAddress;
    ubyte[2]         Reserved;
    NDIS_802_11_SSID Ssid;
    uint             Privacy;
    int              Rssi;
    NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
    NDIS_802_11_CONFIGURATION Configuration;
    NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
    ubyte[8]         SupportedRates;
}

struct NDIS_802_11_BSSID_LIST
{
    uint NumberOfItems;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NDIS_WLAN_BSSID[1] Bssid;
}

struct NDIS_WLAN_BSSID_EX
{
    uint             Length;
    ubyte[6]         MacAddress;
    ubyte[2]         Reserved;
    NDIS_802_11_SSID Ssid;
    uint             Privacy;
    int              Rssi;
    NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
    NDIS_802_11_CONFIGURATION Configuration;
    NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
    ubyte[16]        SupportedRates;
    uint             IELength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] IEs;
}

struct NDIS_802_11_BSSID_LIST_EX
{
    uint NumberOfItems;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NDIS_WLAN_BSSID_EX[1] Bssid;
}

struct NDIS_802_11_FIXED_IEs
{
    ubyte[8] Timestamp;
    ushort   BeaconInterval;
    ushort   Capabilities;
}

struct NDIS_802_11_VARIABLE_IEs
{
    ubyte ElementID;
    ubyte Length;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] data;
}

struct NDIS_802_11_AI_REQFI
{
    ushort   Capabilities;
    ushort   ListenInterval;
    ubyte[6] CurrentAPAddress;
}

struct NDIS_802_11_AI_RESFI
{
    ushort Capabilities;
    ushort StatusCode;
    ushort AssociationId;
}

struct NDIS_802_11_ASSOCIATION_INFORMATION
{
    uint                 Length;
    ushort               AvailableRequestFixedIEs;
    NDIS_802_11_AI_REQFI RequestFixedIEs;
    uint                 RequestIELength;
    uint                 OffsetRequestIEs;
    ushort               AvailableResponseFixedIEs;
    NDIS_802_11_AI_RESFI ResponseFixedIEs;
    uint                 ResponseIELength;
    uint                 OffsetResponseIEs;
}

struct NDIS_802_11_AUTHENTICATION_EVENT
{
    NDIS_802_11_STATUS_INDICATION Status;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NDIS_802_11_AUTHENTICATION_REQUEST[1] Request;
}

struct NDIS_802_11_TEST
{
    uint Length;
    uint Type;
union Anonymous
    {
        NDIS_802_11_AUTHENTICATION_EVENT AuthenticationEvent;
        int RssiTrigger;
    }
}

struct BSSID_INFO
{
    ubyte[6]  BSSID;
    ubyte[16] PMKID;
}

struct NDIS_802_11_PMKID
{
    uint Length;
    uint BSSIDInfoCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/BSSID_INFO[1] BSSIDInfo;
}

struct NDIS_802_11_AUTHENTICATION_ENCRYPTION
{
    NDIS_802_11_AUTHENTICATION_MODE AuthModeSupported;
    NDIS_802_11_WEP_STATUS EncryptStatusSupported;
}

struct NDIS_802_11_CAPABILITY
{
    uint Length;
    uint Version;
    uint NoOfPMKIDs;
    uint NoOfAuthEncryptPairsSupported;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NDIS_802_11_AUTHENTICATION_ENCRYPTION[1] AuthenticationEncryptionSupported;
}

struct NDIS_802_11_NON_BCAST_SSID_LIST
{
    uint NumberOfItems;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NDIS_802_11_SSID[1] Non_Bcast_Ssid;
}

struct NDIS_CO_DEVICE_PROFILE
{
    NDIS_VAR_DATA_DESC DeviceDescription;
    NDIS_VAR_DATA_DESC DevSpecificInfo;
    uint               ulTAPISupplementaryPassThru;
    uint               ulAddressModes;
    uint               ulNumAddresses;
    uint               ulBearerModes;
    uint               ulMaxTxRate;
    uint               ulMinTxRate;
    uint               ulMaxRxRate;
    uint               ulMinRxRate;
    uint               ulMediaModes;
    uint               ulGenerateToneModes;
    uint               ulGenerateToneMaxNumFreq;
    uint               ulGenerateDigitModes;
    uint               ulMonitorToneMaxNumFreq;
    uint               ulMonitorToneMaxNumEntries;
    uint               ulMonitorDigitModes;
    uint               ulGatherDigitsMinTimeout;
    uint               ulGatherDigitsMaxTimeout;
    uint               ulDevCapFlags;
    uint               ulMaxNumActiveCalls;
    uint               ulAnswerMode;
    uint               ulUUIAcceptSize;
    uint               ulUUIAnswerSize;
    uint               ulUUIMakeCallSize;
    uint               ulUUIDropSize;
    uint               ulUUISendUserUserInfoSize;
    uint               ulUUICallInfoSize;
}

struct OFFLOAD_ALGO_INFO
{
    uint algoIdentifier;
    uint algoKeylen;
    uint algoRounds;
}

struct OFFLOAD_SECURITY_ASSOCIATION
{
    OFFLOAD_OPERATION_E Operation;
    uint                SPI;
    OFFLOAD_ALGO_INFO   IntegrityAlgo;
    OFFLOAD_ALGO_INFO   ConfAlgo;
    OFFLOAD_ALGO_INFO   Reserved;
}

struct OFFLOAD_IPSEC_ADD_SA
{
    uint   SrcAddr;
    uint   SrcMask;
    uint   DestAddr;
    uint   DestMask;
    uint   Protocol;
    ushort SrcPort;
    ushort DestPort;
    uint   SrcTunnelAddr;
    uint   DestTunnelAddr;
    ushort Flags;
    short  NumSAs;
    OFFLOAD_SECURITY_ASSOCIATION[3] SecAssoc;
    HANDLE OffloadHandle;
    uint   KeyLen;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] KeyMat;
}

struct OFFLOAD_IPSEC_DELETE_SA
{
    HANDLE OffloadHandle;
}

struct OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY
{
    UDP_ENCAP_TYPE UdpEncapType;
    ushort         DstEncapPort;
}

struct OFFLOAD_IPSEC_ADD_UDPESP_SA
{
    uint   SrcAddr;
    uint   SrcMask;
    uint   DstAddr;
    uint   DstMask;
    uint   Protocol;
    ushort SrcPort;
    ushort DstPort;
    uint   SrcTunnelAddr;
    uint   DstTunnelAddr;
    ushort Flags;
    short  NumSAs;
    OFFLOAD_SECURITY_ASSOCIATION[3] SecAssoc;
    HANDLE OffloadHandle;
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY EncapTypeEntry;
    HANDLE EncapTypeEntryOffldHandle;
    uint   KeyLen;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] KeyMat;
}

struct OFFLOAD_IPSEC_DELETE_UDPESP_SA
{
    HANDLE OffloadHandle;
    HANDLE EncapTypeEntryOffldHandle;
}

struct TRANSPORT_HEADER_OFFSET
{
    ushort ProtocolType;
    ushort HeaderOffset;
}

struct NETWORK_ADDRESS
{
    ushort AddressLength;
    ushort AddressType;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Address;
}

struct NETWORK_ADDRESS_LIST
{
    int    AddressCount;
    ushort AddressType;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NETWORK_ADDRESS[1] Address;
}

struct NETWORK_ADDRESS_IP
{
    ushort   sin_port;
    uint     IN_ADDR;
    ubyte[8] sin_zero;
}

struct NETWORK_ADDRESS_IP6
{
    ushort    sin6_port;
    uint      sin6_flowinfo;
    ushort[8] sin6_addr;
    uint      sin6_scope_id;
}

struct NETWORK_ADDRESS_IPX
{
    uint     NetworkAddress;
    ubyte[6] NodeAddress;
    ushort   Socket;
}

struct GEN_GET_TIME_CAPS
{
    uint Flags;
    uint ClockPrecision;
}

struct GEN_GET_NETCARD_TIME
{
    ulong ReadTime;
}

struct NDIS_PM_PACKET_PATTERN
{
    uint Priority;
    uint Reserved;
    uint MaskSize;
    uint PatternOffset;
    uint PatternSize;
    uint PatternFlags;
}

struct NDIS_PM_WAKE_UP_CAPABILITIES
{
    NDIS_DEVICE_POWER_STATE MinMagicPacketWakeUp;
    NDIS_DEVICE_POWER_STATE MinPatternWakeUp;
    NDIS_DEVICE_POWER_STATE MinLinkChangeWakeUp;
}

struct NDIS_PNP_CAPABILITIES
{
    uint Flags;
    NDIS_PM_WAKE_UP_CAPABILITIES WakeUpCapabilities;
}

struct NDIS_WAN_PROTOCOL_CAPS
{
    uint Flags;
    uint Reserved;
}

struct NDIS_CO_LINK_SPEED
{
    uint Outbound;
    uint Inbound;
}

struct NDIS_LINK_SPEED
{
    ulong XmitLinkSpeed;
    ulong RcvLinkSpeed;
}

struct NDIS_GUID
{
    GUID Guid;
union Anonymous
    {
        uint Oid;
        int  Status;
    }
    uint Size;
    uint Flags;
}

struct NDIS_IRDA_PACKET_INFO
{
    uint ExtraBOFs;
    uint MinTurnAroundTime;
}

struct NDIS_LINK_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NDIS_SUPPORTED_PAUSE_FUNCTIONS PauseFunctions;
    uint               AutoNegotiationFlags;
}

struct NDIS_LINK_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NDIS_SUPPORTED_PAUSE_FUNCTIONS PauseFunctions;
    uint               AutoNegotiationFlags;
}

struct NDIS_OPER_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_OPER_STATUS OperationalStatus;
    uint               OperationalStatusFlags;
}

struct NDIS_IP_OPER_STATUS
{
    uint               AddressFamily;
    NET_IF_OPER_STATUS OperationalStatus;
    uint               OperationalStatusFlags;
}

struct NDIS_IP_OPER_STATUS_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    uint               NumberofAddressFamiliesReturned;
    NDIS_IP_OPER_STATUS[32] IpOperationalStatus;
}

struct NDIS_IP_OPER_STATE
{
    NDIS_OBJECT_HEADER  Header;
    uint                Flags;
    NDIS_IP_OPER_STATUS IpOperationalStatus;
}

struct NDIS_OFFLOAD_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              IPv4Checksum;
    ubyte              TCPIPv4Checksum;
    ubyte              UDPIPv4Checksum;
    ubyte              TCPIPv6Checksum;
    ubyte              UDPIPv6Checksum;
    ubyte              LsoV1;
    ubyte              IPsecV1;
    ubyte              LsoV2IPv4;
    ubyte              LsoV2IPv6;
    ubyte              TcpConnectionIPv4;
    ubyte              TcpConnectionIPv6;
    uint               Flags;
}

struct NDIS_TCP_LARGE_SEND_OFFLOAD_V1
{
struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IpOptions)), FixedArgSig(ElementSig(2)), FixedArgSig(ElementSig(2))], [])*/uint _bitfield72;
    }
}

struct NDIS_TCP_IP_CHECKSUM_OFFLOAD
{
struct IPv4Transmit
    {
        uint Encapsulation;
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IpChecksum)), FixedArgSig(ElementSig(8)), FixedArgSig(ElementSig(2))], [])*/uint _bitfield73;
    }
struct IPv4Receive
    {
        uint Encapsulation;
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IpChecksum)), FixedArgSig(ElementSig(8)), FixedArgSig(ElementSig(2))], [])*/uint _bitfield74;
    }
struct IPv6Transmit
    {
        uint Encapsulation;
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(UdpChecksum)), FixedArgSig(ElementSig(6)), FixedArgSig(ElementSig(2))], [])*/uint _bitfield75;
    }
struct IPv6Receive
    {
        uint Encapsulation;
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(UdpChecksum)), FixedArgSig(ElementSig(6)), FixedArgSig(ElementSig(2))], [])*/uint _bitfield76;
    }
}

struct NDIS_IPSEC_OFFLOAD_V1
{
struct Supported
    {
        uint Encapsulation;
        uint AhEspCombined;
        uint TransportTunnelCombined;
        uint IPv4Options;
        uint Flags;
    }
struct IPv4AH
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Receive)), FixedArgSig(ElementSig(10)), FixedArgSig(ElementSig(2))], [])*/uint _bitfield77;
    }
struct IPv4ESP
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Receive)), FixedArgSig(ElementSig(14)), FixedArgSig(ElementSig(2))], [])*/uint _bitfield78;
    }
}

struct NDIS_TCP_LARGE_SEND_OFFLOAD_V2
{
struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
    }
struct IPv6
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(TcpOptionsSupported)), FixedArgSig(ElementSig(2)), FixedArgSig(ElementSig(2))], [])*/uint _bitfield79;
    }
}

struct NDIS_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    NDIS_TCP_IP_CHECKSUM_OFFLOAD Checksum;
    NDIS_TCP_LARGE_SEND_OFFLOAD_V1 LsoV1;
    NDIS_IPSEC_OFFLOAD_V1 IPsecV1;
    NDIS_TCP_LARGE_SEND_OFFLOAD_V2 LsoV2;
    uint               Flags;
}

struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1
{
struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        uint TcpOptions;
        uint IpOptions;
    }
}

struct NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD
{
struct IPv4Transmit
    {
        uint Encapsulation;
        uint IpOptionsSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
        uint IpChecksum;
    }
struct IPv4Receive
    {
        uint Encapsulation;
        uint IpOptionsSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
        uint IpChecksum;
    }
struct IPv6Transmit
    {
        uint Encapsulation;
        uint IpExtensionHeadersSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
    }
struct IPv6Receive
    {
        uint Encapsulation;
        uint IpExtensionHeadersSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
    }
}

struct NDIS_WMI_IPSEC_OFFLOAD_V1
{
struct Supported
    {
        uint Encapsulation;
        uint AhEspCombined;
        uint TransportTunnelCombined;
        uint IPv4Options;
        uint Flags;
    }
struct IPv4AH
    {
        uint Md5;
        uint Sha_1;
        uint Transport;
        uint Tunnel;
        uint Send;
        uint Receive;
    }
struct IPv4ESP
    {
        uint Des;
        uint Reserved;
        uint TripleDes;
        uint NullEsp;
        uint Transport;
        uint Tunnel;
        uint Send;
        uint Receive;
    }
}

struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2
{
struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
    }
struct IPv6
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        uint IpExtensionHeadersSupported;
        uint TcpOptionsSupported;
    }
}

struct NDIS_WMI_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD Checksum;
    NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1 LsoV1;
    NDIS_WMI_IPSEC_OFFLOAD_V1 IPsecV1;
    NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2 LsoV2;
    uint               Flags;
}

struct NDIS_TCP_CONNECTION_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    uint               Encapsulation;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SupportSack)), FixedArgSig(ElementSig(6)), FixedArgSig(ElementSig(2))], [])*/uint _bitfield80;
    uint               TcpConnectionOffloadCapacity;
    uint               Flags;
}

struct NDIS_WMI_TCP_CONNECTION_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    uint               Encapsulation;
    uint               SupportIPv4;
    uint               SupportIPv6;
    uint               SupportIPv6ExtensionHeaders;
    uint               SupportSack;
    uint               TcpConnectionOffloadCapacity;
    uint               Flags;
}

struct NDIS_PORT_AUTHENTICATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
}

struct NDIS_WMI_METHOD_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint               PortNumber;
    NET_LUID_LH        NetLuid;
    ulong              RequestId;
    uint               Timeout;
    ubyte[4]           Padding;
}

struct NDIS_WMI_SET_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint               PortNumber;
    NET_LUID_LH        NetLuid;
    ulong              RequestId;
    uint               Timeout;
    ubyte[4]           Padding;
}

struct NDIS_WMI_EVENT_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint               IfIndex;
    NET_LUID_LH        NetLuid;
    ulong              RequestId;
    uint               PortNumber;
    uint               DeviceNameLength;
    uint               DeviceNameOffset;
    ubyte[4]           Padding;
}

struct NDIS_WMI_ENUM_ADAPTER
{
    NDIS_OBJECT_HEADER Header;
    uint               IfIndex;
    NET_LUID_LH        NetLuid;
    ushort             DeviceNameLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/CHAR[1] DeviceName;
}

struct NDIS_WMI_OUTPUT_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    ubyte              SupportedRevision;
    uint               DataOffset;
}

struct NDIS_RECEIVE_SCALE_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    uint               CapabilitiesFlags;
    uint               NumberOfInterruptMessages;
    uint               NumberOfReceiveQueues;
}

struct NDIS_RECEIVE_SCALE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ushort             Flags;
    ushort             BaseCpuNumber;
    uint               HashInformation;
    ushort             IndirectionTableSize;
    uint               IndirectionTableOffset;
    ushort             HashSecretKeySize;
    uint               HashSecretKeyOffset;
}

struct NDIS_RECEIVE_HASH_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    uint               HashInformation;
    ushort             HashSecretKeySize;
    uint               HashSecretKeyOffset;
}

struct NDIS_PORT_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NET_IF_DIRECTION_TYPE Direction;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
    uint               Flags;
}

struct NDIS_PORT_CHARACTERISTICS
{
    NDIS_OBJECT_HEADER Header;
    uint               PortNumber;
    uint               Flags;
    NDIS_PORT_TYPE     Type;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NET_IF_DIRECTION_TYPE Direction;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
}

struct NDIS_PORT
{
    NDIS_PORT* Next;
    void*      NdisReserved;
    void*      MiniportReserved;
    void*      ProtocolReserved;
    NDIS_PORT_CHARACTERISTICS PortCharacteristics;
}

struct NDIS_PORT_ARRAY
{
    NDIS_OBJECT_HEADER Header;
    uint               NumberOfPorts;
    uint               OffsetFirstPort;
    uint               ElementSize;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/NDIS_PORT_CHARACTERISTICS[1] Ports;
}

struct NDIS_TIMESTAMP_CAPABILITY_FLAGS
{
    BOOLEAN PtpV2OverUdpIPv4EventMsgReceiveHw;
    BOOLEAN PtpV2OverUdpIPv4AllMsgReceiveHw;
    BOOLEAN PtpV2OverUdpIPv4EventMsgTransmitHw;
    BOOLEAN PtpV2OverUdpIPv4AllMsgTransmitHw;
    BOOLEAN PtpV2OverUdpIPv6EventMsgReceiveHw;
    BOOLEAN PtpV2OverUdpIPv6AllMsgReceiveHw;
    BOOLEAN PtpV2OverUdpIPv6EventMsgTransmitHw;
    BOOLEAN PtpV2OverUdpIPv6AllMsgTransmitHw;
    BOOLEAN AllReceiveHw;
    BOOLEAN AllTransmitHw;
    BOOLEAN TaggedTransmitHw;
    BOOLEAN AllReceiveSw;
    BOOLEAN AllTransmitSw;
    BOOLEAN TaggedTransmitSw;
}

struct NDIS_TIMESTAMP_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    ulong              HardwareClockFrequencyHz;
    BOOLEAN            CrossTimestamp;
    ulong              Reserved1;
    ulong              Reserved2;
    NDIS_TIMESTAMP_CAPABILITY_FLAGS TimestampFlags;
}

struct NDIS_HARDWARE_CROSSTIMESTAMP
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    ulong              SystemTimestamp1;
    ulong              HardwareClockTimestamp;
    ulong              SystemTimestamp2;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndkinfo/ns-ndkinfo-ndk_version))], [])
struct NDK_VERSION
{
    ushort Major;
    ushort Minor;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ndkinfo/ns-ndkinfo-ndk_adapter_info))], [])
struct NDK_ADAPTER_INFO
{
    NDK_VERSION         Version;
    uint                VendorId;
    uint                DeviceId;
    size_t              MaxRegistrationSize;
    size_t              MaxWindowSize;
    uint                FRMRPageCount;
    uint                MaxInitiatorRequestSge;
    uint                MaxReceiveRequestSge;
    uint                MaxReadRequestSge;
    uint                MaxTransferLength;
    uint                MaxInlineDataSize;
    uint                MaxInboundReadLimit;
    uint                MaxOutboundReadLimit;
    uint                MaxReceiveQueueDepth;
    uint                MaxInitiatorQueueDepth;
    uint                MaxSrqDepth;
    uint                MaxCqDepth;
    uint                LargeRequestThreshold;
    uint                MaxCallerData;
    uint                MaxCalleeData;
    uint                AdapterFlags;
    NDK_RDMA_TECHNOLOGY RdmaTechnology;
}

