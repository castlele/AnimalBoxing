import CastleEngine
import OSInfo

@main
final class Application {
    static func main() {
        let gameLoop = GameLoop(drawingEngine: .raylib)

        #if os(macOS)
        MacOSMain.run(gameLoop)
        #elseif os(Linux)
        LinuxMain.run(gameLoop)
        #else
        fatalError("Platform \(OS.current.name) unsupported")
        #endif
    }
}
