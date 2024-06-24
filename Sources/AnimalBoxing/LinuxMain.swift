#if os(Linux)
import Engine

enum LinuxMain {
    static func run(_ gameLoop: GameLoop) {
        LinuxApplication.run(gameLoop)
    }
}

private class LinuxApplication {

    private let gameLoop: GameLoop
    private let windowManager = WindowManager()

    private init(_ gameLoop: GameLoop) {

    }

    static func run(_ gameLoop: GameLoop) {
        let app = LinuxApplication(gameLoop)

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
