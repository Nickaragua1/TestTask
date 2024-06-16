//
//  TicketsListInteractor.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol TicketsListScreenInteractorProtocol: AnyObject {
    func getTicketsListScreenData(completion: @escaping (TicketsListScreenModel) -> Void)
    func loadFromCity() -> String
    func loadToCity() -> String
    func loadThereDate() -> String
}

final class TicketsListScreenInteractor: TicketsListScreenInteractorProtocol {
    
    //MARK: Properties
    let ticketListScreenService: TicketsListScreenServiceProtocol
    let storageService: StorageServiceProtocol
    
    weak var presenter: TicketsListScreenPresenter?

    //MARK: Initializer
    init(ticketListScreenService: TicketsListScreenServiceProtocol, 
         storageService: StorageServiceProtocol) {
        self.ticketListScreenService = ticketListScreenService
        self.storageService = storageService
    }
    
    //MARK: Methods
    func getTicketsListScreenData(completion: @escaping (TicketsListScreenModel) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            self.ticketListScreenService.fetchTicketsListData { result in
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
    
    func loadThereDate() -> String {
        storageService.loadBase(forKey: .thereDate)
    }
}
