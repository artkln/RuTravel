//
//  RecommendationsRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class RecommendationsRouter: RecommendationsRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - RecommendationsRouterInput

    func pushFlightPickModule() {
        let resultVC = FlightPickModuleConfigurator.configure(isInSearchModule: false)
        view?.push(module: resultVC, animated: true)
    }

    func presentRateHotelModule(with hotel: Hotel) {
        let resultVC = RateHotelModuleConfigurator.configure(with: hotel)
        view?.presentModule(resultVC, animated: true, completion: nil)
    }

}
