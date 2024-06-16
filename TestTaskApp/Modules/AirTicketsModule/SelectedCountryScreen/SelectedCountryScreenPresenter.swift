//
//  SelectedCountryPresenter.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol SelectedCountryScreenPresenterProtocol: AnyObject {
    var selectedCountryScreenData: SelectedCountryScreenModel? { get }
    var filters: [FilterModel] { get }
    
    func backButtonTapped()
    func ticketsButonTapped()
    func getSelectedCountryScreenData() 
    func updateTableView()
    func loadData()
    func storeData(with fromCity: String, and toCity: String)
    func updateDateCell(with date: String, weekday: String)
    func updatePlusCell(with date: String, weekday: String)
}

final class SelectedCountryScreenPresenter: SelectedCountryScreenPresenterProtocol {
    
    //MARK: Properties
    weak var view: SelectedCountryScreenViewControllerProtocol?
    
    var selectedCountryScreenData: SelectedCountryScreenModel?
    var filters = [FilterModel(image: R.Image.selectedCountryCollectionViewPlusImage,
                               title: "Обратно",
                               subtitle: nil,
                               cellWidth: 105),
                   FilterModel(image: nil,
                               title: "24 фев",
                               subtitle: ", сб",
                               cellWidth: 95),
                   FilterModel(image: R.Image.selectedCountryCollectionViewProfileImage,
                               title: "1,эконом",
                               subtitle: nil,
                               cellWidth: 104),
                   FilterModel(image: R.Image.selectedCountryCollectionViewFilterImage,
                               title: "Фильтры",
                               subtitle: nil,
                               cellWidth: 115)]
    
    
    //MARK: Private properties
    private let interactor: SelectedCountryScreenInteractorProtocol
    private let router: SelectedCountryScreenRouterProtocol
    
    //MARK: Initializer
    init(interactor: SelectedCountryScreenInteractorProtocol, 
         router: SelectedCountryScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: Methods
    func updateDateCell(with date: String, weekday: String) {
        filters[1].title = date
        filters[1].subtitle = ", " + weekday
        view?.updateCollectionView()
        interactor.storeThereDate(with: date)
    }
    
    func updatePlusCell(with date: String, weekday: String) {
        filters[0].title = date
        filters[0].subtitle = ", " + weekday
        filters[0].image = nil
        filters[0].cellWidth = 95
        view?.updateCollectionView()
    }
    
    func backButtonTapped() {
        router.backToMainScreen()
    }
    
    func ticketsButonTapped() {
        router.openTicketsListScreen()
    }
    
    func getSelectedCountryScreenData() {
        interactor.getSelectedCountryScreenData { model in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.selectedCountryScreenData = model
                updateTableView()
            }
        }
    }
    
    func updateTableView() {
        view?.updateTableView()
    }

    func loadData() {
        let fromCity = interactor.loadFromCity()
        let toCity = interactor.loadToCity()
        view?.updateTextFields(with: fromCity, and: toCity)
    }
    
    func storeData(with fromCity: String, and toCity: String) {
        interactor.storeData(with: fromCity, toCity: toCity)
    }
}
