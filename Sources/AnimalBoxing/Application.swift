import CastleEngine
import OSInfo

@main
final class ApplicationEntry {
    static let delegate = AnimalBoxingApplicationDelegate()

    static func main() {
        let app = Application()

        app.delegate = delegate

        app.run()
    }
}
