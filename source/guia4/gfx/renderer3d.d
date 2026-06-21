module guia4.gfx.renderer3d;

import guia4.gfx.math3d;
import guia4.gfx.model;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import std.math;
import std.algorithm;

/**
 * Software 3D renderer that draws to a HDC using GDI.
 *
 * Supports wireframe and flat-shaded triangle rendering
 * with a Z-buffer. All coordinates are screen-space (pixels).
 */
class SoftwareRenderer3D
{
    private:
    int _width, _height;
    float _near = 0.1f;
    float _far  = 100.0f;
    float _fov  = 45.0f;

    Mat4 _projection;
    Mat4 _view;
    Mat4 _model;

    // projection * view * model (recalculated when changed)
    Mat4 _mvp;
    bool _mvpDirty = true;

    // Z-buffer
    float[] _depthBuffer;
    // Color buffer (for flat shading)
    uint[] _colorBuffer;

    HDC _dc;

    // Render state
    bool _wireframe = false;
    Vec3 _lightDir = Vec3(0.5f, 1.0f, 0.8f).normalized();
    Vec3 _ambientColor = Vec3(0.3f, 0.3f, 0.35f);
    Vec3 _diffuseColor = Vec3(0.9f, 0.85f, 0.8f);

    // Screen-space vertex after projection
    struct ScreenVertex
    {
        int x, y;
        float z;       // 1/z for perspective-correct
        float w;       // clip w
        Vec3 worldPos;
        Vec3 normal;
        Vec3 color;
    }

    // Active model
    Model _modelData;
    Vec3 _modelCenter;
    float _modelRadius;

    public:

    this(HDC dc, int width, int height)
    {
        _dc = dc;
        resize(width, height);
    }

    void resize(int width, int height)
    {
        _width = width;
        _height = height;
        _depthBuffer = new float[width * height];
        _colorBuffer  = new uint[width * height];
        recalcProjection();
    }

    // ── Camera controls ──

    void setFOV(float fovDeg)
    {
        _fov = fovDeg;
        recalcProjection();
    }

    void setView(Mat4 view)
    {
        _view = view;
        _mvpDirty = true;
    }

    void setModel(Mat4 model)
    {
        _model = model;
        _mvpDirty = true;
    }

    void lookAt(Vec3 eye, Vec3 target, Vec3 up)
    {
        _view = Mat4.lookAt(eye, target, up);
        _mvpDirty = true;
    }

    void wireframe(bool wf)
    {
        _wireframe = wf;
    }

    bool wireframe() const { return _wireframe; }

    // ── Model loading ──

    void loadModel(Model m)
    {
        _modelData = m;
        m.normalize();
        m.boundingSphere(_modelCenter, _modelRadius);
        _modelData = m;
        _model = Mat4.identity();
        _mvpDirty = true;
    }

    // ── Rendering ──

    void render()
    {
        if (_modelData.faces.length == 0) return;

        // Clear buffers
        clearBuffers();

        // Recalc MVP if needed
        if (_mvpDirty)
        {
            calculateMVP();
        }

        // Process each face
        foreach (f; _modelData.faces)
        {
            renderFace(f);
        }

        // Blit color buffer to DC
        blitToDC();
    }

    void renderEdges()
    {
        if (_modelData.faces.length == 0) return;

        if (_mvpDirty)
        {
            calculateMVP();
        }

        // Collect all unique edges and draw them
        HPEN pen = CreatePen(PS_SOLID, 1, cast(COLORREF)0x00000000); // black
        HGDIOBJ oldPen = SelectObject(_dc, cast(HGDIOBJ)pen);

        foreach (f; _modelData.faces)
        {
            // Project all 3 vertices
            ScreenVertex[3] sv;
            for (int i = 0; i < 3; i++)
            {
                Vec3 v = _modelData.vertices[f.verts[i]];
                sv[i] = projectVertex(v);
            }

            // Draw triangle edges
            drawLine2D(sv[0].x, sv[0].y, sv[1].x, sv[1].y);
            drawLine2D(sv[1].x, sv[1].y, sv[2].x, sv[2].y);
            drawLine2D(sv[2].x, sv[2].y, sv[0].x, sv[0].y);
        }

        SelectObject(_dc, oldPen);
        DeleteObject(cast(HGDIOBJ)pen);
    }

