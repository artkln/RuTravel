//
//  SupportModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SupportModuleConfigurator {

    // MARK: - Internal methods

    static func configure() -> SupportViewController {
        guard let view = UIStoryboard(name: String(describing: SupportViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? SupportViewController else {
            fatalError("Can't load SupportViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = SupportPresenter()
        let router = SupportRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
