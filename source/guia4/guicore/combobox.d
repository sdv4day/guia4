module guia4.guicore.combobox;

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
 * ComboBox — 下拉组合框
 *
 * 文本框 + 下拉按钮 + 下拉列表。
 * 点击展开/收起下拉列表。
 */
class ComboBox : Control
{
    private string[] _items;
    private int _selectedIndex = -1;
    private bool _isDropDown = false;
    private int _dropDownHeight = 120;
    private int _itemHeight = 24;
    private bool _hovered = false;
    private int _hoveredItem = -1;
    private uint _fontSize = 14;

    this()
    {
        width = 150;
        height = 28;
        focusable = true;
    }

    this(string[] items)
    {
        this();
        _items = items;
    }

    /// 添加列表项
    void addItem(string item)
    {
        _items ~= item;
        markDirty(DirtyBits.Visual);
    }

    /// 当前选中项索引
    int selectedIndex() const @property { return _selectedIndex; }
    void selectedIndex(int v) @property
    {
        if (_items.length == 0)
            _selectedIndex = -1;
        else if (v < 0)
            _selectedIndex = -1;
        else if (v >= cast(int)_items.length)
            _selectedIndex = cast(int)_items.length - 1;
        else
            _selectedIndex = v;
        markDirty(DirtyBits.Visual);
    }

    /// 下拉列表是否展开
    bool isDropDown() const @property { return _isDropDown; }

    /// 当前选中项文本
    string currentText() const @property
    {
        return (_selectedIndex >= 0 && _selectedIndex < cast(int)_items.length)
            ? _items[_selectedIndex] : "";
    }

    /// 列表项数量
    int itemCount() const @property { return cast(int)_items.length; }

    override void fireMouseDown(int mx, int my, int button)
    {
        if (button != 0)
            return;

        // mx, my 已经是控件本地坐标（由 MainWindow clientToControl 转换）

        // 点击下拉按钮区域 → 切换下拉
        if (mx >= width() - 24)
        {
            _isDropDown = !_isDropDown;
            markDirty(DirtyBits.Visual);
            return;
        }

        // 点击文本区域也切换下拉
        if (mx >= 0 && mx < width() - 24 && my >= 0 && my < height())
        {
            _isDropDown = !_isDropDown;
            markDirty(DirtyBits.Visual);
            return;
        }

        super.fireMouseDown(mx, my, button);
    }

    override void fireMouseMove(int mx, int my)
    {
        // mx, my 已经是控件本地坐标
        bool wasHovered = _hovered;
        _hovered = (mx >= 0 && mx < width() && my >= 0 && my < height());
        if (_hovered != wasHovered)
            markDirty(DirtyBits.Visual);

        // 下拉列表悬停
        if (_isDropDown && my > height())
        {
            int itemIdx = (my - height()) / _itemHeight;
            if (itemIdx != _hoveredItem)
            {
                _hoveredItem = itemIdx;
                markDirty(DirtyBits.Visual);
            }
        }
        else
        {
            if (_hoveredItem != -1)
            {
                _hoveredItem = -1;
                markDirty(DirtyBits.Visual);
            }
        }
    }

    /// 处理下拉列表区域的点击（由 MainWindow 调用，当点击在控件边界外但在下拉列表内时）
    /// ax, ay 是窗口绝对坐标
    bool handleDropDownClick(int ax, int ay)
    {
        if (!_isDropDown || _items.length == 0)
            return false;

        // 检查是否在下拉列表区域内
        int dropY = y() + height();
        int dropH = cast(int)_items.length * _itemHeight;
        if (dropH > _dropDownHeight) dropH = _dropDownHeight;

        if (ax >= x() && ax < x() + width() && ay >= dropY && ay < dropY + dropH)
        {
            int itemIdx = (ay - dropY) / _itemHeight;
            if (itemIdx >= 0 && itemIdx < cast(int)_items.length)
            {
                _selectedIndex = itemIdx;
                _isDropDown = false;
                _hoveredItem = -1;
                markDirty(DirtyBits.Visual);
                return true;
            }
        }

        // 点击下拉列表外，关闭下拉
        _isDropDown = false;
        _hoveredItem = -1;
        markDirty(DirtyBits.Visual);
        return true;  // 已处理（关闭下拉）
    }

