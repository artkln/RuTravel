//
//  HotelPickRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 10/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HotelPickRouter: HotelPickRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - HotelPickRouterInput

    func pushFlightPickModule() {
        let resultVC = FlightPickModuleConfigurator.configure(isInSearchModule: true)
        view?.push(module: resultVC, animated: true)
    }

    func presentRateHotelModule(with hotel: Hotel) {
        let resultVC = RateHotelModuleConfigurator.configure(with: hotel)
        view?.presentModule(resultVC, animated: true, completion: nil)
    }

}
