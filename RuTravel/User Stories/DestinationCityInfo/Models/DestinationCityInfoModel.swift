//
//  DestinationCityInfoModel.swift
//  RuTravel
//
//  Created by kalinin on 05.05.2022.
//

import Foundation
import UIKit

struct DestinationCityInfoModel {

    let confirmButtonTitle: String = {
        return "Выбрать город"
    }()

    let backButtonTitle: String = {
       return "Город"
    }()

    let buttonStyle = RuTravelButton.Style.blue

    let destinationCity: City?

}

enum DestinationCityMainSectionRows: Int {

    case title
    case confirm
    case description
    case carousel
    case subDescription

    var cellIdentifier: String {
        switch self {
        case .title:
            return TitleCell.cellId
        case .confirm:
            return ConfirmCell.cellId
        case .description:
            return PlainLabelCell.cellId
        case .carousel:
            return CarouselTableCell.cellId
        case .subDescription:
            return SubDescriptionCell.cellId
        }
    }

}

enum DestinationCityOtherSections: Int {

    case whatToSee
    case whereToStay
    case whatToTry
    case whatToBuy
    case serviceInfo

    var header: String {
        switch self {
        case .whatToSee:
            return "Что посмотреть"
        case .whereToStay:
            return "Где остановиться"
        case .whatToTry:
            return "Что попробовать"
        case .whatToBuy:
            return "Что привезти"
        case .serviceInfo:
            return "Цены"
        }
    }

    var cellIdentifier: String {
        switch self {
        case .whatToSee:
            return BulletedLabelCell.cellId
        case .whereToStay:
            return PlainLabelCell.cellId
        case .whatToTry:
            return PlainLabelCell.cellId
        case .whatToBuy:
            return BulletedLabelCell.cellId
        case .serviceInfo:
            return ServiceCell.cellId
        }
    }

}
