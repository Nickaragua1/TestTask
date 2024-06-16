//
//  MainScreenModel.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

struct MainScreenModel {
    
    //MARK: Properties
    let offers: [OfferModel]
    let images = [R.Image.collectionViewFirstImage,
                  R.Image.collectionViewSecondImage,
                  R.Image.collectionViewThirdImage]
    
    //MARK: Initializer
    init(model: MainScreenResponse) {
        self.offers = model.offers.map { OfferModel(model: $0) }
    }
}

extension MainScreenModel {
    struct OfferModel {
        let id: Int
        let title, town: String
        let price: Int
        
        //MARK: Initializer
        init(model: Offer) {
            self.id = model.id
            self.title = model.title
            self.town = model.town
            self.price = model.price.value
        }
    }
}

