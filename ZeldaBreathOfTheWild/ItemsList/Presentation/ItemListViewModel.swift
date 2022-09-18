//
//  ItemListViewModel.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 16/09/22.
//

import SwiftUI
import Combine

class ItemListViewModel: ObservableObject {
    private let nextViewBuilder: ItemListNextViewBuilder
    var title: String
    private var category: Category
    
    @Published var items: [SomeItem]
    private var allItems: [SomeItem] {
        willSet {
            updateFilteredItems()
        }
    }
    
    @Published var searchText: String = "" {
        willSet {
            updateFilteredItems()
        }
    }
    
    private func updateFilteredItems() {
        if searchText == "" {
            items = allItems
            return
        }
        
        items = allItems.filter({ item in
            item.name.contains(searchText)
        })
    }
    private let getTitleForCategoryUseCase: GetCategoryTitleUseCase
    
    init(category: Category, getTitleForCategoryUseCase: GetCategoryTitleUseCase, nextViewBuilder: ItemListNextViewBuilder) {
        self.category = category
        self.getTitleForCategoryUseCase = getTitleForCategoryUseCase
        self.title =  getTitleForCategoryUseCase.getTitle(for: category)
        self.items = []
        self.allItems = []
        self.nextViewBuilder = nextViewBuilder
    }
    
    func processOnAppear() {
        self.allItems = (1...10).map({
            FoodItem(category: .creatures, id: $0, image: URL(string: "https://botw-compendium.herokuapp.com/api/v2/entry/hot-footed_frog/image"), name: "Any item", description: "any-description", commonLocations: ["one-location"], cookingEffect: "Some effect", heartsRecovered: 1)
        })
    }
    
    func getNextViewFor(item: SomeItem) -> ItemDetailsView {
        return nextViewBuilder.build(name: item.name, category: category, description: item.description, commonLocations: item.commonLocations, imageURL: item.image)
    }
}
