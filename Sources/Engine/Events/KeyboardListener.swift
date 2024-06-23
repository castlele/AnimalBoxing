public final class KeyboardListener {

    private let core: Core

    init(_ core: Core) {
        self.core = core
    }

    public func isKeyPressed(_ key: Key) -> Bool {
        core.isKeyPressed(key)
    }
}
