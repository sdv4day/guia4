module guia4.guicore.layout;

import guia4.guicore.control;
import guia4.guicore.position;

/**
 * ILayout — 布局管理器接口
 */
interface ILayout
{
    void layout(Control parent);
}

/**
 * LayoutDefaults — 布局默认值常量
 * 
 * 消除魔数,统一管理布局默认参数
 */
enum LayoutDefaults
{
    defaultSpacing = 4,
    defaultPadding = 4,
    defaultCellWidth = 100,
    defaultCellHeight = 30,
}

/**
 * BaseLayout — 布局管理器基类
 *
 * 提取公共逻辑,消除VerticalLayout、HorizontalLayout、GridLayout的重复代码
 */
abstract class BaseLayout : ILayout
{
    protected int _spacing = LayoutDefaults.defaultSpacing;
    protected int _padding = LayoutDefaults.defaultPadding;
    
    this(int spacing = LayoutDefaults.defaultSpacing, int padding = LayoutDefaults.defaultPadding)
    {
        _spacing = spacing;
        _padding = padding;
    }
    
    // ── 公共辅助方法 ─────────────────────────────────────
    
    /**
     * 检查控件是否应该跳过布局
     * 
     * Params:
     *   child = 要检查的控件
     * 
     * Returns: true表示应该跳过该控件
     */
    protected final bool shouldSkipChild(Control child) nothrow @nogc
    {
        return !child.visible() || 
               child.isAbsolutePosition() || 
               child.isFixedPosition();
    }
    
    /**
     * 应用位置到控件
     * 
     * 根据定位模式(Static/Relative)设置控件位置
     * 
     * Params:
     *   child = 目标控件
     *   normalX = 正常X坐标
     *   normalY = 正常Y坐标
     */
    protected final void applyPosition(Control child, int normalX, int normalY) nothrow @nogc
    {
        if (child.isRelativePosition())
        {
            // Relative定位：应用x/y偏移
            child.setXY(normalX + child.position().x(), normalY + child.position().y());
        }
        else
        {
            // Static定位：直接设置位置
            child.setXY(normalX, normalY);
        }
    }
    
    /**
     * 从祖先容器推断可用尺寸
     * 
     * 当父容器没有设置尺寸时,向上查找祖先容器获取可用尺寸
     * 
     * Params:
     *   parent = 起始控件
     *   getDimension = 获取尺寸的函数指针
     * 
     * Returns: 可用尺寸,如果没有找到则返回0
     */
    protected final int inferAvailableDimension(Control parent, 
                                                int function(Control) nothrow @nogc getDimension) 
                                                nothrow @nogc
    {
        Control cur = parent.parent();
        while (cur !is null)
        {
            int dim = getDimension(cur);
            if (dim > 0)
                return dim;
            cur = cur.parent();
        }
        return 0;
    }
    
    /**
     * 自动设置父容器尺寸
     * 
     * 如果父容器没有设置尺寸,根据内容自动设置
     * 
     * Params:
     *   parent = 父容器
     *   contentWidth = 内容宽度
     *   contentHeight = 内容高度
     */
    protected final void autoSetParentSize(Control parent, int contentWidth, int contentHeight) nothrow @nogc
    {
        if (parent.width() == 0 && contentWidth > 0)
            parent.width(contentWidth + _padding * 2);
        
        if (parent.height() == 0 && contentHeight > 0)
            parent.height(contentHeight + _padding * 2);
    }
    
    // ── 属性访问器 ─────────────────────────────────────
    
    int spacing() const nothrow @nogc @property { return _spacing; }
    int padding() const nothrow @nogc @property { return _padding; }
}

/**
 * AbsoluteLayout — 绝对布局
 * 
 * 不进行任何布局,控件使用绝对定位
 */
class AbsoluteLayout : ILayout
{
    void layout(Control parent) {}
}

/**
 * VerticalLayout — 垂直布局
 * 
 * 子控件从上到下垂直排列
 */
class VerticalLayout : BaseLayout
{
    this(int spacing = LayoutDefaults.defaultSpacing, int padding = LayoutDefaults.defaultPadding)
    {
        super(spacing, padding);
    }
    
