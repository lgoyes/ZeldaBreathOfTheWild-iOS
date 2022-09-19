//
//  ItemListViewModel.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 16/09/22.
//

import SwiftUI
import Combine

class ItemListViewModel: ObservableObject {
    var title: String
    @Published var items: [SomeItem]
    @Published var searchText: String = "" {
        didSet {
            updateFilteredItems()
        }
    }
    
    @Published var fetchItemsErrorAlertVisible = false
    
    private let fetchCategoryItemsUseCase: FetchCategoryItemsUseCaseProtocol
    private let nextViewBuilder: ItemListNextViewBuilder
    private var category: Category
    private var allItems: [SomeItem]
    private let getTitleForCategoryUseCase: GetCategoryTitleUseCaseProtocol
    private var fetchItemsAsyncContext: Task<Void, Never>?
    
    init(category: Category, getTitleForCategoryUseCase: GetCategoryTitleUseCaseProtocol, nextViewBuilder: ItemListNextViewBuilder, fetchCategoryItemsUseCase: FetchCategoryItemsUseCaseProtocol) {
        self.category = category
        self.getTitleForCategoryUseCase = getTitleForCategoryUseCase
        self.fetchCategoryItemsUseCase = fetchCategoryItemsUseCase
        self.title =  getTitleForCategoryUseCase.getTitle(for: category)
        self.items = []
        self.allItems = []
        self.nextViewBuilder = nextViewBuilder
    }
    
    func processOnAppear() {
        fetchItemsAsyncContext = Task.init {
            do {
                try await performFetchItemsRequest()
            } catch {
                await processCategoryItemFetchingError(error)
            }
        }
    }
    
    func processOnDisappear() {
        fetchItemsAsyncContext?.cancel()
        fetchItemsAsyncContext = nil
    }
    
    func performFetchItemsRequest() async throws {
        let allItems = try await fetchCategoryItemsUseCase.getItems(for: category)
        await processCategoryItems(allItems)
    }
    
    @MainActor private func processCategoryItems(_ categoryItems: CategoryItems) async {
        var items = [SomeItem]()
        items.append(contentsOf: categoryItems.food)
        items.append(contentsOf: categoryItems.nonFood)
        self.allItems = items
        updateFilteredItems()
    }
    
    @MainActor func processCategoryItemFetchingError(_ error: Error) {
        print(error.localizedDescription)
        fetchItemsErrorAlertVisible = true
    }
    
    private func updateFilteredItems() {
        if searchText == "" {
            items = allItems
            return
        }
        
        items = allItems.filter({ item in
            item.name.lowercased().contains(searchText.lowercased())
        })
    }
    
    func getNextViewFor(item: SomeItem) -> ItemDetailsView {
        return nextViewBuilder.build(name: item.name, category: category, description: item.description, commonLocations: item.commonLocations, imageURL: item.image)
    }
}
