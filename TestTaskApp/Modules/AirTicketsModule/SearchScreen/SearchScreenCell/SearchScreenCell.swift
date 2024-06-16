//
//  SearchViewControllerCell.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import Foundation
import UIKit

final class SearchScreenCell: UITableViewCell {
    
    //MARK: Properties
    static let reuseId = "SearchViewControllerTableViewCell"
    
    //MARK: Private properties
    private let cityImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let cityName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 16
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.Color.primaryTableViewColor
        label.text = "Популярное направление"
        label.font = UIFont(
            name: R.Font.SFProDisplayRegular,
            size: 14
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func configureCell(with title: String, image: UIImage) {
        backgroundColor = .clear
        cityName.text = title
        cityImage.image = image
    }
    
    //MARK: Private methods
    private func setupLayouts() {
        addSubview(cityImage)
        addSubview(cityName)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            cityImage.heightAnchor.constraint(equalToConstant: 40),
            cityImage.widthAnchor.constraint(equalToConstant: 40),
            cityImage.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            cityImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            cityImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            cityName.topAnchor.constraint(equalTo: cityImage.topAnchor),
            cityName.leadingAnchor.constraint(equalTo: cityImage.trailingAnchor, constant: 5),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: cityImage.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: cityImage.trailingAnchor, constant: 5)
        ])
    }
}
