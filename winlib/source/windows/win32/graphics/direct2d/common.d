// Written in the D programming language.

module windows.win32.graphics.direct2d.common;

public import windows.core;
public import windows.win32.foundation : HRESULT;
public import windows.win32.graphics.dxgi.common : DXGI_FORMAT;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums

//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ne-dcommon-d2d1_alpha_mode))], [])

alias D2D1_ALPHA_MODE = int;
enum : int
{
    D2D1_ALPHA_MODE_UNKNOWN       = 0x00000000,
    D2D1_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    D2D1_ALPHA_MODE_STRAIGHT      = 0x00000002,
    D2D1_ALPHA_MODE_IGNORE        = 0x00000003,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_figure_begin))], [])

alias D2D1_FIGURE_BEGIN = int;
enum : int
{
    D2D1_FIGURE_BEGIN_FILLED = 0x00000000,
    D2D1_FIGURE_BEGIN_HOLLOW = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_figure_end))], [])

alias D2D1_FIGURE_END = int;
enum : int
{
    D2D1_FIGURE_END_OPEN   = 0x00000000,
    D2D1_FIGURE_END_CLOSED = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_path_segment))], [])

alias D2D1_PATH_SEGMENT = int;
enum : int
{
    D2D1_PATH_SEGMENT_NONE                  = 0x00000000,
    D2D1_PATH_SEGMENT_FORCE_UNSTROKED       = 0x00000001,
    D2D1_PATH_SEGMENT_FORCE_ROUND_LINE_JOIN = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/ne-d2d1-d2d1_fill_mode))], [])

alias D2D1_FILL_MODE = int;
enum : int
{
    D2D1_FILL_MODE_ALTERNATE = 0x00000000,
    D2D1_FILL_MODE_WINDING   = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_border_mode))], [])

alias D2D1_BORDER_MODE = int;
enum : int
{
    D2D1_BORDER_MODE_SOFT = 0x00000000,
    D2D1_BORDER_MODE_HARD = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_blend_mode))], [])

alias D2D1_BLEND_MODE = int;
enum : int
{
    D2D1_BLEND_MODE_MULTIPLY      = 0x00000000,
    D2D1_BLEND_MODE_SCREEN        = 0x00000001,
    D2D1_BLEND_MODE_DARKEN        = 0x00000002,
    D2D1_BLEND_MODE_LIGHTEN       = 0x00000003,
    D2D1_BLEND_MODE_DISSOLVE      = 0x00000004,
    D2D1_BLEND_MODE_COLOR_BURN    = 0x00000005,
    D2D1_BLEND_MODE_LINEAR_BURN   = 0x00000006,
    D2D1_BLEND_MODE_DARKER_COLOR  = 0x00000007,
    D2D1_BLEND_MODE_LIGHTER_COLOR = 0x00000008,
    D2D1_BLEND_MODE_COLOR_DODGE   = 0x00000009,
    D2D1_BLEND_MODE_LINEAR_DODGE  = 0x0000000a,
    D2D1_BLEND_MODE_OVERLAY       = 0x0000000b,
    D2D1_BLEND_MODE_SOFT_LIGHT    = 0x0000000c,
    D2D1_BLEND_MODE_HARD_LIGHT    = 0x0000000d,
    D2D1_BLEND_MODE_VIVID_LIGHT   = 0x0000000e,
    D2D1_BLEND_MODE_LINEAR_LIGHT  = 0x0000000f,
    D2D1_BLEND_MODE_PIN_LIGHT     = 0x00000010,
    D2D1_BLEND_MODE_HARD_MIX      = 0x00000011,
    D2D1_BLEND_MODE_DIFFERENCE    = 0x00000012,
    D2D1_BLEND_MODE_EXCLUSION     = 0x00000013,
    D2D1_BLEND_MODE_HUE           = 0x00000014,
    D2D1_BLEND_MODE_SATURATION    = 0x00000015,
    D2D1_BLEND_MODE_COLOR         = 0x00000016,
    D2D1_BLEND_MODE_LUMINOSITY    = 0x00000017,
    D2D1_BLEND_MODE_SUBTRACT      = 0x00000018,
    D2D1_BLEND_MODE_DIVISION      = 0x00000019,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_colormatrix_alpha_mode))], [])

alias D2D1_COLORMATRIX_ALPHA_MODE = int;
enum : int
{
    D2D1_COLORMATRIX_ALPHA_MODE_PREMULTIPLIED = 0x00000001,
    D2D1_COLORMATRIX_ALPHA_MODE_STRAIGHT      = 0x00000002,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_2daffinetransform_interpolation_mode))], [])

alias D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE = int;
enum : int
{
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR    = 0x00000000,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_LINEAR              = 0x00000001,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_CUBIC               = 0x00000002,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 0x00000003,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_ANISOTROPIC         = 0x00000004,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC  = 0x00000005,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1effects/ne-d2d1effects-d2d1_turbulence_noise))], [])

alias D2D1_TURBULENCE_NOISE = int;
enum : int
{
    D2D1_TURBULENCE_NOISE_FRACTAL_SUM = 0x00000000,
    D2D1_TURBULENCE_NOISE_TURBULENCE  = 0x00000001,
}
//ENUM ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1_1/ne-d2d1_1-d2d1_composite_mode))], [])

