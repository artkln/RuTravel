//
//  TitleCell.swift
//  RuTravel
//
//  Created by kalinin on 07.05.2022.
//

import UIKit

final class TitleCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let titleFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 28)
    }

    // MARK: - Subviews

    @IBOutlet private weak var label: UILabel!

    // MARK: - Static Properties

    static let cellId: String = "TitleCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - DestinationCityInfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? TitleCellModel else {
            fatalError("Unable to cast model as TitleCellModel: \(model)")
        }
        label.text = model.text
    }

}

// MARK: - Appearance

private extension TitleCell {

    func configureAppearance() {
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Constants.titleFont
    }

}
