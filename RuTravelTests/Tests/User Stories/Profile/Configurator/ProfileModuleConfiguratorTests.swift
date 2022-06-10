//
//  ProfileModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class ProfileModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: ProfileViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load ProfileViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = ProfileModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "ProfileViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ProfilePresenter, "output is not ProfilePresenter")

        guard let presenter: ProfilePresenter = viewController.output as? ProfilePresenter else {
            XCTFail("Cannot assign viewController.output as ProfilePresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in ProfilePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ProfilePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ProfileRouter, "router is not ProfileRouter")

        guard let router: ProfileRouter = presenter.router as? ProfileRouter else {
            XCTFail("Cannot assign presenter.router as ProfileRouter")
            return
        }

        XCTAssertTrue(router.view is ProfileViewController, "view in router is not ProfileViewController")
    }

}
