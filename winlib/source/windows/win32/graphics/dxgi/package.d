// Written in the D programming language.

module windows.win32.graphics.dxgi;

public import windows.core;
public import windows.win32.graphics.dxgi.common;
public import windows.win32.foundation : BOOL, HANDLE, HMODULE, HRESULT, HWND, LUID, POINT, PSTR, PWSTR, RECT;
public import windows.win32.graphics.dxgi.common : DXGI_ALPHA_MODE, DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT,
                                                   DXGI_GAMMA_CONTROL, DXGI_GAMMA_CONTROL_CAPABILITIES,
                                                   DXGI_MODE_DESC, DXGI_MODE_ROTATION, DXGI_MODE_SCALING,
                                                   DXGI_MODE_SCANLINE_ORDER, DXGI_RATIONAL, DXGI_SAMPLE_DESC;
public import windows.win32.graphics.gdi : HDC, HMONITOR;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/direct3ddxgi/dxgi-usage))], [])

alias DXGI_USAGE = uint;
enum : uint
{
    DXGI_USAGE_SHADER_INPUT         = 0x00000010,
    DXGI_USAGE_RENDER_TARGET_OUTPUT = 0x00000020,
    DXGI_USAGE_BACK_BUFFER          = 0x00000040,
    DXGI_USAGE_SHARED               = 0x00000080,
    DXGI_USAGE_READ_ONLY            = 0x00000100,
    DXGI_USAGE_DISCARD_ON_PRESENT   = 0x00000200,
    DXGI_USAGE_UNORDERED_ACCESS     = 0x00000400,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/direct3ddxgi/dxgi-present))], [])

alias DXGI_PRESENT = uint;
enum : uint
{
    DXGI_PRESENT_TEST                  = 0x00000001,
    DXGI_PRESENT_DO_NOT_SEQUENCE       = 0x00000002,
    DXGI_PRESENT_RESTART               = 0x00000004,
    DXGI_PRESENT_DO_NOT_WAIT           = 0x00000008,
    DXGI_PRESENT_STEREO_PREFER_RIGHT   = 0x00000010,
    DXGI_PRESENT_STEREO_TEMPORARY_MONO = 0x00000020,
    DXGI_PRESENT_RESTRICT_TO_OUTPUT    = 0x00000040,
    DXGI_PRESENT_USE_DURATION          = 0x00000100,
    DXGI_PRESENT_ALLOW_TEARING         = 0x00000200,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/direct3ddxgi/dxgi-enum-modes))], [])

alias DXGI_ENUM_MODES = uint;
enum : uint
{
    DXGI_ENUM_MODES_INTERLACED      = 0x00000001,
    DXGI_ENUM_MODES_SCALING         = 0x00000002,
    DXGI_ENUM_MODES_STEREO          = 0x00000004,
    DXGI_ENUM_MODES_DISABLED_STEREO = 0x00000008,
}

alias DXGI_MWA_FLAGS = uint;
enum : uint
{
    DXGI_MWA_NO_WINDOW_CHANGES = 0x00000001,
    DXGI_MWA_NO_ALT_ENTER      = 0x00000002,
    DXGI_MWA_NO_PRINT_SCREEN   = 0x00000004,
    DXGI_MWA_VALID             = 0x00000007,
}

alias DXGI_MAP_FLAGS = uint;
enum : uint
{
    DXGI_MAP_READ    = 0x00000001,
    DXGI_MAP_WRITE   = 0x00000002,
    DXGI_MAP_DISCARD = 0x00000004,
}

alias DXGI_RESOURCE_PRIORITY = uint;
enum : uint
{
    DXGI_RESOURCE_PRIORITY_MINIMUM = 0x28000000,
    DXGI_RESOURCE_PRIORITY_LOW     = 0x50000000,
    DXGI_RESOURCE_PRIORITY_NORMAL  = 0x78000000,
    DXGI_RESOURCE_PRIORITY_HIGH    = 0xa0000000,
    DXGI_RESOURCE_PRIORITY_MAXIMUM = 0xc8000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/direct3ddxgi/dxgi-shared-resource-rw))], [])

alias DXGI_SHARED_RESOURCE_RW = uint;
enum : uint
{
    DXGI_SHARED_RESOURCE_READ  = 0x80000000,
    DXGI_SHARED_RESOURCE_WRITE = 0x00000001,
}

alias DXGI_CREATE_FACTORY_FLAGS = uint;
enum : uint
{
    DXGI_CREATE_FACTORY_DEBUG = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ne-dxgi-dxgi_residency))], [])

alias DXGI_RESIDENCY = int;
enum : int
{
    DXGI_RESIDENCY_FULLY_RESIDENT            = 0x00000001,
    DXGI_RESIDENCY_RESIDENT_IN_SHARED_MEMORY = 0x00000002,
    DXGI_RESIDENCY_EVICTED_TO_DISK           = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ne-dxgi-dxgi_swap_effect))], [])

alias DXGI_SWAP_EFFECT = int;
enum : int
{
    DXGI_SWAP_EFFECT_DISCARD         = 0x00000000,
    DXGI_SWAP_EFFECT_SEQUENTIAL      = 0x00000001,
    DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL = 0x00000003,
    DXGI_SWAP_EFFECT_FLIP_DISCARD    = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ne-dxgi-dxgi_swap_chain_flag))], [])

alias DXGI_SWAP_CHAIN_FLAG = int;
enum : int
{
    DXGI_SWAP_CHAIN_FLAG_NONPREROTATED                          = 0x00000001,
    DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH                      = 0x00000002,
    DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE                         = 0x00000004,
    DXGI_SWAP_CHAIN_FLAG_RESTRICTED_CONTENT                     = 0x00000008,
    DXGI_SWAP_CHAIN_FLAG_RESTRICT_SHARED_RESOURCE_DRIVER        = 0x00000010,
    DXGI_SWAP_CHAIN_FLAG_DISPLAY_ONLY                           = 0x00000020,
    DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT          = 0x00000040,
    DXGI_SWAP_CHAIN_FLAG_FOREGROUND_LAYER                       = 0x00000080,
    DXGI_SWAP_CHAIN_FLAG_FULLSCREEN_VIDEO                       = 0x00000100,
    DXGI_SWAP_CHAIN_FLAG_YUV_VIDEO                              = 0x00000200,
    DXGI_SWAP_CHAIN_FLAG_HW_PROTECTED                           = 0x00000400,
    DXGI_SWAP_CHAIN_FLAG_ALLOW_TEARING                          = 0x00000800,
    DXGI_SWAP_CHAIN_FLAG_RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS = 0x00001000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ne-dxgi-dxgi_adapter_flag))], [])

alias DXGI_ADAPTER_FLAG = int;
enum : int
{
    DXGI_ADAPTER_FLAG_NONE     = 0x00000000,
    DXGI_ADAPTER_FLAG_REMOTE   = 0x00000001,
    DXGI_ADAPTER_FLAG_SOFTWARE = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ne-dxgi1_2-dxgi_outdupl_pointer_shape_type))], [])

alias DXGI_OUTDUPL_POINTER_SHAPE_TYPE = int;
enum : int
{
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MONOCHROME   = 0x00000001,
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_COLOR        = 0x00000002,
    DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MASKED_COLOR = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ne-dxgi1_2-dxgi_offer_resource_priority))], [])

alias DXGI_OFFER_RESOURCE_PRIORITY = int;
enum : int
{
    DXGI_OFFER_RESOURCE_PRIORITY_LOW    = 0x00000001,
    DXGI_OFFER_RESOURCE_PRIORITY_NORMAL = 0x00000002,
    DXGI_OFFER_RESOURCE_PRIORITY_HIGH   = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ne-dxgi1_2-dxgi_scaling))], [])

alias DXGI_SCALING = int;
enum : int
{
    DXGI_SCALING_STRETCH              = 0x00000000,
    DXGI_SCALING_NONE                 = 0x00000001,
    DXGI_SCALING_ASPECT_RATIO_STRETCH = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ne-dxgi1_2-dxgi_graphics_preemption_granularity))], [])

alias DXGI_GRAPHICS_PREEMPTION_GRANULARITY = int;
enum : int
{
    DXGI_GRAPHICS_PREEMPTION_DMA_BUFFER_BOUNDARY  = 0x00000000,
    DXGI_GRAPHICS_PREEMPTION_PRIMITIVE_BOUNDARY   = 0x00000001,
    DXGI_GRAPHICS_PREEMPTION_TRIANGLE_BOUNDARY    = 0x00000002,
    DXGI_GRAPHICS_PREEMPTION_PIXEL_BOUNDARY       = 0x00000003,
    DXGI_GRAPHICS_PREEMPTION_INSTRUCTION_BOUNDARY = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ne-dxgi1_2-dxgi_compute_preemption_granularity))], [])

alias DXGI_COMPUTE_PREEMPTION_GRANULARITY = int;
enum : int
{
    DXGI_COMPUTE_PREEMPTION_DMA_BUFFER_BOUNDARY   = 0x00000000,
    DXGI_COMPUTE_PREEMPTION_DISPATCH_BOUNDARY     = 0x00000001,
    DXGI_COMPUTE_PREEMPTION_THREAD_GROUP_BOUNDARY = 0x00000002,
    DXGI_COMPUTE_PREEMPTION_THREAD_BOUNDARY       = 0x00000003,
    DXGI_COMPUTE_PREEMPTION_INSTRUCTION_BOUNDARY  = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/ne-dxgi1_3-dxgi_multiplane_overlay_ycbcr_flags))], [])

alias DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS = int;
enum : int
{
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_NOMINAL_RANGE = 0x00000001,
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_BT709         = 0x00000002,
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_xvYCC         = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/ne-dxgi1_3-dxgi_frame_presentation_mode))], [])

alias DXGI_FRAME_PRESENTATION_MODE = int;
enum : int
{
    DXGI_FRAME_PRESENTATION_MODE_COMPOSED            = 0x00000000,
    DXGI_FRAME_PRESENTATION_MODE_OVERLAY             = 0x00000001,
    DXGI_FRAME_PRESENTATION_MODE_NONE                = 0x00000002,
    DXGI_FRAME_PRESENTATION_MODE_COMPOSITION_FAILURE = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/ne-dxgi1_3-dxgi_overlay_support_flag))], [])

alias DXGI_OVERLAY_SUPPORT_FLAG = int;
enum : int
{
    DXGI_OVERLAY_SUPPORT_FLAG_DIRECT  = 0x00000001,
    DXGI_OVERLAY_SUPPORT_FLAG_SCALING = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/ne-dxgi1_4-dxgi_swap_chain_color_space_support_flag))], [])

alias DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG = int;
enum : int
{
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_PRESENT         = 0x00000001,
    DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_OVERLAY_PRESENT = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/ne-dxgi1_4-dxgi_overlay_color_space_support_flag))], [])

alias DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG = int;
enum : int
{
    DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG_PRESENT = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/ne-dxgi1_4-dxgi_memory_segment_group))], [])

alias DXGI_MEMORY_SEGMENT_GROUP = int;
enum : int
{
    DXGI_MEMORY_SEGMENT_GROUP_LOCAL     = 0x00000000,
    DXGI_MEMORY_SEGMENT_GROUP_NON_LOCAL = 0x00000001,
}

alias DXGI_OUTDUPL_FLAG = int;
enum : int
{
    DXGI_OUTDUPL_COMPOSITED_UI_CAPTURE_ONLY = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/ne-dxgi1_5-dxgi_hdr_metadata_type))], [])

alias DXGI_HDR_METADATA_TYPE = int;
enum : int
{
    DXGI_HDR_METADATA_TYPE_NONE      = 0x00000000,
    DXGI_HDR_METADATA_TYPE_HDR10     = 0x00000001,
    DXGI_HDR_METADATA_TYPE_HDR10PLUS = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/ne-dxgi1_5-dxgi_offer_resource_flags))], [])

alias DXGI_OFFER_RESOURCE_FLAGS = int;
enum : int
{
    DXGI_OFFER_RESOURCE_FLAG_ALLOW_DECOMMIT = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/ne-dxgi1_5-dxgi_reclaim_resource_results))], [])

alias DXGI_RECLAIM_RESOURCE_RESULTS = int;
enum : int
{
    DXGI_RECLAIM_RESOURCE_RESULT_OK            = 0x00000000,
    DXGI_RECLAIM_RESOURCE_RESULT_DISCARDED     = 0x00000001,
    DXGI_RECLAIM_RESOURCE_RESULT_NOT_COMMITTED = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/ne-dxgi1_5-dxgi_feature))], [])

alias DXGI_FEATURE = int;
enum : int
{
    DXGI_FEATURE_PRESENT_ALLOW_TEARING = 0x00000000,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/ne-dxgi1_6-dxgi_adapter_flag3))], [])

