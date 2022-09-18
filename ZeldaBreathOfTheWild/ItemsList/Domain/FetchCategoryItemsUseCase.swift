//
//  FetchCategoryItemsUseCase.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import Foundation

protocol FetchCategoryItemsUseCaseProtocol {
    func getItems(for category: Category) async throws -> CategoryItems
}

struct FetchCategoryItemsUseCase: FetchCategoryItemsUseCaseProtocol {
    enum Error: Swift.Error {
        case serviceNotFound(category: Category)
    }
    
    private let services: [CategoryItemsService]
    
    init(services: [CategoryItemsService]) {
        self.services = services
    }
    
    func getItems(for category: Category) async throws -> CategoryItems {
        guard let service = services.first(where: { $0.canProcess(category: category) }) else {
            throw Error.serviceNotFound(category: category)
        }
        return try await service.getItems(for: category)
    }
}
