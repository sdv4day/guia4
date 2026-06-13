module guia4.guicore.editbox;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import std.array;
import std.algorithm;
import std.conv;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;
import windows.win32.system.dataexchange;
import windows.win32.system.memory;

/**
 * EditBox — 多行编辑器控件
 *
 * 支持换行、上下方向键、鼠标点击定位。
 * 属性：text (多行), cursorLine, cursorCol, scrollY
 * 渲染：白色背景 + 边框 + 多行文字 + 滚动
 */
class EditBox : Control
{
    private string _text;
    private int _cursorLine = 0;
    private int _cursorCol = 0;
    private int _scrollY = 0;
    private bool _cursorVisible = true;
    private string[] _lines; /// 按行分割的文本

    private COLORREF _bgColor          = cast(COLORREF)0x00FFFFFF;
    private COLORREF _textColor        = cast(COLORREF)0x00000000;
    private COLORREF _borderColor      = cast(COLORREF)0x00CCCCCC;
    private COLORREF _focusBorderColor = cast(COLORREF)0x003366FF;
    private COLORREF _selectionBgColor = cast(COLORREF)0x00B0D0FF; /// 选区背景色（浅蓝色）
    private uint _fontSize = 14;
    private int _padding = 4;
    private int _lineHeight = 18; /// 每行像素高度

    // 选区支持
    private int _selectionStartLine = -1;  /// 选区起始行（-1=无选区）
    private int _selectionStartCol = -1;   /// 选区起始列
    private int _selectionEndLine = -1;    /// 选区结束行
    private int _selectionEndCol = -1;     /// 选区结束列
    private bool _isSelecting = false;     /// 正在拖选

    // 右键菜单
    private int _rightClickX = 0;
    private int _rightClickY = 0;
    private bool _contextMenuOpen = false;

    this(Control parent, string text = "")
    {
        super(parent);
        _text = text;
        splitLines();
        width = 200;
        height = 100;
        focusable = true;

        onKeyDown(&handleKeyEvent);
        onTextInput(&handleTextInput);
        onMouseWheel(&handleMouseWheel);

        logTrace("EditBox.ctor(parent=", parent !is null, ", text='", text, "')");
    }

    // ── 属性 ────────────────────────────────────────────────

    string text() const @property { return _text; }

    void text(string v) @property
    {
        _text = v;
        splitLines();
        clampCursor();
        markDirty(DirtyBits.Visual);
    }

    int cursorLine() const @property { return _cursorLine; }
    int cursorCol() const @property { return _cursorCol; }
    int scrollY() const @property { return _scrollY; }

    void scrollY(int v) @property
    {
        int maxScroll = maxScrollY();
        if (v < 0) v = 0;
        if (v > maxScroll) v = maxScroll;
        _scrollY = v;
        markDirty(DirtyBits.Visual);
    }

    /// 计算最大滚动偏移（确保最后一行可见）
    int maxScrollY() const @property
    {
        int maxScroll = cast(int)(_lines.length * _lineHeight) - (height() - _padding * 2);
        if (maxScroll < 0) maxScroll = 0;
        return maxScroll;
    }

    // ── 选区支持 ──────────────────────────────────────────

    /// 是否有选区
    bool hasSelection() const @property
    {
        if (_selectionStartLine < 0) return false;
        if (_selectionStartLine == _selectionEndLine && _selectionStartCol == _selectionEndCol) return false;
        return true;
    }

    /// 清除选区
    void clearSelection()
    {
        _selectionStartLine = -1;
        _selectionStartCol = -1;
        _selectionEndLine = -1;
        _selectionEndCol = -1;
        _isSelecting = false;
    }

