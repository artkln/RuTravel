//
//  InfoChangeableCell.swift
//  RuTravel
//
//  Created by kalinin on 21.05.2022.
//

import UIKit

final class InfoChangeableCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let textFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 19)
        static let changeButtonUnactiveTitle: String = "Изменить"
        static let changeButtonActiveTitle: String = "Отменить"
        static let confirmButtonTitle: String = "Подтвердить"
    }

    // MARK: - Private properties

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var confirmButton: RuTravelButton!
    @IBOutlet private weak var changeButton: RuTravelButton!
    @IBOutlet private weak var changeStackView: UIStackView!
    @IBOutlet private weak var changeTextField: UITextField!

    private var changeButtonIsUnactive = true {
        willSet {
            if newValue {
                changeButton.set(Constants.changeButtonUnactiveTitle)
                changeStackView.isHidden = true
            } else {
                changeButton.set(Constants.changeButtonActiveTitle)
                changeStackView.isHidden = false
            }
        }
    }

    private var onChangeButtonPressed: (() -> Void)?
    private var onConfirmButtonPressed: ((String) -> Void)?
    private var onTextFieldReturn: (() -> Void)?

    // MARK: - Static Properties

    static let cellId: String = "InfoChangeableCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - DestinationCityInfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? InfoChangeableCellModel else {
            fatalError("Unable to cast model as InfoChangeableCellModel: \(model)")
        }

        onChangeButtonPressed = model.onChangeButtonPressed
        onConfirmButtonPressed = model.onConfirmButtonPressed
        onTextFieldReturn = model.onTextFieldReturn
        label.text = model.text
    }

}

// MARK: - UITextFieldDelegate

extension InfoChangeableCell: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onTextFieldReturn?()
        return true
    }

}

// MARK: - Appearance

private extension InfoChangeableCell {

    func configureAppearance() {
        configureLabel()
        configureChangeButton()
        configureConfirmButton()
        configureChangeStackView()
    }

    func configureLabel() {
        label.numberOfLines = 1
        label.font = Constants.textFont
    }

    func configureChangeButton() {
        changeButton.set(Constants.changeButtonUnactiveTitle)
        changeButton.applyStyle(.blue)
        changeButton.addTarget(self, action: #selector(changeButtonPressed(_:)), for: .touchUpInside)
    }

    func configureConfirmButton() {
        confirmButton.set(Constants.confirmButtonTitle)
        confirmButton.applyStyle(.blue)
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed(_:)), for: .touchUpInside)
    }

    func configureChangeStackView() {
        changeStackView.isHidden = true
    }

}

// MARK: - Actions

@objc
private extension InfoChangeableCell {

    func changeButtonPressed(_ sender: Any) {
        changeButtonIsUnactive.toggle()
        onChangeButtonPressed?()
    }

    func confirmButtonPressed(_ sender: Any) {
        changeButtonIsUnactive = true
        onConfirmButtonPressed?(changeTextField.text ?? String())
    }

}
