// Written in the D programming language.

module windows.win32.graphics.directcomposition;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, HWND, LUID, POINT, RECT;
public import windows.win32.graphics.direct2d.common : D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE, D2D1_BLEND_MODE,
                                                       D2D1_BORDER_MODE, D2D1_COLORMATRIX_ALPHA_MODE, D2D1_COLOR_F,
                                                       D2D1_COMPOSITE_MODE, D2D1_TURBULENCE_NOISE, D2D_MATRIX_3X2_F,
                                                       D2D_MATRIX_4X4_F, D2D_MATRIX_5X4_F, D2D_RECT_F, D2D_RECT_U,
                                                       D2D_VECTOR_2F, D2D_VECTOR_4F;
public import windows.win32.graphics.direct3d : D3DMATRIX;
public import windows.win32.graphics.dxgi.common : DXGI_ALPHA_MODE, DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT, DXGI_RATIONAL;
public import windows.win32.graphics.dxgi : IDXGIDevice;
public import windows.win32.security : SECURITY_ATTRIBUTES;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ne-dcomptypes-dcomposition_bitmap_interpolation_mode))], [])

alias DCOMPOSITION_BITMAP_INTERPOLATION_MODE = int;
enum : int
{
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0x00000000,
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_LINEAR           = 0x00000001,
    DCOMPOSITION_BITMAP_INTERPOLATION_MODE_INHERIT          = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ne-dcomptypes-dcomposition_border_mode))], [])

alias DCOMPOSITION_BORDER_MODE = int;
enum : int
{
    DCOMPOSITION_BORDER_MODE_SOFT    = 0x00000000,
    DCOMPOSITION_BORDER_MODE_HARD    = 0x00000001,
    DCOMPOSITION_BORDER_MODE_INHERIT = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ne-dcomptypes-dcomposition_composite_mode))], [])

alias DCOMPOSITION_COMPOSITE_MODE = int;
enum : int
{
    DCOMPOSITION_COMPOSITE_MODE_SOURCE_OVER        = 0x00000000,
    DCOMPOSITION_COMPOSITE_MODE_DESTINATION_INVERT = 0x00000001,
    DCOMPOSITION_COMPOSITE_MODE_MIN_BLEND          = 0x00000002,
    DCOMPOSITION_COMPOSITE_MODE_INHERIT            = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ne-dcomptypes-dcomposition_backface_visibility))], [])

alias DCOMPOSITION_BACKFACE_VISIBILITY = int;
enum : int
{
    DCOMPOSITION_BACKFACE_VISIBILITY_VISIBLE = 0x00000000,
    DCOMPOSITION_BACKFACE_VISIBILITY_HIDDEN  = 0x00000001,
    DCOMPOSITION_BACKFACE_VISIBILITY_INHERIT = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ne-dcomptypes-dcomposition_opacity_mode))], [])

alias DCOMPOSITION_OPACITY_MODE = int;
enum : int
{
    DCOMPOSITION_OPACITY_MODE_LAYER    = 0x00000000,
    DCOMPOSITION_OPACITY_MODE_MULTIPLY = 0x00000001,
    DCOMPOSITION_OPACITY_MODE_INHERIT  = 0xffffffff,
}

alias DCOMPOSITION_DEPTH_MODE = int;
enum : int
{
    DCOMPOSITION_DEPTH_MODE_TREE    = 0x00000000,
    DCOMPOSITION_DEPTH_MODE_SPATIAL = 0x00000001,
    DCOMPOSITION_DEPTH_MODE_SORTED  = 0x00000003,
    DCOMPOSITION_DEPTH_MODE_INHERIT = 0xffffffff,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ne-dcomptypes-composition_frame_id_type))], [])

alias COMPOSITION_FRAME_ID_TYPE = int;
enum : int
{
    COMPOSITION_FRAME_ID_CREATED   = 0x00000000,
    COMPOSITION_FRAME_ID_CONFIRMED = 0x00000001,
    COMPOSITION_FRAME_ID_COMPLETED = 0x00000002,
}

// Constants


enum : int
{
    COMPOSITIONOBJECT_READ  = 0x00000001,
    COMPOSITIONOBJECT_WRITE = 0x00000002,
}

enum uint COMPOSITION_STATS_MAX_TARGETS = 0x00000100;

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ns-dcomptypes-dcomposition_frame_statistics))], [])
struct DCOMPOSITION_FRAME_STATISTICS
{
    long          lastFrameTime;
    DXGI_RATIONAL currentCompositionRate;
    long          currentTime;
    long          timeFrequency;
    long          nextEstimatedFrameTime;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ns-dcomptypes-composition_frame_stats))], [])
struct COMPOSITION_FRAME_STATS
{
    ulong startTime;
    ulong targetTime;
    ulong framePeriod;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ns-dcomptypes-composition_target_id))], [])
struct COMPOSITION_TARGET_ID
{
    LUID displayAdapterLuid;
    LUID renderAdapterLuid;
    uint vidPnSourceId;
    uint vidPnTargetId;
    uint uniqueId;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ns-dcomptypes-composition_stats))], [])
struct COMPOSITION_STATS
{
    uint  presentCount;
    uint  refreshCount;
    uint  virtualRefreshCount;
    ulong time;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomptypes/ns-dcomptypes-composition_target_stats))], [])
struct COMPOSITION_TARGET_STATS
{
    uint              outstandingPresents;
    ulong             presentTime;
    ulong             vblankDuration;
    COMPOSITION_STATS presentedStats;
    COMPOSITION_STATS completedStats;
}

struct DCompositionInkTrailPoint
{
    float x;
    float y;
    float radius;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositioncreatedevice))], [])
@DllImport("dcomp.dll")
HRESULT DCompositionCreateDevice(IDXGIDevice dxgiDevice, const(GUID)* iid, void** dcompositionDevice);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositioncreatedevice2))], [])
@DllImport("dcomp.dll")
HRESULT DCompositionCreateDevice2(IUnknown renderingDevice, const(GUID)* iid, void** dcompositionDevice);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositioncreatedevice3))], [])
@DllImport("dcomp.dll")
HRESULT DCompositionCreateDevice3(IUnknown renderingDevice, const(GUID)* iid, void** dcompositionDevice);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositioncreatesurfacehandle))], [])
@DllImport("dcomp.dll")
HRESULT DCompositionCreateSurfaceHandle(uint desiredAccess, SECURITY_ATTRIBUTES* securityAttributes, 
                                        HANDLE* surfaceHandle);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositionattachmousewheeltohwnd))], [])
@DllImport("dcomp.dll")
HRESULT DCompositionAttachMouseWheelToHwnd(IDCompositionVisual visual, HWND hwnd, BOOL enable);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositionattachmousedragtohwnd))], [])
@DllImport("dcomp.dll")
HRESULT DCompositionAttachMouseDragToHwnd(IDCompositionVisual visual, HWND hwnd, BOOL enable);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositiongetframeid))], [])
@DllImport("dcomp.dll")
HRESULT DCompositionGetFrameId(COMPOSITION_FRAME_ID_TYPE frameIdType, ulong* frameId);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositiongetstatistics))], [])
@DllImport("dcomp.dll")
HRESULT DCompositionGetStatistics(ulong frameId, COMPOSITION_FRAME_STATS* frameStats, uint targetIdCount, 
                                  COMPOSITION_TARGET_ID* targetIds, uint* actualTargetIdCount);

