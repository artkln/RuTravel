//
//  DestinationCityViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class DestinationCityViewTests: XCTestCase {

    // MARK: - Properties

    private var view: DestinationCityViewController?
    private var output: DestinationCityViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = DestinationCityViewController()
        output = DestinationCityViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class DestinationCityViewOutputMock: DestinationCityViewOutput {
    }

}
