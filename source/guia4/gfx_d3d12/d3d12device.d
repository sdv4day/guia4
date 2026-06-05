module guia4.gfx_d3d12.d3d12device;

import guia4.gfx;
import guia4.gfx_d3d12.d3d12texture;
import guia4.gfx_d3d12.d3d12buffer;
import guia4.gfx_d3d12.d3d12rendertarget;
import guia4.gfx_d3d12.d3d12commandlist;
import windows.win32.foundation;

class D3D12RenderDevice : IRenderDevice
{
    this(void* hwnd)
    {
    }
    
    ITexture createTexture(TextureDesc desc)
    {
        return new D3D12Texture(desc);
    }
    
    IBuffer createBuffer(BufferDesc desc)
    {
        return new D3D12Buffer(desc);
    }
    
    IRenderTarget createRenderTarget(ITexture texture)
    {
        return new D3D12RenderTarget(texture);
    }
    
    ICommandList createCommandList()
    {
        return new D3D12CommandList();
    }
    
    void executeCommandList(ICommandList cmdList)
    {
    }
    
    void present(uint syncInterval = 1)
    {
    }
    
    void resize(uint width, uint height)
    {
    }
    
    IRenderTarget backBuffer() nothrow
    {
        return null;
    }
    
    uint maxTextureSize() const nothrow
    {
        return 16384;
    }
    
    bool supportsTearing() const nothrow
    {
        return true;
    }
    
    ~this()
    {
    }
}