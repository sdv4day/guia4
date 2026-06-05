module guia4.gfx_d3d12.d3d12commandlist;

import guia4.gfx;

class D3D12CommandList : ICommandList
{
    void begin() { }
    void end() { }
    void setRenderTarget(IRenderTarget rt) { }
    void clearRenderTarget(IRenderTarget rt, Color color) { }
    void setViewport(Viewport vp) { }
    void setScissorRect(Rect rect) { }
    void setPipeline(IPipeline pipeline) { }
    void setVertexBuffer(uint slot, IBuffer buffer, uint offset = 0) { }
    void setIndexBuffer(IBuffer buffer, uint offset = 0) { }
    void setConstantBuffer(uint slot, IBuffer buffer, ShaderStage stage) { }
    void setTexture(uint slot, ITexture texture, ShaderStage stage) { }
    void draw(uint vertexCount, uint startVertex = 0) { }
    void drawIndexed(uint indexCount, uint startIndex = 0, int baseVertex = 0) { }
    void textureBarrier(ITexture texture, ResourceUsage before, ResourceUsage after) { }
    void copyTexture(ITexture dst, ITexture src) { }
}