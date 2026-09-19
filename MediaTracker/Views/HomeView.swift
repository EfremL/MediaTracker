import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \LogEntry.createdAt) private var entries: [LogEntry]

    /// Called when the month card is tapped. RootView uses it to switch tabs,
    /// so HomeView doesn't need to know anything about the tab bar.
    var onOpenCalendar: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Button(action: onOpenCalendar) {
                        MonthSummaryCard(month: .now, entries: entries)
                    }
                    .buttonStyle(.plain)

                    // TODO (later): "Currently in progress" section, using
                    //       items where item.status == .inProgress
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView(onOpenCalendar: {})
        .modelContainer(PreviewData.container)
}
