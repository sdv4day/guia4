module guia4.guicore.keyboarddispatcher;

import guia4.guicore.control;
import guia4.guicore.textinput;
import guia4.guicore.editbox;
import guia4.guicore.gridwidgetbase;
import guia4.guicore.focusmanager;
import guia4.platform.types : KeyEventData, CharEventData;
import guia4.platform_win32.win32defs : VK_TAB;
import guia4.utils.logger;

/**
 * KeyboardDispatcher — 键盘事件分发器
 *
 * 负责：
 * - 键盘事件分发（keyDown）
 * - 字符输入分发（charInput）
 * - Tab 焦点循环
 */
class KeyboardDispatcher
{
    private Control _owner;       // 拥有者控件（MainWindow）
    private FocusManager _focusManager;

    // 定时器控制委托（用于光标闪烁）
    private void delegate(uint, uint) _startTimer;
    private void delegate(uint) _stopTimer;

    // 重绘委托
    private void delegate() _requestRedraw;

    private static immutable uint BLINK_TIMER_ID = 1002;

    this(Control owner, FocusManager focusManager)
    {
        _owner = owner;
        _focusManager = focusManager;
    }

    /// 设置定时器委托
    void setTimerDelegates(void delegate(uint, uint) startTimer, void delegate(uint) stopTimer)
    {
        _startTimer = startTimer;
        _stopTimer = stopTimer;
    }

    /// 设置重绘委托
    void setRequestRedrawDelegate(void delegate() requestRedraw)
    {
        _requestRedraw = requestRedraw;
    }

    /// 获取当前焦点控件
    Control focusedControl() @property { return _focusManager.focusedControl; }

    /// 设置键盘焦点
    void setFocus(Control ctrl)
    {
        Control prevFocused = _focusManager.focusedControl;
        if (prevFocused is ctrl) return;

        // 停止旧控件的光标闪烁定时器
        if (prevFocused !is null && prevFocused !is _owner)
        {
            auto prevTi = cast(TextInput)prevFocused;
            auto prevEb = cast(EditBox)prevFocused;
            if (prevTi !is null || prevEb !is null)
                _stopTimer(BLINK_TIMER_ID);
        }

        _focusManager.setFocus(ctrl);

        // 启动新控件的光标闪烁定时器
        Control newFocused = _focusManager.focusedControl;
        if (newFocused !is null && newFocused !is _owner)
        {
            auto newTi = cast(TextInput)newFocused;
            auto newEb = cast(EditBox)newFocused;
            if (newTi !is null || newEb !is null)
                _startTimer(BLINK_TIMER_ID, 530);
        }
        _requestRedraw();
    }

    /// 键盘事件处理
    void handleKeyEvent(ref KeyEventData ev)
    {
        logTrace("KeyboardDispatcher.handleKeyEvent(keyCode=", ev.keyCode, ")");

        if (!ev.down) return;

        // Tab / Shift+Tab → 焦点循环
        if (ev.keyCode == VK_TAB)
        {
            auto grid = cast(GridWidgetBase)focusedControl;
            if (grid !is null && grid.isEditing())
            {
                focusedControl.fireKeyDown(ev.keyCode, ev.shift, ev.control, ev.alt);
                _requestRedraw();
                return;
            }
            cycleFocus(ev.shift);
            _requestRedraw();
            return;
        }

        // 转发到焦点控件
        if (focusedControl !is null)
        {
            focusedControl.fireKeyDown(ev.keyCode, ev.shift, ev.control, ev.alt);
        }
        _requestRedraw();
    }

    /// 字符输入处理
    void handleCharEvent(ref CharEventData ev)
    {
        logTrace("KeyboardDispatcher.handleCharEvent(ch='", ev.ch, "')");

        // 过滤控制字符
        if (ev.ch < 0x20 && ev.ch != 0x09 && ev.ch != 0x0A && ev.ch != 0x0D)
            return;

        if (focusedControl !is null)
        {
            focusedControl.fireTextInput(ev.ch);
            _requestRedraw();
        }
    }

    /// 焦点循环
    private void cycleFocus(bool reverse = false)
    {
        Control prevFocused = _focusManager.focusedControl;
        _focusManager.cycleFocus(_owner, reverse);
        Control newFocused = _focusManager.focusedControl;

        if (newFocused !is prevFocused)
        {
            // 停止旧控件的光标闪烁定时器
            if (prevFocused !is null && prevFocused !is _owner)
            {
                auto prevTi = cast(TextInput)prevFocused;
                auto prevEb = cast(EditBox)prevFocused;
                if (prevTi !is null || prevEb !is null)
                    _stopTimer(BLINK_TIMER_ID);
            }
            // 启动新控件的光标闪烁定时器
            if (newFocused !is null && newFocused !is _owner)
            {
                auto newTi = cast(TextInput)newFocused;
                auto newEb = cast(EditBox)newFocused;
                if (newTi !is null || newEb !is null)
                    _startTimer(BLINK_TIMER_ID, 530);
            }
            _requestRedraw();
        }
    }
}