    /// 选区文本
    string selectedText() const @property
    {
        if (!hasSelection()) return "";
        // 确保start <= end
        int sLine = _selectionStartLine, sCol = _selectionStartCol;
        int eLine = _selectionEndLine, eCol = _selectionEndCol;
        if (sLine > eLine || (sLine == eLine && sCol > eCol))
        {
            sLine = eLine; sCol = eCol;
            eLine = _selectionStartLine; eCol = _selectionStartCol;
        }
        if (sLine == eLine)
        {
            return _lines[sLine][sCol .. eCol];
        }
        // 多行选区
        string result = _lines[sLine][sCol .. $] ~ "\n";
        for (int i = sLine + 1; i < eLine; i++)
            result ~= _lines[i] ~ "\n";
        result ~= _lines[eLine][0 .. eCol];
        return result;
    }

    /// 删除选区文本
    private void deleteSelection()
    {
        if (!hasSelection()) return;
        int sLine = _selectionStartLine, sCol = _selectionStartCol;
        int eLine = _selectionEndLine, eCol = _selectionEndCol;
        if (sLine > eLine || (sLine == eLine && sCol > eCol))
        {
            sLine = eLine; sCol = eCol;
            eLine = _selectionStartLine; eCol = _selectionStartCol;
        }
        // 合并行：sLine的sCol前 + eLine的eCol后
        _lines[sLine] = _lines[sLine][0 .. sCol] ~ _lines[eLine][eCol .. $];
        // 删除中间行
        if (eLine > sLine)
        {
            string[] newLines;
            for (int i = 0; i < cast(int)_lines.length; i++)
            {
                if (i == sLine)
                    newLines ~= _lines[sLine];
                else if (i <= sLine || i > eLine)
                    newLines ~= _lines[i];
            }
            _lines = newLines;
        }
        _cursorLine = sLine;
        _cursorCol = sCol;
        clearSelection();
        joinLines();
        clampCursor();
        _cursorVisible = true;
        markDirty(DirtyBits.Visual);
    }

    /// 全选
    void selectAll()
    {
        _selectionStartLine = 0;
        _selectionStartCol = 0;
        _selectionEndLine = cast(int)_lines.length - 1;
        _selectionEndCol = cast(int)_lines[_selectionEndLine].length;
        _cursorLine = _selectionEndLine;
        _cursorCol = _selectionEndCol;
        markDirty(DirtyBits.Visual);
    }

    /// 检查右键菜单是否打开
    bool contextMenuOpen() const @property { return _contextMenuOpen; }

    // ── 剪贴板操作 ──────────────────────────────────────

    /// 剪切
    void cut()
    {
        if (hasSelection())
        {
            copyToClipboard(selectedText());
            deleteSelection();
        }
    }

    /// 复制
    void copy()
    {
        if (hasSelection())
        {
            copyToClipboard(selectedText());
        }
    }

    /// 粘贴
    void paste()
    {
        string clipText = pasteFromClipboard();
        if (clipText.length > 0)
        {
            if (hasSelection())
                deleteSelection();
            // 在光标位置插入（可能包含换行符）
            string line = _lines[_cursorLine];
            string before = line[0 .. _cursorCol];
            string after = line[_cursorCol .. $];

            // 按换行分割粘贴文本
            auto clipLines = clipText.splitter("\n").array;
            if (clipLines.length == 1)
            {
                // 单行粘贴
                _lines[_cursorLine] = before ~ clipLines[0] ~ after;
                _cursorCol += cast(int)clipLines[0].length;
            }
            else
            {
                // 多行粘贴
                _lines[_cursorLine] = before ~ clipLines[0];
                string[] newLines;
                for (int i = 0; i <= _cursorLine; i++)
                    newLines ~= _lines[i];
                for (int i = 1; i < cast(int)clipLines.length - 1; i++)
                    newLines ~= clipLines[i];
                newLines ~= clipLines[$-1] ~ after;
                for (int i = _cursorLine + 1; i < cast(int)_lines.length; i++)
                    newLines ~= _lines[i];
                _lines = newLines;
                _cursorLine += cast(int)clipLines.length - 1;
                _cursorCol = cast(int)clipLines[$-1].length;
            }
            _cursorVisible = true;
            joinLines();
            clampCursor();
            markDirty(DirtyBits.Visual);
        }
    }

