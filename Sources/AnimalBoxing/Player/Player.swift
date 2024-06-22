import Engine

final class Player: BaseDrawingPrimitive2D {

    init() {
        super.init(drawingEngine: .raylib)

        size = Size(100, 50)
        position = DVector2D.zero
        backgroundColor = DrawingColor.red
    }
}
