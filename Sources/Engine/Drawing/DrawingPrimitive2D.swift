public protocol DrawingPrimitive2D {
    var drawingEngine: DrawingEngine { get }
    var size: Size { get set }
    var position: DVector2D { get set }
    var backgroundColor: DrawingColor { get set }

    func draw()
    func update()

    func isPointInside(_ point: DVector2D) -> Bool
}
