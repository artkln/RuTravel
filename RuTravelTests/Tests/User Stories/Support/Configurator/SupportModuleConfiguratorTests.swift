//
//  SupportModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class SupportModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: SupportViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load SupportViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = SupportModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "SupportViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SupportPresenter, "output is not SupportPresenter")

        guard let presenter: SupportPresenter = viewController.output as? SupportPresenter else {
            XCTFail("Cannot assign viewController.output as SupportPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in SupportPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SupportPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SupportRouter, "router is not SupportRouter")

        guard let router: SupportRouter = presenter.router as? SupportRouter else {
            XCTFail("Cannot assign presenter.router as SupportRouter")
            return
        }

        XCTAssertTrue(router.view is SupportViewController, "view in router is not SupportViewController")
    }

}
