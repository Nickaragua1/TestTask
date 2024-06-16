//
//  MainScreenService.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol MainScreenServiceProtocol {
    func fetchMainScreenData(completion: @escaping (Result<MainScreenModel, NetworkingError>) -> Void)
}

final class MainScreenService: MainScreenServiceProtocol {
    
    //MARK: Private properties
    private let networkService: NetworkService
    
    //MARK: Initializer
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    //MARK: Methods
    func fetchMainScreenData(completion: @escaping (Result<MainScreenModel, NetworkingError>) -> Void) {
        guard case let .success(request) = createRequest() else {
            completion(.failure(.badRequest))
            return
        }
        networkService.fetchData(request: request) { (result: Result<MainScreenResponse, NetworkingError>) in
            switch result {
            case .success(let response):
                let model = MainScreenModel(model: response)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension MainScreenService {
    
    func createRequest() -> Result<URLRequest, NetworkingError> {
        guard let url = URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd") else {
            return .failure(.badRequest)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return .success(request)
    }
}
