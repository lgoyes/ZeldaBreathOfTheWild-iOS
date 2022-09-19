//
//  ItemDetailsViewModelTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class ItemDetailsViewModelTests: XCTestCase {
    private struct Constant {
        static let name = "any-name"
        static let category = "any-category"
        static let description = "any-description"
        static let location = "any-location"
        static let image = "any-image"
    }
}

// MARK: - shouldShowCommonLocations

extension ItemDetailsViewModelTests {
    func test_WHEN_shouldShowCommonLocations_GIVEN_atLeastOneLocation_THEN_itShouldReturnTrue() {
        let sut = ItemDetailsViewModel(name: Constant.name, category: Constant.category, description: Constant.description, commonLocations: [Constant.location], imageURL: URL(string: Constant.image))
        let result = sut.shouldShowCommonLocations()
        XCTAssert(result)
    }
    
    func test_WHEN_shouldShowCommonLocations_GIVEN_NoLocation_THEN_itShouldReturnFalse() {
        let sut = ItemDetailsViewModel(name: Constant.name, category: Constant.category, description: Constant.description, commonLocations: [], imageURL: URL(string: Constant.image))
        let result = sut.shouldShowCommonLocations()
        XCTAssertFalse(result)
    }
}