@DllImport("dcomp.dll")
HRESULT DCompositionGetTargetStatistics(ulong frameId, const(COMPOSITION_TARGET_ID)* targetId, 
                                        COMPOSITION_TARGET_STATS* targetStats);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositionboostcompositorclock))], [])
@DllImport("dcomp.dll")
HRESULT DCompositionBoostCompositorClock(BOOL enable);

//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-dcompositionwaitforcompositorclock))], [])
@DllImport("dcomp.dll")
uint DCompositionWaitForCompositorClock(uint count, const(HANDLE)* handles, uint timeoutInMs);


// Interfaces

@GUID("cbfd91d9-51b2-45e4-b3de-d19ccfb863c5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcompanimation/nn-dcompanimation-idcompositionanimation))], [])
interface IDCompositionAnimation : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcompanimation/nf-dcompanimation-idcompositionanimation-reset))], [])
    HRESULT Reset();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcompanimation/nf-dcompanimation-idcompositionanimation-setabsolutebegintime))], [])
    HRESULT SetAbsoluteBeginTime(long beginTime);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcompanimation/nf-dcompanimation-idcompositionanimation-addcubic))], [])
    HRESULT AddCubic(double beginOffset, float constantCoefficient, float linearCoefficient, 
                     float quadraticCoefficient, float cubicCoefficient);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcompanimation/nf-dcompanimation-idcompositionanimation-addsinusoidal))], [])
    HRESULT AddSinusoidal(double beginOffset, float bias, float amplitude, float frequency, float phase);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcompanimation/nf-dcompanimation-idcompositionanimation-addrepeat))], [])
    HRESULT AddRepeat(double beginOffset, double durationToRepeat);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcompanimation/nf-dcompanimation-idcompositionanimation-end))], [])
    HRESULT End(double endOffset, float endValue);
}

@GUID("c37ea93a-e7aa-450d-b16f-9746cb0407f3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiondevice))], [])
interface IDCompositionDevice : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-commit))], [])
    HRESULT Commit();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-waitforcommitcompletion))], [])
    HRESULT WaitForCommitCompletion();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-getframestatistics))], [])
    HRESULT GetFrameStatistics(DCOMPOSITION_FRAME_STATISTICS* statistics);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createtargetforhwnd))], [])
    HRESULT CreateTargetForHwnd(HWND hwnd, BOOL topmost, IDCompositionTarget* target);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createvisual))], [])
    HRESULT CreateVisual(IDCompositionVisual* visual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createsurface))], [])
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, 
                          IDCompositionSurface* surface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createvirtualsurface))], [])
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, 
                                 DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createsurfacefromhandle))], [])
    HRESULT CreateSurfaceFromHandle(HANDLE handle, IUnknown* surface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createsurfacefromhwnd))], [])
    HRESULT CreateSurfaceFromHwnd(HWND hwnd, IUnknown* surface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createtranslatetransform))], [])
    HRESULT CreateTranslateTransform(IDCompositionTranslateTransform* translateTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createscaletransform))], [])
    HRESULT CreateScaleTransform(IDCompositionScaleTransform* scaleTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createrotatetransform))], [])
    HRESULT CreateRotateTransform(IDCompositionRotateTransform* rotateTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createskewtransform))], [])
    HRESULT CreateSkewTransform(IDCompositionSkewTransform* skewTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-creatematrixtransform))], [])
    HRESULT CreateMatrixTransform(IDCompositionMatrixTransform* matrixTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createtransformgroup))], [])
    HRESULT CreateTransformGroup(IDCompositionTransform* transforms, uint elements, 
                                 IDCompositionTransform* transformGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createtranslatetransform3d))], [])
    HRESULT CreateTranslateTransform3D(IDCompositionTranslateTransform3D* translateTransform3D);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createscaletransform3d))], [])
    HRESULT CreateScaleTransform3D(IDCompositionScaleTransform3D* scaleTransform3D);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createrotatetransform3d))], [])
    HRESULT CreateRotateTransform3D(IDCompositionRotateTransform3D* rotateTransform3D);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-creatematrixtransform3d))], [])
    HRESULT CreateMatrixTransform3D(IDCompositionMatrixTransform3D* matrixTransform3D);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createtransform3dgroup))], [])
    HRESULT CreateTransform3DGroup(IDCompositionTransform3D* transforms3D, uint elements, 
                                   IDCompositionTransform3D* transform3DGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createeffectgroup))], [])
    HRESULT CreateEffectGroup(IDCompositionEffectGroup* effectGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createrectangleclip))], [])
    HRESULT CreateRectangleClip(IDCompositionRectangleClip* clip);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-createanimation))], [])
    HRESULT CreateAnimation(IDCompositionAnimation* animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice-checkdevicestate))], [])
    HRESULT CheckDeviceState(BOOL* pfValid);
}

@GUID("eacdd04c-117e-4e17-88f4-d1b12b0e3d89")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiontarget))], [])
interface IDCompositionTarget : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontarget-setroot))], [])
    HRESULT SetRoot(IDCompositionVisual visual);
}

@GUID("4d93059d-097b-4651-9a60-f0f25116e2f3")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionvisual))], [])
interface IDCompositionVisual : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setoffsetx(idcompositionanimation)))], [])
    HRESULT SetOffsetX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setoffsetx(idcompositionanimation)))], [])
    HRESULT SetOffsetX(float offsetX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setoffsety(idcompositionanimation)))], [])
    HRESULT SetOffsetY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setoffsety(idcompositionanimation)))], [])
    HRESULT SetOffsetY(float offsetY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-settransform(constd2d_matrix_3x2_f_)))], [])
    HRESULT SetTransform(IDCompositionTransform transform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-settransform(constd2d_matrix_3x2_f_)))], [])
    HRESULT SetTransform(const(D2D_MATRIX_3X2_F)* matrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-settransformparent))], [])
    HRESULT SetTransformParent(IDCompositionVisual visual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-seteffect))], [])
    HRESULT SetEffect(IDCompositionEffect effect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setbitmapinterpolationmode))], [])
    HRESULT SetBitmapInterpolationMode(DCOMPOSITION_BITMAP_INTERPOLATION_MODE interpolationMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setbordermode))], [])
    HRESULT SetBorderMode(DCOMPOSITION_BORDER_MODE borderMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setclip(constd2d_rect_f_)))], [])
    HRESULT SetClip(IDCompositionClip clip);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setclip(constd2d_rect_f_)))], [])
    HRESULT SetClip(const(D2D_RECT_F)* rect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setcontent))], [])
    HRESULT SetContent(IUnknown content);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-addvisual))], [])
    HRESULT AddVisual(IDCompositionVisual visual, BOOL insertAbove, IDCompositionVisual referenceVisual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-removevisual))], [])
    HRESULT RemoveVisual(IDCompositionVisual visual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-removeallvisuals))], [])
    HRESULT RemoveAllVisuals();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual-setcompositemode))], [])
    HRESULT SetCompositeMode(DCOMPOSITION_COMPOSITE_MODE compositeMode);
}

