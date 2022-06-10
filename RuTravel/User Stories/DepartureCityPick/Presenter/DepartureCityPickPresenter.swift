//
//  DepartureCityPickPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class DepartureCityPickPresenter: DepartureCityPickViewOutput, DepartureCityPickModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
    }

    // MARK: - Properties

    weak var view: DepartureCityPickViewInput?
    var router: DepartureCityPickRouterInput?
    var output: DepartureCityPickModuleOutput?

    // MARK: - Private Properties

    private let firestoreService = FirestoreService.shared

    // MARK: - DepartureCityPickViewOutput

    func loadData() {
        view?.startActivity { [weak self] in
            self?.firestoreService.getPopularCities { result in
                switch result {
                case .success(let cities):
                    self?.view?.configure(with: DepartureCitiesModel(departureCities: cities))
                    self?.view?.stopActivity {}
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    func citySelected(_ city: City) {
        view?.startActivity { [weak self] in
            self?.firestoreService.getCurrentUser { result in
                switch result {
                case .success(let user):
                    self?.updateSearchedJourney(user, city: city)
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    // MARK: - Private Methods

    private func updateSearchedJourney(_ user: User, city: City) {
        var journey = user.searchedJourney
        journey.departureCityInfo = CityRequestInfo(
            name: city.requestInfo.name,
            IATACode: city.requestInfo.IATACode,
            id: city.requestInfo.id
        )
        firestoreService.updateUserJourney(journey, isInSearchModule: true) { [weak self] error in
            if let error = error {
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
                return
            }
            self?.updateRecommendedJourney(user, city: city)
        }
    }

    private func updateRecommendedJourney(_ user: User, city: City) {
        var journey = user.recommendedJourney
        journey.departureCityInfo = CityRequestInfo(
            name: city.requestInfo.name,
            IATACode: city.requestInfo.IATACode,
            id: city.requestInfo.id
        )
        firestoreService.updateUserJourney(journey, isInSearchModule: false) { [weak self] error in
            if let error = error {
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
                return
            }

            self?.view?.stopActivity {
                self?.router?.popModule()
            }
        }
    }

}