alias DXGI_ADAPTER_FLAG3 = int;
enum : int
{
    DXGI_ADAPTER_FLAG3_NONE                         = 0x00000000,
    DXGI_ADAPTER_FLAG3_REMOTE                       = 0x00000001,
    DXGI_ADAPTER_FLAG3_SOFTWARE                     = 0x00000002,
    DXGI_ADAPTER_FLAG3_ACG_COMPATIBLE               = 0x00000004,
    DXGI_ADAPTER_FLAG3_SUPPORT_MONITORED_FENCES     = 0x00000008,
    DXGI_ADAPTER_FLAG3_SUPPORT_NON_MONITORED_FENCES = 0x00000010,
    DXGI_ADAPTER_FLAG3_KEYED_MUTEX_CONFORMANCE      = 0x00000020,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/ne-dxgi1_6-dxgi_hardware_composition_support_flags))], [])

alias DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS = int;
enum : int
{
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_FULLSCREEN       = 0x00000001,
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_WINDOWED         = 0x00000002,
    DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_CURSOR_STRETCHED = 0x00000004,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/ne-dxgi1_6-dxgi_gpu_preference))], [])

alias DXGI_GPU_PREFERENCE = int;
enum : int
{
    DXGI_GPU_PREFERENCE_UNSPECIFIED      = 0x00000000,
    DXGI_GPU_PREFERENCE_MINIMUM_POWER    = 0x00000001,
    DXGI_GPU_PREFERENCE_HIGH_PERFORMANCE = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/ne-dxgidebug-dxgi_debug_rlo_flags))], [])

alias DXGI_DEBUG_RLO_FLAGS = int;
enum : int
{
    DXGI_DEBUG_RLO_SUMMARY         = 0x00000001,
    DXGI_DEBUG_RLO_DETAIL          = 0x00000002,
    DXGI_DEBUG_RLO_IGNORE_INTERNAL = 0x00000004,
    DXGI_DEBUG_RLO_ALL             = 0x00000007,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/ne-dxgidebug-dxgi_info_queue_message_category))], [])

alias DXGI_INFO_QUEUE_MESSAGE_CATEGORY = int;
enum : int
{
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_UNKNOWN               = 0x00000000,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_MISCELLANEOUS         = 0x00000001,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_INITIALIZATION        = 0x00000002,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_CLEANUP               = 0x00000003,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_COMPILATION           = 0x00000004,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_CREATION        = 0x00000005,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_SETTING         = 0x00000006,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_GETTING         = 0x00000007,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = 0x00000008,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_EXECUTION             = 0x00000009,
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY_SHADER                = 0x0000000a,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/ne-dxgidebug-dxgi_info_queue_message_severity))], [])

alias DXGI_INFO_QUEUE_MESSAGE_SEVERITY = int;
enum : int
{
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_CORRUPTION = 0x00000000,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_ERROR      = 0x00000001,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_WARNING    = 0x00000002,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_INFO       = 0x00000003,
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY_MESSAGE    = 0x00000004,
}

