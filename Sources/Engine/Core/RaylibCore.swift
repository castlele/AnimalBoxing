import Raylib

final class RaylibCore: Core {

    // MARK: - Mouse Listening

    func isLeftMouseButtonDown() -> Bool {
        Raylib.isMouseButtonDown(.left)
    }

    func isLeftMouseButtonUp() -> Bool {
        Raylib.isMouseButtonUp(.left)
    }

    func getMousePosition() -> DVector2D {
        Raylib.getMousePosition().toDVector2D
    }

    // MARK: - Keyboard Listening

    func isKeyPressed(_ key: Key) -> Bool {
        Raylib.isKeyPressed(key.asRaylibKey)
    }

    func isKeyDown(_ key: Key) -> Bool {
        Raylib.isKeyDown(key.asRaylibKey)
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

// MARK: - Helpers

private extension Vector2 {
    var toDVector2D: DVector2D {
        // TODO: May be we should use FVector2D?
        DVector2D(Double(x), Double(y))
    }
}
