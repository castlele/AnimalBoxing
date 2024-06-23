public protocol ScenePrimitive2D {
    var drawingEngine: DrawingEngine { get }
    var drawables: [DrawingPrimitive2D] { get }
    var backgroundColor: DrawingColor { get set }

    func draw()
    func update()
}
