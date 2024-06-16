//
//  NetworkService.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func fetchData<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkingError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetchData<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkingError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.badResponse))
                return
            }
            guard  let resp = response as? HTTPURLResponse, resp.statusCode == 200, let
                    responseData = data else
            {
                completion(.failure(.badResponse))
                return
            }

            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(T.self, from: responseData)
                completion(.success(model))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

enum NetworkingError: Error {
    case badUrl
    case badRequest
    case badResponse
    case invalidData
}
