module windows.core;

import std.conv : parse;
import std.traits : ReturnType, Parameters, getUDAs;

alias HRESULT = int;
alias ULONG = uint;
alias LPVOID = void*;
alias BSTR = wchar*;
alias PWSTR = wchar*;

enum SUCCEEDED = (HRESULT hr) => hr >= 0;
enum FAILED = (HRESULT hr) => hr < 0;

struct GUID {
    align(1):
    uint     Data1;
    ushort   Data2;
    ushort   Data3;
    ubyte[8] Data4;

    this(string s)
    {
        assert(s.length == 36, "Invalid GUID length");  
        assert(s[8] == '-' && s[13] == '-' && s[18] == '-' && s[23] == '-', "Invalid GUID format");
        auto s0 = s[0 .. 8].dup;
        auto s1 = s[9 .. 13].dup;
        auto s2 = s[14 .. 18].dup;
        auto s3 = s[19 .. 21].dup;
        auto s4 = s[21 .. 23].dup;
        
        import std.conv;
        Data1 = parse!uint(s0, 16);
        Data2 = parse!ushort(s1, 16);
        Data3 = parse!ushort(s2, 16);
        Data4[0] = parse!ubyte(s3, 16);
        Data4[1] = parse!ubyte(s4, 16);
        for (int i = 0; i < 6; i++)
        {
            auto sb = s[24 + i * 2 .. 26 + i * 2].dup;
            Data4[2 + i] = parse!ubyte(sb, 16);
        }
    }

    string toString() const
    {
        import std.format;
        return format("%08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X",
            Data1, Data2, Data3, Data4[0], Data4[1],
            Data4[2], Data4[3], Data4[4], Data4[5], Data4[6], Data4[7]);
    }

    bool opEquals(ref const GUID other) const
    {
        return Data1 == other.Data1 && Data2 == other.Data2 &&
               Data3 == other.Data3 && Data4 == other.Data4;
    }

    hash_t toHash() const
    {
        hash_t result = Data1;
        result = result * 37 + Data2;
        result = result * 37 + Data3;
        foreach (b; Data4)
            result = result * 37 + b;
        return result;
    }
}

template DEFINE_GUID(name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8)
{
    enum name = GUID(l, w1, w2, [cast(ubyte)b1, cast(ubyte)b2, cast(ubyte)b3, 
                                     cast(ubyte)b4, cast(ubyte)b5, cast(ubyte)b6, 
                                     cast(ubyte)b7, cast(ubyte)b8]);
}

interface IUnknown
{
    extern(Windows) HRESULT QueryInterface(const GUID* riid, void** ppvObject);
    extern(Windows) ULONG AddRef();
    extern(Windows) ULONG Release();
}

class ComObject
{
    IUnknown* _pUnknown;

    this(IUnknown* pUnknown)
    {
        _pUnknown = pUnknown;
        if (_pUnknown)
            _pUnknown.AddRef();
    }

    ~this()
    {
        if (_pUnknown)
            _pUnknown.Release();
    }

    HRESULT QueryInterface(const GUID* riid, void** ppvObject)
    {
        return _pUnknown.QueryInterface(riid, ppvObject);
    }

    ULONG AddRef()
    {
        return _pUnknown.AddRef();
    }

    ULONG Release()
    {
        return _pUnknown.Release();
    }

    bool opCast(T)()
    {
        return _pUnknown !is null;
    }
}

template ComInterface(T)
{
    mixin template ComWrapper(IUnknown* p)
    {
        private IUnknown* _p = p;

        this(IUnknown* pUnknown)
        {
            _p = pUnknown;
            if (_p)
                _p.AddRef();
        }

        ~this()
        {
            if (_p)
                _p.Release();
        }

        HRESULT QueryInterface(const GUID* riid, void** ppvObject)
        {
            return _p.QueryInterface(riid, ppvObject);
        }

        ULONG AddRef()
        {
            return _p.AddRef();
        }

        ULONG Release()
        {
            return _p.Release();
        }
    }
}

struct DllImport
{
    string name;
    string callingConvention;

    this(string name, string callingConvention = "stdcall")
    {
        this.name = name;
        this.callingConvention = callingConvention;
    }
}

struct RAIIFree(alias func)
{
}

struct SupportedOSPlatform
{
    string ver;
    this(string ver) { this.ver = ver; }
}

template GUIDOF(T)
{
    enum GUIDOF = GUID.init;
}