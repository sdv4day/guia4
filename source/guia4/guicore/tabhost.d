module guia4.guicore.tabhost;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.theme;
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

    this(Control parent)
    {
        super(parent);
        width = 300;
        height = 200;
        rendersChildren = true;  // 自己渲染子控件，防止递归重复渲染
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
        page.setXY(0, 0);
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("TabHost.renderWithGDI() size=(", width(), ",", height(), ") activeIndex=", _activeIndex);

        // 确保布局已执行
        ensureLayout();

        // 只渲染 activeIndex 对应的子控件
        auto kids = children();
        if (_activeIndex >= 0 && _activeIndex < cast(int)kids.length)
        {
            auto page = kids[_activeIndex];
            if (page.visible())
            {
                int pageW = width();
                int pageH = height();

                // 设置页面尺寸
                page.width(pageW);
                page.height(pageH);

                int savedDC = SaveDC(hdc);
                // 裁剪到 TabHost 区域（相对于父控件的本地坐标）
                IntersectClipRect(hdc, 0, 0, pageW, pageH);

                // 偏移视口到 TabHost 在父控件中的位置
                POINT hostOrigin;
                OffsetViewportOrgEx(hdc, position().x(), position().y(), &hostOrigin);

                // 填充 TabHost 背景
                RECT bgRect = {0, 0, pageW, pageH};
                HBRUSH bgBrush = CreateSolidBrush(Theme.crContainerBg());
                FillRect(hdc, &bgRect, bgBrush);
                DeleteObject(cast(HGDIOBJ)bgBrush);

                // 渲染 page 本身（如果有自定义渲染）
                page.renderWithGDI(hdc.Value);

                // 渲染 page 的子控件，对每个子控件偏移视口到其位置
                foreach (child; page.children())
                {
                    if (child.visible())
                    {
                        POINT childOrigin;
                        OffsetViewportOrgEx(hdc, child.position().x(), child.position().y(), &childOrigin);
                        child.renderWithGDI(hdc.Value);
                        SetViewportOrgEx(hdc, childOrigin.x, childOrigin.y, null);
                    }
                }

                // 恢复 DC 状态
                SetViewportOrgEx(hdc, hostOrigin.x, hostOrigin.y, null);
                RestoreDC(hdc, savedDC);
            }
        }
    }


    override void render() {}
}