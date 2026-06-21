module guia4.guicore.popup;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.layer;
import guia4.utils.logger;
import guia4.utils.fontcache;
import guia4.platform_win32.win32defs;
import std.utf;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;

/**
 * Popup — 弹出窗口
 *
 * 浮动面板，可指定位置和大小。
 * 渲染在所有其他控件之上。
 */
class Popup : Control
{
    private bool _isOpen = false;
    private Control _content;
    private COLORREF _bgColor = cast(COLORREF)0x00FFFFFF;
    private COLORREF _borderColor = cast(COLORREF)0x00888888;
    private int _shadowOffset = 3;
    private string _title;                    /// 标题文本
    private int _titleBarHeight = 28;         /// 标题栏高度
    private bool _closeBtnHovered = false;    /// 关闭按钮悬停状态
    private bool _isDragging = false;         /// 标题栏拖拽状态
    private bool _dragOriginSet = false;      /// setDragOrigin是否已被调用
    private int _lastAbsX = 0;                /// 上一次鼠标窗口绝对X
    private int _lastAbsY = 0;                /// 上一次鼠标窗口绝对Y
    private int _dragStartX = 0;              /// 拖拽开始时的Popup.x()
    private int _dragStartY = 0;              /// 拖拽开始时的Popup.y()

    this(Control parent)
    {
        super(parent);
        width = 200;
        height = 150;
        visible = false;
        layer = Layer.Popup;
        _title = "弹出窗口";
    }

    /// 标题文本
    string title() const @property { return _title; }
    void title(string v) @property { _title = v; markDirty(); }

    /// 弹出窗口是否打开
    bool isOpen() const @property { return _isOpen; }

    /// 在指定位置打开弹出窗口
    void open(int px, int py)
    {
        setXY(px, py);
        _isOpen = true;
        visible = true;
        markDirty();
    }

    /// 关闭弹出窗口
    void close()
    {
        _isOpen = false;
        visible = false;
        markDirty();
    }

    /// 是否正在拖拽
    bool isDragging() const @property { return _isDragging; }

    /// 设置拖拽起始坐标（由MainWindow调用，传入窗口绝对坐标）
    void setDragOrigin(int absX, int absY)
    {
        _lastAbsX = absX;
        _lastAbsY = absY;
        _dragOriginSet = true;
    }


    /// 设置内容控件
    void content(Control c) @property
    {
        _content = c;
        if (c)
            addChild(c);
    }

    /// 获取内容控件
    Control content() @property { return _content; }

    override void fireMouseDown(int mx, int my, int button)
    {
        if (!_isOpen)
            return;

        // mx, my 已经是控件本地坐标（由 MainWindow clientToControl 转换）
        // 点击弹出窗口外部 → 关闭
        if (mx < 0 || mx >= width() || my < 0 || my >= height())
        {
            close();
            return;
        }

        // 检查是否点击了关闭按钮（标题栏右侧的X按钮）
        int closeBtnSize = _titleBarHeight - 6;
        int closeBtnX = width() - closeBtnSize - 3;
        int closeBtnY = 3;
        if (mx >= closeBtnX && mx < closeBtnX + closeBtnSize &&
            my >= closeBtnY && my < closeBtnY + closeBtnSize)
        {
            close();
            return;
        }

        // 检查是否在标题栏区域（非关闭按钮）→ 启动拖拽
        if (my >= 0 && my < _titleBarHeight)
        {
            _isDragging = true;
            // 记录拖拽开始时的Popup位置
            _dragStartX = position().x();
            _dragStartY = position().y();
            // _lastAbsX/Y 将由 MainWindow 通过 setDragOrigin() 设置为窗口绝对坐标
            return;
        }

        // 转发给内容控件（内容区域在标题栏下方）
        if (_content)
        {
            _content.fireMouseDown(mx, my - _titleBarHeight, button);
        }
    }

    override void fireMouseMove(int mx, int my)
    {
        // 标题栏拖拽移动（mx/my 在拖拽时为窗口绝对坐标，由 MainWindow 传入）
        if (_isDragging)
        {
            // 检查setDragOrigin是否已被调用
            if (!_dragOriginSet)
            {
                return;
            }
            
            // 计算相对于拖拽起始点的偏移
            // _lastAbsX/Y 由 setDragOrigin 设置为鼠标按下时的窗口绝对坐标
            // 当前鼠标位置 mx/my 减去起始位置得到拖拽距离
            int offsetX = mx - _lastAbsX;
            int offsetY = my - _lastAbsY;

            // 新位置 = 拖拽起始位置 + 拖拽距离
            int newX = _dragStartX + offsetX;
            int newY = _dragStartY + offsetY;

            // 边界限制：确保标题栏始终可见（至少留_titleBarHeight像素在窗口内）
            int minVisible = _titleBarHeight;
            int maxX = -width() + minVisible;   // 左边界：右边缘至少minVisible宽度可见
            int maxY = -height() + minVisible;   // 上边界：底部至少minVisible高度可见

            // 获取父窗口尺寸
            int parentW = 800;  // 默认值
            int parentH = 600;  // 默认值
            if (parent() !is null)
            {
                parentW = parent().width();
                parentH = parent().height();
            }

            // 限制范围
            if (newX < maxX) newX = maxX;                       // 不能太左
            if (newX > parentW - minVisible) newX = parentW - minVisible;  // 不能太右
            if (newY < maxY) newY = maxY;                       // 不能太上
            if (newY > parentH - minVisible) newY = parentH - minVisible;  // 不能太下

            setXY(newX, newY);
            markDirty();
            return;
        }

        // 关闭按钮悬停检测（拖拽时跳过，坐标系不同）
        if (!_isDragging)
        {
            int closeBtnSize = _titleBarHeight - 6;
            int closeBtnX = width() - closeBtnSize - 3;
            int closeBtnY = 3;
            bool wasHovered = _closeBtnHovered;
            _closeBtnHovered = (mx >= closeBtnX && mx < closeBtnX + closeBtnSize &&
                                my >= closeBtnY && my < closeBtnY + closeBtnSize);
            if (_closeBtnHovered != wasHovered)
                markDirty();
        }

        super.fireMouseMove(mx, my);
    }

