module guia4.guicore.label;

import guia4.guicore.control;
import guia4.guicore.dirtyflag;
import guia4.guicore.events;
import guia4.guicore.irendercontext;
import guia4.guicore.rendercontextfactory;
import guia4.guicore.color;
import guia4.utils.logger;

/**
 * Label — 静态文本显示控件
 *
 * 不可聚焦，无交互。
 * 渲染通过 IRenderContext 接口，不直接调用 GDI。
 */
class Label : Control
{
    private string _text;
    private Color _textColor = Color.black();
    private int _fontSize = 14;
    private bool _autoSize = true;

    this(Control parent, string text)
    {
        super(parent);
        _text = text;
        width = 80;
        height = 20;
    }

    string text() const @property { return _text; }
    void text(string v) @property { _text = v; markDirty(); }

    Color textColor() const @property { return _textColor; }
    void textColor(Color v) @property { _textColor = v; markDirty(); }

    /// 兼容旧接口：从 uint 设置文本颜色
    void textColor(uint v) @property { _textColor = Color.fromValue(v); markDirty(); }

    int fontSize() const @property { return _fontSize; }
    void fontSize(int v) @property { _fontSize = v; markDirty(); }

    bool autoSize() const @property { return _autoSize; }
    void autoSize(bool v) @property { _autoSize = v; markDirty(); }

    /// 计算文本自动尺寸（在布局阶段调用）
    void measure(IRenderContext ctx)
    {
        if (!_autoSize) return;
        ctx.setFont("Segoe UI", _fontSize);
        int tw, th;
        ctx.measureText(_text, tw, th);
        width = tw;
        height = th;
    }

    override void renderWithGDI(void* hdc_)
    {
        auto ctx = RenderContextFactory.create(hdc_, width(), height());
        logTrace("Label.renderWithGDI() - '", _text, "' size=(", width(), ",", height(), ")");

        // 设置字体
        ctx.setFont("Segoe UI", _fontSize);

        // 绘制文本（视口已偏移到控件位置，使用 (0, 0)）
        ctx.drawText(0, 0, _text, _textColor);
    }

    override void render() {}
}
