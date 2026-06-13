module guia4.guicore.asynctask;

import std.concurrency;
import core.time;
import core.thread;
import guia4.utils.logger;

/**
 * 异步任务框架 — 基于 std.concurrency 的后台线程通信
 *
 * 消息协议（immutable，线程安全）：
 *   - TaskProgress: 进度更新 (percent 0..100, status 描述)
 *   - TaskComplete: 任务完成 (result 结果数据)
 *   - TaskError:    任务出错 (message 错误信息)
 *
 * 使用方式：
 *   // 1. 定义 worker（顶层函数，不可变参数）
 *   void myWorker(Tid ownerTid, immutable int totalItems)
 *   {
 *       foreach (i; 0 .. totalItems)
 *       {
 *           Thread.sleep(10.msecs);
 *           int pct = (i + 1) * 100 / totalItems;
 *           ownerTid.send(immutable TaskProgress(pct, "loading..."));
 *       }
 *       ownerTid.send(immutable TaskComplete("done"));
 *   }
 *
 *   // 2. 启动 worker 线程
 *   auto tid = spawn(&myWorker, thisTid, 500);
 *
 *   // 3. 包装为 AsyncTask（提供轮询接口）
 *   auto task = new AsyncTask(tid);
 *
 *   // 4. 在主线程定时器中轮询
 *   task.poll();
 *   if (task.isComplete()) { ... }
 */

/// 进度消息
immutable struct TaskProgress
{
    int percent;       /// 0..100
    string status;     /// 状态描述
}

/// 完成消息
immutable struct TaskComplete
{
    string result;     /// 结果数据
}

/// 错误消息
immutable struct TaskError
{
    string message;    /// 错误描述
}

/**
 * AsyncTask — 异步任务封装
 *
 * 职责：
 *   - 包装已 spawn 的 worker Tid
 *   - 提供 poll() 供主线程非阻塞轮询消息
 *   - 缓存进度/结果/错误状态供 UI 查询
 */
class AsyncTask
{
    private Tid _workerTid;
    private bool _completed = false;
    private int _progress = 0;
    private string _status = "";
    private string _result = "";
    private string _error = "";

    /// 包装一个已启动的 worker 线程
    this(Tid workerTid)
    {
        _workerTid = workerTid;
        logTrace("AsyncTask created for worker ", workerTid);
    }

    /// 非阻塞轮询所有待处理消息（应在主线程定时器中调用）
    void poll()
    {
        if (_completed)
            return;

        bool hasMsg = true;
        while (hasMsg)
        {
            hasMsg = receiveTimeout(dur!("msecs")(0),
                (immutable TaskProgress p)
                {
                    _progress = p.percent;
                    _status = p.status.idup;
                    logTrace("AsyncTask progress: ", _progress, "% — ", _status);
                },
                (immutable TaskComplete c)
                {
                    _completed = true;
                    _result = c.result.idup;
                    logInfo("AsyncTask completed: ", _result);
                },
                (immutable TaskError e)
                {
                    _completed = true;
                    _error = e.message.idup;
                    logError("AsyncTask error: ", _error);
                }
            );
        }
    }

    // ── 状态查询 ──

    bool isComplete() const nothrow @nogc { return _completed; }
    bool hasError()   const nothrow @nogc { return _error.length > 0; }

    int progress()    const nothrow @nogc { return _progress; }
    string status()   const { return _status; }
    string result()   const { return _result; }
    string error()    const { return _error; }

    /// 等待任务完成（阻塞，仅用于测试场景）
    void waitComplete()
    {
        while (!_completed)
        {
            poll();
            Thread.sleep(dur!("msecs")(10));
        }
    }
}
