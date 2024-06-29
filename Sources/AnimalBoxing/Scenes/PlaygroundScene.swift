import CastleEngine

final class PlaygroundScene: BaseScenePrimitive2D {

    let scene = Scene.playground

    private lazy var player = Player(drawingEngine: drawingEngine)
    private var isEditing = false
    private var isPlayerPinched = false

    // TODO: Better approaches?
    private let map = [
        ["", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", ""],
        ["x", "x", "x", "x", "x", "x", "x", "x"],
    ]

    override init(drawingEngine: DrawingEngine) {
        super.init(drawingEngine: drawingEngine)

        setup()
    }

    override func update() {
        super.update()

        resetSceneIfNeeded()
        updatePhysics()

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

    override func draw() {
        super.draw()

        // TODO: refactor
        map.enumerated().forEach { rowIndex, row in
            row.enumerated().forEach { columnIndex, column in
                if column == "x" {
                    drawingEngine.drawRectangle(
                        x: 100 * columnIndex,
                        y: 100 * rowIndex,
                        width: 100,
                        height: 100,
                        color: .green
                    )
                }
            }
        }
    }

    // MARK: - Private Methods

    private func setup() {
        resetScene()
        addDrawable(player)
    }

    private func updatePhysics() {
        let maxY = player.position.y + player.size.height

        // TODO: Should be count depending on the screen size
        if maxY > 500 {
            player.position.y = 500 - player.size.height
        }
    }

    private func resetSceneIfNeeded() {
        let isControl = drawingEngine.isKeyDown(.leftControl)
        let isLetterR = drawingEngine.isKeyDown(.letterR)

        if isControl, isLetterR {
            resetScene()
        }
    }

    private func resetScene() {
        player.position = DVector2D.zero
    }
}
