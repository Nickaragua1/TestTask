//
//  TicketsListScreenResponse.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import Foundation

struct TicketsListScreenResponse: Codable {
    let tickets: [Ticket]
}

struct Ticket: Codable {
    let id: Int
    let badge: String?
    let price: Price
    let providerName, company: String
    let departure, arrival: Arrival
    let hasTransfer, hasVisaTransfer: Bool
    let luggage: Luggage
    let handLuggage: HandLuggage
    let isReturnable, isExchangable: Bool

    enum CodingKeys: String, CodingKey {
        case id, badge, price
        case providerName = "provider_name"
        case company, departure, arrival
        case hasTransfer = "has_transfer"
        case hasVisaTransfer = "has_visa_transfer"
        case luggage
        case handLuggage = "hand_luggage"
        case isReturnable = "is_returnable"
        case isExchangable = "is_exchangable"
    }
}

struct Arrival: Codable {
    let town: Town
    let date: String
    let airport: Airport
}

enum Airport: String, Codable {
    case aer = "AER"
    case vko = "VKO"
}

enum Town: String, Codable {
    case москва = "Москва"
    case сочи = "Сочи"
}

struct HandLuggage: Codable {
    let hasHandLuggage: Bool
    let size: String?

    enum CodingKeys: String, CodingKey {
        case hasHandLuggage = "has_hand_luggage"
        case size
    }
}

struct Luggage: Codable {
    let hasLuggage: Bool
    let price: Price?

    enum CodingKeys: String, CodingKey {
        case hasLuggage = "has_luggage"
        case price
    }
}

