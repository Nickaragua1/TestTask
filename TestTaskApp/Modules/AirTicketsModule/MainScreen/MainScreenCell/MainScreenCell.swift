//
//  MainModuleCollectionViewCell.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import UIKit

final class MainScreenCell: UICollectionViewCell {
    
    //MARK: Properties
    static let reuseId = "MainCollectionViewCell"
    
    //MARK: Private properties
    private let mainImageView: UIImageView = {
        let image = UIImageView()
        image.image = R.Image.collectionViewFirstImage
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 16
        )
        label.textAlignment = .left
        label.text = "Die Antwoord"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 16
        )
        label.textAlignment = .left
        label.text = "Будапешт"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let costLabelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Image.mainVCBarItemImage
        imageView.tintColor = R.Color.unselectedBarItemColor
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 14
        )
        label.textAlignment = .left
        label.text = "от 22264₽"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func configure(with model: MainScreenModel.OfferModel, image: UIImage) {
        guard let priceText = model.price.formattedIntToString() else { return }
        mainImageView.image = image
        titleLabel.text = model.title
        cityLabel.text = model.town
        costLabel.text = priceText + " ₽"
    }

    //MARK: Private methods
    private func setupLayouts() {
        addSubview(mainImageView)
        addSubview(cityLabel)
        addSubview(titleLabel)
        addSubview(costLabelImage)
        addSubview(costLabel)
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: self.topAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 133),
            mainImageView.widthAnchor.constraint(equalToConstant: 132),
            
            titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            costLabelImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            costLabelImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            costLabelImage.trailingAnchor.constraint(equalTo: costLabel.leadingAnchor),
            costLabelImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            costLabel.centerYAnchor.constraint(equalTo: costLabelImage.centerYAnchor)
        ])
    }
}