    /// Win32 剪贴板：复制文本到剪贴板
    private void copyToClipboard(string txt)
    {
        if (OpenClipboard(HWND.init).Value != 0)
        {
            EmptyClipboard();
            wstring textW = toUTF16(txt);
            HGLOBAL hMem = GlobalAlloc(cast(GLOBAL_ALLOC_FLAGS)0x0002, (textW.length + 1) * wchar.sizeof);
            if (hMem.Value !is null)
            {
                void* pMem = GlobalLock(hMem);
                if (pMem !is null)
                {
                    import core.stdc.string : memcpy;
                    memcpy(pMem, textW.ptr, textW.length * wchar.sizeof);
                    (cast(wchar*)pMem)[textW.length] = 0;
                    GlobalUnlock(hMem);
                    SetClipboardData(cast(uint)13, HANDLE(hMem.Value));
                }
                else
                {
                    GlobalFree(hMem);
                }
            }
            CloseClipboard();
        }
    }

    /// Win32 剪贴板：从剪贴板粘贴文本
    private string pasteFromClipboard()
    {
        string result;
        if (OpenClipboard(HWND.init).Value != 0)
        {
            HANDLE hData = GetClipboardData(cast(uint)13);
            if (hData.Value !is null)
            {
                HGLOBAL hMem = HGLOBAL(hData.Value);
                const(wchar)* pMem = cast(const(wchar)*)GlobalLock(hMem);
                if (pMem !is null)
                {
                    int len = 0;
                    while (pMem[len] != 0) len++;
                    wstring ws = pMem[0 .. len].idup;
                    result = toUTF8(ws);
                    GlobalUnlock(hMem);
                }
            }
            CloseClipboard();
        }
        return result;
    }

    // ── 行分割 ──────────────────────────────────────────────

    private void splitLines()
    {
        if (_text.length == 0)
        {
            _lines = [""];
        }
        else
        {
            _lines = _text.splitter("\n").array;
            if (_lines.length == 0)
                _lines = [""];
        }
    }

    /// 合并行数组为完整文本
    private void joinLines()
    {
        _text = _lines.joiner("\n").to!string;
    }

    /// 确保光标位置合法
    private void clampCursor()
    {
        if (_cursorLine < 0) _cursorLine = 0;
        if (_cursorLine >= cast(int)_lines.length) _cursorLine = cast(int)_lines.length - 1;
        if (_cursorCol < 0) _cursorCol = 0;
        if (_cursorCol > cast(int)_lines[_cursorLine].length)
            _cursorCol = cast(int)_lines[_cursorLine].length;
    }

    // ── 文本输入处理 ──────────────────────────────────────

    private void handleTextInput(dchar ch)
    {
        logTrace("EditBox.handleTextInput(ch='", ch, "')");

        // 编码 dchar 到 UTF-8
        char[4] buf;
        size_t encodedLen = encode(buf, ch);
        string charStr = buf[0 .. encodedLen].idup;

        // 如果有选区，先删除选区
        if (hasSelection())
            deleteSelection();

        // 在光标位置插入字符
        string line = _lines[_cursorLine];
        _lines[_cursorLine] = line[0 .. _cursorCol] ~ charStr ~ line[_cursorCol .. $];
        _cursorCol += encodedLen;
        _cursorVisible = true;
        joinLines();
        markDirty(DirtyBits.Visual);
    }

    // ── 键盘处理 ─────────────────────────────────────────

