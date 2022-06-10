//
//  BulletedLabelCell.swift
//  RuTravel
//
//  Created by kalinin on 07.05.2022.
//

import UIKit

final class BulletedLabelCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let textFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 19)
        static let bullet: String = "✔  "
        static let separator: String = "\n\n"
    }

    // MARK: - Subviews

    @IBOutlet private weak var label: UILabel!

    // MARK: - Static Properties

    static let cellId: String = "BulletedLabelCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - DestinationCityInfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? BulletedLabelCellModel else {
            fatalError("Unable to cast model as BulletedLabelCellModel: \(model)")
        }
        fillBulletedList(with: model.text)
    }

}

// MARK: - Appearance

private extension BulletedLabelCell {

    func configureAppearance() {
        label.numberOfLines = 0
    }

    func fillBulletedList(with text: [String]) {
        let bulletedText = text.map { return Constants.bullet + $0 }

        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = Constants.textFont

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (Constants.bullet as NSString)
            .size(withAttributes: attributes)
            .width
        attributes[.paragraphStyle] = paragraphStyle

        let string = bulletedText.joined(separator: Constants.separator)
        label.attributedText = NSAttributedString(
                                    string: string,
                                    attributes: attributes
        )
    }

}