@GUID("ec81b08f-bfcb-4e8d-b193-a915587999e8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositioneffect))], [])
interface IDCompositionEffect : IUnknown
{
}

@GUID("71185722-246b-41f2-aad1-0443f7f4bfc2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiontransform3d))], [])
interface IDCompositionTransform3D : IDCompositionEffect
{
}

@GUID("fd55faa7-37e0-4c20-95d2-9be45bc33f55")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiontransform))], [])
interface IDCompositionTransform : IDCompositionTransform3D
{
}

@GUID("06791122-c6f0-417d-8323-269e987f5954")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiontranslatetransform))], [])
interface IDCompositionTranslateTransform : IDCompositionTransform
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform-setoffsetx(idcompositionanimation)))], [])
    HRESULT SetOffsetX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform-setoffsetx(idcompositionanimation)))], [])
    HRESULT SetOffsetX(float offsetX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform-setoffsety(float)))], [])
    HRESULT SetOffsetY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform-setoffsety(float)))], [])
    HRESULT SetOffsetY(float offsetY);
}

@GUID("71fde914-40ef-45ef-bd51-68b037c339f9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionscaletransform))], [])
interface IDCompositionScaleTransform : IDCompositionTransform
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform-setscalex(float)))], [])
    HRESULT SetScaleX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform-setscalex(float)))], [])
    HRESULT SetScaleX(float scaleX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform-setscaley(float)))], [])
    HRESULT SetScaleY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform-setscaley(float)))], [])
    HRESULT SetScaleY(float scaleY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform-setcenterx(idcompositionanimation)))], [])
    HRESULT SetCenterX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform-setcenterx(idcompositionanimation)))], [])
    HRESULT SetCenterX(float centerX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform-setcentery(idcompositionanimation)))], [])
    HRESULT SetCenterY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform-setcentery(idcompositionanimation)))], [])
    HRESULT SetCenterY(float centerY);
}

@GUID("641ed83c-ae96-46c5-90dc-32774cc5c6d5")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionrotatetransform))], [])
interface IDCompositionRotateTransform : IDCompositionTransform
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform-setangle(idcompositionanimation)))], [])
    HRESULT SetAngle(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform-setangle(idcompositionanimation)))], [])
    HRESULT SetAngle(float angle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform-setcenterx(idcompositionanimation)))], [])
    HRESULT SetCenterX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform-setcenterx(idcompositionanimation)))], [])
    HRESULT SetCenterX(float centerX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform-setcentery(float)))], [])
    HRESULT SetCenterY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform-setcentery(float)))], [])
    HRESULT SetCenterY(float centerY);
}

@GUID("e57aa735-dcdb-4c72-9c61-0591f58889ee")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionskewtransform))], [])
interface IDCompositionSkewTransform : IDCompositionTransform
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionskewtransform-setanglex(float)))], [])
    HRESULT SetAngleX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionskewtransform-setanglex(float)))], [])
    HRESULT SetAngleX(float angleX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionskewtransform-setangley(idcompositionanimation)))], [])
    HRESULT SetAngleY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionskewtransform-setangley(idcompositionanimation)))], [])
    HRESULT SetAngleY(float angleY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionskewtransform-setcenterx(idcompositionanimation)))], [])
    HRESULT SetCenterX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionskewtransform-setcenterx(idcompositionanimation)))], [])
    HRESULT SetCenterX(float centerX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionskewtransform-setcentery(idcompositionanimation)))], [])
    HRESULT SetCenterY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionskewtransform-setcentery(idcompositionanimation)))], [])
    HRESULT SetCenterY(float centerY);
}

@GUID("16cdff07-c503-419c-83f2-0965c7af1fa6")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionmatrixtransform))], [])
interface IDCompositionMatrixTransform : IDCompositionTransform
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionmatrixtransform-setmatrix))], [])
    HRESULT SetMatrix(const(D2D_MATRIX_3X2_F)* matrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionmatrixtransform-setmatrixelement(int_int_idcompositionanimation)))], [])
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionmatrixtransform-setmatrixelement(int_int_idcompositionanimation)))], [])
    HRESULT SetMatrixElement(int row, int column, float value);
}

@GUID("a7929a74-e6b2-4bd6-8b95-4040119ca34d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositioneffectgroup))], [])
interface IDCompositionEffectGroup : IDCompositionEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositioneffectgroup-setopacity(idcompositionanimation)))], [])
    HRESULT SetOpacity(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositioneffectgroup-setopacity(idcompositionanimation)))], [])
    HRESULT SetOpacity(float opacity);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositioneffectgroup-settransform3d))], [])
    HRESULT SetTransform3D(IDCompositionTransform3D transform3D);
}

@GUID("91636d4b-9ba1-4532-aaf7-e3344994d788")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiontranslatetransform3d))], [])
interface IDCompositionTranslateTransform3D : IDCompositionTransform3D
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform3d-setoffsetx(idcompositionanimation)))], [])
    HRESULT SetOffsetX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform3d-setoffsetx(idcompositionanimation)))], [])
    HRESULT SetOffsetX(float offsetX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform3d-setoffsety(idcompositionanimation)))], [])
    HRESULT SetOffsetY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform3d-setoffsety(idcompositionanimation)))], [])
    HRESULT SetOffsetY(float offsetY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform3d-setoffsetz(float)))], [])
    HRESULT SetOffsetZ(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontranslatetransform3d-setoffsetz(float)))], [])
    HRESULT SetOffsetZ(float offsetZ);
}

@GUID("2a9e9ead-364b-4b15-a7c4-a1997f78b389")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionscaletransform3d))], [])
interface IDCompositionScaleTransform3D : IDCompositionTransform3D
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setscalex(idcompositionanimation)))], [])
    HRESULT SetScaleX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setscalex(idcompositionanimation)))], [])
    HRESULT SetScaleX(float scaleX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setscaley(float)))], [])
    HRESULT SetScaleY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setscaley(float)))], [])
    HRESULT SetScaleY(float scaleY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setscalez(idcompositionanimation)))], [])
    HRESULT SetScaleZ(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setscalez(idcompositionanimation)))], [])
    HRESULT SetScaleZ(float scaleZ);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setcenterx(float)))], [])
    HRESULT SetCenterX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setcenterx(float)))], [])
    HRESULT SetCenterX(float centerX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setcentery(idcompositionanimation)))], [])
    HRESULT SetCenterY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setcentery(idcompositionanimation)))], [])
    HRESULT SetCenterY(float centerY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setcenterz(idcompositionanimation)))], [])
    HRESULT SetCenterZ(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionscaletransform3d-setcenterz(idcompositionanimation)))], [])
    HRESULT SetCenterZ(float centerZ);
}

