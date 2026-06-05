module guia4.gfx.ipipeline;

import guia4.gfx.types;

interface IPipeline
{
    // Get blend description
    BlendDesc blendDesc() const nothrow;
}