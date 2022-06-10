//
//  FlightPickViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 11/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class FlightPickViewTests: XCTestCase {

    // MARK: - Properties

    private var view: FlightPickViewController?
    private var output: FlightPickViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = FlightPickViewController()
        output = FlightPickViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class FlightPickViewOutputMock: FlightPickViewOutput {
    }

}
