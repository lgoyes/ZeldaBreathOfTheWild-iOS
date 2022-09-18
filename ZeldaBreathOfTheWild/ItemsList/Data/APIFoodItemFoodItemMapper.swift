//
//  APIFoodItemFoodItemMapper.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import Foundation

struct APIFoodItemFoodItemMapper {
    func map(input: APIFoodItem) -> FoodItem {
        return FoodItem(
            category: Category(rawValue: input.category)!,
            id: input.id,
            image: URL(string: input.image),
            name: input.name,
            description: input.description,
            commonLocations: input.commonLocations,
            cookingEffect: input.cookingEffect,
            heartsRecovered: input.heartsRecovered)
    }
}
