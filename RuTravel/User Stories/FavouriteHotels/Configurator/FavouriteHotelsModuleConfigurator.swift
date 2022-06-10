//
//  FavouriteHotelsModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum FavouriteHotelsModuleConfigurator {

    // MARK: - Internal methods

    static func configure() -> FavouriteHotelsViewController {
        guard let view = UIStoryboard(name: String(describing: FavouriteHotelsViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? FavouriteHotelsViewController else {
            fatalError("Can't load FavouriteHotelsViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = FavouriteHotelsPresenter()
        let router = FavouriteHotelsRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
