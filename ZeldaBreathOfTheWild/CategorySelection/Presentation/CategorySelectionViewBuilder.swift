//
//  CategorySelectionViewBuilder.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import Foundation

struct CategorySelectionViewBuilder: ViewBuilder {
    private static let buttonsInfo = [
        CategoryButtonInfo(title: "Creatures", image: "globe", color: .red, category: .creatures),
        CategoryButtonInfo(title: "Monsters", image: "globe", color: .green, category: .monsters),
        CategoryButtonInfo(title: "Materials", image: "globe", color: .yellow, category: .materials),
        CategoryButtonInfo(title: "Equipment", image: "globe", color: .red, category: .equipment),
        CategoryButtonInfo(title: "Treasure", image: "globe", color: .green, category: .treasure)
    ]
    
    static func build() -> CategorySelectionView {
        CategorySelectionView(buttonsInfo: buttonsInfo)
    }
}
