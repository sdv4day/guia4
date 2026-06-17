module guia4.guicore.tabcontrol;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.utils.math : clamp;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * TabControl — 水平标签选择控件
 *
 * 水平标签栏，点击选择一个标签。
 * 渲染：标签栏 + 选中标签高亮 + 底部分隔线
 */
class TabControl : Control
{
    private string[] _tabLabels;
    private int _selectedIndex = 0;
    private int _hoveredTab = -1;
    private uint _fontSize = 14;

    this(Control parent, string[] labels)
    {
        super(parent);
        width = 300;
        height = 28;
        _tabLabels = labels;
    }

    /// 添加标签，返回索引
    int addTab(string label)
    {
        _tabLabels ~= label;
        markDirty(DirtyBits.Visual);
        return cast(int)_tabLabels.length - 1;
    }

    /// 当前选中标签索引
    int selectedIndex() const @property { return _selectedIndex; }
    void selectedIndex(int v) @property
    {
        _selectedIndex = v.clamp(0, cast(int)_tabLabels.length - 1);
        markDirty(DirtyBits.Visual);
    }

    /// 标签数量
    int tabCount() const @property { return cast(int)_tabLabels.length; }

    /// 获取标签文本列表
    string[] tabLabels() @property { return _tabLabels; }

    override void fireMouseDown(int mx, int my, int button)
    {
        if (button != 0 || _tabLabels.length == 0)
            return;

        // mx 已经是控件本地坐标
        int tabW = width() / cast(int)_tabLabels.length;
        int idx = mx / tabW;
        if (idx >= 0 && idx < cast(int)_tabLabels.length)
            {
                if (_selectedIndex != idx)
                {
                    _selectedIndex = idx;
                    markDirty(DirtyBits.Visual);
                    // 通知父控件（TabWidget）子控件状态变化，需要重新渲染
                    if (parent() !is null)
                        parent().markDirty(DirtyBits.Children);
                }
            }
    }

    override void fireMouseMove(int mx, int my)
    {
        if (_tabLabels.length == 0)
            return;

        // mx 已经是控件本地坐标
        int tabW = width() / cast(int)_tabLabels.length;
        int idx = mx / tabW;
        if (idx < 0 || idx >= cast(int)_tabLabels.length)
            idx = -1;

        if (idx != _hoveredTab)
        {
            _hoveredTab = idx;
            markDirty(DirtyBits.Visual);
        }
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("TabControl.renderWithGDI() size=(", width(), ",", height(), ")");

        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 作为基准
        int rx = 0;
        int ry = 0;
        int rw = width();
        int rh = height();

        // 背景
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00F0F0F0);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        if (_tabLabels.length == 0)
            return;

        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetBkMode(hdc, TRANSPARENT);

        // 计算每个标签宽度（均匀分布）
        int tabW = rw / cast(int)_tabLabels.length;
        int remainW = rw - tabW * cast(int)_tabLabels.length;

        int tabX = rx;
        for (int i = 0; i < cast(int)_tabLabels.length; i++)
        {
            int thisTabW = tabW + (i < remainW ? 1 : 0);
            int tabY = ry;

            COLORREF bgColor;
            COLORREF textColor;

            if (i == _selectedIndex)
            {
                bgColor = cast(COLORREF)0x00FFFFFF;     // 白色高亮
                textColor = cast(COLORREF)0x00333333;   // 深色文字
            }
            else if (i == _hoveredTab)
            {
                bgColor = cast(COLORREF)0x00E0E0E0;     // 悬停灰色
                textColor = cast(COLORREF)0x00555555;
            }
            else
            {
                bgColor = cast(COLORREF)0x00F0F0F0;     // 默认浅灰
                textColor = cast(COLORREF)0x00666666;
            }

            // 标签背景
            RECT tabRect = {
                cast(LONG)tabX, cast(LONG)tabY,
                cast(LONG)(tabX + thisTabW), cast(LONG)(tabY + rh)
            };
            HBRUSH tabBrush = CreateSolidBrush(bgColor);
            FillRect(hdc, &tabRect, tabBrush);
            DeleteObject(cast(HGDIOBJ)tabBrush);

            // 选中标签底部高亮线
            if (i == _selectedIndex)
            {
                HPEN selPen = CreatePen(PS_SOLID, 2, cast(COLORREF)0x006666FF);
                HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)selPen);
                MoveToEx(hdc, tabX, tabY + rh - 1, null);
                LineTo(hdc, tabX + thisTabW, tabY + rh - 1);
                SelectObject(hdc, oldPen);
                DeleteObject(cast(HGDIOBJ)selPen);
            }

            // 标签文字
            wstring textW = toUTF16(_tabLabels[i]);
            SIZE textSize;
            GetTextExtentPointW(hdc, cast(const(PWSTR))textW.ptr, cast(int)textW.length, &textSize);
            int textX = tabX + (thisTabW - textSize.cx) / 2;
            int textY = tabY + (rh - textSize.cy) / 2;

            SetTextColor(hdc, textColor);
            TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);

            // 标签分隔线（非选中标签右侧）
            if (i < cast(int)_tabLabels.length - 1 && i != _selectedIndex && i + 1 != _selectedIndex)
            {
                HPEN sepPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
                HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)sepPen);
                MoveToEx(hdc, tabX + thisTabW - 1, tabY + 4, null);
                LineTo(hdc, tabX + thisTabW - 1, tabY + rh - 4);
                SelectObject(hdc, oldPen2);
                DeleteObject(cast(HGDIOBJ)sepPen);
            }

            tabX += thisTabW;
        }

        FontCache.release(hdc, fontEntry);

        // 底部分隔线
        HPEN bottomPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen3 = SelectObject(hdc, cast(HGDIOBJ)bottomPen);
        MoveToEx(hdc, rx, ry + rh - 1, null);
        LineTo(hdc, rx + rw, ry + rh - 1);
        SelectObject(hdc, oldPen3);
        DeleteObject(cast(HGDIOBJ)bottomPen);
    }

    override void render() {}
}
