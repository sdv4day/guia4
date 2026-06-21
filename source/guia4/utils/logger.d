module guia4.utils.logger;

import std.logger;
import std.stdio;

/// 项目根路径前缀
enum string PROJECT_ROOT = `D:\\code\\guiA4\\source\\`;

/// 便捷日志别名 — 带 log 前缀避免命名冲突
alias logTrace   = trace;
alias logInfo    = info;
alias logWarning = warning;
alias logError   = error;
alias logCritical = critical;
alias logFatal   = fatal;

/// 公开日志级别
public import std.logger : LogLevel;

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
