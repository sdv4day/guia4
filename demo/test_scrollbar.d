/+ dub.sdl:
    name "test_scrollbar"
    dependency "guia4" path=".."
+/

module test_scrollbar;

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
    auto window = app.createWindow(100, 50, 800, 600, "Scrollbar Test");

    // 创建滚动容器
    auto scroll = new ScrollableContainer(window);
    scroll.layout(new VerticalLayout(10, 20));

    // 添加多个控件，使内容高度超过容器高度
    for (int i = 0; i < 20; i++)
    {
        auto label = new Label(scroll, "Label " ~ i.stringof);
        label.width(200);
        label.height(30);
        label.textColor(0x000000);
    }

    scroll.recalcContent();
    logInfo("Content height: ", scroll.contentHeight());
    logInfo("Container height: ", scroll.height());
    logInfo("Needs scrollbar: ", scroll.contentHeight() > scroll.height());
    
    window.show();
    app.run();
    logInfo("=== Test Exited ===");
}
