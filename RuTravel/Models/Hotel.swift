//
//  Hotel.swift
//  RuTravel
//
//  Created by kalinin on 09.05.2022.
//

import Foundation
import UIKit

final class HotelResponse: Decodable {

    let popularity: [Hotel]

}

final class Hotel: Decodable {

    // MARK: - Nested Types

    private enum Constants {
        static let nameWithQuotesSeparator: String = "\""
        static let nameWithQuotesJoinSeparator: String = "\"\""
        static let bullet: String = "•  "
        static let separator: String = "\n"
    }

    var id: Int?
    var distanceFromCenter: Double?
    var name: String?
    var stars: Int?
    var rating: Int?
    var hasWifi: Bool?

    var cityName: String?
    var userRating: Int?
    var bulletedText: String?
    var link: String?
    var imageUrl = String()

    var picture: UIImage?

    var dictionary: [String: Any] {
        return [
            "id": id as AnyObject,
            "distanceFromCenter": distanceFromCenter as AnyObject,
            "name": name as AnyObject,
            "stars": stars as AnyObject,
            "rating": rating as AnyObject,
            "hasWifi": hasWifi as AnyObject,
            "cityName": cityName as AnyObject,
            "userRating": userRating as AnyObject,
            "bulletedText": bulletedText as AnyObject,
            "link": link as AnyObject,
            "imageUrl": imageUrl as AnyObject
        ]
    }

    enum CodingKeys: String, CodingKey {
        case id = "hotel_id"
        case distanceFromCenter = "distance"
        case name
        case stars
        case rating
        case hasWifi = "has_wifi"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try? values.decode(Int.self, forKey: .id)
        distanceFromCenter = try? values.decode(Double.self, forKey: .distanceFromCenter)

        name = try? values.decode(String.self, forKey: .name)
        if let nameWithQuotes = name,
           nameWithQuotes.contains(Constants.nameWithQuotesSeparator) {
            let nameComponents = nameWithQuotes.components(separatedBy: Constants.nameWithQuotesSeparator)
            name = nameComponents.joined(separator: Constants.nameWithQuotesJoinSeparator)
        }

        stars = try? values.decode(Int.self, forKey: .stars)
        rating = try? values.decode(Int.self, forKey: .rating)
        hasWifi = try? values.decode(Bool.self, forKey: .hasWifi)
        if let id = id {
            link = "https://search.hotellook.com/?language=ru-RU&currency=rub&hotelId=\(id)"
        }
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else {
            return nil
        }

        id = dictionary["id"] as? Int
        distanceFromCenter = dictionary["distanceFromCenter"] as? Double
        name = dictionary["name"] as? String
        stars = dictionary["stars"] as? Int
        rating = dictionary["rating"] as? Int
        hasWifi = dictionary["hasWifi"] as? Bool
        cityName = dictionary["cityName"] as? String
        userRating = dictionary["userRating"] as? Int
        bulletedText = dictionary["bulletedText"] as? String
        link = dictionary["link"] as? String
        imageUrl = dictionary["imageUrl"] as? String ?? String()
    }

    func setBulletedTextAndCity(_ name: String) {
        cityName = name

        let stringCity = "Город: \(name)"

        var stringDistance = "Удаление от центра: "
        if let distanceFromCenter = distanceFromCenter {
            stringDistance += "\(distanceFromCenter) км."
        } else {
            stringDistance += "Не найдено"
        }

        var stringStars = "Звёздность: "
        if let stars = stars {
            stringStars += "\(stars) из 5"
        } else {
            stringStars += "Не найдено"
        }

        var stringRating = "Рейтинг: "
        if let rating = rating {
            stringRating += "\(rating)"
        } else {
            stringRating += "Не найдено"
        }

        var stringWifi = "Имеется WiFi: "
        if let hasWifi = hasWifi {
            stringWifi += hasWifi ? "Да" : "Нет"
        } else {
            stringWifi += "Не найдено"
        }

        let textArray = [stringCity, stringDistance, stringStars, stringRating, stringWifi]

        bulletedText = textArray.map { return Constants.bullet + $0 }
                                .joined(separator: Constants.separator)
    }

}
