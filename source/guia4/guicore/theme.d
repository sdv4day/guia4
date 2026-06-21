module guia4.guicore.theme;

import guia4.guicore.color;

/**
 * Theme — GUI 主题颜色常量（跨平台）
 *
 * 消除各控件中硬编码的颜色魔数，统一在此定义。
 * 未来可扩展为可切换的主题系统。
 */
struct Theme
{
    // ── 通用 ──
    static Color background()    { return Color.rgb(0xFF, 0xFF, 0xFF); }  /// 窗口/控件默认背景
    static Color text()          { return Color.rgb(0x33, 0x33, 0x33); }  /// 默认文字颜色
    static Color textDisabled()  { return Color.rgb(0x99, 0x99, 0x99); }  /// 禁用文字颜色
    static Color border()        { return Color.rgb(0xCC, 0xCC, 0xCC); }  /// 默认边框
    static Color borderDark()    { return Color.rgb(0x88, 0x88, 0x88); }  /// 深色边框

    // ── 状态颜色 ──
    static Color error()         { return Color.rgb(0xD3, 0x2F, 0x2F); }  /// 错误红
    static Color errorBg()       { return Color.rgb(0xFC, 0xE4, 0xE4); }  /// 错误背景（浅红）
    static Color warning()       { return Color.rgb(0xF5, 0x7C, 0x00); }  /// 警告橙
    static Color warningBg()     { return Color.rgb(0xFF, 0xF3, 0xE0); }  /// 警告背景（浅橙）
    static Color success()       { return Color.rgb(0x2E, 0x7D, 0x32); }  /// 成功绿
    static Color successBg()     { return Color.rgb(0xE8, 0xF5, 0xE9); }  /// 成功背景（浅绿）
    static Color info()          { return Color.rgb(0x19, 0x76, 0xD2); }  /// 信息蓝
    static Color infoBg()        { return Color.rgb(0xE3, 0xF2, 0xFD); }  /// 信息背景（浅蓝）

    // ── 面板/容器 ──
    static Color panelBg()       { return Color.rgb(0xF5, 0xF5, 0xF5); }  /// Panel 背景（稍亮）
    static Color containerBg()   { return Color.rgb(0xFA, 0xFA, 0xFA); }  /// Container 背景
    static Color titleBarBg()    { return Color.rgb(0xF0, 0xF0, 0xF0); }  /// 标题栏背景（稍亮）
    static Color headerBg()      { return Color.rgb(0xF5, 0xF5, 0xF5); }  /// 表头背景（稍亮）

    // ── 滚动条 ──
    static Color scrollTrack()   { return Color.rgb(0xE0, 0xE0, 0xE0); }  /// 滚动条轨道
    static Color scrollThumb()   { return Color.rgb(0xA0, 0xA0, 0xA0); }  /// 滚动条滑块
    static Color scrollHover()   { return Color.rgb(0x80, 0x80, 0x80); }  /// 滑块悬停
    static Color scrollDrag()    { return Color.rgb(0x60, 0x60, 0x60); }  /// 滑块拖拽
    static Color scrollBorder()  { return Color.rgb(0x70, 0x70, 0x70); }  /// 滑块边框

    // ── 选中/焦点 ──
    static Color selected()      { return Color.rgb(0xBB, 0xDE, 0xFB); }  /// 选中背景
    static Color selectedText()  { return Color.rgb(0x00, 0x00, 0x00); }  /// 选中文字颜色
    static Color focusBorder()   { return Color.rgb(0x00, 0x78, 0xD4); }  /// 焦点边框

    // ── 菜单 ──
    static Color menuBg()        { return Color.rgb(0xFF, 0xFF, 0xFF); }  /// 菜单背景
    static Color menuBarBg()     { return Color.rgb(0xF5, 0xF5, 0xF5); }  /// 菜单栏背景
    static Color menuHoverBg()   { return Color.rgb(0xE5, 0xE5, 0xE5); }  /// 菜单项悬停

