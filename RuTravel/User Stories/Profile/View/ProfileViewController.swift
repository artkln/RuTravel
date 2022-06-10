//
//  ProfileViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController, ProfileViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let sectionsNumber: Int = 2
        static let rowsInMainSectionNumber: Int = 1
        static let rowsInOptionsSectionNumber: Int = 6
        static let textFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 19)
        static let tableViewRowHeight: CGFloat = 50
    }

    // MARK: - Private Properties

    @IBOutlet private weak var tableView: UITableView!

    private var model: ProfileModel?

    // MARK: - Properties

    var output: ProfileViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.loadData()
    }

    // MARK: - ProfileViewInput

    func configure(with model: ProfileModel) {
        self.model = model
        tableView.reloadData()
        navigationItem.backButtonTitle = model.backButtonTitle
    }

    func showPrompt(title: String, message: String) {
        showAlert(title: title, message: message)
    }

}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sectionsNumber
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section > 0 else {
            return Constants.rowsInMainSectionNumber
        }
        return Constants.rowsInOptionsSectionNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else {
            return UITableViewCell()
        }

        guard indexPath.section > 0 else {
            return mainSectionCell(in: tableView, indexPath: indexPath, model: model)
        }

        return optionsSectionCell(in: tableView, indexPath: indexPath, model: model)
    }

    func mainSectionCell(in tableView: UITableView,
                            indexPath: IndexPath,
                            model: ProfileModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TitleCell.cellId,
            for: indexPath
        ) as? TitleCell else {
            return UITableViewCell()
        }

        cell.configure(with: TitleCellModel(text: model.title))

        return cell
    }

    func optionsSectionCell(in tableView: UITableView,
                            indexPath: IndexPath,
                            model: ProfileModel) -> UITableViewCell {
        guard let row = ProfileOptionsSectionRows(rawValue: indexPath.row) else {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: row.cellIdentifier,
            for: indexPath
        ) as? InfoCell else {
            return UITableViewCell()
        }

        switch row {
        case .exit:
            cell.configure(with: ConfirmCellModel(
                buttonTitle: row.text,
                buttonStyle: model.buttonStyle,
                onButtonPressed: { [weak self] in
                    self?.output?.exitPressed()
                }
            ))
        default:
            cell.configure(with: PlainLabelCellModel(
                text: row.text,
                isAccessoryButtonNeeded: true
            ))
        }

        return cell as? UITableViewCell ?? UITableViewCell()
    }

}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let row = ProfileOptionsSectionRows(rawValue: indexPath.row) else {
            return
        }

        switch row {
        case .settings:
            output?.settingsSelected()
        case .favouriteHotels:
            output?.favouriteHotelsSelected()
        case .favouriteFlights:
            output?.favouriteFlightsSelected()
        case .ordered:
            output?.orderedSelected()
        case .support:
            output?.supportSelected()
        case .exit:
            break
        }
    }

}

// MARK: - Appearance

private extension ProfileViewController {

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
                nibName: ConfirmCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: ConfirmCell.cellId
        )
    }

}
