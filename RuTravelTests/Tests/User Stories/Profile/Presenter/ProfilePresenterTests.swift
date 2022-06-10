//
//  ProfilePresenterTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 03/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class ProfilePresenterTest: XCTestCase {

    // MARK: - Properties

    private var presenter: ProfilePresenter?
    private var view: MockViewController?
    private var output: MockModuleOutput?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        presenter = ProfilePresenter()
        presenter?.router = MockRouter()
        view = MockViewController()
        presenter?.view = view
        output = MockModuleOutput()
        presenter?.output = output
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        view = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class MockRouter: ProfileRouterInput {
    }

    private final class MockViewController: ProfileViewInput {
    }

    private final class MockModuleOutput: ProfileModuleOutput {
    }

}
