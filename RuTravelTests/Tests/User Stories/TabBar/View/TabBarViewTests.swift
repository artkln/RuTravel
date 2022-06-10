//
//  TabBarViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class TabBarViewTests: XCTestCase {

    // MARK: - Properties

    private var view: TabBarViewController?
    private var output: TabBarViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = TabBarViewController()
        output = TabBarViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class TabBarViewOutputMock: TabBarViewOutput {
    }

}
