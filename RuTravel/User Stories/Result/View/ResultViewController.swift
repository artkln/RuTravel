//
//  ResultViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ResultViewController: UIViewController, ResultViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let titleFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 28)
    }

    // MARK: - Properties

    var output: ResultViewOutput?

    // MARK: - Private Properties

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var confirmButton: RuTravelButton!
    private var model: ResultModel?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - ResultViewInput

    func configure(with model: ResultModel) {
        self.model = model
        titleLabel.text = model.title
        confirmButton.set(model.confirmButtonTitle)
    }

    func showPrompt(title: String, message: String) {
        showAlert(title: title, message: message)
    }

}

// MARK: - Appearance

private extension ResultViewController {

    func configureAppearance() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = Constants.titleFont

        confirmButton.applyStyle(.blue)
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed(_:)), for: .touchUpInside)
    }

}

// MARK: - Actions

@objc
private extension ResultViewController {

    func confirmButtonPressed(_ sender: Any) {
        output?.confirmPressed()
    }

}
