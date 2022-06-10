//
//  RateHotelModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum RateHotelModuleConfigurator {

    // MARK: - Internal methods

    static func configure(with hotel: Hotel) -> RateHotelViewController {
        guard let view = UIStoryboard(name: String(describing: RateHotelViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? RateHotelViewController else {
            fatalError("Can't load RateHotelViewController from storyboard, check that controller is initial view controller")
        }
        let router = RateHotelRouter()
        let presenter = RateHotelPresenter(hotel: hotel)

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
