import Engine

final class GameLoop {

    private var currentScene = Scene.playground
    private lazy var currentSceneView = currentScene.scene

    func draw() {
        currentSceneView.draw()
    }

    func update() {
        currentSceneView.update()
    }
}
