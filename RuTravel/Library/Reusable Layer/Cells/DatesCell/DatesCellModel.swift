//
//  DatesCellModel.swift
//  RuTravel
//
//  Created by kalinin on 08.05.2022.
//

import Foundation

final class DatesCellModel: InfoCellModel {

    let onDateConfirm: (String, String) -> Void

    var type: InfoCellType {
        return .dates
    }

    init(onDateConfirm: @escaping (String, String) -> Void) {
        self.onDateConfirm = onDateConfirm
    }

}