alias DXGI_Message_Id = int;
enum : int
{
    DXGI_MSG_IDXGISwapChain_CreationOrResizeBuffers_InvalidOutputWindow                                                 = 0x00000000,
    DXGI_MSG_IDXGISwapChain_CreationOrResizeBuffers_BufferWidthInferred                                                 = 0x00000001,
    DXGI_MSG_IDXGISwapChain_CreationOrResizeBuffers_BufferHeightInferred                                                = 0x00000002,
    DXGI_MSG_IDXGISwapChain_CreationOrResizeBuffers_NoScanoutFlagChanged                                                = 0x00000003,
    DXGI_MSG_IDXGISwapChain_Creation_MaxBufferCountExceeded                                                             = 0x00000004,
    DXGI_MSG_IDXGISwapChain_Creation_TooFewBuffers                                                                      = 0x00000005,
    DXGI_MSG_IDXGISwapChain_Creation_NoOutputWindow                                                                     = 0x00000006,
    DXGI_MSG_IDXGISwapChain_Destruction_OtherMethodsCalled                                                              = 0x00000007,
    DXGI_MSG_IDXGISwapChain_GetDesc_pDescIsNULL                                                                         = 0x00000008,
    DXGI_MSG_IDXGISwapChain_GetBuffer_ppSurfaceIsNULL                                                                   = 0x00000009,
    DXGI_MSG_IDXGISwapChain_GetBuffer_NoAllocatedBuffers                                                                = 0x0000000a,
    DXGI_MSG_IDXGISwapChain_GetBuffer_iBufferMustBeZero                                                                 = 0x0000000b,
    DXGI_MSG_IDXGISwapChain_GetBuffer_iBufferOOB                                                                        = 0x0000000c,
    DXGI_MSG_IDXGISwapChain_GetContainingOutput_ppOutputIsNULL                                                          = 0x0000000d,
    DXGI_MSG_IDXGISwapChain_Present_SyncIntervalOOB                                                                     = 0x0000000e,
    DXGI_MSG_IDXGISwapChain_Present_InvalidNonPreRotatedFlag                                                            = 0x0000000f,
    DXGI_MSG_IDXGISwapChain_Present_NoAllocatedBuffers                                                                  = 0x00000010,
    DXGI_MSG_IDXGISwapChain_Present_GetDXGIAdapterFailed                                                                = 0x00000011,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_BufferCountOOB                                                                = 0x00000012,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_UnreleasedReferences                                                          = 0x00000013,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidSwapChainFlag                                                          = 0x00000014,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidNonPreRotatedFlag                                                      = 0x00000015,
    DXGI_MSG_IDXGISwapChain_ResizeTarget_RefreshRateDivideByZero                                                        = 0x00000016,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_InvalidTarget                                                            = 0x00000017,
    DXGI_MSG_IDXGISwapChain_GetFrameStatistics_pStatsIsNULL                                                             = 0x00000018,
    DXGI_MSG_IDXGISwapChain_GetLastPresentCount_pLastPresentCountIsNULL                                                 = 0x00000019,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_RemoteNotSupported                                                       = 0x0000001a,
    DXGI_MSG_IDXGIOutput_TakeOwnership_FailedToAcquireFullscreenMutex                                                   = 0x0000001b,
    DXGI_MSG_IDXGIFactory_CreateSoftwareAdapter_ppAdapterInterfaceIsNULL                                                = 0x0000001c,
    DXGI_MSG_IDXGIFactory_EnumAdapters_ppAdapterInterfaceIsNULL                                                         = 0x0000001d,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_ppSwapChainIsNULL                                                             = 0x0000001e,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_pDescIsNULL                                                                   = 0x0000001f,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_UnknownSwapEffect                                                             = 0x00000020,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidFlags                                                                  = 0x00000021,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_NonPreRotatedFlagAndWindowed                                                  = 0x00000022,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_NullDeviceInterface                                                           = 0x00000023,
    DXGI_MSG_IDXGIFactory_GetWindowAssociation_phWndIsNULL                                                              = 0x00000024,
    DXGI_MSG_IDXGIFactory_MakeWindowAssociation_InvalidFlags                                                            = 0x00000025,
    DXGI_MSG_IDXGISurface_Map_InvalidSurface                                                                            = 0x00000026,
    DXGI_MSG_IDXGISurface_Map_FlagsSetToZero                                                                            = 0x00000027,
    DXGI_MSG_IDXGISurface_Map_DiscardAndReadFlagSet                                                                     = 0x00000028,
    DXGI_MSG_IDXGISurface_Map_DiscardButNotWriteFlagSet                                                                 = 0x00000029,
    DXGI_MSG_IDXGISurface_Map_NoCPUAccess                                                                               = 0x0000002a,
    DXGI_MSG_IDXGISurface_Map_ReadFlagSetButCPUAccessIsDynamic                                                          = 0x0000002b,
    DXGI_MSG_IDXGISurface_Map_DiscardFlagSetButCPUAccessIsNotDynamic                                                    = 0x0000002c,
    DXGI_MSG_IDXGIOutput_GetDisplayModeList_pNumModesIsNULL                                                             = 0x0000002d,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_ModeHasInvalidWidthOrHeight                                            = 0x0000002e,
    DXGI_MSG_IDXGIOutput_GetCammaControlCapabilities_NoOwnerDevice                                                      = 0x0000002f,
    DXGI_MSG_IDXGIOutput_TakeOwnership_pDeviceIsNULL                                                                    = 0x00000030,
    DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_NoOwnerDevice                                                            = 0x00000031,
    DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_pDestinationIsNULL                                                       = 0x00000032,
    DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_MapOfDestinationFailed                                                   = 0x00000033,
    DXGI_MSG_IDXGIOutput_GetFrameStatistics_NoOwnerDevice                                                               = 0x00000034,
    DXGI_MSG_IDXGIOutput_GetFrameStatistics_pStatsIsNULL                                                                = 0x00000035,
    DXGI_MSG_IDXGIOutput_SetGammaControl_NoOwnerDevice                                                                  = 0x00000036,
    DXGI_MSG_IDXGIOutput_GetGammaControl_NoOwnerDevice                                                                  = 0x00000037,
    DXGI_MSG_IDXGIOutput_GetGammaControl_NoGammaControls                                                                = 0x00000038,
    DXGI_MSG_IDXGIOutput_SetDisplaySurface_IDXGIResourceNotSupportedBypPrimary                                          = 0x00000039,
    DXGI_MSG_IDXGIOutput_SetDisplaySurface_pPrimaryIsInvalid                                                            = 0x0000003a,
    DXGI_MSG_IDXGIOutput_SetDisplaySurface_NoOwnerDevice                                                                = 0x0000003b,
    DXGI_MSG_IDXGIOutput_TakeOwnership_RemoteDeviceNotSupported                                                         = 0x0000003c,
    DXGI_MSG_IDXGIOutput_GetDisplayModeList_RemoteDeviceNotSupported                                                    = 0x0000003d,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_RemoteDeviceNotSupported                                               = 0x0000003e,
    DXGI_MSG_IDXGIDevice_CreateSurface_InvalidParametersWithpSharedResource                                             = 0x0000003f,
    DXGI_MSG_IDXGIObject_GetPrivateData_puiDataSizeIsNULL                                                               = 0x00000040,
    DXGI_MSG_IDXGISwapChain_Creation_InvalidOutputWindow                                                                = 0x00000041,
    DXGI_MSG_IDXGISwapChain_Release_SwapChainIsFullscreen                                                               = 0x00000042,
    DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_InvalidTargetSurfaceFormat                                               = 0x00000043,
    DXGI_MSG_IDXGIFactory_CreateSoftwareAdapter_ModuleIsNULL                                                            = 0x00000044,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_IDXGIDeviceNotSupportedBypConcernedDevice                              = 0x00000045,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_pModeToMatchOrpClosestMatchIsNULL                                      = 0x00000046,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_ModeHasRefreshRateDenominatorZero                                      = 0x00000047,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_UnknownFormatIsInvalidForConfiguration                                 = 0x00000048,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_InvalidDisplayModeScanlineOrdering                                     = 0x00000049,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_InvalidDisplayModeScaling                                              = 0x0000004a,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_InvalidDisplayModeFormatAndDeviceCombination                           = 0x0000004b,
    DXGI_MSG_IDXGIFactory_Creation_CalledFromDllMain                                                                    = 0x0000004c,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_OutputNotOwnedBySwapChainDevice                                          = 0x0000004d,
    DXGI_MSG_IDXGISwapChain_Creation_InvalidWindowStyle                                                                 = 0x0000004e,
    DXGI_MSG_IDXGISwapChain_GetFrameStatistics_UnsupportedStatistics                                                    = 0x0000004f,
    DXGI_MSG_IDXGISwapChain_GetContainingOutput_SwapchainAdapterDoesNotControlOutput                                    = 0x00000050,
    DXGI_MSG_IDXGIOutput_SetOrGetGammaControl_pArrayIsNULL                                                              = 0x00000051,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_FullscreenInvalidForChildWindows                                         = 0x00000052,
    DXGI_MSG_IDXGIFactory_Release_CalledFromDllMain                                                                     = 0x00000053,
    DXGI_MSG_IDXGISwapChain_Present_UnreleasedHDC                                                                       = 0x00000054,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_NonPreRotatedAndGDICompatibleFlags                                            = 0x00000055,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_NonPreRotatedAndGDICompatibleFlags                                            = 0x00000056,
    DXGI_MSG_IDXGISurface1_GetDC_pHdcIsNULL                                                                             = 0x00000057,
    DXGI_MSG_IDXGISurface1_GetDC_SurfaceNotTexture2D                                                                    = 0x00000058,
    DXGI_MSG_IDXGISurface1_GetDC_GDICompatibleFlagNotSet                                                                = 0x00000059,
    DXGI_MSG_IDXGISurface1_GetDC_UnreleasedHDC                                                                          = 0x0000005a,
    DXGI_MSG_IDXGISurface_Map_NoCPUAccess2                                                                              = 0x0000005b,
    DXGI_MSG_IDXGISurface1_ReleaseDC_GetDCNotCalled                                                                     = 0x0000005c,
    DXGI_MSG_IDXGISurface1_ReleaseDC_InvalidRectangleDimensions                                                         = 0x0000005d,
    DXGI_MSG_IDXGIOutput_TakeOwnership_RemoteOutputNotSupported                                                         = 0x0000005e,
    DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_RemoteOutputNotSupported                                               = 0x0000005f,
    DXGI_MSG_IDXGIOutput_GetDisplayModeList_RemoteOutputNotSupported                                                    = 0x00000060,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_pDeviceHasMismatchedDXGIFactory                                               = 0x00000061,
    DXGI_MSG_IDXGISwapChain_Present_NonOptimalFSConfiguration                                                           = 0x00000062,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_FlipSequentialNotSupportedOnD3D10                                             = 0x00000063,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_BufferCountOOBForFlipSequential                                               = 0x00000064,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidFormatForFlipSequential                                                = 0x00000065,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_MultiSamplingNotSupportedForFlipSequential                                    = 0x00000066,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_BufferCountOOBForFlipSequential                                               = 0x00000067,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidFormatForFlipSequential                                                = 0x00000068,
    DXGI_MSG_IDXGISwapChain_Present_PartialPresentationBeforeStandardPresentation                                       = 0x00000069,
    DXGI_MSG_IDXGISwapChain_Present_FullscreenPartialPresentIsInvalid                                                   = 0x0000006a,
    DXGI_MSG_IDXGISwapChain_Present_InvalidPresentTestOrDoNotSequenceFlag                                               = 0x0000006b,
    DXGI_MSG_IDXGISwapChain_Present_ScrollInfoWithNoDirtyRectsSpecified                                                 = 0x0000006c,
    DXGI_MSG_IDXGISwapChain_Present_EmptyScrollRect                                                                     = 0x0000006d,
    DXGI_MSG_IDXGISwapChain_Present_ScrollRectOutOfBackbufferBounds                                                     = 0x0000006e,
    DXGI_MSG_IDXGISwapChain_Present_ScrollRectOutOfBackbufferBoundsWithOffset                                           = 0x0000006f,
    DXGI_MSG_IDXGISwapChain_Present_EmptyDirtyRect                                                                      = 0x00000070,
    DXGI_MSG_IDXGISwapChain_Present_DirtyRectOutOfBackbufferBounds                                                      = 0x00000071,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_UnsupportedBufferUsageFlags                                                   = 0x00000072,
    DXGI_MSG_IDXGISwapChain_Present_DoNotSequenceFlagSetButPreviousBufferIsUndefined                                    = 0x00000073,
    DXGI_MSG_IDXGISwapChain_Present_UnsupportedFlags                                                                    = 0x00000074,
    DXGI_MSG_IDXGISwapChain_Present_FlipModelChainMustResizeOrCreateOnFSTransition                                      = 0x00000075,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_pRestrictToOutputFromOtherIDXGIFactory                                        = 0x00000076,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_RestrictOutputNotSupportedOnAdapter                                           = 0x00000077,
    DXGI_MSG_IDXGISwapChain_Present_RestrictToOutputFlagSetButInvalidpRestrictToOutput                                  = 0x00000078,
    DXGI_MSG_IDXGISwapChain_Present_RestrictToOutputFlagdWithFullscreen                                                 = 0x00000079,
    DXGI_MSG_IDXGISwapChain_Present_RestrictOutputFlagWithStaleSwapChain                                                = 0x0000007a,
    DXGI_MSG_IDXGISwapChain_Present_OtherFlagsCausingInvalidPresentTestFlag                                             = 0x0000007b,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_UnavailableInSession0                                                         = 0x0000007c,
    DXGI_MSG_IDXGIFactory_MakeWindowAssociation_UnavailableInSession0                                                   = 0x0000007d,
    DXGI_MSG_IDXGIFactory_GetWindowAssociation_UnavailableInSession0                                                    = 0x0000007e,
    DXGI_MSG_IDXGIAdapter_EnumOutputs_UnavailableInSession0                                                             = 0x0000007f,
    DXGI_MSG_IDXGISwapChain_CreationOrSetFullscreenState_StereoDisabled                                                 = 0x00000080,
    DXGI_MSG_IDXGIFactory2_UnregisterStatus_CookieNotFound                                                              = 0x00000081,
    DXGI_MSG_IDXGISwapChain_Present_ProtectedContentInWindowedModeWithoutFSOrOverlay                                    = 0x00000082,
    DXGI_MSG_IDXGISwapChain_Present_ProtectedContentInWindowedModeWithoutFlipSequential                                 = 0x00000083,
    DXGI_MSG_IDXGISwapChain_Present_ProtectedContentWithRDPDriver                                                       = 0x00000084,
    DXGI_MSG_IDXGISwapChain_Present_ProtectedContentInWindowedModeWithDWMOffOrInvalidDisplayAffinity                    = 0x00000085,
    DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_WidthOrHeightIsZero                                             = 0x00000086,
    DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_OnlyFlipSequentialSupported                                     = 0x00000087,
    DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_UnsupportedOnAdapter                                            = 0x00000088,
    DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_UnsupportedOnWindows7                                           = 0x00000089,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_FSTransitionWithCompositionSwapChain                                     = 0x0000008a,
    DXGI_MSG_IDXGISwapChain_ResizeTarget_InvalidWithCompositionSwapChain                                                = 0x0000008b,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_WidthOrHeightIsZero                                                           = 0x0000008c,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_ScalingNoneIsFlipModelOnly                                                    = 0x0000008d,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_ScalingUnrecognized                                                           = 0x0000008e,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_DisplayOnlyFullscreenUnsupported                                              = 0x0000008f,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_DisplayOnlyUnsupported                                                        = 0x00000090,
    DXGI_MSG_IDXGISwapChain_Present_RestartIsFullscreenOnly                                                             = 0x00000091,
    DXGI_MSG_IDXGISwapChain_Present_ProtectedWindowlessPresentationRequiresDisplayOnly                                  = 0x00000092,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_DisplayOnlyUnsupported                                                   = 0x00000093,
    DXGI_MSG_IDXGISwapChain1_SetBackgroundColor_OutOfRange                                                              = 0x00000094,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_DisplayOnlyFullscreenUnsupported                                              = 0x00000095,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_DisplayOnlyUnsupported                                                        = 0x00000096,
    DXGI_MSG_IDXGISwapchain_Present_ScrollUnsupported                                                                   = 0x00000097,
    DXGI_MSG_IDXGISwapChain1_SetRotation_UnsupportedOS                                                                  = 0x00000098,
    DXGI_MSG_IDXGISwapChain1_GetRotation_UnsupportedOS                                                                  = 0x00000099,
    DXGI_MSG_IDXGISwapchain_Present_FullscreenRotation                                                                  = 0x0000009a,
    DXGI_MSG_IDXGISwapChain_Present_PartialPresentationWithMSAABuffers                                                  = 0x0000009b,
    DXGI_MSG_IDXGISwapChain1_SetRotation_FlipSequentialRequired                                                         = 0x0000009c,
    DXGI_MSG_IDXGISwapChain1_SetRotation_InvalidRotation                                                                = 0x0000009d,
    DXGI_MSG_IDXGISwapChain1_GetRotation_FlipSequentialRequired                                                         = 0x0000009e,
    DXGI_MSG_IDXGISwapChain_GetHwnd_WrongType                                                                           = 0x0000009f,
    DXGI_MSG_IDXGISwapChain_GetCompositionSurface_WrongType                                                             = 0x000000a0,
    DXGI_MSG_IDXGISwapChain_GetCoreWindow_WrongType                                                                     = 0x000000a1,
    DXGI_MSG_IDXGISwapChain_GetFullscreenDesc_NonHwnd                                                                   = 0x000000a2,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_CoreWindow                                                               = 0x000000a3,
    DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_UnsupportedOnWindows7                                           = 0x000000a4,
    DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_pWindowIsNULL                                                   = 0x000000a5,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_FSUnsupportedForModernApps                                                    = 0x000000a6,
    DXGI_MSG_IDXGIFactory_MakeWindowAssociation_ModernApp                                                               = 0x000000a7,
    DXGI_MSG_IDXGISwapChain_ResizeTarget_ModernApp                                                                      = 0x000000a8,
    DXGI_MSG_IDXGISwapChain_ResizeTarget_pNewTargetParametersIsNULL                                                     = 0x000000a9,
    DXGI_MSG_IDXGIOutput_SetDisplaySurface_ModernApp                                                                    = 0x000000aa,
    DXGI_MSG_IDXGIOutput_TakeOwnership_ModernApp                                                                        = 0x000000ab,
    DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_pWindowIsInvalid                                                = 0x000000ac,
    DXGI_MSG_IDXGIFactory2_CreateSwapChainForCompositionSurface_InvalidHandle                                           = 0x000000ad,
    DXGI_MSG_IDXGISurface1_GetDC_ModernApp                                                                              = 0x000000ae,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_ScalingNoneRequiresWindows8OrNewer                                            = 0x000000af,
    DXGI_MSG_IDXGISwapChain_Present_TemporaryMonoAndPreferRight                                                         = 0x000000b0,
    DXGI_MSG_IDXGISwapChain_Present_TemporaryMonoOrPreferRightWithDoNotSequence                                         = 0x000000b1,
    DXGI_MSG_IDXGISwapChain_Present_TemporaryMonoOrPreferRightWithoutStereo                                             = 0x000000b2,
    DXGI_MSG_IDXGISwapChain_Present_TemporaryMonoUnsupported                                                            = 0x000000b3,
    DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_ArraySizeMismatch                                                        = 0x000000b4,
    DXGI_MSG_IDXGISwapChain_Present_PartialPresentationWithSwapEffectDiscard                                            = 0x000000b5,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_AlphaUnrecognized                                                             = 0x000000b6,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_AlphaIsWindowlessOnly                                                         = 0x000000b7,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_AlphaIsFlipModelOnly                                                          = 0x000000b8,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_RestrictToOutputAdapterMismatch                                               = 0x000000b9,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_DisplayOnlyOnLegacy                                                           = 0x000000ba,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_DisplayOnlyOnLegacy                                                           = 0x000000bb,
    DXGI_MSG_IDXGIResource1_CreateSubresourceSurface_InvalidIndex                                                       = 0x000000bc,
    DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_InvalidScaling                                                  = 0x000000bd,
    DXGI_MSG_IDXGIFactory_CreateSwapChainForCoreWindow_InvalidSwapEffect                                                = 0x000000be,
    DXGI_MSG_IDXGIResource1_CreateSharedHandle_UnsupportedOS                                                            = 0x000000bf,
    DXGI_MSG_IDXGIFactory2_RegisterOcclusionStatusWindow_UnsupportedOS                                                  = 0x000000c0,
    DXGI_MSG_IDXGIFactory2_RegisterOcclusionStatusEvent_UnsupportedOS                                                   = 0x000000c1,
    DXGI_MSG_IDXGIOutput1_DuplicateOutput_UnsupportedOS                                                                 = 0x000000c2,
    DXGI_MSG_IDXGIDisplayControl_IsStereoEnabled_UnsupportedOS                                                          = 0x000000c3,
    DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_InvalidAlphaMode                                                = 0x000000c4,
    DXGI_MSG_IDXGIFactory_GetSharedResourceAdapterLuid_InvalidResource                                                  = 0x000000c5,
    DXGI_MSG_IDXGIFactory_GetSharedResourceAdapterLuid_InvalidLUID                                                      = 0x000000c6,
    DXGI_MSG_IDXGIFactory_GetSharedResourceAdapterLuid_UnsupportedOS                                                    = 0x000000c7,
    DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_2DOnly                                                                 = 0x000000c8,
    DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_StagingOnly                                                            = 0x000000c9,
    DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_NeedCPUAccessWrite                                                     = 0x000000ca,
    DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_NoShared                                                               = 0x000000cb,
    DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_OnlyMipLevels1                                                         = 0x000000cc,
    DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_MappedOrOfferedResource                                                = 0x000000cd,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_FSUnsupportedForModernApps                                               = 0x000000ce,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_FailedToGoFSButNonPreRotated                                                  = 0x000000cf,
    DXGI_MSG_IDXGIFactory_CreateSwapChainOrRegisterOcclusionStatus_BlitModelUsedWhileRegisteredForOcclusionStatusEvents = 0x000000d0,
    DXGI_MSG_IDXGISwapChain_Present_BlitModelUsedWhileRegisteredForOcclusionStatusEvents                                = 0x000000d1,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_WaitableSwapChainsAreFlipModelOnly                                            = 0x000000d2,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_WaitableSwapChainsAreNotFullscreen                                            = 0x000000d3,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_Waitable                                                                 = 0x000000d4,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_CannotAddOrRemoveWaitableFlag                                                 = 0x000000d5,
    DXGI_MSG_IDXGISwapChain_GetFrameLatencyWaitableObject_OnlyWaitable                                                  = 0x000000d6,
    DXGI_MSG_IDXGISwapChain_GetMaximumFrameLatency_OnlyWaitable                                                         = 0x000000d7,
    DXGI_MSG_IDXGISwapChain_GetMaximumFrameLatency_pMaxLatencyIsNULL                                                    = 0x000000d8,
    DXGI_MSG_IDXGISwapChain_SetMaximumFrameLatency_OnlyWaitable                                                         = 0x000000d9,
    DXGI_MSG_IDXGISwapChain_SetMaximumFrameLatency_MaxLatencyIsOutOfBounds                                              = 0x000000da,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_ForegroundIsCoreWindowOnly                                                    = 0x000000db,
    DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_ForegroundUnsupportedOnAdapter                                  = 0x000000dc,
    DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_InvalidScaling                                                  = 0x000000dd,
    DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_InvalidAlphaMode                                                = 0x000000de,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_CannotAddOrRemoveForegroundFlag                                               = 0x000000df,
    DXGI_MSG_IDXGISwapChain_SetMatrixTransform_MatrixPointerCannotBeNull                                                = 0x000000e0,
    DXGI_MSG_IDXGISwapChain_SetMatrixTransform_RequiresCompositionSwapChain                                             = 0x000000e1,
    DXGI_MSG_IDXGISwapChain_SetMatrixTransform_MatrixMustBeFinite                                                       = 0x000000e2,
    DXGI_MSG_IDXGISwapChain_SetMatrixTransform_MatrixMustBeTranslateAndOrScale                                          = 0x000000e3,
    DXGI_MSG_IDXGISwapChain_GetMatrixTransform_MatrixPointerCannotBeNull                                                = 0x000000e4,
    DXGI_MSG_IDXGISwapChain_GetMatrixTransform_RequiresCompositionSwapChain                                             = 0x000000e5,
    DXGI_MSG_DXGIGetDebugInterface1_NULL_ppDebug                                                                        = 0x000000e6,
    DXGI_MSG_DXGIGetDebugInterface1_InvalidFlags                                                                        = 0x000000e7,
    DXGI_MSG_IDXGISwapChain_Present_Decode                                                                              = 0x000000e8,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_Decode                                                                        = 0x000000e9,
    DXGI_MSG_IDXGISwapChain_SetSourceSize_FlipModel                                                                     = 0x000000ea,
    DXGI_MSG_IDXGISwapChain_SetSourceSize_Decode                                                                        = 0x000000eb,
    DXGI_MSG_IDXGISwapChain_SetSourceSize_WidthHeight                                                                   = 0x000000ec,
    DXGI_MSG_IDXGISwapChain_GetSourceSize_NullPointers                                                                  = 0x000000ed,
    DXGI_MSG_IDXGISwapChain_GetSourceSize_Decode                                                                        = 0x000000ee,
    DXGI_MSG_IDXGIDecodeSwapChain_SetColorSpace_InvalidFlags                                                            = 0x000000ef,
    DXGI_MSG_IDXGIDecodeSwapChain_SetSourceRect_InvalidRect                                                             = 0x000000f0,
    DXGI_MSG_IDXGIDecodeSwapChain_SetTargetRect_InvalidRect                                                             = 0x000000f1,
    DXGI_MSG_IDXGIDecodeSwapChain_SetDestSize_InvalidSize                                                               = 0x000000f2,
    DXGI_MSG_IDXGIDecodeSwapChain_GetSourceRect_InvalidPointer                                                          = 0x000000f3,
    DXGI_MSG_IDXGIDecodeSwapChain_GetTargetRect_InvalidPointer                                                          = 0x000000f4,
    DXGI_MSG_IDXGIDecodeSwapChain_GetDestSize_InvalidPointer                                                            = 0x000000f5,
    DXGI_MSG_IDXGISwapChain_PresentBuffer_YUV                                                                           = 0x000000f6,
    DXGI_MSG_IDXGISwapChain_SetSourceSize_YUV                                                                           = 0x000000f7,
    DXGI_MSG_IDXGISwapChain_GetSourceSize_YUV                                                                           = 0x000000f8,
    DXGI_MSG_IDXGISwapChain_SetMatrixTransform_YUV                                                                      = 0x000000f9,
    DXGI_MSG_IDXGISwapChain_GetMatrixTransform_YUV                                                                      = 0x000000fa,
    DXGI_MSG_IDXGISwapChain_Present_PartialPresentation_YUV                                                             = 0x000000fb,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_CannotAddOrRemoveFlag_YUV                                                     = 0x000000fc,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_Alignment_YUV                                                                 = 0x000000fd,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_ShaderInputUnsupported_YUV                                                    = 0x000000fe,
    DXGI_MSG_IDXGIOutput3_CheckOverlaySupport_NullPointers                                                              = 0x000000ff,
    DXGI_MSG_IDXGIOutput3_CheckOverlaySupport_IDXGIDeviceNotSupportedBypConcernedDevice                                 = 0x00000100,
    DXGI_MSG_IDXGIAdapter_EnumOutputs2_InvalidEnumOutputs2Flag                                                          = 0x00000101,
    DXGI_MSG_IDXGISwapChain_CreationOrSetFullscreenState_FSUnsupportedForFlipDiscard                                    = 0x00000102,
    DXGI_MSG_IDXGIOutput4_CheckOverlayColorSpaceSupport_NullPointers                                                    = 0x00000103,
    DXGI_MSG_IDXGIOutput4_CheckOverlayColorSpaceSupport_IDXGIDeviceNotSupportedBypConcernedDevice                       = 0x00000104,
    DXGI_MSG_IDXGISwapChain3_CheckColorSpaceSupport_NullPointers                                                        = 0x00000105,
    DXGI_MSG_IDXGISwapChain3_SetColorSpace1_InvalidColorSpace                                                           = 0x00000106,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidHwProtect                                                              = 0x00000107,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_HwProtectUnsupported                                                          = 0x00000108,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidHwProtect                                                              = 0x00000109,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_HwProtectUnsupported                                                          = 0x0000010a,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers1_D3D12Only                                                                    = 0x0000010b,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers1_FlipModel                                                                    = 0x0000010c,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers1_NodeMaskAndQueueRequired                                                     = 0x0000010d,
    DXGI_MSG_IDXGISwapChain_CreateSwapChain_InvalidHwProtectGdiFlag                                                     = 0x0000010e,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidHwProtectGdiFlag                                                       = 0x0000010f,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_10BitFormatNotSupported                                                       = 0x00000110,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_FlipSwapEffectRequired                                                        = 0x00000111,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidDevice                                                                 = 0x00000112,
    DXGI_MSG_IDXGIOutput_TakeOwnership_Unsupported                                                                      = 0x00000113,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidQueue                                                                  = 0x00000114,
    DXGI_MSG_IDXGISwapChain3_ResizeBuffers1_InvalidQueue                                                                = 0x00000115,
    DXGI_MSG_IDXGIFactory_CreateSwapChainForHwnd_InvalidScaling                                                         = 0x00000116,
    DXGI_MSG_IDXGISwapChain3_SetHDRMetaData_InvalidSize                                                                 = 0x00000117,
    DXGI_MSG_IDXGISwapChain3_SetHDRMetaData_InvalidPointer                                                              = 0x00000118,
    DXGI_MSG_IDXGISwapChain3_SetHDRMetaData_InvalidType                                                                 = 0x00000119,
    DXGI_MSG_IDXGISwapChain_Present_FullscreenAllowTearingIsInvalid                                                     = 0x0000011a,
    DXGI_MSG_IDXGISwapChain_Present_AllowTearingRequiresPresentIntervalZero                                             = 0x0000011b,
    DXGI_MSG_IDXGISwapChain_Present_AllowTearingRequiresCreationFlag                                                    = 0x0000011c,
    DXGI_MSG_IDXGISwapChain_ResizeBuffers_CannotAddOrRemoveAllowTearingFlag                                             = 0x0000011d,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_AllowTearingFlagIsFlipModelOnly                                               = 0x0000011e,
    DXGI_MSG_IDXGIFactory_CheckFeatureSupport_InvalidFeature                                                            = 0x0000011f,
    DXGI_MSG_IDXGIFactory_CheckFeatureSupport_InvalidSize                                                               = 0x00000120,
    DXGI_MSG_IDXGIOutput6_CheckHardwareCompositionSupport_NullPointer                                                   = 0x00000121,
    DXGI_MSG_IDXGISwapChain_SetFullscreenState_PerMonitorDpiShimApplied                                                 = 0x00000122,
    DXGI_MSG_IDXGIOutput_DuplicateOutput_PerMonitorDpiShimApplied                                                       = 0x00000123,
    DXGI_MSG_IDXGIOutput_DuplicateOutput1_PerMonitorDpiRequired                                                         = 0x00000124,
    DXGI_MSG_IDXGIFactory7_UnregisterAdaptersChangedEvent_CookieNotFound                                                = 0x00000125,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_LegacyBltModelSwapEffect                                                      = 0x00000126,
    DXGI_MSG_IDXGISwapChain4_SetHDRMetaData_MetadataUnchanged                                                           = 0x00000127,
    DXGI_MSG_IDXGISwapChain_Present_11On12_Released_Resource                                                            = 0x00000128,
    DXGI_MSG_IDXGIFactory_CreateSwapChain_MultipleSwapchainRefToSurface_DeferredDtr                                     = 0x00000129,
    DXGI_MSG_IDXGIFactory_MakeWindowAssociation_NoOpBehavior                                                            = 0x0000012a,
    DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_NotForegroundWindow                                                     = 0x000003e8,
    DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_DISCARD_BufferCount                                                     = 0x000003e9,
    DXGI_MSG_Phone_IDXGISwapChain_SetFullscreenState_NotAvailable                                                       = 0x000003ea,
    DXGI_MSG_Phone_IDXGISwapChain_ResizeBuffers_NotAvailable                                                            = 0x000003eb,
    DXGI_MSG_Phone_IDXGISwapChain_ResizeTarget_NotAvailable                                                             = 0x000003ec,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidLayerIndex                                                             = 0x000003ed,
    DXGI_MSG_Phone_IDXGISwapChain_Present_MultipleLayerIndex                                                            = 0x000003ee,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidLayerFlag                                                              = 0x000003ef,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidRotation                                                               = 0x000003f0,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidBlend                                                                  = 0x000003f1,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidResource                                                               = 0x000003f2,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidMultiPlaneOverlayResource                                              = 0x000003f3,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidIndexForPrimary                                                        = 0x000003f4,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidIndexForOverlay                                                        = 0x000003f5,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidSubResourceIndex                                                       = 0x000003f6,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidSourceRect                                                             = 0x000003f7,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidDestinationRect                                                        = 0x000003f8,
    DXGI_MSG_Phone_IDXGISwapChain_Present_MultipleResource                                                              = 0x000003f9,
    DXGI_MSG_Phone_IDXGISwapChain_Present_NotSharedResource                                                             = 0x000003fa,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidFlag                                                                   = 0x000003fb,
    DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidInterval                                                               = 0x000003fc,
    DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_MSAA_NotSupported                                                       = 0x000003fd,
    DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_ScalingAspectRatioStretch_Supported_ModernApp                           = 0x000003fe,
    DXGI_MSG_Phone_IDXGISwapChain_GetFrameStatistics_NotAvailable_ModernApp                                             = 0x000003ff,
    DXGI_MSG_Phone_IDXGISwapChain_Present_ReplaceInterval0With1                                                         = 0x00000400,
    DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_FailedRegisterWithCompositor                                            = 0x00000401,
    DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_NotForegroundWindow_AtRendering                                         = 0x00000402,
    DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_FLIP_SEQUENTIAL_BufferCount                                             = 0x00000403,
    DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_FLIP_Modern_CoreWindow_Only                                             = 0x00000404,
    DXGI_MSG_Phone_IDXGISwapChain_Present1_RequiresOverlays                                                             = 0x00000405,
    DXGI_MSG_Phone_IDXGISwapChain_SetBackgroundColor_FlipSequentialRequired                                             = 0x00000406,
    DXGI_MSG_Phone_IDXGISwapChain_GetBackgroundColor_FlipSequentialRequired                                             = 0x00000407,
}

