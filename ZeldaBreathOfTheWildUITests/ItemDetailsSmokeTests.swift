//
//  ItemDetailsSmokeTests.swift
//  ZeldaBreathOfTheWildUITests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest

final class ItemDetailsSmokeTests: XCTestCase {

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

    func test_WHEN_navigatingTowardItemDetails_THEN_itShouldSeeSomeDetails() {
        let creaturesButton = sut.buttons["Creatures"]
        let creaturesButtonExists = creaturesButton.waitForExistence(timeout: 10.0)
        XCTAssertTrue(creaturesButtonExists)
        
        creaturesButton.tap()
        
        let navigationBar = sut.navigationBars["Creatures"]
        let searchBar = navigationBar.searchFields["Search..."]
        let searchBarExists = searchBar.waitForExistence(timeout: 10.0)
        XCTAssert(searchBarExists)
        
        UIPasteboard.general.string = "Sal"
        
        searchBar.tap()
        searchBar.tap()
        sut.menuItems["Paste"].tap()
        
        let salmonEntry = sut.collectionViews.buttons["hearty salmon"]
        let salmonEntryExists = salmonEntry.waitForExistence(timeout: 10.0)
        XCTAssertTrue(salmonEntryExists)
        
        salmonEntry.tap()
        
        let scroll = sut.scrollViews.otherElements
        
        let commonLocationsTitle = scroll.staticTexts["Common Locations"]
        let commonLocationsTitleExists = commonLocationsTitle.waitForExistence(timeout: 10.0)
        XCTAssert(commonLocationsTitleExists)
        
        let commonLocationsBody = scroll.staticTexts["TABANTHA FRONTIER, HEBRA MOUNTAINS"]
        let commonLocationsBodyExists = commonLocationsBody.waitForExistence(timeout: 10.0)
        XCTAssert(commonLocationsBodyExists)
    }
}
