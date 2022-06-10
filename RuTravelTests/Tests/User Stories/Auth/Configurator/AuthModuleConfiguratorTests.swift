//
//  AuthModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 13/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class AuthModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: AuthViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load AuthViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = AuthModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "AuthViewController is nil after configuration")
        XCTAssertTrue(viewController.output is AuthPresenter, "output is not AuthPresenter")

        guard let presenter: AuthPresenter = viewController.output as? AuthPresenter else {
            XCTFail("Cannot assign viewController.output as AuthPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in AuthPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in AuthPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is AuthRouter, "router is not AuthRouter")

        guard let router: AuthRouter = presenter.router as? AuthRouter else {
            XCTFail("Cannot assign presenter.router as AuthRouter")
            return
        }

        XCTAssertTrue(router.view is AuthViewController, "view in router is not AuthViewController")
    }

}
