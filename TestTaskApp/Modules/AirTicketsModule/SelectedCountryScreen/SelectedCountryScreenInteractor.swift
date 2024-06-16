//
//  SelectedCountryInteractor.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol SelectedCountryScreenInteractorProtocol: AnyObject {
    func getSelectedCountryScreenData(completion: @escaping (SelectedCountryScreenModel) -> Void) 
    func loadFromCity() -> String
    func loadToCity() -> String
    func storeData(with fromCity: String, toCity: String)
    func storeThereDate(with: String)
}

final class SelectedCountryScreenInteractor: SelectedCountryScreenInteractorProtocol {
    
    //MARK: Properties
    let selectedCountryScreenService: SelectedCountryScreenServiceProtocol
    let storageService: StorageServiceProtocol
    
    weak var presenter: SelectedCountryScreenPresenter?

    //MARK: Initializer
    init(selectedCountryScreenService: SelectedCountryScreenServiceProtocol, 
         storageService: StorageServiceProtocol) {
        self.selectedCountryScreenService = selectedCountryScreenService
        self.storageService = storageService
    }
    
    //MARK: Methods
    func getSelectedCountryScreenData(completion: @escaping (SelectedCountryScreenModel) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            self.selectedCountryScreenService.fetchSelectedCountryScreenData { result in
                switch result {
                case .success(let model):
                    completion(model)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func loadFromCity() -> String {
        storageService.loadBase(forKey: .selectedFromCity)
    }
    
    func loadToCity() -> String {
        storageService.loadBase(forKey: .selectedToCity)
    }
    
    func storeData(with fromCity: String, toCity: String) {
        storageService.setBase(fromCity, forKey: .selectedFromCity)
        storageService.setBase(toCity, forKey: .selectedToCity)
    }
    
    func storeThereDate(with: String) {
        storageService.setBase(with, forKey: .thereDate)
    }
}
