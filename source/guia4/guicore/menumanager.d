module guia4.guicore.menumanager;

import guia4.guicore.control;
import guia4.guicore.menubar;
import guia4.utils.logger;

/**
 * MenuManager — 菜单管理器
 *
 * 负责：
 * - 关闭所有展开的菜单
 * - 更新子菜单项的悬停状态
 */
class MenuManager
{
    private Control _owner;

    // 重绘委托
    private void delegate() _requestRedraw;

    this(Control owner)
    {
        _owner = owner;
    }

    /// 设置重绘委托
    void setRequestRedrawDelegate(void delegate() requestRedraw)
    {
        _requestRedraw = requestRedraw;
    }

    /// 关闭所有展开的菜单
    void closeAllMenus()
    {
        foreach (child; _owner.children())
        {
            auto mb = cast(MenuBar)child;
            if (mb !is null)
                mb.closeAll();
        }
    }

    /// 检查点击位置是否在菜单区域内
    bool isMenuArea(int px, int py, Control target)
    {
        auto targetMenuBar = cast(MenuBar)target;
        auto targetMenuItem = cast(MenuItem)target;
        if (targetMenuBar !is null || targetMenuItem !is null)
            return true;

        // 检查 target 的父级是否是 MenuBar
        Control p = target.parent();
        while (p !is null)
        {
            if (cast(MenuBar)p !is null)
                return true;
            p = p.parent();
        }
        return false;
    }

    /// 检查并点击子菜单项
    bool handleClickOnSubItem(int px, int py)
    {
        foreach (child; _owner.children())
        {
            auto mb = cast(MenuBar)child;
            if (mb !is null && mb.hasOpenMenu())
            {
                auto subItem = mb.hitTestSubMenu(px, py);
                if (subItem !is null)
                {
                    subItem.fireClick(px, py);
                    return true;
                }
            }
        }
        return false;
    }

    /// 更新子菜单项的悬停状态
    void updateSubMenuHover(MenuBar mb, int mx, int my)
    {
        foreach (child; mb.children())
        {
            auto mi = cast(MenuItem)child;
            if (mi !is null && mi.menuOpen())
            {
                updateSubItemHover(mi, mx, my);
            }
        }
    }

    private void updateSubItemHover(MenuItem parentItem, int mx, int my)
    {
        foreach (subItem; parentItem.subItems())
        {
            bool inItem = mx >= subItem.position().x() && mx < subItem.position().x() + subItem.width() &&
                          my >= subItem.position().y() && my < subItem.position().y() + subItem.height();
            if (inItem && !subItem.hovered())
            {
                subItem.hovered(true);
                _requestRedraw();
            }
            else if (!inItem && subItem.hovered())
            {
                subItem.hovered(false);
                _requestRedraw();
            }
            if (subItem.menuOpen())
            {
                updateSubItemHover(subItem, mx, my);
            }
        }
    }
}
