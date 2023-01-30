//
//  LoadSynaxarsUseCase.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.12.22.
//

import Foundation
import Combine

protocol LoadSynaxarsUseCaseType {
    func execute() -> AnyPublisher<[Synaxar], Error>
}

class LoadSynaxarsUseCase: LoadSynaxarsUseCaseType {
    let repository: KatamerosRepositoryType
    
    init(repository: KatamerosRepositoryType) {
        self.repository = repository
    }
    
    // execute request
    func execute() -> AnyPublisher<[Synaxar], Error> {
        return Future<[Synaxar], Error> { promise in
            promise(.success([]))
        }
        .eraseToAnyPublisher()
    }
}
