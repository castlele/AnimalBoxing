public protocol Core {
    func set(clearColor: DrawingColor)
    func drawRectangle(
        x: Int,
        y: Int,
        width: Int,
        height: Int,
        color: DrawingColor
    )
}
