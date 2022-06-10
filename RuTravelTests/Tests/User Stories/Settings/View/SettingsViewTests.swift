//
//  SettingsViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 14/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class SettingsViewTests: XCTestCase {

    // MARK: - Properties

    private var view: SettingsViewController?
    private var output: SettingsViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = SettingsViewController()
        output = SettingsViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class SettingsViewOutputMock: SettingsViewOutput {
    }

}
