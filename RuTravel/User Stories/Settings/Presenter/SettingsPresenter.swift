//
//  SettingsPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 14/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class SettingsPresenter: SettingsViewOutput, SettingsModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
    }

    // MARK: - Properties

    weak var view: SettingsViewInput?
    var router: SettingsRouterInput?
    var output: SettingsModuleOutput?

    // MARK: - Private Properties

    private let firestoreService = FirestoreService.shared
    private let authService = AuthService.shared

    // MARK: - SettingsViewOutput

    func loadData() {
        firestoreService.listenOnUserUpdates { [weak self] result in
            switch result {
            case .success(let user):
                self?.view?.configure(with: SettingsModel(
                    name: user.name,
                    email: user.email,
                    departureCityName: user.searchedJourney.departureCityInfo?.name
                ))
            case .failure(let error):
                self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
            }
        }
    }

    func updateAuthName(_ newName: String) {
        view?.startActivity { [weak self] in

            self?.authService.setName(newName) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.localizedDescription)
                        return
                    }
                }
                self?.updateFirestoreName(newName)
            }
        }
    }

    func updateAuthEmail(_ newEmail: String) {
        view?.startActivity { [weak self] in

            self?.authService.setEmail(newEmail) { error in
                if let error = error {
                    self?.view?.stopActivity {
                        self?.view?.showPrompt(title: Constants.alertTitle, message: error.localizedDescription)
                        return
                    }
                }
                self?.updateFirestoreEmail(newEmail)
            }
        }
    }

    func changeCityRowSelected() {
        router?.pushDepartureCityPickModule()
    }

    // MARK: - Private methods

    private func updateFirestoreName(_ newName: String) {
        firestoreService.updateUserName(newName) { [weak self] error in
            if let error = error {
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
            }
            self?.view?.stopActivity {}
        }
    }

    private func updateFirestoreEmail(_ newEmail: String) {
        firestoreService.updateUserEmail(newEmail) { [weak self] error in
            if let error = error {
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.description)
                }
            }
            self?.view?.stopActivity {}
        }
    }

}
