module demo3d_anim;

import demo3dcontrol;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/// 为 Demo3DControl 设置自动旋转定时器
/// 直接使用 Win32 SetTimer 进行连续动画
class Demo3DAnimHelper
{
    private Demo3DControl _ctrl3d;
    private HWND _hwnd;
    private uint _timerId;
    private static uint _nextTimerId = 2000;

    this(Demo3DControl ctrl, void* hwnd)
    {
        _ctrl3d = ctrl;
        _hwnd = cast(HWND)hwnd;
    }

    /// 启动自动旋转动画
    void startAutoRotate(uint intervalMs = 16) // ~60fps
    {
        if (_timerId > 0) return;
        _timerId = _nextTimerId++;
        SetTimer(_hwnd, _timerId, intervalMs, null);
    }

    /// 停止自动旋转动画
    void stopAutoRotate()
    {
        if (_timerId > 0)
        {
            KillTimer(_hwnd, _timerId);
            _timerId = 0;
        }
    }

    /// 处理定时器消息 — 在窗口的 WndProc 中调用
    bool handleTimer(uint id)
    {
        if (id == _timerId)
        {
            _ctrl3d.advanceFrame();
            // 触发重绘
            InvalidateRect(_hwnd, null, cast(BOOL)0);
            return true;
        }
        return false;
    }
}
