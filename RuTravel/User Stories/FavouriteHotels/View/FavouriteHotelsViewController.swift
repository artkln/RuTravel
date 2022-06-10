//
//  FavouriteHotelsViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class FavouriteHotelsViewController: UIViewController, FavouriteHotelsViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let tableViewRowHeight: CGFloat = 60
        static let titleFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 28)
        static let blockerLabelText: String = "Добавьте отель в избранное, чтобы он отобразился здесь."
        static let title: String = "Отели"
    }

    // MARK: - Private Properties

    @IBOutlet private weak var blockerLabel: UILabel!
    @IBOutlet private weak var blockerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    private var model: FavouriteHotelsModel?

    // MARK: - Properties

    var output: FavouriteHotelsViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        hideMainInterface(true)
        hideBlockerInterface(true)
        output?.loadData()
    }

    // MARK: - FavouriteHotelsViewInput

    func configure(with model: FavouriteHotelsModel) {
        self.model = model
        configureAppearance()
        tableView.reloadData()
        title = Constants.title
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

private extension FavouriteHotelsViewController {

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
                nibName: HotelCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: HotelCell.cellId
        )
    }

}

// MARK: - UITableViewDataSource

extension FavouriteHotelsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = model else {
            return 0
        }

        return model.hotelList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let model = model,
            let cell = tableView.dequeueReusableCell (
            withIdentifier: HotelCell.cellId,
            for: indexPath
        ) as? HotelCell else {
            return UITableViewCell()
        }

        let hotel = model.hotelList[indexPath.row]

        cell.configure(with: HotelCellModel(
            hotel: hotel,
            onSelectButtonPressed: nil,
            onRateButtonPressed: { [weak self] in
                self?.output?.needRateHotel(hotel)
            },
            onFavouriteButtonPressed: nil,
            onMoreButtonPressed: { [weak self] in
                self?.output?.morePressed(hotel)
            },
            needOnlyRateButton: true,
            areButtonsHidden: false
        ))

        return cell
    }

}

// MARK: - UITableViewDelegate

extension FavouriteHotelsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
