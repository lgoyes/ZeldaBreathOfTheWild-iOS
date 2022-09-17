//
//  CategoryItems.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 14/09/22.
//

import Foundation

class SomeItem: Identifiable {
    let category: Category
    let id: Int
    let image: String
    var name: String
    let description: String
    let commonLocations: [String]
    
    init(category: Category, id: Int, image: String, name: String, description: String, commonLocations: [String]) {
        self.category = category
        self.id = id
        self.image = image
        self.name = name
        self.description = description
        self.commonLocations = commonLocations
    }
}

class FoodItem: SomeItem {
    let cookingEffect: String
    let heartsRecovered: Int
    init(category: Category, id: Int, image: String, name: String, description: String, commonLocations: [String], cookingEffect: String, heartsRecovered: Int) {
        self.cookingEffect = cookingEffect
        self.heartsRecovered = heartsRecovered
        super.init(category: category, id: id, image: image, name: name, description: description, commonLocations: commonLocations)
    }
}

class NonFoodItem: SomeItem {
    let drops: [String]
    init(category: Category, id: Int, image: String, name: String, description: String, commonLocations: [String], drops: [String]) {
        self.drops = drops
        super.init(category: category, id: id, image: image, name: name, description: description, commonLocations: commonLocations)
    }
}

struct CategoryItems {
    let food: [FoodItem]
    let nonFood: [NonFoodItem]
}
