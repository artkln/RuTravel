//
//  Journey.swift
//  RuTravel
//
//  Created by kalinin on 10.05.2022.
//

import Foundation

struct Journey {

    var departureCityInfo: CityRequestInfo?
    var destinationCityInfo: CityRequestInfo?
    var startDate: String?
    var endDate: String?
    var datesString: String {
        var newStartDate = String()
        var newEndDate = String()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if
            let startDate = formatter.date(from: startDate ?? String()),
            let endDate = formatter.date(from: endDate ?? String()) {
            formatter.dateFormat = "dd.MM.yyyy"
            newStartDate = formatter.string(from: startDate)
            newEndDate = formatter.string(from: endDate)
        }
        return "Дата начала поездки: \(newStartDate)\n\n" +
               "Дата окончания поездки: \(newEndDate)"
    }

    var hotel: Hotel?
    var flight: Flight?

    var dictionary: [String: Any] {
        [
            "departureCityInfo": departureCityInfo?.dictionary as AnyObject,
            "destinationCityInfo": destinationCityInfo?.dictionary as AnyObject,
            "startDate": startDate as AnyObject,
            "endDate": endDate as AnyObject,
            "datesString": datesString as AnyObject,
            "hotel": hotel?.dictionary as AnyObject,
            "flight": flight?.dictionary as AnyObject
        ]
    }

    init() {
        departureCityInfo = nil
        destinationCityInfo = nil
        startDate = nil
        endDate = nil
        hotel = nil
        flight = nil
    }

    init?(dictionary: [String: Any]) {
        let departureCityInfoDict = dictionary["departureCityInfo"] as? [String: Any]
        let destinationCityInfoDict = dictionary["destinationCityInfo"] as? [String: Any]
        let hotelDict = dictionary["hotel"] as? [String: Any]
        let flightDict = dictionary["flight"] as? [String: Any]

        departureCityInfo = CityRequestInfo(dictionary: departureCityInfoDict)
        destinationCityInfo = CityRequestInfo(dictionary: destinationCityInfoDict)
        startDate = dictionary["startDate"] as? String
        endDate = dictionary["endDate"] as? String
        hotel = Hotel(dictionary: hotelDict)
        flight = Flight(dictionary: flightDict)
    }

}
