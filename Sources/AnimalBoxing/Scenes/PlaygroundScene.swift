import Engine

final class PlaygroundScene: BaseScenePrimitive2D {

    let scene = Scene.playground

    private let player = Player()

    override init() {
        super.init()

        setup()
    }

    // MARK: - Private Methods

    private func setup() {
        addDrawable(player)
    }
}
