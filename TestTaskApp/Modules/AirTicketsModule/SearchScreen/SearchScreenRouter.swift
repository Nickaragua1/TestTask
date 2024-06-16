//
//  SearchViewRouter.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation
import UIKit

protocol SearchScreenRouterProtocol: AnyObject {
    func openSelectedCountryScreen()
    func openStubView()
}

final class SearchScreenRouter: SearchScreenRouterProtocol {
    
    //MARK: Properties
    weak var viewController: SearchScreenViewController?
    weak var delegate: SearchScreenRouterDelegateProtocol?
    
    //MARK: Methods
    func openSelectedCountryScreen() {
        viewController?.dismiss(animated: true)
        delegate?.openSelectedCountryScreen()
    }
    
    func openStubView() {
        let buttonViewController = ButtonViewController()
        viewController?.navigationController?.pushViewController(
            buttonViewController,
            animated: true
        )
    }
}
