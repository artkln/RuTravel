//
//  OrderedJourneysModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class OrderedJourneysModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: OrderedJourneysViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load OrderedJourneysViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = OrderedJourneysModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "OrderedJourneysViewController is nil after configuration")
        XCTAssertTrue(viewController.output is OrderedJourneysPresenter, "output is not OrderedJourneysPresenter")

        guard let presenter: OrderedJourneysPresenter = viewController.output as? OrderedJourneysPresenter else {
            XCTFail("Cannot assign viewController.output as OrderedJourneysPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in OrderedJourneysPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in OrderedJourneysPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is OrderedJourneysRouter, "router is not OrderedJourneysRouter")

        guard let router: OrderedJourneysRouter = presenter.router as? OrderedJourneysRouter else {
            XCTFail("Cannot assign presenter.router as OrderedJourneysRouter")
            return
        }

        XCTAssertTrue(router.view is OrderedJourneysViewController, "view in router is not OrderedJourneysViewController")
    }

}
