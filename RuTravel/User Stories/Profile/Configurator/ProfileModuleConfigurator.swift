//
//  ProfileModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ProfileModuleConfigurator: ConfigurableFromTabBar {

    // MARK: - Internal methods

    static func configure() -> UIViewController {
        guard let view = UIStoryboard(name: String(describing: ProfileViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? ProfileViewController else {
            fatalError("Can't load ProfileViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = ProfilePresenter()
        let router = ProfileRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
