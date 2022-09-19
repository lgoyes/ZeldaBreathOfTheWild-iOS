//
//  ItemListNextViewBuilderTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class ItemListNextViewBuilderTests: XCTestCase {
    private struct Constant {
        static let name = "any-name"
        static let category = ZeldaBreathOfTheWild.Category.materials
        static let description = "any-description"
        static let location = "any-location"
        static let image = "any-image"
    }

    private var sut: ItemListNextViewBuilder!
    private var useCase: FakeGetCategoryTitleUseCase!
    
    override func setUp() {
        super.setUp()
        useCase = FakeGetCategoryTitleUseCase()
        sut = ItemListNextViewBuilder(getCategoryTitleUseCase: useCase)
    }

    override func tearDown() {
        sut = nil
        useCase = nil
        super.tearDown()
    }
}

extension ItemListNextViewBuilderTests {
    func test_WHEN_build_THEN_itShouldReturnAItemDetailsView() {
        let result = sut.build(name: Constant.name,
                  category: Constant.category,
                  description: Constant.description,
                  commonLocations: [Constant.location],
                  imageURL: URL(string: Constant.image))
    }
}
