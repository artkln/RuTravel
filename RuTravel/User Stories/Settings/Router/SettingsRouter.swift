//
//  SettingsRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 14/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SettingsRouter: SettingsRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - SettingsRouterInput

    func pushDepartureCityPickModule() {
        let resultVC = DepartureCityPickModuleConfigurator.configure()
        view?.push(module: resultVC, animated: true, hideTabBar: true)
    }

}
