import SwiftUI

struct DayCell: View {
    let day: Date
    let entries: [LogEntry]
    let isSelected: Bool
    let isToday: Bool

    private let maxMarkers = 4

       var body: some View {
           VStack(spacing: 3) {
               Text(day, format: .dateTime.day())
                   .font(.body)
                   .fontWeight(isToday ? .bold : .regular)
                   .foregroundStyle(isSelected ? Color.white : Color.primary)
                   .frame(width: 32, height: 32)
                   .background {
                       if isSelected {
                           Circle().fill(Color.accentColor)
                       } else if isToday {
                           Circle().strokeBorder(Color.accentColor, lineWidth: 1.5)
                       }
                   }

               markers
                   .frame(height: 8)
           }
           .frame(maxWidth: .infinity, minHeight: 48)
           .contentShape(Rectangle())
       }

       private var markers: some View {
           HStack(spacing: 3) {
               ForEach(entries.prefix(maxMarkers)) { entry in
                   marker(for: entry)
               }
               if entries.count > maxMarkers {
                   Text("+")
                       .font(.system(size: 8, weight: .bold))
                       .foregroundStyle(.secondary)
               }
           }
       }

       @ViewBuilder
       private func marker(for entry: LogEntry) -> some View {
           let color = entry.item?.type.color ?? .gray
           if entry.isFinish {
               Image(systemName: "checkmark.circle.fill")
                   .font(.system(size: 8))
                   .foregroundStyle(color)
           } else {
               Circle()
                   .fill(color)
                   .frame(width: 6, height: 6)
           }
       }
   }


#Preview {
    HStack {
        DayCell(day: .now, entries: [], isSelected: false, isToday: true)
        DayCell(day: .now, entries: Array(PreviewData.sampleEntries.prefix(3)),
                isSelected: true, isToday: false)
        DayCell(day: .now, entries: PreviewData.sampleEntries.filter(\.isFinish),
                isSelected: false, isToday: false)
    }
    .modelContainer(PreviewData.container)
}
