//
//  ProfileRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ProfileRouter: ProfileRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - ProfileRouterInput

    func pushSettingsModule() {
        let resultVC = SettingsModuleConfigurator.configure()
        view?.push(module: resultVC, animated: true, hideTabBar: true)
    }

    func pushFavouriteHotelsModule() {
        let resultVC = FavouriteHotelsModuleConfigurator.configure()
        view?.push(module: resultVC, animated: true, hideTabBar: true)
    }

    func pushFavouriteFlightsModule() {
        let resultVC = FavouriteFlightsModuleConfigurator.configure()
        view?.push(module: resultVC, animated: true, hideTabBar: true)
    }

    func pushOrderedJourneysModule() {
        let resultVC = OrderedJourneysModuleConfigurator.configure()
        view?.push(module: resultVC, animated: true, hideTabBar: true)
    }

    func pushSupportModule() {
        let resultVC = SupportModuleConfigurator.configure()
        view?.push(module: resultVC, animated: true, hideTabBar: true)
    }

}
