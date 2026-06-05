module guia4.guicore.layer;

// Layer enum - rendering layers from back to front
enum Layer
{
    Background = 0,
    Content    = 1,
    Popup      = 2,
    Tooltip    = 3,
    Overlay    = 4,
    Count      = 5,
}

// Per-layer state
struct LayerState
{
    bool dirty = true; // start dirty so first frame renders
    // ControlList and RenderTarget will be managed by the renderer
    // through the gfx abstraction, not stored here directly
}