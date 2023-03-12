//
//  IconModel.swift
//  Natega
//
//  Created by Nikola Veljanovski on 12.3.23.
//

import Foundation

struct IconModel: Decodable {
    let copticDate, feastName, liturgicalInformation: String
    let saintIcon: [String]
    let upcomingEvents: [UpcomingEvent]
    let year: String
}

struct UpcomingEvent: Decodable {
    let name, time: String
}
