//
//  FirestoreService.swift
//  RuTravel
//
//  Created by kalinin on 14.05.2022.
//

import FirebaseAuth
import FirebaseFirestore

final class FirestoreService {

    // MARK: - Nested Types

    enum CityErrors: Error {
        case errorGettingDocuments
        case noSnapshot
        case cannotCreateFromDictionary

        var description: String {
            switch self {
            case .errorGettingDocuments:
                return "Error getting firestore documents for cities"
            case .noSnapshot:
                return "Error getting cities snapshot"
            case .cannotCreateFromDictionary:
                return "Cannot create cities from dictionary"
            }
        }
    }

    enum FlightErrors: Error {
        case currentUser
        case cannotSave
        case cannotCreateFromDictionary
        case noSnapshot
        case errorGettingDocuments

        var description: String {
            switch self {
            case .currentUser:
                return "Error getting current authorized user"
            case .cannotSave:
                return "Error saving flight to firestore"
            case .cannotCreateFromDictionary:
                return "Cannot create flight from dictionary"
            case .noSnapshot:
                return "Error getting flights snapshot"
            case .errorGettingDocuments:
                return "Error getting firestore documents for flights"
            }
        }
    }

    enum JourneyErrors: Error {
        case currentUser
        case cannotSave
        case cannotCreateFromDictionary
        case noSnapshot
        case errorGettingDocuments

        var description: String {
            switch self {
            case .currentUser:
                return "Error getting current authorized user"
            case .cannotSave:
                return "Error saving journey to firestore"
            case .cannotCreateFromDictionary:
                return "Cannot create journey from dictionary"
            case .noSnapshot:
                return "Error getting journeys snapshot"
            case .errorGettingDocuments:
                return "Error getting firestore documents for journeys"
            }
        }
    }

    enum HotelErrors: Error {
        case currentUser
        case cannotSave
        case cannotCreateFromDictionary
        case noSnapshot
        case errorGettingDocuments

        var description: String {
            switch self {
            case .currentUser:
                return "Error getting current authorized user"
            case .cannotSave:
                return "Error saving hotel to firestore"
            case .cannotCreateFromDictionary:
                return "Cannot create hotel from dictionary"
            case .noSnapshot:
                return "Error getting hotels snapshot"
            case .errorGettingDocuments:
                return "Error getting firestore documents for hotels"
            }
        }
    }

    enum UserErrors: Error {
        case noAuthorizedUser
        case errorGettingDocument
        case documentNotExists
        case cannotCreateFromDictionary
        case cannotCreateFromData
        case cannotSaveUser
        case cannotUpdateUser

        var description: String {
            switch self {
            case .noAuthorizedUser:
                return "Error getting current authorized user"
            case .errorGettingDocument:
                return "Error getting firestore document for current user"
            case .documentNotExists:
                return "Document for user does not exist"
            case .cannotCreateFromDictionary:
                return "Cannot create user from dictionary"
            case .cannotCreateFromData:
                return "Cannot create authorized user from firestore data"
            case .cannotSaveUser:
                return "Cannot save user to firestore"
            case .cannotUpdateUser:
                return "Cannot update user document in firestore"
            }
        }
    }

    static let shared = FirestoreService()
    private init() {}

    private let usersCollection = Firestore.firestore().collection("users")
    private let citiesCollection = Firestore.firestore().collection("cities")
    private let hotelsCollection = Firestore.firestore().collection("hotels")
    private let imageService = ImageService.shared

    func saveNewUser(data: AuthDataResult,
                     completion: @escaping(UserErrors?) -> Void) {
        guard
            let name = data.user.displayName,
            let email = data.user.email else {
            completion(.cannotCreateFromData)
            return
        }

        var user = User()
        user.name = name
        user.email = email

        usersCollection.document(data.user.uid).setData(user.dictionary) { error in
            if error != nil {
                completion(.cannotSaveUser)
                return
            }
            completion(nil)
        }
    }

    func getCurrentUser(completion: @escaping (Result<User, UserErrors>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(.noAuthorizedUser))
            return
        }

        let docRef = usersCollection.document(user.uid)