alias D2D1_COMPOSITE_MODE = int;
enum : int
{
    D2D1_COMPOSITE_MODE_SOURCE_OVER         = 0x00000000,
    D2D1_COMPOSITE_MODE_DESTINATION_OVER    = 0x00000001,
    D2D1_COMPOSITE_MODE_SOURCE_IN           = 0x00000002,
    D2D1_COMPOSITE_MODE_DESTINATION_IN      = 0x00000003,
    D2D1_COMPOSITE_MODE_SOURCE_OUT          = 0x00000004,
    D2D1_COMPOSITE_MODE_DESTINATION_OUT     = 0x00000005,
    D2D1_COMPOSITE_MODE_SOURCE_ATOP         = 0x00000006,
    D2D1_COMPOSITE_MODE_DESTINATION_ATOP    = 0x00000007,
    D2D1_COMPOSITE_MODE_XOR                 = 0x00000008,
    D2D1_COMPOSITE_MODE_PLUS                = 0x00000009,
    D2D1_COMPOSITE_MODE_SOURCE_COPY         = 0x0000000a,
    D2D1_COMPOSITE_MODE_BOUNDED_SOURCE_COPY = 0x0000000b,
    D2D1_COMPOSITE_MODE_MASK_INVERT         = 0x0000000c,
}

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Direct2D/d2d-color-f))], [])
struct D2D_COLOR_F
{
    float r;
    float g;
    float b;
    float a;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/Direct2D/d2d1-color-f))], [])
struct D2D1_COLOR_F
{
    float r;
    float g;
    float b;
    float a;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d1_pixel_format))], [])
struct D2D1_PIXEL_FORMAT
{
    DXGI_FORMAT     format;
    D2D1_ALPHA_MODE alphaMode;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_point_2u))], [])
struct D2D_POINT_2U
{
    uint x;
    uint y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_point_2f))], [])
struct D2D_POINT_2F
{
    float x;
    float y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_vector_2f))], [])
struct D2D_VECTOR_2F
{
    float x;
    float y;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_vector_3f))], [])
struct D2D_VECTOR_3F
{
    float x;
    float y;
    float z;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_vector_4f))], [])
struct D2D_VECTOR_4F
{
    float x;
    float y;
    float z;
    float w;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_rect_f))], [])
struct D2D_RECT_F
{
    float left;
    float top;
    float right;
    float bottom;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_rect_u))], [])
struct D2D_RECT_U
{
    uint left;
    uint top;
    uint right;
    uint bottom;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_size_f))], [])
struct D2D_SIZE_F
{
    float width;
    float height;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_size_u))], [])
struct D2D_SIZE_U
{
    uint width;
    uint height;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_matrix_3x2_f))], [])
struct D2D_MATRIX_3X2_F
{
union Anonymous
    {
struct Anonymous1
        {
            float m11;
            float m12;
            float m21;
            float m22;
            float dx;
            float dy;
        }
struct Anonymous2
        {
            float _11;
            float _12;
            float _21;
            float _22;
            float _31;
            float _32;
        }
        float[6] m;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_matrix_4x3_f))], [])
struct D2D_MATRIX_4X3_F
{
union Anonymous
    {
struct Anonymous
        {
            float _11;
            float _12;
            float _13;
            float _21;
            float _22;
            float _23;
            float _31;
            float _32;
            float _33;
            float _41;
            float _42;
            float _43;
        }
        float[12] m;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_matrix_4x4_f))], [])
struct D2D_MATRIX_4X4_F
{
union Anonymous
    {
struct Anonymous
        {
            float _11;
            float _12;
            float _13;
            float _14;
            float _21;
            float _22;
            float _23;
            float _24;
            float _31;
            float _32;
            float _33;
            float _34;
            float _41;
            float _42;
            float _43;
            float _44;
        }
        float[16] m;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/dcommon/ns-dcommon-d2d_matrix_5x4_f))], [])
struct D2D_MATRIX_5X4_F
{
union Anonymous
    {
struct Anonymous
        {
            float _11;
            float _12;
            float _13;
            float _14;
            float _21;
            float _22;
            float _23;
            float _24;
            float _31;
            float _32;
            float _33;
            float _34;
            float _41;
            float _42;
            float _43;
            float _44;
            float _51;
            float _52;
            float _53;
            float _54;
        }
        float[20] m;
    }
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_gradient_stop))], [])
struct D2D1_GRADIENT_STOP
{
    float        position;
    D2D1_COLOR_F color;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/ns-d2d1-d2d1_bezier_segment))], [])
struct D2D1_BEZIER_SEGMENT
{
    D2D_POINT_2F point1;
    D2D_POINT_2F point2;
    D2D_POINT_2F point3;
}

// Interfaces

@GUID("2cd9069e-12e2-11dc-9fed-001143a055f9")
//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
//INTERFACEF ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/nn-d2d1-id2d1simplifiedgeometrysink))], [])
//INTERFACEF ATTR: AgileAttribute : CustomAttributeSig([], [])
interface ID2D1SimplifiedGeometrySink : IUnknown
{
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1simplifiedgeometrysink-setfillmode))], [])
    void    SetFillMode(D2D1_FILL_MODE fillMode);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1simplifiedgeometrysink-setsegmentflags))], [])
    void    SetSegmentFlags(D2D1_PATH_SEGMENT vertexFlags);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1simplifiedgeometrysink-beginfigure))], [])
    void    BeginFigure(D2D_POINT_2F startPoint, D2D1_FIGURE_BEGIN figureBegin);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1simplifiedgeometrysink-addlines))], [])
    void    AddLines(const(D2D_POINT_2F)* points, uint pointsCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1simplifiedgeometrysink-addbeziers))], [])
    void    AddBeziers(const(D2D1_BEZIER_SEGMENT)* beziers, uint beziersCount);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1simplifiedgeometrysink-endfigure))], [])
    void    EndFigure(D2D1_FIGURE_END figureEnd);
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/d2d1/nf-d2d1-id2d1simplifiedgeometrysink-close))], [])
    HRESULT Close();
}


// GUIDs


const GUID IID_ID2D1SimplifiedGeometrySink = GUIDOF!ID2D1SimplifiedGeometrySink;
