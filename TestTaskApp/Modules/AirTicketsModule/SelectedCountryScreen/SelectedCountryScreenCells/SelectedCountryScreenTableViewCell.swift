//
//  SelectedCountryTableViewCell.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import Foundation
import UIKit

final class SelectedCountryScreenTableViewCell: UITableViewCell {
    
    //MARK: Properties
    static let reuseId = "SelectedCountryTableViewCell"
    
    //MARK: Private properties
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let companyName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplayRegular,
            size: 14
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.Color.horizontalStackAnywhereButtonColor
        label.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image?.withTintColor(.blue)
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayouts()
        self.backgroundColor = R.Color.selectedCountryTableViewColor
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func configureCell(
        with model: SelectedCountryScreenModel.TicketsOfferModel,
        color: UIColor) {
        guard let priceText = model.price.formattedIntToString() else { return }
        backgroundColor = .clear
        companyName.text = model.title
        timeLabel.text = model.timeRange.reduce("", { result, time in
            result + time + " "
        })
        priceLabel.text = priceText + " ₽"
        image.backgroundColor = color
    }
    
    //MARK: Private methods
    private func setupLayouts() {
        addSubview(image)
        addSubview(companyName)
        addSubview(timeLabel)
        addSubview(priceLabel)
        addSubview(priceIcon)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 24),
            image.widthAnchor.constraint(equalToConstant: 24),
            image.topAnchor.constraint(equalTo: companyName.topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            companyName.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            companyName.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            
            timeLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 4),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            timeLabel.leadingAnchor.constraint(equalTo: companyName.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceLabel.centerYAnchor.constraint(equalTo: companyName.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: priceIcon.leadingAnchor, constant: -8),
            
            priceIcon.heightAnchor.constraint(equalToConstant: 16),
            priceIcon.widthAnchor.constraint(equalToConstant: 10),
            priceIcon.centerYAnchor.constraint(equalTo: companyName.centerYAnchor),
            priceIcon.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
