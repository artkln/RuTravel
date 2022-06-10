//
//  CityCellModel.swift
//  RuTravel
//
//  Created by kalinin on 23.05.2022.
//

import UIKit

final class CityCellModel: InfoCellModel {

    let text: String
    let image: UIImage

    var type: InfoCellType {
        return .city
    }

    init(text: String, image: UIImage) {
        self.text = text
        self.image = image
    }

}
