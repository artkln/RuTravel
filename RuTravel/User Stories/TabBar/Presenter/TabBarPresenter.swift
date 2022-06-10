//
//  TabBarPresenter.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

final class TabBarPresenter: TabBarModuleInput, TabBarViewOutput {

    // MARK: - Nested Types

    enum Controllers: CaseIterable {
        case search
        case recommendations
        case profile

        enum Constants {
            static let searchTabIconName: String = "magnifyingglass"
            static let recommendationsTabIconName: String = "rectangle.fill.on.rectangle.fill"
            static let profileTabIconName: String = "person.fill"
            static let searchTabTitle: String = "Поиск"
            static let recommendationsTabTitle: String = "Рекоммендации"
            static let profileTabTitle: String = "Профиль"
        }
    }

    // MARK: - Properties

    weak var view: TabBarViewInput?
    var router: TabBarRouterInput?
    var output: TabBarModuleOutput?

    private var handle: AuthStateDidChangeListenerHandle?

    // MARK: - TabBarViewOutput

    func tabBarWillAppear() {
       handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
           if user == nil {
               self?.presentAuthModule()
           }
       }

        guard Auth.auth().currentUser != nil else {
            return
        }

        let controllers = Controllers.allCases.map(setupController(_:))
        view?.configureControllers(controllers)
    }

    func tabBarWillDisappear() {
        guard let handle = handle else {
            return
        }

        Auth.auth().removeStateDidChangeListener(handle)
    }

}

// MARK: - Controllers

private extension TabBarPresenter.Controllers {

    var icon: UIImage {
        switch self {
        case .search:
            return UIImage(systemName: Constants.searchTabIconName) ?? UIImage()
        case .recommendations:
            return UIImage(systemName: Constants.recommendationsTabIconName) ?? UIImage()
        case .profile:
            return UIImage(systemName: Constants.profileTabIconName) ?? UIImage()
        }
    }

    var title: String {
        switch self {
        case .search:
            return Constants.searchTabTitle
        case .recommendations:
            return Constants.recommendationsTabTitle
        case .profile:
            return Constants.profileTabTitle
        }
    }

    var configurator: ConfigurableFromTabBar.Type {
        switch self {
        case .search:
            return DestinationCityPickModuleConfigurator.self
        case .recommendations:
            return RecommendationsModuleConfigurator.self
        case .profile:
            return ProfileModuleConfigurator.self
        }
    }

}

// MARK: - Private methods

private extension TabBarPresenter {

    func setupController(_ controller: Controllers) -> UIViewController {
        let configuredController = controller.configurator.configure()

        configuredController.tabBarItem.image = controller.icon
        configuredController.tabBarItem.title = controller.title

        return configuredController
    }

    func presentAuthModule() {
        router?.presentAuthModule()
    }

}
