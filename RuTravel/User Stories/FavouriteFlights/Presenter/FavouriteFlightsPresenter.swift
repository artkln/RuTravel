//
//  FavouriteFlightsPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class FavouriteFlightsPresenter: FavouriteFlightsViewOutput, FavouriteFlightsModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
    }

    // MARK: - Properties

    weak var view: FavouriteFlightsViewInput?
    var router: FavouriteFlightsRouterInput?
    var output: FavouriteFlightsModuleOutput?

    // MARK: - Private Properties

    private let firestoreService = FirestoreService.shared

    // MARK: - FavouriteFlightsViewOutput

    func loadData() {
        view?.startActivity { [weak self] in
            self?.firestoreService.getFavouriteFlights { result in
                switch result {
                case .success(let flights):
                    if flights.isEmpty {
                        self?.view?.showBlockerScreen()
                        self?.view?.stopActivity {}
                        return
                    }
                    self?.view?.configure(with: FavouriteFlightsModel(flightsList: flights))
                    self?.view?.stopActivity {}
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    func morePressed(_ flight: Flight) {
        guard let URL = URL(string: flight.link ?? String()) else {
            return
        }

        UIApplication.shared.open(URL)
    }

}
