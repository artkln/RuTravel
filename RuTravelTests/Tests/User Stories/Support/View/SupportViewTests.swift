//
//  SupportViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class SupportViewTests: XCTestCase {

    // MARK: - Properties

    private var view: SupportViewController?
    private var output: SupportViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = SupportViewController()
        output = SupportViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class SupportViewOutputMock: SupportViewOutput {
    }

}
