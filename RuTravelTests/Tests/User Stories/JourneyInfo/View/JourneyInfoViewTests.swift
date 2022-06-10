//
//  JourneyInfoViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class JourneyInfoViewTests: XCTestCase {

    // MARK: - Properties

    private var view: JourneyInfoViewController?
    private var output: JourneyInfoViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = JourneyInfoViewController()
        output = JourneyInfoViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class JourneyInfoViewOutputMock: JourneyInfoViewOutput {
    }

}
