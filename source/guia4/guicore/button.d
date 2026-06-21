module guia4.guicore.button;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.irendercontext;
import guia4.guicore.rendercontextfactory;
import guia4.guicore.color;
import guia4.utils.logger;
import guia4.platform_win32.win32defs;

/**
 * Button — 带状态机的按钮控件
 *
 * 鼠标状态转换（由 MainWindow 鼠标分发协调）：
 *   fireMouseDown(x,y)  → Pressed=true,  视觉=按下
 *   fireMouseUp(x,y)    → Pressed=false, 视觉=正常/悬停
 *   fireMouseMove(x,y)  → Hovered=true   (如果在边界内)
 *   fireMouseMove(-1,-1) → Hovered=false  (光标离开)
 *
 * 点击检测在 MainWindow 分发层处理。
 */
class Button : Control
{
    private string _text;
    private bool _pressed = false;
    private bool _hovered = false;

    this(Control parent, string text)
    {
        super(parent);
        logTrace("Button.ctor(parent=", parent !is null, ", text='", text, "')");
        _text = text;
        width = 100;
        height = 30;
        focusable = true;
    }

    string text() const @property { return _text; }
    void text(string v) @property { logTrace("Button.text = '", v, "'"); _text = v; markDirty(); }

    // ── 鼠标事件 ──────────────────────────────────────────

    override void fireMouseDown(int x, int y, int button)
    {
        logTrace("Button.fireMouseDown(x=", x, ", y=", y, ") - '", _text, "'");
        _pressed = true;
        markDirty();
        super.fireMouseDown(x, y, button);
    }

    override void fireMouseUp(int x, int y, int button)
    {
        logTrace("Button.fireMouseUp(x=", x, ", y=", y, ") - '", _text, "'");
        _pressed = false;
        markDirty();
        super.fireMouseUp(x, y, button);
    }

    override void fireClick(int x, int y)
    {
        logTrace("Button.fireClick(x=", x, ", y=", y, ") - '", _text, "' clicked");
        super.fireClick(x, y);
    }

    override void fireKeyDown(uint keyCode, bool shift = false, bool control = false, bool alt = false)
    {
        logTrace("Button.fireKeyDown(keyCode=", keyCode, ") - '", _text, "'");
        if (keyCode == VK_RETURN || keyCode == VK_SPACE)
        {
            _pressed = true;
            markDirty();
            fireClick(width / 2, height / 2);
            _pressed = false;
            markDirty();
        }
        super.fireKeyDown(keyCode, shift, control, alt);
    }

    override void fireMouseMove(int x, int y)
    {
        if (x < 0 || y < 0)
        {
            if (_hovered)
            {
                logTrace("Button.fireMouseMove(LEAVE) - '", _text, "'");
                _hovered = false;
                markDirty();
            }
        }
        else
        {
            if (!_hovered)
            {
                logTrace("Button.fireMouseMove(ENTER) - '", _text, "' at (", x, ",", y, ")");
                _hovered = true;
                markDirty();
            }
        }
        super.fireMouseMove(x, y);
    }

    // ── 渲染（通过 IRenderContext 接口）───────────────────

    override void renderWithGDI(void* hdc_)
    {
        auto ctx = RenderContextFactory.create(hdc_, width(), height());
        logTrace("Button.renderWithGDI() - '", _text, "' size=(", width(), ",", height(), ")");

        // 根据状态选择颜色
        Color bgColor, borderColor;
        Color textColor = Color.white;

        if (_pressed)
        {
            bgColor = Color.rgb(0x44, 0x44, 0x44);
            borderColor = Color.rgb(0x22, 0x22, 0x22);
        }
        else if (_hovered)
        {
            bgColor = Color.rgb(0x88, 0x88, 0xFF);
            borderColor = Color.rgb(0x55, 0x55, 0xCC);
        }
        else
        {
            bgColor = Color.rgb(0x66, 0x66, 0xFF);
            borderColor = Color.rgb(0x33, 0x33, 0xAA);
        }

        // 绘制圆角矩形背景
        ctx.fillRoundRect(0, 0, width(), height(), 8, bgColor);
        ctx.drawRoundRect(0, 0, width(), height(), 8, borderColor, 2);

        // 绘制文本
        ctx.setFont("Segoe UI", 14);
        int tw, th;
        ctx.measureText(_text, tw, th);
        int textX = (width() - tw) / 2;
        int textY = (height() - th) / 2;
        ctx.drawText(textX, textY, _text, textColor);

        // 焦点指示器
        if (hasFocus())
        {
            ctx.drawRect(2, 2, width() - 4, height() - 4, Color.black);
        }
    }

    override void render() {}
}
