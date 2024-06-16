//
//  MainViewPresenter.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    var mainScreenData: MainScreenModel? { get }
    func didTextFieldTapped()
    func getMainScreenData()
    func storeData(with city: String)
    func loadData()
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
    
    //MARK: Properties
    var mainScreenData: MainScreenModel?

    weak var view: MainScreenViewControllerProtocol?
    
    //MARK: Private properties
    private let interactor: MainScreenInteractorProtocol
    private let router: MainScreenRouterProtocol
    
    //MARK: Initializer
    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: Methods
    func didTextFieldTapped() {
        router.openSearchScreen()
    }
    
    func getMainScreenData() {
        interactor.getMainScreenData { [weak self] model in
            guard let self else { return }
            DispatchQueue.main.async {
                self.mainScreenData = model
                self.updateMainView()
            }
        }
    }
    
    func storeData(with city: String) {
        interactor.storeData(with: city)
    }
    
    func loadData() {
        let fromCity = interactor.loadData()
        view?.updateFromTextField(with: fromCity)
    }
    
    //MARK: Private methods
    private func updateMainView() {
        view?.updateView()
    }
}
