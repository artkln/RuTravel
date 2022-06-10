//
//  DestinationCityPickRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class DestinationCityPickRouter: DestinationCityPickRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - DestinationCityPickRouterInput

    func pushDestinationCityInfoModule(with city: City) {
        let resultVC = DestinationCityInfoModuleConfigurator.configure(with: city)
        view?.push(module: resultVC, animated: true)
    }

}
