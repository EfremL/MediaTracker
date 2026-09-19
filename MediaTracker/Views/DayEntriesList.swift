import SwiftUI
import SwiftData

struct DayEntriesList: View {
    @Environment(\.modelContext) private var context

    let day: Date
    let entries: [LogEntry]

    var body: some View {
        List {
            if entries.isEmpty {
                Text("Nothing logged. Tap + to add something.")
                    .foregroundStyle(.secondary)
            }
            ForEach(entries) { entry in
                // TODO: row = type icon, item title, optional amount + unit,
                //       optional note, and a "Finished" badge if entry.isFinish
                // TODO: tap to edit (amount / note / isFinish)
                Text(entry.item?.title ?? "Unknown")
            }
            .onDelete { offsets in
                // TODO: delete the entries at these offsets via context.delete
            }
        }
        .listStyle(.plain)
    }
}
#Preview("With entries") {
    DayEntriesList(day: .now, entries: PreviewData.sampleEntries)
        .modelContainer(PreviewData.container)
}
 
#Preview("Empty") {
    DayEntriesList(day: .now, entries: [])
        .modelContainer(PreviewData.container)
}
