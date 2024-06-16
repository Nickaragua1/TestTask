//
//  SelectedCountryModuleBuilder.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

final class SelectedCountryScreenModuleBuilder {
    
    func build() -> SelectedCountryScreenViewController {
        let networkService = NetworkService()
        let storageService = StorageService()
        let selectedCountryScreenService = SelectedCountryScreenService(networkService: networkService)
        let interactor = SelectedCountryScreenInteractor(
            selectedCountryScreenService: selectedCountryScreenService,
            storageService: storageService
        )
        let router = SelectedCountryScreenRouter()
        let presenter = SelectedCountryScreenPresenter(
            interactor: interactor,
            router: router
        )
        let viewController = SelectedCountryScreenViewController(presenter: presenter)
        presenter.view = viewController
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
