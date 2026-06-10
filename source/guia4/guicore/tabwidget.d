module guia4.guicore.tabwidget;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.tabcontrol;
import guia4.guicore.tabhost;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * TabWidget — TabControl + TabHost 组合控件
 *
 * 顶部 TabControl + 下方 TabHost。
 * 点击标签自动切换页面。
 */
class TabWidget : Control
{
    private TabControl _tabControl;
    private TabHost _tabHost;
    private int _tabBarHeight = 28;

    this()
    {
        width = 300;
        height = 250;
        _tabControl = new TabControl();
        _tabHost = new TabHost();
        addChild(_tabControl);
        addChild(_tabHost);
    }

    this(Control parent)
    {
        this();
        if (parent)
            parent.addChild(this);
    }

    /// 添加标签页（标签 + 页面内容），返回索引
    int addTab(string label, Control page)
    {
        int idx = _tabControl.addTab(label);
        _tabHost.addPage(page);

        // 立即同步 _tabHost 的大小与位置（首次渲染前 hitTest 才能正确）
        _tabHost.x(x());
        _tabHost.y(y() + _tabBarHeight);
        _tabHost.width(width());
        _tabHost.height(height() - _tabBarHeight);

        // 同步当前选中索引
        _tabHost.activeIndex(_tabControl.selectedIndex());

        return idx;
    }

    /// 当前选中标签索引
    int selectedIndex() const @property { return _tabControl.selectedIndex(); }
    void selectedIndex(int v) @property { _tabControl.selectedIndex(v); }

    /// 获取内部 TabControl
    TabControl tabControl() @property { return _tabControl; }

    /// 获取内部 TabHost
    TabHost tabHost() @property { return _tabHost; }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        logTrace("TabWidget.renderWithGDI() at (", x(), ",", y(), ")");

        // 布局：tabControl 在顶部，tabHost 在下方
        _tabControl.x(x());
        _tabControl.y(y());
        _tabControl.width(width());
        _tabControl.height(_tabBarHeight);

        _tabHost.x(x());
        _tabHost.y(y() + _tabBarHeight);
        _tabHost.width(width());
        _tabHost.height(height() - _tabBarHeight);

        // 同步选中索引
        _tabHost.activeIndex(_tabControl.selectedIndex());

        _tabControl.renderWithGDI(hdc.Value);
        _tabHost.renderWithGDI(hdc.Value);
    }

    override void fireMouseDown(int mx, int my, int button)
    {
        // mx, my 已经是控件本地坐标
        if (my >= 0 && my < _tabBarHeight)
        {
            // 点击在标签栏区域 — 转发到 tabControl
            _tabControl.fireMouseDown(mx, my, button);
        }
        // 标签页内容区域的点击通过 hitTestChild 找到最深子节点后直接分发，
        // 此处无需再处理（避免双重分发）
    }

    override void fireMouseMove(int mx, int my)
    {
        // mx, my 已经是控件本地坐标
        if (my >= 0 && my < _tabBarHeight)
        {
            _tabControl.fireMouseMove(mx, my);
        }
        else if (my >= _tabBarHeight)
        {
            auto kids = _tabHost.children();
            int idx = _tabControl.selectedIndex();
            if (idx >= 0 && idx < cast(int)kids.length)
            {
                int pageLocalX = mx;
                int pageLocalY = my - _tabBarHeight;
                kids[idx].fireMouseMove(pageLocalX, pageLocalY);
            }
        }
    }

    override void render() {}
}