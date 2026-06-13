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
 * 快捷日志函数 - 直接别名到std.logger的全局函数
 * 这样不会改变调用位置
 */
alias logDebug = trace;
alias logTrace = trace;
alias logInfo = info;
alias logWarning = warning;
alias logError = error;
alias logCritical = critical;