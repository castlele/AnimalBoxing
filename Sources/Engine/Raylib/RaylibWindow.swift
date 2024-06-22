import Raylib

public final class RaylibWindow: Window {

    public var draw: (() -> Void)?
    public var shouldClose: Bool {
        Raylib.windowShouldClose
    }

    #if os(macOS)
    public var nativeCloseCallback: (() -> Void)?
    #endif

    public weak var windowManager: WindowManager?
    public var isHidden = false

    public init(_ w: Int32, _ h: Int32, _ title: String) {
        Raylib.initWindow(w, h, title)
    }

    public func close() {
        #if os(macOS)
        if let nativeCloseCallback {
            nativeCloseCallback()
        } else {
            Raylib.closeWindow()
        }
        #else
        Raylib.closeWindow()
        #endif
    }

    public func update() {
        Raylib.beginDrawing()
        Raylib.clearBackground(.red)

        if Raylib.isKeyDown(.letterB) {
            windowManager?.showDebugWindows()
        }

        draw?()

        Raylib.endDrawing()
    }
}
