import SwiftUI
import SwiftData

@main
struct MediaTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [MediaItem.self, LogEntry.self])
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewData.container)
}
