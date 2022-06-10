//
//  DestinationCityInfoPresenterTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class DestinationCityInfoPresenterTest: XCTestCase {

    // MARK: - Properties

    private var presenter: DestinationCityInfoPresenter?
    private var view: MockViewController?
    private var output: MockModuleOutput?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        presenter = DestinationCityInfoPresenter()
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

    private final class MockRouter: DestinationCityInfoRouterInput {
    }

    private final class MockViewController: DestinationCityInfoViewInput {
    }

    private final class MockModuleOutput: DestinationCityInfoModuleOutput {
    }

}
