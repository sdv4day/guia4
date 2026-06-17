module guia4.guicore.eventdispatcher;

import guia4.guicore.control;
import guia4.guicore.events;

/**
 * EventDispatcher — 事件分发器
 *
 * 实现标准 DOM 风格的事件传播机制：
 * 1. 捕获阶段（Capturing）：从根控件到目标控件的父控件
 * 2. 目标阶段（AtTarget）：在目标控件上
 * 3. 冒泡阶段（Bubbling）：从目标控件的父控件到根控件
 *
 * 使用方式：
 *   EventDispatcher.dispatchEvent(widget, mouseEvent);
 */
struct EventDispatcher
{
    /// 分发鼠标事件（支持冒泡）
    static void dispatchMouseEvent(Control target, ref MouseEvent ev)
    {
        if (target is null) return;

        ev.target = target;

        // 构建从根到目标的路径
        Control[] path;
        Control current = target;
        while (current !is null)
        {
            path ~= current;
            current = current.parent();
        }
        // 反转：path[0] = 根，path[$-1] = 目标

        // 1. 捕获阶段（从根到目标的父控件）
        ev.phase = EventPhase.Capturing;
        for (int i = cast(int)path.length - 2; i >= 0 && !ev.propagationStopped; i--)
        {
            ev.phase = EventPhase.Capturing;
            path[i].fireMouseDown(ev.x, ev.y, ev.button);
            if (ev.propagationStopped) return;
        }

        // 2. 目标阶段
        if (!ev.propagationStopped)
        {
            ev.phase = EventPhase.AtTarget;
            target.fireMouseDown(ev.x, ev.y, ev.button);
        }

        // 3. 冒泡阶段（从目标的父控件到根）
        if (!ev.propagationStopped)
        {
            ev.phase = EventPhase.Bubbling;
            current = target.parent();
            while (current !is null && !ev.propagationStopped)
            {
                current.fireMouseDown(ev.x, ev.y, ev.button);
                current = current.parent();
            }
        }

        ev.phase = EventPhase.None;
    }

    /// 分发键盘事件（支持冒泡）
    static void dispatchKeyEvent(Control target, ref KeyEvent ev)
    {
        if (target is null) return;

        ev.target = target;

        // 构建从根到目标的路径
        Control[] path;
        Control current = target;
        while (current !is null)
        {
            path ~= current;
            current = current.parent();
        }

        // 1. 捕获阶段
        ev.phase = EventPhase.Capturing;
        for (int i = cast(int)path.length - 2; i >= 0 && !ev.propagationStopped; i--)
        {
            ev.phase = EventPhase.Capturing;
            path[i].fireKeyDown(ev.keyCode, ev.shift, ev.control, ev.alt);
            if (ev.propagationStopped) return;
        }

        // 2. 目标阶段
        if (!ev.propagationStopped)
        {
            ev.phase = EventPhase.AtTarget;
            target.fireKeyDown(ev.keyCode, ev.shift, ev.control, ev.alt);
        }

        // 3. 冒泡阶段
        if (!ev.propagationStopped)
        {
            ev.phase = EventPhase.Bubbling;
            current = target.parent();
            while (current !is null && !ev.propagationStopped)
            {
                current.fireKeyDown(ev.keyCode, ev.shift, ev.control, ev.alt);
                current = current.parent();
            }
        }

        ev.phase = EventPhase.None;
    }

    /// 分发滚轮事件（支持冒泡）
    static void dispatchWheelEvent(Control target, ref MouseWheelEvent ev)
    {
        if (target is null) return;

        ev.target = target;

        // 构建从根到目标的路径
        Control[] path;
        Control current = target;
        while (current !is null)
        {
            path ~= current;
            current = current.parent();
        }

        // 1. 捕获阶段
        ev.phase = EventPhase.Capturing;
        for (int i = cast(int)path.length - 2; i >= 0 && !ev.propagationStopped; i--)
        {
            ev.phase = EventPhase.Capturing;
            path[i].fireMouseWheel(ev.delta, ev.x, ev.y);
            if (ev.propagationStopped) return;
        }

        // 2. 目标阶段
        if (!ev.propagationStopped)
        {
            ev.phase = EventPhase.AtTarget;
            target.fireMouseWheel(ev.delta, ev.x, ev.y);
        }

        // 3. 冒泡阶段
        if (!ev.propagationStopped)
        {
            ev.phase = EventPhase.Bubbling;
            current = target.parent();
            while (current !is null && !ev.propagationStopped)
            {
                current.fireMouseWheel(ev.delta, ev.x, ev.y);
                current = current.parent();
            }
        }

        ev.phase = EventPhase.None;
    }

    /// 构建从根到目标的控件路径
    static Control[] buildPath(Control target)
    {
        Control[] path;
        Control current = target;
        while (current !is null)
        {
            path ~= current;
            current = current.parent();
        }
        return path;
    }
}