@GUID("d8f5b23f-d429-4a91-b55a-d2f45fd75b18")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionrotatetransform3d))], [])
interface IDCompositionRotateTransform3D : IDCompositionTransform3D
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setangle(idcompositionanimation)))], [])
    HRESULT SetAngle(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setangle(idcompositionanimation)))], [])
    HRESULT SetAngle(float angle);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setaxisx(float)))], [])
    HRESULT SetAxisX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setaxisx(float)))], [])
    HRESULT SetAxisX(float axisX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setaxisy(float)))], [])
    HRESULT SetAxisY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setaxisy(float)))], [])
    HRESULT SetAxisY(float axisY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setaxisz(float)))], [])
    HRESULT SetAxisZ(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setaxisz(float)))], [])
    HRESULT SetAxisZ(float axisZ);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setcenterx(idcompositionanimation)))], [])
    HRESULT SetCenterX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setcenterx(idcompositionanimation)))], [])
    HRESULT SetCenterX(float centerX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setcentery(idcompositionanimation)))], [])
    HRESULT SetCenterY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setcentery(idcompositionanimation)))], [])
    HRESULT SetCenterY(float centerY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setcenterz(idcompositionanimation)))], [])
    HRESULT SetCenterZ(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrotatetransform3d-setcenterz(idcompositionanimation)))], [])
    HRESULT SetCenterZ(float centerZ);
}

@GUID("4b3363f0-643b-41b7-b6e0-ccf22d34467c")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionmatrixtransform3d))], [])
interface IDCompositionMatrixTransform3D : IDCompositionTransform3D
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionmatrixtransform3d-setmatrix))], [])
    HRESULT SetMatrix(const(D3DMATRIX)* matrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionmatrixtransform3d-setmatrixelement(int_int_idcompositionanimation)))], [])
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionmatrixtransform3d-setmatrixelement(int_int_idcompositionanimation)))], [])
    HRESULT SetMatrixElement(int row, int column, float value);
}

@GUID("64ac3703-9d3f-45ec-a109-7cac0e7a13a7")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionclip))], [])
interface IDCompositionClip : IUnknown
{
}

@GUID("9842ad7d-d9cf-4908-aed7-48b51da5e7c2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionrectangleclip))], [])
interface IDCompositionRectangleClip : IDCompositionClip
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrectangleclip-setleft(float)))], [])
    HRESULT SetLeft(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrectangleclip-setleft(float)))], [])
    HRESULT SetLeft(float left);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrectangleclip-settop(float)))], [])
    HRESULT SetTop(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrectangleclip-settop(float)))], [])
    HRESULT SetTop(float top);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrectangleclip-setright(idcompositionanimation)))], [])
    HRESULT SetRight(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrectangleclip-setright(idcompositionanimation)))], [])
    HRESULT SetRight(float right);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrectangleclip-setbottom(float)))], [])
    HRESULT SetBottom(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionrectangleclip-setbottom(float)))], [])
    HRESULT SetBottom(float bottom);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-settopleftradiusx))], [])
    HRESULT SetTopLeftRadiusX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-settopleftradiusx))], [])
    HRESULT SetTopLeftRadiusX(float radius);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-settopleftradiusy))], [])
    HRESULT SetTopLeftRadiusY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-settopleftradiusy))], [])
    HRESULT SetTopLeftRadiusY(float radius);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-settoprightradiusx))], [])
    HRESULT SetTopRightRadiusX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-settoprightradiusx))], [])
    HRESULT SetTopRightRadiusX(float radius);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-settoprightradiusy))], [])
    HRESULT SetTopRightRadiusY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-settoprightradiusy))], [])
    HRESULT SetTopRightRadiusY(float radius);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-setbottomleftradiusx))], [])
    HRESULT SetBottomLeftRadiusX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-setbottomleftradiusx))], [])
    HRESULT SetBottomLeftRadiusX(float radius);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-setbottomleftradiusy))], [])
    HRESULT SetBottomLeftRadiusY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-setbottomleftradiusy))], [])
    HRESULT SetBottomLeftRadiusY(float radius);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-setbottomrightradiusx))], [])
    HRESULT SetBottomRightRadiusX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-setbottomrightradiusx))], [])
    HRESULT SetBottomRightRadiusX(float radius);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-setbottomrightradiusy))], [])
    HRESULT SetBottomRightRadiusY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/directcomp/idcompositionrectangleclip-setbottomrightradiusy))], [])
    HRESULT SetBottomRightRadiusY(float radius);
}

@GUID("bb8a4953-2c99-4f5a-96f5-4819027fa3ac")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionsurface))], [])
interface IDCompositionSurface : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionsurface-begindraw))], [])
    HRESULT BeginDraw(const(RECT)* updateRect, const(GUID)* iid, void** updateObject, POINT* updateOffset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionsurface-enddraw))], [])
    HRESULT EndDraw();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionsurface-suspenddraw))], [])
    HRESULT SuspendDraw();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionsurface-resumedraw))], [])
    HRESULT ResumeDraw();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionsurface-scroll))], [])
    HRESULT Scroll(const(RECT)* scrollRect, const(RECT)* clipRect, int offsetX, int offsetY);
}

@GUID("ae471c51-5f53-4a24-8d3e-d0c39c30b3f0")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionvirtualsurface))], [])
interface IDCompositionVirtualSurface : IDCompositionSurface
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvirtualsurface-resize))], [])
    HRESULT Resize(uint width, uint height);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvirtualsurface-trim))], [])
    HRESULT Trim(const(RECT)* rectangles, uint count);
}

