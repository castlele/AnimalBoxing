open class BaseScenePrimitive2D: ScenePrimitive2D {

    public var drawingEngine: DrawingEngine

    public private(set) var drawables = [DrawingPrimitive2D]()
    public var backgroundColor = DrawingColor.white

    public func addDrawable(_ drawable: DrawingPrimitive2D) {
        drawables.append(drawable)
    }

    public init(drawingEngine: DrawingEngine) {
        self.drawingEngine = drawingEngine
    }

    // MARK: - ScenePrimitive2D

    open func draw() {
        drawingEngine.set(clearColor: backgroundColor)

        drawables.forEach { $0.draw() }
    }

    open func update() {
        drawables.forEach { $0.update() }
    }
}
