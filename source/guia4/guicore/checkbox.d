module guia4.guicore.checkbox;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.irendercontext;
import guia4.guicore.rendercontextfactory;
import guia4.guicore.color;
import guia4.utils.logger;
import guia4.platform_win32.win32defs;

/**
 * Checkbox — 复选框控件
 *
 * 渲染通过 IRenderContext 接口。
 */
class Checkbox : Control
{
    private string _text;
    private bool _checked = false;
    private bool _hovered = false;

    this(Control parent, string text)
    {
        super(parent);
        _text = text;
        width = 150;
        height = 24;
        focusable = true;
    }

    string text() const @property { return _text; }
    void text(string v) @property { _text = v; markDirty(); }

    bool checked() const @property { return _checked; }
    void checked(bool v) @property { _checked = v; markDirty(); }

    override void fireMouseDown(int x, int y, int button)
    {
        if (button == 0)
        {
            _checked = !_checked;
            markDirty();
        }
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseMove(int x, int y)
    {
        bool newHovered = (x >= 0 && y >= 0);
        if (newHovered != _hovered)
        {
            _hovered = newHovered;
            markDirty();
        }
        super.fireMouseMove(x, y);
    }

    override void renderWithGDI(void* hdc_)
    {
        auto ctx = RenderContextFactory.create(hdc_, width(), height());
        logTrace("Checkbox.renderWithGDI() - '", _text, "' checked=", _checked);

        int boxSize = 16;
        int bx = 4;
        int by = (height() - boxSize) / 2;
        int textX = bx + boxSize + 6;

        // 方框颜色
        Color boxBorderColor = _hovered ? Color.rgb(0x00, 0x66, 0xCC) : Color.rgb(0x88, 0x88, 0x88);
        Color boxBgColor = _checked ? Color.rgb(0x33, 0x66, 0xFF) : Color.white;

        // 绘制方框
        ctx.fillRect(bx, by, boxSize, boxSize, boxBgColor);
        ctx.drawRect(bx, by, boxSize, boxSize, boxBorderColor, 1);

        // 如果选中，绘制勾号
        if (_checked)
        {
            ctx.drawLine(bx + 3, by + boxSize / 2, bx + boxSize / 2 - 1, by + boxSize - 4, Color.white, 2);
            ctx.drawLine(bx + boxSize / 2 - 1, by + boxSize - 4, bx + boxSize - 3, by + 3, Color.white, 2);
        }

        // 绘制文字
        ctx.setFont("Segoe UI", 14);
        int textY = (height() - 14) / 2;
        ctx.drawText(textX, textY, _text, Color.black);

        // 焦点指示器
        if (hasFocus())
        {
            ctx.drawRect(1, 1, width() - 2, height() - 2, Color.black);
        }
    }

    override void render() {}
}