@GUID("75f6468d-1b8e-447c-9bc6-75fea80b5b25")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiondevice2))], [])
interface IDCompositionDevice2 : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-commit))], [])
    HRESULT Commit();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-waitforcommitcompletion))], [])
    HRESULT WaitForCommitCompletion();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-getframestatistics))], [])
    HRESULT GetFrameStatistics(DCOMPOSITION_FRAME_STATISTICS* statistics);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createvisual))], [])
    HRESULT CreateVisual(IDCompositionVisual2* visual);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createsurfacefactory))], [])
    HRESULT CreateSurfaceFactory(IUnknown renderingDevice, IDCompositionSurfaceFactory* surfaceFactory);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createsurface))], [])
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, 
                          IDCompositionSurface* surface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createvirtualsurface))], [])
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, 
                                 DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createtranslatetransform))], [])
    HRESULT CreateTranslateTransform(IDCompositionTranslateTransform* translateTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createscaletransform))], [])
    HRESULT CreateScaleTransform(IDCompositionScaleTransform* scaleTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createrotatetransform))], [])
    HRESULT CreateRotateTransform(IDCompositionRotateTransform* rotateTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createskewtransform))], [])
    HRESULT CreateSkewTransform(IDCompositionSkewTransform* skewTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-creatematrixtransform))], [])
    HRESULT CreateMatrixTransform(IDCompositionMatrixTransform* matrixTransform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createtransformgroup))], [])
    HRESULT CreateTransformGroup(IDCompositionTransform* transforms, uint elements, 
                                 IDCompositionTransform* transformGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createtranslatetransform3d))], [])
    HRESULT CreateTranslateTransform3D(IDCompositionTranslateTransform3D* translateTransform3D);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createscaletransform3d))], [])
    HRESULT CreateScaleTransform3D(IDCompositionScaleTransform3D* scaleTransform3D);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createrotatetransform3d))], [])
    HRESULT CreateRotateTransform3D(IDCompositionRotateTransform3D* rotateTransform3D);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-creatematrixtransform3d))], [])
    HRESULT CreateMatrixTransform3D(IDCompositionMatrixTransform3D* matrixTransform3D);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createtransform3dgroup))], [])
    HRESULT CreateTransform3DGroup(IDCompositionTransform3D* transforms3D, uint elements, 
                                   IDCompositionTransform3D* transform3DGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createeffectgroup))], [])
    HRESULT CreateEffectGroup(IDCompositionEffectGroup* effectGroup);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createrectangleclip))], [])
    HRESULT CreateRectangleClip(IDCompositionRectangleClip* clip);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice2-createanimation))], [])
    HRESULT CreateAnimation(IDCompositionAnimation* animation);
}

@GUID("5f4633fe-1e08-4cb8-8c75-ce24333f5602")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiondesktopdevice))], [])
interface IDCompositionDesktopDevice : IDCompositionDevice2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondesktopdevice-createtargetforhwnd))], [])
    HRESULT CreateTargetForHwnd(HWND hwnd, BOOL topmost, IDCompositionTarget* target);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondesktopdevice-createsurfacefromhandle))], [])
    HRESULT CreateSurfaceFromHandle(HANDLE handle, IUnknown* surface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondesktopdevice-createsurfacefromhwnd))], [])
    HRESULT CreateSurfaceFromHwnd(HWND hwnd, IUnknown* surface);
}

@GUID("a1a3c64a-224f-4a81-9773-4f03a89d3c6c")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiondevicedebug))], [])
interface IDCompositionDeviceDebug : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevicedebug-enabledebugcounters))], [])
    HRESULT EnableDebugCounters();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevicedebug-disabledebugcounters))], [])
    HRESULT DisableDebugCounters();
}

@GUID("e334bc12-3937-4e02-85eb-fcf4eb30d2c8")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionsurfacefactory))], [])
interface IDCompositionSurfaceFactory : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionsurfacefactory-createsurface))], [])
    HRESULT CreateSurface(uint width, uint height, DXGI_FORMAT pixelFormat, DXGI_ALPHA_MODE alphaMode, 
                          IDCompositionSurface* surface);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionsurfacefactory-createvirtualsurface))], [])
    HRESULT CreateVirtualSurface(uint initialWidth, uint initialHeight, DXGI_FORMAT pixelFormat, 
                                 DXGI_ALPHA_MODE alphaMode, IDCompositionVirtualSurface* virtualSurface);
}

@GUID("e8de1639-4331-4b26-bc5f-6a321d347a85")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionvisual2))], [])
interface IDCompositionVisual2 : IDCompositionVisual
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual2-setopacitymode))], [])
    HRESULT SetOpacityMode(DCOMPOSITION_OPACITY_MODE mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual2-setbackfacevisibility))], [])
    HRESULT SetBackFaceVisibility(DCOMPOSITION_BACKFACE_VISIBILITY visibility);
}

@GUID("fed2b808-5eb4-43a0-aea3-35f65280f91b")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionvisualdebug))], [])
interface IDCompositionVisualDebug : IDCompositionVisual2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisualdebug-enableheatmap))], [])
    HRESULT EnableHeatMap(const(D2D1_COLOR_F)* color);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisualdebug-disableheatmap))], [])
    HRESULT DisableHeatMap();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisualdebug-enableredrawregions))], [])
    HRESULT EnableRedrawRegions();
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisualdebug-disableredrawregions))], [])
    HRESULT DisableRedrawRegions();
}

@GUID("2775f462-b6c1-4015-b0be-b3e7d6a4976d")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionvisual3))], [])
interface IDCompositionVisual3 : IDCompositionVisualDebug
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual3-setdepthmode))], [])
    HRESULT SetDepthMode(DCOMPOSITION_DEPTH_MODE mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual3-setoffsetz(float)))], [])
    HRESULT SetOffsetZ(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual3-setoffsetz(float)))], [])
    HRESULT SetOffsetZ(float offsetZ);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual3-setopacity(idcompositionanimation)))], [])
    HRESULT SetOpacity(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual3-setopacity(idcompositionanimation)))], [])
    HRESULT SetOpacity(float opacity);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual3-settransform(constd2d_matrix_4x4_f_)))], [])
    HRESULT SetTransform(IDCompositionTransform3D transform);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual3-settransform(constd2d_matrix_4x4_f_)))], [])
    HRESULT SetTransform(const(D2D_MATRIX_4X4_F)* matrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionvisual3-setvisible))], [])
    HRESULT SetVisible(BOOL visible);
}

@GUID("0987cb06-f916-48bf-8d35-ce7641781bd9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiondevice3))], [])
interface IDCompositionDevice3 : IDCompositionDevice2
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-creategaussianblureffect))], [])
    HRESULT CreateGaussianBlurEffect(IDCompositionGaussianBlurEffect* gaussianBlurEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createbrightnesseffect))], [])
    HRESULT CreateBrightnessEffect(IDCompositionBrightnessEffect* brightnessEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createcolormatrixeffect))], [])
    HRESULT CreateColorMatrixEffect(IDCompositionColorMatrixEffect* colorMatrixEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createshadoweffect))], [])
    HRESULT CreateShadowEffect(IDCompositionShadowEffect* shadowEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createhuerotationeffect))], [])
    HRESULT CreateHueRotationEffect(IDCompositionHueRotationEffect* hueRotationEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createsaturationeffect))], [])
    HRESULT CreateSaturationEffect(IDCompositionSaturationEffect* saturationEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createturbulenceeffect))], [])
    HRESULT CreateTurbulenceEffect(IDCompositionTurbulenceEffect* turbulenceEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createlineartransfereffect))], [])
    HRESULT CreateLinearTransferEffect(IDCompositionLinearTransferEffect* linearTransferEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createtabletransfereffect))], [])
    HRESULT CreateTableTransferEffect(IDCompositionTableTransferEffect* tableTransferEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createcompositeeffect))], [])
    HRESULT CreateCompositeEffect(IDCompositionCompositeEffect* compositeEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createblendeffect))], [])
    HRESULT CreateBlendEffect(IDCompositionBlendEffect* blendEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createarithmeticcompositeeffect))], [])
    HRESULT CreateArithmeticCompositeEffect(IDCompositionArithmeticCompositeEffect* arithmeticCompositeEffect);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiondevice3-createaffinetransform2deffect))], [])
    HRESULT CreateAffineTransform2DEffect(IDCompositionAffineTransform2DEffect* affineTransform2dEffect);
}

