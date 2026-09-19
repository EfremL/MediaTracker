import Foundation
import SwiftData

@Model
final class LogEntry {
    /// Normalized to start-of-day. This is what the calendar groups by.
    var day: Date
    /// Exact creation time. Used only to order multiple entries within one day.
    var createdAt: Date

    var amount: Int?            // optional: "I read this today" has no amount
    var note: String
    var isFinish: Bool          // true = this session finished the item

    var item: MediaItem?

    init(item: MediaItem, on date: Date = .now, amount: Int? = nil,
         note: String = "", isFinish: Bool = false) {
        self.item = item
        // NOTE: if the user changes time zone, stored days don't shift. Fine for v1.
        self.day = Calendar.current.startOfDay(for: date)
        self.createdAt = .now
        self.amount = amount
        self.note = note
        self.isFinish = isFinish
    }
}
