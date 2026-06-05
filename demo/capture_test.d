/**
 * capture_test.d
 * Minimal Win32 test: create window, paint gradient, capture screenshot via timer.
 * All operations on the main thread - no background thread crash.
 * Uses ANSI Win32 APIs for nothrow safety in window callbacks.
 */

import core.sys.windows.windows;
import core.sys.windows.wingdi;
import std.string;
import std.stdio;

// Cast IDC_ARROW (LPCWSTR) to LPCSTR for ANSI API
enum IDC_ARROWA = cast(LPCSTR) cast(size_t) 32512;

void captureScreenshot(HWND hwnd, const(char)* filename) nothrow;

extern (Windows)
LRESULT WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) nothrow
{
    switch (msg)
    {
        case WM_DESTROY:
            PostQuitMessage(0);
            return 0;

        case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hwnd, &ps);
            RECT rect;
            GetClientRect(hwnd, &rect);

            // Draw gradient background
            for (int y = 0; y < rect.bottom; y++)
            {
                int r = cast(int)(y * 255.0 / rect.bottom);
                int g = cast(int)((rect.bottom - y) * 200.0 / rect.bottom);
                HBRUSH brush = CreateSolidBrush(cast(COLORREF)RGB(r, g, 128));
                RECT row = {0, y, rect.right, y + 1};
                FillRect(hdc, &row, brush);
                DeleteObject(brush);
            }

            // Draw text
            SetBkMode(hdc, TRANSPARENT);
            SetTextColor(hdc, RGB(255, 255, 255));
            RECT textRect = {50, 50, 400, 100};
            DrawTextA(hdc, "DGUI Framework - Minimal Test", -1, &textRect, DT_LEFT);

            EndPaint(hwnd, &ps);
            return 0;
        }

        case WM_TIMER:
            if (wParam == 1)
            {
                KillTimer(hwnd, 1);
                captureScreenshot(hwnd, "D:\\code\\guiA4\\demo\\capture_test.bmp");
            }
            return 0;

        default:
            return DefWindowProcA(hwnd, msg, wParam, lParam);
    }
}

void captureScreenshot(HWND hwnd, const(char)* filename) nothrow
{
    HDC hdcScreen = GetDC(hwnd);
    HDC hdcMemDC = CreateCompatibleDC(hdcScreen);

    RECT rect;
    GetClientRect(hwnd, &rect);
    int width = rect.right - rect.left;
    int height = rect.bottom - rect.top;

    HBITMAP hBitmap = CreateCompatibleBitmap(hdcScreen, width, height);
    HGDIOBJ hOldBitmap = SelectObject(hdcMemDC, hBitmap);

    BitBlt(hdcMemDC, 0, 0, width, height, hdcScreen, 0, 0, SRCCOPY);

    BITMAPINFOHEADER bi;
    bi.biSize = BITMAPINFOHEADER.sizeof;
    bi.biWidth = width;
    bi.biHeight = -height;
    bi.biPlanes = 1;
    bi.biBitCount = 32;
    bi.biCompression = BI_RGB;
    bi.biSizeImage = 0;
    bi.biXPelsPerMeter = 0;
    bi.biYPelsPerMeter = 0;
    bi.biClrUsed = 0;
    bi.biClrImportant = 0;

    int bufferSize = width * height * 4;
    ubyte[] buffer = new ubyte[bufferSize];
    GetDIBits(hdcScreen, hBitmap, 0, height, buffer.ptr, cast(BITMAPINFO*)&bi, DIB_RGB_COLORS);

    FILE* file = fopen(filename, "wb");
    if (file !is null)
    {
        BITMAPFILEHEADER bf;
        bf.bfType = 0x4D42;
        bf.bfSize = cast(uint)(BITMAPFILEHEADER.sizeof + BITMAPINFOHEADER.sizeof + bufferSize);
        bf.bfReserved1 = 0;
        bf.bfReserved2 = 0;
        bf.bfOffBits = BITMAPFILEHEADER.sizeof + BITMAPINFOHEADER.sizeof;

        fwrite(&bf, BITMAPFILEHEADER.sizeof, 1, file);
        fwrite(&bi, BITMAPINFOHEADER.sizeof, 1, file);
        fwrite(buffer.ptr, bufferSize, 1, file);
        fclose(file);
        printf("Screenshot saved\n");
    }
    else
    {
        printf("FAILED to open file for screenshot\n");
    }

    SelectObject(hdcMemDC, hOldBitmap);
    DeleteObject(hBitmap);
    DeleteDC(hdcMemDC);
    ReleaseDC(hwnd, hdcScreen);

    PostQuitMessage(0);
}

int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
    // Register window class (ANSI)
    WNDCLASSA wc;
    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc = &WndProc;
    wc.hInstance = hInstance;
    wc.hCursor = LoadCursorA(null, IDC_ARROWA);
    wc.hbrBackground = cast(HBRUSH)(COLOR_WINDOW + 1);
    wc.lpszClassName = "CaptureTestClass";

    if (RegisterClassA(&wc) == 0)
    {
        printf("RegisterClass failed\n");
        return 1;
    }

    // Create window (ANSI)
    HWND hwnd = CreateWindowExA(
        0, "CaptureTestClass", "DGUI Capture Test",
        WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT, 800, 600,
        null, null, hInstance, null
    );
    if (hwnd is null)
    {
        printf("CreateWindow failed\n");
        return 1;
    }

    // Set timer for screenshot (1.5 seconds from main thread message loop)
    SetTimer(hwnd, 1, 1500, null);

    ShowWindow(hwnd, nCmdShow);
    UpdateWindow(hwnd);

    printf("Window created, running message loop...\n");

    // Message loop
    MSG msg;
    while (GetMessageA(&msg, null, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessageA(&msg);
    }

    printf("Message loop exited\n");
    return 0;
}
