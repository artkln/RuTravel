//
//  FlightPickViewInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 11/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol FlightPickViewInput: AnyObject {

    func configure(with model: FlightPickModel)
    func showPrompt(title: String, message: String)
    func showBlockerScreen()
    func startActivity(completion: @escaping () -> Void)
    func stopActivity(completion: @escaping () -> Void)

}
