//
//  TabBarModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class TabBarModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: TabBarViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load TabBarViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = TabBarModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "TabBarViewController is nil after configuration")
        XCTAssertTrue(viewController.output is TabBarPresenter, "output is not TabBarPresenter")

        guard let presenter: TabBarPresenter = viewController.output as? TabBarPresenter else {
            XCTFail("Cannot assign viewController.output as TabBarPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in TabBarPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in TabBarPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is TabBarRouter, "router is not TabBarRouter")

        guard let router: TabBarRouter = presenter.router as? TabBarRouter else {
            XCTFail("Cannot assign presenter.router as TabBarRouter")
            return
        }

        XCTAssertTrue(router.view is TabBarViewController, "view in router is not TabBarViewController")
    }

}
