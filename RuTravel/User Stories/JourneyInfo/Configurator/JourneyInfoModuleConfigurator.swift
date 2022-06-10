//
//  JourneyInfoModuleConfigurator.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum JourneyInfoModuleConfigurator {

    // MARK: - Internal methods

    static func configure(isInSearchModule: Bool) -> JourneyInfoViewController {
        guard let view = UIStoryboard(name: String(describing: JourneyInfoViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? JourneyInfoViewController else {
            fatalError("Can't load JourneyInfoViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = JourneyInfoPresenter(isInSearchModule)
        let router = JourneyInfoRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
