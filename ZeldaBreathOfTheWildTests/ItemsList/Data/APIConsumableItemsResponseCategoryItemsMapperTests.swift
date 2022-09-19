//
//  APIConsumableItemsResponseCategoryItemsMapperTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 15/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class APIConsumableItemsResponseCategoryItemsMapperTests: XCTestCase {

    private var sut: DefaultAPIConsumableItemsResponseCategoryItemsMapper!
    
    override func setUp() {
        super.setUp()
        sut = DefaultAPIConsumableItemsResponseCategoryItemsMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - map
    func test_WHEN_map_GIVEN_someAPICategoryItemsResponse_THEN_itShouldReturnACategoryItemsObject() {
        let apiResponse = APIConsumableItemsResponse(data: APIConsumableItemsResponseData(food: [APIFoodItemBuilder.build()], nonFood: [APINonFoodItemBuilder.build()]))
        
        let result = sut.map(input: apiResponse)
        
        XCTAssert(result.food.count > 0)
        XCTAssert(result.nonFood.count > 0)
    }
}
