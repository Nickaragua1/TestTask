//
//  Int+Extension.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import Foundation

extension Int {
    func formattedIntToString() -> String? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        
        let number = NSNumber(integerLiteral: self)
        return formatter.string(from: number)
    }
}
