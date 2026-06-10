module guia4.guicore.textinput;

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
import windows.win32.system.dataexchange;
import windows.win32.system.memory;

/**
 * TextInput 控件 — 单行可编辑文本字段。
 *
 * 支持：
 *   - 可编辑文本字符串，带光标跟踪
 *   - 左/右、Home/End、Backspace、Delete 键盘导航
 *   - 文本插入（通过 onTextInput 处理 WM_CHAR）
 *   - 点击设置光标位置
 *   - 焦点边框 + 焦点时可见光标
 *   - 空文本未聚焦时显示占位符
 *   - 鼠标拖选多个字符
 *   - Shift+方向键扩展选区
 *   - Ctrl+A 全选
 *   - 右键上下文菜单（剪切/复制/粘贴/全选）
 *   - 剪贴板操作（Win32 API）
 *
 * Unicode：文本以 UTF-8 string 存储；光标位置为字节索引。
 * 导航和删除按完整码点推进。
 */
class TextInput : Control
{
    private string _text;
    private string _placeholder;
    private int _cursorPos;           /// UTF-8 字符串中的字节索引
    private bool _cursorVisible = true;

    private COLORREF _bgColor          = cast(COLORREF)0x00FFFFFF;
    private COLORREF _textColor        = cast(COLORREF)0x00000000;
    private COLORREF _borderColor      = cast(COLORREF)0x00CCCCCC;
    private COLORREF _focusBorderColor = cast(COLORREF)0x003366FF;
    private COLORREF _placeholderColor = cast(COLORREF)0x00AAAAAA;
    private COLORREF _selectionBgColor = cast(COLORREF)0x00B0D0FF; /// 选区背景色（浅蓝色）
    private uint _fontSize = 14;
    private int _padding = 4;

    // 选区支持
    private int _selectionStart = -1;   /// 选区起始字节位置（-1=无选区）
    private int _selectionEnd = -1;     /// 选区结束字节位置
    private bool _isSelecting = false;  /// 正在拖选
    private int _rightClickX = 0;       /// 右键菜单位置（控件本地坐标）
    private int _rightClickY = 0;
    private bool _contextMenuOpen = false; /// 右键菜单是否打开

    this(string text = "", string placeholder = "")
    {
        super();
        _text = text;
        _placeholder = placeholder;
        _cursorPos = cast(int)_text.length;
        width = 200;
        height = 28;
        focusable = true;

        onKeyDown(&handleKeyEvent);
        onTextInput(&handleTextInput);

        logTrace("TextInput.ctor(text='", text, "', placeholder='", placeholder, "')");
    }

    this(Control parent, string text = "", string placeholder = "")
    {
        this(text, placeholder);
        if (parent)
            parent.addChild(this);
    }

    // ── 属性 ────────────────────────────────────────────────

    string text() const @property { return _text; }
    void text(string v) @property
    {
        _text = v;
        if (_cursorPos > cast(int)_text.length)
            _cursorPos = cast(int)_text.length;
        clearSelection();
        markDirty(DirtyBits.Visual);
    }

    string placeholder() const @property { return _placeholder; }
    void placeholder(string v) @property { _placeholder = v; markDirty(DirtyBits.Visual); }

    int cursorPos() const @property { return _cursorPos; }

    // ── 选区属性和辅助方法 ──────────────────────────────────

    /// 是否有选区
    bool hasSelection() const @property
    {
        return _selectionStart >= 0 && _selectionEnd >= 0 && _selectionStart != _selectionEnd;
    }

    /// 选区文本
    string selectedText() const @property
    {
        if (!hasSelection()) return "";
        int start = _selectionStart < _selectionEnd ? _selectionStart : _selectionEnd;
        int end = _selectionStart < _selectionEnd ? _selectionEnd : _selectionStart;
        return _text[start .. end];
    }

    /// 选区起始（较小的位置）
    int selectionStart() const @property
    {
        if (!hasSelection()) return _cursorPos;
        return _selectionStart < _selectionEnd ? _selectionStart : _selectionEnd;
    }

