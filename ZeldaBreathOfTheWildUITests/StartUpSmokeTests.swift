//
//  StartUpSmokeTests.swift
//  ZeldaBreathOfTheWildUITests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest

final class StartUpSmokeTests: XCTestCase {

    private var sut: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        sut = XCUIApplication()
        sut.launch()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_WHEN_startUp_THEN_itShouldShowCategoryList() {
        let creaturesButton = sut.buttons["Creatures"]
        let exists = creaturesButton.waitForExistence(timeout: 10.0)
        XCTAssertTrue(exists)
    }
}
