//
//  ProfileModel.swift
//  RuTravel
//
//  Created by kalinin on 13.05.2022.
//

import Foundation

struct ProfileModel {

    let title: String

    let backButtonTitle: String = {
       return "Профиль"
    }()

    let buttonStyle: RuTravelButton.Style

    init(userName: String) {
        title = "Добро пожаловать,\n\(userName)"
        buttonStyle = .exit
    }

}

enum ProfileOptionsSectionRows: Int {

    case settings
    case favouriteHotels
    case favouriteFlights
    case ordered
    case support
    case exit

    var text: String {
        switch self {
        case .settings:
            return "Наcтройки профиля"
        case .favouriteHotels:
            return "Избранные отели"
        case .favouriteFlights:
            return "Избранные перелеты"
        case .ordered:
            return "Заказанные поездки"
        case .support:
            return "Поддержка"
        case .exit:
            return "Выйти"
        }
    }

    var cellIdentifier: String {
        switch self {
        case .exit:
            return ConfirmCell.cellId
        default:
            return PlainLabelCell.cellId
        }
    }

}
