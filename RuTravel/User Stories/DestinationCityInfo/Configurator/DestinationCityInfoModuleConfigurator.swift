//
//  DestinationCityInfoModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum DestinationCityInfoModuleConfigurator {

    // MARK: - Internal methods

    static func configure(with city: City) -> DestinationCityInfoViewController {
        guard let view = UIStoryboard(name: String(describing: DestinationCityInfoViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? DestinationCityInfoViewController else {
            fatalError("Can't load DestinationCityInfoViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = DestinationCityInfoPresenter(city: city)
        let router = DestinationCityInfoRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
