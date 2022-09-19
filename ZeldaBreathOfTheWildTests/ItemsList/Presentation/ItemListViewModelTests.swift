//
//  ItemListViewModelTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class ItemListViewModelTests: XCTestCase {

    private var sut: ItemListViewModel!
    private var fakeGetTitleUseCase: FakeGetCategoryTitleUseCase!
    private var fakeFetchItemsUseCase: FakeFetchCategoryItemsUseCase!
    
    override func setUp() {
        super.setUp()
        fakeGetTitleUseCase = FakeGetCategoryTitleUseCase()
        fakeFetchItemsUseCase = FakeFetchCategoryItemsUseCase()
        sut = ItemListViewModel(
            category: .materials,
            getTitleForCategoryUseCase: fakeGetTitleUseCase,
            nextViewBuilder: ItemListNextViewBuilder(getCategoryTitleUseCase: fakeGetTitleUseCase),
            fetchCategoryItemsUseCase: fakeFetchItemsUseCase)
    }

    override func tearDown() {
        fakeGetTitleUseCase = nil
        fakeFetchItemsUseCase = nil
        sut = nil
        super.tearDown()
    }
    
    func getFoodItem() -> FoodItem {
        FoodItem(category: .materials, id: 1, image: URL(string: "any-string"), name: "any-name", description: "any-description", commonLocations: ["any-location"], cookingEffect: "any-effect", heartsRecovered: 1)
    }
}

// MARK: - getNextViewFor

extension ItemListViewModelTests {
    func test_WHEN_getNextViewFor_GIVEN_someItem_THEN_itShouldReturnNextViewFromBuilder() {
        let nextView = sut.getNextViewFor(item: getFoodItem())
    }
}

// MARK: - performFetchItemsRequest

extension ItemListViewModelTests {
    func test_WHEN_performFetchItemsRequest_GIVEN_noSearchText_THEN_itShouldSetItemsWithoutFilter() throws {
        let foodItem = getFoodItem()
        let someItems = CategoryItems(food: [foodItem], nonFood: [])
        fakeFetchItemsUseCase.items = someItems
        
        let expectation = XCTestExpectation()
        
        Task {
            try await sut.performFetchItemsRequest()
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssert(sut.items.contains(where: { $0.id == foodItem.id }))
    }
    
    func test_WHEN_performFetchItemsRequest_GIVEN_someSearchTextThatDoesNotMatchWithAnyEntry_THEN_itShouldSetItemsWithFilter() throws {
        sut.searchText = "X"
        
        let foodItem = getFoodItem()
        let someItems = CategoryItems(food: [foodItem], nonFood: [])
        fakeFetchItemsUseCase.items = someItems
        
        let expectation = XCTestExpectation()
        
        Task {
            try await sut.performFetchItemsRequest()
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssert(sut.items.isEmpty)
    }
}

// MARK: - processCategoryItemFetchingError

extension ItemListViewModelTests {
    func test_WHEN_processCategoryItemFetchingError_GIVEN_someErrorDuringFetching_THEN_itShouldShowErrorAlert() throws {
        let error = FetchCategoryItemsUseCase.Error.serviceNotFound(category: .materials)
        fakeFetchItemsUseCase.error = error
        
        let expectation = XCTestExpectation()
        
        Task {
            await sut.processCategoryItemFetchingError(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssert(sut.fetchItemsErrorAlertVisible)
    }
}
