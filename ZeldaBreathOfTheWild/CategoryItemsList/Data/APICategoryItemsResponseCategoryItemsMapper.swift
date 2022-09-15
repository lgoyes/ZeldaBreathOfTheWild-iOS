//
//  APICategoryItemsResponseCategoryItemsMapper.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 14/09/22.
//

import Foundation

protocol APICategoryItemsResponseCategoryItemsMapper {
    func map(input: APICategoryItemsResponse) -> CategoryItems
}

struct DefaultAPICategoryItemsResponseCategoryItemsMapper: APICategoryItemsResponseCategoryItemsMapper {
    
    private let apiFoodItemFoodItemMapper = APIFoodItemFoodItemMapper()
    private let apiNonFoodItemNonFoodItemMapper = APINonFoodItemNonFoodItemMapper()
    
    func map(input: APICategoryItemsResponse) -> CategoryItems {
        let foodItems = input.food.map { apiFoodItemFoodItemMapper.map(input: $0) }
        let nonFoodItems = input.nonFood.map { apiNonFoodItemNonFoodItemMapper.map(input: $0) }
        return CategoryItems(food: foodItems, nonFood: nonFoodItems)
    }
}

struct APIFoodItemFoodItemMapper {
    func map(input: APIFoodItem) -> FoodItem {
        return FoodItem(
            category: Category(rawValue: input.category)!,
            id: input.id,
            image: input.image,
            name: input.name,
            description: input.description,
            commonLocations: input.commonLocations,
            cookingEffect: input.cookingEffect,
            heartsRecovered: input.heartsRecovered)
    }
}

struct APINonFoodItemNonFoodItemMapper {
    func map(input: APINonFoodItem) -> NonFoodItem {
        return NonFoodItem(
            category: Category(rawValue: input.category)!,
            id: input.id,
            image: input.image,
            name: input.name,
            description: input.description,
            commonLocations: input.commonLocations,
            drops: input.drops)
    }
}
