//
//  SelectedCountryRouter.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol SelectedCountryScreenRouterProtocol: AnyObject {
    func backToMainScreen()
    func openTicketsListScreen()
}

final class SelectedCountryScreenRouter: SelectedCountryScreenRouterProtocol {
    
    //MARK: Properties
    weak var viewController: SelectedCountryScreenViewController?
    
    //MARK: Methods
    func backToMainScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func openTicketsListScreen() {
        let ticketsListViewController = TicketsListScreenModuleBuilder().build()
        viewController?.navigationController?.pushViewController(
            ticketsListViewController,
            animated: true
        )
    }
}
