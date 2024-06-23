import Raylib

extension Key {
    var asRaylibKey: KeyboardKey {
        KeyboardKey(rawValue: rawValue) ?? .null
    }
}
