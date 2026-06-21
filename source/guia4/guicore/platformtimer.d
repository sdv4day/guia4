module guia4.guicore.platformtimer;

/// 平台无关的时间获取
version(Windows)
{
    import windows.win32.system.systeminformation;

    /// 获取当前时间（毫秒）
    long currentTimeMs()
    {
        return cast(long)GetTickCount64();
    }
}
else version(linux)
{
    import core.stdc.time;

    /// 获取当前时间（毫秒）
    long currentTimeMs()
    {
        timespec ts;
        clock_gettime(CLOCK_MONOTONIC, &ts);
        return cast(long)ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
    }
}
