//
//  FavouriteFlightsPresenterTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class FavouriteFlightsPresenterTest: XCTestCase {

    // MARK: - Properties

    private var presenter: FavouriteFlightsPresenter?
    private var view: MockViewController?
    private var output: MockModuleOutput?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        presenter = FavouriteFlightsPresenter()
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

    private final class MockRouter: FavouriteFlightsRouterInput {
    }

    private final class MockViewController: FavouriteFlightsViewInput {
    }

    private final class MockModuleOutput: FavouriteFlightsModuleOutput {
    }

}
