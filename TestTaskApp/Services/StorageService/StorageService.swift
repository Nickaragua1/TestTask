//
//  StorageService.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import Foundation

protocol StorageServiceProtocol {
    func setBase(_ object: String, forKey key: StorageService.Keys)
    func loadBase(forKey key: StorageService.Keys) -> String
}

class StorageService {
    
    public enum Keys: String {
        case selectedFromCity
        case selectedToCity
        case thereDate
    }
    
    //MARK: Private properties
    private let userDefaults = UserDefaults.standard
    
    private func storeBase(_ object: String, key: String) {
        let data = try? JSONEncoder().encode(object)
        userDefaults.setValue(data, forKey: key)
    }
    
    //MARK: Private methods
    private func restoreBase(forKey key: String) -> String {
        guard let data = userDefaults.data(forKey: key) else 
        { return "" }
        
        guard let city = try? JSONDecoder().decode(String.self, from: data) else
        { return "" }
        return city
    }
}

//MARK: StorageServiceProtocol
extension StorageService: StorageServiceProtocol {
    
    func setBase(_ object: String, forKey key: Keys) {
        storeBase(object, key: key.rawValue)
    }
    
    func loadBase(forKey key: Keys) -> String {
        restoreBase(forKey: key.rawValue)
    }
}
