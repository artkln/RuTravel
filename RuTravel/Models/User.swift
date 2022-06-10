//
//  User.swift
//  RuTravel
//
//  Created by kalinin on 15.05.2022.
//

import Foundation

struct User {

    var name: String
    var email: String
    var searchedJourney: Journey
    var recommendedJourney: Journey

    var dictionary: [String: Any] {
        return [
            "name": name,
            "email": email,
            "searchedJourney": searchedJourney.dictionary,
            "recommendedJourney": recommendedJourney.dictionary
        ]
    }

    init() {
        name = String()
        email = String()
        searchedJourney = Journey()
        recommendedJourney = Journey()
    }

    init?(dictionary: [String: Any]) {
        guard
            let name = dictionary["name"] as? String,
            let email = dictionary["email"] as? String,
            let searchedJourneyDict = dictionary["searchedJourney"] as? [String: Any],
            let searchedJourney = Journey(dictionary: searchedJourneyDict),
            let recommendedJourneyDict = dictionary["recommendedJourney"] as? [String: Any],
            let recommendedJourney = Journey(dictionary: recommendedJourneyDict) else {
            return nil
        }

        self.name = name
        self.email = email
        self.searchedJourney = searchedJourney
        self.recommendedJourney = recommendedJourney
    }

}
