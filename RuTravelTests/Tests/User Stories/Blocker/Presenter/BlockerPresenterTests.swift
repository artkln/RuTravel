//
//  BlockerPresenterTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 15/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class BlockerPresenterTest: XCTestCase {

    // MARK: - Properties

    private var presenter: BlockerPresenter?
    private var view: MockViewController?
    private var output: MockModuleOutput?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        presenter = BlockerPresenter()
        presenter?.router = MockRouter()
        view = MockViewController()
        presenter?.view = view
        output = MockModuleOutput()
        presenter?.output = output
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        view = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class MockRouter: BlockerRouterInput {
    }

    private final class MockViewController: BlockerViewInput {
    }

    private final class MockModuleOutput: BlockerModuleOutput {
    }

}
