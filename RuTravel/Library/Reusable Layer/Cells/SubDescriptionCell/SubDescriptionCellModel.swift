//
//  SubDescriptionCellModel.swift
//  RuTravel
//
//  Created by kalinin on 07.05.2022.
//

import Foundation

final class SubDescriptionCellModel: InfoCellModel {

    let text: String

    var type: InfoCellType {
        return .subDescription
    }

    init(text: String) {
        self.text = text
    }

}
