//
//  CityCell.swift
//  RuTravel
//
//  Created by kalinin on 23.05.2022.
//

import UIKit

class CityCell: UITableViewCell {

    // MARK: - Nested Types

    private enum Constants {
        static let textFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 26)
    }

    // MARK: - Private properties

    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var cityImageView: UIImageView!

    // MARK: - Static Properties

    static let cellId: String = "CityCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - DestinationCityInfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? CityCellModel else {
            fatalError("Unable to cast model as CityCellModel: \(model)")
        }

        cityNameLabel.text = model.text
        cityImageView.image = model.image
    }

}

// MARK: - Appearance

private extension CityCell {

    func configureAppearance() {
        cityNameLabel.numberOfLines = 1
        cityNameLabel.font = Constants.textFont
        cityNameLabel.textAlignment = .center
        cityNameLabel.textColor = ColorName.white.color

        cityImageView.contentMode = .scaleAspectFill
    }

}
