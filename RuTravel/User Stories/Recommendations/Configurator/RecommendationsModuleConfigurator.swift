//
//  RecommendationsModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum RecommendationsModuleConfigurator: ConfigurableFromTabBar {

    // MARK: - Internal methods

    static func configure() -> UIViewController {
        guard let view = UIStoryboard(name: String(describing: RecommendationsViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? RecommendationsViewController else {
            fatalError("Can't load RecommendationsViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = RecommendationsPresenter()
        let router = RecommendationsRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
