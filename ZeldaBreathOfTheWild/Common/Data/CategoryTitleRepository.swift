//
//  CategoryTitleRepository.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 16/09/22.
//

import Foundation

struct CategoryTitleRepository {
    func getTitle(for category: Category) -> String {
        switch category {
        case .creatures:
            return "Creatures"
        case .equipment:
            return "Equipment"
        case .materials:
            return "Materials"
        case .monsters:
            return "Monsters"
        case .treasure:
            return "Treasure"
        }
    }
}
