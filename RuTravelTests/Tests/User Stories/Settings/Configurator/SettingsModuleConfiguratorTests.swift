//
//  SettingsModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 14/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class SettingsModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: SettingsViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load SettingsViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = SettingsModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "SettingsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SettingsPresenter, "output is not SettingsPresenter")

        guard let presenter: SettingsPresenter = viewController.output as? SettingsPresenter else {
            XCTFail("Cannot assign viewController.output as SettingsPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in SettingsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SettingsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SettingsRouter, "router is not SettingsRouter")

        guard let router: SettingsRouter = presenter.router as? SettingsRouter else {
            XCTFail("Cannot assign presenter.router as SettingsRouter")
            return
        }

        XCTAssertTrue(router.view is SettingsViewController, "view in router is not SettingsViewController")
    }

}
