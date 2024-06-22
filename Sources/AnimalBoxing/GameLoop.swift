import Engine
import Raylib

final class GameLoop {
    func start() {
        print("Hello")
        Raylib.beginDrawing()
        Raylib.drawRectangle(0, 0, 100, 50, .green)
        Raylib.endDrawing()
    }
}
