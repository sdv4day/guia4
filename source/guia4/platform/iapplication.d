module guia4.platform.iapplication;

interface IPlatformApplication
{
    // Run the main message loop (blocking)
    int run();

    // Request to quit the application
    void quit(int exitCode = 0);

    // Process a single message (non-blocking)
    // Returns false if no more messages / should quit
    bool processMessage();
}