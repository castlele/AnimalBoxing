public protocol Core {
    func isKeyPressed(_ key: Key) -> Bool

    func set(clearColor: DrawingColor)
    func drawRectangle(
        x: Int,
        y: Int,
        width: Int,
        height: Int,
        color: DrawingColor
    )
}
