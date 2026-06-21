module guia4.guicore.screenshotmanager;

import guia4.utils.logger;
import windows.win32.graphics.gdi;
import windows.win32.foundation;
import windows.win32.ui.windowsandmessaging;
import std.stdio;
import std.string;

/**
 * ScreenshotManager — 截图管理器
 *
 * 负责：
 * - 窗口截图
 * - 延迟截图
 * - 截图后关闭窗口
 */
class ScreenshotManager
{
    private void* _nativeHandle;  // HWND
    private string _screenshotFile;
    private bool _closeAfterScreenshot = false;

    this(void* nativeHandle)
    {
        _nativeHandle = nativeHandle;
    }

    /// 更新原生句柄
    void updateHandle(void* nativeHandle)
    {
        _nativeHandle = nativeHandle;
    }

    /// 截图文件名
    string screenshotFile() @property { return _screenshotFile; }

    /// 截图后是否关闭窗口
    bool closeAfterScreenshot() @property { return _closeAfterScreenshot; }
    void closeAfterScreenshot(bool v) @property { _closeAfterScreenshot = v; }

    /// 执行截图
    void captureScreenshot(string filename = "screenshot.bmp")
    {
        logInfo("ScreenshotManager.captureScreenshot('", filename, "')");
        HWND hwnd = HWND(_nativeHandle);

        HDC hdcScreen = GetDC(hwnd);
        HDC hdcMemDC = CreateCompatibleDC(hdcScreen);

        RECT rect;
        GetClientRect(hwnd, &rect);
        int width = rect.right - rect.left;
        int height = rect.bottom - rect.top;

        HBITMAP hBitmap = CreateCompatibleBitmap(hdcScreen, width, height);
        HGDIOBJ hOldBitmap = SelectObject(hdcMemDC, cast(HGDIOBJ)hBitmap);

        BitBlt(hdcMemDC, 0, 0, width, height, hdcScreen, 0, 0, 0x00CC0020);

        BITMAPINFOHEADER bi;
        bi.biSize = BITMAPINFOHEADER.sizeof;
        bi.biWidth = width;
        bi.biHeight = -height;
        bi.biPlanes = 1;
        bi.biBitCount = 32;
        bi.biCompression = 0;

        int bufferSize = width * height * 4;
        ubyte[] buffer = new ubyte[bufferSize];
        GetDIBits(hdcScreen, hBitmap, 0, cast(uint)height, buffer.ptr, cast(BITMAPINFO*)&bi, 0);

        FILE* file = fopen(filename.toStringz(), "wb");
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

            logInfo("Screenshot saved to: ", filename);
        }

        SelectObject(hdcMemDC, hOldBitmap);
        DeleteObject(cast(HGDIOBJ)hBitmap);
        DeleteDC(hdcMemDC);
        ReleaseDC(hwnd, hdcScreen);
        logInfo("ScreenshotManager.captureScreenshot() - COMPLETED");
    }

    /// 设置截图文件名
    void setScreenshotFile(string filename)
    {
        _screenshotFile = filename;
    }
}
