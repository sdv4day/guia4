// Written in the D programming language.

module windows.win32.networking.winsock;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, CHAR, FARPROC, HANDLE, HRESULT, HWND, LPARAM, LUID, PSTR, PWSTR,
                                         WAIT_EVENT, WPARAM;
public import windows.win32.system.com : BLOB;
public import windows.win32.system.io : OVERLAPPED, OVERLAPPED_ENTRY;
public import windows.win32.system.kernel : COMPARTMENT_ID, PROCESSOR_NUMBER;

extern(Windows) @nogc nothrow:


// Enums


alias WSA_ERROR = int;
enum : int
{
    WSA_IO_PENDING              = 0x000003e5,
    WSA_IO_INCOMPLETE           = 0x000003e4,
    WSA_INVALID_HANDLE          = 0x00000006,
    WSA_INVALID_PARAMETER       = 0x00000057,
    WSA_NOT_ENOUGH_MEMORY       = 0x00000008,
    WSA_OPERATION_ABORTED       = 0x000003e3,
    WSA_WAIT_EVENT_0            = 0x00000000,
    WSA_WAIT_IO_COMPLETION      = 0x000000c0,
    WSABASEERR                  = 0x00002710,
    WSAEINTR                    = 0x00002714,
    WSAEBADF                    = 0x00002719,
    WSAEACCES                   = 0x0000271d,
    WSAEFAULT                   = 0x0000271e,
    WSAEINVAL                   = 0x00002726,
    WSAEMFILE                   = 0x00002728,
    WSAEWOULDBLOCK              = 0x00002733,
    WSAEINPROGRESS              = 0x00002734,
    WSAEALREADY                 = 0x00002735,
    WSAENOTSOCK                 = 0x00002736,
    WSAEDESTADDRREQ             = 0x00002737,
    WSAEMSGSIZE                 = 0x00002738,
    WSAEPROTOTYPE               = 0x00002739,
    WSAENOPROTOOPT              = 0x0000273a,
    WSAEPROTONOSUPPORT          = 0x0000273b,
    WSAESOCKTNOSUPPORT          = 0x0000273c,
    WSAEOPNOTSUPP               = 0x0000273d,
    WSAEPFNOSUPPORT             = 0x0000273e,
    WSAEAFNOSUPPORT             = 0x0000273f,
    WSAEADDRINUSE               = 0x00002740,
    WSAEADDRNOTAVAIL            = 0x00002741,
    WSAENETDOWN                 = 0x00002742,
    WSAENETUNREACH              = 0x00002743,
    WSAENETRESET                = 0x00002744,
    WSAECONNABORTED             = 0x00002745,
    WSAECONNRESET               = 0x00002746,
    WSAENOBUFS                  = 0x00002747,
    WSAEISCONN                  = 0x00002748,
    WSAENOTCONN                 = 0x00002749,
    WSAESHUTDOWN                = 0x0000274a,
    WSAETOOMANYREFS             = 0x0000274b,
    WSAETIMEDOUT                = 0x0000274c,
    WSAECONNREFUSED             = 0x0000274d,
    WSAELOOP                    = 0x0000274e,
    WSAENAMETOOLONG             = 0x0000274f,
    WSAEHOSTDOWN                = 0x00002750,
    WSAEHOSTUNREACH             = 0x00002751,
    WSAENOTEMPTY                = 0x00002752,
    WSAEPROCLIM                 = 0x00002753,
    WSAEUSERS                   = 0x00002754,
    WSAEDQUOT                   = 0x00002755,
    WSAESTALE                   = 0x00002756,
    WSAEREMOTE                  = 0x00002757,
    WSASYSNOTREADY              = 0x0000276b,
    WSAVERNOTSUPPORTED          = 0x0000276c,
    WSANOTINITIALISED           = 0x0000276d,
    WSAEDISCON                  = 0x00002775,
    WSAENOMORE                  = 0x00002776,
    WSAECANCELLED               = 0x00002777,
    WSAEINVALIDPROCTABLE        = 0x00002778,
    WSAEINVALIDPROVIDER         = 0x00002779,
    WSAEPROVIDERFAILEDINIT      = 0x0000277a,
    WSASYSCALLFAILURE           = 0x0000277b,
    WSASERVICE_NOT_FOUND        = 0x0000277c,
    WSATYPE_NOT_FOUND           = 0x0000277d,
    WSA_E_NO_MORE               = 0x0000277e,
    WSA_E_CANCELLED             = 0x0000277f,
    WSAEREFUSED                 = 0x00002780,
    WSAHOST_NOT_FOUND           = 0x00002af9,
    WSATRY_AGAIN                = 0x00002afa,
    WSANO_RECOVERY              = 0x00002afb,
    WSANO_DATA                  = 0x00002afc,
    WSA_QOS_RECEIVERS           = 0x00002afd,
    WSA_QOS_SENDERS             = 0x00002afe,
    WSA_QOS_NO_SENDERS          = 0x00002aff,
    WSA_QOS_NO_RECEIVERS        = 0x00002b00,
    WSA_QOS_REQUEST_CONFIRMED   = 0x00002b01,
    WSA_QOS_ADMISSION_FAILURE   = 0x00002b02,
    WSA_QOS_POLICY_FAILURE      = 0x00002b03,
    WSA_QOS_BAD_STYLE           = 0x00002b04,
    WSA_QOS_BAD_OBJECT          = 0x00002b05,
    WSA_QOS_TRAFFIC_CTRL_ERROR  = 0x00002b06,
    WSA_QOS_GENERIC_ERROR       = 0x00002b07,
    WSA_QOS_ESERVICETYPE        = 0x00002b08,
    WSA_QOS_EFLOWSPEC           = 0x00002b09,
    WSA_QOS_EPROVSPECBUF        = 0x00002b0a,
    WSA_QOS_EFILTERSTYLE        = 0x00002b0b,
    WSA_QOS_EFILTERTYPE         = 0x00002b0c,
    WSA_QOS_EFILTERCOUNT        = 0x00002b0d,
    WSA_QOS_EOBJLENGTH          = 0x00002b0e,
    WSA_QOS_EFLOWCOUNT          = 0x00002b0f,
    WSA_QOS_EUNKOWNPSOBJ        = 0x00002b10,
    WSA_QOS_EPOLICYOBJ          = 0x00002b11,
    WSA_QOS_EFLOWDESC           = 0x00002b12,
    WSA_QOS_EPSFLOWSPEC         = 0x00002b13,
    WSA_QOS_EPSFILTERSPEC       = 0x00002b14,
    WSA_QOS_ESDMODEOBJ          = 0x00002b15,
    WSA_QOS_ESHAPERATEOBJ       = 0x00002b16,
    WSA_QOS_RESERVED_PETYPE     = 0x00002b17,
    WSA_SECURE_HOST_NOT_FOUND   = 0x00002b18,
    WSA_IPSEC_NAME_POLICY_ERROR = 0x00002b19,
}

alias ADDRESS_FAMILY = ushort;
enum : ushort
{
    AF_INET   = cast(ushort)0x0002,
    AF_INET6  = cast(ushort)0x0017,
    AF_UNSPEC = cast(ushort)0x0000,
}

alias SET_SERVICE_OPERATION = uint;
enum : uint
{
    SERVICE_REGISTER    = 0x00000001,
    SERVICE_DEREGISTER  = 0x00000002,
    SERVICE_FLUSH       = 0x00000003,
    SERVICE_ADD_TYPE    = 0x00000004,
    SERVICE_DELETE_TYPE = 0x00000005,
}

alias SEND_RECV_FLAGS = int;
enum : int
{
    MSG_OOB            = 0x00000001,
    MSG_PEEK           = 0x00000002,
    MSG_DONTROUTE      = 0x00000004,
    MSG_WAITALL        = 0x00000008,
    MSG_PUSH_IMMEDIATE = 0x00000020,
}

alias RESOURCE_DISPLAY_TYPE = uint;
enum : uint
{
    RESOURCEDISPLAYTYPE_DOMAIN  = 0x00000001,
    RESOURCEDISPLAYTYPE_FILE    = 0x00000004,
    RESOURCEDISPLAYTYPE_GENERIC = 0x00000000,
    RESOURCEDISPLAYTYPE_GROUP   = 0x00000005,
    RESOURCEDISPLAYTYPE_SERVER  = 0x00000002,
    RESOURCEDISPLAYTYPE_SHARE   = 0x00000003,
    RESOURCEDISPLAYTYPE_TREE    = 0x0000000a,
}

alias WSAPOLL_EVENT_FLAGS = short;
enum : short
{
    POLLRDNORM = cast(short)0x0100,
    POLLRDBAND = cast(short)0x0200,
    POLLIN     = cast(short)0x0300,
    POLLPRI    = cast(short)0x0400,
    POLLWRNORM = cast(short)0x0010,
    POLLOUT    = cast(short)0x0010,
    POLLWRBAND = cast(short)0x0020,
    POLLERR    = cast(short)0x0001,
    POLLHUP    = cast(short)0x0002,
    POLLNVAL   = cast(short)0x0004,
}

alias WINSOCK_SHUTDOWN_HOW = int;
enum : int
{
    SD_RECEIVE = 0x00000000,
    SD_SEND    = 0x00000001,
    SD_BOTH    = 0x00000002,
}

alias WINSOCK_SOCKET_TYPE = int;
enum : int
{
    SOCK_STREAM    = 0x00000001,
    SOCK_DGRAM     = 0x00000002,
    SOCK_RAW       = 0x00000003,
    SOCK_RDM       = 0x00000004,
    SOCK_SEQPACKET = 0x00000005,
}

alias IPPROTO = int;
enum : int
{
    IPPROTO_HOPOPTS               = 0x00000000,
    IPPROTO_ICMP                  = 0x00000001,
    IPPROTO_IGMP                  = 0x00000002,
    IPPROTO_GGP                   = 0x00000003,
    IPPROTO_IPV4                  = 0x00000004,
    IPPROTO_ST                    = 0x00000005,
    IPPROTO_TCP                   = 0x00000006,
    IPPROTO_CBT                   = 0x00000007,
    IPPROTO_EGP                   = 0x00000008,
    IPPROTO_IGP                   = 0x00000009,
    IPPROTO_PUP                   = 0x0000000c,
    IPPROTO_UDP                   = 0x00000011,
    IPPROTO_IDP                   = 0x00000016,
    IPPROTO_RDP                   = 0x0000001b,
    IPPROTO_IPV6                  = 0x00000029,
    IPPROTO_ROUTING               = 0x0000002b,
    IPPROTO_FRAGMENT              = 0x0000002c,
    IPPROTO_ESP                   = 0x00000032,
    IPPROTO_AH                    = 0x00000033,
    IPPROTO_ICMPV6                = 0x0000003a,
    IPPROTO_NONE                  = 0x0000003b,
    IPPROTO_DSTOPTS               = 0x0000003c,
    IPPROTO_ND                    = 0x0000004d,
    IPPROTO_ICLFXBM               = 0x0000004e,
    IPPROTO_PIM                   = 0x00000067,
    IPPROTO_PGM                   = 0x00000071,
    IPPROTO_L2TP                  = 0x00000073,
    IPPROTO_SCTP                  = 0x00000084,
    IPPROTO_RAW                   = 0x000000ff,
    IPPROTO_MAX                   = 0x00000100,
    IPPROTO_RESERVED_RAW          = 0x00000101,
    IPPROTO_RESERVED_IPSEC        = 0x00000102,
    IPPROTO_RESERVED_IPSECOFFLOAD = 0x00000103,
    IPPROTO_RESERVED_WNV          = 0x00000104,
    IPPROTO_RESERVED_MAX          = 0x00000105,
    IPPROTO_IP                    = 0x00000000,
    IPPROTO_RM                    = 0x00000071,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ne-ws2def-scope_level))], [])

alias SCOPE_LEVEL = int;
enum : int
{
    ScopeLevelInterface    = 0x00000001,
    ScopeLevelLink         = 0x00000002,
    ScopeLevelSubnet       = 0x00000003,
    ScopeLevelAdmin        = 0x00000004,
    ScopeLevelSite         = 0x00000005,
    ScopeLevelOrganization = 0x00000008,
    ScopeLevelGlobal       = 0x0000000e,
    ScopeLevelCount        = 0x00000010,
}

alias WSACOMPLETIONTYPE = int;
enum : int
{
    NSP_NOTIFY_IMMEDIATELY = 0x00000000,
    NSP_NOTIFY_HWND        = 0x00000001,
    NSP_NOTIFY_EVENT       = 0x00000002,
    NSP_NOTIFY_PORT        = 0x00000003,
    NSP_NOTIFY_APC         = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ne-winsock2-wsaecomparator))], [])

alias WSAECOMPARATOR = int;
enum : int
{
    COMP_EQUAL   = 0x00000000,
    COMP_NOTLESS = 0x00000001,
}

alias WSAESETSERVICEOP = int;
enum : int
{
    RNRSERVICE_REGISTER   = 0x00000000,
    RNRSERVICE_DEREGISTER = 0x00000001,
    RNRSERVICE_DELETE     = 0x00000002,
}

alias PMTUD_STATE = int;
enum : int
{
    IP_PMTUDISC_NOT_SET = 0x00000000,
    IP_PMTUDISC_DO      = 0x00000001,
    IP_PMTUDISC_DONT    = 0x00000002,
    IP_PMTUDISC_PROBE   = 0x00000003,
    IP_PMTUDISC_MAX     = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ne-ws2ipdef-multicast_mode_type))], [])

alias MULTICAST_MODE_TYPE = int;
enum : int
{
    MCAST_INCLUDE = 0x00000000,
    MCAST_EXCLUDE = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsrm/ne-wsrm-ewindow_advance_method))], [])

alias eWINDOW_ADVANCE_METHOD = int;
enum : int
{
    E_WINDOW_ADVANCE_BY_TIME   = 0x00000001,
    E_WINDOW_USE_AS_DATA_CACHE = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_prefix_origin))], [])

alias NL_PREFIX_ORIGIN = int;
enum : int
{
    IpPrefixOriginOther               = 0x00000000,
    IpPrefixOriginManual              = 0x00000001,
    IpPrefixOriginWellKnown           = 0x00000002,
    IpPrefixOriginDhcp                = 0x00000003,
    IpPrefixOriginRouterAdvertisement = 0x00000004,
    IpPrefixOriginUnchanged           = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_suffix_origin))], [])

alias NL_SUFFIX_ORIGIN = int;
enum : int
{
    NlsoOther                      = 0x00000000,
    NlsoManual                     = 0x00000001,
    NlsoWellKnown                  = 0x00000002,
    NlsoDhcp                       = 0x00000003,
    NlsoLinkLayerAddress           = 0x00000004,
    NlsoRandom                     = 0x00000005,
    IpSuffixOriginOther            = 0x00000000,
    IpSuffixOriginManual           = 0x00000001,
    IpSuffixOriginWellKnown        = 0x00000002,
    IpSuffixOriginDhcp             = 0x00000003,
    IpSuffixOriginLinkLayerAddress = 0x00000004,
    IpSuffixOriginRandom           = 0x00000005,
    IpSuffixOriginUnchanged        = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_dad_state))], [])

alias NL_DAD_STATE = int;
enum : int
{
    NldsInvalid          = 0x00000000,
    NldsTentative        = 0x00000001,
    NldsDuplicate        = 0x00000002,
    NldsDeprecated       = 0x00000003,
    NldsPreferred        = 0x00000004,
    IpDadStateInvalid    = 0x00000000,
    IpDadStateTentative  = 0x00000001,
    IpDadStateDuplicate  = 0x00000002,
    IpDadStateDeprecated = 0x00000003,
    IpDadStatePreferred  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_route_protocol))], [])

alias NL_ROUTE_PROTOCOL = int;
enum : int
{
    RouteProtocolOther            = 0x00000001,
    RouteProtocolLocal            = 0x00000002,
    RouteProtocolNetMgmt          = 0x00000003,
    RouteProtocolIcmp             = 0x00000004,
    RouteProtocolEgp              = 0x00000005,
    RouteProtocolGgp              = 0x00000006,
    RouteProtocolHello            = 0x00000007,
    RouteProtocolRip              = 0x00000008,
    RouteProtocolIsIs             = 0x00000009,
    RouteProtocolEsIs             = 0x0000000a,
    RouteProtocolCisco            = 0x0000000b,
    RouteProtocolBbn              = 0x0000000c,
    RouteProtocolOspf             = 0x0000000d,
    RouteProtocolBgp              = 0x0000000e,
    RouteProtocolIdpr             = 0x0000000f,
    RouteProtocolEigrp            = 0x00000010,
    RouteProtocolDvmrp            = 0x00000011,
    RouteProtocolRpl              = 0x00000012,
    RouteProtocolDhcp             = 0x00000013,
    MIB_IPPROTO_OTHER             = 0x00000001,
    PROTO_IP_OTHER                = 0x00000001,
    MIB_IPPROTO_LOCAL             = 0x00000002,
    PROTO_IP_LOCAL                = 0x00000002,
    MIB_IPPROTO_NETMGMT           = 0x00000003,
    PROTO_IP_NETMGMT              = 0x00000003,
    MIB_IPPROTO_ICMP              = 0x00000004,
    PROTO_IP_ICMP                 = 0x00000004,
    MIB_IPPROTO_EGP               = 0x00000005,
    PROTO_IP_EGP                  = 0x00000005,
    MIB_IPPROTO_GGP               = 0x00000006,
    PROTO_IP_GGP                  = 0x00000006,
    MIB_IPPROTO_HELLO             = 0x00000007,
    PROTO_IP_HELLO                = 0x00000007,
    MIB_IPPROTO_RIP               = 0x00000008,
    PROTO_IP_RIP                  = 0x00000008,
    MIB_IPPROTO_IS_IS             = 0x00000009,
    PROTO_IP_IS_IS                = 0x00000009,
    MIB_IPPROTO_ES_IS             = 0x0000000a,
    PROTO_IP_ES_IS                = 0x0000000a,
    MIB_IPPROTO_CISCO             = 0x0000000b,
    PROTO_IP_CISCO                = 0x0000000b,
    MIB_IPPROTO_BBN               = 0x0000000c,
    PROTO_IP_BBN                  = 0x0000000c,
    MIB_IPPROTO_OSPF              = 0x0000000d,
    PROTO_IP_OSPF                 = 0x0000000d,
    MIB_IPPROTO_BGP               = 0x0000000e,
    PROTO_IP_BGP                  = 0x0000000e,
    MIB_IPPROTO_IDPR              = 0x0000000f,
    PROTO_IP_IDPR                 = 0x0000000f,
    MIB_IPPROTO_EIGRP             = 0x00000010,
    PROTO_IP_EIGRP                = 0x00000010,
    MIB_IPPROTO_DVMRP             = 0x00000011,
    PROTO_IP_DVMRP                = 0x00000011,
    MIB_IPPROTO_RPL               = 0x00000012,
    PROTO_IP_RPL                  = 0x00000012,
    MIB_IPPROTO_DHCP              = 0x00000013,
    PROTO_IP_DHCP                 = 0x00000013,
    MIB_IPPROTO_NT_AUTOSTATIC     = 0x00002712,
    PROTO_IP_NT_AUTOSTATIC        = 0x00002712,
    MIB_IPPROTO_NT_STATIC         = 0x00002716,
    PROTO_IP_NT_STATIC            = 0x00002716,
    MIB_IPPROTO_NT_STATIC_NON_DOD = 0x00002717,
    PROTO_IP_NT_STATIC_NON_DOD    = 0x00002717,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_address_type))], [])

alias NL_ADDRESS_TYPE = int;
enum : int
{
    NlatUnspecified = 0x00000000,
    NlatUnicast     = 0x00000001,
    NlatAnycast     = 0x00000002,
    NlatMulticast   = 0x00000003,
    NlatBroadcast   = 0x00000004,
    NlatInvalid     = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_route_origin))], [])

alias NL_ROUTE_ORIGIN = int;
enum : int
{
    NlroManual              = 0x00000000,
    NlroWellKnown           = 0x00000001,
    NlroDHCP                = 0x00000002,
    NlroRouterAdvertisement = 0x00000003,
    Nlro6to4                = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_neighbor_state))], [])

alias NL_NEIGHBOR_STATE = int;
enum : int
{
    NlnsUnreachable = 0x00000000,
    NlnsIncomplete  = 0x00000001,
    NlnsProbe       = 0x00000002,
    NlnsDelay       = 0x00000003,
    NlnsStale       = 0x00000004,
    NlnsReachable   = 0x00000005,
    NlnsPermanent   = 0x00000006,
    NlnsMaximum     = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_link_local_address_behavior))], [])

alias NL_LINK_LOCAL_ADDRESS_BEHAVIOR = int;
enum : int
{
    LinkLocalAlwaysOff = 0x00000000,
    LinkLocalDelayed   = 0x00000001,
    LinkLocalAlwaysOn  = 0x00000002,
    LinkLocalUnchanged = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_router_discovery_behavior))], [])

alias NL_ROUTER_DISCOVERY_BEHAVIOR = int;
enum : int
{
    RouterDiscoveryDisabled  = 0x00000000,
    RouterDiscoveryEnabled   = 0x00000001,
    RouterDiscoveryDhcp      = 0x00000002,
    RouterDiscoveryUnchanged = 0xffffffff,
}

alias NL_BANDWIDTH_FLAG = int;
enum : int
{
    NlbwDisabled  = 0x00000000,
    NlbwEnabled   = 0x00000001,
    NlbwUnchanged = 0xffffffff,
}

alias NL_NETWORK_CATEGORY = int;
enum : int
{
    NetworkCategoryPublic              = 0x00000000,
    NetworkCategoryPrivate             = 0x00000001,
    NetworkCategoryDomainAuthenticated = 0x00000002,
    NetworkCategoryUnchanged           = 0xffffffff,
    NetworkCategoryUnknown             = 0xffffffff,
}

alias NL_INTERFACE_NETWORK_CATEGORY_STATE = int;
enum : int
{
    NlincCategoryUnknown     = 0x00000000,
    NlincPublic              = 0x00000001,
    NlincPrivate             = 0x00000002,
    NlincDomainAuthenticated = 0x00000003,
    NlincCategoryStateMax    = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_network_connectivity_level_hint))], [])

alias NL_NETWORK_CONNECTIVITY_LEVEL_HINT = int;
enum : int
{
    NetworkConnectivityLevelHintUnknown                   = 0x00000000,
    NetworkConnectivityLevelHintNone                      = 0x00000001,
    NetworkConnectivityLevelHintLocalAccess               = 0x00000002,
    NetworkConnectivityLevelHintInternetAccess            = 0x00000003,
    NetworkConnectivityLevelHintConstrainedInternetAccess = 0x00000004,
    NetworkConnectivityLevelHintHidden                    = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_network_connectivity_cost_hint))], [])

alias NL_NETWORK_CONNECTIVITY_COST_HINT = int;
enum : int
{
    NetworkConnectivityCostHintUnknown      = 0x00000000,
    NetworkConnectivityCostHintUnrestricted = 0x00000001,
    NetworkConnectivityCostHintFixed        = 0x00000002,
    NetworkConnectivityCostHintVariable     = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ne-mstcpip-tcpstate))], [])

alias TCPSTATE = int;
enum : int
{
    TCPSTATE_CLOSED      = 0x00000000,
    TCPSTATE_LISTEN      = 0x00000001,
    TCPSTATE_SYN_SENT    = 0x00000002,
    TCPSTATE_SYN_RCVD    = 0x00000003,
    TCPSTATE_ESTABLISHED = 0x00000004,
    TCPSTATE_FIN_WAIT_1  = 0x00000005,
    TCPSTATE_FIN_WAIT_2  = 0x00000006,
    TCPSTATE_CLOSE_WAIT  = 0x00000007,
    TCPSTATE_CLOSING     = 0x00000008,
    TCPSTATE_LAST_ACK    = 0x00000009,
    TCPSTATE_TIME_WAIT   = 0x0000000a,
    TCPSTATE_MAX         = 0x0000000b,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ne-mstcpip-control_channel_trigger_status))], [])

alias CONTROL_CHANNEL_TRIGGER_STATUS = int;
enum : int
{
    CONTROL_CHANNEL_TRIGGER_STATUS_INVALID                 = 0x00000000,
    CONTROL_CHANNEL_TRIGGER_STATUS_SOFTWARE_SLOT_ALLOCATED = 0x00000001,
    CONTROL_CHANNEL_TRIGGER_STATUS_HARDWARE_SLOT_ALLOCATED = 0x00000002,
    CONTROL_CHANNEL_TRIGGER_STATUS_POLICY_ERROR            = 0x00000003,
    CONTROL_CHANNEL_TRIGGER_STATUS_SYSTEM_ERROR            = 0x00000004,
    CONTROL_CHANNEL_TRIGGER_STATUS_TRANSPORT_DISCONNECTED  = 0x00000005,
    CONTROL_CHANNEL_TRIGGER_STATUS_SERVICE_UNAVAILABLE     = 0x00000006,
}

alias SOCKET_PRIORITY_HINT = int;
enum : int
{
    SocketPriorityHintVeryLow     = 0x00000000,
    SocketPriorityHintLow         = 0x00000001,
    SocketPriorityHintNormal      = 0x00000002,
    SocketMaximumPriorityHintType = 0x00000003,
}

alias RCVALL_VALUE = int;
enum : int
{
    RCVALL_OFF             = 0x00000000,
    RCVALL_ON              = 0x00000001,
    RCVALL_SOCKETLEVELONLY = 0x00000002,
    RCVALL_IPLEVEL         = 0x00000003,
}

alias TCP_ICW_LEVEL = int;
enum : int
{
    TCP_ICW_LEVEL_DEFAULT      = 0x00000000,
    TCP_ICW_LEVEL_HIGH         = 0x00000001,
    TCP_ICW_LEVEL_VERY_HIGH    = 0x00000002,
    TCP_ICW_LEVEL_AGGRESSIVE   = 0x00000003,
    TCP_ICW_LEVEL_EXPERIMENTAL = 0x00000004,
    TCP_ICW_LEVEL_COMPAT       = 0x000000fe,
    TCP_ICW_LEVEL_MAX          = 0x000000ff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ne-mstcpip-socket_usage_type))], [])

