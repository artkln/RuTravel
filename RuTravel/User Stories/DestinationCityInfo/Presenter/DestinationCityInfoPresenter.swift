//
//  DestinationCityInfoPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class DestinationCityInfoPresenter: DestinationCityInfoViewOutput, DestinationCityInfoModuleInput {

    // MARK: - Nested Types

    private enum Constants {
        static let alertTitle: String = "Ошибка"
        static let alertErrorMessage: String = "Не удалось получить информацию о выбранном городе."
    }

    // MARK: - Properties

    weak var view: DestinationCityInfoViewInput?
    var router: DestinationCityInfoRouterInput?
    var output: DestinationCityInfoModuleOutput?

    // MARK: - Private Properties

    private let firestoreService = FirestoreService.shared
    private let imageService = ImageService.shared
    private let destinationCity: City

    // MARK: - Initialization

    init(city: City) {
        destinationCity = city
    }

    // MARK: - DestinationCityInfoViewOutput

    func loadData() {
        view?.startActivity { [weak self] in
            self?.view?.configure(with: DestinationCityInfoModel(
                destinationCity: self?.destinationCity
            ))
            self?.view?.stopActivity {}
        }
    }

    func confirmPressed() {
        router?.pushHotelPickModule()
    }

}
