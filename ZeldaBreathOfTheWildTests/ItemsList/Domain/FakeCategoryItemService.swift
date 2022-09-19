//
//  FakeCategoryItemService.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import Foundation
@testable import ZeldaBreathOfTheWild

final class FakeCategoryItemService: CategoryItemsService {
    enum Error: Swift.Error {
        case unexpectedError
    }
    
    var willProcess = false
    var items: CategoryItems?
    var error: ServiceError?
    var requestExecuted = false
    
    func canProcess(category: ZeldaBreathOfTheWild.Category) -> Bool {
        willProcess
    }
    
    func getItems(for category: ZeldaBreathOfTheWild.Category) async throws -> ZeldaBreathOfTheWild.CategoryItems {
        requestExecuted = true
        if let items = items {
            return items
        } else if let error = error {
            throw error
        } else {
            throw Error.unexpectedError
        }
    }
}
