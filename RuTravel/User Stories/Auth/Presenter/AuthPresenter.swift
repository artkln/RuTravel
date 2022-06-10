//
//  AuthPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 13/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseFirestore
import FirebaseAuth

final class AuthPresenter: AuthViewOutput, AuthModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
        static let emptyFieldsAlertMessage: String = "Заполните все поля"
        static let cantGetUserData: String = "Не удалось получить информацию о пользователе."
    }

    // MARK: - Properties

    weak var view: AuthViewInput?
    var router: AuthRouterInput?
    var output: AuthModuleOutput?

    private let authService = AuthService.shared
    private let firestoreService = FirestoreService.shared
    private var viewModel = AuthModel()

    // MARK: - AuthViewOutput

    func loadData() {
        view?.configure(with: viewModel)
    }

    func upperPressed() {
        viewModel.isSignUpNeeded.toggle()
        view?.configure(with: viewModel)
    }

    func lowerPressed(name: String, email: String, password: String) {
        viewModel.isSignUpNeeded ?
            signUp(name: name, email: email, password: password) :
            signIn(email: email, password: password)
    }

    // MARK: - Private methods

    private func signUp(name: String, email: String, password: String) {
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            view?.startActivity { [weak self] in
                self?.authService.handleSignUp(name: name, email: email, password: password) { result in
                    switch result {
                    case .success(let data):
                        self?.setName(name, for: data)
                    case .failure(let error):
                        self?.view?.stopActivity {
                            self?.view?.showPrompt(title: Constants.alertTitle, message: error.localizedDescription)
                        }
                    }
                }
            }
        } else {
            view?.showPrompt(title: Constants.alertTitle, message: Constants.emptyFieldsAlertMessage)
        }
    }

    private func setName(_ name: String, for data: AuthDataResult) {
        authService.setName(name) { [weak self] error in
            if let error = error {
                self?.view?.stopActivity {
                    self?.view?.showPrompt(title: Constants.alertTitle, message: error.localizedDescription)
                }
                return
            }
            self?.saveNewUser(with: data)
        }
    }

    private func saveNewUser(with data: AuthDataResult) {
        firestoreService.saveNewUser(data: data) { [weak self] error in
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

    private func signIn(email: String, password: String) {
        if !email.isEmpty && !password.isEmpty {
            view?.startActivity { [weak self] in
                self?.authService.handleSignIn(email: email, password: password) { error in
                    if let error = error {
                        self?.view?.stopActivity {
                            self?.view?.showPrompt(title: Constants.alertTitle, message: error.localizedDescription)
                        }
                        return
                    }

                    self?.view?.stopActivity {
                        self?.router?.dismissModule()
                    }
                }
            }
        } else {
            view?.showPrompt(title: Constants.alertTitle, message: Constants.emptyFieldsAlertMessage)
        }
    }

}
