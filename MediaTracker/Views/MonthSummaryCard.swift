import SwiftUI

/// Compact month overview shown on Home. Purely display: it receives its data.
struct MonthSummaryCard: View {
    let month: Date
    let entries: [LogEntry]

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)

    private var entriesThisMonth: [LogEntry] {
        entries.filter { Calendar.current.isDate($0.day, equalTo: month, toGranularity: .month) }
    }

    private var entriesByDay: [Date: [LogEntry]] { entries.groupedByDay() }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(month, format: .dateTime.month(.wide).year())
                        .font(.title2.bold())
                    Text("\(entriesThisMonth.count) entries this month")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }

            // TODO: mini grid. Reuse month.monthGridDays(); for each day show the
            //       number, and a small dot if entriesByDay[day] has entries.
            //       Highlight today.
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(Array(month.monthGridDays().enumerated()), id: \.offset) { _, day in
                    if let day {
                        Text(day, format: .dateTime.day())
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                        // TODO: dot when !(entriesByDay[day] ?? []).isEmpty
                    } else {
                        Color.clear.frame(height: 1)
                    }
                }
            }
        }
        .padding()
        .background(.background.secondary, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    MonthSummaryCard(month: .now, entries: PreviewData.sampleEntries)
        .padding()
        .modelContainer(PreviewData.container)
}
