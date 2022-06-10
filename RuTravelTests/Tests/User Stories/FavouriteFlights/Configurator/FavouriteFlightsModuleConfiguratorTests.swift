//
//  FavouriteFlightsModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class FavouriteFlightsModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: FavouriteFlightsViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load FavouriteFlightsViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = FavouriteFlightsModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "FavouriteFlightsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is FavouriteFlightsPresenter, "output is not FavouriteFlightsPresenter")

        guard let presenter: FavouriteFlightsPresenter = viewController.output as? FavouriteFlightsPresenter else {
            XCTFail("Cannot assign viewController.output as FavouriteFlightsPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in FavouriteFlightsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in FavouriteFlightsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is FavouriteFlightsRouter, "router is not FavouriteFlightsRouter")

        guard let router: FavouriteFlightsRouter = presenter.router as? FavouriteFlightsRouter else {
            XCTFail("Cannot assign presenter.router as FavouriteFlightsRouter")
            return
        }

        XCTAssertTrue(router.view is FavouriteFlightsViewController, "view in router is not FavouriteFlightsViewController")
    }

}
