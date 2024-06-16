//
//  ErrorView.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import UIKit

final class ErrorView: UIView {
    
    //MARK: Private properties
    private let warningImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Image.stubImage
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = R.Title.stubMainTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reasonTitleLabel: UILabel = {
        let label = UILabel()
        label.text = R.Title.stubReasonTitle
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = R.Title.stubDescriptionTitle
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(warningImage)
        stack.addArrangedSubview(mainTitleLabel)
        return stack
    }()
    
    private lazy var descriptionStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(reasonTitleLabel)
        stack.addArrangedSubview(descriptionTitleLabel)
        return stack
    }()
    
    private lazy var mainStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(titleStack)
        stack.addArrangedSubview(descriptionStack)
        return stack
    }()
    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private methods
    private func setupLayouts() {
        addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            warningImage.heightAnchor.constraint(equalToConstant: 35),
            warningImage.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
}
