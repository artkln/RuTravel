//
//  HotelPickViewInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 10/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol HotelPickViewInput: AnyObject {

    func configure(with model: HotelPickModel)
    func showPrompt(title: String, message: String)
    func startActivity(completion: @escaping () -> Void)
    func stopActivity(completion: @escaping () -> Void)

}
