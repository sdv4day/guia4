module guia4.guicore.theme;

import guia4.guicore.color;
import windows.win32.foundation : COLORREF;

/**
 * Theme — GUI 主题颜色常量
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
    static Color containerBg()   { return Color.rgb(0xFA, 0xFA, 0xFA); }  /// ScrollableContainer 背景
    static Color titleBarBg()    { return Color.rgb(0xF0, 0xF0, 0xF0); }  /// 标题栏背景（稍亮）
    static Color headerBg()      { return Color.rgb(0xF5, 0xF5, 0xF5); }  /// 表头背景（稍亮）

    // ── 滚动条 ──
    static Color scrollTrack()   { return Color.rgb(0xE0, 0xE0, 0xE0); }  /// 滚动条轨道（暗灰，与背景有对比）
    static Color scrollThumb()   { return Color.rgb(0xA0, 0xA0, 0xA0); }  /// 滚动条滑块（中灰，明显可见）
    static Color scrollHover()   { return Color.rgb(0x80, 0x80, 0x80); }  /// 滑块悬停（深灰）
    static Color scrollDrag()    { return Color.rgb(0x60, 0x60, 0x60); }  /// 滑块拖拽（更深灰）
    static Color scrollBorder()  { return Color.rgb(0x70, 0x70, 0x70); }  /// 滑块边框

    // ── 选中/焦点 ──
    static Color selected()      { return Color.rgb(0xBB, 0xDE, 0xFB); }  /// 选中背景（更亮的蓝色）
    static Color selectedText()  { return Color.rgb(0x00, 0x00, 0x00); }  /// 选中文字颜色
    static Color focusBorder()   { return Color.rgb(0x00, 0x78, 0xD4); }  /// 焦点边框（蓝色）

    // ── 菜单 ──
    static Color menuBg()        { return Color.rgb(0xFF, 0xFF, 0xFF); }  /// 菜单背景
    static Color menuBarBg()     { return Color.rgb(0xF5, 0xF5, 0xF5); }  /// 菜单栏背景（稍亮）
    static Color menuHoverBg()   { return Color.rgb(0xE5, 0xE5, 0xE5); }  /// 菜单项悬停（稍亮）

    // ── 便捷 COLORREF 转换 ──
    // 用于直接传给 GDI 函数，避免每次调用 toCOLORREF()

    static COLORREF crBackground()   { return background().toCOLORREF(); }
    static COLORREF crText()         { return text().toCOLORREF(); }
    static COLORREF crBorder()       { return border().toCOLORREF(); }
    static COLORREF crBorderDark()   { return borderDark().toCOLORREF(); }
    static COLORREF crError()        { return error().toCOLORREF(); }
    static COLORREF crErrorBg()      { return errorBg().toCOLORREF(); }
    static COLORREF crWarning()      { return warning().toCOLORREF(); }
    static COLORREF crWarningBg()    { return warningBg().toCOLORREF(); }
    static COLORREF crSuccess()      { return success().toCOLORREF(); }
    static COLORREF crSuccessBg()    { return successBg().toCOLORREF(); }
    static COLORREF crInfo()         { return info().toCOLORREF(); }
    static COLORREF crInfoBg()       { return infoBg().toCOLORREF(); }
    static COLORREF crPanelBg()      { return panelBg().toCOLORREF(); }
    static COLORREF crContainerBg()  { return containerBg().toCOLORREF(); }
    static COLORREF crTitleBarBg()   { return titleBarBg().toCOLORREF(); }
    static COLORREF crHeaderBg()     { return headerBg().toCOLORREF(); }
    static COLORREF crScrollTrack()  { return scrollTrack().toCOLORREF(); }
    static COLORREF crScrollThumb()  { return scrollThumb().toCOLORREF(); }
    static COLORREF crScrollHover()  { return scrollHover().toCOLORREF(); }
    static COLORREF crScrollDrag()   { return scrollDrag().toCOLORREF(); }
    static COLORREF crScrollBorder() { return scrollBorder().toCOLORREF(); }
    static COLORREF crSelected()     { return selected().toCOLORREF(); }
    static COLORREF crSelectedText() { return selectedText().toCOLORREF(); }
    static COLORREF crFocusBorder()  { return focusBorder().toCOLORREF(); }
    static COLORREF crMenuBg()       { return menuBg().toCOLORREF(); }
    static COLORREF crMenuBarBg()    { return menuBarBg().toCOLORREF(); }
    static COLORREF crMenuHoverBg()  { return menuHoverBg().toCOLORREF(); }
}
