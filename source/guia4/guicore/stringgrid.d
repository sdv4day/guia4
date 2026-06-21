module guia4.guicore.stringgrid;

import guia4.guicore.gridwidgetbase;
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
 * StringGrid — 字符串网格
 *
 * 继承 GridWidgetBase，用 string[][] 存储数据。
 * cellText 和 headerText 直接从数组返回。
 */
class StringGrid : GridWidgetBase
{
    private string[][] _data;     /// _data[row][col]
    private string[] _headers;    /// 列标题

    this(Control parent, string[] headers, string[][] data)
    {
        super(parent);
        _headers = headers;
        _data = data;
        _colCount = cast(int)headers.length;
        _rowCount = cast(int)data.length;
    }

    /// 设置数据（表头 + 数据）
    void setData(string[] headers, string[][] data)
    {
        _headers = headers;
        _data = data;
        _colCount = cast(int)headers.length;
        _rowCount = cast(int)data.length;
        markDirty();
    }

    /// 设置指定单元格的值
    void setCell(int row, int col, string value)
    {
        if (row >= 0 && row < cast(int)_data.length &&
            col >= 0 && col < cast(int)_data[row].length)
        {
            _data[row][col] = value;
        }
        markDirty();
    }

    /// 获取指定单元格的值
    string getCell(int row, int col) const
    {
        if (row >= 0 && row < cast(int)_data.length &&
            col >= 0 && col < cast(int)_data[row].length)
        {
            return _data[row][col];
        }
        return "";
    }

    /// 获取表头
    string[] headers() @property { return _headers; }

    /// 获取数据
    string[][] data() @property { return _data; }

    override string cellText(int row, int col)
    {
        if (row >= 0 && row < cast(int)_data.length &&
            col >= 0 && col < cast(int)_data[row].length)
        {
            return _data[row][col];
        }
        return "";
    }

    override string headerText(int col)
    {
        if (col >= 0 && col < cast(int)_headers.length)
            return _headers[col];
        return "";
    }

    /// 确认编辑：将编辑文本写入单元格
    override void commitEdit()
    {
        if (_editing)
        {
            // 始终先更新内部数据
            setCell(_editRow, _editCol, _editText);
        }
        // 然后触发回调（如果已设置）
        super.commitEdit();
    }
}
