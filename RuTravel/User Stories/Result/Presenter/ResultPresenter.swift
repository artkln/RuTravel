//
//  ResultPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class ResultPresenter: ResultViewOutput, ResultModuleInput {

    // MARK: - Properties

    weak var view: ResultViewInput?
    var router: ResultRouterInput?
    var output: ResultModuleOutput?

    // MARK: - ResultViewOutput

    func loadData() {
        view?.configure(with: ResultModel())
    }

    func confirmPressed() {
        popToRoot()
    }

    // MARK: - Private Methods

    private func popToRoot() {
        router?.popToRoot()
    }

}
