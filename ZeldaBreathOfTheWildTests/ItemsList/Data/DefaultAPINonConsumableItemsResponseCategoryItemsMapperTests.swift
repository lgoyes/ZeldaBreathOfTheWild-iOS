//
//  DefaultAPINonConsumableItemsResponseCategoryItemsMapperTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class DefaultAPINonConsumableItemsResponseCategoryItemsMapperTests: XCTestCase {
    
    private var sut: DefaultAPINonConsumableItemsResponseCategoryItemsMapper!

    override func setUp() {
        super.setUp()
        sut = DefaultAPINonConsumableItemsResponseCategoryItemsMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

extension DefaultAPINonConsumableItemsResponseCategoryItemsMapperTests {
    func test_WHEN_map_THEN_itShouldMapEachItem() {
        let apiResponse = APINonConsumableItemsResponse(data: [APINonFoodItemBuilder.build()])
        let mappedResponse = sut.map(input: apiResponse)
        XCTAssert(mappedResponse.food.isEmpty)
        XCTAssertEqual(mappedResponse.nonFood.count, 1) 
    }
}
