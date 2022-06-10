//
//  CarouselCell.swift
//  RuTravel
//
//  Created by kalinin on 06.05.2022.
//

import UIKit

final class CarouselCell: UICollectionViewCell {

    // MARK: - Nested Types

    private enum Constants {
        static let imageCornerRadius: CGFloat = 5
    }

    // MARK: - Subviews

    @IBOutlet private weak var imageView: UIImageView!

    // MARK: - Static Properties

    static let cellId: String = "CarouselCell"

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    func configure(with image: UIImage) {
        imageView.image = image
    }

}

// MARK: - Appearance

private extension CarouselCell {

    func configureAppearance() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.imageCornerRadius
    }

}
