//
//  FlightCellModel.swift
//  RuTravel
//
//  Created by kalinin on 11.05.2022.
//

import Foundation

final class FlightCellModel: InfoCellModel {

    let flight: Flight
    var onSelectButtonPressed: (() -> Void)?
    var onFavouriteButtonPressed: (() -> Void)?
    var onMoreButtonPressed: (() -> Void)?
    let areButtonsHidden: Bool

    var type: InfoCellType {
        return .flight
    }

    init(flight: Flight,
         onSelectButtonPressed: (() -> Void)?,
         onFavouriteButtonPressed: (() -> Void)?,
         onMoreButtonPressed: (() -> Void)?,
         areButtonsHidden: Bool) {
        self.flight = flight
        self.onSelectButtonPressed = onSelectButtonPressed
        self.onFavouriteButtonPressed = onFavouriteButtonPressed
        self.onMoreButtonPressed = onMoreButtonPressed
        self.areButtonsHidden = areButtonsHidden
    }

}
