module guia4.guicore.focusmanager;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;

/**
 * FocusManager — 焦点管理器
 *
 * 负责管理控件焦点状态，包括：
 * - 设置/获取焦点控件
 * - Tab 键焦点循环
 * - 收集可聚焦控件列表
 *
 * 注意：此管理器只处理焦点状态，不处理平台相关的副作用
 * （如 TextInput/EditBox 的光标闪烁定时器）。
 * 这些副作用由 MainWindow.setFocus 处理。
 */
class FocusManager
{
    private Control _focusedControl;

    /// 获取当前焦点控件
    Control focusedControl() const @property { return cast(Control)_focusedControl; }

    /// 设置焦点到指定控件（纯状态变更，不触发定时器等副作用）
    /// 返回 true 表示焦点确实发生了变化
    bool setFocus(Control ctrl)
    {
        if (_focusedControl is ctrl)
            return false;

        // 移除旧焦点
        if (_focusedControl !is null)
        {
            _focusedControl.hasFocus(false);
        }

        // 设置新焦点
        _focusedControl = ctrl;

        if (_focusedControl !is null)
        {
            _focusedControl.hasFocus(true);
        }

        return true;
    }

    /// 清除焦点
    void clearFocus()
    {
        setFocus(null);
    }

    /// 收集所有可聚焦控件（深度优先遍历）
    static void collectFocusable(Control parent, ref Control[] list)
    {
        foreach (child; parent.children())
        {
            if (!child.visible()) continue;
            if (child.focusable())
                list ~= child;
            collectFocusable(child, list);
        }
    }

    /// 循环焦点（Tab / Shift+Tab）
    /// root: 焦点遍历的根控件（通常是 MainWindow）
    /// reverse: true = Shift+Tab（反向），false = Tab（正向）
    void cycleFocus(Control root, bool reverse = false)
    {
        Control[] focusableList;
        collectFocusable(root, focusableList);

        if (focusableList.length == 0)
            return;

        int idx = -1;
        if (_focusedControl !is null)
        {
            foreach (i, c; focusableList)
            {
                if (c is _focusedControl)
                {
                    idx = cast(int)i;
                    break;
                }
            }
        }

        if (reverse)
        {
            idx = (idx <= 0) ? cast(int)focusableList.length - 1 : idx - 1;
        }
        else
        {
            idx = (idx < 0 || idx >= cast(int)focusableList.length - 1) ? 0 : idx + 1;
        }

        setFocus(focusableList[idx]);
    }
}
