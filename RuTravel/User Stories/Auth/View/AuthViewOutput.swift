//
//  AuthViewOutput.swift
//  RuTravel
//
//  Created by Artem Kalinin on 13/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth

protocol AuthViewOutput {

    func loadData()
    func upperPressed()
    func lowerPressed(name: String, email: String, password: String)

}
