import OSInfo

@main
final class Application {
    static func main() {
        #if os(macOS)
        MacOSMain.run()
        #elseif os(Linux)
        LinuxMain.run()
        #else
        fatalError("Platform \(OS.current.name) unsupported")
        #endif
    }
}
