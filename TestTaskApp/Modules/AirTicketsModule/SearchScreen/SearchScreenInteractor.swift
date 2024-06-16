//
//  SearchViewInteractor.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol SearchScreenInteractorProtocol: AnyObject {
    func loadData() -> String
    func storeData(with fromCity: String, toCity: String)}

final class SearchScreenInteractor: SearchScreenInteractorProtocol {
    
    //MARK: Properties
    let storageService: StorageServiceProtocol
    
    weak var presenter: SearchScreenPresenter?

    //MARK: Initializer
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    //MARK: Methods
    func loadData() -> String {
        storageService.loadBase(forKey: .selectedFromCity)
    }
    
    func storeData(with fromCity: String, toCity: String) {
        storageService.setBase(fromCity, forKey: .selectedFromCity)
        storageService.setBase(toCity, forKey: .selectedToCity)
    }
}
