//
//  TabBarRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class TabBarRouter: TabBarRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - TabBarRouterInput

    func presentAuthModule() {
        let resultVC = AuthModuleConfigurator.configure()
        resultVC.modalPresentationStyle = .fullScreen
        view?.presentModule(resultVC, animated: true, completion: nil)
    }

}
