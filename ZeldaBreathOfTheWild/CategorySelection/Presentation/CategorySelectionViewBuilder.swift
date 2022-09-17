//
//  CategorySelectionViewBuilder.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import Foundation

struct CategorySelectionViewBuilder: ViewBuilder {
    private static let buttonsInfo = [
        CategoryButtonInfo(title: "Creatures", image: "globe", category: .creatures),
        CategoryButtonInfo(title: "Monsters", image: "globe", category: .monsters),
        CategoryButtonInfo(title: "Materials", image: "globe", category: .materials),
        CategoryButtonInfo(title: "Equipment", image: "globe", category: .equipment),
        CategoryButtonInfo(title: "Treasure", image: "globe", category: .treasure)
    ]
    
    static func build() -> CategorySelectionView {
        CategorySelectionView(buttonsInfo: buttonsInfo)
    }
}
