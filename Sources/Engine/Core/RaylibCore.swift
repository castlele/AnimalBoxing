import Raylib

public final class RaylibCore: Core {

    public func set(clearColor: DrawingColor) {
        Raylib.clearBackground(clearColor.asRaylibColor)
    }

    public func drawRectangle(
        x: Int,
        y: Int,
        width: Int,
        height: Int,
        color: DrawingColor
    ) {
        Raylib.drawRectangle(
            Int32(x),
            Int32(y),
            Int32(width),
            Int32(height),
            color.asRaylibColor
        )
    }
}
