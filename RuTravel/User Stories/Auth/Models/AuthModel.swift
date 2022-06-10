//
//  AuthModel.swift
//  RuTravel
//
//  Created by kalinin on 13.05.2022.
//

import Foundation

struct AuthModel {

    var title: String = {
        return "Добро пожаловать в RuTravel! Пожалуйста, зарегистрируйтесь:"
    }()

    let nameFieldPlaceholder: String = {
        return " Введите имя"
    }()

    let emailFieldPlaceholder: String = {
        return " Введите e-mail"
    }()

    let passwordFieldPlaceholder: String = {
        return " Введите пароль"
    }()

    var alreadyRegisteredTitle: String = {
       return "У Вас уже есть аккаунт?"
    }()

    var lowerButtonTitle: String = {
       return "Зарегистрироваться"
    }()

    var upperButtonTitle: String = {
       return "Войти"
    }()

    var isSignUpNeeded = true {
        willSet {
            if newValue {
                title = "Добро пожаловать в RuTravel! Пожалуйста, зарегистрируйтесь:"
                alreadyRegisteredTitle = "У Вас уже есть аккаунт?"
                upperButtonTitle = "Войти"
                lowerButtonTitle = "Зарегистрироваться"
            } else {
                title = "Войдите в аккаунт:"
                alreadyRegisteredTitle = "Нет аккаунта?"
                upperButtonTitle = "Зарегистрироваться"
                lowerButtonTitle = "Войти"
            }
        }
    }

}
