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
    
    private let fetchCategoryItemsUseCase: FetchCategoryItemsUseCaseProtocol
    private let nextViewBuilder: ItemListNextViewBuilder
    private var category: Category
    private var allItems: [SomeItem]
    private let getTitleForCategoryUseCase: GetCategoryTitleUseCase
    
    init(category: Category, getTitleForCategoryUseCase: GetCategoryTitleUseCase, nextViewBuilder: ItemListNextViewBuilder, fetchCategoryItemsUseCase: FetchCategoryItemsUseCaseProtocol) {
        self.category = category
        self.getTitleForCategoryUseCase = getTitleForCategoryUseCase
        self.fetchCategoryItemsUseCase = fetchCategoryItemsUseCase
        self.title =  getTitleForCategoryUseCase.getTitle(for: category)
        self.items = []
        self.allItems = []
        self.nextViewBuilder = nextViewBuilder
    }
    
    func processOnAppear() {
        Task.init {
            do {
                let allItems = try await fetchCategoryItemsUseCase.getItems(for: category)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.processCategoryItems(allItems)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func processCategoryItems(_ categoryItems: CategoryItems) {
        var items = [SomeItem]()
        items.append(contentsOf: categoryItems.food)
        items.append(contentsOf: categoryItems.nonFood)
        self.allItems = items
        updateFilteredItems()
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
