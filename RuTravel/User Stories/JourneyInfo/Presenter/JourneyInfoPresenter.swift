//
//  JourneyInfoPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class JourneyInfoPresenter: JourneyInfoViewOutput, JourneyInfoModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
    }

    // MARK: - Properties

    weak var view: JourneyInfoViewInput?
    var router: JourneyInfoRouterInput?
    var output: JourneyInfoModuleOutput?

    // MARK: - Private Properties

    private let firestoreService = FirestoreService.shared
    private let imageService = ImageService.shared
    private var isInSearchModule: Bool
    private var user = User()

    // MARK: - Initialization

    init(_ isInSearchModule: Bool) {
        self.isInSearchModule = isInSearchModule
    }

    // MARK: - JourneyInfoViewOutput

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
                    self?.loadSearchedHotelPicture(for: user) :
                    self?.loadRecommendedHotelPicture(for: user)
                case .failure(let error):
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                }
            }
        }
    }

    func confirmPressed() {
        view?.startActivity { [weak self] in

            guard let isInSearchModule = self?.isInSearchModule else {
                self?.view?.stopActivity {}
                return
            }

            let journey = isInSearchModule ?
                self?.user.searchedJourney ?? Journey() :
                self?.user.recommendedJourney ?? Journey()
            self?.firestoreService.saveOrderedJourney(journey) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                    }
                    return
                }

                self?.view?.stopActivity {
                    self?.router?.pushResultModule()
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

    // MARK: - Private Methods

    private func loadSearchedHotelPicture(for user: User) {
        imageService.loadPictureFrom(
            user.searchedJourney.hotel?.imageUrl ?? String()
        ) { [weak self] picture in
            if let picture = picture {
                user.searchedJourney.hotel?.picture = picture
            } else {
                user.searchedJourney.hotel?.picture = Asset.photoPlaceholder.image
            }

            self?.loadSearchedFlightPicture(for: user)
        }
    }

    private func loadRecommendedHotelPicture(for user: User) {
        imageService.loadPictureFrom(
            user.recommendedJourney.hotel?.imageUrl ?? String()
        ) { [weak self] picture in
            if let picture = picture {
                user.recommendedJourney.hotel?.picture = picture
            } else {
                user.recommendedJourney.hotel?.picture = Asset.photoPlaceholder.image
            }

            self?.loadRecommendedFlightPicture(for: user)
        }
    }

    private func loadSearchedFlightPicture(for user: User) {
        imageService.loadPictureFrom(
            user.searchedJourney.flight?.imageUrl ?? String()
        ) { [weak self] picture in
            if let picture = picture {
                user.searchedJourney.flight?.picture = picture
            } else {
                user.searchedJourney.flight?.picture = Asset.photoPlaceholder.image
            }

            DispatchQueue.main.async {
                self?.view?.configure(with: JourneyInfoModel(journey: user.searchedJourney))
                self?.view?.stopActivity {}
            }
        }
    }

    private func loadRecommendedFlightPicture(for user: User) {
        imageService.loadPictureFrom(
            user.recommendedJourney.flight?.imageUrl ?? String()
        ) { [weak self] picture in
            if let picture = picture {
                user.recommendedJourney.flight?.picture = picture
            } else {
                user.recommendedJourney.flight?.picture = Asset.photoPlaceholder.image
            }

            DispatchQueue.main.async {
                self?.view?.configure(with: JourneyInfoModel(journey: user.recommendedJourney))
                self?.view?.stopActivity {}
            }
        }
    }

}
