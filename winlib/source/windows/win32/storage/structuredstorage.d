// Written in the D programming language.

module windows.win32.storage.structuredstorage;

public import windows.core;

extern(Windows) @nogc nothrow:


// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-handle))], [])
struct JET_HANDLE
{
    size_t Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-tableid))], [])
struct JET_TABLEID
{
    size_t Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-api-ptr))], [])
struct JET_API_PTR
{
    size_t Value;
}

