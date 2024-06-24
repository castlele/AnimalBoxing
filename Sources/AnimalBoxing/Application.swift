import Engine
import OSInfo

@main
final class Application {
    static func main() {
        let gameLoop = GameLoop(engine: .raylib)

        #if os(macOS)
        MacOSMain.run(gameLoop)
        #elseif os(Linux)
        LinuxMain.run(gameLoop)
        #else
        fatalError("Platform \(OS.current.name) unsupported")
        #endif
    }
}
