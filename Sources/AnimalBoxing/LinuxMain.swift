#if os(Linux)
import CastleEngine

enum LinuxMain {
    static func run(_ gameLoop: GameLoop) {
        LinuxApplication.run(gameLoop)
    }
}

private class LinuxApplication {

    private let gameLoop: GameLoop
    private let windowManager = WindowManager()

    private init(_ gameLoop: GameLoop) {
        self.gameLoop = gameLoop
    }

    static func run(_ gameLoop: GameLoop) {
        let app = LinuxApplication(gameLoop)

        app.run()
    }

    private func run() {
        let mainWindow = gameLoop.drawingEngine.initWIndow(
            800,
            600,
            "AnimalBoxing",
            nil
        )
        mainWindow.rootScene = gameLoop

        windowManager.set(mainWindow: mainWindow)
        windowManager.update()
    }
}
#endif
