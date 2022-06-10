//
//  RecommendationsModel.swift
//  RuTravel
//
//  Created by kalinin on 12.05.2022.
//

import Foundation

struct RecommendationsModel {

    let title: String = {
        return "Ознакомьтесь с нашими рекоммендациями:"
    }()

    let backButtonTitle: String = {
       return "Рекоммендации"
    }()

    var hotelList = [Hotel]()

}

enum RecommendationsMainSectionRows: Int {

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
