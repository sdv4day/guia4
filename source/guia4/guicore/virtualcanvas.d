module guia4.guicore.virtualcanvas;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.utils.logger;
import guia4.platform_win32.win32defs;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import std.algorithm;

/**
 * VirtualCanvas - 虚拟画布
 * 
 * 使用离屏缓冲区和tile-based脏标记实现高效渲染：
 * 1. 大的虚拟画布缓冲整个内容区域
 * 2. Tile-based脏标记实现像素级更新
 * 3. 显示时只需BitBlt可视区域
 * 
 * 性能特点：
 * - 滚动：只需移动可视窗口偏移，无需重绘
 * - 局部更新：只重绘脏tile，其他区域不受影响
 * - 内存占用：虚拟画布大小 * 4字节（ARGB）
 */
class VirtualCanvas : Control
{
    // ── 虚拟画布 ────────────────────────────────────────────────
    private HDC _bufferDC;                 // 离屏缓冲DC
    private HBITMAP _bufferBmp;            // 离屏位图
    private HGDIOBJ _oldBmp;               // 原始位图（用于恢复）
    private int _canvasWidth = 0;          // 虚拟画布宽度
    private int _canvasHeight = 0;         // 虚拟画布高度
    
    // ── Tile-based脏标记 ────────────────────────────────────────
    private int _tileSize = 32;             // 每个tile的大小（32x32像素）
    private bool[] _dirtyTiles;             // 脏tile标记数组
    private int _tilesX = 0;                // X方向tile数量
    private int _tilesY = 0;                // Y方向tile数量
    private bool _allDirty = true;          // 全局脏标记（初始化时）
    
    // ── 可视窗口 ────────────────────────────────────────────────
    private int _viewX = 0;                 // 可视窗口X偏移
    private int _viewY = 0;                 // 可视窗口Y偏移
    
    // ── 统计信息 ────────────────────────────────────────────────
    private int _dirtyTileCount = 0;        // 当前脏tile数量
    
    this(Control parent)
    {
        super(parent);
        logTrace("VirtualCanvas.ctor()");
    }
    
    /// 析构函数 - 释放GDI资源
    ~this()
    {
        destroyBuffer();
    }
    
    // ── 属性 ────────────────────────────────────────────────────
    
    /// 虚拟画布宽度
    int canvasWidth() const @property { return _canvasWidth; }
    
    /// 虚拟画布高度
    int canvasHeight() const @property { return _canvasHeight; }
    
    /// 可视窗口X偏移
    int viewX() const @property { return _viewX; }
    void viewX(int v) @property
    {
        _viewX = v.clamp(0, _canvasWidth - width);
        markDirty(DirtyBits.Visual);
    }
    
    /// 可视窗口Y偏移
    int viewY() const @property { return _viewY; }
    void viewY(int v) @property
    {
        _viewY = v.clamp(0, _canvasHeight - height);
        markDirty(DirtyBits.Visual);
    }
    
    /// Tile大小
    int tileSize() const @property { return _tileSize; }
    
    /// 脏tile数量
    int dirtyTileCount() const @property { return _dirtyTileCount; }
    
    // ── 初始化和资源管理 ────────────────────────────────────────
    
    /**
     * 初始化虚拟画布
     * 
     * Params:
     *   canvasW = 虚拟画布宽度
     *   canvasH = 虚拟画布高度
     *   hdc = 参考DC（用于创建兼容位图）
     */
    void initCanvas(int canvasW, int canvasH, HDC hdc)
    {
        logTrace("VirtualCanvas.initCanvas(canvasW=", canvasW, ", canvasH=", canvasH, ")");
        
        // 释放旧的缓冲区
        destroyBuffer();
        
        // 设置虚拟画布大小
        _canvasWidth = canvasW;
        _canvasHeight = canvasH;
        
        // 计算tile数量
        _tilesX = (canvasW + _tileSize - 1) / _tileSize;
        _tilesY = (canvasH + _tileSize - 1) / _tileSize;
        
        // 初始化脏标记数组
        _dirtyTiles = new bool[_tilesX * _tilesY];
        _allDirty = true;
        _dirtyTileCount = _tilesX * _tilesY;
        
        // 创建离屏缓冲区
        _bufferDC = CreateCompatibleDC(hdc);
        _bufferBmp = CreateCompatibleBitmap(hdc, canvasW, canvasH);
        _oldBmp = SelectObject(_bufferDC, cast(HGDIOBJ)_bufferBmp);
        
        // 填充白色背景
        RECT rect = {0, 0, canvasW, canvasH};
        HBRUSH brush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(_bufferDC, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);
        
        logInfo("VirtualCanvas initialized: ", canvasW, "x", canvasH, 
                ", tiles: ", _tilesX, "x", _tilesY, 
                ", memory: ", (canvasW * canvasH * 4 / 1024 / 1024), " MB");
    }
    
