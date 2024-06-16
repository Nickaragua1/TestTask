//
//  Double+Extensions.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
