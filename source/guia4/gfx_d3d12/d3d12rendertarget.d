module guia4.gfx_d3d12.d3d12rendertarget;

import guia4.gfx;

class D3D12RenderTarget : IRenderTarget
{
    private ITexture _texture;
    
    this(ITexture texture)
    {
        _texture = texture;
    }
    
    uint width() const @property nothrow { return _texture.width(); }
    uint height() const @property nothrow { return _texture.height(); }
    PixelFormat format() const @property nothrow { return _texture.format(); }
    ITexture texture() const nothrow { return cast(ITexture)_texture; }
    
    void clear(Color color, ClearFlags flags = ClearFlags.Color, float depth = 1.0f, ubyte stencil = 0) { }
}