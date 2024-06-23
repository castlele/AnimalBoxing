public final class DrawingEngine: Core {

    private var core: Core

    init(_ core: Core) {
        self.core = core
    }

    // MARK: - Mouse Events

    public func isLeftMouseButtonDown() -> Bool {
        core.isLeftMouseButtonDown()
    }

    public func isLeftMouseButtonUp() -> Bool {
        core.isLeftMouseButtonUp()
    }

    public func getMousePosition() -> DVector2D {
        core.getMousePosition()
    }

    // MARK: - Keyboard Events

    public func isKeyPressed(_ key: Key) -> Bool {
        core.isKeyPressed(key)
    }

    public func isKeyDown(_ key: Key) -> Bool {
        core.isKeyDown(key)
    }

    // MARK: - Drawing

    public func set(clearColor: DrawingColor) {
        core.set(clearColor: clearColor)
    }

    public func drawRectangle(
        x: Int,
        y: Int,
        width: Int,
        height: Int,
        color: DrawingColor
    ) {
        core.drawRectangle(
            x: x,
            y: y,
            width: width,
            height: height,
            color: color
        )
    }
}
