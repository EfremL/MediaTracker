import Foundation

extension Sequence where Element == LogEntry {

    func groupedByDay() -> [Date: [LogEntry]] {
        Dictionary(grouping: self, by: {$0.day})
            .mapValues {entries in entries.sorted {$0.createdAt < $1.createdAt}}
    }
}
