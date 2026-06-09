module guia4.guicore.gridwidgetbase;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.utils.math : clamp;
import guia4.platform_win32.win32defs;
import std.utf;
import std.conv;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;
import windows.win32.system.systeminformation;

/**
 * GridWidgetBase — 抽象网格控件基类
 *
 * 定义网格接口：行数、列数、行高、列宽、表头可见性。
 * 子类实现 cellText(row, col) 和 headerText(col)。
 * 支持单元格编辑：双击进入编辑模式，回车/Tab确认，Esc取消。
 */
abstract class GridWidgetBase : Control
{
    protected int _rowCount = 0;
    protected int _colCount = 0;
    protected int _rowHeight = 24;
    protected int[] _colWidths;
    protected bool _headerVisible = true;
    protected int _scrollY = 0;
    protected int _scrollX = 0;              /// 水平滚动偏移（像素）
    protected int _selectedRow = -1;
    protected int _selectedCol = -1;
    private uint _fontSize = 14;
    private int _scrollBarWidth = 14;         /// 滚动条宽度（像素）

    // ── 垂直滚动条拖拽状态 ──
    private bool _vThumbDragging = false;
    private int _vThumbDragStart = 0;         /// 拖拽起始鼠标Y
    private int _vThumbDragStartScroll = 0;   /// 拖拽起始scrollY

    // ── 水平滚动条拖拽状态 ──
    private bool _hThumbDragging = false;
    private int _hThumbDragStart = 0;         /// 拖拽起始鼠标X
    private int _hThumbDragStartScroll = 0;   /// 拖拽起始scrollX

    // ── 列级可写控制 ──
    protected bool[] _colEditable;  /// 每列是否可编辑（空数组=全部可编辑）

    // ── 函数回调读写数据 ──
    /// 单元格文本读取回调（优先于 cellText 虚方法）
    alias CellTextDelegate = string delegate(int row, int col);
    /// 单元格文本写入回调（优先于 commitEdit 虚方法）
    alias SetCellDelegate = void delegate(int row, int col, string value);
    /// 列标题读取回调（优先于 headerText 虚方法）
    alias HeaderTextDelegate = string delegate(int col);
    /// 列可编辑检查回调（优先于 _colEditable 数组）
    alias ColEditableDelegate = bool delegate(int col);

    protected CellTextDelegate _cellTextDelegate;
    protected SetCellDelegate _setCellDelegate;
    protected HeaderTextDelegate _headerTextDelegate;
    protected ColEditableDelegate _colEditableDelegate;

    // ── 编辑状态 ──
    protected bool _editing = false;          /// 是否正在编辑单元格
    protected int _editRow = -1;              /// 编辑中的行
    protected int _editCol = -1;              /// 编辑中的列
    protected string _editText;               /// 编辑中的文本
    protected int _editCursorPos = 0;         /// 编辑光标位置（字节索引）
    protected string _editOriginalText;       /// 编辑前的原始文本（用于 Esc 取消）
    protected int _editSelStart = -1;         /// 编辑选区起始字节位置（-1=无选区）
    protected int _editSelEnd = -1;           /// 编辑选区结束字节位置

    // ── 双击检测 ──
    private long _lastClickTime = 0;          /// 上次点击时间（ms）
    private int _lastClickRow = -1;
    private int _lastClickCol = -1;

    this()
    {
        width = 300;
        height = 200;
        focusable = true;
        onMouseWheel(&handleWheel);
        onKeyDown(&handleKeyDown);
        onTextInput(&handleTextInput);
    }

    /// 行数
    int rowCount() const @property { return _rowCount; }

    /// 列数
    int colCount() const @property { return _colCount; }

    /// 行高
    int rowHeight() const @property { return _rowHeight; }
    void rowHeight(int v) @property { _rowHeight = v; markDirty(DirtyBits.Visual); }

    /// 表头是否可见
    bool headerVisible() const @property { return _headerVisible; }
    void headerVisible(bool v) @property { _headerVisible = v; markDirty(DirtyBits.Visual); }

    /// 选中行
    int selectedRow() const @property { return _selectedRow; }
    /// 选中列
    int selectedCol() const @property { return _selectedCol; }

    /// 子类实现：返回指定单元格的文本
    abstract string cellText(int row, int col);

    /// 子类实现：返回列标题
    abstract string headerText(int col);

    /// 设置列宽
    void setColWidths(int[] widths)
    {
        _colWidths = widths;
        markDirty(DirtyBits.Visual);
    }

    /// 设置列可编辑状态
    void setColEditable(bool[] editable)
    {
        _colEditable = editable;
    }

