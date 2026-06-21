module guia4.guicore.dirtyflag;

struct DirtyFlag
{
    private bool _dirty = true;

    bool isDirty() const nothrow @nogc
    {
        return _dirty;
    }

    void mark() nothrow @nogc
    {
        _dirty = true;
    }

    void clear() nothrow @nogc
    {
        _dirty = false;
    }
}
