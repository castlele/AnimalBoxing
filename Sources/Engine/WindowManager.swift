public final class WindowManager {

    private var mainWindow: (any Window)?
    private var debugWindows = [any Window]()

    public var isDebugWindowAvailable: Bool {
        #if DEBUG

        #if os(macOS)
        true
        #else
        false
        #endif

        #else
        false
        #endif
    }

    public init() {}

    public func set(mainWindow: any Window) {
        self.mainWindow = mainWindow
        self.mainWindow?.windowManager = self
    }

    public func showDebugWindows() {
        guard isDebugWindowAvailable else { return }

        debugWindows.forEach { $0.isHidden = false }
    }

    public func debug() {
        #if os(macOS)
        let window = CocoaWindow(800, 600, "Hello, World!")
        debugWindows.append(window)
        #endif
    }

    public func update(gameLoop: (() -> Void)? = nil) {
        guard let mainWindow else {
            fatalError("You should call `initMainWindow(_:_:_:)` first")
        }

        while !mainWindow.shouldClose {
            mainWindow.update()
            gameLoop?()
            debugWindows.forEach { $0.update() }
        }

        debugWindows.forEach { $0.close() }
        mainWindow.close()
    }
}
