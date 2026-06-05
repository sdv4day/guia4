module guia4.gfx_d3d12.d3d12pipeline;

import guia4.gfx;

class D3D12Pipeline : IPipeline
{
    BlendDesc blendDesc() const nothrow { return BlendDesc.init; }
}