//
//  FlightPickViewOutput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 11/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol FlightPickViewOutput {

    func loadData()
    func flightSelected(_ flight: Flight)
    func favouritePressed(_ flight: Flight)
    func morePressed(_ flight: Flight)

}
