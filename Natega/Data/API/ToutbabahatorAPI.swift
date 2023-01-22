//
//  ToutbabahatorAPI.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.12.22.
//

import Foundation
import Combine

protocol ToutbabahatorAPIType {
    func getSynaxars() -> AnyPublisher<[Synaxar], Error>
    func getReadings() -> AnyPublisher<[Reading], Error>
}

struct ToutbabahatorAPI: ToutbabahatorAPIType {
    private var cancellables = Set<AnyCancellable>()
        
    func getSynaxars() -> AnyPublisher<[Synaxar], Error> {
        let url = constructURL(for: .synaxar)
        let publisher = URLSession.shared.dataTaskPublisher(for: url!)
        return publisher
            .map(\.data)
            .replaceError(with: Data())
            .decode(type: [Synaxar].self, decoder: JSONDecoder())
            .print()
            .eraseToAnyPublisher()
    }
    
    func getReadings() -> AnyPublisher<[Reading], Error> {
        let url = constructURL(for: .readings)
        let publisher = URLSession.shared.dataTaskPublisher(for: url!)
        return publisher
            .map(\.data)
            .replaceError(with: Data())
            .decode(type: [Reading].self, decoder: JSONDecoder())
            .print()
            .eraseToAnyPublisher()
    }
    
    // MARK: - Helpers
    private func constructURL(for type: ReadingType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "toutbabahator.com"
        components.path = "/toutbabahator.php"
        components.queryItems = [URLQueryItem(name: "choice", value: type == .readings ? "readings" : "synaxar")]
        return components.url
    }
    
    private enum ReadingType: String {
        case readings
        case synaxar
    }
}
