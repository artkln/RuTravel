//
//  InfoCell.swift
//  RuTravel
//
//  Created by kalinin on 05.05.2022.
//

import Foundation

enum InfoCellType {

    case title
    case dates
    case confirm
    case carousel
    case subDescription
    case plainLabel
    case bulletedLabel
    case service
    case hotel
    case flight
    case infoChangeable
    case city

}

protocol InfoCellModel: AnyObject {

    var type: InfoCellType { get }

}

protocol InfoCell {

    func configure(with model: InfoCellModel)

}
