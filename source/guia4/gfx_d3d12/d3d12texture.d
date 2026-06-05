module guia4.gfx_d3d12.d3d12texture;

import guia4.gfx;

class D3D12Texture : ITexture
{
    private TextureDesc _desc;
    
    this(TextureDesc desc)
    {
        _desc = desc;
    }
    
    TextureDesc desc() const @property nothrow { return _desc; }
    uint width() const @property nothrow { return _desc.width; }
    uint height() const @property nothrow { return _desc.height; }
    PixelFormat format() const @property nothrow { return _desc.format; }
    
    void upload(const void* data, uint rowPitch, uint slicePitch = 0) { }
}