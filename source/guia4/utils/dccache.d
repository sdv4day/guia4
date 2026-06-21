module guia4.utils.dccache;

import windows.win32.graphics.gdi;

/**
 * DCCache — 兼容 DC 缓存
 *
 * 避免每次文本测量都创建/销毁 DC。
 * 提供一个可复用的兼容 DC，用于 GetTextExtentPoint 等文本测量操作。
 */
struct DCCache
{
    private static HDC _cachedDC;
    private static bool _initialized = false;

    /// 获取缓存的兼容 DC（首次调用时创建）
    static HDC get()
    {
        if (!_initialized || _cachedDC.Value is null)
        {
            _cachedDC = CreateCompatibleDC(HDC.init);
            _initialized = true;
        }
        return _cachedDC;
    }

    /// 释放缓存的 DC（程序退出时调用）
    static void release()
    {
        if (_cachedDC.Value !is null)
        {
            DeleteDC(_cachedDC);
            _cachedDC = HDC.init;
            _initialized = false;
        }
    }
}
