//
//  SearchViewModuleBuilder.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

final class SearchScreenModuleBuilder {
    
    func build(with delegate: SearchScreenRouterDelegateProtocol) -> SearchScreenViewController {
        let storageService = StorageService()
        let interactor = SearchScreenInteractor(storageService: storageService)
        let router = SearchScreenRouter()
        let searchScreenData = SearchScreenModel()
        router.delegate = delegate
        let presenter = SearchScreenPresenter(
            interactor: interactor,
            router: router,
            searchScreenData: searchScreenData
        )
        let viewController = SearchScreenViewController(presenter: presenter)
        presenter.view = viewController
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
