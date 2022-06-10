//
//  RecommendationsRouterInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol RecommendationsRouterInput {

    func pushFlightPickModule()
    func presentRateHotelModule(with hotel: Hotel)

}
