//
//  FlightPickViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 11/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class FlightPickViewController: UIViewController, FlightPickViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let tableViewRowHeight: CGFloat = 200
        static let sectionsNumber: Int = 2
        static let rowsInMainSectionNumber: Int = 1
        static let titleFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 28)
        static let blockerLabelText: String = "Мы не смогли найти перелёты на выбранные даты." +
                        " Выберите другие даты и попробуйте ещё раз."
    }

    // MARK: - Private Properties

    @IBOutlet private weak var blockerLabel: UILabel!
    @IBOutlet private weak var blockerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    private var model: FlightPickModel?

    // MARK: - Properties

    var output: FlightPickViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        hideMainInterface(true)
        hideBlockerInterface(true)
        output?.loadData()
    }

    // MARK: - FlightPickViewInput

    func configure(with model: FlightPickModel) {
        self.model = model
        configureAppearance()

        tableView.reloadData()
        navigationItem.backButtonTitle = model.backButtonTitle
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

extension FlightPickViewController: UITableViewDataSource {

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

        return model.flightList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else {
            return UITableViewCell()
        }

        guard indexPath.section > 0 else {
            return mainSectionCell(in: tableView, indexPath: indexPath, model: model)
        }

        return flightSectionCell(in: tableView, indexPath: indexPath, model: model)
    }

    func mainSectionCell(in tableView: UITableView,
                            indexPath: IndexPath,
                            model: FlightPickModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TitleCell.cellId,
            for: indexPath
        ) as? InfoCell else {
            return UITableViewCell()
        }

        cell.configure(with: TitleCellModel(text: model.title))

        return cell as? UITableViewCell ?? UITableViewCell()
    }

    func flightSectionCell(in tableView: UITableView,
                            indexPath: IndexPath,
                            model: FlightPickModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FlightCell.cellId,
            for: indexPath
        ) as? FlightCell else {
            return UITableViewCell()
        }

        let flight = model.flightList[indexPath.row]

        cell.configure(with: FlightCellModel(
            flight: flight,
            onSelectButtonPressed: { [weak self] in
                self?.output?.flightSelected(flight)
            },
            onFavouriteButtonPressed: { [weak self] in
                self?.output?.favouritePressed(flight)
            },
            onMoreButtonPressed: { [weak self] in
                self?.output?.morePressed(flight)
            },
            areButtonsHidden: false
        ))

        return cell
    }

}

// MARK: - UITableViewDelegate

extension FlightPickViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - Appearance

private extension FlightPickViewController {

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
                nibName: FlightCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: FlightCell.cellId
        )
        tableView.register(
            UINib(
                nibName: TitleCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: TitleCell.cellId
        )
    }

}
