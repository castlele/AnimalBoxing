public struct DrawingColor {

    public static let red = DrawingColor(1, 0, 0, 1)
    public static let blue = DrawingColor(0, 0, 1, 1)
    public static let green = DrawingColor(0, 1, 0, 1)
    public static let white = DrawingColor(1, 1, 1, 1)

    public let red: Double
    public let green: Double
    public let blue: Double
    public let alpha: Double

    init(_ r: Double, _ g: Double, _ b: Double, _ a: Double) {
        self.red = r
        self.green = g
        self.blue = b
        self.alpha = a
    }
}
