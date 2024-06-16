//
//  SelectedCountryCell.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import Foundation
import UIKit

final class SelectedCountryScreenCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let reuseId = "SelectedCountryCollectionViewCell"
    
    //MARK: Private properties
    private let chipsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = R.Color.primaryViewColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleView: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        label.textColor = R.Color.unselectedBarItemColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func configure(with title: String, subtitle: String, icon: UIImage?) {
        titleView.text = title
        subtitleView.text = subtitle
        if let icon = icon {
            iconView.image = icon
        } else {
            iconView.isHidden = true
        }
    }
    
    //MARK: Private methods
    private func setupLayouts() {
        addSubview(chipsView)
        chipsView.addSubview(iconView)
        chipsView.addSubview(titleView)
        chipsView.addSubview(subtitleView)
        
        NSLayoutConstraint.activate([
            chipsView.topAnchor.constraint(equalTo: topAnchor),
            chipsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            chipsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chipsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconView.heightAnchor.constraint(equalToConstant: 16),
            iconView.widthAnchor.constraint(equalToConstant: 16),
            iconView.centerYAnchor.constraint(equalTo: chipsView.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: chipsView.leadingAnchor, constant: 12),
            
            subtitleView.centerYAnchor.constraint(equalTo: chipsView.centerYAnchor),
            subtitleView.trailingAnchor.constraint(equalTo: chipsView.trailingAnchor, constant: -12),
            
            titleView.centerYAnchor.constraint(equalTo: chipsView.centerYAnchor),
            titleView.trailingAnchor.constraint(equalTo: subtitleView.leadingAnchor)
        ])
    }
}
