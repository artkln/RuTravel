//
//  PlainLabelCellModel.swift
//  RuTravel
//
//  Created by kalinin on 07.05.2022.
//

import Foundation

final class PlainLabelCellModel: InfoCellModel {

    let text: String
    let isAccessoryButtonNeeded: Bool

    var type: InfoCellType {
        return .plainLabel
    }

    init(text: String, isAccessoryButtonNeeded: Bool) {
        self.text = text
        self.isAccessoryButtonNeeded = isAccessoryButtonNeeded
    }

}
