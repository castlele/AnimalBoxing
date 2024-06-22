public final class DrawingEngine {

    private var core: Core

    init(_ core: Core) {
        self.core = core
    }

    public func set(clearColor: DrawingColor) {
        core.set(clearColor: clearColor)
    }

    public func rectangle(
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
