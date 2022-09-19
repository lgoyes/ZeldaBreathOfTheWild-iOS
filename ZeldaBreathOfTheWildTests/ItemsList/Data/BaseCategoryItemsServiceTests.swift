//
//  BaseCategoryItemsServiceTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class BaseCategoryItemsServiceTests: XCTestCase {

    private var sut: BaseCategoryItemsService<APIConsumableItemsResponse>!
    
    override func setUp() {
        super.setUp()
        let webClient = FakeWebClient()
        let networkRouter = FakeNetworkRouter()
        sut = BaseCategoryItemsService<APIConsumableItemsResponse>(webClient: webClient, networkRouter: networkRouter)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - map

extension BaseCategoryItemsServiceTests {
    func test_WHEN_map_THEN_itShouldFatallyFail() {
        let apiResponse = APIConsumableItemsResponse(data: APIConsumableItemsResponseData(food: [], nonFood: []))
        
        expectFatalError(expectedMessage: CommonConstant.ErrorMessage.abstractMethod) {
            
            _ = self.sut.map(apiResponse: apiResponse)
        }
    }
}


// MARK: - getValidCategories

extension BaseCategoryItemsServiceTests {
    func test_WHEN_getValidCategories_THEN_itShouldFatallyFail() {
        expectFatalError(expectedMessage: CommonConstant.ErrorMessage.abstractMethod) {
            
            _ = self.sut.getValidCategories()
        }
    }
}