    /// 销毁缓冲区
    private void destroyBuffer()
    {
        if (_bufferDC.Value !is null)
        {
            if (_oldBmp.Value !is null)
            {
                SelectObject(_bufferDC, _oldBmp);
            }
            if (_bufferBmp.Value !is null)
            {
                DeleteObject(cast(HGDIOBJ)_bufferBmp);
            }
            DeleteDC(_bufferDC);
        }
        _dirtyTiles = null;
    }
    
    // ── 脏标记管理 ──────────────────────────────────────────────
    
    /**
     * 标记矩形区域为脏
     * 
     * Params:
     *   x = 区域左上角X（虚拟画布坐标）
     *   y = 区域左上角Y（虚拟画布坐标）
     *   w = 区域宽度
     *   h = 区域高度
     */
    void markDirtyRect(int x, int y, int w, int h)
    {
        if (_allDirty)
            return;  // 已经全部脏了
        
        // 计算覆盖的tile范围
        int tileX1 = x / _tileSize;
        int tileY1 = y / _tileSize;
        int tileX2 = (x + w - 1) / _tileSize;
        int tileY2 = (y + h - 1) / _tileSize;
        
        // 限制范围
        tileX1 = tileX1.clamp(0, _tilesX - 1);
        tileY1 = tileY1.clamp(0, _tilesY - 1);
        tileX2 = tileX2.clamp(0, _tilesX - 1);
        tileY2 = tileY2.clamp(0, _tilesY - 1);
        
        // 标记脏tile
        for (int ty = tileY1; ty <= tileY2; ty++)
        {
            for (int tx = tileX1; tx <= tileX2; tx++)
            {
                int idx = ty * _tilesX + tx;
                if (!_dirtyTiles[idx])
                {
                    _dirtyTiles[idx] = true;
                    _dirtyTileCount++;
                }
            }
        }
    }
    
    /// 标记整个画布为脏
    void markAllDirty()
    {
        _allDirty = true;
        _dirtyTileCount = _tilesX * _tilesY;
    }
    
    /// 清除所有脏标记
    void clearAllDirty()
    {
        _allDirty = false;
        _dirtyTileCount = 0;
        for (int i = 0; i < _dirtyTiles.length; i++)
            _dirtyTiles[i] = false;
    }
    
    /// 检查是否有脏区域
    bool hasDirtyTiles() const
    {
        return _allDirty || _dirtyTileCount > 0;
    }
    
    /// 检查指定tile是否脏
    bool isTileDirty(int tileX, int tileY) const
    {
        if (_allDirty)
            return true;
        if (tileX < 0 || tileX >= _tilesX || tileY < 0 || tileY >= _tilesY)
            return false;
        return _dirtyTiles[tileY * _tilesX + tileX];
    }
    
    // ── 渲染 ────────────────────────────────────────────────────
    
    /**
     * 渲染脏tile到虚拟画布
     * 
     * 注意：这个函数只负责调用子控件的渲染，实际的渲染逻辑
     * 应该在子类或外部实现。
     */
    void renderDirtyTiles()
    {
        if (!hasDirtyTiles())
            return;  // 没有脏区域
        
        logTrace("VirtualCanvas.renderDirtyTiles() - dirty tiles: ", _dirtyTileCount);
        
        if (_allDirty)
        {
            // 全部重绘
            renderAllToBuffer();
            clearAllDirty();
        }
        else
        {
            // 只重绘脏tile
            for (int ty = 0; ty < _tilesY; ty++)
            {
                for (int tx = 0; tx < _tilesX; tx++)
                {
                    int idx = ty * _tilesX + tx;
                    if (_dirtyTiles[idx])
                    {
                        // 渲染这个tile
                        int x = tx * _tileSize;
                        int y = ty * _tileSize;
                        renderTileToBuffer(x, y, _tileSize, _tileSize);
                        _dirtyTiles[idx] = false;
                    }
                }
            }
            _dirtyTileCount = 0;
        }
    }
    
