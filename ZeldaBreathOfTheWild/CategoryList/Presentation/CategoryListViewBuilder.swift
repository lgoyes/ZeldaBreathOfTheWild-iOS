//
//  CategoryListViewBuilder.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import Foundation

struct CategoryListViewBuilder {
    private let nextViewBuilder: CategoryListNextViewBuilder
    private let titleRepository: CategoryTitleRepository
    private let titleUseCase: GetCategoryTitleUseCase
    init() {
        titleRepository = CategoryTitleRepository()
        titleUseCase = GetCategoryTitleUseCase(repository: titleRepository)
        nextViewBuilder = CategoryListNextViewBuilder(titleUseCase: titleUseCase)
    }
    
    func build() -> CategoryListView {
        let viewModel = CategoryListViewModel(
            categories: Category.allCases,
            cardNextViewBuilder: nextViewBuilder,
            getTitleForCategoryUseCase: titleUseCase)
        return CategoryListView(viewModel: viewModel)
    }
}
