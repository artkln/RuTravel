//
//  OrderedJourneysModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum OrderedJourneysModuleConfigurator {

    // MARK: - Internal methods

    static func configure() -> OrderedJourneysViewController {
        guard let view = UIStoryboard(name: String(describing: OrderedJourneysViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? OrderedJourneysViewController else {
            fatalError("Can't load OrderedJourneysViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = OrderedJourneysPresenter()
        let router = OrderedJourneysRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