    void layout(Control parent)
    {
        int y = _padding;
        int maxWidth = 0;
        
        // 确定可用宽度：优先使用父容器宽度,否则从祖先推断
        int availableWidth = parent.width() > 0 ? parent.width() : 
                             inferAvailableDimension(parent, function int(Control c) nothrow @nogc => c.width());
        
        foreach (child; parent.children())
        {
            if (shouldSkipChild(child)) continue;
            
            // 计算正常位置
            int normalX = _padding;
            int normalY = y;
            
            applyPosition(child, normalX, normalY);
            
            // 子控件宽度处理
            if ((child.autoWidth || child.hAlign == HAlign.Stretch) && 
                availableWidth > 0 && child.layout() is null)
            {
                child.setLayoutWidth(availableWidth - _padding * 2);
            }
            
            y += child.height() + _spacing;
            
            // 累计最大宽度
            if (child.width() > maxWidth)
                maxWidth = child.width();
        }
        
        // 自动设置父容器尺寸
        autoSetParentSize(parent, maxWidth, y - _spacing);
    }
}

/**
 * HorizontalLayout — 水平布局
 * 
 * 子控件从左到右水平排列
 */
class HorizontalLayout : BaseLayout
{
    this(int spacing = LayoutDefaults.defaultSpacing, int padding = LayoutDefaults.defaultPadding)
    {
        super(spacing, padding);
    }
    
    void layout(Control parent)
    {
        int x = _padding;
        int maxHeight = 0;
        
        // 确定可用高度：优先使用父容器高度,否则从祖先推断
        int availableHeight = parent.height() > 0 ? parent.height() : 
                              inferAvailableDimension(parent, function int(Control c) nothrow @nogc => c.height());
        
        foreach (child; parent.children())
        {
            if (shouldSkipChild(child)) continue;
            
            // 计算正常位置
            int normalX = x;
            int normalY = _padding;
            
            applyPosition(child, normalX, normalY);
            
            // 子控件高度处理
            if ((child.autoHeight || child.vAlign == VAlign.Stretch) && 
                availableHeight > 0 && child.layout() is null)
            {
                child.setLayoutHeight(availableHeight - _padding * 2);
            }
            
            x += child.width() + _spacing;
            
            // 累计最大高度
            if (child.height() > maxHeight)
                maxHeight = child.height();
        }
        
        // 自动设置父容器尺寸
        autoSetParentSize(parent, x - _spacing, maxHeight);
    }
}

/**
 * GridLayout — 网格布局
 * 
 * 子控件按行列网格排列
 */
class GridLayout : BaseLayout
{
    private int _rows;
    private int _cols;
    private int _hSpacing;
    private int _vSpacing;
    
    this(int rows, int cols, 
         int hSpacing = LayoutDefaults.defaultSpacing, 
         int vSpacing = LayoutDefaults.defaultSpacing, 
         int padding = LayoutDefaults.defaultPadding)
    {
        super(LayoutDefaults.defaultSpacing, padding);
        _rows = rows;
        _cols = cols;
        _hSpacing = hSpacing;
        _vSpacing = vSpacing;
    }
    
    void layout(Control parent)
    {
        auto children = parent.children();
        
        // 计算单元格尺寸
        int cellWidth = 0;
        int cellHeight = 0;
        
        if (parent.width() > 0 && parent.height() > 0)
        {
            // 父容器有尺寸,按比例分配
            cellWidth = (parent.width() - _padding * 2 - (_cols - 1) * _hSpacing) / _cols;
            cellHeight = (parent.height() - _padding * 2 - (_rows - 1) * _vSpacing) / _rows;
        }
        else
        {
            // 父容器无尺寸,使用默认尺寸
            cellWidth = LayoutDefaults.defaultCellWidth;
            cellHeight = LayoutDefaults.defaultCellHeight;
        }
        
        // 用于跳过Absolute/Fixed定位的控件
        size_t layoutIndex = 0;
        
        foreach (i, child; children)
        {
            if (shouldSkipChild(child)) continue;
            
            int row = cast(int)(layoutIndex / _cols);
            int col = cast(int)(layoutIndex % _cols);
            
            // 计算正常位置
            int normalX = _padding + col * (cellWidth + _hSpacing);
            int normalY = _padding + row * (cellHeight + _vSpacing);
            
            applyPosition(child, normalX, normalY);
            
            child.setLayoutWidth(cellWidth);
            child.setLayoutHeight(cellHeight);
            
            layoutIndex++;
        }
        
        // 自动设置父容器尺寸
        if (parent.width() == 0)
            parent.width(_padding * 2 + _cols * cellWidth + (_cols - 1) * _hSpacing);
        
        if (parent.height() == 0)
            parent.height(_padding * 2 + _rows * cellHeight + (_rows - 1) * _vSpacing);
    }
    
    int rows() const nothrow @nogc @property { return _rows; }
    int cols() const nothrow @nogc @property { return _cols; }
}
