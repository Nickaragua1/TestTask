//
//  SelectedCountryScreenService.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import Foundation

protocol SelectedCountryScreenServiceProtocol {
    func fetchSelectedCountryScreenData(completion: @escaping (Result<SelectedCountryScreenModel, NetworkingError>) -> Void)
}

final class SelectedCountryScreenService: SelectedCountryScreenServiceProtocol {
    
    //MARK: Private properties
    private let networkService: NetworkService
    
    //MARK: Initializer
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    //MARK: Methods
    func fetchSelectedCountryScreenData(completion: @escaping (Result<SelectedCountryScreenModel, NetworkingError>) -> Void) {
        guard case let .success(request) = createRequest() else {
            completion(.failure(.badRequest))
            return
        }
        networkService.fetchData(request: request) { (result: Result<SelectedCountryScreenResponse, NetworkingError>) in
            switch result {
            case .success(let response):
                let model = SelectedCountryScreenModel(model: response)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension SelectedCountryScreenService {
    
    func createRequest() -> Result<URLRequest, NetworkingError> {
        guard let url = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017") else {
            return .failure(.badRequest)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return .success(request)
    }
}
