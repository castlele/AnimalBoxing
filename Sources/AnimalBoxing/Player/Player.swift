import Engine

final class Player: DrawingPrimitive2D {

    let drawingEngine = DrawingEngine.raylib

    var size = Size(100, 50)
    var position = DVector2D.zero
    var backgroundColor = DrawingColor.red

    private var isStarted = false

    func start() {
        guard isStarted else {
            // TODO: Start methods should run only once in the future
            // fatalError("")
            return
        }

        isStarted = true
    }
}
