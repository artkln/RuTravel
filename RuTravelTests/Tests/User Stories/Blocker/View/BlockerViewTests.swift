//
//  BlockerViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 15/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class BlockerViewTests: XCTestCase {

    // MARK: - Properties

    private var view: BlockerViewController?
    private var output: BlockerViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = BlockerViewController()
        output = BlockerViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class BlockerViewOutputMock: BlockerViewOutput {
    }

}
