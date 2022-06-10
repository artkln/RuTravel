//
//  ProfileViewOutput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol ProfileViewOutput {

    func loadData()
    func exitPressed()

    func settingsSelected()
    func favouriteHotelsSelected()
    func favouriteFlightsSelected()
    func orderedSelected()
    func supportSelected()

}
