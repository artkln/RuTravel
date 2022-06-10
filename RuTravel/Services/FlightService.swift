//
//  FlightService.swift
//  RuTravel
//
//  Created by kalinin on 11.05.2022.
//

import Foundation

final class FlightService {

    static let shared = FlightService()
    private init() {}

    private let imageService = ImageService.shared

    enum FlightErrors: Error {
        case cannotConstructURL
        case errorWhileRequest
        case decodingFlights

        var description: String {
            switch self {
            case .cannotConstructURL:
                return "Cannot construct URL for get flights query"
            case .errorWhileRequest:
                return "Error while performing get flights request"
            case .decodingFlights:
                return "Error while decoding flights from JSON"
            }
        }
    }

    func getFlight(departureCityInfo: CityRequestInfo,
                   destinationCityInfo: CityRequestInfo,
                   departureDate: String,
                   returnDate: String,
                   completion: @escaping (Result<[Flight], FlightErrors>) -> Void) {
        let session = URLSession.shared
        let URLComponents = getFlightURLComponents(originIATACode: departureCityInfo.IATACode,
                                                   destinationIATACode: destinationCityInfo.IATACode,
                                                   departureDate: departureDate,
                                                   returnDate: returnDate)

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
                let flightResponse = try? JSONDecoder().decode(FlightResponse.self, from: data).data else {
                completion(.failure(.decodingFlights))
                return
            }

            let dispatchGroup = DispatchGroup()
            for flight in flightResponse {
                dispatchGroup.enter()

                self?.getAirlineName(IATACode: flight.airline?.IATACode ?? String()) { airlineName in
                    if let airlineName = airlineName {
                        flight.airline?.name = airlineName
                        flight.setBulletedText(
                            departureCityName: departureCityInfo.name,
                            destinationCityName: destinationCityInfo.name
                        )

                        self?.imageService.loadPictureFrom(flight.imageUrl ?? String()) { picture in
                            if let picture = picture {
                                flight.picture = picture
                            } else {
                                flight.picture = Asset.photoPlaceholder.image
                            }
                            dispatchGroup.leave()
                        }
                    } else {
                        flight.airline?.name = flight.airline?.IATACode
                        flight.setBulletedText(
                            departureCityName: departureCityInfo.name,
                            destinationCityName: destinationCityInfo.name
                        )
                        flight.picture = Asset.photoPlaceholder.image
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion(.success(flightResponse))
            }
        }
        task.resume()
    }

    func getAirlineName(IATACode: String,
                        completion: @escaping (String?) -> Void) {
        let session = URLSession.shared
        let URLComponents = getAirlineNameURLComponents(IATACode: IATACode)

        guard let URL = URLComponents.url else {
            completion(nil)
            return
        }

        var request = URLRequest(url: URL)
        request.setValue("aviation-reference-data.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue("469ba91d1dmsh4e41e8d0029fd00p1aef16jsn022683ebcf66", forHTTPHeaderField: "X-RapidAPI-Key")

        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil)
                return
            }

            guard
                let data = data,
                let airlineName = try? JSONDecoder().decode(Airline.self, from: data).name else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(airlineName)
            }
        }
        task.resume()
    }

    private func getFlightURLComponents(originIATACode: String,
                                  destinationIATACode: String,
                                  departureDate: String,
                                  returnDate: String) -> URLComponents {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.travelpayouts.com"
        urlConstructor.path = "/aviasales/v3/prices_for_dates"
        urlConstructor.queryItems = [
            URLQueryItem(name: "origin", value: originIATACode),
            URLQueryItem(name: "destination", value: destinationIATACode),
            URLQueryItem(name: "currency", value: "rub"),
            URLQueryItem(name: "departure_at", value: departureDate),
            URLQueryItem(name: "return_at", value: returnDate),
            URLQueryItem(name: "sorting", value: "price"),
            URLQueryItem(name: "direct", value: "true"),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "token", value: "a5e4abb9fcaa261b9d52276fd8fb85c0")
        ]
        return urlConstructor
    }

    private func getAirlineNameURLComponents(IATACode: String) -> URLComponents {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "aviation-reference-data.p.rapidapi.com"
        urlConstructor.path = "/airline/\(IATACode)"
        return urlConstructor
    }

}
