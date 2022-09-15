//
//  CategoryAPICategoryMapperTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 14/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class CategoryAPICategoryMapperTests: XCTestCase {

    func test_WHEN_map_GIVEN_someCategory_THEN_itShouldReturnAnAPICategory() {
        let sut = DefaultCategoryAPICategoryMapper()
        let actualResult = sut.map(input: .creatures)
        let expectedResult = APICategory.creatures
        XCTAssertEqual(actualResult, expectedResult)
    }
}
