//
//  DestinationCityInfoViewInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol DestinationCityInfoViewInput: AnyObject {

    func configure(with model: DestinationCityInfoModel)
    func showPrompt(title: String, message: String)
    func startActivity(completion: @escaping () -> Void)
    func stopActivity(completion: @escaping () -> Void)

}
