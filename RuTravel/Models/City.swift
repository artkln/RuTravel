//
//  City.swift
//  RuTravel
//
//  Created by kalinin on 14.05.2022.
//

import Foundation
import UIKit

struct City {

    let requestInfo: CityRequestInfo
    let isResort: Bool
    let images: [String]
    let description: String?
    let whatToSee: [String]?
    let whereToStay: String?
    let whatToTry: String?
    let whatToBuy: [String]?
    let subDescription: String?
    let serviceInfo: [String: String]?

    var pictures = [UIImage]()

    var dictionary: [String: Any] {
        return [
            "requestInfo": requestInfo.dictionary,
            "isResort": isResort,
            "images": images,
            "description": description as AnyObject,
            "whatToSee": whatToSee as AnyObject,
            "whereToStay": whereToStay as AnyObject,
            "whatToTry": whatToTry as AnyObject,
            "whatToBuy": whatToBuy as AnyObject,
            "subDescription": subDescription as AnyObject,
            "serviceInfo": serviceInfo as AnyObject
        ]
    }

    init?(dictionary: [String: Any]?) {
        guard
            let dictionary = dictionary,
            let requestInfoDict = dictionary["requestInfo"] as? [String: Any],
            let requestInfo = CityRequestInfo(dictionary: requestInfoDict),
            let isResort = dictionary["isResort"] as? Bool,
            let images = dictionary["images"] as? [String] else {
            return nil
        }

        self.requestInfo = requestInfo
        self.isResort = isResort
        self.images = images
        self.description = dictionary["description"] as? String
        self.whatToSee = dictionary["whatToSee"] as? [String]
        self.whereToStay = dictionary["whereToStay"] as? String
        self.whatToTry = dictionary["whatToTry"] as? String
        self.whatToBuy = dictionary["whatToBuy"] as? [String]
        self.subDescription = dictionary["subDescription"] as? String
        self.serviceInfo = dictionary["serviceInfo"] as? [String: String]
    }

}
