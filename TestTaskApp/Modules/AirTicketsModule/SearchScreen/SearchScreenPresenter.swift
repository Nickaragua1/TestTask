//
//  SearchViewPresenter.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol SearchScreenPresenterProtocol: AnyObject {
    var searchScreenData: SearchScreenModel? { get }
    func textFieldDidTapped()
    func didTapButton()
    func updateToTextField(with cityName: String)
    func loadData()
    func storeData(with fromCity: String, and toCity: String)}

final class SearchScreenPresenter: SearchScreenPresenterProtocol {
    
    //MARK: Properties
    var searchScreenData: SearchScreenModel?
    
    weak var view: SearchScreenViewControllerProtocol?
    
    //MARK: Private properties
    private let interactor: SearchScreenInteractorProtocol
    private let router: SearchScreenRouterProtocol
    
    //MARK: Initializer
    init(interactor: SearchScreenInteractorProtocol, router: SearchScreenRouterProtocol, searchScreenData: SearchScreenModel) {
        self.interactor = interactor
        self.router = router
        self.searchScreenData = searchScreenData
    }
    
    //MARK: Methods
    func textFieldDidTapped() {
        router.openSelectedCountryScreen()
    }
    
    func didTapButton() {
        router.openStubView()
    }
    
    func updateToTextField(with cityName: String) {
        view?.updateToTextField(with: cityName)
    }
    
    func loadData() {
        let fromCity = interactor.loadData()
        view?.updateFromTextField(with: fromCity)
    }
    
    func storeData(with fromCity: String, and toCity: String) {
        interactor.storeData(with: fromCity, toCity: toCity)
    }
}
