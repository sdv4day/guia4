module guia4.gfx.types;

// Pixel format
enum PixelFormat
{
    Unknown,
    R8G8B8A8_UNORM,
    B8G8R8A8_UNORM,
    R8_UNORM,
    D24_UNORM_S8_UINT,
    D32_FLOAT,
    BC1_UNORM,  // DXT1
    BC2_UNORM,  // DXT3
    BC3_UNORM,  // DXT5
}

// Blend mode
enum BlendMode
{
    None,
    Zero,
    One,
    Alpha,
    Additive,
    Premultiplied,
}

// Primitive topology
enum PrimitiveTopology
{
    PointList,
    LineList,
    LineStrip,
    TriangleList,
    TriangleStrip,
}

// Resource usage
enum ResourceUsage
{
    Default,
    Upload,
    Readback,
}

// Buffer type
enum BufferType
{
    Vertex,
    Index,
    Constant,
}

// Texture dimension
enum TextureDimension
{
    Unknown,
    Texture1D,
    Texture2D,
    Texture3D,
}

// Shader stage
enum ShaderStage
{
    Vertex,
    Pixel,
    Compute,
}

// Clear flags
enum ClearFlags : uint
{
    Color   = 0x1,
    Depth   = 0x2,
    Stencil = 0x4,
}

// Viewport
struct Viewport
{
    float x;
    float y;
    float width;
    float height;
    float minDepth;
    float maxDepth;
}

// Rect (scissor/clip)
struct Rect
{
    int left;
    int top;
    int right;
    int bottom;
}

// Color (RGBA float)
struct Color
{
    float r, g, b, a;
    static Color opCall(float r, float g, float b, float a = 1.0f)
    {
        Color c;
        c.r = r; c.g = g; c.b = b; c.a = a;
        return c;
    }
}

// Texture description
struct TextureDesc
{
    uint width;
    uint height;
    uint depth = 1;
    uint mipLevels = 1;
    uint arraySize = 1;
    PixelFormat format;
    TextureDimension dimension;
    ResourceUsage usage;
    uint sampleCount = 1;
    uint sampleQuality = 0;
    bool renderTarget = false;
    bool depthStencil = false;
    bool shaderResource = true;
}

// Buffer description
struct BufferDesc
{
    uint size;
    uint stride;
    BufferType type;
    ResourceUsage usage;
}

// Blend description
struct BlendDesc
{
    bool blendEnable = false;
    BlendMode srcBlend = BlendMode.One;
    BlendMode destBlend = BlendMode.Zero;
    BlendMode srcBlendAlpha = BlendMode.One;
    BlendMode destBlendAlpha = BlendMode.Zero;
}