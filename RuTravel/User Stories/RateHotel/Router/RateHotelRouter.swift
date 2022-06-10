//
//  RateHotelRouter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class RateHotelRouter: RateHotelRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - RateHotelRouterInput

    func dismissModule() {
        view?.dismissView(animated: true, completion: nil)
    }

}
