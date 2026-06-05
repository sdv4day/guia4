module guia4.gfx.icommandlist;

import guia4.gfx.types;
import guia4.gfx.itexture;
import guia4.gfx.ibuffer;
import guia4.gfx.irendertarget;
import guia4.gfx.ipipeline;

interface ICommandList
{
    // Begin recording
    void begin();

    // End recording
    void end();

    // Set render target
    void setRenderTarget(IRenderTarget rt);

    // Clear render target
    void clearRenderTarget(IRenderTarget rt, Color color);

    // Set viewport
    void setViewport(Viewport vp);

    // Set scissor rect
    void setScissorRect(Rect rect);

    // Set pipeline state
    void setPipeline(IPipeline pipeline);

    // Set vertex buffer
    void setVertexBuffer(uint slot, IBuffer buffer, uint offset = 0);

    // Set index buffer
    void setIndexBuffer(IBuffer buffer, uint offset = 0);

    // Set constant buffer
    void setConstantBuffer(uint slot, IBuffer buffer, ShaderStage stage);

    // Set texture
    void setTexture(uint slot, ITexture texture, ShaderStage stage);

    // Draw
    void draw(uint vertexCount, uint startVertex = 0);

    // Draw indexed
    void drawIndexed(uint indexCount, uint startIndex = 0, int baseVertex = 0);

    // Resource barrier for texture transition
    void textureBarrier(ITexture texture, ResourceUsage before, ResourceUsage after);

    // Copy texture
    void copyTexture(ITexture dst, ITexture src);
}