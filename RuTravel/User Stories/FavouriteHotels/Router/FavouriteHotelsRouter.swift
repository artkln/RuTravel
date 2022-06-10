//
//  FavouriteHotelsRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class FavouriteHotelsRouter: FavouriteHotelsRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - FavouriteHotelsRouterInput

    func presentRateHotelModule(with hotel: Hotel) {
        let resultVC = RateHotelModuleConfigurator.configure(with: hotel)
        view?.presentModule(resultVC, animated: true, completion: nil)
    }

}
