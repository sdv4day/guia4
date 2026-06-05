module guia4.gfx.irenderdevice;

import guia4.gfx.types;
import guia4.gfx.itexture;
import guia4.gfx.ibuffer;
import guia4.gfx.irendertarget;
import guia4.gfx.ipipeline;
import guia4.gfx.icommandlist;

interface IRenderDevice
{
    // Create texture
    ITexture createTexture(TextureDesc desc);

    // Create buffer
    IBuffer createBuffer(BufferDesc desc);

    // Create render target from texture
    IRenderTarget createRenderTarget(ITexture texture);

    // Create command list
    ICommandList createCommandList();

    // Execute command list
    void executeCommandList(ICommandList cmdList);

    // Present (swap chain)
    void present(uint syncInterval = 1);

    // Resize back buffer
    void resize(uint width, uint height);

    // Get back buffer render target
    IRenderTarget backBuffer() nothrow;

    // Get device capabilities
    uint maxTextureSize() const nothrow;
    bool supportsTearing() const nothrow;
}