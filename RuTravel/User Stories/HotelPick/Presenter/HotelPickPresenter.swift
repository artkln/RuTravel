//
//  HotelPickPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 10/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HotelPickPresenter: HotelPickViewOutput, HotelPickModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
        static let alertSuccessTitle: String = "Успешно!"
        static let alertSuccessMessage: String = "Вы добавили отель в избранное."
    }

    // MARK: - Properties

    weak var view: HotelPickViewInput?
    var router: HotelPickRouterInput?
    var output: HotelPickModuleOutput?
    var input: RateHotelModuleInput?

    // MARK: - Private Properties

    private var user = User()
    private let hotelService = HotelService.shared
    private let firestoreService = FirestoreService.shared

    // MARK: - HotelPickViewOutput

    func loadData() {
        view?.startActivity { [weak self] in
            self?.firestoreService.getCurrentUser { result in
                switch result {
                case .success(let user):
                    self?.user = user
                    self?.view?.configure(with: HotelPickModel(hotelList: [Hotel]()))
                    self?.view?.stopActivity {}
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    func dateConfirmed(startDate: String, endDate: String) {
        updateSearchedJourney(with: startDate, endDate: endDate)
    }

    func hotelSelected(_ hotel: Hotel) {
        updateSearchedJourney(with: hotel)
    }

    func favouritePressed(_ hotel: Hotel) {
        view?.startActivity { [weak self] in
            self?.firestoreService.saveFavouriteHotel(hotel) { error in
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

    func morePressed(_ hotel: Hotel) {
        guard let URL = URL(string: hotel.link ?? String()) else {
            return
        }

        UIApplication.shared.open(URL)
    }

    func needRateHotel(_ hotel: Hotel) {
        router?.presentRateHotelModule(with: hotel)
    }

    // MARK: - Private Methods

    private func updateSearchedJourney(with startDate: String, endDate: String) {
        view?.startActivity { [weak self] in

            self?.user.searchedJourney.startDate = startDate
            self?.user.searchedJourney.endDate = endDate
            let journey = self?.user.searchedJourney ?? Journey()
            self?.firestoreService.updateUserJourney(journey, isInSearchModule: true) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                    return
                }
                self?.loadHotelList(with: journey)
            }
        }
    }

    private func loadHotelList(with journey: Journey) {
        guard
            let destinationCityInfo = journey.destinationCityInfo,
            let startDate = journey.startDate,
            let endDate = journey.endDate else {
            return
        }

        hotelService.getHotelsWithData(
            destinationCityInfo: destinationCityInfo,
            checkInDate: startDate,
            checkOutDate: endDate
        ) { [weak self] result in
            switch result {
            case .success(let hotels):
                self?.view?.configure(with: HotelPickModel(hotelList: hotels))
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

    private func updateSearchedJourney(with hotel: Hotel) {
        view?.startActivity { [weak self] in

            self?.user.searchedJourney.hotel = hotel
            let journey = self?.user.searchedJourney ?? Journey()
            self?.firestoreService.updateUserJourney(journey, isInSearchModule: true) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                    return
                }

                self?.view?.stopActivity {
                    self?.router?.pushFlightPickModule()
                }
            }
        }
    }

}
