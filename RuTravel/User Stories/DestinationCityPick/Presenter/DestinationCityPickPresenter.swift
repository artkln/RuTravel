//
//  DestinationCityPickPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class DestinationCityPickPresenter: DestinationCityPickViewOutput, DestinationCityPickModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
    }

    // MARK: - Properties

    weak var view: DestinationCityPickViewInput?
    var router: DestinationCityPickRouterInput?
    var output: DestinationCityPickModuleOutput?

    // MARK: - Private Properties

    private let firestoreService = FirestoreService.shared
    private var user = User()

    // MARK: - DestinationCityPickViewOutput

    func loadData() {
        firestoreService.listenOnUserUpdates { [weak self] result in
            switch result {
            case .success(let user):
                if user.searchedJourney.departureCityInfo == nil {
                    self?.view?.stopActivity {}
                    self?.view?.showBlockerScreen()
                    return
                }

                self?.user = user
                self?.getResortCities()
            case .failure(let error):
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
            }
        }
    }

    func citySelected(_ city: City) {
        view?.startActivity { [weak self] in

            self?.user.searchedJourney.destinationCityInfo = city.requestInfo
            let journey = self?.user.searchedJourney ?? Journey()
            self?.firestoreService.updateUserJourney(journey, isInSearchModule: true) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                    return
                }

                self?.view?.stopActivity {
                    self?.router?.pushDestinationCityInfoModule(with: city)
                }
            }
        }
    }

    // MARK: - Private Methods

    private func getResortCities() {
        view?.startActivity { [weak self] in
            self?.firestoreService.getResortCities { result in
                switch result {
                case .success(let cities):
                    self?.getPopularCities(cities)
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    private func getPopularCities(_ resortCities: [City]) {
        firestoreService.getPopularCities { [weak self] result in
            switch result {
            case .success(let popularCities):
                let citiesWithoutDepartureCity = popularCities.filter {
                    $0.requestInfo.name != self?.user.searchedJourney.departureCityInfo?.name
                }
                self?.view?.configure(with: DestinationCitiesModel(
                    destinationCities: [resortCities, citiesWithoutDepartureCity]
                ))
                self?.view?.stopActivity {}
            case .failure(let error):
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
            }
        }
    }

}
