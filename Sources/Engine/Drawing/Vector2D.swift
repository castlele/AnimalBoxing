public struct Vector2D<T: Numeric> {

    public var x: T
    public var y: T

    public init(_ x: T, _ y: T) {
        self.x = x
        self.y = y
    }
}

// MARK: - Type aliases for inner types

public typealias DVector2D = Vector2D<Double>

// MARK: - Helpers

public extension DVector2D {
    static var zero: DVector2D {
        DVector2D(0, 0)
    }
}
