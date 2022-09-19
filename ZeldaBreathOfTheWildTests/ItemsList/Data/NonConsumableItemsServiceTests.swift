//
//  NonConsumableItemsServiceTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class NonConsumableItemsServiceTests: XCTestCase {
    
    private var sut: NonConsumableItemsService!
    private var webClient: FakeWebClient!
    private var networkRouter: FakeNetworkRouter!
    
    override func setUp() {
        super.setUp()
        webClient = FakeWebClient()
        networkRouter = FakeNetworkRouter()
        networkRouter.url = URL(string: "any-url")
        self.sut = NonConsumableItemsService(
            apiNonConsumableItemsResponseCategoryItemsMapper: DefaultAPINonConsumableItemsResponseCategoryItemsMapper(),
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

extension NonConsumableItemsServiceTests {
    func test_WHEN_getItems_GIVEN_someCategory_givenTheBackendWorkedProperlyAndHadNoError_THEN_itShouldFetchSomeItems() {
        let expectation = XCTestExpectation()
        
        let apiResponse = APINonConsumableItemsResponse(data: [])
        webClient.result = apiResponse
        
        Task {
            do {
                _ = try await self.sut.getItems(for: .equipment)
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
                _ = try await sut.getItems(for: .equipment)
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
                _ = try await sut.getItems(for: .equipment)
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

extension NonConsumableItemsServiceTests {
    func test_WHEN_canProcess_GIVEN_someNONConsumableCategoryLikeEquipment_THEN_itShouldReturnTrue() {
        let result = sut.canProcess(category: .equipment)
        XCTAssert(result)
    }
    
    func test_WHEN_canProcess_GIVEN_someConsumableCategoryLikeCreatures_THEN_itShouldReturnFalse() {
        let result = sut.canProcess(category: .creatures)
        XCTAssertFalse(result)
    }
}

// MARK: - getValidCategories

extension NonConsumableItemsServiceTests {
    func test_WHEN_getValidCategories_THEN_itShouldReturnNonConsumableCategoriesSuchAsEquipmentMonstersTreasureAndMaterials() {
        let validCategories = sut.getValidCategories()
        
        let expectedValidCategories : [ZeldaBreathOfTheWild.Category] = [.equipment, .monsters, .treasure, .materials]
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

