//
//  BulletedLabelCellModel.swift
//  RuTravel
//
//  Created by kalinin on 07.05.2022.
//

import Foundation

final class BulletedLabelCellModel: InfoCellModel {

    let text: [String]

    var type: InfoCellType {
        return .bulletedLabel
    }

    init(text: [String]) {
        self.text = text
    }

}
