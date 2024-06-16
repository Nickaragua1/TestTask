//
//  TicketsListModuleBuilder.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

final class TicketsListScreenModuleBuilder {
    
    func build() -> TicketsListScreenViewController {
        let networlService = NetworkService()
        let storageService = StorageService()
        let ticketsListService = TicketsListScreenService(networkService: networlService)
        let interactor = TicketsListScreenInteractor(
            ticketListScreenService: ticketsListService,
            storageService: storageService
        )
        let router = TicketsListScreenRouter()
        let presenter = TicketsListScreenPresenter(
            interactor: interactor,
            router: router
        )
        let viewController = TicketsListScreenViewController(presenter: presenter)
        presenter.view = viewController
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
