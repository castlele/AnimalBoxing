import Engine

final class GameLoop {

    private let drawingEngine: DrawingEngine

    private var currentScene = Scene.playground
    private var currentSceneView: ScenePrimitive2D

    init(engine: DrawingEngine) {
        drawingEngine = engine
        currentSceneView = currentScene.createScene(engine: engine)
    }

    func draw() {
        currentSceneView.draw()
    }

    func update() {
        currentSceneView.update()
    }
}