@GUID("30c421d5-8cb2-4e9f-b133-37be270d4ac2")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionfiltereffect))], [])
interface IDCompositionFilterEffect : IDCompositionEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionfiltereffect-setinput))], [])
    HRESULT SetInput(uint index, IUnknown input, uint flags);
}

@GUID("45d4d0b7-1bd4-454e-8894-2bfa68443033")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiongaussianblureffect))], [])
interface IDCompositionGaussianBlurEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiongaussianblureffect-setstandarddeviation(float)))], [])
    HRESULT SetStandardDeviation(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiongaussianblureffect-setstandarddeviation(float)))], [])
    HRESULT SetStandardDeviation(float amount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiongaussianblureffect-setbordermode))], [])
    HRESULT SetBorderMode(D2D1_BORDER_MODE mode);
}

@GUID("6027496e-cb3a-49ab-934f-d798da4f7da6")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionbrightnesseffect))], [])
interface IDCompositionBrightnessEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setwhitepoint))], [])
    HRESULT SetWhitePoint(const(D2D_VECTOR_2F)* whitePoint);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setblackpoint))], [])
    HRESULT SetBlackPoint(const(D2D_VECTOR_2F)* blackPoint);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setwhitepointx(float)))], [])
    HRESULT SetWhitePointX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setwhitepointx(float)))], [])
    HRESULT SetWhitePointX(float whitePointX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setwhitepointy(idcompositionanimation)))], [])
    HRESULT SetWhitePointY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setwhitepointy(idcompositionanimation)))], [])
    HRESULT SetWhitePointY(float whitePointY);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setblackpointx(idcompositionanimation)))], [])
    HRESULT SetBlackPointX(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setblackpointx(idcompositionanimation)))], [])
    HRESULT SetBlackPointX(float blackPointX);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setblackpointy(float)))], [])
    HRESULT SetBlackPointY(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionbrightnesseffect-setblackpointy(float)))], [])
    HRESULT SetBlackPointY(float blackPointY);
}

@GUID("c1170a22-3ce2-4966-90d4-55408bfc84c4")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositioncolormatrixeffect))], [])
interface IDCompositionColorMatrixEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositioncolormatrixeffect-setmatrix))], [])
    HRESULT SetMatrix(const(D2D_MATRIX_5X4_F)* matrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositioncolormatrixeffect-setmatrixelement(int_int_float)))], [])
    HRESULT SetMatrixElement(int row, int column, IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositioncolormatrixeffect-setmatrixelement(int_int_float)))], [])
    HRESULT SetMatrixElement(int row, int column, float value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositioncolormatrixeffect-setalphamode))], [])
    HRESULT SetAlphaMode(D2D1_COLORMATRIX_ALPHA_MODE mode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositioncolormatrixeffect-setclampoutput))], [])
    HRESULT SetClampOutput(BOOL clamp);
}

@GUID("4ad18ac0-cfd2-4c2f-bb62-96e54fdb6879")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionshadoweffect))], [])
interface IDCompositionShadowEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setstandarddeviation(float)))], [])
    HRESULT SetStandardDeviation(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setstandarddeviation(float)))], [])
    HRESULT SetStandardDeviation(float amount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setcolor))], [])
    HRESULT SetColor(const(D2D_VECTOR_4F)* color);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setred(float)))], [])
    HRESULT SetRed(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setred(float)))], [])
    HRESULT SetRed(float amount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setgreen(float)))], [])
    HRESULT SetGreen(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setgreen(float)))], [])
    HRESULT SetGreen(float amount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setblue(idcompositionanimation)))], [])
    HRESULT SetBlue(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setblue(idcompositionanimation)))], [])
    HRESULT SetBlue(float amount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setalpha(idcompositionanimation)))], [])
    HRESULT SetAlpha(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionshadoweffect-setalpha(idcompositionanimation)))], [])
    HRESULT SetAlpha(float amount);
}

@GUID("6db9f920-0770-4781-b0c6-381912f9d167")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionhuerotationeffect))], [])
interface IDCompositionHueRotationEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionhuerotationeffect-setangle(float)))], [])
    HRESULT SetAngle(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionhuerotationeffect-setangle(float)))], [])
    HRESULT SetAngle(float amountDegrees);
}

@GUID("a08debda-3258-4fa4-9f16-9174d3fe93b1")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionsaturationeffect))], [])
interface IDCompositionSaturationEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionsaturationeffect-setsaturation(float)))], [])
    HRESULT SetSaturation(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionsaturationeffect-setsaturation(float)))], [])
    HRESULT SetSaturation(float ratio);
}

@GUID("a6a55bda-c09c-49f3-9193-a41922c89715")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionturbulenceeffect))], [])
interface IDCompositionTurbulenceEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionturbulenceeffect-setoffset))], [])
    HRESULT SetOffset(const(D2D_VECTOR_2F)* offset);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionturbulenceeffect-setbasefrequency))], [])
    HRESULT SetBaseFrequency(const(D2D_VECTOR_2F)* frequency);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionturbulenceeffect-setsize))], [])
    HRESULT SetSize(const(D2D_VECTOR_2F)* size);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionturbulenceeffect-setnumoctaves))], [])
    HRESULT SetNumOctaves(uint numOctaves);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionturbulenceeffect-setseed))], [])
    HRESULT SetSeed(uint seed);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionturbulenceeffect-setnoise))], [])
    HRESULT SetNoise(D2D1_TURBULENCE_NOISE noise);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionturbulenceeffect-setstitchable))], [])
    HRESULT SetStitchable(BOOL stitchable);
}

