//
//  DepartureCityPickViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class DepartureCityPickViewController: UIViewController, DepartureCityPickViewInput, ModuleTransitionable {

    // MARK: - Nested types

    private enum Constants {
        static let cellTextFont: UIFont = FontFamily.SFProDisplay.regular.font(size: 20)
        static let title: String = "Выбор города"
    }

    // MARK: - Private Properties

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private var model: DepartureCitiesModel?
    private var filteredCities = [City]()

    // MARK: - Properties

    var output: DepartureCityPickViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.loadData()
    }

    // MARK: - DepartureCityPickViewInput

    func configure(with model: DepartureCitiesModel) {
        self.model = model
        configureAppearance()

        title = Constants.title
        filteredCities = model.departureCities
        tableView.reloadData()
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

private extension DepartureCityPickViewController {

    func configureAppearance() {
        hideKeyboardWhenTappedAround()

        configureTableView()
        configureSearchBar()
    }

    func configureSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = model?.searchBarPlaceholder
        searchBar.isTranslucent = false
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

}

extension DepartureCityPickViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityCell.cellId,
            for: indexPath
        ) as? CityCell else {
            return UITableViewCell()
        }

        let city = filteredCities[indexPath.row]

        guard let backgroundPicture = city.pictures.first else {
            return UITableViewCell()
        }

        cell.configure(with: CityCellModel(text: city.requestInfo.name, image: backgroundPicture))

        return cell
    }

}

extension DepartureCityPickViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.citySelected(filteredCities[indexPath.row])
    }

}

extension DepartureCityPickViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view?.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard let departureCities = model?.departureCities else {
            return
        }

        filteredCities = textSearched.isEmpty ?
            departureCities :
            departureCities.filter({(city: City) -> Bool in
                return city.requestInfo.name.range(of: textSearched, options: .caseInsensitive) != nil
            })

        tableView.reloadData()
    }

}
