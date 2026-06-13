module all_controls_demo;

import guia4.app;
import guia4.guicore;
import guia4.utils.logger;
import core.sys.windows.windows;
import std.string;

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

    // ── MenuBar ──
    // MenuBar 使用 DockStyle.Top，自动停靠在顶部，宽度自适应
    // 高度自动根据 item 高度 + 边框计算
    auto menuBar = new MenuBar(window);
    menuBar.itemHeight(MENU_HEIGHT - 1);  // 设置 item 高度，MenuBar 会自动计算总高度

    auto fileNew = menuBar.add("File");
    auto fileNewSub = fileNew.addSubItem("New");
    auto fileOpenSub = fileNew.addSubItem("Open");
    auto helpItem = menuBar.add("Help");
    auto aboutSub = helpItem.addSubItem("About");

    // ── 主滚动容器 ──
    // ScrollableContainer 默认使用 DockStyle.Fill，自动填充剩余空间
    auto scroll = new ScrollableContainer(window);
    scroll.layout(new VerticalLayout(SECTION_SPACING, CONTENT_PADDING));

    // ── Feedback Label ──
    auto feedback = new Label(scroll, "Ready — interact with controls below");
    feedback.width(0);  // 让VerticalLayout分配宽度
    feedback.height(22);
    feedback.textColor(COLOR_DARKGREEN);

    void setFeedback(string msg) { feedback.text("[Action] " ~ msg); }

    // MenuBar事件
    fileNewSub.onClick((ref ClickEvent e) { setFeedback("Menu: File > New"); });
    fileOpenSub.onClick((ref ClickEvent e) { setFeedback("Menu: File > Open"); });
    aboutSub.onClick((ref ClickEvent e) { setFeedback("Menu: Help > About"); });

    // ══════════════════════════════════════════════════════════════
    // Section 1: Buttons
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— Buttons ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        // 3x3按钮网格
        auto grid = new Control(sec);
        grid.layout(new GridLayout(3, 3, 8, 6, 6));
        grid.height(120);

        auto btn1 = new Button(grid, "Normal"); btn1.onClick((ref ClickEvent e) { setFeedback("Normal clicked"); });
        auto btn2 = new Button(grid, "Click Me"); btn2.onClick((ref ClickEvent e) { setFeedback("Click Me clicked"); });
        auto btn3 = new Button(grid, "Third"); btn3.onClick((ref ClickEvent e) { setFeedback("Third clicked"); });
        auto btn4 = new Button(grid, "Tab Target 1"); btn4.onClick((ref ClickEvent e) { setFeedback("Tab Target 1 — use Tab+Enter"); });
        auto btn5 = new Button(grid, "Tab Target 2"); btn5.onClick((ref ClickEvent e) { setFeedback("Tab Target 2 clicked"); });
        auto btn6 = new Button(grid, "Reset Focus"); btn6.onClick((ref ClickEvent e) { window.setFocus(window); setFeedback("Focus reset"); });
        auto btn7 = new Button(grid, "Say Hello"); btn7.onClick((ref ClickEvent e) { setFeedback("Hello from guia4!"); });
        int clickCount = 0;
        auto btn8 = new Button(grid, "Counter"); btn8.onClick((ref ClickEvent e) { clickCount++; setFeedback(format("Clicked %d time(s)", clickCount)); });
        auto btn9 = new Button(grid, "Last One"); btn9.onClick((ref ClickEvent e) { setFeedback("Last button"); });
    }

    /+
    // ══════════════════════════════════════════════════════════════
    // Section 1: Labels（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— Labels ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto lbl1 = new Label(sec, "Default label (14pt, black)");
        lbl1.width(0);

        auto lbl2 = new Label(sec, "Red label (14pt)");
        lbl2.width(0); lbl2.textColor(COLOR_RED);

        auto lbl3 = new Label(sec, "Blue label (14pt)");
        lbl3.width(0); lbl3.textColor(COLOR_BLUE);

        auto lbl4 = new Label(sec, "Large green label (20pt)");
        lbl4.width(0); lbl4.height(28);
        lbl4.fontSize(FONT_LARGE); lbl4.textColor(COLOR_GREEN);

        auto row = new Control(sec);
        row.layout(new HorizontalLayout(12, 0));
        row.height(20);

        auto side1 = new Label(row, "Left (purple)");
        side1.width(200); side1.textColor(COLOR_PURPLE);

        auto side2 = new Label(row, "Right (orange)");
        side2.width(200); side2.textColor(COLOR_ORANGE);
    }

    // ══════════════════════════════════════════════════════════════
    // Section 3: Layout Demos（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— Layout Demos ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto vl = new Label(sec, "VerticalLayout (spacing=4, padding=6):");
        vl.width(0); vl.fontSize(FONT_SMALL); vl.textColor(COLOR_INFO);

        auto vBox = new Control(sec);
        vBox.width(260); vBox.height(110);
        vBox.layout(new VerticalLayout(4, 6));

        foreach (i; 0 .. 3)
        {
            auto b = new Button(vBox, "VBtn " ~ cast(string)[cast(char)('A' + i)]);
            b.width(0); b.height(SMALL_BTN_HEIGHT);
        }

        auto hl = new Label(sec, "HorizontalLayout (spacing=6, padding=6):");
        hl.width(0); hl.fontSize(FONT_SMALL); hl.textColor(COLOR_INFO);

        auto hBox = new Control(sec);
        hBox.width(400); hBox.height(40);
        hBox.layout(new HorizontalLayout(6, 6));

        foreach (i; 0 .. 4)
        {
            auto b = new Button(hBox, "HBtn " ~ cast(string)[cast(char)('0' + i)]);
            b.width(80); b.height(0);
        }

        auto gl = new Label(sec, "GridLayout (2×3, spacing=6, padding=6):");
        gl.width(0); gl.fontSize(FONT_SMALL); gl.textColor(COLOR_INFO);

        auto gBox = new Control(sec);
        gBox.width(400); gBox.height(82);
        gBox.layout(new GridLayout(2, 3, 6, 6, 6));

        foreach (i; 0 .. 6)
        {
            auto b = new Button(gBox, "G" ~ cast(string)[cast(char)('1' + i)]);
        }
    }

    // ══════════════════════════════════════════════════════════════
    // Section 4: TextInput & EditLine & EditBox（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— TextInput & EditLine & EditBox ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto info = new Label(sec, "Tab to focus, start typing:");
        info.width(0); info.fontSize(FONT_SMALL); info.textColor(COLOR_INFO);

        auto tiRow = new Control(sec);
        tiRow.layout(new HorizontalLayout(12, 0));
        tiRow.height(28);

        auto ti1 = new TextInput(tiRow, "Hello, world!");
        ti1.width(300);

        auto ti2 = new TextInput(tiRow, "", "Type here...");
        ti2.width(300);

        auto tiInfo = new Label(sec, "(last action)");
        tiInfo.width(0); tiInfo.fontSize(11); tiInfo.textColor(COLOR_TIP);

        ti1.onKeyDown((ref KeyEvent e) { tiInfo.text(format("ti1: key=0x%X, text='%s'", e.keyCode, ti1.text())); });
        ti2.onTextInput((dchar ch) { tiInfo.text(format("ti2: typed '%c', text='%s'", ch, ti2.text())); });

        auto elLabel = new Label(sec, "EditLine (single-line edit):");
        elLabel.width(0); elLabel.fontSize(FONT_SMALL); elLabel.textColor(COLOR_INFO);

        auto editLine1 = new EditLine(sec, "Single line edit");
        editLine1.width(300);

        auto ebLabel = new Label(sec, "EditBox (multi-line edit):");
        ebLabel.width(0); ebLabel.fontSize(FONT_SMALL); ebLabel.textColor(COLOR_INFO);

        auto editBox1 = new EditBox(sec, "Line 1\nLine 2\nLine 3");
        editBox1.width(400); editBox1.height(80);
    }

    // ══════════════════════════════════════════════════════════════
    // Section 5: CheckBox & RadioButton（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— CheckBox & RadioButton ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto cbRow = new Control(sec);
        cbRow.layout(new HorizontalLayout(16, 0));
        cbRow.height(24);

        auto cb1 = new CheckBox(cbRow, "Option A");
        auto cb2 = new CheckBox(cbRow, "Option B"); cb2.checked(true);
        auto cb3 = new CheckBox(cbRow, "Option C");

        auto rbRow = new Control(sec);
        rbRow.layout(new HorizontalLayout(16, 0));
        rbRow.height(24);

        auto rb1 = new RadioButton(rbRow, "Choice 1"); rb1.groupId(1); rb1.checked(true);
        auto rb2 = new RadioButton(rbRow, "Choice 2"); rb2.groupId(1);
        auto rb3 = new RadioButton(rbRow, "Choice 3"); rb3.groupId(1);
    }

    // ══════════════════════════════════════════════════════════════
    // Section 6: ComboBox（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— ComboBox ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto cb = new ComboBox(sec);
        cb.width(200);
        cb.addItem("Item 1"); cb.addItem("Item 2"); cb.addItem("Item 3");
        cb.addItem("Item 4"); cb.addItem("Item 5");
    }

    // ══════════════════════════════════════════════════════════════
    // Section 7: TabWidget（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— TabWidget ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto tabs = new TabWidget(sec);
        tabs.width(500); tabs.height(160);

        auto page1 = new Control();
        page1.layout(new VerticalLayout(4, 10));
        auto p1Label = new Label(page1, "Tab 1 content"); p1Label.width(200);
        auto p1Btn = new Button(page1, "Tab1 Button");
        tabs.addTab("Tab 1", page1);

        auto page2 = new Control();
        auto p2Label = new Label(page2, "Tab 2 content"); p2Label.setXY(10, 10); p2Label.width(200);
        tabs.addTab("Tab 2", page2);

        auto page3 = new Control();
        auto p3Label = new Label(page3, "Tab 3"); p3Label.setXY(10, 10); p3Label.width(200);
        tabs.addTab("Tab 3", page3);
    }

    // ══════════════════════════════════════════════════════════════
    // Section 8: ScrollableContainer（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— ScrollableContainer ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto scInfo = new Label(sec, "Mouse wheel to scroll:");
        scInfo.width(0); scInfo.fontSize(FONT_SMALL); scInfo.textColor(COLOR_INFO);

        auto sc = new ScrollableContainer(sec);
        sc.contentHeight(400); sc.width(320); sc.height(180);
        sc.layout(new VerticalLayout(6, 10));

        foreach (i; 0 .. 12)
        {
            auto btn = new Button(sc, format("Scroll Btn %d", i + 1));
            btn.width(0); btn.height(SMALL_BTN_HEIGHT);
            btn.onClick((ref ClickEvent e) { setFeedback(format("Scroll Btn %d clicked", i + 1)); });
        }
    }

    // ══════════════════════════════════════════════════════════════
    // Section 9: StringGrid（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— StringGrid ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto grid = new StringGrid(sec,
            ["Name", "Value", "Status"],
            [
                ["Alpha", "100", "OK"],
                ["Beta", "200", "Warn"],
                ["Gamma", "300", "OK"],
                ["Delta", "400", "Error"],
                ["Alpha", "100", "OK"],
                ["Beta", "200", "Warn"],
                ["Gamma", "300", "OK"],
                ["Delta", "400", "Error"],
            ]
        );
        grid.width(400); grid.height(120);
        grid.setColWidths([120, 100, 80]);
    }

    // ══════════════════════════════════════════════════════════════
    // Section 10: TreeWidget（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— TreeWidget ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto root = new TreeItem("Root");
        auto c1 = root.addChild("Child 1");
        c1.addChild("Leaf 1.1");
        c1.addChild("Leaf 1.2");
        auto c2 = root.addChild("Child 2");
        c2.addChild("Leaf 2.1");
        root.addChild("Child 3");
        root.expanded = true;
        c1.expanded = true;

        auto tree = new TreeWidget(sec);
        tree.width(300); tree.height(140);
        tree.root(root);
    }

    // ══════════════════════════════════════════════════════════════
    // Section 11: ScrollBar & Panel（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— ScrollBar & Panel ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto sbBox = new Control(sec);
        sbBox.width(250); sbBox.height(104);

        auto vsb = new ScrollBar(sbBox);
        vsb.setXY(0, 0); vsb.width(14); vsb.height(100);
        vsb.max(100); vsb.pageSize(20);

        auto hsb = new ScrollBar(sbBox, ScrollBarOrientation.Horizontal);
        hsb.setXY(22, 80); hsb.width(200); hsb.height(14);
        hsb.max(100); hsb.pageSize(20);

        auto panel1 = new Panel(sec, "Panel with title");
        panel1.width(300); panel1.height(120);
        panel1.vScroll(true);

        auto panelLabel = new Label(panel1, "Panel content area");
        panelLabel.setXY(10, 30); panelLabel.width(200);

        auto panelBtn = new Button(panel1, "Panel Button");
        panelBtn.setXY(10, 60);
    }

    // Popup（添加到window，不在scroll内）
    auto popup1 = new Popup(window);
    popup1.setXY(100, 200);
    popup1.width(200); popup1.height(100);
    auto popupLabel = new Label(popup1, "Popup content!");
    popupLabel.setXY(10, 10); popupLabel.width(180);
    popup1.content(popupLabel);

    // ══════════════════════════════════════════════════════════════
    // Section 12: Popup & ImageWidgets（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— Popup & Image Controls ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto popInfo = new Label(sec, "Popup is a programmatic overlay. Image controls require BMP files (showing placeholders).");
        popInfo.width(0); popInfo.fontSize(FONT_SMALL); popInfo.textColor(COLOR_INFO);

        auto btnPopup = new Button(sec, "Show Popup");
        btnPopup.onClick((ref ClickEvent e) { popup1.open(200, 300); setFeedback("Popup opened"); });

        auto imgRow = new Control(sec);
        imgRow.layout(new HorizontalLayout(12, 0));
        imgRow.height(60);

        auto imgW = new ImageWidget(imgRow); imgW.width(80); imgW.height(60);
        auto imgB = new ImageButton(imgRow); imgB.width(80); imgB.height(60);
        auto tib = new TextImageButton(imgRow, "IconBtn"); tib.width(120); tib.height(40);
    }

    // ══════════════════════════════════════════════════════════════
    // Section 13: MainMenu & Events（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— MainMenu & Events ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto mmInfo = new Label(sec, "MainMenu extends MenuBar. Use Tab to cycle focus, Enter/Space to click.");
        mmInfo.width(0); mmInfo.fontSize(FONT_SMALL); mmInfo.textColor(COLOR_INFO);

        auto mm = new MainMenu(sec);
        mm.width(400); mm.height(MENU_HEIGHT);
        auto mi1 = mm.add("Menu1");
        auto ms1 = mi1.addSubItem("SubItem 1");
        auto ms2 = mi1.addSubItem("SubItem 2");
        auto mi2 = mm.add("Menu2");
        auto ms3 = mi2.addSubItem("Action A");
        ms3.onClick((ref ClickEvent e) { setFeedback("MainMenu: Action A"); });

        auto mouseLabel = new Label(sec, "Mouse: —");
        mouseLabel.width(0); mouseLabel.fontSize(FONT_SMALL); mouseLabel.textColor(COLOR_TIP);

        window.onMouseMove((ref MouseEvent e) {
            mouseLabel.text(format("Mouse at (%d, %d)", e.x, e.y));
        });
    }

    // ══════════════════════════════════════════════════════════════
    // Section 14: UTF-8 多语言（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— UTF-8 多语言支持 ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto utf8Info = new Label(sec, "框架支持 UTF-8 编码，可正确显示和编辑多语言文本：");
        utf8Info.width(0); utf8Info.fontSize(FONT_SMALL); utf8Info.textColor(COLOR_INFO);

        foreach (text; [
            "中文：你好世界！简体繁體都能正確顯示",
            "日本語：こんにちは世界！",
            "한국어：안녕하세요！",
            "Русский：Привет мир!",
            "Emoji：😀🎉🚀❤️🌟👍",
            "Math：∑∏∫√∞≈≠≤≥±×÷",
        ])
        {
            auto lbl = new Label(sec, text);
            lbl.width(0);
        }

        auto tiRowCN = new Control(sec);
        tiRowCN.layout(new HorizontalLayout(12, 0));
        tiRowCN.height(28);

        auto tiCN = new TextInput(tiRowCN, "输入中文测试"); tiCN.width(300);
        auto tiJP = new TextInput(tiRowCN, "日本語入力"); tiJP.width(300);

        auto ebUTF8 = new EditBox(sec, "多语言编辑：\nChinese: 你好世界\nJapanese: こんにちは\nEmoji: 😀🎉🚀");
        ebUTF8.width(400); ebUTF8.height(100);
    }

    // ══════════════════════════════════════════════════════════════
    // Section 15: Utilities（暂时注释）
    // ══════════════════════════════════════════════════════════════
    {
        auto sec = new Control(scroll);
        sec.layout(new VerticalLayout(ITEM_SPACING, 0));

        auto hdr = new Label(sec, "—— Utilities ——");
        hdr.width(0); hdr.height(HEADER_HEIGHT);
        hdr.fontSize(FONT_HEADER); hdr.textColor(COLOR_HEADER);

        auto utilRow = new Control(sec);
        utilRow.layout(new HorizontalLayout(12, 0));
        utilRow.height(BUTTON_HEIGHT);

        auto btnShot = new Button(utilRow, "Screenshot Now");
        btnShot.width(200); btnShot.height(BUTTON_HEIGHT);
        btnShot.onClick((ref ClickEvent e) {
            setFeedback("Taking screenshot...");
            window.captureImmediate("all_controls_demo.bmp");
            setFeedback("Screenshot saved");
        });

        auto btnDelay = new Button(utilRow, "Screenshot in 3s");
        btnDelay.width(180); btnDelay.height(BUTTON_HEIGHT);
        btnDelay.onClick((ref ClickEvent e) {
            setFeedback("Screenshot in 3s...");
            window.scheduleScreenshot(3000, "all_controls_demo_delayed.bmp");
        });

        auto btnClose = new Button(utilRow, "Close Window");
        btnClose.width(160); btnClose.height(BUTTON_HEIGHT);
        btnClose.onClick((ref ClickEvent e) { window.close(); });
    }
    +/

    // ══════════════════════════════════════════════════════════════
    // Finalize
    // ══════════════════════════════════════════════════════════════
    scroll.recalcContent();
    logInfo("Content height: ", scroll.contentHeight());
    window.show();
    app.run();
    logInfo("=== Demo Exited ===");
}
