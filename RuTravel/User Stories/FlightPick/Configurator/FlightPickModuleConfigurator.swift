//
//  FlightPickModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 11/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum FlightPickModuleConfigurator {

    // MARK: - Internal methods

    static func configure(isInSearchModule: Bool) -> FlightPickViewController {
        guard let view = UIStoryboard(name: String(describing: FlightPickViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? FlightPickViewController else {
            fatalError("Can't load FlightPickViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = FlightPickPresenter(isInSearchModule)
        let router = FlightPickRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
