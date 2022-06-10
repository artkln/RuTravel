//
//  TitleCellModel.swift
//  RuTravel
//
//  Created by kalinin on 07.05.2022.
//

import Foundation

final class TitleCellModel: InfoCellModel {

    let text: String

    var type: InfoCellType {
        return .title
    }

    init(text: String?) {
        self.text = text ?? String()
    }

}
