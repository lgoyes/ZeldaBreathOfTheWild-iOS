//
//  APIConsumableItemsResponse.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 13/09/22.
//

import Foundation

struct APIFoodItem: Decodable {
    let category: String
    let commonLocations: [String]
    let cookingEffect: String
    let description: String
    let heartsRecovered: Int
    let id: Int
    let image: String
    let name: String
    enum CodingKeys: String, CodingKey {
        case category, description, id, image, name
        case commonLocations = "common_locations"
        case cookingEffect = "cooking_effect"
        case heartsRecovered = "hearts_recovered"
    }
}

struct APINonFoodItem: Decodable {
    let category: String
    let commonLocations: [String]?
    let description: String
    let drops: [String]?
    let id: Int
    let image: String
    let name: String
    enum CodingKeys: String, CodingKey {
        case category, description, drops, id, image, name
        case commonLocations = "common_locations"
    }
}

struct APIConsumableItemsResponseData: Decodable {
    let food: [APIFoodItem]
    let nonFood: [APINonFoodItem]
    enum CodingKeys: String, CodingKey {
        case food
        case nonFood = "non_food"
    }
}

struct APIConsumableItemsResponse: Decodable {
    let data: APIConsumableItemsResponseData
}

struct APINonConsumableItemsResponse: Decodable {
    let data: [APINonFoodItem]
}