@GUID("4305ee5b-c4a0-4c88-9385-67124e017683")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionlineartransfereffect))], [])
interface IDCompositionLinearTransferEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setredyintercept(float)))], [])
    HRESULT SetRedYIntercept(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setredyintercept(float)))], [])
    HRESULT SetRedYIntercept(float redYIntercept);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setredslope(float)))], [])
    HRESULT SetRedSlope(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setredslope(float)))], [])
    HRESULT SetRedSlope(float redSlope);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setreddisable))], [])
    HRESULT SetRedDisable(BOOL redDisable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setgreenyintercept(idcompositionanimation)))], [])
    HRESULT SetGreenYIntercept(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setgreenyintercept(idcompositionanimation)))], [])
    HRESULT SetGreenYIntercept(float greenYIntercept);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setgreenslope(float)))], [])
    HRESULT SetGreenSlope(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setgreenslope(float)))], [])
    HRESULT SetGreenSlope(float greenSlope);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setgreendisable))], [])
    HRESULT SetGreenDisable(BOOL greenDisable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setblueyintercept(idcompositionanimation)))], [])
    HRESULT SetBlueYIntercept(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setblueyintercept(idcompositionanimation)))], [])
    HRESULT SetBlueYIntercept(float blueYIntercept);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setblueslope(float)))], [])
    HRESULT SetBlueSlope(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setblueslope(float)))], [])
    HRESULT SetBlueSlope(float blueSlope);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setbluedisable))], [])
    HRESULT SetBlueDisable(BOOL blueDisable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setalphayintercept(float)))], [])
    HRESULT SetAlphaYIntercept(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setalphayintercept(float)))], [])
    HRESULT SetAlphaYIntercept(float alphaYIntercept);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setalphaslope(float)))], [])
    HRESULT SetAlphaSlope(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setalphaslope(float)))], [])
    HRESULT SetAlphaSlope(float alphaSlope);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setalphadisable))], [])
    HRESULT SetAlphaDisable(BOOL alphaDisable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionlineartransfereffect-setclampoutput))], [])
    HRESULT SetClampOutput(BOOL clampOutput);
}

@GUID("9b7e82e2-69c5-4eb4-a5f5-a7033f5132cd")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositiontabletransfereffect))], [])
interface IDCompositionTableTransferEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setredtable))], [])
    HRESULT SetRedTable(const(float)* tableValues, uint count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setgreentable))], [])
    HRESULT SetGreenTable(const(float)* tableValues, uint count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setbluetable))], [])
    HRESULT SetBlueTable(const(float)* tableValues, uint count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setalphatable))], [])
    HRESULT SetAlphaTable(const(float)* tableValues, uint count);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setreddisable))], [])
    HRESULT SetRedDisable(BOOL redDisable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setgreendisable))], [])
    HRESULT SetGreenDisable(BOOL greenDisable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setbluedisable))], [])
    HRESULT SetBlueDisable(BOOL blueDisable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setalphadisable))], [])
    HRESULT SetAlphaDisable(BOOL alphaDisable);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setclampoutput))], [])
    HRESULT SetClampOutput(BOOL clampOutput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setredtablevalue(uint_idcompositionanimation)))], [])
    HRESULT SetRedTableValue(uint index, IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setredtablevalue(uint_idcompositionanimation)))], [])
    HRESULT SetRedTableValue(uint index, float value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setgreentablevalue(uint_idcompositionanimation)))], [])
    HRESULT SetGreenTableValue(uint index, IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setgreentablevalue(uint_idcompositionanimation)))], [])
    HRESULT SetGreenTableValue(uint index, float value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setbluetablevalue(uint_idcompositionanimation)))], [])
    HRESULT SetBlueTableValue(uint index, IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setbluetablevalue(uint_idcompositionanimation)))], [])
    HRESULT SetBlueTableValue(uint index, float value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setalphatablevalue(uint_idcompositionanimation)))], [])
    HRESULT SetAlphaTableValue(uint index, IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositiontabletransfereffect-setalphatablevalue(uint_idcompositionanimation)))], [])
    HRESULT SetAlphaTableValue(uint index, float value);
}

@GUID("576616c0-a231-494d-a38d-00fd5ec4db46")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositioncompositeeffect))], [])
interface IDCompositionCompositeEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositioncompositeeffect-setmode))], [])
    HRESULT SetMode(D2D1_COMPOSITE_MODE mode);
}

@GUID("33ecdc0a-578a-4a11-9c14-0cb90517f9c5")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionblendeffect))], [])
interface IDCompositionBlendEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionblendeffect-setmode))], [])
    HRESULT SetMode(D2D1_BLEND_MODE mode);
}

@GUID("3b67dfa8-e3dd-4e61-b640-46c2f3d739dc")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionarithmeticcompositeeffect))], [])
interface IDCompositionArithmeticCompositeEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setcoefficients))], [])
    HRESULT SetCoefficients(const(D2D_VECTOR_4F)* coefficients);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setclampoutput))], [])
    HRESULT SetClampOutput(BOOL clampoutput);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setcoefficient1(float)))], [])
    HRESULT SetCoefficient1(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setcoefficient1(float)))], [])
    HRESULT SetCoefficient1(float Coeffcient1);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setcoefficient2(idcompositionanimation)))], [])
    HRESULT SetCoefficient2(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setcoefficient2(idcompositionanimation)))], [])
    HRESULT SetCoefficient2(float Coefficient2);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setcoefficient3(float)))], [])
    HRESULT SetCoefficient3(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setcoefficient3(float)))], [])
    HRESULT SetCoefficient3(float Coefficient3);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setcoefficient4(float)))], [])
    HRESULT SetCoefficient4(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionarithmeticcompositeeffect-setcoefficient4(float)))], [])
    HRESULT SetCoefficient4(float Coefficient4);
}

@GUID("0b74b9e8-cdd6-492f-bbbc-5ed32157026d")
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nn-dcomp-idcompositionaffinetransform2deffect))], [])
interface IDCompositionAffineTransform2DEffect : IDCompositionFilterEffect
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionaffinetransform2deffect-setinterpolationmode))], [])
    HRESULT SetInterpolationMode(D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE interpolationMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionaffinetransform2deffect-setbordermode))], [])
    HRESULT SetBorderMode(D2D1_BORDER_MODE borderMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionaffinetransform2deffect-settransformmatrix))], [])
    HRESULT SetTransformMatrix(const(D2D_MATRIX_3X2_F)* transformMatrix);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionaffinetransform2deffect-settransformmatrixelement(int_int_idcompositionanimation)))], [])
    HRESULT SetTransformMatrixElement(int row, int column, IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionaffinetransform2deffect-settransformmatrixelement(int_int_idcompositionanimation)))], [])
    HRESULT SetTransformMatrixElement(int row, int column, float value);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionaffinetransform2deffect-setsharpness(float)))], [])
    HRESULT SetSharpness(IDCompositionAnimation animation);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcomp/nf-dcomp-idcompositionaffinetransform2deffect-setsharpness(float)))], [])
    HRESULT SetSharpness(float sharpness);
}

@GUID("c2448e9b-547d-4057-8cf5-8144ede1c2da")
interface IDCompositionDelegatedInkTrail : IUnknown
{
    HRESULT AddTrailPoints(const(DCompositionInkTrailPoint)* inkPoints, uint inkPointsCount, uint* generationId);
    HRESULT AddTrailPointsWithPrediction(const(DCompositionInkTrailPoint)* inkPoints, uint inkPointsCount, 
                                         const(DCompositionInkTrailPoint)* predictedInkPoints, 
                                         uint predictedInkPointsCount, uint* generationId);
    HRESULT RemoveTrailPoints(uint generationId);
    HRESULT StartNewTrail(const(D2D1_COLOR_F)* color);
}

