import Raylib

final class RaylibCore: Core {

    // MARK: - Keyboard Listening

    func isKeyPressed(_ key: Key) -> Bool {
        Raylib.isKeyPressed(key.asRaylibKey)
    }

    // MARK: - Drawing

    func set(clearColor: DrawingColor) {
        Raylib.clearBackground(clearColor.asRaylibColor)
    }

    func drawRectangle(
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
