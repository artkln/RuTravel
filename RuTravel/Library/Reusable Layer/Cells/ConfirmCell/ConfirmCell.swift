//
//  ConfirmCell.swift
//  RuTravel
//
//  Created by kalinin on 10.05.2022.
//

import UIKit

final class ConfirmCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let textFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 19)
    }

    // MARK: - Private properties

    @IBOutlet private weak var button: RuTravelButton!
    private var onButtonPressed: (() -> Void)?

    // MARK: - Static Properties

    static let cellId: String = "ConfirmCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - DestinationCityInfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? ConfirmCellModel else {
            fatalError("Unable to cast model as ConfirmCellModel: \(model)")
        }
        onButtonPressed = model.onButtonPressed
        button.set(model.buttonTitle)
        button.applyStyle(model.buttonStyle)
    }

}

// MARK: - Appearance

private extension ConfirmCell {

    func configureAppearance() {
        button.applyStyle(.blue)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }

    @objc
    func buttonPressed(_ sender: Any) {
        onButtonPressed?()
    }

}
