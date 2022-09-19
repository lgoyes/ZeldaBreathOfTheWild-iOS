//
//  BaseCategoryItemsService.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import Foundation

class BaseCategoryItemsService<APIResponse: Decodable>: CategoryItemsService {
    private let webClient: WebClientProtocol
    private let networkRouter: NetworkRoutable
    
    init(webClient: WebClientProtocol, networkRouter: NetworkRoutable) {
        self.webClient = webClient
        self.networkRouter = networkRouter
    }
    
    func canProcess(category: Category) -> Bool {
        return getValidCategories().contains(category)
    }
    
    func getValidCategories() -> [Category] {
        fatalError(CommonConstant.ErrorMessage.abstractMethod)
    }
    
    func getItems(for category: Category) async throws -> CategoryItems {
        let endpoint = networkRouter.getEndpoint(for: category)
        let request = endpoint.buildRequest()
        do {
            let response: APIResponse = try await self.webClient.performRequest(request: request)
            let categoryItems = map(apiResponse: response)
            return categoryItems
        } catch WebClientError.invalidRequest {
            throw ServiceError.invalidRequest
        } catch {
            throw ServiceError.unexpectedResponse
        }
    }
    
    func map(apiResponse: APIResponse) -> CategoryItems {
        fatalError(CommonConstant.ErrorMessage.abstractMethod)
    }
}