alias SOCKET_USAGE_TYPE = int;
enum : int
{
    SYSTEM_CRITICAL_SOCKET = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ne-mstcpip-socket_security_protocol))], [])

alias SOCKET_SECURITY_PROTOCOL = int;
enum : int
{
    SOCKET_SECURITY_PROTOCOL_DEFAULT = 0x00000000,
    SOCKET_SECURITY_PROTOCOL_IPSEC   = 0x00000001,
    SOCKET_SECURITY_PROTOCOL_IPSEC2  = 0x00000002,
    SOCKET_SECURITY_PROTOCOL_INVALID = 0x00000003,
}

alias WSA_COMPATIBILITY_BEHAVIOR_ID = int;
enum : int
{
    WsaBehaviorAll              = 0x00000000,
    WsaBehaviorReceiveBuffering = 0x00000001,
    WsaBehaviorAutoTuning       = 0x00000002,
}

alias Q2931_IE_TYPE = int;
enum : int
{
    IE_AALParameters             = 0x00000000,
    IE_TrafficDescriptor         = 0x00000001,
    IE_BroadbandBearerCapability = 0x00000002,
    IE_BHLI                      = 0x00000003,
    IE_BLLI                      = 0x00000004,
    IE_CalledPartyNumber         = 0x00000005,
    IE_CalledPartySubaddress     = 0x00000006,
    IE_CallingPartyNumber        = 0x00000007,
    IE_CallingPartySubaddress    = 0x00000008,
    IE_Cause                     = 0x00000009,
    IE_QOSClass                  = 0x0000000a,
    IE_TransitNetworkSelection   = 0x0000000b,
}

alias AAL_TYPE = int;
enum : int
{
    AALTYPE_5    = 0x00000005,
    AALTYPE_USER = 0x00000010,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nsemail/ne-nsemail-napi_provider_type))], [])

alias NAPI_PROVIDER_TYPE = int;
enum : int
{
    ProviderType_Application = 0x00000001,
    ProviderType_Service     = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nsemail/ne-nsemail-napi_provider_level))], [])

alias NAPI_PROVIDER_LEVEL = int;
enum : int
{
    ProviderLevel_None      = 0x00000000,
    ProviderLevel_Secondary = 0x00000001,
    ProviderLevel_Primary   = 0x00000002,
}

alias NLA_BLOB_DATA_TYPE = int;
enum : int
{
    NLA_RAW_DATA        = 0x00000000,
    NLA_INTERFACE       = 0x00000001,
    NLA_802_1X_LOCATION = 0x00000002,
    NLA_CONNECTIVITY    = 0x00000003,
    NLA_ICS             = 0x00000004,
}

alias NLA_CONNECTIVITY_TYPE = int;
enum : int
{
    NLA_NETWORK_AD_HOC    = 0x00000000,
    NLA_NETWORK_MANAGED   = 0x00000001,
    NLA_NETWORK_UNMANAGED = 0x00000002,
    NLA_NETWORK_UNKNOWN   = 0x00000003,
}

alias NLA_INTERNET = int;
enum : int
{
    NLA_INTERNET_UNKNOWN = 0x00000000,
    NLA_INTERNET_NO      = 0x00000001,
    NLA_INTERNET_YES     = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsock/ne-mswsock-rio_notification_completion_type))], [])

alias RIO_NOTIFICATION_COMPLETION_TYPE = int;
enum : int
{
    RIO_EVENT_COMPLETION = 0x00000001,
    RIO_IOCP_COMPLETION  = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/ne-ws2spi-wsc_provider_info_type))], [])

alias WSC_PROVIDER_INFO_TYPE = int;
enum : int
{
    ProviderInfoLspCategories = 0x00000000,
    ProviderInfoAudit         = 0x00000001,
}

alias IPV4_OPTION_TYPE = int;
enum : int
{
    IP_OPT_EOL          = 0x00000000,
    IP_OPT_NOP          = 0x00000001,
    IP_OPT_SECURITY     = 0x00000082,
    IP_OPT_LSRR         = 0x00000083,
    IP_OPT_TS           = 0x00000044,
    IP_OPT_RR           = 0x00000007,
    IP_OPT_SSRR         = 0x00000089,
    IP_OPT_SID          = 0x00000088,
    IP_OPT_ROUTER_ALERT = 0x00000094,
    IP_OPT_MULTIDEST    = 0x00000095,
}

alias IP_OPTION_TIMESTAMP_FLAGS = int;
enum : int
{
    IP_OPTION_TIMESTAMP_ONLY             = 0x00000000,
    IP_OPTION_TIMESTAMP_ADDRESS          = 0x00000001,
    IP_OPTION_TIMESTAMP_SPECIFIC_ADDRESS = 0x00000003,
}

alias ICMP4_UNREACH_CODE = int;
enum : int
{
    ICMP4_UNREACH_NET                = 0x00000000,
    ICMP4_UNREACH_HOST               = 0x00000001,
    ICMP4_UNREACH_PROTOCOL           = 0x00000002,
    ICMP4_UNREACH_PORT               = 0x00000003,
    ICMP4_UNREACH_FRAG_NEEDED        = 0x00000004,
    ICMP4_UNREACH_SOURCEROUTE_FAILED = 0x00000005,
    ICMP4_UNREACH_NET_UNKNOWN        = 0x00000006,
    ICMP4_UNREACH_HOST_UNKNOWN       = 0x00000007,
    ICMP4_UNREACH_ISOLATED           = 0x00000008,
    ICMP4_UNREACH_NET_ADMIN          = 0x00000009,
    ICMP4_UNREACH_HOST_ADMIN         = 0x0000000a,
    ICMP4_UNREACH_NET_TOS            = 0x0000000b,
    ICMP4_UNREACH_HOST_TOS           = 0x0000000c,
    ICMP4_UNREACH_ADMIN              = 0x0000000d,
}

alias ICMP4_TIME_EXCEED_CODE = int;
enum : int
{
    ICMP4_TIME_EXCEED_TRANSIT    = 0x00000000,
    ICMP4_TIME_EXCEED_REASSEMBLY = 0x00000001,
}

alias ARP_OPCODE = int;
enum : int
{
    ARP_REQUEST  = 0x00000001,
    ARP_RESPONSE = 0x00000002,
}

alias ARP_HARDWARE_TYPE = int;
enum : int
{
    ARP_HW_ENET = 0x00000001,
    ARP_HW_802  = 0x00000006,
}

alias IGMP_MAX_RESP_CODE_TYPE = int;
enum : int
{
    IGMP_MAX_RESP_CODE_TYPE_NORMAL = 0x00000000,
    IGMP_MAX_RESP_CODE_TYPE_FLOAT  = 0x00000001,
}

alias IPV6_OPTION_TYPE = int;
enum : int
{
    IP6OPT_PAD1         = 0x00000000,
    IP6OPT_PADN         = 0x00000001,
    IP6OPT_TUNNEL_LIMIT = 0x00000004,
    IP6OPT_ROUTER_ALERT = 0x00000005,
    IP6OPT_JUMBO        = 0x000000c2,
    IP6OPT_NSAP_ADDR    = 0x000000c3,
}

alias ND_OPTION_TYPE = int;
enum : int
{
    ND_OPT_SOURCE_LINKADDR        = 0x00000001,
    ND_OPT_TARGET_LINKADDR        = 0x00000002,
    ND_OPT_PREFIX_INFORMATION     = 0x00000003,
    ND_OPT_REDIRECTED_HEADER      = 0x00000004,
    ND_OPT_MTU                    = 0x00000005,
    ND_OPT_NBMA_SHORTCUT_LIMIT    = 0x00000006,
    ND_OPT_ADVERTISEMENT_INTERVAL = 0x00000007,
    ND_OPT_HOME_AGENT_INFORMATION = 0x00000008,
    ND_OPT_SOURCE_ADDR_LIST       = 0x00000009,
    ND_OPT_TARGET_ADDR_LIST       = 0x0000000a,
    ND_OPT_ROUTE_INFO             = 0x00000018,
    ND_OPT_RDNSS                  = 0x00000019,
    ND_OPT_DNSSL                  = 0x0000001f,
    ND_OPT_PREF64                 = 0x00000026,
}

alias ND_OPT_PREF64_PREFIX_LENGTH_CODE = int;
enum : int
{
    ND_OPT_PREF64_PREFIX_LENGTH_96 = 0x00000000,
    ND_OPT_PREF64_PREFIX_LENGTH_64 = 0x00000001,
    ND_OPT_PREF64_PREFIX_LENGTH_56 = 0x00000002,
    ND_OPT_PREF64_PREFIX_LENGTH_48 = 0x00000003,
    ND_OPT_PREF64_PREFIX_LENGTH_40 = 0x00000004,
    ND_OPT_PREF64_PREFIX_LENGTH_32 = 0x00000005,
}

alias MLD_MAX_RESP_CODE_TYPE = int;
enum : int
{
    MLD_MAX_RESP_CODE_TYPE_NORMAL = 0x00000000,
    MLD_MAX_RESP_CODE_TYPE_FLOAT  = 0x00000001,
}

alias TUNNEL_SUB_TYPE = int;
enum : int
{
    TUNNEL_SUB_TYPE_NONE  = 0x00000000,
    TUNNEL_SUB_TYPE_CP    = 0x00000001,
    TUNNEL_SUB_TYPE_IPTLS = 0x00000002,
    TUNNEL_SUB_TYPE_HA    = 0x00000003,
}

alias NPI_MODULEID_TYPE = int;
enum : int
{
    MIT_GUID    = 0x00000001,
    MIT_IF_LUID = 0x00000002,
}

alias FALLBACK_INDEX = int;
enum : int
{
    FallbackIndexTcpFastopen = 0x00000000,
    FallbackIndexMax         = 0x00000001,
}

// Constants


enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/sio-rcvall))], [])*/uint
{
    SIO_RCVALL           = 0x98000001,
    SIO_RCVALL_MCAST     = 0x98000002,
    SIO_RCVALL_IGMPMCAST = 0x98000003,
}

enum uint SIO_ABSORB_RTRALERT = 0x98000005;
enum uint SIO_LIMIT_BROADCASTS = 0x98000007;

enum : uint
{
    SIO_INDEX_MCASTIF   = 0x98000009,
    SIO_INDEX_ADD_MCAST = 0x9800000a,
    SIO_INDEX_DEL_MCAST = 0x9800000b,
}

enum uint SIO_RCVALL_IF = 0x9800000e;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/sio-tcp-initial-rto))], [])*/uint SIO_TCP_INITIAL_RTO = 0x98000011;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/sio-query-transport-setting))], [])*/uint SIO_QUERY_TRANSPORT_SETTING = 0x98000014;
enum uint SIO_TCP_SET_ACK_FREQUENCY = 0x98000017;
enum uint SIO_PRIORITY_HINT = 0x98000018;
enum uint SIO_CPU_AFFINITY = 0x98000015;

enum : uint
{
    TIMESTAMPING_FLAG_RX = 0x00000001,
    TIMESTAMPING_FLAG_TX = 0x00000002,
}

enum uint SO_TIMESTAMP_ID = 0x0000300b;
enum ushort TCP_INITIAL_RTO_UNSPECIFIED_MAX_SYN_RETRANSMISSIONS = cast(ushort)0xffff;
enum uint TCP_INITIAL_RTO_DEFAULT_MAX_SYN_RETRANSMISSIONS = 0x00000000;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/sio-acquire-port-reservation))], [])*/uint SIO_ACQUIRE_PORT_RESERVATION = 0x98000064;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/sio-associate-port-reservation))], [])*/uint SIO_ASSOCIATE_PORT_RESERVATION = 0x98000066;
enum uint SIO_QUERY_SECURITY = 0xd80000c9;
enum uint SIO_DELETE_PEER_TARGET_NAME = 0x980000cb;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/sio-query-wfp-connection-redirect-context))], [])*/uint SIO_QUERY_WFP_CONNECTION_REDIRECT_CONTEXT = 0x980000dd;
enum uint SIO_SOCKET_USAGE_NOTIFICATION = 0x980000cc;

enum : uint
{
    SOCKET_SETTINGS_ALLOW_INSECURE                            = 0x00000002,
    SOCKET_SETTINGS_IPSEC_SKIP_FILTER_INSTANTIATION           = 0x00000001,
    SOCKET_SETTINGS_IPSEC_OPTIONAL_PEER_NAME_VERIFICATION     = 0x00000002,
    SOCKET_SETTINGS_IPSEC_ALLOW_FIRST_INBOUND_PKT_UNENCRYPTED = 0x00000004,
}

enum uint SOCKET_QUERY_IPSEC2_ABORT_CONNECTION_ON_FIELD_CHANGE = 0x00000001;
enum uint SOCKET_QUERY_IPSEC2_FIELD_MASK_QM_SA_ID = 0x00000002;

enum : uint
{
    SOCKET_INFO_CONNECTION_ENCRYPTED    = 0x00000002,
    SOCKET_INFO_CONNECTION_IMPERSONATED = 0x00000004,
}

enum uint SIO_QUERY_RSS_SCALABILITY_INFO = 0x580000d2;

enum : uint
{
    IN4ADDR_LOOPBACK              = 0x0100007f,
    IN4ADDR_BROADCAST             = 0xffffffff,
    IN4ADDR_LOOPBACKPREFIX_LENGTH = 0x00000008,
}

enum uint IN4ADDR_MULTICASTPREFIX_LENGTH = 0x00000004;

enum : uint
{
    RIO_MSG_DONT_NOTIFY = 0x00000001,
    RIO_MSG_DEFER       = 0x00000002,
    RIO_MSG_WAITALL     = 0x00000004,
    RIO_MSG_COMMIT_ONLY = 0x00000008,
}

enum uint RIO_CORRUPT_CQ = 0xffffffff;
enum ushort AF_IMPLINK = cast(ushort)0x0003;
enum ushort AF_CHAOS = cast(ushort)0x0005;

enum : ushort
{
    AF_IPX     = cast(ushort)0x0006,
    AF_ISO     = cast(ushort)0x0007,
    AF_OSI     = cast(ushort)0x0007,
    AF_ECMA    = cast(ushort)0x0008,
    AF_DATAKIT = cast(ushort)0x0009,
}

enum : ushort
{
    AF_SNA    = cast(ushort)0x000b,
    AF_DECnet = cast(ushort)0x000c,
    AF_DLI    = cast(ushort)0x000d,
    AF_LAT    = cast(ushort)0x000e,
    AF_HYLINK = cast(ushort)0x000f,
}

enum ushort AF_NETBIOS = cast(ushort)0x0011;
enum ushort AF_FIREFOX = cast(ushort)0x0013;

enum : ushort
{
    AF_BAN     = cast(ushort)0x0015,
    AF_ATM     = cast(ushort)0x0016,
    AF_CLUSTER = cast(ushort)0x0018,
}

enum : ushort
{
    AF_IRDA   = cast(ushort)0x001a,
    AF_NETDES = cast(ushort)0x001c,
}

enum : ushort
{
    AF_TCNPROCESS = cast(ushort)0x001d,
    AF_TCNMESSAGE = cast(ushort)0x001e,
}

enum : ushort
{
    AF_LINK   = cast(ushort)0x0021,
    AF_HYPERV = cast(ushort)0x0022,
}

enum : uint
{
    SOL_IP   = 0x0000fffb,
    SOL_IPV6 = 0x0000fffa,
}

enum int SO_ACCEPTCONN = 0x00000002;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/so-keepalive))], [])*/int SO_KEEPALIVE = 0x00000008;
enum int SO_BROADCAST = 0x00000020;
enum int SO_LINGER = 0x00000080;
enum int SO_SNDBUF = 0x00001001;
enum int SO_SNDLOWAT = 0x00001003;
enum int SO_SNDTIMEO = 0x00001005;
enum int SO_ERROR = 0x00001007;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/so-bsp-state))], [])*/int SO_BSP_STATE = 0x00001009;
enum int SO_GROUP_PRIORITY = 0x00002002;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/so-conditional-accept))], [])*/int SO_CONDITIONAL_ACCEPT = 0x00003002;
enum uint SO_COMPARTMENT_ID = 0x00003004;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/so-port-scalability))], [])*/int SO_PORT_SCALABILITY = 0x00003006;
enum int SO_REUSE_MULTICASTPORT = 0x00003008;
enum uint IP6T_SO_ORIGINAL_DST = 0x0000300f;
enum uint SO_RECEIVED_PROCESSOR = 0x00003011;
enum int TCP_NODELAY = 0x00000001;

enum : uint
{
    IOC_UNIX     = 0x00000000,
    IOC_WS2      = 0x08000000,
    IOC_PROTOCOL = 0x10000000,
}

enum uint SIO_ASSOCIATE_HANDLE = 0x88000001;
enum uint SIO_FIND_ROUTE = 0x48000003;
enum uint SIO_GET_BROADCAST_ADDRESS = 0x48000005;

enum : uint
{
    SIO_GET_QOS       = 0xc8000007,
    SIO_GET_GROUP_QOS = 0xc8000008,
}

enum uint SIO_MULTICAST_SCOPE = 0x8800000a;
enum uint SIO_SET_GROUP_QOS = 0x8800000c;

enum : uint
{
    SIO_ROUTING_INTERFACE_QUERY  = 0xc8000014,
    SIO_ROUTING_INTERFACE_CHANGE = 0x88000015,
}

enum uint SIO_ADDRESS_LIST_CHANGE = 0x28000017;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/sio-query-rss-processor-info))], [])*/uint SIO_QUERY_RSS_PROCESSOR_INFO = 0x48000025;

enum : uint
{
    SIO_RESERVED_1 = 0x8800001a,
    SIO_RESERVED_2 = 0x88000021,
}

enum : uint
{
    IPPORT_TCPMUX      = 0x00000001,
    IPPORT_ECHO        = 0x00000007,
    IPPORT_DISCARD     = 0x00000009,
    IPPORT_SYSTAT      = 0x0000000b,
    IPPORT_DAYTIME     = 0x0000000d,
    IPPORT_NETSTAT     = 0x0000000f,
    IPPORT_QOTD        = 0x00000011,
    IPPORT_MSP         = 0x00000012,
    IPPORT_CHARGEN     = 0x00000013,
    IPPORT_FTP_DATA    = 0x00000014,
    IPPORT_FTP         = 0x00000015,
    IPPORT_TELNET      = 0x00000017,
    IPPORT_SMTP        = 0x00000019,
    IPPORT_TIMESERVER  = 0x00000025,
    IPPORT_NAMESERVER  = 0x0000002a,
    IPPORT_WHOIS       = 0x0000002b,
    IPPORT_MTP         = 0x00000039,
    IPPORT_TFTP        = 0x00000045,
    IPPORT_RJE         = 0x0000004d,
    IPPORT_FINGER      = 0x0000004f,
    IPPORT_TTYLINK     = 0x00000057,
    IPPORT_SUPDUP      = 0x0000005f,
    IPPORT_POP3        = 0x0000006e,
    IPPORT_NTP         = 0x0000007b,
    IPPORT_EPMAP       = 0x00000087,
    IPPORT_NETBIOS_NS  = 0x00000089,
    IPPORT_NETBIOS_DGM = 0x0000008a,
    IPPORT_NETBIOS_SSN = 0x0000008b,
}

enum : uint
{
    IPPORT_SNMP         = 0x000000a1,
    IPPORT_SNMP_TRAP    = 0x000000a2,
    IPPORT_IMAP3        = 0x000000dc,
    IPPORT_LDAP         = 0x00000185,
    IPPORT_HTTPS        = 0x000001bb,
    IPPORT_MICROSOFT_DS = 0x000001bd,
}

enum uint IPPORT_LOGINSERVER = 0x00000201;

enum : uint
{
    IPPORT_EFSSERVER      = 0x00000208,
    IPPORT_BIFFUDP        = 0x00000200,
    IPPORT_WHOSERVER      = 0x00000201,
    IPPORT_ROUTESERVER    = 0x00000208,
    IPPORT_RESERVED       = 0x00000400,
    IPPORT_REGISTERED_MIN = 0x00000400,
    IPPORT_REGISTERED_MAX = 0x0000bfff,
}

enum uint IPPORT_DYNAMIC_MAX = 0x0000ffff;

enum : uint
{
    IN_CLASSA_NSHIFT = 0x00000018,
    IN_CLASSA_HOST   = 0x00ffffff,
    IN_CLASSA_MAX    = 0x00000080,
    IN_CLASSB_NET    = 0xffff0000,
    IN_CLASSB_NSHIFT = 0x00000010,
    IN_CLASSB_HOST   = 0x0000ffff,
    IN_CLASSB_MAX    = 0x00010000,
    IN_CLASSC_NET    = 0xffffff00,
    IN_CLASSC_NSHIFT = 0x00000008,
    IN_CLASSC_HOST   = 0x000000ff,
    IN_CLASSD_NET    = 0xf0000000,
    IN_CLASSD_NSHIFT = 0x0000001c,
    IN_CLASSD_HOST   = 0x0fffffff,
}

enum uint INADDR_NONE = 0xffffffff;

enum : uint
{
    IOC_VOID = 0x20000000,
    IOC_OUT  = 0x40000000,
    IOC_IN   = 0x80000000,
}

enum uint MSG_CTRUNC = 0x00000200;

enum : uint
{
    MSG_MCAST    = 0x00000800,
    MSG_ERRQUEUE = 0x00001000,
}

enum uint AI_CANONNAME = 0x00000002;
enum uint AI_NUMERICSERV = 0x00000008;
enum uint AI_FORCE_CLEAR_TEXT = 0x00000020;
enum uint AI_RETURN_TTL = 0x00000080;
enum uint AI_ADDRCONFIG = 0x00000400;
enum uint AI_NON_AUTHORITATIVE = 0x00004000;
enum uint AI_RETURN_PREFERRED_NAMES = 0x00010000;
enum uint AI_FILESERVER = 0x00040000;
enum uint AI_SECURE_WITH_FALLBACK = 0x00100000;
enum uint AI_RETURN_RESPONSE_FLAGS = 0x10000000;
enum uint AI_RESOLUTION_HANDLE = 0x40000000;

enum : uint
{
    ADDRINFOEX_VERSION_2 = 0x00000002,
    ADDRINFOEX_VERSION_3 = 0x00000003,
    ADDRINFOEX_VERSION_4 = 0x00000004,
    ADDRINFOEX_VERSION_5 = 0x00000005,
    ADDRINFOEX_VERSION_6 = 0x00000006,
    ADDRINFOEX_VERSION_7 = 0x00000007,
}

enum : uint
{
    AI_DNS_SERVER_TYPE_DOH     = 0x00000002,
    AI_DNS_SERVER_TYPE_DOT     = 0x00000003,
    AI_DNS_SERVER_UDP_FALLBACK = 0x00000001,
}

enum uint AI_DNS_RESPONSE_HOSTFILE = 0x00000002;

enum : uint
{
    NS_ALL         = 0x00000000,
    NS_SAP         = 0x00000001,
    NS_NDS         = 0x00000002,
    NS_PEER_BROWSE = 0x00000003,
}

enum : uint
{
    NS_DHCP        = 0x00000006,
    NS_TCPIP_LOCAL = 0x0000000a,
    NS_TCPIP_HOSTS = 0x0000000b,
}

enum uint NS_NETBT = 0x0000000d;

enum : uint
{
    NS_NLA   = 0x0000000f,
    NS_NBP   = 0x00000014,
    NS_MS    = 0x0000001e,
    NS_STDA  = 0x0000001f,
    NS_NTDS  = 0x00000020,
    NS_EMAIL = 0x00000025,
}

enum : uint
{
    NS_NIS     = 0x00000029,
    NS_NISPLUS = 0x0000002a,
}

enum uint NS_NETDES = 0x0000003c;
enum uint NI_NUMERICHOST = 0x00000002;
enum uint NI_NUMERICSERV = 0x00000008;

enum : uint
{
    NI_MAXHOST = 0x00000401,
    NI_MAXSERV = 0x00000020,
}

enum uint IFF_BROADCAST = 0x00000002;
enum uint IFF_POINTTOPOINT = 0x00000008;
enum int IP_OPTIONS = 0x00000001;

enum : int
{
    IP_TOS            = 0x00000003,
    IP_TTL            = 0x00000004,
    IP_MULTICAST_IF   = 0x00000009,
    IP_MULTICAST_TTL  = 0x0000000a,
    IP_MULTICAST_LOOP = 0x0000000b,
}

enum int IP_DROP_MEMBERSHIP = 0x0000000d;
enum int IP_ADD_SOURCE_MEMBERSHIP = 0x0000000f;
enum int IP_BLOCK_SOURCE = 0x00000011;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/ip-pktinfo))], [])*/int IP_PKTINFO = 0x00000013;

enum : int
{
    IP_RECVTTL           = 0x00000015,
    IP_RECEIVE_BROADCAST = 0x00000016,
}

enum int IP_RECVDSTADDR = 0x00000019;
enum int IP_ADD_IFLIST = 0x0000001d;
enum int IP_UNICAST_IF = 0x0000001f;
enum int IP_GET_IFLIST = 0x00000021;
enum int IP_TCLASS = 0x00000027;
enum int IP_RECVTOS = 0x00000028;

enum : int
{
    IP_ECN     = 0x00000032,
    IP_RECVECN = 0x00000032,
}

enum : int
{
    IP_WFP_REDIRECT_RECORDS = 0x0000003c,
    IP_WFP_REDIRECT_CONTEXT = 0x00000046,
}

enum : int
{
    IP_MTU           = 0x00000049,
    IP_NRT_INTERFACE = 0x0000004a,
}

enum int IP_USER_MTU = 0x0000004c;
enum uint IP_UNSPECIFIED_USER_MTU = 0xffffffff;
enum uint IN6ADDR_MULTICASTPREFIX_LENGTH = 0x00000008;
enum uint IN6ADDR_V4MAPPEDPREFIX_LENGTH = 0x00000060;
enum uint IN6ADDR_TEREDOPREFIX_LENGTH = 0x00000020;
enum uint MCAST_LEAVE_GROUP = 0x0000002a;
enum uint MCAST_UNBLOCK_SOURCE = 0x0000002c;
enum uint MCAST_LEAVE_SOURCE_GROUP = 0x0000002e;

