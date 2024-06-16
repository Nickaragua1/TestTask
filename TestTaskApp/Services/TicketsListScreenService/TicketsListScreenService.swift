//
//  TicketsListScreenService.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import Foundation

protocol TicketsListScreenServiceProtocol {
    func fetchTicketsListData(completion: @escaping (Result<TicketsListScreenModel, NetworkingError>) -> Void)
}

final class TicketsListScreenService: TicketsListScreenServiceProtocol {
    
    //MARK: Private properties
    private let networkService: NetworkService
    
    //MARK: Initializer
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    //MARK: Methods
    func fetchTicketsListData(completion: @escaping (Result<TicketsListScreenModel, NetworkingError>) -> Void) {
        guard case let .success(request) = createRequest() else {
            completion(.failure(.badRequest))
            return
        }
        networkService.fetchData(request: request) { (result: Result<TicketsListScreenResponse, NetworkingError>) in
            switch result {
            case .success(let response):
                let model = TicketsListScreenModel(model: response)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension TicketsListScreenService {
    
    func createRequest() -> Result<URLRequest, NetworkingError> {
        guard let url = URL(string: "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf") else {
            return .failure(.badRequest)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return .success(request)
    }
}
