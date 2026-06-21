/+ dub.sdl:
    name "test_horizontal_scroll"
    dependency "guia4" path=".."
+/

module test_horizontal_scroll;

import guia4.app;
import guia4.guicore;
import guia4.utils.logger;
import windows.win32.system.console;

shared static this()
{
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
}

void main()
{
    initLogger(LogLevel.trace);
    auto app = new Application();
    auto window = app.createWindow(100, 50, 800, 600, "Horizontal Scroll Test");

    // 创建一个固定大小的容器作为父容器
    auto container = new Container(window);
    container.setXY(50, 50);
    container.width(600);  // 固定宽度 600
    container.height(400);  // 固定高度 400

    // 创建滚动容器
    auto scroll = new Container(container);
    scroll.dock(DockStyle.None);  // 不使用 DockStyle.Fill
    scroll.setXY(0, 0);
    scroll.width(600);  // 固定大小
    scroll.height(400);

    // 添加一个宽度超过容器的控件
    auto wideControl = scroll.addChild!Container();
    wideControl.setXY(0, 0);  // 直接设置位置
    wideControl.width(1200);  // 宽度 1200，超过容器宽度 600
    wideControl.height(100);
    
    auto label1 = new Label(wideControl, "This is a very wide control that should trigger horizontal scrollbar");
    label1.setXY(10, 10);
    label1.width(1000);
    label1.textColor(0x000000);

    // 添加多个控件，使内容高度也超过容器高度
    for (int i = 0; i < 10; i++)
    {
        auto label = new Label(scroll, "Label " ~ i.stringof);
        label.setXY(0, 100 + i * 40);  // 直接设置位置
        label.width(200);
        label.height(30);
        label.textColor(0x000000);
        label.dock(DockStyle.None);  // 明确设置 DockStyle.None
    }

    // 不调用 ensureLayout()，避免布局管理器重新设置子控件大小
    // container.ensureLayout();
    // scroll.ensureLayout();
    
    // 打印子控件的大小
    info("wideControl size: ", wideControl.width(), "x", wideControl.height(), " position: (", wideControl.position().x(), ",", wideControl.position().y(), ")");
    foreach (i, child; scroll.children())
    {
        info("Child ", i, " size: ", child.width(), "x", child.height(), " position: (", child.position().x(), ",", child.position().y(), ")");
    }

    scroll.recalcContent();
    info("Content width: ", scroll.contentWidth());
    info("Content height: ", scroll.contentHeight());
    info("Container width: ", scroll.width());
    info("Container height: ", scroll.height());
    info("Needs horizontal scrollbar: ", scroll.contentWidth() > scroll.width());
    info("Needs vertical scrollbar: ", scroll.contentHeight() > scroll.height());
    
    window.show();
    app.run();
    logInfo("=== Test Exited ===");
}