enum : int
{
    IPV6_HDRINCL      = 0x00000002,
    IPV6_UNICAST_HOPS = 0x00000004,
}

enum : int
{
    IPV6_MULTICAST_HOPS = 0x0000000a,
    IPV6_MULTICAST_LOOP = 0x0000000b,
}

enum int IPV6_JOIN_GROUP = 0x0000000c;
enum int IPV6_LEAVE_GROUP = 0x0000000d;

enum : /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/ipv6-pktinfo))], [])*/int
{
    IPV6_PKTINFO  = 0x00000013,
    IPV6_HOPLIMIT = 0x00000015,
}

enum : int
{
    IPV6_RECVIF      = 0x00000018,
    IPV6_RECVDSTADDR = 0x00000019,
}

enum : int
{
    IPV6_V6ONLY     = 0x0000001b,
    IPV6_IFLIST     = 0x0000001c,
    IPV6_ADD_IFLIST = 0x0000001d,
}

enum int IPV6_UNICAST_IF = 0x0000001f;
enum int IPV6_GET_IFLIST = 0x00000021;

enum : int
{
    IPV6_TCLASS     = 0x00000027,
    IPV6_RECVTCLASS = 0x00000028,
}

enum : int
{
    IPV6_RECVECN    = 0x00000032,
    IPV6_PKTINFO_EX = 0x00000033,
}

enum int IPV6_WFP_REDIRECT_CONTEXT = 0x00000046;

enum : int
{
    IPV6_MTU           = 0x00000048,
    IPV6_NRT_INTERFACE = 0x0000004a,
}

enum int IPV6_USER_MTU = 0x0000004c;
enum int IP_PROTECTION_LEVEL = 0x00000017;

enum : uint
{
    PROTECTION_LEVEL_EDGERESTRICTED = 0x00000014,
    PROTECTION_LEVEL_RESTRICTED     = 0x0000001e,
    PROTECTION_LEVEL_DEFAULT        = 0x00000014,
}

enum uint INET6_ADDRSTRLEN = 0x00000041;

enum : int
{
    TCP_OFFLOAD_NOT_PREFERRED = 0x00000001,
    TCP_OFFLOAD_PREFERRED     = 0x00000002,
}

enum int TCP_KEEPALIVE = 0x00000003;

enum : int
{
    TCP_MAXRT  = 0x00000005,
    TCP_STDURG = 0x00000006,
}

enum int TCP_ATMARK = 0x00000008;
enum int TCP_TIMESTAMPS = 0x0000000a;
enum int TCP_CONGESTION_ALGORITHM = 0x0000000c;
enum int TCP_MAXRTMS = 0x0000000e;

enum : int
{
    TCP_KEEPCNT   = 0x00000010,
    TCP_KEEPIDLE  = 0x00000003,
    TCP_KEEPINTVL = 0x00000011,
}

enum int TCP_ICMP_ERROR_INFO = 0x00000013;
enum int UDP_RECV_MAX_COALESCED_SIZE = 0x00000003;

enum : uint
{
    WINDOWS_AF_IRDA = 0x0000001a,
    WINDOWS_PF_IRDA = 0x0000001a,
}

enum uint WCE_PF_IRDA = 0x00000016;
enum ushort PF_IRDA = cast(ushort)0x001a;
enum int IRLMP_ENUMDEVICES = 0x00000010;
enum int IRLMP_IAS_QUERY = 0x00000012;
enum int IRLMP_EXCLUSIVE_MODE = 0x00000014;
enum int IRLMP_9WIRE_MODE = 0x00000016;
enum int IRLMP_PARAMETERS = 0x00000018;
enum int IRLMP_SHARP_MODE = 0x00000020;

enum : uint
{
    IAS_ATTRIB_NO_ATTRIB = 0x00000000,
    IAS_ATTRIB_INT       = 0x00000001,
    IAS_ATTRIB_OCTETSEQ  = 0x00000002,
    IAS_ATTRIB_STR       = 0x00000003,
}

enum uint IAS_MAX_OCTET_STRING = 0x00000400;
enum uint IAS_MAX_ATTRIBNAME = 0x00000100;

enum : uint
{
    LmCharSetISO_8859_1 = 0x00000001,
    LmCharSetISO_8859_2 = 0x00000002,
    LmCharSetISO_8859_3 = 0x00000003,
    LmCharSetISO_8859_4 = 0x00000004,
    LmCharSetISO_8859_5 = 0x00000005,
    LmCharSetISO_8859_6 = 0x00000006,
    LmCharSetISO_8859_7 = 0x00000007,
    LmCharSetISO_8859_8 = 0x00000008,
    LmCharSetISO_8859_9 = 0x00000009,
    LmCharSetUNICODE    = 0x000000ff,
}

enum : uint
{
    LM_BAUD_2400   = 0x00000960,
    LM_BAUD_9600   = 0x00002580,
    LM_BAUD_19200  = 0x00004b00,
    LM_BAUD_38400  = 0x00009600,
    LM_BAUD_57600  = 0x0000e100,
    LM_BAUD_115200 = 0x0001c200,
    LM_BAUD_576K   = 0x0008ca00,
    LM_BAUD_1152K  = 0x00119400,
    LM_BAUD_4M     = 0x003d0900,
    LM_BAUD_16M    = 0x00f42400,
}

enum int SO_CONNOPT = 0x00007001;
enum int SO_DISCOPT = 0x00007003;
enum int SO_CONNOPTLEN = 0x00007005;
enum int SO_DISCOPTLEN = 0x00007007;

enum : uint
{
    SO_SYNCHRONOUS_ALERT    = 0x00000010,
    SO_SYNCHRONOUS_NONALERT = 0x00000020,
}

enum int SO_MAXPATHDG = 0x0000700a;
enum int SO_CONNECT_TIME = 0x0000700c;
enum int TCP_BSDURGENT = 0x00007000;
enum uint SIO_SOCKET_CLOSE_NOTIFY = 0x9800000d;
enum uint TF_DISCONNECT = 0x00000001;
enum uint TF_WRITE_BEHIND = 0x00000004;
enum uint TF_USE_SYSTEM_THREAD = 0x00000010;

enum : uint
{
    TP_ELEMENT_MEMORY = 0x00000001,
    TP_ELEMENT_FILE   = 0x00000002,
    TP_ELEMENT_EOP    = 0x00000004,
}

enum uint TP_REUSE_SOCKET = 0x00000002;
enum uint TP_USE_SYSTEM_THREAD = 0x00000010;
enum uint DE_REUSE_SOCKET = 0x00000002;
enum uint NLA_FRIENDLY_NAME = 0x00000002;

enum : uint
{
    SIO_BSP_HANDLE_SELECT = 0x4800001c,
    SIO_BSP_HANDLE_POLL   = 0x4800001d,
}

enum : uint
{
    SIO_EXT_SELECT  = 0xc800001e,
    SIO_EXT_POLL    = 0xc800001f,
    SIO_EXT_SENDMSG = 0xc8000020,
}

enum : uint
{
    SERVICE_SERVICE    = 0x00000002,
    SERVICE_LOCAL      = 0x00000004,
    SERVICE_FLAG_DEFER = 0x00000001,
    SERVICE_FLAG_HARD  = 0x00000002,
}

enum : uint
{
    PROP_LOCALE       = 0x00000002,
    PROP_DISPLAY_HINT = 0x00000004,
}

enum uint PROP_START_TIME = 0x00000010;
enum uint PROP_ADDRESSES = 0x00000100;
enum uint PROP_ALL = 0x80000000;

enum : uint
{
    SERVICE_ADDRESS_FLAG_RPC_DG = 0x00000002,
    SERVICE_ADDRESS_FLAG_RPC_NB = 0x00000004,
}

enum uint NS_VNS = 0x00000032;

enum : uint
{
    NSTYPE_DYNAMIC    = 0x00000002,
    NSTYPE_ENUMERABLE = 0x00000004,
    NSTYPE_WORKGROUP  = 0x00000008,
}

enum : uint
{
    XP_GUARANTEED_DELIVERY = 0x00000002,
    XP_GUARANTEED_ORDER    = 0x00000004,
}

enum uint XP_PSEUDO_STREAM = 0x00000010;
enum uint XP_EXPEDITED_DATA = 0x00000040;
enum uint XP_DISCONNECT_DATA = 0x00000100;
enum uint XP_SUPPORTS_MULTICAST = 0x00000400;
enum uint XP_FRAGMENTATION = 0x00001000;
enum uint RES_SOFT_SEARCH = 0x00000001;
enum uint RES_SERVICE = 0x00000004;

enum : const(wchar)*
{
    SERVICE_TYPE_VALUE_SAPIDW   = "SapId",
    SERVICE_TYPE_VALUE_CONNA    = "ConnectionOriented",
    SERVICE_TYPE_VALUE_CONNW    = "ConnectionOriented",
    SERVICE_TYPE_VALUE_TCPPORTA = "TcpPort",
    SERVICE_TYPE_VALUE_TCPPORTW = "TcpPort",
    SERVICE_TYPE_VALUE_UDPPORTA = "UdpPort",
    SERVICE_TYPE_VALUE_UDPPORTW = "UdpPort",
    SERVICE_TYPE_VALUE_SAPID    = "SapId",
    SERVICE_TYPE_VALUE_CONN     = "ConnectionOriented",
    SERVICE_TYPE_VALUE_TCPPORT  = "TcpPort",
    SERVICE_TYPE_VALUE_UDPPORT  = "UdpPort",
}

enum uint FD_SETSIZE = 0x00000040;

enum : uint
{
    IMPLINK_LOWEXPER  = 0x0000009c,
    IMPLINK_HIGHEXPER = 0x0000009e,
}

enum uint WSASYS_STATUS_LEN = 0x00000080;
enum uint IP_DEFAULT_MULTICAST_LOOP = 0x00000001;
enum int SOCKET_ERROR = 0xffffffff;
enum ushort PF_IMPLINK = cast(ushort)0x0003;
enum ushort PF_CHAOS = cast(ushort)0x0005;

enum : ushort
{
    PF_IPX     = cast(ushort)0x0006,
    PF_ISO     = cast(ushort)0x0007,
    PF_OSI     = cast(ushort)0x0007,
    PF_ECMA    = cast(ushort)0x0008,
    PF_DATAKIT = cast(ushort)0x0009,
}

enum : ushort
{
    PF_SNA    = cast(ushort)0x000b,
    PF_DECnet = cast(ushort)0x000c,
    PF_DLI    = cast(ushort)0x000d,
    PF_LAT    = cast(ushort)0x000e,
    PF_HYLINK = cast(ushort)0x000f,
}

enum ushort PF_VOICEVIEW = cast(ushort)0x0012;
enum ushort PF_UNKNOWN1 = cast(ushort)0x0014;
enum ushort PF_MAX = cast(ushort)0x001d;
enum uint MSG_MAXIOVLEN = 0x00000010;
enum uint MAXGETHOSTSTRUCT = 0x00000400;
enum uint FD_WRITE = 0x00000002;
enum uint FD_ACCEPT = 0x00000008;
enum uint FD_CLOSE = 0x00000020;
enum uint INCL_WINSOCK_API_TYPEDEFS = 0x00000000;
enum int FROM_PROTOCOL_INFO = 0xffffffff;

enum : int
{
    SO_PROTOCOL_INFOW = 0x00002005,
    SO_PROTOCOL_INFO  = 0x00002005,
}

enum ushort PF_ATM = cast(ushort)0x0016;
enum uint FD_READ_BIT = 0x00000000;
enum uint FD_OOB_BIT = 0x00000002;
enum uint FD_CONNECT_BIT = 0x00000004;
enum uint FD_QOS_BIT = 0x00000006;
enum uint FD_ROUTING_INTERFACE_CHANGE_BIT = 0x00000008;
enum uint FD_MAX_EVENTS = 0x0000000a;

enum : uint
{
    WSA_WAIT_FAILED  = 0xffffffff,
    WSA_WAIT_TIMEOUT = 0x00000102,
}

enum uint CF_REJECT = 0x00000001;
enum uint SG_UNCONSTRAINED_GROUP = 0x00000001;
enum uint MAX_PROTOCOL_CHAIN = 0x00000007;
enum uint LAYERED_PROTOCOL = 0x00000000;
enum uint PFL_MULTIPLE_PROTO_ENTRIES = 0x00000001;
enum uint PFL_HIDDEN = 0x00000004;
enum uint PFL_NETWORKDIRECT_PROVIDER = 0x00000010;

enum : uint
{
    XP1_GUARANTEED_DELIVERY = 0x00000002,
    XP1_GUARANTEED_ORDER    = 0x00000004,
}

enum uint XP1_PSEUDO_STREAM = 0x00000010;
enum uint XP1_EXPEDITED_DATA = 0x00000040;
enum uint XP1_DISCONNECT_DATA = 0x00000100;
enum uint XP1_SUPPORT_MULTIPOINT = 0x00000400;
enum uint XP1_MULTIPOINT_DATA_PLANE = 0x00001000;
enum uint XP1_INTERRUPT = 0x00004000;
enum uint XP1_UNI_RECV = 0x00010000;
enum uint XP1_PARTIAL_MESSAGE = 0x00040000;
enum uint BIGENDIAN = 0x00000000;
enum uint SECURITY_PROTOCOL_NONE = 0x00000000;
enum uint JL_RECEIVER_ONLY = 0x00000002;

enum : uint
{
    WSA_FLAG_OVERLAPPED        = 0x00000001,
    WSA_FLAG_MULTIPOINT_C_ROOT = 0x00000002,
    WSA_FLAG_MULTIPOINT_C_LEAF = 0x00000004,
    WSA_FLAG_MULTIPOINT_D_ROOT = 0x00000008,
    WSA_FLAG_MULTIPOINT_D_LEAF = 0x00000010,
}

enum uint WSA_FLAG_NO_HANDLE_INHERIT = 0x00000080;
enum uint SIO_NSP_NOTIFY_CHANGE = 0x88000019;
enum uint TH_TAPI = 0x00000002;
enum uint NS_LOCALNAME = 0x00000013;
enum uint RES_FLUSH_CACHE = 0x00000002;

enum : const(wchar)*
{
    SERVICE_TYPE_VALUE_IPXPORTW  = "IpxSocket",
    SERVICE_TYPE_VALUE_OBJECTIDA = "ObjectId",
    SERVICE_TYPE_VALUE_OBJECTIDW = "ObjectId",
    SERVICE_TYPE_VALUE_OBJECTID  = "ObjectId",
}

enum uint LUP_CONTAINERS = 0x00000002;
enum uint LUP_NEAREST = 0x00000008;

enum : uint
{
    LUP_RETURN_TYPE         = 0x00000020,
    LUP_RETURN_VERSION      = 0x00000040,
    LUP_RETURN_COMMENT      = 0x00000080,
    LUP_RETURN_ADDR         = 0x00000100,
    LUP_RETURN_BLOB         = 0x00000200,
    LUP_RETURN_ALIASES      = 0x00000400,
    LUP_RETURN_QUERY_STRING = 0x00000800,
    LUP_RETURN_ALL          = 0x00000ff0,
    LUP_RES_SERVICE         = 0x00008000,
}

enum uint LUP_FLUSHPREVIOUS = 0x00002000;
enum uint LUP_SECURE = 0x00008000;
enum uint LUP_DNS_ONLY = 0x00020000;
enum uint LUP_RESERVED_UNUSED = 0x00080000;
enum uint LUP_DUAL_ADDR = 0x00200000;
enum uint LUP_DISABLE_IDN_ENCODING = 0x00800000;
enum uint LUP_EXTENDED_QUERYSET = 0x02000000;
enum uint LUP_EXCLUSIVE_CUSTOM_SERVERS = 0x08000000;
enum uint LUP_RETURN_TTL = 0x20000000;
enum uint LUP_RESOLUTION_HANDLE = 0x80000000;

enum : uint
{
    RESULT_IS_ADDED   = 0x00000010,
    RESULT_IS_CHANGED = 0x00000020,
    RESULT_IS_DELETED = 0x00000040,
}

enum : uint
{
    SOCK_NOTIFY_REGISTER_EVENT_IN     = 0x00000001,
    SOCK_NOTIFY_REGISTER_EVENT_OUT    = 0x00000002,
    SOCK_NOTIFY_REGISTER_EVENT_HANGUP = 0x00000004,
}

enum : uint
{
    SOCK_NOTIFY_EVENT_OUT          = 0x00000002,
    SOCK_NOTIFY_EVENT_HANGUP       = 0x00000004,
    SOCK_NOTIFY_EVENT_ERR          = 0x00000040,
    SOCK_NOTIFY_EVENT_REMOVE       = 0x00000080,
    SOCK_NOTIFY_OP_NONE            = 0x00000000,
    SOCK_NOTIFY_OP_ENABLE          = 0x00000001,
    SOCK_NOTIFY_OP_DISABLE         = 0x00000002,
    SOCK_NOTIFY_OP_REMOVE          = 0x00000004,
    SOCK_NOTIFY_TRIGGER_ONESHOT    = 0x00000001,
    SOCK_NOTIFY_TRIGGER_PERSISTENT = 0x00000002,
    SOCK_NOTIFY_TRIGGER_LEVEL      = 0x00000004,
    SOCK_NOTIFY_TRIGGER_EDGE       = 0x00000008,
}

enum : uint
{
    ATMPROTO_AAL1  = 0x00000001,
    ATMPROTO_AAL2  = 0x00000002,
    ATMPROTO_AAL34 = 0x00000003,
    ATMPROTO_AAL5  = 0x00000005,
}

enum : uint
{
    SAP_FIELD_ANY           = 0xffffffff,
    SAP_FIELD_ANY_AESA_SEL  = 0xfffffffa,
    SAP_FIELD_ANY_AESA_REST = 0xfffffffb,
}

enum : uint
{
    ATM_NSAP      = 0x00000002,
    ATM_AESA      = 0x00000002,
    ATM_ADDR_SIZE = 0x00000014,
}

enum : uint
{
    BLLI_L2_Q921           = 0x00000002,
    BLLI_L2_X25L           = 0x00000006,
    BLLI_L2_X25M           = 0x00000007,
    BLLI_L2_ELAPB          = 0x00000008,
    BLLI_L2_HDLC_ARM       = 0x00000009,
    BLLI_L2_HDLC_NRM       = 0x0000000a,
    BLLI_L2_HDLC_ABM       = 0x0000000b,
    BLLI_L2_LLC            = 0x0000000c,
    BLLI_L2_X75            = 0x0000000d,
    BLLI_L2_Q922           = 0x0000000e,
    BLLI_L2_USER_SPECIFIED = 0x00000010,
}

enum : uint
{
    BLLI_L3_X25            = 0x00000006,
    BLLI_L3_ISO_8208       = 0x00000007,
    BLLI_L3_X223           = 0x00000008,
    BLLI_L3_SIO_8473       = 0x00000009,
    BLLI_L3_T70            = 0x0000000a,
    BLLI_L3_ISO_TR9577     = 0x0000000b,
    BLLI_L3_USER_SPECIFIED = 0x00000010,
}

enum uint BLLI_L3_IPI_IP = 0x000000cc;
enum uint BHLI_UserSpecific = 0x00000001;
enum uint BHLI_VendorSpecificAppId = 0x00000003;
enum uint AAL5_MODE_STREAMING = 0x00000002;

enum : uint
{
    AAL5_SSCS_SSCOP_ASSURED     = 0x00000001,
    AAL5_SSCS_SSCOP_NON_ASSURED = 0x00000002,
}

enum : uint
{
    BCOB_A = 0x00000001,
    BCOB_C = 0x00000003,
    BCOB_X = 0x00000010,
}

enum : uint
{
    TT_CBR = 0x00000004,
    TT_VBR = 0x00000008,
}

enum uint TR_END_TO_END = 0x00000001;

enum : uint
{
    CLIP_NOT = 0x00000000,
    CLIP_SUS = 0x00000020,
}

enum uint UP_P2MP = 0x00000001;
enum uint BLLI_L2_MODE_EXT = 0x00000080;

enum : uint
{
    BLLI_L3_MODE_EXT    = 0x00000080,
    BLLI_L3_PACKET_16   = 0x00000004,
    BLLI_L3_PACKET_32   = 0x00000005,
    BLLI_L3_PACKET_64   = 0x00000006,
    BLLI_L3_PACKET_128  = 0x00000007,
    BLLI_L3_PACKET_256  = 0x00000008,
    BLLI_L3_PACKET_512  = 0x00000009,
    BLLI_L3_PACKET_1024 = 0x0000000a,
    BLLI_L3_PACKET_2048 = 0x0000000b,
    BLLI_L3_PACKET_4096 = 0x0000000c,
}

enum uint PI_RESTRICTED = 0x00000040;
enum uint SI_USER_NOT_SCREENED = 0x00000000;
enum uint SI_USER_FAILED = 0x00000002;

enum : uint
{
    CAUSE_LOC_USER            = 0x00000000,
    CAUSE_LOC_PRIVATE_LOCAL   = 0x00000001,
    CAUSE_LOC_PUBLIC_LOCAL    = 0x00000002,
    CAUSE_LOC_TRANSIT_NETWORK = 0x00000003,
}

enum : uint
{
    CAUSE_LOC_PRIVATE_REMOTE        = 0x00000005,
    CAUSE_LOC_INTERNATIONAL_NETWORK = 0x00000007,
}

enum uint CAUSE_UNALLOCATED_NUMBER = 0x00000001;
enum uint CAUSE_NO_ROUTE_TO_DESTINATION = 0x00000003;
enum uint CAUSE_NORMAL_CALL_CLEARING = 0x00000010;
enum uint CAUSE_NO_USER_RESPONDING = 0x00000012;
enum uint CAUSE_NUMBER_CHANGED = 0x00000016;
enum uint CAUSE_DESTINATION_OUT_OF_ORDER = 0x0000001b;
enum uint CAUSE_STATUS_ENQUIRY_RESPONSE = 0x0000001e;
enum uint CAUSE_VPI_VCI_UNAVAILABLE = 0x00000023;
enum uint CAUSE_TEMPORARY_FAILURE = 0x00000029;
enum uint CAUSE_NO_VPI_VCI_AVAILABLE = 0x0000002d;
enum uint CAUSE_QOS_UNAVAILABLE = 0x00000031;

enum : uint
{
    CAUSE_BEARER_CAPABILITY_UNAUTHORIZED = 0x00000039,
    CAUSE_BEARER_CAPABILITY_UNAVAILABLE  = 0x0000003a,
}

enum uint CAUSE_BEARER_CAPABILITY_UNIMPLEMENTED = 0x00000041;
enum uint CAUSE_INVALID_CALL_REFERENCE = 0x00000051;
enum uint CAUSE_INCOMPATIBLE_DESTINATION = 0x00000058;
enum uint CAUSE_INVALID_TRANSIT_NETWORK_SELECTION = 0x0000005b;
enum uint CAUSE_AAL_PARAMETERS_UNSUPPORTED = 0x0000005d;

enum : uint
{
    CAUSE_UNIMPLEMENTED_MESSAGE_TYPE = 0x00000061,
    CAUSE_UNIMPLEMENTED_IE           = 0x00000063,
}

enum uint CAUSE_INVALID_STATE_FOR_MESSAGE = 0x00000065;
enum uint CAUSE_INCORRECT_MESSAGE_LENGTH = 0x00000068;

enum : uint
{
    CAUSE_COND_UNKNOWN   = 0x00000000,
    CAUSE_COND_PERMANENT = 0x00000001,
    CAUSE_COND_TRANSIENT = 0x00000002,
}

enum : uint
{
    CAUSE_REASON_IE_MISSING      = 0x00000004,
    CAUSE_REASON_IE_INSUFFICIENT = 0x00000008,
}

enum : uint
{
    CAUSE_PU_USER     = 0x00000008,
    CAUSE_NA_NORMAL   = 0x00000000,
    CAUSE_NA_ABNORMAL = 0x00000004,
}

enum : uint
{
    QOS_CLASS1 = 0x00000001,
    QOS_CLASS2 = 0x00000002,
    QOS_CLASS3 = 0x00000003,
    QOS_CLASS4 = 0x00000004,
}

enum uint TNS_PLAN_CARRIER_ID_CODE = 0x00000001;
enum uint SIO_GET_ATM_ADDRESS = 0xd0160002;
enum uint SIO_GET_ATM_CONNECTION_ID = 0x50160004;
enum int WSS_OPERATION_IN_PROGRESS = 0x00000103;
enum uint LSP_INSPECTOR = 0x00000001;

enum : uint
{
    LSP_PROXY    = 0x00000004,
    LSP_FIREWALL = 0x00000008,
}

enum uint LSP_OUTBOUND_MODIFY = 0x00000020;
enum uint LSP_LOCAL_CACHE = 0x00000080;
enum int UDP_CHECKSUM_COVERAGE = 0x00000014;

enum : int
{
    IPX_PTYPE       = 0x00004000,
    IPX_FILTERPTYPE = 0x00004001,
}

enum int IPX_DSTYPE = 0x00004002;
enum int IPX_RECVHDR = 0x00004005;
enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/NetMon2/ipx-address))], [])*/int IPX_ADDRESS = 0x00004007;
enum int IPX_GETNETINFO_NORIP = 0x00004009;
enum int IPX_ADDRESS_NOTIFY = 0x0000400c;
enum int IPX_RERIPNETNUMBER = 0x0000400e;
enum int IPX_IMMEDIATESPXACK = 0x00004010;
enum int RM_OPTIONSBASE = 0x000003e8;
enum int RM_SET_MESSAGE_BOUNDARY = 0x000003ea;
enum int RM_SENDER_WINDOW_ADVANCE_METHOD = 0x000003ec;
enum int RM_LATEJOIN = 0x000003ee;
enum int RM_ADD_RECEIVE_IF = 0x000003f0;
enum int RM_SEND_WINDOW_ADV_RATE = 0x000003f2;
enum int RM_SET_MCAST_TTL = 0x000003f4;
enum int RM_HIGH_SPEED_INTRANET_OPT = 0x000003f6;
enum uint SENDER_DEFAULT_WINDOW_ADV_PERCENTAGE = 0x0000000f;
enum uint SENDER_DEFAULT_LATE_JOINER_PERCENTAGE = 0x00000000;
enum uint BITS_PER_BYTE = 0x00000008;
enum uint UNIX_PATH_MAX = 0x0000006c;

