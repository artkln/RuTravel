//
//  ResultRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ResultRouter: ResultRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - ResultRouterInput

    func popToRoot() {
        view?.popToRoot(animated: true)
    }

}
