//
//  ResultModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ResultModuleConfigurator {

    // MARK: - Internal methods

    static func configure() -> ResultViewController {
        guard let view = UIStoryboard(name: String(describing: ResultViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? ResultViewController else {
            fatalError("Can't load ResultViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = ResultPresenter()
        let router = ResultRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
