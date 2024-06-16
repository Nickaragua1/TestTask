//
//  UITextField+Extensions.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import UIKit

public extension UITextField {

    override var textInputMode: UITextInputMode? {
        let locale = Locale(identifier: "ru_RU") // your preferred locale
        let mode = UITextInputMode.activeInputModes.first(where: { $0.primaryLanguage == locale.language.languageCode?.identifier })
        return mode ?? super.textInputMode
    }
}
