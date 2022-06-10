//
//  FavouriteFlightsViewInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol FavouriteFlightsViewInput: AnyObject {

    func configure(with model: FavouriteFlightsModel)
    func showPrompt(title: String, message: String)
    func showBlockerScreen()
    func startActivity(completion: @escaping () -> Void)
    func stopActivity(completion: @escaping () -> Void)

}
