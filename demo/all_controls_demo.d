/**
 * DGUI All Controls Demo
 *
 * Demonstrates every available widget/control in the guia4 framework:
 *   - Label (text, color, font size)
 *   - Button (click handler, mouse states, focus, keyboard activation)
 *   - MenuBar + MenuItem
 *   - Layouts (Vertical, Horizontal, Grid)
 *   - Event handling (mouse, keyboard, focus)
 *   - Timers and screenshots
 */
module all_controls_demo;

import guia4.app;
import guia4.guicore;
import guia4.utils.logger;
import core.sys.windows.windows;
import std.string;

shared static this()
{
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
}

void main()
{
    initLogger(LogLevel.info);
    logInfo("=== DGUI All Controls Demo ===");

    auto app = new Application();
    auto window = app.createWindow(100, 50, 950, 840, "DGUI - All Controls Demo");

    // ── Plan: main scrollable content area (direct child of window, everything else goes inside) ──
    auto plan = new ScrollableContainer();
    plan.x(0);
    plan.y(24);
    plan.width(920);
    plan.height(780);
    window.addChild(plan);

    // ════════════════════════════════════════════════
    // Section 0: Global feedback label
    // ════════════════════════════════════════════════
    auto feedback = new Label("Ready \u2014 interact with the controls below");
    feedback.x(20);
    feedback.y(28);
    feedback.width(700);
    feedback.height(22);
    feedback.textColor(0x00006400);
    plan.addChild(feedback);

    void setFeedback(string msg)
    {
        feedback.text("[Action] " ~ msg);
    }

    // ── Top-of-window MenuBar (always at parent top) ──
    auto menuBar = new MenuBar();
    menuBar.x(0);
    menuBar.y(0);
    menuBar.width(920);
    menuBar.height(24);
    window.addChild(menuBar);

    auto fileItem1 = menuBar.add("File > New");
    fileItem1.onClick((ref ClickEvent e) { setFeedback("Menu: File > New"); });

    auto fileItem2 = menuBar.add("File > Open");
    fileItem2.onClick((ref ClickEvent e) { setFeedback("Menu: File > Open"); });

    auto fileItem3 = menuBar.add("File > Save");
    fileItem3.onClick((ref ClickEvent e) { setFeedback("Menu: File > Save"); });

    auto helpItem = menuBar.add("Help > About");
    helpItem.onClick((ref ClickEvent e) { setFeedback("Menu: Help > About  \u2014 DGUI v0.1"); });

    // ── helper: section header ──
    auto sectionY = 56;

    Label makeHeader(string text)
    {
        auto lbl = new Label(text);
        lbl.x(16);
        lbl.y(sectionY);
        lbl.fontSize(17);
        lbl.textColor(0x005A5A5A);
        lbl.width(400);
        lbl.height(26);
        plan.addChild(lbl);
        sectionY += 30;
        return lbl;
    }

    // ════════════════════════════════════════════════
    // Section 1: Labels \u2014 text, color, font-size variants
    // ════════════════════════════════════════════════
    makeHeader("\u2014\u2014 Labels \u2014\u2014");

    auto lblDef = new Label("Default label  (14pt, black)");
    lblDef.x(28);
    lblDef.y(sectionY);
    plan.addChild(lblDef);
    sectionY += 22;

    auto lblRed = new Label("Red label  (14pt)");
    lblRed.x(28);
    lblRed.y(sectionY);
    lblRed.textColor(0x000033CC);
    plan.addChild(lblRed);
    sectionY += 22;

    auto lblBlue = new Label("Blue label  (14pt)");
    lblBlue.x(28);
    lblBlue.y(sectionY);
    lblBlue.textColor(0x00CC3300);
    plan.addChild(lblBlue);
    sectionY += 22;

    auto lblLarge = new Label("Large green label  (20pt)");
    lblLarge.x(28);
    lblLarge.y(sectionY);
    lblLarge.fontSize(20);
    lblLarge.textColor(0x00209A00);
    plan.addChild(lblLarge);
    sectionY += 30;

    // Two labels side by side
    auto lblSide1 = new Label("Left label (purple)");
    lblSide1.x(28);
    lblSide1.y(sectionY);
    lblSide1.textColor(0x00663300);
    plan.addChild(lblSide1);

    auto lblSide2 = new Label("Right label (orange)");
    lblSide2.x(220);
    lblSide2.y(sectionY);
    lblSide2.textColor(0x00006BCC);
    plan.addChild(lblSide2);
    sectionY += 26;

    // ════════════════════════════════════════════════
    // Section 2: Buttons \u2014 click, hover, press, focus, keyboard
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("\u2014\u2014 Buttons \u2014\u2014");

    // Row 1: basic buttons
    int btnX = 28;

    auto btn1 = new Button("Normal Button");
    btn1.x(btnX);
    btn1.y(sectionY);
    btn1.onClick((ref ClickEvent e) { setFeedback("'Normal Button' clicked"); });
    plan.addChild(btn1);

    auto btn2 = new Button("Click Me");
    btn2.x(btnX + 120);
    btn2.y(sectionY);
    btn2.onClick((ref ClickEvent e) { setFeedback("'Click Me' clicked"); });
    plan.addChild(btn2);

    auto btn3 = new Button("Third");
    btn3.x(btnX + 220);
    btn3.y(sectionY);
    btn3.onClick((ref ClickEvent e) { setFeedback("'Third' clicked"); });
    plan.addChild(btn3);
    sectionY += 38;

    // Row 2: focusable buttons (Tab navigation demo)
    auto btn4 = new Button("Tab Target 1");
    btn4.x(btnX);
    btn4.y(sectionY);
    btn4.onClick((ref ClickEvent e) { setFeedback("'Tab Target 1' \u2014 Tab to focus, Enter/Space to click"); });
    plan.addChild(btn4);

    auto btn5 = new Button("Tab Target 2");
    btn5.x(btnX + 120);
    btn5.y(sectionY);
    btn5.onClick((ref ClickEvent e) { setFeedback("'Tab Target 2' clicked  (focus + Enter/Space works)"); });
    plan.addChild(btn5);

    auto btn6 = new Button("Reset Focus");
    btn6.x(btnX + 220);
    btn6.y(sectionY);
    btn6.onClick((ref ClickEvent e) {
        setFeedback("Focus reset \u2014 press Tab or click any button");
        window.setFocus(window);
    });
    plan.addChild(btn6);
    sectionY += 38;

    // Row 3: interactive buttons
    auto btn7 = new Button("Say Hello");
    btn7.x(btnX);
    btn7.y(sectionY);
    btn7.onClick((ref ClickEvent e) { setFeedback("Hello from DGUI!"); });
    plan.addChild(btn7);

    auto btn8 = new Button("Counter");
    btn8.x(btnX + 120);
    btn8.y(sectionY);
    int clickCount = 0;
    btn8.onClick((ref ClickEvent e) {
        clickCount++;
        setFeedback(format("Button clicked %d time(s)", clickCount));
    });
    plan.addChild(btn8);

    auto btn9 = new Button("Last One");
    btn9.x(btnX + 220);
    btn9.y(sectionY);
    btn9.onClick((ref ClickEvent e) { setFeedback("'Last One' \u2014 end of buttons section"); });
    plan.addChild(btn9);
    sectionY += 42;

    // ════════════════════════════════════════════════
    // Section 3: Layout Demos
    // ════════════════════════════════════════════════
    makeHeader("\u2014\u2014 Layout Demo  (VerticalLayout, HorizontalLayout, GridLayout) \u2014\u2014");

    // --- VerticalLayout ---
    auto vLabel = new Label("VerticalLayout  (spacing=4, padding=6):");
    vLabel.x(28);
    vLabel.y(sectionY);
    vLabel.fontSize(13);
    vLabel.textColor(0x00444444);
    plan.addChild(vLabel);
    sectionY += 20;

    auto vContainer = new Control();
    vContainer.x(36);
    vContainer.y(sectionY);
    vContainer.width(260);
    vContainer.height(100);
    vContainer.layout(new VerticalLayout(4, 6));
    plan.addChild(vContainer);

    foreach (i; 0 .. 3)
    {
        auto b = new Button("VBtn " ~ cast(string)[cast(char)('A' + i)]);
        b.width(vContainer.width() - 12);
        b.height(26);
        vContainer.addChild(b);
    }
    vContainer.applyLayout();
    sectionY += 108;

    // --- HorizontalLayout ---
    auto hLabel = new Label("HorizontalLayout  (spacing=6, padding=6):");
    hLabel.x(28);
    hLabel.y(sectionY);
    hLabel.fontSize(13);
    hLabel.textColor(0x00444444);
    plan.addChild(hLabel);
    sectionY += 20;

    auto hContainer = new Control();
    hContainer.x(36);
    hContainer.y(sectionY);
    hContainer.width(400);
    hContainer.height(40);
    hContainer.layout(new HorizontalLayout(6, 6));
    plan.addChild(hContainer);

    foreach (i; 0 .. 4)
    {
        auto b = new Button("HBtn " ~ cast(string)[cast(char)('0' + i)]);
        b.width(80);
        b.height(hContainer.height() - 12);
        hContainer.addChild(b);
    }
    hContainer.applyLayout();
    sectionY += 50;

    // --- GridLayout ---
    auto gLabel = new Label("GridLayout  (2 rows \u00d7 3 cols, spacing=6, padding=6):");
    gLabel.x(28);
    gLabel.y(sectionY);
    gLabel.fontSize(13);
    gLabel.textColor(0x00444444);
    plan.addChild(gLabel);
    sectionY += 20;

    auto gContainer = new Control();
    gContainer.x(36);
    gContainer.y(sectionY);
    gContainer.width(400);
    gContainer.height(82);
    gContainer.layout(new GridLayout(2, 3, 6, 6, 6));
    plan.addChild(gContainer);

    foreach (i; 0 .. 6)
    {
        auto b = new Button("G" ~ cast(string)[cast(char)('1' + i)]);
        gContainer.addChild(b);
    }
    gContainer.applyLayout();
    sectionY += 92;

    // ════════════════════════════════════════════════
    // Section 4: MenuBar  (now at top of window)
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("\u2014\u2014 MenuBar  (positioned at window top) \u2014\u2014");

    auto menuInfo = new Label("The MenuBar is displayed at y=0 above the feedback label. Hover over items to see highlight, click for action.");
    menuInfo.x(28);
    menuInfo.y(sectionY);
    menuInfo.width(800);
    menuInfo.height(20);
    menuInfo.fontSize(12);
    menuInfo.textColor(0x00444444);
    plan.addChild(menuInfo);

    sectionY += 28;

    // ════════════════════════════════════════════════
    // Section 5: Events & Focus info
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("\u2014\u2014 Events & Focus \u2014\u2014");

    auto infoFocus = new Label("Tab to cycle through buttons  |  Enter/Space to click focused button  |  Click any button to focus it");
    infoFocus.x(28);
    infoFocus.y(sectionY);
    infoFocus.width(800);
    infoFocus.height(20);
    infoFocus.fontSize(12);
    infoFocus.textColor(0x00666666);
    plan.addChild(infoFocus);
    sectionY += 22;

    // Live mouse coordinate display
    auto infoMouse = new Label("Mouse events: \u2014");
    infoMouse.x(28);
    infoMouse.y(sectionY);
    infoMouse.width(800);
    infoMouse.height(20);
    infoMouse.fontSize(12);
    infoMouse.textColor(0x00666666);
    plan.addChild(infoMouse);
    sectionY += 24;

    window.onMouseMove((ref MouseEvent e) {
        infoMouse.text(format("Mouse at (%d, %d)", e.x, e.y));
    });

    // ════════════════════════════════════════════════
    // Section 6: TextInput Demo
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("\u2014\u2014 TextInput \u2014\u2014");

    auto inputInfo = new Label("Editable text fields  \u2014  tab to focus, start typing:");
    inputInfo.x(28);
    inputInfo.y(sectionY);
    inputInfo.fontSize(12);
    inputInfo.textColor(0x00444444);
    plan.addChild(inputInfo);
    sectionY += 22;

    auto ti1 = new TextInput("Hello, world!");
    ti1.x(28);
    ti1.y(sectionY);
    ti1.width(300);
    plan.addChild(ti1);

    auto ti2 = new TextInput("", "Type something here...");
    ti2.x(350);
    ti2.y(sectionY);
    ti2.width(300);
    plan.addChild(ti2);

    auto tiInfoLabel = new Label("(last action)");
    tiInfoLabel.x(28);
    tiInfoLabel.y(sectionY + 32);
    tiInfoLabel.fontSize(11);
    tiInfoLabel.textColor(0x00666666);
    plan.addChild(tiInfoLabel);

    // Track edits
    ti1.onKeyDown((ref KeyEvent e) {
        tiInfoLabel.text(format("ti1: key=0x%X, text='%s'", e.keyCode, ti1.text()));
    });
    ti2.onTextInput((dchar ch) {
        if (ti2.text().length > 0)
            tiInfoLabel.text(format("ti2: typed '%c', text='%s'", ch, ti2.text()));
        else
            tiInfoLabel.text(format("ti2: typed '%c' (empty)", ch));
    });

    sectionY += 60;

    // ════════════════════════════════════════════════
    // Section 7: ScrollableContainer Demo
    // ════════════════════════════════════════════════
    makeHeader("\u2014\u2014 ScrollableContainer \u2014\u2014");

    auto scrollInfo = new Label("Scrollable container  \u2014  mouse wheel to scroll, buttons overflow below:");
    scrollInfo.x(28);
    scrollInfo.y(sectionY);
    scrollInfo.fontSize(12);
    scrollInfo.textColor(0x00444444);
    plan.addChild(scrollInfo);
    sectionY += 22;

    // Create a scrollable container with many buttons
    auto scrollContainer = new ScrollableContainer(400, 320, 180);
    scrollContainer.x(28);
    scrollContainer.y(sectionY);
    plan.addChild(scrollContainer);

    // Add many buttons that overflow the container vertically
    foreach (i; 0 .. 12)
    {
        auto btn = new Button(format("Scroll Btn %d", i + 1));
        btn.x(scrollContainer.x() + 10);
        btn.y(scrollContainer.y() + i * 32 + 6);
        btn.width(scrollContainer.width() - 40);
        btn.height(26);
        btn.onClick((ref ClickEvent e) {
            setFeedback(format("'Scroll Btn %d' clicked inside ScrollableContainer", i + 1));
        });
        scrollContainer.addChild(btn);
    }
    sectionY += scrollContainer.height() + 12;

    // A second scrollable container for comparison
    makeHeader("\u2014\u2014 ScrollableContainer (Auto-content) \u2014\u2014");

    auto scrollInfo2 = new Label("Second container with labels + buttons, taller content:");
    scrollInfo2.x(28);
    scrollInfo2.y(sectionY);
    scrollInfo2.fontSize(12);
    scrollInfo2.textColor(0x00444444);
    plan.addChild(scrollInfo2);
    sectionY += 22;

    auto scrollContainer2 = new ScrollableContainer(600, 280, 200);
    scrollContainer2.x(28);
    scrollContainer2.y(sectionY);
    plan.addChild(scrollContainer2);

    foreach (i; 0 .. 8)
    {
        auto lbl = new Label(format("Scrollable item %d  (mixed content)", i + 1));
        lbl.x(scrollContainer2.x() + 8);
        lbl.y(scrollContainer2.y() + i * 32 + 6);
        lbl.width(scrollContainer2.width() - 24);
        lbl.fontSize(13);
        scrollContainer2.addChild(lbl);
    }

    sectionY += scrollContainer2.height() + 12;

    // ════════════════════════════════════════════════
    // Section 7a: CheckBox & RadioButton
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— CheckBox & RadioButton ——");

    auto cb1 = new CheckBox("Option A");
    cb1.x(28); cb1.y(sectionY);
    plan.addChild(cb1);

    auto cb2 = new CheckBox("Option B");
    cb2.x(160); cb2.y(sectionY);
    cb2.checked(true);
    plan.addChild(cb2);

    auto cb3 = new CheckBox("Option C");
    cb3.x(290); cb3.y(sectionY);
    plan.addChild(cb3);
    sectionY += 30;

    auto rb1 = new RadioButton("Choice 1");
    rb1.x(28); rb1.y(sectionY); rb1.groupId(1); rb1.checked(true);
    plan.addChild(rb1);

    auto rb2 = new RadioButton("Choice 2");
    rb2.x(160); rb2.y(sectionY); rb2.groupId(1);
    plan.addChild(rb2);

    auto rb3 = new RadioButton("Choice 3");
    rb3.x(290); rb3.y(sectionY); rb3.groupId(1);
    plan.addChild(rb3);
    sectionY += 36;

    // ════════════════════════════════════════════════
    // Section 7b: EditLine & EditBox
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— EditLine & EditBox ——");

    auto editLine1 = new EditLine("Single line edit");
    editLine1.x(28); editLine1.y(sectionY); editLine1.width(300);
    plan.addChild(editLine1);
    sectionY += 34;

    auto editBox1 = new EditBox("Line 1\nLine 2\nLine 3");
    editBox1.x(28); editBox1.y(sectionY); editBox1.width(400); editBox1.height(80);
    plan.addChild(editBox1);
    sectionY += 90;

    // ════════════════════════════════════════════════
    // Section 7b2: UTF-8 多语言支持
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— UTF-8 多语言支持 ——");

    auto utf8Info = new Label("框架支持 UTF-8 编码，可正确显示和编辑多语言文本：");
    utf8Info.x(28); utf8Info.y(sectionY); utf8Info.width(600);
    utf8Info.fontSize(12); utf8Info.textColor(0x00444444);
    plan.addChild(utf8Info);
    sectionY += 22;

    // 中文
    auto lblCN = new Label("中文：你好世界！简体繁體都能正確顯示");
    lblCN.x(28); lblCN.y(sectionY); lblCN.width(500);
    plan.addChild(lblCN);
    sectionY += 22;

    // 日文
    auto lblJP = new Label("日本語：こんにちは世界！ひらがなカタカナ漢字混じり");
    lblJP.x(28); lblJP.y(sectionY); lblJP.width(500);
    plan.addChild(lblJP);
    sectionY += 22;

    // 韩文
    auto lblKR = new Label("한국어：안녕하세요！한글 표시가 정상적으로 됩니다");
    lblKR.x(28); lblKR.y(sectionY); lblKR.width(500);
    plan.addChild(lblKR);
    sectionY += 22;

    // 俄文
    auto lblRU = new Label("Русский：Привет мир! Кириллица работает");
    lblRU.x(28); lblRU.y(sectionY); lblRU.width(500);
    plan.addChild(lblRU);
    sectionY += 22;

    // 阿拉伯文
    auto lblAR = new Label("العربية：مرحبا بالعالم! النص من اليمين لليسار");
    lblAR.x(28); lblAR.y(sectionY); lblAR.width(500);
    plan.addChild(lblAR);
    sectionY += 22;

    // 泰文
    auto lblTH = new Label("ไทย：สวัสดีชาวโลก! ภาษาไทยแสดงผลได้");
    lblTH.x(28); lblTH.y(sectionY); lblTH.width(500);
    plan.addChild(lblTH);
    sectionY += 22;

    // 希腊文
    auto lblGR = new Label("Ελληνικά：Γεια σου κόσμε! Ελληνικά γράμματα");
    lblGR.x(28); lblGR.y(sectionY); lblGR.width(500);
    plan.addChild(lblGR);
    sectionY += 22;

    // Emoji
    auto lblEmoji = new Label("Emoji：😀🎉🚀❤️🌟👍🎵🎨🔥💡✅🌈");
    lblEmoji.x(28); lblEmoji.y(sectionY); lblEmoji.width(500);
    plan.addChild(lblEmoji);
    sectionY += 22;

    // 数学符号
    auto lblMath = new Label("Math：∑∏∫√∞≈≠≤≥±×÷∂∇");
    lblMath.x(28); lblMath.y(sectionY); lblMath.width(500);
    plan.addChild(lblMath);
    sectionY += 22;

    // 特殊符号
    auto lblSymbols = new Label("Symbols：©®™€£¥§¶†‡★☆♠♣♥♦");
    lblSymbols.x(28); lblSymbols.y(sectionY); lblSymbols.width(500);
    plan.addChild(lblSymbols);
    sectionY += 30;

    // 多语言 TextInput 展示
    auto utf8InputInfo = new Label("多语言 TextInput 输入测试：");
    utf8InputInfo.x(28); utf8InputInfo.y(sectionY); utf8InputInfo.width(400);
    utf8InputInfo.fontSize(12); utf8InputInfo.textColor(0x00444444);
    plan.addChild(utf8InputInfo);
    sectionY += 20;

    auto tiCN = new TextInput("输入中文测试");
    tiCN.x(28); tiCN.y(sectionY); tiCN.width(300);
    plan.addChild(tiCN);

    auto tiJP = new TextInput("日本語入力");
    tiJP.x(340); tiJP.y(sectionY); tiJP.width(300);
    plan.addChild(tiJP);
    sectionY += 34;

    auto tiMix = new TextInput("Hello 你世界 123");
    tiMix.x(28); tiMix.y(sectionY); tiMix.width(300);
    plan.addChild(tiMix);
    sectionY += 40;

    // 多语言 EditBox 展示
    auto utf8EditInfo = new Label("多语言 EditBox 多行编辑测试：");
    utf8EditInfo.x(28); utf8EditInfo.y(sectionY); utf8EditInfo.width(400);
    utf8EditInfo.fontSize(12); utf8EditInfo.textColor(0x00444444);
    plan.addChild(utf8EditInfo);
    sectionY += 20;

    auto editBoxUTF8 = new EditBox("多语言多行编辑测试：\nChinese: 你好世界\nJapanese: こんにちは\nKorean: 안녕하세요\nRussian: Привет\nEmoji: 😀🎉🚀");
    editBoxUTF8.x(28); editBoxUTF8.y(sectionY); editBoxUTF8.width(400); editBoxUTF8.height(100);
    plan.addChild(editBoxUTF8);
    sectionY += 110;

    // ════════════════════════════════════════════════
    // Section 7c: TabWidget
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— TabWidget ——");

    auto tabWidget = new TabWidget();
    tabWidget.x(28); tabWidget.y(sectionY); tabWidget.width(500); tabWidget.height(160);

    // 标签页 1
    auto tab1Container = new Control();
    auto tab1Label = new Label("这是标签页 1 的内容");
    tab1Label.x(10); tab1Label.y(10); tab1Label.width(200);
    tab1Container.addChild(tab1Label);
    auto tab1Btn = new Button("Tab1 Button");
    tab1Btn.x(10); tab1Btn.y(40);
    tab1Container.addChild(tab1Btn);
    tabWidget.addTab("Tab 1", tab1Container);

    // 标签页 2
    auto tab2Container = new Control();
    auto tab2Label = new Label("这是标签页 2 的内容");
    tab2Label.x(10); tab2Label.y(10); tab2Label.width(200);
    tab2Container.addChild(tab2Label);
    tabWidget.addTab("Tab 2", tab2Container);

    // 标签页 3
    auto tab3Container = new Control();
    auto tab3Label = new Label("这是标签页 3");
    tab3Label.x(10); tab3Label.y(10); tab3Label.width(200);
    tab3Container.addChild(tab3Label);
    tabWidget.addTab("Tab 3", tab3Container);

    plan.addChild(tabWidget);
    sectionY += 170;

    // ════════════════════════════════════════════════
    // Section 7d: ComboBox
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— ComboBox ——");

    auto comboBox1 = new ComboBox();
    comboBox1.x(28); comboBox1.y(sectionY); comboBox1.width(200);
    comboBox1.addItem("Item 1");
    comboBox1.addItem("Item 2");
    comboBox1.addItem("Item 3");
    comboBox1.addItem("Item 4");
    comboBox1.addItem("Item 5");
    plan.addChild(comboBox1);
    sectionY += 36;

    // ════════════════════════════════════════════════
    // Section 7e: StringGrid
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— StringGrid ——");

    auto stringGrid = new StringGrid(
        ["Name", "Value", "Status"],  // 表头
        [                             // 数据
            ["Alpha", "100", "OK"],
            ["Beta", "200", "Warn"],
            ["Gamma", "300", "OK"],
            ["Delta", "400", "Error"],
                        ["Alpha", "100", "OK"],
            ["Beta", "200", "Warn"],
            ["Gamma", "300", "OK"],
            ["Delta", "400", "Error"],
                        ["Alpha", "100", "OK"],
            ["Beta", "200", "Warn"],
            ["Gamma", "300", "OK"],
            ["Delta", "400", "Error"],
                        ["Alpha", "100", "OK"],
            ["Beta", "200", "Warn"],
            ["Gamma", "300", "OK"],
            ["Delta", "400", "Error"],
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
    stringGrid.x(28); stringGrid.y(sectionY); stringGrid.width(400); stringGrid.height(120);
    stringGrid.setColWidths([120, 100, 80]);
    plan.addChild(stringGrid);
    sectionY += 130;

    // ════════════════════════════════════════════════
    // Section 7f: TreeWidget
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— TreeWidget ——");

    auto treeRoot = new TreeItem("Root");
    auto child1 = treeRoot.addChild("Child 1");
    child1.addChild("Leaf 1.1");
    child1.addChild("Leaf 1.2");
    auto child2 = treeRoot.addChild("Child 2");
    child2.addChild("Leaf 2.1");
    treeRoot.addChild("Child 3");
    treeRoot.expanded = true;
    child1.expanded = true;

    auto treeWidget = new TreeWidget();
    treeWidget.x(28); treeWidget.y(sectionY); treeWidget.width(300); treeWidget.height(140);
    treeWidget.root(treeRoot);
    plan.addChild(treeWidget);
    sectionY += 150;

    // ════════════════════════════════════════════════
    // Section 7g: ScrollBar & Spacers
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— ScrollBar & Spacers ——");

    auto vScrollBar = new ScrollBar();
    vScrollBar.x(28); vScrollBar.y(sectionY); vScrollBar.width(14); vScrollBar.height(100);
    vScrollBar.max(100); vScrollBar.pageSize(20);
    plan.addChild(vScrollBar);

    auto hScrollBar = new ScrollBar(ScrollBarOrientation.Horizontal);
    hScrollBar.x(50); hScrollBar.y(sectionY + 80); hScrollBar.width(200); hScrollBar.height(14);
    hScrollBar.max(100); hScrollBar.pageSize(20);
    plan.addChild(hScrollBar);

    auto spacerLabel = new Label("VSpacer/HSpacer are invisible layout helpers");
    spacerLabel.x(50); spacerLabel.y(sectionY); spacerLabel.width(300);
    spacerLabel.fontSize(12); spacerLabel.textColor(0x00666666);
    plan.addChild(spacerLabel);
    sectionY += 104;

    // ════════════════════════════════════════════════
    // Section 7h: Panel
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— Panel ——");

    auto panel1 = new Panel("Panel with title");
    panel1.x(28); panel1.y(sectionY); panel1.width(300); panel1.height(120);
    panel1.vScroll(true);
    plan.addChild(panel1);

    auto panelLabel = new Label("Panel content area");
    panelLabel.x(10); panelLabel.y(30); panelLabel.width(200);
    panel1.addChild(panelLabel);

    auto panelBtn = new Button("Panel Button");
    panelBtn.x(10); panelBtn.y(60);
    panel1.addChild(panelBtn);

    sectionY += 130;

    // ════════════════════════════════════════════════
    // Section 7i: Popup & PopupMenu
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— Popup & PopupMenu ——");

    auto popupInfo = new Label("Popup and PopupMenu are programmatic overlays");
    popupInfo.x(28); popupInfo.y(sectionY); popupInfo.width(400);
    popupInfo.fontSize(12); popupInfo.textColor(0x00444444);
    plan.addChild(popupInfo);

    auto btnShowPopup = new Button("Show Popup");
    btnShowPopup.x(28); btnShowPopup.y(sectionY + 24); btnShowPopup.width(120);
    plan.addChild(btnShowPopup);

    auto popup1 = new Popup();
    popup1.x(100); popup1.y(200); popup1.width(200); popup1.height(100);
    auto popupLabel = new Label("Popup content!");
    popupLabel.x(10); popupLabel.y(10); popupLabel.width(180);
    popup1.content(popupLabel);
    window.addChild(popup1);

    btnShowPopup.onClick((ref ClickEvent e) {
        popup1.open(200, 300);
        setFeedback("Popup opened");
    });

    sectionY += 60;

    // ════════════════════════════════════════════════
    // Section 7j: ImageWidget & ImageButton & TextImageButton
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— ImageWidget & ImageButton & TextImageButton ——");

    auto imgInfo = new Label("Image controls require BMP files. Showing placeholders:");
    imgInfo.x(28); imgInfo.y(sectionY); imgInfo.width(400);
    imgInfo.fontSize(12); imgInfo.textColor(0x00444444);
    plan.addChild(imgInfo);
    sectionY += 22;

    auto imgWidget = new ImageWidget();
    imgWidget.x(28); imgWidget.y(sectionY); imgWidget.width(80); imgWidget.height(60);
    plan.addChild(imgWidget);

    auto imgBtn = new ImageButton();
    imgBtn.x(120); imgBtn.y(sectionY); imgBtn.width(80); imgBtn.height(60);
    plan.addChild(imgBtn);

    auto textImgBtn = new TextImageButton("IconBtn");
    textImgBtn.x(210); textImgBtn.y(sectionY); textImgBtn.width(120); textImgBtn.height(40);
    plan.addChild(textImgBtn);

    sectionY += 70;

    // ════════════════════════════════════════════════
    // Section 7k: MainMenu & PopupMenu
    // ════════════════════════════════════════════════
    sectionY += 4;
    makeHeader("—— MainMenu & PopupMenu ——");

    auto menuInfo2 = new Label("MainMenu extends MenuBar. PopupMenu is a right-click context menu.");
    menuInfo2.x(28); menuInfo2.y(sectionY); menuInfo2.width(500);
    menuInfo2.fontSize(12); menuInfo2.textColor(0x00444444);
    plan.addChild(menuInfo2);

    auto mainMenu1 = new MainMenu();
    mainMenu1.x(28); mainMenu1.y(sectionY + 24); mainMenu1.width(400); mainMenu1.height(24);
    auto mmItem1 = mainMenu1.add("Menu1");
    auto mmSub1 = mmItem1.addSubItem("SubItem 1");
    auto mmSub2 = mmItem1.addSubItem("SubItem 2");
    auto mmItem2 = mainMenu1.add("Menu2");
    auto mmSub3 = mmItem2.addSubItem("Action A");
    mmSub3.onClick((ref ClickEvent e) { setFeedback("MainMenu: Action A"); });
    plan.addChild(mainMenu1);

    sectionY += 60;

    // ════════════════════════════════════════════════
    // Section 8: Utilities  (screenshot, close)
    // ════════════════════════════════════════════════
    sectionY += 6;
    makeHeader("\u2014\u2014 Utilities \u2014\u2014");

    auto btnScreenshot = new Button("Take Screenshot Now");
    btnScreenshot.x(28);
    btnScreenshot.y(sectionY);
    btnScreenshot.width(200);
    btnScreenshot.onClick((ref ClickEvent e) {
        setFeedback("Taking immediate screenshot...");
        window.captureImmediate("all_controls_demo.bmp");
        setFeedback("Screenshot saved to all_controls_demo.bmp");
    });
    plan.addChild(btnScreenshot);

    auto btnScreenshotDelay = new Button("Screenshot in 3s");
    btnScreenshotDelay.x(240);
    btnScreenshotDelay.y(sectionY);
    btnScreenshotDelay.width(180);
    btnScreenshotDelay.onClick((ref ClickEvent e) {
        setFeedback("Screenshot scheduled in 3 seconds...");
        window.scheduleScreenshot(3000, "all_controls_demo_delayed.bmp");
    });
    plan.addChild(btnScreenshotDelay);

    auto btnClose = new Button("Close Window");
    btnClose.x(440);
    btnClose.y(sectionY);
    btnClose.width(160);
    btnClose.onClick((ref ClickEvent e) {
        setFeedback("Closing window...");
        window.close();
    });
    plan.addChild(btnClose);
    sectionY += 42;

    // ════════════════════════════════════════════════
    // Section 9: Summary
    // ════════════════════════════════════════════════
    makeHeader("\u2014\u2014 Summary \u2014\u2014");

    auto summary = new Label(format(
        "Controls: Label + Button + CheckBox + RadioButton + EditLine + EditBox + TextInput + TabWidget + ComboBox + StringGrid + TreeWidget + ScrollBar + Panel + Popup + ImageWidget + ImageButton + TextImageButton + ScrollableContainer + MenuBar + MainMenu + PopupMenu + VSpacer + HSpacer + Layouts(V/H/Grid)"
    ));
    summary.x(28);
    summary.y(sectionY);
    summary.width(850);
    summary.height(20);
    summary.fontSize(12);
    summary.textColor(0x00888888);
    plan.addChild(summary);
    sectionY += 24;

    auto tip = new Label("Tip: Press Tab to cycle focus through buttons.  Enter/Space activates the focused button.");
    tip.x(28);
    tip.y(sectionY);
    tip.width(850);
    tip.height(20);
    tip.fontSize(12);
    tip.textColor(0x00666666);
    plan.addChild(tip);

    // ════════════════════════════════════════════════
    // Finalize scrollable content bounds
    // ════════════════════════════════════════════════
    plan.recalcContent();
    logInfo("Plan content height: ", plan.contentHeight());

    // ════════════════════════════════════════════════
    // Go!
    // ════════════════════════════════════════════════
    logInfo("All controls added \u2014 showing window");

    window.show();
    // 窗口显示后延迟截图，确保控件已渲染
    window.scheduleScreenshot(500, "all_controls_demo_screenshot.bmp");
    app.run();

    logInfo("=== DGUI All Controls Demo Exited ===");
}
