module guia4.guicore.mousedispatcher;

import guia4.guicore.control;
import guia4.guicore.tabhost;
import guia4.guicore.menubar;
import guia4.guicore.combobox;
import guia4.guicore.popup;
import guia4.guicore.textinput;
import guia4.guicore.editbox;
import guia4.platform.types : MouseEventData;
import guia4.utils.logger;

/**
 * MouseDispatcher — 鼠标事件分发器
 *
 * 负责：
 * - 命中测试（hitTestChild）
 * - 鼠标事件分发（按下/释放/移动）
 * - 捕获/悬停状态管理
 */
class MouseDispatcher
{
    private Control _owner;           // 拥有者控件（MainWindow）
    private Control _capturedControl; // 接收 mouse-down 的控件（用于 click 检测）
    private Control _hoveredControl;  // 当前光标下的控件

    // 坐标转换委托
    private void delegate(Control, out int, out int) _controlToClient;
    private void delegate(Control, int, int, out int, out int) _clientToControl;

    // 焦点设置委托
    private void delegate(Control) _setFocus;
    private Control delegate() _getFocusedControl;

    // 请求重绘委托
    private void delegate() _requestRedraw;

    this(Control owner)
    {
        _owner = owner;
    }

    /// 设置坐标转换委托
    void setCoordinateDelegates(
        void delegate(Control, out int, out int) ctrlToClient,
        void delegate(Control, int, int, out int, out int) clientToCtrl)
    {
        _controlToClient = ctrlToClient;
        _clientToControl = clientToCtrl;
    }

    /// 设置焦点委托
    void setFocusDelegates(void delegate(Control) setFocus, Control delegate() getFocused)
    {
        _setFocus = setFocus;
        _getFocusedControl = getFocused;
    }

    /// 设置重绘委托
    void setRequestRedrawDelegate(void delegate() requestRedraw)
    {
        _requestRedraw = requestRedraw;
    }

    /// 当前悬停的控件
    Control hoveredControl() @property { return _hoveredControl; }

    /// 当前捕获的控件
    Control capturedControl() @property { return _capturedControl; }

    /// 鼠标事件处理入口
    void handleMouseEvent(ref MouseEventData ev)
    {
        logTrace("MouseDispatcher.handleMouseEvent(x=", ev.x, ", y=", ev.y, ")");

        if (ev.leave)
        {
            if (_hoveredControl !is null && _hoveredControl !is _owner)
                _hoveredControl.fireMouseMove(-1, -1);
            _hoveredControl = null;
            _capturedControl = null;
            _requestRedraw();
            return;
        }

        // 命中测试
        Control target = hitTestChild(_owner, ev.x, ev.y);
        if (target is null)
            target = _owner;

        if (ev.down)
            handleMouseDown(ev, target);
        else if (!ev.move)
            handleMouseUp(ev, target);
        else
            handleMouseMove(ev, target);
    }

    private void handleMouseDown(ref MouseEventData ev, Control target)
    {
        // 检查是否点击了 TextInput/EditBox 的右键菜单
        auto focused = _getFocusedControl();
        if (focused !is null)
        {
            auto ti = cast(TextInput)focused;
            if (ti !is null && ti.contextMenuOpen)
            {
                auto menu = ti.contextMenu;
                int localX, localY;
                _clientToControl(menu, ev.x, ev.y, localX, localY);
                menu.fireMouseDown(localX, localY, 0);
                _requestRedraw();
                return;
            }
            auto eb = cast(EditBox)focused;
            if (eb !is null && eb.contextMenuOpen)
            {
                auto menu = eb.contextMenu;
                int localX, localY;
                _clientToControl(menu, ev.x, ev.y, localX, localY);
                menu.fireMouseDown(localX, localY, 0);
                _requestRedraw();
                return;
            }
        }

        // Mouse button pressed
        _capturedControl = target;
        if (target.focusable())
            _setFocus(target);
        int localX, localY;
        _clientToControl(target, ev.x, ev.y, localX, localY);
        target.fireMouseDown(localX, localY, ev.button);

        // Popup 拖拽起点
        auto popupTarget = cast(Popup)target;
        if (popupTarget !is null && popupTarget.isDragging())
            popupTarget.setDragOrigin(ev.x, ev.y);
    }

    private void handleMouseUp(ref MouseEventData ev, Control target)
    {
        if (_capturedControl !is null)
        {
            int localX, localY;
            _clientToControl(_capturedControl, ev.x, ev.y, localX, localY);
            _capturedControl.fireMouseUp(localX, localY, ev.button);
            if (_capturedControl is target)
                _capturedControl.fireClick(localX, localY);
        }
        _capturedControl = null;
    }

    private void handleMouseMove(ref MouseEventData ev, Control target)
    {
        Control moveTarget = target;
        if (_capturedControl !is null)
            moveTarget = _capturedControl;

        bool needRedraw = false;

        if (moveTarget !is _hoveredControl)
        {
            if (_hoveredControl !is null && _hoveredControl !is _owner)
                _hoveredControl.fireMouseMove(-1, -1);
            _hoveredControl = moveTarget;
            needRedraw = true;
        }

        int localX, localY;
        auto popupMove = cast(Popup)moveTarget;
        if (popupMove !is null && popupMove.isDragging())
        {
            localX = ev.x;
            localY = ev.y;
            needRedraw = true;
        }
        else
        {
            _clientToControl(moveTarget, ev.x, ev.y, localX, localY);
        }
        moveTarget.fireMouseMove(localX, localY);

        if (needRedraw)
            _requestRedraw();
    }

    /// 递归命中测试
    Control hitTestChild(Control parent, int px, int py, int parentOffsetX = 0, int parentOffsetY = 0)
    {
        auto children = parent.children();
        if (children.length == 0)
            return null;

        int relX = px - parentOffsetX;
        int relY = py - parentOffsetY;

        // 找出最大层级值
        int maxLayer = 0;
        foreach (child; children)
        {
            if (cast(int)child.layer() > maxLayer)
                maxLayer = cast(int)child.layer();
        }

        // 按层级从高到低遍历，同层级内从后往前
        for (int layer = maxLayer; layer >= 0; layer--)
        {
            for (int i = cast(int)children.length - 1; i >= 0; i--)
            {
                auto child = children[i];
                if (!child.visible())
                    continue;
                if (cast(int)child.layer() != layer)
                    continue;

                if (child.hitTest(relX, relY))
                {
                    int childAbsX = parentOffsetX + child.position().x();
                    int childAbsY = parentOffsetY + child.position().y();

                    int adjustedParentOffsetY = childAbsY - child.scrollOffsetY;
                    int adjustedParentOffsetX = childAbsX - child.scrollOffsetX;

                    // TabHost 特殊处理
                    auto th = cast(TabHost)child;
                    if (th !is null)
                    {
                        auto pages = th.children();
                        int activeIdx = th.activeIndex();
                        if (activeIdx >= 0 && activeIdx < cast(int)pages.length)
                        {
                            auto activePage = pages[activeIdx];
                            if (activePage.visible())
                            {
                                auto deeper = hitTestChild(activePage, px, py, childAbsX, adjustedParentOffsetY);
                                if (deeper !is null)
                                    return deeper;
                                return activePage;
                            }
                        }
                        return parent;
                    }

                    auto deeper = hitTestChild(child, px, py, childAbsX, adjustedParentOffsetY);
                    if (deeper !is null)
                        return deeper;
                    return child;
                }
            }
        }
        return null;
    }
}
