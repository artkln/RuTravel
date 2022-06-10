//
//  DestinationCityPickModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum DestinationCityPickModuleConfigurator: ConfigurableFromTabBar {

    // MARK: - Internal methods

    static func configure() -> UIViewController {
        guard let view = UIStoryboard(name: String(describing: DestinationCityPickViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? DestinationCityPickViewController else {
            fatalError("Can't load DestinationCityViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = DestinationCityPickPresenter()
        let router = DestinationCityPickRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
