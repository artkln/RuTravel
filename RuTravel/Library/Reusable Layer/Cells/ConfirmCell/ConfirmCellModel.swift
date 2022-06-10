//
//  ConfirmCellModel.swift
//  RuTravel
//
//  Created by kalinin on 10.05.2022.
//

import Foundation

final class ConfirmCellModel: InfoCellModel {

    let buttonTitle: String
    let buttonStyle: RuTravelButton.Style
    var onButtonPressed: (() -> Void)

    var type: InfoCellType {
        return .confirm
    }

    init(buttonTitle: String, buttonStyle: RuTravelButton.Style, onButtonPressed: @escaping (() -> Void)) {
        self.buttonTitle = buttonTitle
        self.buttonStyle = buttonStyle
        self.onButtonPressed = onButtonPressed
    }

}
