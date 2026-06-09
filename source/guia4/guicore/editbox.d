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
    private uint _fontSize = 14;
    private int _padding = 4;
    private int _lineHeight = 18; /// 每行像素高度

    this(string text = "")
    {
        super();
        _text = text;
        splitLines();
        width = 200;
        height = 100;
        focusable = true;

        onKeyDown(&handleKeyEvent);
        onTextInput(&handleTextInput);
        onMouseWheel(&handleMouseWheel);

        logTrace("EditBox.ctor(text='", text, "')");
    }

    this(Control parent, string text = "")
    {
        super();
        _text = text;
        splitLines();
        width = 200;
        height = 100;
        focusable = true;

        onKeyDown(&handleKeyEvent);
        onTextInput(&handleTextInput);
        onMouseWheel(&handleMouseWheel);

        if (parent)
            parent.addChild(this);
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

    override void fireMouseDown(int x, int y, int button)
    {
        logTrace("EditBox.fireMouseDown(x=", x, ", y=", y, ")");

        // 根据点击位置定位光标
        int localY = y - _padding;
        int lineIdx = (localY + _scrollY) / _lineHeight;
        if (lineIdx < 0) lineIdx = 0;
        if (lineIdx >= cast(int)_lines.length) lineIdx = cast(int)_lines.length - 1;
        _cursorLine = lineIdx;

        // 根据点击 X 定位列位置（简化：按字符比例）
        int localX = x - _padding;
        if (localX < 0) localX = 0;
        string line = _lines[_cursorLine];

        if (line.length > 0)
        {
            // 用临时 DC 测量字符位置
            HDC tempDC = CreateCompatibleDC(cast(HDC)null);
            if (tempDC.Value !is null)
            {
                auto fontEntry = FontCache.get(tempDC, "Segoe UI", cast(int)_fontSize);
                wstring lineW = toUTF16(line);
                SIZE lineSize;
                GetTextExtentPointW(tempDC, cast(const(PWSTR))lineW.ptr, cast(int)lineW.length, &lineSize);

                // 按比例估算字节位置
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

        _cursorVisible = true;
        markDirty(DirtyBits.Visual);
        super.fireMouseDown(x, y, button);
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
        logTrace("EditBox.renderWithGDI() at (", x(), ",", y(), ")");

        int rx = x();
        int ry = y();
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

        // ── 多行文字 ──
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);
        SetTextColor(hdc, _textColor);
        SetBkMode(hdc, TRANSPARENT);

        int textX = rx + _padding;
        int textY = ry + _padding - _scrollY;
        int visibleHeight = rh - _padding * 2;

        foreach (i, line; _lines)
        {
            int lineY = textY + cast(int)i * _lineHeight;

            // 跳过不可见行
            if (lineY + _lineHeight < ry + _padding)
                continue;
            if (lineY > ry + rh - _padding)
                break;

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

    override void render()
    {
    }
}