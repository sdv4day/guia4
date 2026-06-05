module guia4.gfx.itexture;

import guia4.gfx.types;

interface ITexture
{
    TextureDesc desc() const @property nothrow;
    uint width() const @property nothrow;
    uint height() const @property nothrow;
    PixelFormat format() const @property nothrow;

    // Upload data to texture
    void upload(const void* data, uint rowPitch, uint slicePitch = 0);
}