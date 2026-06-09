module guia4.platform.events;

// 事件类型统一定义在 guicore.events 中，此处重新导出以保持向后兼容
// 原先在此模块重复定义的 MouseButton/KeyModifier/MouseEvent/KeyEvent/
// ResizeEvent/CloseEvent/PaintEvent/MouseMoveEvent 已移除
public import guia4.guicore.events;
