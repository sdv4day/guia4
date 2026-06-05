module guia4.gfx.irendertarget;

import guia4.gfx.types;
import guia4.gfx.itexture;

interface IRenderTarget
{
    uint width() const @property nothrow;
    uint height() const @property nothrow;
    PixelFormat format() const @property nothrow;
    ITexture texture() const nothrow;

    // Clear the render target
    void clear(Color color, ClearFlags flags = ClearFlags.Color, float depth = 1.0f, ubyte stencil = 0);
}