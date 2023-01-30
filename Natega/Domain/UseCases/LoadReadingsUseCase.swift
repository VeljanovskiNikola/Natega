//
//  LoadReadingsUseCase.swift
//  Natega
//
//  Created by Nikola Veljanovski on 30.12.22.
//

import Foundation
import Combine

protocol LoadReadingsUseCaseType {
    func execute() -> AnyPublisher<Feast, Error>
}

class LoadReadingsUseCase: LoadReadingsUseCaseType {
    let repository: KatamerosRepositoryType
    
    init(repository: KatamerosRepositoryType) {
        self.repository = repository
    }
    
    // execute request
    func execute() -> AnyPublisher<Feast, Error> {
        self.repository.getReadings()
    }
}