    // ── BGR 便捷方法（Windows GDI 兼容）──
    // 控件通过 GdiRenderContext 渲染时使用 toBGR()

    static uint bgrBackground()   { return background().toBGR(); }
    static uint bgrText()         { return text().toBGR(); }
    static uint bgrBorder()       { return border().toBGR(); }
    static uint bgrBorderDark()   { return borderDark().toBGR(); }
    static uint bgrSelected()     { return selected().toBGR(); }
    static uint bgrFocusBorder()  { return focusBorder().toBGR(); }
    static uint bgrMenuBg()       { return menuBg().toBGR(); }
    static uint bgrMenuBarBg()    { return menuBarBg().toBGR(); }
    static uint bgrMenuHoverBg()  { return menuHoverBg().toBGR(); }
    static uint bgrHeaderBg()     { return headerBg().toBGR(); }
    static uint bgrScrollTrack()  { return scrollTrack().toBGR(); }
    static uint bgrScrollThumb()  { return scrollThumb().toBGR(); }
    static uint bgrScrollHover()  { return scrollHover().toBGR(); }
    static uint bgrScrollDrag()   { return scrollDrag().toBGR(); }
    static uint bgrPanelBg()      { return panelBg().toBGR(); }
    static uint bgrContainerBg()  { return containerBg().toBGR(); }
    static uint bgrTitleBarBg()   { return titleBarBg().toBGR(); }

    // ── 兼容旧接口（crXxx 别名）──
    // 保留 COLORREF 返回类型以便未重构的控件继续工作

    version(Windows)
    {
        import windows.win32.foundation : COLORREF;
        static COLORREF crBackground()   { return COLORREF(bgrBackground()); }
        static COLORREF crText()         { return COLORREF(bgrText()); }
        static COLORREF crBorder()       { return COLORREF(bgrBorder()); }
        static COLORREF crBorderDark()   { return COLORREF(bgrBorderDark()); }
        static COLORREF crSelected()     { return COLORREF(bgrSelected()); }
        static COLORREF crFocusBorder()  { return COLORREF(bgrFocusBorder()); }
        static COLORREF crMenuBg()       { return COLORREF(bgrMenuBg()); }
        static COLORREF crMenuBarBg()    { return COLORREF(bgrMenuBarBg()); }
        static COLORREF crMenuHoverBg()  { return COLORREF(bgrMenuHoverBg()); }
        static COLORREF crHeaderBg()     { return COLORREF(bgrHeaderBg()); }
        static COLORREF crScrollTrack()  { return COLORREF(bgrScrollTrack()); }
        static COLORREF crScrollThumb()  { return COLORREF(bgrScrollThumb()); }
        static COLORREF crScrollHover()  { return COLORREF(bgrScrollHover()); }
        static COLORREF crScrollDrag()   { return COLORREF(bgrScrollDrag()); }
        static COLORREF crPanelBg()      { return COLORREF(bgrPanelBg()); }
        static COLORREF crContainerBg()  { return COLORREF(bgrContainerBg()); }
        static COLORREF crTitleBarBg()   { return COLORREF(bgrTitleBarBg()); }
        static COLORREF crSelectedText() { return COLORREF(selectedText().toBGR()); }
        static COLORREF crError()        { return COLORREF(error().toBGR()); }
        static COLORREF crErrorBg()      { return COLORREF(errorBg().toBGR()); }
        static COLORREF crWarning()      { return COLORREF(warning().toBGR()); }
        static COLORREF crWarningBg()    { return COLORREF(warningBg().toBGR()); }
        static COLORREF crSuccess()      { return COLORREF(success().toBGR()); }
        static COLORREF crSuccessBg()    { return COLORREF(successBg().toBGR()); }
        static COLORREF crInfo()         { return COLORREF(info().toBGR()); }
        static COLORREF crInfoBg()       { return COLORREF(infoBg().toBGR()); }
        static COLORREF crScrollBorder() { return COLORREF(scrollBorder().toBGR()); }
    }
}
