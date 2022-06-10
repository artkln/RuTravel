//
//  ProfilePresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth

final class ProfilePresenter: ProfileViewOutput, ProfileModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
        static let signOutFailedAlertMessage: String = "Выйти из аккаунта не удалось. Повторите попытку."
    }

    // MARK: - Properties

    weak var view: ProfileViewInput?
    var router: ProfileRouterInput?
    var output: ProfileModuleOutput?

    // MARK: - Private Properties

    private let firestoreService = FirestoreService.shared

    // MARK: - ProfileViewOutput

    func loadData() {
        firestoreService.listenOnUserUpdates { [weak self] result in
            switch result {
            case .success(let user):
                self?.view?.configure(with: ProfileModel(userName: user.name))
            case .failure(let error):
                self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
            }
        }
    }

    func exitPressed() {
        do {
            try Auth.auth().signOut()
        } catch {
            view?.showPrompt(title: Constants.alertTitle, message: Constants.signOutFailedAlertMessage)
        }
    }

    func settingsSelected() {
        router?.pushSettingsModule()
    }

    func favouriteHotelsSelected() {
        router?.pushFavouriteHotelsModule()
    }

    func favouriteFlightsSelected() {
        router?.pushFavouriteFlightsModule()
    }

    func orderedSelected() {
        router?.pushOrderedJourneysModule()
    }

    func supportSelected() {
        router?.pushSupportModule()
    }

}
