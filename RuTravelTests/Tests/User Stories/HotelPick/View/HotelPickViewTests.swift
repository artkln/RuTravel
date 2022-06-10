//
//  HotelPickViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 10/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class HotelPickViewTests: XCTestCase {

    // MARK: - Properties

    private var view: HotelPickViewController?
    private var output: HotelPickViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = HotelPickViewController()
        output = HotelPickViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class HotelPickViewOutputMock: HotelPickViewOutput {
    }

}
