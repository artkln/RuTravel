//
//  AuthRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 13/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class AuthRouter: AuthRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - AuthRouterInput

    func dismissModule() {
        view?.dismissView(animated: true, completion: nil)
    }

}
