module guia4.guicore.layout;

import guia4.guicore.control;
import guia4.guicore.position;


interface ILayout
{
    void layout(Control parent);
}

class AbsoluteLayout : ILayout
{
    void layout(Control parent) {}
}

class VerticalLayout : ILayout
{
    private int _spacing = 4;
    private int _padding = 4;
    
    this(int spacing = 4, int padding = 4)
    {
        _spacing = spacing;
        _padding = padding;
    }
    
    /// 从祖先容器推断可用宽度
    private int inferAvailableWidth(Control parent)
    {
        Control cur = parent.parent();
        while (cur !is null)
        {
            if (cur.width() > 0)
                return cur.width();
            cur = cur.parent();
        }
        return 0;
    }
    
    void layout(Control parent)
    {
        int y = _padding;
        int maxWidth = 0;
        
        // 确定可用宽度：优先使用父容器宽度，否则从祖先推断
        int availableWidth = parent.width() > 0 ? parent.width() : inferAvailableWidth(parent);
        
        foreach (child; parent.children())
        {
            if (!child.visible()) continue;
            
            // 检查定位模式：Absolute/Fixed不参与布局
            if (child.isAbsolutePosition() || child.isFixedPosition())
                continue;
            
            // 计算正常位置（Static/Relative都参与布局）
            int normalX = _padding;
            int normalY = y;
            
            // Relative定位：应用x/y偏移
            if (child.isRelativePosition())
            {
                child.setXY(normalX + child.position().x(), normalY + child.position().y());  // x/y是偏移量
            }
            else
            {
                // Static定位：直接设置位置
                child.setXY(normalX, normalY);
            }
            
            // 子控件宽度处理：
            // - 如果子控件宽度为0（未显式设置）且没有自己的布局管理器，继承可用宽度
            // - 如果子控件已有宽度，保持不变
            // - 如果子控件有自己的布局管理器，由其自行计算尺寸
            if (child.width() == 0 && availableWidth > 0 && child.layout() is null)
                child.width(availableWidth - _padding * 2);
            
            y += child.height() + _spacing;
            
            // 累计最大宽度
            if (child.width() > maxWidth)
                maxWidth = child.width();
        }
        
        // 自动设置父容器尺寸（如果父容器没有设置尺寸）
        if (parent.width() == 0 && maxWidth > 0)
            parent.width(maxWidth + _padding * 2);
        
        if (parent.height() == 0 && y > _padding)
            parent.height(y - _spacing + _padding);
    }
    
    int spacing() const @property { return _spacing; }
    int padding() const @property { return _padding; }
}

class HorizontalLayout : ILayout
{
    private int _spacing = 4;
    private int _padding = 4;
    
    this(int spacing = 4, int padding = 4)
    {
        _spacing = spacing;
        _padding = padding;
    }
    
    /// 从祖先容器推断可用高度
    private int inferAvailableHeight(Control parent)
    {
        Control cur = parent.parent();
        while (cur !is null)
        {
            if (cur.height() > 0)
                return cur.height();
            cur = cur.parent();
        }
        return 0;
    }
    
    void layout(Control parent)
    {
        int x = _padding;
        int maxHeight = 0;
        
        // 确定可用高度：优先使用父容器高度，否则从祖先推断
        int availableHeight = parent.height() > 0 ? parent.height() : inferAvailableHeight(parent);
        
        foreach (child; parent.children())
        {
            if (!child.visible()) continue;
            
            // 检查定位模式：Absolute/Fixed不参与布局
            if (child.isAbsolutePosition() || child.isFixedPosition())
                continue;
            
            // 计算正常位置（Static/Relative都参与布局）
            int normalX = x;
            int normalY = _padding;
            
            // Relative定位：应用x/y偏移
            if (child.isRelativePosition())
            {
                child.setXY(normalX + child.position().x(), normalY + child.position().y());  // x/y是偏移量
            }
            else
            {
                // Static定位：直接设置位置
                child.setXY(normalX, normalY);
            }
            
            // 子控件高度处理：
            // - 如果子控件高度为0（未显式设置）且没有自己的布局管理器，继承可用高度
            // - 如果子控件已有高度，保持不变
            // - 如果子控件有自己的布局管理器，由其自行计算尺寸
            if (child.height() == 0 && availableHeight > 0 && child.layout() is null)
                child.height(availableHeight - _padding * 2);
            
            x += child.width() + _spacing;
            
            // 累计最大高度
            if (child.height() > maxHeight)
                maxHeight = child.height();
        }
        
        // 自动设置父容器尺寸（如果父容器没有设置尺寸）
        if (parent.width() == 0 && x > _padding)
            parent.width(x - _spacing + _padding);
        
        if (parent.height() == 0 && maxHeight > 0)
            parent.height(maxHeight + _padding * 2);
    }
    
    int spacing() const @property { return _spacing; }
    int padding() const @property { return _padding; }
}

class GridLayout : ILayout
{
    private int _rows;
    private int _cols;
    private int _hSpacing = 4;
    private int _vSpacing = 4;
    private int _padding = 4;
    
    this(int rows, int cols, int hSpacing = 4, int vSpacing = 4, int padding = 4)
    {
        _rows = rows;
        _cols = cols;
        _hSpacing = hSpacing;
        _vSpacing = vSpacing;
        _padding = padding;
    }
    
    void layout(Control parent)
    {
        auto children = parent.children();
        
        // 计算单元格尺寸
        int cellWidth = 0;
        int cellHeight = 0;
        
        if (parent.width() > 0 && parent.height() > 0)
        {
            // 父容器有尺寸，按比例分配
            cellWidth = (parent.width() - _padding * 2 - (_cols - 1) * _hSpacing) / _cols;
            cellHeight = (parent.height() - _padding * 2 - (_rows - 1) * _vSpacing) / _rows;
        }
        else
        {
            // 父容器无尺寸，使用子控件的默认尺寸
            cellWidth = 100;  // 默认单元格宽度
            cellHeight = 30;  // 默认单元格高度
        }
        
        // 用于跳过Absolute/Fixed定位的控件
        size_t layoutIndex = 0;
        
        foreach (i, child; children)
        {
            if (!child.visible()) continue;
            
            // 检查定位模式：Absolute/Fixed不参与布局
            if (child.isAbsolutePosition() || child.isFixedPosition())
                continue;
            
            int row = cast(int)(layoutIndex / _cols);
            int col = cast(int)(layoutIndex % _cols);
            
            // 计算正常位置
            int normalX = _padding + col * (cellWidth + _hSpacing);
            int normalY = _padding + row * (cellHeight + _vSpacing);
            
            // Relative定位：应用x/y偏移
            if (child.isRelativePosition())
            {
                child.setXY(normalX + child.position().x(), normalY + child.position().y());  // x/y是偏移量
            }
            else
            {
                // Static定位：直接设置位置
                child.setXY(normalX, normalY);
            }
            
            child.width(cellWidth);
            child.height(cellHeight);
            
            layoutIndex++;
        }
        
        // 自动设置父容器尺寸（如果父容器没有设置尺寸）
        if (parent.width() == 0)
            parent.width(_padding * 2 + _cols * cellWidth + (_cols - 1) * _hSpacing);
        
        if (parent.height() == 0)
            parent.height(_padding * 2 + _rows * cellHeight + (_rows - 1) * _vSpacing);
    }
    
    int rows() const @property { return _rows; }
    int cols() const @property { return _cols; }
}
