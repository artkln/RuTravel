//
//  RecommendationsViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class RecommendationsViewTests: XCTestCase {

    // MARK: - Properties

    private var view: RecommendationsViewController?
    private var output: RecommendationsViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = RecommendationsViewController()
        output = RecommendationsViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class RecommendationsViewOutputMock: RecommendationsViewOutput {
    }

}
