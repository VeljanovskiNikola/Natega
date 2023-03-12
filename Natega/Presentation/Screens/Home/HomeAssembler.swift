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
        let apiClient = KatamerosAPI()
        let repository = KatamerosRepository(apiClient: apiClient)
        let readingsCase = LoadReadingsUseCase(repository: repository)
        let jsonApiClient = JSONManager()
        let jsonRepository = JSONRepository(apiClient: jsonApiClient)
        let jsonCase = LoadJsonUseCase(repository: jsonRepository)
        let viewModel = HomeViewModel(readingsCase: readingsCase, loadJsonCase: jsonCase)
        return HomeView(viewModel: viewModel)
    }
}
