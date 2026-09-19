import Foundation
import SwiftData

#if DEBUG
/// In-memory sample data for Xcode previews only
/// Usage in a preview:  SomeView().modelContainer(PreviewData.container)
@MainActor
enum PreviewData {
    static let container: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: MediaItem.self, LogEntry.self,
                                            configurations: config)
        insertSamples(into: container.mainContext)
        return container
    }()

    private static func insertSamples(into context: ModelContext) {
        let book = MediaItem(title: "A Deepness in the Sky", type: .book, creator: "Verner Vinge")
        let show = MediaItem(title: "Mobile Suit Victory Gundam", type: .show)
        let movie = MediaItem(title: "Odyssey", type: .movie)
        let planned = MediaItem(title: "Fire Emblem: Fortune's Weave", type: .game)
        [book, show, movie, planned].forEach { context.insert($0) }

        func day(_ daysAgo: Int) -> Date {
            Calendar.current.date(byAdding: .day, value: -daysAgo, to: .now) ?? .now
        }

        context.insert(LogEntry(item: book, on: day(0), amount: 30))
        context.insert(LogEntry(item: book, on: day(1)))                    // no amount
        context.insert(LogEntry(item: show, on: day(0), amount: 2))
        context.insert(LogEntry(item: show, on: day(0), note: "Watched again"))  // same item, same day
        context.insert(LogEntry(item: movie, on: day(3), isFinish: true))   // finished
        context.insert(LogEntry(item: book, on: day(5), amount: 45))
    }

    static var sampleItem: MediaItem {
        try! container.mainContext.fetch(FetchDescriptor<MediaItem>()).first!
    }

    static var sampleEntries: [LogEntry] {
        (try? container.mainContext.fetch(FetchDescriptor<LogEntry>())) ?? []
    }
}
#endif