enum : uint
{
    SIO_AF_UNIX_SETBINDPARENTPATH = 0x98000101,
    SIO_AF_UNIX_SETCONNPARENTPATH = 0x98000102,
}

enum : uint
{
    ISOPROTO_TP1       = 0x0000001a,
    ISOPROTO_TP2       = 0x0000001b,
    ISOPROTO_TP3       = 0x0000001c,
    ISOPROTO_TP4       = 0x0000001d,
    ISOPROTO_TP        = 0x0000001d,
    ISOPROTO_CLTP      = 0x0000001e,
    ISOPROTO_CLNP      = 0x0000001f,
    ISOPROTO_X25       = 0x00000020,
    ISOPROTO_INACT_NL  = 0x00000021,
    ISOPROTO_ESIS      = 0x00000022,
    ISOPROTO_INTRAISIS = 0x00000023,
}

enum uint ISO_HIERARCHICAL = 0x00000000;

enum : uint
{
    ISO_EXP_DATA_USE  = 0x00000000,
    ISO_EXP_DATA_NUSE = 0x00000001,
}

enum : uint
{
    NSPROTO_SPX   = 0x000004e8,
    NSPROTO_SPXII = 0x000004e9,
}

enum : uint
{
    NETBIOS_UNIQUE_NAME       = 0x00000000,
    NETBIOS_GROUP_NAME        = 0x00000001,
    NETBIOS_TYPE_QUICK_UNIQUE = 0x00000002,
    NETBIOS_TYPE_QUICK_GROUP  = 0x00000003,
}

enum : uint
{
    VNSPROTO_RELIABLE_IPC = 0x00000002,
    VNSPROTO_SPP          = 0x00000003,
}

enum uint _BIG_ENDIAN = 0x000010e1;
enum uint BYTE_ORDER = 0x000004d2;
enum uint DL_HEADER_LENGTH_MAXIMUM = 0x00000040;

enum : uint
{
    SNAP_SSAP    = 0x000000aa,
    SNAP_CONTROL = 0x00000003,
    SNAP_OUI     = 0x00000000,
}

enum : uint
{
    ETH_LENGTH_OF_VLAN_HEADER = 0x00000004,
    ETH_LENGTH_OF_SNAP_HEADER = 0x00000008,
}

enum : uint
{
    ETHERNET_TYPE_IPV4    = 0x00000800,
    ETHERNET_TYPE_ARP     = 0x00000806,
    ETHERNET_TYPE_IPV6    = 0x000086dd,
    ETHERNET_TYPE_802_1Q  = 0x00008100,
    ETHERNET_TYPE_802_1AD = 0x000088a8,
}

enum uint IPV4_VERSION = 0x00000004;
enum uint MAX_IPV4_HLEN = 0x0000003c;
enum uint IPV4_MIN_MINIMUM_MTU = 0x00000160;

enum : uint
{
    SIZEOF_IP_OPT_ROUTING_HEADER   = 0x00000003,
    SIZEOF_IP_OPT_TIMESTAMP_HEADER = 0x00000004,
    SIZEOF_IP_OPT_SECURITY         = 0x0000000b,
    SIZEOF_IP_OPT_STREAMIDENTIFIER = 0x00000004,
    SIZEOF_IP_OPT_ROUTERALERT      = 0x00000004,
}

enum uint ICMPV4_INVALID_PREFERENCE_LEVEL = 0x80000000;

enum : uint
{
    IGMP_VERSION1_REPORT_TYPE = 0x00000012,
    IGMP_VERSION2_REPORT_TYPE = 0x00000016,
}

enum uint IGMP_VERSION3_REPORT_TYPE = 0x00000022;
enum uint IPV6_TRAFFIC_CLASS_MASK = 0x0000c00f;
enum uint IPV6_ECN_MASK = 0x00003000;
enum uint MAX_IPV6_PAYLOAD = 0x0000ffff;
enum uint IPV6_MINIMUM_MTU = 0x00000500;
enum uint IP6F_RESERVED_MASK = 0x00000600;
enum uint EXT_LEN_UNIT = 0x00000008;

enum : uint
{
    IP6OPT_TYPE_DISCARD   = 0x00000040,
    IP6OPT_TYPE_FORCEICMP = 0x00000080,
    IP6OPT_TYPE_ICMP      = 0x000000c0,
    IP6OPT_MUTABLE        = 0x00000020,
}

enum : uint
{
    ICMP6_DST_UNREACH_ADMIN       = 0x00000001,
    ICMP6_DST_UNREACH_BEYONDSCOPE = 0x00000002,
    ICMP6_DST_UNREACH_ADDR        = 0x00000003,
    ICMP6_DST_UNREACH_NOPORT      = 0x00000004,
}

enum uint ICMP6_TIME_EXCEED_REASSEMBLY = 0x00000001;

enum : uint
{
    ICMP6_PARAMPROB_NEXTHEADER    = 0x00000001,
    ICMP6_PARAMPROB_OPTION        = 0x00000002,
    ICMP6_PARAMPROB_FIRSTFRAGMENT = 0x00000003,
}

enum : uint
{
    ND_RA_FLAG_MANAGED    = 0x00000080,
    ND_RA_FLAG_OTHER      = 0x00000040,
    ND_RA_FLAG_HOME_AGENT = 0x00000020,
    ND_RA_FLAG_PREFERENCE = 0x00000018,
}

enum : uint
{
    ND_NA_FLAG_SOLICITED = 0x40000000,
    ND_NA_FLAG_OVERRIDE  = 0x20000000,
}

enum : uint
{
    ND_OPT_PI_FLAG_AUTO        = 0x00000040,
    ND_OPT_PI_FLAG_ROUTER_ADDR = 0x00000020,
    ND_OPT_PI_FLAG_SITE_PREFIX = 0x00000010,
    ND_OPT_PI_FLAG_ROUTE       = 0x00000001,
}

enum uint ND_OPT_RDNSS_MIN_LEN = 0x00000018;

enum : uint
{
    IN6_EMBEDDEDV4_UOCTET_POSITION = 0x00000008,
    IN6_EMBEDDEDV4_BITS_IN_BYTE    = 0x00000008,
}

enum : uint
{
    TH_FIN                = 0x00000001,
    TH_SYN                = 0x00000002,
    TH_RST                = 0x00000004,
    TH_PSH                = 0x00000008,
    TH_ACK                = 0x00000010,
    TH_URG                = 0x00000020,
    TH_ECE                = 0x00000040,
    TH_CWR                = 0x00000080,
    TH_OPT_EOL            = 0x00000000,
    TH_OPT_NOP            = 0x00000001,
    TH_OPT_MSS            = 0x00000002,
    TH_OPT_WS             = 0x00000003,
    TH_OPT_SACK_PERMITTED = 0x00000004,
    TH_OPT_SACK           = 0x00000005,
    TH_OPT_TS             = 0x00000008,
    TH_OPT_FASTOPEN       = 0x00000022,
}

enum SOCKET INVALID_SOCKET = SOCKET(0xffffffff);
enum WSAEVENT WSA_INVALID_EVENT = WSAEVENT(0x00000000);

enum : int
{
    FIONREAD = 0x4004667f,
    FIONBIO  = 0x8004667e,
    FIOASYNC = 0x8004667d,
}

enum int SIOCGHIWAT = 0x40047301;
enum int SIOCGLOWAT = 0x40047303;

enum : uint
{
    INADDR_ANY       = 0x00000000,
    INADDR_BROADCAST = 0xffffffff,
}

enum /*FIELD ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/so-exclusiveaddruse))], [])*/int SO_EXCLUSIVEADDRUSE = 0xfffffffb;

enum : int
{
    LM_HB1_PnP         = 0x00000001,
    LM_HB1_PDA_Palmtop = 0x00000002,
}

enum : int
{
    LM_HB1_Printer   = 0x00000008,
    LM_HB1_Modem     = 0x00000010,
    LM_HB1_Fax       = 0x00000020,
    LM_HB1_LANAccess = 0x00000040,
}

enum int LM_HB2_FileServer = 0x00000002;

// Callbacks

alias LPCONDITIONPROC = int function(WSABUF* lpCallerId, WSABUF* lpCallerData, QOS* lpSQOS, QOS* lpGQOS, 
                                     WSABUF* lpCalleeId, WSABUF* lpCalleeData, uint* g, size_t dwCallbackData);
alias LPWSAOVERLAPPED_COMPLETION_ROUTINE = void function(uint dwError, uint cbTransferred, 
                                                         OVERLAPPED* lpOverlapped, uint dwFlags);
alias LPFN_TRANSMITFILE = BOOL function(SOCKET hSocket, HANDLE hFile, uint nNumberOfBytesToWrite, 
                                        uint nNumberOfBytesPerSend, OVERLAPPED* lpOverlapped, 
                                        TRANSMIT_FILE_BUFFERS* lpTransmitBuffers, uint dwReserved);
alias LPFN_ACCEPTEX = BOOL function(SOCKET sListenSocket, SOCKET sAcceptSocket, void* lpOutputBuffer, 
                                    uint dwReceiveDataLength, uint dwLocalAddressLength, uint dwRemoteAddressLength, 
                                    uint* lpdwBytesReceived, OVERLAPPED* lpOverlapped);
alias LPFN_GETACCEPTEXSOCKADDRS = void function(void* lpOutputBuffer, uint dwReceiveDataLength, 
                                                uint dwLocalAddressLength, uint dwRemoteAddressLength, 
                                                SOCKADDR** LocalSockaddr, int* LocalSockaddrLength, 
                                                SOCKADDR** RemoteSockaddr, int* RemoteSockaddrLength);
alias LPFN_TRANSMITPACKETS = BOOL function(SOCKET hSocket, TRANSMIT_PACKETS_ELEMENT* lpPacketArray, 
                                           uint nElementCount, uint nSendSize, OVERLAPPED* lpOverlapped, 
                                           uint dwFlags);
alias LPFN_CONNECTEX = BOOL function(SOCKET s, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                                     int namelen, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpSendBuffer, 
                                     uint dwSendDataLength, uint* lpdwBytesSent, OVERLAPPED* lpOverlapped);
alias LPFN_DISCONNECTEX = BOOL function(SOCKET s, OVERLAPPED* lpOverlapped, uint dwFlags, uint dwReserved);
alias LPFN_WSARECVMSG = int function(SOCKET s, WSAMSG* lpMsg, uint* lpdwNumberOfBytesRecvd, 
                                     OVERLAPPED* lpOverlapped, 
                                     LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);
alias LPFN_WSASENDMSG = int function(SOCKET s, WSAMSG* lpMsg, uint dwFlags, uint* lpNumberOfBytesSent, 
                                     OVERLAPPED* lpOverlapped, 
                                     LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);
alias LPFN_WSAPOLL = int function(WSAPOLLFD* fdarray, uint nfds, int timeout);
alias LPFN_RIORECEIVE = BOOL function(RIO_RQ SocketQueue, RIO_BUF* pData, uint DataBufferCount, uint Flags, 
                                      void* RequestContext);
alias LPFN_RIORECEIVEEX = int function(RIO_RQ SocketQueue, RIO_BUF* pData, uint DataBufferCount, 
                                       RIO_BUF* pLocalAddress, RIO_BUF* pRemoteAddress, RIO_BUF* pControlContext, 
                                       RIO_BUF* pFlags, uint Flags, void* RequestContext);
alias LPFN_RIOSEND = BOOL function(RIO_RQ SocketQueue, RIO_BUF* pData, uint DataBufferCount, uint Flags, 
                                   void* RequestContext);
alias LPFN_RIOSENDEX = BOOL function(RIO_RQ SocketQueue, RIO_BUF* pData, uint DataBufferCount, 
                                     RIO_BUF* pLocalAddress, RIO_BUF* pRemoteAddress, RIO_BUF* pControlContext, 
                                     RIO_BUF* pFlags, uint Flags, void* RequestContext);
alias LPFN_RIOCLOSECOMPLETIONQUEUE = void function(RIO_CQ CQ);
alias LPFN_RIOCREATECOMPLETIONQUEUE = RIO_CQ function(uint QueueSize, 
                                                      RIO_NOTIFICATION_COMPLETION* NotificationCompletion);
alias LPFN_RIOCREATEREQUESTQUEUE = RIO_RQ function(SOCKET Socket, uint MaxOutstandingReceive, 
                                                   uint MaxReceiveDataBuffers, uint MaxOutstandingSend, 
                                                   uint MaxSendDataBuffers, RIO_CQ ReceiveCQ, RIO_CQ SendCQ, 
                                                   void* SocketContext);
alias LPFN_RIODEQUEUECOMPLETION = uint function(RIO_CQ CQ, RIORESULT* Array, uint ArraySize);
alias LPFN_RIODEREGISTERBUFFER = void function(RIO_BUFFERID BufferId);
alias LPFN_RIONOTIFY = int function(RIO_CQ CQ);
alias LPFN_RIOREGISTERBUFFER = RIO_BUFFERID function(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR DataBuffer, 
                                                     uint DataLength);
alias LPFN_RIORESIZECOMPLETIONQUEUE = BOOL function(RIO_CQ CQ, uint QueueSize);
alias LPFN_RIORESIZEREQUESTQUEUE = BOOL function(RIO_RQ RQ, uint MaxOutstandingReceive, uint MaxOutstandingSend);
alias LPBLOCKINGCALLBACK = BOOL function(size_t dwContext);
alias LPWSAUSERAPC = void function(size_t dwContext);
alias LPWSPACCEPT = SOCKET function(SOCKET s, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* addr, 
                                    int* addrlen, LPCONDITIONPROC lpfnCondition, size_t dwCallbackData, int* lpErrno);
alias LPWSPADDRESSTOSTRING = int function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SOCKADDR* lpsaAddress, 
                                          uint dwAddressLength, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                          PWSTR lpszAddressString, uint* lpdwAddressStringLength, int* lpErrno);
alias LPWSPASYNCSELECT = int function(SOCKET s, HWND hWnd, uint wMsg, int lEvent, int* lpErrno);
alias LPWSPBIND = int function(SOCKET s, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                               int namelen, int* lpErrno);
alias LPWSPCANCELBLOCKINGCALL = int function(int* lpErrno);
alias LPWSPCLEANUP = int function(int* lpErrno);
alias LPWSPCLOSESOCKET = int function(SOCKET s, int* lpErrno);
alias LPWSPCONNECT = int function(SOCKET s, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                                  int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS, 
                                  int* lpErrno);
alias LPWSPDUPLICATESOCKET = int function(SOCKET s, uint dwProcessId, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                          int* lpErrno);
alias LPWSPENUMNETWORKEVENTS = int function(SOCKET s, HANDLE hEventObject, WSANETWORKEVENTS* lpNetworkEvents, 
                                            int* lpErrno);
alias LPWSPEVENTSELECT = int function(SOCKET s, WSAEVENT hEventObject, int lNetworkEvents, int* lpErrno);
alias LPWSPGETOVERLAPPEDRESULT = BOOL function(SOCKET s, OVERLAPPED* lpOverlapped, uint* lpcbTransfer, BOOL fWait, 
                                               uint* lpdwFlags, int* lpErrno);
alias LPWSPGETPEERNAME = int function(SOCKET s, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* name, 
                                      int* namelen, int* lpErrno);
alias LPWSPGETSOCKNAME = int function(SOCKET s, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* name, 
                                      int* namelen, int* lpErrno);
alias LPWSPGETSOCKOPT = int function(SOCKET s, int level, int optname, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR optval, 
                                     int* optlen, int* lpErrno);
alias LPWSPGETQOSBYNAME = BOOL function(SOCKET s, WSABUF* lpQOSName, QOS* lpQOS, int* lpErrno);
alias LPWSPIOCTL = int function(SOCKET s, uint dwIoControlCode, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpvInBuffer, 
                                uint cbInBuffer, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpvOutBuffer, 
                                uint cbOutBuffer, uint* lpcbBytesReturned, OVERLAPPED* lpOverlapped, 
                                LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                                int* lpErrno);
alias LPWSPJOINLEAF = SOCKET function(SOCKET s, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                                      int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, 
                                      QOS* lpGQOS, uint dwFlags, int* lpErrno);
alias LPWSPLISTEN = int function(SOCKET s, int backlog, int* lpErrno);
alias LPWSPRECV = int function(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, 
                               uint* lpFlags, OVERLAPPED* lpOverlapped, 
                               LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                               int* lpErrno);
alias LPWSPRECVDISCONNECT = int function(SOCKET s, WSABUF* lpInboundDisconnectData, int* lpErrno);
alias LPWSPRECVFROM = int function(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, 
                                   uint* lpFlags, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/SOCKADDR* lpFrom, 
                                   int* lpFromlen, OVERLAPPED* lpOverlapped, 
                                   LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                                   int* lpErrno);
alias LPWSPSELECT = int function(int nfds, FD_SET* readfds, FD_SET* writefds, FD_SET* exceptfds, 
                                 const(TIMEVAL)* timeout, int* lpErrno);
alias LPWSPSEND = int function(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, 
                               uint dwFlags, OVERLAPPED* lpOverlapped, 
                               LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                               int* lpErrno);
alias LPWSPSENDDISCONNECT = int function(SOCKET s, WSABUF* lpOutboundDisconnectData, int* lpErrno);
alias LPWSPSENDTO = int function(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, 
                                 uint dwFlags, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/const(SOCKADDR)* lpTo, 
                                 int iTolen, OVERLAPPED* lpOverlapped, 
                                 LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                                 int* lpErrno);
alias LPWSPSETSOCKOPT = int function(SOCKET s, int level, int optname, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PSTR) optval, 
                                     int optlen, int* lpErrno);
alias LPWSPSHUTDOWN = int function(SOCKET s, int how, int* lpErrno);
alias LPWSPSOCKET = SOCKET function(int af, int type, int protocol, WSAPROTOCOL_INFOW* lpProtocolInfo, uint g, 
                                    uint dwFlags, int* lpErrno);
alias LPWSPSTRINGTOADDRESS = int function(PWSTR AddressString, int AddressFamily, 
                                          WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKADDR* lpAddress, 
                                          int* lpAddressLength, int* lpErrno);
alias LPWPUCLOSEEVENT = BOOL function(WSAEVENT hEvent, int* lpErrno);
alias LPWPUCLOSESOCKETHANDLE = int function(SOCKET s, int* lpErrno);
alias LPWPUCREATEEVENT = WSAEVENT function(int* lpErrno);
alias LPWPUCREATESOCKETHANDLE = SOCKET function(uint dwCatalogEntryId, size_t dwContext, int* lpErrno);
alias LPWPUFDISSET = int function(SOCKET s, FD_SET* fdset);
alias LPWPUGETPROVIDERPATH = int function(GUID* lpProviderId, PWSTR lpszProviderDllPath, int* lpProviderDllPathLen, 
                                          int* lpErrno);
alias LPWPUMODIFYIFSHANDLE = SOCKET function(uint dwCatalogEntryId, SOCKET ProposedHandle, int* lpErrno);
alias LPWPUPOSTMESSAGE = BOOL function(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);
alias LPWPUQUERYBLOCKINGCALLBACK = int function(uint dwCatalogEntryId, LPBLOCKINGCALLBACK* lplpfnCallback, 
                                                size_t* lpdwContext, int* lpErrno);
alias LPWPUQUERYSOCKETHANDLECONTEXT = int function(SOCKET s, size_t* lpContext, int* lpErrno);
alias LPWPUQUEUEAPC = int function(WSATHREADID* lpThreadId, LPWSAUSERAPC lpfnUserApc, size_t dwContext, 
                                   int* lpErrno);
alias LPWPURESETEVENT = BOOL function(WSAEVENT hEvent, int* lpErrno);
alias LPWPUSETEVENT = BOOL function(WSAEVENT hEvent, int* lpErrno);
alias LPWPUOPENCURRENTTHREAD = int function(WSATHREADID* lpThreadId, int* lpErrno);
alias LPWPUCLOSETHREAD = int function(WSATHREADID* lpThreadId, int* lpErrno);
alias LPWPUCOMPLETEOVERLAPPEDREQUEST = int function(SOCKET s, OVERLAPPED* lpOverlapped, uint dwError, 
                                                    uint cbTransferred, int* lpErrno);
alias LPWSPSTARTUP = int function(ushort wVersionRequested, WSPDATA* lpWSPData, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                  WSPUPCALLTABLE UpcallTable, WSPPROC_TABLE* lpProcTable);
alias LPWSCENUMPROTOCOLS = int function(int* lpiProtocols, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOW* lpProtocolBuffer, 
                                        uint* lpdwBufferLength, int* lpErrno);
alias LPWSCDEINSTALLPROVIDER = int function(GUID* lpProviderId, int* lpErrno);
alias LPWSCINSTALLPROVIDER = int function(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                                          const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, 
                                          int* lpErrno);
alias LPWSCGETPROVIDERPATH = int function(GUID* lpProviderId, PWSTR lpszProviderDllPath, int* lpProviderDllPathLen, 
                                          int* lpErrno);
alias LPWSCUPDATEPROVIDER = int function(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                                         const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, 
                                         int* lpErrno);
alias LPWSCINSTALLNAMESPACE = int function(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, 
                                           uint dwVersion, GUID* lpProviderId);
alias LPWSCUNINSTALLNAMESPACE = int function(GUID* lpProviderId);
alias LPWSCENABLENSPROVIDER = int function(GUID* lpProviderId, BOOL fEnable);
alias LPNSPCLEANUP = int function(GUID* lpProviderId);
alias LPNSPLOOKUPSERVICEBEGIN = int function(GUID* lpProviderId, WSAQUERYSETW* lpqsRestrictions, 
                                             WSASERVICECLASSINFOW* lpServiceClassInfo, uint dwControlFlags, 
                                             HANDLE* lphLookup);
alias LPNSPLOOKUPSERVICENEXT = int function(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAQUERYSETW* lpqsResults);
alias LPNSPIOCTL = int function(HANDLE hLookup, uint dwControlCode, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpvInBuffer, 
                                uint cbInBuffer, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpvOutBuffer, 
                                uint cbOutBuffer, uint* lpcbBytesReturned, WSACOMPLETION* lpCompletion, 
                                WSATHREADID* lpThreadId);
alias LPNSPLOOKUPSERVICEEND = int function(HANDLE hLookup);
alias LPNSPSETSERVICE = int function(GUID* lpProviderId, WSASERVICECLASSINFOW* lpServiceClassInfo, 
                                     WSAQUERYSETW* lpqsRegInfo, WSAESETSERVICEOP essOperation, uint dwControlFlags);
alias LPNSPINSTALLSERVICECLASS = int function(GUID* lpProviderId, WSASERVICECLASSINFOW* lpServiceClassInfo);
alias LPNSPREMOVESERVICECLASS = int function(GUID* lpProviderId, GUID* lpServiceClassId);
alias LPNSPGETSERVICECLASSINFO = int function(GUID* lpProviderId, uint* lpdwBufSize, 
                                              WSASERVICECLASSINFOW* lpServiceClassInfo);
alias LPNSPSTARTUP = int function(GUID* lpProviderId, NSP_ROUTINE* lpnspRoutines);
alias LPNSPV2STARTUP = int function(GUID* lpProviderId, void** ppvClientSessionArg);
alias LPNSPV2CLEANUP = int function(GUID* lpProviderId, void* pvClientSessionArg);
alias LPNSPV2LOOKUPSERVICEBEGIN = int function(GUID* lpProviderId, WSAQUERYSET2W* lpqsRestrictions, 
                                               uint dwControlFlags, void* lpvClientSessionArg, HANDLE* lphLookup);
alias LPNSPV2LOOKUPSERVICENEXTEX = void function(HANDLE hAsyncCall, HANDLE hLookup, uint dwControlFlags, 
                                                 uint* lpdwBufferLength, WSAQUERYSET2W* lpqsResults);
alias LPNSPV2LOOKUPSERVICEEND = int function(HANDLE hLookup);
alias LPNSPV2SETSERVICEEX = void function(HANDLE hAsyncCall, GUID* lpProviderId, WSAQUERYSET2W* lpqsRegInfo, 
                                          WSAESETSERVICEOP essOperation, uint dwControlFlags, 
                                          void* lpvClientSessionArg);
alias LPNSPV2CLIENTSESSIONRUNDOWN = void function(GUID* lpProviderId, void* pvClientSessionArg);
alias LPFN_NSPAPI = uint function();
alias LPSERVICE_CALLBACK_PROC = void function(LPARAM lParam, HANDLE hAsyncTaskHandle);
alias LPLOOKUPSERVICE_COMPLETION_ROUTINE = void function(uint dwError, uint dwBytes, OVERLAPPED* lpOverlapped);
alias LPWSCWRITEPROVIDERORDER = int function(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);
alias LPWSCWRITENAMESPACEORDER = int function(GUID* lpProviderId, uint dwNumberOfEntries);

// Structs


@RAIIFree!WSACloseEvent
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct WSAEVENT
{
    ptrdiff_t Value;
}

@RAIIFree!closesocket
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
struct SOCKET
{
    size_t Value;
}

struct socklen_t
{
    int Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/rio-bufferid))], [])
struct RIO_BUFFERID
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/riocqueue))], [])
struct RIO_CQ
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/WinSock/riorqueue))], [])
struct RIO_RQ
{
    ptrdiff_t Value;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/qos/ns-qos-flowspec))], [])
struct FLOWSPEC
{
    uint TokenRate;
    uint TokenBucketSize;
    uint PeakBandwidth;
    uint Latency;
    uint DelayVariation;
    uint ServiceType;
    uint MaxSduSize;
    uint MinimumPolicedSize;
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-servent))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct SERVENT
{
    PSTR   s_name;
    byte** s_aliases;
    PSTR   s_proto;
    short  s_port;
}
}

version (X86) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-wsadata))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 6)))], [])
struct WSADATA
{
    ushort    wVersion;
    ushort    wHighVersion;
    ushort    iMaxSockets;
    ushort    iMaxUdpDg;
    PSTR      lpVendorInfo;
    CHAR[257] szDescription;
    CHAR[129] szSystemStatus;
}
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/inaddr/ns-inaddr-in_addr))], [])
struct IN_ADDR
{
union S_un
    {
struct S_un_b
        {
            ubyte s_b1;
            ubyte s_b2;
            ubyte s_b3;
            ubyte s_b4;
        }
struct S_un_w
        {
            ushort s_w1;
            ushort s_w2;
        }
        uint S_addr;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-sockaddr))], [])
