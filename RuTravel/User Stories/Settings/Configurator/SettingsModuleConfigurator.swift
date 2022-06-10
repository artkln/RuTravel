//
//  SettingsModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 14/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SettingsModuleConfigurator {

    // MARK: - Internal methods

    static func configure() -> SettingsViewController {
        guard let view = UIStoryboard(name: String(describing: SettingsViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? SettingsViewController else {
            fatalError("Can't load SettingsViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = SettingsPresenter()
        let router = SettingsRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
