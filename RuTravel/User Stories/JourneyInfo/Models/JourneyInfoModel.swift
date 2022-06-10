//
//  JourneyInfoModel.swift
//  RuTravel
//
//  Created by kalinin on 12.05.2022.
//

import Foundation

struct JourneyInfoModel {

    let title: String = {
        return "Проверьте информацию о своём путешествии:"
    }()

    let backButtonTitle: String = {
       return "Путешествие"
    }()

    let confirmButtonTitle: String = {
       return "Подтвердить"
    }()

    let journey: Journey
    let buttonStyle = RuTravelButton.Style.blue

    init(journey: Journey) {
        self.journey = journey
    }

}

enum JourneyInfoSections: Int {

    case title
    case dates
    case hotel
    case flight
    case confirm

    var header: String {
        switch self {
        case .title:
            return String()
        case .dates:
            return "Даты поездки"
        case .hotel:
            return "Отель"
        case .flight:
            return "Перелёт"
        case .confirm:
            return String()
        }
    }

    var cellIdentifier: String {
        switch self {
        case .title:
            return TitleCell.cellId
        case .dates:
            return PlainLabelCell.cellId
        case .hotel:
            return HotelCell.cellId
        case .flight:
            return FlightCell.cellId
        case .confirm:
            return ConfirmCell.cellId
        }
    }

}
