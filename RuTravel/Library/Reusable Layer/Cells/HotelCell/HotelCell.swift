//
//  HotelCell.swift
//  RuTravel
//
//  Created by kalinin on 10.05.2022.
//

import UIKit

final class HotelCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let nameTextFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 19)
        static let descriptionTextFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 16)
        static let rateButtonTitle: String = "Оценить"
        static let selectButtonTitle: String = "Выбрать"
        static let favouriteButtonTitle: String = "Избранное"
        static let moreButtonTitle: String = "Подробнее"
        static let bullet: String = "•  "
        static let imageCornerRadius: CGFloat = 5
    }

    // MARK: - Private properties

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var hotelImageView: UIImageView!
    @IBOutlet private weak var moreButton: RuTravelButton!
    @IBOutlet private weak var rateButton: RuTravelButton!
    @IBOutlet private weak var selectButton: RuTravelButton!
    @IBOutlet private weak var favouriteButton: RuTravelButton!
    @IBOutlet private weak var buttonsStackView: UIStackView!

    private var onSelectButtonPressed: (() -> Void)?
    private var onRateButtonPressed: (() -> Void)?
    private var onFavouriteButtonPressed: (() -> Void)?
    private var onMoreButtonPressed: (() -> Void)?

    // MARK: - Static Properties

    static let cellId: String = "HotelCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - DestinationCityInfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? HotelCellModel else {
            fatalError("Unable to cast model as HotelCellModel: \(model)")
        }

        onSelectButtonPressed = model.onSelectButtonPressed
        onRateButtonPressed = model.onRateButtonPressed
        onFavouriteButtonPressed = model.onFavouriteButtonPressed
        onMoreButtonPressed = model.onMoreButtonPressed

        nameLabel.text = model.hotel.name
        hotelImageView.image = model.hotel.picture
        favouriteButton.isHidden = model.needOnlyRateButton
        selectButton.isHidden = model.needOnlyRateButton
        buttonsStackView.isHidden = model.areButtonsHidden

        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = Constants.descriptionTextFont

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (Constants.bullet as NSString)
            .size(withAttributes: attributes)
            .width
        attributes[.paragraphStyle] = paragraphStyle
        descriptionLabel.attributedText = NSAttributedString(
            string: model.hotel.bulletedText ?? String(),
            attributes: attributes
        )
    }

}

// MARK: - Appearance

private extension HotelCell {

    func configureAppearance() {
        configureLabels()
        configureRateButton()
        configureSelectButton()
        configureFavouriteButton()
        configureMoreButton()
        configureHotelImageView()
    }

    func configureLabels() {
        nameLabel.numberOfLines = 0
        nameLabel.font = Constants.nameTextFont
        nameLabel.textAlignment = .center

        descriptionLabel.numberOfLines = 0
    }

    func configureRateButton() {
        rateButton.set(Constants.rateButtonTitle)
        rateButton.applyStyle(.blue)
        rateButton.addTarget(self, action: #selector(rateButtonPressed(_:)), for: .touchUpInside)
    }

    func configureSelectButton() {
        selectButton.set(Constants.selectButtonTitle)
        selectButton.applyStyle(.blue)
        selectButton.addTarget(self, action: #selector(selectButtonPressed(_:)), for: .touchUpInside)
    }

    func configureFavouriteButton() {
        favouriteButton.set(Constants.favouriteButtonTitle)
        favouriteButton.applyStyle(.blue)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed(_:)), for: .touchUpInside)
    }

    func configureMoreButton() {
        moreButton.set(Constants.moreButtonTitle)
        moreButton.applyStyle(.blue)
        moreButton.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
    }

    func configureHotelImageView() {
        hotelImageView.contentMode = .scaleAspectFill
        hotelImageView.clipsToBounds = true
        hotelImageView.layer.cornerRadius = Constants.imageCornerRadius
    }
}

// MARK: - Actions

@objc
private extension HotelCell {

    func selectButtonPressed(_ sender: Any) {
        onSelectButtonPressed?()
    }

    func rateButtonPressed(_ sender: Any) {
        onRateButtonPressed?()
    }

    func favouriteButtonPressed(_ sender: Any) {
        onFavouriteButtonPressed?()
    }

    func moreButtonPressed(_ sender: Any) {
        onMoreButtonPressed?()
    }

}
