import Raylib

extension DrawingColor {
    var asRaylibColor: Color {
        Color(
            r: UInt8(red * 255),
            g: UInt8(green * 255),
            b: UInt8(blue * 255),
            a: UInt8(alpha * 255)
        )
    }
}
