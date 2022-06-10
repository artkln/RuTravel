//
//  Flight.swift
//  RuTravel
//
//  Created by kalinin on 11.05.2022.
//

import Foundation
import UIKit

final class FlightResponse: Decodable {

    let data: [Flight]

}

final class Flight: Decodable {

    // MARK: - Nested Types

    private enum Constants {
        static let bullet: String = "•  "
        static let separator: String = "\n"
    }

    let price: Int?
    let airline: Airline?
    let flightNumber: String?
    let departureAt: String?
    let returnAt: String?
    let duration: Int?
    let link: String?

    var bulletedText: String?
    var imageUrl: String?

    var picture: UIImage?

    var dictionary: [String: Any] {
        return [
            "price": price as AnyObject,
            "airline": airline?.dictionary as AnyObject,
            "flightNumber": flightNumber as AnyObject,
            "departureAt": departureAt as AnyObject,
            "returnAt": returnAt as AnyObject,
            "duration": duration as AnyObject,
            "link": link as AnyObject,
            "bulletedText": bulletedText as AnyObject,
            "imageUrl": imageUrl as AnyObject
        ]
    }

    enum CodingKeys: String, CodingKey {
        case price
        case airlineIATACode = "airline"
        case flightNumber = "flight_number"
        case departureAt = "departure_at"
        case returnAt = "return_at"
        case duration
        case link
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        price = try? value.decode(Int.self, forKey: .price)
        airline = Airline(IATACode: try? value.decode(String.self, forKey: .airlineIATACode))
        flightNumber = try? value.decode(String.self, forKey: .flightNumber)
        departureAt = try? value.decode(String.self, forKey: .departureAt)
        returnAt = try? value.decode(String.self, forKey: .returnAt)
        duration = try? value.decode(Int.self, forKey: .duration)

        if let rawLink = try? value.decode(String.self, forKey: .link) {
            link = "https://www.aviasales.ru" + rawLink
        } else {
            link = nil
        }

        if let airlineIATACode = airline?.IATACode {
            imageUrl = "https://pics.avs.io/200/200/\(airlineIATACode).png"
        }
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else {
            return nil
        }

        let airlineDict = dictionary["airline"] as? [String: Any]

        price = dictionary["price"] as? Int
        airline = Airline(dictionary: airlineDict)
        flightNumber = dictionary["flightNumber"] as? String
        departureAt = dictionary["departureAt"] as? String
        returnAt = dictionary["returnAt"] as? String
        duration = dictionary["duration"] as? Int
        link = dictionary["link"] as? String
        bulletedText = dictionary["bulletedText"] as? String
        imageUrl = dictionary["imageUrl"] as? String ?? String()
    }

    func setBulletedText(departureCityName: String, destinationCityName: String) {
        let citiesString = "Маршрут: \(departureCityName) - \(destinationCityName)"

        var stringDuration = "Продолжительность рейса: "
        if let duration = duration {
            stringDuration += "\(duration / 60) ч. \(duration % 60) мин."
        } else {
            stringDuration += "Не найдено"
        }

        var stringAirline = "Авиакомпания: "
        if let airlineName = airline?.name {
            stringAirline += "\(airlineName)"
        } else {
            stringAirline += "Не найдено"
        }

        var stringFlightNumber = "Номер рейса: "
        if let flightNumber = flightNumber {
            stringFlightNumber += "\(flightNumber)"
        } else {
            stringFlightNumber += "Не найдено"
        }

        var stringDeparture = "Вылет: "
        if let departureAt = departureAt {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
            if let date = formatter.date(from: departureAt) {
                formatter.dateFormat = "dd.MM.yyyy HH:mm"
                stringDeparture += "\(formatter.string(from: date))"
            } else {
                stringDeparture += "Не найдено"
            }
        } else {
            stringDeparture += "Не найдено"
        }

        var stringReturn = "Вылет (обратно): "
        if let returnAt = returnAt {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
            if let date = formatter.date(from: returnAt) {
                formatter.dateFormat = "dd.MM.yyyy HH:mm"
                stringReturn += "\(formatter.string(from: date))"
            } else {
                stringReturn += "Не найдено"
            }
        } else {
            stringReturn += "Не найдено"
        }

        let textArray = [
            citiesString,
            stringAirline,
            stringDeparture,
            stringReturn,
            stringDuration,
            stringFlightNumber
        ]

        bulletedText = textArray.map { return Constants.bullet + $0 }
                                .joined(separator: Constants.separator)
    }

}
