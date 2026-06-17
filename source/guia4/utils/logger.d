module guia4.utils.logger;

// 直接重导出std.logger的所有功能
public import std.logger;

// 提供初始化函数
import std.stdio;

/**
 * 初始化全局日志系统
 *
 * Params:
 *   level = 日志级别（默认 LogLevel.info）
 */
void initLogger(LogLevel level = LogLevel.info)
{
    auto logger = new FileLogger(stdout, level);
    sharedLog = cast(shared) logger;
    logger.info("Logger initialized with level: ", level);
}

/**
 * 日志级别说明：
 *   logTrace  → trace  (最详细，渲染循环等热路径，生产环境应关闭)
 *   logDebug  → info   (调试信息，比 trace 高一级，开发时开启)
 *   logInfo   → info   (常规信息)
 *   logWarning → warning
 *   logError  → error
 *   logCritical → critical
 *
 * 热路径优化：当 ENABLE_TRACE_LOG 未定义时，logTrace 为空操作，
 * 编译器会完全消除调用开销。
 */

version (ENABLE_TRACE_LOG)
{
    alias logTrace = trace;
}
else
{
    /// 空操作：release 模式下 logTrace 不产生任何代码
    void logTrace(T...)(lazy T args) {}
}

alias logDebug = info;
alias logInfo = info;
alias logWarning = warning;
alias logError = error;
alias logCritical = critical;