// Constants


enum uint DXGI_MAX_SWAP_CHAIN_BUFFERS = 0x00000010;
enum uint DXGI_INFO_QUEUE_MESSAGE_ID_STRING_FROM_APPLICATION = 0x00000000;

enum : HRESULT
{
    DXGI_ERROR_INVALID_CALL      = HRESULT(0x887a0001),
    DXGI_ERROR_NOT_FOUND         = HRESULT(0x887a0002),
    DXGI_ERROR_MORE_DATA         = HRESULT(0x887a0003),
    DXGI_ERROR_UNSUPPORTED       = HRESULT(0x887a0004),
    DXGI_ERROR_DEVICE_REMOVED    = HRESULT(0x887a0005),
    DXGI_ERROR_DEVICE_HUNG       = HRESULT(0x887a0006),
    DXGI_ERROR_DEVICE_RESET      = HRESULT(0x887a0007),
    DXGI_ERROR_WAS_STILL_DRAWING = HRESULT(0x887a000a),
}

enum HRESULT DXGI_ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE = HRESULT(0x887a000c);

enum : HRESULT
{
    DXGI_ERROR_NONEXCLUSIVE            = HRESULT(0x887a0021),
    DXGI_ERROR_NOT_CURRENTLY_AVAILABLE = HRESULT(0x887a0022),
}

