//
//  RateHotelViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class RateHotelViewTests: XCTestCase {

    // MARK: - Properties

    private var view: RateHotelViewController?
    private var output: RateHotelViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = RateHotelViewController()
        output = RateHotelViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class RateHotelViewOutputMock: RateHotelViewOutput {
    }

}
