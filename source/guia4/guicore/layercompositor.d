module guia4.guicore.layercompositor;

import guia4.guicore.control;
import guia4.guicore.layer;
import guia4.guicore.dirtyflag;
import guia4.platform_win32.win32defs;
import guia4.guicore.theme;
import guia4.utils.logger;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import std.algorithm;

/**
 * LayerCompositor - Layer合并引擎
 * 
 * 负责将多个控件的layer buffer按z轴顺序合并成最终输出
 * 
 * 核心概念：
 * - Camera：可视窗口，可以移动（scrollX, scrollY）
 * - 控件Buffer：每个控件独立buffer，内容不变（除非标记为脏）
 * - 滚动优化：滚动时复用buffer重叠部分，只渲染新暴露区域
 * 
 * 工作流程：
 * 1. Camera移动 → 计算滚动增量
 * 2. 复用旧buffer重叠部分 → 移动到新位置
 * 3. 只渲染新暴露区域 → 合并到输出buffer
 * 4. 输出到屏幕
 */
class LayerCompositor
{
    private HDC _outputDC;              // 输出buffer DC
    private HBITMAP _outputBmp;         // 输出buffer位图
    private HGDIOBJ _outputOldBmp;      // 原始位图
    private int _width;                 // 输出宽度（Camera宽度）
    private int _height;                // 输出高度（Camera高度）
    
    private HDC _historyDC;             // 历史buffer DC（用于差异对比）
    private HBITMAP _historyBmp;        // 历史buffer位图
    private HGDIOBJ _historyOldBmp;     // 原始位图
    
    private bool _initialized = false;
    private Control[] _sortedCache;  // 排序缓存，避免每次composite都dup+sort
    
    // ── Camera（可视窗口）────────────────────────────────────────
    private int _cameraX = 0;           // Camera在世界中的X位置
    private int _cameraY = 0;           // Camera在世界中的Y位置
    private int _lastCameraX = 0;       // 上一次Camera位置
    private int _lastCameraY = 0;       // 上一次Camera位置
    
    this()
    {
    }
    
    /**
     * 析构函数 — 仅标记资源为已销毁
     * 
     * 注意：不在析构函数中调用 GDI API（如 DeleteDC, DeleteObject），
     * 因为 GC 可能在 D 运行时的模块析构阶段析构对象，此时调用
     * GDI API 可能导致访问冲突。
     * 
     * 正确的做法是在程序退出前显式调用 destroy() 方法。
     */
    ~this()
    {
        // 仅标记为未初始化，不调用 GDI API
        _initialized = false;
    }
    
    /**
     * 初始化合并引擎
     * 
     * Params:
     *   width = 输出宽度
     *   height = 输出高度
     *   refDC = 参考DC（用于创建兼容位图）
     */
    void init(int width, int height, HDC refDC)
    {
        // 释放旧的buffer
        destroy();
        
        _width = width;
        _height = height;
        
        // 创建输出buffer
        _outputDC = CreateCompatibleDC(refDC);
        _outputBmp = CreateCompatibleBitmap(refDC, width, height);
        _outputOldBmp = SelectObject(_outputDC, cast(HGDIOBJ)_outputBmp);
        
        // 创建历史buffer
        _historyDC = CreateCompatibleDC(refDC);
        _historyBmp = CreateCompatibleBitmap(refDC, width, height);
        _historyOldBmp = SelectObject(_historyDC, cast(HGDIOBJ)_historyBmp);
        
        // 填充白色背景
        RECT rect = {0, 0, width, height};
        HBRUSH brush = CreateSolidBrush(Theme.crBackground());
        FillRect(_outputDC, &rect, brush);
        FillRect(_historyDC, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);
        
        _initialized = true;
    }
    
    /// 销毁资源
    void destroy()
    {
        if (_outputDC.Value !is null)
        {
            if (_outputOldBmp.Value !is null)
                SelectObject(_outputDC, _outputOldBmp);
            if (_outputBmp.Value !is null)
                DeleteObject(cast(HGDIOBJ)_outputBmp);
            DeleteDC(_outputDC);
            _outputDC = HDC.init;
            _outputBmp = HBITMAP.init;
            _outputOldBmp = HGDIOBJ.init;
        }

        if (_historyDC.Value !is null)
        {
            if (_historyOldBmp.Value !is null)
                SelectObject(_historyDC, _historyOldBmp);
            if (_historyBmp.Value !is null)
                DeleteObject(cast(HGDIOBJ)_historyBmp);
            DeleteDC(_historyDC);
            _historyDC = HDC.init;
            _historyBmp = HBITMAP.init;
            _historyOldBmp = HGDIOBJ.init;
        }

        _initialized = false;
    }
    
