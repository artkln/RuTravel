//
//  HotelPickViewOutput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 10/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol HotelPickViewOutput {

    func loadData()
    func dateConfirmed(startDate: String, endDate: String)
    func hotelSelected(_ hotel: Hotel)
    func needRateHotel(_ hotel: Hotel)
    func favouritePressed(_ hotel: Hotel)
    func morePressed(_ hotel: Hotel)

}
