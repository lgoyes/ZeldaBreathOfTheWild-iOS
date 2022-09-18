//
//  CategoryListNextViewBuilder.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import SwiftUI

struct CategoryListNextViewBuilder {
    private let titleUseCase: GetCategoryTitleUseCase
    private let nextViewBuilder: ItemListNextViewBuilder
    
    init(titleUseCase: GetCategoryTitleUseCase) {
        self.titleUseCase = titleUseCase
        self.nextViewBuilder = ItemListNextViewBuilder(getCategoryTitleUseCase: titleUseCase)
    }
    
    func build(for category: Category) -> ItemListView {
        let viewModel = ItemListViewModel(
            category: category,
            getTitleForCategoryUseCase: titleUseCase,
            nextViewBuilder: nextViewBuilder)
        let nextView = ItemListView(viewModel: viewModel, nextViewBuilder: nextViewBuilder)
        return nextView
    }
}
