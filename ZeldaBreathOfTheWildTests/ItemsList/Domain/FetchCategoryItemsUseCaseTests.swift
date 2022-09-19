//
//  FetchCategoryItemsUseCaseTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class FetchCategoryItemsUseCaseTests: XCTestCase {

    private var sut: FetchCategoryItemsUseCase!
    private var fakeService: FakeCategoryItemService!
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        fakeService = nil
        super.tearDown()
    }

    func test_WHEN_getItems_GIVEN_noServiceForRequiredCategory_THEN_itShouldThrowAnError() {
        sut = FetchCategoryItemsUseCase(services: [])
        
        let expectation = XCTestExpectation()
        Task {
            do {
                _ = try await sut.getItems(for: .creatures)
            } catch {
                XCTAssertEqual(error as! FetchCategoryItemsUseCase.Error, .serviceNotFound(category: .creatures))
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_WHEN_getItems_GIVEN_someServiceForTheRequiredCategory_THEN_itShouldHaveTheServiceExecuteTheRequest() {
        fakeService = FakeCategoryItemService()
        fakeService.willProcess = true
        fakeService.items = CategoryItems(food: [], nonFood: [])
        
        sut = FetchCategoryItemsUseCase(services: [fakeService])
        
        let expectation = XCTestExpectation()
        Task {
            do {
                _ = try await sut.getItems(for: .creatures)
                XCTAssert(fakeService.requestExecuted)
            } catch {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }

}
