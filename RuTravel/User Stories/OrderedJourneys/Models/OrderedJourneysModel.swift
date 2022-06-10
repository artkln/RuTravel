//
//  OrderedJourneysModel.swift
//  RuTravel
//
//  Created by kalinin on 22.05.2022.
//

import Foundation

struct OrderedJourneysModel {

    let journeysList: [Journey]

}

enum OrderedJourneysSectionRows: Int {

    case dates
    case hotel
    case flight

    var header: String {
        switch self {
        case .dates:
            return "Даты поездки"
        case .hotel:
            return "Отель"
        case .flight:
            return "Перелёт"
        }
    }

    var cellIdentifier: String {
        switch self {
        case .dates:
            return PlainLabelCell.cellId
        case .hotel:
            return HotelCell.cellId
        case .flight:
            return FlightCell.cellId
        }
    }

}
