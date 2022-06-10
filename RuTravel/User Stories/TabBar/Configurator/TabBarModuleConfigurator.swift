//
//  TabBarModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum TabBarModuleConfigurator {

    // MARK: - Internal methods

    static func configure() -> UIViewController {
        let view = TabBarViewController()
        let presenter = TabBarPresenter()
        let router = TabBarRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
