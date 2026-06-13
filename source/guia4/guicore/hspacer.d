module guia4.guicore.hspacer;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import windows.win32.graphics.gdi;

/**
 * HSpacer — 水平占位符
 *
 * 空控件，用于在布局中填充水平空间。
 * 不渲染任何内容。
 */
class HSpacer : Control
{
    this(Control parent)
    {
        super(parent);
        width = 1;
        height = 1;
        logTrace("HSpacer.ctor(parent)");
    }

    this(Control parent, int w)
    {
        super(parent);
        width = w;
        height = 1;
        logTrace("HSpacer.ctor(parent, w=", w, ")");
    }

    override void renderWithGDI(void* hdc_)
    {
        // 不渲染任何内容
    }

    override void render()
    {
    }
}