enum HRESULT DXGI_ERROR_REMOTE_OUTOFMEMORY = HRESULT(0x887a0024);

enum : HRESULT
{
    DXGI_ERROR_WAIT_TIMEOUT         = HRESULT(0x887a0027),
    DXGI_ERROR_SESSION_DISCONNECTED = HRESULT(0x887a0028),
}

enum HRESULT DXGI_ERROR_CANNOT_PROTECT_CONTENT = HRESULT(0x887a002a);
enum HRESULT DXGI_ERROR_NAME_ALREADY_EXISTS = HRESULT(0x887a002c);

enum : HRESULT
{
    DXGI_ERROR_NOT_CURRENT               = HRESULT(0x887a002e),
    DXGI_ERROR_HW_PROTECTION_OUTOFMEMORY = HRESULT(0x887a0030),
}

enum HRESULT DXGI_ERROR_NON_COMPOSITED_UI = HRESULT(0x887a0032);

enum : HRESULT
{
    DXGI_ERROR_CACHE_CORRUPT        = HRESULT(0x887a0033),
    DXGI_ERROR_CACHE_FULL           = HRESULT(0x887a0034),
    DXGI_ERROR_CACHE_HASH_COLLISION = HRESULT(0x887a0035),
}

enum : HRESULT
{
    DXGI_ERROR_MPO_UNPINNED            = HRESULT(0x887a0064),
    DXGI_ERROR_SETDISPLAYMODE_REQUIRED = HRESULT(0x887a0065),
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/direct3ddxgi/dxgi-rgba))], [])
struct DXGI_RGBA
{
    float r;
    float g;
    float b;
    float a;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ns-dxgi-dxgi_frame_statistics))], [])
struct DXGI_FRAME_STATISTICS
{
    uint PresentCount;
    uint PresentRefreshCount;
    uint SyncRefreshCount;
    long SyncQPCTime;
    long SyncGPUTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ns-dxgi-dxgi_mapped_rect))], [])
struct DXGI_MAPPED_RECT
{
    int    Pitch;
    ubyte* pBits;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ns-dxgi-dxgi_adapter_desc))], [])
struct DXGI_ADAPTER_DESC
{
    wchar[128] Description;
    uint       VendorId;
    uint       DeviceId;
    uint       SubSysId;
    uint       Revision;
    size_t     DedicatedVideoMemory;
    size_t     DedicatedSystemMemory;
    size_t     SharedSystemMemory;
    LUID       AdapterLuid;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ns-dxgi-dxgi_output_desc))], [])
struct DXGI_OUTPUT_DESC
{
    wchar[32]          DeviceName;
    RECT               DesktopCoordinates;
    BOOL               AttachedToDesktop;
    DXGI_MODE_ROTATION Rotation;
    HMONITOR           Monitor;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ns-dxgi-dxgi_shared_resource))], [])
struct DXGI_SHARED_RESOURCE
{
    HANDLE Handle;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ns-dxgi-dxgi_surface_desc))], [])
struct DXGI_SURFACE_DESC
{
    uint             Width;
    uint             Height;
    DXGI_FORMAT      Format;
    DXGI_SAMPLE_DESC SampleDesc;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ns-dxgi-dxgi_swap_chain_desc))], [])
struct DXGI_SWAP_CHAIN_DESC
{
    DXGI_MODE_DESC   BufferDesc;
    DXGI_SAMPLE_DESC SampleDesc;
    DXGI_USAGE       BufferUsage;
    uint             BufferCount;
    HWND             OutputWindow;
    BOOL             Windowed;
    DXGI_SWAP_EFFECT SwapEffect;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_SWAP_CHAIN_FLAG))], [])*/uint Flags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ns-dxgi-dxgi_adapter_desc1))], [])
struct DXGI_ADAPTER_DESC1
{
    wchar[128] Description;
    uint       VendorId;
    uint       DeviceId;
    uint       SubSysId;
    uint       Revision;
    size_t     DedicatedVideoMemory;
    size_t     DedicatedSystemMemory;
    size_t     SharedSystemMemory;
    LUID       AdapterLuid;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_ADAPTER_FLAG))], [])*/uint Flags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/ns-dxgi-dxgi_display_color_space))], [])
struct DXGI_DISPLAY_COLOR_SPACE
{
    float[16] PrimaryCoordinates;
    float[32] WhitePoints;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_outdupl_move_rect))], [])
struct DXGI_OUTDUPL_MOVE_RECT
{
    POINT SourcePoint;
    RECT  DestinationRect;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_outdupl_desc))], [])
struct DXGI_OUTDUPL_DESC
{
    DXGI_MODE_DESC     ModeDesc;
    DXGI_MODE_ROTATION Rotation;
    BOOL               DesktopImageInSystemMemory;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_outdupl_pointer_position))], [])
struct DXGI_OUTDUPL_POINTER_POSITION
{
    POINT Position;
    BOOL  Visible;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_outdupl_pointer_shape_info))], [])
struct DXGI_OUTDUPL_POINTER_SHAPE_INFO
{
    uint  Type;
    uint  Width;
    uint  Height;
    uint  Pitch;
    POINT HotSpot;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_outdupl_frame_info))], [])
struct DXGI_OUTDUPL_FRAME_INFO
{
    long LastPresentTime;
    long LastMouseUpdateTime;
    uint AccumulatedFrames;
    BOOL RectsCoalesced;
    BOOL ProtectedContentMaskedOut;
    DXGI_OUTDUPL_POINTER_POSITION PointerPosition;
    uint TotalMetadataBufferSize;
    uint PointerShapeBufferSize;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_mode_desc1))], [])
struct DXGI_MODE_DESC1
{
    uint              Width;
    uint              Height;
    DXGI_RATIONAL     RefreshRate;
    DXGI_FORMAT       Format;
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    DXGI_MODE_SCALING Scaling;
    BOOL              Stereo;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_swap_chain_desc1))], [])
struct DXGI_SWAP_CHAIN_DESC1
{
    uint             Width;
    uint             Height;
    DXGI_FORMAT      Format;
    BOOL             Stereo;
    DXGI_SAMPLE_DESC SampleDesc;
    DXGI_USAGE       BufferUsage;
    uint             BufferCount;
    DXGI_SCALING     Scaling;
    DXGI_SWAP_EFFECT SwapEffect;
    DXGI_ALPHA_MODE  AlphaMode;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_SWAP_CHAIN_FLAG))], [])*/uint Flags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_swap_chain_fullscreen_desc))], [])
struct DXGI_SWAP_CHAIN_FULLSCREEN_DESC
{
    DXGI_RATIONAL     RefreshRate;
    DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
    DXGI_MODE_SCALING Scaling;
    BOOL              Windowed;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_present_parameters))], [])
struct DXGI_PRESENT_PARAMETERS
{
    uint   DirtyRectsCount;
    RECT*  pDirtyRects;
    RECT*  pScrollRect;
    POINT* pScrollOffset;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/ns-dxgi1_2-dxgi_adapter_desc2))], [])
struct DXGI_ADAPTER_DESC2
{
    wchar[128] Description;
    uint       VendorId;
    uint       DeviceId;
    uint       SubSysId;
    uint       Revision;
    size_t     DedicatedVideoMemory;
    size_t     DedicatedSystemMemory;
    size_t     SharedSystemMemory;
    LUID       AdapterLuid;
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_ADAPTER_FLAG))], [])*/uint Flags;
    DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
    DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/ns-dxgi1_3-dxgi_matrix_3x2_f))], [])
struct DXGI_MATRIX_3X2_F
{
    float _11;
    float _12;
    float _21;
    float _22;
    float _31;
    float _32;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/ns-dxgi1_3-dxgi_decode_swap_chain_desc))], [])
struct DXGI_DECODE_SWAP_CHAIN_DESC
{
    /*FIELD ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_SWAP_CHAIN_FLAG))], [])*/uint Flags;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/ns-dxgi1_3-dxgi_frame_statistics_media))], [])
struct DXGI_FRAME_STATISTICS_MEDIA
{
    uint PresentCount;
    uint PresentRefreshCount;
    uint SyncRefreshCount;
    long SyncQPCTime;
    long SyncGPUTime;
    DXGI_FRAME_PRESENTATION_MODE CompositionMode;
    uint ApprovedPresentDuration;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/ns-dxgi1_4-dxgi_query_video_memory_info))], [])
struct DXGI_QUERY_VIDEO_MEMORY_INFO
{
    ulong Budget;
    ulong CurrentUsage;
    ulong AvailableForReservation;
    ulong CurrentReservation;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/ns-dxgi1_5-dxgi_hdr_metadata_hdr10))], [])
struct DXGI_HDR_METADATA_HDR10
{
    ushort[2] RedPrimary;
    ushort[2] GreenPrimary;
    ushort[2] BluePrimary;
    ushort[2] WhitePoint;
    uint      MaxMasteringLuminance;
    uint      MinMasteringLuminance;
    ushort    MaxContentLightLevel;
    ushort    MaxFrameAverageLightLevel;
}

struct DXGI_HDR_METADATA_HDR10PLUS
{
    ubyte[72] Data;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/ns-dxgi1_6-dxgi_adapter_desc3))], [])
struct DXGI_ADAPTER_DESC3
{
    wchar[128]         Description;
    uint               VendorId;
    uint               DeviceId;
    uint               SubSysId;
    uint               Revision;
    size_t             DedicatedVideoMemory;
    size_t             DedicatedSystemMemory;
    size_t             SharedSystemMemory;
    LUID               AdapterLuid;
    DXGI_ADAPTER_FLAG3 Flags;
    DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
    DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/ns-dxgi1_6-dxgi_output_desc1))], [])
struct DXGI_OUTPUT_DESC1
{
    wchar[32]          DeviceName;
    RECT               DesktopCoordinates;
    BOOL               AttachedToDesktop;
    DXGI_MODE_ROTATION Rotation;
    HMONITOR           Monitor;
    uint               BitsPerColor;
    DXGI_COLOR_SPACE_TYPE ColorSpace;
    float[2]           RedPrimary;
    float[2]           GreenPrimary;
    float[2]           BluePrimary;
    float[2]           WhitePoint;
    float              MinLuminance;
    float              MaxLuminance;
    float              MaxFullFrameLuminance;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/ns-dxgidebug-dxgi_info_queue_message))], [])
struct DXGI_INFO_QUEUE_MESSAGE
{
    GUID          Producer;
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category;
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity;
    int           ID;
    const(ubyte)* pDescription;
    size_t        DescriptionByteLength;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/ns-dxgidebug-dxgi_info_queue_filter_desc))], [])
struct DXGI_INFO_QUEUE_FILTER_DESC
{
    uint NumCategories;
    DXGI_INFO_QUEUE_MESSAGE_CATEGORY* pCategoryList;
    uint NumSeverities;
    DXGI_INFO_QUEUE_MESSAGE_SEVERITY* pSeverityList;
    uint NumIDs;
    int* pIDList;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/ns-dxgidebug-dxgi_info_queue_filter))], [])
struct DXGI_INFO_QUEUE_FILTER
{
    DXGI_INFO_QUEUE_FILTER_DESC AllowList;
    DXGI_INFO_QUEUE_FILTER_DESC DenyList;
}

// Functions

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-createdxgifactory))], [])
@DllImport("dxgi.dll")
HRESULT CreateDXGIFactory(const(GUID)* riid, void** ppFactory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-createdxgifactory1))], [])
@DllImport("dxgi.dll")
HRESULT CreateDXGIFactory1(const(GUID)* riid, void** ppFactory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-createdxgifactory2))], [])
@DllImport("dxgi.dll")
HRESULT CreateDXGIFactory2(DXGI_CREATE_FACTORY_FLAGS Flags, const(GUID)* riid, void** ppFactory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-dxgigetdebuginterface1))], [])
@DllImport("dxgi.dll")
HRESULT DXGIGetDebugInterface1(uint Flags, const(GUID)* riid, void** pDebug);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nf-dxgi1_6-dxgideclareadapterremovalsupport))], [])
@DllImport("dxgi.dll")
HRESULT DXGIDeclareAdapterRemovalSupport();

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nf-dxgi1_6-dxgidisablevblankvirtualization))], [])
@DllImport("dxgi.dll")
HRESULT DXGIDisableVBlankVirtualization();


// Interfaces

