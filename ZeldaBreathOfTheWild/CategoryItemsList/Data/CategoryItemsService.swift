//
//  CategoryItemsService.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 13/09/22.
//

import Foundation

protocol CategoryItemsService {
    func getItems(for category: Category, onSuccess: @escaping (CategoryItems)->Void, onError: @escaping (ServiceError)->())
}

class DefaultCategoryItemsService: CategoryItemsService {
    private let webClient: WebClientProtocol
    private let categoryAPICategoryMapper: CategoryAPICategoryMapper
    private let apiCategoryItemsResponseCategoryItemsMapper: APICategoryItemsResponseCategoryItemsMapper
    
    init(webClient: WebClientProtocol, categoryAPICategoryMapper: CategoryAPICategoryMapper, apiCategoryItemsResponseCategoryItemsMapper: APICategoryItemsResponseCategoryItemsMapper) {
        self.webClient = webClient
        self.categoryAPICategoryMapper = categoryAPICategoryMapper
        self.apiCategoryItemsResponseCategoryItemsMapper = apiCategoryItemsResponseCategoryItemsMapper
    }
    
    func getItems(for category: Category, onSuccess: @escaping (CategoryItems) -> Void, onError: @escaping (ServiceError) -> ()) {
        let apiCategory = categoryAPICategoryMapper.map(input: category)
        let endpoint = Endpoint(httpMethod: .GET, url: URL(string: "\(DataConstant.baseUrl)\(DataConstant.categoryEndpoint)\(apiCategory.rawValue)")!, body: nil)
        self.webClient.performRequest(request: endpoint.buildRequest()) { [weak self] (response: APICategoryItemsResponse) in
            guard let self = self else { return }
            let categoryItems = self.apiCategoryItemsResponseCategoryItemsMapper.map(input: response)
            onSuccess(categoryItems)
        } onError: { webClientError in
            switch webClientError {
            case let value where value == .invalidRequest:
                onError(.invalidRequest)
            default:
                onError(.unexpectedResponse)
            }
        }
    }
}
