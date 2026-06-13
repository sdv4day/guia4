module guia4.guicore.vspacer;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import windows.win32.graphics.gdi;

/**
 * VSpacer — 垂直占位符
 *
 * 空控件，用于在布局中填充垂直空间。
 * 不渲染任何内容。
 */
class VSpacer : Control
{
    this(Control parent)
    {
        super(parent);
        width = 1;
        height = 1;
        logTrace("VSpacer.ctor(parent)");
    }

    this(Control parent, int h)
    {
        super(parent);
        width = 1;
        height = h;
        logTrace("VSpacer.ctor(parent, h=", h, ")");
    }

    override void renderWithGDI(void* hdc_)
    {
        // 不渲染任何内容
    }

    override void render()
    {
    }
}
