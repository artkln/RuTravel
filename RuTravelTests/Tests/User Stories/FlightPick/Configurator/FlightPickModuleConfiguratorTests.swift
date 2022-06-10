//
//  FlightPickModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 11/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class FlightPickModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: FlightPickViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load FlightPickViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = FlightPickModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "FlightPickViewController is nil after configuration")
        XCTAssertTrue(viewController.output is FlightPickPresenter, "output is not FlightPickPresenter")

        guard let presenter: FlightPickPresenter = viewController.output as? FlightPickPresenter else {
            XCTFail("Cannot assign viewController.output as FlightPickPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in FlightPickPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in FlightPickPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is FlightPickRouter, "router is not FlightPickRouter")

        guard let router: FlightPickRouter = presenter.router as? FlightPickRouter else {
            XCTFail("Cannot assign presenter.router as FlightPickRouter")
            return
        }

        XCTAssertTrue(router.view is FlightPickViewController, "view in router is not FlightPickViewController")
    }

}
