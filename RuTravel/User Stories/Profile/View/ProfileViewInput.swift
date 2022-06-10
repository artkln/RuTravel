//
//  ProfileViewInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol ProfileViewInput: AnyObject {

    func configure(with model: ProfileModel)
    func showPrompt(title: String, message: String)

}
