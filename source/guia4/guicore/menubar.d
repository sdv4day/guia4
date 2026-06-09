module guia4.guicore.menubar;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import std.algorithm;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

class MenuBar : Control
{
    private struct ItemSlot
    {
        MenuItem item;
        int width;     /// computed text width + padding
    }
    private ItemSlot[] _slots;
    private uint _fontSize = 14;
    private int _itemPadding = 12;    /// horizontal padding per item
    private int _sidePadding = 8;     /// left/right padding for the whole bar

    this()
    {
        height = 24;
        logTrace("MenuBar.ctor()");
    }

    this(Control parent)
    {
        this();
        if (parent)
            parent.addChild(this);
    }

    /// 添加菜单项
    MenuItem add(string text)
    {
        auto item = new MenuItem(text);
        this.addChild(item);
        _slots ~= ItemSlot(item, 0);
        return item;
    }

    /// 关闭所有展开的子菜单
    void closeAll()
    {
        foreach (ref slot; _slots)
        {
            slot.item.closeMenu();
        }
        markDirty(DirtyBits.Visual);
    }

    /// 检查是否有任何菜单展开
    bool hasOpenMenu() const
    {
        foreach (ref slot; _slots)
        {
            if (slot.item._menuOpen)
                return true;
        }
        return false;
    }

    /// 命中测试子菜单项（递归检查展开的子菜单）
    MenuItem hitTestSubMenu(int px, int py)
    {
        foreach (ref slot; _slots)
        {
            if (slot.item._menuOpen)
            {
                auto hit = slot.item.hitTestSubMenu(px, py);
                if (hit !is null)
                    return hit;
            }
        }
        return null;
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("MenuBar.renderWithGDI() at (", x(), ",", y(), ")");

        int rx = x();
        int ry = y();
        int rw = width();
        int rh = height();

        // ── Background ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00E8E8E8);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // Bottom border
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        MoveToEx(hdc, rx, ry + rh - 1, null);
        LineTo(hdc, rx + rw, ry + rh - 1);
        SelectObject(hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── Layout + render items ──
        // 创建字体用于测量
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);

        int itemX = rx + _sidePadding;
        int itemY = ry;   // items span full height of MenuBar

        foreach (ref slot; _slots)
        {
            wstring textW = toUTF16(slot.item._text);
            SIZE textSize;
            GetTextExtentPointW(hdc, cast(const(PWSTR))textW.ptr,
                                cast(int)textW.length, &textSize);

            slot.width = textSize.cx + _itemPadding * 2;
            int itemW = slot.width;

            // Position the MenuItem control (absolute coords)
            slot.item.x(itemX);
            slot.item.y(itemY);
            slot.item.width(itemW);
            slot.item.height(rh);

            // Render the item
            slot.item.renderWithGDI(hdc.Value);

            itemX += itemW;
        }

        FontCache.release(hdc, fontEntry);
    }

    override void fireMouseDown(int mx, int my, int button)
    {
        // mx, my 已经是控件本地坐标（由 MainWindow clientToControl 转换）
        // slot.item.x()/y() 是绝对坐标，需要减去 MenuBar 的位置转为本地比较
        int barX = x();
        int barY = y();
        // 检查是否点击了某个 MenuItem
        foreach (ref slot; _slots)
        {
            int itemLocalX = slot.item.x() - barX;
            int itemLocalY = slot.item.y() - barY;
            if (mx >= itemLocalX && mx < itemLocalX + slot.width &&
                my >= itemLocalY && my < itemLocalY + slot.item.height())
            {
                if (slot.item.hasSubMenu())
                {
                    // 切换子菜单展开状态
                    slot.item._menuOpen = !slot.item._menuOpen;
                    // 关闭其他菜单
                    if (slot.item._menuOpen)
                    {
                        foreach (ref other; _slots)
                        {
                            if (other.item !is slot.item)
                                other.item.closeMenu();
                        }
                    }
                    markDirty(DirtyBits.Visual);
                }
                return;
            }
        }

        // 点击菜单栏空白处，关闭所有
        closeAll();
    }

