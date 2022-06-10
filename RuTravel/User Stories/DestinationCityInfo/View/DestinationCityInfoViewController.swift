//
//  DestinationCityInfoViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class DestinationCityInfoViewController: UIViewController, DestinationCityInfoViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let tableViewRowHeight: CGFloat = 200
        static let tableViewHeaderHeight: CGFloat = 20
        static let sectionsNumber: Int = 6
        static let rowsInMainSectionNumber: Int = 5
        static let rowsInOtherSectionsNumber: Int = 1
    }

    // MARK: - Private Properties

    @IBOutlet private weak var tableView: UITableView!

    private var model: DestinationCityInfoModel?

    // MARK: - Properties

    var output: DestinationCityInfoViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.loadData()
    }

    // MARK: - DestinationCityInfoViewInput

    func configure(with model: DestinationCityInfoModel) {
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

extension DestinationCityInfoViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sectionsNumber
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else {
            return Constants.rowsInOtherSectionsNumber
        }

        return Constants.rowsInMainSectionNumber
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else {
            return UITableViewCell()
        }

        guard indexPath.section > 0 else {
            return mainSectionCell(in: tableView, indexPath: indexPath, model: model)
        }

        return otherSectionsCell(in: tableView, indexPath: indexPath, model: model)
    }

    func mainSectionCell(in tableView: UITableView,
                            indexPath: IndexPath,
                            model: DestinationCityInfoModel) -> UITableViewCell {
        guard
            let destinationCity = model.destinationCity,
            let row = DestinationCityMainSectionRows(rawValue: indexPath.row) else {
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
            cell.configure(with: TitleCellModel(text: destinationCity.requestInfo.name))
        case .confirm:
            cell.configure(with: ConfirmCellModel(
                buttonTitle: model.confirmButtonTitle,
                buttonStyle: model.buttonStyle,
                onButtonPressed: { [weak self] in
                    self?.output?.confirmPressed()
                }
            ))
        case .description:
            cell.configure(with: PlainLabelCellModel(
                text: destinationCity.description ?? String(),
                isAccessoryButtonNeeded: false
            ))
        case .carousel:
            cell.configure(with: CarouselTableCellModel(pictures: destinationCity.pictures))
        case .subDescription:
            cell.configure(with: SubDescriptionCellModel(text: destinationCity.subDescription ?? String()))
        }

        return cell as? UITableViewCell ?? UITableViewCell()
    }

    func otherSectionsCell(in tableView: UITableView,
                           indexPath: IndexPath,
                           model: DestinationCityInfoModel) -> UITableViewCell {
        guard
            let destinationCity = model.destinationCity,
            let whatToSee = destinationCity.whatToSee,
            let whereToStay = destinationCity.whereToStay,
            let whatToTry = destinationCity.whatToTry,
            let whatToBuy = destinationCity.whatToBuy,
            let serviceInfo = destinationCity.serviceInfo,
            let section = DestinationCityOtherSections(rawValue: indexPath.section - 1) else {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: section.cellIdentifier,
            for: indexPath
        ) as? InfoCell else {
            return UITableViewCell()
        }

        switch section {
        case .whatToSee:
            cell.configure(with: BulletedLabelCellModel(text: whatToSee))
        case .whereToStay:
            cell.configure(with: PlainLabelCellModel(
                text: whereToStay,
                isAccessoryButtonNeeded: false
            ))
        case .whatToTry:
            cell.configure(with: PlainLabelCellModel(
                text: whatToTry,
                isAccessoryButtonNeeded: false
            ))
        case .whatToBuy:
            cell.configure(with: BulletedLabelCellModel(text: whatToBuy))
        case .serviceInfo:
            cell.configure(with: ServiceCellModel(serviceInfo: serviceInfo))
        }

        return cell as? UITableViewCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = DestinationCityOtherSections(rawValue: section - 1) else {
            return nil
        }

        return section.header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.tableViewHeaderHeight
    }

}

// MARK: - UITableViewDelegate

extension DestinationCityInfoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - Appearance

private extension DestinationCityInfoViewController {

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
                nibName: BulletedLabelCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: BulletedLabelCell.cellId
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
        tableView.register(
            UINib(
                nibName: CarouselTableCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: CarouselTableCell.cellId
        )
        tableView.register(
            UINib(
                nibName: SubDescriptionCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: SubDescriptionCell.cellId
        )
        tableView.register(
            UINib(
                nibName: ServiceCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: ServiceCell.cellId
        )
    }

}