    /**
     * 合成所有layer到输出buffer
     * 
     * Params:
     *   controls = 需要渲染的控件列表
     *   dirtyOnly = 是否只渲染脏控件
     *   clearBuffer = 是否清空输出buffer（滚动时不清空，保留复用内容）
     * 
     * Returns: 输出buffer DC
     */
    HDC composite(Control[] controls, bool dirtyOnly = false, bool clearBuffer = true)
    {
        if (!_initialized)
            return _outputDC;
        
        // 1. 清空输出buffer（如果需要）
        if (clearBuffer)
        {
            RECT rect = {0, 0, _width, _height};
            HBRUSH brush = CreateSolidBrush(Theme.crBackground());
            FillRect(_outputDC, &rect, brush);
            DeleteObject(cast(HGDIOBJ)brush);
        }
        
        // 2. 按layer排序（z轴顺序，低layer先渲染）
        // 复用缓存，避免每次dup+sort产生GC压力
        if (_sortedCache.length != controls.length)
            _sortedCache = new Control[](controls.length);
        _sortedCache[] = controls[];
        _sortedCache[].sort!((a, b) => cast(int)a.layer() < cast(int)b.layer());
        
        // 3. 依次合成各layer
        foreach (ctrl; _sortedCache[0 .. controls.length])
        {
            if (!ctrl.visible())
                continue;
            
            compositeLayer(ctrl, dirtyOnly);
        }
        
        return _outputDC;
    }
    
    /**
     * 合成单个layer
     * 
     * Params:
     *   ctrl = 要合成的控件
     *   dirtyOnly = 是否只渲染脏控件
     */
    private void compositeLayer(Control ctrl, bool dirtyOnly)
    {
        logTrace("compositeLayer: ctrl=", typeid(ctrl).name, " position=(", ctrl.position().x(), ",", ctrl.position().y(), ") size=(", ctrl.width(), ",", ctrl.height(), ")");
        
        // 确保控件布局已执行
        ctrl.ensureLayout();
        
        // ── Layer-based渲染核心逻辑 ──
        // 每个控件有独立的layer buffer（缓存控件内容，相对于控件自身坐标系）
        // Camera移动时，只需将layer buffer合成到新的屏幕位置
        // 不从历史buffer复制（历史buffer用于差异对比，不用于滚动）
        
        // 计算控件相对于Camera的位置
        // 控件世界位置 - Camera位置 = 屏幕位置
        int screenX = ctrl.position().x() - _cameraX;
        int screenY = ctrl.position().y() - _cameraY;
        
        // 检查控件是否在Camera可见区域内
        if (screenX + ctrl.width() < 0 || screenX >= _width ||
            screenY + ctrl.height() < 0 || screenY >= _height)
        {
            // 控件不在可见区域，跳过
            return;
        }
        
        // 检查控件是否需要更新layer buffer
        bool needUpdateBuffer = ctrl.isDirty();
        
        if (ctrl.hasLayerBuffer())
        {
            // 控件有独立的layer buffer
            if (needUpdateBuffer)
            {
                // 控件有脏标记，先更新layer buffer
                ctrl.updateLayerBuffer();
            }
            
            // 检查buffer是否有效（可能updateLayerBuffer因为buffer未初始化而失败）
            if (!ctrl.hasLayerBuffer())
            {
                // Buffer未初始化，调用renderWithGDI来初始化
                // 使用输出DC作为参考DC
                SaveDC(_outputDC);
                IntersectClipRect(_outputDC, screenX, screenY, 
                                 screenX + ctrl.width(), screenY + ctrl.height());
                ctrl.renderWithGDI(_outputDC.Value);
                RestoreDC(_outputDC, -1);
            }
            else
            {
                // 将控件的layer buffer合成到输出buffer
                // 使用相对于Camera的屏幕位置
                BitBlt(_outputDC, screenX, screenY, ctrl.width(), ctrl.height(),
                       ctrl.layerBufferDC(), 0, 0, SRCCOPY);
            }
            
            // 控件有layer buffer，不递归渲染子控件
            // 子控件的内容已经包含在layer buffer中
        }
        else
        {
            // 控件没有独立buffer，直接渲染到输出buffer
            // dirtyOnly 模式：只渲染自身如果它是脏的，但始终递归子控件
            bool renderSelf = !dirtyOnly || ctrl.isDirty();
            
            if (renderSelf)
            {
                SaveDC(_outputDC);

                // 设置裁剪区域（相对于Camera）
                IntersectClipRect(_outputDC, screenX, screenY,
                                 screenX + ctrl.width(), screenY + ctrl.height());

                // 偏移视口到控件屏幕位置，使控件使用相对坐标 (0,0) 绘制
                POINT oldOrigin;
                OffsetViewportOrgEx(_outputDC, screenX, screenY, &oldOrigin);

                // 渲染控件
                ctrl.renderWithGDI(_outputDC.Value);

                SetViewportOrgEx(_outputDC, oldOrigin.x, oldOrigin.y, null);
                RestoreDC(_outputDC, -1);
            }
            
            // 始终递归子控件 — 每个子控件独立检查自己的脏标记
            if (!ctrl.rendersChildren())
            {
                foreach (child; ctrl.children())
                {
                    compositeLayer(child, dirtyOnly);
                }
            }
        }
    }
    
