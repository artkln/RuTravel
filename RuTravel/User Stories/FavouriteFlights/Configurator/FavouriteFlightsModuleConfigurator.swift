//
//  FavouriteFlightsModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum FavouriteFlightsModuleConfigurator {

    // MARK: - Internal methods

    static func configure(output: FavouriteFlightsModuleOutput? = nil) -> FavouriteFlightsViewController {
        guard let view = UIStoryboard(name: String(describing: FavouriteFlightsViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? FavouriteFlightsViewController else {
            fatalError("Can't load FavouriteFlightsViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = FavouriteFlightsPresenter()
        let router = FavouriteFlightsRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
