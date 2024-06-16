//
//  TicketsListPresenter.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 14.06.2024.
//

import Foundation

protocol TicketsListScreenPresenterProtocol: AnyObject {
    var ticketListSreenModel: TicketsListScreenModel? { get }
    func backButtonTapped()
    func getTicketsListScreenData()
    func loadData()
}

final class TicketsListScreenPresenter: TicketsListScreenPresenterProtocol {
    
    //MARK: Properties
    var ticketListSreenModel: TicketsListScreenModel?
    
    weak var view: TicketsListScreenViewControllerProtocol?
    
    //MARK: Private properties
    private let interactor: TicketsListScreenInteractorProtocol
    private let router: TicketsListScreenRouterProtocol
    
    //MARK: Initializer
    init(interactor: TicketsListScreenInteractorProtocol,
         router: TicketsListScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: Methods
    func backButtonTapped() {
        router.backToSelectedCountryScreen()
    }
    
    func getTicketsListScreenData() {
        interactor.getTicketsListScreenData { model in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.ticketListSreenModel = model
                view?.updateTicketsList()
            }
        }
    }
    
    func loadData() {
        let fromCity = interactor.loadFromCity()
        let toCity = interactor.loadToCity()
        let thereDate = interactor.loadThereDate()
        view?.updateTitles(
            with: fromCity,
            toCity: toCity,
            thereDate: thereDate
        )
    }
}
