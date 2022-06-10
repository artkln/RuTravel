//
//  CarouselTableCellModel.swift
//  RuTravel
//
//  Created by kalinin on 07.05.2022.
//

import UIKit

final class CarouselTableCellModel: InfoCellModel {

    let pictures: [UIImage]

    var type: InfoCellType {
        return .carousel
    }

    init(pictures: [UIImage]) {
        self.pictures = pictures
    }

}
