//
//  APIFoodItemFoodItemMapperTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 14/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class APIFoodItemFoodItemMapperTests: XCTestCase {
    var sut: APIFoodItemFoodItemMapper!
    var apiItem: APIFoodItem!
    var actualResult: FoodItem!
    
    override func setUp() {
        super.setUp()
        sut = APIFoodItemFoodItemMapper()
    }

    override func tearDown() {
        sut = nil
        apiItem = nil
        actualResult = nil
        super.tearDown()
    }
}

// MARK: - map

extension APIFoodItemFoodItemMapperTests {
    func test_WHEN_map_GIVEN_someAPIFoodItem_THEN_itShouldMapItem() {
        self.GIVEN_someAPIFoodItem()
        
        actualResult = sut.map(input: apiItem)
        
        self.THEN_itShouldMapItem()
    }
    
    private func GIVEN_someAPIFoodItem() {
        apiItem = APIFoodItemBuilder.build()
    }
    
    private func THEN_itShouldMapItem() {
        XCTAssertEqual(actualResult.category.rawValue, APIFoodItemBuilder.Constant.someCategory)
        XCTAssertEqual(actualResult.commonLocations, [APIFoodItemBuilder.Constant.someLocation])
        XCTAssertEqual(actualResult.cookingEffect, APIFoodItemBuilder.Constant.someCookingEffect)
        XCTAssertEqual(actualResult.description, APIFoodItemBuilder.Constant.someDescription)
        XCTAssertEqual(actualResult.heartsRecovered, APIFoodItemBuilder.Constant.someHeartsRecovered)
        XCTAssertEqual(actualResult.id, APIFoodItemBuilder.Constant.someId)
        XCTAssertEqual(actualResult.image, APIFoodItemBuilder.Constant.someImage)
        XCTAssertEqual(actualResult.name, APIFoodItemBuilder.Constant.someName)
    }
}
