//
//  PlainLabelCell.swift
//  RuTravel
//
//  Created by kalinin on 07.05.2022.
//

import UIKit

final class PlainLabelCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let textFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 19)
    }

    // MARK: - Subviews

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var accessoryButton: UIButton!

    // MARK: - Static Properties

    static let cellId: String = "PlainLabelCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - DestinationCityInfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? PlainLabelCellModel else {
            fatalError("Unable to cast model as PlainLabelCellModel: \(model)")
        }
        label.text = model.text
        accessoryButton.isHidden = model.isAccessoryButtonNeeded ? false : true
    }

}

// MARK: - Appearance

private extension PlainLabelCell {

    func configureAppearance() {
        label.numberOfLines = 0
        label.font = Constants.textFont

        accessoryButton.setImage(Asset.arrowIcon.image, for: .normal)
    }

}
