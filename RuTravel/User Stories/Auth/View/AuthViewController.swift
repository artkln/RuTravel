//
//  AuthViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 13/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

final class AuthViewController: UIViewController, AuthViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let textFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 16)
        static let titleFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 28)
    }

    // MARK: - Private Properties

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var alreadyRegisteredLabel: UILabel!
    @IBOutlet private weak var lowerButton: RuTravelButton!
    @IBOutlet private weak var upperButton: RuTravelButton!

    private var model: AuthModel?

    // MARK: - Properties

    var output: AuthViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.loadData()
    }

    // MARK: - AuthViewInput

    func configure(with model: AuthModel) {
        self.model = model
        titleLabel.text = model.title
        nameField.placeholder = model.nameFieldPlaceholder
        nameField.isHidden = !model.isSignUpNeeded
        emailField.placeholder = model.emailFieldPlaceholder
        passwordField.placeholder = model.passwordFieldPlaceholder
        alreadyRegisteredLabel.text = model.alreadyRegisteredTitle
        lowerButton.set(model.lowerButtonTitle)
        upperButton.set(model.upperButtonTitle)
    }

    func showPrompt(title: String, message: String) {
        showAlert(title: title, message: message)
    }

    func startActivity(completion: @escaping () -> Void) {
        showActivityAlert(completion: completion)
    }

    func stopActivity(completion: @escaping () -> Void) {
        hideActivityAlert(completion: completion)
    }

}

// MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

}

// MARK: - Appearance

private extension AuthViewController {

    func configureAppearance() {
        hideKeyboardWhenTappedAround()

        configureTitleLabel()
        configureAlreadyRegisteredLabel()
        configureUpperButton()
        configureLowerButton()
        configureNameField()
        configureEmailField()
        configurePasswordField()
    }

    func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = Constants.titleFont
    }

    func configureAlreadyRegisteredLabel() {
        alreadyRegisteredLabel.textAlignment = .center
        alreadyRegisteredLabel.font = Constants.textFont
    }

    func configureUpperButton() {
        upperButton.applyStyle(.blue)
        upperButton.addTarget(self, action: #selector(upperButtonPressed(_:)), for: .touchUpInside)
    }

    func configureLowerButton() {
        lowerButton.applyStyle(.blue)
        lowerButton.addTarget(self, action: #selector(lowerButtonPressed(_:)), for: .touchUpInside)
    }

    func configureNameField() {
        nameField.textContentType = .name
        nameField.autocapitalizationType = .words
    }

    func configureEmailField() {
        emailField.textContentType = .emailAddress
        emailField.keyboardType = .emailAddress
    }

    func configurePasswordField() {
        passwordField.textContentType = .password
        passwordField.isSecureTextEntry = true
    }

}

// MARK: - Actions

@objc
private extension AuthViewController {

    func upperButtonPressed(_ sender: Any) {
        output?.upperPressed()
    }

    func lowerButtonPressed(_ sender: Any) {
        guard
            let name = nameField.text,
            let email = emailField.text,
            let password = passwordField.text else {
            return
        }
        output?.lowerPressed(name: name, email: email, password: password)
    }

}
