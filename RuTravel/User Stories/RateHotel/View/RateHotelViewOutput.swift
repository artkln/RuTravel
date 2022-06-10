//
//  RateHotelViewOutput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol RateHotelViewOutput {

    func loadData()
    func ratePressed(rating: Int)
    func backPressed()
    func incorrectRating()

}
