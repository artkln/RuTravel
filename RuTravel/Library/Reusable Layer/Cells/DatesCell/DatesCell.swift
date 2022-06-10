//
//  DatesCell.swift
//  RuTravel
//
//  Created by kalinin on 08.05.2022.
//

import UIKit

final class DatesCell: UITableViewCell, InfoCell {

    // MARK: - Nested Types

    private enum Constants {
        static let textFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 19)
        static let dateFormat: String = "yyyy-MM-dd"
        static let startDateLabelText: String = "Начало поездки:"
        static let endDateLabelText: String = "Окончание поездки:"
        static let confirmButtonTitle: String = "Показать отели"
    }

    // MARK: - Subviews

    @IBOutlet private weak var startDateLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var startDatePicker: UIDatePicker!
    @IBOutlet private weak var endDatePicker: UIDatePicker!
    @IBOutlet private weak var confirmButton: RuTravelButton!

    // MARK: - Static Properties

    static let cellId: String = "DatesCell"

    // MARK: - Private Properties

    private var startDate = String()
    private var endDate = String()
    private var onDateConfirm: ((String, String) -> Void)?

    // MARK: - Initialization

    override func awakeFromNib() {
        configureAppearance()
    }

    // MARK: - InfoCell

    func configure(with model: InfoCellModel) {
        guard let model = model as? DatesCellModel else {
            fatalError("Unable to cast model as DatesCellModel: \(model)")
        }
        self.onDateConfirm = model.onDateConfirm
        confirmButton.set(Constants.confirmButtonTitle)
    }

}

// MARK: - Appearance

private extension DatesCell {

    func configureAppearance() {
        configureStartDateLabel()
        configureDates()
        configureEndDateLabel()
        configureStartDatePicker()
        configureEndDatePicker()
        configureConfirmButton()
    }

    func configureDates() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        startDate = dateFormatter.string(from: Date())
        endDate = dateFormatter.string(from: Date())
    }

    func configureStartDateLabel() {
        startDateLabel.font = Constants.textFont
        startDateLabel.text = Constants.startDateLabelText
    }

    func configureEndDateLabel() {
        endDateLabel.font = Constants.textFont
        endDateLabel.text = Constants.endDateLabelText
    }

    func configureStartDatePicker() {
        startDatePicker.date = Date()
        startDatePicker.locale = .current
        startDatePicker.preferredDatePickerStyle = .compact
        startDatePicker.addTarget(
            self,
            action: #selector(handleStartDateSelection(_:)),
            for: .valueChanged
        )
    }

    func configureEndDatePicker() {
        endDatePicker.date = Date()
        endDatePicker.locale = .current
        endDatePicker.preferredDatePickerStyle = .compact
        endDatePicker.addTarget(
            self,
            action: #selector(handleEndDateSelection(_:)),
            for: .valueChanged
        )
    }

    func configureConfirmButton() {
        confirmButton.applyStyle(.blue)
        confirmButton.addTarget(
            self,
            action: #selector(buttonPressed),
            for: .touchUpInside
        )
        confirmButton.setEnabled(false)
    }

}

@objc
private extension DatesCell {

    func handleStartDateSelection(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        startDate = dateFormatter.string(from: sender.date)

        confirmButton.setEnabled(startDatePicker.date < endDatePicker.date)
    }

    func handleEndDateSelection(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        endDate = dateFormatter.string(from: sender.date)

        confirmButton.setEnabled(endDatePicker.date > startDatePicker.date)
    }

    func buttonPressed() {
        onDateConfirm?(startDate, endDate)
    }

}
