module guia4.platform.types;

// 平台层事件数据结构 — 从平台消息提取的原始事件数据
// 这些结构不包含 Control 引用，是平台窗口和 MainWindow 之间的桥梁

/// 鼠标事件数据 — 从平台消息转发到 MainWindow 层
struct MouseEventData
{
    int x;
    int y;
    int button;  // 0=左键, 1=右键, 2=中键
    bool down;   // true = 按下, false = 释放（仅按钮消息）
    bool move;   // true 表示鼠标移动
    bool leave;  // true 表示鼠标离开窗口
}

/// 键盘事件数据 — 从平台消息转发
struct KeyEventData
{
    uint keyCode;   // 虚键码 (VK_*)
    bool down;      // true = 按下, false = 释放
    bool alt;       // Alt 键是否按下
    bool shift;     // Shift 键是否按下
    bool control;   // Ctrl 键是否按下
}

/// 鼠标滚轮事件数据
struct WheelEventData
{
    int x;          // 客户区 x 坐标
    int y;          // 客户区 y 坐标
    int delta;      // 正值 = 向上滚动, 负值 = 向下滚动
    int hDelta;     // 正值 = 向右滚动, 负值 = 向左滚动（横向滚轮）
}

/// 字符输入事件数据
struct CharEventData
{
    dchar ch;       // Unicode 码点
}