struct SOCKADDR
{
    ADDRESS_FAMILY sa_family;
    CHAR[14]       sa_data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-socket_address))], [])
struct SOCKET_ADDRESS
{
    SOCKADDR* lpSockaddr;
    int       iSockaddrLength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-socket_address_list))], [])
struct SOCKET_ADDRESS_LIST
{
    int iAddressCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SOCKET_ADDRESS[1] Address;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-csaddr_info))], [])
struct CSADDR_INFO
{
    SOCKET_ADDRESS LocalAddr;
    SOCKET_ADDRESS RemoteAddr;
    int            iSocketType;
    int            iProtocol;
}

struct SOCKADDR_STORAGE
{
    ADDRESS_FAMILY ss_family;
    CHAR[6]        __ss_pad1;
    long           __ss_align;
    CHAR[112]      __ss_pad2;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-sockaddr_storage_xp))], [])
struct SOCKADDR_STORAGE_XP
{
    short     ss_family;
    CHAR[6]   __ss_pad1;
    long      __ss_align;
    CHAR[112] __ss_pad2;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-socket_processor_affinity))], [])
struct SOCKET_PROCESSOR_AFFINITY
{
    PROCESSOR_NUMBER Processor;
    ushort           NumaNodeId;
    ushort           Reserved;
}

struct SCOPE_ID
{
union Anonymous
    {
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Level)), FixedArgSig(ElementSig(28)), FixedArgSig(ElementSig(4))], [])*/uint _bitfield81;
        }
        uint Value;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-sockaddr_in))], [])
struct SOCKADDR_IN
{
    ADDRESS_FAMILY sin_family;
    ushort         sin_port;
    IN_ADDR        sin_addr;
    CHAR[8]        sin_zero;
}

struct SOCKADDR_DL
{
    ADDRESS_FAMILY sdl_family;
    ubyte[8]       sdl_data;
    ubyte[4]       sdl_zero;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-wsabuf))], [])
struct WSABUF
{
    uint len;
    PSTR buf;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-wsamsg))], [])
struct WSAMSG
{
    SOCKADDR* name;
    int       namelen;
    WSABUF*   lpBuffers;
    uint      dwBufferCount;
    WSABUF    Control;
    uint      dwFlags;
}

struct CMSGHDR
{
    size_t cmsg_len;
    int    cmsg_level;
    int    cmsg_type;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoa))], [])
struct ADDRINFOA
{
    int        ai_flags;
    int        ai_family;
    int        ai_socktype;
    int        ai_protocol;
    size_t     ai_addrlen;
    PSTR       ai_canonname;
    SOCKADDR*  ai_addr;
    ADDRINFOA* ai_next;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfow))], [])
struct ADDRINFOW
{
    int        ai_flags;
    int        ai_family;
    int        ai_socktype;
    int        ai_protocol;
    size_t     ai_addrlen;
    PWSTR      ai_canonname;
    SOCKADDR*  ai_addr;
    ADDRINFOW* ai_next;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ADDRINFOEXW))], [])
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoexa))], [])
struct ADDRINFOEXA
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PSTR         ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEXA* ai_next;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoexw))], [])
struct ADDRINFOEXW
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PWSTR        ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEXW* ai_next;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ADDRINFOEX2W))], [])
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex2a))], [])
struct ADDRINFOEX2A
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    PSTR          ai_canonname;
    SOCKADDR*     ai_addr;
    void*         ai_blob;
    size_t        ai_bloblen;
    GUID*         ai_provider;
    ADDRINFOEX2A* ai_next;
    int           ai_version;
    PSTR          ai_fqdn;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex2w))], [])
struct ADDRINFOEX2W
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    PWSTR         ai_canonname;
    SOCKADDR*     ai_addr;
    void*         ai_blob;
    size_t        ai_bloblen;
    GUID*         ai_provider;
    ADDRINFOEX2W* ai_next;
    int           ai_version;
    PWSTR         ai_fqdn;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex3))], [])
struct ADDRINFOEX3
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PWSTR        ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEX3* ai_next;
    int          ai_version;
    PWSTR        ai_fqdn;
    int          ai_interfaceindex;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex4))], [])
struct ADDRINFOEX4
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PWSTR        ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEX4* ai_next;
    int          ai_version;
    PWSTR        ai_fqdn;
    int          ai_interfaceindex;
    HANDLE       ai_resolutionhandle;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex5))], [])
struct ADDRINFOEX5
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PWSTR        ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEX5* ai_next;
    int          ai_version;
    PWSTR        ai_fqdn;
    int          ai_interfaceindex;
    HANDLE       ai_resolutionhandle;
    uint         ai_ttl;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfo_dns_server))], [])
struct ADDRINFO_DNS_SERVER
{
    uint      ai_servertype;
    ulong     ai_flags;
    uint      ai_addrlen;
    SOCKADDR* ai_addr;
union Anonymous
    {
        PWSTR ai_template;
        PWSTR ai_hostname;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex6))], [])
struct ADDRINFOEX6
{
    int                  ai_flags;
    int                  ai_family;
    int                  ai_socktype;
    int                  ai_protocol;
    size_t               ai_addrlen;
    PWSTR                ai_canonname;
    SOCKADDR*            ai_addr;
    void*                ai_blob;
    size_t               ai_bloblen;
    GUID*                ai_provider;
    ADDRINFOEX5*         ai_next;
    int                  ai_version;
    PWSTR                ai_fqdn;
    int                  ai_interfaceindex;
    HANDLE               ai_resolutionhandle;
    uint                 ai_ttl;
    uint                 ai_numservers;
    ADDRINFO_DNS_SERVER* ai_servers;
    ulong                ai_responseflags;
}

struct ADDRINFOEX7
{
    int                  ai_flags;
    int                  ai_family;
    int                  ai_socktype;
    int                  ai_protocol;
    size_t               ai_addrlen;
    PWSTR                ai_canonname;
    SOCKADDR*            ai_addr;
    void*                ai_blob;
    size_t               ai_bloblen;
    GUID*                ai_provider;
    ADDRINFOEX7*         ai_next;
    int                  ai_version;
    PWSTR                ai_fqdn;
    int                  ai_interfaceindex;
    HANDLE               ai_resolutionhandle;
    uint                 ai_ttl;
    uint                 ai_numservers;
    ADDRINFO_DNS_SERVER* ai_servers;
    ulong                ai_responseflags;
    ulong                ai_extraflags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-fd_set))], [])
struct FD_SET
{
    uint       fd_count;
    SOCKET[64] fd_array;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-timeval))], [])
struct TIMEVAL
{
    int tv_sec;
    int tv_usec;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-hostent))], [])
struct HOSTENT
{
    PSTR   h_name;
    byte** h_aliases;
    short  h_addrtype;
    short  h_length;
    byte** h_addr_list;
}

struct netent
{
    PSTR   n_name;
    byte** n_aliases;
    short  n_addrtype;
    uint   n_net;
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-servent))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct SERVENT
{
    PSTR   s_name;
    byte** s_aliases;
    short  s_port;
    PSTR   s_proto;
}
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-protoent))], [])
struct PROTOENT
{
    PSTR   p_name;
    byte** p_aliases;
    short  p_proto;
}

version (X86_64) {
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-wsadata))], [])
//STRUCT ATTR: SupportedArchitectureAttribute : CustomAttributeSig([FixedArgSig(ElementSig(EnumDefinition(Row!(MD.typeDef)(15EB78, 302), 1)))], [])
struct WSADATA
{
    ushort    wVersion;
    ushort    wHighVersion;
    CHAR[257] szDescription;
    CHAR[129] szSystemStatus;
    ushort    iMaxSockets;
    ushort    iMaxUdpDg;
    PSTR      lpVendorInfo;
}
}

struct sockproto
{
    ushort sp_family;
    ushort sp_protocol;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-linger))], [])
struct LINGER
{
    ushort l_onoff;
    ushort l_linger;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-qos))], [])
struct QOS
{
    FLOWSPEC SendingFlowspec;
    FLOWSPEC ReceivingFlowspec;
    WSABUF   ProviderSpecific;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanetworkevents))], [])
struct WSANETWORKEVENTS
{
    int     lNetworkEvents;
    int[10] iErrorCode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaprotocolchain))], [])
struct WSAPROTOCOLCHAIN
{
    int     ChainLen;
    uint[7] ChainEntries;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAPROTOCOL_INFOW))], [])
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaprotocol_infoa))], [])
struct WSAPROTOCOL_INFOA
{
    uint             dwServiceFlags1;
    uint             dwServiceFlags2;
    uint             dwServiceFlags3;
    uint             dwServiceFlags4;
    uint             dwProviderFlags;
    GUID             ProviderId;
    uint             dwCatalogEntryId;
    WSAPROTOCOLCHAIN ProtocolChain;
    int              iVersion;
    int              iAddressFamily;
    int              iMaxSockAddr;
    int              iMinSockAddr;
    int              iSocketType;
    int              iProtocol;
    int              iProtocolMaxOffset;
    int              iNetworkByteOrder;
    int              iSecurityScheme;
    uint             dwMessageSize;
    uint             dwProviderReserved;
    CHAR[256]        szProtocol;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaprotocol_infow))], [])
struct WSAPROTOCOL_INFOW
{
    uint             dwServiceFlags1;
    uint             dwServiceFlags2;
    uint             dwServiceFlags3;
    uint             dwServiceFlags4;
    uint             dwProviderFlags;
    GUID             ProviderId;
    uint             dwCatalogEntryId;
    WSAPROTOCOLCHAIN ProtocolChain;
    int              iVersion;
    int              iAddressFamily;
    int              iMaxSockAddr;
    int              iMinSockAddr;
    int              iSocketType;
    int              iProtocol;
    int              iProtocolMaxOffset;
    int              iNetworkByteOrder;
    int              iSecurityScheme;
    uint             dwMessageSize;
    uint             dwProviderReserved;
    wchar[256]       szProtocol;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsacompletion))], [])
struct WSACOMPLETION
{
    WSACOMPLETIONTYPE Type;
union Parameters
    {
struct WindowMessage
        {
            HWND   hWnd;
            uint   uMsg;
            WPARAM context;
        }
struct Event
        {
            OVERLAPPED* lpOverlapped;
        }
struct Apc
        {
            OVERLAPPED* lpOverlapped;
            LPWSAOVERLAPPED_COMPLETION_ROUTINE lpfnCompletionProc;
        }
struct Port
        {
            OVERLAPPED* lpOverlapped;
            HANDLE      hPort;
            size_t      Key;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-afprotocols))], [])
struct AFPROTOCOLS
{
    int iAddressFamily;
    int iProtocol;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaversion))], [])
struct WSAVERSION
{
    uint           dwVersion;
    WSAECOMPARATOR ecHow;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAQUERYSETW))], [])
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaqueryseta))], [])
struct WSAQUERYSETA
{
    uint         dwSize;
    PSTR         lpszServiceInstanceName;
    GUID*        lpServiceClassId;
    WSAVERSION*  lpVersion;
    PSTR         lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    PSTR         lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    PSTR         lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaquerysetw))], [])
struct WSAQUERYSETW
{
    uint         dwSize;
    PWSTR        lpszServiceInstanceName;
    GUID*        lpServiceClassId;
    WSAVERSION*  lpVersion;
    PWSTR        lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    PWSTR        lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    PWSTR        lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAQUERYSET2W))], [])
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaqueryset2a))], [])
struct WSAQUERYSET2A
{
    uint         dwSize;
    PSTR         lpszServiceInstanceName;
    WSAVERSION*  lpVersion;
    PSTR         lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    PSTR         lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    PSTR         lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaqueryset2w))], [])
struct WSAQUERYSET2W
{
    uint         dwSize;
    PWSTR        lpszServiceInstanceName;
    WSAVERSION*  lpVersion;
    PWSTR        lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    PWSTR        lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    PWSTR        lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSANSCLASSINFOW))], [])
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsansclassinfoa))], [])
struct WSANSCLASSINFOA
{
    PSTR  lpszName;
    uint  dwNameSpace;
    uint  dwValueType;
    uint  dwValueSize;
    void* lpValue;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsansclassinfow))], [])
struct WSANSCLASSINFOW
{
    PWSTR lpszName;
    uint  dwNameSpace;
    uint  dwValueType;
    uint  dwValueSize;
    void* lpValue;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSASERVICECLASSINFOW))], [])
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaserviceclassinfoa))], [])
struct WSASERVICECLASSINFOA
{
    GUID*            lpServiceClassId;
    PSTR             lpszServiceClassName;
    uint             dwCount;
    WSANSCLASSINFOA* lpClassInfos;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaserviceclassinfow))], [])
struct WSASERVICECLASSINFOW
{
    GUID*            lpServiceClassId;
    PWSTR            lpszServiceClassName;
    uint             dwCount;
    WSANSCLASSINFOW* lpClassInfos;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSANAMESPACE_INFOW))], [])
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanamespace_infoa))], [])
struct WSANAMESPACE_INFOA
{
    GUID NSProviderId;
    uint dwNameSpace;
    BOOL fActive;
    uint dwVersion;
    PSTR lpszIdentifier;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanamespace_infow))], [])
struct WSANAMESPACE_INFOW
{
    GUID  NSProviderId;
    uint  dwNameSpace;
    BOOL  fActive;
    uint  dwVersion;
    PWSTR lpszIdentifier;
}

//STRUCT ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSANAMESPACE_INFOEXW))], [])
//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanamespace_infoexa))], [])
struct WSANAMESPACE_INFOEXA
{
    GUID NSProviderId;
    uint dwNameSpace;
    BOOL fActive;
    uint dwVersion;
    PSTR lpszIdentifier;
    BLOB ProviderSpecific;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanamespace_infoexw))], [])
struct WSANAMESPACE_INFOEXW
{
    GUID  NSProviderId;
    uint  dwNameSpace;
    BOOL  fActive;
    uint  dwVersion;
    PWSTR lpszIdentifier;
    BLOB  ProviderSpecific;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsapollfd))], [])
struct WSAPOLLFD
{
    SOCKET              fd;
    WSAPOLL_EVENT_FLAGS events;
    WSAPOLL_EVENT_FLAGS revents;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-sock_notify_registration))], [])
struct SOCK_NOTIFY_REGISTRATION
{
    SOCKET socket;
    void*  completionKey;
    ushort eventFilter;
    ubyte  operation;
    ubyte  triggerFlags;
    uint   registrationResult;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/in6addr/ns-in6addr-in6_addr))], [])
struct IN6_ADDR
{
union u
    {
        ubyte[16] Byte;
        ushort[8] Word;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_in6_old))], [])
struct sockaddr_in6_old
{
    short    sin6_family;
    ushort   sin6_port;
    uint     sin6_flowinfo;
    IN6_ADDR sin6_addr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_gen))], [])
union sockaddr_gen
{
    SOCKADDR         Address;
    SOCKADDR_IN      AddressIn;
    sockaddr_in6_old AddressIn6;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-interface_info))], [])
struct INTERFACE_INFO
{
    uint         iiFlags;
    sockaddr_gen iiAddress;
    sockaddr_gen iiBroadcastAddress;
    sockaddr_gen iiNetmask;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-interface_info_ex))], [])
struct INTERFACE_INFO_EX
{
    uint           iiFlags;
    SOCKET_ADDRESS iiAddress;
    SOCKET_ADDRESS iiBroadcastAddress;
    SOCKET_ADDRESS iiNetmask;
}

struct SOCKADDR_IN6
{
    ADDRESS_FAMILY sin6_family;
    ushort         sin6_port;
    uint           sin6_flowinfo;
    IN6_ADDR       sin6_addr;
union Anonymous
    {
        uint     sin6_scope_id;
        SCOPE_ID sin6_scope_struct;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_in6_w2ksp1))], [])
struct SOCKADDR_IN6_W2KSP1
{
    short    sin6_family;
    ushort   sin6_port;
    uint     sin6_flowinfo;
    IN6_ADDR sin6_addr;
    uint     sin6_scope_id;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_inet))], [])
union SOCKADDR_INET
{
    SOCKADDR_IN    Ipv4;
    SOCKADDR_IN6   Ipv6;
    ADDRESS_FAMILY si_family;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_in6_pair))], [])
struct SOCKADDR_IN6_PAIR
{
    SOCKADDR_IN6* SourceAddress;
    SOCKADDR_IN6* DestinationAddress;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-ip_mreq))], [])
struct IP_MREQ
{
    IN_ADDR imr_multiaddr;
    IN_ADDR imr_interface;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-ip_mreq_source))], [])
struct IP_MREQ_SOURCE
{
    IN_ADDR imr_multiaddr;
    IN_ADDR imr_sourceaddr;
    IN_ADDR imr_interface;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-ip_msfilter))], [])
struct IP_MSFILTER
{
    IN_ADDR             imsf_multiaddr;
    IN_ADDR             imsf_interface;
    MULTICAST_MODE_TYPE imsf_fmode;
    uint                imsf_numsrc;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/IN_ADDR[1] imsf_slist;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-ipv6_mreq))], [])
struct IPV6_MREQ
{
    IN6_ADDR ipv6mr_multiaddr;
    uint     ipv6mr_interface;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-group_req))], [])
struct GROUP_REQ
{
    uint             gr_interface;
    SOCKADDR_STORAGE gr_group;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-group_source_req))], [])
struct GROUP_SOURCE_REQ
{
    uint             gsr_interface;
    SOCKADDR_STORAGE gsr_group;
    SOCKADDR_STORAGE gsr_source;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-group_filter))], [])
struct GROUP_FILTER
{
    uint                gf_interface;
    SOCKADDR_STORAGE    gf_group;
    MULTICAST_MODE_TYPE gf_fmode;
    uint                gf_numsrc;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SOCKADDR_STORAGE[1] gf_slist;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-in_pktinfo))], [])
struct IN_PKTINFO
{
    IN_ADDR ipi_addr;
    uint    ipi_ifindex;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-in6_pktinfo))], [])
struct IN6_PKTINFO
{
    IN6_ADDR ipi6_addr;
    uint     ipi6_ifindex;
}

struct IN_PKTINFO_EX
{
    IN_PKTINFO pkt_info;
    SCOPE_ID   scope_id;
}

struct IN6_PKTINFO_EX
{
    IN6_PKTINFO pkt_info;
    SCOPE_ID    scope_id;
}

struct IN_RECVERR
{
    IPPROTO protocol;
    uint    info;
    ubyte   type;
    ubyte   code;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-icmp_error_info))], [])
struct ICMP_ERROR_INFO
{
    SOCKADDR_INET srcaddress;
    IPPROTO       protocol;
    ubyte         type;
    ubyte         code;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsrm/ns-wsrm-rm_send_window))], [])
struct RM_SEND_WINDOW
{
    uint RateKbitsPerSec;
    uint WindowSizeInMSecs;
    uint WindowSizeInBytes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsrm/ns-wsrm-rm_sender_stats))], [])
struct RM_SENDER_STATS
{
    ulong DataBytesSent;
    ulong TotalBytesSent;
    ulong NaksReceived;
    ulong NaksReceivedTooLate;
    ulong NumOutstandingNaks;
    ulong NumNaksAfterRData;
    ulong RepairPacketsSent;
    ulong BufferSpaceAvailable;
    ulong TrailingEdgeSeqId;
    ulong LeadingEdgeSeqId;
    ulong RateKBitsPerSecOverall;
    ulong RateKBitsPerSecLast;
    ulong TotalODataPacketsSent;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsrm/ns-wsrm-rm_receiver_stats))], [])
struct RM_RECEIVER_STATS
{
    ulong NumODataPacketsReceived;
    ulong NumRDataPacketsReceived;
    ulong NumDuplicateDataPackets;
    ulong DataBytesReceived;
    ulong TotalBytesReceived;
    ulong RateKBitsPerSecOverall;
    ulong RateKBitsPerSecLast;
    ulong TrailingEdgeSeqId;
    ulong LeadingEdgeSeqId;
    ulong AverageSequencesInWindow;
    ulong MinSequencesInWindow;
    ulong MaxSequencesInWindow;
    ulong FirstNakSequenceNumber;
    ulong NumPendingNaks;
    ulong NumOutstandingNaks;
    ulong NumDataPacketsBuffered;
    ulong TotalSelectiveNaksSent;
    ulong TotalParityNaksSent;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsrm/ns-wsrm-rm_fec_info))], [])
struct RM_FEC_INFO
{
    ushort  FECBlockSize;
    ushort  FECProActivePackets;
    ubyte   FECGroupSize;
    BOOLEAN fFECOnDemandParityEnabled;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsnwlink/ns-wsnwlink-ipx_address_data))], [])
struct IPX_ADDRESS_DATA
{
    int      adapternum;
    ubyte[4] netnum;
    ubyte[6] nodenum;
    BOOLEAN  wan;
    BOOLEAN  status;
    int      maxpkt;
    uint     linkspeed;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsnwlink/ns-wsnwlink-ipx_netnum_data))], [])
struct IPX_NETNUM_DATA
{
    ubyte[4] netnum;
    ushort   hopcount;
    ushort   netdelay;
    int      cardnum;
    ubyte[6] router;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsnwlink/ns-wsnwlink-ipx_spxconnstatus_data))], [])
struct IPX_SPXCONNSTATUS_DATA
{
    ubyte    ConnectionState;
    ubyte    WatchDogActive;
    ushort   LocalConnectionId;
    ushort   RemoteConnectionId;
    ushort   LocalSequenceNumber;
    ushort   LocalAckNumber;
    ushort   LocalAllocNumber;
    ushort   RemoteAckNumber;
    ushort   RemoteAllocNumber;
    ushort   LocalSocket;
    ubyte[6] ImmediateAddress;
    ubyte[4] RemoteNetwork;
    ubyte[6] RemoteNode;
    ushort   RemoteSocket;
    ushort   RetransmissionCount;
    ushort   EstimatedRoundTripDelay;
    ushort   RetransmittedPackets;
    ushort   SuppressedPacket;
}

struct LM_IRPARMS
{
    uint   nTXDataBytes;
    uint   nRXDataBytes;
    uint   nBaudRate;
    uint   thresholdTime;
    uint   discTime;
    ushort nMSLinkTurn;
    ubyte  nTXPackets;
    ubyte  nRXPackets;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/af_irda/ns-af_irda-sockaddr_irda))], [])
struct SOCKADDR_IRDA
{
    ushort   irdaAddressFamily;
    ubyte[4] irdaDeviceID;
    CHAR[25] irdaServiceName;
}

struct WINDOWS_IRDA_DEVICE_INFO
{
    ubyte[4] irdaDeviceID;
    CHAR[22] irdaDeviceName;
    ubyte    irdaDeviceHints1;
    ubyte    irdaDeviceHints2;
    ubyte    irdaCharSet;
}

struct WCE_IRDA_DEVICE_INFO
{
    ubyte[4] irdaDeviceID;
    CHAR[22] irdaDeviceName;
    ubyte[2] Reserved;
}

struct WINDOWS_DEVICELIST
{
    uint numDevice;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WINDOWS_IRDA_DEVICE_INFO[1] Device;
}

struct WCE_DEVICELIST
{
    uint numDevice;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WCE_IRDA_DEVICE_INFO[1] Device;
}

struct WINDOWS_IAS_SET
{
    CHAR[64]  irdaClassName;
    CHAR[256] irdaAttribName;
    uint      irdaAttribType;
union irdaAttribute
    {
        int irdaAttribInt;
struct irdaAttribOctetSeq
        {
            ushort      Len;
            ubyte[1024] OctetSeq;
        }
struct irdaAttribUsrStr
        {
            ubyte      Len;
            ubyte      CharSet;
            ubyte[256] UsrStr;
        }
    }
}

struct WINDOWS_IAS_QUERY
{
    ubyte[4]  irdaDeviceID;
    CHAR[64]  irdaClassName;
    CHAR[256] irdaAttribName;
    uint      irdaAttribType;
union irdaAttribute
    {
        int irdaAttribInt;
struct irdaAttribOctetSeq
        {
            uint        Len;
            ubyte[1024] OctetSeq;
        }
struct irdaAttribUsrStr
        {
            uint       Len;
            uint       CharSet;
            ubyte[256] UsrStr;
        }
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ns-nldef-nl_interface_offload_rod))], [])
struct NL_INTERFACE_OFFLOAD_ROD
{
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(TlGiantSendOffloadSupported)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(1))], [])*/ubyte _bitfield82;
}

struct NL_PATH_BANDWIDTH_ROD
{
    ulong   Bandwidth;
    ulong   Instability;
    BOOLEAN BandwidthPeaked;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ns-nldef-nl_network_connectivity_hint))], [])
struct NL_NETWORK_CONNECTIVITY_HINT
{
    NL_NETWORK_CONNECTIVITY_LEVEL_HINT ConnectivityLevel;
    NL_NETWORK_CONNECTIVITY_COST_HINT ConnectivityCost;
    BOOLEAN ApproachingDataLimit;
    BOOLEAN OverDataLimit;
    BOOLEAN Roaming;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nldef/ns-nldef-nl_bandwidth_information))], [])
struct NL_BANDWIDTH_INFORMATION
{
    ulong   Bandwidth;
    ulong   Instability;
    BOOLEAN BandwidthPeaked;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-transport_setting_id))], [])
struct TRANSPORT_SETTING_ID
{
    GUID Guid;
}

struct tcp_keepalive
{
    uint onoff;
    uint keepalivetime;
    uint keepaliveinterval;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-real_time_notification_setting_input))], [])
struct REAL_TIME_NOTIFICATION_SETTING_INPUT
{
    TRANSPORT_SETTING_ID TransportSettingId;
    GUID                 BrokerEventGuid;
}

struct REAL_TIME_NOTIFICATION_SETTING_INPUT_EX
{
    TRANSPORT_SETTING_ID TransportSettingId;
    GUID                 BrokerEventGuid;
    BOOLEAN              Unmark;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-real_time_notification_setting_output))], [])
struct REAL_TIME_NOTIFICATION_SETTING_OUTPUT
{
    CONTROL_CHANNEL_TRIGGER_STATUS ChannelStatus;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-associate_nameres_context_input))], [])