    /**
     * 将虚拟画布的可视区域呈现到屏幕
     * 
     * Params:
     *   screenDC = 屏幕DC
     */
    void present(HDC screenDC)
    {
        if (_bufferDC.Value is null)
            return;
        
        // BitBlt可视区域到屏幕
        BitBlt(screenDC, 0, 0, width, height,
               _bufferDC, _viewX, _viewY, SRCCOPY);
    }
    
    /**
     * 渲染所有内容到虚拟画布
     * 
     * 子类应该重写这个方法来实现实际的渲染逻辑。
     */
    protected void renderAllToBuffer()
    {
        logTrace("VirtualCanvas.renderAllToBuffer() - children: ", children().length);
        
        // 默认实现：填充白色背景
        RECT rect = {0, 0, _canvasWidth, _canvasHeight};
        HBRUSH brush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(_bufferDC, &rect, brush);
        DeleteObject(cast(HGDIOBJ)brush);
        
        // 渲染子控件
        foreach (child; children())
        {
            if (child.visible())
            {
                logTrace("  Rendering child at (", child.position().x(), ",", child.position().y(), ")");
                child.renderWithGDI(_bufferDC.Value);
            }
        }
    }
    
    /**
     * 渲染单个tile到虚拟画布
     * 
     * 子类可以重写这个方法来优化tile渲染。
     */
    protected void renderTileToBuffer(int x, int y, int w, int h)
    {
        // 设置裁剪区域
        SaveDC(_bufferDC);
        RECT clipRect = {x, y, x + w, y + h};
        IntersectClipRect(_bufferDC, x, y, x + w, y + h);
        
        // 填充背景
        HBRUSH brush = CreateSolidBrush(cast(COLORREF)0x00FFFFFF);
        FillRect(_bufferDC, &clipRect, brush);
        DeleteObject(cast(HGDIOBJ)brush);
        
        // 渲染子控件（需要检查是否与tile相交）
        foreach (child; children())
        {
            if (child.visible())
            {
                // 简单检查：如果控件与tile相交，则渲染
                if (child.position().x() < x + w && child.position().x() + child.width() > x &&
                    child.position().y() < y + h && child.position().y() + child.height() > y)
                {
                    child.renderWithGDI(_bufferDC.Value);
                }
            }
        }
        
        RestoreDC(_bufferDC, -1);
    }
    
    // ── Control重写 ─────────────────────────────────────────────
    
    override void renderWithGDI(void* hdc_)
    {
        auto hdc = cast(HDC)hdc_;
        
        logTrace("VirtualCanvas.renderWithGDI() - allDirty=", _allDirty, 
                 ", dirtyCount=", _dirtyTileCount, 
                 ", bufferDC=", _bufferDC.Value !is null,
                 ", children=", children().length);
        
        // 确保布局已执行
        ensureLayout();
        
        // 1. 渲染脏tile到虚拟画布
        renderDirtyTiles();
        
        // 2. 将可视区域呈现到屏幕
        present(hdc);
    }
    
    // ── 滚动 ────────────────────────────────────────────────────
    
    /**
     * 滚动可视窗口
     * 
     * Params:
     *   dx = X方向滚动量（正数向右）
     *   dy = Y方向滚动量（正数向下）
     */
    void scroll(int dx, int dy)
    {
        int newX = (_viewX + dx).clamp(0, _canvasWidth - width);
        int newY = (_viewY + dy).clamp(0, _canvasHeight - height);
        
        if (newX != _viewX || newY != _viewY)
        {
            _viewX = newX;
            _viewY = newY;
            // 滚动不需要标记脏，只需移动可视窗口
            markDirty(DirtyBits.Visual);
        }
    }
    
    /// 滚动到指定位置
    void scrollTo(int x, int y)
    {
        viewX = x;
        viewY = y;
    }
}