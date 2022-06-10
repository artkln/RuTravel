//
//  JourneyInfoRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class JourneyInfoRouter: JourneyInfoRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - JourneyInfoRouterInput

    func pushResultModule() {
        let resultVC = ResultModuleConfigurator.configure()
        view?.push(module: resultVC, animated: true)
    }

}
