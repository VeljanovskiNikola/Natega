//
//  LoadSynaxarsUseCase.swift
//  Natega
//
//  Created by Nikola Veljanovski on 30.12.22.
//

import Foundation
import Combine

protocol LoadReadingsUseCaseType {
    func execute() -> AnyPublisher<[Reading], Error>
}

class LoadReadingsUseCase: LoadReadingsUseCaseType {
    let repository: ToutbabahatorRepositoryType
    
    init(repository: ToutbabahatorRepositoryType) {
        self.repository = repository
    }
    
    // execute request
    func execute() -> AnyPublisher<[Reading], Error> {
        self.repository.getReadings()
    }
}
