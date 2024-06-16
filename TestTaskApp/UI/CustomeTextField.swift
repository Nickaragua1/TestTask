//
//  CustomeTextField.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import UIKit

final class CustomeTextField: UITextField {
    
    //MARK: Properties
    let insets: UIEdgeInsets
    let enterCityValidType: String.ValidTypes = .enterCity
    
    //MARK: Initializer
    init(placeholder: String,insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Override methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    //MARK: Private methods
    private func setupTextField(placeholder: String) {
        textColor = .white
        self.placeholder = placeholder
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: R.Color.unselectedBarItemColor,
                         NSAttributedString.Key.font: UIFont(
                            name: R.Font.SFProDisplaySemibold,
                            size: 16) ?? UIFont()]
        )
        font = UIFont(name: R.Font.SFProDisplaySemibold, size: 16)
    }
    
    //MARK: Methods
     func setTextField(
        textField: UITextField,
        validType: String.ValidTypes,
        string: String,
        range: NSRange
    ) -> Bool {
        
        if string.isValid(validType: validType) {
            return true
        } else {
            let text = (textField.text ?? "")
            let result: String
            
            if range.length == 1 {
                let end = text.index(text.startIndex, offsetBy: text.count - 1)
                result = String(text[text.startIndex..<end])
            } else {
                result = text
            }
            textField.text = result
            return false
        }
    }
}
