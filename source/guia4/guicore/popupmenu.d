module guia4.guicore.popupmenu;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.layer;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * PopupMenu — 弹出菜单
 *
 * 右键弹出菜单，类似 MenuItem 的子菜单面板。
 * 在指定位置弹出。
 */
class PopupMenu : Control
{
    private struct PopupItem
    {
        string text;
        bool separator = false;  /// 分隔线
    }

    private PopupItem[] _items;
    private bool _isOpen = false;
    private int _hoveredIndex = -1;
    private uint _fontSize = 14;
    private int _itemHeight = 24;

    this(Control parent)
    {
        super(parent);
        width = 160;
        height = 0;
        visible = false;
        layer = Layer.Popup;
    }

    /// 添加菜单项
    void addItem(string text)
    {
        _items ~= PopupItem(text);
        recalcHeight();
    }

    /// 添加分隔线
    void addSeparator()
    {
        _items ~= PopupItem("", true);
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

        // mx, my 已经是控件本地坐标（由 MainWindow clientToControl 转换）
        // 点击菜单外部 → 关闭
        if (mx < 0 || mx >= width() || my < 0 || my >= height())
        {
            close();
            return;
        }

        int idx = my / _itemHeight;
        if (idx >= 0 && idx < cast(int)_items.length && !_items[idx].separator)
        {
            // 触发该项的 onClick
            fireClick(mx, my);
            close();
        }
    }

    override void fireMouseMove(int mx, int my)
    {
        if (!_isOpen)
            return;

        // mx, my 已经是控件本地坐标（由 MainWindow clientToControl 转换）
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

        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 作为基准
        int rx = 0;
        int ry = 0;
        int rw = width();
        int rh = height();

        // ── 白色背景 ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── 边框 ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00888888);
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
                // 分隔线
                HPEN sepPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
                HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)sepPen);
                MoveToEx(hdc, rx + 4, itemY + _itemHeight / 2, null);
                LineTo(hdc, rx + rw - 4, itemY + _itemHeight / 2);
                SelectObject(hdc, oldPen2);
                DeleteObject(cast(HGDIOBJ)sepPen);
            }
            else
            {
                // 悬停项高亮
                if (i == _hoveredIndex)
                {
                    RECT hovRect = {
                        cast(LONG)rx, cast(LONG)itemY,
                        cast(LONG)(rx + rw), cast(LONG)(itemY + _itemHeight)
                    };
                    HBRUSH hovBrush = CreateSolidBrush(cast(COLORREF)0x00D0D0D0);
                    FillRect(hdc, &hovRect, hovBrush);
                    DeleteObject(cast(HGDIOBJ)hovBrush);
                }

                // 文字
                SetTextColor(hdc, cast(COLORREF)0x00333333);
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