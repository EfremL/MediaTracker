import Foundation
import SwiftData

@Model
final class MediaItem {
    var title: String
    var type: MediaType
    var creator: String
    var totalUnits: Int?        // optional: only used if you want progress bars
    var rating: Int?
    var notes: String
    var isDropped: Bool         // the one status that entries can't express
    var dateAdded: Date

    // Deleting an item deletes its entries (cascade).
    @Relationship(deleteRule: .cascade, inverse: \LogEntry.item)
    var entries: [LogEntry] = []

    init(title: String, type: MediaType, creator: String = "") {
        self.title = title
        self.type = type
        self.creator = creator
        self.notes = ""
        self.isDropped = false
        self.dateAdded = .now
    }

    // MARK: - Derived status (single source of truth = the entries)

    // Current rule: any finishing entry => Finished, and rewatching/rereading
    // does NOT move it back. TODO: decide if you want different behavior.
    var status: ItemStatus {
        if entries.contains(where: \.isFinish) { return .finished }
        if isDropped { return .dropped }
        return entries.isEmpty ? .planned : .inProgress
    }

    // TODO: date of most recent finishing entry (for sorting the Finished section)
    var lastFinishedDate: Date? { nil }

    // TODO: date of most recent entry of any kind (for "recents" in the add sheet)
    var lastLoggedDate: Date? { nil }

    // TODO: sum of amounts, ignoring entries where amount is nil
    var totalLoggedAmount: Int { 0 }
}
