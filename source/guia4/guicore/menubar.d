module guia4.guicore.menubar;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.layer;
import guia4.guicore.theme;
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
    private int _borderHeight = 1;    /// 底部边框高度
    private int _itemHeight = 20;     /// 默认 item 高度

    this(Control parent)
    {
        super(parent);
        rendersChildren(true);  // MenuBar自己渲染MenuItem
        dock(DockStyle.Top);    // 默认停靠在顶部，宽度自适应父容器
        layer(Layer.Popup);     // 使用Popup层，确保在所有Content控件之后渲染（子菜单不被覆盖）
        updateHeight();         // 根据item高度计算MenuBar高度
        logTrace("MenuBar.ctor()");
    }

    /// 设置 item 高度（会自动更新 MenuBar 高度）
    void itemHeight(int v) @property
    {
        _itemHeight = v;
        updateHeight();
    }

    /// 获取 item 高度
    int itemHeight() const @property { return _itemHeight; }

    /// 设置边框高度（会自动更新 MenuBar 高度）
    void borderHeight(int v) @property
    {
        _borderHeight = v;
        updateHeight();
    }

    /// 获取边框高度
    int borderHeight() const @property { return _borderHeight; }

    /// 根据 item 高度和边框计算 MenuBar 高度
    private void updateHeight()
    {
        // 检查是否有自定义高度的 item
        int maxItemHeight = _itemHeight;
        foreach (slot; _slots)
        {
            if (slot.item.hasCustomHeight())
            {
                int h = slot.item.height();
                if (h > maxItemHeight)
                    maxItemHeight = h;
            }
        }
        height = maxItemHeight + _borderHeight;
    }

    /// 添加菜单项
    MenuItem add(string text)
    {
        auto item = new MenuItem(this, text);
        _slots ~= ItemSlot(item, 0);
        updateHeight();  // 添加 item 后更新高度
        return item;
    }

    /// 关闭所有展开的子菜单
    void closeAll()
    {
        foreach (ref slot; _slots)
        {
            slot.item.closeMenu();
        }
        markDirty();
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
        logTrace("MenuBar.renderWithGDI() size=(", width(), ",", height(), ")");

        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 作为基准
        int rx = 0;
        int ry = 0;
        int rw = width();
        int rh = height();

        // ── Background ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(Theme.crMenuBarBg());
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // Bottom border
        HPEN borderPen = CreatePen(PS_SOLID, 1, Theme.crBorder());
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
            // 计算宽度：如果 MenuItem 有自定义宽度则使用，否则自动计算
            int itemW;
            if (slot.item.hasCustomWidth())
            {
                itemW = slot.item.width();
            }
            else
            {
                wstring textW = toUTF16(slot.item._text);
                SIZE textSize;
                GetTextExtentPointW(hdc, cast(const(PWSTR))textW.ptr,
                                    cast(int)textW.length, &textSize);
                itemW = textSize.cx + _itemPadding * 2;
            }

            // 计算高度：如果 MenuItem 有自定义高度则使用，否则使用默认 item 高度
            int itemH = slot.item.hasCustomHeight() ? slot.item.height() : _itemHeight;

            slot.width = itemW;

            // Position the MenuItem control (absolute coords)
            slot.item.setXY(itemX, itemY);
            // 只在非自定义模式下设置尺寸
            if (!slot.item.hasCustomWidth())
                slot.item.setAutoWidth(itemW);
            if (!slot.item.hasCustomHeight())
                slot.item.setAutoHeight(itemH);

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
        int barX = position().x();
        int barY = position().y();
        // 检查是否点击了某个 MenuItem
        foreach (ref slot; _slots)
        {
            int itemLocalX = slot.item.position().x() - barX;
            int itemLocalY = slot.item.position().y() - barY;
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
                    markDirty();
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
        int barX = position().x();
        int barY = position().y();
        // 如果有菜单展开，鼠标在菜单栏项上移动时切换展开的子菜单
        foreach (ref slot; _slots)
        {
            int itemLocalX = slot.item.position().x() - barX;
            int itemLocalY = slot.item.position().y() - barY;
            bool inSlot = mx >= itemLocalX && mx < itemLocalX + slot.width &&
                          my >= itemLocalY && my < itemLocalY + slot.item.height();

            if (inSlot && !slot.item._hovered)
            {
                slot.item._hovered = true;
                // 标记该MenuItem为脏（只更新该item的buffer）
                slot.item.markDirty();
                // 如果有其他菜单展开，切换到这个
                if (hasOpenMenu() && slot.item.hasSubMenu())
                {
                    closeAll();
                    slot.item._menuOpen = true;
                    markDirty(); // 子菜单展开需要重新布局
                }
            }
            else if (!inSlot && slot.item._hovered)
            {
                slot.item._hovered = false;
                // 标记该MenuItem为脏（只更新该item的buffer）
                slot.item.markDirty();
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
    private COLORREF _textColor  = Theme.crText();
    private COLORREF _hoverBg    = Theme.crMenuHoverBg();
    package bool _hovered = false;

    /// 获取/设置悬停状态（用于外部更新）
    bool hovered() const @property { return _hovered; }
    void hovered(bool v) @property { if (_hovered != v) { _hovered = v; markDirty(); } }

    // 子菜单支持
    package MenuItem[] _subItems;       /// 子菜单项列表
    package bool _menuOpen = false;     /// 子菜单是否展开
    private int _subMenuItemHeight = 24; /// 子菜单项高度

    // Layer buffer尺寸缓存（用于检测尺寸变化）
    private int _bufferWidth = 0;
    private int _bufferHeight = 0;

    // 自定义尺寸标志
    private bool _customWidth = false;
    private bool _customHeight = false;

    this(Control parent, string text)
    {
        super(parent);
        _text = text;
        // 不设置默认宽高，由 MenuBar 自动计算或用户手动设置
    }

    /// 设置自定义宽度（禁用自动计算）
    void setCustomWidth(int v)
    {
        _customWidth = true;
        super.width(v);
    }

    /// 设置自定义高度（禁用自动计算）
    void setCustomHeight(int v)
    {
        _customHeight = true;
        super.height(v);
    }

    /// 设置自定义尺寸（禁用自动计算）
    void setCustomSize(int w, int h)
    {
        setCustomWidth(w);
        setCustomHeight(h);
    }

    /// 是否使用自定义宽度
    bool hasCustomWidth() const @property { return _customWidth; }

    /// 是否使用自定义高度
    bool hasCustomHeight() const @property { return _customHeight; }

    /// 重置为自动尺寸
    void resetCustomSize()
    {
        _customWidth = false;
        _customHeight = false;
    }

    /// 内部方法：设置自动计算的宽度（不触发自定义标志）
    package void setAutoWidth(int v)
    {
        super.width(v);
    }

    /// 内部方法：设置自动计算的高度（不触发自定义标志）
    package void setAutoHeight(int v)
    {
        super.height(v);
    }
    
    /**
     * 析构函数 — 仅标记资源为已销毁
     * 
     * 注意：不在析构函数中调用 GDI API（如 DeleteDC, DeleteObject），
     * 因为 GC 可能在 D 运行时的模块析构阶段析构对象，此时调用
     * GDI API 可能导致访问冲突。
     * 
     * 正确的做法是在控件被移除时显式调用 destroyLayerBuffer() 方法。
     */
    ~this()
    {
        // 仅标记资源为已销毁，不调用 GDI API
        // 实际的 GDI 资源清理应该在 destroyLayerBuffer() 中完成
    }

    string text() const @property { return _text; }
    void text(string v) { _text = v; markDirty(); }

    /// 添加子菜单项
    MenuItem addSubItem(string text)
    {
        auto item = new MenuItem(this, text);
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
        markDirty();
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
            if (px >= subItem.position().x() && px < subItem.position().x() + subItem.width() &&
                py >= subItem.position().y() && py < subItem.position().y() + subItem.height())
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
            markDirty();
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
                markDirty();
            }
        }
        else
        {
            if (!_hovered)
            {
                _hovered = true;
                markDirty();
            }
        }
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("MenuItem.renderWithGDI() - '", _text, "' size=(", width(), ",", height(), ")");

        // MenuBar 直接调用 renderWithGDI 时没有再次偏移视口到子项位置，
        // 因此 MenuItem 需要使用自身在父容器中的相对坐标
        int rx = position().x();
        int ry = position().y();
        int rw = width();
        int rh = height();

        // ── Layer Buffer管理 ──
        bool bufferNeedsRebuild = !_layerBufferValid || 
                                   rw != _bufferWidth || 
                                   rh != _bufferHeight;
        
        if (bufferNeedsRebuild)
        {
            // 重建buffer（尺寸变化）
            initLayerBuffer(hdc);
            _bufferWidth = rw;
            _bufferHeight = rh;
        }
        
        bool bufferNeedsUpdate = bufferNeedsRebuild || isDirty();
        
        if (bufferNeedsUpdate)
        {
            // 更新buffer内容
            updateItemBuffer();
            clearDirty();
        }
        
        // ── 合成buffer到父DC ──
        if (_layerBufferValid)
        {
            BitBlt(hdc, rx, ry, rw, rh, _layerDC, 0, 0, SRCCOPY);
        }

        // 如果子菜单展开，渲染下拉面板
        if (_menuOpen && _subItems.length > 0)
        {
            // 移除父容器设置的clip限制，允许子菜单绘制到MenuBar bounds之外
            int savedDC = SaveDC(hdc);
            SelectClipRgn(hdc, cast(HRGN)null);
            renderSubMenu(hdc);
            RestoreDC(hdc, savedDC);
        }
    }
    
    /// 更新MenuItem的layer buffer内容
    private void updateItemBuffer()
    {
        if (!_layerBufferValid)
            return;
        
        int rw = _bufferWidth;
        int rh = _bufferHeight;
        
        // ── Background ──
        RECT bgRect = {0, 0, rw, rh};
        HBRUSH bgBrush;
        if (_hovered)
            bgBrush = CreateSolidBrush(_hoverBg);
        else
            bgBrush = CreateSolidBrush(Theme.crMenuBarBg());
        FillRect(_layerDC, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── Text ──
        auto fontEntry = FontCache.get(_layerDC, "Segoe UI", cast(int)_fontSize);

        SetTextColor(_layerDC, _textColor);
        SetBkMode(_layerDC, TRANSPARENT);

        wstring textW = toUTF16(_text);
        int textX = 6;   // extra horizontal padding
        int textY = (rh - cast(int)_fontSize) / 2;
        TextOutW(_layerDC, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);

        // 如果有子菜单，绘制右侧箭头 ▶
        if (hasSubMenu())
        {
            wstring arrow = "▶"w;
            int arrowX = rw - 16;
            int arrowY = (rh - cast(int)_fontSize) / 2;
            TextOutW(_layerDC, arrowX, arrowY, cast(const(PWSTR))arrow.ptr, cast(int)arrow.length);
        }

        FontCache.release(_layerDC, fontEntry);
    }

    /// 渲染子菜单下拉面板
    private void renderSubMenu(HDC hdc)
    {
        int subX = position().x();                    // 子菜单左对齐父项
        int subY = position().y() + height();         // 子菜单在父项下方
        int subW = 160;                    // 子菜单宽度
        int subH = cast(int)_subItems.length * _subMenuItemHeight;

        // 绘制子菜单背景
        RECT subRect = { cast(LONG)subX, cast(LONG)subY, cast(LONG)(subX + subW), cast(LONG)(subY + subH) };
        HBRUSH bgBrush = CreateSolidBrush(Theme.crMenuBg());
        FillRect(hdc, &subRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // 绘制子菜单边框
        HPEN borderPen = CreatePen(PS_SOLID, 1, Theme.crBorder());
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, subRect.left, subRect.top, subRect.right, subRect.bottom);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // 绘制每个子菜单项
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetTextColor(hdc, Theme.crText());
        SetBkMode(hdc, TRANSPARENT);

        foreach (i, subItem; _subItems)
        {
            int itemY = subY + cast(int)i * _subMenuItemHeight;

            // 设置子项位置（用于命中测试）
            subItem.setXY(subX, itemY);
            subItem.width(subW);
            subItem.height(_subMenuItemHeight);

            // 悬停背景
            if (subItem._hovered)
            {
                RECT hoverRect = { cast(LONG)subX, cast(LONG)itemY, cast(LONG)(subX + subW), cast(LONG)(itemY + _subMenuItemHeight) };
                HBRUSH hoverBrush = CreateSolidBrush(Theme.crMenuHoverBg());
                FillRect(hdc, &hoverRect, hoverBrush);
                DeleteObject(cast(HGDIOBJ)hoverBrush);
            }

            // 文字
            wstring textW = toUTF16(subItem._text);
            TextOutW(hdc, subX + 8, itemY + (_subMenuItemHeight - cast(int)_fontSize) / 2,
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
