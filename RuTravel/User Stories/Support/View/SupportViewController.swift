//
//  SupportViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SupportViewController: UIViewController, SupportViewInput, ModuleTransitionable {

    // MARK: - Nested Types

    private enum Constants {
        static let textFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 19)
        static let title: String = "Поддержка"
    }

    // MARK: - Private Properties

    @IBOutlet private weak var mainTextLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var vkTextView: UITextView!
    @IBOutlet private weak var telegramTextView: UITextView!
    @IBOutlet private weak var copyrightLabel: UILabel!
    @IBOutlet private weak var phoneImageView: UIImageView!
    @IBOutlet private weak var vkImageView: UIImageView!
    @IBOutlet private weak var telegramImageView: UIImageView!
    private var model: SupportModel?

    // MARK: - Properties

    var output: SupportViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.loadData()
    }

    // MARK: - SupportViewInput

    func configure(with model: SupportModel) {
        self.model = model

        title = Constants.title
        mainTextLabel.text = model.mainText
        phoneLabel.text = model.phoneText
        vkTextView.attributedText = model.vkLink
        telegramTextView.attributedText = model.telegramLink
        copyrightLabel.text = model.copyrightText
    }

}

// MARK: - UITextViewDelegate

extension SupportViewController: UITextViewDelegate {

    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }

}

// MARK: - Appearance

private extension SupportViewController {

    func configureAppearance() {
        configureLabels()
        configureImageViews()
    }

    func configureLabels() {
        mainTextLabel.numberOfLines = 0
        mainTextLabel.font = Constants.textFont
        mainTextLabel.textAlignment = .center

        copyrightLabel.numberOfLines = 0
        copyrightLabel.font = Constants.textFont
        copyrightLabel.textAlignment = .center

        phoneLabel.numberOfLines = 1
        phoneLabel.font = Constants.textFont
        phoneLabel.textAlignment = .left
    }

    func configureImageViews() {
        phoneImageView.image = Asset.phoneLogo.image
        vkImageView.image = Asset.vkLogo.image
        telegramImageView.image = Asset.telegramLogo.image
    }

}