struct ASSOCIATE_NAMERES_CONTEXT_INPUT
{
    TRANSPORT_SETTING_ID TransportSettingId;
    ulong                Handle;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-timestamping_config))], [])
struct TIMESTAMPING_CONFIG
{
    uint   Flags;
    ushort TxTimestampsBuffered;
}

struct PRIORITY_STATUS
{
    SOCKET_PRIORITY_HINT Sender;
    SOCKET_PRIORITY_HINT Receiver;
}

struct RCVALL_IF
{
    RCVALL_VALUE Mode;
    uint         Interface;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-tcp_initial_rto_parameters))], [])
struct TCP_INITIAL_RTO_PARAMETERS
{
    ushort Rtt;
    ubyte  MaxSynRetransmissions;
}

struct TCP_ICW_PARAMETERS
{
    TCP_ICW_LEVEL Level;
}

struct TCP_ACK_FREQUENCY_PARAMETERS
{
    ubyte TcpDelayedAckFrequency;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-tcp_info_v0))], [])
struct TCP_INFO_v0
{
    TCPSTATE State;
    uint     Mss;
    ulong    ConnectionTimeMs;
    BOOLEAN  TimestampsEnabled;
    uint     RttUs;
    uint     MinRttUs;
    uint     BytesInFlight;
    uint     Cwnd;
    uint     SndWnd;
    uint     RcvWnd;
    uint     RcvBuf;
    ulong    BytesOut;
    ulong    BytesIn;
    uint     BytesReordered;
    uint     BytesRetrans;
    uint     FastRetrans;
    uint     DupAcksIn;
    uint     TimeoutEpisodes;
    ubyte    SynRetrans;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-tcp_info_v1))], [])
struct TCP_INFO_v1
{
    TCPSTATE State;
    uint     Mss;
    ulong    ConnectionTimeMs;
    BOOLEAN  TimestampsEnabled;
    uint     RttUs;
    uint     MinRttUs;
    uint     BytesInFlight;
    uint     Cwnd;
    uint     SndWnd;
    uint     RcvWnd;
    uint     RcvBuf;
    ulong    BytesOut;
    ulong    BytesIn;
    uint     BytesReordered;
    uint     BytesRetrans;
    uint     FastRetrans;
    uint     DupAcksIn;
    uint     TimeoutEpisodes;
    ubyte    SynRetrans;
    uint     SndLimTransRwin;
    uint     SndLimTimeRwin;
    ulong    SndLimBytesRwin;
    uint     SndLimTransCwnd;
    uint     SndLimTimeCwnd;
    ulong    SndLimBytesCwnd;
    uint     SndLimTransSnd;
    uint     SndLimTimeSnd;
    ulong    SndLimBytesSnd;
}

struct TCP_INFO_v2
{
    TCPSTATE State;
    uint     Mss;
    ulong    ConnectionTimeMs;
    BOOLEAN  TimestampsEnabled;
    uint     RttUs;
    uint     MinRttUs;
    uint     BytesInFlight;
    uint     Cwnd;
    uint     SndWnd;
    uint     RcvWnd;
    uint     RcvBuf;
    ulong    BytesOut;
    ulong    BytesIn;
    uint     BytesReordered;
    uint     BytesRetrans;
    uint     FastRetrans;
    uint     DupAcksIn;
    uint     TimeoutEpisodes;
    ubyte    SynRetrans;
    uint     SndLimTransRwin;
    uint     SndLimTimeRwin;
    ulong    SndLimBytesRwin;
    uint     SndLimTransCwnd;
    uint     SndLimTimeCwnd;
    ulong    SndLimBytesCwnd;
    uint     SndLimTransSnd;
    uint     SndLimTimeSnd;
    ulong    SndLimBytesSnd;
    uint     OutOfOrderPktsIn;
    BOOLEAN  EcnNegotiated;
    uint     EceAcksIn;
    uint     PtoEpisodes;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-inet_port_range))], [])
struct INET_PORT_RANGE
{
    ushort StartPort;
    ushort NumberOfPorts;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-inet_port_reservation_token))], [])
struct INET_PORT_RESERVATION_TOKEN
{
    ulong Token;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-inet_port_reservation_instance))], [])
struct INET_PORT_RESERVATION_INSTANCE
{
    INET_PORT_RANGE Reservation;
    INET_PORT_RESERVATION_TOKEN Token;
}

struct INET_PORT_RESERVATION_INFORMATION
{
    uint OwningPid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_security_settings))], [])
struct SOCKET_SECURITY_SETTINGS
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint SecurityFlags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_security_settings_ipsec))], [])
struct SOCKET_SECURITY_SETTINGS_IPSEC
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint  SecurityFlags;
    uint  IpsecFlags;
    GUID  AuthipMMPolicyKey;
    GUID  AuthipQMPolicyKey;
    GUID  Reserved;
    ulong Reserved2;
    uint  UserNameStringLen;
    uint  DomainNameStringLen;
    uint  PasswordStringLen;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] AllStrings;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_peer_target_name))], [])
struct SOCKET_PEER_TARGET_NAME
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE PeerAddress;
    uint             PeerTargetNameStringLen;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/wchar[1] AllStrings;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_security_query_template))], [])
struct SOCKET_SECURITY_QUERY_TEMPLATE
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE PeerAddress;
    uint             PeerTokenAccessMask;
}

struct SOCKET_SECURITY_QUERY_TEMPLATE_IPSEC2
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE PeerAddress;
    uint             PeerTokenAccessMask;
    uint             Flags;
    uint             FieldMask;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_security_query_info))], [])
struct SOCKET_SECURITY_QUERY_INFO
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint  Flags;
    ulong PeerApplicationAccessTokenHandle;
    ulong PeerMachineAccessTokenHandle;
}

struct SOCKET_SECURITY_QUERY_INFO_IPSEC2
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint  Flags;
    ulong PeerApplicationAccessTokenHandle;
    ulong PeerMachineAccessTokenHandle;
    ulong MmSaId;
    ulong QmSaId;
    uint  NegotiationWinerr;
    GUID  SaLookupContext;
}

struct RSS_SCALABILITY_INFO
{
    BOOLEAN RssEnabled;
}

struct WSA_COMPATIBILITY_MODE
{
    WSA_COMPATIBILITY_BEHAVIOR_ID BehaviorId;
    uint TargetOsVersion;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsockdef/ns-mswsockdef-rioresult))], [])
struct RIORESULT
{
    int   Status;
    uint  BytesTransferred;
    ulong SocketContext;
    ulong RequestContext;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsockdef/ns-mswsockdef-rio_buf))], [])
struct RIO_BUF
{
    RIO_BUFFERID BufferId;
    uint         Offset;
    uint         Length;
}

struct RIO_CMSG_BUFFER
{
    uint TotalLength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2atm/ns-ws2atm-atm_address))], [])
struct ATM_ADDRESS
{
    uint      AddressType;
    uint      NumofDigits;
    ubyte[20] Addr;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2atm/ns-ws2atm-atm_blli))], [])
struct ATM_BLLI
{
    uint     Layer2Protocol;
    uint     Layer2UserSpecifiedProtocol;
    uint     Layer3Protocol;
    uint     Layer3UserSpecifiedProtocol;
    uint     Layer3IPI;
    ubyte[5] SnapID;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2atm/ns-ws2atm-atm_bhli))], [])
struct ATM_BHLI
{
    uint     HighLayerInfoType;
    uint     HighLayerInfoLength;
    ubyte[8] HighLayerInfo;
}

struct SOCKADDR_ATM
{
    ushort      satm_family;
    ATM_ADDRESS satm_number;
    ATM_BLLI    satm_blli;
    ATM_BHLI    satm_bhli;
}

struct Q2931_IE
{
    Q2931_IE_TYPE IEType;
    uint          IELength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] IE;
}

struct AAL5_PARAMETERS
{
    uint  ForwardMaxCPCSSDUSize;
    uint  BackwardMaxCPCSSDUSize;
    ubyte Mode;
    ubyte SSCSType;
}

struct AALUSER_PARAMETERS
{
    uint UserDefined;
}

struct AAL_PARAMETERS_IE
{
    AAL_TYPE AALType;
union AALSpecificParameters
    {
        AAL5_PARAMETERS    AAL5Parameters;
        AALUSER_PARAMETERS AALUserParameters;
    }
}

struct ATM_TD
{
    uint PeakCellRate_CLP0;
    uint PeakCellRate_CLP01;
    uint SustainableCellRate_CLP0;
    uint SustainableCellRate_CLP01;
    uint MaxBurstSize_CLP0;
    uint MaxBurstSize_CLP01;
    BOOL Tagging;
}

struct ATM_TRAFFIC_DESCRIPTOR_IE
{
    ATM_TD Forward;
    ATM_TD Backward;
    BOOL   BestEffort;
}

struct ATM_BROADBAND_BEARER_CAPABILITY_IE
{
    ubyte BearerClass;
    ubyte TrafficType;
    ubyte TimingRequirements;
    ubyte ClippingSusceptability;
    ubyte UserPlaneConnectionConfig;
}

struct ATM_BLLI_IE
{
    uint     Layer2Protocol;
    ubyte    Layer2Mode;
    ubyte    Layer2WindowSize;
    uint     Layer2UserSpecifiedProtocol;
    uint     Layer3Protocol;
    ubyte    Layer3Mode;
    ubyte    Layer3DefaultPacketSize;
    ubyte    Layer3PacketWindowSize;
    uint     Layer3UserSpecifiedProtocol;
    uint     Layer3IPI;
    ubyte[5] SnapID;
}

struct ATM_CALLING_PARTY_NUMBER_IE
{
    ATM_ADDRESS ATM_Number;
    ubyte       Presentation_Indication;
    ubyte       Screening_Indicator;
}

struct ATM_CAUSE_IE
{
    ubyte    Location;
    ubyte    Cause;
    ubyte    DiagnosticsLength;
    ubyte[4] Diagnostics;
}

struct ATM_QOS_CLASS_IE
{
    ubyte QOSClassForward;
    ubyte QOSClassBackward;
}

struct ATM_TRANSIT_NETWORK_SELECTION_IE
{
    ubyte TypeOfNetworkId;
    ubyte NetworkIdPlan;
    ubyte NetworkIdLength;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] NetworkId;
}

struct ATM_CONNECTION_ID
{
    uint DeviceNumber;
    uint VPI;
    uint VCI;
}

struct ATM_PVC_PARAMS
{
align (4):
    ATM_CONNECTION_ID PvcConnectionId;
    QOS               PvcQos;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nsemail/ns-nsemail-napi_domain_description_blob))], [])
struct NAPI_DOMAIN_DESCRIPTION_BLOB
{
    uint AuthLevel;
    uint cchDomainName;
    uint OffsetNextDomainDescription;
    uint OffsetThisDomainName;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nsemail/ns-nsemail-napi_provider_installation_blob))], [])
struct NAPI_PROVIDER_INSTALLATION_BLOB
{
    uint dwVersion;
    uint dwProviderType;
    uint fSupportsWildCard;
    uint cDomains;
    uint OffsetFirstDomain;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsock/ns-mswsock-transmit_file_buffers))], [])
struct TRANSMIT_FILE_BUFFERS
{
    void* Head;
    uint  HeadLength;
    void* Tail;
    uint  TailLength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsock/ns-mswsock-transmit_packets_element))], [])
struct TRANSMIT_PACKETS_ELEMENT
{
    uint dwElFlags;
    uint cLength;
union Anonymous
    {
struct Anonymous
        {
            long   nFileOffset;
            HANDLE hFile;
        }
        void* pBuffer;
    }
}

struct NLA_BLOB
{
struct header
    {
        NLA_BLOB_DATA_TYPE type;
        uint               dwSize;
        uint               nextOffset;
    }
union data
    {
        CHAR[1] rawData;
struct interfaceData
        {
            uint dwType;
            uint dwSpeed;
            /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/CHAR[1] adapterName;
        }
struct locationData
        {
            /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/CHAR[1] information;
        }
struct connectivity
        {
            NLA_CONNECTIVITY_TYPE type;
            NLA_INTERNET internet;
        }
struct ICS
        {
struct remote
            {
                uint       speed;
                uint       type;
                uint       state;
                wchar[256] machineName;
                wchar[256] sharedAdapterName;
            }
        }
    }
}

struct WSAPOLLDATA
{
    int  result;
    uint fds;
    int  timeout;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/WSAPOLLFD[1] fdArray;
}

struct WSASENDMSG
{
    WSAMSG*     lpMsg;
    uint        dwFlags;
    uint*       lpNumberOfBytesSent;
    OVERLAPPED* lpOverlapped;
    LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsock/ns-mswsock-rio_notification_completion))], [])
struct RIO_NOTIFICATION_COMPLETION
{
    RIO_NOTIFICATION_COMPLETION_TYPE Type;
union Anonymous
    {
struct Event
        {
            HANDLE EventHandle;
            BOOL   NotifyReset;
        }
struct Iocp
        {
            HANDLE IocpHandle;
            void*  CompletionKey;
            void*  Overlapped;
        }
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsock/ns-mswsock-rio_extension_function_table))], [])
struct RIO_EXTENSION_FUNCTION_TABLE
{
    uint              cbSize;
    LPFN_RIORECEIVE   RIOReceive;
    LPFN_RIORECEIVEEX RIOReceiveEx;
    LPFN_RIOSEND      RIOSend;
    LPFN_RIOSENDEX    RIOSendEx;
    LPFN_RIOCLOSECOMPLETIONQUEUE RIOCloseCompletionQueue;
    LPFN_RIOCREATECOMPLETIONQUEUE RIOCreateCompletionQueue;
    LPFN_RIOCREATEREQUESTQUEUE RIOCreateRequestQueue;
    LPFN_RIODEQUEUECOMPLETION RIODequeueCompletion;
    LPFN_RIODEREGISTERBUFFER RIODeregisterBuffer;
    LPFN_RIONOTIFY    RIONotify;
    LPFN_RIOREGISTERBUFFER RIORegisterBuffer;
    LPFN_RIORESIZECOMPLETIONQUEUE RIOResizeCompletionQueue;
    LPFN_RIORESIZEREQUESTQUEUE RIOResizeRequestQueue;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wspdata))], [])
struct WSPDATA
{
    ushort     wVersion;
    ushort     wHighVersion;
    wchar[256] szDescription;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wsathreadid))], [])
struct WSATHREADID
{
    HANDLE ThreadHandle;
    size_t Reserved;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wspproc_table))], [])
struct WSPPROC_TABLE
{
    LPWSPACCEPT          lpWSPAccept;
    LPWSPADDRESSTOSTRING lpWSPAddressToString;
    LPWSPASYNCSELECT     lpWSPAsyncSelect;
    LPWSPBIND            lpWSPBind;
    LPWSPCANCELBLOCKINGCALL lpWSPCancelBlockingCall;
    LPWSPCLEANUP         lpWSPCleanup;
    LPWSPCLOSESOCKET     lpWSPCloseSocket;
    LPWSPCONNECT         lpWSPConnect;
    LPWSPDUPLICATESOCKET lpWSPDuplicateSocket;
    LPWSPENUMNETWORKEVENTS lpWSPEnumNetworkEvents;
    LPWSPEVENTSELECT     lpWSPEventSelect;
    LPWSPGETOVERLAPPEDRESULT lpWSPGetOverlappedResult;
    LPWSPGETPEERNAME     lpWSPGetPeerName;
    LPWSPGETSOCKNAME     lpWSPGetSockName;
    LPWSPGETSOCKOPT      lpWSPGetSockOpt;
    LPWSPGETQOSBYNAME    lpWSPGetQOSByName;
    LPWSPIOCTL           lpWSPIoctl;
    LPWSPJOINLEAF        lpWSPJoinLeaf;
    LPWSPLISTEN          lpWSPListen;
    LPWSPRECV            lpWSPRecv;
    LPWSPRECVDISCONNECT  lpWSPRecvDisconnect;
    LPWSPRECVFROM        lpWSPRecvFrom;
    LPWSPSELECT          lpWSPSelect;
    LPWSPSEND            lpWSPSend;
    LPWSPSENDDISCONNECT  lpWSPSendDisconnect;
    LPWSPSENDTO          lpWSPSendTo;
    LPWSPSETSOCKOPT      lpWSPSetSockOpt;
    LPWSPSHUTDOWN        lpWSPShutdown;
    LPWSPSOCKET          lpWSPSocket;
    LPWSPSTRINGTOADDRESS lpWSPStringToAddress;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wspupcalltable))], [])
struct WSPUPCALLTABLE
{
    LPWPUCLOSEEVENT      lpWPUCloseEvent;
    LPWPUCLOSESOCKETHANDLE lpWPUCloseSocketHandle;
    LPWPUCREATEEVENT     lpWPUCreateEvent;
    LPWPUCREATESOCKETHANDLE lpWPUCreateSocketHandle;
    LPWPUFDISSET         lpWPUFDIsSet;
    LPWPUGETPROVIDERPATH lpWPUGetProviderPath;
    LPWPUMODIFYIFSHANDLE lpWPUModifyIFSHandle;
    LPWPUPOSTMESSAGE     lpWPUPostMessage;
    LPWPUQUERYBLOCKINGCALLBACK lpWPUQueryBlockingCallback;
    LPWPUQUERYSOCKETHANDLECONTEXT lpWPUQuerySocketHandleContext;
    LPWPUQUEUEAPC        lpWPUQueueApc;
    LPWPURESETEVENT      lpWPUResetEvent;
    LPWPUSETEVENT        lpWPUSetEvent;
    LPWPUOPENCURRENTTHREAD lpWPUOpenCurrentThread;
    LPWPUCLOSETHREAD     lpWPUCloseThread;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wsc_provider_audit_info))], [])
struct WSC_PROVIDER_AUDIT_INFO
{
    uint  RecordSize;
    void* Reserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-nsp_routine))], [])
struct NSP_ROUTINE
{
    uint            cbSize;
    uint            dwMajorVersion;
    uint            dwMinorVersion;
    LPNSPCLEANUP    NSPCleanup;
    LPNSPLOOKUPSERVICEBEGIN NSPLookupServiceBegin;
    LPNSPLOOKUPSERVICENEXT NSPLookupServiceNext;
    LPNSPLOOKUPSERVICEEND NSPLookupServiceEnd;
    LPNSPSETSERVICE NSPSetService;
    LPNSPINSTALLSERVICECLASS NSPInstallServiceClass;
    LPNSPREMOVESERVICECLASS NSPRemoveServiceClass;
    LPNSPGETSERVICECLASSINFO NSPGetServiceClassInfo;
    LPNSPIOCTL      NSPIoctl;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-nspv2_routine))], [])
struct NSPV2_ROUTINE
{
    uint                cbSize;
    uint                dwMajorVersion;
    uint                dwMinorVersion;
    LPNSPV2STARTUP      NSPv2Startup;
    LPNSPV2CLEANUP      NSPv2Cleanup;
    LPNSPV2LOOKUPSERVICEBEGIN NSPv2LookupServiceBegin;
    LPNSPV2LOOKUPSERVICENEXTEX NSPv2LookupServiceNextEx;
    LPNSPV2LOOKUPSERVICEEND NSPv2LookupServiceEnd;
    LPNSPV2SETSERVICEEX NSPv2SetServiceEx;
    LPNSPV2CLIENTSESSIONRUNDOWN NSPv2ClientSessionRundown;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct NS_INFOA
{
    uint dwNameSpace;
    uint dwNameSpaceFlags;
    PSTR lpNameSpace;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct NS_INFOW
{
    uint  dwNameSpace;
    uint  dwNameSpaceFlags;
    PWSTR lpNameSpace;
}

struct SERVICE_TYPE_VALUE
{
    uint dwNameSpace;
    uint dwValueType;
    uint dwValueSize;
    uint dwValueNameOffset;
    uint dwValueOffset;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_type_value_absa))], [])
struct SERVICE_TYPE_VALUE_ABSA
{
    uint  dwNameSpace;
    uint  dwValueType;
    uint  dwValueSize;
    PSTR  lpValueName;
    void* lpValue;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_type_value_absw))], [])
struct SERVICE_TYPE_VALUE_ABSW
{
    uint  dwNameSpace;
    uint  dwValueType;
    uint  dwValueSize;
    PWSTR lpValueName;
    void* lpValue;
}

struct SERVICE_TYPE_INFO
{
    uint dwTypeNameOffset;
    uint dwValueCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SERVICE_TYPE_VALUE[1] Values;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_type_info_absa))], [])
struct SERVICE_TYPE_INFO_ABSA
{
    PSTR lpTypeName;
    uint dwValueCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SERVICE_TYPE_VALUE_ABSA[1] Values;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_type_info_absw))], [])
struct SERVICE_TYPE_INFO_ABSW
{
    PWSTR lpTypeName;
    uint  dwValueCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SERVICE_TYPE_VALUE_ABSW[1] Values;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_address))], [])
struct SERVICE_ADDRESS
{
    uint   dwAddressType;
    uint   dwAddressFlags;
    uint   dwAddressLength;
    uint   dwPrincipalLength;
    ubyte* lpAddress;
    ubyte* lpPrincipal;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_addresses))], [])
struct SERVICE_ADDRESSES
{
    uint dwAddressCount;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/SERVICE_ADDRESS[1] Addresses;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_infoa))], [])
struct SERVICE_INFOA
{
    GUID*              lpServiceType;
    PSTR               lpServiceName;
    PSTR               lpComment;
    PSTR               lpLocale;
    RESOURCE_DISPLAY_TYPE dwDisplayHint;
    uint               dwVersion;
    uint               dwTime;
    PSTR               lpMachineName;
    SERVICE_ADDRESSES* lpServiceAddress;
    BLOB               ServiceSpecificInfo;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_infow))], [])
struct SERVICE_INFOW
{
    GUID*              lpServiceType;
    PWSTR              lpServiceName;
    PWSTR              lpComment;
    PWSTR              lpLocale;
    RESOURCE_DISPLAY_TYPE dwDisplayHint;
    uint               dwVersion;
    uint               dwTime;
    PWSTR              lpMachineName;
    SERVICE_ADDRESSES* lpServiceAddress;
    BLOB               ServiceSpecificInfo;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-ns_service_infoa))], [])
struct NS_SERVICE_INFOA
{
    uint          dwNameSpace;
    SERVICE_INFOA ServiceInfo;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-ns_service_infow))], [])
struct NS_SERVICE_INFOW
{
    uint          dwNameSpace;
    SERVICE_INFOW ServiceInfo;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-protocol_infoa))], [])
struct PROTOCOL_INFOA
{
    uint dwServiceFlags;
    int  iAddressFamily;
    int  iMaxSockAddr;
    int  iMinSockAddr;
    int  iSocketType;
    int  iProtocol;
    uint dwMessageSize;
    PSTR lpProtocol;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-protocol_infow))], [])
struct PROTOCOL_INFOW
{
    uint  dwServiceFlags;
    int   iAddressFamily;
    int   iMaxSockAddr;
    int   iMinSockAddr;
    int   iSocketType;
    int   iProtocol;
    uint  dwMessageSize;
    PWSTR lpProtocol;
}

//STRUCT ATTR: AnsiAttribute : CustomAttributeSig([], [])
struct NETRESOURCE2A
{
    uint     dwScope;
    uint     dwType;
    uint     dwUsage;
    uint     dwDisplayType;
    PSTR     lpLocalName;
    PSTR     lpRemoteName;
    PSTR     lpComment;
    NS_INFOA ns_info;
    GUID     ServiceType;
    uint     dwProtocols;
    int*     lpiProtocols;
}

//STRUCT ATTR: UnicodeAttribute : CustomAttributeSig([], [])
struct NETRESOURCE2W
{
    uint     dwScope;
    uint     dwType;
    uint     dwUsage;
    uint     dwDisplayType;
    PWSTR    lpLocalName;
    PWSTR    lpRemoteName;
    PWSTR    lpComment;
    NS_INFOA ns_info;
    GUID     ServiceType;
    uint     dwProtocols;
    int*     lpiProtocols;
}

struct SERVICE_ASYNC_INFO
{
    LPSERVICE_CALLBACK_PROC lpServiceCallbackProc;
    LPARAM lParam;
    HANDLE hAsyncTaskHandle;
}

struct SOCKADDR_UN
{
    ADDRESS_FAMILY sun_family;
    CHAR[108]      sun_path;
}

struct SOCKADDR_IPX
{
    short   sa_family;
    CHAR[4] sa_netnum;
    CHAR[6] sa_nodenum;
    ushort  sa_socket;
}

struct SOCKADDR_TP
{
    ushort    tp_family;
    ushort    tp_addr_type;
    ushort    tp_taddr_len;
    ushort    tp_tsel_len;
    ubyte[64] tp_addr;
}

struct SOCKADDR_NB
{
    short    snb_family;
    ushort   snb_type;
    CHAR[16] snb_name;
}

struct SOCKADDR_VNS
{
    ushort   sin_family;
    ubyte[4] net_address;
    ubyte[2] subnet_addr;
    ubyte[2] port;
    ubyte    hops;
    ubyte[5] filler;
}

union DL_OUI
{
    ubyte[3] Byte;
struct Anonymous
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Local)), FixedArgSig(ElementSig(1)), FixedArgSig(ElementSig(1))], [])*/ubyte _bitfield83;
    }
}

union DL_EI48
{
    ubyte[3] Byte;
}

union DL_EUI48
{
    ubyte[6] Byte;
struct Anonymous
    {
        DL_OUI  Oui;
        DL_EI48 Ei48;
    }
}

union DL_EI64
{
    ubyte[5] Byte;
}

union DL_EUI64
{
    ubyte[8] Byte;
    ulong    Value;
struct Anonymous
    {
        DL_OUI Oui;
union Anonymous
        {
            DL_EI64 Ei64;
struct Anonymous
            {
                ubyte   Type;
                ubyte   Tse;
                DL_EI48 Ei48;
            }
        }
    }
}

struct SNAP_HEADER
{
    ubyte    Dsap;
    ubyte    Ssap;
    ubyte    Control;
    ubyte[3] Oui;
    ushort   Type;
}

struct ETHERNET_HEADER
{
    DL_EUI48 Destination;
    DL_EUI48 Source;
union Anonymous
    {
        ushort Type;
        ushort Length;
    }
}

