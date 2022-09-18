//
//  CategoryItemsService.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 13/09/22.
//

import Foundation

protocol CategoryItemsService {
    func getItems(for category: Category) async throws -> CategoryItems
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
    
    func getItems(for category: Category) async throws -> CategoryItems {
        let apiCategory = categoryAPICategoryMapper.map(input: category)
        let endpoint = Endpoint(httpMethod: .GET, url: URL(string: "\(DataConstant.baseUrl)\(DataConstant.categoryEndpoint)\(apiCategory.rawValue)")!, body: nil)
        do {
            let response : APIConsumableItemsResponse = try await self.webClient.performRequest(request: endpoint.buildRequest())
            let categoryItems = self.apiCategoryItemsResponseCategoryItemsMapper.map(input: response)
            return categoryItems
        } catch WebClientError.invalidRequest {
            throw ServiceError.invalidRequest
        } catch {
            throw ServiceError.unexpectedResponse
        }
    }
}