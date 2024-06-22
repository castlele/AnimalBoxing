import Engine

final class GameLoop {

    private var currentScene = Scene.playground
    private lazy var currentSceneView = currentScene.scene

    // TODO: Separate start and update methods
    func start() {
        currentSceneView.start()
    }
}