@GUID("aec22fb8-76f3-4639-9be0-28eb43a67a2e")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgiobject))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIObject : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiobject-setprivatedata))], [])
    HRESULT SetPrivateData(const(GUID)* Name, uint DataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiobject-setprivatedatainterface))], [])
    HRESULT SetPrivateDataInterface(const(GUID)* Name, const(IUnknown) pUnknown);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiobject-getprivatedata))], [])
    HRESULT GetPrivateData(const(GUID)* Name, uint* pDataSize, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pData);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiobject-getparent))], [])
    HRESULT GetParent(const(GUID)* riid, void** ppParent);
}

@GUID("3d3e0379-f9de-4d58-bb6c-18d62992f1a6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgidevicesubobject))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDeviceSubObject : IDXGIObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgidevicesubobject-getdevice))], [])
    HRESULT GetDevice(const(GUID)* riid, void** ppDevice);
}

@GUID("035f3ab4-482e-4e50-b41f-8a7f8bd8960b")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgiresource))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIResource : IDXGIDeviceSubObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiresource-getsharedhandle))], [])
    HRESULT GetSharedHandle(HANDLE* pSharedHandle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiresource-getusage))], [])
    HRESULT GetUsage(DXGI_USAGE* pUsage);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiresource-setevictionpriority))], [])
    HRESULT SetEvictionPriority(DXGI_RESOURCE_PRIORITY EvictionPriority);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiresource-getevictionpriority))], [])
    HRESULT GetEvictionPriority(DXGI_RESOURCE_PRIORITY* pEvictionPriority);
}

@GUID("9d8e1289-d7b3-465f-8126-250e349af85d")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgikeyedmutex))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIKeyedMutex : IDXGIDeviceSubObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgikeyedmutex-acquiresync))], [])
    HRESULT AcquireSync(ulong Key, uint dwMilliseconds);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgikeyedmutex-releasesync))], [])
    HRESULT ReleaseSync(ulong Key);
}

@GUID("cafcb56c-6ac3-4889-bf47-9e23bbd260ec")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgisurface))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGISurface : IDXGIDeviceSubObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgisurface-getdesc))], [])
    HRESULT GetDesc(DXGI_SURFACE_DESC* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgisurface-map))], [])
    HRESULT Map(DXGI_MAPPED_RECT* pLockedRect, DXGI_MAP_FLAGS MapFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgisurface-unmap))], [])
    HRESULT Unmap();
}

@GUID("4ae63092-6327-4c1b-80ae-bfe12ea32b86")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgisurface1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGISurface1 : IDXGISurface
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgisurface1-getdc))], [])
    HRESULT GetDC(BOOL Discard, HDC* phdc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgisurface1-releasedc))], [])
    HRESULT ReleaseDC(RECT* pDirtyRect);
}

@GUID("2411e7e1-12ac-4ccf-bd14-9798e8534dc0")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgiadapter))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIAdapter : IDXGIObject
{
//METH ATTR: CanReturnErrorsAsSuccessAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiadapter-enumoutputs))], [])
    HRESULT EnumOutputs(uint Output, IDXGIOutput* ppOutput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiadapter-getdesc))], [])
    HRESULT GetDesc(DXGI_ADAPTER_DESC* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiadapter-checkinterfacesupport))], [])
    HRESULT CheckInterfaceSupport(const(GUID)* InterfaceName, long* pUMDVersion);
}

@GUID("ae02eedb-c735-4690-8d52-5a8dc20213aa")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgioutput))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIOutput : IDXGIObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-getdesc))], [])
    HRESULT GetDesc(DXGI_OUTPUT_DESC* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-getdisplaymodelist))], [])
    HRESULT GetDisplayModeList(DXGI_FORMAT EnumFormat, DXGI_ENUM_MODES Flags, uint* pNumModes, 
                               DXGI_MODE_DESC* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-findclosestmatchingmode))], [])
    HRESULT FindClosestMatchingMode(const(DXGI_MODE_DESC)* pModeToMatch, DXGI_MODE_DESC* pClosestMatch, 
                                    IUnknown pConcernedDevice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-waitforvblank))], [])
    HRESULT WaitForVBlank();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-takeownership))], [])
    HRESULT TakeOwnership(IUnknown pDevice, BOOL Exclusive);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-releaseownership))], [])
    void    ReleaseOwnership();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-getgammacontrolcapabilities))], [])
    HRESULT GetGammaControlCapabilities(DXGI_GAMMA_CONTROL_CAPABILITIES* pGammaCaps);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-setgammacontrol))], [])
    HRESULT SetGammaControl(const(DXGI_GAMMA_CONTROL)* pArray);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-getgammacontrol))], [])
    HRESULT GetGammaControl(DXGI_GAMMA_CONTROL* pArray);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-setdisplaysurface))], [])
    HRESULT SetDisplaySurface(IDXGISurface pScanoutSurface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-getdisplaysurfacedata))], [])
    HRESULT GetDisplaySurfaceData(IDXGISurface pDestination);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgioutput-getframestatistics))], [])
    HRESULT GetFrameStatistics(DXGI_FRAME_STATISTICS* pStats);
}

@GUID("310d36a0-d2e7-4c0a-aa04-6a9d23b8886a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgiswapchain))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGISwapChain : IDXGIDeviceSubObject
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-present))], [])
    HRESULT Present(uint SyncInterval, DXGI_PRESENT Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-getbuffer))], [])
    HRESULT GetBuffer(uint Buffer, const(GUID)* riid, void** ppSurface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-setfullscreenstate))], [])
    HRESULT SetFullscreenState(BOOL Fullscreen, IDXGIOutput pTarget);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-getfullscreenstate))], [])
    HRESULT GetFullscreenState(BOOL* pFullscreen, IDXGIOutput* ppTarget);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-getdesc))], [])
    HRESULT GetDesc(DXGI_SWAP_CHAIN_DESC* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-resizebuffers))], [])
    HRESULT ResizeBuffers(uint BufferCount, uint Width, uint Height, DXGI_FORMAT NewFormat, 
                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_SWAP_CHAIN_FLAG))], [])*/uint SwapChainFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-resizetarget))], [])
    HRESULT ResizeTarget(const(DXGI_MODE_DESC)* pNewTargetParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-getcontainingoutput))], [])
    HRESULT GetContainingOutput(IDXGIOutput* ppOutput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-getframestatistics))], [])
    HRESULT GetFrameStatistics(DXGI_FRAME_STATISTICS* pStats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiswapchain-getlastpresentcount))], [])
    HRESULT GetLastPresentCount(uint* pLastPresentCount);
}

@GUID("7b7166ec-21c7-44ae-b21a-c9ae321ae369")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgifactory))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIFactory : IDXGIObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgifactory-enumadapters))], [])
    HRESULT EnumAdapters(uint Adapter, IDXGIAdapter* ppAdapter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgifactory-makewindowassociation))], [])
    HRESULT MakeWindowAssociation(HWND WindowHandle, DXGI_MWA_FLAGS Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgifactory-getwindowassociation))], [])
    HRESULT GetWindowAssociation(HWND* pWindowHandle);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgifactory-createswapchain))], [])
    HRESULT CreateSwapChain(IUnknown pDevice, DXGI_SWAP_CHAIN_DESC* pDesc, IDXGISwapChain* ppSwapChain);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgifactory-createsoftwareadapter))], [])
    HRESULT CreateSoftwareAdapter(HMODULE Module, IDXGIAdapter* ppAdapter);
}

@GUID("54ec77fa-1377-44e6-8c32-88fd5f44c84c")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgidevice))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDevice : IDXGIObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgidevice-getadapter))], [])
    HRESULT GetAdapter(IDXGIAdapter* pAdapter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgidevice-createsurface))], [])
    HRESULT CreateSurface(const(DXGI_SURFACE_DESC)* pDesc, uint NumSurfaces, DXGI_USAGE Usage, 
                          const(DXGI_SHARED_RESOURCE)* pSharedResource, IDXGISurface* ppSurface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgidevice-queryresourceresidency))], [])
    HRESULT QueryResourceResidency(IUnknown* ppResources, DXGI_RESIDENCY* pResidencyStatus, uint NumResources);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgidevice-setgputhreadpriority))], [])
    HRESULT SetGPUThreadPriority(int Priority);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgidevice-getgputhreadpriority))], [])
    HRESULT GetGPUThreadPriority(int* pPriority);
}

@GUID("770aae78-f26f-4dba-a829-253c83d1b387")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgifactory1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIFactory1 : IDXGIFactory
{
//METH ATTR: CanReturnErrorsAsSuccessAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgifactory1-enumadapters1))], [])
    HRESULT EnumAdapters1(uint Adapter, IDXGIAdapter1* ppAdapter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgifactory1-iscurrent))], [])
    BOOL    IsCurrent();
}

@GUID("29038f61-3839-4626-91fd-086879011a05")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgiadapter1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIAdapter1 : IDXGIAdapter
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgiadapter1-getdesc1))], [])
    HRESULT GetDesc1(DXGI_ADAPTER_DESC1* pDesc);
}

@GUID("77db970f-6276-48ba-ba28-070143b4392c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nn-dxgi-idxgidevice1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDevice1 : IDXGIDevice
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgidevice1-setmaximumframelatency))], [])
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi/nf-dxgi-idxgidevice1-getmaximumframelatency))], [])
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
}

@GUID("ea9dbf1a-c88e-4486-854a-98aa0138f30c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nn-dxgi1_2-idxgidisplaycontrol))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDisplayControl : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgidisplaycontrol-isstereoenabled))], [])
    BOOL IsStereoEnabled();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgidisplaycontrol-setstereoenabled))], [])
    void SetStereoEnabled(BOOL enabled);
}

@GUID("191cfac3-a341-470d-b26e-a864f428319c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nn-dxgi1_2-idxgioutputduplication))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIOutputDuplication : IDXGIObject
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutputduplication-getdesc))], [])
    void    GetDesc(DXGI_OUTDUPL_DESC* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutputduplication-acquirenextframe))], [])
    HRESULT AcquireNextFrame(uint TimeoutInMilliseconds, DXGI_OUTDUPL_FRAME_INFO* pFrameInfo, 
                             IDXGIResource* ppDesktopResource);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutputduplication-getframedirtyrects))], [])
    HRESULT GetFrameDirtyRects(uint DirtyRectsBufferSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/RECT* pDirtyRectsBuffer, 
                               uint* pDirtyRectsBufferSizeRequired);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutputduplication-getframemoverects))], [])
    HRESULT GetFrameMoveRects(uint MoveRectsBufferSize, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/DXGI_OUTDUPL_MOVE_RECT* pMoveRectBuffer, 
                              uint* pMoveRectsBufferSizeRequired);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutputduplication-getframepointershape))], [])
    HRESULT GetFramePointerShape(uint PointerShapeBufferSize, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/void* pPointerShapeBuffer, 
                                 uint* pPointerShapeBufferSizeRequired, 
                                 DXGI_OUTDUPL_POINTER_SHAPE_INFO* pPointerShapeInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutputduplication-mapdesktopsurface))], [])
    HRESULT MapDesktopSurface(DXGI_MAPPED_RECT* pLockedRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutputduplication-unmapdesktopsurface))], [])
    HRESULT UnMapDesktopSurface();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutputduplication-releaseframe))], [])
    HRESULT ReleaseFrame();
}

@GUID("aba496dd-b617-4cb8-a866-bc44d7eb1fa2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nn-dxgi1_2-idxgisurface2))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGISurface2 : IDXGISurface1
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgisurface2-getresource))], [])
    HRESULT GetResource(const(GUID)* riid, void** ppParentResource, uint* pSubresourceIndex);
}

@GUID("30961379-4609-4a41-998e-54fe567ee0c1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nn-dxgi1_2-idxgiresource1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIResource1 : IDXGIResource
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiresource1-createsubresourcesurface))], [])
    HRESULT CreateSubresourceSurface(uint index, IDXGISurface2* ppSurface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiresource1-createsharedhandle))], [])
    HRESULT CreateSharedHandle(const(SECURITY_ATTRIBUTES)* pAttributes, uint dwAccess, const(PWSTR) lpName, 
                               HANDLE* pHandle);
}

@GUID("05008617-fbfd-4051-a790-144884b4f6a9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nn-dxgi1_2-idxgidevice2))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDevice2 : IDXGIDevice1
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgidevice2-offerresources))], [])
    HRESULT OfferResources(uint NumResources, IDXGIResource* ppResources, DXGI_OFFER_RESOURCE_PRIORITY Priority);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgidevice2-reclaimresources))], [])
    HRESULT ReclaimResources(uint NumResources, IDXGIResource* ppResources, BOOL* pDiscarded);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgidevice2-enqueuesetevent))], [])
    HRESULT EnqueueSetEvent(HANDLE hEvent);
}

