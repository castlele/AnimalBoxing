import Engine

final class GameLoop: BaseScenePrimitive2D {

    private var currentScene = Scene.playground
    private var currentSceneView: ScenePrimitive2D

    override init(drawingEngine: DrawingEngine) {
        currentSceneView = currentScene.createScene(engine: drawingEngine)

        super.init(drawingEngine: drawingEngine)
    }

    override func draw() {
        currentSceneView.draw()
    }

    override func update() {
        currentSceneView.update()
    }
}
