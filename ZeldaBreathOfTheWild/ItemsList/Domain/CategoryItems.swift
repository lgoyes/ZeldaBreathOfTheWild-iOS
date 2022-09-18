//
//  CategoryItems.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 14/09/22.
//

import Foundation

class SomeItem: Identifiable {
    var category: Category
    var id: Int
    var image: URL?
    var name: String
    var description: String
    var commonLocations: [String]
    
    init(category: Category, id: Int, image: URL?, name: String, description: String, commonLocations: [String]) {
        self.category = category
        self.id = id
        self.image = image
        self.name = name
        self.description = description
        self.commonLocations = commonLocations
    }
}

class FoodItem: SomeItem {
    var cookingEffect: String
    var heartsRecovered: Int
    init(category: Category, id: Int, image: URL?, name: String, description: String, commonLocations: [String], cookingEffect: String, heartsRecovered: Int) {
        self.cookingEffect = cookingEffect
        self.heartsRecovered = heartsRecovered
        super.init(category: category, id: id, image: image, name: name, description: description, commonLocations: commonLocations)
    }
}

class NonFoodItem: SomeItem {
    var drops: [String]
    init(category: Category, id: Int, image: URL?, name: String, description: String, commonLocations: [String], drops: [String]) {
        self.drops = drops
        super.init(category: category, id: id, image: image, name: name, description: description, commonLocations: commonLocations)
    }
}

struct CategoryItems {
    let food: [FoodItem]
    let nonFood: [NonFoodItem]
}
