module async_demo;

import guia4.app;
import guia4.guicore;
import guia4.guicore.asynctask;
import guia4.utils.logger;
import std.concurrency;
import core.thread;
import core.time;
import std.conv : to;
import std.string : format;
import core.sys.windows.windows;

shared static this()
{
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
}

// ── Worker 函数（顶层函数，供 spawn 调用）──
// 参数必须是 immutable，符合 std.concurrency 的线程安全要求
void dataLoaderWorker(Tid ownerTid, immutable int totalItems)
{
    const int batchSize = 10;

    foreach (batch; 0 .. totalItems / batchSize)
    {
        // 模拟耗时计算（每批次约 15ms）
        Thread.sleep(dur!("msecs")(15));

        int startIdx = batch * batchSize + 1;
        int endIdx = (batch + 1) * batchSize;
        int percent = cast(int)((cast(float)endIdx / totalItems) * 100);
        if (percent > 100) percent = 100;

        string status = format("正在加载数据 %d ~ %d / %d", startIdx, endIdx, totalItems);
        ownerTid.send(immutable TaskProgress(percent, status));
    }

    // 模拟最终数据处理
    Thread.sleep(dur!("msecs")(50));
    ownerTid.send(immutable TaskComplete(format("成功加载 %d 条数据", totalItems)));
}

void main()
{
    initLogger(LogLevel.trace);
    auto app = new Application();
    auto window = app.createWindow(100, 50, 700, 500, "AsyncTask Demo — 后台数据加载");

    // ── UI 布局 ──
    auto menuBar = new MenuBar(window);
    menuBar.add("File");
    menuBar.add("Help");

    auto container = new ScrollableContainer(window);
    container.contentHeight(2000);

    // 标题
    auto titleLabel = new Label(container, "AsyncTask 异步任务演示");
    titleLabel.dock = DockStyle.None;
    titleLabel.setXY(20, 20);
    titleLabel.width(500);
    titleLabel.height(32);

    // 说明
    auto descLabel = new Label(container, "后台线程加载数据，UI 保持响应");
    descLabel.dock = DockStyle.None;
    descLabel.setXY(20, 56);
    descLabel.width(500);
    descLabel.height(24);
    descLabel.textColor(0x00666666);

    // 进度显示
    auto progressLabel = new Label(container, "进度: 0%");
    progressLabel.dock = DockStyle.None;
    progressLabel.setXY(20, 96);
    progressLabel.width(300);
    progressLabel.height(28);

    auto statusLabel = new Label(container, "状态: 初始化...");
    statusLabel.dock = DockStyle.None;
    statusLabel.setXY(20, 130);
    statusLabel.width(600);
    statusLabel.height(24);

    // 文本进度条（用字符模拟）
    auto barLabel = new Label(container, "[                                                  ]");
    barLabel.dock = DockStyle.None;
    barLabel.setXY(20, 164);
    barLabel.width(600);
    barLabel.height(24);

    // 耗时统计
    auto timeLabel = new Label(container, "耗时: 0.0s");
    timeLabel.dock = DockStyle.None;
    timeLabel.setXY(20, 198);
    timeLabel.width(200);
    timeLabel.height(24);

    // 数据列表区域
    auto listHeader = new Label(container, "已加载数据预览:");
    listHeader.dock = DockStyle.None;
    listHeader.setXY(20, 240);
    listHeader.width(300);
    listHeader.height(24);

    Label[] dataLabels;
    const int MAX_VISIBLE_ITEMS = 12;
    foreach (i; 0 .. MAX_VISIBLE_ITEMS)
    {
        auto lbl = new Label(container, "");
        lbl.dock = DockStyle.None;
        lbl.setXY(40, 268 + i * 24);
        lbl.width(580);
        lbl.height(22);
        dataLabels ~= lbl;
    }

    // ── 启动异步任务 ──
    // 1. 使用 spawn 创建后台线程（std.concurrency）
    const int totalItems = 500;
    auto workerTid = spawn(&dataLoaderWorker, thisTid, totalItems);

    // 2. 包装为 AsyncTask（提供轮询接口）
    auto task = new AsyncTask(workerTid);

    // ── 进度回调 ──
    import std.datetime.stopwatch : StopWatch, AutoStart;
    auto sw = StopWatch(AutoStart.yes);
    int lastShownBatch = -1;

    void onProgress()
    {
        int pct = task.progress();
        string status = task.status();

        progressLabel.text(format("进度: %d%%", pct));
        statusLabel.text("状态: " ~ status);

        // 更新文本进度条
        int filled = pct * 50 / 100;
        string bar = "[";
        foreach (i; 0 .. 50)
            bar ~= (i < filled) ? "=" : " ";
        bar ~= "]";
        barLabel.text(bar);

        // 更新耗时
        auto elapsed = sw.peek.total!"msecs" / 1000.0;
        timeLabel.text(format("耗时: %.1fs", elapsed));

        // 更新数据列表（每 20 条更新一次显示）
        int currentBatch = pct * totalItems / 100 / 20;
        if (currentBatch > lastShownBatch)
        {
            lastShownBatch = currentBatch;
            foreach (i; 0 .. MAX_VISIBLE_ITEMS)
            {
                int itemNum = currentBatch * 20 + i + 1;
                if (itemNum <= totalItems)
                {
                    float value = 3.14159 + itemNum * 0.001;
                    dataLabels[i].text(format("  [%03d] 记录 #%d  =>  值: %.4f", itemNum, itemNum, value));
                }
                else
                {
                    dataLabels[i].text("");
                }
            }
        }

        window.requestRedraw();
    }

    // ── 完成回调 ──
    void onComplete()
    {
        // 更新 UI 为完成状态
        progressLabel.text("进度: 100% — 完成!");
        progressLabel.textColor(0x00209A00);
        statusLabel.text("状态: " ~ task.result());
        timeLabel.text(timeLabel.text() ~ " — 完成");
        window.requestRedraw();

        // 延迟截图，截图完成后自动关闭
        window.scheduleScreenshotAndClose(600, "async_demo_result.bmp");
    }

    // ── 启动 ──
    window.show();

    // 启动异步任务轮询（50ms 间隔）
    window.startAsyncTask(task, &onProgress, &onComplete);

    app.run();
    logInfo("=== AsyncTask Demo Exited ===");
}
