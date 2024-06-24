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
        let mainWindow = gameLoop.drawingEngine.initWindow(800, 600, "AnimalBoxing") {
            NSApplication.shared.windows
                .forEach {
                    $0.close()
                }

            exit(0)
        }

        mainWindow.rootScene = gameLoop

        windowManager.set(mainWindow: mainWindow)
        windowManager.update()
    }
}
#endif
