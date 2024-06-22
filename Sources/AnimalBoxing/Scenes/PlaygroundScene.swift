import Engine

final class PlaygroundScene: SceneView {

    let scene = Scene.playground

    private let player = Player()

    func start() {
        DrawingEngine.raylib.set(clearColor: .white)

        player.start()
        player.update()
    }
}
