//
//  HotelService.swift
//  RuTravel
//
//  Created by kalinin on 09.05.2022.
//

import Foundation
import UIKit

final class HotelService {

    // MARK: - Nested types

    private enum Constants {
        static let city: String = "City"
        static let hotelName: String = "Hotel Name"
        static let hotelRating: String = "Hotel Rating"
        static let CSVFileName: String = "CSVRec.csv"
        static let recommendationsNumber: Int64 = 5
    }

    static let shared = HotelService()
    private init() {}

    private let imageService = ImageService.shared

    enum HotelErrors: Error {
        case cannotConstructURL
        case errorWhileRequest
        case decodingHotels
        case CSVFile

        var description: String {
            switch self {
            case .cannotConstructURL:
                return "Cannot construct URL for get hotels query"
            case .errorWhileRequest:
                return "Error while performing get hotels request"
            case .decodingHotels:
                return "Error while decoding hotels from JSON"
            case .CSVFile:
                return "Error creating CSV file with hotels"
            }
        }
    }

    func getHotelsWithData(destinationCityInfo: CityRequestInfo,
                           checkInDate: String,
                           checkOutDate: String,
                           completion: @escaping (Result<[Hotel], HotelErrors>) -> Void) {
        let session = URLSession.shared
        let URLComponents = getHotelURLComponents(
            cityId: destinationCityInfo.id,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate
        )

        guard let URL = URLComponents.url else {
            completion(.failure(.cannotConstructURL))
            return
        }

        let request = URLRequest(url: URL)

        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            if error != nil {
                completion(.failure(.errorWhileRequest))
                return
            }

            guard
                let data = data,
                let hotelResponse = try? JSONDecoder().decode(HotelResponse.self, from: data).popularity else {
                completion(.failure(.decodingHotels))
                return
            }

            let dispatchGroup = DispatchGroup()
            for hotel in hotelResponse {
                dispatchGroup.enter()
                hotel.setBulletedTextAndCity(destinationCityInfo.name)

                self?.getPhotoId(from: String(hotel.id ?? 0)) { photoId in
                    if let photoId = photoId {
                        hotel.imageUrl = "https://photo.hotellook.com/image_v2/limit/\(photoId)/800/520.auto"
                        self?.imageService.loadPictureFrom(hotel.imageUrl) { picture in
                            if let picture = picture {
                                hotel.picture = picture
                            } else {
                                hotel.picture = Asset.photoPlaceholder.image
                            }
                            dispatchGroup.leave()
                        }
                    } else {
                        hotel.picture = Asset.photoPlaceholder.image
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion(.success(hotelResponse))
            }
        }
        task.resume()
    }

    private func getPhotoId(from hotelId: String,
                            completion: @escaping (Int?) -> Void) {
        let session = URLSession.shared
        let URLComponents = getPhotoIdURLComponents(hotelId: hotelId)

        guard let URL = URLComponents.url else {
            completion(nil)
            return
        }

        let request = URLRequest(url: URL)

        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil)
                return
            }

            guard
                let data = data,
                let photoIdResponse = try? JSONDecoder().decode([String: [Int]].self, from: data),
                let photoId = photoIdResponse[hotelId]?.first else {
                completion(nil)
                return
            }

            completion(photoId)
        }
        task.resume()
    }

    private func getHotelURLComponents(cityId: String,
                                  checkInDate: String,
                                  checkOutDate: String) -> URLComponents {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "yasen.hotellook.com"
        urlConstructor.path = "/tp/public/widget_location_dump.json"
        urlConstructor.queryItems = [
            URLQueryItem(name: "currency", value: "rub"),
            URLQueryItem(name: "language", value: "ru"),
            URLQueryItem(name: "limit", value: "100"),
            URLQueryItem(name: "id", value: cityId),
            URLQueryItem(name: "type", value: "popularity"),
            URLQueryItem(name: "check_in", value: checkInDate),
            URLQueryItem(name: "check_out", value: checkOutDate),
            URLQueryItem(name: "token", value: "a5e4abb9fcaa261b9d52276fd8fb85c0")
        ]
        return urlConstructor
    }

    private func getPhotoIdURLComponents(hotelId: String) -> URLComponents {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "yasen.hotellook.com"
        urlConstructor.path = "/photos/hotel_photos"
        urlConstructor.queryItems = [
            URLQueryItem(name: "id", value: hotelId)
        ]
        return urlConstructor
    }

    func getAllHotels(from cities: [City],
                      startDate: String,
                      endDate: String,
                      completion: @escaping (Result<[Hotel], HotelErrors>) -> Void) {
        var hotelList = [Hotel]()

        let dispatchGroup = DispatchGroup()
        for city in cities {
            dispatchGroup.enter()

            getHotelsWithData(destinationCityInfo: city.requestInfo, checkInDate: startDate, checkOutDate: endDate) { result in
                switch result {
                case .success(let hotels):
                    hotelList.append(contentsOf: hotels)
                    dispatchGroup.leave()
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(.success(hotelList))
        }
    }

    func getCSVTrainingData(from cities: [City],
                            startDate: String,
                            endDate: String,
                            completion: @escaping (HotelErrors?) -> Void) {
        var trainingData = [[String: AnyObject]]()
        let dispatchGroup = DispatchGroup()

        var cityHotels = [[String: AnyObject]]()
        for city in cities {
            dispatchGroup.enter()

            getHotelsWithData(destinationCityInfo: city.requestInfo, checkInDate: startDate, checkOutDate: endDate) { result in
                switch result {
                case .success(let hotels):
                    for hotel in hotels {
                        var hotelRow = [String: AnyObject]()
                        hotelRow.updateValue(city.requestInfo.name as AnyObject, forKey: Constants.city)
                        hotelRow.updateValue(hotel.name as AnyObject, forKey: Constants.hotelName)
                        hotelRow.updateValue(hotel.rating as AnyObject, forKey: Constants.hotelRating)
                        cityHotels.append(hotelRow)
                    }
                    dispatchGroup.leave()
                case .failure(let error):
                    completion(error)
                    return
                }
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            trainingData.append(contentsOf: cityHotels)
            self?.createCSV(from: trainingData) { error in
                completion(error)
            }
        }
    }

    private func createCSV(from recArray: [Dictionary<String, AnyObject>],
                           completion: @escaping (HotelErrors?) -> Void) {
        var csvString = "\(Constants.city),\(Constants.hotelName),\(Constants.hotelRating)\n\n"
        for row in recArray {
            guard
                let city = row[Constants.city],
                let name = row[Constants.hotelName],
                let rating = row[Constants.hotelRating] else {
                completion(.CSVFile)
                return
            }

            csvString = csvString.appending("\(city),\"\(name)\",\(rating)\n")
        }

        let fileManager = FileManager.default
        do {
            let path = try fileManager.url(
                for: .documentDirectory,
                in: .allDomainsMask,
                appropriateFor: nil,
                create: false
            )
            let fileURL = path.appendingPathComponent(Constants.CSVFileName)
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            completion(.CSVFile)
        }
        completion(nil)
    }

}
