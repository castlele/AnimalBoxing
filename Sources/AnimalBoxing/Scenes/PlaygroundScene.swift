import Engine

final class PlaygroundScene: BaseScenePrimitive2D {

    let scene = Scene.playground

    private lazy var player = Player(drawingEngine: drawingEngine)
    private var isEditing = false
    private var isPlayerPinched = false

    init() {
        super.init(drawingEngine: .raylib)

        setup()
    }

    override func update() {
        super.update()

        let isControl = drawingEngine.isKeyDown(.leftControl)
        let isLetterB = drawingEngine.isKeyDown(.letterB)

        if isControl, isLetterB {
            player.isUserInteractionsEnabled.toggle()
            isEditing.toggle()
        }

        let pos = drawingEngine.getMousePosition()

        if isEditing, drawingEngine.isLeftMouseButtonDown() {

            if player.isPointInside(pos) {
                isPlayerPinched = true
            }
        }

        if drawingEngine.isLeftMouseButtonUp() {
            isPlayerPinched = false
        }

        if isPlayerPinched {
            player.position = pos
        }
    }

    // MARK: - Private Methods

    private func setup() {
        addDrawable(player)
    }
}