    override void fireMouseMove(int mx, int my)
    {
        // mx, my 已经是控件本地坐标（由 MainWindow clientToControl 转换）
        int barX = x();
        int barY = y();
        // 如果有菜单展开，鼠标在菜单栏项上移动时切换展开的子菜单
        foreach (ref slot; _slots)
        {
            int itemLocalX = slot.item.x() - barX;
            int itemLocalY = slot.item.y() - barY;
            bool inSlot = mx >= itemLocalX && mx < itemLocalX + slot.width &&
                          my >= itemLocalY && my < itemLocalY + slot.item.height();

            if (inSlot && !slot.item._hovered)
            {
                slot.item._hovered = true;
                // 如果有其他菜单展开，切换到这个
                if (hasOpenMenu() && slot.item.hasSubMenu())
                {
                    closeAll();
                    slot.item._menuOpen = true;
                }
                markDirty(DirtyBits.Visual);
            }
            else if (!inSlot && slot.item._hovered)
            {
                slot.item._hovered = false;
                markDirty(DirtyBits.Visual);
            }
        }
    }

    override void render()
    {
    }
}

class MenuItem : Control
{
    package string _text;
    private uint _fontSize = 14;

    // Colors
    private COLORREF _textColor  = cast(COLORREF)0x00333333;
    private COLORREF _hoverBg    = cast(COLORREF)0x00D0D0D0;
    package bool _hovered = false;

    /// 获取/设置悬停状态（用于外部更新）
    bool hovered() const @property { return _hovered; }
    void hovered(bool v) @property { if (_hovered != v) { _hovered = v; markDirty(DirtyBits.Visual); } }

    // 子菜单支持
    package MenuItem[] _subItems;       /// 子菜单项列表
    package bool _menuOpen = false;     /// 子菜单是否展开

    this(string text = "MenuItem")
    {
        _text = text;
        width = 60;
        height = 20;
    }

    this(Control parent, string text)
    {
        this(text);
        if (parent)
            parent.addChild(this);
    }

    string text() const @property { return _text; }
    void text(string v) { _text = v; markDirty(DirtyBits.Visual); }

    /// 添加子菜单项
    MenuItem addSubItem(string text)
    {
        auto item = new MenuItem(text);
        _subItems ~= item;
        return item;
    }

    /// 是否有子菜单
    bool hasSubMenu() const @property { return _subItems.length > 0; }

    /// 子菜单是否展开
    bool menuOpen() const @property { return _menuOpen; }

    /// 获取子菜单项列表（用于外部遍历）
    MenuItem[] subItems() @property { return _subItems; }

    /// 关闭此菜单及其所有子菜单
    void closeMenu()
    {
        _menuOpen = false;
        _hovered = false;
        foreach (sub; _subItems)
        {
            sub.closeMenu();
        }
        markDirty(DirtyBits.Visual);
    }

    /// 关闭所有展开的子菜单（向上查找到 MenuBar）
    void closeAllMenus()
    {
        Control p = parent();
        while (p !is null)
        {
            auto mb = cast(MenuBar)p;
            if (mb !is null)
            {
                mb.closeAll();
                return;
            }
            p = p.parent();
        }
    }

    /// 命中测试子菜单项（递归检查展开的子菜单区域）
    MenuItem hitTestSubMenu(int px, int py)
    {
        if (!_menuOpen || _subItems.length == 0)
            return null;

        foreach (subItem; _subItems)
        {
            // 检查子项位置
            if (px >= subItem.x() && px < subItem.x() + subItem.width() &&
                py >= subItem.y() && py < subItem.y() + subItem.height())
            {
                return subItem;
            }
            // 递归检查子项的子菜单
            auto deeper = subItem.hitTestSubMenu(px, py);
            if (deeper !is null)
                return deeper;
        }
        return null;
    }

    override void fireClick(int x, int y)
    {
        if (hasSubMenu())
        {
            _menuOpen = !_menuOpen;
            markDirty(DirtyBits.Visual);
        }
        else
        {
            super.fireClick(x, y);
            // 点击叶子项后关闭所有菜单
            closeAllMenus();
        }
    }

