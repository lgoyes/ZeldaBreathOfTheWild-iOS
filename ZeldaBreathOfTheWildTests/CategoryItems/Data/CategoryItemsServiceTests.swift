//
//  CategoryItemsServiceTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 13/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class CategoryItemsServiceTests: XCTestCase {
    var sut: DefaultCategoryItemsService!
    var webClient: FakeWebClient!
    
    override func setUp() {
        super.setUp()
        webClient = FakeWebClient()
        self.sut = DefaultCategoryItemsService(
            webClient: webClient,
            categoryAPICategoryMapper: DefaultCategoryAPICategoryMapper(),
            apiCategoryItemsResponseCategoryItemsMapper: DefaultAPICategoryItemsResponseCategoryItemsMapper())
    }

    override func tearDown() {
        webClient = nil
        self.sut = nil
        super.tearDown()
    }
}

// MARK: - getItems

extension CategoryItemsServiceTests {
    func test_WHEN_getItems_GIVEN_someCategory_givenTheBackendWorkedProperlyAndHadNoError_THEN_itShouldFetchSomeItems() {
        let successExpectation = XCTestExpectation()
        let errorExpectation = XCTestExpectation()
        errorExpectation.isInverted = true
        
        let apiResponse = APICategoryItemsResponse(food: [APIFoodItemBuilder.build()], nonFood: [APINonFoodItemBuilder.build()])
        webClient.result = apiResponse
        
        sut.getItems(for: .creatures) { categoryItems in
            successExpectation.fulfill()
        } onError: { _ in
            errorExpectation.fulfill()
        }
        
        wait(for: [successExpectation, errorExpectation], timeout: 0.1)
    }
    
    func test_WHEN_getItems_GIVEN_someCategory_givenTheBackendHadSomeErrorLikeInvalidRequest_THEN_itShouldExecuteTheOnErrorCallback() {
        let successExpectation = XCTestExpectation()
        successExpectation.isInverted = true

        let errorExpectation = XCTestExpectation()
        
        
        webClient.error = .invalidRequest
        
        sut.getItems(for: .creatures) { categoryItems in
            successExpectation.fulfill()
        } onError: { error in
            XCTAssertEqual(error, .invalidRequest)
            errorExpectation.fulfill()
        }
        
        wait(for: [successExpectation, errorExpectation], timeout: 0.1)
    }
    
    func test_WHEN_getItems_GIVEN_someCategory_givenTheBackendHadSomeErrorLikeErrorDecodingData_THEN_itShouldExecuteTheOnErrorCallback() {
        let successExpectation = XCTestExpectation()
        successExpectation.isInverted = true

        let errorExpectation = XCTestExpectation()
        
        
        webClient.error = .errorDecodingData
        
        sut.getItems(for: .creatures) { categoryItems in
            successExpectation.fulfill()
        } onError: { error in
            XCTAssertEqual(error, .unexpectedResponse)
            errorExpectation.fulfill()
        }
        
        wait(for: [successExpectation, errorExpectation], timeout: 0.1)
    }
}
