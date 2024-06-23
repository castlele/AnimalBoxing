import Engine

final class Player: BaseDrawingPrimitive2D {

    public var isUserInteractionsEnabled = true

    override init(drawingEngine: DrawingEngine) {
        super.init(drawingEngine: drawingEngine)

        size = Size(100, 50)
        position = DVector2D.zero
        backgroundColor = DrawingColor.red
    }

    override func update() {
        super.update()

        guard isUserInteractionsEnabled else { return }

        if drawingEngine.isKeyPressed(.letterA) {
            position.x -= 10
        }

        if drawingEngine.isKeyPressed(.letterD) {
            position.x += 10
        }
    }
}
