//
//  SelectedCountryScreenModel.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import UIKit

struct SelectedCountryScreenModel {
    
    //MARK: Properties
    let ticketsOffers: [TicketsOfferModel]
    let imageColors = [
        R.Color.horizontalStackFireButtonColor,
        R.Color.horizontalStackWeekendButtonColor,
        .white
    ]
    
    //MARK: Initializer
    init(model: SelectedCountryScreenResponse) {
        self.ticketsOffers = model.ticketsOffers.map { TicketsOfferModel(model: $0) }
    }
}

extension SelectedCountryScreenModel {
    struct TicketsOfferModel {
        let id: Int
        let title: String
        let timeRange: [String]
        let price: Int
        
        //MARK: Initializer
        init(model: TicketsOffer) {
            self.id = model.id
            self.title = model.title
            self.timeRange = model.timeRange
            self.price = model.price.value
        }
    }
}

struct FilterModel {
    var image: UIImage?
    var title: String
    var subtitle: String?
    var cellWidth: Int
}
