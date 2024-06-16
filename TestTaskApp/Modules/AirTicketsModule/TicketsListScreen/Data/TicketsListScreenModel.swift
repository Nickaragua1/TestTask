//
//  TicketsListScreenModel.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import Foundation

struct TicketsListScreenModel {
    
    //MARK: Properties
    let tickets: [TicketModel]

    //MARK: Initializer
    init(model: TicketsListScreenResponse) {
        self.tickets = model.tickets.map {TicketModel(model: $0)}
    }
}

extension TicketsListScreenModel {
    struct TicketModel {
        let id: Int
        let badge: String?
        let price: Int
        var departure, arrival: String?
        let departureAirport, arrivalAirport: String
        let hasTransfer: Bool
        var flightTime: String?
        
        //MARK: Initializer
        init(model: Ticket) {
            self.id = model.id
            self.badge = model.badge
            self.price = model.price.value
            self.arrivalAirport = model.arrival.airport.rawValue
            self.departureAirport = model.departure.airport.rawValue
            self.hasTransfer = model.hasTransfer
            self.departure = getHours(from: model.departure.date)
            self.arrival = getHours(from: model.arrival.date)
            self.flightTime = getFlightTime(from: model.departure.date, toDate: model.arrival.date) + "ч в пути"
        }
        
        //MARK: Methods
        func getFlightTime(from fromDate: String, toDate: String) -> String {
            guard let fromDate = fromDate.getDate(),
                  let toDate = toDate.getDate() else { return "" }
            
            let flightTime = fromDate.distance(to: toDate) / 3600
            return String(flightTime.rounded(toPlaces: 1))
        }
        
        func getHours(from date: String) -> String {
            guard let date = date.getDate() else { return "" }
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"

            let timeString = formatter.string(from: date)
            return timeString
        }
    }
}
