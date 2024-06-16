//
//  MainViewInteractor.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol MainScreenInteractorProtocol: AnyObject {
    func getMainScreenData(completion: @escaping (MainScreenModel) -> Void)
    func storeData(with city: String)
    func loadData() -> String
}

final class MainScreenInteractor: MainScreenInteractorProtocol {
    
    //MARK: Properties
    let mainScreenService: MainScreenServiceProtocol
    let storageService: StorageServiceProtocol
    
    weak var presenter: MainScreenPresenter?
    
    //MARK: Initializer
    init(mainScreenService: MainScreenServiceProtocol,
         storageService: StorageServiceProtocol) {
        self.mainScreenService = mainScreenService
        self.storageService = storageService
    }
    
    //MARK: Methods
    func getMainScreenData(completion: @escaping (MainScreenModel) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            self.mainScreenService.fetchMainScreenData { result in
                switch result {
                case .success(let model):
                    completion(model)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func storeData(with city: String) {
        storageService.setBase(city, forKey: .selectedFromCity)
    }
    
    func loadData() -> String {
        storageService.loadBase(forKey: .selectedFromCity)
    }
}
