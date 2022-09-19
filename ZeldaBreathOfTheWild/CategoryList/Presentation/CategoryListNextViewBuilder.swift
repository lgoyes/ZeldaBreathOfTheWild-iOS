//
//  CategoryListNextViewBuilder.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import SwiftUI

struct CategoryListNextViewBuilder {
    private let titleUseCase: GetCategoryTitleUseCaseProtocol
    private let fetchCategoryItemsUseCase: FetchCategoryItemsUseCase
    private let nextViewBuilder: ItemListNextViewBuilder
    
    init(titleUseCase: GetCategoryTitleUseCaseProtocol) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let jsonDecoder = JSONDecoder()
        let webClient = RESTClient(urlSession: urlSession, jsonDecoder: jsonDecoder)
        let networkRouter = NetworkRouter(categoryAPICategoryMapper: DefaultCategoryAPICategoryMapper())
        let consumableItemsService = ConsumableItemsService(
            apiConsumableItemsResponseCategoryItemsMapper: DefaultAPIConsumableItemsResponseCategoryItemsMapper(),
            webClient: webClient,
            networkRouter: networkRouter)
        let nonConsumableItemsService = NonConsumableItemsService(
            apiNonConsumableItemsResponseCategoryItemsMapper: DefaultAPINonConsumableItemsResponseCategoryItemsMapper(),
            webClient: webClient,
            networkRouter: networkRouter)
        let services: [CategoryItemsService] = [consumableItemsService, nonConsumableItemsService]
        self.fetchCategoryItemsUseCase = FetchCategoryItemsUseCase(services: services)
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
