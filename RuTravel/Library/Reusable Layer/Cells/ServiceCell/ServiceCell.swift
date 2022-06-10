//
//  ServiceCell.swift
//  RuTravel
//
//  Created by kalinin on 08.05.2022.
//

import UIKit

final class ServiceCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let nameFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 19)
        static let priceFont: UIFont = FontFamily.SFProDisplay.lightItalic.font(size: 19)
        static let separator: String = "\n\n"
    }

    // MARK: - Subviews

    @IBOutlet private weak var label: UILabel!

    // MARK: - Static Properties

    static let cellId: String = "ServiceCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - DestinationCityInfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? ServiceCellModel else {
            fatalError("Unable to cast model as ServiceCellModel: \(model)")
        }
        fillServiceList(with: model.serviceInfo)
    }

}

// MARK: - Appearance

private extension ServiceCell {

    func configureAppearance() {
        label.numberOfLines = 0
    }

    func fillServiceList(with info: [String: String]) {
        let serviceList = NSMutableAttributedString()
        var nameAttributes = [NSAttributedString.Key: Any]()
        var priceAttributes = [NSAttributedString.Key: Any]()
        nameAttributes[.font] = Constants.nameFont
        priceAttributes[.font] = Constants.priceFont

        info.forEach {
            serviceList.append(NSAttributedString(
                string: $0.key,
                attributes: nameAttributes
            ))
            serviceList.append(NSAttributedString(
                string: $0.value,
                attributes: priceAttributes
            ))
            serviceList.append(NSAttributedString(
                string: Constants.separator,
                attributes: nil
            ))
        }

        label.attributedText = serviceList
    }

}