    override void fireMouseUp(int mx, int my, int button)
    {
        if (_isDragging)
        {
            _isDragging = false;
            _dragOriginSet = false;
            markDirty();
            return;
        }
        super.fireMouseUp(mx, my, button);
    }

    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        if (!_isOpen)
            return;

        logTrace("Popup.renderWithGDI() at (", position().x(), ",", position().y(), ")");

        int rx = 0;
        int ry = 0;
        int rw = width();
        int rh = height();

        // ── 阴影效果（偏移灰色矩形） ──
        RECT shadowRect = {
            cast(LONG)(rx + _shadowOffset), cast(LONG)(ry + _shadowOffset),
            cast(LONG)(rx + rw + _shadowOffset), cast(LONG)(ry + rh + _shadowOffset)
        };
        HBRUSH shadowBrush = CreateSolidBrush(cast(COLORREF)0x00808080);
        FillRect(hdc, &shadowRect, shadowBrush);
        DeleteObject(cast(HGDIOBJ)shadowBrush);

        // ── 标题栏背景 ──
        RECT titleRect = {
            cast(LONG)rx, cast(LONG)ry,
            cast(LONG)(rx + rw), cast(LONG)(ry + _titleBarHeight)
        };
        HBRUSH titleBrush = CreateSolidBrush(cast(COLORREF)0x00E8E8E8);
        FillRect(hdc, &titleRect, titleBrush);
        DeleteObject(cast(HGDIOBJ)titleBrush);

        // ── 标题文字 ──
        auto fontEntry = FontCache.get(hdc, "Segoe UI", 12);
        SetTextColor(hdc, cast(COLORREF)0x00333333);
        SetBkMode(hdc, TRANSPARENT);
        if (_title.length > 0)
        {
            wstring titleW = toUTF16(_title);
            TextOutW(hdc, rx + 8, ry + (_titleBarHeight - 12) / 2,
                     cast(const(PWSTR))titleW.ptr, cast(int)titleW.length);
        }
        FontCache.release(hdc, fontEntry);

        // ── 关闭按钮（X） ──
        int closeBtnSize = _titleBarHeight - 6;
        int closeBtnX = rx + rw - closeBtnSize - 3;
        int closeBtnY = ry + 3;
        if (_closeBtnHovered)
        {
            RECT closeRect = {
                cast(LONG)closeBtnX, cast(LONG)closeBtnY,
                cast(LONG)(closeBtnX + closeBtnSize), cast(LONG)(closeBtnY + closeBtnSize)
            };
            HBRUSH closeBrush = CreateSolidBrush(cast(COLORREF)0x00E04040);
            FillRect(hdc, &closeRect, closeBrush);
            DeleteObject(cast(HGDIOBJ)closeBrush);
        }
        // X 符号
        auto closeFontEntry = FontCache.get(hdc, "Segoe UI", closeBtnSize);
        SetTextColor(hdc, _closeBtnHovered ? cast(COLORREF)0x00FFFFFF : cast(COLORREF)0x00666666);
        SetBkMode(hdc, TRANSPARENT);
        wstring closeSym = "✕"w;
        SIZE closeSize;
        GetTextExtentPointW(hdc, cast(const(PWSTR))closeSym.ptr, cast(int)closeSym.length, &closeSize);
        TextOutW(hdc, closeBtnX + (closeBtnSize - closeSize.cx) / 2,
                 closeBtnY + (closeBtnSize - closeSize.cy) / 2,
                 cast(const(PWSTR))closeSym.ptr, cast(int)closeSym.length);
        FontCache.release(hdc, closeFontEntry);

        // ── 内容区域白色背景（标题栏下方） ──
        RECT bgRect = {
            cast(LONG)rx, cast(LONG)(ry + _titleBarHeight),
            cast(LONG)(rx + rw), cast(LONG)(ry + rh)
        };
        HBRUSH bgBrush = CreateSolidBrush(_bgColor);
        FillRect(hdc, &bgRect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // ── 边框 ──
        HPEN borderPen = CreatePen(PS_SOLID, 1, _borderColor);
        HGDIOBJ oldPen = SelectObject(hdc, cast(HGDIOBJ)borderPen);
        HGDIOBJ oldBrush = SelectObject(hdc, cast(HGDIOBJ)GetStockObject(HOLLOW_BRUSH));
        Rectangle(hdc, rx, ry, rx + rw, ry + rh);
        SelectObject(hdc, oldPen);
        SelectObject(hdc, oldBrush);
        DeleteObject(cast(HGDIOBJ)borderPen);

        // ── 渲染内容控件（标题栏下方） ──
        if (_content && _content.visible())
        {
            _content.setXY(rx, ry + _titleBarHeight);
            _content.width(rw);
            _content.height(rh - _titleBarHeight);
            _content.renderWithGDI(hdc.Value);
        }
    }

    override void render() {}
}