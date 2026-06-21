module guia4.guicore.container;

import guia4.guicore.control;
import guia4.platform_win32.win32defs;
import guia4.utils.logger;
import windows.win32.graphics.gdi;

/**
 * Container — 透明布局容器
 *
 * 仅用于分组和布局管理，不绘制任何视觉内容（无背景、无边框、无圆角）。
 * 自己负责渲染子控件。
 */
class Container : Control
{
    this(Control parent)
    {
        super(parent);
        rendersChildren = true;
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        if (children().length == 0)
            return;
        ensureLayout();
        foreach (child; children())
        {
            if (!child.visible())
                continue;
            int savedDC = SaveDC(hdc);
            POINT oldOrigin;
            OffsetViewportOrgEx(hdc, child.position().x(), child.position().y(), &oldOrigin);
            child.renderWithGDI(hdc_);
            SetViewportOrgEx(hdc, oldOrigin.x, oldOrigin.y, null);
            RestoreDC(hdc, savedDC);
        }
    }
}
