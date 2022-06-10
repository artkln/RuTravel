//
//  FavouriteFlightsViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class FavouriteFlightsViewController: UIViewController, FavouriteFlightsViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let tableViewRowHeight: CGFloat = 60
        static let titleFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 28)
        static let blockerLabelText: String = "Добавьте перелёт в избранное, чтобы он отобразился здесь."
        static let title: String = "Перелёты"
    }

    // MARK: - Private Properties

    @IBOutlet private weak var blockerLabel: UILabel!
    @IBOutlet private weak var blockerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    private var model: FavouriteFlightsModel?

    // MARK: - Properties

    var output: FavouriteFlightsViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        hideMainInterface(true)
        hideBlockerInterface(true)
        output?.loadData()
    }

    // MARK: - FavouriteFlightsViewInput

    func configure(with model: FavouriteFlightsModel) {
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

// MARK: - Appearance

private extension FavouriteFlightsViewController {

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
                nibName: FlightCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: FlightCell.cellId
        )
    }

}

// MARK: - UITableViewDataSource

extension FavouriteFlightsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = model else {
            return 0
        }

        return model.flightsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let model = model,
            let cell = tableView.dequeueReusableCell (
            withIdentifier: FlightCell.cellId,
            for: indexPath
        ) as? FlightCell else {
            return UITableViewCell()
        }

        let flight = model.flightsList[indexPath.row]

        cell.configure(with: FlightCellModel(
            flight: flight,
            onSelectButtonPressed: nil,
            onFavouriteButtonPressed: nil,
            onMoreButtonPressed: { [weak self] in
                self?.output?.morePressed(flight)
            },
            areButtonsHidden: true
        ))

        return cell
    }

}

// MARK: - UITableViewDelegate

extension FavouriteFlightsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
