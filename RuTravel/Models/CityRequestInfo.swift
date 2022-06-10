//
//  DepartureCityInfo.swift
//  RuTravel
//
//  Created by kalinin on 15.05.2022.
//

import Foundation

struct CityRequestInfo {

    var name: String
    var IATACode: String
    var id: String

    var dictionary: [String: Any] {
        return [
            "name": name,
            "IATACode": IATACode,
            "id": id
        ]
    }

    init(name: String, IATACode: String, id: String) {
        self.name = name
        self.IATACode = IATACode
        self.id = id
    }

    init?(dictionary: [String: Any]?) {
        guard
            let dictionary = dictionary,
            let name = dictionary["name"] as? String,
            let IATACode = dictionary["IATACode"] as? String,
            let id = dictionary["id"] as? String else {
            return nil
        }

        self.name = name
        self.IATACode = IATACode
        self.id = id
    }

}
