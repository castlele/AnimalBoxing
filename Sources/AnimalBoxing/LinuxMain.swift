#if os(Linux)
import Engine

enum LinuxMain {
    static func run() {
        LinuxApplication.run()
    }
}

private class LinuxApplication {

    private let windowManager = WindowManager()
    private let gameLoop = GameLoop()

    private init() {}

    static func run() {
        let app = LinuxApplication()

        app.run()
    }

    private func run() {
        let mainWindow = RaylibWindow(800, 600, "AnimalBoxing")
        mainWindow.drawCallback = gameLoop.draw
        mainWindow.updateCallback = gameLoop.update

        windowManager.set(mainWindow: mainWindow)
        windowManager.update()
    }
}
#endif
