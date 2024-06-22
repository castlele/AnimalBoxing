import Cocoa
import OSInfo

@main
final class Application {
    static func main() {
        let gameLoop = GameLoop()

        #if os(macOS)
        MacOSMain.run(gameLoop.start)
        #else
        fatalError("Platform \(OS.current.name) unsupported")
        #endif
    }
}
