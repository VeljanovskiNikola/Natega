//
//  Date+Extensions.swift
//  Natega
//
//  Created by Nikola Veljanovski on 21.12.22.
//

import Foundation
extension Date {
    // This date format is needed for the url.
    var formattedDateForAPI: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: Date())
    }
    
    func localDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let date = dateFormatter.date(from: dateFormatter.dateFormat)
        else { return Date() }
        return date
    }
    
    static func copticDate() -> String {
        let calendar = Calendar(identifier: .coptic)
        let date = Date()
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let monthName = calendar.monthSymbols[month - 1]

        return "\(monthName) \(day)"
    }
}