    /// 检查指定列是否可编辑
    bool isColEditable(int col) const
    {
        // 优先使用回调
        if (_colEditableDelegate !is null)
            return _colEditableDelegate(col);
        // 其次使用数组
        if (_colEditable.length == 0)
            return true;  /// 空数组 = 全部可编辑（默认行为）
        if (col >= 0 && col < cast(int)_colEditable.length)
            return _colEditable[col];
        return false;  /// 超出范围不可编辑
    }

    /// 设置单元格文本读取回调
    void onCellText(CellTextDelegate dlg) { _cellTextDelegate = dlg; }

    /// 设置单元格文本写入回调
    void onSetCell(SetCellDelegate dlg) { _setCellDelegate = dlg; }

    /// 设置列标题读取回调
    void onHeaderText(HeaderTextDelegate dlg) { _headerTextDelegate = dlg; }

    /// 设置列可编辑检查回调
    void onColEditable(ColEditableDelegate dlg) { _colEditableDelegate = dlg; }

    /// 垂直滚动位置
    int scrollY() const @property { return _scrollY; }
    void scrollY(int v) @property
    {
        _scrollY = v.clamp(0, maxScroll());
        markDirty(DirtyBits.Visual);
    }

    /// 水平滚动位置
    int scrollX() const @property { return _scrollX; }
    void scrollX(int v) @property
    {
        _scrollX = v.clamp(0, maxScrollX());
        markDirty(DirtyBits.Visual);
    }

    /// 所有列的总宽度
    int totalColWidth() const
    {
        int total = 0;
        for (int c = 0; c < _colCount; c++)
            total += getColWidth(c);
        return total;
    }

    /// 垂直滚动条是否需要显示
    bool needVScroll() const
    {
        int totalH = _rowCount * _rowHeight;
        int viewH = height() - (_headerVisible ? _rowHeight : 0);
        return totalH > viewH;
    }

    /// 水平滚动条是否需要显示
    bool needHScroll() const
    {
        int totalW = totalColWidth();
        int viewW = width();
        return totalW > viewW;
    }

    // ── 编辑相关方法 ──────────────────────────────────────

    /// 是否正在编辑
    bool isEditing() const @property { return _editing; }

    /// 是否有编辑选区
    bool hasEditSelection() const
    {
        return _editSelStart >= 0 && _editSelEnd >= 0 && _editSelStart != _editSelEnd;
    }

    /// 清除编辑选区
    void clearEditSelection()
    {
        _editSelStart = -1;
        _editSelEnd = -1;
    }

    /// 开始编辑指定单元格
    void beginEdit(int row, int col)
    {
        if (row < 0 || row >= _rowCount || col < 0 || col >= _colCount)
            return;

        // 检查列是否可编辑
        if (!isColEditable(col))
            return;

        // 如果已在编辑其他单元格，先提交
        if (_editing && (row != _editRow || col != _editCol))
            commitEdit();

        _editRow = row;
        _editCol = col;
        _editOriginalText = (_cellTextDelegate !is null) ? _cellTextDelegate(row, col) : cellText(row, col);
        _editText = _editOriginalText;
        _editCursorPos = cast(int)_editText.length;
        _editSelStart = -1;
        _editSelEnd = -1;
        _editing = true;
        _selectedRow = row;
        _selectedCol = col;
        markDirty(DirtyBits.Visual);
    }

    /// 确认编辑（基类清理编辑状态，子类 override 以写入数据）
    void commitEdit()
    {
        if (!_editing)
            return;
        // 优先使用回调写入
        if (_setCellDelegate !is null)
        {
            _setCellDelegate(_editRow, _editCol, _editText);
        }
        _editing = false;
        _editRow = -1;
        _editCol = -1;
        markDirty(DirtyBits.Visual);
    }

    /// 取消编辑，恢复原始文本
    void cancelEdit()
    {
        if (!_editing)
            return;
        _editing = false;
        _editRow = -1;
        _editCol = -1;
        markDirty(DirtyBits.Visual);
    }

    private void handleWheel(ref MouseWheelEvent ev)
    {
        int delta = ev.delta;
        _scrollY = (_scrollY + (delta > 0 ? -_rowHeight : _rowHeight)).clamp(0, maxScroll());
        markDirty(DirtyBits.Visual);
    }

    private int maxScroll() const
    {
        int totalH = _rowCount * _rowHeight;
        int viewH = height() - (_headerVisible ? _rowHeight : 0) - (needHScroll() ? _scrollBarWidth : 0);
        return (totalH > viewH) ? totalH - viewH : 0;
    }

    /// 水平最大滚动值
    private int maxScrollX() const
    {
        int totalW = totalColWidth();
        int viewW = width() - (needVScroll() ? _scrollBarWidth : 0);
        return (totalW > viewW) ? totalW - viewW : 0;
    }

    // ── 鼠标事件 ──────────────────────────────────────────

