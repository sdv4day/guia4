module guia4.guicore.clipboard;

import std.utf;

/// 平台无关的剪贴板操作
version(Windows)
{
    import windows.win32.system.dataexchange;
    import windows.win32.system.memory;
    import windows.win32.foundation;

    /// 复制文本到剪贴板
    void clipboardCopy(string text)
    {
        if (OpenClipboard(HWND.init).Value != 0)
        {
            EmptyClipboard();
            wstring textW = toUTF16(text);
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
                    GlobalFree(hMem);
            }
            CloseClipboard();
        }
    }

    /// 从剪贴板粘贴文本
    string clipboardPaste()
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

    /// 剪切文本（复制后清空选区）
    void clipboardCut(string text)
    {
        clipboardCopy(text);
    }
}
else version(linux)
{
    // TODO: Wayland/X11 clipboard 实现
    void clipboardCopy(string text) { /* placeholder */ }
    string clipboardPaste() { return ""; }
    void clipboardCut(string text) { clipboardCopy(text); }
}
