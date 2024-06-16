//
//  MainScreenDTO.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

struct MainScreenResponse: Codable {
    let offers: [Offer]
}

struct Offer: Codable {
    let id: Int
    let title, town: String
    let price: Price
}

struct Price: Codable {
    let value: Int
}
