//
//  AuthViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 13/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class AuthViewTests: XCTestCase {

    // MARK: - Properties

    private var view: AuthViewController?
    private var output: AuthViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = AuthViewController()
        output = AuthViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class AuthViewOutputMock: AuthViewOutput {
    }

}
