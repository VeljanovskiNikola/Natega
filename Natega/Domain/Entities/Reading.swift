//
//  Reading.swift
//  Natega
//
//  Created by Nikola Veljanovski on 30.12.22.
//

import Foundation
struct Reading: Codable, Identifiable {
    var id: UUID = UUID()
    let type: String
    let paulineEpistle, catholicEpistle, acts, psalm: Acts
    let prophecy: Int
    let gospel: Acts

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case paulineEpistle = "PaulineEpistle"
        case catholicEpistle = "CatholicEpistle"
        case acts = "Acts"
        case psalm = "Psalm"
        case prophecy = "Prophecy"
        case gospel = "Gospel"
    }
}

enum Acts: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Acts.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Acts"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
