//
//  CategoryListViewModel.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import Foundation

struct CategoryListViewModel {
    let categories: [Category]
    let cardNextViewBuilder: CategoryListNextViewBuilder
    let getTitleForCategoryUseCase: GetCategoryTitleUseCaseProtocol
    
    func getTitle(for category: Category) -> String {
        getTitleForCategoryUseCase.getTitle(for: category)
    }
    
    func getNextView(for category: Category) -> ItemListView {
        cardNextViewBuilder.build(for: category)
    }
}
