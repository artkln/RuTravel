//
//  ResultModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class ResultModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: ResultViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load ResultViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = ResultModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "ResultViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ResultPresenter, "output is not ResultPresenter")

        guard let presenter: ResultPresenter = viewController.output as? ResultPresenter else {
            XCTFail("Cannot assign viewController.output as ResultPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in ResultPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ResultPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ResultRouter, "router is not ResultRouter")

        guard let router: ResultRouter = presenter.router as? ResultRouter else {
            XCTFail("Cannot assign presenter.router as ResultRouter")
            return
        }

        XCTAssertTrue(router.view is ResultViewController, "view in router is not ResultViewController")
    }

}
