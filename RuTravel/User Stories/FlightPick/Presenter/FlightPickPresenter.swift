//
//  FlightPickPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 11/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

final class FlightPickPresenter: FlightPickViewOutput, FlightPickModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
        static let alertSuccessTitle: String = "Успешно!"
        static let alertSuccessMessage: String = "Вы добавили перелёт в избранное."
        static let alertErrorMessage: String = "Мы не смогли найти перелёты на эту дату."
    }

    // MARK: - Properties

    weak var view: FlightPickViewInput?
    var router: FlightPickRouterInput?
    var output: FlightPickModuleOutput?

    // MARK: - Private Properties

    private let flightService = FlightService.shared
    private let firestoreService = FirestoreService.shared
    private var isInSearchModule: Bool
    private var user = User()

    // MARK: - Initialization

    init(_ isInSearchModule: Bool) {
        self.isInSearchModule = isInSearchModule
    }

    // MARK: - FlightPickViewOutput

    func loadData() {
        view?.startActivity { [weak self] in
            self?.firestoreService.getCurrentUser { result in
                switch result {
                case .success(let user):
                    self?.user = user

                    guard let isInSearchModule = self?.isInSearchModule else {
                        return
                    }

                    isInSearchModule ?
                    self?.loadFlightList(with: user.searchedJourney) :
                    self?.loadFlightList(with: user.recommendedJourney)
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    func flightSelected(_ flight: Flight) {
        isInSearchModule ?
            updateSearchedJourney(with: flight) :
            updateRecommendedJourney(with: flight)
    }

    func favouritePressed(_ flight: Flight) {
        view?.startActivity { [weak self] in
            self?.firestoreService.saveFavouriteFlight(flight) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                    return
                }

                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertSuccessTitle, message: Constants.alertSuccessMessage)
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

    // MARK: - Private Methods

    private func loadFlightList(with journey: Journey) {
         guard
             let departureCityInfo = journey.departureCityInfo,
             let destinationCityInfo = journey.destinationCityInfo,
             let startDate = journey.startDate,
             let endDate = journey.endDate else {
             return
         }

         flightService.getFlight(
             departureCityInfo: departureCityInfo,
             destinationCityInfo: destinationCityInfo,
             departureDate: startDate,
             returnDate: endDate
         ) { [weak self] result in
             switch result {
             case .success(let flights):
                 if flights.isEmpty {
                     self?.view?.stopActivity {
                         self?.view?.showBlockerScreen()
                     }
                     return
                 }
                 self?.view?.configure(with: FlightPickModel(flightList: flights))
                 self?.view?.stopActivity {}
             case .failure(let error):
                 DispatchQueue.main.async {
                     self?.view?.stopActivity {
                         self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                     }
                 }
             }
         }
    }

    private func updateSearchedJourney(with flight: Flight) {
        view?.startActivity { [weak self] in

            self?.user.searchedJourney.flight = flight
            self?.firestoreService.updateUserJourney(
                self?.user.searchedJourney ?? Journey(),
                isInSearchModule: true
            ) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                    return
                }

                self?.view?.stopActivity {
                    self?.pushJourneyInfoModule()
                }
            }
        }
    }

    private func updateRecommendedJourney(with flight: Flight) {
        view?.startActivity { [weak self] in

            self?.user.recommendedJourney.flight = flight
            self?.firestoreService.updateUserJourney(
                self?.user.recommendedJourney ?? Journey(),
                isInSearchModule: false
            ) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                    return
                }

                self?.view?.stopActivity {
                    self?.pushJourneyInfoModule()
                }
            }
        }
    }

    private func pushJourneyInfoModule() {
        router?.pushJourneyInfoModule(isInSearchModule)
    }

}