    override void fireMouseMove(int x, int y)
    {
        // MainWindow sends (-1, -1) as a "mouse leave" sentinel.
        if (x < 0 || y < 0)
        {
            if (_hovered)
            {
                _hovered = false;
                markDirty(DirtyBits.Visual);
            }
        }
        else
        {
            if (!_hovered)
            {
                _hovered = true;
                markDirty(DirtyBits.Visual);
            }
        }
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("MenuItem.renderWithGDI() - '", _text, "' at (", x(), ",", y(), ")");

        int rx = x();
        int ry = y();
        int rw = width();
        int rh = height();

        // ── Hover background ──
        if (_hovered)
        {
            RECT hoverRect = {
                cast(LONG)rx, cast(LONG)ry,
                cast(LONG)(rx + rw), cast(LONG)(ry + rh)
            };
            HBRUSH hoverBrush = CreateSolidBrush(_hoverBg);
            FillRect(hdc, &hoverRect, hoverBrush);
            DeleteObject(cast(HGDIOBJ)hoverBrush);
        }

        // ── Text ──
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);

        SetTextColor(hdc, _textColor);
        SetBkMode(hdc, TRANSPARENT);

        wstring textW = toUTF16(_text);
        int textX = rx + 6;   // extra horizontal padding
        int textY = ry + (rh - cast(int)_fontSize) / 2;
        TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);

        // 如果有子菜单，绘制右侧箭头 ▶
        if (hasSubMenu())
        {
            wstring arrow = "▶"w;
            int arrowX = rx + rw - 16;
            int arrowY = ry + (rh - cast(int)_fontSize) / 2;
            TextOutW(hdc, arrowX, arrowY, cast(const(PWSTR))arrow.ptr, cast(int)arrow.length);
        }

        FontCache.release(hdc, fontEntry);

        // 如果子菜单展开，渲染下拉面板
        if (_menuOpen && _subItems.length > 0)
        {
            renderSubMenu(hdc);
        }
    }

    /// 渲染子菜单下拉面板
    private void renderSubMenu(HDC hdc)
    {
        int subX = x();                    // 子菜单左对齐父项
        int subY = y() + height();         // 子菜单在父项下方
        int subW = 160;                    // 子菜单宽度
        int subH = cast(int)_subItems.length * 24;  // 每项24px高

        // 绘制子菜单背景
        RECT subRect = { cast(LONG)subX, cast(LONG)subY, cast(LONG)(subX + subW), cast(LONG)(subY + subH) };
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &subRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // 绘制子菜单边框
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, subRect.left, subRect.top, subRect.right, subRect.bottom);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // 绘制每个子菜单项
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetTextColor(hdc, cast(COLORREF)0x00333333);
        SetBkMode(hdc, TRANSPARENT);

        foreach (i, subItem; _subItems)
        {
            int itemY = subY + cast(int)i * 24;

            // 设置子项位置（用于命中测试）
            subItem.x(subX);
            subItem.y(itemY);
            subItem.width(subW);
            subItem.height(24);

            // 悬停背景
            if (subItem._hovered)
            {
                RECT hoverRect = { cast(LONG)subX, cast(LONG)itemY, cast(LONG)(subX + subW), cast(LONG)(itemY + 24) };
                HBRUSH hoverBrush = CreateSolidBrush(cast(COLORREF)0x00D0D0D0);
                FillRect(hdc, &hoverRect, hoverBrush);
                DeleteObject(cast(HGDIOBJ)hoverBrush);
            }

            // 文字
            wstring textW = toUTF16(subItem._text);
            TextOutW(hdc, subX + 8, itemY + (24 - cast(int)_fontSize) / 2,
                     cast(const(PWSTR))textW.ptr, cast(int)textW.length);

            // 子项的子菜单箭头
            if (subItem.hasSubMenu())
            {
                wstring arrow = "▶"w;
                TextOutW(hdc, subX + subW - 16, itemY + (24 - cast(int)_fontSize) / 2,
                         cast(const(PWSTR))arrow.ptr, cast(int)arrow.length);
            }

            // 递归渲染子项的展开菜单
            if (subItem._menuOpen && subItem._subItems.length > 0)
            {
                subItem.renderSubMenu(hdc);
            }
        }

        FontCache.release(hdc, fontEntry);
    }

    override void render()
    {
    }
}
