//
//  CategoryItemsService.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 13/09/22.
//

import Foundation

protocol CategoryItemsService {
    func getItems(for category: APICategory, onSuccess: @escaping (APICategoryItemsResponse)->Void, onError: @escaping (ServiceError)->())
}

class DefaultCategoryItemsService: CategoryItemsService {
    private let webClient: WebClientProtocol
    
    init(webClient: WebClientProtocol) {
        self.webClient = webClient
    }
    
    func getItems(for category: APICategory, onSuccess: @escaping (APICategoryItemsResponse) -> Void, onError: @escaping (ServiceError) -> ()) {
        let endpoint = Endpoint(httpMethod: .GET, url: URL(string: "\(DataConstant.baseUrl)\(DataConstant.categoryEndpoint)\(category.rawValue)")!, body: nil)
        
        self.webClient.performRequest(request: endpoint.buildRequest()) { (response: APICategoryItemsResponse) in
            onSuccess(response)
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
