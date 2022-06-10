//
//  DestinationCityPickViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class DestinationCityPickViewController: UIViewController, DestinationCityPickViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let titleFont: UIFont = FontFamily.SFProDisplay.bold.font(size: 28)
        static let cellTextFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 20)
        static let tableViewHeaderHeight: CGFloat = 30
        static let blockerLabelText: String = "Чтобы найти путешествие, сначала выберите ваш город в настройках профиля."
    }

    // MARK: - Private Properties

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var blockerView: UIView!
    @IBOutlet private weak var blockerLabel: UILabel!

    private var model: DestinationCitiesModel?
    private var filteredCities = [[City]]()

    // MARK: - Properties

    var output: DestinationCityPickViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        hideMainInterface(true)
        hideBlockerInterface(true)
        output?.loadData()
    }

    // MARK: - DestinationCityPickViewInput

    func configure(with model: DestinationCitiesModel) {
        self.model = model
        self.filteredCities = model.destinationCities
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

extension DestinationCityPickViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredCities.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityCell.cellId,
            for: indexPath
        ) as? CityCell else {
            return UITableViewCell()
        }

        let city = filteredCities[indexPath.section][indexPath.row]

        guard let backgroundPicture = city.pictures.first else {
            return UITableViewCell()
        }

        cell.configure(with: CityCellModel(text: city.requestInfo.name, image: backgroundPicture))

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let model = model,
              !filteredCities[section].isEmpty else {
            return nil
        }

        if section == 0 {
            return model.titleForFirstHeader
        } else {
            return model.titleForSecondHeader
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.tableViewHeaderHeight
    }

}

extension DestinationCityPickViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.citySelected(filteredCities[indexPath.section][indexPath.row])
    }

}

extension DestinationCityPickViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view?.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard
            let resortCities = model?.destinationCities.first,
            let popularCities = model?.destinationCities.last else {
            return
        }

        let filteredResortCities = textSearched.isEmpty ?
            resortCities :
            resortCities.filter({(city: City) -> Bool in
                return city.requestInfo.name.range(of: textSearched, options: .caseInsensitive) != nil
            })

        let filteredPopularCities = textSearched.isEmpty ?
            popularCities :
            popularCities.filter({(city: City) -> Bool in
                return city.requestInfo.name.range(of: textSearched, options: .caseInsensitive) != nil
            })

        filteredCities = [filteredResortCities, filteredPopularCities]

        tableView.reloadData()
    }

}

// MARK: - Appearance

private extension DestinationCityPickViewController {

    func configureAppearance() {
        hideKeyboardWhenTappedAround()

        configureTitleLabel()
        configureTableView()
        configureSearchBar()

        hideMainInterface(false)
        hideBlockerInterface(true)
    }

    func hideMainInterface(_ hide: Bool) {
        titleLabel.isHidden = hide
        tableView.isHidden = hide
        searchBar.isHidden = hide
    }

    func hideBlockerInterface(_ hide: Bool) {
        blockerView.isHidden = hide
    }

    func configureTitleLabel() {
        titleLabel.text = model?.title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = Constants.titleFont
    }

    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.register(
            UINib(
                nibName: CityCell.cellId,
                bundle: nil
            ),
            forCellReuseIdentifier: CityCell.cellId
        )
    }

    func configureSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = model?.searchBarPlaceholder
        searchBar.isTranslucent = false
    }

    func configureBlockerAppearance() {
        view.bringSubviewToFront(blockerView)
        hideBlockerInterface(false)

        blockerLabel.numberOfLines = 0
        blockerLabel.textAlignment = .center
        blockerLabel.font = Constants.titleFont
        blockerLabel.text = Constants.blockerLabelText
    }

}
