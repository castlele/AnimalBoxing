#if os(macOS)
import Cocoa
import Engine
import RaylibC

enum MacOSMain {
    static func run() {
        let delegate = AppDelegate()
        NSApplication.shared.delegate = delegate

        _ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
    }
}

// MARK: - AppDelegate

private final class AppDelegate: NSObject, NSApplicationDelegate {

    private let windowManager = WindowManager()
    private let gameLoop = GameLoop()

    func applicationDidFinishLaunching(_ notification: Notification) {
        let mainWindow = RaylibWindow(800, 600, "AnimalBoxing")
        mainWindow.drawCallback = gameLoop.draw
        mainWindow.updateCallback = gameLoop.update
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
