//
//  CategoryListNextViewBuilder.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import SwiftUI

struct CategoryListNextViewBuilder {
    private let titleUseCase: GetCategoryTitleUseCase
    private let fetchCategoryItemsUseCase: FetchCategoryItemsUseCase
    private let nextViewBuilder: ItemListNextViewBuilder
    
    init(titleUseCase: GetCategoryTitleUseCase) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let jsonDecoder = JSONDecoder()
        let webClient = RESTClient(urlSession: urlSession, jsonDecoder: jsonDecoder)
        let categoryItemsService = DefaultCategoryItemsService(
            webClient: webClient,
            categoryAPICategoryMapper: DefaultCategoryAPICategoryMapper(),
            apiCategoryItemsResponseCategoryItemsMapper: DefaultAPICategoryItemsResponseCategoryItemsMapper())
        self.fetchCategoryItemsUseCase = FetchCategoryItemsUseCase(service: categoryItemsService)
        self.titleUseCase = titleUseCase
        self.nextViewBuilder = ItemListNextViewBuilder(getCategoryTitleUseCase: titleUseCase)
    }
    
    func build(for category: Category) -> ItemListView {
        let viewModel = ItemListViewModel(
            category: category,
            getTitleForCategoryUseCase: titleUseCase,
            nextViewBuilder: nextViewBuilder,
            fetchCategoryItemsUseCase: fetchCategoryItemsUseCase)
        let nextView = ItemListView(viewModel: viewModel, nextViewBuilder: nextViewBuilder)
        return nextView
    }
}
