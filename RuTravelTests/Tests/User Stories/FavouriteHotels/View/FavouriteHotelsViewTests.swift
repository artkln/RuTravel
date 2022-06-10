//
//  FavouriteHotelsViewTests.swift
//  RuTravel
//
//  Created by Artem Kalinin on 22/05/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RuTravel

final class FavouriteHotelsViewTests: XCTestCase {

    // MARK: - Properties

    private var view: FavouriteHotelsViewController?
    private var output: FavouriteHotelsViewOutputMock?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        view = FavouriteHotelsViewController()
        output = FavouriteHotelsViewOutputMock()
        view?.output = output
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        output = nil
    }

    // MARK: - Main tests

    // MARK: - Mocks

    private final class FavouriteHotelsViewOutputMock: FavouriteHotelsViewOutput {
    }

}
