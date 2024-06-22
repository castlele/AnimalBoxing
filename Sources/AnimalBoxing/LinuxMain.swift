#if os(Linux)
import Engine

enum LinuxMain {
    static func run(_ gameLoop: @escaping () -> Void) {
        LinuxApplication.run(gameLoop)
    }
}

private class LinuxApplication {

    private let windowManager = WindowManager()
    private var gameLoop: (() -> Void)?

    private init() {}

    static func run(_ gameLoop: @escaping () -> Void) {
        let app = LinuxApplication()
        app.gameLoop = gameLoop

        app.run()
    }

    private func run() {
        let mainWindow = RaylibWindow(800, 600, "AnimalBoxing")
        mainWindow.draw = gameLoop
        windowManager.set(mainWindow: mainWindow)
        windowManager.update()
    }
}
#endif