    private:

    void recalcProjection()
    {
        if (_width <= 0 || _height <= 0) return;
        float aspect = _width / cast(float)_height;
        _projection = Mat4.perspective(_fov, aspect, _near, _far);
        _mvpDirty = true;
    }

    void calculateMVP()
    {
        Mat4 viewModel = _view * _model;
        _mvp = _projection * viewModel;
        _mvpDirty = false;
    }

    /// Clear depth and color buffers
    void clearBuffers()
    {
        // depth = far
        _depthBuffer[] = _far;
        // color = dark background
        _colorBuffer[] = 0xFF1A1A2E; // dark navy
    }

    /// Project a model-space vertex to screen space
    ScreenVertex projectVertex(Vec3 v) const
    {
        ScreenVertex sv;

        // Transform to clip space
        float w = _mvp.data[3]  * v.x + _mvp.data[7]  * v.y +
                  _mvp.data[11] * v.z + _mvp.data[15];
        if (abs(w) < 1e-10f) w = 1e-10f;

        float invW = 1.0f / w;
        float clipX = (_mvp.data[0] * v.x + _mvp.data[4] * v.y + _mvp.data[8]  * v.z + _mvp.data[12]) * invW;
        float clipY = (_mvp.data[1] * v.x + _mvp.data[5] * v.y + _mvp.data[9]  * v.z + _mvp.data[13]) * invW;
        float clipZ = (_mvp.data[2] * v.x + _mvp.data[6] * v.y + _mvp.data[10] * v.z + _mvp.data[14]) * invW;

        // Map to screen space
        sv.x = cast(int)((clipX + 1.0f) * 0.5f * _width);
        sv.y = cast(int)((1.0f - clipY) * 0.5f * _height); // flip Y
        sv.z = clipZ;
        sv.w = w;
        sv.worldPos = (_model * v).transform(_view);
        sv.normal = Vec3(0, 1, 0); // default normal (will be overwritten per-face)
        return sv;
    }

    /// Render a single face (triangle)
    void renderFace(Face f)
    {
        ScreenVertex[3] sv;
        for (int i = 0; i < 3; i++)
        {
            sv[i] = projectVertex(_modelData.vertices[f.verts[i]]);
        }

        // Back-face culling (simple check using screen-space area)
        int area = (sv[1].x - sv[0].x) * (sv[2].y - sv[0].y) -
                   (sv[2].x - sv[0].x) * (sv[1].y - sv[0].y);
        if (area <= 0) return; // back-face

        // Compute face normal for lighting
        Vec3 v0 = (_model * _modelData.vertices[f.verts[0]]).transform(_view);
        Vec3 v1 = (_model * _modelData.vertices[f.verts[1]]).transform(_view);
        Vec3 v2 = (_model * _modelData.vertices[f.verts[2]]).transform(_view);

        Vec3 faceNormal = (v1 - v0).cross(v2 - v0).normalized();

        // Simple diffuse lighting
        float ndotl = max(0.0f, faceNormal.dot(-_lightDir));
        Vec3 color;
        color.x = (_ambientColor.x + _diffuseColor.x * ndotl) * 255;
        color.y = (_ambientColor.y + _diffuseColor.y * ndotl) * 255;
        color.z = (_ambientColor.z + _diffuseColor.z * ndotl) * 255;

        // Clamp colors
        color.x = min(255.0f, max(0.0f, color.x));
        color.y = min(255.0f, max(0.0f, color.y));
        color.z = min(255.0f, max(0.0f, color.z));

        uint rgb = (cast(uint)color.x) |
                   (cast(uint)color.y << 8) |
                   (cast(uint)color.z << 16);

        if (_wireframe)
        {
            drawLine2D(sv[0].x, sv[0].y, sv[1].x, sv[1].y);
            drawLine2D(sv[1].x, sv[1].y, sv[2].x, sv[2].y);
            drawLine2D(sv[2].x, sv[2].y, sv[0].x, sv[0].y);
        }
        else
        {
            fillFlatTriangle(sv[0], sv[1], sv[2], rgb);
        }
    }

