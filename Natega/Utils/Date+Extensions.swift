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
        let dateFormatter = DateFormatter()
        let calendar = Calendar(identifier: .coptic)
        dateFormatter.locale = Locale.init(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        dateFormatter.eraSymbols = ["", ""]
        dateFormatter.calendar = calendar
        return dateFormatter.string(from: Date())
    }
}
