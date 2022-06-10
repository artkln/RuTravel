//
//  FlightPickModel.swift
//  RuTravel
//
//  Created by kalinin on 11.05.2022.
//

import Foundation

struct FlightPickModel {

    let title: String = {
        return "Выберите перелёт:"
    }()

    let backButtonTitle: String = {
       return "Выбор перелёта"
    }()

    let flightList: [Flight]

}
