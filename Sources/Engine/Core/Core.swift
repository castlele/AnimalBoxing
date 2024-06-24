public protocol Core {
    func initWindow(
        _ width: Int,
        _ height: Int,
        _ title: String,
        _ nativeCloseCallback: (() -> Void)?
    ) -> Window

    func isLeftMouseButtonDown() -> Bool
    func isLeftMouseButtonUp() -> Bool
    func getMousePosition() -> DVector2D

    func isKeyPressed(_ key: Key) -> Bool
    func isKeyDown(_ key: Key) -> Bool

    func set(clearColor: DrawingColor)
    func drawRectangle(
        x: Int,
        y: Int,
        width: Int,
        height: Int,
        color: DrawingColor
    )
}
