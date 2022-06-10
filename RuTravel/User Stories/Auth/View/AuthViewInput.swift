//
//  AuthViewInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 13/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol AuthViewInput: AnyObject {

    func configure(with model: AuthModel)
    func showPrompt(title: String, message: String)
    func startActivity(completion: @escaping () -> Void)
    func stopActivity(completion: @escaping () -> Void)

}