    /**
     * 计算差异区域（新buffer vs 历史buffer）
     * 
     * 简化实现：返回整个区域
     * TODO: 实现像素级差异对比
     * 
     * Returns: 差异区域的矩形列表
     */
    RECT[] computeDiff()
    {
        // 简化实现：返回整个区域
        // 完整实现需要逐像素对比两个buffer
        RECT diff;
        diff.left = 0;
        diff.top = 0;
        diff.right = _width;
        diff.bottom = _height;
        
        return [diff];
    }
    
    /**
     * 输出差异部分到屏幕
     * 
     * Params:
     *   screenDC = 屏幕DC
     *   diffRects = 差异区域列表
     */
    void outputDiff(HDC screenDC, RECT[] diffRects)
    {
        foreach (rect; diffRects)
        {
            int w = rect.right - rect.left;
            int h = rect.bottom - rect.top;
            
            // 只输出差异区域
            BitBlt(screenDC, rect.left, rect.top, w, h,
                   _outputDC, rect.left, rect.top, SRCCOPY);
        }
    }
    
    /**
     * 更新历史buffer（将当前输出buffer复制到历史buffer）
     */
    void updateHistory()
    {
        BitBlt(_historyDC, 0, 0, _width, _height,
               _outputDC, 0, 0, SRCCOPY);
    }
    
    // ── Camera管理 ───────────────────────────────────────────
    
    /**
     * 移动Camera（滚动）
     * 
     * Camera移动时：
     * 1. 计算滚动增量
     * 2. 复用旧buffer的重叠部分
     * 3. 只渲染新暴露区域
     * 
     * Params:
     *   x = Camera新的X位置
     *   y = Camera新的Y位置
     * 
     * Returns: 是否有滚动（需要更新buffer）
     */
    bool moveCamera(int x, int y)
    {
        int deltaX = x - _cameraX;
        int deltaY = y - _cameraY;
        
        if (deltaX == 0 && deltaY == 0)
            return false;  // 没有移动
        
        // 保存旧位置
        _lastCameraX = _cameraX;
        _lastCameraY = _cameraY;
        
        // 更新Camera位置
        _cameraX = x;
        _cameraY = y;
        
        // 复用旧buffer的重叠部分
        reuseBufferOverlap(deltaX, deltaY);
        
        return true;
    }
    
    /**
     * 复用buffer重叠部分
     * 
     * 滚动时，大部分内容是重叠的，可以复用：
     * - 向右滚动10像素：左边10像素新暴露，右边复用
     * - 向下滚动10像素：上边10像素新暴露，下边复用
     */
    private void reuseBufferOverlap(int deltaX, int deltaY)
    {
        // 计算重叠区域
        int overlapX = _width - (deltaX > 0 ? deltaX : -deltaX);
        int overlapY = _height - (deltaY > 0 ? deltaY : -deltaY);
        
        if (overlapX <= 0 || overlapY <= 0)
        {
            // 没有重叠，整个区域都需要重新渲染
            return;
        }
        
        // 计算重叠区域的源位置和目标位置
        int srcX, srcY, dstX, dstY;
        
        if (deltaX > 0)
        {
            // 向右滚动：从左边复制
            srcX = 0;
            dstX = deltaX;
        }
        else
        {
            // 向左滚动：从右边复制
            srcX = -deltaX;
            dstX = 0;
        }
        
        if (deltaY > 0)
        {
            // 向下滚动：从上边复制
            srcY = 0;
            dstY = deltaY;
        }
        else
        {
            // 向上滚动：从下边复制
            srcY = -deltaY;
            dstY = 0;
        }
        
        // 从历史buffer复制重叠部分到输出buffer
        BitBlt(_outputDC, dstX, dstY, overlapX, overlapY,
               _historyDC, srcX, srcY, SRCCOPY);
    }
    
