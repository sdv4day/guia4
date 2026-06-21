module guia4.guicore.comboboxmanager;

import guia4.guicore.control;
import guia4.guicore.combobox;
import guia4.utils.logger;
import windows.win32.graphics.gdi;

/**
 * ComboBoxManager — ComboBox 下拉列表管理器
 *
 * 负责：
 * - 查找打开的 ComboBox
 * - 更新下拉列表悬停状态
 * - 关闭所有下拉列表
 * - 渲染下拉列表
 */
class ComboBoxManager
{
    private Control _owner;

    // 坐标转换委托
    private void delegate(Control, out int, out int) _controlToClient;

    this(Control owner)
    {
        _owner = owner;
    }

    /// 设置坐标转换委托
    void setCoordinateDelegate(void delegate(Control, out int, out int) ctrlToClient)
    {
        _controlToClient = ctrlToClient;
    }

    /// 查找打开下拉列表的 ComboBox
    ComboBox findOpenComboBox(int px, int py)
    {
        return findOpenComboBoxInControl(_owner, px, py);
    }

    private ComboBox findOpenComboBoxInControl(Control c, int px, int py)
    {
        foreach (child; c.children())
        {
            int childAbsX, childAbsY;
            _controlToClient(child, childAbsX, childAbsY);

            auto cb = cast(ComboBox)child;
            if (cb !is null && cb.isDropDown())
            {
                int dropY = childAbsY + cb.height();
                int dropH = cast(int)cb.itemCount() * 24;
                if (dropH > 120) dropH = 120;

                if (px >= childAbsX && px < childAbsX + cb.width() &&
                    py >= childAbsY && py < dropY + dropH)
                {
                    return cb;
                }
            }
            auto result = findOpenComboBoxInControl(child, px, py);
            if (result !is null)
                return result;
        }
        return null;
    }

    /// 更新 ComboBox 下拉列表悬停
    void updateDropDownHover(int mx, int my)
    {
        updateDropDownHoverInControl(_owner, mx, my);
    }

    private void updateDropDownHoverInControl(Control c, int mx, int my)
    {
        foreach (child; c.children())
        {
            auto cb = cast(ComboBox)child;
            if (cb !is null && cb.isDropDown())
            {
                int childAbsX, childAbsY;
                _controlToClient(cb, childAbsX, childAbsY);
                cb.handleDropDownMouseMove(mx, my, childAbsX, childAbsY);
            }
            updateDropDownHoverInControl(child, mx, my);
        }
    }

    /// 关闭所有 ComboBox 的下拉列表
    void closeAllDropDowns()
    {
        closeAllDropDownsInControl(_owner);
    }

    private void closeAllDropDownsInControl(Control c)
    {
        foreach (child; c.children())
        {
            auto cb = cast(ComboBox)child;
            if (cb !is null && cb.isDropDown())
            {
                int childAbsX, childAbsY;
                _controlToClient(cb, childAbsX, childAbsY);
                cb.handleDropDownClick(-1, -1, childAbsX, childAbsY);
            }
            closeAllDropDownsInControl(child);
        }
    }

    /// 渲染所有打开的 ComboBox 下拉列表
    void renderDropDowns(HDC hdc)
    {
        void scanControls(Control ctrl)
        {
            foreach (child; ctrl.children())
            {
                auto cb = cast(ComboBox)child;
                if (cb !is null && cb.isDropDown())
                {
                    int childAbsX, childAbsY;
                    _controlToClient(cb, childAbsX, childAbsY);
                    cb.renderDropDownOnly(hdc, childAbsX, childAbsY);
                }
                scanControls(child);
            }
        }
        scanControls(_owner);
    }
}
