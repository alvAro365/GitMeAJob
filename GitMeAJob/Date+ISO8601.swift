//
//  Date+ISO8601.swift
//  GitMeAJob
//

import Foundation

extension Date {
    static func getJobPublishedDate(convertDate: String) -> String {
        let currentDateFormat = "E MMM d HH:mm:ssZ yyyy"
        let dateFormatter = DateFormatter()
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterPrint.dateFormat = "MMMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = currentDateFormat
        let dateWithHoursAndSeconds = dateFormatter.date(from: convertDate)
        let dateWithMonthDayYear = dateFormatterPrint.string(from: dateWithHoursAndSeconds!)
        
        return getPublishingDate(jobDate: dateWithHoursAndSeconds!, date: dateWithMonthDayYear)
    }
    
    private static func getPublishingDate(jobDate: Date, date: String) -> String {
        let currentDate = Date()
        let components = Set<Calendar.Component>([.day, .hour, .minute, .month, .year])
        let differenceOfDate = Calendar.current.dateComponents(components, from: jobDate, to: currentDate)
        let days = Int(differenceOfDate.day!)
        var dateLabelText = ""

        switch (days) {
        case 0:
            dateLabelText = "Today"
        case 1:
            dateLabelText = "Yesterday"
        default:
            if days >= 2 && days < 6 {
                dateLabelText = "About \(days) days ago"
            } else {
                dateLabelText = date
            }
        }
        return dateLabelText
    }
}
