module guia4.guicore.dirtyflag;

// Dirty flag bits
enum DirtyBits : uint
{
    None      = 0x0000_0000,
    Position  = 0x0000_0001,
    Size      = 0x0000_0002,
    Visibility = 0x0000_0004,
    Visual    = 0x0000_0008,
    Layout    = 0x0000_0010,
    Children  = 0x0000_0020,
    All       = 0xFFFF_FFFF,
}

struct DirtyFlag
{
    private uint _bits = DirtyBits.None;

    bool isDirty() const nothrow @nogc
    {
        return _bits != DirtyBits.None;
    }

    bool isDirty(DirtyBits bit) const nothrow @nogc
    {
        return (_bits & bit) != 0;
    }

    void mark(DirtyBits bit) nothrow @nogc
    {
        _bits |= bit;
    }

    void clear() nothrow @nogc
    {
        _bits = DirtyBits.None;
    }

    void clear(DirtyBits bit) nothrow @nogc
    {
        _bits &= ~bit;
    }

    uint bits() const nothrow @nogc @property
    {
        return _bits;
    }
}