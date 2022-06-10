//
//  ResultViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 12/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class ResultViewTests: XCTestCase {

    // MARK: - Properties

    private var view: ResultViewController?
    private var output: ResultViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = ResultViewController()
        output = ResultViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class ResultViewOutputMock: ResultViewOutput {
    }

}