    /// 选区结束（较大的位置）
    int selectionEnd() const @property
    {
        if (!hasSelection()) return _cursorPos;
        return _selectionStart < _selectionEnd ? _selectionEnd : _selectionStart;
    }

    /// 清除选区
    void clearSelection()
    {
        _selectionStart = -1;
        _selectionEnd = -1;
        _isSelecting = false;
    }

    /// 设置选区
    void setSelection(int start, int end)
    {
        _selectionStart = start.clamp(0, cast(int)_text.length);
        _selectionEnd = end.clamp(0, cast(int)_text.length);
        markDirty(DirtyBits.Visual);
    }

    /// 全选
    void selectAll()
    {
        _selectionStart = 0;
        _selectionEnd = cast(int)_text.length;
        _cursorPos = _selectionEnd;
        markDirty(DirtyBits.Visual);
    }

    /// 检查右键菜单是否打开
    bool contextMenuOpen() const @property { return _contextMenuOpen; }

    // ── 文本输入处理 ──────────────────────────────────────

    private void handleTextInput(dchar ch)
    {
        logTrace("TextInput.handleTextInput(ch='", ch, "')");

        // 如果有选区，先删除
        if (hasSelection())
            deleteSelection();

        // 编码 dchar 到 UTF-8
        char[4] buf;
        size_t encodedLen = encode(buf, ch);
        string charStr = buf[0 .. encodedLen].idup;

        // 在光标位置插入
        _text = _text[0 .. _cursorPos] ~ charStr ~ _text[_cursorPos .. $];
        _cursorPos += encodedLen;
        _cursorVisible = true;
        markDirty(DirtyBits.Visual);
    }

    // ── 键盘处理 ─────────────────────────────────────────

