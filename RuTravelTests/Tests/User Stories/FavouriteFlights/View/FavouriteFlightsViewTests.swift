//
//  FavouriteFlightsViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class FavouriteFlightsViewTests: XCTestCase {

    // MARK: - Properties

    private var view: FavouriteFlightsViewController?
    private var output: FavouriteFlightsViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = FavouriteFlightsViewController()
        output = FavouriteFlightsViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class FavouriteFlightsViewOutputMock: FavouriteFlightsViewOutput {
    }

}
