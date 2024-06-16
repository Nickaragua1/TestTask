//
//  CustomeTextFieldButton.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import UIKit

final class CustomeTextFieldButton: UIButton {
    
    //MARK: Initializer
    init(image: UIImage) {
        super.init(frame: .zero)
        setupButton(with: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func setupButton(with image: UIImage) {
        setImage(image, for: .normal)
        tintColor = R.Color.unselectedBarItemColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 24).isActive = true
        widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
}
