import Raylib

final class RaylibWindow: Window {

    var rootScene: ScenePrimitive2D?
    var nativeCloseCallback: (() -> Void)?
    var isHidden = false
    weak var windowManager: WindowManager?

    var shouldClose: Bool {
        Raylib.windowShouldClose
    }

    init(
        _ w: Int32,
        _ h: Int32,
        _ title: String,
        _ nativeCloseCallback: (() -> Void)?
    ) {
        self.nativeCloseCallback = nativeCloseCallback

        Raylib.initWindow(w, h, title)
    }

    func close() {
        if let nativeCloseCallback {
            nativeCloseCallback()
        } else {
            Raylib.closeWindow()
        }
    }

    func update() {
        Raylib.beginDrawing()

        rootScene?.update()
        rootScene?.draw()

        Raylib.endDrawing()
    }
}
