//
//  MLRecommenderService.swift
//  RuTravel
//
//  Created by kalinin on 12.05.2022.
//

import CoreML

final class MLRecommenderService {

    // MARK: - Nested types

    private enum Constants {
        static let recommendationsNumber: Int64 = 5
    }

    static let shared = MLRecommenderService()
    private let hotelService = HotelService.shared
    private let firestoreService = FirestoreService.shared

    private init() {}

    enum Errors: Error {
        case prediction
        case model

        var description: String {
            switch self {
            case .prediction:
                return "Error getting recommendations from model"
            case .model:
                return "Error creating ML Model"
            }
        }
    }

    func getRecommendations(_ hotels: [Hotel],
                                    completion: @escaping (Result<[String], Errors>) -> Void) {
        let config = MLModelConfiguration()
        guard let model = try? JourneyRecommender(configuration: config) else {
            completion(.failure(.model))
            return
        }

        var inputItems = [String: Double]()

        hotels.forEach {
            inputItems.updateValue(Double($0.userRating ?? Int()), forKey: $0.name ?? String())
        }

        let input = JourneyRecommenderInput(
            items: inputItems,
            k: Constants.recommendationsNumber,
            restrict_: nil,
            exclude: nil
        )

        guard let unwrappedResults = try? model.prediction(input: input) else {
            completion(.failure(.prediction))
            return
        }

        completion(.success(unwrappedResults.recommendations))
    }

}
