//
//  SelectedCountryViewController.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import Foundation
import UIKit

protocol SelectedCountryScreenViewControllerProtocol: AnyObject {
    func updateTableView()
    func updateCollectionView()
    func updateTextFields(with fromCity: String, and toCity: String)
}

final class SelectedCountryScreenViewController: UIViewController, SelectedCountryScreenViewControllerProtocol {
            
    //MARK: Private properties
    private let presenter: SelectedCountryScreenPresenterProtocol

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
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.textFieldViewColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableViewBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.selectedCountryTableViewColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableViewTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 20
        )
        label.text = "Прямые рейсы"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var datePicker: UIDatePicker?
    
    private lazy var filtersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(
            SelectedCountryScreenCollectionViewCell.self,
            forCellWithReuseIdentifier: SelectedCountryScreenCollectionViewCell.reuseId
        )
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(
            SelectedCountryScreenTableViewCell.self,
            forCellReuseIdentifier: SelectedCountryScreenTableViewCell.reuseId
        )
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = R.Color.primaryTableViewColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var fromTextField: CustomeTextField = {
     let textField = CustomeTextField(
        placeholder: "Откуда - Москва",
     insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     )
        textField.delegate = self
        textField.rightView = swapButton
        textField.rightViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var toTextField: CustomeTextField = {
     let textField = CustomeTextField(
        placeholder: "Куда - Турция",
     insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     )
        textField.delegate = self
        textField.rightView = cancelButton
        textField.rightViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var cancelButton: CustomeTextFieldButton = {
        let button = CustomeTextFieldButton(image: R.Image.cancelButtonImage)
        button.addTarget(
            self,
            action: #selector(cleanOffTextField),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var swapButton: CustomeTextFieldButton = {
        let button = CustomeTextFieldButton(image: R.Image.swapButtonImage)
        button.addTarget(
            self,
            action: #selector(swapTextFields),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var backButton: CustomeTextFieldButton = {
        let button = CustomeTextFieldButton(
            image: R.Image.backButtonImage
        )
        button.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var goToTicketsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.Color.horizontalStackAnywhereButtonColor
        button.layer.cornerRadius = 8
        button.setTitle("Посмотреть все билеты", for: .normal)
        button.titleLabel?.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 16
        )
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(ticketsButonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    //MARK: Initializer
    init(presenter: SelectedCountryScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        navigationController?.navigationBar.isHidden = true
        presenter.getSelectedCountryScreenData()
        presenter.loadData()
    }
    
    //MARK: Methods
    func updateTableView() {
        tableView.reloadData()
    }
    
    func updateCollectionView() {
        filtersCollectionView.reloadData()
    }
    
    func updateTextFields(with fromCity: String, and toCity: String) {
        fromTextField.text = fromCity
        toTextField.text = toCity
    }
    
    @objc func backButtonTapped() {
        presenter.backButtonTapped()
    }
    
    @objc func ticketsButonTapped() {
        presenter.ticketsButonTapped()
        storeData()
    }
    
    @objc func dueDateChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "ru_Ru")
        dateFormatter.locale = locale
        
        dateFormatter.dateFormat = "d MMM"
        let date = dateFormatter.string(from: sender.date)
        
        dateFormatter.dateFormat = "E"
        let weekday = dateFormatter.string(from: sender.date).lowercased()
        
        presenter.updateDateCell(with: date, weekday: weekday)
    }
    
    @objc func duePlusDateChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "ru_Ru")
        dateFormatter.locale = locale
        
        dateFormatter.dateFormat = "d MMM"
        let date = dateFormatter.string(from: sender.date)
        
        dateFormatter.dateFormat = "E"
        let weekday = dateFormatter.string(from: sender.date).lowercased()
        
        presenter.updatePlusCell(with: date, weekday: weekday)
    }
    
    //MARK: Private methods
    private func storeData() {
        presenter.storeData(
            with: fromTextField.text ?? "",
            and: toTextField.text ?? ""
        )
    }
    
    private func dateCellDidTap() {
        if self.view.subviews.contains(where: { $0 is UIDatePicker }) {
            self.datePicker?.removeFromSuperview()
        } else {
            datePicker = nil
            setupDatePicker(from: 1)
        }
        fromTextField.resignFirstResponder()
        toTextField.resignFirstResponder()
    }
    
    private func plusCellDidTap() {
        if self.view.subviews.contains(where: { $0 is UIDatePicker }) {
            self.datePicker?.removeFromSuperview()
        } else {
            fromTextField.resignFirstResponder()
            toTextField.resignFirstResponder()
            datePicker = nil
            setupDatePicker(from: 0)
        }
    }
    
    private func setupDatePicker(from button: Int) {
        let picker = datePicker ?? UIDatePicker()
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ru_RU")
        picker.preferredDatePickerStyle = .inline
        if button == 0 {
            picker.addTarget(self, action: #selector(duePlusDateChanged(sender:)), for: .valueChanged)
        } else {
            picker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: .valueChanged)
        }
        picker.backgroundColor = .black
        datePicker = picker
        
        guard let datePicker else { return }
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.heightAnchor.constraint(equalToConstant: 400).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupLayouts() {
        view.backgroundColor = .black
        view.addSubview(textFieldView)
        textFieldView.addSubview(fromTextField)
        textFieldView.addSubview(separatorView)
        textFieldView.addSubview(toTextField)
        textFieldView.addSubview(backButton)
        view.addSubview(filtersCollectionView)
        view.addSubview(tableViewBackgroundView)
        tableViewBackgroundView.addSubview(tableViewTitle)
        tableViewBackgroundView.addSubview(tableView)
        view.addSubview(goToTicketsButton)
        
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 79),
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            backButton.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 14),
            backButton.widthAnchor.constraint(equalToConstant: 16),
            backButton.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 12),
            
            fromTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 16),
            fromTextField.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 11),
            fromTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -17),

            separatorView.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 8),
            separatorView.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            separatorView.leadingAnchor.constraint(equalTo: fromTextField.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: fromTextField.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            toTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            toTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -16),
            toTextField.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),
            toTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -17),
            
            filtersCollectionView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 16),
            filtersCollectionView.heightAnchor.constraint(equalToConstant: 35),
            filtersCollectionView.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
            filtersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableViewBackgroundView.topAnchor.constraint(equalTo: filtersCollectionView.bottomAnchor, constant: 20),
            tableViewBackgroundView.heightAnchor.constraint(equalToConstant: 288),
            tableViewBackgroundView.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor),
            tableViewBackgroundView.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
            
            tableViewTitle.topAnchor.constraint(equalTo: tableViewBackgroundView.topAnchor, constant: 20),
            tableViewTitle.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 18),
            
            tableView.topAnchor.constraint(equalTo: tableViewTitle.bottomAnchor, constant: 8),
            tableView.heightAnchor.constraint(equalToConstant: 224),
            tableView.leadingAnchor.constraint(equalTo: tableViewBackgroundView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableViewBackgroundView.trailingAnchor, constant: -16),
            
            goToTicketsButton.topAnchor.constraint(equalTo: tableViewBackgroundView.bottomAnchor, constant: 16),
            goToTicketsButton.leadingAnchor.constraint(equalTo: tableViewBackgroundView.leadingAnchor),
            goToTicketsButton.trailingAnchor.constraint(equalTo: tableViewBackgroundView.trailingAnchor),
            goToTicketsButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    @objc private func cleanOffTextField() {
        toTextField.text = ""
    }
    
    @objc private func swapTextFields() {
        var text = ""
        text = toTextField.text ?? ""
        toTextField.text = fromTextField.text
        fromTextField.text = text
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension SelectedCountryScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedCountryScreenCollectionViewCell.reuseId, for: indexPath) as? SelectedCountryScreenCollectionViewCell else 
        { return UICollectionViewCell() }
        
        let filter = presenter.filters[indexPath.row]
        cell.configure(with: filter.title, subtitle: filter.subtitle ?? "", icon: filter.image ?? UIImage())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            plusCellDidTap()
        }
        if indexPath.row == 1 {
            dateCellDidTap()
        }
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension SelectedCountryScreenViewController: UICollectionViewDelegateFlowLayout {
    func
    collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = presenter.filters[indexPath.row].cellWidth
        return CGSize(width: cellWidth, height: 35)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension SelectedCountryScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.selectedCountryScreenData?.ticketsOffers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectedCountryScreenTableViewCell.reuseId) as? SelectedCountryScreenTableViewCell else
        { return UITableViewCell() }
        
        guard let model = presenter.selectedCountryScreenData?.ticketsOffers[indexPath.row] else
        { return UITableViewCell() }
        
        guard let modelColors = presenter.selectedCountryScreenData?.imageColors[indexPath.row] else
        { return UITableViewCell() }

        cell.configureCell(with: model, color: modelColors)
        return cell
    }
}

//MARK: UITextFieldDelegate
extension SelectedCountryScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
