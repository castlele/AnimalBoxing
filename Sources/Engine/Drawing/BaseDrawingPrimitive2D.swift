open class BaseDrawingPrimitive2D: DrawingPrimitive2D {

    public var drawingEngine: DrawingEngine
    public var size = Size.zero
    public var position = DVector2D.zero
    public var backgroundColor = DrawingColor.white

    public init(drawingEngine: DrawingEngine) {
        self.drawingEngine = drawingEngine
    }

    open func update() {
    }

    open func draw() {
        drawingEngine.drawRectangle(
            x: Int(position.x),
            y: Int(position.y),
            width: Int(size.width),
            height: Int(size.height),
            color: backgroundColor
        )
    }

    open func isPointInside(_ point: DVector2D) -> Bool {
        let isInsideX = point.x >= position.x && point.x <= position.x + size.width
        let isInsideY = point.y >= position.y && point.y <= position.y + size.height

        return isInsideX && isInsideY
    }
}
