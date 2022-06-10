//
//  InfoChangeableCellModel.swift
//  RuTravel
//
//  Created by kalinin on 21.05.2022.
//

import Foundation

final class InfoChangeableCellModel: InfoCellModel {

    let text: String
    var onChangeButtonPressed: (() -> Void)?
    var onConfirmButtonPressed: ((String) -> Void)?
    var onTextFieldReturn: (() -> Void)?

    var type: InfoCellType {
        return .infoChangeable
    }

    init(text: String,
         onChangeButtonPressed: (() -> Void)?,
         onConfirmButtonPressed: ((String) -> Void)?,
         onTextFieldReturn: (() -> Void)?) {
        self.text = text
        self.onChangeButtonPressed = onChangeButtonPressed
        self.onConfirmButtonPressed = onConfirmButtonPressed
        self.onTextFieldReturn = onTextFieldReturn
    }

}
