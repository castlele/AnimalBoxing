public protocol ScenePrimitive2D {
    var drawables: [DrawingPrimitive2D] { get }
    var backgroundColor: DrawingColor { get set }

    func draw()
    func update()
}
