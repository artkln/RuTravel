//
//  SubDescriptionCell.swift
//  RuTravel
//
//  Created by kalinin on 07.05.2022.
//

import UIKit

final class SubDescriptionCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let subTextFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 16)
    }

    // MARK: - Subviews

    @IBOutlet private weak var label: UILabel!

    // MARK: - Static Properties

    static let cellId: String = "SubDescriptionCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - InfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? SubDescriptionCellModel else {
            fatalError("Unable to cast model as SubDescriptionCellModel: \(model)")
        }
        label.text = model.text
    }

}

// MARK: - Appearance

private extension SubDescriptionCell {

    func configureAppearance() {
        label.numberOfLines = 0
        label.font = Constants.subTextFont
        label.textColor = ColorName.gray.color
    }

}
