//
//  FlightPickRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 11/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class FlightPickRouter: FlightPickRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - FlightPickRouterInput

    func pushJourneyInfoModule(_ isInSearchModule: Bool) {
        let resultVC = JourneyInfoModuleConfigurator.configure(isInSearchModule: isInSearchModule)
        view?.push(module: resultVC, animated: true)
    }

}
