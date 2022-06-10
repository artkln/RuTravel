//
//  FavouriteHotelsPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class FavouriteHotelsPresenter: FavouriteHotelsViewOutput, FavouriteHotelsModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
    }

    // MARK: - Properties

    weak var view: FavouriteHotelsViewInput?
    var router: FavouriteHotelsRouterInput?
    var output: FavouriteHotelsModuleOutput?

    // MARK: - Private Properties

    private let firestoreService = FirestoreService.shared

    // MARK: - FavouriteHotelsViewOutput

    func loadData() {
        view?.startActivity { [weak self] in
            self?.firestoreService.getFavouriteHotels { result in
                switch result {
                case .success(let hotels):
                    if hotels.isEmpty {
                        self?.view?.showBlockerScreen()
                        self?.view?.stopActivity {}
                        return
                    }

                    self?.view?.configure(with: FavouriteHotelsModel(hotelList: hotels))
                    self?.view?.stopActivity {}
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

    func morePressed(_ hotel: Hotel) {
        guard let URL = URL(string: hotel.link ?? String()) else {
            return
        }

        UIApplication.shared.open(URL)
    }

}
