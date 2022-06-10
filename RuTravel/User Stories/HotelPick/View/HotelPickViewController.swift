//
//  HotelPickViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 10/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HotelPickViewController: UIViewController, HotelPickViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let tableViewRowHeight: CGFloat = 60
        static let sectionsNumber: Int = 2
        static let rowsInMainSectionNumber: Int = 2
    }

    // MARK: - Private Properties

    @IBOutlet private weak var tableView: UITableView!
    private var model: HotelPickModel?

    // MARK: - Properties

    var output: HotelPickViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.loadData()
    }

    // MARK: - DestinationCityPickViewInput

    func configure(with model: HotelPickModel) {
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

// MARK: - Appearance

private extension HotelPickViewController {

    func configureAppearance() {
        configureTableView()
    }

    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.tableViewRowHeight
        tableView.separatorStyle = .none
        tableView.register(
            UINib(
                nibName: HotelCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: HotelCell.cellId
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
                nibName: DatesCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: DatesCell.cellId
        )
    }

}

// MARK: - UITableViewDataSource

extension HotelPickViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sectionsNumber
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = model else {
            return 0
        }

        guard section > 0 else {
            return Constants.rowsInMainSectionNumber
        }

        return model.hotelList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else {
            return UITableViewCell()
        }

        guard indexPath.section > 0 else {
            return mainSectionCell(in: tableView, indexPath: indexPath, model: model)
        }

        return hotelSectionCell(in: tableView, indexPath: indexPath, model: model)
    }

    func mainSectionCell(in tableView: UITableView,
                            indexPath: IndexPath,
                            model: HotelPickModel) -> UITableViewCell {
        guard let row = HotelPickMainSectionRows(rawValue: indexPath.row) else {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: row.cellIdentifier,
            for: indexPath
        ) as? InfoCell else {
            return UITableViewCell()
        }

        switch row {
        case .title:
            cell.configure(with: TitleCellModel(text: model.title))
        case .dates:
            cell.configure(with: DatesCellModel(
                onDateConfirm: { [weak self] startDate, endDate in
                    self?.output?.dateConfirmed(startDate: startDate, endDate: endDate)
                }
            ))
        }

        return cell as? UITableViewCell ?? UITableViewCell()
    }

    func hotelSectionCell(in tableView: UITableView,
                            indexPath: IndexPath,
                            model: HotelPickModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell (
            withIdentifier: HotelCell.cellId,
            for: indexPath
        ) as? HotelCell else {
            return UITableViewCell()
        }

        let hotel = model.hotelList[indexPath.row]

        cell.configure(with: HotelCellModel(
            hotel: hotel,
            onSelectButtonPressed: { [weak self] in
                self?.output?.hotelSelected(hotel)
            },
            onRateButtonPressed: { [weak self] in
                self?.output?.needRateHotel(hotel)
            },
            onFavouriteButtonPressed: { [weak self] in
                self?.output?.favouritePressed(hotel)
            },
            onMoreButtonPressed: { [weak self] in
                self?.output?.morePressed(hotel)
            },
            needOnlyRateButton: false,
            areButtonsHidden: false
        ))

        return cell
    }

}

// MARK: - UITableViewDelegate

extension HotelPickViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
