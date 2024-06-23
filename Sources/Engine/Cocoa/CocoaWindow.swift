#if os(macOS)
import Cocoa

final class DrawingView: NSView {
    override func draw(_ dirtyRect: NSRect) {
    }
}

final class MainViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let drawingView = DrawingView()

        view.addSubview(drawingView)
        drawingView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            drawingView.topAnchor.constraint(equalTo: view.topAnchor),
            drawingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            drawingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drawingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

final public class CocoaWindow: NSWindow, Window {

    public var updateCallback: (() -> Void)?
    public var drawCallback: (() -> Void)?
    public var shouldClose: Bool { false }
    public weak var windowManager: WindowManager?
    public var isHidden: Bool {
        get { _isHidden }
        set {
            _isHidden = newValue
            self.setIsVisible(!isHidden)

            if isVisible {
                self.center()
                self.makeKeyAndOrderFront(nil)
            }
        }
    }

    private var _isHidden = true

    public convenience init(_ w: Int32, _ h: Int32, _ title: String) {
        let windowRect = NSRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: Double(w), height: Double(h))
        )

        self.init(
            contentRect: windowRect,
            styleMask: [.resizable, .closable, .titled],
            backing: .buffered,
            defer: true
        )

        self.title = title
        setIsVisible(false)
    }

    public override func close() {
        isHidden.toggle()
    }

    public func set(content: NSViewController) {
    }

    public override func update() {
        super.update()

        if contentViewController == nil {
            set(content: NSViewController())
        }
    }
}

#endif
