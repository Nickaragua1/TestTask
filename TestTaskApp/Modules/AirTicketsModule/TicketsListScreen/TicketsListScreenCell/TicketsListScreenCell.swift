//
//  TicketsListTableViewCell.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import Foundation
import UIKit

final class TicketsListScreenCell: UITableViewCell {
    
    //MARK: Properties
    static let reuseId = "TicketsListTableViewCell"
    
    //MARK: Private properties
    private let badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.horizontalStackAnywhereButtonColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let badgeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.selectedCountryTableViewColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 22
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = R.Color.horizontalStackFireButtonColor
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let departureAirportLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrivalAirportLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flightTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transferTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func configure(with model: TicketsListScreenModel.TicketModel) {
        backgroundColor = .clear
        if let badgeText = model.badge {
            badgeTitle.text = badgeText
        } else {
            badgeView.isHidden = true
        }
        guard let priceText = model.price.formattedIntToString() else { return }
        priceLabel.text = priceText + " ₽"
        departureLabel.text = (model.departure ?? "") + " — "
        arrivalLabel.text = model.arrival
        departureAirportLabel.text = model.departureAirport
        arrivalAirportLabel.text = model.arrivalAirport
        flightTimeLabel.text = model.flightTime
        if model.hasTransfer {
            transferTimeLabel.text = ""
        } else {
            transferTimeLabel.text = " / Без пересадок"
        }
    }
    
    //MARK: Private methods
    private func setupViews() {
        addSubview(cardBackgroundView)
        addSubview(badgeView)
        badgeView.addSubview(badgeTitle)
        cardBackgroundView.addSubview(priceLabel)
        cardBackgroundView.addSubview(image)
        cardBackgroundView.addSubview(departureLabel)
        cardBackgroundView.addSubview(departureAirportLabel)
        cardBackgroundView.addSubview(arrivalLabel)
        cardBackgroundView.addSubview(arrivalAirportLabel)
        cardBackgroundView.addSubview(flightTimeLabel)
        cardBackgroundView.addSubview(transferTimeLabel)
        
        NSLayoutConstraint.activate([
            cardBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cardBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            cardBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            badgeView.heightAnchor.constraint(equalToConstant: 20),
            badgeView.widthAnchor.constraint(equalToConstant: 125),
            badgeView.centerYAnchor.constraint(equalTo:
                                                cardBackgroundView.topAnchor),
            badgeView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            badgeTitle.centerYAnchor.constraint(equalTo: badgeView.centerYAnchor),
            badgeTitle.centerXAnchor.constraint(equalTo: badgeView.centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: 16),
            
            image.heightAnchor.constraint(equalToConstant: 24),
            image.widthAnchor.constraint(equalToConstant: 24),
            image.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 25),
            image.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: 16),
            
            departureLabel.bottomAnchor.constraint(equalTo: image.centerYAnchor, constant: -2),
            departureLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            
            departureAirportLabel.topAnchor.constraint(equalTo: image.centerYAnchor, constant: 2),
            departureAirportLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            
            arrivalLabel.centerYAnchor.constraint(equalTo: departureLabel.centerYAnchor),
            arrivalLabel.leadingAnchor.constraint(equalTo: departureLabel.trailingAnchor, constant: 3),
            
            arrivalAirportLabel.centerYAnchor.constraint(equalTo: departureAirportLabel.centerYAnchor),
            arrivalAirportLabel.leadingAnchor.constraint(equalTo: arrivalLabel.leadingAnchor),
            
            flightTimeLabel.centerYAnchor.constraint(equalTo: departureLabel.centerYAnchor),
            flightTimeLabel.leadingAnchor.constraint(equalTo: arrivalLabel.trailingAnchor, constant: 16),
            
            transferTimeLabel.centerYAnchor.constraint(equalTo: departureLabel.centerYAnchor),
            transferTimeLabel.leadingAnchor.constraint(equalTo: flightTimeLabel.trailingAnchor)
        ])
    }
}
