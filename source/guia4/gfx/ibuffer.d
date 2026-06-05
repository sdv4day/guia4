module guia4.gfx.ibuffer;

import guia4.gfx.types;

interface IBuffer
{
    BufferDesc desc() const @property nothrow;
    uint size() const @property nothrow;
    uint stride() const @property nothrow;
    BufferType bufferType() const @property nothrow;

    // Upload data to buffer
    void upload(const void* data, uint dataSize);
}