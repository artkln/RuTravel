//
//  HotelPickModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 10/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class HotelPickModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: HotelPickViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load HotelPickViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = HotelPickModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "HotelPickViewController is nil after configuration")
        XCTAssertTrue(viewController.output is HotelPickPresenter, "output is not HotelPickPresenter")

        guard let presenter: HotelPickPresenter = viewController.output as? HotelPickPresenter else {
            XCTFail("Cannot assign viewController.output as HotelPickPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in HotelPickPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in HotelPickPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is HotelPickRouter, "router is not HotelPickRouter")

        guard let router: HotelPickRouter = presenter.router as? HotelPickRouter else {
            XCTFail("Cannot assign presenter.router as HotelPickRouter")
            return
        }

        XCTAssertTrue(router.view is HotelPickViewController, "view in router is not HotelPickViewController")
    }

}
