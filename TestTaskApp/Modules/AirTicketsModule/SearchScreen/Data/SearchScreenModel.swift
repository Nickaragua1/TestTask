//
//  SearchScreenModel.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import UIKit

struct SearchScreenModel {
    
    //MARK: Properties
    let popularDirections = [
        PopularDirection(cityName: "Стамбул", image: R.Image.searchScreenFirstImage),
        PopularDirection(cityName: "Сочи", image: R.Image.searchScreenSecondImage),
        PopularDirection(cityName: "Пхукет", image: R.Image.searchScreenThirdImage)
    ]
}

extension SearchScreenModel {
    struct PopularDirection {
        let cityName: String
        let image: UIImage
    }
}