@GUID("790a45f7-0d42-4876-983a-0a55cfe6f4aa")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nn-dxgi1_2-idxgiswapchain1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGISwapChain1 : IDXGISwapChain
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-getdesc1))], [])
    HRESULT GetDesc1(DXGI_SWAP_CHAIN_DESC1* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-getfullscreendesc))], [])
    HRESULT GetFullscreenDesc(DXGI_SWAP_CHAIN_FULLSCREEN_DESC* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-gethwnd))], [])
    HRESULT GetHwnd(HWND* pHwnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-getcorewindow))], [])
    HRESULT GetCoreWindow(const(GUID)* refiid, void** ppUnk);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-present1))], [])
    HRESULT Present1(uint SyncInterval, DXGI_PRESENT PresentFlags, 
                     const(DXGI_PRESENT_PARAMETERS)* pPresentParameters);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-istemporarymonosupported))], [])
    BOOL    IsTemporaryMonoSupported();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-getrestricttooutput))], [])
    HRESULT GetRestrictToOutput(IDXGIOutput* ppRestrictToOutput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-setbackgroundcolor))], [])
    HRESULT SetBackgroundColor(const(DXGI_RGBA)* pColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-getbackgroundcolor))], [])
    HRESULT GetBackgroundColor(DXGI_RGBA* pColor);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-setrotation))], [])
    HRESULT SetRotation(DXGI_MODE_ROTATION Rotation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiswapchain1-getrotation))], [])
    HRESULT GetRotation(DXGI_MODE_ROTATION* pRotation);
}

@GUID("50c83a1c-e072-4c48-87b0-3630fa36a6d0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nn-dxgi1_2-idxgifactory2))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIFactory2 : IDXGIFactory1
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-iswindowedstereoenabled))], [])
    BOOL    IsWindowedStereoEnabled();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-createswapchainforhwnd))], [])
    HRESULT CreateSwapChainForHwnd(IUnknown pDevice, HWND hWnd, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                   const(DXGI_SWAP_CHAIN_FULLSCREEN_DESC)* pFullscreenDesc, 
                                   IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-createswapchainforcorewindow))], [])
    HRESULT CreateSwapChainForCoreWindow(IUnknown pDevice, IUnknown pWindow, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                         IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-getsharedresourceadapterluid))], [])
    HRESULT GetSharedResourceAdapterLuid(HANDLE hResource, LUID* pLuid);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-registerstereostatuswindow))], [])
    HRESULT RegisterStereoStatusWindow(HWND WindowHandle, uint wMsg, uint* pdwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-registerstereostatusevent))], [])
    HRESULT RegisterStereoStatusEvent(HANDLE hEvent, uint* pdwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-unregisterstereostatus))], [])
    void    UnregisterStereoStatus(uint dwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-registerocclusionstatuswindow))], [])
    HRESULT RegisterOcclusionStatusWindow(HWND WindowHandle, uint wMsg, uint* pdwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-registerocclusionstatusevent))], [])
    HRESULT RegisterOcclusionStatusEvent(HANDLE hEvent, uint* pdwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-unregisterocclusionstatus))], [])
    void    UnregisterOcclusionStatus(uint dwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgifactory2-createswapchainforcomposition))], [])
    HRESULT CreateSwapChainForComposition(IUnknown pDevice, const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                          IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
}

@GUID("0aa1ae0a-fa0e-4b84-8644-e05ff8e5acb5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nn-dxgi1_2-idxgiadapter2))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIAdapter2 : IDXGIAdapter1
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgiadapter2-getdesc2))], [])
    HRESULT GetDesc2(DXGI_ADAPTER_DESC2* pDesc);
}

@GUID("00cddea8-939b-4b83-a340-a685226666cc")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nn-dxgi1_2-idxgioutput1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIOutput1 : IDXGIOutput
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutput1-getdisplaymodelist1))], [])
    HRESULT GetDisplayModeList1(DXGI_FORMAT EnumFormat, DXGI_ENUM_MODES Flags, uint* pNumModes, 
                                DXGI_MODE_DESC1* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutput1-findclosestmatchingmode1))], [])
    HRESULT FindClosestMatchingMode1(const(DXGI_MODE_DESC1)* pModeToMatch, DXGI_MODE_DESC1* pClosestMatch, 
                                     IUnknown pConcernedDevice);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutput1-getdisplaysurfacedata1))], [])
    HRESULT GetDisplaySurfaceData1(IDXGIResource pDestination);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_2/nf-dxgi1_2-idxgioutput1-duplicateoutput))], [])
    HRESULT DuplicateOutput(IUnknown pDevice, IDXGIOutputDuplication* ppOutputDuplication);
}

@GUID("6007896c-3244-4afd-bf18-a6d3beda5023")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nn-dxgi1_3-idxgidevice3))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDevice3 : IDXGIDevice2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidevice3-trim))], [])
    void Trim();
}

@GUID("a8be2ac4-199f-4946-b331-79599fb98de7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nn-dxgi1_3-idxgiswapchain2))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGISwapChain2 : IDXGISwapChain1
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchain2-setsourcesize))], [])
    HRESULT SetSourceSize(uint Width, uint Height);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchain2-getsourcesize))], [])
    HRESULT GetSourceSize(uint* pWidth, uint* pHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchain2-setmaximumframelatency))], [])
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchain2-getmaximumframelatency))], [])
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchain2-getframelatencywaitableobject))], [])
    HANDLE  GetFrameLatencyWaitableObject();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchain2-setmatrixtransform))], [])
    HRESULT SetMatrixTransform(const(DXGI_MATRIX_3X2_F)* pMatrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchain2-getmatrixtransform))], [])
    HRESULT GetMatrixTransform(DXGI_MATRIX_3X2_F* pMatrix);
}

@GUID("595e39d1-2724-4663-99b1-da969de28364")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nn-dxgi1_3-idxgioutput2))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIOutput2 : IDXGIOutput1
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgioutput2-supportsoverlays))], [])
    BOOL SupportsOverlays();
}

@GUID("25483823-cd46-4c7d-86ca-47aa95b837bd")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nn-dxgi1_3-idxgifactory3))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIFactory3 : IDXGIFactory2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgifactory3-getcreationflags))], [])
    DXGI_CREATE_FACTORY_FLAGS GetCreationFlags();
}

@GUID("2633066b-4514-4c7a-8fd8-12ea98059d18")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nn-dxgi1_3-idxgidecodeswapchain))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDecodeSwapChain : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidecodeswapchain-presentbuffer))], [])
    HRESULT PresentBuffer(uint BufferToPresent, uint SyncInterval, DXGI_PRESENT Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidecodeswapchain-setsourcerect))], [])
    HRESULT SetSourceRect(const(RECT)* pRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidecodeswapchain-settargetrect))], [])
    HRESULT SetTargetRect(const(RECT)* pRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidecodeswapchain-setdestsize))], [])
    HRESULT SetDestSize(uint Width, uint Height);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidecodeswapchain-getsourcerect))], [])
    HRESULT GetSourceRect(RECT* pRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidecodeswapchain-gettargetrect))], [])
    HRESULT GetTargetRect(RECT* pRect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidecodeswapchain-getdestsize))], [])
    HRESULT GetDestSize(uint* pWidth, uint* pHeight);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidecodeswapchain-setcolorspace))], [])
    HRESULT SetColorSpace(DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS ColorSpace);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgidecodeswapchain-getcolorspace))], [])
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS GetColorSpace();
}

@GUID("41e7d1f2-a591-4f7b-a2e5-fa9c843e1c12")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nn-dxgi1_3-idxgifactorymedia))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIFactoryMedia : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgifactorymedia-createswapchainforcompositionsurfacehandle))], [])
    HRESULT CreateSwapChainForCompositionSurfaceHandle(IUnknown pDevice, HANDLE hSurface, 
                                                       const(DXGI_SWAP_CHAIN_DESC1)* pDesc, 
                                                       IDXGIOutput pRestrictToOutput, IDXGISwapChain1* ppSwapChain);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgifactorymedia-createdecodeswapchainforcompositionsurfacehandle))], [])
    HRESULT CreateDecodeSwapChainForCompositionSurfaceHandle(IUnknown pDevice, HANDLE hSurface, 
                                                             DXGI_DECODE_SWAP_CHAIN_DESC* pDesc, 
                                                             IDXGIResource pYuvDecodeBuffers, 
                                                             IDXGIOutput pRestrictToOutput, 
                                                             IDXGIDecodeSwapChain* ppSwapChain);
}

@GUID("dd95b90b-f05f-4f6a-bd65-25bfb264bd84")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nn-dxgi1_3-idxgiswapchainmedia))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGISwapChainMedia : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchainmedia-getframestatisticsmedia))], [])
    HRESULT GetFrameStatisticsMedia(DXGI_FRAME_STATISTICS_MEDIA* pStats);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchainmedia-setpresentduration))], [])
    HRESULT SetPresentDuration(uint Duration);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgiswapchainmedia-checkpresentdurationsupport))], [])
    HRESULT CheckPresentDurationSupport(uint DesiredPresentDuration, uint* pClosestSmallerPresentDuration, 
                                        uint* pClosestLargerPresentDuration);
}

@GUID("8a6bb301-7e7e-41f4-a8e0-5b32f7f99b18")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nn-dxgi1_3-idxgioutput3))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIOutput3 : IDXGIOutput2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_3/nf-dxgi1_3-idxgioutput3-checkoverlaysupport))], [])
    HRESULT CheckOverlaySupport(DXGI_FORMAT EnumFormat, IUnknown pConcernedDevice, 
                                /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_OVERLAY_SUPPORT_FLAG))], [])*/uint* pFlags);
}

@GUID("94d99bdb-f1f8-4ab0-b236-7da0170edab1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nn-dxgi1_4-idxgiswapchain3))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGISwapChain3 : IDXGISwapChain2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiswapchain3-getcurrentbackbufferindex))], [])
    uint    GetCurrentBackBufferIndex();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiswapchain3-checkcolorspacesupport))], [])
    HRESULT CheckColorSpaceSupport(DXGI_COLOR_SPACE_TYPE ColorSpace, 
                                   /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG))], [])*/uint* pColorSpaceSupport);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiswapchain3-setcolorspace1))], [])
    HRESULT SetColorSpace1(DXGI_COLOR_SPACE_TYPE ColorSpace);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiswapchain3-resizebuffers1))], [])
    HRESULT ResizeBuffers1(uint BufferCount, uint Width, uint Height, DXGI_FORMAT Format, 
                           /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_SWAP_CHAIN_FLAG))], [])*/uint SwapChainFlags, 
                           const(uint)* pCreationNodeMask, IUnknown* ppPresentQueue);
}

@GUID("dc7dca35-2196-414d-9f53-617884032a60")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nn-dxgi1_4-idxgioutput4))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIOutput4 : IDXGIOutput3
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgioutput4-checkoverlaycolorspacesupport))], [])
    HRESULT CheckOverlayColorSpaceSupport(DXGI_FORMAT Format, DXGI_COLOR_SPACE_TYPE ColorSpace, 
                                          IUnknown pConcernedDevice, 
                                          /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG))], [])*/uint* pFlags);
}

@GUID("1bc6ea02-ef36-464f-bf0c-21ca39e5168a")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nn-dxgi1_4-idxgifactory4))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIFactory4 : IDXGIFactory3
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgifactory4-enumadapterbyluid))], [])
    HRESULT EnumAdapterByLuid(LUID AdapterLuid, const(GUID)* riid, void** ppvAdapter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgifactory4-enumwarpadapter))], [])
    HRESULT EnumWarpAdapter(const(GUID)* riid, void** ppvAdapter);
}

@GUID("645967a4-1392-4310-a798-8053ce3e93fd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nn-dxgi1_4-idxgiadapter3))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIAdapter3 : IDXGIAdapter2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiadapter3-registerhardwarecontentprotectionteardownstatusevent))], [])
    HRESULT RegisterHardwareContentProtectionTeardownStatusEvent(HANDLE hEvent, uint* pdwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiadapter3-unregisterhardwarecontentprotectionteardownstatus))], [])
    void    UnregisterHardwareContentProtectionTeardownStatus(uint dwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiadapter3-queryvideomemoryinfo))], [])
    HRESULT QueryVideoMemoryInfo(uint NodeIndex, DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup, 
                                 DXGI_QUERY_VIDEO_MEMORY_INFO* pVideoMemoryInfo);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiadapter3-setvideomemoryreservation))], [])
    HRESULT SetVideoMemoryReservation(uint NodeIndex, DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup, 
                                      ulong Reservation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiadapter3-registervideomemorybudgetchangenotificationevent))], [])
    HRESULT RegisterVideoMemoryBudgetChangeNotificationEvent(HANDLE hEvent, uint* pdwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiadapter3-unregistervideomemorybudgetchangenotification))], [])
    void    UnregisterVideoMemoryBudgetChangeNotification(uint dwCookie);
}

@GUID("80a07424-ab52-42eb-833c-0c42fd282d98")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/nn-dxgi1_5-idxgioutput5))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIOutput5 : IDXGIOutput4
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/nf-dxgi1_5-idxgioutput5-duplicateoutput1))], [])
    HRESULT DuplicateOutput1(IUnknown pDevice, uint Flags, uint SupportedFormatsCount, 
                             const(DXGI_FORMAT)* pSupportedFormats, IDXGIOutputDuplication* ppOutputDuplication);
}

