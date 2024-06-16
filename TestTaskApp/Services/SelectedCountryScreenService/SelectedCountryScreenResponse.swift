//
//  SelectedCountryScreenResponse.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import Foundation

struct SelectedCountryScreenResponse: Codable {
    let ticketsOffers: [TicketsOffer]

    enum CodingKeys: String, CodingKey {
        case ticketsOffers = "tickets_offers"
    }
}

struct TicketsOffer: Codable {
    let id: Int
    let title: String
    let timeRange: [String]
    let price: Price

    enum CodingKeys: String, CodingKey {
        case id, title
        case timeRange = "time_range"
        case price
    }
}