        docRef.getDocument { (document, error) in
            if error != nil {
                completion(.failure(.errorGettingDocument))
                return
            }

            guard
                let document = document,
                    document.exists else {
                completion(.failure(.documentNotExists))
                return
            }

            guard
                let dataDescription = document.data(),
                let user = User(dictionary: dataDescription) else {
                completion(.failure(.cannotCreateFromDictionary))
                return
            }

            completion(.success(user))
        }
    }

    func listenOnUserUpdates(completion: @escaping (Result<User, UserErrors>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(.noAuthorizedUser))
            return
        }

        let docRef = usersCollection.document(user.uid)

        docRef.addSnapshotListener { (documentSnapshot, error) in
            if error != nil {
                completion(.failure(.errorGettingDocument))
                return
            }

            guard let document = documentSnapshot else {
                completion(.failure(.documentNotExists))
                return
            }

            guard
                let dataDescription = document.data(),
                let user = User(dictionary: dataDescription) else {
                completion(.failure(.cannotCreateFromDictionary))
                return
            }

            completion(.success(user))
        }
    }

    func updateUserJourney(_ journey: Journey,
                    isInSearchModule: Bool,
                    completion: @escaping (UserErrors?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.noAuthorizedUser)
            return
        }

        let journeyRef = isInSearchModule ?
                            "searchedJourney" :
                            "recommendedJourney"
        let docRef = usersCollection.document(user.uid)

        docRef.updateData([
            journeyRef: journey.dictionary
        ]) { error in
            if error != nil {
                completion(.cannotUpdateUser)
                return
            }
            completion(nil)
        }
    }

    func updateUserName(_ name: String,
                        completion: @escaping (UserErrors?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.noAuthorizedUser)
            return
        }

        let docRef = usersCollection.document(user.uid)

        docRef.updateData([
            "name": name
        ]) { error in
            if error != nil {
                completion(.cannotUpdateUser)
                return
            }
            completion(nil)
        }
    }

    func updateUserEmail(_ email: String,
                        completion: @escaping (UserErrors?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.noAuthorizedUser)
            return
        }

        let docRef = usersCollection.document(user.uid)

        docRef.updateData([
            "email": email
        ]) { error in
            if error != nil {
                completion(.cannotUpdateUser)
                return
            }
            completion(nil)
        }
    }

    func getPopularCities(completion: @escaping (Result<[City], CityErrors>) -> Void) {
        citiesCollection.whereField("isResort", isEqualTo: false)
            .getDocuments { [weak self] (querySnapshot, error) in
                if error != nil {
                    completion(.failure(.errorGettingDocuments))
                    return
                }

                guard let querySnapshot = querySnapshot else {
                    completion(.failure(.noSnapshot))
                    return
                }

                let dispatchGroup = DispatchGroup()

                var cities = [City]()
                for document in querySnapshot.documents {
                    guard
                        var city = City(dictionary: document.data()) else {
                        completion(.failure(.cannotCreateFromDictionary))
                        return
                    }

                    dispatchGroup.enter()

                    self?.imageService.loadCityPictures(from: city.images) { pictures in
                        if let pictures = pictures {
                            city.pictures = pictures
                        } else {
                            city.pictures = [Asset.photoPlaceholder.image]
                        }
                        cities.append(city)
                        dispatchGroup.leave()
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(.success(cities.sorted {
                        $0.requestInfo.name < $1.requestInfo.name
                    }))
                }
            }
    }

    func getResortCities(completion: @escaping (Result<[City], CityErrors>) -> Void) {
        citiesCollection.whereField("isResort", isEqualTo: true)
            .getDocuments { [weak self] (querySnapshot, error) in
                if error != nil {
                    completion(.failure(.errorGettingDocuments))
                    return
                }

                guard let querySnapshot = querySnapshot else {
                    completion(.failure(.noSnapshot))
                    return
                }

                let dispatchGroup = DispatchGroup()

                var cities = [City]()
                for document in querySnapshot.documents {
                    guard
                        var city = City(dictionary: document.data()) else {
                        completion(.failure(.cannotCreateFromDictionary))
                        return
                    }

                    dispatchGroup.enter()

                    self?.imageService.loadCityPictures(from: city.images) { pictures in
                        if let pictures = pictures {
                            city.pictures = pictures
                        } else {
                            city.pictures = [Asset.photoPlaceholder.image]
                        }
                        cities.append(city)
                        dispatchGroup.leave()
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(.success(cities.sorted {
                        $0.requestInfo.name < $1.requestInfo.name
                    }))
                }
            }
    }

    func getAllCities(completion: @escaping (Result<[City], CityErrors>) -> Void) {
        citiesCollection.getDocuments { (querySnapshot, error) in
                if error != nil {
                    completion(.failure(.errorGettingDocuments))
                    return
                }

                guard let querySnapshot = querySnapshot else {
                    completion(.failure(.noSnapshot))
                    return
                }

                var cities = [City]()
                for document in querySnapshot.documents {
                    guard
                        let city = City(dictionary: document.data()) else {
                        completion(.failure(.cannotCreateFromDictionary))
                        return
                    }
                    cities.append(city)
                }

                completion(.success(cities.sorted {
                    $0.requestInfo.name < $1.requestInfo.name
                }))
        }
    }

    func getCityByName(_ name: String,
                       completion: @escaping (Result<City, CityErrors>) -> Void) {
        citiesCollection.getDocuments { (querySnapshot, error) in
            if error != nil {
                completion(.failure(.errorGettingDocuments))
                return
            }

            guard let querySnapshot = querySnapshot else {
                completion(.failure(.noSnapshot))
                return
            }

            for document in querySnapshot.documents {
                guard
                    let city = City(dictionary: document.data()) else {
                    completion(.failure(.cannotCreateFromDictionary))
                    return
                }

                if city.requestInfo.name == name {
                    completion(.success(city))
                    return
                }
            }
        }
    }

    func saveRatedHotel(_ hotel: Hotel,
                        completion: @escaping (HotelErrors?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.currentUser)
            return
        }

        usersCollection.document(user.uid)
            .collection("ratedHotels").document(String(hotel.id ?? Int()))
            .setData(hotel.dictionary) { error in
                if error != nil {
                    completion(.cannotSave)
                    return
                }
                completion(nil)
            }
    }

    func getRatedHotels(completion: @escaping (Result<[Hotel], HotelErrors>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(.currentUser))
            return
        }

        usersCollection.document(user.uid)
            .collection("ratedHotels").getDocuments { [weak self] (querySnapshot, error) in
                if error != nil {
                    completion(.failure(.errorGettingDocuments))
                    return
                }

                guard let querySnapshot = querySnapshot else {
                    completion(.failure(.noSnapshot))
                    return
                }

                let dispatchGroup = DispatchGroup()

                var hotels = [Hotel]()
                for document in querySnapshot.documents {
                    guard
                        let hotel = Hotel(dictionary: document.data()) else {
                        completion(.failure(.cannotCreateFromDictionary))
                        return
                    }

                    dispatchGroup.enter()

                    self?.imageService.loadPictureFrom(hotel.imageUrl) { picture in
                        if let picture = picture {
                            hotel.picture = picture
                        } else {
                            hotel.picture = Asset.photoPlaceholder.image
                        }
                        hotels.append(hotel)
                        dispatchGroup.leave()
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(.success(hotels))
                }
            }
    }

    func getHotelByName(_ name: String,
                        completion: @escaping (Result<Hotel, HotelErrors>) -> Void) {
        hotelsCollection.limit(to: 1).whereField("name", isEqualTo: name)
            .getDocuments { [weak self] (querySnapshot, error) in
                if error != nil {
                    completion(.failure(.errorGettingDocuments))
                    return
                }

                guard let querySnapshot = querySnapshot else {
                    completion(.failure(.noSnapshot))
                    return
                }

                var hotels = [Hotel]()
                for document in querySnapshot.documents {
                    guard
                        let hotel = Hotel(dictionary: document.data()) else {
                        completion(.failure(.cannotCreateFromDictionary))
                        return
                    }
                    hotels.append(hotel)
                }

                guard let hotel = hotels.first else {
                    completion(.failure(.errorGettingDocuments))
                    return
                }

                self?.imageService.loadPictureFrom(hotel.imageUrl) { picture in
                    if let picture = picture {
                        hotel.picture = picture
                    } else {
                        hotel.picture = Asset.photoPlaceholder.image
                    }
                    completion(.success(hotel))
                }
            }
    }

    func saveFavouriteHotel(_ hotel: Hotel,
                            completion: @escaping (HotelErrors?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.currentUser)
            return
        }

        usersCollection.document(user.uid)
            .collection("favouriteHotels").document(String(hotel.id ?? Int()))
            .setData(hotel.dictionary) { error in
                if error != nil {
                    completion(.cannotSave)
                    return
                }
                completion(nil)
            }
    }

    func getFavouriteHotels(completion: @escaping (Result<[Hotel], HotelErrors>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(.currentUser))
            return
        }

        usersCollection.document(user.uid)
            .collection("favouriteHotels").getDocuments { [weak self] (querySnapshot, error) in
                if error != nil {
                    completion(.failure(.errorGettingDocuments))
                    return
                }

                guard let querySnapshot = querySnapshot else {
                    completion(.failure(.noSnapshot))
                    return
                }

                let dispatchGroup = DispatchGroup()

                var hotels = [Hotel]()
                for document in querySnapshot.documents {
                    guard
                        let hotel = Hotel(dictionary: document.data()) else {
                        completion(.failure(.cannotCreateFromDictionary))
                        return
                    }

                    dispatchGroup.enter()

                    self?.imageService.loadPictureFrom(hotel.imageUrl) { picture in
                        if let picture = picture {
                            hotel.picture = picture
                        } else {
                            hotel.picture = Asset.photoPlaceholder.image
                        }
                        hotels.append(hotel)
                        dispatchGroup.leave()
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(.success(hotels))
                }
            }
    }

    func saveAllHotels(_ hotels: [Hotel],
                       completion: @escaping (HotelErrors?) -> Void) {
        let dispatchGroup = DispatchGroup()

        for hotel in hotels {
            dispatchGroup.enter()
            hotelsCollection.document(String(hotel.id ?? Int()))
                .setData(hotel.dictionary) { error in
                    if error != nil {
                        completion(.cannotSave)
                        return
                    }
                    dispatchGroup.leave()
                }
        }

        dispatchGroup.notify(queue: .main) {
            completion(nil)
        }
    }

    func saveFavouriteFlight(_ flight: Flight,
                             completion: @escaping (FlightErrors?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.currentUser)
            return
        }

        usersCollection.document(user.uid)
            .collection("favouriteFlights").document(flight.flightNumber ?? String())
            .setData(flight.dictionary) { error in
                if error != nil {
                    completion(.cannotSave)
                    return
                }
                completion(nil)
            }
    }

    func getFavouriteFlights(completion: @escaping (Result<[Flight], FlightErrors>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(.currentUser))
            return
        }

        usersCollection.document(user.uid)
            .collection("favouriteFlights").getDocuments { [weak self] (querySnapshot, error) in
                if error != nil {
                    completion(.failure(.errorGettingDocuments))
                    return
                }

                guard let querySnapshot = querySnapshot else {
                    completion(.failure(.noSnapshot))
                    return
                }

                let dispatchGroup = DispatchGroup()

                var flights = [Flight]()
                for document in querySnapshot.documents {
                    guard
                        let flight = Flight(dictionary: document.data()) else {
                        completion(.failure(.cannotCreateFromDictionary))
                        return
                    }

                    dispatchGroup.enter()

                    self?.imageService.loadPictureFrom(flight.imageUrl ?? String()) { picture in
                        if let picture = picture {
                            flight.picture = picture
                        } else {
                            flight.picture = Asset.photoPlaceholder.image
                        }
                        flights.append(flight)
                        dispatchGroup.leave()
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(.success(flights))
                }
            }
    }

    func saveOrderedJourney(_ journey: Journey,
                            completion: @escaping (JourneyErrors?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.currentUser)
            return
        }

        usersCollection.document(user.uid)
            .collection("orderedJourneys").document(String(journey.hotel?.id ?? Int()))
            .setData(journey.dictionary) { error in
                if error != nil {
                    completion(.cannotSave)
                    return
                }
                completion(nil)
            }
    }

    func getOrderedJourneys(completion: @escaping (Result<[Journey], JourneyErrors>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(.currentUser))
            return
        }

        usersCollection.document(user.uid)
            .collection("orderedJourneys").getDocuments { [weak self] (querySnapshot, error) in
                if error != nil {
                    completion(.failure(.errorGettingDocuments))
                    return
                }

                guard let querySnapshot = querySnapshot else {
                    completion(.failure(.noSnapshot))
                    return
                }

                let dispatchGroup = DispatchGroup()

                var journeys = [Journey]()
                for document in querySnapshot.documents {
                    guard
                        let journey = Journey(dictionary: document.data()) else {
                        completion(.failure(.cannotCreateFromDictionary))
                        return
                    }

                    dispatchGroup.enter()

                    self?.imageService.loadPictureFrom(journey.hotel?.imageUrl ?? String()) { picture in
                        if let picture = picture {
                            journey.hotel?.picture = picture
                        } else {
                            journey.hotel?.picture = Asset.photoPlaceholder.image
                        }

                        self?.imageService.loadPictureFrom(journey.flight?.imageUrl ?? String()) { picture in
                            if let picture = picture {
                                journey.flight?.picture = picture
                            } else {
                                journey.flight?.picture = Asset.photoPlaceholder.image
                            }

                            journeys.append(journey)
                            dispatchGroup.leave()
                        }
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(.success(journeys))
                }
            }
    }

}
