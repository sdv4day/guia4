module guia4.guicore.popupmenu;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.layer;
import guia4.guicore.theme;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * PopupMenu — 弹出菜单 / 右键上下文菜单
 *
 * 通用弹出菜单组件，支持：
 * - 添加菜单项和分隔线
 * - 菜单项点击回调（onItemClick）
 * - 悬停高亮
 * - 点击外部自动关闭
 *
 * 使用方式：
 *   auto menu = new PopupMenu(null);
 *   menu.width = 120;
 *   menu.addItem("剪切");
 *   menu.addItem("复制");
 *   menu.onItemClick = (index, text) { ... };
 *   menu.popup(x, y);
 */
class PopupMenu : Control
{
    private struct PopupItem
    {
        string text;
        bool separator = false;
    }

    private PopupItem[] _items;
    private bool _isOpen = false;
    private int _hoveredIndex = -1;
    private uint _fontSize = 14;
    private int _itemHeight = 24;

    /// 菜单项点击回调：参数为 (itemIndex, itemText)
    void delegate(int index, string text) onItemClick;

    this(Control parent)
    {
        super(parent);
        width = 160;
        height = 0;
        visible = false;
        layer = Layer.Popup;
    }

    /// 添加菜单项，返回该项索引
    int addItem(string text)
    {
        int idx = cast(int)_items.length;
        _items ~= PopupItem(text);
        recalcHeight();
        return idx;
    }

    /// 添加分隔线
    void addSeparator()
    {
        _items ~= PopupItem("", true);
        recalcHeight();
    }

    /// 清空所有菜单项
    void clearItems()
    {
        _items.length = 0;
        recalcHeight();
    }

    /// 菜单项数量
    int itemCount() const @property { return cast(int)_items.length; }

    /// 弹出菜单是否打开
    bool isOpen() const @property { return _isOpen; }

    /// 在指定位置弹出菜单
    void popup(int px, int py)
    {
        setXY(px, py);
        _isOpen = true;
        visible = true;
        _hoveredIndex = -1;
        markDirty(DirtyBits.Visual);
    }

    /// 关闭菜单
    void close()
    {
        _isOpen = false;
        visible = false;
        _hoveredIndex = -1;
        markDirty(DirtyBits.Visual);
    }

    /// 重新计算高度
    private void recalcHeight()
    {
        height = cast(int)_items.length * _itemHeight;
        markDirty(DirtyBits.Visual);
    }

    override void fireMouseDown(int mx, int my, int button)
    {
        if (!_isOpen || button != 0)
            return;

        // 点击菜单外部 → 关闭
        if (mx < 0 || mx >= width() || my < 0 || my >= height())
        {
            close();
            return;
        }

        int idx = my / _itemHeight;
        if (idx >= 0 && idx < cast(int)_items.length && !_items[idx].separator)
        {
            // 触发回调
            if (onItemClick !is null)
                onItemClick(idx, _items[idx].text);
            close();
        }
    }

    override void fireMouseMove(int mx, int my)
    {
        if (!_isOpen)
            return;

        if (mx < 0 || mx >= width() || my < 0 || my >= height())
        {
            if (_hoveredIndex != -1)
            {
                _hoveredIndex = -1;
                markDirty(DirtyBits.Visual);
            }
            return;
        }

        int idx = my / _itemHeight;
        if (idx != _hoveredIndex)
        {
            _hoveredIndex = idx;
            markDirty(DirtyBits.Visual);
        }
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        if (!_isOpen)
            return;

        logTrace("PopupMenu.renderWithGDI() size=(", width(), ",", height(), ")");

        int rx = 0;
        int ry = 0;
        int rw = width();
        int rh = height();

        // ── 背景 ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(Theme.crMenuBg());
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── 边框 ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, Theme.crBorderDark());
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, rx, ry, rx + rw, ry + rh);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── 逐项渲染 ──
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetBkMode(hdc, TRANSPARENT);

        for (int i = 0; i < cast(int)_items.length; i++)
        {
            int itemY = ry + i * _itemHeight;
            ref PopupItem item = _items[i];

            if (item.separator)
            {
                HPEN sepPen = CreatePen(PS_SOLID, 1, Theme.crBorder());
                HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)sepPen);
                MoveToEx(hdc, rx + 4, itemY + _itemHeight / 2, null);
                LineTo(hdc, rx + rw - 4, itemY + _itemHeight / 2);
                SelectObject(hdc, oldPen2);
                DeleteObject(cast(HGDIOBJ)sepPen);
            }
            else
            {
                // 悬停高亮
                if (i == _hoveredIndex)
                {
                    RECT hovRect = {
                        cast(LONG)rx, cast(LONG)itemY,
                        cast(LONG)(rx + rw), cast(LONG)(itemY + _itemHeight)
                    };
                    HBRUSH hovBrush = CreateSolidBrush(Theme.crMenuHoverBg());
                    FillRect(hdc, &hovRect, hovBrush);
                    DeleteObject(cast(HGDIOBJ)hovBrush);
                }

                // 文字
                SetTextColor(hdc, Theme.crText());
                wstring textW = toUTF16(item.text);
                int textX = rx + 8;
                int textY = itemY + (_itemHeight - cast(int)_fontSize) / 2;
                TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);
            }
        }

        FontCache.release(hdc, fontEntry);
    }

    override void render() {}
}
