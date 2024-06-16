//
//  Date+Extension.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 15.06.2024.
//

import Foundation

extension String {
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
    
    enum ValidTypes {
        case enterCity
    }
    
    enum Regex: String {
        case regex = "[\\s\\b\\rа-яА-Я-]{1,}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .enterCity: regex = Regex.regex.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
