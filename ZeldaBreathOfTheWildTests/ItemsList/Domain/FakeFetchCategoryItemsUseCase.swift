//
//  FakeFetchCategoryItemsUseCase.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import Foundation
@testable import ZeldaBreathOfTheWild

final class FakeFetchCategoryItemsUseCase: FetchCategoryItemsUseCaseProtocol {
    
    enum Error: Swift.Error {
        case anyError
    }
    
    var items: CategoryItems?
    var error: FetchCategoryItemsUseCase.Error?
    
    func getItems(for category: ZeldaBreathOfTheWild.Category) async throws -> ZeldaBreathOfTheWild.CategoryItems {
        if let items = items {
            return items
        } else if let error = error {
            throw error
        } else {
            throw Error.anyError
        }
    }
}
