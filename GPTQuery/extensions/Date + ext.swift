import Foundation

//MARK: -  Разница между двумя днями
extension Date {
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        
        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
}


//MARK: - получение отформатированного промежутка от необходимой даты до текущей
extension Date {
    func getIntervalFromToCurrentDate(date: Date, locale: Locale = Locale(identifier: "en_GB")) -> String {
        let interval = Date() - date
        
        switch interval.day ?? 0 {
        case let x where (x > 10) || (x < 2) :
            let relativeDateFormatter = DateFormatter()
            relativeDateFormatter.timeStyle = .none
            relativeDateFormatter.dateStyle = .medium
            relativeDateFormatter.locale = locale
            relativeDateFormatter.doesRelativeDateFormatting = true
            
            return relativeDateFormatter.string(from: date)
        case 2...10 :
            let relativeDateFormatter = RelativeDateTimeFormatter()
            relativeDateFormatter.unitsStyle = .full

            return relativeDateFormatter.localizedString(for: date, relativeTo: Date())
        default:
            return "unknown date"
        }
    }
}
