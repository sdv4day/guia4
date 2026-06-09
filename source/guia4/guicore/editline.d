module guia4.guicore.editline;

import guia4.guicore.control;
import guia4.guicore.textinput;

/**
 * EditLine — 单行编辑框
 *
 * 直接继承 TextInput，提供与 dlangui 兼容的命名。
 * 无额外功能。
 */
class EditLine : TextInput
{
    this(string text = "", string placeholder = "")
    {
        super(text, placeholder);
    }

    this(Control parent, string text = "")
    {
        super(text);
        if (parent)
            parent.addChild(this);
    }
}