@GUID("3d585d5a-bd4a-489e-b1f4-3dbcb6452ffb")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/nn-dxgi1_5-idxgiswapchain4))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGISwapChain4 : IDXGISwapChain3
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/nf-dxgi1_5-idxgiswapchain4-sethdrmetadata))], [])
    HRESULT SetHDRMetaData(DXGI_HDR_METADATA_TYPE Type, uint Size, void* pMetaData);
}

@GUID("95b4f95f-d8da-4ca4-9ee6-3b76d5968a10")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/nn-dxgi1_5-idxgidevice4))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDevice4 : IDXGIDevice3
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/nf-dxgi1_5-idxgidevice4-offerresources1))], [])
    HRESULT OfferResources1(uint NumResources, IDXGIResource* ppResources, DXGI_OFFER_RESOURCE_PRIORITY Priority, 
                            /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_OFFER_RESOURCE_FLAGS))], [])*/uint Flags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/nf-dxgi1_5-idxgidevice4-reclaimresources1))], [])
    HRESULT ReclaimResources1(uint NumResources, IDXGIResource* ppResources, 
                              DXGI_RECLAIM_RESOURCE_RESULTS* pResults);
}

@GUID("7632e1f5-ee65-4dca-87fd-84cd75f8838d")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/nn-dxgi1_5-idxgifactory5))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIFactory5 : IDXGIFactory4
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_5/nf-dxgi1_5-idxgifactory5-checkfeaturesupport))], [])
    HRESULT CheckFeatureSupport(DXGI_FEATURE Feature, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pFeatureSupportData, 
                                uint FeatureSupportDataSize);
}

@GUID("3c8d99d1-4fbf-4181-a82c-af66bf7bd24e")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nn-dxgi1_6-idxgiadapter4))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIAdapter4 : IDXGIAdapter3
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nf-dxgi1_6-idxgiadapter4-getdesc3))], [])
    HRESULT GetDesc3(DXGI_ADAPTER_DESC3* pDesc);
}

@GUID("068346e8-aaec-4b84-add7-137f513f77a1")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nn-dxgi1_6-idxgioutput6))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIOutput6 : IDXGIOutput5
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nf-dxgi1_6-idxgioutput6-getdesc1))], [])
    HRESULT GetDesc1(DXGI_OUTPUT_DESC1* pDesc);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nf-dxgi1_6-idxgioutput6-checkhardwarecompositionsupport))], [])
    HRESULT CheckHardwareCompositionSupport(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS))], [])*/uint* pFlags);
}

@GUID("c1b6694f-ff09-44a9-b03c-77900a0a1d17")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17134))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nn-dxgi1_6-idxgifactory6))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIFactory6 : IDXGIFactory5
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nf-dxgi1_6-idxgifactory6-enumadapterbygpupreference))], [])
    HRESULT EnumAdapterByGpuPreference(uint Adapter, DXGI_GPU_PREFERENCE GpuPreference, const(GUID)* riid, 
                                       void** ppvAdapter);
}

@GUID("a4966eed-76db-44da-84c1-ee9a7afb20a8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nn-dxgi1_6-idxgifactory7))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIFactory7 : IDXGIFactory6
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nf-dxgi1_6-idxgifactory7-registeradapterschangedevent))], [])
    HRESULT RegisterAdaptersChangedEvent(HANDLE hEvent, uint* pdwCookie);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgi1_6/nf-dxgi1_6-idxgifactory7-unregisteradapterschangedevent))], [])
    HRESULT UnregisterAdaptersChangedEvent(uint dwCookie);
}

@GUID("d67441c7-672a-476f-9e82-cd55b44949ce")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nn-dxgidebug-idxgiinfoqueue))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIInfoQueue : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-setmessagecountlimit))], [])
    HRESULT SetMessageCountLimit(GUID Producer, ulong MessageCountLimit);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-clearstoredmessages))], [])
    void    ClearStoredMessages(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getmessage))], [])
    HRESULT GetMessage(GUID Producer, ulong MessageIndex, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/DXGI_INFO_QUEUE_MESSAGE* pMessage, 
                       size_t* pMessageByteLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getnumstoredmessagesallowedbyretrievalfilters))], [])
    ulong   GetNumStoredMessagesAllowedByRetrievalFilters(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getnumstoredmessages))], [])
    ulong   GetNumStoredMessages(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getnummessagesdiscardedbymessagecountlimit))], [])
    ulong   GetNumMessagesDiscardedByMessageCountLimit(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getmessagecountlimit))], [])
    ulong   GetMessageCountLimit(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getnummessagesallowedbystoragefilter))], [])
    ulong   GetNumMessagesAllowedByStorageFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getnummessagesdeniedbystoragefilter))], [])
    ulong   GetNumMessagesDeniedByStorageFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-addstoragefilterentries))], [])
    HRESULT AddStorageFilterEntries(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getstoragefilter))], [])
    HRESULT GetStorageFilter(GUID Producer, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/DXGI_INFO_QUEUE_FILTER* pFilter, 
                             size_t* pFilterByteLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-clearstoragefilter))], [])
    void    ClearStorageFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-pushemptystoragefilter))], [])
    HRESULT PushEmptyStorageFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-pushdenyallstoragefilter))], [])
    HRESULT PushDenyAllStorageFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-pushcopyofstoragefilter))], [])
    HRESULT PushCopyOfStorageFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-pushstoragefilter))], [])
    HRESULT PushStorageFilter(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-popstoragefilter))], [])
    void    PopStorageFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getstoragefilterstacksize))], [])
    uint    GetStorageFilterStackSize(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-addretrievalfilterentries))], [])
    HRESULT AddRetrievalFilterEntries(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getretrievalfilter))], [])
    HRESULT GetRetrievalFilter(GUID Producer, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/DXGI_INFO_QUEUE_FILTER* pFilter, 
                               size_t* pFilterByteLength);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-clearretrievalfilter))], [])
    void    ClearRetrievalFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-pushemptyretrievalfilter))], [])
    HRESULT PushEmptyRetrievalFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-pushdenyallretrievalfilter))], [])
    HRESULT PushDenyAllRetrievalFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-pushcopyofretrievalfilter))], [])
    HRESULT PushCopyOfRetrievalFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-pushretrievalfilter))], [])
    HRESULT PushRetrievalFilter(GUID Producer, DXGI_INFO_QUEUE_FILTER* pFilter);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-popretrievalfilter))], [])
    void    PopRetrievalFilter(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getretrievalfilterstacksize))], [])
    uint    GetRetrievalFilterStackSize(GUID Producer);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-addmessage))], [])
    HRESULT AddMessage(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category, 
                       DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, int ID, const(PSTR) pDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-addapplicationmessage))], [])
    HRESULT AddApplicationMessage(DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, const(PSTR) pDescription);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-setbreakoncategory))], [])
    HRESULT SetBreakOnCategory(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category, BOOL bEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-setbreakonseverity))], [])
    HRESULT SetBreakOnSeverity(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity, BOOL bEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-setbreakonid))], [])
    HRESULT SetBreakOnID(GUID Producer, int ID, BOOL bEnable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getbreakoncategory))], [])
    BOOL    GetBreakOnCategory(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY Category);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getbreakonseverity))], [])
    BOOL    GetBreakOnSeverity(GUID Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY Severity);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getbreakonid))], [])
    BOOL    GetBreakOnID(GUID Producer, int ID);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-setmutedebugoutput))], [])
    void    SetMuteDebugOutput(GUID Producer, BOOL bMute);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgiinfoqueue-getmutedebugoutput))], [])
    BOOL    GetMuteDebugOutput(GUID Producer);
}

@GUID("119e7452-de9e-40fe-8806-88f90c12b441")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nn-dxgidebug-idxgidebug))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDebug : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgidebug-reportliveobjects))], [])
    HRESULT ReportLiveObjects(GUID apiid, DXGI_DEBUG_RLO_FLAGS flags);
}

@GUID("c5a05f0c-16f2-4adf-9f4d-a8c4d58ac550")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nn-dxgidebug-idxgidebug1))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface IDXGIDebug1 : IDXGIDebug
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgidebug1-enableleaktrackingforthread))], [])
    void EnableLeakTrackingForThread();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgidebug1-disableleaktrackingforthread))], [])
    void DisableLeakTrackingForThread();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dxgidebug/nf-dxgidebug-idxgidebug1-isleaktrackingenabledforthread))], [])
    BOOL IsLeakTrackingEnabledForThread();
}

@GUID("9f251514-9d4d-4902-9d60-18988ab7d4b5")
interface IDXGraphicsAnalysis : IUnknown
{
    void BeginCapture();
    void EndCapture();
}


// GUIDs


const GUID IID_IDXGIAdapter           = GUIDOF!IDXGIAdapter;
const GUID IID_IDXGIAdapter1          = GUIDOF!IDXGIAdapter1;
const GUID IID_IDXGIAdapter2          = GUIDOF!IDXGIAdapter2;
const GUID IID_IDXGIAdapter3          = GUIDOF!IDXGIAdapter3;
const GUID IID_IDXGIAdapter4          = GUIDOF!IDXGIAdapter4;
const GUID IID_IDXGIDebug             = GUIDOF!IDXGIDebug;
const GUID IID_IDXGIDebug1            = GUIDOF!IDXGIDebug1;
const GUID IID_IDXGIDecodeSwapChain   = GUIDOF!IDXGIDecodeSwapChain;
const GUID IID_IDXGIDevice            = GUIDOF!IDXGIDevice;
const GUID IID_IDXGIDevice1           = GUIDOF!IDXGIDevice1;
const GUID IID_IDXGIDevice2           = GUIDOF!IDXGIDevice2;
const GUID IID_IDXGIDevice3           = GUIDOF!IDXGIDevice3;
const GUID IID_IDXGIDevice4           = GUIDOF!IDXGIDevice4;
const GUID IID_IDXGIDeviceSubObject   = GUIDOF!IDXGIDeviceSubObject;
const GUID IID_IDXGIDisplayControl    = GUIDOF!IDXGIDisplayControl;
const GUID IID_IDXGIFactory           = GUIDOF!IDXGIFactory;
const GUID IID_IDXGIFactory1          = GUIDOF!IDXGIFactory1;
const GUID IID_IDXGIFactory2          = GUIDOF!IDXGIFactory2;
const GUID IID_IDXGIFactory3          = GUIDOF!IDXGIFactory3;
const GUID IID_IDXGIFactory4          = GUIDOF!IDXGIFactory4;
const GUID IID_IDXGIFactory5          = GUIDOF!IDXGIFactory5;
const GUID IID_IDXGIFactory6          = GUIDOF!IDXGIFactory6;
const GUID IID_IDXGIFactory7          = GUIDOF!IDXGIFactory7;
const GUID IID_IDXGIFactoryMedia      = GUIDOF!IDXGIFactoryMedia;
const GUID IID_IDXGIInfoQueue         = GUIDOF!IDXGIInfoQueue;
const GUID IID_IDXGIKeyedMutex        = GUIDOF!IDXGIKeyedMutex;
const GUID IID_IDXGIObject            = GUIDOF!IDXGIObject;
const GUID IID_IDXGIOutput            = GUIDOF!IDXGIOutput;
const GUID IID_IDXGIOutput1           = GUIDOF!IDXGIOutput1;
const GUID IID_IDXGIOutput2           = GUIDOF!IDXGIOutput2;
const GUID IID_IDXGIOutput3           = GUIDOF!IDXGIOutput3;
const GUID IID_IDXGIOutput4           = GUIDOF!IDXGIOutput4;
const GUID IID_IDXGIOutput5           = GUIDOF!IDXGIOutput5;
const GUID IID_IDXGIOutput6           = GUIDOF!IDXGIOutput6;
const GUID IID_IDXGIOutputDuplication = GUIDOF!IDXGIOutputDuplication;
const GUID IID_IDXGIResource          = GUIDOF!IDXGIResource;
const GUID IID_IDXGIResource1         = GUIDOF!IDXGIResource1;
const GUID IID_IDXGISurface           = GUIDOF!IDXGISurface;
const GUID IID_IDXGISurface1          = GUIDOF!IDXGISurface1;
const GUID IID_IDXGISurface2          = GUIDOF!IDXGISurface2;
const GUID IID_IDXGISwapChain         = GUIDOF!IDXGISwapChain;
const GUID IID_IDXGISwapChain1        = GUIDOF!IDXGISwapChain1;
const GUID IID_IDXGISwapChain2        = GUIDOF!IDXGISwapChain2;
const GUID IID_IDXGISwapChain3        = GUIDOF!IDXGISwapChain3;
const GUID IID_IDXGISwapChain4        = GUIDOF!IDXGISwapChain4;
const GUID IID_IDXGISwapChainMedia    = GUIDOF!IDXGISwapChainMedia;
const GUID IID_IDXGraphicsAnalysis    = GUIDOF!IDXGraphicsAnalysis;
