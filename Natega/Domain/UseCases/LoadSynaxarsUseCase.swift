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
    let repository: ToutbabahatorRepositoryType
    
    init(repository: ToutbabahatorRepositoryType) {
        self.repository = repository
    }
    
    // execute request
    func execute() -> AnyPublisher<[Synaxar], Error> {
        self.repository.getSynaxars()
    }
}
