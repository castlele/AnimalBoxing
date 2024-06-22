public protocol Window: AnyObject {
    var draw: (() -> Void)? { get set }
    var shouldClose: Bool { get }
    var windowManager: WindowManager? { get set }
    var isHidden: Bool { get set }

    init(_ w: Int32, _ h: Int32, _ title: String)

    func close()
    func update()
}

