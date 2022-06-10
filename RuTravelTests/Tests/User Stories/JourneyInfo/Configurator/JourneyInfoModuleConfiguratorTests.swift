//
//  JourneyInfoModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class JourneyInfoModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: JourneyInfoViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load JourneyInfoViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = JourneyInfoModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "JourneyInfoViewController is nil after configuration")
        XCTAssertTrue(viewController.output is JourneyInfoPresenter, "output is not JourneyInfoPresenter")

        guard let presenter: JourneyInfoPresenter = viewController.output as? JourneyInfoPresenter else {
            XCTFail("Cannot assign viewController.output as JourneyInfoPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in JourneyInfoPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in JourneyInfoPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is JourneyInfoRouter, "router is not JourneyInfoRouter")

        guard let router: JourneyInfoRouter = presenter.router as? JourneyInfoRouter else {
            XCTFail("Cannot assign presenter.router as JourneyInfoRouter")
            return
        }

        XCTAssertTrue(router.view is JourneyInfoViewController, "view in router is not JourneyInfoViewController")
    }

}
