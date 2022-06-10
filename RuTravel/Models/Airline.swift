//
//  Airline.swift
//  RuTravel
//
//  Created by kalinin on 11.05.2022.
//

import Foundation

final class Airline: Decodable {

    var name: String?
    var IATACode: String?

    var dictionary: [String: Any] {
        return [
            "name": name as AnyObject,
            "IATACode": IATACode as AnyObject
        ]
    }

    enum CodingKeys: String, CodingKey {
        case name
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        name = try? value.decode(String.self, forKey: .name)
    }

    init(IATACode: String?) {
        self.IATACode = IATACode
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else {
            return nil
        }

        name = dictionary["name"] as? String
        IATACode = dictionary["IATACode"] as? String
    }

}
