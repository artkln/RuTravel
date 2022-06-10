//
//  RecommendationsPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

final class RecommendationsPresenter: RecommendationsViewOutput, RecommendationsModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
        static let alertSuccessTitle: String = "Успешно!"
        static let alertSuccessMessage: String = "Вы добавили отель в избранное."
    }

    // MARK: - Properties

    weak var view: RecommendationsViewInput?
    var router: RecommendationsRouterInput?
    var output: RecommendationsModuleOutput?

    // MARK: - Private Properties

    private let MLService = MLRecommenderService.shared
    private let firestoreService = FirestoreService.shared
    private let hotelService = HotelService.shared
    private var viewModel = RecommendationsModel()
    private var user = User()

    // MARK: - RecommendationsViewOutput

    func loadData() {
        firestoreService.listenOnUserUpdates { [weak self] result in
            switch result {
            case .success(let user):
                if user.recommendedJourney.departureCityInfo == nil {
                    self?.view?.stopActivity {}
                    self?.view?.showBlockerScreen()
                    return
                }

                self?.user = user
                self?.view?.configure(with: self?.viewModel)
                self?.view?.stopActivity {}
            case .failure(let error):
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
            }
        }
    }

    func dateConfirmed(startDate: String, endDate: String) {
        user.recommendedJourney.startDate = startDate
        user.recommendedJourney.endDate = endDate
        loadAllCities()
    }

    func hotelSelected(_ hotel: Hotel) {
        view?.startActivity { [weak self] in
            self?.firestoreService.getCityByName(hotel.cityName ?? String()) { result in
                switch result {
                case .success(let city):
                    self?.updateRecommendedJourney(
                        with: hotel,
                        destinationCityInfo: city.requestInfo
                    )
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    func needRateHotel(_ hotel: Hotel) {
        router?.presentRateHotelModule(with: hotel)
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

    // MARK: - Load all hotels to database block

    private func loadAllCities() {
        view?.startActivity { [weak self] in
            self?.firestoreService.getAllCities { result in
                switch result {
                case .success(let cities):
                    //self?.getCSV(from: cities)
                    self?.loadAllHotels(from: cities)
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    private func getCSV(from cities: [City]) {
        hotelService.getCSVTrainingData(
            from: cities,
            startDate: user.recommendedJourney.startDate ?? String(),
            endDate: user.recommendedJourney.endDate ?? String()
        ) { [weak self] error in
            self?.view?.stopActivity {
                if let error = error {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
            }
        }
    }

    private func loadAllHotels(from cities: [City]) {
        hotelService.getAllHotels(
            from: cities,
            startDate: user.recommendedJourney.startDate ?? String(),
            endDate: user.recommendedJourney.endDate ?? String()
        ) { [weak self] result in
            switch result {
            case .success(let hotels):
                self?.saveAllHotels(hotels)
            case .failure(let error):
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
            }
        }
    }

    private func saveAllHotels(_ hotels: [Hotel]) {
        firestoreService.saveAllHotels(hotels) { [weak self] error in
            if let error = error {
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
                return
            }
            self?.loadRatedHotels()
        }
    }

    // MARK: - Get recommendations from hotels in database block

    private func loadRatedHotels() {
        firestoreService.getRatedHotels { [weak self] result in
            switch result {
            case .success(let hotels):
                self?.loadRecommendations(with: hotels)
            case .failure(let error):
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
            }
        }
    }

    private func loadRecommendations(with hotels: [Hotel]) {
        MLService.getRecommendations(hotels) { [weak self] result in
            switch result {
            case .success(let data):
                self?.getHotelsFromRecommendations(data)
            case .failure(let error):
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
            }
        }
    }

    private func getHotelsFromRecommendations(_ recommendations: [String]) {
        viewModel.hotelList = []
        let dispatchGroup = DispatchGroup()

        for recommendation in recommendations {
            dispatchGroup.enter()
            firestoreService.getHotelByName(recommendation) { [weak self] result in
                switch result {
                case .success(let hotel):
                    self?.viewModel.hotelList.append(hotel)
                    dispatchGroup.leave()
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                    return
                }
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.configure(with: self?.viewModel)
            self?.view?.stopActivity {}
        }
    }

    // MARK: - Update journey block

    private func updateRecommendedJourney(with hotel: Hotel,
                                          destinationCityInfo: CityRequestInfo) {
        user.recommendedJourney.destinationCityInfo = destinationCityInfo
        user.recommendedJourney.hotel = hotel
        firestoreService.updateUserJourney(user.recommendedJourney, isInSearchModule: false) { [weak self] error in
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
