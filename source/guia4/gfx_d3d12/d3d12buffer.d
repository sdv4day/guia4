module guia4.gfx_d3d12.d3d12buffer;

import guia4.gfx;

class D3D12Buffer : IBuffer
{
    private BufferDesc _desc;
    
    this(BufferDesc desc)
    {
        _desc = desc;
    }
    
    BufferDesc desc() const @property nothrow { return _desc; }
    uint size() const @property nothrow { return _desc.size; }
    uint stride() const @property nothrow { return _desc.stride; }
    BufferType bufferType() const @property nothrow { return _desc.type; }
    
    void upload(const void* data, uint dataSize) { }
}