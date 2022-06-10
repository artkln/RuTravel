//
//  JourneyInfoViewOutput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol JourneyInfoViewOutput {

    func loadData()
    func confirmPressed()
    func morePressed(_ hotel: Hotel)
    func morePressed(_ flight: Flight)

}
