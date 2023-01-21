//
//  KatamerosRepository.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.12.22.
//

import Foundation
import Combine

protocol ToutbabahatorRepositoryType { // a.k.a. gateway
    func getSynaxars() -> AnyPublisher<[Synaxar], Error>
    func getReadings() -> AnyPublisher<[Reading], Error>
}

struct ToutbabahatorRepository: ToutbabahatorRepositoryType {
    let apiClient: ToutbabahatorAPIType
    
    public func getSynaxars() -> AnyPublisher<[Synaxar], Error> {
        return apiClient.getSynaxars()
    }
    public func getReadings() -> AnyPublisher<[Reading], Error> {
        return apiClient.getReadings()
    }
}
