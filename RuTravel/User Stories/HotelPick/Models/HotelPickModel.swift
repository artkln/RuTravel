//
//  HotelPickModel.swift
//  RuTravel
//
//  Created by kalinin on 10.05.2022.
//

import Foundation

struct HotelPickModel {

    let title: String = {
        return "Теперь выберите отель:"
    }()

    let backButtonTitle: String = {
       return "Выбор отеля"
    }()

    var hotelList: [Hotel]

}

enum HotelPickMainSectionRows: Int {

    case title
    case dates

    var cellIdentifier: String {
        switch self {
        case .title:
            return TitleCell.cellId
        case .dates:
            return DatesCell.cellId
        }
    }

}
