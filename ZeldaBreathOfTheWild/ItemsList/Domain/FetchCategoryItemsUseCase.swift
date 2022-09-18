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
    let service: CategoryItemsService
    
    func getItems(for category: Category) async throws -> CategoryItems {
        try await service.getItems(for: category)
    }
}
