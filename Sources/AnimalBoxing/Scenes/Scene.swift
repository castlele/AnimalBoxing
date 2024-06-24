import Engine

enum Scene {
    case playground

    func createScene(engine: DrawingEngine) -> ScenePrimitive2D {
        switch self {
        case .playground: PlaygroundScene(drawingEngine: engine)
        }
    }
}
