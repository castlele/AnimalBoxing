enum Scene {
    case playground

    var scene: SceneView {
        switch self {
        case .playground: PlaygroundScene()
        }
    }
}