    override void fireMouseDown(int mx, int my, int button)
    {
        if (button != 0)
            return;

        // ── 检查垂直滚动条点击 ──
        if (needVScroll())
        {
            int vsbX = width() - _scrollBarWidth;
            int vsbY = (_headerVisible ? _rowHeight : 0);
            int vsbH = height() - vsbY - (needHScroll() ? _scrollBarWidth : 0);
            if (mx >= vsbX && mx < width() && my >= vsbY && my < vsbY + vsbH)
            {
                handleVScrollClick(my - vsbY, vsbH);
                return;
            }
        }

        // ── 检查水平滚动条点击 ──
        if (needHScroll())
        {
            int hsbY = height() - _scrollBarWidth;
            int hsbX = 0;
            int hsbW = width() - (needVScroll() ? _scrollBarWidth : 0);
            if (mx >= hsbX && mx < hsbX + hsbW && my >= hsbY && my < hsbY + _scrollBarWidth)
            {
                handleHScrollClick(mx - hsbX, hsbW);
                return;
            }
        }

        // mx, my 已经是控件本地坐标（由 MainWindow clientToControl 转换）
        int headerH = _headerVisible ? _rowHeight : 0;
        int bodyY = my - headerH;

        if (bodyY < 0)
            return; // 点击了表头

        // 计算点击的行
        int row = (bodyY + _scrollY) / _rowHeight;
        if (row < 0 || row >= _rowCount)
            return;

        // 计算点击的列
        int col = -1;
        int colX = -_scrollX;
        for (int c = 0; c < _colCount; c++)
        {
            int cw = getColWidth(c);
            if (mx >= colX && mx < colX + cw)
            {
                col = c;
                break;
            }
            colX += cw;
        }

        if (col >= 0)
        {
            // 双击检测：同一单元格两次点击间隔 < 300ms
            long now = GetTickCount64();
            bool isDoubleClick = (row == _lastClickRow && col == _lastClickCol &&
                                  (now - _lastClickTime) < 300);

            _lastClickTime = now;
            _lastClickRow = row;
            _lastClickCol = col;

            if (isDoubleClick)
            {
                // 双击：进入编辑模式
                if (_editing)
                    commitEdit(); // 先提交当前编辑
                beginEdit(row, col);
            }
            else
            {
                // 单击
                if (_editing)
                    commitEdit(); // 提交当前编辑
                _selectedRow = row;
                _selectedCol = col;
                markDirty(DirtyBits.Visual);
            }
        }

        // 调用 super 触发 onMouseDown 监听器（在处理完单元格逻辑后）
        super.fireMouseDown(mx, my, button);
    }

    /// 垂直滚动条点击处理
    private void handleVScrollClick(int clickY, int trackH)
    {
        int totalH = _rowCount * _rowHeight;
        int thumbH = cast(int)((cast(long)trackH * trackH) / totalH);
        if (thumbH < 16) thumbH = 16;
        if (thumbH > trackH) thumbH = trackH;
        int movable = trackH - thumbH;
        int maxS = maxScroll();
        int thumbY;
        if (maxS <= 0) thumbY = 0;
        else thumbY = cast(int)((cast(long)_scrollY * movable) / maxS);

        // 点击在滑块上：开始拖拽
        if (clickY >= thumbY && clickY < thumbY + thumbH)
        {
            _vThumbDragging = true;
            _vThumbDragStart = clickY + (_headerVisible ? _rowHeight : 0);  /// 还原为控件本地Y坐标
            _vThumbDragStartScroll = _scrollY;
            markDirty(DirtyBits.Visual);
            return;
        }

        // 点击在滑块上方：向上翻页
        if (clickY < thumbY)
        {
            int viewH = height() - (_headerVisible ? _rowHeight : 0) - (needHScroll() ? _scrollBarWidth : 0);
            _scrollY = (_scrollY - viewH).clamp(0, maxS);
            markDirty(DirtyBits.Visual);
            return;
        }

        // 点击在滑块下方：向下翻页
        int viewH2 = height() - (_headerVisible ? _rowHeight : 0) - (needHScroll() ? _scrollBarWidth : 0);
        _scrollY = (_scrollY + viewH2).clamp(0, maxS);
        markDirty(DirtyBits.Visual);
    }

