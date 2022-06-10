//
//  BlockerModuleConfiguratorTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 15/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class BlockerModuleConfiguratorTests: XCTestCase {

	// MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(name: String(describing: BlockerViewController.self),
                        bundle: Bundle.main).instantiateInitialViewController() == nil {
            XCTFail("Can't load BlockerViewController from storyboard, check that controller is initial view controller")
        }
    }

    func testThatScreenConfiguresCorrectly() {
        // when
        let viewController = BlockerModuleConfigurator().configure()

        // then
        XCTAssertNotNil(viewController.output, "BlockerViewController is nil after configuration")
        XCTAssertTrue(viewController.output is BlockerPresenter, "output is not BlockerPresenter")

        guard let presenter: BlockerPresenter = viewController.output as? BlockerPresenter else {
            XCTFail("Cannot assign viewController.output as BlockerPresenter")
            return
        }

        XCTAssertNotNil(presenter.view, "view in BlockerPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in BlockerPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is BlockerRouter, "router is not BlockerRouter")

        guard let router: BlockerRouter = presenter.router as? BlockerRouter else {
            XCTFail("Cannot assign presenter.router as BlockerRouter")
            return
        }

        XCTAssertTrue(router.view is BlockerViewController, "view in router is not BlockerViewController")
    }

}
