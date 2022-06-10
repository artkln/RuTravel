//
//  HotelCellModel.swift
//  RuTravel
//
//  Created by kalinin on 10.05.2022.
//

import Foundation

final class HotelCellModel: InfoCellModel {

    let hotel: Hotel
    var onSelectButtonPressed: (() -> Void)?
    var onRateButtonPressed: (() -> Void)?
    var onFavouriteButtonPressed: (() -> Void)?
    var onMoreButtonPressed: (() -> Void)?
    let needOnlyRateButton: Bool
    let areButtonsHidden: Bool

    var type: InfoCellType {
        return .hotel
    }

    init(hotel: Hotel,
         onSelectButtonPressed: (() -> Void)?,
         onRateButtonPressed: (() -> Void)?,
         onFavouriteButtonPressed: (() -> Void)?,
         onMoreButtonPressed: (() -> Void)?,
         needOnlyRateButton: Bool,
         areButtonsHidden: Bool) {
        self.hotel = hotel
        self.onSelectButtonPressed = onSelectButtonPressed
        self.onRateButtonPressed = onRateButtonPressed
        self.onFavouriteButtonPressed = onFavouriteButtonPressed
        self.onMoreButtonPressed = onMoreButtonPressed
        self.needOnlyRateButton = needOnlyRateButton
        self.areButtonsHidden = areButtonsHidden
    }

}
