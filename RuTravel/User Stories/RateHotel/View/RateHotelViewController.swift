//
//  RateHotelViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class RateHotelViewController: UIViewController, RateHotelViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let titleFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 20)
    }

    // MARK: - Properties

    var output: RateHotelViewOutput?

    // MARK: - Private Properties

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var backButton: RuTravelButton!
    @IBOutlet private weak var rateButton: RuTravelButton!

    private var rating: Double?
    private var model: RateHotelModel?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.loadData()
    }

    // MARK: - RateHotelViewInput

    func configure(with model: RateHotelModel) {
        self.model = model
        titleLabel.text = model.title
        rateButton.set(model.rateButtonTitle)
        backButton.set(model.backButtonTitle)
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

extension RateHotelViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        rateButton.setEnabled(true)
        return true
    }

}

// MARK: - Appearance

private extension RateHotelViewController {

    func configureAppearance() {
        hideKeyboardWhenTappedAround()

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = Constants.titleFont

        rateButton.applyStyle(.blue)
        rateButton.addTarget(self, action: #selector(rateButtonPressed(_:)), for: .touchUpInside)
        rateButton.setEnabled(false)

        backButton.applyStyle(.blue)
        backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
    }

}

// MARK: - Actions

@objc
private extension RateHotelViewController {

    func rateButtonPressed(_ sender: Any) {
        guard let stringRating = textField.text else {
            return
        }

        guard
            let intRating = Int(stringRating),
            intRating >= 0,
            intRating <= 100 else {
            output?.incorrectRating()
            return
        }

        output?.ratePressed(rating: intRating)
    }

    func backButtonPressed(_ sender: Any) {
        output?.backPressed()
    }

}
