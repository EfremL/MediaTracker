import Foundation

extension Date {
    var startOfDay: Date { Calendar.current.startOfDay(for: self) }

    func monthGridDays() -> [Date?] {
        let calendar = Calendar.current
        
        guard let firstDay = calendar.dateInterval(of: .month, for: self)?.start,
                let dayCount = calendar.range(of: .day, in: .month, for: self)?.count
        else {
            return []
        }
        let weekday = calendar.component(.weekday, from: firstDay)
        let leadingBlanks = (weekday - calendar.firstWeekday+7) % 7
        
        let blanks: [Date?] = Array(repeating: nil, count: leadingBlanks)
        let days: [Date?] = (0..<dayCount).map {offset in calendar.date(byAdding: .day, value: offset, to: firstDay)}
        
        return blanks + days
        
    }

    func addingMonths(_ value: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: value, to: self) ?? self
    }
}
