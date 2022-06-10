//
//  JourneyInfoPresenterTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class JourneyInfoPresenterTest: XCTestCase {

    // MARK: - Properties

    private var presenter: JourneyInfoPresenter?
    private var view: MockViewController?
    private var output: MockModuleOutput?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        presenter = JourneyInfoPresenter()
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

    private final class MockRouter: JourneyInfoRouterInput {
    }

    private final class MockViewController: JourneyInfoViewInput {
    }

    private final class MockModuleOutput: JourneyInfoModuleOutput {
    }

}
