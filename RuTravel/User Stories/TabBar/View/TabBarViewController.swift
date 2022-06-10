//
//  TabBarViewController.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController, ModuleTransitionable, TabBarViewInput {

    // MARK: - Properties

    var output: TabBarViewOutput?

    // MARK: - UIViewController

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.tabBarWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output?.tabBarWillDisappear()
    }

    // MARK: - TabBarViewInput

    func configureControllers(_ controllers: [UIViewController]) {
        viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
    }

}