@GUID("df0c7cec-cdeb-4d4a-b91c-721bf22f4e6c")
interface IDCompositionInkTrailDevice : IUnknown
{
    HRESULT CreateDelegatedInkTrail(IDCompositionDelegatedInkTrail* inkTrail);
    HRESULT CreateDelegatedInkTrailForSwapChain(IUnknown swapChain, IDCompositionDelegatedInkTrail* inkTrail);
}

@GUID("929bb1aa-725f-433b-abd7-273075a835f2")
interface IDCompositionTexture : IUnknown
{
    HRESULT SetSourceRect(const(D2D_RECT_U)* sourceRect);
    HRESULT SetColorSpace(DXGI_COLOR_SPACE_TYPE colorSpace);
    HRESULT SetAlphaMode(DXGI_ALPHA_MODE alphaMode);
    HRESULT GetAvailableFence(ulong* fenceValue, const(GUID)* iid, void** availableFence);
}

@GUID("85fc5cca-2da6-494c-86b6-4a775c049b8a")
interface IDCompositionDevice4 : IDCompositionDevice3
{
    HRESULT CheckCompositionTextureSupport(IUnknown renderingDevice, BOOL* supportsCompositionTextures);
    HRESULT CreateCompositionTexture(IUnknown d3dTexture, IDCompositionTexture* compositionTexture);
}

@GUID("a1de1d3f-6405-447f-8e95-1383a34b0277")
interface IDCompositionDynamicTexture : IUnknown
{
    HRESULT SetTexture(IDCompositionTexture pTexture, const(RECT)* pRects, size_t rectCount);
    HRESULT SetTexture(IDCompositionTexture pTexture);
}

@GUID("2c6bebfe-a603-472f-af34-d2443356e61b")
interface IDCompositionDevice5 : IDCompositionDevice4
{
    HRESULT CreateDynamicTexture(IDCompositionDynamicTexture* compositionDynamicTexture);
}


// GUIDs


const GUID IID_IDCompositionAffineTransform2DEffect   = GUIDOF!IDCompositionAffineTransform2DEffect;
const GUID IID_IDCompositionAnimation                 = GUIDOF!IDCompositionAnimation;
const GUID IID_IDCompositionArithmeticCompositeEffect = GUIDOF!IDCompositionArithmeticCompositeEffect;
const GUID IID_IDCompositionBlendEffect               = GUIDOF!IDCompositionBlendEffect;
const GUID IID_IDCompositionBrightnessEffect          = GUIDOF!IDCompositionBrightnessEffect;
const GUID IID_IDCompositionClip                      = GUIDOF!IDCompositionClip;
const GUID IID_IDCompositionColorMatrixEffect         = GUIDOF!IDCompositionColorMatrixEffect;
const GUID IID_IDCompositionCompositeEffect           = GUIDOF!IDCompositionCompositeEffect;
const GUID IID_IDCompositionDelegatedInkTrail         = GUIDOF!IDCompositionDelegatedInkTrail;
const GUID IID_IDCompositionDesktopDevice             = GUIDOF!IDCompositionDesktopDevice;
const GUID IID_IDCompositionDevice                    = GUIDOF!IDCompositionDevice;
const GUID IID_IDCompositionDevice2                   = GUIDOF!IDCompositionDevice2;
const GUID IID_IDCompositionDevice3                   = GUIDOF!IDCompositionDevice3;
const GUID IID_IDCompositionDevice4                   = GUIDOF!IDCompositionDevice4;
const GUID IID_IDCompositionDevice5                   = GUIDOF!IDCompositionDevice5;
const GUID IID_IDCompositionDeviceDebug               = GUIDOF!IDCompositionDeviceDebug;
const GUID IID_IDCompositionDynamicTexture            = GUIDOF!IDCompositionDynamicTexture;
const GUID IID_IDCompositionEffect                    = GUIDOF!IDCompositionEffect;
const GUID IID_IDCompositionEffectGroup               = GUIDOF!IDCompositionEffectGroup;
const GUID IID_IDCompositionFilterEffect              = GUIDOF!IDCompositionFilterEffect;
const GUID IID_IDCompositionGaussianBlurEffect        = GUIDOF!IDCompositionGaussianBlurEffect;
const GUID IID_IDCompositionHueRotationEffect         = GUIDOF!IDCompositionHueRotationEffect;
const GUID IID_IDCompositionInkTrailDevice            = GUIDOF!IDCompositionInkTrailDevice;
const GUID IID_IDCompositionLinearTransferEffect      = GUIDOF!IDCompositionLinearTransferEffect;
const GUID IID_IDCompositionMatrixTransform           = GUIDOF!IDCompositionMatrixTransform;
const GUID IID_IDCompositionMatrixTransform3D         = GUIDOF!IDCompositionMatrixTransform3D;
const GUID IID_IDCompositionRectangleClip             = GUIDOF!IDCompositionRectangleClip;
const GUID IID_IDCompositionRotateTransform           = GUIDOF!IDCompositionRotateTransform;
const GUID IID_IDCompositionRotateTransform3D         = GUIDOF!IDCompositionRotateTransform3D;
const GUID IID_IDCompositionSaturationEffect          = GUIDOF!IDCompositionSaturationEffect;
const GUID IID_IDCompositionScaleTransform            = GUIDOF!IDCompositionScaleTransform;
const GUID IID_IDCompositionScaleTransform3D          = GUIDOF!IDCompositionScaleTransform3D;
const GUID IID_IDCompositionShadowEffect              = GUIDOF!IDCompositionShadowEffect;
const GUID IID_IDCompositionSkewTransform             = GUIDOF!IDCompositionSkewTransform;
const GUID IID_IDCompositionSurface                   = GUIDOF!IDCompositionSurface;
const GUID IID_IDCompositionSurfaceFactory            = GUIDOF!IDCompositionSurfaceFactory;
const GUID IID_IDCompositionTableTransferEffect       = GUIDOF!IDCompositionTableTransferEffect;
const GUID IID_IDCompositionTarget                    = GUIDOF!IDCompositionTarget;
const GUID IID_IDCompositionTexture                   = GUIDOF!IDCompositionTexture;
const GUID IID_IDCompositionTransform                 = GUIDOF!IDCompositionTransform;
const GUID IID_IDCompositionTransform3D               = GUIDOF!IDCompositionTransform3D;
const GUID IID_IDCompositionTranslateTransform        = GUIDOF!IDCompositionTranslateTransform;
const GUID IID_IDCompositionTranslateTransform3D      = GUIDOF!IDCompositionTranslateTransform3D;
const GUID IID_IDCompositionTurbulenceEffect          = GUIDOF!IDCompositionTurbulenceEffect;
const GUID IID_IDCompositionVirtualSurface            = GUIDOF!IDCompositionVirtualSurface;
const GUID IID_IDCompositionVisual                    = GUIDOF!IDCompositionVisual;
const GUID IID_IDCompositionVisual2                   = GUIDOF!IDCompositionVisual2;
const GUID IID_IDCompositionVisual3                   = GUIDOF!IDCompositionVisual3;
const GUID IID_IDCompositionVisualDebug               = GUIDOF!IDCompositionVisualDebug;
