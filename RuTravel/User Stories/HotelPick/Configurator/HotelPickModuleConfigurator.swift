//
//  HotelPickModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 10/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum HotelPickModuleConfigurator {

    // MARK: - Internal methods

    static func configure() -> HotelPickViewController {
        guard let view = UIStoryboard(name: String(describing: HotelPickViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? HotelPickViewController else {
            fatalError("Can't load HotelPickViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = HotelPickPresenter()
        let router = HotelPickRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
