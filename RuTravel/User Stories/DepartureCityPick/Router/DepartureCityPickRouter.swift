//
//  DepartureCityPickRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class DepartureCityPickRouter: DepartureCityPickRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

    // MARK: - DepartureCityPickRouterInput

    func popModule() {
        view?.pop(animated: true)
    }

}
