//
//  APINonFoodItemNonFoodItemMapperTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 14/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class APINonFoodItemNonFoodItemMapperTests: XCTestCase {
    private var sut: APINonFoodItemNonFoodItemMapper!
    private var apiItem: APINonFoodItem!
    private var actualResult: NonFoodItem!
    
    override func setUp() {
        super.setUp()
        sut = APINonFoodItemNonFoodItemMapper()
    }

    override func tearDown() {
        sut = nil
        apiItem = nil
        actualResult = nil
        super.tearDown()
    }
}

// MARK: - map

extension APINonFoodItemNonFoodItemMapperTests {
    func test_WHEN_map_GIVEN_someAPINonFoodItemWithCommonLocationsAndDrops_THEN_itShouldMapItemAsIs() {
        self.GIVEN_someAPINonFoodItem()
        
        actualResult = sut.map(input: apiItem)
        
        self.THEN_itShouldMapItemAsIs()
    }
    
    private func GIVEN_someAPINonFoodItem() {
        apiItem = APINonFoodItemBuilder.build()
    }
    
    private func THEN_itShouldMapItemAsIs() {
        XCTAssertEqual(actualResult.category.rawValue, APINonFoodItemBuilder.Constant.someCategory)
        XCTAssertEqual(actualResult.commonLocations, [APINonFoodItemBuilder.Constant.someLocation])
        XCTAssertEqual(actualResult.description, APINonFoodItemBuilder.Constant.someDescription)
        XCTAssertEqual(actualResult.drops, [APINonFoodItemBuilder.Constant.someDrop])
        XCTAssertEqual(actualResult.id, APINonFoodItemBuilder.Constant.someId)
        XCTAssertEqual(actualResult.image, URL(string: APINonFoodItemBuilder.Constant.someImage))
        XCTAssertEqual(actualResult.name, APINonFoodItemBuilder.Constant.someName)
    }
    
    func test_WHEN_map_GIVEN_someAPINonFoodItemWITHOUTCommonLocationsAndDrops_THEN_itShouldMapItem() {
        self.GIVEN_someAPINonFoodItemWithoutCommonLocationsAndDrops()
        
        actualResult = sut.map(input: apiItem)
        
        self.THEN_itShouldMapItemWithEmptyArraysWhereMissing()
    }
    
    private func GIVEN_someAPINonFoodItemWithoutCommonLocationsAndDrops() {
        apiItem = APINonFoodItemBuilder.buildWithoutCommonLocationsAndDrops()
    }
    
    private func THEN_itShouldMapItemWithEmptyArraysWhereMissing() {
        XCTAssertEqual(actualResult.category.rawValue, APINonFoodItemBuilder.Constant.someCategory)
        XCTAssertEqual(actualResult.commonLocations, [])
        XCTAssertEqual(actualResult.description, APINonFoodItemBuilder.Constant.someDescription)
        XCTAssertEqual(actualResult.drops, [])
        XCTAssertEqual(actualResult.id, APINonFoodItemBuilder.Constant.someId)
        XCTAssertEqual(actualResult.image, URL(string: APINonFoodItemBuilder.Constant.someImage))
        XCTAssertEqual(actualResult.name, APINonFoodItemBuilder.Constant.someName)
    }
}
