// Written in the D programming language.
module windows.win32.system.core;

import std.conv : parse;
import std.traits : ReturnType, Parameters, getUDAs;



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
        Data1 = parseHex!uint(s[0 .. 8]);
        Data2 = parseHex!ushort(s[9 .. 13]);
        Data3 = parseHex!ushort(s[14 .. 18]);
        Data4[0] = parseHex!ubyte(s[19 .. 21]);
        Data4[1] = parseHex!ubyte(s[21 .. 23]);
        for (size_t i; i < 6; ++i)
            Data4[i + 2] = parseHex!ubyte(s[i * 2 + 24 .. i * 2 + 26]);
    }

    private static T parseHex(T)(scope const(char)[] str)
    {
        auto s = str.idup;
        return parse!T(s, 16);
    }

    this()(const auto ref GUID other)
    {
        this.Data1 = other.Data1;
        this.Data2 = other.Data2;
        this.Data3 = other.Data3;
        this.Data4 = other.Data4;
    }
    
}


template GUIDOF(T, A...)
{
    static if (A.length == 0)
        alias GUIDOF = GUIDOF!(T, __traits(getAttributes, T));
    else static if (A.length == 1)
    {
        static assert(is(typeof(A[0]) == GUID), T.stringof ~ "doesn't have a @GUID attribute attached to it");
        enum GUIDOF = A;
    }
    else static if (is(typeof(A[0]) == GUID))
        enum GUIDOF = A[0];
    else
        alias GUIDOF = GUIDOF!(T, A[1 .. $]);
}



struct DllImport
{
    string libName;
}

struct RAIIFree(alias H)
{
    private alias Handler = H;
}

auto autoFree(T)(T handle)
{
    return RAIIWrapper!(T, FreeFunctionOf!T)(handle);
}

struct RAIIWrapper(Handle, alias CloseHandler)
{

    Handle s;
    alias s this;
    @disable this();
    @disable this(this);
    this(Handle value)
    {
        this.s = value;
    }
    ~this()
    {
        CloseHandler(s);
    }
}


private template FreeFunctionOf(T, A...)
{
    static if (A.length == 0)
    {
        alias attrs = __traits(getAttributes, T);
        static assert(attrs.length > 0, T.stringof ~ " doesn't have any attribute attached to it");
        alias FreeFunctionOf = FreeFunctionOf!(T, attrs);
    }
    else static if (A.length == 1)
    {
        static assert(isFreeHandler!(T, A[0]), T.stringof ~ " doesn't have a correct @RAIIFree attribute attached to it");
        alias FreeFunctionOf = A[0].Handler;
    }
    else static if (isFreeHandler!(T, A[0]))
        alias FreeFunctionOf = A[0].Handler;
    else
        alias FreeFunctionOf = FreeFunctionOf!(T, A[1 .. $]);
}

private template isFreeHandler(T, alias A)
{
    enum isFreeHandler = is(typeof(A.Handler))
        && is(typeof(A.Handler(T.init)));
}

private extern(Windows) void* LoadLibraryA(const char* lpLibFileName);
private extern(Windows) void* GetProcAddress(void* hModule, const char* lpProcName);
private extern(Windows) bool FreeLibrary(void* hModule);

private struct DllCallState(Ret, Params...)
{
    Ret function(Params) funcPtr;
    bool loaded;
    void* dllHandle;
}

private auto getDllCallState(alias Func)()
{
    alias Ret = ReturnType!Func;
    alias Params = Parameters!Func;
    
    static DllCallState!(Ret, Params) state;
    return &state;
}

private auto callFunc(T, Args...)(T func, Args args)
{
    version(Static){
        static assert(0,"is static call");
    }
    static if (Args.length == 0)
        return func();
    else
    {
        enum string params = () {
            string p;
            static foreach (i, T; Args)
                p ~= (i > 0 ? ", " : "") ~ "args[" ~ i.stringof ~ "]";
            return p;
        }();
        return mixin("func(" ~ params ~ ")");
    }
}

auto dllCall(alias Func, Args...)(Args args)
{
    alias Ret = ReturnType!Func;
    alias Params = Parameters!Func;
    
    static string getDllName() {
        import std.traits : getUDAs;
        auto udas = getUDAs!(Func, DllImport);
        static if (udas.length > 0) {
            return udas[0].libName;
        }
        return null;
    }
    
    enum dllName = getDllName();
    enum entryPoint = __traits(identifier, Func);
    
    auto state = getDllCallState!Func();
    
    if (!state.loaded)
    {
        synchronized
        {
            if (!state.loaded)
            {
                state.dllHandle = LoadLibraryA(dllName.ptr);
                if (state.dllHandle is null)
                    throw new Exception("无法加载 " ~ dllName);
                
                state.funcPtr = cast(typeof(state.funcPtr))GetProcAddress(state.dllHandle, entryPoint.ptr);
                if (state.funcPtr is null)
                    throw new Exception("找不到函数 " ~ entryPoint);
                
                state.loaded = true;
            }
        }
    }
    
    return callFunc(state.funcPtr, args);
}

bool dllUnload(alias Func)()
{
    auto state = getDllCallState!Func();
    
    if (!state.loaded)
        return true;
    
    synchronized
    {
        if (!state.loaded)
            return true;
        
        if (state.dllHandle !is null)
        {
            auto result = FreeLibrary(state.dllHandle);
            state.dllHandle = null;
            state.funcPtr = null;
            state.loaded = false;
            return result;
        }
    }
    return true;
}

