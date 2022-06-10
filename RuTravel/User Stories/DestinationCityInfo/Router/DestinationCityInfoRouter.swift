//
//  DestinationCityInfoRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class DestinationCityInfoRouter: DestinationCityInfoRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - DestinationCityInfoRouterInput

    func pushHotelPickModule() {
        let resultVC = HotelPickModuleConfigurator.configure()
        view?.push(module: resultVC, animated: true)
    }

}
