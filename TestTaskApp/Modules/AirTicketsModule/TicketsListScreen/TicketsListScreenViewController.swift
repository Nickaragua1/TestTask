//
//  TicketsListViewController.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import Foundation
import UIKit

protocol TicketsListScreenViewControllerProtocol: AnyObject {
    func updateTicketsList()
    func updateTitles(with fromCity: String, toCity: String, thereDate: String)
}

final class TicketsListScreenViewController: UIViewController, TicketsListScreenViewControllerProtocol {
    
    //MARK: Private properties
    private let presenter: TicketsListScreenPresenterProtocol

    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.searchViewControllerColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fromCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 16
        )
        label.text = "Москва-"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 16
        )
        label.text = "Сочи"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: R.Font.SFProDisplayRegular,
            size: 14
        )
        label.text = "23 февраля, 1 пассажир"
        label.textColor = R.Color.unselectedBarItemColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let filterButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.horizontalStackAnywhereButtonColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        let image = R.Image.filterImage
        button.setImage(image, for: .normal)
        button.setTitle(" Фильтр", for: .normal)
        button.titleLabel?.font = UIFont(
            name: R.Font.SFProDisplayRegular,
            size: 14
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let grafButton: UIButton = {
        let button = UIButton()
        let image = R.Image.barImage
        button.setImage(image, for: .normal)
        button.setTitle(" График цен", for: .normal)
        button.titleLabel?.font = UIFont(
            name: R.Font.SFProDisplayMediumItalic,
            size: 14
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(
            TicketsListScreenCell.self,
            forCellReuseIdentifier: TicketsListScreenCell.reuseId
        )
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 137
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
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
    
    //MARK: Initializer
    init(presenter: TicketsListScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        presenter.getTicketsListScreenData()
        setupLayouts()
        presenter.loadData()
    }
    
    //MARK: Methods
    func updateTicketsList() {
        tableView.reloadData()
    }
    
    func updateTitles(with fromCity: String, toCity: String, thereDate: String) {
        fromCityLabel.text = fromCity + " - "
        toCityLabel.text = toCity
        infoLabel.text = thereDate + ", 1 пассажир"
    }
    
    @objc func backButtonTapped() {
        presenter.backButtonTapped()
    }
    
    //MARK: Private methods
    private func setupLayouts() {
        view.addSubview(tableView)
        view.addSubview(infoView)
        infoView.addSubview(backButton)
        infoView.addSubview(fromCityLabel)
        infoView.addSubview(toCityLabel)
        infoView.addSubview(infoLabel)
        view.addSubview(filterButtonView)
        filterButtonView.addSubview(filterButton)
        filterButtonView.addSubview(grafButton)
        
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            infoView.heightAnchor.constraint(equalToConstant: 56),
            
            backButton.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 14),
            backButton.widthAnchor.constraint(equalToConstant: 16),
            backButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 6),

            fromCityLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),
            fromCityLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 8),
            
            toCityLabel.leadingAnchor.constraint(equalTo: fromCityLabel.trailingAnchor),
            toCityLabel.topAnchor.constraint(equalTo: fromCityLabel.topAnchor),
            
            infoLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -8),
            infoLabel.leadingAnchor.constraint(equalTo: fromCityLabel.leadingAnchor),

            tableView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 34),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            filterButtonView.heightAnchor.constraint(equalToConstant: 37),
            filterButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 78),
            filterButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -78),
            filterButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            filterButton.heightAnchor.constraint(equalToConstant: 30),
            filterButton.leadingAnchor.constraint(equalTo: filterButtonView.leadingAnchor, constant: 16),
            filterButton.centerYAnchor.constraint(equalTo: filterButtonView.centerYAnchor),
            
            grafButton.heightAnchor.constraint(equalToConstant: 30),
            grafButton.trailingAnchor.constraint(equalTo: filterButtonView.trailingAnchor, constant: -16),
            grafButton.centerYAnchor.constraint(equalTo: filterButtonView.centerYAnchor)
        ])
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension TicketsListScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.ticketListSreenModel?.tickets.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TicketsListScreenCell.reuseId) as? TicketsListScreenCell else {
            return UITableViewCell()
        }
        guard let model = presenter.ticketListSreenModel?.tickets[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: model)
        return cell
    }
}
