//
//  CategoryItemsListViewModel.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 16/09/22.
//

import Foundation
import Combine

class CategoryItemsListViewModel: ObservableObject {
    @Published var items: [SomeItem]
    @Published var searchText: String
    var title: String
    var category: Category?
    
    init(getTitleForCategoryUseCase: GetTitleForCategoryUseCase, category: Category) {
        self.items = [FoodItem].init(repeating: FoodItem(category: .creatures, id: 1, image: "https://botw-compendium.herokuapp.com/api/v2/entry/hot-footed_frog/image", name: "Any item", description: "any-description", commonLocations: ["one-location"], cookingEffect: "Some effect", heartsRecovered: 1), count: 5)
        self.searchText = ""
        self.category = category
        self.title =  getTitleForCategoryUseCase.getTitle(for: category)
    }
    
}
