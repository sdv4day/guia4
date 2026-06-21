module guia4.guicore.filedialog;

import guia4.utils.logger;
import std.utf : toUTF16;
import std.conv : to;

/**
 * FileDialog — 文件选择对话框
 *
 * 使用 Win32 GetOpenFileNameW/GetSaveFileNameW API。
 * 静态方法接口，不需要渲染，不继承 Control。
 *
 * 注意：当前为简化实现，Win32 dialogs API 不可用时返回空字符串。
 * 后续可引入完整的 Win32 绑定后启用原生对话框。
 */
class FileDialog
{
    /// 显示打开文件对话框，返回选中的文件路径（空字符串表示取消）
    static string openFile(string title = "打开",
                           string filter = "所有文件\0*.*\0\0",
                           string defaultDir = "")
    {
        logTrace("FileDialog.openFile() title='", title, "'");

        version (Windows)
        {
            try
            {
                // 尝试使用 Win32 API
                import core.sys.windows.windows : OPENFILENAMEW, GetOpenFileNameW;
                OPENFILENAMEW ofn = OPENFILENAMEW.init;

                wchar[260] fileBuf = 0;

                ofn.lStructSize = cast(uint)OPENFILENAMEW.sizeof;
                ofn.hwndOwner = null;
                ofn.lpstrFile = fileBuf.ptr;
                ofn.nMaxFile = cast(uint)fileBuf.length;
                ofn.lpstrInitialDir = (defaultDir.length > 0) ? toUTF16(defaultDir).ptr : null;
                ofn.lpstrTitle = (title.length > 0) ? toUTF16(title).ptr : null;
                ofn.Flags = 0x00001000; // OFN_FILEMUSTEXIST

                // 过滤器
                if (filter.length > 0)
                {
                    wstring filterW;
                    foreach (c; filter)
                        filterW ~= cast(wchar)c;
                    if (filterW.length < 2 || filterW[$-2] != 0 || filterW[$-1] != 0)
                    {
                        filterW ~= cast(wchar)0;
                        filterW ~= cast(wchar)0;
                    }
                    ofn.lpstrFilter = filterW.ptr;
                }

                if (GetOpenFileNameW(&ofn))
                {
                    int len = 0;
                    while (len < 260 && fileBuf[len] != 0)
                        len++;
                    if (len > 0)
                    {
                        wstring pathW = fileBuf[0 .. len].idup;
                        return to!string(pathW);
                    }
                }
            }
            catch (Exception e)
            {
                logTrace("FileDialog.openFile() exception: ", e.msg);
            }
        }

        logTrace("FileDialog.openFile() - Win32 API unavailable, returning empty");
        return ""; // 取消或失败
    }

    /// 显示保存文件对话框，返回选中的文件路径（空字符串表示取消）
    static string saveFile(string title = "保存",
                           string filter = "所有文件\0*.*\0\0",
                           string defaultDir = "")
    {
        logTrace("FileDialog.saveFile() title='", title, "'");

        version (Windows)
        {
            try
            {
                import core.sys.windows.windows : OPENFILENAMEW, GetSaveFileNameW;
                OPENFILENAMEW ofn = OPENFILENAMEW.init;

                wchar[260] fileBuf = 0;

                ofn.lStructSize = cast(uint)OPENFILENAMEW.sizeof;
                ofn.hwndOwner = null;
                ofn.lpstrFile = fileBuf.ptr;
                ofn.nMaxFile = cast(uint)fileBuf.length;
                ofn.lpstrInitialDir = (defaultDir.length > 0) ? toUTF16(defaultDir).ptr : null;
                ofn.lpstrTitle = (title.length > 0) ? toUTF16(title).ptr : null;
                ofn.Flags = 0x00000002; // OFN_OVERWRITEPROMPT

                // 过滤器
                if (filter.length > 0)
                {
                    wstring filterW;
                    foreach (c; filter)
                        filterW ~= cast(wchar)c;
                    if (filterW.length < 2 || filterW[$-2] != 0 || filterW[$-1] != 0)
                    {
                        filterW ~= cast(wchar)0;
                        filterW ~= cast(wchar)0;
                    }
                    ofn.lpstrFilter = filterW.ptr;
                }

                if (GetSaveFileNameW(&ofn))
                {
                    int len = 0;
                    while (len < 260 && fileBuf[len] != 0)
                        len++;
                    if (len > 0)
                    {
                        wstring pathW = fileBuf[0 .. len].idup;
                        return to!string(pathW);
                    }
                }
            }
            catch (Exception e)
            {
                logTrace("FileDialog.saveFile() exception: ", e.msg);
            }
        }

        logTrace("FileDialog.saveFile() - Win32 API unavailable, returning empty");
        return ""; // 取消或失败
    }
}
