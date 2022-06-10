//
//  HotelPickRouterInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 10/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol HotelPickRouterInput {

    func pushFlightPickModule()
    func presentRateHotelModule(with hotel: Hotel)

}
