module demo.menubar_perf_test;

import guia4.app;
import guia4.guicore;
import guia4.utils.logger;
import std.logger;
import std.stdio;

shared static this()
{
    import core.sys.windows.windows;
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
}

void main()
{
    // Initialize logger with TRACE level to see renderWithGDI calls
    initLogger(LogLevel.trace);
    logInfo("=== MenuBar Performance Test ===");
    
    auto app = new Application();
    auto window = app.createWindow(100, 100, 600, 400, "MenuBar Perf Test");
    
    // 创建MenuBar
    auto menuBar = new MenuBar(window);
    menuBar.x = 0;
    menuBar.y = 0;
    menuBar.width = 600;
    menuBar.height = 24;
    
    // 添加几个菜单项
    auto fileItem = menuBar.add("File");
    fileItem.addSubItem("New");
    fileItem.addSubItem("Open");
    fileItem.addSubItem("Save");
    fileItem.addSubItem("Exit");
    
    auto editItem = menuBar.add("Edit");
    editItem.addSubItem("Cut");
    editItem.addSubItem("Copy");
    editItem.addSubItem("Paste");
    
    auto viewItem = menuBar.add("View");
    viewItem.addSubItem("Zoom In");
    viewItem.addSubItem("Zoom Out");
    
    auto helpItem = menuBar.add("Help");
    helpItem.addSubItem("About");
    
    logInfo("MenuBar created with 4 items");
    logInfo("Move mouse over menu items to test hover performance");
    logInfo("Expected: Only the hovered MenuItem should call renderWithGDI");
    
    window.show();
    app.run();
    
    logInfo("=== MenuBar Performance Test Exited ===");
}