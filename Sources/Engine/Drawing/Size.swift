public struct Size {
    public let width: Double
    public let height: Double

    public init (_ w: Double, _ h: Double) {
        width = w
        height = h
    }
}

// MARK: - Helpers

public extension Size {
    static var zero = Size(0, 0)
}
