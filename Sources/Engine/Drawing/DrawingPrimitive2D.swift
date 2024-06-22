public protocol DrawingPrimitive2D {
    var size: Size { get set }
    var position: DVector2D { get set }
    var drawingEngine: DrawingEngine { get }
    var backgroundColor: DrawingColor { get set }

    func draw()
    func update()
}
