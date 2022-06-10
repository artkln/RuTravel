//
//  RateHotelModel.swift
//  RuTravel
//
//  Created by kalinin on 12.05.2022.
//

import Foundation

struct RateHotelModel {

    let title: String = {
        return "Уже были в данном отеле? Отлично. Оцените его по шкале от 0 до 100:"
    }()

    let backButtonTitle: String = {
       return "Назад"
    }()

    let rateButtonTitle: String = {
       return "Оценить"
    }()

    let hotel: Hotel

}
