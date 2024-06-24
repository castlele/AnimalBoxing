public protocol Window: AnyObject {
    // TODO: Should be supported `ScenePrimitive3D`
    var rootScene: ScenePrimitive2D? { get set }
    var nativeCloseCallback: (() -> Void)? { get set }
    var shouldClose: Bool { get }
    var windowManager: WindowManager? { get set }
    var isHidden: Bool { get set }

    init(
        _ w: Int32,
        _ h: Int32,
        _ title: String,
        _ nativeCloseCallback: (() -> Void)?
    )

    func update()
    func close()
}

