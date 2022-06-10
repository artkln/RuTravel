//
//  JourneyInfoViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class JourneyInfoViewController: UIViewController, JourneyInfoViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let tableViewRowHeight: CGFloat = 200
        static let tableViewHeaderHeight: CGFloat = 20
        static let sectionsNumber: Int = 5
        static let rowsInSectionNumber: Int = 1
    }

    // MARK: - Private Properties

    @IBOutlet private weak var tableView: UITableView!
    private var model: JourneyInfoModel?

    // MARK: - Properties

    var output: JourneyInfoViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.loadData()
    }

    // MARK: - JourneyInfoViewInput

    func configure(with model: JourneyInfoModel) {
        self.model = model
        tableView.reloadData()
        navigationItem.backButtonTitle = model.backButtonTitle
    }

    func showPrompt(title: String, message: String) {
        showAlert(title: title, message: message)
    }

    func startActivity(completion: @escaping () -> Void) {
        showActivityAlert(completion: completion)
    }

    func stopActivity(completion: @escaping () -> Void) {
        hideActivityAlert(completion: completion)
    }

}

// MARK: - UITableViewDataSource

extension JourneyInfoViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sectionsNumber
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.rowsInSectionNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let model = model,
            let hotel = model.journey.hotel,
            let flight = model.journey.flight,
            let section = JourneyInfoSections(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: section.cellIdentifier,
            for: indexPath
        ) as? InfoCell else {
            return UITableViewCell()
        }

        switch section {
        case .title:
            cell.configure(with: TitleCellModel(text: model.title))
        case .dates:
            cell.configure(with: PlainLabelCellModel(
                text: model.journey.datesString,
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
        case .confirm:
            cell.configure(with: ConfirmCellModel(
                buttonTitle: model.confirmButtonTitle,
                buttonStyle: model.buttonStyle,
                onButtonPressed: { [weak self] in
                    self?.output?.confirmPressed()
                }
            ))
        }

        return cell as? UITableViewCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = JourneyInfoSections(rawValue: section) else {
            return nil
        }

        return section.header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.tableViewHeaderHeight
    }

}

// MARK: - UITableViewDelegate

extension JourneyInfoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - Appearance

private extension JourneyInfoViewController {

    func configureAppearance() {
        configureTableView()
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
                nibName: TitleCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: TitleCell.cellId
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
        tableView.register(
            UINib(
                nibName: ConfirmCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: ConfirmCell.cellId
        )
    }

}
