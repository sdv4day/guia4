module guia4.utils.logger;

import std.logger;
public import std.logger: LogLevel;
import std.stdio;

private Logger _logger;

/**
 * 初始化全局日志系统
 * 
 * Params:
 *   level = 日志级别（默认 LogLevel.info）
 */
void initLogger(LogLevel level = LogLevel.info)
{
    _logger = new FileLogger(stdout, level);
    _logger.info("Logger initialized with level: ", level);
}

/**
 * 获取全局日志器
 */
Logger logger() @property
{
    if (_logger is null)
    {
        initLogger();
    }
    return _logger;
}

/**
 * 快捷日志函数
 */
void logTrace(T...)(T args) { logger.trace(args); }
void logInfo(T...)(T args) { logger.info(args); }
void logWarning(T...)(T args) { logger.warning(args); }
void logError(T...)(T args) { logger.error(args); }
void logCritical(T...)(T args) { logger.critical(args); }