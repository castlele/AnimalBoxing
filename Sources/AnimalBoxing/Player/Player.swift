import Engine

final class Player: BaseDrawingPrimitive2D {

    public var isUserInteractionsEnabled = true

    override init(drawingEngine: DrawingEngine) {
        super.init(drawingEngine: drawingEngine)

        size = Size(100, 50)
        backgroundColor = DrawingColor.red
    }

    override func update() {
        super.update()

        guard isUserInteractionsEnabled else { return }

        if drawingEngine.isKeyDown(.letterA) {
            position.x -= 10
        }

        if drawingEngine.isKeyDown(.letterD) {
            position.x += 10
        }

        position.y += 10
    }
}
