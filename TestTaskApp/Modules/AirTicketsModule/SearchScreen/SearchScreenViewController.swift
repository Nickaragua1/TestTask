//
//  SearchViewController.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import Foundation
import UIKit

protocol SearchScreenViewControllerProtocol: AnyObject {
    func updateToTextField(with cityName: String)
    func updateFromTextField(with data: String)
}

final class SearchScreenViewController: UIViewController, SearchScreenViewControllerProtocol {
    
    //MARK: Private properties
    private let presenter: SearchScreenPresenterProtocol

    private let textFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.primaryViewColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = R.Color.shadowColor.cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    private let textFieldViewSearchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Image.textFieldSearchImage
        imageView.tintColor = .white
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textFieldViewPlaneImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Image.searchViewPlaneImage
        imageView.tintColor = R.Color.unselectedBarItemColor
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fromTextField: CustomeTextField = {
        let textField = CustomeTextField(
            placeholder: "Откуда - Москва",
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        )
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.textFieldViewColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let routeLabel: UILabel = {
        let label = UILabel()
        label.text = "Сложный маршрут"
        label.font = UIFont(
            name: R.Font.SFProDisplayRegular,
            size: 14
        )
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    
    private let whereLabel: UILabel = {
        let label = UILabel()
        label.text = "Куда угодно"
        label.font = UIFont(
            name: R.Font.SFProDisplayRegular,
            size: 14
        )
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    
    private let weekdaysLabel: UILabel = {
        let label = UILabel()
        label.text = "Выходные"
        label.font = UIFont(
            name: R.Font.SFProDisplayRegular,
            size: 14
        )
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    
    private let hotLabel: UILabel = {
        let label = UILabel()
        label.text = "Горячие билеты"
        label.font = UIFont(
            name: R.Font.SFProDisplayRegular,
            size: 14
        )
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let tableViewBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.primaryViewColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.Color.primaryViewColor
        tableView.register(
            SearchScreenCell.self,
            forCellReuseIdentifier: SearchScreenCell.reuseId
        )
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = R.Color.primaryTableViewColor
        return tableView
    }()
    
    private lazy var toTextField: CustomeTextField = {
        let textField = CustomeTextField(
            placeholder: "Куда - Турция",
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        )
        textField.rightView = cancelButton
        textField.rightViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var cancelButton: CustomeTextFieldButton = {
        let button = CustomeTextFieldButton(image: R.Image.cancelButtonImage)
        button.addTarget(
            self,
            action: #selector(cleanOffTextField), for: .touchUpInside
        )
        return button
    }()
    
    private lazy var routeButton: UIButton = {
        let button = UIButton()
        let image = R.Image.horizontalStackRoutButtonImage
        button.backgroundColor = R.Color.horizontalStackRoutButtonColor
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(
            self,
            action: #selector(openStubView),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var weekdaysButton: UIButton = {
        let button = UIButton()
        let image = R.Image.horizontalStackWeekendButtonImage
        button.backgroundColor = R.Color.horizontalStackWeekendButtonColor
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(
            self,
            action: #selector(openStubView),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var hotButton: UIButton = {
        let button = UIButton()
        let image = R.Image.horizontalStackFireButtonImage
        button.backgroundColor = R.Color.horizontalStackFireButtonColor
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(
            self,
            action: #selector(openStubView),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var whereButton: UIButton = {
        let button = UIButton()
        let image = R.Image.horizontalStackAnywhereButtonImage
        button.backgroundColor = R.Color.horizontalStackAnywhereButtonColor
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(
            self,
            action: #selector(whereButtonDidTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    //MARK: Initializer
    init(presenter: SearchScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Color.searchViewControllerColor
        setupStack()
        setupLayouts()
        presenter.loadData()
    }
    
    //MARK: Methods
    func updateToTextField(with cityName: String) {
        toTextField.text = cityName
    }
    
    func updateFromTextField(with data: String) {
        fromTextField.text = data
    }

    @objc func openStubView() {
        presenter.didTapButton()
    }
    
    //MARK: Private methods
    private func storeData() {
        presenter.storeData(
            with: fromTextField.text ?? "",
            and: toTextField.text ?? ""
        )
    }
    
    private func setupStack() {
        let buttons = [routeButton, whereButton, weekdaysButton, hotButton]
        let labels = [routeLabel, whereLabel, weekdaysLabel, hotLabel]
        
        for i in 0...3 {
            let containerView: UIView = {
                let view = UIView()
                view.backgroundColor = .clear
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            containerView.addSubview(buttons[i])
            containerView.addSubview(labels[i])
            
            containerView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            containerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            buttons[i].centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            buttons[i].topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            
            labels[i].centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            labels[i].topAnchor.constraint(equalTo: buttons[i].bottomAnchor, constant: 5).isActive = true
            
            horizontalStack.addArrangedSubview(containerView)
        }
    }
    
    private func setupLayouts() {
        view.addSubview(textFieldView)
        textFieldView.addSubview(fromTextField)
        textFieldView.addSubview(separatorView)
        textFieldView.addSubview(toTextField)
        textFieldView.addSubview(textFieldViewPlaneImage)
        textFieldView.addSubview(textFieldViewSearchImage)
        view.addSubview(horizontalStack)
        view.addSubview(tableViewBackgroundView)
        tableViewBackgroundView.addSubview(tableView)
        tableViewBackgroundView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldView.heightAnchor.constraint(equalToConstant: 96),
            
            textFieldViewPlaneImage.centerYAnchor.constraint(equalTo: fromTextField.centerYAnchor),
            textFieldViewPlaneImage.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 19),
            textFieldViewPlaneImage.trailingAnchor.constraint(equalTo: fromTextField.leadingAnchor, constant: -16),
            textFieldViewPlaneImage.heightAnchor.constraint(equalToConstant: 14),
            textFieldViewPlaneImage.widthAnchor.constraint(equalToConstant: 20),
            
            fromTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 16),
            fromTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -17),
            
            separatorView.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 8),
            separatorView.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            separatorView.leadingAnchor.constraint(equalTo: textFieldViewPlaneImage.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: fromTextField.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            textFieldViewSearchImage.centerYAnchor.constraint(equalTo: toTextField.centerYAnchor),
            textFieldViewSearchImage.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 16),
            textFieldViewSearchImage.trailingAnchor.constraint(equalTo: toTextField.leadingAnchor, constant: -16),
            textFieldViewSearchImage.heightAnchor.constraint(equalToConstant: 24),
            textFieldViewSearchImage.widthAnchor.constraint(equalToConstant: 24),
            
            toTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            toTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -16),
            toTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -17),
            
            horizontalStack.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 26),
            horizontalStack.heightAnchor.constraint(equalToConstant: 90),
            horizontalStack.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor),
            
            tableViewBackgroundView.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 30),
            tableViewBackgroundView.heightAnchor.constraint(equalToConstant: 216),
            tableViewBackgroundView.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor),
            tableViewBackgroundView.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
            
            tableView.centerYAnchor.constraint(equalTo: tableViewBackgroundView.centerYAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 190),
            tableView.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func cleanOffTextField() {
        toTextField.text = ""
    }
    
    @objc private func whereButtonDidTapped() {
        toTextField.text = "Куда угодно"
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension SearchScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.searchScreenData?.popularDirections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchScreenCell.reuseId) as? SearchScreenCell else
        { return UITableViewCell() }
        
        guard let direction = presenter.searchScreenData?.popularDirections[indexPath.row] else
        { return UITableViewCell()}
        cell.configureCell(with: direction.cityName, image: direction.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cityName = presenter.searchScreenData?.popularDirections[indexPath.row].cityName else
        { return }
        presenter.updateToTextField(with: cityName)
    }
}

//MARK: UITextFieldDelegate
extension SearchScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performAction()
        storeData()
        return true
    }
    
    func performAction() {
        presenter.textFieldDidTapped()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var flag = false
        switch textField {
        case fromTextField:
            flag = fromTextField.setTextField(
               textField: fromTextField,
               validType: .enterCity,
               string: string,
               range: range
           )
        case toTextField:
            flag = toTextField.setTextField(
               textField: toTextField,
               validType: .enterCity,
               string: string,
               range: range
           )
        default:
            return true
        }
        return flag
    }
}
