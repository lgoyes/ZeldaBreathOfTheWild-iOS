//
//  CategoryItemsService.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import Foundation

protocol CategoryItemsService {
    func canProcess(category: Category) -> Bool
    func getItems(for category: Category) async throws -> CategoryItems
}
