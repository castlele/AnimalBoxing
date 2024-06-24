public final class WindowManager {

    private var mainWindow: (any Window)?
    private var debugWindows = [any Window]()

    public var isDebugWindowAvailable: Bool {
        false
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

    public func update() {
        guard let mainWindow else {
            fatalError("You should call `initMainWindow(_:_:_:)` first")
        }

        while !mainWindow.shouldClose {
            mainWindow.update()
            debugWindows.forEach { $0.update() }
        }

        debugWindows.forEach { $0.close() }
        mainWindow.close()
    }
}
