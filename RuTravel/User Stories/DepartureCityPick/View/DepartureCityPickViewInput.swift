//
//  DepartureCityPickViewInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol DepartureCityPickViewInput: AnyObject {

    func configure(with model: DepartureCitiesModel)
    func showPrompt(title: String, message: String)
    func startActivity(completion: @escaping () -> Void)
    func stopActivity(completion: @escaping () -> Void)

}
