//
//  DestinationCityInfoModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class DestinationCityInfoModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: DestinationCityInfoViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load DestinationCityInfoViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = DestinationCityInfoModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "DestinationCityInfoViewController is nil after configuration")
        XCTAssertTrue(viewController.output is DestinationCityInfoPresenter, "output is not DestinationCityInfoPresenter")

        guard let presenter: DestinationCityInfoPresenter = viewController.output as? DestinationCityInfoPresenter else {
            XCTFail("Cannot assign viewController.output as DestinationCityInfoPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in DestinationCityInfoPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in DestinationCityInfoPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is DestinationCityInfoRouter, "router is not DestinationCityInfoRouter")

        guard let router: DestinationCityInfoRouter = presenter.router as? DestinationCityInfoRouter else {
            XCTFail("Cannot assign presenter.router as DestinationCityInfoRouter")
            return
        }

        XCTAssertTrue(router.view is DestinationCityInfoViewController, "view in router is not DestinationCityInfoViewController")
    }

}
