//
//  HomeAssembler.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.12.22.
//

import Foundation

protocol HomeAssembler {
    func resolve() -> HomeView
}

class HomeViewAssembler: HomeAssembler { }

extension HomeViewAssembler {
    func resolve() -> HomeView {
        let apiClient = ToutbabahatorAPI()
        let repository = ToutbabahatorRepository(apiClient: apiClient)
        let synaxarsCase = LoadSynaxarsUseCase(repository: repository)
        let readingsCase = LoadReadingsUseCase(repository: repository)
        let viewModel = HomeViewModel(synaxarsCase: synaxarsCase,
                                      readingsCase: readingsCase)
        return HomeView(viewModel: viewModel)
    }
}