    private void handleKeyEvent(ref KeyEvent event)
    {
        logTrace("EditBox.handleKeyEvent(keyCode=", event.keyCode, ")");

        // Ctrl+A 全选
        if (event.control && event.keyCode == 'A')
        {
            selectAll();
            return;
        }
        // Ctrl+C 复制
        if (event.control && event.keyCode == 'C')
        {
            copy();
            return;
        }
        // Ctrl+V 粘贴
        if (event.control && event.keyCode == 'V')
        {
            paste();
            return;
        }
        // Ctrl+X 剪切
        if (event.control && event.keyCode == 'X')
        {
            cut();
            return;
        }

        switch (event.keyCode)
        {
            case VK_UP:
                if (_cursorLine > 0)
                {
                    _cursorLine--;
                    clampCursor();
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_DOWN:
                if (_cursorLine < cast(int)_lines.length - 1)
                {
                    _cursorLine++;
                    clampCursor();
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_LEFT:
                if (_cursorCol > 0)
                {
                    // 向前移动一个码点
                    int prev = _cursorCol - 1;
                    while (prev > 0 && (_lines[_cursorLine][prev] & 0xC0) == 0x80)
                        prev--;
                    _cursorCol = prev;
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                else if (_cursorLine > 0)
                {
                    // 移到上一行末尾
                    _cursorLine--;
                    _cursorCol = cast(int)_lines[_cursorLine].length;
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_RIGHT:
                if (_cursorCol < cast(int)_lines[_cursorLine].length)
                {
                    // 向后移动一个码点
                    int next = _cursorCol + 1;
                    while (next < cast(int)_lines[_cursorLine].length && (_lines[_cursorLine][next] & 0xC0) == 0x80)
                        next++;
                    _cursorCol = next;
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                else if (_cursorLine < cast(int)_lines.length - 1)
                {
                    // 移到下一行开头
                    _cursorLine++;
                    _cursorCol = 0;
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_HOME:
                _cursorCol = 0;
                _cursorVisible = true;
                markDirty(DirtyBits.Visual);
                break;

            case VK_END:
                _cursorCol = cast(int)_lines[_cursorLine].length;
                _cursorVisible = true;
                markDirty(DirtyBits.Visual);
                break;

            case VK_BACK:
                if (hasSelection())
                {
                    deleteSelection();
                    break;
                }
                if (_cursorCol > 0)
                {
                    // 删除前一个码点
                    string line = _lines[_cursorLine];
                    int prevStart = _cursorCol - 1;
                    while (prevStart > 0 && (line[prevStart] & 0xC0) == 0x80)
                        prevStart--;
                    _lines[_cursorLine] = line[0 .. prevStart] ~ line[_cursorCol .. $];
                    _cursorCol = prevStart;
                    _cursorVisible = true;
                    joinLines();
                    markDirty(DirtyBits.Visual);
                }
                else if (_cursorLine > 0)
                {
                    // 删除换行符，合并到上一行
                    int prevLen = cast(int)_lines[_cursorLine - 1].length;
                    _lines[_cursorLine - 1] = _lines[_cursorLine - 1] ~ _lines[_cursorLine];
                    // 移除当前行
                    string[] newLines;
                    foreach (i, l; _lines)
                    {
                        if (i != _cursorLine)
                            newLines ~= l;
                    }
                    _lines = newLines;
                    _cursorLine--;
                    _cursorCol = prevLen;
                    _cursorVisible = true;
                    joinLines();
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_DELETE:
                if (hasSelection())
                {
                    deleteSelection();
                    break;
                }
                if (_cursorCol < cast(int)_lines[_cursorLine].length)
                {
                    // 删除当前码点
                    string line = _lines[_cursorLine];
                    int cpEnd = _cursorCol + 1;
                    while (cpEnd < cast(int)line.length && (line[cpEnd] & 0xC0) == 0x80)
                        cpEnd++;
                    _lines[_cursorLine] = line[0 .. _cursorCol] ~ line[cpEnd .. $];
                    _cursorVisible = true;
                    joinLines();
                    markDirty(DirtyBits.Visual);
                }
                else if (_cursorLine < cast(int)_lines.length - 1)
                {
                    // 删除换行符，合并下一行
                    _lines[_cursorLine] = _lines[_cursorLine] ~ _lines[_cursorLine + 1];
                    // 移除下一行
                    string[] newLines;
                    foreach (i, l; _lines)
                    {
                        if (i != _cursorLine + 1)
                            newLines ~= l;
                    }
                    _lines = newLines;
                    _cursorVisible = true;
                    joinLines();
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_RETURN:
                // 插入换行，分割当前行
                string line = _lines[_cursorLine];
                string before = line[0 .. _cursorCol];
                string after = line[_cursorCol .. $];
                _lines[_cursorLine] = before;
                // 在下一行位置插入
                string[] newLines;
                foreach (i, l; _lines)
                {
                    newLines ~= l;
                    if (i == _cursorLine)
                        newLines ~= after;
                }
                _lines = newLines;
                _cursorLine++;
                _cursorCol = 0;
                _cursorVisible = true;
                joinLines();
                markDirty(DirtyBits.Visual);
                break;

            default:
                break;
        }
    }

    // ── 焦点处理 ────────────────────────────────────────────

    override bool hasFocus() const @property
    {
        return super.hasFocus;
    }

    override void hasFocus(bool v) @property
    {
        super.hasFocus(v);
        _cursorVisible = v;
        markDirty(DirtyBits.Visual);
    }

    /// 由闪烁定时器调用
    void cursorTick()
    {
        if (hasFocus())
        {
            _cursorVisible = !_cursorVisible;
            markDirty(DirtyBits.Visual);
        }
    }

    // ── 鼠标事件 ──────────────────────────────────────────

    /// 根据点击位置定位光标
    private void positionCursorFromClick(int x, int y)
    {
        int localY = y - _padding;
        int lineIdx = (localY + _scrollY) / _lineHeight;
        if (lineIdx < 0) lineIdx = 0;
        if (lineIdx >= cast(int)_lines.length) lineIdx = cast(int)_lines.length - 1;
        _cursorLine = lineIdx;

        int localX = x - _padding;
        if (localX < 0) localX = 0;
        string line = _lines[_cursorLine];

        if (line.length > 0)
        {
            HDC tempDC = CreateCompatibleDC(cast(HDC)null);
            if (tempDC.Value !is null)
            {
                auto fontEntry = FontCache.get(tempDC, "Segoe UI", cast(int)_fontSize);
                wstring lineW = toUTF16(line);
                SIZE lineSize;
                GetTextExtentPointW(tempDC, cast(const(PWSTR))lineW.ptr, cast(int)lineW.length, &lineSize);

                double ratio = (lineSize.cx > 0) ? cast(double)localX / cast(double)lineSize.cx : 0.0;
                if (ratio > 1.0) ratio = 1.0;
                _cursorCol = cast(int)(line.length * ratio);

                FontCache.release(tempDC, fontEntry);
                DeleteDC(tempDC);
            }
            else
            {
                _cursorCol = cast(int)line.length;
            }
        }
        else
        {
            _cursorCol = 0;
        }
    }

    override void fireMouseDown(int x, int y, int button)
    {
        logTrace("EditBox.fireMouseDown(x=", x, ", y=", y, ", button=", button, ")");

        // 右键
        if (button == 1)
        {
            // 先定位光标
            positionCursorFromClick(x, y);
            // 显示右键菜单
            _rightClickX = x;
            _rightClickY = y;
            _contextMenuOpen = true;
            markDirty(DirtyBits.Visual);
            return;
        }

        // 左键
        _contextMenuOpen = false;

        // 定位光标
        positionCursorFromClick(x, y);

        // 开始拖选
        _isSelecting = true;
        _selectionStartLine = _cursorLine;
        _selectionStartCol = _cursorCol;
        _selectionEndLine = _cursorLine;
        _selectionEndCol = _cursorCol;

        _cursorVisible = true;
        markDirty(DirtyBits.Visual);
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        if (button == 0 && _isSelecting)
        {
            _isSelecting = false;
            if (_selectionStartLine == _selectionEndLine && _selectionStartCol == _selectionEndCol)
                clearSelection();
            markDirty(DirtyBits.Visual);
        }
        super.fireMouseUp(x, y, button);
    }

    override void fireMouseMove(int x, int y)
    {
        if (_isSelecting)
        {
            positionCursorFromClick(x, y);
            _selectionEndLine = _cursorLine;
            _selectionEndCol = _cursorCol;
            markDirty(DirtyBits.Visual);
        }
        super.fireMouseMove(x, y);
    }

    private void handleMouseWheel(ref MouseWheelEvent ev)
    {
        // 滚轮滚动
        int scrollDelta = (ev.delta > 0) ? -3 : 3;
        scrollY = _scrollY + scrollDelta;

        markDirty(DirtyBits.Visual);
    }

    // ── 渲染 ──────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        // 关键修复：视口已经被偏移到控件位置，所以使用 (0, 0) 作为基准
        logTrace("EditBox.renderWithGDI() size=(", width(), ",", height(), ")");

        int rx = 0;
        int ry = 0;
        int rw = width();
        int rh = height();

        // ── 白色背景 ──
        RECT rect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(_bgColor);
        FillRect(hdc, &rect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── 边框 ──
        COLORREF border = hasFocus() ? _focusBorderColor : _borderColor;
        HPEN borderPen = CreatePen(PS_SOLID, 1, border);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, rect.left, rect.top, rect.right, rect.bottom);
        SelectObject(hdc, oldBrush);
        SelectObject(hdc, oldPen);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── 多行文字 + 选区高亮 ──
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetTextColor(hdc, _textColor);
        SetBkMode(hdc, TRANSPARENT);

        int textX = rx + _padding;
        int textY = ry + _padding - _scrollY;
        int visibleHeight = rh - _padding * 2;

        // 计算规范化选区范围（确保 start <= end）
        int selSLine = -1, selSCol = -1, selELine = -1, selECol = -1;
        if (hasSelection())
        {
            selSLine = _selectionStartLine; selSCol = _selectionStartCol;
            selELine = _selectionEndLine; selECol = _selectionEndCol;
            if (selSLine > selELine || (selSLine == selELine && selSCol > selECol))
            {
                selSLine = _selectionEndLine; selSCol = _selectionEndCol;
                selELine = _selectionStartLine; selECol = _selectionStartCol;
            }
        }

        foreach (i, line; _lines)
        {
            int lineY = textY + cast(int)i * _lineHeight;

            // 跳过不可见行
            if (lineY + _lineHeight < ry + _padding)
                continue;
            if (lineY > ry + rh - _padding)
                break;

            // ── 选区高亮 ──
            if (hasSelection() && cast(int)i >= selSLine && cast(int)i <= selELine)
            {
                // 计算该行的选区起始列和结束列
                int lineSelStartCol = 0;
                int lineSelEndCol = cast(int)line.length;

                if (cast(int)i == selSLine)
                    lineSelStartCol = selSCol;
                if (cast(int)i == selELine)
                    lineSelEndCol = selECol;

                if (lineSelStartCol < lineSelEndCol)
                {
                    // 测量选区起始位置X
                    int selStartX = textX;
                    if (lineSelStartCol > 0 && line.length > 0)
                    {
                        int clamped = (lineSelStartCol <= cast(int)line.length) ? lineSelStartCol : cast(int)line.length;
                        wstring beforeSel = toUTF16(line[0 .. clamped]);
                        SIZE measured;
                        GetTextExtentPointW(hdc, cast(const(PWSTR))beforeSel.ptr,
                                            cast(int)beforeSel.length, &measured);
                        selStartX += measured.cx;
                    }

                    // 测量选区结束位置X
                    int selEndX = textX;
                    if (lineSelEndCol > 0 && line.length > 0)
                    {
                        int clamped = (lineSelEndCol <= cast(int)line.length) ? lineSelEndCol : cast(int)line.length;
                        wstring beforeEnd = toUTF16(line[0 .. clamped]);
                        SIZE measured;
                        GetTextExtentPointW(hdc, cast(const(PWSTR))beforeEnd.ptr,
                                            cast(int)beforeEnd.length, &measured);
                        selEndX += measured.cx;
                    }

                    RECT selRect = {
                        cast(LONG)selStartX, cast(LONG)lineY,
                        cast(LONG)selEndX, cast(LONG)(lineY + _lineHeight)
                    };
                    HBRUSH selBrush = CreateSolidBrush(_selectionBgColor);
                    FillRect(hdc, &selRect, selBrush);
                    DeleteObject(cast(HGDIOBJ)selBrush);
                }
            }

            if (line.length > 0)
            {
                wstring lineW = toUTF16(line);
                TextOutW(hdc, textX, lineY, cast(const(PWSTR))lineW.ptr, cast(int)lineW.length);
            }
        }

        // ── 光标 ──
        if (hasFocus() && _cursorVisible)
        {
            int cursorY = textY + _cursorLine * _lineHeight;

            // 光标只在可见区域内绘制
            if (cursorY >= ry + _padding && cursorY < ry + rh - _padding)
            {
                // 测量光标位置之前的文本宽度
                string curLine = _lines[_cursorLine];
                int cursorX = textX;

                if (_cursorCol > 0 && curLine.length > 0)
                {
                    int colClamped = (_cursorCol <= cast(int)curLine.length) ? _cursorCol : cast(int)curLine.length;
                    wstring beforeCursor = toUTF16(curLine[0 .. colClamped]);
                    SIZE measured;
                    GetTextExtentPointW(hdc, cast(const(PWSTR))beforeCursor.ptr,
                                        cast(int)beforeCursor.length, &measured);
                    cursorX += measured.cx;
                }

                HPEN cursorPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00000000);
                HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)cursorPen);
                MoveToEx(hdc, cursorX, cursorY, null);
                LineTo(hdc, cursorX, cursorY + _lineHeight);
                SelectObject(hdc, oldPen2);
                DeleteObject(cast(HGDIOBJ)cursorPen);
            }
        }

        FontCache.release(hdc, fontEntry);
    }

    // ── 右键菜单 ──────────────────────────────────────────

    /// 处理右键菜单项点击（由 MainWindow 调用）
    bool handleContextMenuClick(int mx, int my)
    {
        if (!_contextMenuOpen) return false;

        int menuX = _rightClickX;
        int menuY = _rightClickY;
        int menuW = 120;
        int menuH = 4 * 24;

        if (mx >= menuX && mx < menuX + menuW && my >= menuY && my < menuY + menuH)
        {
            int itemIndex = (my - menuY) / 24;
            switch (itemIndex)
            {
                case 0: cut(); break;
                case 1: copy(); break;
                case 2: paste(); break;
                case 3: selectAll(); break;
                default: break;
            }
            _contextMenuOpen = false;
            markDirty(DirtyBits.Visual);
            return true;
        }

        _contextMenuOpen = false;
        markDirty(DirtyBits.Visual);
        return false;
    }

    /// 渲染右键上下文菜单（由 MainWindow 在所有内容之上调用）
    public void renderContextMenuOnly(HDC hdc, int absX, int absY)
    {
        int menuX = absX + _rightClickX;
        int menuY = absY + _rightClickY;
        int menuW = 120;
        int menuH = 4 * 24;

        RECT menuRect = { cast(LONG)menuX, cast(LONG)menuY, cast(LONG)(menuX + menuW), cast(LONG)(menuY + menuH) };
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &menuRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        HBRUSH borderBrush = CreateSolidBrush(cast(COLORREF)0x00CCCCCC);
        FrameRect(hdc, &menuRect, borderBrush);
        DeleteObject(cast(HGDIOBJ)borderBrush);

        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetTextColor(hdc, cast(COLORREF)0x00333333);
        SetBkMode(hdc, TRANSPARENT);

        string[4] labels = ["剪切", "复制", "粘贴", "全选"];
        foreach (i, label; labels)
        {
            int itemY = menuY + cast(int)i * 24;
            wstring textW = toUTF16(label);
            TextOutW(hdc, menuX + 8, itemY + (24 - cast(int)_fontSize) / 2,
                     cast(const(PWSTR))textW.ptr, cast(int)textW.length);
        }

        FontCache.release(hdc, fontEntry);
    }

    override void render()
    {
    }
}