    /// 水平滚动条点击处理
    private void handleHScrollClick(int clickX, int trackW)
    {
        int totalW = totalColWidth();
        int thumbW = cast(int)((cast(long)trackW * trackW) / totalW);
        if (thumbW < 16) thumbW = 16;
        if (thumbW > trackW) thumbW = trackW;
        int movable = trackW - thumbW;
        int maxS = maxScrollX();
        int thumbX;
        if (maxS <= 0) thumbX = 0;
        else thumbX = cast(int)((cast(long)_scrollX * movable) / maxS);

        // 点击在滑块上：开始拖拽
        if (clickX >= thumbX && clickX < thumbX + thumbW)
        {
            _hThumbDragging = true;
            _hThumbDragStart = clickX;
            _hThumbDragStartScroll = _scrollX;
            markDirty(DirtyBits.Visual);
            return;
        }

        // 点击在滑块左方：向左翻页
        if (clickX < thumbX)
        {
            int viewW = width() - (needVScroll() ? _scrollBarWidth : 0);
            _scrollX = (_scrollX - viewW).clamp(0, maxS);
            markDirty(DirtyBits.Visual);
            return;
        }

        // 点击在滑块右方：向右翻页
        int viewW2 = width() - (needVScroll() ? _scrollBarWidth : 0);
        _scrollX = (_scrollX + viewW2).clamp(0, maxS);
        markDirty(DirtyBits.Visual);
    }

    override void fireMouseMove(int mx, int my)
    {
        if (_vThumbDragging)
        {
            // 拖拽垂直滑块
            int headerH = _headerVisible ? _rowHeight : 0;
            int delta = my - _vThumbDragStart;
            int trackH = height() - headerH - (needHScroll() ? _scrollBarWidth : 0);
            int totalH = _rowCount * _rowHeight;
            int thumbH = cast(int)((cast(long)trackH * trackH) / totalH);
            if (thumbH < 16) thumbH = 16;
            if (thumbH > trackH) thumbH = trackH;
            int movable = trackH - thumbH;
            if (movable > 0)
            {
                int maxS = maxScroll();
                int valueDelta = (delta * maxS) / movable;
                _scrollY = (_vThumbDragStartScroll + valueDelta).clamp(0, maxS);
                markDirty(DirtyBits.Visual);
            }
            return;
        }
        if (_hThumbDragging)
        {
            // 拖拽水平滑块
            int delta = mx - _hThumbDragStart;
            int trackW = width() - (needVScroll() ? _scrollBarWidth : 0);
            int totalW = totalColWidth();
            int thumbW = cast(int)((cast(long)trackW * trackW) / totalW);
            if (thumbW < 16) thumbW = 16;
            if (thumbW > trackW) thumbW = trackW;
            int movable = trackW - thumbW;
            if (movable > 0)
            {
                int maxS = maxScrollX();
                int valueDelta = (delta * maxS) / movable;
                _scrollX = (_hThumbDragStartScroll + valueDelta).clamp(0, maxS);
                markDirty(DirtyBits.Visual);
            }
            return;
        }
        super.fireMouseMove(mx, my);
    }

    override void fireMouseUp(int mx, int my, int button)
    {
        if (_vThumbDragging)
        {
            _vThumbDragging = false;
            markDirty(DirtyBits.Visual);
            return;
        }
        if (_hThumbDragging)
        {
            _hThumbDragging = false;
            markDirty(DirtyBits.Visual);
            return;
        }
        super.fireMouseUp(mx, my, button);
    }

    // ── 键盘事件 ──────────────────────────────────────────

    private void handleKeyDown(ref KeyEvent event)
    {
        if (_editing)
        {
            handleEditKeyDown(event);
        }
        else
        {
            handleNavKeyDown(event);
        }
    }

