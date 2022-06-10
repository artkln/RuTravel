//
//  SettingsModel.swift
//  RuTravel
//
//  Created by kalinin on 14.05.2022.
//

import Foundation

struct SettingsModel {

    var nameRowText: String
    var emailRowText: String
    let passwordRowText = "Ваш пароль:   •••••••••"
    var departureCityRowText = "Выбрать город"

    init(name: String, email: String, departureCityName: String?) {
        if let departureCityName = departureCityName {
            departureCityRowText = "Ваш город:   \(departureCityName)"
        }
        nameRowText = "Ваше имя:   \(name)"
        emailRowText = "Ваш e-mail:   \(email)"
    }

}

enum SettingsRows: Int {

    case name
    case email
    case password
    case departureCity

    var cellIdentifier: String {
        switch self {
        case .departureCity, .password:
            return PlainLabelCell.cellId
        default:
            return InfoChangeableCell.cellId
        }
    }

}
