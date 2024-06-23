import Engine

final class Player: BaseDrawingPrimitive2D {

    init() {
        super.init(drawingEngine: .raylib)

        size = Size(100, 50)
        position = DVector2D.zero
        backgroundColor = DrawingColor.red
    }

    override func update() {
        super.update()

        if KeyboardListener.raylib.isKeyPressed(.letterA) {
            position.x -= 10
        }

        if KeyboardListener.raylib.isKeyPressed(.letterD) {
            position.x += 10
        }
    }
}


