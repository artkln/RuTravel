//
//  SupportPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class SupportPresenter: SupportViewOutput, SupportModuleInput {

    // MARK: - Properties

    weak var view: SupportViewInput?
    var router: SupportRouterInput?
    var output: SupportModuleOutput?

    // MARK: - SupportViewOutput

    func loadData() {
        view?.configure(with: SupportModel())
    }

}