    /// 处理下拉列表区域的鼠标移动（由 MainWindow 调用）
    /// ax, ay 是窗口绝对坐标
    void handleDropDownMouseMove(int ax, int ay)
    {
        if (!_isDropDown) return;

        int dropY = y() + height();
        if (ax >= x() && ax < x() + width() && ay >= dropY)
        {
            int itemIdx = (ay - dropY) / _itemHeight;
            if (itemIdx != _hoveredItem)
            {
                _hoveredItem = itemIdx;
                markDirty(DirtyBits.Visual);
            }
        }
        else
        {
            if (_hoveredItem != -1)
            {
                _hoveredItem = -1;
                markDirty(DirtyBits.Visual);
            }
        }
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("ComboBox.renderWithGDI() at (", x(), ",", y(), ")");

        int rx = x();
        int ry = y();
        int rw = width();
        int rh = height();

        // ── 文本框背景 ──
        COLORREF bgColor = _hovered ? cast(COLORREF)0x00FFFFFF : cast(COLORREF)0x00FCFCFC;
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(bgColor);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── 边框 ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, rx, ry, rx + rw, ry + rh);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── 当前选中文字 ──
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetTextColor(hdc, cast(COLORREF)0x00333333);
        SetBkMode(hdc, TRANSPARENT);

        string displayText = currentText();
        if (displayText.length > 0)
        {
            wstring textW = toUTF16(displayText);
            int textX = rx + 6;
            int textY = ry + (rh - cast(int)_fontSize) / 2;
            TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);
        }

        // ── 下拉按钮 (▼) ──
        int btnX = rx + rw - 24;
        int btnY = ry;
        int btnW = 24;
        int btnH = rh;

        RECT btnRect = {
            cast(LONG)btnX, cast(LONG)btnY,
            cast(LONG)(btnX + btnW), cast(LONG)(btnY + btnH)
        };
        COLORREF btnBg = _hovered ? cast(COLORREF)0x00E0E0E0 : cast(COLORREF)0x00F0F0F0;
        HBRUSH btnBrush = CreateSolidBrush(btnBg);
        FillRect(hdc, &btnRect, btnBrush);
        DeleteObject(cast(HGDIOBJ)btnBrush);

        // 按钮分隔线
        HPEN sepPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)sepPen);
        MoveToEx(hdc, btnX, btnY, null);
        LineTo(hdc, btnX, btnY + btnH);
        SelectObject(hdc, oldPen2);
        DeleteObject(cast(HGDIOBJ)sepPen);

        // ▼ 箭头
        wstring arrow = "▼"w;
        SIZE arrowSize;
        GetTextExtentPointW(hdc, cast(const(PWSTR))arrow.ptr, cast(int)arrow.length, &arrowSize);
        int arrowX = btnX + (btnW - arrowSize.cx) / 2;
        int arrowY = btnY + (btnH - arrowSize.cy) / 2;
        TextOutW(hdc, arrowX, arrowY, cast(const(PWSTR))arrow.ptr, cast(int)arrow.length);

        FontCache.release(hdc, fontEntry);

        // ── 下拉列表 ──
        if (_isDropDown && _items.length > 0)
        {
            renderDropDown(hdc);
        }
    }

    /// 渲染下拉列表
    private void renderDropDown(HDC hdc)
    {
        int rx = x();
        int ry = y() + height();
        int rw = width();
        int totalH = cast(int)_items.length * _itemHeight;
        if (totalH > _dropDownHeight)
            totalH = _dropDownHeight;

        // 背景
        RECT dropRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + totalH)
        };
        HBRUSH dropBrush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &dropRect, dropBrush);
        DeleteObject(cast(HGDIOBJ)dropBrush);

        // 边框
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00888888);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, rx, ry, rx + rw, ry + totalH);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // 列表项
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetBkMode(hdc, TRANSPARENT);

        for (int i = 0; i < cast(int)_items.length; i++)
        {
            int itemY = ry + i * _itemHeight;
            if (itemY >= ry + totalH)
                break;

            // 选中项高亮
            if (i == _selectedIndex)
            {
                RECT selRect = {
                    cast(LONG)rx, cast(LONG)itemY,
                    cast(LONG)(rx + rw), cast(LONG)(itemY + _itemHeight)
                };
                HBRUSH selBrush = CreateSolidBrush(cast(COLORREF)0x00CCCCFF);
                FillRect(hdc, &selRect, selBrush);
                DeleteObject(cast(HGDIOBJ)selBrush);
            }
            // 悬停项高亮
            else if (i == _hoveredItem)
            {
                RECT hovRect = {
                    cast(LONG)rx, cast(LONG)itemY,
                    cast(LONG)(rx + rw), cast(LONG)(itemY + _itemHeight)
                };
                HBRUSH hovBrush = CreateSolidBrush(cast(COLORREF)0x00E8E8E8);
                FillRect(hdc, &hovRect, hovBrush);
                DeleteObject(cast(HGDIOBJ)hovBrush);
            }

            // 文字
            SetTextColor(hdc, cast(COLORREF)0x00333333);
            wstring textW = toUTF16(_items[i]);
            int textX = rx + 6;
            int textY = itemY + (_itemHeight - cast(int)_fontSize) / 2;
            TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);
        }

        FontCache.release(hdc, fontEntry);
    }

    override void render() {}
}