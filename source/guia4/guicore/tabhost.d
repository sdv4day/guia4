module guia4.guicore.tabhost;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * TabHost — 标签页容器
 *
 * 包含多个子页面，根据 activeIndex 显示对应页面。
 * 只渲染 activeIndex 对应的子控件。
 */
class TabHost : Control
{
    private int _activeIndex = 0;

    this()
    {
        width = 300;
        height = 200;
    }

    this(Control parent)
    {
        this();
        if (parent)
            parent.addChild(this);
    }

    /// 当前活跃页面索引
    int activeIndex() const @property { return _activeIndex; }
    void activeIndex(int v) @property
    {
        if (_activeIndex != v)
        {
            _activeIndex = v;
            markDirty(DirtyBits.Visual);
        }
    }

    /// 页面数量
    int pageCount() @property { return cast(int)children().length; }

    /// 添加一个页面（Control 作为页面容器）
    void addPage(Control page)
    {
        addChild(page);
        // 页面位置固定为 (0,0)，大小在 renderWithGDI 中同步
        page.x(0);
        page.y(0);
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("TabHost.renderWithGDI() at (", x(), ",", y(), ") activeIndex=", _activeIndex);

        // 只渲染 activeIndex 对应的子控件
        auto kids = children();
        if (_activeIndex >= 0 && _activeIndex < cast(int)kids.length)
        {
            auto page = kids[_activeIndex];
            if (page.visible())
            {
                int pageX = x();
                int pageY = y();
                int pageW = width();
                int pageH = height();

                // 设置页面尺寸（不设位置，因为用 DC 偏移）
                page.width(pageW);
                page.height(pageH);

                // 使用 DC 坐标偏移渲染页面内容
                // SaveDC 保存当前状态
                // IntersectClipRect 裁剪到 TabHost 区域
                // OffsetViewportOrgEx 将原点偏移到 TabHost 位置
                // 这样子控件用相对坐标（如 x=10, y=10）渲染时，
                // GDI 实际绘制在 (pageX+10, pageY+10)
                int savedDC = SaveDC(hdc);
                IntersectClipRect(hdc, pageX, pageY, pageX + pageW, pageY + pageH);
                POINT oldOrigin;
                OffsetViewportOrgEx(hdc, pageX, pageY, &oldOrigin);

                // 临时将 page 位置设为 (0,0)，这样 page.renderWithGDI 
                // 内部使用 x()/y() 渲染时坐标是相对的
                int origPageX = page.x();
                int origPageY = page.y();
                page.x(0);
                page.y(0);

                // 渲染 page 本身（如果有自定义渲染）
                page.renderWithGDI(hdc.Value);

                // 渲染 page 的子控件（Control 基类不会自动渲染子控件）
                foreach (child; page.children())
                {
                    if (child.visible())
                        child.renderWithGDI(hdc.Value);
                }

                // 恢复 page 原始位置
                page.x(origPageX);
                page.y(origPageY);

                // 恢复 DC 状态
                RestoreDC(hdc, savedDC);
            }
        }
    }


    override void render() {}
}