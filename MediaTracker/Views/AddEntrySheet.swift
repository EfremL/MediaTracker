import SwiftUI
import SwiftData

/// Goal: fewest taps. Tapping an item logs it immediately for `day`.
/// Details (amount, note, finished) are optional extras.
struct AddEntrySheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \MediaItem.dateAdded, order: .reverse) private var items: [MediaItem]

    let day: Date

    @State private var search = ""
    @State private var showDetails = false
    @State private var amount: Int?
    @State private var note = ""
    @State private var isFinish = false
    @State private var showingNewItem = false

    // TODO: order = in-progress first, then recently logged, then everything else;
    //       apply `search` filter to title
    private var visibleItems: [MediaItem] { items }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    DisclosureGroup("Details (optional)", isExpanded: $showDetails) {
                        TextField("Amount", value: $amount, format: .number)
                            .keyboardType(.numberPad)
                        TextField("Note", text: $note, axis: .vertical)
                        Toggle("Mark as finished", isOn: $isFinish)
                    }
                }

                Section("Items") {
                    ForEach(visibleItems) { item in
                        Button { log(item) } label: {
                            // TODO: reuse a shared row view (icon, title, creator)
                            Text(item.title)
                        }
                    }
                    Button("New item…") { showingNewItem = true }
                }
            }
            .searchable(text: $search)
            .navigationTitle("Add to \(day.formatted(.dateTime.month().day()))")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .sheet(isPresented: $showingNewItem) {
                NewItemView { newItem in
                    // TODO: optionally log the new item right away
                }
            }
        }
    }

    private func log(_ item: MediaItem) {
        // TODO: create LogEntry(item:on:amount:note:isFinish:), insert into context, dismiss.
        //       Allow multiple entries for the same item on the same day.
    }
}

#Preview {
    AddEntrySheet(day: .now)
        .modelContainer(PreviewData.container)
}
