//
//  LoadJsonUseCase.swift
//  Natega
//
//  Created by Nikola Veljanovski on 12.3.23.
//

import Combine


protocol LoadJsonUseCaseProtocol {
    func execute<T: Decodable>(fileName: String) -> AnyPublisher<T, Error>
}

class LoadJsonUseCase: LoadJsonUseCaseProtocol {
    let repository: JSONRepositoryProtocol
    init(repository: JSONRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute<T>(fileName: String) -> AnyPublisher<T, Error> where T : Decodable {
        repository.loadJson(from: fileName)
    }
}
