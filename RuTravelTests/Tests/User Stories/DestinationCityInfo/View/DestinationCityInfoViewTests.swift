//
//  DestinationCityInfoViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 04/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class DestinationCityInfoViewTests: XCTestCase {

    // MARK: - Properties

    private var view: DestinationCityInfoViewController?
    private var output: DestinationCityInfoViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = DestinationCityInfoViewController()
        output = DestinationCityInfoViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class DestinationCityInfoViewOutputMock: DestinationCityInfoViewOutput {
    }

}