struct VLAN_TAG
{
union Anonymous
    {
        ushort Tag;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(User_Priority)), FixedArgSig(ElementSig(13)), FixedArgSig(ElementSig(3))], [])*/ushort _bitfield84;
        }
    }
    ushort Type;
}

struct ICMP_HEADER
{
    ubyte  Type;
    ubyte  Code;
    ushort Checksum;
}

struct ICMP_MESSAGE
{
    ICMP_HEADER Header;
union Data
    {
        uint[1]   Data32;
        ushort[2] Data16;
        ubyte[4]  Data8;
    }
}

struct IPV4_HEADER
{
union Anonymous1
    {
        ubyte VersionAndHeaderLength;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DontUse2)), FixedArgSig(ElementSig(8)), FixedArgSig(ElementSig(8))], [])*/ushort _bitfield85;
        }
    }
union Anonymous2
    {
        ubyte TypeOfServiceAndEcnField;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DontUse2)), FixedArgSig(ElementSig(8)), FixedArgSig(ElementSig(8))], [])*/ushort _bitfield86;
        }
    }
    ushort  TotalLength;
    ushort  Identification;
union Anonymous3
    {
        ushort FlagsAndOffset;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DontUse2)), FixedArgSig(ElementSig(8)), FixedArgSig(ElementSig(8))], [])*/ushort _bitfield87;
        }
    }
    ubyte   TimeToLive;
    ubyte   Protocol;
    ushort  HeaderChecksum;
    IN_ADDR SourceAddress;
    IN_ADDR DestinationAddress;
}

struct IPV4_OPTION_HEADER
{
union Anonymous
    {
        ubyte OptionType;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(CopiedFlag)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(1))], [])*/ubyte _bitfield88;
        }
    }
    ubyte OptionLength;
}

struct IPV4_TIMESTAMP_OPTION
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte              Pointer;
union Anonymous
    {
        ubyte FlagsOverflow;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Overflow)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(4))], [])*/ubyte _bitfield89;
        }
    }
}

struct IPV4_ROUTING_HEADER
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte              Pointer;
}

struct ICMPV4_ROUTER_SOLICIT
{
    ICMP_MESSAGE RsHeader;
}

struct ICMPV4_ROUTER_ADVERT_HEADER
{
    ICMP_MESSAGE RaHeader;
}

struct ICMPV4_ROUTER_ADVERT_ENTRY
{
    IN_ADDR RouterAdvertAddr;
    int     PreferenceLevel;
}

struct ICMPV4_TIMESTAMP_MESSAGE
{
    ICMP_MESSAGE Header;
    uint         OriginateTimestamp;
    uint         ReceiveTimestamp;
    uint         TransmitTimestamp;
}

struct ICMPV4_ADDRESS_MASK_MESSAGE
{
    ICMP_MESSAGE Header;
    uint         AddressMask;
}

struct ARP_HEADER
{
    ushort HardwareAddressSpace;
    ushort ProtocolAddressSpace;
    ubyte  HardwareAddressLength;
    ubyte  ProtocolAddressLength;
    ushort Opcode;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] SenderHardwareAddress;
}

struct IGMP_HEADER
{
union Anonymous1
    {
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Version)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(4))], [])*/ubyte _bitfield90;
        }
        ubyte VersionType;
    }
union Anonymous2
    {
        ubyte Reserved;
        ubyte MaxRespTime;
        ubyte Code;
    }
    ushort  Checksum;
    IN_ADDR MulticastAddress;
}

struct IGMPV3_QUERY_HEADER
{
    ubyte   Type;
union Anonymous1
    {
        ubyte MaxRespCode;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(QQCType)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(1))], [])*/ubyte _bitfield91;
        }
    }
    ushort  Checksum;
    IN_ADDR MulticastAddress;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Reserved)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(4))], [])*/ubyte _bitfield92;
union Anonymous2
    {
        ubyte QueriersQueryInterfaceCode;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(QQCType)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(1))], [])*/ubyte _bitfield93;
        }
    }
    ushort  SourceCount;
}

struct IGMPV3_REPORT_RECORD_HEADER
{
    ubyte   Type;
    ubyte   AuxillaryDataLength;
    ushort  SourceCount;
    IN_ADDR MulticastAddress;
}

struct IGMPV3_REPORT_HEADER
{
    ubyte  Type;
    ubyte  Reserved;
    ushort Checksum;
    ushort Reserved2;
    ushort RecordCount;
}

struct IPV6_HEADER
{
union Anonymous
    {
        uint VersionClassFlow;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Anonymous2)), FixedArgSig(ElementSig(8)), FixedArgSig(ElementSig(24))], [])*/uint _bitfield94;
        }
    }
    ushort   PayloadLength;
    ubyte    NextHeader;
    ubyte    HopLimit;
    IN6_ADDR SourceAddress;
    IN6_ADDR DestinationAddress;
}

struct IPV6_FRAGMENT_HEADER
{
    ubyte NextHeader;
    ubyte Reserved;
union Anonymous
    {
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DontUse2)), FixedArgSig(ElementSig(11)), FixedArgSig(ElementSig(5))], [])*/ushort _bitfield95;
        }
        ushort OffsetAndFlags;
    }
    uint  Id;
}

struct IPV6_EXTENSION_HEADER
{
    ubyte NextHeader;
    ubyte Length;
}

struct IPV6_OPTION_HEADER
{
    ubyte Type;
    ubyte DataLength;
}

struct IPV6_OPTION_JUMBOGRAM
{
    IPV6_OPTION_HEADER Header;
    ubyte[4]           JumbogramLength;
}

struct IPV6_OPTION_ROUTER_ALERT
{
    IPV6_OPTION_HEADER Header;
    ubyte[2]           Value;
}

struct IPV6_ROUTING_HEADER
{
    ubyte    NextHeader;
    ubyte    Length;
    ubyte    RoutingType;
    ubyte    SegmentsLeft;
    ubyte[4] Reserved;
}

struct ND_ROUTER_SOLICIT_HEADER
{
    ICMP_MESSAGE nd_rs_hdr;
}

struct ND_ROUTER_ADVERT_HEADER
{
    ICMP_MESSAGE nd_ra_hdr;
    uint         nd_ra_reachable;
    uint         nd_ra_retransmit;
}

union IPV6_ROUTER_ADVERTISEMENT_FLAGS
{
struct Anonymous
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(ManagedAddressConfiguration)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(1))], [])*/ubyte _bitfield96;
    }
    ubyte Value;
}

struct ND_NEIGHBOR_SOLICIT_HEADER
{
    ICMP_MESSAGE nd_ns_hdr;
    IN6_ADDR     nd_ns_target;
}

struct ND_NEIGHBOR_ADVERT_HEADER
{
    ICMP_MESSAGE nd_na_hdr;
    IN6_ADDR     nd_na_target;
}

union IPV6_NEIGHBOR_ADVERTISEMENT_FLAGS
{
struct Anonymous
    {
        /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Router)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(1))], [])*/ubyte _bitfield97;
        ubyte[3] Reserved2;
    }
    uint Value;
}

struct ND_REDIRECT_HEADER
{
    ICMP_MESSAGE nd_rd_hdr;
    IN6_ADDR     nd_rd_target;
    IN6_ADDR     nd_rd_dst;
}

struct ND_OPTION_HDR
{
    ubyte nd_opt_type;
    ubyte nd_opt_len;
}

struct ND_OPTION_PREFIX_INFO
{
    ubyte    nd_opt_pi_type;
    ubyte    nd_opt_pi_len;
    ubyte    nd_opt_pi_prefix_len;
union Anonymous1
    {
        ubyte            nd_opt_pi_flags_reserved;
struct Flags
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Preference)), FixedArgSig(ElementSig(3)), FixedArgSig(ElementSig(2))], [])*/ubyte _bitfield98;
        }
    }
    uint     nd_opt_pi_valid_time;
    uint     nd_opt_pi_preferred_time;
union Anonymous2
    {
        uint nd_opt_pi_reserved2;
struct Anonymous
        {
            ubyte[3] nd_opt_pi_reserved3;
            ubyte    nd_opt_pi_site_prefix_len;
        }
    }
    IN6_ADDR nd_opt_pi_prefix;
}

struct ND_OPTION_RD_HDR
{
    ubyte  nd_opt_rh_type;
    ubyte  nd_opt_rh_len;
    ushort nd_opt_rh_reserved1;
    uint   nd_opt_rh_reserved2;
}

struct ND_OPTION_MTU
{
    ubyte  nd_opt_mtu_type;
    ubyte  nd_opt_mtu_len;
    ushort nd_opt_mtu_reserved;
    uint   nd_opt_mtu_mtu;
}

struct ND_OPTION_ROUTE_INFO
{
    ubyte    nd_opt_ri_type;
    ubyte    nd_opt_ri_len;
    ubyte    nd_opt_ri_prefix_len;
union Anonymous
    {
        ubyte nd_opt_ri_flags_reserved;
struct Flags
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Preference)), FixedArgSig(ElementSig(3)), FixedArgSig(ElementSig(2))], [])*/ubyte _bitfield99;
        }
    }
    uint     nd_opt_ri_route_lifetime;
    IN6_ADDR nd_opt_ri_prefix;
}

struct ND_OPTION_RDNSS
{
    ubyte  nd_opt_rdnss_type;
    ubyte  nd_opt_rdnss_len;
    ushort nd_opt_rdnss_reserved;
    uint   nd_opt_rdnss_lifetime;
}

struct ND_OPTION_DNSSL
{
    ubyte  nd_opt_dnssl_type;
    ubyte  nd_opt_dnssl_len;
    ushort nd_opt_dnssl_reserved;
    uint   nd_opt_dnssl_lifetime;
}

struct ND_OPTION_PREF64
{
    ubyte     nd_opt_p64_type;
    ubyte     nd_opt_p64_len;
union Anonymous
    {
        ushort nd_opt_p64_lifetime_plc;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(nd_opt_p64_scaled_lifetime)), FixedArgSig(ElementSig(3)), FixedArgSig(ElementSig(13))], [])*/ushort _bitfield100;
        }
    }
    ubyte[12] nd_opt_p64_prefix;
}

struct MLD_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort      MaxRespTime;
    ushort      Reserved;
    IN6_ADDR    MulticastAddress;
}

struct MLDV2_QUERY_HEADER
{
    ICMP_HEADER IcmpHeader;
union Anonymous1
    {
        ushort MaxRespCode;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(QQCType)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(1))], [])*/ubyte _bitfield101;
        }
    }
    ushort      Reserved;
    IN6_ADDR    MulticastAddress;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(QueryReserved)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(4))], [])*/ubyte _bitfield102;
union Anonymous2
    {
        ubyte QueriersQueryInterfaceCode;
struct Anonymous
        {
            /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(QQCType)), FixedArgSig(ElementSig(7)), FixedArgSig(ElementSig(1))], [])*/ubyte _bitfield103;
        }
    }
    ushort      SourceCount;
}

struct MLDV2_REPORT_RECORD_HEADER
{
    ubyte    Type;
    ubyte    AuxillaryDataLength;
    ushort   SourceCount;
    IN6_ADDR MulticastAddress;
}

struct MLDV2_REPORT_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort      Reserved;
    ushort      RecordCount;
}

struct TCP_HDR
{
align (1):
    ushort th_sport;
    ushort th_dport;
    uint   th_seq;
    uint   th_ack;
    /*FIELD ATTR: NativeBitfieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(th_len)), FixedArgSig(ElementSig(4)), FixedArgSig(ElementSig(4))], [])*/ubyte _bitfield104;
    ubyte  th_flags;
    ushort th_win;
    ushort th_sum;
    ushort th_urp;
}

struct TCP_OPT_MSS
{
align (1):
    ubyte  Kind;
    ubyte  Length;
    ushort Mss;
}

struct TCP_OPT_WS
{
align (1):
    ubyte Kind;
    ubyte Length;
    ubyte ShiftCnt;
}

struct TCP_OPT_SACK_PERMITTED
{
align (1):
    ubyte Kind;
    ubyte Length;
}

struct TCP_OPT_SACK
{
align (1):
    ubyte Kind;
    ubyte Length;
struct Block
    {
    align (1):
        uint Left;
        uint Right;
    }
}

struct TCP_OPT_TS
{
align (1):
    ubyte Kind;
    ubyte Length;
    uint  Val;
    uint  EcR;
}

struct TCP_OPT_UNKNOWN
{
align (1):
    ubyte Kind;
    ubyte Length;
}

struct TCP_OPT_FASTOPEN
{
align (1):
    ubyte Kind;
    ubyte Length;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] Cookie;
}

struct DL_TUNNEL_ADDRESS
{
    COMPARTMENT_ID CompartmentId;
    SCOPE_ID       ScopeId;
    /*FIELD ATTR: FlexibleArrayAttribute : CustomAttributeSig([], [])*/ubyte[1] IpAddress;
}

struct DL_TEREDO_ADDRESS
{
align (1):
    ubyte[6] Reserved;
union Anonymous
    {
    align (1):
        DL_EUI64 Eui64;
struct Anonymous
        {
        align (1):
            ushort  Flags;
            ushort  MappedPort;
            IN_ADDR MappedAddress;
        }
    }
}

struct DL_TEREDO_ADDRESS_PRV
{
align (1):
    ubyte[6] Reserved;
union Anonymous
    {
    align (1):
        DL_EUI64 Eui64;
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
}

struct IPTLS_METADATA
{
align (1):
    ulong SequenceNumber;
}

struct NPI_MODULEID
{
    ushort            Length;
    NPI_MODULEID_TYPE Type;
union Anonymous
    {
        GUID Guid;
        LUID IfLuid;
    }
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscenumprotocols32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCEnumProtocols32(int* lpiProtocols, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOW* lpProtocolBuffer, 
                       uint* lpdwBufferLength, int* lpErrno);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscdeinstallprovider32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCDeinstallProvider32(GUID* lpProviderId, int* lpErrno);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscinstallprovider64_32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCInstallProvider64_32(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                            const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscgetproviderpath32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCGetProviderPath32(GUID* lpProviderId, PWSTR lpszProviderDllPath, int* lpProviderDllPathLen, int* lpErrno);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscupdateprovider32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCUpdateProvider32(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                        const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscsetproviderinfo32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCSetProviderInfo32(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* Info, 
                         size_t InfoSize, uint Flags, int* lpErrno);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscgetproviderinfo32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCGetProviderInfo32(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* Info, 
                         size_t* InfoSize, uint Flags, int* lpErrno);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscenumnamespaceproviders32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCEnumNameSpaceProviders32(uint* lpdwBufferLength, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOW* lpnspBuffer);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscenumnamespaceprovidersex32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCEnumNameSpaceProvidersEx32(uint* lpdwBufferLength, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOEXW* lpnspBuffer);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscinstallnamespace32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCInstallNameSpace32(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, uint dwVersion, 
                          GUID* lpProviderId);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscinstallnamespaceex32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCInstallNameSpaceEx32(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, uint dwVersion, 
                            GUID* lpProviderId, BLOB* lpProviderSpecific);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscuninstallnamespace32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCUnInstallNameSpace32(GUID* lpProviderId);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscenablensprovider32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCEnableNSProvider32(GUID* lpProviderId, BOOL fEnable);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscinstallproviderandchains64_32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCInstallProviderAndChains64_32(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                                     const(PWSTR) lpszProviderDllPath32, const(PWSTR) lpszLspName, 
                                     uint dwServiceFlags, WSAPROTOCOL_INFOW* lpProtocolInfoList, 
                                     uint dwNumberOfEntries, uint* lpdwCatalogEntryId, int* lpErrno);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sporder/nf-sporder-wscwriteproviderorder32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCWriteProviderOrder32(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sporder/nf-sporder-wscwritenamespaceorder32))], [])
version (X86) {
@DllImport("WS2_32.dll")
int WSCWriteNameSpaceOrder32(GUID* lpProviderId, uint dwNumberOfEntries);

}
//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-__wsafdisset))], [])
@DllImport("WS2_32.dll")
int __WSAFDIsSet(SOCKET fd, FD_SET* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-accept))], [])
@DllImport("WS2_32.dll")
SOCKET accept(SOCKET s, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* addr, 
              int* addrlen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-bind))], [])
@DllImport("WS2_32.dll")
int bind(SOCKET s, 
         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
         int namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-closesocket))], [])
@DllImport("WS2_32.dll")
int closesocket(SOCKET s);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-connect))], [])
@DllImport("WS2_32.dll")
int connect(SOCKET s, 
            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
            int namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-ioctlsocket))], [])
@DllImport("WS2_32.dll")
int ioctlsocket(SOCKET s, int cmd, uint* argp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-getpeername))], [])
@DllImport("WS2_32.dll")
int getpeername(SOCKET s, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* name, 
                int* namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-getsockname))], [])
@DllImport("WS2_32.dll")
int getsockname(SOCKET s, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* name, 
                int* namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-getsockopt))], [])
@DllImport("WS2_32.dll")
int getsockopt(SOCKET s, int level, int optname, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR optval, 
               int* optlen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-htonl))], [])
@DllImport("WS2_32.dll")
uint htonl(uint hostlong);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-htons))], [])
@DllImport("WS2_32.dll")
ushort htons(ushort hostshort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(inet_pton() or InetPton()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsipv6ok/nf-wsipv6ok-inet_addr))], [])
@DllImport("WS2_32.dll")
uint inet_addr(const(PSTR) cp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(inet_ntop() or InetNtop()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsipv6ok/nf-wsipv6ok-inet_ntoa))], [])
@DllImport("WS2_32.dll")
PSTR inet_ntoa(IN_ADDR in_);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-listen))], [])
@DllImport("WS2_32.dll")
int listen(SOCKET s, int backlog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-ntohl))], [])
@DllImport("WS2_32.dll")
uint ntohl(uint netlong);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-ntohs))], [])
@DllImport("WS2_32.dll")
ushort ntohs(ushort netshort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-recv))], [])
@DllImport("WS2_32.dll")
int recv(SOCKET s, 
         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR buf, 
         int len, SEND_RECV_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-recvfrom))], [])
@DllImport("WS2_32.dll")
int recvfrom(SOCKET s, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR buf, 
             int len, int flags, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/SOCKADDR* from, 
             int* fromlen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-select))], [])
@DllImport("WS2_32.dll")
int select(int nfds, FD_SET* readfds, FD_SET* writefds, FD_SET* exceptfds, const(TIMEVAL)* timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-send))], [])
@DllImport("WS2_32.dll")
int send(SOCKET s, 
         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) buf, 
         int len, SEND_RECV_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-sendto))], [])
@DllImport("WS2_32.dll")
int sendto(SOCKET s, 
           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) buf, 
           int len, int flags, 
           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(SOCKADDR)* to, 
           int tolen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-setsockopt))], [])
@DllImport("WS2_32.dll")
int setsockopt(SOCKET s, int level, int optname, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PSTR) optval, 
               int optlen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-shutdown))], [])
@DllImport("WS2_32.dll")
int shutdown(SOCKET s, WINSOCK_SHUTDOWN_HOW how);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-socket))], [])
@DllImport("WS2_32.dll")
SOCKET socket(int af, WINSOCK_SOCKET_TYPE type, int protocol);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(getnameinfo() or GetNameInfoW()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsipv6ok/nf-wsipv6ok-gethostbyaddr))], [])
@DllImport("WS2_32.dll")
HOSTENT* gethostbyaddr(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(PSTR) addr, 
                       int len, int type);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(getaddrinfo() or GetAddrInfoW()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsipv6ok/nf-wsipv6ok-gethostbyname))], [])
@DllImport("WS2_32.dll")
HOSTENT* gethostbyname(const(PSTR) name);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-gethostname))], [])
@DllImport("WS2_32.dll")
int gethostname(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR name, 
                int namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-gethostnamew))], [])
@DllImport("WS2_32.dll")
int GetHostNameW(PWSTR name, int namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-getservbyport))], [])
@DllImport("WS2_32.dll")
SERVENT* getservbyport(int port, const(PSTR) proto);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-getservbyname))], [])
@DllImport("WS2_32.dll")
SERVENT* getservbyname(const(PSTR) name, const(PSTR) proto);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-getprotobynumber))], [])
@DllImport("WS2_32.dll")
PROTOENT* getprotobynumber(int number);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-getprotobyname))], [])
@DllImport("WS2_32.dll")
PROTOENT* getprotobyname(const(PSTR) name);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsastartup))], [])
@DllImport("WS2_32.dll")
int WSAStartup(ushort wVersionRequested, WSADATA* lpWSAData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsacleanup))], [])
@DllImport("WS2_32.dll")
int WSACleanup();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsasetlasterror))], [])
@DllImport("WS2_32.dll")
void WSASetLastError(int iError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsagetlasterror))], [])
@DllImport("WS2_32.dll")
WSA_ERROR WSAGetLastError();

//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Winsock 2))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaisblocking))], [])
@DllImport("WS2_32.dll")
BOOL WSAIsBlocking();

//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Winsock 2))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaunhookblockinghook))], [])
@DllImport("WS2_32.dll")
int WSAUnhookBlockingHook();

//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Winsock 2))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasetblockinghook))], [])
@DllImport("WS2_32.dll")
FARPROC WSASetBlockingHook(FARPROC lpBlockFunc);

//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(Winsock 2))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsacancelblockingcall))], [])
@DllImport("WS2_32.dll")
int WSACancelBlockingCall();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(getservbyname()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsaasyncgetservbyname))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetServByName(HWND hWnd, uint wMsg, const(PSTR) name, const(PSTR) proto, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR buf, 
                             int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(getservbyport()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsaasyncgetservbyport))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetServByPort(HWND hWnd, uint wMsg, int port, const(PSTR) proto, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR buf, 
                             int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(getprotobyname()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsaasyncgetprotobyname))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetProtoByName(HWND hWnd, uint wMsg, const(PSTR) name, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR buf, 
                              int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(getprotobynumber()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsaasyncgetprotobynumber))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetProtoByNumber(HWND hWnd, uint wMsg, int number, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR buf, 
                                int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(GetAddrInfoExW()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsipv6ok/nf-wsipv6ok-wsaasyncgethostbyname))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetHostByName(HWND hWnd, uint wMsg, const(PSTR) name, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR buf, 
                             int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(getnameinfo() or GetNameInfoW()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/wsipv6ok/nf-wsipv6ok-wsaasyncgethostbyaddr))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetHostByAddr(HWND hWnd, uint wMsg, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(PSTR) addr, 
                             int len, int type, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/PSTR buf, 
                             int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsacancelasyncrequest))], [])
@DllImport("WS2_32.dll")
int WSACancelAsyncRequest(HANDLE hAsyncTaskHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAEventSelect()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-wsaasyncselect))], [])
@DllImport("WS2_32.dll")
int WSAAsyncSelect(SOCKET s, HWND hWnd, uint wMsg, int lEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaaccept))], [])
@DllImport("WS2_32.dll")
SOCKET WSAAccept(SOCKET s, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* addr, 
                 int* addrlen, LPCONDITIONPROC lpfnCondition, size_t dwCallbackData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsacloseevent))], [])
@DllImport("WS2_32.dll")
BOOL WSACloseEvent(WSAEVENT hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaconnect))], [])
@DllImport("WS2_32.dll")
int WSAConnect(SOCKET s, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
               int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaconnectbynamew))], [])
@DllImport("WS2_32.dll")
BOOL WSAConnectByNameW(SOCKET s, PWSTR nodename, PWSTR servicename, uint* LocalAddressLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/SOCKADDR* LocalAddress, 
                       uint* RemoteAddressLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/SOCKADDR* RemoteAddress, 
                       const(TIMEVAL)* timeout, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAConnectByNameW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaconnectbynamea))], [])
@DllImport("WS2_32.dll")
BOOL WSAConnectByNameA(SOCKET s, const(PSTR) nodename, const(PSTR) servicename, uint* LocalAddressLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/SOCKADDR* LocalAddress, 
                       uint* RemoteAddressLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/SOCKADDR* RemoteAddress, 
                       const(TIMEVAL)* timeout, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaconnectbylist))], [])
@DllImport("WS2_32.dll")
BOOL WSAConnectByList(SOCKET s, SOCKET_ADDRESS_LIST* SocketAddress, uint* LocalAddressLength, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* LocalAddress, 
                      uint* RemoteAddressLength, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKADDR* RemoteAddress, 
                      const(TIMEVAL)* timeout, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsacreateevent))], [])
@DllImport("WS2_32.dll")
WSAEVENT WSACreateEvent();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSADuplicateSocketW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaduplicatesocketa))], [])
@DllImport("WS2_32.dll")
int WSADuplicateSocketA(SOCKET s, uint dwProcessId, WSAPROTOCOL_INFOA* lpProtocolInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaduplicatesocketw))], [])
@DllImport("WS2_32.dll")
int WSADuplicateSocketW(SOCKET s, uint dwProcessId, WSAPROTOCOL_INFOW* lpProtocolInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaenumnetworkevents))], [])
@DllImport("WS2_32.dll")
int WSAEnumNetworkEvents(SOCKET s, WSAEVENT hEventObject, WSANETWORKEVENTS* lpNetworkEvents);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAEnumProtocolsW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaenumprotocolsa))], [])
@DllImport("WS2_32.dll")
int WSAEnumProtocolsA(int* lpiProtocols, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOA* lpProtocolBuffer, 
                      uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaenumprotocolsw))], [])
@DllImport("WS2_32.dll")
int WSAEnumProtocolsW(int* lpiProtocols, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOW* lpProtocolBuffer, 
                      uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaeventselect))], [])
@DllImport("WS2_32.dll")
int WSAEventSelect(SOCKET s, WSAEVENT hEventObject, int lNetworkEvents);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsagetoverlappedresult))], [])
@DllImport("WS2_32.dll")
BOOL WSAGetOverlappedResult(SOCKET s, OVERLAPPED* lpOverlapped, uint* lpcbTransfer, BOOL fWait, uint* lpdwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsagetqosbyname))], [])
@DllImport("WS2_32.dll")
BOOL WSAGetQOSByName(SOCKET s, WSABUF* lpQOSName, QOS* lpQOS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsahtonl))], [])
@DllImport("WS2_32.dll")
int WSAHtonl(SOCKET s, uint hostlong, uint* lpnetlong);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsahtons))], [])
@DllImport("WS2_32.dll")
int WSAHtons(SOCKET s, ushort hostshort, ushort* lpnetshort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaioctl))], [])
@DllImport("WS2_32.dll")
int WSAIoctl(SOCKET s, uint dwIoControlCode, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpvInBuffer, 
             uint cbInBuffer, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpvOutBuffer, 
             uint cbOutBuffer, uint* lpcbBytesReturned, OVERLAPPED* lpOverlapped, 
             LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsajoinleaf))], [])
