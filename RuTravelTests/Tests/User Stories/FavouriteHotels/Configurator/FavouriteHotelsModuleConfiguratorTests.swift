//
//  FavouriteHotelsModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class FavouriteHotelsModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: FavouriteHotelsViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load FavouriteHotelsViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = FavouriteHotelsModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "FavouriteHotelsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is FavouriteHotelsPresenter, "output is not FavouriteHotelsPresenter")

        guard let presenter: FavouriteHotelsPresenter = viewController.output as? FavouriteHotelsPresenter else {
            XCTFail("Cannot assign viewController.output as FavouriteHotelsPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in FavouriteHotelsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in FavouriteHotelsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is FavouriteHotelsRouter, "router is not FavouriteHotelsRouter")

        guard let router: FavouriteHotelsRouter = presenter.router as? FavouriteHotelsRouter else {
            XCTFail("Cannot assign presenter.router as FavouriteHotelsRouter")
            return
        }

        XCTAssertTrue(router.view is FavouriteHotelsViewController, "view in router is not FavouriteHotelsViewController")
    }

}
