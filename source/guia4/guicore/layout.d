module guia4.guicore.layout;

import guia4.guicore.control;
import guia4.guicore.layoutdata;

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
    
    void layout(Control parent)
    {
        int y = _padding;
        foreach (child; parent.children())
        {
            if (!child.visible()) continue;
            child.x(_padding);
            child.y(y);
            child.width(parent.width() - _padding * 2);
            y += child.height() + _spacing;
        }
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
    
    void layout(Control parent)
    {
        int x = _padding;
        foreach (child; parent.children())
        {
            if (!child.visible()) continue;
            child.x(x);
            child.y(_padding);
            child.height(parent.height() - _padding * 2);
            x += child.width() + _spacing;
        }
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
        int cellWidth = (parent.width() - _padding * 2 - (_cols - 1) * _hSpacing) / _cols;
        int cellHeight = (parent.height() - _padding * 2 - (_rows - 1) * _vSpacing) / _rows;
        
        foreach (i, child; children)
        {
            if (!child.visible()) continue;
            int row = cast(int)(i / _cols);
            int col = cast(int)(i % _cols);
            child.x(_padding + col * (cellWidth + _hSpacing));
            child.y(_padding + row * (cellHeight + _vSpacing));
            child.width(cellWidth);
            child.height(cellHeight);
        }
    }
    
    int rows() const @property { return _rows; }
    int cols() const @property { return _cols; }
}

template StaticLayout(Control[] controls, int width, int height, string layoutType = "vertical")
{
    LayoutData[controls.length] calculateLayout()
    {
        LayoutData[controls.length] result;
        int x = 4, y = 4;
        
        static if (layoutType == "vertical")
        {
            foreach (i, c; controls)
            {
                result[i] = LayoutData(x, y, width - 8, c.height());
                y += c.height() + 4;
            }
        }
        else static if (layoutType == "horizontal")
        {
            foreach (i, c; controls)
            {
                result[i] = LayoutData(x, y, c.width(), height - 8);
                x += c.width() + 4;
            }
        }
        
        return result;
    }
    
    enum StaticLayout = calculateLayout();
}