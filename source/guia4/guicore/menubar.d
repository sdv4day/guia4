module guia4.guicore.menubar;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;

class MenuBar : Control
{
    this()
    {
        height = 24;
    }
    
    this(Control parent)
    {
        height = 24;
        if (parent)
        {
            parent.addChild(this);
        }
    }
    
    MenuItem add(string text)
    {
        auto item = new MenuItem(this, text);
        return item;
    }
    
    override void render()
    {
    }
}

class MenuItem : Control
{
    private string _text;
    private ClickHandler _handler;
    
    this(string text = "MenuItem")
    {
        _text = text;
        width = 80;
        height = 20;
    }
    
    this(Control parent, string text)
    {
        _text = text;
        width = 80;
        height = 20;
        if (parent)
        {
            parent.addChild(this);
        }
    }
    
    string text() const @property { return _text; }
    void text(string v) { _text = v; markDirty(DirtyBits.Visual); }
    
    override void onClick(ClickHandler handler)
    {
        _handler = handler;
    }
    
    override void render()
    {
    }
}