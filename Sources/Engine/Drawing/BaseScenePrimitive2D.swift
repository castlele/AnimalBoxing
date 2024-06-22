open class BaseScenePrimitive2D: ScenePrimitive2D {

    public private(set) var drawables = [DrawingPrimitive2D]()
    public var backgroundColor = DrawingColor.white

    public func addDrawable(_ drawable: DrawingPrimitive2D) {
        drawables.append(drawable)
    }

    public init() { }

    // MARK: - ScenePrimitive2D

    open func draw() {
        DrawingEngine.raylib.set(clearColor: .white)

        drawables.forEach { $0.draw() }
    }

    open func update() {
        drawables.forEach { $0.update() }
    }
}
