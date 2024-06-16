//
//  TicketsListRouter.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol TicketsListScreenRouterProtocol: AnyObject {
    func backToSelectedCountryScreen()
}

final class TicketsListScreenRouter: TicketsListScreenRouterProtocol {
    
    //MARK: Properties
    weak var viewController: TicketsListScreenViewController?
    
    //MARK: Methods
    func backToSelectedCountryScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
