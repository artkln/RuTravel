//
//  OrderedJourneysPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class OrderedJourneysPresenter: OrderedJourneysViewOutput, OrderedJourneysModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
    }

    // MARK: - Properties

    weak var view: OrderedJourneysViewInput?
    var router: OrderedJourneysRouterInput?
    var output: OrderedJourneysModuleOutput?

    // MARK: - Private Properties

    private let firestoreService = FirestoreService.shared
    private let imageService = ImageService.shared

    // MARK: - OrderedJourneysViewOutput

    func loadData() {
        view?.startActivity { [weak self] in
            self?.firestoreService.getOrderedJourneys { result in
                switch result {
                case .success(let journeys):
                    if journeys.isEmpty {
                        self?.view?.showBlockerScreen()
                        self?.view?.stopActivity {}
                        return
                    }
                    self?.view?.configure(with: OrderedJourneysModel(journeysList: journeys))
                    self?.view?.stopActivity {}
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    func morePressed(_ hotel: Hotel) {
        guard let URL = URL(string: hotel.link ?? String()) else {
            return
        }

        UIApplication.shared.open(URL)
    }

    func morePressed(_ flight: Flight) {
        guard let URL = URL(string: flight.link ?? String()) else {
            return
        }

        UIApplication.shared.open(URL)
    }

}
