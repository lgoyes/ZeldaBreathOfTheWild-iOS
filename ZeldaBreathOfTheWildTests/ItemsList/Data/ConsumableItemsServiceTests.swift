//
//  ConsumableItemsServiceTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 13/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class ConsumableItemsServiceTests: XCTestCase {
    
    private var sut: ConsumableItemsService!
    private var webClient: FakeWebClient!
    private var networkRouter: FakeNetworkRouter!
    
    override func setUp() {
        super.setUp()
        webClient = FakeWebClient()
        networkRouter = FakeNetworkRouter()
        networkRouter.url = URL(string: "any-url")
        self.sut = ConsumableItemsService(
            apiConsumableItemsResponseCategoryItemsMapper: DefaultAPIConsumableItemsResponseCategoryItemsMapper(),
            webClient: webClient,
            networkRouter: networkRouter)
    }
    
    override func tearDown() {
        webClient = nil
        networkRouter = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: - getItems

extension ConsumableItemsServiceTests {
    func test_WHEN_getItems_GIVEN_someCategory_givenTheBackendWorkedProperlyAndHadNoError_THEN_itShouldFetchSomeItems() {
        let expectation = XCTestExpectation()
        
        let apiResponse = APIConsumableItemsResponse(data: APIConsumableItemsResponseData(food: [APIFoodItemBuilder.build()], nonFood: [APINonFoodItemBuilder.build()]))
        webClient.result = apiResponse
        
        Task {
            do {
                _ = try await self.sut.getItems(for: .creatures)
            } catch {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_WHEN_getItems_GIVEN_someCategory_givenTheBackendHadSomeErrorLikeInvalidRequest_THEN_itShouldExecuteTheOnErrorCallback() {
        let expectation = XCTestExpectation()
        
        webClient.error = .invalidRequest
        
        Task {
            do {
                _ = try await sut.getItems(for: .creatures)
                XCTFail()
            } catch {
                // This patch is correct
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_WHEN_getItems_GIVEN_someCategory_givenTheBackendHadSomeErrorLikeErrorDecodingData_THEN_itShouldExecuteTheOnErrorCallback() {
        let expectation = XCTestExpectation()
        
        webClient.error = .errorDecodingData
        
        Task {
            do {
                _ = try await sut.getItems(for: .creatures)
                XCTFail()
            } catch {
                // This patch is correct
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
}

// MARK: - canProcess

extension ConsumableItemsServiceTests {
    func test_WHEN_canProcess_GIVEN_someConsumableCategoryLikeCreatures_THEN_itShouldReturnTrue() {
        let result = sut.canProcess(category: .creatures)
        XCTAssert(result)
    }
    
    func test_WHEN_canProcess_GIVEN_someNONConsumableCategoryLikeTreasures_THEN_itShouldReturnFalse() {
        let result = sut.canProcess(category: .treasure)
        XCTAssertFalse(result)
    }
}

// MARK: - getValidCategories

extension ConsumableItemsServiceTests {
    func test_WHEN_getValidCategories_THEN_itShouldReturnOnlyCreatures() {
        let validCategories = sut.getValidCategories()
        
        let expectedValidCategories : [ZeldaBreathOfTheWild.Category] = [.creatures]
        var allValidCategoriesAreIncluded = true
        for expectedValidCategory in expectedValidCategories {
            if !validCategories.contains(expectedValidCategory) {
                allValidCategoriesAreIncluded = false
                break
            }
        }
        XCTAssertTrue(allValidCategoriesAreIncluded)
        XCTAssertEqual(expectedValidCategories.count, validCategories.count)
    }
}

