//
//  MainViewRouter.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol MainScreenRouterProtocol: AnyObject {
    func openSearchScreen()
}

protocol SearchScreenRouterDelegateProtocol: AnyObject {
    func openSelectedCountryScreen()
}

final class MainScreenRouter: MainScreenRouterProtocol {
    
    //MARK: Properties
    var viewController: MainScreenViewController?
    
    //MARK: Methods
    func openSearchScreen() {
        let serachViewController = SearchScreenModuleBuilder().build(with: self)
        viewController?.showSearchView(with: serachViewController)
    }
}

//MARK: SearchScreenRouterDelegateProtocol
extension MainScreenRouter: SearchScreenRouterDelegateProtocol {
    func openSelectedCountryScreen() {
        let selectedCountryViewController = SelectedCountryScreenModuleBuilder().build()
        viewController?.navigationController?.pushViewController(
            selectedCountryViewController,
            animated: true
        )
    }
}
