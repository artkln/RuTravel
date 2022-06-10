//
//  RateHotelPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class RateHotelPresenter: RateHotelViewOutput, RateHotelModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Некорректный рейтинг"
        static let alertMessage: String = "Оцените отель по шкале от 0 до 100"
    }

    // MARK: - Properties

    weak var view: RateHotelViewInput?
    var router: RateHotelRouterInput?
    var output: RateHotelModuleOutput?

    // MARK: - Private Properties

    private var hotel: Hotel
    private let firestoreService = FirestoreService.shared

    // MARK: - Initialization

    init(hotel: Hotel) {
        self.hotel = hotel
    }

    // MARK: - RateHotelViewOutput

    func loadData() {
        view?.configure(with: RateHotelModel(hotel: hotel))
    }

    func ratePressed(rating: Int) {
        view?.startActivity { [weak self] in

            guard let hotel = self?.hotel else {
                self?.view?.stopActivity {
                    self?.router?.dismissModule()
                }
                return
            }

            hotel.userRating = rating
            self?.firestoreService.saveRatedHotel(hotel) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                    return
                }

                self?.view?.stopActivity {
                    self?.router?.dismissModule()
                }
            }
        }
    }

    func backPressed() {
        router?.dismissModule()
    }

    func incorrectRating() {
        view?.showPrompt(title: Constants.alertTitle, message: Constants.alertMessage)
    }

}
