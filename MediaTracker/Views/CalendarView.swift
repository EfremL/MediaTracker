import SwiftUI
import SwiftData

/// Lives in its own tab, so it owns its NavigationStack again.
struct CalendarView: View {
    @Query(sort: \LogEntry.createdAt) private var entries: [LogEntry]

    @State private var displayedMonth: Date = .now
    @State private var selectedDay: Date = Date().startOfDay
    @State private var showingAdd = false

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)

    private var entriesByDay: [Date: [LogEntry]] { entries.groupedByDay() }

    private var selectedDayEntries: [LogEntry] { entriesByDay[selectedDay] ?? [] }

    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                monthHeader
                weekdayHeader

                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(Array(displayedMonth.monthGridDays().enumerated()), id: \.offset) { _, day in
                        if let day {
                            DayCell(day: day,
                                    entries: entriesByDay[day] ?? [],
                                    isSelected: day == selectedDay,
                                    isToday: Calendar.current.isDateInToday(day))
                                .onTapGesture { selectedDay = day }
                        } else {
                            Color.clear.frame(height: 48)
                        }
                    }
                }
                .padding(.horizontal)

                Divider()

                DayEntriesList(day: selectedDay, entries: selectedDayEntries)
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showingAdd = true } label: { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddEntrySheet(day: selectedDay)
            }
        }
    }

    private var monthHeader: some View {
        HStack {
            Button { displayedMonth = displayedMonth.addingMonths(-1) } label: {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Text(displayedMonth, format: .dateTime.month(.wide).year())
                .font(.headline)
            Spacer()
            Button {displayedMonth = displayedMonth.addingMonths(1) } label: {
                Image(systemName: "chevron.right")
            }
        }
        .padding(.horizontal)
    }

    private var weekdayHeader: some View {
        // TODO: use Calendar.current.veryShortWeekdaySymbols, rotated to start at firstWeekday
        HStack {
            ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { symbol in
                Text(symbol).font(.caption).frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CalendarView()
        .modelContainer(PreviewData.container)
}
