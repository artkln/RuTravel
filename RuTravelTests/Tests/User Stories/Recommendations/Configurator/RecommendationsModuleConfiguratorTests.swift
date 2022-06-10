//
//  RecommendationsModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class RecommendationsModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: RecommendationsViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load RecommendationsViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = RecommendationsModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "RecommendationsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is RecommendationsPresenter, "output is not RecommendationsPresenter")

        guard let presenter: RecommendationsPresenter = viewController.output as? RecommendationsPresenter else {
            XCTFail("Cannot assign viewController.output as RecommendationsPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in RecommendationsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in RecommendationsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is RecommendationsRouter, "router is not RecommendationsRouter")

        guard let router: RecommendationsRouter = presenter.router as? RecommendationsRouter else {
            XCTFail("Cannot assign presenter.router as RecommendationsRouter")
            return
        }

        XCTAssertTrue(router.view is RecommendationsViewController, "view in router is not RecommendationsViewController")
    }

}
