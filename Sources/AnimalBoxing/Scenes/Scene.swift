import Engine

enum Scene {
    case playground

    var scene: ScenePrimitive2D {
        switch self {
        case .playground: PlaygroundScene()
        }
    }
}
