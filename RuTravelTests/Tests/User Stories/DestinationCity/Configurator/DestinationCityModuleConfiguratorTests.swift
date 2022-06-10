//
//  DestinationCityModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class DestinationCityModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: DestinationCityViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load DestinationCityViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = DestinationCityModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "DestinationCityViewController is nil after configuration")
        XCTAssertTrue(viewController.output is DestinationCityPresenter, "output is not DestinationCityPresenter")

        guard let presenter: DestinationCityPresenter = viewController.output as? DestinationCityPresenter else {
            XCTFail("Cannot assign viewController.output as DestinationCityPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in DestinationCityPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in DestinationCityPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is DestinationCityRouter, "router is not DestinationCityRouter")

        guard let router: DestinationCityRouter = presenter.router as? DestinationCityRouter else {
            XCTFail("Cannot assign presenter.router as DestinationCityRouter")
            return
        }

        XCTAssertTrue(router.view is DestinationCityViewController, "view in router is not DestinationCityViewController")
    }

}
