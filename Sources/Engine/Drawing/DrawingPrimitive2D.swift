public protocol DrawingPrimitive2D {
    var size: Size { get set }
    var position: DVector2D { get set }
    var drawingEngine: DrawingEngine { get }
    var backgroundColor: DrawingColor { get set }

    func start()
    func update()
}

// MARK: - Default Update

public extension DrawingPrimitive2D {
    func update() {
        drawingEngine.rectangle(
            x: Int(position.x),
            y: Int(position.y),
            width: Int(size.width),
            height: Int(size.height),
            color: backgroundColor
        )
    }
}
