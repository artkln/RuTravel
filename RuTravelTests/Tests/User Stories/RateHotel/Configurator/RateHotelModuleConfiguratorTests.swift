//
//  RateHotelModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class RateHotelModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: RateHotelViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load RateHotelViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = RateHotelModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "RateHotelViewController is nil after configuration")
        XCTAssertTrue(viewController.output is RateHotelPresenter, "output is not RateHotelPresenter")

        guard let presenter: RateHotelPresenter = viewController.output as? RateHotelPresenter else {
            XCTFail("Cannot assign viewController.output as RateHotelPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in RateHotelPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in RateHotelPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is RateHotelRouter, "router is not RateHotelRouter")

        guard let router: RateHotelRouter = presenter.router as? RateHotelRouter else {
            XCTFail("Cannot assign presenter.router as RateHotelRouter")
            return
        }

        XCTAssertTrue(router.view is RateHotelViewController, "view in router is not RateHotelViewController")
    }

}
