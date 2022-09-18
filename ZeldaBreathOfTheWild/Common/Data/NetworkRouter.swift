//
//  NetworkRouter.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import Foundation

protocol NetworkRoutable {
    func getEndpoint(for category: Category) -> Endpoint
}

struct NetworkRouter: NetworkRoutable {
    private let categoryAPICategoryMapper: CategoryAPICategoryMapper
    init(categoryAPICategoryMapper: CategoryAPICategoryMapper) {
        self.categoryAPICategoryMapper = categoryAPICategoryMapper
    }

    func getEndpoint(for category: Category) -> Endpoint {
        let apiCategory = categoryAPICategoryMapper.map(input: category)
        let endpoint = Endpoint(httpMethod: .GET, url: URL(string: "\(DataConstant.baseUrl)\(DataConstant.categoryEndpoint)\(apiCategory.rawValue)")!, body: nil)
        return endpoint
    }
}
