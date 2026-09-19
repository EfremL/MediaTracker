import SwiftUI
import SwiftData

struct LibraryView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \MediaItem.title) private var items: [MediaItem]

    @State private var search = ""
    @State private var showingNewItem = false

    // TODO: filter by `search`
    private var filtered: [MediaItem] { items }

    var body: some View {
        NavigationStack {
            List {
                // TODO: one Section per ItemStatus (In Progress, Planned, Finished, Dropped),
                //       skipping empty ones. Sort Finished by lastFinishedDate.
                ForEach(filtered) { item in
                    NavigationLink(value: item) {
                        Text(item.title)   // TODO: shared row view
                    }
                }
                // TODO: swipe to delete, with a confirmation (it deletes the item's entries)
            }
            .navigationTitle("Library")
            .searchable(text: $search)
            .navigationDestination(for: MediaItem.self) { ItemDetailView(item: $0) }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showingNewItem = true } label: { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $showingNewItem) { NewItemView() }
        }
    }
}
#Preview {
    LibraryView()
        .modelContainer(PreviewData.container)
}
