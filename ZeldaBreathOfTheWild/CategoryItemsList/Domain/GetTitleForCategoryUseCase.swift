//
//  GetTitleForCategoryUseCase.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 16/09/22.
//

import Foundation

struct GetTitleForCategoryUseCase {
    private let repository: CategoryTitleRepository
    
    init(repository: CategoryTitleRepository) {
        self.repository = repository
    }
    
    func getTitle(for category: Category) -> String {
        repository.getTitle(for: category)
    }
}
