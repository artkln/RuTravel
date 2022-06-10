//
//  SearchModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class SearchModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: SearchViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load SearchViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = SearchModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "SearchViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SearchPresenter, "output is not SearchPresenter")

        guard let presenter: SearchPresenter = viewController.output as? SearchPresenter else {
            XCTFail("Cannot assign viewController.output as SearchPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in SearchPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SearchPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SearchRouter, "router is not SearchRouter")

        guard let router: SearchRouter = presenter.router as? SearchRouter else {
            XCTFail("Cannot assign presenter.router as SearchRouter")
            return
        }

        XCTAssertTrue(router.view is SearchViewController, "view in router is not SearchViewController")
    }

}