    /// Fill a flat-shaded triangle using scanline rasterization
    void fillFlatTriangle(ScreenVertex v0, ScreenVertex v1, ScreenVertex v2, uint color)
    {
        // Sort by Y (top to bottom)
        ScreenVertex tmp;
        if (v0.y > v1.y) { tmp = v0; v0 = v1; v1 = tmp; }
        if (v0.y > v2.y) { tmp = v0; v0 = v2; v2 = tmp; }
        if (v1.y > v2.y) { tmp = v1; v1 = v2; v2 = tmp; }

        int totalHeight = v2.y - v0.y + 1;
        if (totalHeight <= 0) return;

        for (int y = v0.y; y <= v2.y; y++)
        {
            if (y < 0 || y >= _height) continue;

            // Determine which segment we're in (top or bottom half)
            bool secondHalf = (v1.y >= 0 && y > v1.y) || v1.y < 0;

            ScreenVertex a, b;
            if (!secondHalf)
            {
                // Between v0 and v1 (shorter edge)
                a = interpolateVertex(v0, v2, y); // long edge
                b = interpolateVertex(v0, v1, y); // short edge
            }
            else
            {
                // Between v1 and v2 (shorter edge)
                a = interpolateVertex(v0, v2, y); // long edge
                b = interpolateVertex(v1, v2, y); // short edge
            }

            // Make sure a.x <= b.x
            if (a.x > b.x)
            {
                int tx = a.x; a.x = b.x; b.x = tx;
            }

            if (a.x < 0) a.x = 0;
            if (b.x >= _width) b.x = _width - 1;

            // Fill scanline
            for (int x = a.x; x <= b.x; x++)
            {
                int idx = y * _width + x;
                // Simple z-test
                float z = interpolateZ(a, b, a.x, b.x, x);
                if (z >= _near && z <= _depthBuffer[idx])
                {
                    _depthBuffer[idx] = z;
                    _colorBuffer[idx] = color;
                }
            }
        }
    }

    /// Linearly interpolate vertex attributes at Y
    ScreenVertex interpolateVertex(ScreenVertex a, ScreenVertex b, int y) const
    {
        ScreenVertex result;
        if (a.y == b.y)
        {
            result.x = a.x;
            result.z = a.z;
            return result;
        }

        float t = (y - a.y) / cast(float)(b.y - a.y);
        t = clamp(t, 0.0f, 1.0f);

        result.x = cast(int)(a.x + (b.x - a.x) * t);
        result.y = y;
        result.z = a.z + (b.z - a.z) * t;
        return result;
    }

    /// Interpolate Z across a scanline
    float interpolateZ(ScreenVertex a, ScreenVertex b, int ax, int bx, int x) const
    {
        if (bx == ax) return a.z;
        float t = (x - ax) / cast(float)(bx - ax);
        t = clamp(t, 0.0f, 1.0f);
        return a.z + (b.z - a.z) * t;
    }

    /// Draw a 2D line using GDI
    void drawLine2D(int x1, int y1, int x2, int y2)
    {
        MoveToEx(_dc, x1, y1, null);
        LineTo(_dc, x2, y2);
    }

    /// Blit the color buffer to the HDC
    void blitToDC()
    {
        BITMAPINFO bmi;
        bmi.bmiHeader.biSize   = BITMAPINFOHEADER.sizeof;
        bmi.bmiHeader.biWidth  = _width;
        bmi.bmiHeader.biHeight = -_height; // top-down
        bmi.bmiHeader.biPlanes = 1;
        bmi.bmiHeader.biBitCount = 32;
        bmi.bmiHeader.biCompression = BI_RGB;

        SetDIBitsToDevice(
            _dc,
            0, 0, _width, _height,
            0, 0, 0, _height,
            _colorBuffer.ptr,
            &bmi,
            DIB_RGB_COLORS
        );
    }
}
