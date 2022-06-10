//
//  AuthModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 13/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum AuthModuleConfigurator {

    // MARK: - Internal methods

    static func configure() -> AuthViewController {
        guard let view = UIStoryboard(name: String(describing: AuthViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? AuthViewController else {
            fatalError("Can't load AuthViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = AuthPresenter()
        let router = AuthRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
