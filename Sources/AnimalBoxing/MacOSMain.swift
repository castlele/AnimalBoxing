#if os(macOS)
import Cocoa
import Engine

enum MacOSMain {
    static func run(_ gameLoop: GameLoop) {
        let delegate = AppDelegate(gameLoop)
        NSApplication.shared.delegate = delegate

        _ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
    }
}

// MARK: - AppDelegate

private final class AppDelegate: NSObject, NSApplicationDelegate {

    private let gameLoop: GameLoop
    private let windowManager = WindowManager()

    init(_ gameLoop: GameLoop) {
        self.gameLoop = gameLoop

        super.init()
    }

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
