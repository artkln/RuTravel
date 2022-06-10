//
//  DepartureCityPickModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum DepartureCityPickModuleConfigurator {

    // MARK: - Internal methods

    static func configure() -> DepartureCityPickViewController {
        guard let view = UIStoryboard(name: String(describing: DepartureCityPickViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? DepartureCityPickViewController else {
            fatalError("Can't load SearchViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = DepartureCityPickPresenter()
        let router = DepartureCityPickRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
