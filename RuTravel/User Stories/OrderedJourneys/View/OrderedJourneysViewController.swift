//
//  OrderedJourneysViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class OrderedJourneysViewController: UIViewController, OrderedJourneysViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let tableViewRowHeight: CGFloat = 200
        static let tableViewHeaderHeight: CGFloat = 20
        static let rowsInSectionNumber: Int = 3
        static let titleFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 28)
        static let blockerLabelText: String = "Закажите путешествие, чтобы оно отобразилось здесь."
        static let title: String = "Поездки"
    }

    // MARK: - Private Properties

    @IBOutlet private weak var blockerLabel: UILabel!
    @IBOutlet private weak var blockerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    private var model: OrderedJourneysModel?

    // MARK: - Properties

    var output: OrderedJourneysViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        hideMainInterface(true)
        hideBlockerInterface(true)
        output?.loadData()
    }

    // MARK: - OrderedJourneysViewInput

    func configure(with model: OrderedJourneysModel) {
        self.model = model
        configureAppearance()

        title = Constants.title
        tableView.reloadData()
    }

    func showPrompt(title: String, message: String) {
        showAlert(title: title, message: message)
    }

    func showBlockerScreen() {
        configureBlockerAppearance()
    }

    func startActivity(completion: @escaping () -> Void) {
        showActivityAlert(completion: completion)
    }

    func stopActivity(completion: @escaping () -> Void) {
        hideActivityAlert(completion: completion)
    }

}

// MARK: - UITableViewDataSource

extension OrderedJourneysViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let model = model else {
            return 0
        }

        return model.journeysList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.rowsInSectionNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let model = model,
            let row = OrderedJourneysSectionRows(rawValue: indexPath.row) else {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: row.cellIdentifier,
            for: indexPath
        ) as? InfoCell else {
            return UITableViewCell()
        }

        let journey = model.journeysList[indexPath.section]

        guard
            let hotel = journey.hotel,
            let flight = journey.flight else {
            return UITableViewCell()
        }

        switch row {
        case .dates:
            cell.configure(with: PlainLabelCellModel(
                text: journey.datesString,
                isAccessoryButtonNeeded: false
            ))
        case .hotel:
            cell.configure(with: HotelCellModel(
                hotel: hotel,
                onSelectButtonPressed: nil,
                onRateButtonPressed: nil,
                onFavouriteButtonPressed: nil,
                onMoreButtonPressed: { [weak self] in
                    self?.output?.morePressed(hotel)
                },
                needOnlyRateButton: false,
                areButtonsHidden: true
            ))
        case .flight:
            cell.configure(with: FlightCellModel(
                flight: flight,
                onSelectButtonPressed: nil,
                onFavouriteButtonPressed: nil,
                onMoreButtonPressed: { [weak self] in
                    self?.output?.morePressed(flight)
                },
                areButtonsHidden: true
            ))
        }

        return cell as? UITableViewCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Поездка \(section + 1)"
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.tableViewHeaderHeight
    }

}

// MARK: - UITableViewDelegate

extension OrderedJourneysViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - Appearance

private extension OrderedJourneysViewController {

    func configureAppearance() {
        configureTableView()
        hideMainInterface(false)
        hideBlockerInterface(true)
    }

    func hideMainInterface(_ hide: Bool) {
        tableView.isHidden = hide
    }

    func hideBlockerInterface(_ hide: Bool) {
        blockerLabel.isHidden = hide
        blockerView.isHidden = hide
    }

    func configureBlockerAppearance() {
        hideBlockerInterface(false)

        title = Constants.title
        blockerLabel.numberOfLines = 0
        blockerLabel.textAlignment = .center
        blockerLabel.font = Constants.titleFont
        blockerLabel.text = Constants.blockerLabelText
    }

    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.tableViewRowHeight
        tableView.separatorStyle = .none
        tableView.register(
            UINib(
                nibName: PlainLabelCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: PlainLabelCell.cellId
        )
        tableView.register(
            UINib(
                nibName: HotelCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: HotelCell.cellId
        )
        tableView.register(
            UINib(
                nibName: FlightCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: FlightCell.cellId
        )
    }

}
