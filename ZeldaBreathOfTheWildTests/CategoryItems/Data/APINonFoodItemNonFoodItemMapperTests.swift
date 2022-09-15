//
//  APINonFoodItemNonFoodItemMapperTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 14/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class APINonFoodItemNonFoodItemMapperTests: XCTestCase {
    var sut: APINonFoodItemNonFoodItemMapper!
    var apiItem: APINonFoodItem!
    var actualResult: NonFoodItem!
    
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
    func test_WHEN_map_GIVEN_someAPINonFoodItem_THEN_itShouldMapItem() {
        self.GIVEN_someAPINonFoodItem()
        
        actualResult = sut.map(input: apiItem)
        
        self.THEN_itShouldMapItem()
    }
    
    private func GIVEN_someAPINonFoodItem() {
        apiItem = APINonFoodItemBuilder.build()
    }
    
    private func THEN_itShouldMapItem() {
        XCTAssertEqual(actualResult.category.rawValue, APINonFoodItemBuilder.Constant.someCategory)
        XCTAssertEqual(actualResult.commonLocations, [APINonFoodItemBuilder.Constant.someLocation])
        XCTAssertEqual(actualResult.description, APINonFoodItemBuilder.Constant.someDescription)
        XCTAssertEqual(actualResult.drops, [APINonFoodItemBuilder.Constant.someDrop])
        XCTAssertEqual(actualResult.id, APINonFoodItemBuilder.Constant.someId)
        XCTAssertEqual(actualResult.image, APINonFoodItemBuilder.Constant.someImage)
        XCTAssertEqual(actualResult.name, APINonFoodItemBuilder.Constant.someName)
    }
}
