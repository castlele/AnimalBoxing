#if os(macOS)
import Cocoa
import Engine
import RaylibC

enum MacOSMain {
    static func run(_ gameLoop: @escaping () -> Void) {
        let delegate = AppDelegate(gameLoop)
        NSApplication.shared.delegate = delegate

        _ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
    }
}

// MARK: - AppDelegate

private final class AppDelegate: NSObject, NSApplicationDelegate {

    private var windowManager = WindowManager()
    private var gameLoop: () -> Void

    init(_ gameLoop: @escaping () -> Void) {
        self.gameLoop = gameLoop
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        let mainWindow = RaylibWindow(800, 600, "AnimalBoxing")
        mainWindow.nativeCloseCallback = {
            NSApplication.shared.windows
                .filter {
                    $0 as? CocoaWindow == nil
                }
                .forEach {
                    $0.close()
                }

            exit(0)
        }

        windowManager.set(mainWindow: mainWindow)
        windowManager.debug()

        windowManager.update()
    }
}
#endif
