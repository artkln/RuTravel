//
//  SettingsViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 14/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController, SettingsViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let tableViewRowHeight: CGFloat = 60
        static let rowsInSectionNumber: Int = 4
        static let changeCityRow: Int = 3
        static let title: String = "Настройки"
    }

    // MARK: - Private Properties

    @IBOutlet private weak var tableView: UITableView!
    private var model: SettingsModel?

    // MARK: - Properties

    var output: SettingsViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.loadData()
    }

    // MARK: - SettingsViewInput

    func configure(with model: SettingsModel) {
        self.model = model
        tableView.reloadData()
        title = Constants.title
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

extension SettingsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.rowsInSectionNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let model = model,
            let row = SettingsRows(rawValue: indexPath.row) else {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: row.cellIdentifier,
            for: indexPath
        ) as? InfoCell else {
            return UITableViewCell()
        }

        switch row {
        case .name:
            cell.configure(with: InfoChangeableCellModel(
                text: model.nameRowText,
                onChangeButtonPressed: { [weak self] in
                    UIView.performWithoutAnimation {
                        self?.tableView.performBatchUpdates({})
                    }
                },
                onConfirmButtonPressed: { [weak self] newName in
                    UIView.performWithoutAnimation {
                        self?.tableView.performBatchUpdates({})
                    }
                    self?.output?.updateAuthName(newName)
                },
                onTextFieldReturn: { [weak self] in
                    self?.view.endEditing(true)
                }
            ))
        case .email:
            cell.configure(with: InfoChangeableCellModel(
                text: model.emailRowText,
                onChangeButtonPressed: { [weak self] in
                    UIView.performWithoutAnimation {
                        self?.tableView.performBatchUpdates({})
                    }
                },
                onConfirmButtonPressed: { [weak self] newEmail in
                    UIView.performWithoutAnimation {
                        self?.tableView.performBatchUpdates({})
                    }
                    self?.output?.updateAuthEmail(newEmail)
                },
                onTextFieldReturn: { [weak self] in
                    self?.view.endEditing(true)
                }
            ))
        case .password:
            cell.configure(with: PlainLabelCellModel(
                text: model.passwordRowText,
                isAccessoryButtonNeeded: false
            ))
        case .departureCity:
            cell.configure(with: PlainLabelCellModel(
                text: model.departureCityRowText,
                isAccessoryButtonNeeded: true
            ))
        }

        return cell as? UITableViewCell ?? UITableViewCell()
    }

}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == Constants.changeCityRow {
            output?.changeCityRowSelected()
        }
    }

}

// MARK: - Appearance

private extension SettingsViewController {

    func configureAppearance() {
        hideKeyboardWhenTappedAround()
        configureTableView()
    }

    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.tableViewRowHeight
        tableView.separatorInset = .zero
        tableView.register(
            UINib(
                nibName: PlainLabelCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: PlainLabelCell.cellId
        )
        tableView.register(
            UINib(
                nibName: InfoChangeableCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: InfoChangeableCell.cellId
        )
    }

}