    /**
     * 获取需要渲染的新暴露区域
     * 
     * Returns: 需要渲染的矩形列表
     */
    RECT[] getExposedRegions()
    {
        int deltaX = _cameraX - _lastCameraX;
        int deltaY = _cameraY - _lastCameraY;
        
        RECT[] regions;
        
        // X方向新暴露的区域
        if (deltaX > 0)
        {
            // 向右滚动：左边新暴露
            RECT r;
            r.left = 0;
            r.top = 0;
            r.right = deltaX;
            r.bottom = _height;
            regions ~= r;
        }
        else if (deltaX < 0)
        {
            // 向左滚动：右边新暴露
            RECT r;
            r.left = _width + deltaX;
            r.top = 0;
            r.right = _width;
            r.bottom = _height;
            regions ~= r;
        }
        
        // Y方向新暴露的区域
        if (deltaY > 0)
        {
            // 向下滚动：上边新暴露
            RECT r;
            r.left = 0;
            r.top = 0;
            r.right = _width;
            r.bottom = deltaY;
            regions ~= r;
        }
        else if (deltaY < 0)
        {
            // 向上滚动：下边新暴露
            RECT r;
            r.left = 0;
            r.top = _height + deltaY;
            r.right = _width;
            r.bottom = _height;
            regions ~= r;
        }
        
        return regions;
    }
    
    /// 获取当前Camera位置
    int cameraX() const @property { return _cameraX; }
    int cameraY() const @property { return _cameraY; }
    
    /// 获取历史buffer DC
    HDC historyDC() @property { return _historyDC; }
    
    /**
     * 完整的渲染流程
     * 
     * Params:
     *   screenDC = 屏幕DC
     *   controls = 需要渲染的控件列表
     *   hasDirty = 是否有脏控件
     */
    void render(HDC screenDC, Control[] controls, bool hasDirty)
    {
        // 计算Camera移动
        bool cameraMoved = (_cameraX != _lastCameraX || _cameraY != _lastCameraY);
        
        if (!hasDirty && !cameraMoved)
        {
            // 没有脏标记且Camera没移动，直接输出历史buffer
            BitBlt(screenDC, 0, 0, _width, _height, _historyDC, 0, 0, SRCCOPY);
            return;
        }
        
        // ── Layer-based渲染核心逻辑 ──
        // 每个控件有独立的layer buffer（缓存控件内容）
        // Camera移动时，只需按新位置重新合成layer buffer
        // 不需要从历史buffer复用（历史buffer用于差异对比，不用于滚动）
        
        if (cameraMoved)
        {
            // Camera移动：重新合成所有layer buffer到新位置
            // 清空输出buffer，按新Camera位置重新合成
            composite(controls, false, true);
        }
        else if (hasDirty)
        {
            // 只有脏控件，Camera没移动
            // 只渲染脏控件（不清空buffer，保留非脏控件内容）
            composite(controls, true, false);
        }
        
        // 输出到屏幕
        BitBlt(screenDC, 0, 0, _width, _height, _outputDC, 0, 0, SRCCOPY);
        
        // 更新历史
        updateHistory();
        
        // 更新Camera位置记录
        _lastCameraX = _cameraX;
        _lastCameraY = _cameraY;
    }
    
    /**
     * 渲染指定区域的控件
     */
    private void renderRegion(Control[] controls, RECT region)
    {
        // 先填充新暴露区域的背景
        HBRUSH brush = CreateSolidBrush(Theme.crBackground());
        FillRect(_outputDC, &region, brush);
        DeleteObject(cast(HGDIOBJ)brush);
        
        SaveDC(_outputDC);
        
        // 设置裁剪区域
        IntersectClipRect(_outputDC, region.left, region.top, region.right, region.bottom);
        
        // 渲染在该区域内的控件
        foreach (ctrl; controls)
        {
            if (!ctrl.visible())
                continue;
            
            // 计算控件相对于Camera的位置
            int ctrlX = ctrl.position().x() - _cameraX;
            int ctrlY = ctrl.position().y() - _cameraY;
            
            // 检查控件是否与区域相交
            if (ctrlX + ctrl.width() >= region.left && ctrlX < region.right &&
                ctrlY + ctrl.height() >= region.top && ctrlY < region.bottom)
            {
                // 渲染控件
                compositeLayer(ctrl, false);
            }
        }
        
        RestoreDC(_outputDC, -1);
    }
}