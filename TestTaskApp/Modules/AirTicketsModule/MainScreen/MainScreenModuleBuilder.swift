//
//  MainViewModuleBuilder.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

final class MainScreenModuleBuilder {
    
    func build() -> MainScreenViewController {
        let networkService = NetworkService()
        let storageService = StorageService()
        let mainScreenService = MainScreenService(networkService: networkService)
        let interactor = MainScreenInteractor(
            mainScreenService: mainScreenService,
            storageService: storageService
        )
        let router = MainScreenRouter()
        let presenter = MainScreenPresenter(
            interactor: interactor,
            router: router
        )
        let viewController = MainScreenViewController(presenter: presenter)
        presenter.view = viewController
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
