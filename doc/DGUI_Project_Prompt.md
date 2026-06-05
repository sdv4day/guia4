## 项目目标

使用 **D 语言** 开发一个现代化、高性能、保留模式（Retained Mode）GUI 框架。

框架核心设计目标：

* Windows 首发平台
* 核心渲染后端优先支持 D3D12
* 架构预留 Vulkan 后端
* GUI Core 与渲染后端完全解耦
* GUI Core 与平台层完全解耦
* 最大化利用 D 语言编译期能力（CTFE、Template、Mixin、Static Reflection）
* 保持直观易用的面向对象 API
* 实现多层缓存与选择性重绘
* 避免传统 GUI 框架的虚函数和运行时反射开销

---

## 设计原则

### 1. API 优先

用户应能以自然方式构建界面：

```d
auto win = new MainWindow;

auto menu = new MenuBar(win);

menu.add!("&Open")(&onOpen);
auto menu1 = menu.add!(lang!"Save")(&onSave);

auto btn = new Button(menu1,"Click Me",&onButtonClick);

win.show();
```

开发者无需关注：

* GPU资源
* Layer管理
* 脏矩形
* 命令缓冲
* 平台差异

---

### 2. 编译时优化优先

凡可在编译期确定的信息：

* 不允许拖到运行期

重点利用：

* CTFE
* 模板
* mixin
* static foreach
* static if
* __traits
* std.traits 和 phobos2 库

实现：

* 布局预计算
* 控件注册
* 事件路由表生成
* 类型分派
* 属性绑定

---

### 3. 保留模式 GUI

框架采用：

```
Control Tree
    ↓
Layout
    ↓
Layer Cache
    ↓
Renderer
```

而非 Immediate Mode。

每个控件持有自身状态。

---

### 4. 多层渲染

界面拆分为多个独立 Layer：

```
Background
Content
Popup
Tooltip
Overlay
```

每层拥有：

```
RenderTarget
DirtyFlag
ControlList
```

---

### 5. 选择性更新

每个控件维护：

```
DirtyFlag
```

属性变更：

```
Control Dirty
    ↓
Parent Dirty
    ↓
Layer Dirty
```

渲染时：

```
仅重绘脏层
```

避免全界面重绘。

---

### 6. GPU Layer Cache

每个 Layer：

```
Texture
Framebuffer
```

更新策略：

```
Dirty Layer
    ↓
重新绘制到 Layer Texture
```

最终：

```
Layer0
Layer1
Layer2
Layer3
    ↓
Composite
    ↓
BackBuffer
```

---

## 控件系统

采用：

```
CRTP
+
Mixin
+
Compile-Time Registration
```

禁止：

```
大量虚函数
RTTI
运行时反射
```

---

### 控件基类职责

维护：

```
Position
Size
Visibility
DirtyFlag
Layer
Parent
Children
```

提供：

```
render()
layout()
hitTest()
```

---

## 事件系统

采用：

```
Compile-Time Dispatch
```

实现：

```
Immutable Callback Table
```

运行时：

```
EventId
    ↓
Direct Call
```

避免：

```
Signal/Slot
字符串查找
运行时反射
```

---

## 布局系统

支持：

```
Absolute
Vertical
Horizontal
Grid
```

静态布局：

```
CTFE预计算
```

结果保存为：

```
immutable LayoutData
```

运行时零计算。

---

## 渲染架构

### GUI Core

只依赖：

```
IRenderDevice
ITexture
IRenderTarget
ICommandList
```

禁止出现：

```
ID3D12Resource
VkImage
VkBuffer
```

等后端对象。

---

### RenderDevice 抽象

统一抽象：

```
Texture
Buffer
Pipeline
RenderTarget
CommandList
```

设计参考：

```
D3D12
Vulkan
共同抽象层
```

而非 OpenGL 风格。

---

## 后端规划

### 第一阶段

Windows + D3D12

### 第二阶段

Windows + DirectComposition

### 第三阶段

Windows + Vulkan

### 第四阶段

Wayland + Vulkan

---

## Windows MVP 依赖

仅使用：

```
Windows.Win32.Foundation

Windows.Win32.System.Com

Windows.Win32.UI.WindowsAndMessaging

Windows.Win32.Graphics.Dxgi
Windows.Win32.Graphics.Dxgi.Common

Windows.Win32.Graphics.Direct3D12
Windows.Win32.Graphics.Direct3D.Dxc

Windows.Win32.Graphics.DirectWrite

Windows.Win32.Graphics.Imaging
```

---

## 第二阶段依赖

```
Windows.Win32.Graphics.DirectComposition

Windows.Win32.Graphics.Dwm
```

---

## 第三阶段依赖

```
Windows.Win32.System.DataExchange

Windows.Win32.UI.Input.Ime

Windows.Win32.UI.TextServices

Windows.Win32.System.Ole

Windows.Win32.UI.Shell
```

---

## 不作为核心依赖

以下模块不应进入 GUI Core：

```
Windows.Win32.Graphics.Gdi

Windows.Win32.Graphics.GdiPlus

Windows.Win32.Graphics.Direct2D

Windows.Win32.Graphics.Direct2D.Common

Windows.Win32.Graphics.Imaging.D2D
```

原因：

* 与 Vulkan 无法共享实现
* 增加平台耦合
* 不符合自绘渲染架构

---

## 性能目标

### 布局

```
静态布局：
0运行时计算
```

---

### 事件

```
接近直接函数调用成本
```

---

### 渲染

```
仅更新脏层
```

---

### GPU

```
Layer Texture Cache
+
Alpha Composite
```

---

### 内存

```
Texture Pool
Buffer Pool
Arena Allocator
```

避免频繁分配。

---

## 最终目标

构建一个：

```
D语言
+
保留模式GUI
+
编译时优化
+
多层缓存
+
D3D12
+
Vulkan
+
跨平台
```

的现代 GUI 框架，其设计理念更接近：

* Flutter
* Chromium
* DirectComposition
* WPF

而非：

* WinForms
* MFC
* Qt Widgets
* GDI/GDI+ 体系
