// Written in the D programming language.

module windows.win32.system.io;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, NTSTATUS;

extern(Windows) @nogc nothrow:


// Callbacks

alias LPOVERLAPPED_COMPLETION_ROUTINE = void function(uint dwErrorCode, uint dwNumberOfBytesTransfered, 
                                                      OVERLAPPED* lpOverlapped);
alias PIO_APC_ROUTINE = void function(void* ApcContext, IO_STATUS_BLOCK* IoStatusBlock, uint Reserved);

// Structs


//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-overlapped))], [])
struct OVERLAPPED
{
    size_t Internal;
    size_t InternalHigh;
union Anonymous
    {
struct Anonymous
        {
            uint Offset;
            uint OffsetHigh;
        }
        void* Pointer;
    }
    HANDLE hEvent;
}

//STRUCT ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-overlapped_entry))], [])
struct OVERLAPPED_ENTRY
{
    size_t      lpCompletionKey;
    OVERLAPPED* lpOverlapped;
    size_t      Internal;
    uint        dwNumberOfBytesTransferred;
}

struct IO_STATUS_BLOCK
{
union Anonymous
    {
        NTSTATUS Status;
        void*    Pointer;
    }
    size_t Information;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-createiocompletionport))], [])
@DllImport("KERNEL32.dll")
HANDLE CreateIoCompletionPort(HANDLE FileHandle, HANDLE ExistingCompletionPort, size_t CompletionKey, 
                              uint NumberOfConcurrentThreads);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-getqueuedcompletionstatus))], [])
@DllImport("KERNEL32.dll")
BOOL GetQueuedCompletionStatus(HANDLE CompletionPort, uint* lpNumberOfBytesTransferred, size_t* lpCompletionKey, 
                               OVERLAPPED** lpOverlapped, uint dwMilliseconds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-getqueuedcompletionstatusex))], [])
@DllImport("KERNEL32.dll")
BOOL GetQueuedCompletionStatusEx(HANDLE CompletionPort, OVERLAPPED_ENTRY* lpCompletionPortEntries, uint ulCount, 
                                 uint* ulNumEntriesRemoved, uint dwMilliseconds, BOOL fAlertable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-postqueuedcompletionstatus))], [])
@DllImport("KERNEL32.dll")
BOOL PostQueuedCompletionStatus(HANDLE CompletionPort, uint dwNumberOfBytesTransferred, size_t dwCompletionKey, 
                                OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-deviceiocontrol))], [])
@DllImport("KERNEL32.dll")
BOOL DeviceIoControl(HANDLE hDevice, uint dwIoControlCode, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpInBuffer, 
                     uint nInBufferSize, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpOutBuffer, 
                     uint nOutBufferSize, uint* lpBytesReturned, 
                     /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-getoverlappedresult))], [])
@DllImport("KERNEL32.dll")
BOOL GetOverlappedResult(HANDLE hFile, OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-cancelioex))], [])
@DllImport("KERNEL32.dll")
BOOL CancelIoEx(HANDLE hFile, OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-cancelio))], [])
@DllImport("KERNEL32.dll")
BOOL CancelIo(HANDLE hFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-getoverlappedresultex))], [])
@DllImport("KERNEL32.dll")
BOOL GetOverlappedResultEx(HANDLE hFile, OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, 
                           uint dwMilliseconds, BOOL bAlertable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/ioapiset/nf-ioapiset-cancelsynchronousio))], [])
@DllImport("KERNEL32.dll")
BOOL CancelSynchronousIo(HANDLE hThread);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
//METH ATTR: DocumentationAttribute : CustomAttributeSig([FixedArgSig(ElementSig(https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-bindiocompletioncallback))], [])
@DllImport("KERNEL32.dll")
BOOL BindIoCompletionCallback(HANDLE FileHandle, LPOVERLAPPED_COMPLETION_ROUTINE Function, uint Flags);


