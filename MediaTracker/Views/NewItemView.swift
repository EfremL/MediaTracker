import SwiftUI
import SwiftData

struct NewItemView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    /// Called after the item is created, so callers can log it immediately.
    var onCreate: (MediaItem) -> Void = { _ in }

    @State private var type: MediaType = .book
    @State private var title = ""
    @State private var creator = ""

    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(MediaType.allCases) { Text($0.label).tag($0) }
                }
                TextField("Title", text: $title)
                TextField("Creator (optional)", text: $creator)
                // TODO: optional total units, if you want progress bars
            }
            .navigationTitle("New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        // TODO: create MediaItem, insert, call onCreate, dismiss
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
#Preview {
    NewItemView()
        .modelContainer(PreviewData.container)
}
