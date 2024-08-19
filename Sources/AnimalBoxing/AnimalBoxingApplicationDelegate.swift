import CastleEngine
import Cocoa

final class AnimalBoxingApplicationDelegate: ApplicationDelegate {

    let gameLoop = GameLoop(drawingEngine: .raylib)
    private let windowManager = WindowManager()

    func onAppStarted() {
        let mainWindow = gameLoop.drawingEngine.initWindow(800, 600, "AnimalBoxing", nil)

        mainWindow.rootScene = gameLoop

        windowManager.set(mainWindow: mainWindow)
        windowManager.update()

    }

    func onAppClose() {
        print("World")
    }
}