    /// 处理 KeyEvent：提取 keyCode 和修饰键，分发
    private void handleKeyEvent(ref KeyEvent event)
    {
        logTrace("TextInput.handleKeyEvent(keyCode=", event.keyCode, ", shift=", event.shift, ", control=", event.control, ")");

        bool shift = event.shift;
        bool ctrl = event.control;

        // Ctrl+A 全选
        if (ctrl && event.keyCode == 'A')
        {
            selectAll();
            return;
        }

        // Ctrl+C 复制
        if (ctrl && event.keyCode == 'C')
        {
            copy();
            return;
        }

        // Ctrl+V 粘贴
        if (ctrl && event.keyCode == 'V')
        {
            paste();
            return;
        }

        // Ctrl+X 剪切
        if (ctrl && event.keyCode == 'X')
        {
            cut();
            return;
        }

        switch (event.keyCode)
        {
            case VK_LEFT:
                if (_cursorPos > 0)
                {
                    // 向前移动一个码点
                    int prev = _cursorPos - 1;
                    while (prev > 0 && (_text[prev] & 0xC0) == 0x80)
                        prev--;

                    if (shift)
                    {
                        // Shift+Left：扩展选区
                        if (!hasSelection())
                        {
                            _selectionStart = _cursorPos;
                            _selectionEnd = prev;
                        }
                        else
                        {
                            _selectionEnd = prev;
                        }
                    }
                    else
                    {
                        // 无 Shift：如果有选区则跳到选区起始，否则正常移动
                        if (hasSelection())
                        {
                            _cursorPos = selectionStart();
                            clearSelection();
                        }
                        else
                        {
                            _cursorPos = prev;
                        }
                    }
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_RIGHT:
                if (_cursorPos < cast(int)_text.length)
                {
                    // 向后移动一个码点
                    int next = _cursorPos + 1;
                    while (next < cast(int)_text.length && (_text[next] & 0xC0) == 0x80)
                        next++;

                    if (shift)
                    {
                        // Shift+Right：扩展选区
                        if (!hasSelection())
                        {
                            _selectionStart = _cursorPos;
                            _selectionEnd = next;
                        }
                        else
                        {
                            _selectionEnd = next;
                        }
                    }
                    else
                    {
                        // 无 Shift：如果有选区则跳到选区结束，否则正常移动
                        if (hasSelection())
                        {
                            _cursorPos = selectionEnd();
                            clearSelection();
                        }
                        else
                        {
                            _cursorPos = next;
                        }
                    }
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_HOME:
                if (shift)
                {
                    if (!hasSelection())
                        _selectionStart = _cursorPos;
                    _selectionEnd = 0;
                }
                else
                {
                    _cursorPos = 0;
                    clearSelection();
                }
                _cursorVisible = true;
                markDirty(DirtyBits.Visual);
                break;

            case VK_END:
                if (shift)
                {
                    if (!hasSelection())
                        _selectionStart = _cursorPos;
                    _selectionEnd = cast(int)_text.length;
                }
                else
                {
                    _cursorPos = cast(int)_text.length;
                    clearSelection();
                }
                _cursorVisible = true;
                markDirty(DirtyBits.Visual);
                break;

            case VK_BACK:
                if (hasSelection())
                {
                    // 删除选区
                    deleteSelection();
                }
                else if (_cursorPos > 0 && _text.length > 0)
                {
                    // 查找前一个码点的起始
                    int prevStart = _cursorPos - 1;
                    while (prevStart > 0 && (_text[prevStart] & 0xC0) == 0x80)
                        prevStart--;
                    _text = _text[0 .. prevStart] ~ _text[_cursorPos .. $];
                    _cursorPos = prevStart;
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                break;

            case VK_DELETE:
                if (hasSelection())
                {
                    deleteSelection();
                }
                else if (_cursorPos < cast(int)_text.length)
                {
                    // 查找当前码点的结束
                    int cpEnd = _cursorPos + 1;
                    while (cpEnd < cast(int)_text.length && (_text[cpEnd] & 0xC0) == 0x80)
                        cpEnd++;
                    _text = _text[0 .. _cursorPos] ~ _text[cpEnd .. $];
                    _cursorVisible = true;
                    markDirty(DirtyBits.Visual);
                }
                break;

            default:
                // VK_RETURN, VK_UP, VK_DOWN 及其他键：无操作
                break;
        }
    }

    // ── 选区删除和剪贴板操作 ──────────────────────────────

    /// 删除选区文本
    private void deleteSelection()
    {
        if (!hasSelection()) return;
        int start = selectionStart();
        int end = selectionEnd();
        _text = _text[0 .. start] ~ _text[end .. $];
        _cursorPos = start;
        clearSelection();
        _cursorVisible = true;
        markDirty(DirtyBits.Visual);
    }

    /// 剪切选区文本到剪贴板
    void cut()
    {
        if (hasSelection())
        {
            copyToClipboard(selectedText());
            deleteSelection();
        }
    }

    /// 复制选区文本到剪贴板
    void copy()
    {
        if (hasSelection())
        {
            copyToClipboard(selectedText());
        }
    }

    /// 从剪贴板粘贴文本
    void paste()
    {
        string clipText = pasteFromClipboard();
        if (clipText.length > 0)
        {
            if (hasSelection())
                deleteSelection();
            _text = _text[0 .. _cursorPos] ~ clipText ~ _text[_cursorPos .. $];
            _cursorPos += cast(int)clipText.length;
            _cursorVisible = true;
            markDirty(DirtyBits.Visual);
        }
    }

    /// Win32 剪贴板：复制文本到剪贴板
    private void copyToClipboard(string txt)
    {
        if (OpenClipboard(HWND.init).Value != 0)
        {
            EmptyClipboard();
            // 转为 UTF-16
            wstring textW = toUTF16(txt);
            // 分配全局内存
            HGLOBAL hMem = GlobalAlloc(cast(GLOBAL_ALLOC_FLAGS)0x0002 /*GMEM_MOVEABLE*/, (textW.length + 1) * wchar.sizeof);
            if (hMem.Value !is null)
            {
                void* pMem = GlobalLock(hMem);
                if (pMem !is null)
                {
                    import core.stdc.string : memcpy;
                    memcpy(pMem, textW.ptr, textW.length * wchar.sizeof);
                    (cast(wchar*)pMem)[textW.length] = 0;
                    GlobalUnlock(hMem);
                    // SetClipboardData 接受 HANDLE，从 HGLOBAL 转换
                    SetClipboardData(cast(uint)13 /*CF_UNICODETEXT*/, HANDLE(hMem.Value));
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
            HANDLE hData = GetClipboardData(cast(uint)13 /*CF_UNICODETEXT*/);
            if (hData.Value !is null)
            {
                // 将 HANDLE 转为 HGLOBAL 以便 GlobalLock
                HGLOBAL hMem = HGLOBAL(hData.Value);
                const(wchar)* pMem = cast(const(wchar)*)GlobalLock(hMem);
                if (pMem !is null)
                {
                    // 计算长度
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

    // ── 焦点处理 ────────────────────────────────────────────

    // 覆写 getter 和 setter 以跟踪光标可见性
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

    /// 由闪烁定时器调用，切换光标可见性。
    void cursorTick()
    {
        if (hasFocus())
        {
            _cursorVisible = !_cursorVisible;
            markDirty(DirtyBits.Visual);
        }
    }

    // ── 鼠标事件处理 ──────────────────────────────────────

    override void fireMouseDown(int x, int y, int button)
    {
        logTrace("TextInput.fireMouseDown(x=", x, ", y=", y, ", button=", button, ")");

        if (button == 1)  // 右键
        {
            // 先定位光标
            positionCursorFromX(x);
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
        positionCursorFromX(x);

        // 开始拖选
        _isSelecting = true;
        _selectionStart = _cursorPos;
        _selectionEnd = _cursorPos;

        _cursorVisible = true;
        markDirty(DirtyBits.Visual);
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        if (button == 0 && _isSelecting)
        {
            _isSelecting = false;
            // 如果选区为空，清除选区
            if (_selectionStart == _selectionEnd)
                clearSelection();
            markDirty(DirtyBits.Visual);
        }
        super.fireMouseUp(x, y, button);
    }

    override void fireMouseMove(int x, int y)
    {
        if (_isSelecting)
        {
            // 更新选区结束位置
            positionCursorFromX(x);
            _selectionEnd = _cursorPos;
            markDirty(DirtyBits.Visual);
        }
        super.fireMouseMove(x, y);
    }

    /// 根据鼠标 x 位置定位光标
    private void positionCursorFromX(int x)
    {
        if (_text.length > 0 && width() > _padding * 2)
        {
            HDC tempDC = CreateCompatibleDC(cast(HDC)null);
            if (tempDC.Value !is null)
            {
                auto fontEntry = FontCache.get(tempDC, "Segoe UI", cast(int)_fontSize);
                int clickX = x - _padding;

                int bytePos = 0;
                int prevBytePos = 0;
                int prevWidth = 0;
                bool found = false;

                while (bytePos < cast(int)_text.length)
                {
                    wstring textUpTo = toUTF16(_text[0 .. bytePos]);
                    SIZE measured;
                    GetTextExtentPointW(tempDC, cast(const(PWSTR))textUpTo.ptr,
                                        cast(int)textUpTo.length, &measured);

                    if (measured.cx >= clickX)
                    {
                        int mid = (prevWidth + measured.cx) / 2;
                        _cursorPos = (clickX <= mid) ? prevBytePos : bytePos;
                        found = true;
                        break;
                    }

                    prevWidth = measured.cx;
                    prevBytePos = bytePos;

                    // 前进到下一个码点
                    bytePos++;
                    while (bytePos < cast(int)_text.length && (_text[bytePos] & 0xC0) == 0x80)
                        bytePos++;
                }

                if (!found)
                    _cursorPos = cast(int)_text.length;

                FontCache.release(tempDC, fontEntry);
                DeleteDC(tempDC);
            }
            else
            {
                _cursorPos = cast(int)_text.length;
            }
        }
        else
        {
            _cursorPos = cast(int)_text.length;
        }
    }

    /// 处理右键菜单项点击（由 MainWindow 调用）
    /// mx, my 是控件本地坐标
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

        // 点击菜单外，关闭菜单
        _contextMenuOpen = false;
        markDirty(DirtyBits.Visual);
        return false;
    }

    // ── 渲染 ────────────────────────────────────────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("TextInput.renderWithGDI() - '", _text, "' at (", x(), ",", y(), ")");

        int rx = x();
        int ry = y();
        int rw = width();
        int rh = height();

        // ── 背景 ──
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
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── 文本 ──
        auto fontEntry = FontCache.get(hdc, "Segoe UI", cast(int)_fontSize);

        int textX = rx + _padding;
        int textY = ry + (rh - cast(int)_fontSize) / 2;

        // 决定显示文本 vs 占位符
        string displayText = _text;
        COLORREF textCol = _textColor;
        if (displayText.length == 0 && _placeholder.length > 0 && !hasFocus())
        {
            displayText = _placeholder;
            textCol = _placeholderColor;
        }

        // ── 选区高亮 ──
        // 只在有选区且显示的是实际文本（非占位符）时绘制
        if (hasSelection() && displayText is _text)
        {
            int selStart = selectionStart();
            int selEnd = selectionEnd();

            // 测量选区起始和结束的像素位置
            wstring beforeSel = toUTF16(_text[0 .. selStart]);
            wstring selText = toUTF16(_text[selStart .. selEnd]);

            SIZE beforeSize, selSize;
            GetTextExtentPointW(hdc, cast(const(PWSTR))beforeSel.ptr,
                                cast(int)beforeSel.length, &beforeSize);
            GetTextExtentPointW(hdc, cast(const(PWSTR))selText.ptr,
                                cast(int)selText.length, &selSize);

            // 绘制选区背景
            RECT selRect = {
                cast(LONG)(textX + beforeSize.cx), cast(LONG)textY,
                cast(LONG)(textX + beforeSize.cx + selSize.cx), cast(LONG)(textY + cast(int)_fontSize)
            };
            HBRUSH selBrush = CreateSolidBrush(_selectionBgColor);
            FillRect(hdc, &selRect, selBrush);
            DeleteObject(cast(HGDIOBJ)selBrush);
        }

        SetTextColor(hdc, textCol);
        SetBkMode(hdc, TRANSPARENT);

        wstring textW = toUTF16(displayText);
        TextOutW(hdc, textX, textY, cast(const(PWSTR))textW.ptr, cast(int)textW.length);

        // ── 光标 ──
        if (hasFocus() && _cursorVisible)
        {
            // 测量光标位置之前的文本宽度
            wstring beforeCursor = toUTF16(displayText[0 .. _cursorPos]);
            SIZE measured;
            GetTextExtentPointW(hdc, cast(const(PWSTR))beforeCursor.ptr,
                                cast(int)beforeCursor.length, &measured);

            int cursorX = textX + measured.cx;
            int cursorY1 = ry + _padding;
            int cursorY2 = ry + rh - _padding;

            HPEN cursorPen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00000000);
            HGDIOBJ oldPen2 = SelectObject(hdc, cast(HGDIOBJ)cursorPen);
            MoveToEx(hdc, cursorX, cursorY1, null);
            LineTo(hdc, cursorX, cursorY2);
            SelectObject(hdc, oldPen2);
            DeleteObject(cast(HGDIOBJ)cursorPen);
        }

        FontCache.release(hdc, fontEntry);

    }

    /// 渲染右键上下文菜单（由 MainWindow 在所有内容之上调用）
    public void renderContextMenuOnly(HDC hdc, int absX, int absY)
    {
        int menuX = absX + _rightClickX;
        int menuY = absY + _rightClickY;
        int menuW = 120;
        int menuH = 4 * 24; // 4项：剪切、复制、粘贴、全选

        // 背景
        RECT menuRect = { cast(LONG)menuX, cast(LONG)menuY, cast(LONG)(menuX + menuW), cast(LONG)(menuY + menuH) };
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(hdc, &menuRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // 边框
        HBRUSH borderBrush = CreateSolidBrush(cast(COLORREF)0x00CCCCCC);
        FrameRect(hdc, &menuRect, borderBrush);
        DeleteObject(cast(HGDIOBJ)borderBrush);

        // 菜单项文字
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

