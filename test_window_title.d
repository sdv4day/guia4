/**
 * 窗口标题测试程序
 */
module test_window_title;

import guia4.app;
import guia4.guicore;
import guia4.utils.logger;
import core.sys.windows.windows;

shared static this()
{
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
}

void main()
{
    initLogger(LogLevel.info);
    
    auto app = new Application();
    
    // 测试1: 纯英文标题
    auto window1 = app.createWindow(100, 100, 400, 300, "Test Window - English");
    writeln("窗口1创建成功: ", window1.title());
    
    // 测试2: 中文标题
    auto window2 = app.createWindow(520, 100, 400, 300, "测试窗口 - 中文");
    writeln("窗口2创建成功: ", window2.title());
    
    // 测试3: 混合标题
    auto window3 = app.createWindow(310, 420, 400, 300, "Test - 测试窗口");
    writeln("窗口3创建成功: ", window3.title());
    
    // 添加标签显示标题
    auto label1 = new Label("Window 1: Test Window - English");
    label1.setXY(10, 10);
    window1.addChild(label1);
    
    auto label2 = new Label("窗口2: 测试窗口 - 中文");
    label2.setXY(10, 10);
    window2.addChild(label2);
    
    auto label3 = new Label("Window 3: Test - 测试窗口");
    label3.setXY(10, 10);
    window3.addChild(label3);
    
    // 显示所有窗口
    window1.show();
    window2.show();
    window3.show();
    
    writeln("所有窗口已显示，请检查标题栏是否正确显示");
    writeln("按Alt+F4关闭窗口");
    
    app.run();
}