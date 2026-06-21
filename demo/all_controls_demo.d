module all_controls_demo;

import guia4.app;
import guia4.guicore;
import guia4.guicore.panel;
import guia4.utils.logger;
import windows.win32.system.console;
import std.string;
import demo3dcontrol;

// ══════════════════════════════════════════════════════════════
// 布局常量
// ══════════════════════════════════════════════════════════════
enum {
    WINDOW_X = 100,
    WINDOW_Y = 50,
    WINDOW_W = 960,
    WINDOW_H = 800,
    MENU_HEIGHT = 24,
    SCROLL_WIDTH = 940,
    SCROLL_HEIGHT = 740,
    SECTION_SPACING = 10,
    ITEM_SPACING = 4,
    CONTENT_PADDING = 16,
    HEADER_HEIGHT = 28,
    BUTTON_HEIGHT = 32,
    SMALL_BTN_HEIGHT = 26,
    FONT_HEADER = 16,
    FONT_SMALL = 12,
    FONT_LARGE = 20,
    COLOR_HEADER = 0x005A5A5A,
    COLOR_INFO = 0x00444444,
    COLOR_TIP = 0x00666666,
    COLOR_SUMMARY = 0x00888888,
    COLOR_RED = 0x000033CC,
    COLOR_BLUE = 0x00CC3300,
    COLOR_GREEN = 0x00209A00,
    COLOR_PURPLE = 0x00663300,
    COLOR_ORANGE = 0x00006BCC,
    COLOR_DARKGREEN = 0x00006400,
}

shared static this()
{
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
}

void main()
{
    initLogger(LogLevel.trace);
    auto app = new Application();
    auto window = app.createWindow(WINDOW_X, WINDOW_Y, WINDOW_W, WINDOW_H, "guia4 - All Controls Demo");

    // ── 主滚动容器 ──
    auto scroll = new Panel(window);
    scroll.vScroll = true;
    scroll.dock = DockStyle.Fill;
    scroll.layout(new VerticalLayout(SECTION_SPACING, CONTENT_PADDING));

    // ══════════════════════════════════════════════════════════════
    // Section: StringGrid
    // ══════════════════════════════════════════════════════════════
    StringGrid grid;
    {
        auto sec = new Container(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— StringGrid ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        // 创建 StringGrid
        string[] headers = ["ID", "Name", "Age", "City", "Email"];
        string[][] data = [
            ["1", "Alice", "28", "Beijing", "alice@example.com"],
            ["2", "Bob", "35", "Shanghai", "bob@example.com"],
            ["3", "Charlie", "42", "Guangzhou", "charlie@example.com"],
            ["4", "Diana", "31", "Shenzhen", "diana@example.com"],
            ["5", "Eve", "26", "Hangzhou", "eve@example.com"],
            ["6", "Frank", "45", "Nanjing", "frank@example.com"],
            ["7", "Grace", "33", "Chengdu", "grace@example.com"],
            ["8", "Henry", "29", "Wuhan", "henry@example.com"],
            ["9", "Ivy", "38", "Xian", "ivy@example.com"],
            ["10", "Jack", "27", "Tianjin", "jack@example.com"],
        ];

        grid = new StringGrid(sec, headers, data);
        grid.width(700);
        grid.height(200);

        // 设置列宽
        grid.setColWidths([50, 100, 60, 120, 200]);  // ID, Name, Age, City, Email
    }

    // ══════════════════════════════════════════════════════════════
    // Section 7: TabWidget
    // ══════════════════════════════════════════════════════════════
    auto sec = new Container(scroll);
    sec.layout(new VerticalLayout(ITEM_SPACING, 0));

    auto hdr = new Label(sec, "—— TabWidget ——");
    hdr.width(0); hdr.height(HEADER_HEIGHT);
    hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

    auto tabs = new TabWidget(sec);
    tabs.width(500); tabs.height(160);

    auto page1 = new Container(tabs);
    page1.layout(new VerticalLayout(4, 10));
    auto p1Label = new Label(page1, "Tab 1 content"); p1Label.width(200); p1Label.textColor(0x005A5A5A);
    auto p1Btn = new Button(page1, "Tab1 Button");
    tabs.addTab("Tab 1", page1);

    auto page2 = new Container(tabs);
    auto p2Label = new Label(page2, "Tab 2 content"); p2Label.setXY(10, 10); p2Label.width(200); p2Label.textColor(0x005A5A5A);
    tabs.addTab("Tab 2", page2);

    auto page3 = new Container(tabs);
    auto p3Label = new Label(page3, "Tab 3"); p3Label.setXY(10, 10); p3Label.width(200); p3Label.textColor(0x005A5A5A);
    tabs.addTab("Tab 3", page3);

    // ══════════════════════════════════════════════════════════════
    // Section: 3D Model Viewer
    // ══════════════════════════════════════════════════════════════
    Demo3DControl view3d;
    {
        auto sec3d = new Container(scroll);
        sec3d.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr3d = new Label(sec3d, "—— 3D Model Viewer ——");
        hdr3d.width(0); hdr3d.height(HEADER_HEIGHT);
        hdr3d.fontSize(FONT_HEADER); hdr3d.textColor(COLOR_HEADER);

        // 创建3D控件
        view3d = new Demo3DControl(sec3d, "models/cube.obj");
        view3d.width(400); view3d.height(300);
    }

    // ══════════════════════════════════════════════════════════════
    // Finalize
    // ══════════════════════════════════════════════════════════════
    logInfo("StringGrid pos=(", grid.position().x(), ",", grid.position().y(), ") size=(", grid.width(), "x", grid.height(), ") visible=", grid.visible(), " rowCount=", grid.rowCount(), " colCount=", grid.colCount());
    window.show();

    // 设置3D自动旋转动画（需要在show之后，因为需要HWND）
    if (view3d.modelLoaded())
    {
        window.setAnim3DCallback(&view3d.advanceFrame);
        window.startAnim3DTimer(16); // ~60fps
    }

    // 自动截图用于验证修复效果（10秒后截图并关闭）
    window.scheduleScreenshotAndClose(10000, "all_controls_test.bmp");

    app.run();
    logInfo("=== Demo Exited ===");
}
