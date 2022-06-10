//
//  RateHotelViewInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol RateHotelViewInput: AnyObject {

    func configure(with model: RateHotelModel)
    func showPrompt(title: String, message: String)
    func startActivity(completion: @escaping () -> Void)
    func stopActivity(completion: @escaping () -> Void)

}
