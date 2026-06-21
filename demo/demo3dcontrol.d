module demo3dcontrol;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.color;
import guia4.guicore.irendercontext;
import guia4.guicore.rendercontextfactory;
import guia4.gfx.renderer3d;
import guia4.gfx.model;
import guia4.gfx.math3d;
import guia4.utils.logger;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import std.conv;
import std.math;

/**
 * Demo3DControl — 3D模型显示控件
 *
 * 使用 SoftwareRenderer3D 渲染 OBJ 模型，支持鼠标拖拽旋转。
 */
class Demo3DControl : Control
{
    private:
    SoftwareRenderer3D _renderer;
    Model _model;
    string _modelPath;
    bool _modelLoaded = false;
    bool _wireframe = false;

    // 旋转角度（度）
    float _rotX = 0, _rotY = 45;
    // 相机距离
    float _camDist = 3.0f;

    // 鼠标拖拽状态
    bool _dragging = false;
    int _lastMouseX, _lastMouseY;

    // 自动旋转
    bool _autoRotate = true;

    public:
    this(Control parent, string objPath)
    {
        super(parent);
        _modelPath = objPath;
        width = 400;
        height = 300;

        // 加载模型
        loadModel(objPath);

        // 注册鼠标事件
        onMouseDown(&mouseDown);
        onMouseUp(&mouseUp);
        onMouseMove(&mouseMove);

        logInfo("Demo3DControl created: path='", objPath, "'");
    }

    ~this()
    {
        // cleanup
    }

    // ── 属性 ──

    bool wireframe() const @property { return _wireframe; }
    void wireframe(bool v) @property { _wireframe = v; markDirty(); }

    bool autoRotate() const @property { return _autoRotate; }
    void autoRotate(bool v) @property { _autoRotate = v; markDirty(); }

    float rotationX() const @property { return _rotX; }
    float rotationY() const @property { return _rotY; }

    bool modelLoaded() const @property { return _modelLoaded; }

    /// 加载OBJ模型
    void loadModel(string path)
    {
        import std.file : exists;
        import std.string : format;

        if (!exists(path))
        {
            logError("Demo3DControl: model file not found: ", path);
            _modelLoaded = false;
            return;
        }

        _model = loadOBJ(path);
        _model.normalize();
        _model.computeFaceNormals();
        _modelLoaded = true;
        _rotX = 0;
        _rotY = 45;

        logInfo("Demo3DControl: loaded model with ",
                _model.vertices.length, " vertices, ",
                _model.faces.length, " faces");
        markDirty();
    }

    /// 切换线框模式
    void toggleWireframe()
    {
        _wireframe = !_wireframe;
        markDirty();
    }

    /// 推进一帧（用于定时器驱动的动画）
    void advanceFrame()
    {
        if (_autoRotate && _modelLoaded)
        {
            _rotY += 0.5f; // 每帧旋转0.5度
            if (_rotY >= 360) _rotY -= 360;
            markDirty();
        }
    }

    // ── 鼠标事件 ──

    void mouseDown(ref MouseEvent e)
    {
        _dragging = true;
        _lastMouseX = e.x;
        _lastMouseY = e.y;
    }

    void mouseUp(ref MouseEvent e)
    {
        _dragging = false;
    }

    void mouseMove(ref MouseEvent e)
    {
        if (!_dragging) return;

        int dx = e.x - _lastMouseX;
        int dy = e.y - _lastMouseY;
        _lastMouseX = e.x;
        _lastMouseY = e.y;

        // 拖拽旋转
        _rotY += dx * 0.5f;
        _rotX += dy * 0.5f;

        // 限制X旋转范围
        if (_rotX > 89)  _rotX = 89;
        if (_rotX < -89) _rotX = -89;

        markDirty();
    }

    // ── 渲染 ──

    override void renderWithGDI(void* hdc_)
    {
        if (!_modelLoaded)
        {
            // 显示加载失败信息
            drawErrorMessage(hdc_);
            return;
        }

        auto hdc = cast(HDC)hdc_;
        int w = width;
        int h = height;

        if (w <= 0 || h <= 0) return;

        // 为这个控件创建离屏DC用于渲染
        HDC memDC = CreateCompatibleDC(hdc);
        HBITMAP memBmp = CreateCompatibleBitmap(hdc, w, h);
        HGDIOBJ oldBmp = SelectObject(memDC, cast(HGDIOBJ)memBmp);

        // 填充深色背景
        RECT rect = {0, 0, w, h};
        HBRUSH bgBrush = CreateSolidBrush(cast(COLORREF)0x002E1A1A); // dark navy
        FillRect(memDC, &rect, bgBrush);
        DeleteObject(cast(HGDIOBJ)bgBrush);

        // 设置渲染器
        if (_renderer is null)
            _renderer = new SoftwareRenderer3D(memDC, w, h);
        else
            _renderer.resize(w, h);

        _renderer.wireframe = _wireframe;

        // 计算模型变换
        Mat4 rot = Mat4.rotateY(_rotY) * Mat4.rotateX(_rotX);
        _renderer.setModel(rot);

        // 设置相机
        Vec3 eye = Vec3(0, 0, _camDist);
        Vec3 target = Vec3(0, 0, 0);
        Vec3 up = Vec3(0, 1, 0);
        _renderer.lookAt(eye, target, up);

        // 加载模型到渲染器
        _renderer.loadModel(_model);

        // 渲染
        _renderer.render();

        // 复制到目标DC
        BitBlt(hdc, 0, 0, w, h, memDC, 0, 0, SRCCOPY);

        // 清理
        SelectObject(memDC, oldBmp);
        DeleteObject(cast(HGDIOBJ)memBmp);
        DeleteDC(memDC);

        // 绘制信息文本
        drawInfo(hdc_);
    }

    override void render() {}

    // ── 辅助 ──

    private void drawErrorMessage(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        RECT rect = {0, 0, width, height};
        HBRUSH brush = CreateSolidBrush(cast(COLORREF)0x00000000);
        FillRect(hdc, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);

        SetTextColor(hdc, cast(COLORREF)0x00FFFFFF);
        SetBkMode(hdc, TRANSPARENT);

        string msg = "Failed to load model: " ~ _modelPath;
        import std.utf : toUTF16;
        auto wmsg = toUTF16(msg);
        TextOutW(hdc, 4, 4, cast(const(PWSTR))wmsg.ptr, cast(int)wmsg.length);
    }

    private void drawInfo(void* hdc_)
    {
        auto ctx = RenderContextFactory.create(hdc_, width, height);

        string info = "Faces: " ~ to!string(_model.faces.length) ~
                     "  Vertices: " ~ to!string(_model.vertices.length) ~
                     "  [Drag to rotate]";

        if (_wireframe)
            info ~= " [Wireframe]";

        ctx.setFont("Consolas", 11);
        ctx.drawText(4, height - 16, info, Color(180, 180, 180));

        // 右上角FPS/角度信息
        string angleInfo = "RX: " ~ to!string(cast(int)_rotX) ~
                          "° RY: " ~ to!string(cast(int)_rotY) ~ "°";
        ctx.drawText(width - 160, 4, angleInfo, Color(140, 140, 140));
    }
}