    /// 编辑模式下的键盘处理
    private void handleEditKeyDown(ref KeyEvent event)
    {
        switch (event.keyCode)
        {
            case VK_RETURN:
                commitEdit();
                break;

            case VK_ESCAPE:
                cancelEdit();
                break;

            case VK_TAB:
                commitEdit();
                // 移到下一个单元格
                if (_selectedCol + 1 < _colCount)
                {
                    _selectedCol++;
                }
                else if (_selectedRow + 1 < _rowCount)
                {
                    _selectedRow++;
                    _selectedCol = 0;
                }
                markDirty(DirtyBits.Visual);
                break;

            case VK_LEFT:
                if (event.shift)
                {
                    // Shift+←：扩展选区
                    if (_editSelStart < 0)
                    {
                        _editSelStart = _editCursorPos;
                        _editSelEnd = _editCursorPos;
                    }
                    if (_editCursorPos > 0)
                    {
                        int prev = _editCursorPos - 1;
                        while (prev > 0 && (_editText[prev] & 0xC0) == 0x80)
                            prev--;
                        _editCursorPos = prev;
                        _editSelEnd = prev;
                        markDirty(DirtyBits.Visual);
                    }
                }
                else
                {
                    // 无 Shift：移动光标，清除选区
                    if (hasEditSelection())
                    {
                        // 如果有选区，移动到选区起始
                        _editCursorPos = (_editSelStart < _editSelEnd) ? _editSelStart : _editSelEnd;
                        clearEditSelection();
                    }
                    else if (_editCursorPos > 0)
                    {
                        int prev = _editCursorPos - 1;
                        while (prev > 0 && (_editText[prev] & 0xC0) == 0x80)
                            prev--;
                        _editCursorPos = prev;
                    }
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_RIGHT:
                if (event.shift)
                {
                    // Shift+→：扩展选区
                    if (_editSelStart < 0)
                    {
                        _editSelStart = _editCursorPos;
                        _editSelEnd = _editCursorPos;
                    }
                    if (_editCursorPos < cast(int)_editText.length)
                    {
                        int next = _editCursorPos + 1;
                        while (next < cast(int)_editText.length && (_editText[next] & 0xC0) == 0x80)
                            next++;
                        _editCursorPos = next;
                        _editSelEnd = next;
                        markDirty(DirtyBits.Visual);
                    }
                }
                else
                {
                    // 无 Shift：移动光标，清除选区
                    if (hasEditSelection())
                    {
                        // 如果有选区，移动到选区结束
                        _editCursorPos = (_editSelStart < _editSelEnd) ? _editSelEnd : _editSelStart;
                        clearEditSelection();
                    }
                    else if (_editCursorPos < cast(int)_editText.length)
                    {
                        int next = _editCursorPos + 1;
                        while (next < cast(int)_editText.length && (_editText[next] & 0xC0) == 0x80)
                            next++;
                        _editCursorPos = next;
                    }
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_HOME:
                if (event.shift)
                {
                    // Shift+Home：扩展选区到开头
                    if (_editSelStart < 0)
                    {
                        _editSelStart = _editCursorPos;
                        _editSelEnd = _editCursorPos;
                    }
                    _editCursorPos = 0;
                    _editSelEnd = 0;
                    markDirty(DirtyBits.Visual);
                }
                else
                {
                    _editCursorPos = 0;
                    clearEditSelection();
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_END:
                if (event.shift)
                {
                    // Shift+End：扩展选区到末尾
                    if (_editSelStart < 0)
                    {
                        _editSelStart = _editCursorPos;
                        _editSelEnd = _editCursorPos;
                    }
                    _editCursorPos = cast(int)_editText.length;
                    _editSelEnd = _editCursorPos;
                    markDirty(DirtyBits.Visual);
                }
                else
                {
                    _editCursorPos = cast(int)_editText.length;
                    clearEditSelection();
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_BACK:
                if (hasEditSelection())
                {
                    // 有选区时删除选区
                    int selMin = (_editSelStart < _editSelEnd) ? _editSelStart : _editSelEnd;
                    int selMax = (_editSelStart < _editSelEnd) ? _editSelEnd : _editSelStart;
                    _editText = _editText[0 .. selMin] ~ _editText[selMax .. $];
                    _editCursorPos = selMin;
                    clearEditSelection();
                    markDirty(DirtyBits.Visual);
                }
                else if (_editCursorPos > 0 && _editText.length > 0)
                {
                    // 删除前一个码点
                    int prevStart = _editCursorPos - 1;
                    while (prevStart > 0 && (_editText[prevStart] & 0xC0) == 0x80)
                        prevStart--;
                    _editText = _editText[0 .. prevStart] ~ _editText[_editCursorPos .. $];
                    _editCursorPos = prevStart;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_DELETE:
                if (hasEditSelection())
                {
                    // 有选区时删除选区
                    int selMin = (_editSelStart < _editSelEnd) ? _editSelStart : _editSelEnd;
                    int selMax = (_editSelStart < _editSelEnd) ? _editSelEnd : _editSelStart;
                    _editText = _editText[0 .. selMin] ~ _editText[selMax .. $];
                    _editCursorPos = selMin;
                    clearEditSelection();
                    markDirty(DirtyBits.Visual);
                }
                else if (_editCursorPos < cast(int)_editText.length)
                {
                    // 删除当前码点
                    int cpEnd = _editCursorPos + 1;
                    while (cpEnd < cast(int)_editText.length && (_editText[cpEnd] & 0xC0) == 0x80)
                        cpEnd++;
                    _editText = _editText[0 .. _editCursorPos] ~ _editText[cpEnd .. $];
                    markDirty(DirtyBits.Visual);
                }
                break;

            default:
                break;
        }
    }

    /// 非编辑模式下的键盘处理（导航）
    private void handleNavKeyDown(ref KeyEvent event)
    {
        switch (event.keyCode)
        {
            case VK_RETURN:
            case VK_F2:
                // 回车或F2进入编辑模式
                if (_selectedRow >= 0 && _selectedCol >= 0 && isColEditable(_selectedCol))
                    beginEdit(_selectedRow, _selectedCol);
                break;

            case VK_UP:
                if (_selectedRow > 0)
                {
                    _selectedRow--;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_DOWN:
                if (_selectedRow < _rowCount - 1)
                {
                    _selectedRow++;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_LEFT:
                if (_selectedCol > 0)
                {
                    _selectedCol--;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_RIGHT:
                if (_selectedCol < _colCount - 1)
                {
                    _selectedCol++;
                    markDirty(DirtyBits.Visual);
                }
                break;

            default:
                break;
        }
    }

    // ── 文本输入事件 ──────────────────────────────────────

    private void handleTextInput(dchar ch)
    {
        if (!_editing)
            return;

        // 过滤控制字符（退格、Tab、Enter 等由 WM_KEYDOWN 处理）
        if (ch < 0x20)
            return;

        // 如果有选区，先删除
        if (hasEditSelection())
        {
            int selMin = (_editSelStart < _editSelEnd) ? _editSelStart : _editSelEnd;
            int selMax = (_editSelStart < _editSelEnd) ? _editSelEnd : _editSelStart;
            _editText = _editText[0 .. selMin] ~ _editText[selMax .. $];
            _editCursorPos = selMin;
            clearEditSelection();
        }

        // 编码 dchar 到 UTF-8
        char[4] buf;
        size_t encodedLen = encode(buf, ch);
        string charStr = buf[0 .. encodedLen].idup;

        // 在光标位置插入
        _editText = _editText[0 .. _editCursorPos] ~ charStr ~ _editText[_editCursorPos .. $];
        _editCursorPos += cast(int)encodedLen;
        markDirty(DirtyBits.Visual);
    }

    /// 获取指定列的宽度
    protected int getColWidth(int col) const
    {
        if (col >= 0 && col < cast(int)_colWidths.length)
            return _colWidths[col];
        // 默认等宽
        if (_colCount <= 0)
            return 100;
        return width() / _colCount;
    }

    // ── 渲染 ──────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("GridWidgetBase.renderWithGDI() at (", x(), ",", y(), ")");

        int rx = x();
        int ry = y();
        int rw = width();
        int rh = height();

        // ── 背景白色 ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetBkMode(hdc, TRANSPARENT);

        int headerH = _headerVisible ? _rowHeight : 0;
        int clipBottom = ry + rh;

        // ── 表头 ──
        if (_headerVisible)
        {
            // 表头背景
            RECT hdrRect = {
                cast(LONG)rx, cast(LONG)ry,
                cast(LONG)(rx + rw), cast(LONG)(ry + _rowHeight)
            };
            HBRUSH hdrBrush = CreateSolidBrush(cast(COLORREF)0x00E8E8E8);
            FillRect(hdc, &hdrRect, hdrBrush);
            DeleteObject(cast(HGDIOBJ)hdrBrush);

            // 表头文字
            SetTextColor(hdc, cast(COLORREF)0x00333333);
            int colX = rx - _scrollX;
            for (int c = 0; c < _colCount; c++)
            {
                int cw = getColWidth(c);
                string hdr = (_headerTextDelegate !is null) ? _headerTextDelegate(c) : headerText(c);
                wstring hdrW = toUTF16(hdr);
                int textX = colX + 4;
                int textY = ry + (_rowHeight - cast(int)_fontSize) / 2;
                TextOutW(hdc, textX, textY, cast(const(PWSTR))hdrW.ptr, cast(int)hdrW.length);
                colX += cw;
            }
        }

        // ── 逐行逐列渲染单元格 ──
        int bodyY = ry + headerH - _scrollY;
        for (int r = 0; r < _rowCount; r++)
        {
            int cellY = bodyY + r * _rowHeight;

            // 跳过不可见行
            if (cellY + _rowHeight <= ry + headerH)
                continue;
            if (cellY >= clipBottom)
                break;

            int colX = rx - _scrollX;
            for (int c = 0; c < _colCount; c++)
            {
                int cw = getColWidth(c);

                // 正在编辑的单元格：渲染编辑框
                if (_editing && r == _editRow && c == _editCol)
                {
                    renderEditCell(hdc, colX, cellY, cw);
                    colX += cw;
                    continue;
                }

                // 选中单元格高亮
                if (r == _selectedRow && c == _selectedCol)
                {
                    RECT selRect = {
                        cast(LONG)colX, cast(LONG)cellY,
                        cast(LONG)(colX + cw), cast(LONG)(cellY + _rowHeight)
                    };
                    // 可编辑列选中：蓝色背景；不可编辑列选中：灰色背景
                    COLORREF selColor = isColEditable(c) ? cast(COLORREF)0x00CCCCFF : cast(COLORREF)0x00E0E0E0;
                    HBRUSH selBrush = CreateSolidBrush(selColor);
                    FillRect(hdc, &selRect, selBrush);
                    DeleteObject(cast(HGDIOBJ)selBrush);
                }

                // 单元格文字
                SetTextColor(hdc, cast(COLORREF)0x00333333);
                string cell = (_cellTextDelegate !is null) ? _cellTextDelegate(r, c) : cellText(r, c);
                wstring cellW = toUTF16(cell);
                int textX = colX + 4;
                int textY = cellY + (_rowHeight - cast(int)_fontSize) / 2;
                TextOutW(hdc, textX, textY, cast(const(PWSTR))cellW.ptr, cast(int)cellW.length);

                colX += cw;
            }
        }

        FontCache.release(hdc, fontEntry);

        // ── 网格线 ──
        HPEN gridPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00CCCCCC);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)gridPen);

        // 水平线
        {
            // 表头底线
            if (_headerVisible)
            {
                MoveToEx(hdc, rx, ry + headerH, null);
                LineTo(hdc, rx + rw, ry + headerH);
            }
            // 行分隔线
            for (int r = 0; r <= _rowCount; r++)
            {
                int lineY = bodyY + r * _rowHeight;
                if (lineY < ry + headerH)
                    continue;
                if (lineY > clipBottom)
                    break;
                MoveToEx(hdc, rx, lineY, null);
                LineTo(hdc, rx + rw, lineY);
            }
        }

        // 垂直线
        {
            int colX = rx - _scrollX;
            for (int c = 0; c <= _colCount; c++)
            {
                MoveToEx(hdc, colX, ry, null);
                LineTo(hdc, colX, ry + rh);
                if (c < _colCount)
                    colX += getColWidth(c);
            }
        }

        SelectObject(hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)gridPen);

        // ── 滚动条 ──
        if (needVScroll())
            renderVScrollBar(hdc, rx, ry, rw, rh);
        if (needHScroll())
            renderHScrollBar(hdc, rx, ry, rw, rh);
        // 右下角交汇区域
        if (needVScroll() && needHScroll())
        {
            int cornerX = rx + rw - _scrollBarWidth;
            int cornerY = ry + rh - _scrollBarWidth;
            RECT cornerRect = { cast(LONG)cornerX, cast(LONG)cornerY,
                                cast(LONG)(cornerX + _scrollBarWidth), cast(LONG)(cornerY + _scrollBarWidth) };
            HBRUSH cornerBrush = CreateSolidBrush(cast(COLORREF)0x00E0E0E0);
            FillRect(hdc, &cornerRect, cornerBrush);
            DeleteObject(cast(HGDIOBJ)cornerBrush);
        }

        // ── 边框 ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00888888);
        HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, rx, ry, rx + rw, ry + rh);
        SelectObject(hdc, oldPen2);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);
    }

    /// 渲染垂直滚动条
    private void renderVScrollBar(HDC hdc, int rx, int ry, int rw, int rh)
    {
        int headerH = _headerVisible ? _rowHeight : 0;
        int sbX = rx + rw - _scrollBarWidth;
        int sbY = ry + headerH;
        int sbH = rh - headerH - (needHScroll() ? _scrollBarWidth : 0);
        if (sbH <= 0) return;

        // 轨道背景
        RECT trackRect = { cast(LONG)sbX, cast(LONG)sbY, cast(LONG)(sbX + _scrollBarWidth), cast(LONG)(sbY + sbH) };
        HBRUSH trackBrush = CreateSolidBrush(cast(COLORREF)0x00E0E0E0);
        FillRect(hdc, &trackRect, trackBrush);
        DeleteObject(cast(HGDIOBJ)trackBrush);

        // 滑块
        int totalH = _rowCount * _rowHeight;
        int thumbH = cast(int)((cast(long)sbH * sbH) / totalH);
        if (thumbH < 16) thumbH = 16;
        if (thumbH > sbH) thumbH = sbH;
        int movable = sbH - thumbH;
        int maxS = maxScroll();
        int thumbY;
        if (maxS <= 0) thumbY = 0;
        else thumbY = cast(int)((cast(long)_scrollY * movable) / maxS);

        RECT thumbRect = { cast(LONG)(sbX + 1), cast(LONG)(sbY + thumbY),
                           cast(LONG)(sbX + _scrollBarWidth - 1), cast(LONG)(sbY + thumbY + thumbH) };
        HBRUSH thumbBrush = CreateSolidBrush(cast(COLORREF)0x00C0C0C0);
        FillRect(hdc, &thumbRect, thumbBrush);
        DeleteObject(cast(HGDIOBJ)thumbBrush);
    }

    /// 渲染水平滚动条
    private void renderHScrollBar(HDC hdc, int rx, int ry, int rw, int rh)
    {
        int sbY = ry + rh - _scrollBarWidth;
        int sbX = rx;
        int sbW = rw - (needVScroll() ? _scrollBarWidth : 0);
        if (sbW <= 0) return;

        // 轨道背景
        RECT trackRect = { cast(LONG)sbX, cast(LONG)sbY, cast(LONG)(sbX + sbW), cast(LONG)(sbY + _scrollBarWidth) };
        HBRUSH trackBrush = CreateSolidBrush(cast(COLORREF)0x00E0E0E0);
        FillRect(hdc, &trackRect, trackBrush);
        DeleteObject(cast(HGDIOBJ)trackBrush);

        // 滑块
        int totalW = totalColWidth();
        int thumbW = cast(int)((cast(long)sbW * sbW) / totalW);
        if (thumbW < 16) thumbW = 16;
        if (thumbW > sbW) thumbW = sbW;
        int movable = sbW - thumbW;
        int maxS = maxScrollX();
        int thumbX;
        if (maxS <= 0) thumbX = 0;
        else thumbX = cast(int)((cast(long)_scrollX * movable) / maxS);

        RECT thumbRect = { cast(LONG)(sbX + thumbX), cast(LONG)(sbY + 1),
                           cast(LONG)(sbX + thumbX + thumbW), cast(LONG)(sbY + _scrollBarWidth - 1) };
        HBRUSH thumbBrush = CreateSolidBrush(cast(COLORREF)0x00C0C0C0);
        FillRect(hdc, &thumbRect, thumbBrush);
        DeleteObject(cast(HGDIOBJ)thumbBrush);
    }

    /// 渲染编辑中的单元格（白色背景 + 蓝色边框 + 文本 + 选区高亮 + 光标）
    private void renderEditCell(HDC hdc, int cellX, int cellY, int cellW)
    {
        // 白色背景
        RECT editRect = {
            cast(LONG)cellX, cast(LONG)cellY,
            cast(LONG)(cellX + cellW), cast(LONG)(cellY + _rowHeight)
        };
        HBRUSH editBrush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &editRect, editBrush);
        DeleteObject(cast(HGDIOBJ)editBrush);

        // 蓝色边框
        HPEN editPen = CreatePen(PS_SOLID, 2, cast(COLORREF)0x00FF6600);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)editPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, cellX, cellY, cellX + cellW, cellY + _rowHeight);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)editPen);

        // 编辑文本
        SetTextColor(hdc, cast(COLORREF)0x00000000);
        wstring editW = toUTF16(_editText);
        int textX = cellX + 4;
        int textY = cellY + (_rowHeight - cast(int)_fontSize) / 2;

        // 选区高亮（先画选区背景，再画文本覆盖）
        if (hasEditSelection())
        {
            int selMin = (_editSelStart < _editSelEnd) ? _editSelStart : _editSelEnd;
            int selMax = (_editSelStart < _editSelEnd) ? _editSelEnd : _editSelStart;

            wstring beforeSel = toUTF16(_editText[0 .. selMin]);
            wstring selText = toUTF16(_editText[selMin .. selMax]);

            SIZE sizeBefore, sizeSel;
            GetTextExtentPointW(hdc, cast(const(PWSTR))beforeSel.ptr, cast(int)beforeSel.length, &sizeBefore);
            GetTextExtentPointW(hdc, cast(const(PWSTR))selText.ptr, cast(int)selText.length, &sizeSel);

            RECT selRect = {
                cast(LONG)(textX + sizeBefore.cx), cast(LONG)(cellY + 2),
                cast(LONG)(textX + sizeBefore.cx + sizeSel.cx), cast(LONG)(cellY + _rowHeight - 2)
            };
            HBRUSH selBrush = CreateSolidBrush(cast(COLORREF)0x00CCCCFF);
            FillRect(hdc, &selRect, selBrush);
            DeleteObject(cast(HGDIOBJ)selBrush);
        }

        // 渲染文本（TextOutW 会覆盖在选区背景之上）
        TextOutW(hdc, textX, textY, cast(const(PWSTR))editW.ptr, cast(int)editW.length);

        // 光标（闪烁效果：每 530ms 切换，使用 GetTickCount64）
        long tick = GetTickCount64();
        bool cursorOn = ((tick / 530) % 2) == 0;

        if (cursorOn)
        {
            // 测量光标位置之前的文本宽度
            wstring beforeCursor = toUTF16(_editText[0 .. _editCursorPos]);
            SIZE measured;
            GetTextExtentPointW(hdc, cast(const(PWSTR))beforeCursor.ptr,
                                cast(int)beforeCursor.length, &measured);

            int cursorX = textX + measured.cx;
            int cursorY1 = cellY + 2;
            int cursorY2 = cellY + _rowHeight - 2;

            HPEN cursorPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00000000);
            HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)cursorPen);
            MoveToEx(hdc, cursorX, cursorY1, null);
            LineTo(hdc, cursorX, cursorY2);
            SelectObject(hdc, oldPen2);
            DeleteObject(cast(HGDIOBJ)cursorPen);
        }
    }

    override void render() {}
}

