//
//  ServiceCellModel.swift
//  RuTravel
//
//  Created by kalinin on 08.05.2022.
//

import Foundation

final class ServiceCellModel: InfoCellModel {

    let serviceInfo: [String: String]

    var type: InfoCellType {
        return .service
    }

    init(serviceInfo: [String: String]) {
        self.serviceInfo = serviceInfo
    }

}