@DllImport("WS2_32.dll")
SOCKET WSAJoinLeaf(SOCKET s, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                   int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsantohl))], [])
@DllImport("WS2_32.dll")
int WSANtohl(SOCKET s, uint netlong, uint* lphostlong);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsantohs))], [])
@DllImport("WS2_32.dll")
int WSANtohs(SOCKET s, ushort netshort, ushort* lphostshort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsarecv))], [])
@DllImport("WS2_32.dll")
int WSARecv(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, 
            OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSARecv()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsarecvdisconnect))], [])
@DllImport("WS2_32.dll")
int WSARecvDisconnect(SOCKET s, WSABUF* lpInboundDisconnectData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsarecvfrom))], [])
@DllImport("WS2_32.dll")
int WSARecvFrom(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/SOCKADDR* lpFrom, 
                int* lpFromlen, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaresetevent))], [])
@DllImport("WS2_32.dll")
BOOL WSAResetEvent(WSAEVENT hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasend))], [])
@DllImport("WS2_32.dll")
int WSASend(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, 
            OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasendmsg))], [])
@DllImport("WS2_32.dll")
int WSASendMsg(SOCKET Handle, WSAMSG* lpMsg, uint dwFlags, uint* lpNumberOfBytesSent, OVERLAPPED* lpOverlapped, 
               LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSASend()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasenddisconnect))], [])
@DllImport("WS2_32.dll")
int WSASendDisconnect(SOCKET s, WSABUF* lpOutboundDisconnectData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasendto))], [])
@DllImport("WS2_32.dll")
int WSASendTo(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/const(SOCKADDR)* lpTo, 
              int iTolen, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasetevent))], [])
@DllImport("WS2_32.dll")
BOOL WSASetEvent(WSAEVENT hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSASocketW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasocketa))], [])
@DllImport("WS2_32.dll")
SOCKET WSASocketA(int af, int type, int protocol, WSAPROTOCOL_INFOA* lpProtocolInfo, uint g, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasocketw))], [])
@DllImport("WS2_32.dll")
SOCKET WSASocketW(int af, int type, int protocol, WSAPROTOCOL_INFOW* lpProtocolInfo, uint g, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsawaitformultipleevents))], [])
@DllImport("WS2_32.dll")
WAIT_EVENT WSAWaitForMultipleEvents(uint cEvents, const(HANDLE)* lphEvents, BOOL fWaitAll, uint dwTimeout, 
                                    BOOL fAlertable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAAddressToStringW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaaddresstostringa))], [])
@DllImport("WS2_32.dll")
int WSAAddressToStringA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SOCKADDR* lpsaAddress, 
                        uint dwAddressLength, WSAPROTOCOL_INFOA* lpProtocolInfo, PSTR lpszAddressString, 
                        uint* lpdwAddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaaddresstostringw))], [])
@DllImport("WS2_32.dll")
int WSAAddressToStringW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SOCKADDR* lpsaAddress, 
                        uint dwAddressLength, WSAPROTOCOL_INFOW* lpProtocolInfo, PWSTR lpszAddressString, 
                        uint* lpdwAddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAStringToAddressW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsastringtoaddressa))], [])
@DllImport("WS2_32.dll")
int WSAStringToAddressA(PSTR AddressString, int AddressFamily, WSAPROTOCOL_INFOA* lpProtocolInfo, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKADDR* lpAddress, 
                        int* lpAddressLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsastringtoaddressw))], [])
@DllImport("WS2_32.dll")
int WSAStringToAddressW(PWSTR AddressString, int AddressFamily, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKADDR* lpAddress, 
                        int* lpAddressLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSALookupServiceBeginW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsalookupservicebegina))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceBeginA(WSAQUERYSETA* lpqsRestrictions, uint dwControlFlags, HANDLE* lphLookup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsalookupservicebeginw))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceBeginW(WSAQUERYSETW* lpqsRestrictions, uint dwControlFlags, HANDLE* lphLookup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSALookupServiceNextW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsalookupservicenexta))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceNextA(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAQUERYSETA* lpqsResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsalookupservicenextw))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceNextW(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAQUERYSETW* lpqsResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsanspioctl))], [])
@DllImport("WS2_32.dll")
int WSANSPIoctl(HANDLE hLookup, uint dwControlCode, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpvInBuffer, 
                uint cbInBuffer, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpvOutBuffer, 
                uint cbOutBuffer, uint* lpcbBytesReturned, WSACOMPLETION* lpCompletion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsalookupserviceend))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceEnd(HANDLE hLookup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAInstallServiceClassW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsainstallserviceclassa))], [])
@DllImport("WS2_32.dll")
int WSAInstallServiceClassA(WSASERVICECLASSINFOA* lpServiceClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsainstallserviceclassw))], [])
@DllImport("WS2_32.dll")
int WSAInstallServiceClassW(WSASERVICECLASSINFOW* lpServiceClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaremoveserviceclass))], [])
@DllImport("WS2_32.dll")
int WSARemoveServiceClass(GUID* lpServiceClassId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAGetServiceClassInfoW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsagetserviceclassinfoa))], [])
@DllImport("WS2_32.dll")
int WSAGetServiceClassInfoA(GUID* lpProviderId, GUID* lpServiceClassId, uint* lpdwBufSize, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSASERVICECLASSINFOA* lpServiceClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsagetserviceclassinfow))], [])
@DllImport("WS2_32.dll")
int WSAGetServiceClassInfoW(GUID* lpProviderId, GUID* lpServiceClassId, uint* lpdwBufSize, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSASERVICECLASSINFOW* lpServiceClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAEnumNameSpaceProvidersW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaenumnamespaceprovidersa))], [])
@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersA(uint* lpdwBufferLength, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOA* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaenumnamespaceprovidersw))], [])
@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersW(uint* lpdwBufferLength, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOW* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAEnumNameSpaceProvidersW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaenumnamespaceprovidersexa))], [])
@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersExA(uint* lpdwBufferLength, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOEXA* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaenumnamespaceprovidersexw))], [])
@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersExW(uint* lpdwBufferLength, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOEXW* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSAGetServiceClassNameByClassIdW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsagetserviceclassnamebyclassida))], [])
@DllImport("WS2_32.dll")
int WSAGetServiceClassNameByClassIdA(GUID* lpServiceClassId, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR lpszServiceClassName, 
                                     uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsagetserviceclassnamebyclassidw))], [])
@DllImport("WS2_32.dll")
int WSAGetServiceClassNameByClassIdW(GUID* lpServiceClassId, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR lpszServiceClassName, 
                                     uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSASetServiceW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasetservicea))], [])
@DllImport("WS2_32.dll")
int WSASetServiceA(WSAQUERYSETA* lpqsRegInfo, WSAESETSERVICEOP essoperation, uint dwControlFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsasetservicew))], [])
@DllImport("WS2_32.dll")
int WSASetServiceW(WSAQUERYSETW* lpqsRegInfo, WSAESETSERVICEOP essoperation, uint dwControlFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsaproviderconfigchange))], [])
@DllImport("WS2_32.dll")
int WSAProviderConfigChange(HANDLE* lpNotificationHandle, OVERLAPPED* lpOverlapped, 
                            LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-wsapoll))], [])
@DllImport("WS2_32.dll")
int WSAPoll(WSAPOLLFD* fdArray, uint fds, int timeout);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-processsocketnotifications))], [])
@DllImport("WS2_32.dll")
uint ProcessSocketNotifications(HANDLE completionPort, uint registrationCount, 
                                SOCK_NOTIFY_REGISTRATION* registrationInfos, uint timeoutMs, uint completionCount, 
                                OVERLAPPED_ENTRY* completionPortEntries, uint* receivedEntryCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv4addresstostringa))], [])
@DllImport("ntdll.dll")
PSTR RtlIpv4AddressToStringA(const(IN_ADDR)* Addr, PSTR S);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv4addresstostringexa))], [])
@DllImport("ntdll.dll")
int RtlIpv4AddressToStringExA(const(IN_ADDR)* Address, ushort Port, PSTR AddressString, uint* AddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv4addresstostringw))], [])
@DllImport("ntdll.dll")
PWSTR RtlIpv4AddressToStringW(const(IN_ADDR)* Addr, PWSTR S);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv4addresstostringexw))], [])
@DllImport("ntdll.dll")
int RtlIpv4AddressToStringExW(const(IN_ADDR)* Address, ushort Port, PWSTR AddressString, uint* AddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv4stringtoaddressa))], [])
@DllImport("ntdll.dll")
int RtlIpv4StringToAddressA(const(PSTR) S, BOOLEAN Strict, const(PSTR)* Terminator, IN_ADDR* Addr);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv4stringtoaddressexa))], [])
@DllImport("ntdll.dll")
int RtlIpv4StringToAddressExA(const(PSTR) AddressString, BOOLEAN Strict, IN_ADDR* Address, ushort* Port);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv4stringtoaddressw))], [])
@DllImport("ntdll.dll")
int RtlIpv4StringToAddressW(const(PWSTR) S, BOOLEAN Strict, const(PWSTR)* Terminator, IN_ADDR* Addr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv4stringtoaddressexw))], [])
@DllImport("ntdll.dll")
int RtlIpv4StringToAddressExW(const(PWSTR) AddressString, BOOLEAN Strict, IN_ADDR* Address, ushort* Port);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv6addresstostringa))], [])
@DllImport("ntdll.dll")
PSTR RtlIpv6AddressToStringA(const(IN6_ADDR)* Addr, PSTR S);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv6addresstostringexa))], [])
@DllImport("ntdll.dll")
int RtlIpv6AddressToStringExA(const(IN6_ADDR)* Address, uint ScopeId, ushort Port, PSTR AddressString, 
                              uint* AddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv6addresstostringw))], [])
@DllImport("ntdll.dll")
PWSTR RtlIpv6AddressToStringW(const(IN6_ADDR)* Addr, PWSTR S);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv6addresstostringexw))], [])
@DllImport("ntdll.dll")
int RtlIpv6AddressToStringExW(const(IN6_ADDR)* Address, uint ScopeId, ushort Port, PWSTR AddressString, 
                              uint* AddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv6stringtoaddressa))], [])
@DllImport("ntdll.dll")
int RtlIpv6StringToAddressA(const(PSTR) S, const(PSTR)* Terminator, IN6_ADDR* Addr);

//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv6stringtoaddressexa))], [])
@DllImport("ntdll.dll")
int RtlIpv6StringToAddressExA(const(PSTR) AddressString, IN6_ADDR* Address, uint* ScopeId, ushort* Port);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv6stringtoaddressw))], [])
@DllImport("ntdll.dll")
int RtlIpv6StringToAddressW(const(PWSTR) S, const(PWSTR)* Terminator, IN6_ADDR* Addr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlipv6stringtoaddressexw))], [])
@DllImport("ntdll.dll")
int RtlIpv6StringToAddressExW(const(PWSTR) AddressString, IN6_ADDR* Address, uint* ScopeId, ushort* Port);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlethernetaddresstostringa))], [])
@DllImport("ntdll.dll")
PSTR RtlEthernetAddressToStringA(const(DL_EUI48)* Addr, PSTR S);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlethernetaddresstostringw))], [])
@DllImport("ntdll.dll")
PWSTR RtlEthernetAddressToStringW(const(DL_EUI48)* Addr, PWSTR S);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlethernetstringtoaddressa))], [])
@DllImport("ntdll.dll")
int RtlEthernetStringToAddressA(const(PSTR) S, const(PSTR)* Terminator, DL_EUI48* Addr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ip2string/nf-ip2string-rtlethernetstringtoaddressw))], [])
@DllImport("ntdll.dll")
int RtlEthernetStringToAddressW(const(PWSTR) S, const(PWSTR)* Terminator, DL_EUI48* Addr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(WSARecv()))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsock/nf-mswsock-wsarecvex))], [])
@DllImport("MSWSOCK.dll")
int WSARecvEx(SOCKET s, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR buf, 
              int len, int* flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsock/nf-mswsock-transmitfile))], [])
@DllImport("MSWSOCK.dll")
BOOL TransmitFile(SOCKET hSocket, HANDLE hFile, uint nNumberOfBytesToWrite, uint nNumberOfBytesPerSend, 
                  OVERLAPPED* lpOverlapped, TRANSMIT_FILE_BUFFERS* lpTransmitBuffers, uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsock/nf-mswsock-acceptex))], [])
@DllImport("MSWSOCK.dll")
BOOL AcceptEx(SOCKET sListenSocket, SOCKET sAcceptSocket, void* lpOutputBuffer, uint dwReceiveDataLength, 
              uint dwLocalAddressLength, uint dwRemoteAddressLength, uint* lpdwBytesReceived, 
              OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/mswsock/nf-mswsock-getacceptexsockaddrs))], [])
@DllImport("MSWSOCK.dll")
void GetAcceptExSockaddrs(void* lpOutputBuffer, uint dwReceiveDataLength, uint dwLocalAddressLength, 
                          uint dwRemoteAddressLength, SOCKADDR** LocalSockaddr, int* LocalSockaddrLength, 
                          SOCKADDR** RemoteSockaddr, int* RemoteSockaddrLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscenumprotocols))], [])
@DllImport("WS2_32.dll")
int WSCEnumProtocols(int* lpiProtocols, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOW* lpProtocolBuffer, 
                     uint* lpdwBufferLength, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscdeinstallprovider))], [])
@DllImport("WS2_32.dll")
int WSCDeinstallProvider(GUID* lpProviderId, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscinstallprovider))], [])
@DllImport("WS2_32.dll")
int WSCInstallProvider(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                       const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscgetproviderpath))], [])
@DllImport("WS2_32.dll")
int WSCGetProviderPath(GUID* lpProviderId, PWSTR lpszProviderDllPath, int* lpProviderDllPathLen, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscupdateprovider))], [])
@DllImport("WS2_32.dll")
int WSCUpdateProvider(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                      const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscsetproviderinfo))], [])
@DllImport("WS2_32.dll")
int WSCSetProviderInfo(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* Info, 
                       size_t InfoSize, uint Flags, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscgetproviderinfo))], [])
@DllImport("WS2_32.dll")
int WSCGetProviderInfo(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* Info, 
                       size_t* InfoSize, uint Flags, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscsetapplicationcategory))], [])
@DllImport("WS2_32.dll")
int WSCSetApplicationCategory(const(PWSTR) Path, uint PathLength, const(PWSTR) Extra, uint ExtraLength, 
                              uint PermittedLspCategories, uint* pPrevPermLspCat, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscgetapplicationcategory))], [])
@DllImport("WS2_32.dll")
int WSCGetApplicationCategory(const(PWSTR) Path, uint PathLength, const(PWSTR) Extra, uint ExtraLength, 
                              uint* pPermittedLspCategories, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wpucompleteoverlappedrequest))], [])
@DllImport("WS2_32.dll")
int WPUCompleteOverlappedRequest(SOCKET s, OVERLAPPED* lpOverlapped, uint dwError, uint cbTransferred, 
                                 int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscinstallnamespace))], [])
@DllImport("WS2_32.dll")
int WSCInstallNameSpace(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, uint dwVersion, 
                        GUID* lpProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscuninstallnamespace))], [])
@DllImport("WS2_32.dll")
int WSCUnInstallNameSpace(GUID* lpProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscinstallnamespaceex))], [])
@DllImport("WS2_32.dll")
int WSCInstallNameSpaceEx(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, uint dwVersion, 
                          GUID* lpProviderId, BLOB* lpProviderSpecific);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wscenablensprovider))], [])
@DllImport("WS2_32.dll")
int WSCEnableNSProvider(GUID* lpProviderId, BOOL fEnable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wsaadvertiseprovider))], [])
@DllImport("WS2_32.dll")
int WSAAdvertiseProvider(const(GUID)* puuidProviderId, const(NSPV2_ROUTINE)* pNSPv2Routine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wsaunadvertiseprovider))], [])
@DllImport("WS2_32.dll")
int WSAUnadvertiseProvider(const(GUID)* puuidProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2spi/nf-ws2spi-wsaprovidercompleteasynccall))], [])
@DllImport("WS2_32.dll")
int WSAProviderCompleteAsyncCall(HANDLE hAsyncCall, int iRetCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-enumprotocolsa))], [])
@DllImport("MSWSOCK.dll")
int EnumProtocolsA(int* lpiProtocols, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpProtocolBuffer, 
                   uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-enumprotocolsw))], [])
@DllImport("MSWSOCK.dll")
int EnumProtocolsW(int* lpiProtocols, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpProtocolBuffer, 
                   uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-getaddressbynamea))], [])
@DllImport("MSWSOCK.dll")
int GetAddressByNameA(uint dwNameSpace, GUID* lpServiceType, PSTR lpServiceName, int* lpiProtocols, 
                      uint dwResolution, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpCsaddrBuffer, 
                      uint* lpdwBufferLength, PSTR lpAliasBuffer, uint* lpdwAliasBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-getaddressbynamew))], [])
@DllImport("MSWSOCK.dll")
int GetAddressByNameW(uint dwNameSpace, GUID* lpServiceType, PWSTR lpServiceName, int* lpiProtocols, 
                      uint dwResolution, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpCsaddrBuffer, 
                      uint* lpdwBufferLength, PWSTR lpAliasBuffer, uint* lpdwAliasBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-gettypebynamea))], [])
@DllImport("MSWSOCK.dll")
int GetTypeByNameA(PSTR lpServiceName, GUID* lpServiceType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-gettypebynamew))], [])
@DllImport("MSWSOCK.dll")
int GetTypeByNameW(PWSTR lpServiceName, GUID* lpServiceType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-getnamebytypea))], [])
@DllImport("MSWSOCK.dll")
int GetNameByTypeA(GUID* lpServiceType, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR lpServiceName, 
                   uint dwNameLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-getnamebytypew))], [])
@DllImport("MSWSOCK.dll")
int GetNameByTypeW(GUID* lpServiceType, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR lpServiceName, 
                   uint dwNameLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-setservicea))], [])
@DllImport("MSWSOCK.dll")
int SetServiceA(uint dwNameSpace, SET_SERVICE_OPERATION dwOperation, uint dwFlags, SERVICE_INFOA* lpServiceInfo, 
                SERVICE_ASYNC_INFO* lpServiceAsyncInfo, uint* lpdwStatusFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-setservicew))], [])
@DllImport("MSWSOCK.dll")
int SetServiceW(uint dwNameSpace, SET_SERVICE_OPERATION dwOperation, uint dwFlags, SERVICE_INFOW* lpServiceInfo, 
                SERVICE_ASYNC_INFO* lpServiceAsyncInfo, uint* lpdwStatusFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-getservicea))], [])
@DllImport("MSWSOCK.dll")
int GetServiceA(uint dwNameSpace, GUID* lpGuid, PSTR lpServiceName, uint dwProperties, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpBuffer, 
                uint* lpdwBufferSize, SERVICE_ASYNC_INFO* lpServiceAsyncInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/nspapi/nf-nspapi-getservicew))], [])
@DllImport("MSWSOCK.dll")
int GetServiceW(uint dwNameSpace, GUID* lpGuid, PWSTR lpServiceName, uint dwProperties, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpBuffer, 
                uint* lpdwBufferSize, SERVICE_ASYNC_INFO* lpServiceAsyncInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-getaddrinfo))], [])
@DllImport("WS2_32.dll")
int getaddrinfo(const(PSTR) pNodeName, const(PSTR) pServiceName, const(ADDRINFOA)* pHints, ADDRINFOA** ppResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-getaddrinfow))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoW(const(PWSTR) pNodeName, const(PWSTR) pServiceName, const(ADDRINFOW)* pHints, ADDRINFOW** ppResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(GetAddrInfoExW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-getaddrinfoexa))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoExA(const(PSTR) pName, const(PSTR) pServiceName, uint dwNameSpace, GUID* lpNspId, 
                   const(ADDRINFOEXA)* hints, ADDRINFOEXA** ppResult, TIMEVAL* timeout, OVERLAPPED* lpOverlapped, 
                   LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, HANDLE* lpNameHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-getaddrinfoexw))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoExW(const(PWSTR) pName, const(PWSTR) pServiceName, uint dwNameSpace, GUID* lpNspId, 
                   const(ADDRINFOEXW)* hints, ADDRINFOEXW** ppResult, TIMEVAL* timeout, OVERLAPPED* lpOverlapped, 
                   LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, HANDLE* lpHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-getaddrinfoexcancel))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoExCancel(HANDLE* lpHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-getaddrinfoexoverlappedresult))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoExOverlappedResult(OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(SetAddrInfoExW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-setaddrinfoexa))], [])
@DllImport("WS2_32.dll")
int SetAddrInfoExA(const(PSTR) pName, const(PSTR) pServiceName, SOCKET_ADDRESS* pAddresses, uint dwAddressCount, 
                   BLOB* lpBlob, uint dwFlags, uint dwNameSpace, GUID* lpNspId, TIMEVAL* timeout, 
                   OVERLAPPED* lpOverlapped, LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, 
                   HANDLE* lpNameHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-setaddrinfoexw))], [])
@DllImport("WS2_32.dll")
int SetAddrInfoExW(const(PWSTR) pName, const(PWSTR) pServiceName, SOCKET_ADDRESS* pAddresses, uint dwAddressCount, 
                   BLOB* lpBlob, uint dwFlags, uint dwNameSpace, GUID* lpNspId, TIMEVAL* timeout, 
                   OVERLAPPED* lpOverlapped, LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, 
                   HANDLE* lpNameHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-freeaddrinfo))], [])
@DllImport("WS2_32.dll")
void freeaddrinfo(ADDRINFOA* pAddrInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-freeaddrinfow))], [])
@DllImport("WS2_32.dll")
void FreeAddrInfoW(ADDRINFOW* pAddrInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: ObsoleteAttribute : CustomAttributeSig([FixedArgSig(ElementSig(FreeAddrInfoExW()))], [])
//METH ATTR: AnsiAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-freeaddrinfoex))], [])
@DllImport("WS2_32.dll")
void FreeAddrInfoEx(ADDRINFOEXA* pAddrInfoEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: UnicodeAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-freeaddrinfoexw))], [])
@DllImport("WS2_32.dll")
void FreeAddrInfoExW(ADDRINFOEXW* pAddrInfoEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-getnameinfo))], [])
@DllImport("WS2_32.dll")
int getnameinfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(SOCKADDR)* pSockaddr, 
                socklen_t SockaddrLength, 
                /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pNodeBuffer, 
                uint NodeBufferSize, 
                /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pServiceBuffer, 
                uint ServiceBufferSize, int Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-getnameinfow))], [])
@DllImport("WS2_32.dll")
int GetNameInfoW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(SOCKADDR)* pSockaddr, 
                 socklen_t SockaddrLength, 
                 /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pNodeBuffer, 
                 uint NodeBufferSize, 
                 /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pServiceBuffer, 
                 uint ServiceBufferSize, int Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-inet_pton))], [])
@DllImport("WS2_32.dll")
int inet_pton(int Family, const(PSTR) pszAddrString, void* pAddrBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-inetptonw))], [])
@DllImport("WS2_32.dll")
int InetPtonW(int Family, const(PWSTR) pszAddrString, void* pAddrBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-inet_ntop))], [])
@DllImport("WS2_32.dll")
PSTR inet_ntop(int Family, const(void)* pAddr, PSTR pStringBuf, size_t StringBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-inetntopw))], [])
@DllImport("WS2_32.dll")
PWSTR InetNtopW(int Family, const(void)* pAddr, PWSTR pStringBuf, size_t StringBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-wsasetsocketsecurity))], [])
@DllImport("fwpuclnt.dll")
int WSASetSocketSecurity(SOCKET Socket, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKET_SECURITY_SETTINGS)* SecuritySettings, 
                         uint SecuritySettingsLen, OVERLAPPED* Overlapped, 
                         LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-wsaquerysocketsecurity))], [])
@DllImport("fwpuclnt.dll")
int WSAQuerySocketSecurity(SOCKET Socket, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKET_SECURITY_QUERY_TEMPLATE)* SecurityQueryTemplate, 
                           uint SecurityQueryTemplateLen, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKET_SECURITY_QUERY_INFO* SecurityQueryInfo, 
                           uint* SecurityQueryInfoLen, OVERLAPPED* Overlapped, 
                           LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-wsasetsocketpeertargetname))], [])
@DllImport("fwpuclnt.dll")
int WSASetSocketPeerTargetName(SOCKET Socket, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKET_PEER_TARGET_NAME)* PeerTargetName, 
                               uint PeerTargetNameLen, OVERLAPPED* Overlapped, 
                               LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-wsadeletesocketpeertargetname))], [])
@DllImport("fwpuclnt.dll")
int WSADeleteSocketPeerTargetName(SOCKET Socket, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* PeerAddr, 
                                  uint PeerAddrLen, OVERLAPPED* Overlapped, 
                                  LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-wsaimpersonatesocketpeer))], [])
@DllImport("fwpuclnt.dll")
int WSAImpersonateSocketPeer(SOCKET Socket, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* PeerAddr, 
                             uint PeerAddrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ws2tcpip/nf-ws2tcpip-wsarevertimpersonation))], [])
@DllImport("fwpuclnt.dll")
int WSARevertImpersonation();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/socketapi/nf-socketapi-setsocketmediastreamingmode))], [])
@DllImport("Windows.Networking.dll")
HRESULT SetSocketMediaStreamingMode(BOOL value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sporder/nf-sporder-wscwriteproviderorder))], [])
@DllImport("WS2_32.dll")
int WSCWriteProviderOrder(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/sporder/nf-sporder-wscwritenamespaceorder))], [])
@DllImport("WS2_32.dll")
int WSCWriteNameSpaceOrder(GUID* lpProviderId, uint dwNumberOfEntries);


