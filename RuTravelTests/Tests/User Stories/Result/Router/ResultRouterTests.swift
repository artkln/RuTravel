//
//  ResultRouterTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class ResultRouterTests: XCTestCase {

	// MARK: - Properties

    private var view: MockModuleTransitionable?
    private var router: ResultRouter?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        router = ResultRouter()
        view = MockModuleTransitionable()
        router?.view = view
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        router = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class MockModuleTransitionable: ModuleTransitionable {

        func showModule(_ module: UIViewController) {
        }

        func dismissView(animated: Bool, completion: (() -> Void)?) {
        }

        func presentModule(_ module: UIViewController, animated: Bool, completion: (() -> Void)?) {
        }

        func pop(animated: Bool) {
        }

        func popToRoot(animated: Bool) {
        }

        func push(module: UIViewController, animated: Bool) {
        }

        func push(module: UIViewController, animated: Bool, hideTabBar: Bool) {
        }

    }

}
