//
//  DestinationCitiesModel.swift
//  RuTravel
//
//  Created by kalinin on 04.05.2022.
//

import Foundation

struct DestinationCitiesModel {

    let title: String = {
        return "Давайте начнем. Выберите город, куда хотите отправиться:"
    }()

    let searchBarPlaceholder: String = {
        return " Найдите город..."
    }()

    let titleForFirstHeader: String = {
        return "Города-курорты"
    }()

    let titleForSecondHeader: String = {
        return "Популярные города"
    }()

    let backButtonTitle: String = {
       return "Выбор города"
    }()

    let destinationCities: [[City]]

}
