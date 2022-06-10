//
//  FavouriteHotelsViewOutput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol FavouriteHotelsViewOutput {

    func loadData()
    func needRateHotel(_ hotel: Hotel)
    func morePressed(_ hotel: Hotel)

}
