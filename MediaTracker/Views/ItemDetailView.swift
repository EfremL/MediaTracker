import SwiftUI
import SwiftData

struct ItemDetailView: View {
    @Bindable var item: MediaItem

    // TODO: entries sorted newest first (by day, then createdAt)
    private var sortedEntries: [LogEntry] { item.entries }

    var body: some View {
        Form {
            Section {
                // TODO: derived status (read-only), rating, "dropped" toggle bound to item.isDropped
                Text(item.status.label)
            }
            Section("Notes") {
                TextField("Notes", text: $item.notes, axis: .vertical)
            }
            Section("History") {
                // TODO: list entries with date, optional amount, note, and finished marker
                // TODO: allow editing isFinish on an entry after the fact
                ForEach(sortedEntries) { entry in
                    Text(entry.day.formatted(date: .abbreviated, time: .omitted))
                }
            }
        }
        .navigationTitle(item.title)
        // TODO: toolbar button: "I did this today" one-tap log
    }
}
#Preview {
    NavigationStack {
        ItemDetailView(item: PreviewData.sampleItem)
    }
    .modelContainer(PreviewData.container)
}
