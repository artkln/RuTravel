//
//  ResultViewInput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol ResultViewInput: AnyObject {

    func configure(with model: ResultModel)
    func showPrompt(title: String, message: String)

}
